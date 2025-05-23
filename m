Return-Path: <netdev+bounces-193170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E103CAC2B55
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BC24E273E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE220202F79;
	Fri, 23 May 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk6Ut7Ls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484421F3B87;
	Fri, 23 May 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035614; cv=none; b=IfTnKoH8jyhTmD3f3eLS6XHGDu79yGwBEskQ6CQsv6L9sqPOynA95AVO28lxr5dHXD1UCRb201L74dcT/fR7aHEwn/2GMWuDq/9Vlf89+QgncaCY3gY/hokPlWp+M30F0kXgEFL7VJFl1+Hm9TFJzJapl2yoG3cY52dwZxNvHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035614; c=relaxed/simple;
	bh=fL6KMEvzjubszOU7BO+HMkgcuTdu6nhrdb/ECZrA8zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNUdtLPmnjFqoRQzcNJk5TR3ZIYd9IcxVmGSVw4g6hLv2o1rxH3607GoZO2cJwasfe15H/WyAdwFjeKT8Z9/e4w7zDQnmfkOgoKke8r682NJ5puYkzSDEbgL5GF9E/Vo41v4BotY8dD/rwMS0Is+NdvioVPL4bm/EmVgRz3f3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk6Ut7Ls; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c9563fd9so303518b3a.3;
        Fri, 23 May 2025 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748035612; x=1748640412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AzkMPnhR5yyxCN44W9Le7GSmY6Hc7Zm9NxaGmrId8No=;
        b=Zk6Ut7Ls/ahwuShDryORtxEeS+0H9zEQWlnjwSubA1njuhrMK+4l/uKgAIam7RiC7K
         0zCJQnF/tg6zPbvYu6PjUxW2GK4mD5LiOX8KUW+MxJOLD98cczJLEPMN3fifzCUL3zKd
         y8a0RfLQ9yNXxXPo/BMjMoGWdaEuTpMzQCh9IOlf/XzrDsQQ0rUjLIU//8aOV/dyhqhM
         bujm8EDa5giUHY10hgSqFOzKeaTGeEOd6KUUIkFKxXjP1srHbXm2VLY3PiyCLud3lEFA
         ZtPoVFvtjVrpphaduBurpcgBKEPZgGI+Xq56f0Jjq0cVdAAYVvs3mAtdcSbOMVht9QzF
         YV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748035612; x=1748640412;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzkMPnhR5yyxCN44W9Le7GSmY6Hc7Zm9NxaGmrId8No=;
        b=uv+xrm/gAHiwDlU3u7YGVJyceEwtF3x6kvZ8KGcBAlViiTP9yTUyEE0I4oja2kWlAV
         Mr9Lo0XoH8AKbY5wTHlh15zGK58sfvq1M+l1p9ByqzDQR8QypVBRbi1S1O00B9Kz3l8k
         MiyW/XS1cTt/Ae6IaocQfYmbq/lOkDOJZtwdP0VRvF8GfruxfyHqkwIdL5Z5WJZ7lMAL
         UX79K78bwm4e0UQisfVfPoXLzXBn1Oeo1MJe97Ugo0icPqdlVhYCl6TgKNpCu619pPut
         Kb1q2vuZYsaI9vv7E70JqG2YmzqlOtx0mn0rNFch8tSjxpGFLypD7d8BrGFGWCE4vGsG
         XnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1ToYHcenJIC38XFPZSxL70lTbCie4f2OJG5G3lByCno7mtQ36Z7WEBUlUQzOYEX+fbR3G2KiBHAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymbMksbRnbC0QkEKjqCqRrfrVVLGVALF2rd8O/faGyReG8F9ix
	B3lCMcv4pPwXe3MJTna3F4IENtEzZhOh1Up538Dlb/y2isBcaxpNFtME
X-Gm-Gg: ASbGnctjxrYaP09d/Ui+pzwMpxuNbEDf2pJp1Uo/pn5jmI654DdZdaNPxdTmhxrGcs9
	5LuXDtzhcMf6Q3UfNbwRwE2teKioQ4ntuslO1y/is7gQTTvQTBbCxFVxe6q8NLCBGId4R3pb6XG
	u+0xnIsSBdz/Yy2vWcUNtpOs+pbIDKm8k6vmEW5qLFCJZcVmdDQPHL/95ZZQSkMAvhGAM2Y82AC
	GSk7KPPIbe0CIzCwjbpZEcW19J5dPFPx+ZvFJGKUftAh9F2yL6oEvNtAuw3sCzfnSoC1tbRsLfl
	/+rZP0x/d2Q6Od5MyZtDHu1NhYm2t2pr1VjLrCZqPn6o52bpSeeUkQeeN9pj5u46b/8XVggiAQe
	QdOo=
X-Google-Smtp-Source: AGHT+IHe/GRFVdJ73EQjIE0HgPoByteV1mFJxCTJ+v/GziVNeV3j+gBFjipMDUYphxYeFlG80V4x3A==
X-Received: by 2002:a05:6a00:3c83:b0:73e:1e24:5a4e with SMTP id d2e1a72fcca58-745fe03d5c5mr1681627b3a.24.1748035612424;
        Fri, 23 May 2025 14:26:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96deaf4sm13204044b3a.23.2025.05.23.14.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 14:26:51 -0700 (PDT)
Message-ID: <23aa83c8-2b60-4979-b1d7-4f9b55043b15@gmail.com>
Date: Fri, 23 May 2025 14:26:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: usb: lan78xx: constify fphy_status
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux USB Mailing List <linux-usb@vger.kernel.org>
References: <af1ddf74-1188-46ab-83c3-83293ae47d63@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <af1ddf74-1188-46ab-83c3-83293ae47d63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/25 12:51, Heiner Kallweit wrote:
> Constify variable fphy_status.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/usb/lan78xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 759dab980..17c23eada 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2630,7 +2630,7 @@ static int lan78xx_configure_flowcontrol(struct lan78xx_net *dev,
>    */
>   static struct phy_device *lan78xx_register_fixed_phy(struct lan78xx_net *dev)
>   {
> -	struct fixed_phy_status fphy_status = {
> +	static const struct fixed_phy_status fphy_status = {

You are also making this static, but that's not detailed in the commit 
message.
-- 
Florian

