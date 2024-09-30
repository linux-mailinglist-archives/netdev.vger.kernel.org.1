Return-Path: <netdev+bounces-130602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA2298AE47
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92201C20AC6
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2171A4E85;
	Mon, 30 Sep 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVNr87aO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D61A42B5;
	Mon, 30 Sep 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727888; cv=none; b=tVL7Xf09AiR5dntk16ZS5UJNMLwFRQECXa0rpD0JNXVX//4v5k6Z1hiOcZMAYmYIxbEuHMMcCWLop16iAMg0Zvk8pPrbBVnNQma4XYe+jSRMIBXkCw3/jHe6ChqPyc879tnGglkGQugxRr8dDfyhwiK9UZoB9/xFXRxnwJwQd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727888; c=relaxed/simple;
	bh=y53djnXZffFQbui/nFPDit97NcI8aKLCR1UhxjfHPVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DITVriEckTjHXSPhcQtBkKeSsQZQCvwlwpS6k6ij16IcblpSmYyA491Eil7FyV/dEUVUEnOh0hpeiCOvbk5VWe8lDWFN+1cs9SC4YzKNf6fKewNf4wwdyniLKOKpWS+cfN9djxENL4N/rnhLsJ6Fc7VmbJtA0QlyyRj0gHiSdFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVNr87aO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718e6299191so2525420b3a.2;
        Mon, 30 Sep 2024 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727887; x=1728332687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz4jzOMWaom/iCmcOWzqiV9C3pSZMLIQYWl395YO/Xo=;
        b=SVNr87aOxZeqpyxtx7zVYmHHNNy1Nq7gI/Fwm61+qVNpOpL1+3yJL3GnJa6D0MX+R0
         TWEXehTKBwsMUYWiFDUOpg0mAri1WokjGUI7CvOW9GR6H4BqB9GOoZm2/arwFfAsduvR
         1ofs+mO9091aG2yEi6gUe/hRJa1YkIZDKjS3bc9Z8gEIBluojT8iarCrB2qMxTuaxQ2v
         5FNkEk9bvO5LeRWuaqhVccuovaHziKWG2NemsKxucDz6a8m5DtX+jhUk5JUt3skmWpWj
         Uz2ORwaCWPW3CgleBycO1jT3lzlx/b5V2nAaE7u8rnPNx2s9YeHByL6fymgNshYuCvt7
         4lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727887; x=1728332687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oz4jzOMWaom/iCmcOWzqiV9C3pSZMLIQYWl395YO/Xo=;
        b=E49qbT8gvszfYonVX2479kOaDtXR0Od3qQ4Dpfkhtf2aL0AZTqAojPdwxCzEzeP1oQ
         shlyx52H1xXiLwIL4t/Q86+n+QZ+lPxQEZEbU7rVioUSYhIQpDuOUfenpvUQk3p0S53s
         cO6Yyku4qdG9w4H3FO/aMSOXfvb+r/bKgriuPdW+F671UYd2OIJJbnO6Do1RtOn9h6SA
         t45vEczXSZi7LvF9zhoN99MPDHw9SjVvT8G0TbJarQJitD5x2gSENrkhgUnVroFTcsls
         AhL0EqypnHN0qZlu6VRriF7lMKWpGsurR/t+nPgcDPk5EO37FgzWIeopewXc8IUMSrDV
         EjzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnpVF/IsYHYOEINIdvd+ODYVELq+sYiJzMWRQ69Rn0O6H9cjLNC3mgZhPzrs2aFLR0snKZcW/7RfXbpCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzinS3yNS5ZHvXgMp/5MO6GOsrpuFhbIh64Q5cL3NzALvnIFLv9
	pH7tp7YJOBNr35RdxHYywi8bv8gCEpeNLQP9kEtjIGzGts5txXb2xua3losu
X-Google-Smtp-Source: AGHT+IGrIrA/eQrujStQXqywOx4ORbtc2YOCSnNbno/NY5h+8n0ULbhFqeZiMS1LVsfstXxG3/N2Kg==
X-Received: by 2002:a05:6a00:2e87:b0:714:28eb:ff5d with SMTP id d2e1a72fcca58-71b25f40b29mr20809092b3a.8.1727727886807;
        Mon, 30 Sep 2024 13:24:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:46 -0700 (PDT)
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
Subject: [PATCH net-next 8/9] net: lantiq_etop: use module_platform_driver_probe
Date: Mon, 30 Sep 2024 13:24:33 -0700
Message-ID: <20240930202434.296960-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
References: <20240930202434.296960-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The explicit init and exit functions don't do anything special. Just use
the macro.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 0cb5d536f351..4d8534092667 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -686,24 +686,7 @@ static struct platform_driver ltq_mii_driver = {
 	},
 };
 
-static int __init
-init_ltq_etop(void)
-{
-	int ret = platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
-
-	if (ret)
-		pr_err("ltq_etop: Error registering platform driver!");
-	return ret;
-}
-
-static void __exit
-exit_ltq_etop(void)
-{
-	platform_driver_unregister(&ltq_mii_driver);
-}
-
-module_init(init_ltq_etop);
-module_exit(exit_ltq_etop);
+module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
 MODULE_DESCRIPTION("Lantiq SoC ETOP");
-- 
2.46.2


