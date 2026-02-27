Return-Path: <netdev+bounces-261979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKYsEnEAomm9yAQAu9opvQ
	(envelope-from <netdev+bounces-261979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 21:37:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B79591BDBAB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 21:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B4023115E35
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEA0477E33;
	Fri, 27 Feb 2026 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0iUrGgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39A38551C
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224534; cv=none; b=QhzjoSFXJMr6QJPJXJrrhvQepNnRoiQmkCHjLNi2obs1SDF5iTRn5HVakC6shxz+XSd4Qnxw4McuvYcE9iKI8EpyMU62lPDx8MFzIDaApDQraTe8pjAG/LAcKvbA6uPpaIMHfocW2GW5DmbSRwVUjAf7dIpLxIN5jd/uMBN2C/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224534; c=relaxed/simple;
	bh=rjHPintehtxkM9UQsRWMqrYGwY/SaNBxtvh2ru+FDpM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LmguNtT0ZgnvTTE16lCsZmftvr/n2FuKYF2nOjeW+wDL4ujM22Fb60WShkmj33oU8UzdPr6s2uC0iR7uLGMpn6yAbGy8VE7144rmB8QhQ0SxutNq9ENhxVavOiplkj2baAJE688NfPfDSLwymZuvBhZ29tZIEou0uY0jp1OuH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srutherford.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0iUrGgo; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srutherford.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12711967e0eso3312458c88.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 12:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772224531; x=1772829331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nRaIjBVYslTopVZnWl1PKdjxejATawghymOdcPvjdcM=;
        b=R0iUrGgol4tL9q70rFD9WqTyanQutyR67QvrPGpLZ5YfxRdlxNatDfKbkBM4ycM4N1
         9gyfQnJqwq8X0UmH8YQVHTEAUfopPcMJ/n5LdmxwWiBC7BoYsH5kixJRYNmwLsFwZJnq
         sBnTsEOm/xoPy/Ii+h0jYkzGnXX1wJ9XqGPvUuF+1roJod37jD56OFZOdnRvtN5bzr9x
         9q0kxt5sFpTKSx/dsJubyTSYprrAM7WYf6qcK0azms57JoT3/t8Ga9af2WVP2Kue64+Y
         /ZI6RpyUepX1Zbm8A713ZgKJnTkT6ZAroLD4GvH2cCTo6/Mt8izN9F/xHGl/mszheDmg
         itmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772224531; x=1772829331;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRaIjBVYslTopVZnWl1PKdjxejATawghymOdcPvjdcM=;
        b=j+0uz2jrhu98/LubPhwkAN7poBijqoafxsRfpVD+zhkqPLsvJusUxWim3J84Is+k4r
         FA1hL24TLFn/gMZbnC1MXpr5+r59bcd8YhQ5XiocxygVb2WZoDedEKYBE1iJ3pGNIJ5+
         f0rIbkNmPkJqUsMsgK3z38LkBSuIiuy8uEEMnOtmOfmLlgTFqUhotQl5wC6eghsNwJKZ
         kzEvRN9WM7LWLa8/x0euh+A7mHYnbuTxa/zGuqSq3alI38LH8dxibv1IlGOz8LoILo3e
         EiRxV8/YofgYV73fH7sn77ewtM6np5+058Azt/Kbidn0r4CF8OILQfXFDIYFv0G9lsyR
         Y5LA==
X-Gm-Message-State: AOJu0YzXr0bFPWXhEiyyxkZXwqaEv9/ZCScyfXES/MeRW2ETshuJDdCd
	qDsw4MX3kRKCC/TKRvzT9gPVTvBYfQS9qYFgfuz5ckqiC/W/hUzxsowchY8rcCkV+rWVbegGH+W
	on/LHZULpw/+dMog9LLh/PqqJNw==
X-Received: from dlj37.prod.google.com ([2002:a05:7022:525:b0:127:16fc:ca92])
 (user=srutherford job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:43aa:b0:119:e56c:18be with SMTP id a92af1059eb24-1278fc8a31cmr1426907c88.38.1772224529468;
 Fri, 27 Feb 2026 12:35:29 -0800 (PST)
Date: Fri, 27 Feb 2026 20:34:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227203457.558196-1-srutherford@google.com>
Subject: [RFC PATCHv2 0/1] idpf: IDPF + SWIOTLB Bug
From: Steve Rutherford <srutherford@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, aleksander.lobakin@intel.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com, 
	Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261979-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srutherford@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B79591BDBAB
X-Rspamd-Action: no action

Found an issue with the IDPF driver when SWIOTLB is enabled. The issue
results in empty headers for packets that hit the split queue workaround
path. It's caused by a spurious sync in that path. The header is synced
from the SWIOTLB even when the header was shoved into the payload.

I cooked up a sample patch, but I'm not an expert in this driver, so I have
no idea if it's the right solution. It did allow my QEMU VM to boot with a
superficially functional passed-through IDPF NIC and SWIOTLB=force.

The patch was written against COS's 6.12, so I assume that it will not
apply cleanly elsewhere, but I figured a wrong sample patch was better than
a long paragraph describing the same thing. My read of more recent kernels
is that this problem is still present, but could be mistaken.

v2 - Updated title and tags based on feedback.

Steve Rutherford (1):
  idpf: Fix header clobber in IDPF with SWIOTLB enabled

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog


