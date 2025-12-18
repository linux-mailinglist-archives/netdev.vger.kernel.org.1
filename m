Return-Path: <netdev+bounces-245321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A513CCB7E9
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7578301C3F6
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FD2312824;
	Thu, 18 Dec 2025 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="aF4RoEE+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8330FC3C
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054879; cv=none; b=SRW0B2VDumWELflxuLzu4WzxEG3x9UY8Q9N9vxL8oqEUOzk7YcXBCe8x7HytELOfh4KHbTPIDCQtE2zh6uGhO4V5RWXIByxjXtTwB3GbCX+qDd+9s55dVdqz2hhRempSN+otm2DofXOF0O9bcVpfDmaE0NKixHwc43GDA6q2n/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054879; c=relaxed/simple;
	bh=C94wtR82WZosBhwJeXMjomAJoz5qlm/EHE8TbW0CHRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYyczsx4PLIX6NHzgoygWBjEoHZF6Mi3utX1qmbYGQRmbn/tjkx/dx/gtx2YDFM62PFCV5+kh6KmKMWoCAeHOGwZGvMf+ZRnLbaRYr4iKgnpClN4KyEiSYW3ZML+Gt/5kchL2abnlv8+A1qNh6m7sRCAMA0tTj45jP/B2XFbrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aF4RoEE+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso289136a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 02:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1766054877; x=1766659677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQsHHsPqBsIwtZa6+F15eqWTVM/7tFhJlfrDEbVJnzo=;
        b=aF4RoEE+pmyO5kujTWbyt5G7xDA0T512AVVbQUY24O0W7gueEZxqjWbIiIkrps7IRj
         YPvWCWSJDLlDXXL6bzF5KsS1cLOvVeTJX7ExPXPVL3yut127PFnsQVgJ8nS2S4uo9RAC
         Ynp67q4KuRkDBRAXFRcaWqnITvfPxZv8J431bJll6Lkbwvn+X+EdtkC40pKy1PzT7QyX
         qSyhlH+j+vPMx66A2lFfhJ5T0xpN+0mDYm+EmOdmCboH/RMmkyk+EpKwqivLDtoedTXB
         /+mmpQLAoLiZVfex/Y0VBzNHPOMeP9x099rnIZbCgKhguhpmlJ0XMG5lErWdMeJo0f/f
         ga3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766054877; x=1766659677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQsHHsPqBsIwtZa6+F15eqWTVM/7tFhJlfrDEbVJnzo=;
        b=klMJiJGKLqJ3TOFwbuifvm7PdDI7yKmUZtwWLOBxHbqIlLfxaz0mh6RV6JPN0sucFI
         Nwww7CiEFOo7DrGkl3JRKcdTUTLjtoyZZ8rYmHS3lO864pbvsoh55He9Sc5gkeXoxmHA
         ybDcxmVb978SDLS7fzQZNxgrNuLd7dvcicmLrlQPaHYaG2TP4ct2EQ//g0pESvqYCFeL
         wAbLMLkVL9DQWzAMJVdaWZgURI46AZ4d5AlLlytpQJL0RnLef+CsOPbjTBJdSoG0qjhM
         ulJ+g5yoTocpNWsZlMgP5Ij7Q1T4XT0Md50aGkzlNoJ7t3BPBFu+WL16G3Jn8Nmb+x+0
         YG9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwlhOJxggfYaLXj8hMVk32kTzcT03naCnBjU3ZM73RFo4EL6yhuZ1d3xslDO6sHR+ur1+Udn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5+XWUu60lGNdELBXJn1Jc/VFdmvv/+8CIWrhDh2IteN9urEf
	8grkYkv5u2WxyVzullrxk6jEP+ZptYfQz0TveVK/y1LvLWOBNwh9o4j6i3exm+fCVng=
X-Gm-Gg: AY/fxX5l40ZJVZIkerJQheCyuxGFi1LAwjiHtbe1R/OAn+ZVUl/ehAvlfa+8SyrQBdR
	1jzZ1zXmSNUO5yBR693eeW1zuAvR7tsbL6WJjtYeR+6zSlSv2lu/g7eHOyHTek+fQBweTY0AfeZ
	reErrKkk34RY3VB7KJIVZAQfL06NRf6dHPn+NQM5/GHzKWNxWmxlpquGXLuAQ0GY9EZf+0RsNZe
	f899+U1/4L8fB1tAVFo+MceDkQTKB2mseUH4cyycXzKNX/oHT2Lz1rPeHiQxJL1n3E4BGfiWyRu
	GTGASAapUrX/WaQvINt0KU5RJsESp4SyBCzP+O3dAZnOhlt6zhiQBN+DRv48v2C4Q49rQweQJGU
	Cld0wY3s8dAbOxMdIbUKCDAQ/UM96Brf2LuTwLcL08qzEek+GTeK3FCrdRf5eyN2VisDRfKnqYe
	TQ3NBk4+IE05DXqrWu76Rxn9sHaPXGNfJIoe83IFz66Q==
X-Google-Smtp-Source: AGHT+IGXXlccKF4Rkh7bjvtuJ+L+NN0lCcnq831RrYUEbki8gizuqPGa1mG4ZTJ8rHdDDTqFJvX2ig==
X-Received: by 2002:a05:693c:40d0:b0:2ab:ca55:89ab with SMTP id 5a478bee46e88-2ac3014dce6mr15879824eec.42.1766054877329;
        Thu, 18 Dec 2025 02:47:57 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b04e58d04asm3393552eec.2.2025.12.18.02.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 02:47:56 -0800 (PST)
Message-ID: <1688676b-9252-47b9-97b7-c9dc28d7ac8c@blackwall.org>
Date: Thu, 18 Dec 2025 12:47:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: Describe @tunnel_hash member in
 net_bridge_vlan_group struct
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>, bridge@lists.linux.dev
Cc: Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>
References: <20251218042936.24175-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251218042936.24175-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/12/2025 06:29, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./net/bridge/br_private.h:267 struct member 'tunnel_hash' not described in 'net_bridge_vlan_group'
> 
> Fix it by describing @tunnel_hash member.
> 
> Fixes: efa5356b0d9753 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> This patch is split from assorted kernel-doc fixes series [1].
> 
> Changes since v1 [2]:
> 
>    - Apply wording suggestion (Ido)
> 
> [1]: https://lore.kernel.org/netdev/20251215113903.46555-1-bagasdotme@gmail.com/
> [2]: https://lore.kernel.org/netdev/20251215113903.46555-15-bagasdotme@gmail.com/
> 
>   net/bridge/br_private.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 7280c4e9305f36..b9b2981c484149 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -247,6 +247,7 @@ struct net_bridge_vlan {
>    * struct net_bridge_vlan_group
>    *
>    * @vlan_hash: VLAN entry rhashtable
> + * @tunnel_hash: Hash table to map from tunnel key ID (e.g. VXLAN VNI) to VLAN
>    * @vlan_list: sorted VLAN entry list
>    * @num_vlans: number of total VLAN entries
>    * @pvid: PVID VLAN id
> 
> base-commit: 885bebac9909994050bbbeed0829c727e42bd1b7

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

