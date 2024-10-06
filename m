Return-Path: <netdev+bounces-132481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E6991CE2
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 09:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AAC1F240D8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1768172BCE;
	Sun,  6 Oct 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlLXcs7z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2D166F34;
	Sun,  6 Oct 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197890; cv=none; b=FTk7AjWMNcmAdQQkLXAx90pj0s2SJ4zfQJMSQCFon4MuLcCGD/ARG0Gsnd27KeQPEDWH62lkWUAwP1T6HC2A96bUZKFddrGwmqwjfU0yGzlw6HBjBSUgLzHHHE6zXTWiMrRdCc50fR/VfK9N3qeYbKm7mbmMa2fRPZO0uBcH96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197890; c=relaxed/simple;
	bh=R8vmG0u3lFl9fsXKHPJv8VqmdcKKDyrNnQXHw0Dmp2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJk9TTud4PzkrR2m1fLMLQJ76dqtK5IaOozT4W2Hqggn5zGXeT3gE0xp01d2+rTeFHEtR3s5nt3y4S3SH3y9yu+pjMC+72IF+wpvYtwQ9CdqbJhHd8XmEP++mRerl0GoSJRWnyGqG22zL4Wju3eo64y5SnFtWHYLv20iULlHDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlLXcs7z; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20b8be13cb1so36788035ad.1;
        Sat, 05 Oct 2024 23:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197889; x=1728802689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyNsEi0JeRXi6J1a9d2wdU47n7lnZVibMGfNyAtDMsk=;
        b=RlLXcs7zSqq16XUxgkaXFPYbt/1n2MydCS1RwnXY69FZkgFEOiw5SqYs0fdgGYueer
         STmJNVGlqDdn+SCGlo6QOtsK7lG4dIcJ2Ls7lwgh5VozRxNI/9Dx2wHUywYH1IHuPjXy
         S6gIX135QwTy5a/nfL5WZ2lWFH19h74/+iLSGFU4HKE5fxLBJM2NJ5mFadUYiB6U0iIM
         GgFQJFkspT6MLAhSdqpU3g1bfIlQUc0qDES3EAcDGx0qt2tF1DQ+8hAHeajuSn5PpjHN
         /S2bPIANQBrpeEyo2LFyKgakh0Cg78zRB5GhJ0Y1yj7Awskk8ODVRQGEDhlQg3nD474f
         a9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197889; x=1728802689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyNsEi0JeRXi6J1a9d2wdU47n7lnZVibMGfNyAtDMsk=;
        b=KuIQe/IVFqFIsrNV2QbDvKhoP9PuwkA+mWkOaKWBePR7IP2VuEuBpwdgPZcA6HC2wN
         Rc75hy3+Ov+w40PKt5/0HWtT7FlC3cOGJXyaAx2jBdWKfpyf7jCZN3TMqRbPqACh669o
         Vt5Ik22NP5WmjTYH4OwrKvy1bdVrFHmNfpt2LwHtZhu4rMgCnwLoPKiy+VyQuEi8m2rQ
         e84oAa8NoRTOK+KczWQUJh0lhl0Pxg+2y/yVeZxdW+VYbnhcuXDswuppw2T9WlnbKrGE
         NgcL+hvgxV70ZFlYyq5Sdm8Lg9vqgktwyNfcSJ9TCKjf9/sUmBcS2VxUjPWamQ6jLZW3
         VAfw==
X-Forwarded-Encrypted: i=1; AJvYcCVgQ1/BrXil23i+qC79tp2lBdcCECcZovB/uyHC90WIZ+3+Ft3OlhHuF4Wv8nvCc7LQBeOjlWo9JjQcnpU=@vger.kernel.org, AJvYcCWdqHsukdx+kT0s9V8DQSnkf7i04OHY0oKTjU+KBLoYV6cKU6krAuT+fpDLLA2QTvV+jM+r8Zh0@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7z4nqxVHuOz479R176xTcm9njnDrX/AVgI5qkR9oaxdh9f8b
	qG1HJi/P1dGi6YFk9VBIPim9DMCM0z3Lc205pD2PMWag5iLrwVIG
X-Google-Smtp-Source: AGHT+IHx42K0WqJ7EvcJSGjOcyT5M9GQpn0waDeAp3xdXSAlH9kCkGHV8u7YOUh7HcgCxMClRPiyXQ==
X-Received: by 2002:a17:902:7446:b0:205:4885:235e with SMTP id d9443c01a7336-20bff04b26bmr98164725ad.39.1728197888703;
        Sat, 05 Oct 2024 23:58:08 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:58:08 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v5 12/12] net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()
Date: Sun,  6 Oct 2024 14:56:16 +0800
Message-Id: <20241006065616.2563243-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb() with kfree_skb_reason() in encap_bypass_if_local, and
no new skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index da4de19d0331..f7e94bb8e30e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2341,7 +2341,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_INVALID_HDR);
 
 			return -ENOENT;
 		}
-- 
2.39.5


