Return-Path: <netdev+bounces-148219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B657F9E0E03
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BBBAB2C8BB
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B421E0DBD;
	Mon,  2 Dec 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKJcJmDw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F21E0B75;
	Mon,  2 Dec 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174626; cv=none; b=ZbFLZEkRMBZx3/pz7Q2sJyF8kEOn+ksxIX4MWbyZr/u4NAOAVnrIzvdAA8Be3ePKXR3Gsy12iiOgO1Sdlktqt+hlKTkJ/9lFVAuv2EffTdsD/B1CMKEhLrqfKxANX9svhnjmIQdgYGsMEy7i25E9I/5tyPrWzcTXYQELR0hk2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174626; c=relaxed/simple;
	bh=Hg2YJCbKPvRfVlyXe4AKKc1T/lU4ZsS8zwKr1Q4Wu+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7xsVLeABe/ZKJ0KirDRDmv/i+q6VVAGZHOYeHkLpjGa8fHvttluM9zX2Q5WFi/C1/4xgOWci0x+w6hPeqQsR1BgfiYhyoeVsDu5ZgpiHkM8Ll9UvLX6T+qdSyLN/BRUxG+JJYdMM78qiRny45r7S9VHXWPrz+jFWSH0io08VvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKJcJmDw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21561af95c3so20134665ad.3;
        Mon, 02 Dec 2024 13:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174624; x=1733779424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnM6r/uVITTRqw7KKlw64GThaVylgqvEAeVcWJSdEdE=;
        b=YKJcJmDwVn4dg9K2p+hxY/AcPlnb3oxZv4ryQDLVIaMm6SLHKoc8vRv3SbT0nyPJbr
         4iCMpA7ZRRyjzjIC8iq9DABtX7A3aOiYXAAZVDcU3rFAxmBGhJ1EHvEu5EjH3faJoMvQ
         wyWa5QABm8AB1SRFZYNhgBmy2yCuISbk0wtzVKGDOxJk59dDh9vQGye2rzxS8i/na2rC
         vvUKnDJYpIMeW2PDyiQgC7yNkfYkTGMNRtN5slqn48cTGdKuylfLdKsiXq90fyCZRlIk
         QQwOJLA2RL47lfK5pae58xU+8DdLCa58yWMOoou1xvo3B/UkBtglx0eEtV2tAhVPTMTa
         fXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174624; x=1733779424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnM6r/uVITTRqw7KKlw64GThaVylgqvEAeVcWJSdEdE=;
        b=PZVgP382VxKs8vWZLVp17/smh/+akEHEniusXgKMkNN0l+0EVCjIIpePQ1nMNtBfId
         dvjQ0vbp8Va586rrqFA2ZjTAc79DQ6h6NcVoY9Ln8yrJhXX4VN5cVxSyMD1KLlJhuDdz
         Xb8WSKhpbzSR9PrO+De4s46Z/ow0/ogbBxag1bgxlBYgPpBE83/VNQq3WBbNgq2mJNct
         whGWQuYtVQVoG7SWrjuoX2gWxWZDlRLMGzo+gNJ2oRNKGxdPeOKJfeFn4cHbsWfhgAJI
         r4ZKsYLTjQkXb8/mzGGM2SKo0Y9TU/YNMUnMA4soIpTnNzrgpnlY7q5ETad7klrTGjc2
         AW1A==
X-Forwarded-Encrypted: i=1; AJvYcCVxk+AKZ/evGpqxoYkF8eBjKkhzOGOmRl/ONJhhQ3aSrmVFiujTRKaxMX50P9gYqwsCJphkzMBFyPZ6Uuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRCQR6UG4rs7Puy+lwv4pWtTJMjM6kZBK6sFBoNE4wEvwMX2r
	0Opn4cU5z5ei+jzLeJOEFZoypkYYiNAsx5BHOG0uijaVvgxDbkKPzxEH/Fnq
X-Gm-Gg: ASbGncuuAKL95BALcrN+4vCB5VdnrUHBGtjKDBFBcC0xIZo0VWv4U4dcgP1IfYDJKGm
	IoHRfUp1Dz/3CvgoJquubG+sPYA52+7wfOg7OprnWbFLy0CABD83RgQIsh/cDRaS7p0WAQF9qEs
	Ll2ZFQmKZ54dgpjjeWxGTIgEgHitzBojMdaEJtl0X0e+VUa+bHCDgK0cngHjf4RgjvPAZu9rMkQ
	enusfdOwglhxZj0TkamRmysSg==
X-Google-Smtp-Source: AGHT+IHp5Bvo2l6KxjQOljcmZ82naHQkbnKwlj3SfCeCIggC8uoeNwkOMMZOgZHud27sBM+Kvcakyg==
X-Received: by 2002:a17:902:d489:b0:215:401b:9535 with SMTP id d9443c01a7336-215bd13edf3mr312885ad.47.1733174624038;
        Mon, 02 Dec 2024 13:23:44 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:43 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 08/11] net: gianfar: assign ofdev to priv struct
Date: Mon,  2 Dec 2024 13:23:28 -0800
Message-ID: <20241202212331.7238-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202212331.7238-1-rosenp@gmail.com>
References: <20241202212331.7238-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is done in probe but not of_init. This will be used for further
devm conversions.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 9ff756130ba8..4b023beaa0b1 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -687,6 +687,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	priv = netdev_priv(dev);
 	priv->ndev = dev;
+	priv->ofdev = ofdev;
+	priv->dev = &ofdev->dev;
 
 	priv->mode = mode;
 
-- 
2.47.0


