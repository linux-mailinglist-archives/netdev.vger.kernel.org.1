Return-Path: <netdev+bounces-80652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EE78802CF
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984AA1F2145C
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D75517556;
	Tue, 19 Mar 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZSNIrDn2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF413ACC
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867396; cv=none; b=mT/lpQtNkbhjXjkgxDLel+0F011F084HNTW6xpaTX5suy2yho+ubsDEpeU5Veyek/m+JLim657I4C/qyJLiS/yyQITh5MOv3L82lvtEnwcnBIQ9MHK1Kf3Ch7oBjhFFllRZZauq1dE5ozR4Cq7kYvVzveOGnQg0MznVyTCoMpQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867396; c=relaxed/simple;
	bh=zwV5R1fNKUksTn3FQN7UJ7oJ5fpusan9TRq/gW9aPlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADQ9of7SNZP95MMZWgt15dHdge49BrVeZYXnG3aWiTzODi4Pvbn+yp50KSLNidhnQOmS72BVVEwnPzzUb7bChA3WldspOpSXcZIANI8fUWysPMZIZzSumHn6NH3zsZlwMpUt9MQKYzt4ihG9av1KgFmIhgIAscm6HFmb22yR4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZSNIrDn2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6cadfffdbso5327422b3a.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1710867392; x=1711472192; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoWaAZ2K6qJ4R2UuvRzu9RVM/I7b3YdO0TPiKDDBaBs=;
        b=ZSNIrDn2evglcqSIAEMG0wGn6hTPTeZFKRn9tLL32aSTMuw1UJykah4UJbBCJtF4Il
         jHY7JIRrgXan5Ft9kXSDocVAvLY1gITIYNZ09/d8/8FHtOAqA/mU0mwxrE85anQL94rs
         mmIXugYV7fxMpWigdaRfNIFkt+BdlJkXXB0CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867392; x=1711472192;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hoWaAZ2K6qJ4R2UuvRzu9RVM/I7b3YdO0TPiKDDBaBs=;
        b=GtsrSLDQeS5fGsLSYFQRM6liJCbFGDllScDNr2iZqBe8x2mMqV+UAPAf1z6jvvzoa0
         Bwa8qpQjDYgWeWUuPGCHTZoB6uw8wZReu/tcMTwZaZbVttZZDlXN+76UoNLxDJ04p3K0
         pqhDxb5o6EqfhfVNsUXJwHgxFjqYpdLN/ME+qphb3AeLvCmZzgaObW6uNteVu+w5cMre
         IYPt8OO1V45gEujEthjYDT9D6n01B97LCQh1iSk2yEQ9BrLOjYLHrodReEZUfqagZstV
         nt8CzKraEZjhNyA0X9m97/uAd7lRBj2E91Nvst/hBj5Fb0ovOIf3Dp8eU34tGM4nUvn3
         Ll3g==
X-Forwarded-Encrypted: i=1; AJvYcCWan+ixuOVsBCgFSFuD4Pvtydv5yktFrIcyXDxgPWVkasAu+ziuZMhAepa0YK6WjkrborcOHMss09BBw9+KaC12g5fFDM0F
X-Gm-Message-State: AOJu0YzeO8UTGw/6RS9gEgLkkbWr9bMvdQXNiv0Bxbm/byfU2lHrjl9V
	UhgrX65qGpa3b0x5hvy6jgeyO7aK9OSQOLHHgXpW+EQgDHE7YDNoQ2X2d/R7rA==
X-Google-Smtp-Source: AGHT+IFKO5VARD+AaOQlquzPE5/fmFqiWWXZd1tRDAfGpo2FSzQFEf9lzIerKzTE3JBXhpJbO+2Njw==
X-Received: by 2002:a05:6a20:84a5:b0:1a0:e089:e25e with SMTP id u37-20020a056a2084a500b001a0e089e25emr11088610pzd.46.1710867392293;
        Tue, 19 Mar 2024 09:56:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y9-20020a62f249000000b006e6854d45afsm10175180pfl.97.2024.03.19.09.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:56:30 -0700 (PDT)
Message-ID: <eb1130c7-ba38-46ec-9c3c-6352be3870b1@broadcom.com>
Date: Tue, 19 Mar 2024 09:56:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bcmgenet: Reset RBUF on first open
To: Maarten <maarten@rmail.be>, Doug Berger <opendmb@gmail.com>,
 netdev@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Phil Elwell <phil@raspberrypi.com>
References: <20240224000025.2078580-1-maarten@rmail.be>
 <bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
 <f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
 <16eca789cf7b513b74de03832bd4cbf3@rmail.be>
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
In-Reply-To: <16eca789cf7b513b74de03832bd4cbf3@rmail.be>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000033f7580614065b7d"

