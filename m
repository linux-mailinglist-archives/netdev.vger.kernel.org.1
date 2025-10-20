Return-Path: <netdev+bounces-230793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A76BEF85F
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 08:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA18D3483E1
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E62C178D;
	Mon, 20 Oct 2025 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEd6g3Td"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85D14F9FB
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943298; cv=none; b=Sdzl2RLm1v4Ph5to3qTUUgO59tPrtdR8MfeOnyFItUTIUQ30jJgjAfkK98XzXnu7MzQ7urQxrL3wPMcdJ3VZVK1whrfrcvfHI+zpnTPZUi6DHYFwcOl9BA3qo/vgCqMjIMo7IEVyLhWt8BmzVs439lIlYW0rXUR5zX0S/l726uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943298; c=relaxed/simple;
	bh=0tqT5oeajt50yKYvNBJOiwBt6ouRde7zOPag2n6MxNU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KzfFxHf8cZSNoHyUTa/f7Go7ImtpqI9/MizZ/1giBqVtujZ9Ezcxy9R378qX/RF6B4Hw5QrVcBXcEGuXv4jRa1uhQMBQuA3abLm33kDEJ3juwjLrwFzyXJ4jCN2+EyhnvH7ivVzeqwZmERk5vN7hVixdXTyaBxaSiFSHljD8q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEd6g3Td; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso3046796f8f.3
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760943294; x=1761548094; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCOb7kU/lxyPJcAkkEw6fuBmfkV0l8hBRDc6MDcbRJA=;
        b=hEd6g3Tdkvy/idYUqiDsYx4gSKH9siZ7jJ8Dl+NGtV02vOfxajBxyMz11Ub/Mzn73r
         Flk4Ye1oe3yJqUCrDKNWcTdiC3xfy+mTc4TIHQUKk8ljjW2NcN/RTkpcKr4xb5WsFHvK
         dlL+z7k35FwaQ7JT29DgO+VRGNlLEvXBdKKuN/rDvWLWBAviCZ/csBgsFlnotmf7YnsN
         Z1Ozxo0gHP7auwP9QfrngSHN2pLsBY59nujdoeVdTKaOtgrWQ13FNtRp7A71ySQfjlpz
         qwoga8IErRuuTHt5mjh8xVZJGag2tMdjAbD/wSg94SbAGFC07a4uD8yh7kQTzBFbsRVP
         iv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760943294; x=1761548094;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCOb7kU/lxyPJcAkkEw6fuBmfkV0l8hBRDc6MDcbRJA=;
        b=NuCWiLcgNrBCL2MPZU92kbMF6tZM+y+g80lPQJ++u2+ZcU21rjtKHbNr0WFdkDakUM
         OTcepBGr+H62ZFd/cBgFZFAZWnsqBYq/KcfsVBZoJyXfFf7P32U7aijWTC2EB6j6qxh/
         e5jKpaPviRg8vOS55+B2q7PHK2py+GTme/1X+OsksPXzOqHci3VF+z0GHjZeiCBODj3n
         4WHcAj1sl8j2BGQt7owvua0Ikopr8Awpd7O+yRvEOXYs0A6L4+IMZzKwh27fvRkULPgz
         AftwK/BfTCDXU9sheH9+Zm1ix3YQ2nRQSX9yYfNRP9Y2EeMJd5VV64j3iM7zaofwktu6
         7c/Q==
X-Gm-Message-State: AOJu0Yz+TRcY2LG4eC9J0ws8whFawfnyINWKC7E9TYgbnjWEKYlDKH3i
	6cBlMinrfaonfW4cljI4c1G4i362IwqIq2M+KXejE0GaL9LDLwyHqG+yYxuyoQ==
X-Gm-Gg: ASbGnctD1jDwG2cFC5aJLq8uiM8jZYO1IE6wt0S3gf1r9g/BoRWdu4YVkWiolTU1rH8
	4CcQADRZ18rojO6fzPZGyGkaP1UjBPiZW7LIwnrpFA2X1DGSHY9fqdv5X+uHx8kTXQqsT+uzbAK
	/spj7DHkkirvDheh+73hranVJsFBmaop1BMDfC+9TyLeprv33li9Nr+jv5JZ5++q6g4CgCoIBy4
	Cgi+WdCwQ1VIF8dnCBl3QrCio9+2gvHLYleflz7ojzjEqnWlyOA5lxwydDTJxIpO8KSGxxDGmEH
	N/d19VNPd3pM6GXLAqeofca4/BhQ/uc7vSkqpN0jCQYfpLkLhhd/EElau8RDhDP2SlbJsd7Dwoc
	TAyG7fq2Eq9Q0MZgBuYAforuWCPZkEffKAgIZC0nTYXU/TBpNvBSFAyohWXbUAhxXw22kMNrrkV
	hUSweE9eXjK2+svsRhlWGr1cvkKHxSgjlQOdH4u+WMeQikAPLJIILySpRNKYsxaDKpodqEYgZ/J
	HydcF6UCsk3j9RJsQ24uIuAcexqwLcGoirTZfJb
X-Google-Smtp-Source: AGHT+IF4Cr8ENMF9oM2lBaHJ2Z1jCwmlYOqMbPkab6XWNNalMYcfjhGO3vPR+3J2fPbVtBB4N6pqog==
X-Received: by 2002:a05:6000:2c0c:b0:426:d619:cac7 with SMTP id ffacd0b85a97d-42704d9397amr8504846f8f.36.1760943294418;
        Sun, 19 Oct 2025 23:54:54 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f33:a300:751b:d37:589a:9c8d? (p200300ea8f33a300751b0d37589a9c8d.dip0.t-ipconnect.de. [2003:ea:8f33:a300:751b:d37:589a:9c8d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427ea5bab52sm13580947f8f.22.2025.10.19.23.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 23:54:53 -0700 (PDT)
Message-ID: <c4fc061f-b6d5-418b-a0dc-6b238cdbedce@gmail.com>
Date: Mon, 20 Oct 2025 08:54:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: hibmcge: select FIXED_PHY
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

hibmcge uses fixed_phy_register() et al, but doesn't cater for the case
that hibmcge is built-in and fixed_phy is a module. To solve this
select FIXED_PHY.

Note: This could also be treated as a fix, but as no problems are known,
treat it as an improvement.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 65302c41b..38875c196 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -148,6 +148,7 @@ config HIBMCGE
 	tristate "Hisilicon BMC Gigabit Ethernet Device Support"
 	depends on PCI && PCI_MSI
 	select PHYLIB
+	select FIXED_PHY
 	select MOTORCOMM_PHY
 	select REALTEK_PHY
 	help
-- 
2.51.1.dirty


