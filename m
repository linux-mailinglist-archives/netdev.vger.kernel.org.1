Return-Path: <netdev+bounces-202251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21137AECE64
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 17:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581C016FC10
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E88230BE5;
	Sun, 29 Jun 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GVTHQ6K6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5C1F0E55
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751212502; cv=none; b=uHOmJ3oxOwR78UFO+GSh2pl+q/YZTpD0KERLvzd2TtDdl3GAdcn8wf7aRYvTgPVQakbjmEeT0g/fb/SV//uIBGDtaH3upn+QnvpIsMIpjRIn3A+3co6wNYPw8W8G+VyZMGEPKfZZxl7H3ioXdJjlCAoBsWquz4HdwGolzomm+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751212502; c=relaxed/simple;
	bh=7hqeM+s8qGiVK22Wqt9KuDJXdJ0loKcbmmyCBjn9RUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYMzEwFjD6UTnMxSIHPnSNzxpV6A/U5TraVo5D//QlULNFaDmMXwShIlGoGQzC7h5pkKZfw1DRKyzZ4AI5HFVsUA7lYfFzVe1MjA5hIpvKMB3ed9j6KO4Vdw25DPyB4OASrYQLFZonq58Ccc5f15CVZbmh3eg4jUoSOeKGyd3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GVTHQ6K6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so3956437b3a.0
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751212501; x=1751817301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yeqm6Oj1B3MxM+2GGrExdoU2J2pYPcyYcjdp7qgYkEY=;
        b=GVTHQ6K66Bf/krD1q+aPJTvXkrh5PrujoBwDLR9bX5hOI57/g3rPuWVo0NoRWPU56X
         uYl84rukuNXx/BIa2abJhN8YHN6WNOaU3F5u6WZozerZJySisocMXU5u/pLXGEdyOopw
         AWxET2+X83tdGLMPoDRYBZfQ38Q6pwF+0Bb4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751212501; x=1751817301;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeqm6Oj1B3MxM+2GGrExdoU2J2pYPcyYcjdp7qgYkEY=;
        b=iWoUYe7f4DSmP82AFh8hUWz6S2WNlX58lDs7zGWpl4ByBqKhtSFiM/AQDC+AH4zUfI
         4cYr+aowg1zIVDibhtiS5eCkKcOAxhaVpkVyCRF98OadOg21YzRnkCrFRO6bR65ZL14l
         SY2MD5dklnTYRWYQtRxqS6JiWaCl8McBd6X7Xvht7rtBxp4dPBa36kd6EK05HgcNGNr3
         tf5jQy/tam9tgkL0tb3UFrB05s2wZX7rVTi9ilIXkxQ2tNrJnsKIlvXTk6UzWFKZjWCm
         K8REkBD33kGheCILbp9I/nd9KvC9VwLmpOYH6WJBMPPRPpj0Q4CN+Gh8G6a/wDKOO7Ik
         LJJA==
X-Forwarded-Encrypted: i=1; AJvYcCXNmHzlabP2/raP+eakkmn6oG+a8cLxxYSC6RTYrrbTL7kQNS+wzvERDIopOZ3YWrp3N1VZ/1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/FwEmN4TSH0u9ub8Z5S2/JqtwcKuJpT24nsqaKTnLuvCbIr9
	22g4HYrmGpBBlXSE3LuOxLf6aG3K8KYV0Sa4ife396pU4Q1Mp4EMfTI/Fn58MtUNBw==
X-Gm-Gg: ASbGncss8gm6P6YMMur8dSquzK7fedaMir8+sq4JchTAnpRDZKasxT3YLEbECxcXEnO
	xjJEYfl18PTjRfmlEGNEcLO+s84ZnG26/fffcJ03YiD6jldl6EJHg9wHvyPt5AO8pj+llPOQtKa
	i+qstcxsoYwh1s9MTUi82AO+OFPKWVkvdcAyRKPqBKwDz40b6Hd+CzRahBqBfUcfaoFAopUAdFH
	qiMUJp4b1b8p5T6XPpxo06G9koU0v7RBDIbfzQUtCVM8JXG1ariFb6srivdIDhMyUcnNrL7FDB6
	/iDZVC0IVDtpvbIRfqm+aOeSq89q89EBPaCOR8rZ4VsOjkZJaUyD5TvxrGqNfRrLSTCnLUEysC1
	D88GcJ4aFH8d0xVFDAg==
