Return-Path: <netdev+bounces-191661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71982ABCA24
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BFB7ACDB6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CB9221287;
	Mon, 19 May 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e3JdDpwb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F037221276
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690697; cv=none; b=nEN0K5gxoxjCyu/m6yLMJMnjwyWF8ZlQIbQyzm7wfqgeYL+kFg9X/ApEdLzuUXPyGUHsIbnboJgBcQ3KSTuZld+NhZ6Lz7HcUJQIaFi6QpfVHMrIzaQRTZZnL860w6lCbFBkL9l64e+V2xm5vJ1LqAy+TOmu+j6H0/GjD4gMAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690697; c=relaxed/simple;
	bh=Q/HNA60Js94CrhkFFUA+1o4C8hYPEeQSOnp3Ug1CF8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxVE+NTekjYDEMbTncXKC4kD/H+5ZlUFnhJEwiUvN4OI3rHcXyxWqj7hLRkOeyN5OrIHifQeZKsHIQNKmlBCvLntQ+j93+hOY8io/KwLTCIsL+rfmr3dgWDeGWS0ld2J1m9wSneHGOcMljbc2tpcbuvp2MbDn+xHVg/5lG7EESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e3JdDpwb; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-30ecc762cb7so1775782a91.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 14:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747690694; x=1748295494; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWRlUiOrTu55CN/SJEHmFIKx3B73fbjRbbtcLl/D3EY=;
        b=e3JdDpwbtTtldzinuq8COkrr1BgXijipn1SPnfv/s2hUmUiZwbPm2vJ6kqueONf9Qk
         TnYwbEU0bCv0dkURPinztRmrKfZmWG5RaF/UJkWYTwHrmMDIVXjgDcXeFshamBag+sN+
         ui6cIG//QMJxvNU2ILOHpB2bfAkY9UzDG6dxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747690694; x=1748295494;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DWRlUiOrTu55CN/SJEHmFIKx3B73fbjRbbtcLl/D3EY=;
        b=ouxPjv9UxJTFW+1oll060OGXNoaaVPHz8x5Qjqt69QYy6Bc81dItwzX1qOT7+E0Viu
         5YIjdtGWGs9bRl5uQdXtGckrUzYaTxwS7c/+gjQF64tp3wjOWv9r2zklLefsEvu+2KEo
         ngwxhasygcCPCqmFNR4wA6iGyOqTYgmHXdTVmHEhewTArhGARX3TZl7ZFSOqsTf3JPMI
         AIM9GgZj4jBo9USgJl//LR0wdlTPyXQESwzQysPwajR2lMsKDW1piZ6SxL7V+a6nr4TN
         e0PZdcDi+uz5s1FP21LQ77YAGBA2xV/jU5gsUsslcnuGesZK+Uv2otjO9uShk5+zhJR4
         zDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXliNHI+EDM0lkLWg/Pq07ScYDQr44XruuBVrtHnG1d+J8yOu37iMye5rmcvpRpxNp/6QSA0sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCY0PUw6SHmb2zeSddYUeDy+jm4cMyD7elLnRicEsRO+r5jWM
	1XYu5+jP8LmnAXppppWxDr3pYZPVauUQSpiq4M/hODIhBPqCPHgFmp/+dRw2iThXXw==
X-Gm-Gg: ASbGnctag5FmShn5cRMK4vKO3Jnq61HuLNu1OkF7T0RomTMba9s647679OcSez9UpVE
	dQw5bYFrvX0izFkKojZGiprugCIXegcq+udNyKFxZGnIMyWlVx+BXXTC9sKV8bRDLyMF5fu4WDG
	g6zh6wn8XdeHogNPBO4IzpL5qYQ1OJyLTyQLrVODt9Vgo0Rwq/ic9MHbM8H1QKT77oFvzpW95sl
	HufUxj21YEikN6q3EI1ggIZTo2AJx8F/81TgUHkneyZr/uDJyFqio8K9hZSElYuhBE0naF6f72q
	xkzjXuij6pcxb/bF4aed5kdi9fd4bv9CQVNCvJTzxGLIcUjZ8vhZpAu4dDKcuF1MwFToxNe6f+/
	BhXDryRLj6kWnPkI=
X-Google-Smtp-Source: AGHT+IG2MsRi3asODUADlwzC+y4703c6p4SK4AeUw/CM8gLmkfgO/EzI569jzFwBnrmiALyp+RRgVw==
X-Received: by 2002:a17:90b:5487:b0:2fa:3b6b:3370 with SMTP id 98e67ed59e1d1-30e4dccbaffmr26074795a91.16.1747690693659;
        Mon, 19 May 2025 14:38:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d45eesm151406a91.29.2025.05.19.14.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 14:38:02 -0700 (PDT)
Message-ID: <446fcb22-3fb5-4a43-83c3-3b22152643cc@broadcom.com>
Date: Mon, 19 May 2025 14:38:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: dsa: b53: fix configuring RGMII delay on
 bcm63xx
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
 <20250519174550.1486064-3-jonas.gorski@gmail.com>
 <ed75677c-c3fb-41d1-a2cd-dd84d224ffe3@lunn.ch>
 <CAOiHx=nwbs7030GKZHLc6Pc6LA6Hqq0NYfNSt=3zOgnj5zpAYQ@mail.gmail.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <CAOiHx=nwbs7030GKZHLc6Pc6LA6Hqq0NYfNSt=3zOgnj5zpAYQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ff8eb3063583f237"

