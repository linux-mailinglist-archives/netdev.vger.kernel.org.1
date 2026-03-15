Return-Path: <netdev+bounces-267942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL5RCUXjtmmkKAEAu9opvQ
	(envelope-from <netdev+bounces-267942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:50:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0B4291899
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77A653006D43
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168B372EC7;
	Sun, 15 Mar 2026 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfDfpUjs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24B19D07E
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773593405; cv=none; b=qzyB+bocVJ8zhVLP+cxVKNmGY1X0q9rQh+pdd00/wqcsSTz9hlA2kbkQCNtMs69b5md5rnAOpBEoabd7twNFOI3TFtPqc/otga2Fmab6qKfUSUZAyTnoceTjf5sABJJk7PvZeFznN8X8araSrtEsGYT0RxGpwgEQ4ifgdtXdzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773593405; c=relaxed/simple;
	bh=oHRt6X+F7bpekcJPDP7wcH7Yh5wtJFBOaws5B2wE4h4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e8n1h2S0o2E2EqciUrZnbFQOwKOvXwgoF5Ld/NiYQ7UY3DZ27ArTNgrer/Y1pDcWlkU+LgNtAiaJBgu4B8AQAyzhZpJB5dqBFGTaFRwRUoLZ4MwAkrydN1eGWJyZgnkezTRGKY0E12F4DOz33OP6/UWqPINb0gQjw3Mg9wFZT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfDfpUjs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so45174875e9.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773593402; x=1774198202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rObUljC38Hdry53z0R6PTBszYRze3OJesm0j2L/VR9g=;
        b=NfDfpUjsZGCYl2JA3Ohbigkx512QnGZzmxQRKN1scakv/0gys0FoLaaMNSwSYjoapC
         Y0MX3w6xBzC8BhDJ2Q0f4/0EnL6BWCZHGC2jzHNGstdHReEAXyQbGQVufRTw0B6s/F3r
         VD75+M6cc+QXoryFALyt7kIOdhoJpI3pOTNdBiZ7EwIzlc+TO/qOtcmxFJTindlJdQ81
         dAYmyz2Cs45/kcusj8twWuTzelmMM2eyfLqtbMFExP1Lqz1v4atSeQfKX7lLGuCqJQaz
         knEynhjTJAoR27ut6DWB/nyVZrQRMXVaTfKFTlFK4CzDg6zZ2+qy/rTMq7abAzDP4iPq
         HoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773593402; x=1774198202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rObUljC38Hdry53z0R6PTBszYRze3OJesm0j2L/VR9g=;
        b=MMqS0W30FB0kkxbj5SxRpBIzvzVlBPdV6GmsVDPnMSJQ8+UfY88OtcJG0QETwn2jdp
         vFikKASjtZ60ZKXPVco1X6m9fwKBTQ7g+JZDMBzRiFhLRVQUw9e3xu/+31xWwFQWb2NG
         EiBTwglK1GRpehHE99NkXRxCOwwh3lrnwY1kqkmM6LX6NCKZvTs634UM8DMkgwWG+uRs
         oiRK4SBCX39Qs1PPOKH+5776lY1D3tH+eiiAZ9XI0vux9Ls2h5OD5bHacNxpthCeAaAJ
         +hkai62M2WhBcEGsEeEsO1BG7WG/D9I4rrFwPzkny+b/nQSbFhWJlsskI/Rvo+SNxYXU
         uRuA==
X-Gm-Message-State: AOJu0YyClJ+oW9lXgFfh9cJybAvUXvbNeZ8jnJZFnEvAzdcabK0EtRef
	5MGL5VeokaiFoa0BFbyOp50THprQzY48HYo24fbg0LqP54L8X7jpkdSx
X-Gm-Gg: ATEYQzzgKYP8tn1qiaFmgtwYaOoUHBAEY/OXXwXUoVY4WCIDd8/f4Z2ROfj1RKnDyab
	ZF6jAAWnC0/5orJCSZ7WcEK7FbllN490tkCtAESxraECop5Xbeu8LZlfspoFuJXjEba/XrY+sE6
	jPEbwjHCwrq5/wJ2Phha5hi3OX/QwxFX2uH/kEqe/vRo1aOYOhYX9AnYk6CSg48Ggnxk7w/QHdl
	CmU5oIfMGQpInprKJCqcMCAHm3UNwbqGkSBqlzF+9pTwUR1JuOd5lITdxDzZShhCdZb0HuLRRQJ
	Fg6IgzuUMy+I46V/hi8SaTjYIRLKcqlpolXVmZwEnKbBYd92jdrsuDxbMae9Vg/Dw30C/vUmcxn
	a/+mx410n+15xBVS3dzh/4AO8P9NsK747MJ+0inhRUPOlLNVajjdhLoRGI9z1Eiugos1IwuD4kh
	ulWkHYo6cHFe7ckmunKq8RePPcyfbtnJLQN/d4PKAoD2Y+ECd5D3wH2INqLBufYpBj5hG5Q0z7H
	jPMb1utS9npo7WY0XdbLz8iGym3R6NFiuS9B2tLQuDa+0FPSqZV0b6/IyqHLXFWNw==
X-Received: by 2002:a05:600c:3550:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-4855670c971mr182570875e9.29.1773593401569;
        Sun, 15 Mar 2026 09:50:01 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45? (p200300ea8f19c4005d7d7d8bdc1aae45.dip0.t-ipconnect.de. [2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm13284167f8f.0.2026.03.15.09.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 09:50:01 -0700 (PDT)
Message-ID: <9cdf83e9-470d-45da-8efe-ace0decf0204@gmail.com>
Date: Sun, 15 Mar 2026 17:50:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] net: phy: remove Kconfig symbol MDIO_BUS
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
References: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
Content-Language: en-US
In-Reply-To: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267942-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F0B4291899
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After usage of config symbol MDIO_BUS has been removed from REGMAP_MIO
as last user, the symbol can be removed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/Kconfig  | 6 ------
 drivers/net/phy/Makefile | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7b73332a13d..b5ee338b620 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -3,11 +3,6 @@
 # PHY Layer Configuration
 #
 
-config MDIO_BUS
-	tristate "MDIO bus consumer layer"
-	help
-	  MDIO bus consumer layer
-
 config PHYLINK
 	tristate
 	select PHYLIB
@@ -19,7 +14,6 @@ config PHYLINK
 
 menuconfig PHYLIB
 	tristate "PHY Device support and infrastructure"
-	select MDIO_BUS
 	help
 	  Ethernet controllers are usually attached to PHY
 	  devices.  This option provides infrastructure for
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 8d262b4e2be..05e4878af27 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -15,7 +15,7 @@ libphy-$(CONFIG_SWPHY)		+= swphy.o
 libphy-$(CONFIG_LED_TRIGGER_PHY)	+= phy_led_triggers.o
 libphy-$(CONFIG_OPEN_ALLIANCE_HELPERS) += open_alliance_helpers.o
 
-obj-$(CONFIG_MDIO_BUS)		+= mdio_bus.o
+obj-$(CONFIG_PHYLIB)		+= mdio_bus.o
 obj-$(CONFIG_PHYLINK)		+= phylink.o
 obj-$(CONFIG_PHYLIB)		+= libphy.o
 obj-$(CONFIG_PHYLIB)		+= mdio_devres.o
-- 
2.53.0



