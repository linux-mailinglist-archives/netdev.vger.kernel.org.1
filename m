Return-Path: <netdev+bounces-236918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F1EC422C3
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 02:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE061886A5B
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 01:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A48D2882B2;
	Sat,  8 Nov 2025 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LwF46o8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9C287256
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563736; cv=none; b=OksUwKXI7GTdoD34M+GZWeQbye6yqiBsTlyaqUqyt7xj/EMAmP/UVM22n0eBCWHGTpguvvfDrIXuSvSPUiO6s6MZ3yEZSG3tMZ9dGr6bQnNWGAkLllM7hpG+VA6OIGM/lCvdrSG/AYmYFUy91OSscq5mEcIfcpJJNw4HEbBnlGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563736; c=relaxed/simple;
	bh=yYypKuNDzrnsPiv4+LgBrKjFl28v1GmS19I40yhmMBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSe8XYvSprv3hawlHrv6CxRoCTMiJqm3jNQT6euj1FFyMTjLImzu3livugWNnlm+VBaS7od/BeKSv29ENrqk6TPBPcLmJ7b1Houwj9WY9YR+3pKbAAD/mpgK2uniXpAjhwZwEdwoTCIP6a96yz1FrbxJR490ciLABbjbvIHMgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LwF46o8i; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-5dbddd71c46so585043137.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 17:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762563734; x=1763168534;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2KLiTx9z4PvssP8GJtKr+i7+87tsUxNJNIhNihcb9F4=;
        b=Nkm+56sIyGXI6oimEOEdv5N0AV1s5xbqtl/1DwCPEd8ovV57NgpRlN5HZrJfTdLB0X
         73eQqLQd/aOReeT8Mj58cWH7bvlEmoiia8AE8JnpuopM7JW5hclvcYd99AGNONo+r9Rz
         wyyKDmSpwJKjfLApHN04ak9DnJYyBpTCAWrG2Ea2Gqya8StdzvwiAg5Vx0stq+6m8I1J
         s1fL6z2GNP7da8bbjlrlr+LOYS0Guahc4qc369GVbyXPyxpjBv9nDgM3FPY6m4hPvWXh
         OY6Aeqbna97RJxLobj3Edj5nhMQ7k6u3KMq0bF0bfiHsMEe1sjAMdFBZbkl+Qv4+RiWI
         llZg==
X-Gm-Message-State: AOJu0Yx9UJ+qZL49QlMOx49ljRkZuUkXzRvxVEuvRCiLxGiCHxou5uoA
	9MXoc1Q5WMVnX7r9x9RBo6tEZn5btBYputceT+hc+iBaIRO4cN2mv1GRNpfWBihT1FfcK6hqZAf
	m7+foAaBSg+BSiTHGq5xDPP9IM9xltAm19ZVq+hQb6fg7xGHYM+HolbPTwsTddv+eV6TDHxdhT6
	Zq+OQ58wwFbAJQZNNlmS9aBRqdvf6a0m88YpXoWGp/wj/V63nAn0xPGTdKso/o762xcEGu1bOA/
	IBuFgJWnYLLgsUD
X-Gm-Gg: ASbGncu4khJnUDyw6/USeCyhO1GOiCak5qZAQTYtvo9fw8lxKFOfIoh07amSpvIFO13
	v6oXi0QS78ZHXjt78/9KDndCL4bmpapn2LCkUIScilTfX2GRYOXo+O1A7iqZLhHfnjl7oXw50tv
	t+fbY6GXS3xKDKgdE7/a9LacXjmT8mO6t6vKtxwHlWIrJJzFNGwizrlFhUzjc8zTVtGTBPIH3Ho
	KkzLe2RVi3uMU3OlU3VNFlVn/eFbxmr6iSWRL26iQRoQnCtJAgfdGYndp0/kBONLCq8Z/Pt9bgH
	riNIe9eOapq3j9URTiUEPXEyuBX3ih83eHifZjTyWezrjOZb96pM65UwgQH1Bv5dnOIjY+zdW5q
	ll18n/XdQW8vtCpLlEDDInWgTC5rD9osmSzjlwye2B2z6MOJ3aHFdkn82kqlSCk4w0Bbj1GYw3M
	5Vd0/t0ryg+weu4ckPe2L55m03X/ig/4aDSqtyW4g=
X-Google-Smtp-Source: AGHT+IEqmcsxo8xEKHjoTaCWhqZjyWmbOYyW+m/phyDoARoPFPQW6YWmzhzkZpnAVzXS4PsHsG57UeK1Gsay
X-Received: by 2002:a05:6102:c4f:b0:5dd:8a19:de55 with SMTP id ada2fe7eead31-5ddc4684354mr513423137.5.1762563733608;
        Fri, 07 Nov 2025 17:02:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5dda1fb771bsm587500137.3.2025.11.07.17.02.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 17:02:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-3c97be590afso633005fac.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 17:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762563732; x=1763168532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2KLiTx9z4PvssP8GJtKr+i7+87tsUxNJNIhNihcb9F4=;
        b=LwF46o8icTQTNjmPYvUWzVcEE4ECDfWolSmnzJYSYZjRF5rszZyDxJE7RUCFaAlaEH
         OaiAhGcUyijAwTcVNwdZSFBPtWkcwTF069hjFeICNbjvR9Hgzoiwe+hkNqBhKhgRvECJ
         TJh6CNYZVglQRZDS2dMckX4M1kxBghsOmsuLU=
X-Received: by 2002:a05:6870:b023:b0:3e0:b4ef:8af with SMTP id 586e51a60fabf-3e7c255e925mr1177616fac.2.1762563731825;
        Fri, 07 Nov 2025 17:02:11 -0800 (PST)
X-Received: by 2002:a05:6870:b023:b0:3e0:b4ef:8af with SMTP id 586e51a60fabf-3e7c255e925mr1177600fac.2.1762563731351;
        Fri, 07 Nov 2025 17:02:11 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41ebb0fc6sm2787027fac.2.2025.11.07.17.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 17:02:10 -0800 (PST)
Message-ID: <1726ca39-5c40-453e-82c3-50e9dd00df67@broadcom.com>
Date: Fri, 7 Nov 2025 17:02:00 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] net: dsa: b53: add support for
 5389/5397/5398 ARL entry format
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
 <20251107080749.26936-8-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-8-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> BCM5389, BCM5397 and BCM5398 use a different ARL entry format with just
> a 16 bit fwdentry register, as well as different search control and data
> offsets.
> 
> So add appropriate ops for them and switch those chips to use them.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


