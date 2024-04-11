Return-Path: <netdev+bounces-87130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B148A1D64
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D027D1F2261B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B61D8EC5;
	Thu, 11 Apr 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FapsvyxN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3321D8EAC
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855062; cv=none; b=Wv4ZOB5ezTmOIi26s2wdCzc7VmhZu34NxKfemRr/awOF4hjZasbe5jTOiTVkQrO2lM+WLvV+dYkRLBYx2w01qzzX1MrCfjNJYXoqH5yKBIIRoxB8HvCn9TqOSYBHj09WSU/JYuaOcBwd4P0rWVDv7+T2O5sZ+1Fwa2Fj8wfFzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855062; c=relaxed/simple;
	bh=YGvm3YXGse5Q1PZcNcDRbABSlYxDJ1DW+EyV5hLN/GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGoE3bXp2Eo9JxIUiLQ/ENdDKWcqSXz46gWcnrNcYRAG7GMhFZc2o75q4FBdT1OLemyUKwIEf6S5UN2m1+3IwzvhPwQU8VV3UsO27yYhkSW+LWIeFpyyTIue6qkjw6KQO2as4IRT90ygvgT85PV45eE3/0XbvM4dWCQRb9jbUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FapsvyxN; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-434b7ab085fso9843541cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712855059; x=1713459859; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8LcVnNJSrlTbXTLRxAvFdyeQS4/G7FICNtP/E4UgmI=;
        b=FapsvyxNp9x4lIAEAavkI9BPN0YIgJ1SrJpua75CBZzXZya0/edi2qdvuYbCXVkyDn
         jJwmVgnzXO7MGyiPb1mDHecU6nSjusnPB+/MfCWzGjjA2O0XDF1vFXNIbi18dRK1xnog
         T9Q2p1PFTlvRmKtJUxmIf5HHn16MfFDX4Q3PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712855059; x=1713459859;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V8LcVnNJSrlTbXTLRxAvFdyeQS4/G7FICNtP/E4UgmI=;
        b=B1MNx1F2MX1einudvYGpndK5e1kf+zbPBKnlYhdjR718ap9ykMKn0O09F1C04yjy7n
         J0wFf6QITXs75j8csxORt3rCjvlnDZGLHO3ley4q87uJ0ji4+dRh/dbNuspgg2lYNIFo
         c2fDJjvQG4YFu19591UIFImVZaJOZX+UVWAUbfIWki7Yro3zM3nyf78BACq5MhFRbQsO
         Tm+da4dv1s0fdRzuR5a4Q3OBImgbhlfLjWojvgiS+Oy5JYVkEkWB34bACv62UoTVRYVC
         aB+RRZe84DtJMvl0zbaHb8+wm8t3UTY/hG+QrKSBVlOv/ukWvSshgrosS6A9qWPyh0gW
         mGXg==
X-Forwarded-Encrypted: i=1; AJvYcCW44SaJvj5DJfbQ3YmEOQYZPiT9POqqL2g9ddBYU+TtPwzooXZ2gIQl/rvYM4ce5qffH4ksmiIuo4IqFFH8qMuAadOJVBA+
X-Gm-Message-State: AOJu0Yza/xKG/hBhHl+8cZh8cRN5TCJDhc5B6E2ouaRHQYzT2rBZfQWG
	WOnPQ9QLrx3KTgyHcGu+fbfz8iwbrqPT85NNG3xdDO/Yad/abTJPoleDhwVWbw==
X-Google-Smtp-Source: AGHT+IHArwTviBOsq97436WyOMhDZL9GJhRdTZpc/jQE3RtNru32WX6ZtWnGP4YHCqmqB1fqdxuxkg==
X-Received: by 2002:ad4:5741:0:b0:69b:5054:32e7 with SMTP id q1-20020ad45741000000b0069b505432e7mr2833537qvx.5.1712855058879;
        Thu, 11 Apr 2024 10:04:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id px11-20020a056214050b00b0069b534fb8b0sm231458qvb.59.2024.04.11.10.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 10:04:17 -0700 (PDT)
Message-ID: <cb4695ba-8107-4810-b859-da102dd2bfba@broadcom.com>
Date: Thu, 11 Apr 2024 10:04:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: genet: Fixup EEE
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240408-stmmac-eee-v1-1-3d65d671c06b@lunn.ch>
 <4826747e-0dd5-4ab9-af02-9d17a1ab7358@broadcom.com>
 <67c0777f-f66e-4293-af8b-08e0c4ab0acc@lunn.ch>
 <c2a16e3c-374c-4fd1-9ca7-bf0aeb5ed941@broadcom.com>
 <ZhdycHAooDITV1a3@pengutronix.de>
 <843316df-162f-4551-97ec-8e30dc054b41@lunn.ch>
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
In-Reply-To: <843316df-162f-4551-97ec-8e30dc054b41@lunn.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005c18630615d52556"

