Return-Path: <netdev+bounces-230584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A3EBEB75A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D23814EBEBB
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F88331A5B;
	Fri, 17 Oct 2025 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0YUY2eB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D23009E2
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731947; cv=none; b=IQ5yKtd0/tCkuNDlUcUKLh7aEiflewZXIl7/aVLw3HM5wrD8EdtcsXZAg73Ijn6HF88rSF8t5xIv+nC2TiuyhHIKJFhTzSXlJOGX+UuwRb6Q2UwEIhuBio+Q64PKo2ZR99YNTDUlcsP4aziN96V0fT9P1Bf2ZCtTm+HQNtZzbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731947; c=relaxed/simple;
	bh=7d8xA+Rb85QvktFR5r1RPpwcMEHV/NHrEtNUyIl35Oo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cN04q39LOfGjnV798zl0ppq4CTAQvNfCMNsNGRRQdj9gN1njYEoAAs9vspjtA3xRUI05y3yfO5y6biwR+fyhaXvMOgFOiEy8Cakfe5o6IwqDSC3/r+Vm9soFfZ4QTQ/mGnCbK7pRoupApdYMPsCq1V6VoaZqxe5Nlt3QB60F+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0YUY2eB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471076f819bso19325255e9.3
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731944; x=1761336744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wkopBqf8XYWQn7yIXs19Ca/y5CuHRi1wdlBHb18vbzs=;
        b=P0YUY2eBEgHNgEK3sbefDQ0UaYs/93A66t1tHchN3qVoT7GJj4zVRRxB3LHN1XqBbm
         LA7+UJCmlw4X7ZVBL7rFESn2SRIFe0mNvQXqpKu6x6Gs09X0cgTVJAO0VDtG0i/OqAbP
         nh9sV+pqFCKC8NPMy5KDjNBPJM52cIoOZjsQWhcR2DKQ0Q2q5+QrB2zlM7TssHOzFoS8
         wNB4GsNFgKb2Sr1BQ41qbGyJiLYAd6EluE8Fk2/dSelBFk6TLeKuUACi8fIfAbfFXOYp
         mAHDNNB5wnt6KnTd90VzhgVT2wGCOtiIkT7wO78LoSe3OgbN4AziwRVIblUpX/Um1jx1
         yorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731944; x=1761336744;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkopBqf8XYWQn7yIXs19Ca/y5CuHRi1wdlBHb18vbzs=;
        b=lKTpO6gVrkKYixvpnRsi196K7XkqrScUGXxMKdS6xmkU3cwg1v4EqgUF6h8lj2U0gY
         DkO4x0UppKYnZ4ouqHVV4U7vh1imuCOz51GQKAUZ9FDXxRiCO7jbuGdww8in5tWjt3OC
         P+nc9dklLBrcA7Ng6i/QMlvG8SvRoqk/1V9vEl08+4f2IB4CrNxuWYlLGsEVZlZ/4LWs
         V/l9Jr6lmXnfLOXL+vAcTKAEAcTD78tlIHulWprUJGFmI5Sxf0138Z/IrrZqC3W6Hb6H
         WcZMhfbB15Xb54nhHm3hig7G5RmSRlCkWXtIyK2uPw5Iz+ZHtbgNKxiYwV27sjPmvufu
         1k6A==
X-Gm-Message-State: AOJu0YxoMA+2PedhW7+HIPjdf6Rb+0ST5vi17dJDGrbjuoIRGxI15dnt
	G+nTfnK5J7ojUYETBCncuEjdm1UhWTtQSgsTAcY/PyfkvFtTUqIeYl9b
X-Gm-Gg: ASbGncuaMDt9kR8i8OVr951l73NnYLENsJ64wqNrAhWxG9l+GhWVlcQ6RoReqXE4aBJ
	KCrfQJ+489l/oOT56FIy4yy6Errr+Qws8t2g4SxJcW2NlARVcmU6yxINZHnWT6KI56RLGluuSX6
	4UXedWlvObzPzwXTTc1MFJg7QKh7GtWacTkSEg0hSmG1h5E+2Acqa4Q3+sZQqBkditqatLDZYel
	3WvIMRry2LQbw51m1iD20hWATWgt5P27dUgBZWDeM2MQXO5r6T1TpgEaKkhHgV61KYnV7kIWhDB
	2TTY0zsfGVtkamszW+TtQ3RlsG+5Gn5OtjYMUecCzkZs9L+6sxZeAF+mbRisS//U23FM/JrrafC
	0G4s3L6qz5iP/ImKM5MP9tJxsFau9m5l2Dliq0G0nHo8fyTdTEDGSvdnuow1YPxCWVCyu9DBAZW
	iHGpCpXmHtT23GTtI97o2UMAwZJfIaEGESNkifXQ5aTep6gz1Vz3AtcHth1TYgWhN1HNZh73+JF
	ysm0Dvishov0BBTEJhX3BDNsd23Q5t1c9d1kTws
X-Google-Smtp-Source: AGHT+IG6aRCAIZQZqDFNbIj5t62pONwesKDekQizlBgJeej9B01o66f7rj1Ku5gjZ9P3gfkSkV4dHw==
X-Received: by 2002:a05:600c:4507:b0:45d:d88b:cca with SMTP id 5b1f17b1804b1-47117874afbmr34006555e9.1.1760731943786;
        Fri, 17 Oct 2025 13:12:23 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f33:9c00:f581:27c5:5f61:b9b? (p200300ea8f339c00f58127c55f610b9b.dip0.t-ipconnect.de. [2003:ea:8f33:9c00:f581:27c5:5f61:b9b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm11095325e9.1.2025.10.17.13.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 13:12:23 -0700 (PDT)
Message-ID: <e920afc9-ec29-4bc8-850b-0a35042fea12@gmail.com>
Date: Fri, 17 Oct 2025 22:12:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] net: phy: fixed_phy: add helper
 fixed_phy_register_100fd
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In few places a 100FD fixed PHY is used. Create a helper so that users
don't have to define the struct fixed_phy_status.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 12 ++++++++++++
 include/linux/phy_fixed.h   |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 0e1b28f06..bdc3a4bff 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -227,6 +227,18 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 }
 EXPORT_SYMBOL_GPL(fixed_phy_register);
 
+struct phy_device *fixed_phy_register_100fd(void)
+{
+	static const struct fixed_phy_status status = {
+		.link	= 1,
+		.speed	= SPEED_100,
+		.duplex	= DUPLEX_FULL,
+	};
+
+	return fixed_phy_register(&status, NULL);
+}
+EXPORT_SYMBOL_GPL(fixed_phy_register_100fd);
+
 void fixed_phy_unregister(struct phy_device *phy)
 {
 	phy_device_remove(phy);
diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index d17ff750c..08275ef64 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -20,6 +20,7 @@ extern int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier);
 void fixed_phy_add(const struct fixed_phy_status *status);
 struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 				      struct device_node *np);
+struct phy_device *fixed_phy_register_100fd(void);
 
 extern void fixed_phy_unregister(struct phy_device *phydev);
 extern int fixed_phy_set_link_update(struct phy_device *phydev,
@@ -34,6 +35,11 @@ fixed_phy_register(const struct fixed_phy_status *status,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct phy_device *fixed_phy_register_100fd(void)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void fixed_phy_unregister(struct phy_device *phydev)
 {
 }
-- 
2.51.1.dirty



