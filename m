Return-Path: <netdev+bounces-103696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 550BA9091A2
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 19:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44415B2C22E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC719EEBD;
	Fri, 14 Jun 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMtBnXml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41919DF6D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386307; cv=none; b=MoWiip8cgCv17Cxadn+sy4VN9BosYLckCwtbX8JAXlq8QJltTLFgWR4M8WB0geVeW7N7Poe6nToEYqe+Fhb5mV1Jw0bXFJLVD0X1M3H3QApFbxPeHQEF+jPkNJBGCawSlf9WLm+xgW2ZCMeC2wcFYAlcYlL1yhyVG3+9cjvQvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386307; c=relaxed/simple;
	bh=BSipHlIgDvAU9jtI+0UzoGnMftxvZb9NU2THa75rZr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ht4kojvhi4FI+ndV7IBLtLNWwqin0iXbs+BnCbmhDsEDOKdqrcGx51QLKWaQa7UbBq3IAAQ7ZD2/MyG+1od+cQ6sfRTkisHY8i5xNKquhTukmzwELbbh9Goq6GaD25GU7hRi3BQhrE4kJTroxenjdDdLck4B2JWDtvWFam3JT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMtBnXml; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35fdf7aa8a1so1718897f8f.2
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718386303; x=1718991103; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aAn+dyPFDj13W9kA9p8UoX5UEoPcAwL160WAxAoG68=;
        b=JMtBnXmlPkwAZGeP120iN5JmDE7dBxPvv/O/r4PZ2EtSpsOvoafQjb4HqXugYmIohg
         7+oTb+Ca7kqtML11aUm0WEpcHAaLSjAOMqb4prFAJIkZhACXOM+53Ddd3Ts4TyaXaTkC
         J6482p/iPzmWQNq2Kg92AT7omsUN7jj9CMnZ/Fw5XTOk6lNh9cfXhmBgg1VmFRgv6a/I
         pldcPbi/usSIM5+5oWduSQ4SvKD3kS1/MVzno12JCJs/jYFedMRZPoigT8V9cIRA9OVv
         lZpezaREi8rlC4/sSo4dox5JVNE0/9KIz1YXUSoR3uVTeK5Di8xLHbFXUSPtcrzIAc/P
         x4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718386303; x=1718991103;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aAn+dyPFDj13W9kA9p8UoX5UEoPcAwL160WAxAoG68=;
        b=HzciiKa2z+y8iWCqfAtnWImkpEoEOKPsIabWPnUWMphVn0uJyy0sw2g6Sr0o8+tz4n
         nXKBKOBvxt4g2btsKDyjYGGpctAjkSMEo0eRPg+nOtO71qexhKMlmjO3ponhavEwrBR0
         lhQ/PVdrAJjKeEacXAqgBi63OwqRSDgtvB61tMk6FYYOwsjNT0243qXuJ1vGjUxPEUfg
         hUwXBSC+KXuCW95Pus6OJfAQR2tjGUCPcJAHZ2i/dvZa007o9i2gEAWi6TftuUlUS07J
         2m0HXTb/alZyeYqXCemF50Fe2D2H1pHXL4CWu8wKiSZtsOJ+AXLfhtUXlB7UnyrBrSGQ
         avyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7YLjM42YqqSsg7IN/shYf1gaya+Dx5sIpkcE5A/8+eK8bsN8vXGttBNcnykIIXOgZkEEQY/EZ39gIwx6UZnG8J+L1ayQ5
X-Gm-Message-State: AOJu0Yzozv9bIY2gVBTQNYdcYpPtt5CVOLKUJFF+edXmrDmjceSxx7kq
	nww2O+VrV9K/501LbmcM60yDyL2CWFBORuxo8vkSTGv5S4NpCdHiUgyXcqnddjLtm3frLS9Ak7q
	x
X-Google-Smtp-Source: AGHT+IHG7stbgSaExY65n+9KApXBI+yAhKzMZixuvshFIifsWmYEYNx+9bdoDb5iW6MQiJc8Gmrfkg==
X-Received: by 2002:a05:6000:4014:b0:360:7558:49dd with SMTP id ffacd0b85a97d-3607a75c379mr3218191f8f.36.1718386302611;
        Fri, 14 Jun 2024 10:31:42 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad082sm4909069f8f.59.2024.06.14.10.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:31:42 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:31:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] ptp: fix integer overflow in max_vclocks_store
Message-ID: <d094ecbe-8b14-45cc-8cd8-f70fdeca55d8@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

On 32bit systems, the "4 * max" multiply can overflow.  Use size_mul()
to fix this.

Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ptp/ptp_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index a15460aaa03b..bc1562fcd6c9 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -296,7 +296,7 @@ static ssize_t max_vclocks_store(struct device *dev,
 	if (max < ptp->n_vclocks)
 		goto out;
 
-	size = sizeof(int) * max;
+	size = size_mul(sizeof(int), max);
 	vclock_index = kzalloc(size, GFP_KERNEL);
 	if (!vclock_index) {
 		err = -ENOMEM;
-- 
2.43.0


