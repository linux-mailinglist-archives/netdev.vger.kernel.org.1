Return-Path: <netdev+bounces-307595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0yTNM+GoVmpc/wAAu9opvQ
	(envelope-from <netdev+bounces-307595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:23:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D515758F50
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:23:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=azP2SjXs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307595-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307595-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D91301E59B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4B741D629;
	Tue, 14 Jul 2026 21:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141763D966A
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 21:23:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064223; cv=none; b=acIJ2ABrERhHAHkWd343USsLLwYW2da8A/Az6m//TtPHZyWpnTEhXZUdiZtVTRJkQVNL19R6QTdWscyUvQWvvnyEcKiYko8rZ5Vfj7MC2jMp6Pr3l8yHlRQmCWAO38cAsk1s86fOkZhzCnp25u6mrXB8qJxg0w9TS/8ABqJQh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064223; c=relaxed/simple;
	bh=n9Yz/38hoJril5dCerx/HxGEMGg/Te0wQ4wLGv6TztA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiGovidSiPRKn88GtZZ7+d3GZg/hH+i1CPOvzqleq7a87L99fxR6Sy1Et05uZb59a1+U/4MHvz+R1Q4sFbYhvq1tufNhcM5Q3G+XADzQNRk935CcofJ1Zo9qEIpLNzHjVp1cqmPcRPc22gxx6yxr/jDARtnoIcRYGb638SyD4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=azP2SjXs; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423f236418so1248494b3a.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784064221; x=1784669021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1344qgK1KXfGz8odnjT3G64QkGD5RQr6ifbgVRduQo=;
        b=azP2SjXsmGbkjgyYUH/HUxQFlR8JTnNFIsymrhIsgh5OWS0mZ9cjS7UmTg2rYJbvdp
         cKcG7J3F9XOr1QFWuu95SXGhYMii0kAjWIlm1FI3p5BRIC4VWB6eEoQT5nScdH1EQMLW
         pCYDteB+Mfn+fSj1widPhnA1dww7TY/P9sl26mWRtx+X6XMbpk812MhVOU1bjsXpTsEj
         FG3XbUQ4iuB2pnKy4dhBBFxbn4+VV2CVTGbsP/nU7UZSiaFz7Ip1YXrURc4vdLROJB8M
         mU29d+903RXOpoZOSbHgxuolM6VNZWgJbzIgBFiljK3vR7DpXSYRNmJoluHOo1lCCrH4
         F4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784064221; x=1784669021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1344qgK1KXfGz8odnjT3G64QkGD5RQr6ifbgVRduQo=;
        b=KP1/UKaBbVKOohnVTo3/3rivrQ20qzG/NCaejXwPvKo5MamyBRIjh2rRG0WtRzVsRX
         B6QCTQL6K7Lq5t970ACOb9aTHJE0Ofmn03bIRrX1mo8cMl5oG3lMfUWb9ipuYi3ZA3Lk
         oWhDUFczColoHmzAVAGW6LFyoscGEr004lnz8iI22NzUj+4Vx6+zsawHBygMlbYRaeyB
         SVmkMKscRg97DfTNbL8B9q152UqMPngciLLm5Q6uDNcTmI0Gll8NXRi2inweP1irx8H1
         hWxrb1F/61iu9xl2e2qH9rKMMfU1JyDaVoO146mRnXUa4T6TYmzqC9UmS9D75vxkTv9Y
         fkYw==
X-Gm-Message-State: AOJu0YwMYZzeQ4h0orE1FEDiP+OTHdW0swbqUN3J5CMoWt++ZYfmEsH7
	AIN7aFRdrMmwwaDsQwj/qqi8socLMG0JB/M26BU6nJw3M8P6KpcSaufj7tBbO7Vz0A==
X-Gm-Gg: AfdE7cm+lojym6I+OkKHs/Tb41OrlaHCmPVwOQRd9ZGMVB8nJcgYLtruQyNmh0aTlQq
	8Fz5ZLrp92f3omGuwNPovsMjRe3KZmYwAHmxa2UgBTX8rIKf3YjGld7r52+JUca6WDXO1J86TK/
	f7Cn9IQpO2avvfa7maaR4Smq5VGFJlwhKh+1VF1F8KKAgruWCDY3jZv/Wk0+BWVEgtYkWpn1Whv
	TAMy99EArKqFFvnShtNYbRE5iSL3VFRuxTEkmwyc0hZYXkM9Tqw7RQyXGojOnqrh9ZodzsbILql
	ZnphboBSU4nOVCeXka2RZ4tgOoSmALapG3rBAQS5Lpv0I4VAHcculMGmlSD3aHZG+kQFK/v0zYP
	OLONm5aDgkeVgOn+ArNbeC6G2suWuHKybDiStwUVnuY+garOaakCNi24bidI2/WEcNP/v8rgUNU
	jeL52McxYBhg==
X-Received: by 2002:a05:6a00:27a5:b0:847:e2c7:59c5 with SMTP id d2e1a72fcca58-848896bb796mr14050225b3a.49.1784064221414;
        Tue, 14 Jul 2026 14:23:41 -0700 (PDT)
Received: from p1.. ([172.56.106.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dc8e7sm2018325b3a.47.2026.07.14.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:23:41 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3] rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()
Date: Tue, 14 Jul 2026 14:22:39 -0700
Message-ID: <20260714212239.1511269-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307595-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.oracle.com,oracle.com,gmail.com,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:santosh.shilimkar@oracle.com,m:ka-cheong.poon@oracle.com,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D515758F50

rds_tcp_laddr_check() looks up a scoped IPv6 interface with
dev_get_by_index_rcu(), drops the RCU read-side lock, and only then
passes the bare struct net_device * into ipv6_chk_addr().

dev_get_by_index_rcu() only keeps the device alive within the same RCU
read-side section. After rcu_read_unlock(), a concurrent RTM_DELLINK can
free the net_device; ipv6_chk_addr() then dereferences the stale pointer
in __ipv6_chk_addr_and_flags() (e.g. l3mdev_master_dev_rcu(dev)), reading
freed memory.

Keep the RCU read-side lock held across the ipv6_chk_addr() call instead
of dropping it right after the lookup, so the device cannot be freed
while it is in use.

  BUG: KASAN: slab-use-after-free in __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
  Read of size 8 at addr ffff8880106ec000 by task exploit/153
  Call Trace:
   ...
   kasan_report (mm/kasan/report.c:595)
   __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
   ipv6_chk_addr (net/ipv6/addrconf.c:2031 net/ipv6/addrconf.c:1972)
   rds_tcp_laddr_check (net/rds/tcp.c:370)
   rds_bind (net/rds/bind.c:248)
   __sys_bind (net/socket.c:1920)
   __x64_sys_bind (net/socket.c:1956)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Changes since v1:
  Use rcu_read_locks instead of dev_hold/put
  Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled

Changes since v2:
  Add change log

Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to struct in6_addr")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Allison Henderson <achender@kernel.org>
---
v2: Use rcu_read_locks and rebase on rds: Fix inet6_addr_lst NULL 
    dereference when IPv6 is disabled
v3: Add change log to commit message as Allison suggested


 net/rds/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 955d92277d5a..30cfb0087f2c 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -355,23 +355,25 @@ int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
 	/* If the scope_id is specified, check only those addresses
 	 * hosted on the specified interface.
 	 */
+	rcu_read_lock();
 	if (scope_id != 0) {
-		rcu_read_lock();
 		dev = dev_get_by_index_rcu(net, scope_id);
 		/* scope_id is not valid... */
 		if (!dev) {
 			rcu_read_unlock();
 			return -EADDRNOTAVAIL;
 		}
-		rcu_read_unlock();
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6_mod_enabled()) {
 		ret = ipv6_chk_addr(net, addr, dev, 0);
-		if (ret)
+		if (ret) {
+			rcu_read_unlock();
 			return 0;
+		}
 	}
 #endif
+	rcu_read_unlock();
 	return -EADDRNOTAVAIL;
 }
 
-- 
2.43.0


