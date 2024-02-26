Return-Path: <netdev+bounces-75073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F86868149
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA181C285CE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2D12FB3F;
	Mon, 26 Feb 2024 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZzKp1kRG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3901DFCD
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976536; cv=none; b=shuftd3IMDGsAy1QLgRP6ZYmOWybEvKpy7qVAp+PUVaWU3OoKX0Ofs/i1w3ORciuQYOW+/j4URyoLM9faE9VgHpZtgDI95y2xb1VUkbZ3dFnOkiuozc6TS71Hzmo8p+PBbN86VhpUjN3Q2AvuDWnY0qztFwziy7XMbWlqrwUwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976536; c=relaxed/simple;
	bh=bXIckHVFUNSMjC0w/2lHUBaQh34SabMAerU84cjCgYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Md36TFlAO+bW8Gv5JQT8JpPsNm+ZtzIvrxGHQyOy7Jk8RhXGnMazJ2YFikFctSoRyBjvpAP/Pq0261UDuPu7M5XICy8gx9nU+8RRM1UfdZYtPRBNAPq5CpI9Jlj/LWexGMAdouqxbiQOKp9jH7qyImrx/D2yWWMNYl5FqZPuMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZzKp1kRG; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68ef590377aso12465736d6.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708976533; x=1709581333; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wPZSYx7ujwoOvqtapXmngtP+lqO8obP+FOgMAvyINFI=;
        b=ZzKp1kRGHctvvRyjCMPruTW6kEKfzQd9xRouyjDI6P2NxLdS4aM9tU7E/bThD47dFB
         f/iQSanxIQK9dZCygNREaumstZSbnTp7u1PNVCN852Hz20IkcnpNa4XXtvg4sapm5m8t
         T89ZoR6kZsFcAJcq3K6vqA9r3bVkM9uDq77oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976533; x=1709581333;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPZSYx7ujwoOvqtapXmngtP+lqO8obP+FOgMAvyINFI=;
        b=g3cOlkvpUMzWThcUWl0vlJyBt85pDSdq6xJkmJRBWyFpESNNEBchSRxgAcVT6Bvpkt
         ggMnsuqkiNOY+PIWG4DSrYL1sSmLoMqelobwV17DZGu1pUdEbA1m+Dq55HqNFxaHv2uk
         HDe189czaCoqXTvcu6u84Ovgcxfxu1KMINYIDA2cfcNa1Qtzqp+RHUTJBYdsX4e4M/om
         wI0RtTkXVwF69LnKIkr+uTm3kv3XgUyePow/lca4W4ebxKETc8W8sqeLYqvkEW75Yjdy
         HFyf8c7I+uiq5fxL3UIxK9xFYzQm0LaHgYa8PbTja3sDzhNxiT47ATO6c5Vc5NsbR4s0
         JEsw==
X-Forwarded-Encrypted: i=1; AJvYcCUQAvDm6jlbmjtVMGawSUCbfS3OCipYW5wUkChKS/KTq8Um7wQRHmpRhJamMKAX1AgQk7JHZL++tryYXNJLk5hBMoonhle2
X-Gm-Message-State: AOJu0Yy5yYw/qhEI5CDIPQxiFvaIXjl90F1G2oVzYq4UMoWOsUtxTZyS
	054a6Un4vg0ncG62NHLLvLP5oLS3K/C6MhbkoQZuiqIce1TcpqSnRUzE0K+Ksw==
X-Google-Smtp-Source: AGHT+IFIUjgr9Pr42P0T3vSgrnGlm/GOsIPOky9cChtXWCjg6r3k1pxqbPrg/CFJwArBgAyW+70QWA==
X-Received: by 2002:a05:6214:cae:b0:68f:8ddd:aad3 with SMTP id s14-20020a0562140cae00b0068f8dddaad3mr173321qvs.20.1708976532987;
        Mon, 26 Feb 2024 11:42:12 -0800 (PST)
Received: from [10.69.74.12] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f6-20020ad45586000000b0068f920768a5sm3225619qvx.140.2024.02.26.11.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 11:42:12 -0800 (PST)
Message-ID: <b6c74bbe-89f0-4201-b968-57996f0e0223@broadcom.com>
Date: Mon, 26 Feb 2024 11:42:09 -0800
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
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <b9164eae-69e2-44f3-8deb-e3a5180e459c@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000328e9f06124e1bf9"

--000000000000328e9f06124e1bf9
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/24/24 2:22 AM, Krzysztof Kozlowski wrote:
> On 23/02/2024 23:24, Justin Chen wrote:
>> Add support for ASP 2.2.
>>
>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>> ---
>>   Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>> index 75d8138298fb..5a345f03de17 100644
>> --- a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>> +++ b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>> @@ -15,6 +15,10 @@ description: Broadcom Ethernet controller first introduced with 72165
>>   properties:
>>     compatible:
>>       oneOf:
>> +      - items:
>> +          - enum:
>> +              - brcm,bcm74165-asp
>> +          - const: brcm,asp-v2.2
>>         - items:
>>             - enum:
>>                 - brcm,bcm74165-asp
> 
> Hm, this confuses me: why do you have same SoC with three different
> versions of the same block?
> 

bcm72165 -> asp-v2.0
bcm74165 -> asp-v2.1
Are two different SoCs.

The entry I just added is
bcm74165 -> asp-v2.2
This is a SoC minor revision. Maybe it should bcm74165b0-asp instead? 
Not sure what the protocol is.

Thanks,
Justin

> Best regards,
> Krzysztof
> 

--000000000000328e9f06124e1bf9
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
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGvaHLPlnvjYM31I+CH+MHbjhayJqjU9NQl3
56b0p0/OMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyNjE5
NDIxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAglDoxk1yyJQNEkLjXw5TzHKfIIX3Z4waYO8B6WzQpiyOoGdCWb/UU
zNKdDiRvfnT7eQ0dr+xWsoQXLyFPIKbK3wzGXZY7x9YrIWtLKgik/DbIBzmWWB1I7Kl9hledKd38
dQyZSDrrlObxnXRpkpDf1Y/XJu7xGBPkXE6jK3HmhewZpa2t47aqX0bSPG4fRMAmds0hx44bpIJc
FmI/GxH6isMjQCr5m3S7iOMbrxiBTCPv3w2k+ksSUHG8JrIjIFd07AXsjusxarBDAkoV8ZfmuCUj
hVWA4c7TVwyZ1sqQ2VDBi6tivtZ4ijyyxcgnUK87BK6QHtBcdPRZvvP17IXX
--000000000000328e9f06124e1bf9--

