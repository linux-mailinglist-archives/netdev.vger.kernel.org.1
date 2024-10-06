Return-Path: <netdev+bounces-132479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F218991CDE
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17B11C216E9
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D5171E5F;
	Sun,  6 Oct 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWase6wG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4231EB36;
	Sun,  6 Oct 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197877; cv=none; b=tyu6vJ1HYnjKm7gX+CjFQ6QVSBLStbUprJ8hEsU6ZxW+jkPL9xwRxQODEz9h8eT+PjuH3mWAVxT1EFAoCI8cKHaArqh2r++tMV1uIY8RyosazNrwbNoD8Za+59BVRPy43uaKKQEK0mev3FnTs4wDE3/bFpVIxqjJOb4gObsl72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197877; c=relaxed/simple;
	bh=YBE7Gm/eB2TlKhxoUuPSI1O81VwH7aGArvM+el/K8oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+XXvmzqyiNgzbAB0HtnkSVYEAM8PU9sa4aT8PtFENQymCg+5ZnNRVPFVgCcKCfm/D//MHdDm7GdaPzdQKz0Yay5kU/A659qgsZs6ZzSYu/h8RmxFx+4xHZ53isKBpXgyb+WCdbeN5+WmIrwfQVlJvwp68VlrxdtjyrraUNZCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWase6wG; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b58f2e1f4so22917685ad.2;
        Sat, 05 Oct 2024 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197874; x=1728802674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUrRZI6iM2TdSh5ZMNy/fS83zTOTT53JwP3p/9CnIm0=;
        b=WWase6wG+zrmBQZ2ctfbFN62xdCRS84ryNK6FsmmLBPDB1qHYY/WFRXN1CqsUBu7qk
         1WpUNlSJNVSWK1dLlXHCevQpJMUgj4gbDdMzZxwoWeWabeIFAY0wJdKSPSQbZKV0/HH6
         giDZolQfuHV/H4GoFEK6kr0HzRBF9rcOi6EwF9Qady5c+WtmDT7/BwxLqijpgd+YDrGM
         e613HTuqD5/ODfnDidGSrPYMnRoS6s+3+0840sthxVLps8fDQNzV7HJnMYE5cOtE9BoK
         YrWWZEM4HNfHvPQEjbOIzq0JunEiHQBJyJlyyJWEXy8DNGPvZmEz/kkmEJ+rRlfWk2db
         Ecbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197874; x=1728802674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUrRZI6iM2TdSh5ZMNy/fS83zTOTT53JwP3p/9CnIm0=;
        b=Gw8HEmeUQhOI096kGAd2FtNqiaKS5FOYiNvMH5bBTc9qQyg3OXwo6YSmAaB8I78wq7
         Eva6JgA3ygAhyDgiBxnH9twlOeeB8xhPLeXRTUszdngXUlM61yTXnWqXH328r2zZGm1A
         1SgIXwqfGMRIOM40k4wgtl1XYV8iJn6PrXiY4u1wS+lzvOLannI0+PM4xlaHD1InbyTz
         fbk3U94ndHc839gX5Sw6ZKBHKjGqqjnB0GnTRbrA+XH4l+FIfstoO3XWRAT/R88Ue772
         eivn9qIQo1Tnxch6g/SeKxQhYdXlyWoh7w6N71Oyh7XuvzFbkCgirvLh5KQkL69T4d20
         UK6g==
X-Forwarded-Encrypted: i=1; AJvYcCVuluToP8tX4HwaxDNelVRbTYQj0H1WMcbv1xO/CxsuXlAXChNXcdR1DGRyGlYs5H22c0er+eyoHfoMwsA=@vger.kernel.org, AJvYcCWWAVvfhNrMKH+SRvkHDfNqdPm7XG645KSv4TlykuvPgxJ9ykSNupKjwygTcTQGZiifYY4yHZOJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAKZd9J2kIhTgJ+g11uWU01XUy+7oDPWO6kSO9ysS19cCF6mG
	0zDc1lLy36q9GXK3Sug8+pMxMd2/L+UcgtkbWnMZtcXpKoA4dZHH
X-Google-Smtp-Source: AGHT+IHFWCumIHgc11KXUc6Nu3PPfqOmTx28qcmiKH7nGDeP4D5XmucA6wZ7v9cbFVE1kcmyI0hFqQ==
X-Received: by 2002:a17:903:2307:b0:20b:75ce:cfb6 with SMTP id d9443c01a7336-20bfe023d1cmr156580815ad.6.1728197874426;
        Sat, 05 Oct 2024 23:57:54 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:57:54 -0700 (PDT)
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
Subject: [PATCH net-next v5 10/12] net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
Date: Sun,  6 Oct 2024 14:56:14 +0800
Message-Id: <20241006065616.2563243-11-dongml2@chinatelecom.cn>
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

Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
reasons are introduced in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
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
2.39.5


