Return-Path: <netdev+bounces-303911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /xS5LlW5RWpJEQsAu9opvQ
	(envelope-from <netdev+bounces-303911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 03:05:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5A66F2B75
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 03:05:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=KjLhFvIc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303911-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303911-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C031C302EEDB
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3F225417;
	Thu,  2 Jul 2026 01:05:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E977262E
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 01:05:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782954323; cv=none; b=aaEpFuD6E0Jw9ezXVMSKwqKJczGZGZLbBemTBCi31HhFdO5UmleXjHZVuQaotB32dsDkJnPc2ZNqvz8/dfkIcO/G15RhzV2rw/EIU47o0xGkhnQyAb+Hf3AJgZR9r0cYQKi4T8MlG2ftY3xdMMge566FfbU8UrCiWhiScgqE5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782954323; c=relaxed/simple;
	bh=BL7fpg+hev2aTdz+USemxNuBl28/n+mItaSQrlZpMJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdmkHOH7jOporUNqDzGfVEtFbJ/LRKF+N/ScMsiBc65d542FLheRicq55Ck4UfXqsiq5LGOfmyQogfpaVVdG5vvP5GaONEfA2Mi03BMLpRx08BKcMt0dMF5AFxe/h7NTed2OWyfoGN7iYm5a9V4A6IabL9fHre+oAvqIcHenPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=KjLhFvIc; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37fcae0ecb3so933937a91.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 18:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782954321; x=1783559121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WeonFO4IjuG4HJdhzbTWC6iM3TkwFvdMtNEruwDISF8=;
        b=KjLhFvIcDoJD9eF6GAXIC/PRfw9IG2TN6vx/4d5uVKaB/XzQHJjWk6R5ybytuvQKZD
         O0b77S8m3nG9XW7Aoj2SoetVGt5826Tvh34deidU5VyxwfuxSbcGlJDtSkr5k7i3jmrk
         /NZtzFRjYWLF/Id3Gvr0JJqXLAt7lYJ/mYJ6sixxZp+2SND06h5zrI0MC4Dqz7hyfx/j
         fOnKvAs7CUER4HXxKyH4YZ1RwVIsTwXEzPDAlb4YjqoxhwlVJhSOGWXed2Vp5ieNPgTk
         d8z9huDcPWCNs5/86XCoybi/wJrT7AAI8POCyAOCmu143lDeVSLNwjMVnjUjiDOufeqU
         QTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782954321; x=1783559121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeonFO4IjuG4HJdhzbTWC6iM3TkwFvdMtNEruwDISF8=;
        b=pyfgA3BjM+R42KT2yzmJ/JDSFyElhaKL2HI2ShlRV68pGThi1bhFZwveQxXqLcBHih
         RwfNHsONDUWGHUIZXm1hlgXB5MlRSMMKNSKw1NsIcCttasWUt67NFIVSPbS+nDmHjGCF
         MnUlls1buOAdfLhzIjZc/g15TeRhNjsTrhrDdM/J/D99QTIjY605yh+mgBr72UlqKuat
         Qbf9LWbJ8f6Y38oKSS3cobjRI2Bh85k/Qp/hId5UG+2i1rU/TEwW1r6VBZTzAeeo+bSt
         cjIxV7xVhsLuprF1ONjOw+mmNatxWT8j0dTch56/xpukylsc0pVUO1HFCS6YqlzsV0zt
         MzOg==
X-Forwarded-Encrypted: i=1; AHgh+RoNDdjCNm4sQRuaQWTPVkI2u0n0DhhyBAEve1w6xrgM7x4ghVEMTIvwqBqe6NGDvKqcfmF+AZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCuOGMN8nMf89Axvdmzvs1K39VIhFBslmwiJQ/MroXoKdIVel
	IapUya7pTD0oAZN4HTKmbrOatrabOry8rgpu/TMrrUgE7wtRnmtBRGSlZdRxJaPG3Q==
X-Gm-Gg: AfdE7cn+Mj143X02zONo9UAlsM8urZG5WEM5Fs3osf7K9+xH5ADE8KLlQD1q0G2f5TB
	sxdZgLUDOq4KVcVjENipT029WCWI4z2KfDT1cbdLYTnEgPmUAblIzyCI80Vd9LltJTu+N1SETrB
	nhrBRI4mCUtFRy9TspzN5z9lCSU/lCSBnkOLgu4uPxYxEKG/epixpTH1mt2httiX6Pup5RuYUnU
	ZzA7ol7hubyPCRDCDM/KYHCAlBvUEvzGvWy0yDFG2ngcfVE69GDK/77exCtH59U6a8pd/bDrP7K
	lRkqMFMfGMLejMXn0PyzOMslNpSovks56x4bhi/6Shbr9BlrnOXHix7JnhSJ5/32ZgfE6X6qLCS
	+mbosBj1+iEwU4nIKtrlcYz4AC8unozCAjpfnZm2R20foWfMx0EbizM34ev/t3YTBrh9GjUL+Xe
	wqqoLm9pafl5D00V9zUw==
X-Received: by 2002:a17:90a:e7cf:b0:37f:9ce1:7369 with SMTP id 98e67ed59e1d1-380aa21c833mr4035350a91.31.1782954320615;
        Wed, 01 Jul 2026 18:05:20 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84366sm3417434eec.16.2026.07.01.18.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 18:05:20 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH ipsec] xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
Date: Thu,  2 Jul 2026 01:05:16 +0000
Message-ID: <20260702010516.221830-1-xmei5@asu.edu>
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303911-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F5A66F2B75

On the error path where in6_dev_get(dev) returns NULL, xfrm6_fill_dst()
releases the device reference with netdev_put() but leaves
xdst->u.dst.dev set. dst_destroy() later calls netdev_put(dst->dev)
again, so the same net_device reference is released twice, underflowing
its refcount (ref_tracker WARNING + "unregister_netdevice: waiting for
<dev> to become free").

Clear xdst->u.dst.dev after the netdev_put(), the same way the XFRM
device-offload paths xfrm_dev_state_add() and xfrm_dev_policy_add() in
net/xfrm/xfrm_device.c NULL ->dev when releasing the reference on error.

  ref_tracker: reference already released.
  ref_tracker: allocated in:
   xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:86)
   ...
   udpv6_sendmsg (net/ipv6/udp.c:1696)
   ...
  ref_tracker: freed in:
   xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:90)
   ...
  WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x58b/0x780
   dst_destroy (net/core/dst.c:115)
   rcu_core
   handle_softirqs
   ...

Fixes: 84c4a9dfbf43 ("xfrm6: release dev before returning error")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv6/xfrm6_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 125ea9a5b8a0..3b749475f6ed 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -88,6 +88,7 @@ static int xfrm6_fill_dst(struct xfrm_dst *xdst, struct net_device *dev,
 	xdst->u.rt6.rt6i_idev = in6_dev_get(dev);
 	if (!xdst->u.rt6.rt6i_idev) {
 		netdev_put(dev, &xdst->u.dst.dev_tracker);
+		xdst->u.dst.dev = NULL;
 		return -ENODEV;
 	}
 
-- 
2.43.0


