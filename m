Return-Path: <netdev+bounces-302338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vw4JM07WP2oSYwkAu9opvQ
	(envelope-from <netdev+bounces-302338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 15:55:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171A6D20CB
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 15:55:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b="K5aZWKC/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302338-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302338-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1449E301AAA2
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D003AE19B;
	Sat, 27 Jun 2026 13:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04343AD52E;
	Sat, 27 Jun 2026 13:55:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782568524; cv=none; b=Tv4l8DxeMwQGMgN/tHZrCeFc8cqo9KO2/PbZSb3qlOR/FQvyaR8FYVTC5sm4tV6SJotUu6K0nve+1rZ5Lnv0A1UVqP1DYkfMWs35RGzrh0nzWtn3+xQ4pT0fo+GItGkGybWccbyyzIv5wZFd7nfhyyXI1rqFtvIQQ8950dl23Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782568524; c=relaxed/simple;
	bh=loRejJPdY42lTMFeWlZavOGb/y/2IXL2/teHAE9iPms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNKT0F4lrIa45BL9Mk311EvEOSOYUjgicWi1Oe0WLD96y8egq5aw++2YjK3FTBJ6eblxYvH3OLwpsBFXA64nfhFDqvyftuP4DoX0jrOlNr/zI5H0Q6rSda+UTI8qMnqwCcY5XhAikZCW/gvrra1fOhYrJaulhqMc43gGS30hdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=K5aZWKC/; arc=none smtp.client-ip=101.71.155.101
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 44009d482;
	Sat, 27 Jun 2026 21:50:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Taras Chornyi <taras.chornyi@plvision.eu>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Question: prestera: clarify event handler RCU-list contract
Date: Sat, 27 Jun 2026 21:50:02 +0800
Message-Id: <20260627135002.4060912-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f0958456303a1kunm905bc835d1e63
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSRgeVk5PThpOT0JISxkaTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=K5aZWKC/hz6vcaDXRWRfQQ6ABhjwMuIU1qJws3tvHcfCCukEv0xnfMestW7FGoPKf6DpMZMLuLCsGab3BP3FrftEXLIY72VzLb8+ol9wfh6VMpfQ6Q9xoCfyPAZ00wSs88P1JH7COASWh98H06XyP6u4dE+4/e8hLxNJvwo79W8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=zHWSksGJHZMLLtybnVMeWmWVN7/HyGiBUlF7lcISkF0=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302338-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:taras.chornyi@plvision.eu,m:runyu.xiao@seu.edu.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3171A6D20CB

Hi Prestera maintainers,

This question comes from a candidate found by our static analysis tool
and then manually reviewed against the current tree. The audit used
CONFIG_PROVE_RCU_LIST as target-matched triage evidence; I am asking
for maintainer guidance because the source-level review did not prove
a use-after-free.

A CONFIG_PROVE_RCU_LIST audit flags the shared event-handler lookup
helper:

  drivers/net/ethernet/marvell/prestera/prestera_hw.c:923 __find_event_handler()

The receive-side paths use prestera_find_event_handler(), which wraps
the helper in rcu_read_lock(), copies the handler record, and drops RCU
before invoking the callback.

The registration paths call __find_event_handler() directly:

  drivers/net/ethernet/marvell/prestera/prestera_hw.c:2255 prestera_hw_event_handler_register()
  drivers/net/ethernet/marvell/prestera/prestera_hw.c:2280 prestera_hw_event_handler_unregister()

Registration adds entries with list_add_rcu().  Unregistration removes
entries with list_del_rcu() and frees them with kfree_rcu().  The call
sites look init/fini-style, and I am not claiming a use-after-free here.
The question is only how the non-receive-side lookup contract is meant
to be expressed.

Would you prefer one of these directions?

  1. split the helper into an RCU-reader lookup and a registration-time
     lookup;

  2. wrap the direct register/unregister lookups in a local RCU read-side
     section;

  3. add an explicit event-handler registration lock if concurrent
     register/unregister is possible;

  4. document that handler registration is init/fini ordered and leave
     the direct helper calls unchanged.

I am intentionally sending this as a maintainer question rather than a
patch because the right shape depends on the intended registration and
teardown model.

Thanks.

