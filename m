Return-Path: <netdev+bounces-151802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D999F0F17
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D002618806D3
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7331E105B;
	Fri, 13 Dec 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GykInT51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3651E0E01
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100098; cv=none; b=N5f2aOZUwJtBDkonBe1ZHrGc3f+TodVdYrpG8tNuSRkFmntQ9U7Xfmwpr0mtFN0tas2UrQKpkTJ/YJBQU02MJTko1orP6o11gmzzUU7LTtr5vR2+adfORyyjLQQJBG3c4Tn8yNzK6J25/1IfPaTM7SFXxuowDigOp0oStCX4yyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100098; c=relaxed/simple;
	bh=ycSL9pobM2GhQ8mh8TcgkFJoZAB71btUIwZlSI8OBQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n9g+zqFCghDw5BlpP7djV1kU/BRY/YgmETD7Z0WFwWZOeyptWn6PxmB7XIbZJE0dO508ugUZn8vgU7GpnFa+OnDWU7StrqJyP5w9mdKD4lfhcIrypw6N5HMnZ1wpgVpelz67lU/k5Ro44eTbnkiCQCxUarXq5gLX5kMcCNZ5Lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GykInT51; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6aad76beeso273481966b.2
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 06:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734100095; x=1734704895; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HgAV16YkdRGlFfEMnvEaWjST0Bhl3h+Wb8WzngoB54=;
        b=GykInT51SChvGiDEfeYGzIpfxjxZnSLyHN6saQXW62tSB3pMMm2Y2Xhc7LGknP+bzC
         BiBTo5GyCes6qwTWuBbzekG1bi8FWoAGKd7gGL564zQh2QMU16FTlQ5ROWLPlLh1Vi9u
         pdcO1rnWcxJ8Lk8CHe+/2m8PXgaJI1nqvNix/EEKiuGLugc+yFC/3WIH+84G6hleQkfh
         /Zcc5wH1X3FjPr23RVnt559R6Jd22E6oe+d2NlobGQBVC23HKgGtubwkNA/cM28ShEYI
         w3pOScruyWraGjM2xnhQQOK4DqQY6R9f5ybfuWjaGoSDJQb2Zqk8SfTPgxFrdttq031Z
         5NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100095; x=1734704895;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HgAV16YkdRGlFfEMnvEaWjST0Bhl3h+Wb8WzngoB54=;
        b=hzt9rkOX7hLQS//4sXaAKmWnKSb4Jk/PRvy7qOfRFpvG8JEelToqeIXAaMqUDIiLME
         Hcod78LXmg+hUiZK8CQ+/7sg7Entrg3PUQkVD3PFWxrddKSmcWTKRst1gEIroq2HKYP/
         be8lG54SKUsg5kEvSZST4oeI9Wi99wR7DDg1R2mJYPwGsQ/Mu2JNqtD3vo0TsB9Nv94I
         176iU/n2E2pMxwJ+i8sUyjUKeMTOCvgY+dLIDDZEWuPGzAB+1MD1LzH+kWUYiII4R8o8
         3bA8cTA6SJZpfuAi6kgCJ04RBMoHT55InI1PQ2ExibQN3tppav/mv6NINZNnynaYaPt1
         Nz+g==
X-Forwarded-Encrypted: i=1; AJvYcCXOLRBgsoPHD3WnuoBUIii5/wW0rGSIhRsGnMwH+HScNe2xj7fkG9JFpvYHj8Qd8XBXmCecf+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgyJdVCQHL/Mei4HMUhNpIpjSSnTSFezClPAeAlMF7ppdkbYO
	EbTJX5eXBa9pSJFFMPXZVifONuPR5JuyeqHws/EJXVeOHq+QpiFOFxc//nYTMhE=
X-Gm-Gg: ASbGncvdGGfq/o+s+27euWljC1fDJRX8WCxIbqw6UQi8va1JG5r2uX6WwooWK5ic2oo
	Ep4d/ZlLHPWn4CnhZtq9xesYgObG7NaSjD84X23qDHzqNjYsHEFQQdYswj+0iVm10mgnBnS9VaD
	zxnwE8WFZGyQggFnN9DjNbbaaOHp+nml0yD+HG+SKx0OP7knAa/IrAB51HjUBzjoHoFk5Tu7gfV
	TXsg2KCX64fOO4VTypuXW6oulmPtKMSYvLj1dWRur8ZVgNBaj6VrYdfM2wUng==
X-Google-Smtp-Source: AGHT+IGJkag4RDJORMNjsRd1byODIzZaljb10SMvh4Y3I8u2YSlY83WcCmGpoYoRVmZz3xf2h0z1zQ==
X-Received: by 2002:a17:906:7944:b0:aa6:6e04:eef6 with SMTP id a640c23a62f3a-aab77f07a24mr319003966b.61.1734100095261;
        Fri, 13 Dec 2024 06:28:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6773936c8sm808925466b.85.2024.12.13.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:28:14 -0800 (PST)
Date: Fri, 13 Dec 2024 17:28:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aviad Krawczyk <aviad.krawczyk@huawei.com>
Cc: Cai Huoqing <cai.huoqing@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zhao Chen <zhaochen6@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: hinic: Fix cleanup in create_rxqs/txqs()
Message-ID: <0cc98faf-a0ed-4565-a55b-0fa2734bc205@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a check for NULL at the start of create_txqs() and
create_rxqs() which tess if "nic_dev->txqs" is non-NULL.  The
intention is that if the device is already open and the queues
are already created then we don't create them a second time.

However, the bug is that if we have an error in the create_txqs()
then the pointer doesn't get set back to NULL.  The NULL check
at the start of the function will say that it's already open when
it's not and the device can't be used.

Set ->txqs back to NULL on cleanup on error.

Fixes: c3e79baf1b03 ("net-next/hinic: Add logical Txq and Rxq")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 890f213da8d1..ae1f523d6841 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -172,6 +172,7 @@ static int create_txqs(struct hinic_dev *nic_dev)
 	hinic_sq_dbgfs_uninit(nic_dev);
 
 	devm_kfree(&netdev->dev, nic_dev->txqs);
+	nic_dev->txqs = NULL;
 	return err;
 }
 
@@ -268,6 +269,7 @@ static int create_rxqs(struct hinic_dev *nic_dev)
 	hinic_rq_dbgfs_uninit(nic_dev);
 
 	devm_kfree(&netdev->dev, nic_dev->rxqs);
+	nic_dev->rxqs = NULL;
 	return err;
 }
 
-- 
2.45.2


