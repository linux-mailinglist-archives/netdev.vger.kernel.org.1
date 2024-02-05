Return-Path: <netdev+bounces-69124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E977F849B04
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC352833E6
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5712E41A;
	Mon,  5 Feb 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rvC2F6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768902D04C
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137291; cv=none; b=JvcGszpuOkKHer0Zp89UOzjVviLhvlJeutnDD9T9ZGaQKDHUxwsdECcbEcLO88M3atNnPvYgHzIVbIY01uOX7/LLiqUT8DIpm8CNEAkwvn58rFLkTV81E4MW3Aq2pyTxJUDMZ7Vqg2zuNY//EYMVK/Dv1oDRnmxQ/UOgUHlE4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137291; c=relaxed/simple;
	bh=D4zdKYgEI8SANhLoeqnPAi4IZHnljQAAsNLd75I1ZM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KrmzI3OwTHnQQ+o0PFSSkiA6I5ADPx8yKiHbd8/NLx0eDlfoi5xzGWLoU4QUOzXgf7EVPtU2hQ3Ms8Hy3bPGn+rpnafCSIaQvheU/ehOHuciG1RpqC8I7vk0PouiLBHQrkQogWsF1+E9vA+0RMt5BHWJIsrV4sbI19HxTKHKl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rvC2F6s; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5fc6463b0edso75395727b3.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137288; x=1707742088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KyZCd8Hb1FDN7k6tGmc5xiWirDlutdqrradrH80psE0=;
        b=3rvC2F6sD+iI9qDJG0Ws2DZRdlheZpuYiT9O1XxcygsW3r/eYM0tPcgIupcw23uSZa
         OSWfomjcWY5WyZsAEOvmI1CnD7i8Z+/c82KZrSPUPT5MM2Q0XEX8vWKJbFSFyrUiZGhg
         W8ii9SX9NbBqHoFdVlg/6Vdt9sQ8zxCHm6rvIEZpyPGYnqAFi/ivfxuRlHmbUn7HvdCO
         67ywlFfdrK4eYLvxZ9gIFFuu22s7yC/Plr2OjeKDjC1KtjRvbUO7H2PvrgkmJjCZJzj7
         sXytfpZBmCBcawOJDB3rcb0+J2dBCJ2/3a5Hh1q5b4uFI2dZWxwnl9On8fDlLhoP1tJZ
         sMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137288; x=1707742088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyZCd8Hb1FDN7k6tGmc5xiWirDlutdqrradrH80psE0=;
        b=ZilmFxHvKW6MXW8oUyZxGXWqBN0VZjJqiw7Ohhnhk/75tUMBHp6fq/kMDpqGQ3CISZ
         GyNFi+tUOJoCdtDm1L9NZn6WSTfQT7sANWF4VHWgtCcrPvPiwHdHfbOCy/faP9ihZx6v
         EJcvaMak4ygA91tbAM85NBpvtru0C+1Z/6VXPdB/okGDpe2RdwTvWh8PE1JnXaSob5wV
         AHrZ3S/jrTB7+MFsoad9jn+9NrUmV3yAIlz9L/xaYqpaf8OyIWi5Kg5ujXTpIG+5JnhI
         I5qVk4qKDJPTvGNtXcAP/7a2kywiZ/d1p/A1N+nNscyO1j9PDRcTSYdTMmBF035KL3z4
         AQ7w==
X-Gm-Message-State: AOJu0YwrhEBxgUBSie98IMf5LOJK55u5hP4o6PE7utnuLedag5QSefdi
	9Ugcf6ihVfSOLVUwHlO0TNcYwXazj2IDpPXovY6gNNBW7i8DiEqGOlYulZd18ZyeR2e4cndR/km
	f18dRGHZbLg==
X-Google-Smtp-Source: AGHT+IGIsQOq1B9zrs930Co2Fie3dxx6nVLXTxvwa6nOkoaaQJAfQuA0uhn30s62sSRY//Qtf3kWl4nelQOW5A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:9b53:0:b0:604:594:2a58 with SMTP id
 s80-20020a819b53000000b0060405942a58mr1861016ywg.2.1707137288368; Mon, 05 Feb
 2024 04:48:08 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:43 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-7-edumazet@google.com>
Subject: [PATCH v3 net-next 06/15] gtp: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call per netns.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/gtp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index b1919278e931f4e9fb6b2d2ec2feb2193b2cda61..62c601d9f7528d456dc6695814bf01a4d756d2da 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1876,23 +1876,23 @@ static int __net_init gtp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit gtp_net_exit(struct net *net)
+static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_to_kill)
 {
-	struct gtp_net *gn = net_generic(net, gtp_net_id);
-	struct gtp_dev *gtp;
-	LIST_HEAD(list);
+	struct net *net;
 
-	rtnl_lock();
-	list_for_each_entry(gtp, &gn->gtp_dev_list, list)
-		gtp_dellink(gtp->dev, &list);
+	list_for_each_entry(net, net_list, exit_list) {
+		struct gtp_net *gn = net_generic(net, gtp_net_id);
+		struct gtp_dev *gtp;
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		list_for_each_entry(gtp, &gn->gtp_dev_list, list)
+			gtp_dellink(gtp->dev, dev_to_kill);
+	}
 }
 
 static struct pernet_operations gtp_net_ops = {
 	.init	= gtp_net_init,
-	.exit	= gtp_net_exit,
+	.exit_batch_rtnl = gtp_net_exit_batch_rtnl,
 	.id	= &gtp_net_id,
 	.size	= sizeof(struct gtp_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


