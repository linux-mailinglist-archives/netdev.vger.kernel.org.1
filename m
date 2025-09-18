Return-Path: <netdev+bounces-224427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D214B8493B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36915863A0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B613043DA;
	Thu, 18 Sep 2025 12:26:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA4A3002B4
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198370; cv=none; b=VkDYEGFoFAVie6borKGMLTwR6+i3yVGDwKxtoSK9dMIxpQsHNONm88GwOZ5XpmlzSYxujAX+/b6t0gkECvOogWS4FIopOd112aUM5Qln7VtGSYqL+pYnQx8dHaPOlVAUlF6SwkfaKfjkyTSeJtlfUL/rRE8XOcnnk57V3hJO/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198370; c=relaxed/simple;
	bh=1ZyrXc5eguQ4nZOdpuBHcd9qz/QJUzyRk5wrrrTeEOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJGvxLocVHHyLd0Bh/c2fTtpDT/lNDgPKY5R7TAb+HQOMglyOhVnrHXwSgBzrQ0jf6EF+QYhFYlwm4WNYpmPkqh0a97k8o+PfX4FI7wnOzKinn2ZiiOlSUN7kZRivFg6z4yfzSeVmfUFgYdsP2VFP6/8EUSn1h6PN2LxGMt/i20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so1451010a12.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198367; x=1758803167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHgQrtaXA3CwQHoEgNdvwm+devLT6VoGzzYSteKI2z0=;
        b=L3xR6oS3VIav8yI1FZcIlA2sp3Es60IvtzRPPQBoBDiAPDNdSgQkvnCZUd4IFnE+rr
         MfhCBiRsqtLSb4uH8qkkvty7aup+Fg/Se1Ie1jCBkn4dF5jV4OIhZ5J3tE26C676d/fX
         0/N2viHeOJUBq0ag/G90p5F4oEQAscILkS37vYPbEl61+rgh6hKgk5l8kdYYa9Z2CD5a
         UB1ep9+XVteFYeAOK7tYqexUvg7eZLuL3JwM5oSyhtExST8epYU2+7RnffOPlvrl6EkH
         FuYwK+6boS6jhSNGvaXAXTHJ+/sPg/xyldvOpSelATKI0RNZhzhlfADPpX4bWBwc588T
         4Zfw==
X-Gm-Message-State: AOJu0Yw66j3D/52txsfqv1U+p3Wj8ujuabnAeTzUGfMG8qrgHwj6td10
	njUnnqIDQwFwmu3iB7iT9lMUr/7vONOjH/fFw6EyuwEiodaori1Fygax
X-Gm-Gg: ASbGncsIRPwxpyQeXdQ5DGv737E6WAhIq/Upj2MTGufzTUT0YeGwwpt6rPzBh42s8Mg
	CRl08ZNgC4XMa6WD6znj1OlFgmynhR+uxtOE2nNsb29hPYCbcpmAySC1Lrh2wSO/12wj5YZqyP/
	4JAwoOV806ZkGL8CA9edBz/dSDcOEmnyKUZsywTZlCjO70cK0OkInAGP9/8gncelI+ivqYqSxeI
	GlNYmWlbCDx9NF9JBg2Ee7mu8JWyA23LVRFX/Y2YFYo1HA5nQ+1rGpWIXiCspvDCvVskEJbKRWz
	Kd7V96/izE84lgqt6GCljQcK8STixZRoJTBNwcmcGfCNjgTDEuZ1kpwVxdRlfqlCyJouQ6FPE6O
	o+qXGIrKJ4TmS3pxcnNtGlir0biQl0ELo
X-Google-Smtp-Source: AGHT+IHQbn9/m3ccJDFvWSaJoDeaFgApVbuYmutNfQ/dxYqND/Giu0MzmqpZxURl3wjAOffAbFRuJQ==
X-Received: by 2002:a17:907:3e1f:b0:b04:2b28:223d with SMTP id a640c23a62f3a-b1bb6048f2cmr589960866b.20.1758198366662;
        Thu, 18 Sep 2025 05:26:06 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc73bb6e0sm185376966b.32.2025.09.18.05.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:26:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 05:25:58 -0700
Subject: [PATCH net-next 2/2] net: netpoll: use synchronize_net() instead
 of synchronize_rcu()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netpoll_jv-v1-2-67d50eeb2c26@debian.org>
References: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
In-Reply-To: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, efault@gmx.de, jv@jvosburgh.net, 
 kernel-team@meta.com, calvin@wbinvd.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=leitao@debian.org;
 h=from:subject:message-id; bh=1ZyrXc5eguQ4nZOdpuBHcd9qz/QJUzyRk5wrrrTeEOQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy/paWSB6Fsp2/fITxY8soCELwCOwl8v0wjEV0
 H4HXZ1ZML6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMv6WgAKCRA1o5Of/Hh3
 bRh4D/9ado3wKgqC7kSdWCw/7N8jroWV1gnq7FDqlPy0XR/oGiEtEqrOlccvW8piHS7D4WfPEIr
 eOHdVZ3xaA8UUpvL3rJQvUxGMxmK5pv7eRTMbwpiV3qhszg9DczV33sRHgcza3HobBlgxNPYHQJ
 3R3ODo+f+AlixpSjKfO06p7NFtB7JLn98x5xVaas0l12U7mmpLuGIyqPtwOturZPeoHBshuMAce
 C7ahevhH7qsIAlXci44biqJJyjlbKLnQqT3thPhex3KszG6wNu9zuEwV6wBxGfMoPg4ETrS0Olv
 YsJi8vMGWCu90y5mShzrtOGSgVAmGWKDjMyY9uSnunisWOnLz1vXjw131vExdKTlXqnjyXAupFI
 hiqr5CrD2Dk4BD3RQyt+UMDSHzTyz5krtjBefnGpn8G+sAtB6Ow8551NfZ7sYwtVEB79VkbUlq/
 d8N9OJt71qmZH+NnR9v/CA8cxK8I5OLq70ox17PYH5Rz33w7M4z6fk77UVc4q9+8wjz6ToOhNZ4
 dM5anWbhf/5DoLWPZx6n+tyRyzeK4REvtCNKs4J/zNyouLdh+G5oZuYBqNrWqS+DIIP0fdxgRf6
 yXNHkfzEmgEP5/RYVAWh4SBfQdKQqKuVriLa9f7TPnljwwb5RVIyIBP7B4fvqterSlYGeShijTg
 3d0BPAtG2dm3N7A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace synchronize_rcu() with synchronize_net() in __netpoll_free().

synchronize_net() is RTNL-aware and will use the more efficient
synchronize_rcu_expedited() when called under RTNL lock, avoiding
the potentially expensive synchronize_rcu() in RTNL critical sections.

Since __netpoll_free() is called with RTNL held (as indicated by
ASSERT_RTNL()), this change improves performance by reducing the
time spent in the RTNL critical section.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c58faa7471650..60a05d3b7c249 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -834,7 +834,7 @@ void __netpoll_free(struct netpoll *np)
 	ASSERT_RTNL();
 
 	/* Wait for transmitting packets to finish before freeing. */
-	synchronize_rcu();
+	synchronize_net();
 	__netpoll_cleanup(np);
 	kfree(np);
 }

-- 
2.47.3


