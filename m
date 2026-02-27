Return-Path: <netdev+bounces-261685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIF2OroIoWlXpwQAu9opvQ
	(envelope-from <netdev+bounces-261685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:00:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 459AF1B225A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F20BD30817F2
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B6302140;
	Fri, 27 Feb 2026 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1mMakp/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD20301037
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161197; cv=none; b=glnhWzcs0P++DkVOTdhnCWIIel40Pkv4z/Vcu5EnwuWdaMC8ZfYU3/xndkH2lOEKRBvlqHa40qJQrCGxhcw+8JbgLXPxgsPd4A7FxLRxriW4TLzmWpSy3tYoEeGyYVbvneSOFR1Ehyrt1glwU4nrBQBhAs3/ungNMVlwHpqbH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161197; c=relaxed/simple;
	bh=//7wOODElqYTQiR8nL5gR7HXR2TzZyBl5X8K0sjoxBc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EoeKDZqelmvEMqFOnoyNTqih6+LFVXl7UIJM68xetSxI6f6kfaSPBvtVyB+/GIoHpzMfvaD+//tHyIP9UAwD7NQQUg6klBLJynHvVqXgUCRmJmSyqhSTBTHUzJRdQgr1ty7dLWqG0Bd21yLBlsENkEclHbbdHp7Oq9MVbnKB3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srutherford.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1mMakp/; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srutherford.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1565635eec.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772161194; x=1772765994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C05Mn9JMafI99EWEgRgLLPj/E+g1PjLcWaGlhM4Kvtg=;
        b=N1mMakp/shPkrt0fOI3qBu/xpT6epAxtg7spoYTucgO6HWxx2rQPUlcI7MC1tBbzeT
         B4ZA8NNJSAD0fIJEcJIECrv7LjcC/VCpayWnG8jFIvu3t9/cN19VRB754M1s5689lAPA
         So3c87uL32ag9YFAKDWF4QzXpyiDry4PyRiSswPxSths4Tp9jCqffL3NFO3CojbtdOal
         bMJIRafZVzSuZXbgF6RLLKu8naV4aKxPjI6uwa+YjY9yen12+C+1uIfGgQkjGYvmNBnU
         2g9BBGIK2bCDnHwSSvA0pEKpK92Tz6SVa1+Ex4IkF9AHiTJ9q4MK8fju+dW5OHLb7WSL
         rC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772161194; x=1772765994;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C05Mn9JMafI99EWEgRgLLPj/E+g1PjLcWaGlhM4Kvtg=;
        b=wvvFu9JKQGsm54PHw9gNd0/Kg3T73MKFXmMMYGfvwGug65fwkZoETddhrHfpMhYARW
         IkdcFABvYfit3zg2gAWJV4sDH6HnaKM+homMYHDShdd9Oej5ZfBgjJt0FdDmt781/QyT
         jPnd8d5f7MDB6QwBu70GgQU1aq2KXWBRnPqiA0yufqC7648ctxqVQtcyekXdbc/bGIgH
         kDCEUNoWBcnw7dlgSBQOMvMChUzOvMVwtNDdVD2Ve4bj+R/GC1sgBURwjnmvoHxTqHjF
         Tjo29i3Pc+pdnMFTYWrglLa+38N/UsBpH0262zMXyFH8neJQaYeSE9Z3L7gWIkCXUSND
         49cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLmSJpNIcv8R35zWbzOYtAxpW3cCfg499vp21XNANY+nRVYswee2pHeJOD0ech4Jy8yo8cDCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+YS6ENpHeQBgriwPZOoK7jB2UNbSqp2v8tvkWi4PZKYOW61Y
	aMtm1mBnhmKXT6Ed1g8nmdJgfkp79k2JbHTaMYq/bGb4WpXQuRG3H/JodEyXKPAKMSnkdk5Ojel
	412YNEze1LakYjNHPkUwkG5KR7w==
X-Received: from dlbcy24.prod.google.com ([2002:a05:7022:b98:b0:127:1b87:b031])
 (user=srutherford job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6289:b0:124:a610:62f6 with SMTP id a92af1059eb24-1278fd340a7mr448355c88.44.1772161193541;
 Thu, 26 Feb 2026 18:59:53 -0800 (PST)
Date: Fri, 27 Feb 2026 02:59:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227025950.174755-1-srutherford@google.com>
Subject: [RFC PATCH 0/1] IDPF + SWIOTLB Bug
From: Steve Rutherford <srutherford@google.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	aleksander.lobakin@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srutherford@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 459AF1B225A
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

Steve Rutherford (1):
  Fix header clobber in IDPF with SWIOTLB enabled

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog


