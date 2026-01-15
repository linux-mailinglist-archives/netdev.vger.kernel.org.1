Return-Path: <netdev+bounces-250067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEBDD23973
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD6F23091450
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161F35BDCA;
	Thu, 15 Jan 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvNWvnRc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sUx76jJK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A03563EA
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469689; cv=none; b=ZXIm6pQDiB13xltB0tSRe7Aqu1mrjyKZNs5Ih7JjdRDf8xCwuiPtmntEREZPrsE//4X5zTqPjjUKJ4riddgv9z/crWrqhRwNHpf00z8AHV8Lep2PDxYahteToB8wJz7xpw3Hosd3Gx349Dg1ZG3nJEpBSOlEX0gqRjQUftAiqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469689; c=relaxed/simple;
	bh=FU/Zot1uLaGlDsxBHIciSijwP7/7/23IMh9tmerRsEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpsZaFR+DRBLDRskDBysOCzRT/OxbsUWNu29HHSxP0ao04osl+OSJKS92h3PM2ksodMaP3a62RcFY9BCwq6GAt6+az+8xFNX1XAbDkGqqeV5KpG+l+1vObTeV1aArzqmAh7a0fXEzYc2hYzqynLm4pZVFiCv5UOHx4VKoE6Rjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvNWvnRc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sUx76jJK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768469687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CUscDU6UaJzLMrwM7wJMVQOj4YBDvGy2zrior6L6Cw=;
	b=KvNWvnRcWxqYiqCCLA1qbeXHb1InoOe2IZhf5dk3IkrEQtI/HtuuI/D7QypC+xHoNVqLHQ
	iRkFZ3lpdMS1fZnPuOH2EAokXqV5Kih5cIGEGWFhpGPvnGetoUKLE0lfMF9kEwPnsmT4QR
	EwNs3dzB21l7DM0DeK9191BTjSL0ST8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-_jEXurlBNW-uyPBbWiv_kA-1; Thu, 15 Jan 2026 04:34:45 -0500
X-MC-Unique: _jEXurlBNW-uyPBbWiv_kA-1
X-Mimecast-MFC-AGG-ID: _jEXurlBNW-uyPBbWiv_kA_1768469685
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ed980309aso8577975e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768469684; x=1769074484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CUscDU6UaJzLMrwM7wJMVQOj4YBDvGy2zrior6L6Cw=;
        b=sUx76jJKhfn2uXGPjJF+Mkfo43Zio0BPSBEJrk2YNr6Pw8dUb5ojO3XiN3xwPS5urk
         xdlKVuM+QQbTYYkiFpC6Id+qqGqHRGMyUAAJHi8f5gp7cegHRQ6EYjL14QZD0ZV4G/S2
         HInhkL4mDSlFl6ydTH1LLwbgc5UHUqZdfAo8a0ZIFFCSJN3EkTEI6ZclQ+r6JAbyo77P
         8e3osenAIxJzpqCQo9LqdbGdR9oZbKyxQU4elLwywAo/qsdvYat1Qzms036kcy/J0ulY
         BNP6xM9wQBnAm/hwDplvdh8lUi8nOV+L8h6VDN/nO3robCsQPlHM05yZGHoJhx3zFbnn
         ERoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469684; x=1769074484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CUscDU6UaJzLMrwM7wJMVQOj4YBDvGy2zrior6L6Cw=;
        b=d0KOMSUuS000mnHrXoeUrukOJK6XDghru9s2z8REqycdGKjmJ1N7TlnScOnG5E1zFs
         P/HfotNCVaq/ciaj9NhfGZACdITr+b77Au131/NSFi9tKCQdyrXyTNNjZh+RzcRaKhfj
         CqLOesFB+2TLZWKuDoIGXzspv4tp+APH87qGWNh4aDqXw/JL3GYpqEsId2qw+dWrdjBQ
         qm/zP5A7cPYZz9bfhLOqgi+TBu4SsbNmZXsTVDMkXByG7ABPSm74cVx9e3rg6nR3KXtY
         J833gqrjP7UGMqAd+EM4Bil1yEQQqM76SuT4kaUNUF6oxezR2U/dGdYbEcMAhUCCJDMv
         FRsA==
X-Forwarded-Encrypted: i=1; AJvYcCU1is5gK93XN3xOCL7rrdI38vJCj90ida8JKn2jpfKhSdiBihK3orLDtbTupMekLURJSVJdAoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4o/cKoZ+TB9POY+XL+qsklIG/JxEQPKJNXIGEhygbbShZUuIa
	D5ogiz/tROL2eAIMvoV7xoIaWIq3P2fiXpC10umjvwhqnfvENPsysG2gPaX/W87wa/qJKWl0Slq
	xH1r5Pclvp6mFtTzFGT0+UK7bEl4XtVULO416D0QBQBK6q64L1TvJdZAltw==
X-Gm-Gg: AY/fxX4np03Kuki9v6q4qguiubFHqr9AXQ6Dsgix0L2Wxqn+Nuo7NNqevitSlXj/0Rf
	FHgGhPTZ7DTsubcFR4uYm0E/nivb2gHuBntUE6v9UoL/37qjqp55Gdd9QNCIKx6DXDT1Th44Z3r
	+aBitj34kT1N5hvX2GWyCRH9i0Z9lNYapD8ldFv2b3uTROD15DzNrlHrpz8nJSL2E+yfVhnCboy
	p2tLoagPjsRuhfLeYeFjoKLx4Yn7WmdPbMArmRrRS8YmF2P39brPRMLsTqStZOLPJ3VDoPD4fJR
	75Gx8HLEvMfE8aNFxBaZpJtxdFT4o1uCd/4hDNLVqYfJVesFCqa1VHMqAX0bEnZhOpS4PxAasrQ
	xwldWGMmus3ZaKg==
X-Received: by 2002:a05:600c:3b82:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47f428f7447mr30633435e9.15.1768469684621;
        Thu, 15 Jan 2026 01:34:44 -0800 (PST)
X-Received: by 2002:a05:600c:3b82:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47f428f7447mr30633005e9.15.1768469684215;
        Thu, 15 Jan 2026 01:34:44 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428afd9csm37134515e9.6.2026.01.15.01.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 01:34:43 -0800 (PST)
Message-ID: <33ff22b4-ead6-4703-8ded-1be5b5d0ead0@redhat.com>
Date: Thu, 15 Jan 2026 10:34:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
To: Vinod Koul <vkoul@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Eric Woudstra <ericwouds@gmail.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Lee Jones <lee@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
 <20260111093940.975359-6-vladimir.oltean@nxp.com>
 <87o6n04b84.fsf@miraculix.mork.no> <20260111141549.xtl5bpjtru6rv6ys@skbuf>
 <aWeV1CEaEMvImS-9@vaman>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aWeV1CEaEMvImS-9@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/14/26 2:10 PM, Vinod Koul wrote:
> On 11-01-26, 16:15, Vladimir Oltean wrote:
>> On Sun, Jan 11, 2026 at 12:53:15PM +0100, Bjørn Mork wrote:
>>> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
>>>
>>>> Add helpers in the generic PHY folder which can be used using 'select
>>>> GENERIC_PHY_COMMON_PROPS' from Kconfig
>>>
>>> The code looks good to me now.
>>>
>>> But renaming stuff is hard. Leftover old config symbol in the commit
>>> description here. Could be fixed up on merge, maybe?
>>>
>>>
>>> Bjørn
>>
>> This is unfortunate. I'll let Vinot comment on the preferred approach,
>> although I also wouldn't prefer resending to fix a minor commit message
>> mistake. Thanks for spotting and for the review in general.
> 
> Yes fixed that while applying

Could you please share a stable branch/tag, so that we can pull patches
1-5 into the net-next tree from there?

Thanks!

Paolo



