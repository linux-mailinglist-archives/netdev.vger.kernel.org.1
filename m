Return-Path: <netdev+bounces-153348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D8B9F7B68
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8758C188D101
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DFD22577B;
	Thu, 19 Dec 2024 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="qBLcYn1r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322BE22757A
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611498; cv=none; b=cuNrUsFb0nGvITrwkbk4t/wuP7NugmwNwBef/jWg8TxXZBBIn9wPgIFQLng9rlrwegmgPuv5+PqTeorRnozhvSI7fMgyV1/L1cVeV2Syn8ytWZOlakrMfyFaJy6rsUiBqQQCBQ1k58mHn7aIn8gxySfsNClSMpKs2eiIU/rHQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611498; c=relaxed/simple;
	bh=eG/KWNgmsoX96wx43T0aE6wr0gUHnDtXlepdD8zP+Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZU2JkPUxuhAhCUhSAVUPWCTlYZ181GcHTkyC5EsED4/AOz/d4T/xfm0oHHbxu2zuE6dTuD8jQtWytPKA+C1wX9WKY0eewnIQfs4IJlk9y5ycJOHrk0AAEFIzSon62M8a7+dnYLFVLDmYlyJ2XMiH/ibKbpAHcggyFnYLpVN+w60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=qBLcYn1r; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53f22fd6832so656889e87.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 04:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1734611494; x=1735216294; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T9ewfodQmWnYrWnDlQ1tRoBvOOanfWQbaFltm/ARv+c=;
        b=qBLcYn1ragVrSBJkydWwfOxE3F2ODpmh+pFIhFyiUiuvI2fkm633/j8Tit6AZaUBpU
         lhrP+6momFCVGJY7v1dnoyRX89mvIyhA2cHLewmACfbpebHR3rzRpBel4a5y60kWJhFC
         z8he41qLJPcRY6UBRdfH2GGL/19bQEGGadOg2PGoa0NFyHlKhStVK3VJveZ4ltaRB5+o
         /T52xMOw05bUD5Ky82N40SlFdF5oBlyWiI6aXtVbN2doethOE5gUTyKeq3YiWvjK7xFE
         zOa+x3/DjEQ1ahSdaNQnNP+tlS7sqwGcPTqUPNekdLH2LjVspOLdywBZ7GbzLu4ozP6o
         Psvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611494; x=1735216294;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9ewfodQmWnYrWnDlQ1tRoBvOOanfWQbaFltm/ARv+c=;
        b=g1JomSnKLmF+n1U8dTHWQDQ4yStTbmcDjrCWDGzpZoqeAamkVAsm/DL3/AT//iCQSD
         eQFnK6Xs+395s8DCG08bcn3LXaRsbbWPEyu5dk1JHsmF44dEo0N5xOk1ZLbKocqMUqf2
         1zHDa7JRVVJxSqVFVdQQrk+WISx+HNSe46LsHZzhlD6jtyU5HVrEi90diyj4wmUGnTB+
         Gfi8/HGgo5L7fGya495jdxKLv0U9iTFnqn8MWUQ06EYeMuKEoVY+M/ym7s/GowozMDWu
         tdGlAMgNLDuz004wbE7GgrF3sW3nqwxawIeMnkBt1dLbvAZ5j3qA4kg2QZ/4hf2ZtCzB
         eXpw==
X-Forwarded-Encrypted: i=1; AJvYcCU49AarZ2r77QcUbDCQKlWMc05OiGJ1yOSSD7uVmxRfO5EG86P1uhW30hJKStCJFVZl5l3T6vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg36HTZdA4N8Nf7R2YvWaJbVQl3EGB7vCVHU43ZW3MGx2E5Z7r
	NPk+eOR0EBR+fj4dYymK9l8kILggqYqg6eqle+Vdbig7ZrWdf/NgWZG1CExEj6o=
X-Gm-Gg: ASbGncvzLvBdjPhFj9T0Y8FG4AvTeeNsh5B9QnFEoqm6tCRNmUul5oCq/oeKsLvICrp
	PY4BAsiENwOfZ/m50br603YCbyiC8qeE5YL4ZMqXN8UfPN6iU5tArT0CoIz48liAooUGpH9j8QR
	okBRbJhvsi/sKuLXX1z14coCmuRcs2t7TuDDXbuBXfBIXAGNZwpHOFno7mLEeTT/EBeE7Bw4PAa
	WUg6Sku0FDhaxhG/xiYlIcnE/2YvPOhIJugbmvHBF8Yrc3HLprIZwuiC3L2+W+7rh9lbiRpqgiA
	i7EdjzWaJEbl6ZI87TQx/9LT
X-Google-Smtp-Source: AGHT+IEtt+caURBdLa9qm0DKCE0IhUhc8vtL5ravQ0ZXkEKN6ZWAAmoa/M9QHQhtH3GExu8YdQJAQA==
X-Received: by 2002:a05:6512:3e07:b0:540:3561:962b with SMTP id 2adb3069b0e04-541ed8e4c74mr2238843e87.15.1734611494244;
        Thu, 19 Dec 2024 04:31:34 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223b28722sm145975e87.243.2024.12.19.04.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 04:31:32 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz,
	pabeni@redhat.com
Subject: [PATCH v2 net 2/4] net: dsa: mv88e6xxx: Give chips more time to activate their PPUs
Date: Thu, 19 Dec 2024 13:30:41 +0100
Message-ID: <20241219123106.730032-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219123106.730032-1-tobias@waldekranz.com>
References: <20241219123106.730032-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

In a daisy-chain of three 6393X devices, delays of up to 750ms are
sometimes observed before completion of PPU initialization (Global 1,
register 0, bit 15) is signaled. Therefore, allow chips more time
before giving up.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 46926b769460..c7683ea334a7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -92,7 +92,7 @@ int mv88e6xxx_write(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val)
 static int _mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 				u16 mask, u16 val, u16 *last)
 {
-	const unsigned long timeout = jiffies + msecs_to_jiffies(50);
+	const unsigned long timeout = jiffies + msecs_to_jiffies(2000);
 	u16 data;
 	int err;
 	int i;
-- 
2.43.0


