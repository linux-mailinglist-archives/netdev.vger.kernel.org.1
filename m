Return-Path: <netdev+bounces-114600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945DB942FE7
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51431C228DF
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6672F1B29B7;
	Wed, 31 Jul 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NPzsenht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF011B1510
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431753; cv=none; b=kk8nwZZlD2EipasSpD6hYwdrD/i7j+eftfDCWczzqFlLu1mA2Acy4nrAlISCE5SK7xDvlcKAWl4vz+yAW+Uy/Mt1gJMJi6Lf1hg4AujDt7TD1QDOXUEuZKGuYPZIKH1HZjc0L7Dv1+TcLzqR+pGmQ1xvvuLYx156qL3wsSFQu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431753; c=relaxed/simple;
	bh=tXrNhEtYj51EG3loVWDEE8cFvUlVg8YXAdF5iRelxyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4OAhcUJQ1MlvzpIWG65Mz52/kqwdCAYsG0nRsIHqkBNvRi5I+A9/pXCRim+Qu0vOybBQXDZicwJ0n2s0H+b1of3JbyS/+jma173Rc1Jq6ElvqhIwOLc9pwdZJZFkm7+IUW/K1Rgz8s2OWcenXlyM0ww2cbyglgI0cnc3OhUwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NPzsenht; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc6ee64512so40754715ad.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722431751; x=1723036551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXxjmz+occooGbVYmoKul8P4v5h5JtRlfw54Rb+UbI4=;
        b=NPzsenht2ZwKzrAfG0VWtA+SV3LnrKOVX1Kvsbe9KHvbdoxzvkBBGrP6IpOqIe1Ivm
         H3XZm11Ym/FKAnogmZtWW91c9bS6cy4ltjLiycO7378X5xpJcxPFlnrqo8sYJOzVi1vY
         bj3EgnFI95bQMM70nfdc3dFs69RbvNUH9D3uV1Qo6bgF68e2jmI5PF/4AGiw2/4impGG
         jI4Q87tAA0k0vXVsrD6rDdqLrbyhw0w/jfGrvEeLhbL6xi5VRPeS+r6eZQy8gbFRBj5K
         PFRLxvjphn04Ui7JR2OYkU/5g4GS7tcQiFNMWUH6mEJGsaU/tGa9bl3/ooOfUdT1v68p
         rBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431751; x=1723036551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXxjmz+occooGbVYmoKul8P4v5h5JtRlfw54Rb+UbI4=;
        b=QQk4N08ibfth81uXXI8EHSVGUGNQhRBLSnbO4mn1/5SMB2SxmqIRhiC7qNYV90vL4c
         f9NQk3uvkM6Re882Wci1TtYzztcDcbos0h+7efh6zkgmYBheDFpNSG7nR+OLYXQPzEbE
         nO0dbdoN+/hK7l8p+ybRN9SGHNeqa4OW4GxmBC+VQJDuZZu9oW4qLhlpxdY8xiTYPB8I
         Q5emMOhad4H2KYHpTRYiaTGL7omXk6bigZ96N5nV1TkqMc6JCtj/S8/Lr9KNdiTG61rF
         HYWHTTRBImhKkDGcN5X2KugicZRBdLSpFKAafeBLn/xZIFEKvbvaDw9i3O4iCK+TlYHG
         cIaw==
X-Gm-Message-State: AOJu0YxSpamx4Cypio4kCc8zQNqYNqmI0iXnZGHQnm6HXuyZdDkInfuZ
	F//abEOn5JrFQ9AIFvwAfyoc95LCOISHC7v5c+u1EE/gaS0RObHS4C+ff9XYU5RlIr4/x+SFwi4
	jVtA=
X-Google-Smtp-Source: AGHT+IHEb1JlgJH1dOdGirOsMzgi4Krr9MU8bpCrOmCnWKOPe34lEvBWwGFO8i8UCUI4QZkH3Qapcw==
X-Received: by 2002:a17:903:228d:b0:1fd:74ca:df49 with SMTP id d9443c01a7336-1ff0484a657mr144810895ad.33.1722431750983;
        Wed, 31 Jul 2024 06:15:50 -0700 (PDT)
Received: from localhost (fwdproxy-prn-115.fbsv.net. [2a03:2880:ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa8806sm119888415ad.262.2024.07.31.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:15:50 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v2 4/4] bnxt_en: only set dev->queue_mgmt_ops if BNXT_SUPPORTS_NTUPLE_VNIC
Date: Wed, 31 Jul 2024 06:15:42 -0700
Message-ID: <20240731131542.3359733-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731131542.3359733-1-dw@davidwei.uk>
References: <20240731131542.3359733-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The queue API calls bnxt_hwrm_vnic_update() to stop/start the flow of
packets. It can only be called if BNXT_SUPPORTS_NTUPLE_VNIC(), so key
support for it by only setting queue_mgmt_ops if this is true.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ce60c9322fe6..2801ae94d87b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15713,7 +15713,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
-	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	pci_set_drvdata(pdev, dev);
 
 	rc = bnxt_alloc_hwrm_resources(bp);
@@ -15892,8 +15891,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_LIST_HEAD(&bp->usr_fltr_list);
 
-	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
+	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp)) {
 		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
+		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
+	}
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.43.0


