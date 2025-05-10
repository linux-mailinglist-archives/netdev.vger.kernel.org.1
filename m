Return-Path: <netdev+bounces-189474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81681AB23FE
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3223BDF2B
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79241F12FC;
	Sat, 10 May 2025 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhNvPAMN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1C221F1F
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884908; cv=none; b=Nr9T3oueLxvGXwLhfuDIWtOAalj7E3Qv9vnRpBK2em+uTNcYdLUnwnEL/R1vmSMZJVfC1JFwpwdG57kIh7YRAhetL/c0/tdCFpTu6SshdXvLK3ekbJ91lU+PnhtbZzAg4g5X/XLqVtuCJrmjBcd3hW8OwtdldcQ46Ddu19qLnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884908; c=relaxed/simple;
	bh=BGNOVtfsO8bgHDCqkxhaIIIMZaItN79LR8eTMjqVYAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOj8fRm4knOgWVeUO9ea3Ehj6wS6gRTK919wGL1GZbRFXZZgTNw62iSCn0P7UG+j/EOAQnd8kHYS4scEo5f68QfrrWA5mdoXRn6FSIloYOtDAnkTxHlCCaEJZrK8ZvHp+6UpesXSN8MB5Qpv6eQl8TYom5i3ZAmo7QQy9FXGJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhNvPAMN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso570168b3a.2
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746884906; x=1747489706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=548WZn/S4K7x40OmmUSfPZLeG/CfUSGzx/rlh6jbEuY=;
        b=dhNvPAMNbLR1Y4g2VUwMBbic658KhdAgd/mXj8RaRC3Es8vbLTSDM9vltR+0MPo8Te
         Zneh+sBi+zCrDPJBFk3KUHM7H7+pKMsRMBSY0CtlvVMDPnL4FkKEKUORoc+Pxc5w014T
         kdsBabOqu18BVwoKGqI2i8S5WXC8Sh7CdCrK8F/tzgy4psFYFeqCulIEas/AnRfOIhS+
         /7SLOKdNPV1Xx1zPa80iAINuPpiW99W639bZzbrELECxJSSyjG3S/gSlVAMBl8kko5H6
         +qYlRqJvDwU6eHfSbgnD0A4L6Zy1ncJ/Bibb4sLHi8O8edyihZOM7H1nVHAg6MMgnlaM
         rj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746884906; x=1747489706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=548WZn/S4K7x40OmmUSfPZLeG/CfUSGzx/rlh6jbEuY=;
        b=Jy/qPmDBYcQZ8fx1wTmrwLf3x9rijuM6q6qr3RRjPPebHfCBR7krrpa40uNf2YiW1a
         9apua+lzwmjKMQ0iJrg/OTub0FB6FLVUQSOrrNuJoek6Eu42YOvptEn6lsw1MFjIVATm
         TMp688oU8DtN8rzyua03r9i7GMVfG3CRDjaLFkUKqm79R3iqOr1oC+E++GqzR9eZGb0+
         VeTbkDJJzjZYZa12o+cJ2/DW0v0wH46VHy1Hyy1g0MwNXPgzN/4kyVnBR4+cRehp6nHX
         zni2zaFCZHm372EsDlSYMhvAl6nsZMSsE0e4x+yt7p1MbxUd6QQC13dQKGQQOIGLZ780
         ypsw==
X-Forwarded-Encrypted: i=1; AJvYcCVFOHX8xYei16GlaA8bylJRlhHp2vLVz8mYTOvodeuKXo876uWMz0XwHvwK+PYB8k/KkkvN9Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2jAegH53peuWqRPefGUc3sb0JjyPE+O9/8mHfHLLcaxNfvKH+
	3bxNg36tNRJy5OVBNqS0t04EpY3i8HRfR746eqgcyR23fc+4Zk17
X-Gm-Gg: ASbGncuWAZM3wNoV/nK1CXz01n9bN7c4jSIQ2YArtif2F4XF7s6vFPR/basSde5pbPe
	u2FAjfD/P2+LbF3nIF0Wcb/C9fjHkEKLca3xW89g7ZeixV91+4r6zdltvPA4yvPcPtQrgAu3nu/
	n3spH4FU6o85Z4EXrHocIYSkh0nTCstbeaz++LA1VmvN53yidO9MKNGjbQE91paqivzw818sapo
	P/J0nkH2Bi1jMNnTziXvp4n7nhSTfNw7ouPLQdtiEl/ex8pfT0tpo8By1m0T8omF1b0hxzNj6wM
	YTSpEY2cTgLXOrdO4wrcTwGXbDjt0ZCw0mt1jfCuxYjTsyt9Jj+uREaPy2/fJDyPYtzsjOVBmfD
	CBj+6c02geh23sHNX4yiIfFPQ
X-Google-Smtp-Source: AGHT+IGe3B5B3RalliaBNkeqdqvGOp0m/hHLJIw4a+hcw50RwCHZe4bcxR3LB2IrWTuiOVsCyntcoQ==
X-Received: by 2002:a05:6a00:84e:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-7423b3f138dmr9527488b3a.0.1746884906308;
        Sat, 10 May 2025 06:48:26 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423773939fsm3360424b3a.62.2025.05.10.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 06:48:26 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	irusskikh@marvell.com,
	bharat@chelsio.com,
	ayush.sawal@chelsio.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/3] net: atlantic: generate software timestamp just before the doorbell
Date: Sat, 10 May 2025 21:48:10 +0800
Message-Id: <20250510134812.48199-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250510134812.48199-1-kerneljasonxing@gmail.com>
References: <20250510134812.48199-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Make sure the call of skb_tx_timestamp is as close as possible to the
doorbell.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_main.c | 1 -
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index c1d1673c5749..b565189e5913 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -123,7 +123,6 @@ static netdev_tx_t aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *nd
 	}
 #endif
 
-	skb_tx_timestamp(skb);
 	return aq_nic_xmit(aq_nic, skb);
 }
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index bf3aa46887a1..e71cd10e4e1f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -898,6 +898,8 @@ int aq_nic_xmit(struct aq_nic_s *self, struct sk_buff *skb)
 
 	frags = aq_nic_map_skb(self, skb, ring);
 
+	skb_tx_timestamp(skb);
+
 	if (likely(frags)) {
 		err = self->aq_hw_ops->hw_ring_tx_xmit(self->aq_hw,
 						       ring, frags);
-- 
2.43.5


