Return-Path: <netdev+bounces-198728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51DADD594
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8432A3B1727
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0CF2DFF32;
	Tue, 17 Jun 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O44xcvWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4252DFF2B
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176621; cv=none; b=JsD7ppUbNdSFtK9W7uLdlQIYN3ZNwtTroTWlJy7YlZTgOIRf3UXbitjhHJHjjubTf2Yce6qB55mp3M3CGiV8OL23OkCnRSxT1IjjJxvsfIcgYoRXZD6AX3FPp/NG4kYHAzFRekAYDvGNuO4SxC1ZSi9DPECywK9FKLAbrA9MoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176621; c=relaxed/simple;
	bh=pVyvF3eYxxjO246g5QZE97s8sjAFnfNwoI4mCPK0V5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p3wRddMWbFGz4zfz1klHwy7vGLQCeQSbHnE02lXkohCcMA2vVlQfNJLIGTFkRkNRTTrYLWrA7cMIbIS3QMy3vTCqGlEePxvXesJdlR1mmQZ510yxLfDuLPZLyGxPUwjv6n5nFYhakZ0Zp6VWNg5D7CrAr5mesrzob4ipxKRn2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O44xcvWe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234fcadde3eso76474895ad.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750176620; x=1750781420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XadhcNtxF1ej4n+cxZcsL+dzrWJT+s0macaGyzV2RaU=;
        b=O44xcvWeHiiNzcKBlWJaq80BWLy0GAOoeP8i9KeGRtW5zjYsenh1gI0xsuivv5KBc6
         RqmYVixTM/IEeje+P/vDo9PhBem9XfPVVGOgyvbRtxfUJqzecDCLv3tTEM3MbfBcMc9n
         Ecv5I8eg0Y8ymJHFlEAgxpKXoW4+P5RJ8Rzys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176620; x=1750781420;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XadhcNtxF1ej4n+cxZcsL+dzrWJT+s0macaGyzV2RaU=;
        b=L5MxuwgrLJYN6DcwgPGByHDM4kG+0mKLsyRej0j/Wd8JQwn5VzbNaETtA8+YpbJGJK
         hPej0P1tH5ODMp1ntGMbYzMJxphJI+/KmIP8FEZ8BcR1VyvhEV4Guh9H7unqgDGqFh7z
         ROiaY2ir7nd0n0qaf61bmSbS8aceXRp8jP5OBh7GzeaXo6KeA/vg0Yb8tiOyXjOyBeE8
         O6U6FZoZCAoeU9ivp5EB7ENhwEyhEh7HMpjAKWJidLzhg0QSjV9Vw1EYCGVTCR+Zyse/
         ZYUAaRXvLozrPPV1msi6p356IDHwZ/mF9GhL3LpJ7OVTF2+NJKkfalL8OtOxaONKyfxf
         gGag==
X-Forwarded-Encrypted: i=1; AJvYcCWJ127hPUXS3YoMLh+PQAMPtjE+y5IyYZef92gzKUkY7xSEmLsQSParHdpNP3Q68pKqqjy1c+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaKQJjvS/VEBSNyG1QKYshJIloV97pG/GPODmP86cVlAS47nv
	2sSNJNpINcM3FtZgs1tYr8k/c5jfIS78bcoHtHT8FGmBTSxnmWDoTHBWXwgmx5VuUg==
X-Gm-Gg: ASbGncuhcKRpPmc7opjtr+izOCOzN0gPYhMTVMuziyfME1wnwLPjq2EzNH/1LvxK0t2
	vvcyyrOkSXqHlPDkFTIbB3VROtkDW/xlspt1ZFu/AHdQV4llY7aUPh4ungvB5F4pqqnuf4Bt1df
	hr7mWRl9bVmmEQ5MXXxsx+iM88uoomsABVTFeKJE5VaB7je5FSagrzHYivYnP5QIsIfLZjwFUJE
	28WfDaYU2O+DHrVK2y+U/8BG6gXWP7q1bLmN8kZAzfrZXNzIHsjF9S36UklADTwqaOuJAnUJZdD
	7QER0EEnjuJfQy7x3PhKO1pctz+D7I5auyvCNl96UVUCZxJhzIFveroiNZmJnTJJuLqTaJlhMN0
	Zg68rpjtd7nOHvD4KP+lO4GiaUQQrrTuA6dLt
X-Google-Smtp-Source: AGHT+IFrnm/6g2DdRD4ThsyOlmM9n95VHHRp9LotSb21QFKqc3Hyfe+DmATQ1RwzBN8km8ELJ/9BcA==
X-Received: by 2002:a17:903:22cd:b0:235:efbb:953c with SMTP id d9443c01a7336-2366b329f4amr187483075ad.13.1750176619593;
        Tue, 17 Jun 2025 09:10:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88d921sm82016405ad.40.2025.06.17.09.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:10:18 -0700 (PDT)
Message-ID: <3b0d8a90-7312-41af-9ac6-9128aef2cce9@broadcom.com>
Date: Tue, 17 Jun 2025 09:10:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 04/14] net: dsa: b53: detect BCM5325 variants
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250614080000.1884236-1-noltari@gmail.com>
 <20250614080000.1884236-5-noltari@gmail.com>
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
In-Reply-To: <20250614080000.1884236-5-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/14/25 00:59, Álvaro Fernández Rojas wrote:
> We need to be able to differentiate the BCM5325 variants because:
> - BCM5325M switches lack the ARLIO_PAGE->VLAN_ID_IDX register.
> - BCM5325E have less 512 ARL buckets instead of 1024.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

