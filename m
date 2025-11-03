Return-Path: <netdev+bounces-235242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C047C2E38E
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D6348B2E
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB882EDD70;
	Mon,  3 Nov 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E4icyLMr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3D1DF248
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207919; cv=none; b=rEqKzjeZyadFx4C72/vEkYYqZ3vme4G3cLDvoj2qEVqgyUU0fYgDkkCxiHPqe3WWF6CS31DbvPbnfY1qY3EC+7izJ7vZ/Geo1L5G2IgN/lXWUQKPvBeG8sTMQRBVADgNFyp0En05v+/4tbIvMBfQLnseqcnboYdrAhdHToez4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207919; c=relaxed/simple;
	bh=KNld0hPOC0rvgPmM+x1YqBqsiUtIYLq7mTzBOKAmv0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2e8TR0fPB+Hoxm3Zcba2q37rCkRNM39GdYw1klKxSqaMFHP2i+2c5yXvfOSAkt9isZ1kfROqDhyMBzmtiay6kqMAXDgStoRVLvmVypj9qBQDgukqfBKs9ZvHhGSXqXEzQp4rIhJ849Goc7jjM/XKQfLGkPDlUYsj/PhyIPanao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E4icyLMr; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-3c9991e6ad1so3421968fac.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 14:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762207916; x=1762812716;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIukxs2eDwE3mLXELpSXoxd+kJ/H0EaWzJP2uktACOw=;
        b=qwNSjdZ8fd+5kqVjxBGCs0e3XEiyG+1AbrrMGSCR8UtRWN0SuE8pQQp0uW7iqe/7BX
         Ru0CvbMHlpHARBy1fvLNkfkDY9wCjsnOvHuQ+PTcmZTPPBRLu+PbFM/M7X9GvLi++7cw
         PNH5oi6BqMgxL+T6kNrFMT3SzH2jzrHx+givrFCbA9NTthLvDg3EZFB5IylajeM2q1Bb
         8HoPrm97aIXUIrXn+adBZ4VFoP3A7XWFaLC7WDnAWlSfO2uCEKxvlnJuxvyTFru97HFf
         AK8Ii9XE4KYgxWuaoGRoMzD2zTQ9y8UfIVjgbn33scTFnlV459CXFF2nCQbDJClMXq2t
         PPPw==
X-Forwarded-Encrypted: i=1; AJvYcCVn32ZrWe7bHuJg/UJKgXZGMp4883JHCbNmnZjLn46L+pprDCvM00RziUJCMRoT6QxBBfsREW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUXId7HyFCCrZDuQeH3SurGLiWNf8FCDZ2qt7hZD3I98YEUBAl
	LxIEHgKKl7VkVmAl8CDb6v3RjIbM/nBkdsr9KKpCnhMoblDEB4dNExqp2qfRXRxldTlutaZtoEq
	ABxdq25MKRVBBO5NCZwhL2Ru1XX5BU5T1lDL1WiqP9d2xBIlcAB93wF24ppKltKSinqhstE3rBx
	3G+4I6IPzUCDtrl6DumVFKnz60Um8PjyEI8Ia3M3xELbQxX8ApUVqezXB10xXCFwb+b1DAXlD9y
	JZucqOcXpWEuQCX
X-Gm-Gg: ASbGnctqSmqWtqMYQOrjI0km2v97gwz8lLAljao+yQarFmP+mz2R+qH1rFwNCMUY9ws
	rKQlnEFtJIAEP7aeXdOBnDy/hWfdNSz+p9ZIQn6Kq3lYfj5xP7NcsNf2Xjy8au19PNd/8Dxyz/c
	rX6stOoyynjMNfJj+ZmgSaA8Y+ceDsVEMnBkVb82L12mAMO0d76zZID4QutpMTc83yo1dTBHJTr
	NZgp6d+6UQ6En3Eck6HOCHnwIZho3+dXTcr/l2yPVoDcGpN/QXXMw+pgN8m96Se4APVBP2+5K+f
	EhPed1JmK8pVsI5Wt3gyQDWTO5JrUl9qsmk3+gUxDzmi6YZpqxm56MsVQ80O+psGpgMqSQIw0Sj
	4cVEXx/ay+2UeInFNO3EuqiJyLOqbIqs1zWLfDbCRQqk3f6meGRUj03x1mzhV4rDmcoaRloBfv6
	eyj+x8srauKPp89brqOGK11tce4hRnYuR5S7pQ07k=
