Return-Path: <netdev+bounces-121142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6777995BF60
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2489B2819E5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C61F957;
	Thu, 22 Aug 2024 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfIJdYdT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705618028
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356983; cv=none; b=V00Wwtbj9vcxh0TkOD8wqWMJi4ohEPI6gMEU9Lba4t0pr8ZGY/K3kvziXSnpGFWPjOFO/Wgsg1zgXxE1RghF1zf+yjX/cQZfh9iU+Ukpv1NMbR6p7zT2BFRCt2V+c5Jpiq/bgNow4hq7I/ktVXILkMfVqOXxzGg4tnmIkaeA4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356983; c=relaxed/simple;
	bh=dAOTAzQtsqUhJ9nr+5AGQRTrWWUNCbb+9JVeDxdYdVA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mm8BVb3prFG6VkdqGd4rKZIRwV0iQ9VY/OA17mhSDbKnT3FG45a3ohHKaG8qNYUMybyHmRkA17lB7pb9fBADhdbfD/KA8qg1ajgQQgctvz4eEcty/F20TqvKyB4P/5HkTqgB7GhsDXBoS9CdH9vnt6RubdQkoCqLEaGTG/3e/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MfIJdYdT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b0f068833bso34769287b3.0
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724356981; x=1724961781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6i/VvSQHyY+RKFqO+9VqqWKRABFbfUdHNxxXJ99lOWg=;
        b=MfIJdYdTZn/k4o2mJz5BEE60OCJ/6lm+Susg0lwFoX9i0Z9qdA0aux91tfjjp75Kje
         vMr88ZQh95LD2c3ufgIp9dStUdU8QNCPfhqLzLwArK7BcXYzEHBmnQwHGJl2C0xQqw6E
         kA2YFKhUiFTT06eQnXiWFIKW71WKtGGEb0SlfsaRwkKHoGKKr8Op2s8KswWJF9UvfCCO
         6fBA88TFr05CvwzcHJb5Jnlz0wpzrdNVqJxsr8oZ7jnu/3A3p7uTUe/A50rHObOuCn2+
         da5JiQqQZZZ6rttdP1i6rK8jr2d6A0g6zjO7sDP8nPUzct2NduLbMUYLj3B+f47EGluH
         iQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724356981; x=1724961781;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6i/VvSQHyY+RKFqO+9VqqWKRABFbfUdHNxxXJ99lOWg=;
        b=ZphuzhTwMZ613I6SbWFr/0f2/vTpL+LdB5lYbGwWM1H4n+AVgirsWXhQI/BbB/10G0
         R4myM6Rp2zt+bYgb5eqmmvMwModYk1riYHdYumKO1MIzvtTjspRWObQm4OfhXcF6ySil
         VJX1tH0U8LXoBdPqd1IE7bx4oCZ0O7wtq9cQnyiGi5qUokyjVB6LYcY01agpRNrKGtZg
         FX3mZEorOIbOBGP/wGcosGIgTDB1vjwD0BgCzryEcqap42WMk7pcL+nMzbOHvTCMQiaj
         O2mGHTSyOg56UfxQMWrvwIzequuql3/lFs10wdm2JBpRgfOe70vrNCvwL0TJMyaK5Sjt
         wGYA==
X-Gm-Message-State: AOJu0YyuHs3QkOkPD1ZgGE5d35/g8lWyf2iP/pJqj/Z9Vg+hzwE8+MtZ
	4xk2AxwoJiN5V5IIi0KVajNC9cOHqp4pBI+JLki6K12DLOeLyngZodcRjd0WJVNciwjoSOVY2O/
	q0DFpchvkiKw9FRWM2T9gqUHeHYqw1f3ktTI/uK6PRLqQgKnFMWBp48b6YoL671XvE3SmaCcZQH
	AEZCd7r5eXmfvfyObwUfedjGw6DpJtbxm0
X-Google-Smtp-Source: AGHT+IF/eAtuwmCkEArYum4zSj+lXK7uEFAUJEx3jN5lFOP/VeSI4YPBIgG4raiLgH2NTJijgxJO4QSsouE=
X-Received: from wangfe.mtv.corp.google.com ([2a00:79e0:2e35:7:ee65:a7c9:8a6f:c427])
 (user=wangfe job=sendgmr) by 2002:a05:690c:c08:b0:644:c4d6:add0 with SMTP id
 00721157ae682-6c30307d93fmr2852897b3.1.1724356980681; Thu, 22 Aug 2024
 13:03:00 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:02:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240822200252.472298-1-wangfe@google.com>
Subject: [PATCH] xfrm: add SA information to the offloaded packet
From: Feng Wang <wangfe@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com
Cc: wangfe@google.com
Content-Type: text/plain; charset="UTF-8"

From: wangfe <wangfe@google.com>

In packet offload mode, append Security Association (SA) information
to each packet, replicating the crypto offload implementation.
The XFRM_XMIT flag is set to enable packet to be returned immediately
from the validate_xmit_xfrm function, thus aligning with the existing
code path for packet offload mode.

This SA info helps HW offload match packets to their correct security
policies. The XFRM interface ID is included, which is crucial in setups
with multiple XFRM interfaces where source/destination addresses alone
can't pinpoint the right policy.

Signed-off-by: wangfe <wangfe@google.com>
---
v2:
  - Add why HW offload requires the SA info to the commit message
v1: https://lore.kernel.org/all/20240812182317.1962756-1-wangfe@google.com/
---
 net/xfrm/xfrm_output.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e5722c95b8bb..a12588e7b060 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
 	int family;
 	int err;
+	struct xfrm_offload *xo;
+	struct sec_path *sp;
 
 	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
 		: skb_dst(skb)->ops->family;
@@ -728,6 +730,25 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			kfree_skb(skb);
 			return -EHOSTUNREACH;
 		}
+		sp = secpath_set(skb);
+		if (!sp) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
+
+		sp->olen++;
+		sp->xvec[sp->len++] = x;
+		xfrm_state_hold(x);
+
+		xo = xfrm_offload(skb);
+		if (!xo) {
+			secpath_reset(skb);
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+		xo->flags |= XFRM_XMIT;
 
 		return xfrm_output_resume(sk, skb, 0);
 	}
-- 
2.46.0.295.g3b9ea8a38a-goog


