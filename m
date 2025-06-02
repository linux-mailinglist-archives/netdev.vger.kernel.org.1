Return-Path: <netdev+bounces-194649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC44ACBB4C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05483A6225
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3171CA81;
	Mon,  2 Jun 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GWFmNgou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4933F7
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890844; cv=none; b=RR4w4tYXFU5Cnmt64MtXy08o4VWOqxVbJUsmwRhn7u+liKhh++voJQ/BwDz54E0V5MQfp2Z7skTbKpNt5J152zG3yQyiH69ZyuCSe9ld9kqwW9slkTDc1/AV9vL1I1lnlhV+qjhZQnbTj8gw/oPQbyTFp0f61ay2uyceieAuaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890844; c=relaxed/simple;
	bh=WTzrwAL3v0QbUCxwUDRBQYjEh6Ha0q2pUIzeniOkvU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cpA6UEIITnOBpoL9a9xD3AZhBTBLIzFf2JSPFr3n5J+lO3+xA0SMueiovTRANsmWQvVduFWF/0JG5X1/91/k7C+9lZaCHDafuQZQjTUg7zMhCCLB62Aka3MrQ47orqEsuDS/9hK08CfsorTYrmfjB0thjlsD2yXKNsbO/rKj+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GWFmNgou; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso3443930a12.3
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748890842; x=1749495642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GcH20JTNBaY4y9WzIt8drFwfFqd3EprUGDsBzYEQ4V0=;
        b=GWFmNgouELc3vo61GoOOb7aPfDIpnoUyL1bAyI5EL5GmPaAAUCFD7fzNzlo61o8PSG
         CuoB9UPxxDE557XbNj5K45cf5UPzrVwIcz9sLOLZDHBAvyzC70fnfaObk26ipc6HNNmK
         QNB1Qa/hjqx0JD1oz893vxym+pRGZFu2nKrk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748890842; x=1749495642;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcH20JTNBaY4y9WzIt8drFwfFqd3EprUGDsBzYEQ4V0=;
        b=xC9WiyHcG3+l0pbjMWvINnbENZgtz4kANWul2/frwQ3Doa8qWyzIPx/SyX16DjkznB
         YBNTQuoPJAT777oPQ/uj28cpQSYbuXJClz3U4EXOLc62R3vQsxuco4u92nsrp0zSXi/w
         9hKHnNs8/1fHlZtOT4GkkuxPn3bg2pAIn83SY0BQfl6cvopG5xncxASyr6Kap/r27hGZ
         XFsZh9BELDWML0Gc/GaAIR3eRLn4j9hJgm9nXqA4C4MDnGlVGzciXRfE/OXg1Q7WD8Pc
         gU7hlmR+oxWhhVWyUzc5EK29ZYFSsRCwA1FZM7hG79qqDES36eM5sYHwoDLakr0Jqlrx
         CV1A==
X-Forwarded-Encrypted: i=1; AJvYcCXOnFGcNs/LJON5Jq7cDQ7dRbGysxVdlws/dYrc1Ee6k/zpfwiDt9x8iW1jIG0TkzcaPe9DAi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhOagCamkBp4RtAlpQdUfrYTGCw/2yJ3hynaId+AHHDcybVeYW
	2oQfhRgO7c707ZXjbu5MfoTjcGZqMWiHa6XZZv9vm/Q465n71LAoG2YpmZ5nOn/xYA==
X-Gm-Gg: ASbGncv2E8O/tgyf+tiXUxmbKpMXGxw1BbTnawCP3Y69URAiH+shjb1G3CEhz+8RywJ
	D3x67aw4UuaX4fS/3G/WSiazRj8qmvOdX1OJvgInSBvi5wC9cwxBoLZ7/AVBSIqBFqOz1o7ZdCw
	fnrFh31Dj4b9Z9wLRkt/5tuNhCcyirzHcj2zBkp7/W/7CkqCLCoUMDEHaCouVOxuAGWtexw3CH0
	KePg+SbuLxy19SCGXe7W+MnzKDLbP2th8Y8G+1jI02cOAH/HjdZQrG1/l9jqCcNHzmbUFrxAFnX
	LuDKgKJUmd7aIxSRuTFw7Z31HLkfqnYs5ypO6QUJanfwFeFOA9au9brOpCBGLm9y0v4BiS/0jGl
	+Z85QohecbDZLQ/bDBSg03V+eUQ==
X-Google-Smtp-Source: AGHT+IHIrpvkNgSlMz38q6LQHuGQWpTAX7KFlJgjFpEk9HBf0Ufg3NNhVVaSy4N30OgFCMqDHFsaDw==
X-Received: by 2002:a17:90b:3b90:b0:311:eb85:96df with SMTP id 98e67ed59e1d1-31241531935mr25379469a91.17.1748890841545;
        Mon, 02 Jun 2025 12:00:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3221a4sm5923401a91.42.2025.06.02.12.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 12:00:40 -0700 (PDT)
Message-ID: <53748db9-2efb-4e8b-9583-5fe21fc4b993@broadcom.com>
Date: Mon, 2 Jun 2025 12:00:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] net: bcmgenet: add support for GRO software
 interrupt coalescing
To: Zak Kemble <zakkemble@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250531224853.1339-1-zakkemble@gmail.com>
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
In-Reply-To: <20250531224853.1339-1-zakkemble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zak,

On 5/31/25 15:48, Zak Kemble wrote:
> Hey, these patches enable support for software IRQ coalescing and GRO
> aggregation and applies conservative defaults which can help improve
> system and network performance by reducing the number of hardware
> interrupts and improving GRO aggregation ratio.

Without this patch, seeing the following with an iperf3 server running 
at a gigabit link:

00:18:19     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal 
  %guest   %idle
00:18:20     all    0.53    0.00    9.36    0.00    8.56   18.98    0.00 
    0.00   62.57

and with your patches applied:

00:00:56     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal 
  %guest   %idle
00:00:57     all    0.00    0.00    3.29    0.00    1.01    7.34    0.00 
    0.00   88.35

so definitively helping, thanks!

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

You will have to repost once net-next opens though:

https://patchwork.hopto.org/net-next.html

Thanks!
-- 
Florian

