Return-Path: <netdev+bounces-236917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F535C42256
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 01:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5992A4E8B44
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 00:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55727FB25;
	Sat,  8 Nov 2025 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QM7035nR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610626E6E5
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562634; cv=none; b=dmi2oXYqa6hh5jzFVV9B/XkWh1XdlgH5psQaDTnKu4tolcIUWK3MATFByZQOpoEnPG0c/xhvN/Jod7zGVsG/pV1rp+xlCxq5EDNRZ6rncYfaIylqDf03nm+2pAsQqW5ZDubEv1k/vXg94YBsgqLpBlx7ESUxkIegwKjHhE2rFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562634; c=relaxed/simple;
	bh=vAeJct9AMkGPgfmMi3kykGsZlO5pFFP0fK3T3Fizb44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF7CXZetXj7RYdCgt7GEVLzBqVewlgeaCn3LDbV9Kp1yFgng3edOLyt++3vFSAj5OMjoAPCBaYGSgYh74T9tmiVBmN+pdkJHy3ItvmTJU6kXpo/0H/MsREOPuT8/aMRGJmoXPhRKCG9NeICnmR84LmKEfFKSXgEmblqU/IB3Aw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QM7035nR; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-297e982506fso766755ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562632; x=1763167432;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5mnLb18c1kWkhzhd3oWKLRctbwgm3hHIsiANySVejY=;
        b=pPA2C6JQ6sAIkewODqd4PTxWq7rRi8VEKB/2golRo3kbPZRmAbY3zslv9IW0NRwBfN
         VqsTgIQcBoTWLp4JKInHQHvssyS6HEZSiEcbAb/RzTXMoxf+qmWXcknPOX+x1H2+8e3H
         8MpAp3dkbHujULoJaFs48xabZalccp9mDqpD03kYg4nuhiiLclSKU3jrphW0yuawDKHr
         ToMuBlkv6o9k+QzICVfr+5p9yhRYE5v//4DHDQtCr7Lj+onepJIsQI5cHBjnpNzch6z6
         NVDj0E4RUmfZ97Y9k6SKw9s+M4T4OmaH5SlqL5D0IZHNPhFRTlZhuNnUHROcK4mNaShY
         R6IQ==
X-Gm-Message-State: AOJu0YydHVWX2vAbn957SnReF8KhC3KgXR8VB2NP/2CSq4NDirXy9Xv9
	EivXaYLf82J5EGpqPAm4Ta2oFulNQ6SgF9iAATzQIZBPzNMXI4/GTcnSrBVgBnycIY0B89KasMd
	V8U0zr061eb94TB3CqNBc8Z98efXmQckbt7s10xleNhVHXfWKlv5UqnK8miO827dEzJQ20SFiSp
	rjJ7l1LOBCEFP7LQMWMLwwdwyZx02EwGGFxg4wAacsEmxIRwlG5xCFSqwfQKBZp4k2wpSu1iaZe
	dkm7jdVS2vIH/4a
X-Gm-Gg: ASbGncsKXcoK7ijh3q3CgjGuNM1O9nk83F/2KE0lxlzKK5RiHhcyxPV6xG/+zxXQwLH
	br4by/OqZgkjSLnTaedPKzdZnDSyWmClGzY+1jMSQ4rprJ7VWfUFg7iPdZI9aKpJ6xgTc9pc5Vt
	H8l8uX1e9omaRpXsoCpUp++b3rc8U/xyU45fwDqZ1pV+JDrMdu2O5VRARiyVvTAHk51SeHf6AqF
	XzVPZRlXdVKSgvpF34lcAh73q7rzFZC7PwXFVjK6iOFhohK735ULJitKWtexfkb9kQktZk0bqTu
	dQfkjNs6ws7HHX5ttfA3zvuhYQQHUoJGT5+tVVmQthoVFyyHXEUmMOBGdSJLrmEo95TW8EfOaCO
	FY1c5bO6WlOKLXLhtGBsLpXd1X8Re8GtKju1QSWiCAafzNCnQfsDMWzfVgoLEvFTxkSyUN33bOj
	NESwZRk+iFPTeDRlyOfWXAvyV7MB3dti3nivuKuGmcDA==
X-Google-Smtp-Source: AGHT+IEcOt6EE05BOqPIDfllW2Gj9S0JGdOSWNhQA/nKoAC7AA0L4UnstvZyONgEOxH1/uuM+XQl4SWqKKmv
X-Received: by 2002:a17:902:f68b:b0:295:8662:6a4e with SMTP id d9443c01a7336-297e56dc469mr11565625ad.47.1762562632052;
        Fri, 07 Nov 2025 16:43:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2965096e4b1sm5787365ad.9.2025.11.07.16.43.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:43:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c6d329f19cso2950577a34.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762562630; x=1763167430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t5mnLb18c1kWkhzhd3oWKLRctbwgm3hHIsiANySVejY=;
        b=QM7035nR6UFRBShbiiBn/+6AItlKs3tQ+A8O7Tky/mC5AaLKG1TSoZff/yQawZp8LQ
         ccBky6b5zMR56q5l/u7m8na3VJtuhMxBoN0yhhbH1HsFQxZDKXj55uOIlTkUAc3TFVNR
         AJSOU5Xy+rud5g8uAJUE+Ny6R26p+du2jZ7CU=
X-Received: by 2002:a05:6808:180e:b0:450:13d3:fccc with SMTP id 5614622812f47-4502a321df8mr714083b6e.12.1762562630659;
        Fri, 07 Nov 2025 16:43:50 -0800 (PST)
X-Received: by 2002:a05:6808:180e:b0:450:13d3:fccc with SMTP id 5614622812f47-4502a321df8mr714072b6e.12.1762562630290;
        Fri, 07 Nov 2025 16:43:50 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4500280856fsm3034390b6e.24.2025.11.07.16.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:43:49 -0800 (PST)
Message-ID: <893ab5d1-cf71-4bf0-b855-ca2123d98e7f@broadcom.com>
Date: Fri, 7 Nov 2025 16:43:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/8] net: dsa: b53: move ARL entry functions into
 ops struct
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
 <20251107080749.26936-7-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-7-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> Now that the differences in ARL entry formats are neatly contained into
> functions per chip family, wrap them into an ops struct and add wrapper
> functions to access them.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


