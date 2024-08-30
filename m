Return-Path: <netdev+bounces-123712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA479663E6
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0EA2836F0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545C1B2EDF;
	Fri, 30 Aug 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjMzTeSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D031B29BE;
	Fri, 30 Aug 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027188; cv=none; b=NmLG8g2sPMTQ6A1RQKmc1YvhE7H+RfJVdgaW5GkYiuKbjzQhrIMUYhTAtNhbL0ykUyjOIETjiqNdlLnv0G614OYIEvH+mnlotYjsPQC6TXipxWjNb3ltmXaA2R5+xX3dVeSiE4saFaFDKWeRUYMclHHbt7vj3s2XYir6vd3jZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027188; c=relaxed/simple;
	bh=vNLImMnxZ5sxE2h4imNGm83IpOg8z40DUTl0oKme2Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgqaFEUK3UD0OUDSABafSHAnb8UG05qqqyiBk/GCiSw3Aagu6fUDHQs5S3t0Q8h23hmAX0T5JIn3h96y0IhOKs5ij9tO0982Fe5ULjd18wZ0sFB2fDB9q3drBcoyQ7jkRUF0nPPjjWyKeDQNfEwpkGhQePJ9Cowf6X4v8PbKah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjMzTeSa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so2161360a12.2;
        Fri, 30 Aug 2024 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725027185; x=1725631985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQRy4092oZ8MiCLO//SAf3ybAmf/GD54hTQVJH3atJk=;
        b=XjMzTeSaD+f8V2mcacya8MRkVFblMjsjdWjQoIcmMKRf2cxYFkKsi4BXQt6PLfqDVo
         o+Nn0fUNqlQ/dJjfsI9WSh8GWWo8+q1H6/mIOoSjZysG5XT4Wjq/IggRMBTDBOF5nXzl
         FswDrqOulZfh5cyU8VJXZmU7gQ8zgbETlDgMcEtQBpzXqnjUY6k6A0s+Tow0vQqbTvXx
         SedRhTY0Id5Wj03s3O/VawQv7PORq4NMmXuczIh9ygjhIbUmNIIA8cXV6BPuTDrLb/Gd
         beRY6+K9BGQS+CH01FgV56+uLPHByGz2LxSoalXoJB1hQvfmkeblb+dDf9Z3eRg67tAj
         C/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027185; x=1725631985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQRy4092oZ8MiCLO//SAf3ybAmf/GD54hTQVJH3atJk=;
        b=cwu1DWywAmrFZ/CCFWTkyhF749KXylpH01lYCGRkPdOdgkieZja1Prw8sICaRLkbc9
         +3g8rTp6rCSpF2wzdyhI1u21KdQ+cyfbt7B1pZHySmLS9omtYuzTzE2yNQIF7qq3STzR
         mKs3yqG3vWqeR4GWn/0Sfy7jfRvS4U/kwmRKIOdPO8EqA/iJT+cj38Oi9QH+iJgwsYru
         dPnirgxMbHcdEtEIeXg0Odc+x4oKshB7uc4j2Lf6rkkd3z53NlVPRDa2OjQ/CzXHkn3F
         lFITPxykcA/41QOItmWbw5M/B+svSecVubAVsoHEvUnAyYiTXJr0AwhBu/6a6qCC2PPB
         +GfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKACzLEQV7ZIxbPMIwIbWpFMQNvkadmaJydP3aw9QpfHt2t9nkCbmqQfo24r+ZIJUovXrPYiym9AfBONo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Wepqn7XGwYeoCIG6PCj9dkhCsNQBOA6ORoWYYo0jg8P6TjiR
	eSv2+APu1y1oQRVImVObDPU2R6PHnFUWLyNUFah9e6dQdm18cOc8
X-Google-Smtp-Source: AGHT+IEU5d45V4+bhlsOk29S923A4WYh3TpDx67P1RsbX1sduM2Zwr0K9EMaM2mhjZpQMbjvEUgbpA==
X-Received: by 2002:a17:907:980a:b0:a7a:b070:92cc with SMTP id a640c23a62f3a-a897fa638famr528178966b.45.1725027184718;
        Fri, 30 Aug 2024 07:13:04 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196975sm221304166b.135.2024.08.30.07.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:13:04 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arun.Ramadoss@microchip.com,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v2 2/3] net: dsa: microchip: clean up ksz8_reg definition macros
Date: Fri, 30 Aug 2024 16:12:42 +0200
Message-ID: <20240830141250.30425-3-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830141250.30425-1-vtpieter@gmail.com>
References: <20240830141250.30425-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Remove macros that are already defined at more appropriate places.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz8_reg.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index ff264d57594f..329688603a58 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -364,8 +364,6 @@
 #define REG_IND_DATA_1			0x77
 #define REG_IND_DATA_0			0x78
 
-#define REG_IND_DATA_PME_EEE_ACL	0xA0
-
 #define REG_INT_STATUS			0x7C
 #define REG_INT_ENABLE			0x7D
 
@@ -709,8 +707,6 @@
 #define KSZ8795_ID_LO			0x1550
 #define KSZ8863_ID_LO			0x1430
 
-#define KSZ8795_SW_ID			0x8795
-
 #define PHY_REG_LINK_MD			0x1D
 
 #define PHY_START_CABLE_DIAG		BIT(15)
-- 
2.43.0


