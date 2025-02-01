Return-Path: <netdev+bounces-161946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6240A24BF0
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 23:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9FD1886026
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 22:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7821CDFBC;
	Sat,  1 Feb 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9N+2Jmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3825632;
	Sat,  1 Feb 2025 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738447340; cv=none; b=kesbIK9li6+dQop2x8NMWeCDj7dLvmxbdYuwo1jxSKpJD16/lkr0os8O+6Xo6FFZ7vZUtqzVB0L1yLvJ39Ho4pSrerWz6xExS3mKEexoQzqHNKMh+15EOpInldRTrCh9xBuXq6KNC1PoicIiyJJcNkGOt0+YK3DeCwBazfFTamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738447340; c=relaxed/simple;
	bh=YOKZ8tm/XM+Md6LtDQtHHnnpOZKljrjRnPwzYlDh464=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1ttQn1bYhksDFlwNZ7YWh8PWk7wmwF1cHjBMOXzpJxWhxqqgLitx6foPtrYpLy0zXPd9KPcIraYQumaOjNMi9HRSaYedESktwUE5RsaLfaZGznut/TtZFlNxKlmNX7qcL4R0sJYsO8oBJ2O39Yk3JR1NGlDgpSbfvNTfxaU1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9N+2Jmj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b1f05caso52564305ad.3;
        Sat, 01 Feb 2025 14:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738447338; x=1739052138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yZTYWsQ2rXMvswbcnWNhWM5wo7jgjGDZPXJeK35/HXo=;
        b=k9N+2Jmj3nS9lRn1ZqiFzLBSqyrBREWwU3Pn32kPOURzae+FhhPvrZ/3ILlfxbdPsB
         YJ2KLQFtfh9unyapju/fYd1B4FfEG7c6tfZNFyHFFRr0CaG5DSUHatBR/TUIJWvc4C8E
         JXMGk+H0gNVpPstJYbjI/gT6a3elGGakafy5Ed+IBGwZF1z8a9vGfYViDocmMHSbKqiz
         9WC5pvRMk34rwseMv/eSngBKxBGoq85xk1XPbeR9N+n61OGlpPVbaqx9aUKe6sepAqUS
         1KQVBLqEBtvGMSH5qQnKlfrNMvyjzCAoRJ+W/xBALV7B68IWx6eomp9jxAFOvVTeI3B9
         dc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738447338; x=1739052138;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZTYWsQ2rXMvswbcnWNhWM5wo7jgjGDZPXJeK35/HXo=;
        b=i7gSkejAsdUfuVJPC/DdKhlo/3+e29Eqiwk2JYpGNNjYe+/y9rMDSfXKdyVNXtF+Z1
         aZ2I4V3HSxrocogrmvdm2qNx7QOx+hdGeRM3/VcbLnbkxk/9vBabdnzi3mGn1EgIdVO4
         82jeaLsENLZeF26wtCpG6Rj8ZhQjtX8VSNaVE/ekbFTRZyKpYlWDBWYzSPLiA4nWhj6H
         9s5XWSob2J6Wu+xwD6SqWK1vv+HA91pL2wZecuQ2Z93YqL81eArgFdTzqELZRnQaQ1hB
         14B/bsTMazyE4iEh+OAmnkllkqpc9KGdkISAlAxUoJPHdBnVvNITdtVBRBwb2jiQEs8c
         csfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvHdfyOE+h1acAhe0HcmLr9PicPp67/Icsb9I29FClyGcxzyIYyi5b8MyM5t5VDn0ctgbxaDic@vger.kernel.org, AJvYcCXUwCptB0pMFrxOa8FloVvx5BK7uCTBrLAns7kQq0TxTIUt88AgsqrLkR+P5eWO2HWxP12IoxoLJWlM4sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxix9iNgbj1wYZZorG09SL/vccomCZzjXTjzucNTGiTt8gpsV1/
	IcQxouByGBpPRoSSQl50VEu7vGwnrnk1l5sVTivqhdnFXRWWUTeH
X-Gm-Gg: ASbGnctri3HdlGyqkrP3CzkZ2ART4xM9S9J+Ti5i7iBbm5TWBovSwXPkGaXihQLzsYp
	FrzTgZ40SEXAy1Kg2DEhyZ7oOERyvn66yY1JOEULuas6bA2NXWft5Hpt04JSsF4jROg1YjYp7NJ
	3eGYM9oJU2wHIvY9nrqTDPuU5vo5NDTbPuDfGSgcNqnos5WxaEWAS5+isV4WOON5vC1v2gzgkc5
	cb+0G6CCqJYRTBFgN04gO3ZipnBzEEHeAhBPbGVdFtYNNpFkR29nMgzpAlGWn1TAMxdAywdNbrq
	qQva4E6kcrDLfaYf+s10h1fQDr9ioY2yIel8H64Gf+lEwAIfP8iy2sWxCyi0ZwVb
X-Google-Smtp-Source: AGHT+IESOLZrNPRE8eNq6AjXqLjXF+vkm3bCDTeO+deTf9IYocKz/OepfOidluOgF5vpIheeDhFc5g==
X-Received: by 2002:a17:902:f606:b0:215:89a0:416f with SMTP id d9443c01a7336-21dd7d82c71mr242374595ad.30.1738447338310;
        Sat, 01 Feb 2025 14:02:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ebabasm49881245ad.129.2025.02.01.14.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 14:02:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8c2ecfb0-cfbc-439c-a0b5-b9e18a5eef98@roeck-us.net>
Date: Sat, 1 Feb 2025 14:02:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability value
 when FIFO size isn't specified
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net>
 <Z56FmH968FUGkC5J@shell.armlinux.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z56FmH968FUGkC5J@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/25 12:35, Russell King (Oracle) wrote:
> On Sat, Feb 01, 2025 at 11:14:41AM -0800, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Jan 27, 2025 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
>>> When Tx/Rx FIFO size is not specified in advance, the driver checks if
>>> the value is zero and sets the hardware capability value in functions
>>> where that value is used.
>>>
>>> Consolidate the check and settings into function stmmac_hw_init() and
>>> remove redundant other statements.
>>>
>>> If FIFO size is zero and the hardware capability also doesn't have upper
>>> limit values, return with an error message.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>
>> This patch breaks qemu's stmmac emulation, for example for
>> npcm750-evb. The error message is:
>> 	stmmaceth f0804000.eth: Can't specify Rx FIFO size
> 
> Interesting. I looked at QEMU to see whether anything in the Debian
> stable version of QEMU might possibly have STMMAC emulation, but
> drew a blank... Even trying to find where in QEMU it emulates the
> STMMAC. I do see that it does include this, so maybe I can use that
> to test some of my stmmac changes. Thanks!
> 

Support was added in qemu v9.0.0. See qemu commit 08f787a34c
("hw/net: Add NPCMXXX GMAC device"). It doesn't directly say what
the emulated hardware actually is, but the commit message says

     The following message shows up with the change:
     Broadcom BCM54612E stmmac-0:00: attached PHY driver [Broadcom BCM54612E] (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
     stmmaceth f0802000.eth eth0: Link is Up - 1Gbps/Full - flow control rx/tx

so that is a bit of a hint.

Guenter


