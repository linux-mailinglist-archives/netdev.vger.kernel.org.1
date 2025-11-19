Return-Path: <netdev+bounces-240003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A805AC6F20C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77C824FE905
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467F2364EBA;
	Wed, 19 Nov 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRQ9dG0z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOb09aEi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B9364E85
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560459; cv=none; b=s2jUPuU0R4hpEo1AYbyOgJCj5+5SFZlFR7smn3Yes41TC0X6Bm5XHECqEmeq8pqeLx0CFnRfw2nxSTFrgoCDW24y7enRXQvAD0IvWBmGXbi0asjHqNNAOuRScmPUJ02K08AovZWibS0+bhIIVXdZK9rZKdmAYgsWz5dLlUNB6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560459; c=relaxed/simple;
	bh=ImTVZmeh2vpFNfLD9fQrwKuy0gfErSGb+u4ZJhYXRog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjYby5+WIexgUsiJ8KdiSP4sNL8ndH9mq9DW0HzkEOa4NkjasKarDgiCEIFgJokf8y58E7XblVnSk9ldykiHcSy8pkdWHL8KZFl0MvNyeCalBZNskUboBX1sR60XZHuXy0d/cb7Op+9cx4tywcNYEQIObprWKjKpqsMJK6oxoyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRQ9dG0z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOb09aEi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763560456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnlIszaOHEuOBlJDc6m/bOwJ07Ul0Eza3MBUpFh3LWw=;
	b=RRQ9dG0zK0taG6LGFgTz223WRLEeb3PpBWnz+EFc0cgdFa5vrA8iFw3ZHlVQvFiQ8KREp3
	DRwMWCzPhWSmyJmerzfNAsKDCg5fGtglv85XeL48cMOvpMpl5RRQnDTHl6uPmT9Mtpfu6e
	U7rRqK3Gr9vSvuLh2ylX0BCujOqBSTw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Ky1-XJI3MbWsrbiIPTuYyA-1; Wed, 19 Nov 2025 08:54:15 -0500
X-MC-Unique: Ky1-XJI3MbWsrbiIPTuYyA-1
X-Mimecast-MFC-AGG-ID: Ky1-XJI3MbWsrbiIPTuYyA_1763560454
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779981523fso35082815e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763560453; x=1764165253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnlIszaOHEuOBlJDc6m/bOwJ07Ul0Eza3MBUpFh3LWw=;
        b=DOb09aEiAqkDsgsZQg3xJg19oFxetu78FEchLBG7GjVPM3eu0FOlU2oIctSrZRUGhF
         4W+bi3OQ8bek7T//4hx/uptyU6ooTr8JD4EFLjVx3xeSrl2/mC/eUNwz2cylGcrCS98g
         H+sFADd44kUGb9ZTYnQhwiyaRr1t/OLtx44yPhMEFsj6thtzm4Tcplq7hgldXCwojo83
         bcOwGTiVMcYYCgDrx/yhgOe2sRqMR2nywZEQE7JL4eCaal51lE3uVfyiIxCF8h5QjGAm
         v+i4+FyGW8DZNwpk2KBFGIg7QzG35vDrsy3ybEEDWzy3dNwjjLxE/Iln8de/qmfg/rV0
         pPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560453; x=1764165253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SnlIszaOHEuOBlJDc6m/bOwJ07Ul0Eza3MBUpFh3LWw=;
        b=iLtm/sG0cWllS1gWWB+/zQQ2RniqOD5OByY5EnevCau0C3F6Kr2ehUn6ZiiFxji598
         c7xsHF5XR0v0b94oaunNw4vI+bXrPRmZs5zBapEkY+iuuT6ZWsIX6EuQUiqjcRyeSNW1
         yQHW7PVJc8G9UK6Ku1ebWou4+AMPZXasajZQNBIWW2XPK0uW0hPkQEmojj41eUZfvOPp
         AvUT9oWuLO8mxZNrd72iMOoFd1suJpc/qvzFxknVmRljRl+V003nZFGyrlXrFid9JVlb
         dzbgX7dlqQEVlKLCPbt8Q9eOrXbKDCgnG82+nj7wjIji216wpqLlZdLWZGs1uaf/qWR8
         ASug==
X-Gm-Message-State: AOJu0YxakeCfE55jxvSYiq17o5gla73ai1Qu31W9EKg7SuIiPIi/CSO0
	9VDJC2Zf4VcpgJ8sVtiUNgqx4FKEyhT01P5lh+1j9j8WsBG6Sc6iXaweJehECFPaY2UoH+H0NF/
	jILQMzY8I3mfbARwu2bjAxp5MRKobI09J+j+mbR8eSd7oY9/AP6nvkg0BsX00tv/h1umGQ2WnhC
	JCIyEyIiFr5Dr/h13gqtGBbGLNb0AoDCHjYe5q68sQH7yI
X-Gm-Gg: ASbGncvg6z4XzEA9HdhafoerEKnEnsd9TJUKWFd9SGWc5/xdTp5BL1sBNc0VcxJT0md
	RD+9U6jaNCZdNiGBSLGNgKQGzkefFheiuvy2al77EiKQlnj2hvDiLX+Wl6rIgvMUbOUlhoQ1sJN
	e7LTcyXGOaSShOwsu91DsP2gkcmZ1AKklS/J1MRFxTWETOa7+zJYO05/TYQiimbOfe2cd33QI5C
	5nuzvU7RBZkUB+HSHg2B/IbOf4AwmEIGbK63XiwX9+yQVrfvg9UYbmuAv9FDX887LMOulld9sim
	QxfEJ8QboDEfhGL4w/ct79OTs/cGcGemd2BDdMFRJ7mOl4v3YgYWqsC7eSELvOTPAsG1qhJB5q/
	Bn+fvA0y/H8rnGnqjPjMTjH1FwwbYCU4A723//FBKApqyz4jLVA==
X-Received: by 2002:a05:600c:138d:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-4778fe5de6fmr214885785e9.10.1763560453373;
        Wed, 19 Nov 2025 05:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/GU144oCaIQ5cTK6D4mmTfBL+SEfYfvxUHRRC/UEbphSgwawi6L7Tk7ZZsP+c3l1fV9o0Bw==
X-Received: by 2002:a05:600c:138d:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-4778fe5de6fmr214885475e9.10.1763560452979;
        Wed, 19 Nov 2025 05:54:12 -0800 (PST)
Received: from localhost (net-130-25-194-234.cust.vodafonedsl.it. [130.25.194.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1012a92sm49865655e9.4.2025.11.19.05.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:54:10 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH RFC net-next 3/6] cadence: macb/gem: use the current queue number for stats
Date: Wed, 19 Nov 2025 14:53:27 +0100
Message-ID: <20251119135330.551835-4-pvalerio@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119135330.551835-1-pvalerio@redhat.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gem_get_ethtool_stats calculates the size of the statistics
data to copy always considering maximum number of queues.

The patch makes sure the statistics are copied only for the
active queues as returned in the string set count op.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
This is not related to XDP, but an issue related to this was
spotted while introducing ethtool stats support resulting in page
pool stats pollution.
Page pool stats support patch was later dropped from the series
once realized its deprecation.
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index be0c8e101639..5829c1f773dd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3212,7 +3212,7 @@ static void gem_get_ethtool_stats(struct net_device *dev,
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
-			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-- 
2.51.1


