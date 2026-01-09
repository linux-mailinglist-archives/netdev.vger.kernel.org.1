Return-Path: <netdev+bounces-248491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9DED0A012
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B972E30C85B1
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9778B35971B;
	Fri,  9 Jan 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="N5mDZd3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E033372B
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962283; cv=none; b=Bm5mArS/+eQ7JNWaSP34Liygi0xPgiUIGCepNumvDT2xkM/v7uF0FOgdUzBdBSq1cwyIAxcQsg59z37by5XEt0D5fAc02z67SMfTv3cZOGatkU9boUPcGY16qNBXsuwT9QBh+niV4lDgdIDceL9Q9iNyZLesMM1io2ErZnRTcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962283; c=relaxed/simple;
	bh=pCePNRJ/Geejast6eOyH3mTBkPFdK4IanixiX5nAZ5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Silqi45aiOSQgH92rz/6/0RQYkTGML1L+qx6LxSCXm3jDUbW7bzIUhNXCF81LQOU4+95P0pIxJcgD93JC5JvCtCgylHDyxHy2MJxCIAW2x60/BpFiK3mnCDslxgpaZ+mbNOiOr87brrg424A/gBMcjZY8Acm7iXq5xXfkSm2ZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=N5mDZd3Q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b73161849e1so812978366b.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 04:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767962280; x=1768567080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmgtpSCyUdGCs6k4As/mmm3rTuvH18R6z3Rt3Vmk304=;
        b=N5mDZd3QRQgvD43sruTN0c8C6CT7Z4wvyV/ZAK1P1InsK/+gkTP4L76QtdEXyMsCRK
         MYPIzksFeMATckY0tibFlpDCOSIpIh5WZ1YNpU72TMYbpJg07paRlblbHPRUGGOBwE95
         De8q3MRXK+li1zON2We64DlaayQEGqCqk5iGhVP+h9wD1JbeWbztcRGlFAj2bw7ttCGz
         V9eo3U2wsnu/aN7KI+TpOljh5E0MKJW1abOLXNBYqmhN1hplTJ/se7bZgZE+0FB7HYI9
         2Pl+W0WYz12b6UeY5eL29Yn1Arj/wMtcBe9MWRx7lrQ+cFvW0vLS6zdAmhW8zshqlcIj
         RyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767962280; x=1768567080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmgtpSCyUdGCs6k4As/mmm3rTuvH18R6z3Rt3Vmk304=;
        b=TszZ5mAJ9GgRL4wxuTtDMvmBP1vXKBA/1un4buGW2rhPxnQzftwtvYsK+B1MP8qxcZ
         Me4yemm5EixOez9OA/A3pWSx2Kug60l45XMOZiYvn+AhuKlrnqCjKifjgZDKKJS9Tg5x
         8Zr3gjnozvWNqV45wb1miXGVYzPX0H6QQo/q1s7iZ3R+6yFpLzgUjyu1sxBi+FuzHhBn
         y511rUlRW3qh5uG2JF8Iz+i76FXZauW9HMmsgTS9FxuT3QCX6iQMDCBU4L82K6hsKq5I
         YTGxcbewMjS2fEw1W0J2r13EDWbOIM6XOz2v9Csi+bsD0l0O2HRrpKsEkOPCVgO26VRk
         vuFw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7w/5jKcI2LxR1G3AMJKuuheqESqC0AtkKfgkew1T/8dQgdusvhN3y6ZAYZYS/wwCoLysTQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGwlrUtIoWnu4T9t3rZyU7+ZHTB1DRJp1CiGrbADKwfAeZpoi
	WzQkIEomFSTSBbyxcJLbVcKs6dZWgD9ETmnKQba2xvAqziJWCnhI631403/B+H1rzlSesmg21XO
	pv3XQ
