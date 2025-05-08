Return-Path: <netdev+bounces-188868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF10EAAF1BC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C6D3AC614
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2455E1DF99C;
	Thu,  8 May 2025 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2NplHL5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB01ACED7
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 03:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675233; cv=none; b=u+TZ+1YfjtcQBJ8iZ9UZP5+UBW2mQZkF27jW1Ky+YXCgBLi9sucjPGJ4XstZX3s5CaGooQZwNJScC8epCiGTq616BKqDXnhkwJyTb9Zd4e00K1LvXUrOvA7VtdzCD+htkMW8L5JMl3loxQe6To6Pk7XqG7IpXeX9zlhOv7JgRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675233; c=relaxed/simple;
	bh=pPM/SPxEf9tESD/ggJqae5rGKUJSjuqnjQSMzvz28KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OK6LLwtEhy7nV/9bqL9GV62XP9hQkAeQaEHfoXHxK91PUKO8iw+zDLEadU1veClK4tMCl2TCpM0AWDWSvrKuhqyJmFnvVgDzsV9r3kfQ5OxkvHqK7VY6+nvbz5fgeiG1W1fdsnVY+MT2Kwq8fJ1rqufSvZtzs4Y7yhNWKXjfPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2NplHL5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e661313a3so5934955ad.3
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 20:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746675231; x=1747280031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGvbCVQtorwpWG15UFM2tqk4BSvFGG2eWntXtTW2Lrg=;
        b=B2NplHL580R51V0PzXYJrFen3txmPlRsuk67BHzbWiQhmcXv/lCSyz6tZ9RAwq/bSo
         9loO7oL+FYRPKqFYVWcebIEGNvcN6I2ryQWjgnTh3VKrGnwU29LVVGNKXcnkV8N3vEnC
         ub8XUew2y5lnjz1FVMf29sIUC86u7DXmpoee8YI9LJhhF99MdAw19pFvMtu2zWEeyshi
         5k2mR+cBuy+Rhj5nZeSXqHbHcsqgwvmiSjhqCg1lSP+iVZOs5uH+Oz1fR6Zidakmmijr
         0IL9sr4DuaRjdCuvQIAvkIBmpPs+liGu3xH3+w7H5PpC3vC9xfCyB8+WjXTy50JcYtHE
         IeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746675231; x=1747280031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGvbCVQtorwpWG15UFM2tqk4BSvFGG2eWntXtTW2Lrg=;
        b=irmku4Aj8VYBAE7fmybZJVjhsyq1nKyYVZoza+Qa4shSaHKKN51o8r+gFttGIFeN8I
         mSqKfMAmWq0jkKFtUO8rqdqcUVYZ/x74+uQekQc37SHYoCb5ttpggBjqQChY2P1Z+DM+
         SUM8CN+9qTS0JEHc4e9T8ERIK9kGSfDxiTEWVhh9vfuRuDymgYA7qOD0PfDwARKtVSOk
         QlU1V4/wYo9wrf6vWzS3MBHhI0/LNosb6vsPfjqZezSc8aTXb1qzf38ecsDtk/f82uub
         s1YqKL0D1XU2mAMKZzCo4zDsuwriR/MzCQViJdSBsjyJkN4BxYaduLmR7sExKDG2X4K2
         d4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUHUoZEUE++UyhokyJgZuk7/Q/jShdL+0W23bFzBZfRzK5SEoh9fcuUu2GpjFCpeHP1xW26ohQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmfUzBDXC7dDuM4MCkllK1tySVLTeO5bQZ0DgQNSG1ZwTGV5H
	O20ATj9qKbfKriFugMLumW7FmhH1RWChw6wur1fkieBIzeEYCNrF
X-Gm-Gg: ASbGncvjTEKIg46vcV2vJtb6XY4/GoAtM599wYrxgCUGsE/Avx8mzpEg51FjFNPYsOY
	pJiwRs8wo7V2h5RPp5RYcpvoOkvb5nzOZDNfCn9R1dmzeG5Z+rOvcrY6lNIhCtWlVWGwczpOthr
	i7VZ7k3w98AOuZp0koSxKfKtM+EZzTVccq5xmTCMGNogQkqmwfipyXfkHgWszcOWUBKEdB+M/Yp
	ApULXSV4OEGDgyqzuzm1zsecKBWxud9dt71a41yAEz2ysTdn/XKtBcfSyhMQyJKEqXorR3InepH
	VjULehWbLLfdoZAzfv+1/JUeoV1xg+W/eLvHwkCG8Q96jUlJtug1rP2TkNlfjmc7UQHCE2BCG/m
	l/8gUFHAtcqOtJYqDwtWWlJk=
X-Google-Smtp-Source: AGHT+IGM1d3vMyoJVzz7bHiOOLFntriOtcga4Tmp07QYCN7v6+1I5ai0Z52Kyi4KuEEHu9Zu2ZDSHg==
X-Received: by 2002:a17:902:ca89:b0:22e:7971:4d30 with SMTP id d9443c01a7336-22e79714f4bmr32012585ad.39.1746675230673;
        Wed, 07 May 2025 20:33:50 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ffdsm101685265ad.179.2025.05.07.20.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 20:33:50 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: irusskikh@marvell.com,
	andrew+netdev@lunn.ch,
	bharat@chelsio.com,
	ayush.sawal@chelsio.com,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sgoutham@marvell.com,
	willemb@google.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v1 1/4] net: atlantic: generate software timestamp just before the doorbell
Date: Thu,  8 May 2025 11:33:25 +0800
Message-Id: <20250508033328.12507-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250508033328.12507-1-kerneljasonxing@gmail.com>
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Make sure the call of skb_tx_timestamp as close to the doorbell.

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