--00000000000033f7580614065b7d
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/16/24 04:53, Maarten wrote:
> Doug Berger schreef op 2024-02-27 00:13:
>> On 2/26/2024 9:34 AM, Florian Fainelli wrote:
>>> On 2/23/24 15:53, Maarten Vanraes wrote:
>>>> From: Phil Elwell <phil@raspberrypi.com>
>>>>
>>>> If the RBUF logic is not reset when the kernel starts then there
>>>> may be some data left over from any network boot loader. If the
>>>> 64-byte packet headers are enabled then this can be fatal.
>>>>
>>>> Extend bcmgenet_dma_disable to do perform the reset, but not when
>>>> called from bcmgenet_resume in order to preserve a wake packet.
>>>>
>>>> N.B. This different handling of resume is just based on a hunch -
>>>> why else wouldn't one reset the RBUF as well as the TBUF? If this
>>>> isn't the case then it's easy to change the patch to make the RBUF
>>>> reset unconditional.
>>>
>>> The real question is why is not the boot loader putting the GENET 
>>> core into a quasi power-on-reset state, since this is what Linux 
>>> expects, and also it seems the most conservative and prudent 
>>> approach. Assuming the RDMA and Unimac RX are disabled, otherwise we 
>>> would happily continuing to accept packets in DRAM, then the question 
>>> is why is not the RBUF flushed too, or is it flushed, but this is 
>>> insufficient, if so, have we determined why?
>>>
>>>>
>>>> See: https://github.com/raspberrypi/linux/issues/3850
>>>>
>>>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>>>> Signed-off-by: Maarten Vanraes <maarten@rmail.be>
>>>> ---
>>>>   drivers/net/ethernet/broadcom/genet/bcmgenet.c | 16 ++++++++++++----
>>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>>
>>>> This patch fixes a problem on RPI 4B where in ~2/3 cases (if you're 
>>>> using
>>>> nfsroot), you fail to boot; or at least the boot takes longer than
>>>> 30 minutes.
>>>
>>> This makes me wonder whether this also fixes the issues that Maxime 
>>> reported a long time ago, which I can reproduce too, but have not 
>>> been able to track down the source of:
>>>
>>> https://lore.kernel.org/linux-kernel/20210706081651.diwks5meyaighx3e@gilmour/
>>>
>>>>
>>>> Doing a simple ping revealed that when the ping starts working again
>>>> (during the boot process), you have ping timings of ~1000ms, 2000ms or
>>>> even 3000ms; while in normal cases it would be around 0.2ms.
>>>
>>> I would prefer that we find a way to better qualify whether a RBUF 
>>> reset is needed or not, but I suppose there is not any other way, 
>>> since there is an "RBUF enabled" bit that we can key off.
>>>
>>> Doug, what do you think?
>> I agree that the Linux driver expects the GENET core to be in a "quasi
>> power-on-reset state" and it seems likely that in both Maxime's case
>> and the one identified here that is not the case. It would appear that
>> the Raspberry Pi bootloader and/or "firmware" are likely not disabling
>> the GENET receiver after loading the kernel image and before invoking
>> the kernel. They may be disabling the DMA, but that is insufficient
>> since any received data would likely overflow the RBUF leaving it in a
>> "bad" state which this patch apparently improves.
>>
>> So it seems likely these issues are caused by improper
>> bootloader/firmware behavior.
>>
>> That said, I suppose it would be nice if the driver were more robust.
>> However, we both know how finicky the receive path of the GENET core
>> can be about its initialization. Therefore, I am unwilling to "bless"
>> this change for upstream without more due diligence on our side.
> 
> Hey, did you guys have any chance to check this stuff out? any thoughts 
> on it?

We are both busy with higher priority work and I cannot see us being 
able to dedicate any time to this issue until April.

While we are sympathetic to your issue and you having upstreamed a fix 
for it, it is entirely self inflicted by having the VPU boot loader 
firmware not properly quiesce the GENET controller, at least based upon 
the description, therefore the natural fix should be... in the firmware.

 From my perspective: NAK.
-- 
Florian


--00000000000033f7580614065b7d
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK7AXPAkOUtlZR6k
x/UfY2G7NgSgvJ6VQRhVjWeuZq9gMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDMxOTE2NTYzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDS+m7wlCXAJ1jWQvdzwHgGSgWm7l+OFrpJ
v7dX/vZEJBJO3az2HR0ksrh4lYBXhlRuNWpdSvZog+LhOoLUOoEzzRRom+tywbT9xlwBrVQaVDD5
snTWI0yXeUji09aO4LEQDnbF4CSWrgMADuKAnan0rDbedOO6GptkEtn7vGAn7ysuGpUQ/OC/J5U4
s/xghm+CcBxM7nv5knUZM7shehkBH+uhVEkylZ26BG2iDnkoSjkpikw/8uTAKdv6RHrhlrpO3dyI
vYQfZ1nH1eV46MJw4X+d9xNGP6VVdLE9/sXW2xk170LRcqTNVSsPfjSNYDON7oJSzdw7tZ1hs6/B
7SAq
--00000000000033f7580614065b7d--

