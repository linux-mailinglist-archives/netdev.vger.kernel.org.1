Return-Path: <netdev+bounces-130997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F87598C598
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145161F23542
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488C1CEAD7;
	Tue,  1 Oct 2024 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjmusiZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF41CEAAD;
	Tue,  1 Oct 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808378; cv=none; b=jx2BoN7z9Bj5dCuohDv2r8kDaqA7SOpOgwh4tr0d/92jGj8/0+TzlgEEFA8s9ZJbNuTxDHAOR28D4OqohoS5pGGV7axsWRzEYQwE8FgdV3Sd4P73HH3MMCP8C07jpnY24BjmrSOaCrw0+EoNxWeWoDjiaG9ZLO91A7vXMQeIoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808378; c=relaxed/simple;
	bh=46GVykT6SX+LlJ6jm/yAcXTk9kODUQH0b7YRv9z9aDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpaMWuGU8rmvYnmhksiC5jRz06iJ6DGMU4M5ouBoGHiKR70jdpq5878xM6dgdZwiIDj3upoaRF51DnLgbjxCFDDpBiGcqCNqNAGTvQK8bv5iX0AE0shrjEJMxcZxC+WKwAi/DF/20YuwmfjDJBBChU82DStJtS0OkGEXaZef2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjmusiZG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b01da232aso766315ad.1;
        Tue, 01 Oct 2024 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808376; x=1728413176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbgRMhvLgzToQp3FK/UHWQovuPUhRbZqbf3H6v2KiJM=;
        b=bjmusiZGeKIrpLDlUZUm5A43cWCJYtBqUJAxE1jWg7yxWII8Qm2VIbifx8IKVKRoWM
         s4QlJVNhRcVuePGdPUqRS2X9Eqz7AFK46qsZwlIpmqYoeRrz+nC5FKzqI/I9i7JOqUEL
         oX+vJM45dx97h/jbNuFPCsSsy4WcBqawkFzDSc3ktyZxK17l67DuuuIVfOwDJJV4HQ34
         9Lgw/BoBqjLcp2lqwgVfK0UrGABFxWjMwSUnHDOxJTa2tc33By8r39Abhtkv+yJU+3Pm
         DXzJ/LLh/YJ0frVvyaXvLqjFZ3nlW4pcxGFWi7hzq9gKN0rm4nFSEAQXZb5ZRfL3ptjY
         UjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808376; x=1728413176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbgRMhvLgzToQp3FK/UHWQovuPUhRbZqbf3H6v2KiJM=;
        b=vz1BRdBmBZ5xxMJwgoBM5czL7lgg3O9YVWFNx3IYrlMBXibJ4npp+wXaPQjoxxdK1P
         Q3lfOQuaMnxORHu+Yqn8a6QFgQLY2k0wE9UwL6DrVqkYKMUp+JI6zf+3vQ+lDb/MyVxs
         p45QWAbhmIVCmn+u+gbnL7GYrwytsEO5Aga2SdraVHEjwTred4f91HJBLrqJWYgyDuQf
         lvJBD4jPxw5aLTQq31IFY/Vn/2hDdR0gwfgmOoVhcyN2Y2/KOZiVrz1YvFMlTdD3xOfN
         7wAQaaEWnZk5RAY8l9JdgFtzpwImK+mhPVbMVFauO5xzhlIvUeMHIGb3YsTqVbFrcAJK
         RNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWStz+ivyJwaUfuRjmPyPZ+cdRvbHqqhHw650BT0ScPbx7CQ5BJtcwSg3YsjjsA9dnIekokuNwA5JyEW2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRz5/KcKvb36oZ7Ljgfh2zyvSQlw4wTtJ/JsBxe5n934S8cDLv
	j+txirlGI/tSiaZtyMqXD6AOHUVlyMLv25eBUuqsCj/g6bkwHje6C5so+mY8
X-Google-Smtp-Source: AGHT+IHbDWyA114ABuIxQsPZCAYlI9Xdmw59CL2Ff2AaJvvzn2eE9rYXzIZz52sLa7tk9CiPxjHP/w==
X-Received: by 2002:a17:902:f791:b0:20b:a8ad:9b0c with SMTP id d9443c01a7336-20bc5b66b7emr7548425ad.3.1727808375913;
        Tue, 01 Oct 2024 11:46:15 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCHv2 net-next 05/10] net: lantiq_etop: move phy_disconnect to stop
Date: Tue,  1 Oct 2024 11:46:02 -0700
Message-ID: <20241001184607.193461-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001184607.193461-1-rosenp@gmail.com>
References: <20241001184607.193461-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy is initialized in start, not in probe. Move to stop instead of
remove to disconnect it earlier.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/lantiq_etop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index d1fcbfd3e255..9ca8f01585f6 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -447,6 +447,7 @@ ltq_etop_stop(struct net_device *dev)
 
 	netif_tx_stop_all_queues(dev);
 	phy_stop(dev->phydev);
+	phy_disconnect(dev->phydev);
 	for (i = 0; i < MAX_DMA_CHAN; i++) {
 		struct ltq_etop_chan *ch = &priv->ch[i];
 
@@ -711,7 +712,6 @@ static void ltq_etop_remove(struct platform_device *pdev)
 	if (dev) {
 		netif_tx_stop_all_queues(dev);
 		ltq_etop_hw_exit(dev);
-		phy_disconnect(dev->phydev);
 	}
 }
 
-- 
2.46.2


