Return-Path: <netdev+bounces-118392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18915951757
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB3A1C217F5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F8B143C6C;
	Wed, 14 Aug 2024 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N0mNBwov"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5B14373B
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626504; cv=none; b=ZbK0sZTmRk+8/Kg6PYyg0bN4enZh/ETO2Iluf8sjgQwAyhfc0lLGfKgcoqkEV14UTi5X3eX1ElbSvpQWYJB2eWOMMVkRSJtT3ZEUeF1vZyvY7fYLrs975ZFAAYsSa8y5gwsEiObd6j3NJEQHTaK3Qj3JnfLwmpEOFh1W3c11GVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626504; c=relaxed/simple;
	bh=44WOPlnqlPk/mb/+BMsrqQCYiSdeF1zdyuVp4QVRKio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gCbG8AXJpDgDJ9iqjRjufzwv9/cuaLBXa6tO1pq/iXKRcAbe8UqQx+GCfro5GI3pi85IzJgqcSaRgYGOCDmJF8SFINj/L2AqyjtBxegPh+ciYf180hnISL4dkHVULmwoezILOuvtDEkrOz/D/uI/NwBCQPAPMy5x8/sUruzAlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N0mNBwov; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201d6ac1426so5393695ad.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723626500; x=1724231300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32PXXV2QL2XbF8eLBvu4oAhbSZGQ+NlsUMAqd8y/jh8=;
        b=N0mNBwovtY9nG6vCIuc0W1fNGjX6pR9t1JqrLn4KL43oj3o8Mp0EWsdUagS0IlXwtU
         XqDFwjP1sczJSjTlEOQf3I6b6m3UkkDr5TwfPdEl0/ey12LIFHZ51MdS8XiuKR4TvCH5
         /uu+NKwTL/q/UgN7QIYuVSQiMS9JfJ58+4b4f+9ulIwNFjzCX5J2CEDBxtQ8V+nlz6uL
         R/SSGsEeGTm1oTeLG3HzzXWjYMCD4rPva/x/1HOcMQULq+nCOF+3j/qNIy7Y+4xHxk82
         w16XscJEn2AD/pEwlyaCjNJhBv7fY/vVN7J+I1wQJ/ytQyYGZdMmylx9IJuwsyjdn+sU
         a0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626500; x=1724231300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32PXXV2QL2XbF8eLBvu4oAhbSZGQ+NlsUMAqd8y/jh8=;
        b=Ws7G7hx6Rjpcxb/BglQZnEwitoeQNGm9JvdikHXjuspcv0l4Y8IMQt3kTcNmiHD+5M
         DkGHrxU1eV01d+duUUTyCsnL1h5sMOXPLRm3By3ZcRLC2tJBJ9dPTLEo5bXMZ6rz21yl
         /4s30x7SAHwm629MFjHMzNIEyvFISLsnyST4+3DvrY2GLyzN9hC1oPO6fd48PNt2F4wF
         5YxdpBdlWE08pjUs8YeNA/oJWFhr9Yjk/OpjGHL/qE39Jt49EprjOIEi/HNPr7y5qqW7
         Qedwikl6Bh3F1WSi4yjueQkVv01ikfNjCSQ8TIaYpt5w1qwo0mUxbnQcmxaXtNrkUzYC
         +AVg==
X-Gm-Message-State: AOJu0YzISRorfN8FNQTBtXLVCo1GMNrMCypdpqRmCIj0Ama91EoBoHbg
	zmTW+KFZruHC7uEB31Nc0WTE732d9GKJEzXFI7scoUa2ZGU7eB9XgkMSRn2JzQs=
X-Google-Smtp-Source: AGHT+IHuYXuhltEliMauH5KaebG0cPWH0eOsGcHY9bRFUYY3iGer/a5GVOSz9JPxxkNZ4ftgPwkdew==
X-Received: by 2002:a17:902:f643:b0:1fd:6655:e732 with SMTP id d9443c01a7336-201d64d0e9dmr25671975ad.54.1723626500510;
        Wed, 14 Aug 2024 02:08:20 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1c86f3sm25456875ad.244.2024.08.14.02.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:08:20 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH] net: Don't allow to attach xdp if bond slave device's upper already has a program
Date: Wed, 14 Aug 2024 17:08:11 +0800
Message-Id: <20240814090811.35343-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Cannot attach when an upper device already has a program, This
restriction is only for bond's slave devices, and should not be
accidentally injured for devices like eth0 and vxlan0.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 net/core/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..e1f87662376a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9501,10 +9501,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 	}
 
 	/* don't allow if an upper device already has a program */
-	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
-		if (dev_xdp_prog_count(upper) > 0) {
-			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
-			return -EEXIST;
+	if (netif_is_bond_slave(dev)) {
+		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
+			if (dev_xdp_prog_count(upper) > 0) {
+				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
+				return -EEXIST;
+			}
 		}
 	}
 
-- 
2.30.2


