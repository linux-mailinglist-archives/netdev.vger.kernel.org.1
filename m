Return-Path: <netdev+bounces-191667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2911AABCA54
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589901883F8E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C153BA3D;
	Mon, 19 May 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J6UTdW4Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D481A262D
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691455; cv=none; b=PaNMVugFobifGQpkgEZ38y0ef7h6A2sSLE6CVzZ1T6NYOjSZ1piNm2/OCLn4Vu69RjN9Rf+MRXXnbh69mERvVBEzS30t4En3YmAlIoVNr68mzxrh2yOiZZhJv8iGRSUlb2OnpgTTSgtjrmXL898L378FpOdNS5APvTx2uC8QJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691455; c=relaxed/simple;
	bh=YfLDV8PW3arTrItrhRXCiwNVcAsDhyOhV6cabaT/F2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=svHXSMu6iJnyfrcOff9zNE6iJ8J1P4NmTfXLJaLueBkXIIXIG0vVbJe0IXQTQRexYiw7/argfkI2aIpE/OpVXduEAMFgIrS3FocbBAurAw8k5r52hjbS8Pa/WX0XVcFBHMkQEyFnBXQUoiXskSv9gFCB2Xx1tBapOdtBQHfseTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J6UTdW4Z; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30820167b47so4022265a91.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747691453; x=1748296253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JoI0Ad8vXEKcjj7c0mVyJHAT9DBx9v4StOdgPr1HKzI=;
        b=J6UTdW4ZgZXbHQbJHnq3W/mc/biKOZ8erlIYRQJt+8Q20c9GhuqH65QLpXdeRS1CPv
         9OcVXh8YmYaJ50fC5yCaf+idf3AD2bk6FjL1ZOoHz9gM0m74Pa1OIM5QxjoGAcTuE5NO
         qoB0FbP+WWzbslph5bOtpJeY3VeQcrUjwz7h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747691453; x=1748296253;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoI0Ad8vXEKcjj7c0mVyJHAT9DBx9v4StOdgPr1HKzI=;
        b=arzerf8SEPB4+wpHu9J5/UbGFK3BowC9JlPIanUwU6ULNzPa622bczeF1j95sPuEhY
         Sq8YyiOnc0a4INX2qdG0gcVmPD6FjLP777RBu490ubcLJ4izXWbTcA0JuLYemgINiD1T
         16z1/eaAirO8oKQcxq+npqKd/6qZhUAwAWCjUmw7J+AWLMWruMJ9FjOaeOZZJv80f3hK
         jkjzuv1r5CrbDhM1b2G58XOvGdTJLmpS5VnUAXKSSksDm9Nz0qoZLtLoh7dJj6eKvkgK
         iGGk7GUKb45hINtmormXPBlK+bBwwinyQew4jWaNBDciuxNMUUa8ExZvH6+X7ReyrzwV
         Mbzg==
X-Forwarded-Encrypted: i=1; AJvYcCVbIz3ez6sEMQEmoADu29VXWKuBshl9GvC3o28FYy0zivd+xXoyDdFlCtJV2IhSxZD5m6Vm6Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFdceTC7O5s2DHqaqTsaJfRWEU6rVQ17H6aXzdmpCl1aMWoim
	9su4HOOsCtvfolTt1miaGeugxpi273ERFTspngME3W7FqQTqCu1kIQM5xpl2wPq1DA==
X-Gm-Gg: ASbGncuUvYZ6So6RT351L/qLw+mM0rHlgkOQE3U3Yz96Fr7cntzhP9AdMqIOhIFR2hv
	k6fAvM2qWvwoG9abS3Loh36Db5yNy3TI6oy415rmj3Hk+7RSCUBIgulIDVy3kuj6nt26qMoqdfQ
	T+chvrkDfPGgOpLdekNoHow8CCO+PH6muHqIfo8ClLk45SOQHjzFxLuDjLFv8yYCfdGXRQYVIuO
	Mp9u/b5xMe5BYURMEqurh2bTrxFpFQu9N1BibGy9U9rdIjOwDnofnXvEMY0lV/EbeqrC6RQ4vzB
	Es8pXzWccrH+YApGBZCmLHepTEAO5OQl+CHJoNzgMbvtzq3fKx3zo16Iuh95yuWksl8D3q+FJSG
	i4wVVOzyqPMZ46Sy/prCS9coMCA==
X-Google-Smtp-Source: AGHT+IHWjss/8w7QnJWaDvnp/XY1GjLa5xWSNrrY94KscMc6U7LvP5JFkKSbbUBIM7VFyWpybhylFA==
X-Received: by 2002:a17:90b:2ecf:b0:30e:8fe1:f787 with SMTP id 98e67ed59e1d1-30e8fe1f8bfmr12324143a91.5.1747691453154;
        Mon, 19 May 2025 14:50:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365f3487sm159150a91.42.2025.05.19.14.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 14:50:52 -0700 (PDT)
Message-ID: <9c444f3a-26dc-4554-9703-40ee942bbde7@broadcom.com>
Date: Mon, 19 May 2025 14:50:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] net: bcmgenet: 64bit stats and expose more stats
 in ethtool
To: Zak Kemble <zakkemble@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250519113257.1031-1-zakkemble@gmail.com>
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
In-Reply-To: <20250519113257.1031-1-zakkemble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/25 04:32, Zak Kemble wrote:
> Hi, this patchset updates the bcmgenet driver with new 64bit statistics via
> ndo_get_stats64 and rtnl_link_stats64, now reports hardware discarded
> packets in the rx_missed_errors stat and exposes more stats in ethtool.

For this series:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks Zak!
-- 
Florian

