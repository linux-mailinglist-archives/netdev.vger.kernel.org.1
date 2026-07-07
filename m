Return-Path: <netdev+bounces-305249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DC3TCklRTGohjAEAu9opvQ
	(envelope-from <netdev+bounces-305249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:07:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C5271688F
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:07:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=126.com header.s=s110527 header.b=cuRt6UfV;
	dmarc=pass (policy=none) header.from=126.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305249-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305249-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C93D330095CB
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2352EAD1C;
	Tue,  7 Jul 2026 01:07:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3C18FDDE;
	Tue,  7 Jul 2026 01:07:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783386434; cv=none; b=rKPn1iJddw0mydF2nCfAGDHJH/BAehtcgIEVJ0xFZOcSLvkCOvoyj+FRqYdw5BmfwOaA30gJT4KWbMyFkSXOgowD5P9LoukASZlreuHjmcRhuQuHJMzH1mRqyUBdZal37wliP/kDPgyzg02kgQIokVoAy7rY5K57jC/sSfYzC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783386434; c=relaxed/simple;
	bh=Aq7XpudnAcKaS81HjDJDNYPswQh+BUSNaYY8W66620A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMTs5A2UfOJPoLhcLhDFxWbMgAtwOCPoyTHjqdJd4lmHpWCMXZd3tnGKz6wtajx61iiUsJZH/9xBJR8fo4K2MtU/YvUA46YCBa3vUE5Z7aJiPJ4qQKYwYf+gNemTgNVTRMuWUpbPmoxBkX/m2lUE224txmaFWAuz6mE+Flmc9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=cuRt6UfV; arc=none smtp.client-ip=117.135.210.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=O/
	yofhFvHkov23hY7UUkFz/6GuSRZ5PQqaEKBSq6uK8=; b=cuRt6UfVqt+OOV63XA
	Qq7Yvn7fnto+BEbMIL+RZG0TK+eMzYryk/MAIzC1/3ps1j8+iWCSWFSpHqwLbJLp
	NQmr2TF+dEhQBtpeTnDENIUCBc4iXquKw/yyGceQ/lcjz0Eh5wgoeaZqHYyiFfrd
	T93a23CIVB7axoJYwE8lTuAL0=
Received: from LAPTOP-M8806FGF.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3J84NUUxqULAkDA--.47340S2;
	Tue, 07 Jul 2026 09:06:22 +0800 (CST)
From: zhangzl2013@126.com
To: Zhaolong Zhang <zhangzl2013@126.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianheng Peng <pengqh1@chinatelecom.cn>,
	Zhaolong Zhang <zhangzl68@chinatelecom.cn>
Subject: [PATCH net] bonding: fix devconf_all NULL dereference when IPv6 is disabled
Date: Tue,  7 Jul 2026 09:06:22 +0800
Message-ID: <20260707010622.487333-1-zhangzl2013@126.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3J84NUUxqULAkDA--.47340S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xAF1DZw4ktry5tFyrWFg_yoW8tF15pr
	Z3KrW5ur1ktr1UAF4UX3W093s5Za18XFZFkrWIkr95Zan5Ka1DAFy7Jr109F15trWrCFZI
	va1Uta90gwn5Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEfHUPUUUUU=
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/xtbBog4F1GpMUQ7iOwAA3d
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhangzl2013@126.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:liuhangbin@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengqh1@chinatelecom.cn,m:zhangzl68@chinatelecom.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[126.com,jvosburgh.net,lunn.ch,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[126.com];
	FORGED_SENDER(0.00)[zhangzl2013@126.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305249-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[zhangzl2013@126.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,chinatelecom.cn];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[126.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96C5271688F

From: Zhaolong Zhang <zhangzl68@chinatelecom.cn>

When booting with the 'ipv6.disable=1' parameter, the devconf_all is
never initialized because inet6_init() exits before addrconf_init() is
called which initializes it. bond_send_validate(), however, will still
call bond_ns_send_all() even ipv6 is indeed disabled. It will lead to
NULL derefence of net->ipv6.devconf_all in ip6_pol_route().

 BUG: kernel NULL pointer dereference, address: 000000000000000c
 [...]
 Workqueue: bond0 bond_arp_monitor [bonding]
 RIP: 0010:ip6_pol_route+0x69/0x480
 [...]
 Call Trace:
  <TASK>
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_ip6_pol_route_output+0x10/0x10
  fib6_rule_lookup+0xfe/0x260
  ? wakeup_preempt+0x8a/0x90
  ? srso_return_thunk+0x5/0x5f
  ? srso_return_thunk+0x5/0x5f
  ? sched_balance_rq+0x369/0x810
  ip6_route_output_flags+0xd7/0x170
  bond_ns_send_all+0xde/0x280 [bonding]
  bond_ab_arp_probe+0x296/0x320 [bonding]
  ? srso_return_thunk+0x5/0x5f
  bond_activebackup_arp_mon+0xb4/0x2c0 [bonding]
  process_one_work+0x196/0x370
  worker_thread+0x1af/0x320
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xe3/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x199/0x260
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Fix this by adding ipv6_mod_enabled() condition check in the caller.

Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
Signed-off-by: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
---
 drivers/net/bonding/bond_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e044fc733b8c..522eab060f9e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3455,7 +3455,8 @@ static void bond_send_validate(struct bonding *bond, struct slave *slave)
 {
 	bond_arp_send_all(bond, slave);
 #if IS_ENABLED(CONFIG_IPV6)
-	bond_ns_send_all(bond, slave);
+	if (likely(ipv6_mod_enabled()))
+		bond_ns_send_all(bond, slave);
 #endif
 }
 
-- 
2.52.0


