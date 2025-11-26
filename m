Return-Path: <netdev+bounces-241986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 313C2C8B644
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2CEE3570B3
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ECA30B51A;
	Wed, 26 Nov 2025 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L2CNhbiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3F279DAB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180655; cv=none; b=HlEDUqJfxO5jlZgOfCLV7xsoK5Dq/QFJ9+HW6d6WF27wnTvpBgDcYh9Hl5ntY/woJtbqBMN0YakizsDVieE4zJ1PgeDNTibVW3woNIg8dwptwacXlvisb4q5w1oMV80uURBXMHaBzzIf6gpWNLBb/uNKn7eOfNytj3Cyg/S6gu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180655; c=relaxed/simple;
	bh=iQFkqZkNaLnSECN9bN272l77uiTJ/psYkLjucTwvz+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQLORWFIqEXrqCJ0Ei9UWdX6eDuChhlhpHsGKMIcqjEEZioPGq2TQHRIhSDL7Gdwv6PxWBoi0LG9LDut9H3ZUA/tdA7t6z3YpdLA/NA/YlIRcMOpd1uZB/s5pcMvlZMsw+qSnmsvn2PIEt900kWUzn7UWw59W2nzW7RNSN8lkUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L2CNhbiJ; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88051279e87so147186d6.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764180653; x=1764785453;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B3JiV1z2HJEUDRSAVH4UXdvnPDfJ17h9ZDmgB2dTCQA=;
        b=KFHBbjRviTsiP075fgSEJoQ4EqajRN1b4Aw5cf6ydJgooFRAE62DfzNQhPLR8VMr7d
         QtJ3JL0u6IELgdo6ok7T3COYfabZj5Rx2po+33n7gfgfxO9LL/29a9NccX1ofXx7EPId
         prynw2/d81TgjVsklBHMTQYUizGNPB9YqFrzG6/x61cLtAoAft+6SwBOIFIo3zhpa/Ci
         9Vk45H0Y7TCmduzQxnzgA0rlsz8aygdCKTU2ajPd67kZy6ld0qegv5/ppu2tFVh2v/8W
         95xJ1Z66oSWlW571izXljzZQWbA0wZOILU5XVmqSxUzqTIXxEKNBrnirDmepsHf5cwC7
         9wkw==
X-Forwarded-Encrypted: i=1; AJvYcCV3V1OBcGO1i2wE9NX30mm+gQ2XVp3Iivied0XZrooL200ngdgAbx8HWXiYl7MMPHD+x3lHsRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6F0635bpKE12yjZWNeIs7Nk7iqD4JYsK9yEkJLp9g4uvvP4uL
	E0g2PsGKozI6rkiE6nrNmq75g7X0P7Tj/Ad2fJfHzA1GoTNFaPiZcvMC70nSq+ARtjnfsxs1RBE
	L4CDOBomLEPz+82a6SoGjM/h2WToYCh56TPBgRUOViyKddeWYRK9bJxsdGm3d5NagyqaXPds1HB
	0UtKZMZtmBZDqMYH6wDq52pByyb5mMBoQtrIifn0cGGUC03/EOA2bmxMVaql3hs4Pz3Y3cY08w1
	C+udWNCUInuJTd3
X-Gm-Gg: ASbGncudaSgX2VdvjMEAEUP+2C12LhJYaZ82hJn4SJ9TspCpwrbM1YtcJ4jaOZ1fMlP
	QmFqCb+n4CL4ZjV8Yvw5SIr6rd03OZ2QNKego7SiVhmCLFep6FnWqc81biStvF+Fq9oJssGyNlT
	Nd/tabr1eR1E1oCkl8eAccRgsg5oCOfbzj5QPe9Uw114GK/c9iXhiv35ZweXYoEZmJ08qeFVfDW
	STyK73Q4B311UMhBZeUePlDZEPX9B409rjxtNv1QLp5QyYgWJ0cFu7mwfBOkhuzgme3AK5jIy21
	o0RkU89E8S5sBNRn+IYILyFMzWP2bpT9WZBS5dvv0074oxUIbtwNmi5pIszLdApD/GhOeg+lfgs
	R7DuaR3bUpLg0VJBPMMT1eIceMtxFi+uB5zpVVsQ1miKHrMuXAAZHGLks1QJibp2vgy2UH4dk/1
	D0kw3MEfKavHnlePQHKTZvH0fHexiecRSx18fcsGHgLvdeJrAggkuQ
X-Google-Smtp-Source: AGHT+IGJ8Iklt5Lfsl4YNle1zdPIcBvA51OEaAryFIsoWL8PWda+1MgF07M2knnEaM4Fh7eVJtDXSkHHRUk/
X-Received: by 2002:a05:6214:ace:b0:7e9:2697:dc63 with SMTP id 6a1803df08f44-8847c535c5emr310016896d6.48.1764180652687;
        Wed, 26 Nov 2025 10:10:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8846e5ceafasm23165966d6.32.2025.11.26.10.10.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 10:10:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso80462a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764180651; x=1764785451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B3JiV1z2HJEUDRSAVH4UXdvnPDfJ17h9ZDmgB2dTCQA=;
        b=L2CNhbiJVbmDKXMGNEYo2N8g9jgZuHY3Oz0FnrTf5LbvtoddfvvHdwTBtnmB5pj6en
         +FXq3YC6x/XVx2Y+DE3yl2/lWhytGGe+TdBWDxUv9w26AntaPE65m5MfFlraK5ySVzaa
         3SwrxLt1KmVZvysaDIq3+o8D1opIKTDLztT60=
X-Forwarded-Encrypted: i=1; AJvYcCUBqZ2E7762Djyp3KswvdiAQXO5cqUo+2PHhImJnrDOa45Et3B6hHpfalgScnD7rSb88qg1t6w=@vger.kernel.org
X-Received: by 2002:a05:7022:3c08:b0:11b:87a0:fa9a with SMTP id a92af1059eb24-11c9d847ff4mr11081025c88.23.1764180651297;
        Wed, 26 Nov 2025 10:10:51 -0800 (PST)
X-Received: by 2002:a05:7022:3c08:b0:11b:87a0:fa9a with SMTP id a92af1059eb24-11c9d847ff4mr11080994c88.23.1764180650722;
        Wed, 26 Nov 2025 10:10:50 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e5674csm97158277c88.8.2025.11.26.10.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 10:10:50 -0800 (PST)
Message-ID: <be9ab45c-831b-4a90-9e85-da15af838626@broadcom.com>
Date: Wed, 26 Nov 2025 10:10:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] net: dsa: b53: fix VLAN_ID_IDX write size
 for BCM5325/65
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
 <20251125075150.13879-2-jonas.gorski@gmail.com>
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
In-Reply-To: <20251125075150.13879-2-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/24/2025 11:51 PM, Jonas Gorski wrote:
> Since BCM5325 and BCM5365 only support up to 256 VLANs, the VLAN_ID_IDX
> register is only 8 bit wide, not 16 bit, so use an appropriate accessor.
> 
> Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


