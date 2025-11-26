Return-Path: <netdev+bounces-241987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C938C8B64D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03DF24E4D92
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0130EF69;
	Wed, 26 Nov 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U+x5g9sc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432B30B51A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180677; cv=none; b=lj1a9bMsVkDd1xknxcvlOeqFPuu1sU6i/SYiG8JqwDt5PnnIjxyIOrMvrVAoIsWrlllUIv7dMYVR9vCtnrvpM+zVeRY/SQcFF9gNb8kgIubduLuH8rM1MYRIs8AIuLqPnecqoXSaBSpJOT6+hk8AuHk0asPgh3nIAKzUhyHDt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180677; c=relaxed/simple;
	bh=BOv+7qPPfYqBXvtB9hz+WUu4h9pnKM11ELwwpnr47fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYlc6D9LYTAqYdH7yEI0Km6R1GO02Mw4vLE4TZkT1QehdlV1ATY4q8sT7LskB8HxKu0DGfnSAe+8MdteUrHOg7UbHk4HBy2SXVAynUUUtPqDUsXZ5zrH8XslaonIsv6VO9wUukxzlYOoS52VX8YVCROMp2wj+oC9fHk91P5yjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U+x5g9sc; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-882399d60baso262476d6.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764180675; x=1764785475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wOPELGXMQMUZTyBAQwM/SIRQILBhRxtVvlU20T5W2VE=;
        b=g970/z9lA9gLruOAHGRtcUV8u0LmrfJE2KTiqcorAEcJ1+z4hF387leV5U4xkgrex2
         VUn39SvBtN7aymUpMd7nASFgPFq6n5fpEhf8lRehV/Ah5RoNZRV9KwCVylQfnCkxF047
         zAwCRY2N/Ss7kVqvNzcw1vBDh9t4u8Az82pDIDDdt+qxxfiifRX0HrSQEEdReJ0h4YA9
         /2TbcC7tHfuUwBzr3QqjySRDcuae+E7cGVSk2yV12Q/WlNixaCoK4uSpGkeASBvMt316
         9jjCpfv3EBvnIP+kNFxmrqv2UdgJ37xikSIYU4iCsT6+IB2peEI/8Xs3DsoorBcTBjnD
         IK+A==
X-Forwarded-Encrypted: i=1; AJvYcCWlZ2KQRIO2rV6nyoJZYxyWcXjJDTMPHNAE5cg/YIAeH35Qe9H1bC3Ofc9ihI/SE9UHZmgNvqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jW9dkaTk3Ad3bEcyMhBqdZ3HAlIK8NjMEqHGeclYsMkg702x
	81nIJCa0seSuHlBAcYS6nXdyZAm+/GNATx16zpNPx2D8YBOLlU+NrQiY5M/tzNNoKMGQP/tRle3
	SkE1sebqYWmnmHpBV9STIrVz047uj+ryYizRGMQTm1EsxgDPDpw6jIrITENudgHDV4HcBzP5PKy
	dVz4o2APrQlXexU1uan8juKXwrLQ6gBSJfdBFyiLmwrG6AB1EY0vmshp64i99fkabb2j9Cg41fD
	VBJemvQdE/DLJKD
X-Gm-Gg: ASbGnctEmaFKwlyiekSu9IiDqAiBMC2PjY4dNLf788zQXd8VsohNv+aDAGlwmR8OhWZ
	yCjv6Bium1Rh+jXOS/R+K/zZ6Vw6IJTqeb2QL0ZdG1IQjOY8eAYA+QkCZffjd7gLqeHijLjY8/I
	h0pqhoz6jt8GF+sjQkNUAZikPraBK9CiYv13NcGrjLHTFXP08unOolOxL0hyY9qf+QsDd6ZoIWM
	jLvd1/NzFd+Eh79p3ote4MGcow34vcpvtcPw7flCm6VWSq4IIZgYQdOGbozs1Clx1658DTpDPGe
	WGQbNjt/M4lyw3oVQtDprpnVXUV7drlyosEYMnkJ3FXZBFHYDx1JOBkGWgclEa8iePi0EqmRCgl
	dOsnru+ORsoCWo6fG66TLiwgkY2N7hCZKRwtfeA+yDvWEuNvZP+JQjY7g0rYuKIxFK4ZERfloUm
	GGmXrLh0CI2sshizEeYro5m8GlMOtdx8aYuD9kXsyfB/E4cSnRL8z6
X-Google-Smtp-Source: AGHT+IHlW1z3HzcTmWrhVRPblZ0gBBQcBfPmOBXem8PG6fcg2UldGA9XKrJ2oyRjsgEN0V/iWk52cDpOGh1d
X-Received: by 2002:a05:6214:2e43:b0:863:5c7a:728c with SMTP id 6a1803df08f44-8863af6dc24mr124857346d6.34.1764180674845;
        Wed, 26 Nov 2025 10:11:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8846e57624esm23597086d6.16.2025.11.26.10.11.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 10:11:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b993eb2701bso77069a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764180673; x=1764785473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wOPELGXMQMUZTyBAQwM/SIRQILBhRxtVvlU20T5W2VE=;
        b=U+x5g9scJiQYtmdxr/cjck4NwZidTTcJzM9BbPFz9qiJTb0bXs54lxhixU6jemS+hN
         gpM3QOoPY8cLL1Z9H7Yry0ltFSSgfy7p/T6qSmiS1cIJ3mMwLCsynhxRqKm82G94nWFD
         OQjx6REgHMfiqtqneqrno5+a7VS9m/B3lHd3U=
X-Forwarded-Encrypted: i=1; AJvYcCWdsJ8uxUvgJ1gQ43majmL+4GOBIj5g6v9Dt4rQ5vhmqX8ohCo+VYAPC17Vk1qJQy64RwNrpt4=@vger.kernel.org
X-Received: by 2002:a05:693c:2b17:b0:2a4:7697:a835 with SMTP id 5a478bee46e88-2a941593ea3mr4059843eec.14.1764180673502;
        Wed, 26 Nov 2025 10:11:13 -0800 (PST)
X-Received: by 2002:a05:693c:2b17:b0:2a4:7697:a835 with SMTP id 5a478bee46e88-2a941593ea3mr4059822eec.14.1764180672884;
        Wed, 26 Nov 2025 10:11:12 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc204881sm85114996eec.0.2025.11.26.10.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 10:11:12 -0800 (PST)
Message-ID: <149edede-4db3-4453-a76e-f09dc8074630@broadcom.com>
Date: Wed, 26 Nov 2025 10:11:11 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] net: dsa: b53: fix extracting VID from entry
 for BCM5325/65
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
 <20251125075150.13879-3-jonas.gorski@gmail.com>
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
In-Reply-To: <20251125075150.13879-3-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/24/2025 11:51 PM, Jonas Gorski wrote:
> BCM5325/65's Entry register uses the highest three bits for
> VALID/STATIC/AGE, so shifting by 53 only will add these to
> b53_arl_entry::vid.
> 
> So make sure to mask the vid value as well, to not get invalid VIDs.
> 
> Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


