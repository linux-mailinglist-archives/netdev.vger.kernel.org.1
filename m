Return-Path: <netdev+bounces-300975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VX1yGQjrOGpAkAcAu9opvQ
	(envelope-from <netdev+bounces-300975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:58:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E86AD73B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:57:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=bp9dVocf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300975-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300975-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF26A3008765
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33B383319;
	Mon, 22 Jun 2026 07:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35712381AE5
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:57:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115064; cv=none; b=mAEgNlnNxVkU9znUVrwtLLFs3IzGFoLRfPW2GBsPsCeFDiQhsmtA9I5Ec+6iUDp58w4E1I3dJI2bz/u/eukkyceN3jgfPzXm7mi05cOS46GaIQBQyY6Z1ip0zntI680vYAnmqJ9/zM/WNON+FWKX4/F0fT7osK7hBKGokdbFc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115064; c=relaxed/simple;
	bh=qglayTtlV9MNBP3Gf3/3tK7Cmi3KV52Qp3qBdwLtGaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdpBW/GRBrJ7GXE+cf2wwpSFE1ByVv5dO8OD2YjtCW+jsuZSBr/LjgeEOvyNonAUWTeaISg/r+DUHjNRxXO0p7+ipz6E2krMMHjwd0ZZNQ3GMioFkciFPUtnrbNmuM5mpIjkT5ixzvrzaMbMX3ovfQbCfZIaVtEvEQW4tl6MPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=bp9dVocf; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 04B2F201E2;
	Mon, 22 Jun 2026 09:57:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QkuzZ0m-J7gw; Mon, 22 Jun 2026 09:57:34 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4935520754;
	Mon, 22 Jun 2026 09:57:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4935520754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782115054;
	bh=gMaYxNxtWs2KKmj6H9ZguUSLOBsBq8KP5IUB/6bELYo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=bp9dVocfoLL6uvA8w61AillJltdJ66bsOXGxaoIaMs6Yj67tncmGM0pDknwc1pbkR
	 zuyer1XPUh71MyfByqeEl9uPdXEp230HKBz4g41kN9uYmWYBZwOMm20Yvjb+XhyywH
	 o0YcFmaftO1Iyxv7sUC/YLp2u9IpIZ4lylCGzNOyMlPbIEtdewXn+xhrSOM6XRlnYd
	 Qby7YfCPxtKwgeDcXdnBwGxsibRx075jr/M8lGqjy1/B/0C785cWoWYTOdVvNWrJTl
	 mjuu9Ug6EGOioDlbjp0nLrwwf+9lBe2nY9xEmKJpqTaWCaDwJk7e0yGer7pU3LLbI4
	 JAdWCVcMFTzvA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 09:57:33 +0200
Received: (nullmailer pid 30058 invoked by uid 1000);
	Mon, 22 Jun 2026 07:57:32 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/7] net: af_key: initialize alg_key_len for IPComp states
Date: Mon, 22 Jun 2026 09:57:04 +0200
Message-ID: <20260622075726.29685-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622075726.29685-1-steffen.klassert@secunet.com>
References: <20260622075726.29685-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300975-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B22E86AD73B

From: Zijing Yin <yzjaurora@gmail.com>

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
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/key/af_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 9cffeef18cd9..3216f897a305 100644
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


