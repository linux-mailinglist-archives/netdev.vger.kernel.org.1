Return-Path: <netdev+bounces-116717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10C94B708
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4233B21D6D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30D13BACC;
	Thu,  8 Aug 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahCRXWgX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AF7464
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100681; cv=none; b=Pti3mDrh+BwQ9OKcbaDefP307G7UvawnOmDuVCvV+4YIpx1vMhsCIV422GWmHH+mRWgEw28ebySTJZZsVXOGuFNsyT4qOzJyxLms+FzyF0nN0Q8rUudyTUbJupNRyKBnXMFxIxym8T2JE6bJN8goONlLFREfE/nt66r1vD6BeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100681; c=relaxed/simple;
	bh=RpJ5ezoFXXL4XTOGzeOh7eXrxX/51pH6nflXYUtH4iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dLqSPFhbDg/qOMhIVt717u6rBGPR7btTf2KIppycc9lwbVTX1eOcwi0vjsV3OGc1Myy66WBgfCAmvPCnZFRkoMQHskeA33J9hCTIrASA+QVKHjqS24ijlRFA4ITWepT0ELEdBLdiVbE1YQB9FEt3EdZjSZZ/RZuFE5OwN1S7qig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahCRXWgX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb52e2cb33so535711a91.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723100679; x=1723705479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhHgk5+MExVRerc2zvAl69g5TceM5eejbXpPFGfzM/4=;
        b=ahCRXWgX/KNe2F2In5KHhP2StjYQ7BqwA8bskaz2UiCA8L/MEHzZjw//UfcNdBgUk2
         Qmm0J4GAmyzESy46rRoVRsCzyIdJJUjMiK9tkfAc0Nqlcji/fpvH5nOE4fi4FD93ijDR
         JPOTxGd8Iz0dwlkxaDoQVAFFNsmmHa4odi46l/ICH6V+lOEdiRWxe024twqX5d6pkZZm
         GpuNkp+lhVYZ1iwX7ZJAFBJTILTQY8PLTMcuACWFzEoqtVadcicvyD/KidBwaB11XxfW
         QMRMDXfxhYuxddn+pYrRv+USRcUL6lKXATnSLVvIumcQSoRvWhpNaRK+hlhIhTsIBgtw
         b2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723100679; x=1723705479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhHgk5+MExVRerc2zvAl69g5TceM5eejbXpPFGfzM/4=;
        b=AOzP4db/KltO3ehWfrFeg5eHKMGaLKHhK5Bh5yZjXkilhUcwRSvpjiiKkfrEYQn2HX
         t17XaFh8H0+J6/vWCPdc2oZxQktNl6QONapPUIxfn2qviRb2hGlVd1oT0PjnJkafNHRt
         AgyrsOs6Ns2fyviZmxhrNnoL6gUuyzb8M72r5HW4l1h7ti+J1/sASeA077oOS/wvFbDn
         VQ3Orwmsg1mVFkiznDLbafnLAsTOysqxOMTYvcIwd8XVMVterWMhzErUw1NbiQv4V01c
         VvnOoHLSjfAGXU7cO8DjqFq0lirXSJ4OcH0x/qbIoZU6hmN1Hr7tSJAG3PYkvmg4VO7b
         MB9g==
X-Gm-Message-State: AOJu0YwuuB3IqDKmQv4OFSbDWem8q+n+osvqO2ZxQjx4NDSyU+RoVU+1
	exH95k5v56ZHNCm97cJUvnhMwojcKTi2u4f4J2iAI+BWjryMrBl1CJu1EeF4
X-Google-Smtp-Source: AGHT+IHQPFbEBmPku3UNjRiNZ78MX5bcbWhwcG7bgC77wYPE6M5DSuSGuBpSWllzVaFc4j8ETgJDIw==
X-Received: by 2002:a17:90b:1c05:b0:2c9:9643:98f4 with SMTP id 98e67ed59e1d1-2d1c336334fmr1035428a91.5.1723100679178;
        Thu, 08 Aug 2024 00:04:39 -0700 (PDT)
Received: from localhost.localdomain ([139.198.112.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3a9cc31sm2710750a91.3.2024.08.08.00.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 00:04:38 -0700 (PDT)
From: Duan Jiong <djduanjiong@gmail.com>
To: netdev@vger.kernel.org
Cc: Duan Jiong <djduanjiong@gmail.com>
Subject: [PATCH v3] veth: Drop MTU check when forwarding packets
Date: Thu,  8 Aug 2024 15:04:28 +0800
Message-Id: <20240808070428.13643-1-djduanjiong@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the mtu of the veth card is not the same at both ends, there
is no need to check the mtu when forwarding packets, and it should
be a permissible behavior to allow receiving packets with larger
mtu than your own.

Signed-off-by: Duan Jiong <djduanjiong@gmail.com>
---
 drivers/net/veth.c        | 2 +-
 include/linux/netdevice.h | 1 +
 net/core/dev.c            | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 426e68a95067..f505fe2a55c1 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -317,7 +317,7 @@ static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
 static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
 			    struct veth_rq *rq, bool xdp)
 {
-	return __dev_forward_skb(dev, skb) ?: xdp ?
+	return __dev_forward_skb_nomtu(dev, skb) ?: xdp ?
 		veth_xdp_rx(rq, skb) :
 		__netif_rx(skb);
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d20c6c99eb88..8cee9b40e50e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3943,6 +3943,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
+int __dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index e1bb6d7856d9..acd740f78b1c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2190,6 +2190,12 @@ static int __dev_forward_skb2(struct net_device *dev, struct sk_buff *skb,
 	return ret;
 }
 
+int __dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb)
+{
+	return __dev_forward_skb2(dev, skb, false);
+}
+EXPORT_SYMBOL_GPL(__dev_forward_skb_nomtu);
+
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
 {
 	return __dev_forward_skb2(dev, skb, true);
-- 
2.38.1


