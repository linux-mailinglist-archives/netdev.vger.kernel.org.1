Return-Path: <netdev+bounces-224517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23184B85D2C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30D8626982
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B14314B63;
	Thu, 18 Sep 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnshcCct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6D3148A0
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210731; cv=none; b=k42LI+nhbK++vLPsM9eCmLSbNdtMHnSaQyfa7V+TcfMTBDOBZyhVFWG0SI3V4jB4i+xiwUVGPwdjB/p6Qk06OSsELpkwotipQ5UR4K2XX6+7g60djmD5WodDucVk1gtXIMYHX16HjIe+PvHN7b8o/tLFcgoGGO51dScJaVi+1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210731; c=relaxed/simple;
	bh=u2k1Rr9QBw8xX9iYyL/KWDz57X3niKHiwCDWpq4SBAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWAfAiGOkE5Qg6K3+oilEcxvoNBRc06ko16C2Hpyr2TGN4L6lSo+HAQDhbZNbkhw8QYEXXWitLGtfBRvCtuFEx0eWKF3owFU3o/0HEHOJwk/40csj/hqfGraPdT2ozb4+bccKHcXDl+MLLOHou2Y2sUtZCmZETc9IBppcNZ/ShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnshcCct; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ea5bc345eddso995803276.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758210729; x=1758815529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T63cMN2bpLMBXbmgHnjsoj/q6IuKsI3obGUosBDYGxc=;
        b=VnshcCctex56M6F+fP1NNDznWK5fcg7OpeQG/WRG6qdTq3cxc9i6xT0R1ojAKlcwQ0
         hyhk/LaRG0TfxST2qdreNnKRQJD5L2r4kuyrwcmUS6w+MZf7fmDaK9bG9LO5l+pT9xoe
         1K1oiM4FcpRQ/65h0lHTsSKlH+LC0NOhunPv2lVMKe7jChoYXjB/ITh/OqcE/UtnyAoE
         kTBOyAAEEqQo01ZgaaXshzZ5TqkP0WV6ZyhjD+gK7sX75pqWLEFxwF+epHRzoV4OfBSF
         ScvI7NmTm6sKIBToEYGZ8vuuK5Ih7khShGACuI4Rv+3VvYmXTeLuhmuGAmdwe85AEcGt
         9blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210729; x=1758815529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T63cMN2bpLMBXbmgHnjsoj/q6IuKsI3obGUosBDYGxc=;
        b=Kw4KEAgry+H1dc1qUvdAdCH2zFTF5baOlK9MlFTqyB5BBuL+KFPChhJxVs/f4W7Xdq
         /XomQeBsyP9ZW7L4lv826Co2n+PPtqrVX9s4nGDNz0PoAtM7tzv9C5CJKdhdpx56yaGN
         CStLvaebhDxgGlLNSsbmoBpBrdQBXNSDrX1EP5d77jpuvyCOy0cr2mvF0PZ7+aTt1kQz
         UiJgD+p5abE4G2eQ9Kk7NzWy/zi238NhA8GFPsWP70eAay5vB2fT7Vyfd716nN2gYhN0
         jqAHURTiBF76q0B5wQNnFljuxw4LjWh9MlHp3KR3xIPioy/InhA5lJ0BSc6MOpI8EQeH
         wz+w==
X-Forwarded-Encrypted: i=1; AJvYcCX+Lw9eqcIPtmERAaA/nuRkQo02vr7bn8PKm8Ra2AbMlF7CSoRB71QLyCnT1G975WV5L94mEhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhCm0y0fPt381W+EZR3D12HbCgQmVY8ZpJMgDQoHTiUtcLvt7J
	Rsye/6HmF9hSMw3NarEHSoyIKclM57SvS3DCrNcBm/fBURqwaxnEJIm5
X-Gm-Gg: ASbGncuUpBBW+R0/0gc1rEleFhpG/7nQcSuOZGXGp+WgljYWYbTy7ZPLXqaVNVa8DDU
	4DQMP8NemOhPrtO8GTVkrzoRVseu6yEl4iCpmec5YOVzCXdoc3d3TO34qPauxTwiT8jQ0bjUXH+
	gd2PoX8QfiOvpXFOUc0pOFBbcOkgv3s19wxDDyU79Djk0ON9Zfh/CLpMeY03PXIHf1du388xVM1
	2VwrLP3YyBi1zJbtwfqCQUOlgfbm2Oo9eMo97gosv7iLWafEq6H1s7fUgdNvclK0dAZ7yDzyDa+
	ynFuqRZfcj3UI9T46/UIKv6nwJe5CJ6xE+Lr5ttyqIkbk3xJ5dvRqbkwKoFixa8kATwQPfFN2rf
	ntdQTI4gRqN4sIk/M++yVjG3nByC5Xn0N0sx6Fyd8riv9f73l+g==
X-Google-Smtp-Source: AGHT+IFasLJf4lljiuoLwmAUal9bwTtz+HdxBRw2GK+55MQ2GCzRLkGseEqjjhwo4IHBq2ctytywiw==
X-Received: by 2002:a05:6902:300b:b0:ea5:a9c6:1d98 with SMTP id 3f1490d57ef6-ea5c03adeadmr5826490276.2.1758210728723;
        Thu, 18 Sep 2025 08:52:08 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce709697sm930705276.6.2025.09.18.08.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:08 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] psp: fix preemptive inet_twsk() cast in psp_sk_get_assoc_rcu()
Date: Thu, 18 Sep 2025 08:52:03 -0700
Message-ID: <20250918155205.2197603-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250918155205.2197603-1-daniel.zahka@gmail.com>
References: <20250918155205.2197603-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is weird to cast to a timewait_sock before checking sk_state, even
if the use is after such a check. Remove the tw local variable, and
use inet_twsk() directly in the timewait branch.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 include/net/psp/functions.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index fb3cbe8427ea..980de7e58f8a 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -126,7 +126,6 @@ psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
 
 static inline struct psp_assoc *psp_sk_get_assoc_rcu(const struct sock *sk)
 {
-	struct inet_timewait_sock *tw;
 	struct psp_assoc *pas;
 	int state;
 
@@ -134,9 +133,9 @@ static inline struct psp_assoc *psp_sk_get_assoc_rcu(const struct sock *sk)
 	if (!sk_is_inet(sk) || state & TCPF_NEW_SYN_RECV)
 		return NULL;
 
-	tw = inet_twsk(sk);
-	pas = state & TCPF_TIME_WAIT ? rcu_dereference(tw->psp_assoc) :
-				       rcu_dereference(sk->psp_assoc);
+	pas = state & TCPF_TIME_WAIT ?
+		      rcu_dereference(inet_twsk(sk)->psp_assoc) :
+		      rcu_dereference(sk->psp_assoc);
 	return pas;
 }
 
-- 
2.47.3


