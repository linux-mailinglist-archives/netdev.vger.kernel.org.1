Return-Path: <netdev+bounces-221562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908E5B50E06
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA5E16D022
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714FC2C0F78;
	Wed, 10 Sep 2025 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+VIRA6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FB2248BD
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485750; cv=none; b=Gu15FVAHC+ig43J8N3D4HZamslF5TZ9jktkVTSpZRTIBrab7l/7UXSikuH2bz+459NiExXHWzW9xNIlhV2Bxp1oOg1xcevvnYwrmYuU08w89/DlvvhI2FWxlREo5a1GqOqMvwoGGhHuJHjOpFDGZFFOimO/4SmI1APRA6DVzNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485750; c=relaxed/simple;
	bh=at2P4MvH7MRu3vzpA8l/ndV8dNazkR6IoHLw/W129ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hg+Lq+YLeVkZklb7gT9iqa2fLkI/1k1wh1T+/29H9es/Kno3XQDu/cLZUDAnTmMBK/mgR7ixXBO7lVbxh0BSdH2Vx+V9+L3VeoRRDHwoXTzmEJPAgSYnCZF3Vgc+TN1XkAHLUqUkRtrPDGeE0V05V5yNE3Gjy3xh6BZVGbMDoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+VIRA6S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45df7ca2955so1257865e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757485747; x=1758090547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H5CzVspjJ64c7oQh7HtkUvW9H3yqxwZTwBq28Yh68Pw=;
        b=U+VIRA6SRgetu/QFPgUYnk5ZNP5OL5fDjD5OXahABWkVf1sSTzkCKWRyfTv74mF1U2
         5l68pDwtsMC6cJpnA//+M2YnASo3l4ZFQiP/xuNS6YzmWYASzplkCk8DI56TXxRqN4SR
         k9GPEr5VXxa/pJsEbv8xQ2QFPyqUgzkDLkO5DEg3jBT0JsZCKhMde72+F3QRztwZGFUr
         crUJ/kU47V7R22xbvoYhHLRlKSx3+J/Sb43duc3ToSIYq04LmA9Yruprnx751D2Rheaj
         dL8iCIh2R3xqHYQocTkukt5aFoHOzuaWY3X02vEc5RL7dKg34zVeJrZqW2u4As1vlPO6
         t8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757485747; x=1758090547;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5CzVspjJ64c7oQh7HtkUvW9H3yqxwZTwBq28Yh68Pw=;
        b=OrmkHzSWYFR6Cwc/fX+t7O0rFdfHcxn9R87IgnSVqPuVpAgGhK7YQwXWg2b5Xdr+jg
         ClCI5MchzxfyOMKozX0pJgokRy9T3fqhVe003Bu0OLGTZZiuds5R+FhlGlXb8TwFEVJF
         2As0BgPjBw0lEmlCgkC9YQafCfTI5SUigpr/yEfGnMdoSwhC80ME4IwhJ7e7vTfFrPdl
         n6UblMuf2z/160mCaCopQwkKbGjRuv3IZ1ORrWVW6IKWFyRc7xosRAlLdscAfZztLp4r
         WWzGXjX44zFIxZJXQo6JfHHpKpTiL3LG7ndmW9sEiQeL84h6VG0qUN9RZMLvyMu+dEFO
         neJA==
X-Forwarded-Encrypted: i=1; AJvYcCUMj99ONtcmtqd3daHIXSCi1sPZjF4+qOLFAXloigEwrOQ5E7tnczBjc8ldqkGPURoSL5McecU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Bzu8RNpJ1fIsRNIaVLn4XNdXNiMxNxTdjlMiKx7XPJblnf0f
	YGkS4YgXQxz7qTPjwfDyg5MkvDMJFzSH8W3beJHOYQr3ObzfVS5fWZC+
