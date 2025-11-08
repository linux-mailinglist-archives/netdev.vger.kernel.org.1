Return-Path: <netdev+bounces-236912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9798C42229
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 01:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E001892BB0
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 00:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7AF280CC1;
	Sat,  8 Nov 2025 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cbtJNrWn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A42798F3
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562382; cv=none; b=ABDszyIW2WjxKZWkE1PD5TNxsyrp89mJh1DktdObA1erompfmRbsUVmeyRhPi2DelLL8JD08UxQUnfzOB7xKfLrtyrCH4oMbbfE7fM3x17bWZsVYtENGgRINdBmv/F2PvRN8tbouAVr6xIGKvwqugj6Nu5vtsju3jYA4DthYoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562382; c=relaxed/simple;
	bh=g39YASjqSO7130GjXqnikm7hPktau40PI9WdldTf3zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2I8xNNKfvTwfjQ0zyEIi6iPiaae08LpZ1GFuHteOVzSAlSMmWoQl50gV8gz0wvfLC/hMXrIWVw9ZgSjRBqpIDXiKXxFTbt4fI0HhC5gQ0y8pQRms/rimsrdbJRSZehD7XyWTZ+XiPA6RRUCEvNcF6JgSXeRwyeTKdCXxxXlU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cbtJNrWn; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-7ea50f94045so12112386d6.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562379; x=1763167179;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jGyR352isTozpneLwHRAuD7ZvJbNROvjnghKEwwrzs8=;
        b=nMnza+aDpKe9QDCjDNSgAKLuUFBXQ/mMCtOAQCRDzbcCgi2Xm2DzJdK7/TP3StiqVA
         YnRdCT1f6+iaBdd+3TACqn13qoibVDq5lkbHNyNk3MKhnQXkgajNhvbekBlqU/0N0P/9
         muG5xw2waWdBxhgPZrB4Ojqky1aUGrGlTvl9ZZrS2igflAnvqwdiPGVrh6nOigPFVvvJ
         uyyp0xVmfozjh59ytYB9XQ+L/g6Wl9At6M19SsM2ZP6K9/HlDuAq2cvftCcZyuaWRXjP
         TeD/S7aVC+mAgQ+mPyaN1RXsEUA8URTxUA4z132UjgGa4qgfgppAvAmzQJQnjv6ao1GE
         Ez/w==
X-Gm-Message-State: AOJu0YwexMr6R5Ex6PkHRq9JiJOHMLGgGiLRfnlTIaeLFVXe3clyclFe
	miU1DOo1+gfOTeh/oT3mlpnVZldJ91a4KCZGiD+AMmDYCE5BclJM4rjGd5+Kro5+6h9Q5YrHWLg
	oHPYvgPMtcaUVDWb4zcwpDhNlk1/80CBTAnG5G773gRDJ4jQvTTxkaDJ2Kn3whd9HpSvvDtl9Ty
	wnB4BboGwJSWc0W1DR3VL2uDY8yZBW6wSMaMfcCVNVNIXdvJv3ELzV6Mxb6aoCZdVWVOA5v2A3p
	Tt75NxilHMzNUoa
X-Gm-Gg: ASbGncuxSc43be5EwDO1XzqSgf6AyHA0DHr0Q0UvgHZugdrZ3rXN+p3nF614bZ9DU4A
	7Em0Q+dbtKW0BDZ4VDFnFfm58GFsnk82RSS3peDQRJRUtQO2hJDs8BUghGyNBtp4Tb9oyy2GiLA
	6DSkVH3xwe49bSSvQFs2MJGQOmRvFL6wgjlM+70+dq6zOEq5r+kG1VXzR5vemRX8E/c43lrGMn5
	tPrctfZ1WdPZ81YmkwvypzcKSX6sEFbJU8p5xf4UzxwpZsiOgjuxpdlEJ0RiT/a4W5+sJtaBEMc
	47zLO+PMUSKyM4Yyd/43FQ4hXbqDKC8uSmJRbmCIFkPApgNtFUtyWG6m1eI74D6OVLBr0T5/tTx
	Lc4apCNp41ALh9oY//VUhi+rPEcaLUyZHZh2aHOe/MhxEm/OVtPn0OwYoAtAbDevftZLdvDqKQh
	CXJo07lkYzB01sEj1MP1ia8XnaiaLS+eF6pFKIuZY=
X-Google-Smtp-Source: AGHT+IFcnAoSllcdTdRG7BRjmpHQ5JSLNAwk4bkxCNl/3qK5v8/2n95siBpM7h+qmpWh7K7WgGuhPG2MwWiN
X-Received: by 2002:ad4:5ccd:0:b0:880:5589:54cd with SMTP id 6a1803df08f44-882379eca73mr20844536d6.19.1762562379058;
        Fri, 07 Nov 2025 16:39:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88238b21701sm723506d6.17.2025.11.07.16.39.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:39:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-651e6698cfbso1976666eaf.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762562378; x=1763167178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jGyR352isTozpneLwHRAuD7ZvJbNROvjnghKEwwrzs8=;
        b=cbtJNrWnoqObOlkcNNHP4T6cAVA+XjYX1/CBkjMyFlrhyYORWhK/i4vRIJTXHHFO3E
         dpMhcHAhSniRoZVHM+1HOg5cvRnD6yrCN2a++voX7oA8b6T5V7MLNqyJLKJsPSpz0sbJ
         qrWzPbjs4B4zrea9kDSk3NZMsmqL1njlGSPFA=
X-Received: by 2002:a05:6820:3087:b0:656:bbd9:51d7 with SMTP id 006d021491bc7-656d8cb6f44mr710829eaf.2.1762562378351;
        Fri, 07 Nov 2025 16:39:38 -0800 (PST)
X-Received: by 2002:a05:6820:3087:b0:656:bbd9:51d7 with SMTP id 006d021491bc7-656d8cb6f44mr710817eaf.2.1762562378029;
        Fri, 07 Nov 2025 16:39:38 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm3153782eaf.16.2025.11.07.16.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:39:37 -0800 (PST)
Message-ID: <ca051f0d-34cd-4058-9239-9b15db158c57@broadcom.com>
Date: Fri, 7 Nov 2025 16:39:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] net: dsa: b53: b53_arl_read{,25}(): use the
 entry for comparision
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
 <20251107080749.26936-2-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-2-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> Align the b53_arl_read{,25}() functions by consistently using the
> parsed arl entry instead of parsing the raw registers again.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


