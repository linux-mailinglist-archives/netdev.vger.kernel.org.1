Return-Path: <netdev+bounces-118837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF7952E87
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08741F2388D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2B19DFBB;
	Thu, 15 Aug 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjF7EG6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44ED19DF4A;
	Thu, 15 Aug 2024 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725995; cv=none; b=rNoyH2czxYg+zSrhx++gAYEclNThPy9T6gV6k/Q09+kHfY0XOCpza2aIhI3FH9QrZDJONW6LZLJcGlndpJMoFjTGlvK3RlNUahkNP2ZAAk8LXoOZefF9RHsXKXzu6FSvzA5WwrYnAzD2Ye0mirS5GTx872Q1OYrwRJZc0EYFw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725995; c=relaxed/simple;
	bh=3CB5+WYB/JCM8BXKmWb57xhOtRNKMSHonAri1yGtjc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2bTHUyzmgn+qNGLdEli1XKutvKd/HNf5Ay1n4CQ33lsUyeokomW+eZNqjiKHUwS6nM48PRly0QU+t3t5HbhEP0djUT9WbFun5rHroa92hy2Rp/8xpiROW1QipZUvjHMnFOB7wwuXOQZf1EOLYASEtlV+9WqlN5HuGGFOmAXf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjF7EG6g; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-710bdddb95cso558003b3a.3;
        Thu, 15 Aug 2024 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725992; x=1724330792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LvBHU4ajrcGnbQIJBpscVn3KQDzyzOuVH6Fpensg2A=;
        b=mjF7EG6gUjomNLL3vhUcdKJH9IEn3FQ8NqsqLKU0M8M+qUJv8otrg1gCoTGpIxL/Zb
         e9nv6RZUpAyl4O0kzcZlvZ+cxem7hw6e3ssG8B561j3iKHPbFIpnGABFQzz01sDU0QeS
         kE0MIT4PrPYPFvdGRq2zjZLWfWxIfufMFifmX/vSPHMDF+d5EBwKYveWPEMxzjdv2q/y
         TA7LOeOMxNcIW8kinLxf+isV3l5zc5vA2uGfxlNxtndLs8KA5JlJBJiFFSQUhJK6EgUn
         Vxa+Y63KF2F7+SxOznsk+31MUUTfKvfqEcGzCufPdSx6eazuXKD6BN42FKn+RFMqex0v
         KSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725992; x=1724330792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LvBHU4ajrcGnbQIJBpscVn3KQDzyzOuVH6Fpensg2A=;
        b=D1JuxC14ddhgPt6CsmmXdaId5Jy7zad4NcGPsXWLKyCveaRkQnHvgrk2C6t+fbS03C
         AupLsBEtAsaMCjawMh2lP8wp/a+edaXGS4+Ykd2yfv7VhLxYcnB0jew7xvaGDO5mDBgZ
         4A/M0ZacuEgkkB6YElvFeFSd+/IACy9zgE9AIftOE+4CIcXi3Lt2xAJaeQnXSrZWqb/e
         Tvthqr8ZLASdM/Z/TvGh38+d2N+zvio5GG/S+gZEBVGLs3aYf3kwz2Zf514u5l+yxq1F
         1xy8Zdf2vsH39pVQB00i8mWFNWdZFSIAvzhP6vqsZ8N0+al1wFjM1nuOb5D38oI78zd7
         KqxA==
X-Forwarded-Encrypted: i=1; AJvYcCVMK3JOjzgxpDWHuOyJGTUN52r7A3nnMjpeArO/lx9xxVsddZeTFiUTxXNVVDUdaXNWKhWQTmOsDEGaeqt8ngIKnxKev4HzmS/p+sG30Dy7QMhugMNgeu/Nh7qQurW36aGXc8r3
X-Gm-Message-State: AOJu0Yw9VdW6x3Z9fshhXshPyYnLh4Hy0slCZlwK6L21x3XQ/9ld3bJW
	JSNCGMjOLPAyBtTbsS3QF/ztRuZSItSnfy9tWZDObIeb+jjoWu8n
X-Google-Smtp-Source: AGHT+IGDFLR335ccHyK2aSZ7q7ZUDdrCd7IGe3RKT4niKiFVLF6M7ja7YBFS9nlHizlX6jZP1/beEQ==
X-Received: by 2002:a05:6a00:1402:b0:70d:2b23:a724 with SMTP id d2e1a72fcca58-712673abae5mr7748585b3a.23.1723725991961;
        Thu, 15 Aug 2024 05:46:31 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:46:31 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 10/10] net: vxlan: use vxlan_kfree_skb in encap_bypass_if_local
Date: Thu, 15 Aug 2024 20:43:02 +0800
Message-Id: <20240815124302.982711-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb with vxlan_kfree_skb in encap_bypass_if_local, and no
new skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 885aa956b5c2..87d7eca49e20 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2340,7 +2340,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
-			kfree_skb(skb);
+			vxlan_kfree_skb(skb, VXLAN_DROP_VNI);
 
 			return -ENOENT;
 		}
-- 
2.39.2


