Return-Path: <netdev+bounces-126389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83730970FA2
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4131A282FA2
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CBA1B1428;
	Mon,  9 Sep 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOjCnDT0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D51B1401;
	Mon,  9 Sep 2024 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866634; cv=none; b=aVGwE3MiBnXkkVrig1kUPmfT4X1Sm7Zj5dM4eovvSejOmHaKuySAt3GQAb1RvKaGSlQrk96g2J66DJuLLtTXeg+9MTu6K2TuXHo26bmgqfBrJou3Ek9/m9h72Kg8IyOXo+I4Ih2jt1lhl0qD1sjubxBK2E7r3DW5dhRsKjVkzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866634; c=relaxed/simple;
	bh=Rr9RB6rPx8aBSG8JDHsFKgYqTcV7ecNiXdCKNntRjb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ow0WDvzZQfJyMorG1VNYvVZnc2iymdbeqAprAQlg6mXAzmTaATO2sp9mUnyg96FhrxvHkDsQNokzgGrVSepB4oa4gAGW+RtfI7fAvlmThQKpASXiY9ZHuaIqhhYy+IFA05qYhPkO1H9hqcrwvbrj0BFSjy8exNPjBtIcnNLT4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOjCnDT0; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-710d77380cdso1165598a34.0;
        Mon, 09 Sep 2024 00:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866632; x=1726471432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/KxcFdkO/q8G/4oZRDXYZwcy84T8+3My1pCNg8ZJ14=;
        b=IOjCnDT0uhJU3cbbN5MeZ1qf7b8+XsKetIKgv5b3kcEUkfV8KC0zKZmN+tvHu88Og2
         uBifp0Fk0Sf9ef4fTG3DedhH3/Wjabxt5RQyNO4lvOXsS4ja8ma4wvEPlf7kjln2mFNe
         ebcUsBTPrpte2+aH793GH+MXJnLjfCyBKo8aiCTPfx4RcmzNsP1REWMpJMjNwR1FEa5q
         fezsK7bg1xPWY3p896foRupEgghiLvhrtG8cZ260CtMs1TjU3nxBKGtv43+uIKH/jcQ2
         GmxnfQD1klIb9qA6sm6uWJ+kN5E2uaZBpVP6y7mmZM79Ak1sSB0DC1+Y4ujMOt7cWvN+
         b0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866632; x=1726471432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/KxcFdkO/q8G/4oZRDXYZwcy84T8+3My1pCNg8ZJ14=;
        b=FtPB0gKpdK5cSCDA4WwrWrThxKvBrYTXUR7c0velvOXVkcc4tGlJa5i52qgnt0Kc2w
         objPWYEZZGLpqZzYos+nd1pqng8YNKZPSKplSVPRP1VRW9WWJhgyzd7hrp0n9iPxtTUQ
         p+SkwubeUbSpnlpZE2MOKNZVYvaVtKC2DhEXjd1wsFe7+lk7/cV20xvuC1vu7HaGPmdL
         LGfcBJv9mJYoCa3uY5buDB0SWDXT4pqcF5J1H1BQka6LV5Wq5NzCd4dOmoUOTzwFOUv4
         RPE04DSglEZ7owvX6F4PfjNYzRoQsRVF4pXbuq79bGiN6htvZR0SNVPepTqh5HL3IS2P
         ZJfA==
X-Forwarded-Encrypted: i=1; AJvYcCW3T4z7loo8hKSyI4xElf7XXwzRcm3C4ryP5nEY+F5jQwc9tdPH+Fvp2lViJnlhvMEohxA0RGIT@vger.kernel.org, AJvYcCXJi7Cmo++FhHflTaLt9daTtFHuTZAl/2h0Dr08gN0EjQdJ1UhT/eR/uyIRyRTFvJSjr7ZR7uTAWu505TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQQ+m9Wk0Vr50YWnGn2Dw+ERTgMPC1ZUh0Zjl4cQQStLQMgnq
	ln0NY05hbkpMUqUn+qaWIXbhYcLZDlkjXdFePr3/svtN5T8z/kn/
X-Google-Smtp-Source: AGHT+IHxg8+zPAIuvGRLoN8oXLZ67VrBN/PDnzZCbR1frQinlKZsWvlqhilE0JHvpdTBU3tlJyNh8w==
X-Received: by 2002:a05:6358:7623:b0:1b5:f95a:5a6c with SMTP id e5c5f4694b2df-1b8386e0c35mr1183317555d.20.1725866631762;
        Mon, 09 Sep 2024 00:23:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:51 -0700 (PDT)
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
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 10/12] net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
Date: Mon,  9 Sep 2024 15:16:50 +0800
Message-Id: <20240909071652.3349294-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
reaons are introduced in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 60eb95a06d55..e1173ae13428 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1712,7 +1712,7 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 		vxlan_xmit_one(skb, vxlan->dev, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
 
 	return NETDEV_TX_OK;
 }
-- 
2.39.2