X-Google-Smtp-Source: AGHT+IHvJHjgsPCwgL95BsSO9a9GmLWta/fUIYmxVFQv02LYZIB0gv8b1BqC2du/VWpmBrPa9QD0lg==
X-Received: by 2002:a05:6a21:339b:b0:220:51ef:5d23 with SMTP id adf61e73a8af0-220a112e9bdmr17275999637.20.1751212500750;
        Sun, 29 Jun 2025 08:55:00 -0700 (PDT)
Received: from [10.230.3.249] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c7e89sm7147150b3a.109.2025.06.29.08.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 08:54:59 -0700 (PDT)
Message-ID: <fc47c52a-b22b-44f0-805a-dc4d5e9fec46@broadcom.com>
Date: Sun, 29 Jun 2025 08:54:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bcmgenet: Initialize u64 stats seq counter
To: Ryo Takakura <ryotkkr98@gmail.com>, opendmb@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, zakkemble@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250629114109.214057-1-ryotkkr98@gmail.com>
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
In-Reply-To: <20250629114109.214057-1-ryotkkr98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/29/2025 4:41 AM, Ryo Takakura wrote:
> Initialize u64 stats as it uses seq counter on 32bit machines
> as suggested by lockdep below.
> 
> [    1.830953][    T1] INFO: trying to register non-static key.
> [    1.830993][    T1] The code is fine but needs lockdep annotation, or maybe
> [    1.831027][    T1] you didn't initialize this object before use?
> [    1.831057][    T1] turning off the locking correctness validator.
> [    1.831090][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.16.0-rc2-v7l+ #1 PREEMPT
> [    1.831097][    T1] Tainted: [W]=WARN
> [    1.831099][    T1] Hardware name: BCM2711
> [    1.831101][    T1] Call trace:
> [    1.831104][    T1]  unwind_backtrace from show_stack+0x18/0x1c
> [    1.831120][    T1]  show_stack from dump_stack_lvl+0x8c/0xcc
> [    1.831129][    T1]  dump_stack_lvl from register_lock_class+0x9e8/0x9fc
> [    1.831141][    T1]  register_lock_class from __lock_acquire+0x420/0x22c0
> [    1.831154][    T1]  __lock_acquire from lock_acquire+0x130/0x3f8
> [    1.831166][    T1]  lock_acquire from bcmgenet_get_stats64+0x4a4/0x4c8
> [    1.831176][    T1]  bcmgenet_get_stats64 from dev_get_stats+0x4c/0x408
> [    1.831184][    T1]  dev_get_stats from rtnl_fill_stats+0x38/0x120
> [    1.831193][    T1]  rtnl_fill_stats from rtnl_fill_ifinfo+0x7f8/0x1890
> [    1.831203][    T1]  rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xd0/0x138
> [    1.831214][    T1]  rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x48/0x8c
> [    1.831225][    T1]  rtmsg_ifinfo from register_netdevice+0x8c0/0x95c
> [    1.831237][    T1]  register_netdevice from register_netdev+0x28/0x40
> [    1.831247][    T1]  register_netdev from bcmgenet_probe+0x690/0x6bc
> [    1.831255][    T1]  bcmgenet_probe from platform_probe+0x64/0xbc
> [    1.831263][    T1]  platform_probe from really_probe+0xd0/0x2d4
> [    1.831269][    T1]  really_probe from __driver_probe_device+0x90/0x1a4
> [    1.831273][    T1]  __driver_probe_device from driver_probe_device+0x38/0x11c
> [    1.831278][    T1]  driver_probe_device from __driver_attach+0x9c/0x18c
> [    1.831282][    T1]  __driver_attach from bus_for_each_dev+0x84/0xd4
> [    1.831291][    T1]  bus_for_each_dev from bus_add_driver+0xd4/0x1f4
> [    1.831303][    T1]  bus_add_driver from driver_register+0x88/0x120
> [    1.831312][    T1]  driver_register from do_one_initcall+0x78/0x360
> [    1.831320][    T1]  do_one_initcall from kernel_init_freeable+0x2bc/0x314
> [    1.831331][    T1]  kernel_init_freeable from kernel_init+0x1c/0x144
> [    1.831339][    T1]  kernel_init from ret_from_fork+0x14/0x20
> [    1.831344][    T1] Exception stack(0xf082dfb0 to 0xf082dff8)
> [    1.831349][    T1] dfa0:                                     00000000 00000000 00000000 00000000
> [    1.831353][    T1] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.831356][    T1] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> Fixes: 59aa6e3072aa ("net: bcmgenet: switch to use 64bit statistics")
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>

Good catch, thank you Ryo!

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


