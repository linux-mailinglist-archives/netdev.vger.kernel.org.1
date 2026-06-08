Return-Path: <netdev+bounces-296623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MT9UJ8PeJmpsmAIAu9opvQ
	(envelope-from <netdev+bounces-296623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:24:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4D5658005
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:24:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RW57Hmdh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296623-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296623-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F2D32CAAAD
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6163DD530;
	Mon,  8 Jun 2026 14:45:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C053DD537
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 14:45:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929909; cv=none; b=rZerI2SDk5DDwbKvOzsZAUEpzQ7JCt9G0MqIRXxCV654TSCVR4G6tLVj4c9R1CA+mHI2w9LYCQ1y2jbinxO/IbyrDGWfj2GrI4UOeGJZP7z87ubsQJ0JYYvn1ZrobQeGtvntWCVrxzdJaaUjFWkAkJJAfepQntqKIn2clXzzQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929909; c=relaxed/simple;
	bh=TtwzUePYBB0fe6C2btS90QFO48NdmxKYZXm6ZV8wtmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLF8efuR7j2qNhLuufP/DmkWNpG2sY/6OqfTedukFxqBeMyABY4v6GIkEG/c1c2btrXUk0dSjNzOFK35NQAW22e5EKouJ1m3wY4dPI4jzM9WRbzZNVOlh1rcDD8Ut3f+EcnmWlsMNwxgZXlGAF2W7baWJpBrz/W6e8AKCg/XbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW57Hmdh; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490c28f84fdso6973765e9.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780929906; x=1781534706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cROChVtUMlBOZjOAs4b3kSSichf3rGSm2eer0rPlUJ0=;
        b=RW57HmdhlF+dYWsukrQJeZx4gykIArzl9T0Bq+uMKsLXV2gSa5sdGUq9qC2s3g0eF/
         UoYpvm02gBO4WLnsQnROElbLiUST6JFxB+HQD9mDWUgN3bfihFdEY8vBtGk4O65JAU3P
         BjARC3kqy6MIfkl6Wc1zZtZLBe+0zYJgQN1IwoeNDNJCz163FRmlua0Fc9OTghPrD1C2
         mgO9kMuDACE+faE3xM6hD+EH8NZO9RnDffwQIYxyRZLpv2ksO91+jSQsBbRPpAbbzOQr
         aapo1ZgS/msu9U3TWbANq0z6oTuWc7U0W5wnAwRlyhQogdoTaP9O3sVLnww1Vdwj7XN/
         QnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929906; x=1781534706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cROChVtUMlBOZjOAs4b3kSSichf3rGSm2eer0rPlUJ0=;
        b=q1av3L5aBe/dZQvycOOdrWGqJQ2LD/z0AkColOz+aAUudNGbLNmsefI81XHcGcaRRK
         3gxN2ZA9FXefLgI+njneqvM+BXAJchxe0LsmC3GfDkQDzHDHT26ZHByYsUcyMbR5mWWz
         K3FqsCrIRTt/BPx2RYb61c4AIw2Jw1iOml8aNRXguMkbUOgsuAFeel8eCY+k67BTvaUa
         0VVCPg7teQ7zfFL5udMhRW+IMu4Y896l1W9FFxkW4SMr5ek6DWYPK30HBWfCXSOxRUdL
         qu7CQ+1dtk74lKSDVA/ceFoDoafHjRVW3DU190Q8ODC2ignRthRuD+lDwqTBkrBKEnWs
         1rTg==
X-Forwarded-Encrypted: i=1; AFNElJ9XlgiGqbZ0T60nCQiLXetDtHw54UhlJL/4VKJIsAdsvmNJLG4SoOshrUf/3DCRyljW3J0oOKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ578AZt21mdlfB863gbc47IqxHa9Q8gbU/CzImk27PbD3tbXy
	Jsx9naUKl9Be0YlOydz0Ks7DV0QADMRi42QRWEjd97/UgZfnt40MI8NoLlwg3voj
X-Gm-Gg: Acq92OFnt6qn1c4lE9H8rfy3v4JtSy1uR8G5rFf51kcpcmlqleGuVTbt/5v3NdLmjvR
	/i2T1AE5HO0OwY/aJT+nWASXjU/KI/RK1vAoGjSzF8nnXpNE3ZCZ1Wt/5qi83YAgaemic/7CuOe
	SAexv3XSJUi9bw/vHvCVAUVeQUeihJWwEA1XIyqIqmFZVG323L/jis7mZ/wLCMQMeo1YHa1Ad6C
	TwzGLUqjIRjjw3yqv8oU1fgJTOD+Y+8mSimLXXsIOOp2EFK91QrfWZ5hxmbn6Rbc0pjIBYBI+nk
	KC5tSyrfco3TIjz0ox1I4Vkpy4xj7Uen545EC6ghlcsxqFh4iCJdEkeQhFljTxtNT/RRRV+grnV
	p0PU7ZgoVS8kAA6yo9kPFJk7GUrjMkZ6+cef/Mv+p5KTtguSFJNDimlMgF8FWKI9AnqgTXWzz31
	ThMezJqfymr6rM++zWjeB9nzkw5RFShKCi+FWBStau71BPS146xyKbbMGDi3p7VhXjq7Dq1ZKdL
	ZWNzzOte6Oyt8JCtg==
X-Received: by 2002:a05:600c:a011:b0:488:7e7b:dbc2 with SMTP id 5b1f17b1804b1-490c25dcc9bmr112364045e9.3.1780929906001;
        Mon, 08 Jun 2026 07:45:06 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm409212995e9.6.2026.06.08.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:45:05 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: af_key: initialize alg_key_len for IPComp states
Date: Mon,  8 Jun 2026 07:44:41 -0700
Message-ID: <20260608144453.3553219-1-yzjaurora@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296623-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:yzjaurora@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:idosch@nvidia.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F4D5658005

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
v2:
 fix some typos. 

Link to v1: https://lore.kernel.org/all/20260607210119.2437752-1-yzjaurora@gmail.com/

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


