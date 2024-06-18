Return-Path: <netdev+bounces-104682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 863A290E026
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E2AB20FC2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E1A11CA9;
	Tue, 18 Jun 2024 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2SA7sEej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100313D625
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 23:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754362; cv=none; b=OGpBCUJ5DKq89NOrnXbFJmyAdo5U7q+9swTGgB3OXS4ALHk8Lhf4IQT8WkSLpt3mxxg8sSSC0fjRWI9c5Uj7etVvH6Du2roShWDYZezkOjN8QcfiKlFpcQkIbJxIlDJU1ayqFe8MFzOtUo1V98xRmC77qNS1UzH1Ht3ysteB/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754362; c=relaxed/simple;
	bh=Vv/pGecdW5mJJRQGX5tyIEpCm2C7+FeMPfTw45KVodI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjmYpvCtR0wqJnqZp5fwb3rwJfPr4IGfPY4puqPWwuVp2T+psjZi8038Fdp7/gC9er0vhBWQGcIj2ksQvV3yG5aIHD/taw+wYXulmZ4muambY/n9WyYDxZ8gM3gjz9RRvWuMHyrunlL1d6k6iFwluZD+PdjluwUwuQBdVgaEKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2SA7sEej; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f70131063cso47818705ad.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 16:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718754360; x=1719359160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45BJoW1IfpKqWawwgwzrTCr6fv/cdo+rvEcgmJzCh7o=;
        b=2SA7sEejehwDRCaTQhuqpXswe4hkWbewwQyQKgLwAwI6OaNLFJQk9DpClSY2ZvaMtn
         G8gvuylQ857U2gchiYRTLnVaD0zhUf3ItaGrcqkw7Ap1+R005SPq9379nwOAC3vxN+XM
         8Fn6BtlLWFvaHEjOBLaPcd4IQznoiyKXpU89HUG+FGnpTv6nan4yZu0dLh4S4jPioRp1
         LZx1D2IbstUlFHKUKbjo2B5zIOgDNpi4w0K5H2IWgloCQXV3QWMSAmWaX6Sy2NDqkZEE
         OllK5nOjPhaCJh0p2XzJ6UqValgXFWmO+SGVYenqA5F/vNRfyLhioz/6hWZkP2cilqxK
         soXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754360; x=1719359160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45BJoW1IfpKqWawwgwzrTCr6fv/cdo+rvEcgmJzCh7o=;
        b=B3OEW9BP5RFVIpqlrCT8GscvGI+x7zz2u2NJTfMoaPCmX/oZULBvRPN2DVqTF82J2d
         SCb1cnj/bCJVZreglFEcQrt7Jj96WerKUIMlrgS3qY/CW57oTjcDD6dUj930eqpxSiUB
         FXTJWL7HXZEf3y+dAop1mJGH5F6ZiZ0AHKQn+wrXlaXmbCj/liXLLPGJvM6zmPnCTCOu
         ZNYSZisbxIL4xDFIY+VK3GHUentJn3DUn4v4aU2BQAbXuiWa1/s2Mg5eiJ8MPAgQazVx
         61nFnlE/ZKoLuLg42jO7L+s/C4S3vwiZJlA6eaIPpKsxXsevq/xPG0ZdTaYv9Af8T5Rz
         sNXA==
X-Forwarded-Encrypted: i=1; AJvYcCWdLDbLeT7up5o8yMO3JlwZjOnhDISMERfXDYEU0K531P1Ms5Ocd+Mo048E+jSwhHEJjepiWPovbmECH3RqTwb5piQ+feiI
X-Gm-Message-State: AOJu0YzE8ECGOpZXM/h2XSrQOPgCbvT4+6NXus589kM5x/HkDrPoW7RY
	Da0SCRPbxh/tA8cFWgf4jH9Zfe8FNVgfchhp8iol1uXJBkF4DggnFJNQqduRfPc=
X-Google-Smtp-Source: AGHT+IFbtpYVGpjI0OViZqfIFNwlKUd3m3g3vCQJvUmMHzyu+RLyA7eD+3YPJRKX0b6MggHAF8LVlQ==
X-Received: by 2002:a17:902:d4cd:b0:1f9:a8ce:338d with SMTP id d9443c01a7336-1f9aa473817mr10673755ad.63.1718754360167;
        Tue, 18 Jun 2024 16:46:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::6:95e4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9986d3130sm18830895ad.80.2024.06.18.16.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:45:59 -0700 (PDT)
Message-ID: <5be9c248-8d63-4199-89ef-4cd9023604d7@davidwei.uk>
Date: Tue, 18 Jun 2024 16:45:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 1/7] net: move ethtool-related netdev state
 into its own struct
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.com,
 edumazet@google.com, pabeni@redhat.com, Edward Cree
 <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, mw@semihalf.com,
 linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
 <03163fb4a362a6f72fc423d6ca7d4e2d62577bcf.1718750587.git.ecree.xilinx@gmail.com>
 <070a3de4-d502-45f9-913f-5392e0ebee45@davidwei.uk>
 <20240618164307.7138ce89@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240618164307.7138ce89@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-18 16:43, Jakub Kicinski wrote:
> On Tue, 18 Jun 2024 16:05:13 -0700 David Wei wrote:
>>> @@ -11065,6 +11065,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>>>  	dev->real_num_rx_queues = rxqs;
>>>  	if (netif_alloc_rx_queues(dev))
>>>  		goto free_all;
>>> +	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);  
>>
>> Why GFP_KERNEL_ACCOUNT instead of just GFP_KERNEL?
> 
> netdevs can be created by a user, think veth getting created in 
> a container. So we need to account the allocated memory towards 
> the memory limit of the current user.

(Y)

> 
>>> +	if (!dev->ethtool)
>>> +		goto free_all;
>>>  
>>>  	strcpy(dev->name, name);
>>>  	dev->name_assign_type = name_assign_type;
>>> @@ -11115,6 +11118,7 @@ void free_netdev(struct net_device *dev)
>>>  		return;
>>>  	}
>>>  
>>> +	kfree(dev->ethtool);  
>>
>> dev->ethtool = NULL?
> 
> defensive programming is sometimes permitted by not encouraged :)

I've been here enough to know this bit!

But, kfree(foo) followed by foo = NULL is a common pattern I see in
kernel code. free_netdev() does it a bit further down. Is this pattern
deprecated, then?

