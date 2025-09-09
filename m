Return-Path: <netdev+bounces-221446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B439B5083E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D51C65B01
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C5257437;
	Tue,  9 Sep 2025 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UlVMsHwJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70131D385
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453720; cv=none; b=nIr5+UKO2XhC3CpJgQeMIgQADwDLU0lmP/WvHu6PN1kKxfwUFuYVH2dSt2r1Eg2DhF88sCzCd7716nGpjhO27j7nwVXmKrgoHE3jYjP1+ndFkSBgB6DhQ8jBtTAXt0pC8WaRkelOivpC23xu4AQaYjL2+QGuGBTUDTHLgZuD9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453720; c=relaxed/simple;
	bh=zlR++V1qXLZnYXmVj2aFLYCzIA+ljUfh/dXVUjgWgBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CJpwq29Q6LKJWdjdu9GSxDRTfou1UqbrcwGd9P/ETp1Rih3acRWWWGIn9jGCQq5KaKFGduoJY+jpZIZcxv+BOraDCkQgLKVBQILiecwuDH0UPQjtcRhWenQHh8nNBxDSmdIDKg10V+K84g67W0zuSvOM7FrWfxCAUigJ4km9P2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UlVMsHwJ; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-70ddadde2e9so46726306d6.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 14:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453718; x=1758058518;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uAmuHhm3LYzoTljvua/gkJB2gnNmv98h/d7I8/WAEno=;
        b=SvxsAOmVK4+4rx+cdIEkPlWlHpGjWd8I8XcTDoOvVlip5CJ4ZAEPQ1XPk2Dg1nzmcv
         DGYgTZUChe/L3aETb6wZ8W9bbJ/50P/QxRos++0aqDyfNLsOlympGVOrxnJ0eGr303Vn
         8dM/qGrMWd8TNikhrrvXzu68yF7iMveOb0n3oqPq+EbVNpi7M+wvabscCAPbJx50IWxj
         VrYgK6Gly6Em410QP4wmLIi0f8uro/73GpWai3H0/sEcVjkchUQILt++a0+CxDqAqxwl
         rKzjaBmRTxvaHg/JLL6+HV0kZbHIdTPflkjy1gGWjOmWkLUFa7qtPjRlRjOpGTU0uSZd
         swGg==
X-Forwarded-Encrypted: i=1; AJvYcCUFOu/5Ea/fnisFIkJtg71qXjMbE/yRQ+QxeBr4ATahUEg0mXY6JhijG8DreqXpbVI/XwddyO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQjmQ4Ogv72nGuKeaynb4M8JVf+DIGT4cLNTUE9yhG44kTiEv
	wYmJ9had9QZtw7J3XYx/LxrOcKEBgrLlNkOX+INTiocWTwt6r/rrrLrdIVqJC4iWXk+dHydxWD5
	I1MjDmYRPLeSfs51ExfaA9tnfJ+TyBQMZDnnJqIflEN84e+ZM+WVBIK+OqDD+xjn0FlGjhyjsck
	Sy8cpVmpXHbelkZg66nqHLRiRSpT2Hbj8z+YbYXwga9wnm5JYjsbVnedxUWodBmCddZU+8fTMBA
	IzbcynwNglfWUZb
X-Gm-Gg: ASbGnct8fp0Tq9N+AvbyiH5xw9jg3MtexTtAoMd2qs4xjelwpxbdLC/97bPabdH3gU1
	E3tFoW5ov+ph+zZNPIykiCarEmQCGRQ73EYjNSohAZX777EAqmTyBR8AmbcjrLpmpwpUP6tQzyw
	r0+ezCCrcvSdwX9bGP6/fC9naeNY5fBoNSD5HPV2n3QDU4k+1cO+rC9+FS35qmVZdu2rdxAhx8/
	5SlHPK4bpkNkgOiOVjxxFEhQBn6GTCgErSwG8qmauF7b394T8p7VMAYitj9h9yV2ZrBlzPMd9zM
	FtD89e6lYbIaTwoqZPo6pzwKkzqDRaYK+c7qAPi83w1yNErDqTCy54rtZe30jcpzkAGOJjjY4z3
	Wo2RmapPnzuFChOhkevJxhBDMSJAKvcdTdw3Jx301QUnTJvcyK21cc2h+pFZ1EjmjkTdFPB7uDa
	CSF/ofRrA=
X-Google-Smtp-Source: AGHT+IFBwAxtbId+LYRvMcoLZX1WusOxPn6414qQuStPKNC4iSNbK0U3LvD9K5St9r1wiEhz79PM9gtJGa11
X-Received: by 2002:a05:6214:29e6:b0:729:fdfa:df20 with SMTP id 6a1803df08f44-7391bf469bcmr124171066d6.3.1757453717582;
        Tue, 09 Sep 2025 14:35:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-720b5b9c923sm16120746d6.42.2025.09.09.14.35.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:35:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-81b8e3e29edso215955385a.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757453717; x=1758058517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uAmuHhm3LYzoTljvua/gkJB2gnNmv98h/d7I8/WAEno=;
        b=UlVMsHwJ/1k4zL+y5uw3SVxXtAxaADfpPOaHFRwahrb3qtkPQQpoB0kOBlhxLrUAlk
         dpezwxoxWklTQRQsDqLSIS29h1dfYZcx05o2FAv0O7Y/NeNnTDbQtkxGGVNuOSihBBNf
         CTKGIDCiTU1TU9wp7tdyG3RGZFuZP713W5YMI=
X-Forwarded-Encrypted: i=1; AJvYcCWw2ClvGJHxKBBZgRAAIqNC2gfSMbzRzaiz1MbFw5A4c3IQXONIVfpfN5EbtGD1Bm+jfWoAkP0=@vger.kernel.org
X-Received: by 2002:a05:620a:319c:b0:81d:5a83:e69e with SMTP id af79cd13be357-81d5a83e7ecmr150036385a.38.1757453716833;
        Tue, 09 Sep 2025 14:35:16 -0700 (PDT)
X-Received: by 2002:a05:620a:319c:b0:81d:5a83:e69e with SMTP id af79cd13be357-81d5a83e7ecmr150034185a.38.1757453716398;
        Tue, 09 Sep 2025 14:35:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5e2e25e5sm176795085a.39.2025.09.09.14.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:35:15 -0700 (PDT)
Message-ID: <f8dca287-8131-4ea8-9e07-d1f9d87c6b52@broadcom.com>
Date: Tue, 9 Sep 2025 14:35:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [net-next PATCH 1/3] net: phy: introduce phy_id_compare_model()
 PHY ID helper
To: Christian Marangi <ansuelsmth@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
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
In-Reply-To: <20250909202818.26479-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/9/25 13:28, Christian Marangi wrote:
> Similar to phy_id_compare_vendor(), introduce the equivalent
> phy_id_compare_model() helper for the generic PHY ID Model mask.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

