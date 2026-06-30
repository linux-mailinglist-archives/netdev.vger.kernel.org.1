Return-Path: <netdev+bounces-303194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KVTLDv/JQ2oEiAoAu9opvQ
	(envelope-from <netdev+bounces-303194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:51:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 975216E50FA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:51:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=wYd2D1cD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303194-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303194-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF4730D6527
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42E368D5F;
	Tue, 30 Jun 2026 13:50:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323736655D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 13:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827414; cv=none; b=e6j8U/2aQFR1FMbQ47HJMpguHIanzc3GaYD6LiqnKoG9qtM5CHxFX8YkFxZxUMMvC+DNbccJ3wn1SF3vay1cdbrpb/66l1IP+hx2QZscAvh0gak7+mz9T+mWVj9Qizjw2M1P5JVAIBA8s5wrUy/c1+XDCa48TAhdgpx9iBeluHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827414; c=relaxed/simple;
	bh=OY/WLvSMj3uNnrwh7DqXkFCXLCQIr8dCX1FF87BNPvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiVwsDT5yHpPkzy8xpblMMjVxXf32PWDcVSnstbbKQUeEvDRuLo8M7cgkOIZIuqWPGJqzHfgDwcnVK2aYmO0ymKHzVl3meuQMkNHS+vEI0RHflVFK5Sim+jD7dL1rFtlG1hkWmEqnP1BSGq7q6Wk9YWirJCk8EKXfbzyMvo1VCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=wYd2D1cD; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=chPXv7++l38ngSLvkWCokAnOz0yB1awOLYQnYMHr4js=;
	b=wYd2D1cDDBHMXhRtV125IjhreNgzEkma9b8QF9y8aERTZX18kz/zd99boU6xPGFX5VjHFX
	J2kBaipvq1qLTOtXh7ch2IuHp8yBKlAhpKOE1L2F3C59vCiSSrC6+CnhmuEjwi0lpubU9Y
	uCNbOAzh6ciOGVR3SQY1Suam1jN4Xban/kExSjtjz/l03vvuj6iysv5SV+7ClNPdgmVxdk
	Z0fVPP8pJpdC3GE2IiBy0MIJ2s3ZwQVzZwfeE/CKkysViE2evhxyB0cNwWQ+RcnglBS9wU
	/RARVCvmu9RtgpmPw8AgpPG4r83ZH7Hav1ny8pOBAq/d2l3qX3cNjX6ngllsRw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/6] pull request: batman-adv 2026-06-30
Date: Tue, 30 Jun 2026 15:44:24 +0200
Message-ID: <20260630134430.85786-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303194-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,simonwunderlich.de:dkim,simonwunderlich.de:mid,simonwunderlich.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,open-mesh.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 975216E50FA

Dear net maintainers,

here are a couple of bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 805185b7c7a1069e407b6f7b3bc98e44d415f484:

  Merge tag 'net-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-25 12:25:36 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260630

for you to fetch changes up to 26560c4a03dc4d607331600c187f59ab2df5f341:

  batman-adv: dat: ensure accessible eth_hdr proto field (2026-06-28 11:49:04 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfix, all by Sven Eckelmann:

 - fix pointers after potential skb reallocs (5 patches)

 - dat: ensure accessible eth_hdr proto field

----------------------------------------------------------------
Sven Eckelmann (6):
      batman-adv: retrieve ethhdr after potential skb realloc on RX
      batman-adv: access unicast_ttvn skb->data only after skb realloc
      batman-adv: gw: acquire ethernet header only after skb realloc
      batman-adv: dat: acquire ARP hw source only after skb realloc
      batman-adv: bla: reacquire gw address after skb realloc
      batman-adv: dat: ensure accessible eth_hdr proto field

 net/batman-adv/distributed-arp-table.c | 28 +++++++++++++++++++++++++++-
 net/batman-adv/gateway_client.c        |  3 ++-
 net/batman-adv/main.c                  |  3 +++
 net/batman-adv/mesh-interface.c        |  1 +
 net/batman-adv/routing.c               |  3 ++-
 5 files changed, 35 insertions(+), 3 deletions(-)

