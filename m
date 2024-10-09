Return-Path: <netdev+bounces-133431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A56995DD4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B131C211AD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B93517C22A;
	Wed,  9 Oct 2024 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrFnIprV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA917CA0B;
	Wed,  9 Oct 2024 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728441000; cv=none; b=lOopgeAORcHywyYR0+S/POBpnnDzG058L+YBLVQx9nX2dPS2E4ej1bSq99owsNLYZ9qXcJgNtD7vExU6Fu9umghklsi9aM1b5DnCRbYzAfth1o1+WQyYk7Ieo6x8lPelRdV1KMGbkJeZH3LuihIZGksIsooU3FRqJbeRRSxtiLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728441000; c=relaxed/simple;
	bh=YBE7Gm/eB2TlKhxoUuPSI1O81VwH7aGArvM+el/K8oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8m7XJGfa3wTo81ibNvs3PUaKyUrNw1FOlwJmGyUUgCbiztOzRRpkxga0kHPcN7Nwy7nB0//a35JmXkR/EVoMTvzibC0OcTGCG5h6rIz4tmfAlgujl24TnmVLBo/CcXBHDeTdJ1oEXal4ow200tDcC1Z8iculF8iwtrDeEudAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrFnIprV; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b86298710so54016945ad.1;
        Tue, 08 Oct 2024 19:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440998; x=1729045798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUrRZI6iM2TdSh5ZMNy/fS83zTOTT53JwP3p/9CnIm0=;
        b=YrFnIprVsmEUz5TSZ3zpm2QxK+6a5HO2Crte+VnHWKa4K/aBLDHduvADoAJbok3pU/
         KV+eGLma0m5hi/bIrcH3n2RUE3YruV172nedJ5ile3lL6Oa1ZyxYeYhrSCr42sJqsUAi
         HIxb0jcxZF8rVV0F/bzUJZXqv9lb8R1ovvOKR+kSKMcQ1QO2KUOIm5Z4udjC25H/o3M+
         Eoo/OxiYInhqqwKJf454HexaB9xFHgrGS5tInXVVXjsUx0Reml2YewZb6p4HCfp39n18
         RFP4Egcx8hkpfQpYHerEYPe0PlZRY6No/rN5Lfp7z+UZlSDHHsByfxc+Af1OsT/AqkKa
         85Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440998; x=1729045798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUrRZI6iM2TdSh5ZMNy/fS83zTOTT53JwP3p/9CnIm0=;
        b=rT1FBFz1MRGzjjNLxUutJBc9OijzCDxIAmCs1TViF9Fc1Kr9HodfclT/pvJbqWvVQ4
         7+j9UDRUfHm7mD3Dr36l2qHjv/evTUCHgUaT8K7xjzFct8uERl/Y88jExsVl1NRmv95I
         5hQdR3x/SGw/mk0sBxvybBYAJoapAvAfdc6RaozaQD7D9iByNq7wCUgImtgi6AUv1Gju
         Hrfeb1GPJRasSPO37610ohDOZfnR4XTEp/d5y6riukjnZkHkMJLmGpJAPAnV+8s8ms3M
         yKgc71Y1iP72Ch0GlQxbggNnX1Jk1qAWA66F1sWzbYyhZa8NZXIfzKEfS97C35ZYOuLN
         I+DA==
X-Forwarded-Encrypted: i=1; AJvYcCU1NT0xl51pmik4uQOO4sXsZrZq57mrjvbhtE1RFnOkW2nZ/szNktkJxFjoswYMtcQWPWtSyLcMQ6CpbRo=@vger.kernel.org, AJvYcCUEdHiLvUvRttgRBHy1z4WKfXdZ5Z8KnNp93BnknYzh7vyVgO178Bn7McSn4qrOO7DEdtMZNguv@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/SoWaVKLL2DlQVIs3VZBm+i6qfHWdPM48b9gWQE5JrcWp511
	oITr5a006HYcaC9zG7TyTOQ0Nkkjb/DajPQANRPxERaWsaYqzhzI
X-Google-Smtp-Source: AGHT+IEDWkwzAvcKuYIWzL4PV7Q3/38i4O5qIt5/Lk8iF/ZzYGbMknUTYLwJpmvJOayhQr/HNqCsWw==
X-Received: by 2002:a17:902:e541:b0:20b:7d21:fb8a with SMTP id d9443c01a7336-20c6379b4c0mr13167735ad.61.1728440998272;
        Tue, 08 Oct 2024 19:29:58 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:57 -0700 (PDT)
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
Subject: [PATCH net-next v7 10/12] net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
Date: Wed,  9 Oct 2024 10:28:28 +0800
Message-Id: <20241009022830.83949-11-dongml2@chinatelecom.cn>
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


