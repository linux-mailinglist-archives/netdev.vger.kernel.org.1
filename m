Return-Path: <netdev+bounces-229330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F72BDAB97
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86AE0352EBC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B935623A994;
	Tue, 14 Oct 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cAIhpQFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF12376FC
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461222; cv=none; b=lS6IDzn1PAYIXj2yCYm64ojH3Nsi2Y/q3l6hVlD60NvTmunnaqQ+cLS5NZFiYmgNSeedjQqmxwetrjrrKMRazag+owMuXNMGeXRVPtspCyiyl3V6NhEU/WhzZlbO/Aye4VKkT/BimRq5ojqh3dU15ai0pPlM3JdhU7nJCykczqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461222; c=relaxed/simple;
	bh=4bKh6CBaGCJrIciuK2WjKe//apQDhJoVpt2PoSIp340=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz24qj6F5q2poz2LfXAY4aOHxxHhcZJGKfkRLWKE3R5KKY6OeOJ5r/Tu3o+d7wSxP9yKff2stkANXMlxGZogZWODGoBBAOuu1KwrRQdqUv7poGnlEB3oypX6MW7JzV6wKYkMpORvGBnYqIXTMKPLTS9T4VTu3amoO+uH+l1uov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cAIhpQFX; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-7946137e7a2so85506066d6.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760461220; x=1761066020;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47hy/eMh6oarfIC86oJHEXvdQdUE7mbvpox0rMjMn8E=;
        b=umDJsw4ZalIWYUNMzbYKIyjAAD7RvHheuWK8QzWUvp8OgMpD1A1q/xLBmgPctWjx7R
         BDwrus1jltPYv1Zh9NzwUIz2vAtvj1Ca3EqeS1ZmbMVRZs1045f7zRRDiEDOD9DmjDcJ
         XdQWpGEvcHCoDda5FVNIH+tNtvA/J2VDSIJBgwyml45a7roygIp25QgQ4JIS0ll70gs6
         EZEL+x/U3Tr8eZ6XemoygETfimgahZNgYF1Sv2jhCY7pfjTk1rECRzln6+BZ62QoiAjz
         AoXIZEMrbLl+KW/nQWLxWp1qqvTxYOpdMRTRZNVV3k2HIX6piwCxVL5NGvooG29uhpeV
         /3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWb6C+/mbpe3NrW78+tq6azhsdtlF8mRVwbXnnN1/Xtq13ALUn5GpDe77R4vLzWe273+WK0MWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlqTtNSBYMnHJd2vzrO0pHbx2aV/8vkiJUJMt0RG/uQ3wTBmk
	x83VTJaH3lnvKArEFb/+ZDiPI3aqrhInH5IOpqrUeEDQNK0iYDL5wjxPu37POa3VK0okEXBsQNa
	YW90yHb4aYji6NI/S4TtJ794KtMPjIpfhe5Gv8OcBL1UFfuRSCPy6ueAhr+29GWTzaveTuVOizD
	GluuIpxFUnazbNHI/XCHnWVqmZmYpOOXd3QjyKWvtjlKpR/zJVn78VP9fe24o5Y/nxy/B58uebB
	Bkcaexyr68+jL9u
X-Gm-Gg: ASbGncsmnwSVGil7odMrAqxp0R2WcuCS7VqBhJDeTnfR0Yw+uw4B2yGFuJgZPnuqQtd
	IYHEXzIH3rmqm5yDdV3g0IG6eIRl/z/2IUbRrt5ITiG5PowOgVbk+5EXvhneCt2rQaZqFmXnmcE
	F4q42LsSVkdYF2rpKohrycW9Y7FbjeSYqNJFCMYzg4TGm3BwQWERIblSgHI7xS+BomzI/Q5Ng//
	ryYNkc4yDhmiqtnxF16r36FBVZy2NcxtbDj5MqrSFJNqWtk+R34FEqbZ4K/a0Y0hxQJP/CnnNpS
	EnohmJ7/T+YH6fjz+x/mArgibKw5LiOHxe8WE17xI2HRsvUiWUFBd8i8BlBs0SncmMzDkJSdr2A
	RklOQLTaepU3I8zD+lQuS6/ZesbSLot7KZw4CfzyK0kL2citbtSebbdWCk1CsmFkSYlORIyuzZq
	YfwZv3
X-Google-Smtp-Source: AGHT+IHIeoS41hZVSsAlSPzfKWK9sW+O/RAyFJi03JApvqWP+OuQieUn5+uNOt8IGOJ624VbAB4WoKjGfbBW
X-Received: by 2002:a05:6214:1c0c:b0:802:3d9c:4450 with SMTP id 6a1803df08f44-87b21032734mr373464266d6.19.1760461219783;
        Tue, 14 Oct 2025 10:00:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87c012887c9sm226316d6.24.2025.10.14.10.00.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 10:00:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88d842aa73aso214303785a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760461219; x=1761066019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=47hy/eMh6oarfIC86oJHEXvdQdUE7mbvpox0rMjMn8E=;
        b=cAIhpQFXMq6ksp0EhDOAsjRgqn+l1fP26vnlKhVgzOMoFTxO2+JH2OS1U5BamhnQLr
         QwtSNouJFiVS9n6JE7cJ0FQ1Li56SBPhjdx/C6wQQFvep5GvEHJ6fVllFtlChRq7mJaZ
         /pSoRpFcAQ3QrXKhjZCRgvVBpr4VwPB2RX7CA=
X-Forwarded-Encrypted: i=1; AJvYcCWEDwWE1aLMgS/ZQ0cD5wXcZ5UiILyA7Gq2kDxqNizGOYdJ+cxCqSHt18bHI8VZFKWeGmI1XdU=@vger.kernel.org
X-Received: by 2002:a05:620a:f07:b0:855:f375:10aa with SMTP id af79cd13be357-883525c0f62mr4014221385a.50.1760461218418;
        Tue, 14 Oct 2025 10:00:18 -0700 (PDT)
X-Received: by 2002:a05:620a:f07:b0:855:f375:10aa with SMTP id af79cd13be357-883525c0f62mr4014208685a.50.1760461217630;
        Tue, 14 Oct 2025 10:00:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849fb96f50sm1232895485a.25.2025.10.14.10.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 10:00:16 -0700 (PDT)
Message-ID: <1f6c4433-21dd-4ddd-8db2-4a45cf233941@broadcom.com>
Date: Tue, 14 Oct 2025 10:00:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bcmgenet: remove unused platform code
To: Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <108b4e64-55d4-4b4e-9a11-3c810c319d66@gmail.com>
 <aO5Mgy4VLgtQ2ErN@horms.kernel.org>
Content-Language: en-US, fr-FR
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
In-Reply-To: <aO5Mgy4VLgtQ2ErN@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/14/25 06:13, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 08:02:47AM +0200, Heiner Kallweit wrote:
>> This effectively reverts b0ba512e25d7 ("net: bcmgenet: enable driver to
>> work without a device tree"). There has never been an in-tree user of
>> struct bcmgenet_platform_data, all devices use OF or ACPI.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> I'm actually kind of surprised platform driver support was added as
> recently as 2014. But I guess there was a reason at the time.

Upstreaming of that driver was done in 2014 and as a result there was 
interest from a customer at a time to continue to work with the modern 
driver from upstream copied nearly as-is into the vendor tree, hence 
support for platform data was submitted and accepted to facilitate that.

Since said platforms are now supported by the BMIPS_GENERIC platform, 
which is DT only, it makes sense to remove the platform data code now.

Thanks!
-- 
Florian