X-Gm-Gg: ASbGncsfhvqPs0EhSjcPpKtUUDR9/BIfFxSruJGyczNZTY9XZslJHfe81npTt1OGCiQ
	Y9ME/xV7KWQcLoBErsVkF0MmEoQIGLemKfP0L+hcP8KbTpbKTOM3hzSdDCnPNU6qbvraSLIr4HS
	k3COA1sJ1ad3ODOA48iV5zEF11DJEQ/LwvJnsBLdb1qhY7D7w7/8Ye9urLx30nUE6nbIg/NGERr
	7NrC8u6dLNN1A9abOGQw8tkvZ4Z8m1LXJaQVqOqUSeWtnZw1VV7YHMwItzic0faLkftWI5DD55Y
	//d1OdDIBmS1i1M3MBGRk5GYDhTuNpp0DJyrB5nBVvvn5jhz4cNQ1yBfP27500Oqye5bkCy3Tuj
	XbRovE0n9Rv8+MaR//aT2x5koSlPa7GV1eZndsgOhN/teeyoFazPqFFOwX/cQ2YfJ6E6Qfb/Ft1
	afgYhErGkMXtVKkPgmVgp82mXKNoFcHP4pyKFP0BY4h8ggXadn5w7rNl+RU0+BBKfkyeNvYLR7
X-Google-Smtp-Source: AGHT+IHE7M5RA1vylcD7uKoFLSgQWUYDTl1yP4TJmqDhe6BpIlxD3kcKga7a9hMPvev6Ym3yxpyBLQ==
X-Received: by 2002:a05:600c:3ba4:b0:45b:9961:9c09 with SMTP id 5b1f17b1804b1-45dddee8ea3mr147694795e9.17.1757485746701;
        Tue, 09 Sep 2025 23:29:06 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f22:bd00:e583:499c:4869:2690? (p200300ea8f22bd00e583499c48692690.dip0.t-ipconnect.de. [2003:ea:8f22:bd00:e583:499c:4869:2690])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45df804bce3sm15261265e9.0.2025.09.09.23.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 23:29:06 -0700 (PDT)
Message-ID: <30e08158-46bd-4426-a521-a7d8af1f7370@gmail.com>
Date: Wed, 10 Sep 2025 08:29:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: phylink: warn if deprecated array-style
 fixed-link binding is used
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
 <bca6866a-4840-4da0-a735-1a394baadbd8@gmail.com>
 <c9d4aa1a-6d94-4110-87fa-8c5670c3c75d@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c9d4aa1a-6d94-4110-87fa-8c5670c3c75d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2025 11:27 PM, Andrew Lunn wrote:
> On Tue, Sep 09, 2025 at 09:16:36PM +0200, Heiner Kallweit wrote:
>> The array-style fixed-link binding has been marked deprecated for more
>> than 10 yrs, but still there's a number of users. Print a warning when
>> usage of the deprecated binding is detected.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> It should be a pretty mechanical transformation to convert them. How
> many are there?
> 

At first I looked only at the Arm DT's, but there are more users of the
old binding under arch/powerpc. In total it's 24 users.

arch/powerpc/boot/dts/mpc8313erdb.dts:                  fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/tqm8xx.dts:                               fixed-link = <0 0 10 0 0>;
arch/powerpc/boot/dts/mpc8378_rdb.dts:                  fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/mgcoge.dts:                               fixed-link = <0 0 10 0 0>;
arch/powerpc/boot/dts/mpc8308rdb.dts:                   fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/mpc8377_rdb.dts:                  fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/mpc8379_rdb.dts:                  fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/mpc8349emitx.dts:                 fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts:                      fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi:             fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/p1025rdb.dtsi:                fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi:             fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/t104xqds.dtsi:                                fixed-link = <0 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/t104xqds.dtsi:                                fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi:             fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/p2020rdb.dts:                 fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi:             fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/t1040rdb.dts:                         fixed-link = <0 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/t1040rdb.dts:                         fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/fsl/p1020rdb.dtsi:                fixed-link = <1 1 1000 0 0>;
arch/powerpc/boot/dts/charon.dts:                       fixed-link = <1 1 100 0 0>;
arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts:              fixed-link = <1 1 10000 0 0>;
arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts:       fixed-link = <0 1 1000 0 0>;
arch/arm/boot/dts/st/stih418-b2199.dts:                 fixed-link = <0 1 1000 0 0>;

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew


