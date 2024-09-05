Return-Path: <netdev+bounces-125670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E377596E37A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DA01C2457B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797871A255F;
	Thu,  5 Sep 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpBqYwjC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737D193434;
	Thu,  5 Sep 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565785; cv=none; b=SxxM9WYvlDTa7AqVXIH0zJSxvGEgsv+5Nr8Q08ooqnPYcgrZU0juFRTV+ofd+qGqCfqLGKm1qenW+k4Ka7wuRcEWgoUsLL0PxFHjU0simeL/kls9rYoVt1FycPJWgHTdmaGH+/OLCl6Fg8T4srdvnp/Ko0NSIqyv4ykddmx44Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565785; c=relaxed/simple;
	bh=2e+zqLJChzoEk17K7RQCNuO6avikar5qyyl/r+8hbIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EK/eilEy/KxyN/zMUuaFzmUYWkN6FmGr/GAn/JHrWqskw9O6rHuyGmq+dmi8ZCUETav6GyvRNjSV5m0H5JQJYLPEQCjYTElZQkrtDVNu9hwHdTG9x0n8RPJ4ZRzgMYxA2WbNoCct9iJhhUSWjx2cFQfOFwplsKm6rboJhu3acNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpBqYwjC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-715cc93694fso1080190b3a.2;
        Thu, 05 Sep 2024 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565783; x=1726170583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDORespKQdD6y18i2/lwUAe4YrBswe868gOWj16POCs=;
        b=IpBqYwjCQWqLfcLS0SfNT/p2v8qKnE4o42szUlDaoYAucKI4R1l5kO2lxMcS/tTQwn
         5w/hpK4U+N7cgMxDbvSoDuuGaby6/HK+BrTbsA9Jq1c6jmLpPqnP9Thq9vXtF1IAjaxF
         GAi8F0iecU7aiEd5kur/NtkAYK7d7b58/tS2P0S3gmvFhBkrgRjToQY14/36FrTZawEt
         RKN2wa9bcnmR93v+62MufTStAZMDc67MPGgmhbcLrLKcXGMEvT+oyMwU4BZbmypW84Pj
         0LvhmZspfVw92NlT0jUpf0Y9P5wglKPvjOG2w98RteIW4/NUwV0l1BB5UR7Dq6DclLGR
         JE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565783; x=1726170583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDORespKQdD6y18i2/lwUAe4YrBswe868gOWj16POCs=;
        b=heBwjeHATjBR5cEAJtJ63ZmoJWHB4kp2GZURinEEkuy8Ddt8HlyUUyj0gvpgoEsfdt
         9f8nQ21smR4CBo0wfjdMH/PtMei86HY3YRwXs6llzIjNPwfM16B/dZrVgTouSj356j+a
         AY2BalZ8+sahg4jQn+BWSKNE2K08ygrZzZNRl5SI8SlKjdTOp2Z3Ll/YS71QwWXjSS8T
         mikdPf9eQcjG0RaEEe6p6Ow6kr2voxPD47Yqm2kG6E9foCYH/1FMiz80Q/OoIiHLA4pS
         18DK3yLLWs6yGMexiQgGppaVo5hbQdDHFKBZaCS+pHNDxT7PFcC9l0CYog2+EHDaXqJG
         KBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9L6FhDPoD+KdUvGCg0Lpylm8R5An7ShhmD4AkJpmqjNZuhUXNVJZBbjzquwr8dm23SZ81Fm7Zh5ZTcpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBaRXMQC96b/568OAzjP/5PvsZ1HqmY5ZqRlCh/rH6t27MEvO8
	t5N8WRwvznlkQcwbFo8SXvzV2H4xAP9zyfkDTxZbrP1nEnZFZ5yJtC+jUgkp
X-Google-Smtp-Source: AGHT+IHWfs0ZKT4XrRqI/6tXkYn2zDzLsooHJtJMUNXqmuBZpj15Uw7z4zm1C2OyFVp6rEuQNQIBrw==
X-Received: by 2002:a05:6a00:1a89:b0:714:157a:bfc7 with SMTP id d2e1a72fcca58-718d5e53d08mr284848b3a.15.1725565783055;
        Thu, 05 Sep 2024 12:49:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1248410b3a.182.2024.09.05.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:49:42 -0700 (PDT)
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
Subject: [PATCHv2 net-next 2/7] net: ag71xx: add MODULE_DESCRIPTION
Date: Thu,  5 Sep 2024 12:49:33 -0700
Message-ID: <20240905194938.8453-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905194938.8453-1-rosenp@gmail.com>
References: <20240905194938.8453-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that COMPILE_TEST is enabled, it gets flagged when building with
allmodconfig W=1 builds. Text taken from the beginning of the file.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index db2a8ade6205..e7da70f14f06 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -2033,4 +2033,5 @@ static struct platform_driver ag71xx_driver = {
 };
 
 module_platform_driver(ag71xx_driver);
+MODULE_DESCRIPTION("Atheros AR71xx built-in ethernet mac driver");
 MODULE_LICENSE("GPL v2");
-- 
2.46.0


