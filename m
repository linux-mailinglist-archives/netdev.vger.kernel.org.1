Return-Path: <netdev+bounces-130517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F4B98AB7F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DA6282ED1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605A4199953;
	Mon, 30 Sep 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtzQGRtN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E6199928;
	Mon, 30 Sep 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719246; cv=none; b=QGht9NHc4cvMWNIedU3RUzGmFqJudLvj+nNFZJjt9ulKXtCvIq7eprzUE8UHuI4MkmTi8e2F31lsXX4MjSwWceMzPx7n3PuNbWw9ln3R50xvNaZDgN/4ajeJD96qHE8QM3RZYEK1sFqKXqADAu+rAkiiOT1pjcHWcV7ztVyBhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719246; c=relaxed/simple;
	bh=kk6BZgx6e1aK6qkYUJ4gDXK7X1PwsJgqDQzdqq529+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhlAHkEYnnZKfrawHuif3vMfVpNB1ZQ9Ocqbym5RGnA/uSxqr9709qlXPBWu5HFmHywTTJQHWjwj2s3DfTouoHlayaHUl2Tpnf6WH5KqjPpzi15iiy1VU7Luvp+fvibct6cxtanfwmy7OxfG6QH/9qQ9TmdOqwDtyoDALrLdTyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtzQGRtN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718816be6cbso3988693b3a.1;
        Mon, 30 Sep 2024 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719244; x=1728324044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTdchS1usQhL1WtM0gjI76UYTIDbC6vW1SK3n+i286A=;
        b=OtzQGRtNt4wbPjP7AY+yTX+MArBHvrG57e9ldAkKxQBps/bBbKdyiQ2v11Wli0speg
         +oifxiSpSgnFVMMJccuccXfTO8NTzIwc1jvNO+Piccl93rQ8aVlmo3+MAM4XV1Uw69CI
         IL1jNTDB5OOZKmA9yI+1ZiTmDKQQ4dgeYzJ6GOJXZhq/SMr2G+Vbpy5HskGvNk478Ksj
         5HjTYi/mRSgyTFWPfKbQju9+JyssuiPNvjUbBLfxbnepY/loER6ZkcDHJ/vqZvy/P7e7
         q6st8BDNpWRyYnltwdibK9HshkZxeSIdDQcofBxqgE37WKCOAFhzJaW1RkXf2Yhn+LO2
         WjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719244; x=1728324044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTdchS1usQhL1WtM0gjI76UYTIDbC6vW1SK3n+i286A=;
        b=R3jII9r95rk6H3vjk0pl/4ZSneg71tbpjINFgavoC+bLJ+hyQJMfN2SlhjNFaFEEod
         DbHKnbnv73aIX7AC4BGc0XxmPrjQQU1BLN0ZVHYT1WPiGW8F4dWRRKNRsfcXteGQvfoq
         9uwTs15Eh2hM3UGqC35pUwscgMAnEMRB7HvGrrIcJaGTALBHfTT1bAedXyXl7r23h31i
         G/Pp/urGaytEI9fOxsbtxifSs+j4fgm6ZcPCXy6JzPWpeHgYbkAwf3py1W57qOEUTtU7
         vvqK+/0WZYxMTtb0uqGi21K4ZaKxfH+yGw3HRNyoxJrrWs9k7JuYea6D09oVoqRy+n72
         2YKg==
X-Forwarded-Encrypted: i=1; AJvYcCUEf9K0jj2YPw8ZuO6dkD7M2zX2NYWIxXzlvc3988SDorhDEp2muThgqGDvIIl4UfT/kHz4AVl13vrJJMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeYJlPsOGAHGZCRd/sjAh3Fbnc92fs9M9tYPQ4jXIFn9th9J2
	rwUilLY+rMw5wt3ohSIjqm23UR7u5bzu0uk9Ddcd576sPy78K8Z/R0Ypd1NE
X-Google-Smtp-Source: AGHT+IFPQCNNFERY9WYij2gd6TzTazHKoJBoHkAmq4dolUqRdFNjctkXTiSCaPsQNpuhiKsXvccuBQ==
X-Received: by 2002:a05:6a00:2e13:b0:717:9754:4ade with SMTP id d2e1a72fcca58-71b26057a2bmr20963419b3a.22.1727719243788;
        Mon, 30 Sep 2024 11:00:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 03/13] net: ibm: emac: use devm_platform_ioremap_resource
Date: Mon, 30 Sep 2024 11:00:26 -0700
Message-ID: <20240930180036.87598-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930180036.87598-1-rosenp@gmail.com>
References: <20240930180036.87598-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to have a struct resource. Gets rid of the TODO.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 97ae0b7ccb0d..205ba7aa02d4 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3050,12 +3050,10 @@ static int emac_probe(struct platform_device *ofdev)
 
 	ndev->irq = dev->emac_irq;
 
-	/* Map EMAC regs */
-	// TODO : platform_get_resource() and devm_ioremap_resource()
-	dev->emacp = devm_of_iomap(&ofdev->dev, np, 0, NULL);
-	if (!dev->emacp) {
+	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->emacp)) {
 		dev_err(&ofdev->dev, "can't map device registers");
-		err = -ENOMEM;
+		err = PTR_ERR(dev->emacp);
 		goto err_gone;
 	}
 
-- 
2.46.2


