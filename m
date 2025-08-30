Return-Path: <netdev+bounces-218486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AEEB3CA27
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 12:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3929A1B22860
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354D6275114;
	Sat, 30 Aug 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvEn2Oub"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7761E520C;
	Sat, 30 Aug 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549681; cv=none; b=MMGrEbMyTh9x7ZN82fgqA1EaYgtoDqzP6ugsUukUENDIiNg7yBu6pvxf7WcWsDiPljLe/3kfgspcrW5h+LspmDv/7vFIfsPe7qvWJkHv08qWm/Mdb1Rd2H8AAa+c1sgUDVYJMU5S4xfqxp2mRPT+Qei+HiqA2SIuDpRcaCyKtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549681; c=relaxed/simple;
	bh=QL26qbYwjJ86fBGWjkwODZpkeBJTXfcZ6fSupKbXgFE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gHD3sjLA1ApBf+uWbvxiKpLph13eelQkT7e9v+QaXk6j94ITRKFr1/ifxSQs4IkGJhGe+0j6Y041y2kJYWNOuq2lkK+HTVn0WIFHqypVOL/nAQw/YD/cpPNwPlogLaImL2Kvrh1siJIhD3ZNryQ7bYWEiZlK8ERaKjiGjUlAH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvEn2Oub; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b629c8035so17432395e9.3;
        Sat, 30 Aug 2025 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756549678; x=1757154478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eja/Sr2qjuVkf9pl7iOKbeZKj1qoBUOEtTGkXbe6Dbk=;
        b=bvEn2Oub132AFSxNPwsqubZEgWEGdSbijE7imyAn25FMsqNo6PzQCPMFowGKEGzBYd
         xXuJaurIYXk6nPyl7RpyONo+0N+2qwwza0iwR0EukWzCaFeTuVykE2v0N2h0s191oKej
         HbwQqvlZmNFrXXja5UtgKDcR3POoGyX/uheS2mbaVIOklStHovid9faG5aV1RDPEXxNB
         WBsGjgqTbXA8FVBplA5wm1JsQ9VkEXZBIL9TW+dgO2vc3PSSGZmP2PlDQ5Qa5v1J4Ll5
         xnQCvqP2EEApKwyPuLbp/WQE9OwACKFqPM6FxgU84EfEKE+xX8YH49CWqB22fCbKNmQ1
         /nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756549678; x=1757154478;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eja/Sr2qjuVkf9pl7iOKbeZKj1qoBUOEtTGkXbe6Dbk=;
        b=A7Bb2jjjY/BD9cpxRXHooQbtSu1g+yXlBSfKVnNFAjzrJjHwT4Ii6h1/xnb+JMVFO5
         vKS39h1BMuvQHV4C6CS6JHSHdpP5fwG6e/KIlfTKLtSlgagOD+OlvTAQ04h+c92dmXvQ
         +HdhRDJChleDkNm8TklAaTzDoDFBgo/fw/VxwQS5pUW10lkESD/USd8ripp6S65ORpc5
         O9YidoERsE+Am5Ouyq5z5lzIbmuc1A5PsH2oVvEgn/m9K7PpDM73+M1IF5vI3GyheQGk
         FTZEDYPAkCxBFjJ7Rb3mnacEVulrsXvRRDE5gCzVU/oVpcPtPWd+APVqnk5lLLd+UHrg
         tTEg==
X-Forwarded-Encrypted: i=1; AJvYcCUmBB8h6yDbvbhNaIXU782RCsfClcjYAxZlTLE/Tu8B0fRRiA4wyW+ALTy4pEWd9DYkF29l4g9a1tas@vger.kernel.org, AJvYcCXUSMgS3imkLDTbzVJUATcY2AsKfXY7stG7dP1qhi4OCwrHcJ/6L341nz68Rp98wZGpzFJC5peV@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGobeimE9udP3G8FmD1wz1PYb5yQdeDji7XzbhbWJUiXepGxU
	Y/Zo49ybOsEn62NnQ0/OlBcipl9ExCfYRQORIyeM8XxPTg0BUGBtDjwD
X-Gm-Gg: ASbGncuazRJpMcLC2igNjkyASszg+3HlyNPO34FCtDf0/nGX9MHkoKYnVOggC8+6OnS
	cX7AM5bxKYu51eVx6SZkmri+AcjMv0a3S0VyubZ9phMwyKgsUzfofx8kqvRJEM9iP9831waTLwp
	Po82EMBR+06M91YL7il1Lwvr9pLmLSJhR+8W/5FLn+rLl9kSsSx6+B4f2IdMkjzNjt/wLUjQWkQ
	1foG6+dEnm2fQOJLh0MIeftSo7qazTVoL5OCLOw3HDDcAOivMG7t9QZmsM5/izO6Egh4YhATCqc
	88f+qoaaXF9epiUBNtI4L4Ssesizmde4poLHzzTM267XhXBS9oRMJSWdtT/0m3qygtaaK3rKUnQ
	HFX+V1P5C0OySB0iPa2AD4WTvzkY6exRjCa/JdQDLKc0oHv6zM3koER7YOoX+stBkI9ta9ma4TD
	+9a5HuUuOxwKn4M6sfE9Y0/849Pnpth48IqHvoJm9TLVCYsKAWd64QCPDa+BtKSxm52Bc=
X-Google-Smtp-Source: AGHT+IEbinJMv0Q50yWLcSQLB4WIKLpbG3dkEZKOAzvtHVjw3gGu6LpEKbKaKP2RsWcyI8GyeNhlCw==
X-Received: by 2002:a05:600c:1f08:b0:45b:7bba:c7b5 with SMTP id 5b1f17b1804b1-45b8557c880mr10933925e9.28.1756549677730;
        Sat, 30 Aug 2025 03:27:57 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2? (p200300ea8f2f9b00080ca2fc7bcf03a2.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b8525a94bsm23354035e9.15.2025.08.30.03.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 03:27:57 -0700 (PDT)
Message-ID: <7427825b-7d2f-4edb-a357-fa5eabb6d7d7@gmail.com>
Date: Sat, 30 Aug 2025 12:28:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/5] ARM: dts: ls1021a: switch to new fixed-link
 binding
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The old array-type fixed-link binding has been deprecated
for more than 10 yrs. Switch to the new binding.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
index e13ccae62..8d2438498 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
@@ -120,7 +120,10 @@ &enet1 {
 };
 
 &enet2 {
-	fixed-link = <0 1 1000 0 0>;
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
 	phy-connection-type = "rgmii-id";
 	status = "okay";
 };
-- 
2.51.0



