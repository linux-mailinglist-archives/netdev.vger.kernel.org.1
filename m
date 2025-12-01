Return-Path: <netdev+bounces-242861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F327FC957F1
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 02:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BA37341BE9
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 01:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94C772639;
	Mon,  1 Dec 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q+V9j2wS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297333987
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764552589; cv=none; b=FKKG3dhyvBAKTrx3O4dQxUWPxJtsBm3FJb22n/NRjZ9SimvkGHQQyh8STKYglBQ0uR4PEbP4FXNCTXwB7afc87YjaJFzIIXYZXRKPkBwZpPsurF+iFJD8VGmDOhndKO0BaY/pg+gugmJ/+PoyZcdvz+jwy6+eMMUoUnqpJywFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764552589; c=relaxed/simple;
	bh=LMMS5/B1rXKZ3CevXhiJM3KouUbJPfKUr5xa6WXB7+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FC6qBs4UKclIb/aJ/QVaw5XNirgaRT2yJtIfW/FZfTobof+e4Bxe0HjrE3IxWGX+tnNryJSsSYxyhyLvGCvOAyjZf0OtESNjPde5+sndrtuJk22Lvh7Mie6gZL2s2Jl4De3eteB2pKkuefpQamXd33NvXZzbh9VHu3Ws3tIuW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q+V9j2wS; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4ed66b5abf7so50755331cf.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 17:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764552587; x=1765157387;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K3rFcloiy03aTJ8JMY5WA+kyME069+OKwWqh/DMRR7o=;
        b=dRSokJfHSKrf/y6x2xP+0kU6lH4zbXEsVYeqG1UGltw+Wv908R9nY50yhXat0EHsKK
         FOwyndsFlqHK0wLTRP5Aa6jTE3vUBkbVwEhqhpy5DQCbizglTaJP3aSpOZP052eWfxwX
         fcGhR6xxfwSpwqwn1j7+ZERHJsu+3I4tqmI5aaSxwJT+sQYdm0ZFLpGZ9/IjB33T/XLF
         O1XshkqWM5p1iibLOkcQDPSGCjDUaX0EPmDDJmGFmK3NonNVxxQ3pKZDynJdQ6lKplY0
         JRbDmZ+zIpvXQGOVfTRBJkk4iHa20gknF8ZWFK22AsAXxRKdmiAG8I11s/7/fmgKcpHA
         WdNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhmn9qw3BGUf35KNvHe8jql9u7U68NZvRtbhsg55qDcIK/d1K/GMMNrAIJZl0QZokW71kRHJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUZY8wbyQ5g65EJM8Zzpba/KIBmPY8XHBfVBMFFuySYGY0Mo1
	WAkVykmTUCTyTqXdXzbUCHZkvb8j+saBk52R8bMYuhPJkqeDs/qDGEVw3eIkrgXLU5XyD+N3V9a
	2WJnDUqFMvO5YX9pVfKnCvagcE67s6h9e/bm1jb+I1OOLEecE+MGcfBHzHJdAnu2JG43t9bu59V
	oH9U3aRQaSWICsdLECpI1Jwqz7++xHBVHZmOigdlCeTUo3jXM6z6j1eWRfKqxFJoG8/4eyaxXLK
	GECL0YxfG94aP72
X-Gm-Gg: ASbGncvugDbhBWPPROqByje2Rj5CcQ4Ydt41ept70myzj18tElIRnh5C9eg/j0MJI6T
	OTZc7lNu18iEPcuPT38D1Opc5dgvsRSnpWnnuGwqlfipmDY5adqlw/D4GFdgY2hbrI2xtyDdNh8
	U9fh+dcp9VVEbh42YtklcKoOiUUmKm+E7t5f9fu/40wDIoQnpmJzWLv2hSep2A1LA9xOpFB8X8z
	tSARTKXmy9l6bTK05L6D4gi3+/CiOO7r+j5gmcXQbm+SD38ZUljuPCDoOQV5wZeyPorZw8GJy+y
	GoVbv3UA9ZjUkClUwz2c6Jxg+HkBm9qN3eH9plcuh7MC43Tm7WIim7/y7UoqW4+kvsbTmSqYUWt
	XN/Kj4NdNRRbe3fGSe1ddQIRpVUALY5zFzfTXfk9QlI0ZgnUgMvkFvuQK1KEtLB84q5Ht/puFQ4
	ekY7ZNuIZAyipRemiyvY4IJw6XlCy/d+06UTW+4Kxye0/cws6MiQ==
X-Google-Smtp-Source: AGHT+IEycI4sAeqojm10LiXCC81eSoAT9OsEjo/92T6E87UL93rOWrhiVZEd/78zljOb0WHnlG1shI54InoP
X-Received: by 2002:a05:622a:110e:b0:4ee:1815:18c4 with SMTP id d75a77b69052e-4ee4b418af2mr593830951cf.3.1764552587236;
        Sun, 30 Nov 2025 17:29:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-886524a8fa4sm15042326d6.6.2025.11.30.17.29.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2025 17:29:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2a467c4e74bso5376978eec.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 17:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764552585; x=1765157385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K3rFcloiy03aTJ8JMY5WA+kyME069+OKwWqh/DMRR7o=;
        b=Q+V9j2wSgkZHj+DsVbnKhOml5v43BuUCpVz1gUo2UmsR5vx7+4Zakp087KvfO5KuXM
         aWKGy5RJAmuba+GMojLzEBsuTKnDF/UQ+MMQME7rDciJNHEastFx1Z5Rsht02xXNkafo
         0tgwrSVv72jctEVBORowVNTbx192xyM/J3xso=
X-Forwarded-Encrypted: i=1; AJvYcCVtmKjpabbZg4cZPDlBfFjs2fIvDNaciqEK86Wm77LVMY/OfebEdQwXkgFSrJeiwQ74hJ6B/JE=@vger.kernel.org
X-Received: by 2002:a05:7300:a599:b0:2a4:50c2:a74c with SMTP id 5a478bee46e88-2a6ff57ffd2mr25698302eec.8.1764552584971;
        Sun, 30 Nov 2025 17:29:44 -0800 (PST)
X-Received: by 2002:a05:7300:a599:b0:2a4:50c2:a74c with SMTP id 5a478bee46e88-2a6ff57ffd2mr25698292eec.8.1764552584467;
        Sun, 30 Nov 2025 17:29:44 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm51681536c88.4.2025.11.30.17.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 17:29:43 -0800 (PST)
Message-ID: <a26d07db-8e2d-4c4c-bdb0-bb9b03f20343@broadcom.com>
Date: Sun, 30 Nov 2025 17:29:42 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] net: dsa: b53: fix CPU port unicast ARL
 entries for BCM5325/65
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251128080625.27181-1-jonas.gorski@gmail.com>
 <20251128080625.27181-5-jonas.gorski@gmail.com>
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
In-Reply-To: <20251128080625.27181-5-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/28/2025 12:06 AM, Jonas Gorski wrote:
> On BCM5325 and BCM5365, unicast ARL entries use 8 as the value for the
> CPU port, so we need to translate it to/from 5 as used for the CPU port
> at most other places.
> 
> Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