X-Gm-Gg: AY/fxX5kAbPBJh8du9c5dvHP7D3CZC4zgPUP6eX8oHaSmQAUIW2KKFfhIypwMtmD69+
	Otl/BoKpVsVpvzBuyNFdClsCwZRZ3p2yv04fTcaI5i4NR60m1h+mPwA7sJcnukE/miW1XTqS4xw
	JlrW9Bn6Tam7PWhGJwIO6AxUqnOCCQIc/PYJxZDLfoR5Am0xpgXvF+Bxy2tgSlti8srxn+o2BeK
	54xtHsgGSmU7BOe9X/v6rOnaBIckoLjW8l3v49ZlUgTlrk7pwrkSF1uM7Xq20UGxsr82W9hySsJ
	dtyF1oPnAx8xXspPEQnciMmcVt405kJEQN1BQoa2pzMNigr9fnIJCZ7fy2+l7GK5vrBztZfzXBY
	PZHfCpcrL/pFT8wWTcrA8sQPgeTG1N0xQIzswm+A/JDHGAZldp9f3uN6j9x0bVgkFuneCimoAuw
	Q/K5vt5vOMQPmpqScCniIa4NYjlg84hdBCpzTg7oEMUvxXwj4LxwvlyLrDW9/v8I8JmKPuwA==
X-Google-Smtp-Source: AGHT+IHsPgR40X+wpRAxVOPhgYu8DNrZZqYCCRvBUPPDWd4i/4gQVDgk51cykP0uAeUN5jiSR6miNg==
X-Received: by 2002:a17:907:3d02:b0:b83:3716:ca6b with SMTP id a640c23a62f3a-b84451c7c7bmr942769466b.17.1767962279632;
        Fri, 09 Jan 2026 04:37:59 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5118eesm1089541366b.52.2026.01.09.04.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 04:37:59 -0800 (PST)
Message-ID: <fd629b2e-79ee-4edb-9c5a-23aa803db6b4@blackwall.org>
Date: Fri, 9 Jan 2026 14:37:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v2 4/5] bonding: 3ad: Add support for
 SPEED_80000
To: Mika Westerberg <mika.westerberg@linux.intel.com>, netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>, Ian MacDonald
 <ian@netstatz.com>, Salvatore Bonaccorso <carnil@debian.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jay Vosburgh <jv@jvosburgh.net>, Simon Horman <horms@kernel.org>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
 <20260109122606.3586895-5-mika.westerberg@linux.intel.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260109122606.3586895-5-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/01/2026 14:26, Mika Westerberg wrote:
> Add support for ethtool SPEED_80000. This is needed to allow
> Thunderbolt/USB4 networking driver to be used with the bonding driver.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/net/bonding/bond_3ad.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index 1a8de2bf8655..e5e9c7207309 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -72,6 +72,7 @@ enum ad_link_speed_type {
>   	AD_LINK_SPEED_40000MBPS,
>   	AD_LINK_SPEED_50000MBPS,
>   	AD_LINK_SPEED_56000MBPS,
> +	AD_LINK_SPEED_80000MBPS,
>   	AD_LINK_SPEED_100000MBPS,
>   	AD_LINK_SPEED_200000MBPS,
>   	AD_LINK_SPEED_400000MBPS,
> @@ -297,6 +298,7 @@ static inline int __check_agg_selection_timer(struct port *port)
>    *     %AD_LINK_SPEED_40000MBPS
>    *     %AD_LINK_SPEED_50000MBPS
>    *     %AD_LINK_SPEED_56000MBPS
> + *     %AD_LINK_SPEED_80000MBPS
>    *     %AD_LINK_SPEED_100000MBPS
>    *     %AD_LINK_SPEED_200000MBPS
>    *     %AD_LINK_SPEED_400000MBPS
> @@ -365,6 +367,10 @@ static u16 __get_link_speed(struct port *port)
>   			speed = AD_LINK_SPEED_56000MBPS;
>   			break;
>   
> +		case SPEED_80000:
> +			speed = AD_LINK_SPEED_80000MBPS;
> +			break;
> +
>   		case SPEED_100000:
>   			speed = AD_LINK_SPEED_100000MBPS;
>   			break;

You should also update __get_agg_bandwidth(), otherwise the
aggregated bandwidth will be reported as 0.

Cheers,
  Nik


