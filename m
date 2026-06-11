Return-Path: <netdev+bounces-298193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1PXnKtHdKmqvyQMAu9opvQ
	(envelope-from <netdev+bounces-298193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:09:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C539E673548
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:09:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=N35DenAT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298193-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298193-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D58306F9F5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0730404BDF;
	Thu, 11 Jun 2026 16:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213334BA5A;
	Thu, 11 Jun 2026 16:05:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193944; cv=none; b=OK5W7DbLaKFsXOSO8GmFF1vpuFOHjsZxC5kGbogh8pdQzq8BTkSP8i1G6RLvRsnago+DAt+V8DH4o+0W15ljhopOJYjL7PTIfrmQ8u5l7DV4HWMCHJeRihwz0EDLPWiIhwAs/LC7iIoO9BLYpUA/qpUpl4OqEIHc/BTugy1DEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193944; c=relaxed/simple;
	bh=N/DTl39OS6g3d/Df+S+eJkbGSsR18EMSnguW635v4Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WaKVNZn47J2lp5QERT2TiDNsE0KnksZM/DXBb7NAf4NCOxiPkZvo2pVpQ3zeKRKKqMGtJJuP8bF9YmCXxOsigR1Y3shCqim90sTBj7F0skPcsjpYXDKO9OQaCNkP71w7ia0iSQNGH/+Zc5qn8iR74BgMU197o5OT26kwr/jhqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=N35DenAT; arc=none smtp.client-ip=45.254.49.197
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 420765d8f;
	Fri, 12 Jun 2026 00:00:26 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: netdev@vger.kernel.org
Cc: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amakarov@marvell.com,
	tduszynski@marvell.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net 0/2] octeontx2: quiesce stale mailbox IRQ state before request_irq()
Date: Fri, 12 Jun 2026 00:00:12 +0800
Message-Id: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb769d35a03a1kunm0ec2af3116af45
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTk8YVkwZTU4eHkkYH09CGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=N35DenATHoIawouiTee9pAKgEdC3e0+aAbVrZO6BoQl/LzKsz6imvrd5IDtwrnmDWygBZ9IUGTdQ3yifoMKc9+9w5A73ipeDBumMt+wpdhQeDOHEebBZfjdASGjqvFEzK/AvhNncGX9s4tKImudvRm5YgyTnDA+9cbwW54CCgjw=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=2QY9a7IL3Zh4/EbBPPumYIr+t15aOCKMkBuqKDwyEWI=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298193-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:amakarov@marvell.com,m:tduszynski@marvell.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C539E673548

Both OTX2 mailbox registration paths currently install their IRQ
handlers before clearing stale local mailbox interrupt state, even
though the code comments already say that the clear is needed first to
avoid spurious interrupts.

This issue was found by our static analysis tool and manually audited on
Linux v6.18.21. Directed QEMU no-device validation further showed that
the real PF and VF mailbox handlers are already reachable in that
pre-clear window and can touch the same mailbox and workqueue carrier
before local quiesce has completed.

This series keeps the change minimal:

- clear stale mailbox interrupt state before request_irq()
- keep interrupt enabling after the handler is installed

That closes the early-IRQ window without introducing a new
enable-before-handler window.

Patch 1 fixes the PF mailbox registration path.
Patch 2 fixes the VF mailbox registration path.

Build-tested by compiling otx2_pf.o and otx2_vf.o.

No OTX2 hardware was available for end-to-end runtime testing.

Runyu Xiao (2):
  octeontx2-pf: clear stale mailbox IRQ state before request_irq()
  octeontx2-vf: clear stale mailbox IRQ state before request_irq()

 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 20 ++++++++---------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  | 22 +++++++++----------
 2 files changed, 19 insertions(+), 23 deletions(-)

-- 
2.34.1

