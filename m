Return-Path: <netdev+bounces-235187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5DBC2D48A
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3764D461626
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB72B319862;
	Mon,  3 Nov 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GopdNs/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A930DEDE
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188558; cv=none; b=GEtHZ744OOvvtuFPca3ohPDbePKchHn+BtEZzDaod0788vh58JKueyzNaRMPRyrTkINtf4dBiO+cKKSvIY6BA8T+jJ0BTIMqM3pOhKQ+QCwTA/bXUnJXGD7FSBXL6nQTnxGDdK0UIgbFfwDOYv4AuT72fjtI9F/XOSzanb1/U4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188558; c=relaxed/simple;
	bh=ehGpxSuBgfBOKgPeo/kH+fJB9QB6yqngXkefpVgDlXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7ITEtcIs7d1diF50k/8YolkXzjdePfgHOZMFerSP1VjC8F4D7zInAGLZcqoQ/uH3adXAGU/l50xOgET7YgkFprTSvngO767rZRphzSPWTaP17iL7/626LHb9IF7cR0NapzzwsIPrT1fQ5Mi0rYwhb3CNjZ+TqZwFcApS5SUA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GopdNs/q; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-b98983baeacso745378a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188557; x=1762793357;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgUwdfuZpXqy9lYjOTOW63pOPjpSJgOLcy0yCGYOUWw=;
        b=C2EgoBlZbYVuQli3XoRAVTPdBj7hHw5j8tdBycOFdPen6wSb7ypj76et/TRxL54VdN
         bX7oPL1eIm1XOb/lW9hwerBhdRdaoU0/Nir0gDOlgrTibMfUMCFjSNduOzruuzpc6+AV
         Gy0PC04Mz6+vYEpOBn3PWY1U4g6CmMRGZNmhJC8dJ3WaQxNrX8y5PVHEt83xd5tQQwgt
         GceYN4e3BZbmwdGNcp6EwsPR2i3HnPsr49+0EtycbRLS0RIx12fD0ERFBtJLReLUaUBp
         11YcBRfZ8ayrCpr+aKw0NuY4/MikZgLqOr4RG1WxMBs4fPuB1R1mjCVcenCz30qSf4qT
         Y4FQ==
X-Gm-Message-State: AOJu0YwZljnFS1eEC1g8tyxVpCt78kP2G87f1myUnhpQt14EG5IUruab
	y1o2BZLgslWtcToMXgW4UDNbJN5IVhUHDt0wuwW4Nm+qpstcOgAsrcH69gzj8bWXO9ZM9BX2DVI
	ACw+snKKxuAsW+SJ9gCho6EN1UOoyqQcxK6G8V+BjjHX1J31PMwZ3UVpBoJ1FCxG29Wq8hcqfO/
	cXKUDfRDMn8DqGUJ/BpYm2twUCX/rcu4O3hfyQZJQGiFI4/6OSNycOaRU+AiyETpgpxUnpRputI
	36NjwLJQlZHJEbm
X-Gm-Gg: ASbGnctJJ53g96Wl4uxeaFf1xveIM0TdSVpM5F4lVs7q61ra6OEeNgbBBTSbTihucJo
	ztnrZeReX240WhS0ZuEfdZOBSwsso9P5vlp6PqfiWwdeeC/3oZdRawLoTqv+m7NVqQJFhcwO+Vh
	T59mp64KZAr00AJgtiGhVzS53e1aU6MIV7m6SsEQMCSoJUP6CGOc+cIjysTK3rXuRekx+gHPAWu
	ZZpNXcsMITmdNNPHxUoeDmg5cTBFDLflQ/Pl4ee7J6YwQA423nElvNXhdUh4es6Z8WRJcXweJv/
	oU8k0TovvdE6CouuaE45bJBCyfJNsguYk0V8/lpcATbLXOPkgd9ZpoiCVTHmNOAllHKAczVUgyE
	eC6mSABACWUQKgRBJcJgSJM38AlFmw+xW2rkBPGGGqQL+77/ulaTpV73q2XegUNfsR9Z3z5QH5K
	xzVjdfSk5fUt8uDlF2o0wrK4Hh8v0wJ7rF/Nebd9U=
X-Google-Smtp-Source: AGHT+IEXZBrUk1JMZWODMg/h7eesacZZR07gD3MExg7inRm74lJLyt3xJvW65ZuQsAqXP4D/GqmFXXxrSYsW
X-Received: by 2002:a17:902:f68a:b0:290:c0d7:237e with SMTP id d9443c01a7336-2951a55d517mr183818205ad.39.1762188556684;
        Mon, 03 Nov 2025 08:49:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2959cefaab6sm5314235ad.58.2025.11.03.08.49.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:49:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a9d56c36caso2142069085a.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762188555; x=1762793355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FgUwdfuZpXqy9lYjOTOW63pOPjpSJgOLcy0yCGYOUWw=;
        b=GopdNs/qu/ihqi5yUFN3zH4NHN1PQLgo7PWWQmiJfmlSdmnNBI+nCMzQquBIIzvQv8
         lmQQy2LTHh3NNmmrpoAw2qLh2cXQTQjugLckl3nRSg3a9hI4u/WcEiT1lB7GIkgvlHAv
         OtSWkgokLqtU5BJLKZPVgxX18Y/CSi/tcQuDg=
X-Received: by 2002:a05:620a:1aa4:b0:8a3:1b83:fbf with SMTP id af79cd13be357-8ab99498c48mr1518206385a.21.1762188555505;
        Mon, 03 Nov 2025 08:49:15 -0800 (PST)
X-Received: by 2002:a05:620a:1aa4:b0:8a3:1b83:fbf with SMTP id af79cd13be357-8ab99498c48mr1518202185a.21.1762188554983;
        Mon, 03 Nov 2025 08:49:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fbe610bsm1518821cf.13.2025.11.03.08.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:49:13 -0800 (PST)
Message-ID: <ab0e31be-47a1-453f-9d73-26b8d02bd882@broadcom.com>
Date: Mon, 3 Nov 2025 08:49:12 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: dsa: b53: fix bcm63xx RGMII port link
 adjustment
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251101132807.50419-1-jonas.gorski@gmail.com>
 <20251101132807.50419-3-jonas.gorski@gmail.com>
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
In-Reply-To: <20251101132807.50419-3-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/1/25 06:28, Jonas Gorski wrote:
> BCM63XX's switch does not support MDIO scanning of external phys, so its
> MACs needs to be manually configured for autonegotiated link speeds.
> 
> So b53_force_port_config() and b53_force_link() accordingly also when
> mode is MLO_AN_PHY for those ports.
> 
> Fixes lower speeds than 1000/full on rgmii ports 4 - 7.
> 
> This aligns the behaviour with the old bcm63xx_enetsw driver for those
> ports.
> 
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


