Return-Path: <netdev+bounces-99674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE55E8D5CB0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01261C219EA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89C7C6EB;
	Fri, 31 May 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="NvLwxWoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC7EEAD
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144070; cv=none; b=mUmh4u25WU3IuvGefPIxTAVKcjXPnylrzOeimqh+BLiW91TihKXOAl+ioOhtkGlWiVRqy55urvTxqxO9aewxQbt0DJXnYy4CDM1kODQ66Uq3+JZDSSW7ZWIxcNTzqq7lVe4OA92++Q6PcmAGlIfSRZ1Y0Kih0Er86O5tuzoyQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144070; c=relaxed/simple;
	bh=IJbxPCNMouBhYz+nveoZZGH8XvZoT3tJwwUzzzEqNFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoBrmeksiCxnhsPidzuFcH3F3zS6BnWrMBeOPsXxgzsr0aSj1ePb4W4TbwyFBCcN1roHVuHUE2R7P3DUSIwjMInywgLVb9Fs1UXlxK5Ncw2RLxm9nnnzogOG0MSLsjjgt/SA7sZoPrv7Hfb6C14R2GR7E05uPYxMOGpuQ6LKrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=NvLwxWoJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5789733769dso3222106a12.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717144066; x=1717748866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CczSpm496AORC0Lz1xbvgXRHePaSNFD5ety9dh5tj7k=;
        b=NvLwxWoJ91NpvYkgAPpMbGDSrw8J9Jw5VkSInZhxBQ3B+XWAsSmNLI+27G7YXX5Out
         z2tX8hMxGxBmij686aWzh9S56tJSGA2aMf8+pmRkQSAlcjWZpvM/fwILw3XcP/EEv5kH
         eBUGJ4BFPqank3NdeIu7qpwZJs4uCWWTDOPZj8N1DNDfeEcED04nuQf4ODdE/fLPaJ51
         kECjWrd86490A9fkYi47OQC50B/6FbNoj+9zfBhIcMZXDoRnk9fQCUn/TZK+8jf9iKx0
         /HHrBo5p9hhrJgtlXe34wrJPI6tztD6SCBfyMewgvJVIq9GEyvdrmWtXaj5I2/wZ4lLd
         /D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144066; x=1717748866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CczSpm496AORC0Lz1xbvgXRHePaSNFD5ety9dh5tj7k=;
        b=MPL1V8GZP7fwqingLYoLuOJAsPB52MEPHHoqfi3b6jqkfiNq5XU7bKLZ1AFeHgdBHv
         vNGXOby+7kQLCcdcplxgyso3iSVr+yss7qt+xeInl09HbM01N0czhmMgFNm1JUSVWDku
         +jpv8SdVZ0/X0YvnbIzkQvM5S18v8lUiTj1dapO/I+BdEhUXkYf8uU22IWZaexHfI0O5
         gyjERygEpD1Bm2fHh0dUvkuN+RPW5Kg1kyH27YV5gtpehY7817qOMV2cX4JKbVEhJeuD
         CXn3HpGiR9NXMBLrET/OX/bZTkixQKf9REdXWRMebzuuH+Y1F0j4PI2XiCq3TME2J51j
         IdRg==
X-Forwarded-Encrypted: i=1; AJvYcCUp0oqAtmRDZItKZoFs5sfMrkPvNSB2j2kKjqzo/ptojvpdMv6EtW9xWB5EvROVq4tuq9GMJ0AX0FvmvFyknZABanKJZTAr
X-Gm-Message-State: AOJu0YzAsVdPOM8X2kihR+eAGmbSGnCgwKm89X5ry590Z64GAeoWEKlf
	CUqgTrgLTkwsuu+Wz01vDbX8UmNy6VHZwAh3tt4vsdxsrK4k3QUr5jD3KTggwUpKCZL0iY/py3y
	gUqpsgw==
X-Google-Smtp-Source: AGHT+IHVpq5jzDNuclnC7a1iNf1qGeZnJRgw4W8zfuGHaA66en+KhpJjecK6QkwfE6pV2cdJtjrdHA==
X-Received: by 2002:a17:906:2851:b0:a67:907f:e68a with SMTP id a640c23a62f3a-a681a878304mr99864066b.27.1717144065986;
        Fri, 31 May 2024 01:27:45 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-25-143.comnet.bg. [109.160.25.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb342009sm61538766b.189.2024.05.31.01.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 01:27:45 -0700 (PDT)
Message-ID: <10eab0b6-4106-481f-abdb-b97fb162355b@blackwall.org>
Date: Fri, 31 May 2024 11:27:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: Clean up one inconsistent indenting warn
 reported by smatch
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20240531081136.582-1-chenhx.fnst@fujitsu.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240531081136.582-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 11:11, Chen Hanxiao wrote:
> smatch complains:
> net/bridge/br_netlink_tunnel.c:
>    318 br_process_vlan_tunnel_info() warn: inconsistent indenting
> 
> Fix it with proper indenting.
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  net/bridge/br_netlink_tunnel.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index 17abf092f7ca..25ac3a5386ef 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -315,8 +315,9 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
>  
>  			if (curr_change)
>  				*changed = curr_change;
> -			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> -						    curr_change);
> +

Drop the extra new line.

> +			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> +						   curr_change);
>  		}
>  		if (v_start && v_end)
>  			br_vlan_notify(br, p, v_start->vid, v_end->vid,

The patch should be targeted at net-next (subject PATCH net-next).
Also please remove the "reported by smatch" from the subject
we have a Reported-by tag, but I think that information is not
needed here. Just "fix inconsistent indentation" is enough, you've
already mentioned it was found by smatch in the commit msg.

Thanks,
 Nik


