Return-Path: <netdev+bounces-130538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA9898ABEA
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4790E281AF5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E18199FC5;
	Mon, 30 Sep 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4BocECq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6341990D1;
	Mon, 30 Sep 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720309; cv=none; b=KlAdEhKI6PuttJ1fRGyef03MiWQx5mfeSc/pz5gthKhxCQfMLELexiGZIRaXy8FjPozzAj9bM3yLJA0TmYHXbW5SE528GQndy4MVExDjbIntrPXLlI5eBgQMC9JkAQtosY9TioBBOu0bbHpKkkUDzILCj9095NSm6xu69vSzU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720309; c=relaxed/simple;
	bh=+5DCAmNofiqQxSfTPouF2/P46xP4+6bAFIJeMZcjia8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ES/rVgst/MBnANm22R23cAN2eatMlR54finiNxLoxWbChtk47sQycHS4mX8OOIjSSQxPCAWlmbMegrcx8GrEkM8k04VUA7vWOqRQ7PqUV40ln7ius9Islr2WpJulFDZCXH3pFmmfizRuGGwGka6huT3ooZ19dFQVI5hKZRSfD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4BocECq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b84bfbdfcso8764015ad.0;
        Mon, 30 Sep 2024 11:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727720307; x=1728325107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c92ixIRY2KWnqqRQ0uFbE36joymNkXozEPE3FiZECyc=;
        b=g4BocECqtxnnzYZtVjU53HKsUT6qno3JJllpp9E76S7YBLj9zShIaYUzlc+isq3q9x
         92Yr74uZQhgg90lPU184HkLPQqu14ieBsLKaC3uE6bZLT9zIXPfS3VugVNz38PWRKdiC
         BtBgnX2vGzCxYOUYTqM3wjpWZSe1t0Wv+qu+2eaV0VfOsjtMnNZVLYhOse0RXUPJTMAf
         CoEYRnU6gbnDAeyzf90oyZtiPYEZCnK3Kyu8EG7c5jX3wnDNDKSvoOZ2mzfKumAu7gRX
         N0d3tt7gjtvTbtG02RLlogEdY1+vEK+MPWtUJgo/ONUjRmpJiO0zmHhnWH2q2+s6CsHX
         Hn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720307; x=1728325107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c92ixIRY2KWnqqRQ0uFbE36joymNkXozEPE3FiZECyc=;
        b=tgqwkaoGPylXSfpM9py2epkfeHD/rhIvyH+AZbB7cSsqeJKFptlWNQ6a5nEHTQ0yrK
         TGmE9uMwj37vnPKUfT31Ip4B/uUUH3bQLZUDEzoRrpHy9JJMPDQcLJ12+TeWn34gAmCf
         u83Rvq7JY8GjKNOBw5GQ9OITrQNTMBwOF9DZZCbspL6nYYYYFGIO8GthoEwj0z+Wjv+C
         z43Hrtb+YDP01uvkiI2c6Jg2ohFNNQycG86GoC5OkQs64F+pM0N/wGoZOMWz0lfRjXcz
         MjzW1xQFSv9cU45wjv9pkTaps9HhHxSSOledYVxD8Wx0UDr/qZN4Usi//RfL3tkVVbpF
         Dt+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzUlr0JAa1UFs2Agjs7fNWcKCyKMjqo0QMlDv39ConUCbMukNwe3KA6HfsdXtjxMnGNS+YyFBW7QIT7WM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vcbmNuZ/rYbJjnjO9UtdNV4mRAaOlaO6TOov8nO9VSdxw8W4
	LUmzi1aNpQcX0uOmEL5LbuENZxazu3xNkDZASbt4YzncilAnS30UO8ttNJs+
X-Google-Smtp-Source: AGHT+IGVz6KimAeENwWbsdFMBCHcSSj5y2auLCcU6IKBtDcSW9Bdzx3AyNecMdnUQ6RpH/8zBLTRrA==
X-Received: by 2002:a17:903:1105:b0:20b:5aeb:9b8 with SMTP id d9443c01a7336-20ba9f061e2mr8160785ad.24.1727720307429;
        Mon, 30 Sep 2024 11:18:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37db029csm57444365ad.106.2024.09.30.11.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:18:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 1/5] net: ag71xx: use devm_ioremap_resource
Date: Mon, 30 Sep 2024 11:18:19 -0700
Message-ID: <20240930181823.288892-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930181823.288892-1-rosenp@gmail.com>
References: <20240930181823.288892-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can just use res directly.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 9586b6894f7e..9c85450ce859 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1841,9 +1841,9 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return PTR_ERR(ag->mac_reset);
 	}
 
-	ag->mac_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!ag->mac_base)
-		return -ENOMEM;
+	ag->mac_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ag->mac_base))
+		return PTR_ERR(ag->mac_base);
 
 	/* ensure that HW is in manual polling mode before interrupts are
 	 * activated. Otherwise ag71xx_interrupt might call napi_schedule
-- 
2.46.2


