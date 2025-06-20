Return-Path: <netdev+bounces-199778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6C1AE1C5F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009634A0883
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7C28B4FB;
	Fri, 20 Jun 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNmsdmcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458D28DB4C;
	Fri, 20 Jun 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426924; cv=none; b=Y3pPtFzQlqXGomPd7/lhJsUee1T5qH730c3azY8v2ktznep+CtN2gm7SrHI0JqTtLhM7dATf8BevwL3X3AL+9gsvvvjmY+UeIC2U+1WWL4dmiLxZyNmZ4uIpD8EbWOeKxxb/VhNculIjZtlydWHe2UCUEpiEzfln/nMXyMbNBJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426924; c=relaxed/simple;
	bh=cKeD8MJ11uQjEVwv2q6OaS91Wmxgb2CLaPxh4I+NOBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2AfXRcLaHFfKKSZH1uEXYcGrxGsIwxOqUEEdsKsJd+DvFmTDk7CzT1fGE+6feoUUumUeTj5PTrbqkIfvLh6vbwcDpjicTcZHVGopUeiTTzaAAreqYbSTLLNuSJ7BOd/MFZjKbHstsSIaEv4+i02QhHx/kSSB7vioIs45GEw/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNmsdmcd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2353a2bc210so16368675ad.2;
        Fri, 20 Jun 2025 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426920; x=1751031720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE9bQHddXM1L6vafWPqB8LgPsA3C5qgIW5OXgUaknnM=;
        b=nNmsdmcdCf4nP3Rf1XejKQq9DzuarSE+1zDiB5CMN6jhSUF0ugBmCXqPekAHGGxaCn
         YxKFrmPNgUAv15O+jZbWJ4WI26dIhtwCKbhaXVyqZOYLLV0oK3AlRt1dK8K5cZ98tzS1
         1PzjQx5Xrm7Su2T9qkzn0NDqOOc1a1ocbylmrIWWF36Zzi3XpEFsQrv9B0quLz/aphP/
         6DcS9f007wNzUhgk/uaPecGlQMS3ebxHwvyUeMVlrMBAijnPWeF27nCbVeRapm7Z+YcV
         0BeAYqzm+VDeRQvznyvDKlAW7dgATqVT6I6mVIMwc/FJiJeI9miYLJgGz6bcpw931JuV
         Rn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426920; x=1751031720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE9bQHddXM1L6vafWPqB8LgPsA3C5qgIW5OXgUaknnM=;
        b=ZYlDTfmSoACH/W4y2M44noZBQuq1RidG0Sd04286f7gQR1dJklyaWZq2SmpKjS9EMe
         bVVDhlEzp5UyeCU6sFvm9SngXv+TM+TVtdTX4GmObljVmNFX+QhwQXIZTv7Kbmb1OfBm
         ye7uevBclQl1pGfQAdEzTlt+mAEjX05Xj3L9iFQ4mLCszb4OTMbCROKPhrCu5rwMHjcJ
         gS9XTFZK1X93TEF2Xbjldv6OOrRKOoFNGot+hqYWTif/qbkWcfHeJs3+zPRcTEnb3+Ag
         XALiXOONTKpmoZqiSunRf0yiIT07Itt4o9vHWKUhft2kXH6rp9iRLb/NYn9wsU+A12tW
         woWg==
X-Forwarded-Encrypted: i=1; AJvYcCUN0ZSgbqSJaJKy2Flgwe0xh+m5xI34FoYL121UEnS4RQXKItCW2XS/lZc67qtEptFisd8mo+xw@vger.kernel.org, AJvYcCUqYQAbWnbyBso5it4PPb9qVcekIZLiVoLGyH6LpoFos7V4eauqBZjptNdRHZEAZAohKN9faNNYwXNX@vger.kernel.org, AJvYcCVG1b4zGuoY8Hgwn9CuYn0UbLP8W0q8Ob7B/46zdhW7XkeJm3FzQGyWSLfcuAEo/CBDqpmzHTD80Rto6rNO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02QJu7FoONIwPt9WeCOy2pNWC/VCCBbnoyBCuEJ8UJPv/sIeF
	Edy5iA4Ypg5KisiMptg86aENMBOW+V92hoyRWL75j3lCwRZ4bbJnfZwH
