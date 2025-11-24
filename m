Return-Path: <netdev+bounces-241289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D830C825EB
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1823AAAD7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A232D7CC;
	Mon, 24 Nov 2025 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U0NJgvIw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6E1A9F87
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014655; cv=none; b=eISj0ydArUxYn6euTBJqa5vCN7xG8ZTP3rQgW/HBi8Qkr79TMyoKveu65qCtyLGOiRAMBUvI+w+9M9ND/nfLsDgtmJUaw7BPw34j2aV/lbEglvtKSMxRTnwq8FxJuZEwxzbOllr4DZ7gyHk5syl+LE5IYBtkPSv6/0Qf5OY8ZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014655; c=relaxed/simple;
	bh=c7RXQjSG1u7TxuP394DeURNsLlRg6UVOKpu47VWA+0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbfrhdEV6eMYm23l3/142KMoJaiHl7yH6KDGtkmMcxuU8HRsmIwP8cq3DOY3OteiB3DeWZNI6KFeSszWaA3c9TqNMTUBw3ngRnf+tYSUg1CAyA7gZOzunlySxWtPJiNEXmqai4Fb87WtCHfkP/CNBp9WX4KWaFLJvC+d22b/3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U0NJgvIw; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-88267973e5cso29901736d6.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014653; x=1764619453;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yxt9wyXBQN3+3bn2pbBdvoblZIkW/chDCdZidX2FGvM=;
        b=EQp17nlf9/F3iAMtLpoP8dA4uR3YZfZXhjAcZXy6ASdTgyN1F65LsRtZgYJM1Sfjr/
         VSOFIpRAMfnERCdQ465dheYTJLkCran4gDZPYSMYGKjf7PeQ+2gn4gn1gtu5laFR2r21
         6P2TshNkqLGq3F1o74B79iD0An3kwPeb4o70jZcwoZV9MOwX3P9Po0FYPqJGgukj5IU9
         b/0+35pHSxLLY+zIm7klUSCUduDUVfUsNT+SZriRK2a3KIEgyZUUJpFT0nJL6gdHETIm
         Xed4ONQVlwa+GjYfJXKm4PaEylRGSWZ3oOx7fDN9j/aik4OkC9I0XT1+jjGlScJjkfog
         ZxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+tiUWGl1g9B1JVOn1h4fpLaMuz38Cinj3BWogttdCaG/m1Y5CZepwNGn99m2R0NEvi13T0JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTr8TVtHXdhjzAhF99ac3R3Er14ooAdg0XmYLkvZqyJIlrE8+D
	nqEj+jchPMI5yDWZTQ7yyftsbxmMRzRPkvv9Pm/N0dDIrQNKMyAnWwMbY95J9LznbP1OpjUq+7v
	3MgcffuDfsRUCZ31SjRRrkQS2VCROnnw/NpZbc7dHso+sHlg0YtfbCsmQ10cUtURY05dS7eRrOG
	jnajE/mG41XUmX8G/09vgDzs0+QgYkaJF/GdYm8aN53+rDHsvfMfIk7Jqgwa5hfiN0Nxq5IGgOg
	Z0TkMWJ0rM5pBlX
X-Gm-Gg: ASbGncudqLtsl8hYjgno3sSyXJmltKvXRTJiE6n1AkKf1X38CyrImSzX8zr5x/tyqD8
	yxm/L08ahU0aWXzNZ4TY49YByUUm6hqXt1E35WQwdpuuVnI1l/wKT3YsnNP5dtpO126sriq76ZM
	bYYGGgm0zTFTJh1eNusigTge+mwSb8xlbiQQGvNdhj7ClVhdzC4HMMMy7djJ9jWQI4SBR9c884o
	ebr/1+8uRgbsIJWdpNKRavVaVHR66a4Y0G7SKIXzfXaWnw0L0R3f1CemIcAy/XfrU2OCC/lBFwS
	+rfeHbHvR+djqgu3Q+370uUsdaF48QZqDJOZER7e9Bc18kozSK0TfgXSJgl4hxQw6tPb5Dt9snB
	0IUTzFeQazLXK+o9vnuFvW8uFxxwJjQAzt9X8Levw0zY+AlbrPwYKESXLUNaEfMOO+CpiPpw4cU
	/eXcE1o1Sl8t7VxA/0KH2D/QwtqtpYWfihUNVl7PVQj8/vzlQFug==
X-Google-Smtp-Source: AGHT+IGouPXtbC9ZlogE7WFGFogMZBKEmFNDsbgGxMQVPocmzL3iX3R4NRDDjRlrZf2lOHz055FnB8FcVOLQ
X-Received: by 2002:a05:622a:386:b0:4c4:6b67:ccd7 with SMTP id d75a77b69052e-4efbdabf498mr2286261cf.55.1764014652965;
        Mon, 24 Nov 2025 12:04:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4ee48dfc812sm1328401cf.7.2025.11.24.12.04.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2025 12:04:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b99f6516262so14720106a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764014651; x=1764619451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxt9wyXBQN3+3bn2pbBdvoblZIkW/chDCdZidX2FGvM=;
        b=U0NJgvIwNiYiasw48KNYt3Rkql4DzXRsDMCsI5+TnPG8muQPZeRDHrz/PFjh4cJQb0
         aBrHIqUQFPKHmp/0ldYpZhD6pAjUp9b3O2S7a7Ju3It5ak6MkJyxPcfu+XZ+BgGpXJcq
         TP7D71eJW5ajH9B0GS6roezvawi2XOZZ63Izw=
X-Forwarded-Encrypted: i=1; AJvYcCW3EbDAt9LDTm+kTY5BZ5jKYxcryaIsSG3IPsKRUDRcW0cHL/M+W0zvLCuVRFG3vTaSnFumxPI=@vger.kernel.org
X-Received: by 2002:a05:7300:2728:b0:2a4:3592:cf65 with SMTP id 5a478bee46e88-2a9415ab694mr248376eec.9.1764014651490;
        Mon, 24 Nov 2025 12:04:11 -0800 (PST)
X-Received: by 2002:a05:7300:2728:b0:2a4:3592:cf65 with SMTP id 5a478bee46e88-2a9415ab694mr248359eec.9.1764014651002;
        Mon, 24 Nov 2025 12:04:11 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc5e3750sm49650572eec.6.2025.11.24.12.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 12:04:09 -0800 (PST)
Message-ID: <d8646640-fd2b-485c-b1fa-4a864e1d951a@broadcom.com>
Date: Mon, 24 Nov 2025 12:04:08 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/7] net: phy: broadcom: add HW timestamp
 configuration reporting
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrei Botila <andrei.botila@oss.nxp.com>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
References: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
 <20251124181151.277256-4-vadim.fedorenko@linux.dev>
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
In-Reply-To: <20251124181151.277256-4-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/24/2025 10:11 AM, Vadim Fedorenko wrote:
> The driver stores configuration information and can technically report
> it. Implement hwtstamp_get callback to report the configuration.
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