--0000000000005c18630615d52556
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 07:35, Andrew Lunn wrote:
> On Thu, Apr 11, 2024 at 07:17:36AM +0200, Oleksij Rempel wrote:
>> Hi Florian,
>>
>> On Wed, Apr 10, 2024 at 10:48:26AM -0700, Florian Fainelli wrote:
>>
>>> I am seeing a functional difference with and without your patch however, and
>>> also, there appears to be something wrong within the bcmgenet driver after
>>> PHYLIB having absorbed the EEE configuration. Both cases we start on boot
>>> with:
>>>
>>> # ethtool --show-eee eth0
>>> EEE settings for eth0:
>>>          EEE status: disabled
>>>          Tx LPI: disabled
>>>          Supported EEE link modes:  100baseT/Full
>>>                                     1000baseT/Full
>>>          Advertised EEE link modes:  100baseT/Full
>>>                                      1000baseT/Full
>>>          Link partner advertised EEE link modes:  100baseT/Full
>>>                                                   1000baseT/Full
>>>
>>> I would expect the EEE status to be enabled, that's how I remember it
>>> before.
>>
>> Yes, current default kernel implementation is to use EEE if available.
> 
> We do however seem to be inconsistent in this example. EEE seems to be
> disabled, yet it is advertising? Or is it showing what we would
> advertise, when EEE is enabled?

What I consider to be the "canonical" behavior is the following on boot:

# ethtool --show-eee eth0
EEE settings for eth0:
         EEE status: enabled - active
         Tx LPI: disabled
         Supported EEE link modes:  100baseT/Full
                                    1000baseT/Full
         Advertised EEE link modes:  100baseT/Full
                                     1000baseT/Full
         Link partner advertised EEE link modes:  100baseT/Full
                                                  1000baseT/Full

whereby we advertise EEE, the link partner does too, and the adjust_link 
callback determined that we could EEE as a result via phy_init_eee(). 
This is seen on 6.8.

Starting with 6.9-rc and Andrew's series to rework EEE, I have the 
behavior provided before:

# ethtool --show-eee eth0
EEE settings for eth0:
         EEE status: disabled
         Tx LPI: disabled
         Supported EEE link modes:  100baseT/Full
                                    1000baseT/Full
         Advertised EEE link modes:  100baseT/Full
                                     1000baseT/Full
         Link partner advertised EEE link modes:  100baseT/Full
                                                  1000baseT/Full

whereby we need user intervention to opt-in and have EEE enabled with:

ethtool --set-eee eth0 eee on

This presents users with a difference in behavior which we might get 
regression reports for.

> 
>>> Now, with your patch, once I turn on EEE with:
>>>
>>> # ethtool --set-eee eth0 eee on
>>> # ethtool --show-eee eth0
>>> EEE settings for eth0:
>>>          EEE status: enabled - active
>>>          Tx LPI: disabled
>>>          Supported EEE link modes:  100baseT/Full
>>>                                     1000baseT/Full
>>>          Advertised EEE link modes:  100baseT/Full
>>>                                      1000baseT/Full
>>>          Link partner advertised EEE link modes:  100baseT/Full
>>>                                                   1000baseT/Full
>>> #
>>>
>>> there is no change to the EEE_CTRL register to set the EEE_EN, this only
>>> happens when doing:
>>>
>>> # ethtool --set-eee eth0 eee on tx-lpi on
>>>
>>> which is consistent with the patch, but I don't think this is quite correct
>>> as I remembered that "eee on" meant enable EEE for the RX path, and "tx-lpi
>>> on" meant enable EEE for the TX path?
>>
>> Yes. More precisely, with "eee on" we allow the PHY to advertise EEE
>> link modes. On link_up, if both sides are agreed to use EEE, MAC is
>> configured to process LPI opcodes from the PHY and send LPI opcodes to
>> the PHY if "tx-lpi on" was configured too. tx-lpi will not be enabled in
>> case of "eee off".
> 
> Florian seems to be suggesting the RX and TX path could have different
> configurations? RX EEE could be enabled but TX EEE disabled? That i
> don't understand, in terms of auto-neg. auto-neg is for the link as a
> whole, it does not appear to allow different results for each
> direction. Does tx-lpi only make sense when EEE is forced, not
> auto-neg'ed?

To me the 'tx-lpi' parameter allows for an additional level of local 
control of whether TX path should sent LPI or not, irrespective of 
forced versus auto-negotiated EEE capability.

I am not sure why the API was defined like it was in the first place and 
what was the rationale for offering a separate 'tx-lpi', this might have 
been based upon a real or hypothetical use case.

If we are to honor the separate controls, we would have to agree on 
their meaning and we had discussed this before with Oleksij.

EEE_EN means that the Ethernet MAC (called UNIMAC in this block) enables 
clock gating signaling from the PHY up to DMA interface, this is how the 
power savings are actually realized on the digital logic side.
-- 
Florian


--0000000000005c18630615d52556
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
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICTJbn7/SiiUVfFk
h+NewE9NH1ew+gZh2QLyNdm7XqT4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDQxMTE3MDQxOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAvyDrgZnVKvlDpdfDe2385xGYUfs4LZyuf
AE7PI/oeR6ylohRsUdaeBrqpaIJQmQZViI7BHaE5hPn19AfZO5lHoElGLh9GBTFl17YVZkWhtObW
/49eJ8qcqrQWoYkapLEMe8oQyg4Wv98KdUfT+jeTTW06hX/5A1RCSFEeG90Cb7Grj86/Lu/zz9LI
L40E7pO4rbgDUDJ/JWvB1KBtRqjc6NrpzvYM9XvA1z4T34lvZQM4286zh9KOgD6FI6EG1fAfC9vO
rVCBzS2zvH98GTd9cFDG6VoIb4AGYxgKVbT9zJ/hXx1513xYu4Ot+Emtb0f1ELyvKh+lalQjMtw7
t1rw
--0000000000005c18630615d52556--