X-Gm-Gg: ASbGncsbc0T/zCMxD/Jrdbs4gMB24kuWVL23r9LQMf2JSo3zJrZUsTVFJOPTqBkpdOb
	pwJ+Jlmjga3GMzFJAnr1/gBU2VccRjirvL30hn8Y4mp6cZ6czfQiukGS+qVeE15KW5FYapH2KDj
	/hJNX3iBxOGICSX/PWCbQzijeIS4leN28CzKn3ry4QcP8VsFf/YyplVWDprK25+wc98IHfb64uB
	dSons7lTGMdqfoHA6Ah4rIEOixZgqx3cGIgoXKjD1atAHM13F3je+ZPkKIzvV6HwcARy3cv/Jk9
	/ifGRRuh9XJq1yh6vZn2ZqAU3XwAoi2jSkI0sLPt4YfgD8kfAhTlyF/wn/QPFacL+CpLWzfYO6u
	3fDmyRsrR57aJLnM=
X-Google-Smtp-Source: AGHT+IE1nsULJpWgm02bIhhOQ0wFOwAxlY7BAaPrFj0l5NnELEdC2caeS/Mhi44XQtbjxwP25bzu2Q==
X-Received: by 2002:a17:902:ec8c:b0:234:a139:1203 with SMTP id d9443c01a7336-237d9960355mr48220785ad.32.1750426919613;
        Fri, 20 Jun 2025 06:41:59 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861047fsm18885505ad.134.2025.06.20.06.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:41:59 -0700 (PDT)
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
Subject: [RFC PATCH net-next 1/6] net: dsa: b53: Add phy_enable(), phy_disable() methods
Date: Fri, 20 Jun 2025 06:41:16 -0700
Message-ID: <20250620134132.5195-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620134132.5195-1-kylehendrydev@gmail.com>
References: <20250620134132.5195-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add phy enable/disable to b53 ops to be called when
enabling/disabling ports.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 6 ++++++
 drivers/net/dsa/b53/b53_priv.h   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 46978757c972..77acc7b8abfb 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -689,6 +689,9 @@ int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 
 	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 
+	if (dev->ops->phy_enable)
+		dev->ops->phy_enable(dev, port);
+
 	if (dev->ops->irq_enable)
 		ret = dev->ops->irq_enable(dev, port);
 	if (ret)
@@ -727,6 +730,9 @@ void b53_disable_port(struct dsa_switch *ds, int port)
 	reg |= PORT_CTRL_RX_DISABLE | PORT_CTRL_TX_DISABLE;
 	b53_write8(dev, B53_CTRL_PAGE, B53_PORT_CTRL(port), reg);
 
+	if (dev->ops->phy_disable)
+		dev->ops->phy_disable(dev, port);
+
 	if (dev->ops->irq_disable)
 		dev->ops->irq_disable(dev, port);
 }
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index b1b9e8882ba4..f1124f5e50da 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -45,6 +45,8 @@ struct b53_io_ops {
 	int (*phy_write16)(struct b53_device *dev, int addr, int reg, u16 value);
 	int (*irq_enable)(struct b53_device *dev, int port);
 	void (*irq_disable)(struct b53_device *dev, int port);
+	void (*phy_enable)(struct b53_device *dev, int port);
+	void (*phy_disable)(struct b53_device *dev, int port);
 	void (*phylink_get_caps)(struct b53_device *dev, int port,
 				 struct phylink_config *config);
 	struct phylink_pcs *(*phylink_mac_select_pcs)(struct b53_device *dev,
-- 
2.43.0


