Return-Path: <netdev+bounces-133433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD2995DD9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4301C21675
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3173617E8E2;
	Wed,  9 Oct 2024 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coIt0OyB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFED76C61;
	Wed,  9 Oct 2024 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728441010; cv=none; b=bDZdc5ke8Sf8OREkTv7+9jtwsKhvAgGJxM2X+XljFY3hVbsJvqH6H59gYVfJoq9WjO3WY2IXjGJfitBBNPFbEWIUETSPOnMXWtFu8t9irKsntKO8WfP2wG0gBGK3WcEQo4tpW6WUsn4qyjFLCZ11QiXsdGEQoxejOrZ7ZuGEo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728441010; c=relaxed/simple;
	bh=R8vmG0u3lFl9fsXKHPJv8VqmdcKKDyrNnQXHw0Dmp2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A06lwGmNL0lH0VLrlTxQATD/pMEH0j3JoEPHMLSNDQH8Jsvnw/cI0dFjWdEZlF1VZwNx4S3ihoB0mdp2nhmKCJQn4SrLT9L8uOP0BsaXOCoinwAyKXfTtHHw2d4bQ3dcZtIfZtPywDWnhrdKkuePLsCii/OUm94UjvMaPr3HS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coIt0OyB; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b58f2e1f4so42963825ad.2;
        Tue, 08 Oct 2024 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728441008; x=1729045808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyNsEi0JeRXi6J1a9d2wdU47n7lnZVibMGfNyAtDMsk=;
        b=coIt0OyBkHIXXb+7PQZKDEwum2PZV/cYopb81enX6lHQHRRSqtXGYwyf5q0YHAZLJF
         SPT10Lbxlo33gxbIMm61md7u3TEa9gdN3j8CMo8QVHjpioMWXORCls6NoeZ31ziE/Jdm
         Y9ZsUMVgqIHbfatVqT3ayWePff55LR3q56IrlVvbJ9AlrmFMn1w7dIAZsjGFwVgiC22y
         7FP4U9sulspT/CaoEdgK5QbdLZql3PPNtc0qtj7NqRQ/CcDmRh2HC8/PQPRiMoIqmdwP
         KOtefV4knb2F8mHHEE/DT2u2Z7AEobmyT7oEs9NrSVZtBJmEgUpjuFV27H7ZZJuHN4zm
         DADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728441008; x=1729045808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyNsEi0JeRXi6J1a9d2wdU47n7lnZVibMGfNyAtDMsk=;
        b=SVKFvtMWZLKcIFLKFLsIMH+Gx4pq35sxymv3EN3lp1zQVryzTont1xdMgZOk/k8hqh
         mkVv8y6jq+SoHg3ccZNJtkwPG2UeTgvkGSxhjV5A1WGVPJXUF3Si/B/yDrFCIVAPyu0r
         ehl72Xglb57qsyUtpAgCI2LJwsviS+5GTF/wmuiwGzpKvvGpaWa0DWYKYPUCr/9aaoY4
         9z7q6fOqOaPnN2A1Wq7shQEP3wrzUE5xR2kgnmwA69aE7HbsoOZk78r7USfsVUjCmjuO
         0zOVN1Ue5ekuasJdbq5yrPhKnyMbWxZ89lgwcu+U77fExTvmWdB+ocx6r6SSd3ljUFiQ
         lsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1HJSRJxkiZcI8hWmV5rlePS4Jhh6S4bntfxnpDeghqCTMILIxrKqP0vuQT1p9Lbf5es62TEhC8qvE/hI=@vger.kernel.org, AJvYcCXZuvyxfCS008sTAxWMAyeOP6CwQBis5WKJeAF6oNKu0nK1XPFOPveF8b5c1s9UtcZQbQnIv6Mr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/t1sxQBzejvbeZppVny435p99/eIX7+feBittCLyjdNyzoUQj
	YYn0ooIevX5gfFH3JC8x6LhNwKWFmu0Y2RhtxZhNtQAq16ZfmmOH
X-Google-Smtp-Source: AGHT+IF63z2mmMAQqwEG9PWLmebWgkxbfTFUpNjLHfaMsBtbxJN/L+ziwODlqorfWpWvsmolRnDGLw==
X-Received: by 2002:a17:903:1d1:b0:20b:51f0:c82e with SMTP id d9443c01a7336-20c637879bcmr15520125ad.51.1728441008109;
        Tue, 08 Oct 2024 19:30:08 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:30:07 -0700 (PDT)
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
Subject: [PATCH net-next v7 12/12] net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()
Date: Wed,  9 Oct 2024 10:28:30 +0800
Message-Id: <20241009022830.83949-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009022830.83949-1-dongml2@chinatelecom.cn>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
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


