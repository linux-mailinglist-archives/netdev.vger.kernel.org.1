Return-Path: <netdev+bounces-243571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5F4CA3E07
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2067A3016EFF
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59716346762;
	Thu,  4 Dec 2025 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXCf2S6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09CF2E5B3D
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855593; cv=none; b=HO2b22XMiKexSavQkt6zns247nD5YRt+wkFLzyvxZAiRIMYHqzVd1VCr8IJ2eFsvmUK24Iml5hdc4uj4Unu922Llat39eSDc8x2x3mT6P3vL7xpoA+BuuZGkxVd1ES8Z/OHqkF9HhE16JF+pV7y0NCgAip+cnXK8Y78TLVZ7MqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855593; c=relaxed/simple;
	bh=Byady7NBttcZvBzss9LmHECB2eAKN21blUD0eYYKe0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efbQNvGrKY29HZVH5p6vWeyPKRKE6Y839LsMEtuNUK2tWRme0KJFwkYeI9gBwn9q9lAVFVv1K6GmnbfMomxRKz5+O2TmLNuddZKhHewH/oVnZRzwa4TXkz+XmWq9ZynbbcnOW0HuPKW+gEmciGPClk3lMy4iCoehZ+V1JJKzA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXCf2S6T; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1553165a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 05:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764855590; x=1765460390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpH8Z+iCPRMm2GQp2wva6RkvWE9tQWZcrTCI041rIRk=;
        b=aXCf2S6T5JHiBNdGKgzOuYKbVxitbZAi+CCp3poZmCxklN5zCzuZjavEzR6ynOicJn
         rUZl8yjBg28RSxtK5kJeBx2MGti1rN4puPK/0wjO22YOpYoJqw9XSCSJYtej76FxdCtc
         J7TWoZktA1+Yz33AssytQ0kYNIeXfpZF85ocPbjzq0lnuTyCAeua7law+YJ/Fhab983a
         apqQVdcLcNBOuHUXB4CQgxqeCJPye3Xih2eRlVoZjGFUUiltpbexk8/+hzTV1PEsng0E
         UlYhL1OuZZxM9+SL5yFJ57taf4KYD0WJEsZuEe4U1IkSBSbieCdqk8KNzag/kxTbTOyu
         K57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764855590; x=1765460390;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpH8Z+iCPRMm2GQp2wva6RkvWE9tQWZcrTCI041rIRk=;
        b=Po4/jssfDKNWxS14fwImdFQL5mh651E3r6qdAsRYBnlIhyqt39xmwlM648vzH0YtNW
         6eKq98piu7opWkiD8IwLDUH92ZPWVad9STVwdL/lASvF7QUyww2M8QzWTrvjpDMfGEq7
         KqnfvmCcE2duMPcB/KM6SWk/ghBuqBHfKDmKU5Lco6fm8jS/r5vu7Tet6toCpnHPbleL
         xNN5hLWyrvrK1U3DokFg8lRvpkYBHZrSIFcTNfTNaDpc8E93qMDqfiCZQNQiJRegaUao
         RPBT476VKSYhWnfoQ2j8zgCGKMWV+9olGin6yXsg+cLtJZEX4u8j9QsPCS58gS4n89fs
         C6eA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/OBfznSYEvTT+GbNGay9QbbyQVeVNCP8pmnmz7uEWNnCUiKjtw/5VbkaNQ9ZSUOPNACL3+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1w5+mgm0gIvnwesBOL3OStae+c/6JDcLptS62tURlmPse+9g9
	QhputcoemNUSVASPXe86/JspYpM2fWWTRn52mfKK8L/0/lKaiXsZXtgo
X-Gm-Gg: ASbGnctDDNjo4F59QOfxieispkji0ZejxzF9tiuyKM6D0lpBB3fowMsAwgiJx4e9WBr
	gRGg0bfCTOTcJDF50bRI5WN3V3XCnxjHfMBK8Dv8KesWPX1iVe0ZHAfcOXZ0Sc0osDZ1XtGmagw
	TOV4Ko1wK9T0NL4TWQKiu+3Ze+XoE9Q3cT3SQwPK8kafh3/5ohynyLN8OlEq+GRhERCL1R0wugQ
	UvlV6C6Jh/lC5v6FcTiBsXYTZpKaUkENl50jAsSYt2tkyVXYV0Fghx+bNOX2ZCQpQ//2sx9Rpyw
	Ip96MxthpMe4ROLKNC6DM3490auSZ89hQC4XalJp6FFdGbjVod302PjY4LAsoTWWCymXITX2JK6
	gLZFcmhEtelmJBOvwbkiTMp766tJ2dUDYwdKw6lD2PkvDWhAQNIDuDrLMl/qg/0sDHvDdj16vLr
	SVPpv7VqmpmNef8iZWTu41wm5BNG/iHAXYvmtz6iYyIobAMw1OZ5wbZ8GD2UTfCL2xXoB3Ki+y
X-Google-Smtp-Source: AGHT+IHyxocklivKXDBa3Wth7R4D/VqTLCwo+FByG3Nl3VEFRJTgTKno+GZt80pxVvvVR/fSlLKsgg==
X-Received: by 2002:a05:6402:40ce:b0:647:62ba:123b with SMTP id 4fb4d7f45d1cf-647a6a23982mr3154351a12.9.1764855589895;
        Thu, 04 Dec 2025 05:39:49 -0800 (PST)
Received: from [192.168.0.2] (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b368de06sm1265575a12.22.2025.12.04.05.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 05:39:49 -0800 (PST)
Message-ID: <a5236fe2-4e9b-49ef-9734-f3b60746896d@gmail.com>
Date: Thu, 4 Dec 2025 14:39:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] broadcom: b44: prevent uninitialized value usage
To: Alexey Simakov <bigalex934@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michael Buesch <mb@bu3sch.de>, "John W. Linville" <linville@tuxdriver.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20251204052243.5824-1-bigalex934@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Content-Language: en-US
In-Reply-To: <20251204052243.5824-1-bigalex934@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/4/25 06:22, Alexey Simakov wrote:
> On execution path with raised B44_FLAG_EXTERNAL_PHY, b44_readphy()
> leaves bmcr value uninitialized and it is used later in the code.
> 
> Add check of this flag at the beginning of the b44_nway_reset() and
> exit early of the function if an external PHY is used, that would
> also correspond to other b44_readphy() call sites.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: 753f492093da ("[B44]: port to native ssb support")
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/b44.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
> index 0353359c3fe9..cbfd65881326 100644
> --- a/drivers/net/ethernet/broadcom/b44.c
> +++ b/drivers/net/ethernet/broadcom/b44.c
> @@ -1789,6 +1789,9 @@ static int b44_nway_reset(struct net_device *dev)
>  	u32 bmcr;
>  	int r;
>  
> +	if (bp->flags & B44_FLAG_EXTERNAL_PHY)
> +		return 0;

Wouldn't the right fix here to call phy_ethtool_nway_reset(dev->phydev); instead
of just returning 0? That way it properly restarts auto-negotiation even in this
case.

> +
>  	spin_lock_irq(&bp->lock);
>  	b44_readphy(bp, MII_BMCR, &bmcr);
>  	b44_readphy(bp, MII_BMCR, &bmcr);

Best regards,
Jonas

