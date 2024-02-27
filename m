Return-Path: <netdev+bounces-75199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563B86898F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DD11F264BD
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905F653E02;
	Tue, 27 Feb 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZEFiC74D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7594CDE5
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017627; cv=none; b=EF2qNpcyaCtgll/htB3JawEwNMk6B7kjNiBPYZQIHpdS6LLUY5ayNJMxjLS0stwLyGuS7mBqFrUk1w7pZ/wx3mX5p8EUklwVBkcgZtLO4nIJcFpJQ85l6Ud39aP7bRYEXR3SDsn4G7RD/CpJu4QX5tJ6+TwWSHrxRNHhruW+Uq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017627; c=relaxed/simple;
	bh=zcJ7kugNLwixOpn/j7ORgzxzAmQuQHkw1OAGhNr4kBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuGUKgrifyncai901p4q1MOBSrq6biHxJnGd7oYXtDaRuy5RdvxU0RWQgRELI8nWx2IBlb0RnXMylXuEn16Cof2VDiMgSJs7tFephrXdkMzpnsZMgTRqpnlMfefbake0N+W6t0L6kTKaN9xI2lduDFI9U0rYmGfSycrpKu7a3WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZEFiC74D; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbc649c275so1921537b6e.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709017625; x=1709622425; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EC9sNzivY5kB5zPzsvVdeKVq1dGq4S2uV4+N7klXTes=;
        b=ZEFiC74DpifMv7CSVsm4OdTBAK2CfF3U1H/hRipAmZ3jP2sqn8UiI4tmMUIu4xk2pF
         Mze7UHkEbnxc576PMgaDzBm+xbGmYMl6QfRPW564xns15dFFJ9rmBAQza4ypqUSV8mBk
         m03VgR/lBEf/mzfD6lsvmocfi7V7BBThS1DYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017625; x=1709622425;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC9sNzivY5kB5zPzsvVdeKVq1dGq4S2uV4+N7klXTes=;
        b=vY9w77yDi6lXHVLLgYt3dM4CwyE07/Wv7zS15N1sZ+awajpa8QTc+K4VNaAi27PsH0
         7i/4jzFVvainDQCTsAGyV0EFkJ6OO7WXoSM8bzaEKo0NNyvMA6VK1pFVOMvV9eiC7dOg
         ZV+PFzfly81m25Gug0+B24SNMgzC6ORlqAO2bKBIjhc9n4uZc0KvAjb8uBUe2WxZB7+H
         4nMDqB8yXrx0ePcCpNjEosIlGpvJcPa6r5f00eYXo5kPv/B7s3DYCEc15VAZDGTufn55
         eAy2lUJT7E0IBlp5DsXULXFBtT9rIeAXWBsCmoqdY1zb8EKHKdOTqVhLTcCVlR+Z6Q2y
         WC2A==
X-Forwarded-Encrypted: i=1; AJvYcCVOWnQLSKhCqwgVr6rKikzA8H2ftTtVJLnD/2zuFn6ktzVEixot/nkordqbGdJpJVrhVMbKBwHjhknDVNFUL1KFu5rfrmhb
X-Gm-Message-State: AOJu0Yw2a9bci/Tp5ep3jAk/f+wDOm7q1SEzr8byNPp8+LdMqWhcF0/U
	7M933fDD5RWlbXphz7M/1MiQcu6cxsTS7lz168/EQmdvnnGVs/8ytrzdS5IJug==
X-Google-Smtp-Source: AGHT+IGvK4V8tH8kE5Mpe/YpieSP7d73FRXNh7KMT7O8CAfbr1Lv34SeMspDPtX0LKWZsqGLh1Tpyw==
X-Received: by 2002:a05:6808:22a1:b0:3c0:35db:683e with SMTP id bo33-20020a05680822a100b003c035db683emr1585298oib.32.1709017624810;
        Mon, 26 Feb 2024 23:07:04 -0800 (PST)