X-Google-Smtp-Source: AGHT+IG9EW/2XtuExp7zTHlfcyBUvVOMzMoAszjtvRuAMhjMaC2nvTQ70TBV9oi6qFoXgOaI6RrE8oRV9Ioo
X-Received: by 2002:a05:6e02:2192:b0:433:3396:5fd3 with SMTP id e9e14a558f8ab-43337823a17mr14759935ab.4.1762207905314;
        Mon, 03 Nov 2025 14:11:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-43335b2c243sm1396125ab.17.2025.11.03.14.11.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 14:11:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-798920399a6so5537133b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 14:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762207903; x=1762812703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mIukxs2eDwE3mLXELpSXoxd+kJ/H0EaWzJP2uktACOw=;
        b=E4icyLMrchO9kh82wzkDJRwJIIGED66UN7dERQjNCX+V2iZDAEc4otrtt3n5Qdb+lE
         RkTKTbzDlYvIeEyDYgvxbunk1+Q3cJsJhsu01nhLqcS9HGHGoUO5trLpBFs+apwsCDAi
         f4HMZPAblXIyuA0rA5+zSt8VCz4F4VLAuCABk=
X-Forwarded-Encrypted: i=1; AJvYcCU2JxZXyS0MMfBDW0FJfHLLtCkpIpNkwrN/aMCHvmeQe13+xjYLgCLw3FlDu3zaxkaCVt7MnDU=@vger.kernel.org
X-Received: by 2002:a05:6a21:3984:b0:344:8a19:524d with SMTP id adf61e73a8af0-34e28829751mr1186802637.2.1762207903504;
        Mon, 03 Nov 2025 14:11:43 -0800 (PST)
X-Received: by 2002:a05:6a21:3984:b0:344:8a19:524d with SMTP id adf61e73a8af0-34e28829751mr1186775637.2.1762207903106;
        Mon, 03 Nov 2025 14:11:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2893b60sm181227a12.9.2025.11.03.14.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 14:11:42 -0800 (PST)
Message-ID: <19e08c53-7e6e-40c5-9fd2-981675e85f26@broadcom.com>
Date: Mon, 3 Nov 2025 14:11:40 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Jakub Kicinski <kuba@kernel.org>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027194621.133301-1-jonas.gorski@gmail.com>
 <20251027211540.dnjanhdbolt5asxi@skbuf>
 <CAOiHx=nw-phPcRPRmHd6wJ5XksxXn9kRRoTuqH4JZeKHfxzD5A@mail.gmail.com>
 <20251029181216.3f35f8ba@kernel.org>
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
In-Reply-To: <20251029181216.3f35f8ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/29/25 18:12, Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 11:15:23 +0100 Jonas Gorski wrote:
>>> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>>>
>>> Sorry for dropping the ball on v1. To reply to your reply there,
>>> https://lore.kernel.org/netdev/CAOiHx=mNnMJTnAN35D6=LPYVTQB+oEmedwqrkA6VRLRVi13Kjw@mail.gmail.com/
>>> I hadn't realized that b53 sets ds->untag_bridge_pvid conditionally,
>>> which makes any consolidation work in stable trees very complicated
>>> (although still desirable in net-next).
>>
>> It's for some more obscure cases where we cannot use the Broadcom tag,
>> like a switch where the CPU port isn't a management port but a normal
>> port. I am not sure this really exists, but maybe Florian knows if
>> there are any (still used) boards where this applies.

There are two devices that I encountered where we could not use Broadcom 
tags. One was indeed a case where the CPU port was for reasons unknown 
not the IMP port, and therefore it was not possible to use Broadcom 
tags. This system is not supported anymore and won't be. The second 
device was an external BCM53125 connected to an internal SF2 switch, in 
that case, we cannot enable Broadcom tags on the BCM53125 because there 
is no way to way to cascade both tags one after the other on ingress 
unfortunately...

>>
>> If not, I am more than happy to reject this path as -EINVAL instead of
>> the current TAG_NONE with untag_bridge_pvid = true.
> 
> IIUC Vladimir is okay with the patch but I realized now that Florian
> is not even CCed here, and ack would be good. Adding him now. And we
> should probably add a MAINTAINERS entry for tag_brcm to avoid this in
> the future?

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


