Return-Path: <netdev+bounces-137719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5D9A9822
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C197B1F235F4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 05:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEEC80C13;
	Tue, 22 Oct 2024 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7Gbq3NS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98312C522;
	Tue, 22 Oct 2024 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729573921; cv=none; b=IYZxv7awz1a0Zw8BxM6O5Jn35/C7/mJBB9oF6WZAyvQdp0fHkvoi+wXbdcPTiyYzybqaO/nJE90/mwYmoVe+K4g+vaKJLePAB8aVC/+qscw0pKOVOi2Zw53rUkn/CZRq8Y8QZVsL1pYap62jNYyADpWj8cDbzMnCyNINGxvjDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729573921; c=relaxed/simple;
	bh=6nL3F0+rXvu/ufwo6ILRxMgK5uGgnngX3VW9rqLR2cI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jJIpTq/icyRW0cA/hioFV932fuymwI68jfcLgOZe8Vazjkn8Uajb463/hb/u3G1q5aVDPoPFZaD94n2tLUPlmogNqx1apC8oQk6bY/9hL7y8RNnHpRjS0n5RTuIZxtCZ9/CMoiMRPQCrO6LGdWaLD7UCoVRiVIw7Oi0WTbP9B8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7Gbq3NS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c693b68f5so55562675ad.1;
        Mon, 21 Oct 2024 22:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729573919; x=1730178719; darn=vger.kernel.org;
        h=content-disposition:content-description:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKMBsCanZz1Gh8n+AXUDeahzWcX6egHuFJT38KRlsqs=;
        b=U7Gbq3NSUCTWk9aoGgC3vkORAN4WO/65FMpR9u7w/ny/Jze3lZvd0RswgDvD5Nj/9T
         VlMoxZ/rumAG/7W6tX943EIx4P5IRZz0xpTLOB60zJdGiK4uyYt5XMzWJh6W1l4SrLg/
         K3bQ9iT3gTwgAPvfIZZrtDXVExwMSOsuFuJPlYw1pWChup5cb1MtYMbf4cuMCCHWMqks
         tCxG2PDPEYIR0nLKVkPbA8DL/zZdtkbo9gkRIOFg8I0q027IUV0L3QfA4eCi/HNEGll+
         ETaefy5aWpyfteZyW3KDhy1IMnGiAyPrEft1xW3EMdsudNzTwHrnrDH64b+h17NMfiPn
         2GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729573919; x=1730178719;
        h=content-disposition:content-description:mime-version:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKMBsCanZz1Gh8n+AXUDeahzWcX6egHuFJT38KRlsqs=;
        b=qNxYZS+XK8SMhtdPBCcBSR2leXHpsqQ69DtRFqBolO7xayrJ/89uETRqXl7YW2zS9/
         mX9vMS7tHgkQ3GRgTDaVENJWBDnq90F2MR4YtOQY+SSM5cBBY1en72wNYQ/1GVcAnOrQ
         mv2Gi3YvSQFO7SFgPTAX2PGoO2FpikQjARC6ERG6GdIp62VA9Nu/JB01C050nbNeKcQo
         kzl94DM9nk2FMGYZl080gGXshHmedsZB5vRIBJ9qfVMLLomrMdvJTKBildjo6dJf+myQ
         Q5aFPg2lw7MbB8lcdsb05xbvnbICqI/s4/6xuHzDOtcQsnlSe6u6QZUOHAAYpyXPC0tC
         86Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ew3arVYQfKXMbV/iZIiF+B9+fjjAfCP42L7qUYm5IQJE1OLTNgNKS0mxSmrOvzz0XckeA/zyQUuDVYTR@vger.kernel.org, AJvYcCUCTi0NA9rBSx+CC5RuM7pHNX3i8kO4ZMrGlwQG/Lc6RR6XtTf60lD0w9hDr1WgZu55QT/QUA4pp/ce9sqhS1I=@vger.kernel.org, AJvYcCVLLcfNmB0dCy1GjrAJguImSCbo7QD1mIcDvR5JrzDvpsB7eysfgNJ2cNtoA/RHPgCBt9nxPXPo@vger.kernel.org
X-Gm-Message-State: AOJu0YxM83+bzzumhZtWzd6gNdz+J9Bx8sKWx46R4um4hNC8/yGnN4Yz
	GcqVrdXDUUtLp4lFebW1Q/JoSKftByjkUzoBPccAxT13DtWAmsft
X-Google-Smtp-Source: AGHT+IFa0NskIKUN1a+IaBC/kiN3u+O4oI32iW4jSozQeLQ+HEEZ9YiELB5Tn/cEBttmtLXKufCSSw==
X-Received: by 2002:a17:903:2306:b0:205:3e6d:9949 with SMTP id d9443c01a7336-20e98596fc9mr18662135ad.52.1729573919236;
        Mon, 21 Oct 2024 22:11:59 -0700 (PDT)
Received: from Fantasy-Ubuntu ([2001:56a:7eb6:f700:f589:b8ad:400:2216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f3665sm34705005ad.271.2024.10.21.22.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 22:11:58 -0700 (PDT)
Date: Mon, 21 Oct 2024 23:11:56 -0600
From: Johnny Park <pjohnny0508@gmail.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next] igb: Fix spelling "intialize"->"initialize"
Message-ID: <Zxc0HP27kcMwGyaa@Fantasy-Ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: Typo fix "intialize" -> "initialize"
Content-Disposition: inline

Simple patch that fixes the spelling mistake "intialize" in igb_main.c

Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ef4cb871452..ad091179872b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1204,7 +1204,7 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 	/* initialize pointer to rings */
 	ring = q_vector->ring;
 
-	/* intialize ITR */
+	/* initialize ITR */
 	if (rxr_count) {
 		/* rx or rx/tx vector */
 		if (!adapter->rx_itr_setting || adapter->rx_itr_setting > 3)
-- 
2.43.0