Received: from [192.168.86.41] ([136.52.74.64])
        by smtp.gmail.com with ESMTPSA id f33-20020a056a000b2100b006e45cffab54sm5190069pfu.49.2024.02.26.23.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 23:07:03 -0800 (PST)
Message-ID: <09c07d4b-6004-4897-adca-0d6211414d2a@broadcom.com>
Date: Mon, 26 Feb 2024 23:07:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next resend 2/6] dt-bindings: net: brcm,asp-v2.0: Add
 asp-v2.2
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, opendmb@gmail.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, rafal@milecki.pl,
 devicetree@vger.kernel.org
References: <20240223222434.590191-1-justin.chen@broadcom.com>
 <20240223222434.590191-3-justin.chen@broadcom.com>
 <b9164eae-69e2-44f3-8deb-e3a5180e459c@linaro.org>
 <b6c74bbe-89f0-4201-b968-57996f0e0223@broadcom.com>
 <c0e9eb68-f485-40a9-b025-82a73af06006@linaro.org>
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <c0e9eb68-f485-40a9-b025-82a73af06006@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000773a2a061257acc8"

--000000000000773a2a061257acc8
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/26/2024 10:55 PM, Krzysztof Kozlowski wrote:
> On 26/02/2024 20:42, Justin Chen wrote:
>>
>>
>> On 2/24/24 2:22 AM, Krzysztof Kozlowski wrote:
>>> On 23/02/2024 23:24, Justin Chen wrote:
>>>> Add support for ASP 2.2.
>>>>
>>>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>>>> index 75d8138298fb..5a345f03de17 100644
>>>> --- a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>>>> @@ -15,6 +15,10 @@ description: Broadcom Ethernet controller first introduced with 72165
>>>>    properties:
>>>>      compatible:
>>>>        oneOf:
>>>> +      - items:
>>>> +          - enum:
>>>> +              - brcm,bcm74165-asp
>>>> +          - const: brcm,asp-v2.2
>>>>          - items:
>>>>              - enum:
>>>>                  - brcm,bcm74165-asp
>>>
>>> Hm, this confuses me: why do you have same SoC with three different
>>> versions of the same block?
>>>
>>
>> bcm72165 -> asp-v2.0
>> bcm74165 -> asp-v2.1
>> Are two different SoCs.
> 
> Ah, right, existing bindings has two SoCs.
> 
>>
>> The entry I just added is
>> bcm74165 -> asp-v2.2
>> This is a SoC minor revision. Maybe it should bcm74165b0-asp instead?
>> Not sure what the protocol is.
> 
> So still the confusion - same SoC with different IP blocks. That's
> totally opposite of what we expect: same version of IP block used in
> multiple SoCs.
> 
>

Agreed. Unfortunately what we expect is not always what comes to fruition...

Thinking about it again, I prefer bcm74165b0-asp. Otherwise it doesn't 
properly describe the hardware as we do not have one SoC with two 
different IP blocks.

Thanks,
Justin

> 
> Best regards,
> Krzysztof
> 

--000000000000773a2a061257acc8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK2olAmGvglMprWf+NO9bW78dpc0j4rE+fNq
weWionaQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyNzA3
MDcwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAkX9/Gr8lAbPNwskqSW3AZiU4pOW9KRGrQQypoN74vPMdtMDOFE6YE
cvxI3PUYteGYBp4J78skkbPZ2RJo1DHkgEY20MNB5cg10bjOVnhtEjtXjcKkLgWy4i/v0MCN1PO8
uPvReb1cQGeIaWbCFaJoy9gxdANQYyxrsV0tyFL0K9hNy2U3brlhhQ+FJ7BOqNZGFyDUkrAop/uL
AXdgqoDbiNrKmHKQO2eye2T0IgobS0CzQCxby3I0MEeuZk5xHbwZTTZ4v1HO+z367YyR7pNyKQnQ
vP8/8j1ba9j9EGFSDVNAv/fLaa7HVwBtmsppYq47vn34QsANFBsRTw/Vy5ia
--000000000000773a2a061257acc8--

