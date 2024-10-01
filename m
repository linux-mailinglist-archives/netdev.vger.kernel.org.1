Return-Path: <netdev+bounces-130991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD398C568
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272C928764C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3B1CF5E4;
	Tue,  1 Oct 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqpwcmN0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C71CF5CE;
	Tue,  1 Oct 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807373; cv=none; b=gz5e/tYAcu8OBcuV/xAHUDx7bXdChXcVBEcJJDt+muBuiMbWDYpCFaZ8vv9s2amlDOAWegfEuTCy9aLV3VrH8AiVdmRHb57W00O1RQTLabSp6YBTdBlytk4L4lHs2AchE35Tx6u7PgMfP7hJhaiZiE5TIj/YZaPgrjGRJh1B4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807373; c=relaxed/simple;
	bh=R7pMI3RlR/Q1QL96R7slexlvSamq12LC67dyRYJ+w0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxxicCy0aADCVcurysC0WZgLxktl811DpRueNKNoKU6RawiEYVsuNAAE3XXbG/1kSmmqsRSfQB9zll/g9eUmxHEUH5BIvwcjaL0Fjl9sePEe6f+1GaFFkDxaU/phQI/jEdWYpcx8gxMKoj/NigpnWjCniAPZvyTHNMvsJ0deqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqpwcmN0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-719ba0654f9so4969010b3a.3;
        Tue, 01 Oct 2024 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807370; x=1728412170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw8VwDOz5fOX4AAGu9NDF1NRWlAj+unYZmC2Pjfirnw=;
        b=HqpwcmN0ZP4pNZJ3uMUJefGtR9ORi1B3GzbGyVg1Wt4fKToln02ErhndgqgKUmG1QG
         juRWD8RuciLk50zA33/0Oxw+6usVQvUC+lYbPZFEVdOBSbXztddYV9UyXIDzZB6IWZjp
         OzAYV0p+TRVSmR7C7xD940N6VNbzAdmQu/Ejw7u8W/3oAnmh2cVyaXVachQM84KyDpND
         jOg1eBj+zPBemH3U+YbK+9YmiKA273hlvBCoiICkLwqisZsyrGtBEuWK4XOCYl7g+k67
         ZShhpA09KSJDB0uv9kXgBM/eARZ9nLxsQMAL9F+rhmcx2vc4wRevGeNsbeZeQAsoLvuA
         TeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807370; x=1728412170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw8VwDOz5fOX4AAGu9NDF1NRWlAj+unYZmC2Pjfirnw=;
        b=u/khBob631kB8uBlpkU7cTvTKEjHxErn1hknC1MpsW3QM9zPll0QyXinBfV10OZVM4
         mw+D659UwqbwEadIrvZoDKnjyNC2HQSBa/V5amEHmDPPUjuv9FV7sIugREu00iGnIX6V
         gK/idoA+DSbZ0KfoSxQw6llVbO42+NMGo9c3ygdvYyQ5Z6x2r9hsXz1DDJ+Y1/Mf/DKE
         jU//O5+GZkjNmcVxb5NmP9Kn/+agf8LeW/7+tQVilm/x3+sHroTDqzx1Rv8C7397vJmR
         P9IIZ3UWnKHYJojC3xi/GYqHUmO8s1FV+xuxePyuApasWDiXOyXq9afGfSPRRHZYutgn
         zkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSM7Od3Jsrjw9tk7sbSjEczlKJ1zGQUZIrsUBHzubq4h8lr/qEt7El/nOdgPPdjsHDL7CLyLJiUCqdVd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvB44t5A3ZdQzzDyrL0doa/ziKNYEcmy5VKlDHMKKjW/6Ol9VL
	QyxVC8Tdgpwyf1IVzFK81ra5HtCA3+iRuzqDFxJLs/ri9DsALW47hGmaG9fB
X-Google-Smtp-Source: AGHT+IG9I4dbXDNY9oRlsmnlCgX5xW4nOY/g+16GVSiYV6shXVFS2IczH6pnRmiYXt5yP3NJwt3cwA==
X-Received: by 2002:a05:6a21:e92:b0:1cc:da34:585e with SMTP id adf61e73a8af0-1d5e2dd9f6dmr801905637.46.1727807370485;
        Tue, 01 Oct 2024 11:29:30 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 9/9] net: smsc911x: move reset_gpio member down
Date: Tue,  1 Oct 2024 11:29:16 -0700
Message-ID: <20241001182916.122259-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001182916.122259-1-rosenp@gmail.com>
References: <20241001182916.122259-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not needed in struct. It seems to be unused actually.

Add error handling to avoid unused variable errors and to handle
-EPROBE_DEFER, if applicable.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 77a5b766751c..3b2388c1c939 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -131,9 +131,6 @@ struct smsc911x_data {
 
 	/* register access functions */
 	const struct smsc911x_ops *ops;
-
-	/* Reset GPIO */
-	struct gpio_desc *reset_gpiod;
 };
 
 /* Easy access to information */
@@ -369,14 +366,15 @@ smsc911x_rx_readfifo_shift(struct smsc911x_data *pdata, unsigned int *buf,
 static int smsc911x_request_resources(struct platform_device *pdev)
 {
 	static const char *const supplies[] = { "vdd33a", "vddvario" };
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct smsc911x_data *pdata = netdev_priv(ndev);
+	struct gpio_desc *reset_gpiod;
 	struct clk *clk;
 
 	/* Request optional RESET GPIO */
-	pdata->reset_gpiod = devm_gpiod_get_optional(&pdev->dev,
-						     "reset",
-						     GPIOD_OUT_LOW);
+	reset_gpiod =
+		devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpiod))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset_gpiod),
+				     "GPIO device not found");
 
 	/* Request clock */
 	clk = devm_clk_get_optional(&pdev->dev, NULL);
-- 
2.46.2


