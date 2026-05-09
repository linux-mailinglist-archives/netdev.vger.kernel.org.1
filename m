Return-Path: <netdev+bounces-286196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEwgD8Rq/2kR6QAAu9opvQ
	(envelope-from <netdev+bounces-286196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:11:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB6B500A70
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97839300B056
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86DE2E7657;
	Sat,  9 May 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="tsz4LYDW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEB15B0EC
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346688; cv=none; b=FdXmMtiX86C2R35Mq8pFaPLMxhPryJswzTkr0GKB1U4sh0BIog2dyhqyBvu1BLHdyMMeLAYusgxVPfL/Pqepm5+wIlZwY9iEWk/gdQQxdBX+MytV2SThgWeze0d8XTfaFsYGpLY4/HMTCh2j/bPDzQE4HF5hRhQaW+QuKlf9KIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346688; c=relaxed/simple;
	bh=/QF52SRvq00pAvdN8SPIuXTLkLczvXHpzWkmPXBrVNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgNq0OWaTJeFDl8A17dPzNcUM50eqp7mky1PNx9rahgDZa4E215FRFOT5O2dNXYW53dbfjSbby20tM/ybatn0Wi4kHtW6i3EgrrlXv37WZ7314pUm7RyD8ibe+9jr5E8Xtcpq7FSe1VwmfRZTXEDwFU3tInrdAAO1bJQ69JW2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=tsz4LYDW; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c8ccc7755so4487460c88.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778346686; x=1778951486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3SmsjTYOJysAgnF/CizqO+U27wUoAbqDY4Fci4Eug8E=;
        b=tsz4LYDWwERwETFkXQxMg1G1gxFkrYmZyRXmL6sdqIzDO1qPsH6C/XCz5/rMbn4DxW
         NahyQQ99MMXjtZ/Awyi9pMEtlYG9h1t4qDokcXr++2nOBa+kFIsz51pCdcOcjSgm8PtU
         ak6MNYrKguOoB3f0fYG6uVGts9s8zTncyPr+tzStklbPpNP+s0UrhIg2hxcFzHmVOnJf
         msSkx//7kr7Hkuwcr5izOI3ozzWS2/CRm6+gkla1R/0Yj1ijHIooowskZEAdoHhgAaJf
         zHc2dzTX234p8oAkmmVQ2sajndrcD+Dn5BsSZwC0ejZ6jXZsU5WHKeq5FDUfAptOTQKl
         0N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346686; x=1778951486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SmsjTYOJysAgnF/CizqO+U27wUoAbqDY4Fci4Eug8E=;
        b=Tz37GUZdSwEx5F/bwTdCpWwCZIFxSDRCIa+5YNFghbs/lPtV0KSzfz3ptk8aYRvgmB
         o5w5+BzaG4HYm04L8LXVe4r6iLFz8yS4zfki/m3CeGLbnctJ7K+299Xaby1j8wdW9J8F
         3Yq6k5LcgLr9bgC1fQMVauogFAAhMDEEQySYM6KzNoCw8YIZm+mg9/6cKeGtpFs2bIWI
         0rTgRK25pFt6+cb/1uHaj5Mzc2gPgOFOAvyrUXQ4gM1SO4UIKGTf7nBcyGU+4tlVx8a9
         CNOBH1GklYLb75f5Mz453Et6AynA+xzVfWMlHmsiuXKIo/5oJXFyD4TdHx81N7dqdha7
         bbXw==
X-Gm-Message-State: AOJu0YxxhopVk9ejt1KBWeBm6tBmpLTA08Dxf71EzxKv0xuC75HBbeZ5
	W8A1/SKrcMI/OSjZ+qKCKhUKuZJedaupx0H/zPsE2VR90UUNDXPzXvZWVjGtuH1czXdpVnEuYBx
	liWpY
X-Gm-Gg: Acq92OHWPLjF8T5GIKNUY5Z3sK0c9DDst8iIdyx35r6ErLw9qWKKcPeBs8UCEnINEea
	LvGJ0vtfrCCNP+MBVHqz+4Swm8UHbr8BBBsfth+6dHlYN88eFNKHk8NP9xkmyIXId6nGRGzjqHa
	X+FFoSIhSSkgyTyyjTUDNwekFsxyt98Kt/1ZGMqP21GX8mK/D0JETovD0Snb7/L+qowMotsayGu
	AyhkVyqosxAx7VgHnH+sUI/17SVN+V3QiCjYrMu89YvyxPd6Dn0mdJsMDxo6lZ3hy04eBrzdHxW
	wlOjrD0zksFJavMlqZh1gV9W2aso5MmBkPcJbyvdNCLVH+/KqdUiKUvu6/6XBR6vzT8BV1oWT9e
	nDsm7335HyCVFX0mUgsosGTL8+cZadCYPo+gyRmiAG5pHV/hHY16BJnNG8OfWv/hCJETzGSGxhq
	qv/5L3kKOvLJYxq3XlMrNkjmpfwuVteYQCOR3EYMHOH8s=
X-Received: by 2002:a05:7022:2381:b0:127:3f2a:af21 with SMTP id a92af1059eb24-132a7ee94d3mr1615763c88.15.1778346686202;
        Sat, 09 May 2026 10:11:26 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm8524568eec.6.2026.05.09.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:11:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next v5 0/5] net/sched: netem: enhancements
Date: Sat,  9 May 2026 10:03:21 -0700
Message-ID: <20260509171123.307549-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8EB6B500A70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286196-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

This is a collection of improvements to netem found while
investigating the fixes now in net tree.

v5 - minor cleanups
   - add allocation_errors counter
   - align counters with where impairment occurs

Stephen Hemminger (5):
  net/sched: netem: reorder struct netem_sched_data
  net/sched: netem: remove useless VERSION
  net/sched: netem: replace pr_info with netlink extack error messages
  net/sched: netem: handle multi-segment skb in corruption
  net/sched: netem: add per-impairment extended statistics

 include/uapi/linux/pkt_sched.h |  10 ++
 net/sched/sch_netem.c          | 223 ++++++++++++++++++++-------------
 2 files changed, 144 insertions(+), 89 deletions(-)

-- 
2.53.0


