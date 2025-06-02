Return-Path: <netdev+bounces-194670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8672FACBCBC
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 23:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6457A8DB1
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FC61ACEC7;
	Mon,  2 Jun 2025 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZkFkHRht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B213019F48D
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748900305; cv=none; b=FCBXllP3XSjsn1lG15BvM87an6hsOvWpjWwqu/ZkZCnQQ5yqIIfdmhSe6GvL8QHH27w9+QraWJWlqrhq/D7zhplURJSRs0Rg+1qY72afzEkrvXly701cNkMDtHLzp7jH2imRIjmVE0sx++zEZWuAmE/zOisKsD3Obv5HdI+SYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748900305; c=relaxed/simple;
	bh=Ui4uYFqve41fxber8UjVsihCB3aUnN1o1Z3IFxnIydI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJyqmKFvoY8kwiilLiSB4vN4Sda7X+5vATh5FekTRKrR6Dk5n8XfAQqT8Mf1xRd/7TGdbcPz1rht3dcr3Ag+vMSXMdOiPDUpuABN0pIPpaYXRXxCEIk0U8MTTWMVtyyvevg86Mrt35BqHRbABm8wrryqPxiweUr0u6mjucUTAFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZkFkHRht; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5377254b3a.2
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 14:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748900303; x=1749505103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZjqpYvzOu/E1QRY9S6tRLsm2usimRLkMEz/exGkrf8=;
        b=ZkFkHRht8z7OWldVAFaPAn6rSTBj9NfxAl0jVTYzDEadHRF3HfdZAuejuv2+SLWpnT
         7msYWZyEBXTPxoLb+uolTdx0uYbeaRAPKihHN1hocdse1ERBLVPWSV2EH4JaLDyIToaW
         XdKTGuHcomVZufkJUBQI+6q30RlAS6KA33hTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748900303; x=1749505103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZjqpYvzOu/E1QRY9S6tRLsm2usimRLkMEz/exGkrf8=;
        b=qCkrVNeRqP5njWwe5iG44yse+4kiSN+AFqlJnJWpnYjjl/oNfIdZ7OA6bq9rGPX3Nf
         3SykzzZqDzKfhSJqlA4Wih7hbBx4MxgIcgGIRXtnFi2A6CFSuE/qeh7yN9tSUrL8FN08
         gPwtYp8msw24CL7RHuxd0NxfuQ2DS2WdAEpZISmcJeCEI8Q1luM1LAgEhAG/NuhcSfSY
         btkZTOMeYfAopZvVFvq5pSF5K3W+5GkygQi0utxEFevGxCycnNLFf7NPx72e/kFtx618
         qckEXcR15LdpgvLukfl3k9GzexpwkOGSI6vYn90xI2xYWqz33uhouHOPWfuY7zbfsfFK
         xr7g==
X-Gm-Message-State: AOJu0Yz+FrPVhH0lpLrHMI9qHWzHgXkgVgbXd3ozEM10ODS8q8CpZGhR
	xtBsByypp8TI2FoukWKI9PAPtgRGmDb069m0THxleW0iiMKvqGAWHgiu5hPGbf/tBiHPSbENc2h
	N4JufYmr+
X-Gm-Gg: ASbGncsUzaqCDvdF+0+3u1oXdkETHqRspV0SOedQo04PSQKiT1/gceaVPQO/DaACbdj
	/M9V/yd6QyxIAfgjUbLT8Yv3p7jBKYtMJBsyxcY7ptXKiqJ4kT6v4SGojnz/z7In/BCTrn5srgD
	siABgw6VdG8r6a6EiSjfRW9uzHw9YvpSELEH2TXSH/NLhySO2uTOTyNOKCsrJn6h6pl9iFRdMtn
	rNi4k+ES9Bj77n+yxWJffChHxJDmhJei5pQKJVvf5Ps8oALck5YAA2rURVebDJ41GdwJYNYqMHO
	5LvcOD9vuN2A4ZOKpMf1ZJsXWE8hJFPKt4egrkSFFt+EEMoscbGRuNHHmE4ALeMvrghxiPHsdrL
	ZSoT2g12TllRUpIs=
X-Google-Smtp-Source: AGHT+IF8yRfd4dylOpz6L2d6nuH49Z0C6wyEZooEBgDMRlhm8qDJz7+P6+f2ww3sHrXlF3COu0JvGQ==
X-Received: by 2002:a05:6a00:2301:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-747d1835b73mr11858723b3a.6.1748900302946;
        Mon, 02 Jun 2025 14:38:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff71eesm8075400b3a.159.2025.06.02.14.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 14:38:21 -0700 (PDT)
Message-ID: <bb955bad-d9f4-430c-9df9-beb66dd60d7c@broadcom.com>
Date: Mon, 2 Jun 2025 14:38:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/5] net: dsa: b53: do not enable RGMII delay on
 bcm63xx
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250602193953.1010487-1-jonas.gorski@gmail.com>
 <20250602193953.1010487-3-jonas.gorski@gmail.com>
Content-Language: en-US
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
In-Reply-To: <20250602193953.1010487-3-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 12:39, Jonas Gorski wrote:
> bcm63xx's RGMII ports are always in MAC mode, never in PHY mode, so we
> shouldn't enable any delays and let the PHY handle any delays as
> necessary.
> 
> This fixes using RGMII ports with normal PHYs like BCM54612E, which will
> handle the delay in the PHY.
> 
> Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


