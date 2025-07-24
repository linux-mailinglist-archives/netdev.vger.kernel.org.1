Return-Path: <netdev+bounces-209598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93518B0FF47
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632AD3B8671
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CC1FBCA7;
	Thu, 24 Jul 2025 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByRWyn4n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926421F7098;
	Thu, 24 Jul 2025 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329202; cv=none; b=uvn/Zpc3xoaTzeInBCKoPpyHDBrJRwWEr2dJu8vbuy3Il/XWxXX+NfsMUq7U0a1fSgUcBwRvVxUMeNgoI6akZjprSBzsZAPHdkzsDrMFTNTjVyPAmJDRMkZcgVPugVEkHC2T6W6e7bQ0lV4RInKqMsKmHSvHJim8ddOJC/wtkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329202; c=relaxed/simple;
	bh=nR2e3cke1oft70XT5XEjRqZiWHmttAzoGzJ2L3sHmGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqqMSnjEL9T2lxn2TQqIREke8GvAZz6bTvJ92lLIRUBwppXczzFbm2m/zPIff8mRkOtMiFc1fMnjwdAtSaNRdK+TuuJr6/otU2CJ1dbRX4kd8dxSdJBYltRHtqBbuK1bu/8vTP2c4hLwaR/qwE7ajCmxJJIWMHqjXS04GV9dwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByRWyn4n; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23f8bcce78dso5282775ad.3;
        Wed, 23 Jul 2025 20:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329201; x=1753934001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPzBqQ4anogS523DIc8alx1GLkEr++4UonHbZ6se8GQ=;
        b=ByRWyn4nHVvmgUV1tuNkRktTKb+dm04Dzw0qP9IUGX4kLJea6zS72hu9roB8hkeBHi
         ObEf/iEA1ICRaXb0IjJbb5yYJdoAlsjTDta3hyvT3rVk+Ka37WZPAfH9rb4S3wfjLx4n
         tw5puAQrq0gO65AAc4TFNMuZBdSmFFZDlodw46YBprcZ1cIKq6Pj4d1XtnTHRGvzAB64
         uI0nh3b86sHQqbUZN76XoUTm/pVTQyYO8U5kPZxCA01hcip+MTlQb4je/dUjotgzHbse
         AFF86BXEnIGiHjDDl66vW5raYuPo+y6+aw2/T75duW4kAzqMaYTcVSYNIs0hDUeDpsuQ
         571Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329201; x=1753934001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPzBqQ4anogS523DIc8alx1GLkEr++4UonHbZ6se8GQ=;
        b=uRiK6ETYQWtrh015sTd+WsjafSMJSKRbkdJtoX2eiAzn5QAgZtq7+XwcYY+T/zynb+
         6MW9UUopwPuIe59UqkalYxjlBPjwCCicy4IT9rF5/D3fB6yQnWzvit8KR6krOJby2ZYv
         ONgIDLdoSooPVIOQwsurNQZh6Dlf2pk7U0smSEYqX00wEEel2zDZAQG4zoyJ8mV47yH7
         epXaikpKKQkvdcpExk86/GUi6sN89UA/IWZHa5gFpiV7Vb41nZGf/B17CKlmNavVSv/I
         V46denZ19soLx8K8eGwLt0DLmXSctPJpY5Tti0wZfKmcWPN4Xepgw7qQsQ8yY4XRB5OG
         eaAw==
X-Forwarded-Encrypted: i=1; AJvYcCUIgWaozGGogeXIa8QyLkU8VvBtMlk8jZCfKg/EOnnLH/rXDsBuRqcMnaNzklPqRvZeVECCJqxT@vger.kernel.org, AJvYcCWuMwqMvKKwKfduhGdAEXR0lo23fyfBEKMwqJPA6O1pv4tM9xeztf6GPE1ucdzg0nUU2h8hCrz3zHOD@vger.kernel.org, AJvYcCXKDGgec1rBRv5uRwEy0dfPzYhh9VDZKbZYY9z3rx9j8s48yuH72MB2KUXXJWrFY5yvQjWT+3MqGq6pKmX/@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7kGsqXXpv0ipv8iB0D2dGz8+YKa9HgSkCyt5c4o3QG7Eufor
	iGxlg+Nm3L3Y4t0gDq/rU69YkN+WAR1gFszpHMZnCC2GK/YQc+eIpScZfTiOpQ==
X-Gm-Gg: ASbGncvaS91wgPOMp5VQPwnom+PdcwCgnSPTN3D8b40EvOlQn+xwPnjNMGUUeZj77Pf
	PigXIkqVYicgMnz8swJh9LVS5iXnrsdbpQiV5twaNCl0iSCadtCq7UPn1TZqk2kfbwh6rmCm7T6
	q5mSZBKuT//6tOHCyT1BGBrYlk7qVQeiIBGNyM32Lu7+qlT5r/JQPj+Yze7l7yjdlQMbQAuC8gV
	sNYKCosFcbfiZ0jhPLC/gfj+UNc1H76fK5TsOx+MIpzImH+28ViKpNW9pJu9Xhm/tDen+Jvkmxd
	XW0Nd3d88phnPTh2L298dda2DBkeVIzeiB8Gh7AYKDNaw15H8UkHp0HUez+ncLLFcDQ5RaI05bH
	T5CeOT241CCXM1z3hUMZucrm/EuZVef81GM5qXkpC
X-Google-Smtp-Source: AGHT+IF7/fO+Oeg/2Bn6jqGDofrgWYgsbEQ8EY5QQBfh4wZNAU3uQiVgQ8o1+Ctwlwo9uO2HpdKgbg==
X-Received: by 2002:a17:903:2bcc:b0:23c:7c59:c74e with SMTP id d9443c01a7336-23f980775d4mr74813465ad.0.1753329200894;
        Wed, 23 Jul 2025 20:53:20 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f883sm4458625ad.13.2025.07.23.20.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:53:20 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/7] dt-bindings: net: dsa: b53: Document brcm,gpio-ctrl property
Date: Wed, 23 Jul 2025 20:52:41 -0700
Message-ID: <20250724035300.20497-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724035300.20497-1-kylehendrydev@gmail.com>
References: <20250724035300.20497-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for bcm63xx gpio-ctrl phandle which allows
access to registers that control phy functionality.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
index d6c957a33b48..fbab3a1a8d3e 100644
--- a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
@@ -66,6 +66,12 @@ properties:
               - brcm,bcm63268-switch
           - const: brcm,bcm63xx-switch
 
+  brcm,gpio-ctrl:
+    description:
+      A phandle to the syscon node of the bcm63xx gpio controller
+      which contains phy control registers
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
   - reg
-- 
2.43.0


