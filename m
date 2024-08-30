Return-Path: <netdev+bounces-123559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B992F965506
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF38B24281
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1759D137745;
	Fri, 30 Aug 2024 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB+9uyaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27941531F9;
	Fri, 30 Aug 2024 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983390; cv=none; b=ZSw3pC6MMY5VPslvQMKKDKU+uUlQSkhdqo/wNriaCDVCiHgoJ/DwISiJDLyRQ0ZXPdwXVZC61/FtXyA5zfzC3Yk5DJTTNjEqlnAKczI1ykjIoaPyQGbzWVt+CH/uE6XdsK8hCiFvtowSZ4xgOElnSypIIPEfizVDlc10appHa3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983390; c=relaxed/simple;
	bh=/ygayHblCOTxFAz6eoXnqXHoViN5LhOqUxLiV2HDyEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdQ6U5ARVTkQS2WTcPyuU/NyG/AWrmQhDGjrmhIMvJ6WLnvEM87//wP9oKJ3cwiMgls6phGWt39CBqtCumXhB9ZE3iBIBn+K1X7ExZxM6iyQz9NUAc2oGsrbhMWrMy4Jn1/TOdiiq0tFdcoNlwlzvwYczIl0H4xbS98sZwCJ7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB+9uyaK; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-715cdc7a153so1058275b3a.0;
        Thu, 29 Aug 2024 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983388; x=1725588188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDu2MVZvn2ikJWd9emVPbJH/BIivnGxQIwwx2gcqaW0=;
        b=SB+9uyaKvuqKcl9zg55IBCU1jsIMJdlooDnQnLSATP8N1noBF815j7tTEX8S+fNfni
         yovPU9oqPJ/EuffU3npvCMOxFXoJWB9u+muJ6zm+DuQbUFSKGLuyOLSKngHTKN5u63X1
         0tQEfhjLWKQIQHLITtsAVoJmj4veEEVi7lFo086KtZz49loWzsak9KQCHHpddhuDWYqt
         iBaR9st15XzB/FDjo/v0iehPigrTIkq3HsvXcpnhhIN/qSbwe3ByxTjvWhSZq85dnJtn
         Tq0br4hKmokAeg3h6bHO2jtwTsFgQ6clZDLSWQ2lzpFS9qkQTs/vcQwIEjvJZeewysvh
         Ydkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983388; x=1725588188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDu2MVZvn2ikJWd9emVPbJH/BIivnGxQIwwx2gcqaW0=;
        b=wHj7pMQwPaPv5SlM6y+YvWVCFH+nLvb3ZCsyFrVf/aq6Gvyga7Yqoz9F87tibh7Rqk
         a0Wx+3X++BKaBBdIIrRNDN0MfcknoXwLa1hfftSi68Otsa2fNqn7EWjRfx8+FoPepKyo
         N2Tduy+Uu6C00RHULVp88USQqAymLLIsMk121TSBo1q5YkheT/naeR6IfEiCvWCJHF7m
         yZqe56D5ezlaW92lz/WR5ukC2HqS3AlaJbQTXhSjTPJC3JxfleRHehnDnEwjUip/G93v
         WfhVyj5bb91ef9gNPM4OhBePXRp62EHuw42Ky+6Vmp5ui2lMxbxUvTQYyabKzCC7FHyc
         XJFg==
X-Forwarded-Encrypted: i=1; AJvYcCW3072D/7Sy26FQUpnhKTSydvvqvDt+FOVdUU1tWhwDucQZdRL7I0LUge2iyCT71blSwn2eweTcKF1w1qg=@vger.kernel.org, AJvYcCWgOAxLBdjCoWJeUklCGdwIFuSIfytGqEFDo2ju014AfRVR3PtLDsWYVr9Sd2xKDEJN8m44PU47@vger.kernel.org
X-Gm-Message-State: AOJu0YztsBAdvpKwgfldDCXbP2WyCK63awYMhFSAb8xJv/g/fbnwEmW1
	cqd+eZgpL/D+TvfgMHnBjxzmrTTQnzrK/fi2jrhVmVL9ZRQd1fdZ
X-Google-Smtp-Source: AGHT+IECAxt/KKRq+Z6qTVSzI8FjmNUSPy+ysdiXw2gKK7eFF16UWBCUUQCK1+K3Yc2w96eBr62scQ==
X-Received: by 2002:a05:6a00:85a5:b0:714:2336:fa91 with SMTP id d2e1a72fcca58-715e1046500mr6880515b3a.14.1724983387831;
        Thu, 29 Aug 2024 19:03:07 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:03:07 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
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
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 11/12] net: vxlan: use kfree_skb_reason in vxlan_encap_bypass
Date: Fri, 30 Aug 2024 10:00:00 +0800
Message-Id: <20240830020001.79377-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb with kfree_skb_reason in vxlan_encap_bypass, and no new
skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f013b9007d3a..adf89423e5fd 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2288,7 +2288,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	rcu_read_lock();
 	dev = skb->dev;
 	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
 
-- 
2.39.2


