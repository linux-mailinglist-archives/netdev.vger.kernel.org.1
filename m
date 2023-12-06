Return-Path: <netdev+bounces-54509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C5807589
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15198B20FA7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286247777;
	Wed,  6 Dec 2023 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="x4pwIHGn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9FCD3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 08:44:42 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d048c171d6so51167155ad.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 08:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701881082; x=1702485882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1n+hUHrQ3jdYpTFXY4hRVwRAm0ea6knPIuI4zsgLEY=;
        b=x4pwIHGneJt6WLef0XEWObvXwpjW93klDrKv8nw7M7ezG9mulRA4OBYQ/jyZmk2fl0
         ZXGE1Bb/gstIX5V+3Qo99mDjMyGozXQNzUWqclaL39sO2Qir7m4WSFE7C1ufKotZkq3/
         qQtOcVnBRGAECNbLeiJ0WOoPkzCu/X2lXAV2gTkI2yg4FkYC5yxUjs/AAjbYTeEdxgUC
         h0CrFCY5vnxd6JR8CaoSf4GagGMPzeAesdCjjcd5AIK75AKr+sshfnDLiPq5Rz1rLko0
         LyMCVJl/I3WO8JuOBWpfrxY8JMUsQfo7Raiq3WW6RduSwzX2G8daWvey+IjhaXCxMDK2
         H3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881082; x=1702485882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1n+hUHrQ3jdYpTFXY4hRVwRAm0ea6knPIuI4zsgLEY=;
        b=OT4NabsZexY1CuFLcrpTgk+Vj7h0IaGhAX4hRtYgCJSzLxXlzPaF9W1Wz8smdc5orn
         TXJ4s3CCjHDX46j6rf4icy2/f9pZnzDZHBfAyKFxM799eC0VQD0saxB8KLk4LWKRBI6F
         XyTDFbndqDlATaKfoeujYx0jI3LeseWXPliNzd2tPHl2YhTgw0/x2LueC25uLvk6TN0z
         VFFq4qayjfCXdNn+y/oQejruFTVGM2lwr6Dsjz6M3gfReOYFYKpfgUHwWQ3V9dlPK1iI
         N2hs2juB+Xu3VJtK6vgD/6yyVijUgpDeZ7uHcsMAm4/iayw9Uth1rDmO4yixwm9EoKY0
         h3rQ==
X-Gm-Message-State: AOJu0YxQBhvNGXfAzRiM/pSslQ+s07q6nAabwZOkqfhbV2hvscsOEn+L
	CciWex0efJPR8bTr1eU2iaW6r2iiZ/dbjU7W76Y=
X-Google-Smtp-Source: AGHT+IGZ/SOLjkZ3FCy4v/KN/ZPXD0BaC6UPAJ0G10qWDS0CVww7VfaNlQI4NByc/By8a9NHnyMAhw==
X-Received: by 2002:a17:902:e882:b0:1d0:b3f5:c318 with SMTP id w2-20020a170902e88200b001d0b3f5c318mr1292638plg.106.1701881081988;
        Wed, 06 Dec 2023 08:44:41 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001cfc3f73920sm36719pll.227.2023.12.06.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:44:41 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v3 1/5] rtnl: add helper to check if rtnl group has listeners
Date: Wed,  6 Dec 2023 13:44:12 -0300
Message-Id: <20231206164416.543503-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206164416.543503-1-pctammela@mojatatu.com>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jamal Hadi Salim <jhs@mojatatu.com>

As of today, rtnl code creates a new skb and unconditionally fills and
broadcasts it to the relevant group. For most operations this is okay
and doesn't waste resources in general.

When operations are done without the rtnl_lock, as in tc-flower, such
skb allocation, message fill and no-op broadcasting can happen in all
cores of the system, which contributes to system pressure and wastes
precious cpu cycles when no one will receive the built message.

Introduce this helper so rtnetlink operations can simply check if someone
is listening and then proceed if necessary.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/linux/rtnetlink.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 3d6cf306cd55..a7d757e96c55 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -130,4 +130,11 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
+static inline int rtnl_has_listeners(const struct net *net, u32 group)
+{
+	struct sock *rtnl = net->rtnl;
+
+	return netlink_has_listeners(rtnl, group);
+}
+
 #endif	/* __LINUX_RTNETLINK_H */
-- 
2.40.1