--000000000000ff8eb3063583f237
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/19/25 12:44, Jonas Gorski wrote:
> On Mon, May 19, 2025 at 9:14 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> On Mon, May 19, 2025 at 07:45:49PM +0200, Jonas Gorski wrote:
>>> The RGMII delay type of the PHY interface is intended for the PHY, not
>>> the MAC, so we need to configure the opposite. Else we double the delay
>>> or don't add one at all if the PHY also supports configuring delays.
>>>
>>> Additionally, we need to enable RGMII_CTRL_TIMING_SEL for the delay
>>> actually being effective.
>>>
>>> Fixes e.g. BCM54612E connected on RGMII ports that also configures RGMII
>>> delays in its driver.
>>
>> We have to be careful here not to cause regressions. It might be
>> wrong, but are there systems using this which actually work? Does this
>> change break them?
> 
> The only user (of bcm63xx and b53 dsa) I am aware of is OpenWrt, and
> we are capable of updating our dts files in case they were using
> broken configuration. Though having PHYs on the RGMII ports is a very
> rare configuration, and usually there is switch connected with a fixed
> link, so likely the issue was never detected.
> 
>>>
>>> Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
>>> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>>> ---
>>>   drivers/net/dsa/b53/b53_common.c | 13 +++++++------
>>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>>> index a316f8c01d0a..b00975189dab 100644
>>> --- a/drivers/net/dsa/b53/b53_common.c
>>> +++ b/drivers/net/dsa/b53/b53_common.c
>>> @@ -1328,19 +1328,19 @@ static void b53_adjust_63xx_rgmii(struct dsa_switch *ds, int port,
>>>
>>>        switch (interface) {
>>>        case PHY_INTERFACE_MODE_RGMII_ID:
>>> -             rgmii_ctrl |= (RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
>>> +             rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
>>>                break;
>>>        case PHY_INTERFACE_MODE_RGMII_RXID:
>>> -             rgmii_ctrl &= ~(RGMII_CTRL_DLL_TXC);
>>> -             rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
>>> +             rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
>>> +             rgmii_ctrl &= ~RGMII_CTRL_DLL_RXC;
>>>                break;
>>>        case PHY_INTERFACE_MODE_RGMII_TXID:
>>> -             rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC);
>>> -             rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
>>> +             rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
>>> +             rgmii_ctrl &= ~RGMII_CTRL_DLL_TXC;
>>>                break;
>>>        case PHY_INTERFACE_MODE_RGMII:
>>>        default:
>>> -             rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
>>> +             rgmii_ctrl |= RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC;
>>>                break;
>>
>> These changes look wrong. There is more background here:
>>
>> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287
> 
> This is what makes it work for me (I tested all four modes, rgmii,
> rgmii-id, rgmii-txid and rgmii-rxid). Without this change, b53 will
> configure the same delays on the MAC layer as the PHY driver (bcm54xx,
> https://elixir.bootlin.com/linux/v6.15-rc7/source/drivers/net/phy/broadcom.c#L73
> ), which breaks connectivity at least for me.
> 
> E.g. with a phy-mode of "rgmii-id", both b53 and the PHY driver would
> enable rx and tx delays, causing the delays to be 4 ns instead of 2
> ns. So I don't see how this could have ever worked.

It's possible this was tested with an external PHY which was not 
configured by drivers/net/phy/broadcom.c?

> 
> Also note that b53_adjust_531x5_rgmii()
> https://elixir.bootlin.com/linux/v6.15-rc7/source/drivers/net/dsa/b53/b53_common.c#L1360
> already behaves that way, this just makes bcm63xx now work the same
> (so these functions could now even be merged).

Yes, I was going to suggest we should be doing that.

There are precedents with other Broadcom drivers for doing things 
incorrectly, and having to put quirks to deal with that, yours truly 
having greatly contributed to doing that:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b972b54a68b2512a7528658ecd023aea108c03a5
-- 
Florian

--000000000000ff8eb3063583f237
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIABc6NMifrvs5aoe
mHfq2lsqPthjpmWR6VNKrIfJFOtZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI1MDUxOTIxMzgxNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIB
MA0GCSqGSIb3DQEBAQUABIIBAO6i2gNh6/ZU/YpSvjBYJLJ7nU3orZh/EDArX+iNuybYh4HHWDc/
C1tXwGxtDEAfOBqvcmOxYmBtaCXCNW2G2lPx/POO5Qhm8DcIeN3z2p6ufHZ3AIc5QqjlQZjzOgaf
JQpffTWEVrYT7K34Cf1skN9WXLU784nTrxQrfHFpuVXM9pXJjArWxiMrpCEVkUfuX/wY1/oQyNHD
Zrhm9OY1lGydpY/3I7Oau1IoN/ukobmTMqroyWYoC0+e4zbsxXsJj3zhMgJmJMGtw+R6WS10jSWU
m9R14BnPAwLTUs8Zz4I+7muKLolq0KGCfn7QSksTnkoDhyD+SLcOndKQolGODrU=
--000000000000ff8eb3063583f237--

