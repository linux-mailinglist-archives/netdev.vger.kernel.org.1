Return-Path: <netdev+bounces-296310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YzdtCCjcJWpuMwIAu9opvQ
	(envelope-from <netdev+bounces-296310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:01:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF098651942
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:01:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZICtpup9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296310-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296310-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 023463001FF9
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 21:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E765832FA18;
	Sun,  7 Jun 2026 21:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3F2E4257
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 21:01:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780866085; cv=none; b=mZFydO7xbLr36qw+8arwUZLAFp3VNd4TuP5o+lcNJcAGAURCsiVXy16j8G4/wbQ9c5urEIdyR3CeScK7bc29lF3rcEjrBDI8qVVWUi4euy6WYUm2NhiH2ho2zxH3TgSNowVcnTvUFm3PQ4rgOTfjb9NDsgU0VOe5jD2s8bw7l5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780866085; c=relaxed/simple;
	bh=cvyOcjhtMlvvFxqMsah19NK9zcmo5fvDbymjyWwBqUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INuVZPLjtqKMUGNKWCXqCdctGwpaZEOfHn4X0UMkYEOX08ELaYixhr3ranxUBglR3xjVRFRrVmCKDGuWUaqfbqBdzsonY4C7pphNPoqptO8vK/g8jgjUEjOTXbj9YSEjQJVh17xMST6zeX+CenMI4CghKsx28mmL77+y4AgiiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZICtpup9; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a7629453so3613545e9.0
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780866083; x=1781470883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuWhUU666YoCkcgjw3YuQ/NERV8K0Y26bfg0NnK3PCM=;
        b=ZICtpup9fHGT/Om+JcLOpWNhN6g1UvQR+qApKh4wXClQbt29+kubA6XKC9kmuEMAxD
         5nY2k4jFmnxTvrXUYp+XEuK2wNeIp2wPaR2vKgSq6BQ2qbEDGSraACWyIsoIVw5ATfaT
         gDbEWq6f0YhZCjTwyEoClRG9/y1uohp7WLRLCTIpCYmrWrQ0AzEfSJDj5EGMZqonJezc
         OmRfQWmpA11hk9My4Uj2YBjPgCA/qH8U6qcw9FHeKAhw22LRx73UUKekIQ0RmANGw5qW
         MLisEp2qQ/5H96i7wh2H/Zv86Th/uHblABFDYOhBjs2iUA4gxxn3uTznVVG/5xdz3ERR
         rwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780866083; x=1781470883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuWhUU666YoCkcgjw3YuQ/NERV8K0Y26bfg0NnK3PCM=;
        b=K7UYK2QUA+IBr+oAbL9NtCG/RwoBKloArYRx+gEXCNs19PCqA/E9wzEUUTjrYZt7d1
         N+EdLtsC9oWHt/efuwi+xh/DXNTbbScRd5IfwvwHWgwFqKdG8pfP9qcOgo9bG/EFjXyT
         G9YpKFXrF7RWSRVlZ3SpzmhCaz2MQeOl0S5GETP+8izPcREPsMZ00Hyqv5Xp7ixEbgq/
         4MBWfNKCK/hyyJ68u8Rm13g2rKYew0753bttJFqJqglN4U1Y06BqKF9UcSNpjAfa4X5E
         0CQG5V/c5ihNAfXJug68nJ4lCNBmA9hvyOogPpomG1bTvSShbCQXKTIz16YQEJccMc8R
         wC4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Aio4Pc99kbTfzteSuuGsYcKVMF+38KElDO8tHAFKWl2JT4Y5nCvEyyA5R4Q1qqVr6sm6AN6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlr8AqQZL0VPfxxn+U9BDl3S0fVkmCsZ83yhxpYAz0nmPbRUk
	GzO6T4OXSbVBLfZTFr5z0J/24Re5ew+QIt/H8uLCU4nNob5GsnNj7M6r
X-Gm-Gg: Acq92OH5ZZCByagdMZ1Rl/0xDiyZptTcRsjum6vYx2bAj7cq/JFqjoMbMaU8PkbVfwL
	I79DERRrvBE7dmuBxtFblF00o/yFKKPqTB7mXMjbdY3cizgdqaE2YWlc0DBTCQ66bp3pFMQi6V+
	S/MJBDWx5Ra+o0Glr4ObVCj9Q1kvk5UBzI9lOPjlXTDiiYZZT0BuOQ/GnAlyC49yO9AA5gkW+Ax
	dz0dWSncXSbxhnZpbPHkp+PU0yTf3wdw1wx0a4B6CdQb8DFT04wmYR4ElXJ16S6WUZCu9p1fYIP
	QPRwKJCCwprmC8j2cD5wTwyLl86ATw0TsiRFwO4orPtirYSn4atT9kTk4TPdS+kzXwSkgsAxrNF
	+Ese4zLwtSL8f9oWs6+T9ED8NSbEeNc76EfZdhUgq6r2QSy2fdC4tli4NoMlLR+lK0eu+d9gTLT
	cvx6vmso4bimC+ePaNUi1W/3T2F0Ao8ie//Kna+CJ4fooUZo/fKZORb7otVVR4Og6wyAj+hsAz1
	uP5hg6IltpTQqh+Sg==
X-Received: by 2002:a05:600c:3551:b0:490:b71f:2eb with SMTP id 5b1f17b1804b1-490c26220b7mr90247955e9.7.1780866082417;
        Sun, 07 Jun 2026 14:01:22 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm47940617f8f.28.2026.06.07.14.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:01:21 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Your Name <yzjaurora@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: af_key: initialize alg_key_len for IPComp states
Date: Sun,  7 Jun 2026 14:01:17 -0700
Message-ID: <20260607210119.2437752-1-yzjaurora@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296310-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:yzjaurora@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:idosch@nvidia.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF098651942

From: Your Name <yzjaurora@gmail.com>

pfkey_msg2xfrm_state() handles the IPComp (SADB_X_SATYPE_IPCOMP) case by
allocating x->calg and copying only the algorithm name:

	x->calg = kmalloc_obj(*x->calg);
	if (!x->calg) {
		err = -ENOMEM;
		goto out;
	}
	strcpy(x->calg->alg_name, a->name);
	x->props.calgo = sa->sadb_sa_encrypt;

Unlike the authentication (x->aalg) and encryption (x->ealg) branches of
the same function, the compression branch never initializes
calg->alg_key_len.  IPComp carries no key and the allocation only
reserves sizeof(struct xfrm_algo) (i.e. no room for a key), so the field
is left containing uninitialized slab data.

calg->alg_key_len is later used as a length by xfrm_algo_clone() when an
IPComp state is cloned during XFRM_MSG_MIGRATE:

	xfrm_state_migrate()
	  xfrm_state_clone_and_setup()
	    x->calg = xfrm_algo_clone(orig->calg);
	      kmemdup(orig, xfrm_alg_len(orig));

where xfrm_alg_len() returns sizeof(*alg) + (alg_key_len + 7) / 8.  With
a non-zero garbage alg_key_len, kmemdup() reads past the end of the
68-byte calg object.  Adding an IPComp SA via PF_KEY and then migrating
it triggers (net-next, KASAN, init_on_alloc=0):

  BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x44/0x60
  Read of size 4164 at addr ff11000025a74980 by task diag2/9287
  CPU: 3 UID: 0 PID: 9287 Comm: diag2 7.1.0-rc6-g903db046d557 #1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x10e/0x1f0
   print_report+0xf7/0x600
   kasan_report+0xe4/0x120
   kasan_check_range+0x105/0x1b0
   __asan_memcpy+0x23/0x60
   kmemdup_noprof+0x44/0x60
   xfrm_state_migrate+0x70a/0x1da0
   xfrm_migrate+0x753/0x18a0
   xfrm_do_migrate+0xb47/0xf10
   xfrm_user_rcv_msg+0x411/0xb50
   netlink_rcv_skb+0x158/0x420
   xfrm_netlink_rcv+0x71/0x90
   netlink_unicast+0x584/0x850
   netlink_sendmsg+0x8b0/0xdc0
   ____sys_sendmsg+0x9f7/0xb90
   ___sys_sendmsg+0x134/0x1d0
   __sys_sendmsg+0x16d/0x220
   do_syscall_64+0x116/0x7d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  Allocated by task 9287:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0xaa/0xb0
   pfkey_add+0x2652/0x2ea0
   pfkey_process+0x6d0/0x830
   pfkey_sendmsg+0x42c/0x850
   __sys_sendto+0x461/0x4b0
   __x64_sys_sendto+0xe0/0x1c0
   do_syscall_64+0x116/0x7d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ff11000025a74980
   which belongs to the cache kmalloc-96 of size 96
  The buggy address is located 0 bytes inside of
   allocated 68-byte region [ff11000025a74980, ff11000025a749c4)

Depending on the uninitialized value the same field can instead request
an oversized kmemdup() allocation and make the migration clone fail.

The XFRM netlink path is not affected: verify_one_alg() rejects an
XFRMA_ALG_COMP attribute shorter than xfrm_alg_len(), so a calg added via
XFRM_MSG_NEWSA is always self-consistent.

Initialize calg->alg_key_len to 0, matching the aalg/ealg branches.

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
 net/key/af_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 9cffeef18..3216f897a 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1218,6 +1218,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 				goto out;
 			}
 			strcpy(x->calg->alg_name, a->name);
+			x->calg->alg_key_len = 0;
 			x->props.calgo = sa->sadb_sa_encrypt;
 		} else {
 			int keysize = 0;
-- 
2.43.0


