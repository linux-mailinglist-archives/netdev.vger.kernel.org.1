Return-Path: <netdev+bounces-175208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4464CA645E4
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896401704DE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9060621D5B8;
	Mon, 17 Mar 2025 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xfc2MoOE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080A21CC70
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200817; cv=none; b=DOmHUzRFs/G2WS2Nxrir0egd0mBAVb5giNw8AcjYYo/tZBOB+fml8/qnTUh6420egEsoCCaGy7thom3I8gXoEZod94BPe77t3QdYHa7fGhm5h4qqGCo9seMelmWRf6bODGAu4cJpFhm2cBTvYgAY/fX1Oki7ENfcBfG/UvaMLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200817; c=relaxed/simple;
	bh=u9uTr3xH9JxG3bZCIZpahiftmo6kj8G9gzRQfRJ4hNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5G7HOEv7P0PFNTEX3Tx2GkwstXX+t4mIFvgBySHlRJKvP48a1CZdG4dua2PaLz5aHhpoOKGRkiQGARk0VC47DFbRGMjNBcJtij63SmUYBBsDQUeJ7iKULZt6T08C8nKbphT8UZqMZcvxK8YOU85HKbmCHnHuTPYTCwQB1VFJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xfc2MoOE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742200813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tc3pwwx+CdIZctw9BUeITMxNIjp9Mm5qewrk6IKNcaM=;
	b=Xfc2MoOEnf8tqBV9NFSm9vQfiPsZF/Nj/9P+bRAFx22X6qDn9GISUhb4hDJGVmvHx4+nSh
	/fXthusSfGd7GBwMUGvWe8pOuMFcV44TZk3ZRRw9Obux4aXCtwzzvpP2gQmhEwJUAwd9UU
	Z5HOXO0qKsMtc0CyLSam1fL4I9lFYSg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-GPQZRimGNJOqUSaIhPrg2Q-1; Mon, 17 Mar 2025 04:40:12 -0400
X-MC-Unique: GPQZRimGNJOqUSaIhPrg2Q-1
X-Mimecast-MFC-AGG-ID: GPQZRimGNJOqUSaIhPrg2Q_1742200811
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3914608e90eso2733521f8f.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 01:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742200811; x=1742805611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc3pwwx+CdIZctw9BUeITMxNIjp9Mm5qewrk6IKNcaM=;
        b=ZJycgE0CMLTetr76bpy8oPk+w3ancH38QCjcaNHDoKlvf4g0lb2XDpdkSUeuHx5P1r
         UuFH7QvjJsMfoLALvIIU/QKMdUGiIXocBk9MYo571dt4Uggu46C5rZ7HxXPGHaK3I1vu
         N9tn73jZfa7avpDPv4NnmzbxhJ1Lkp4FD9Aeg0H/23Yc9Axhwnd3MOrqp6uL17sno2a0
         XPjBAU6XPDfjpsKID0sqLjRtrnAir9W7zU4UGfgfUM9nBcsSd1T4icaTCxdUoqaTgO+H
         We4kccAlHzS91RwPKEzWK5C19tNGKpXd/niEB28FECKQ+5pLZ2t9FeKHQsd5AuTjA98K
         oosw==
X-Gm-Message-State: AOJu0YypTHzVxyxh33OK1Z6B5YAEtw1eXyDOr8XAiy5zAKD7Xrms+wqZ
	HU3OZbYbQ4mcgVkRoF1qOjqdXBCisv21X6gymLjXrILpvp+2cfVOS/C3YjVjVYPpBwvn08mx4us
	M9OEGSw3NKkVDfb4HjXB0RuY/zIQCSaLW6lTrxU9APkP79sHp8nVM9Q==
X-Gm-Gg: ASbGncsVxjQcBwlRa/ppm/b/3A46/xuDyOurZnTFVbWbfkPsyswh2cPhBIKLFloD3pc
	2VOTtlINdD0Sw7DWTwvtO7lBaLrQBD8SF8B7aJRRLr29Fzd4i0ooP5qN2ZisITWuf6EjeaUq+lh
	VwG0MxxyqvE8Z0fY0ZcbXzOV3hsEXg36U6EIWfbvZ/IKhjerR/wW1fqhoPpIDYcIuJuRuglb5VZ
	A2i9AnZ1qAedU5uRMBlLonfFxfzt23s31r1Vcm9jbiTfH+8YlVSrG7yqU+kwu8TwEJUEAFmqecX
	qEcRHuPIdJ4a51aDCJm6vOfhL28HVecpRpkf8NeBfZtSoQ==
X-Received: by 2002:a05:6000:381:b0:390:f0f3:138a with SMTP id ffacd0b85a97d-3971e96bdd0mr11725361f8f.27.1742200810781;
        Mon, 17 Mar 2025 01:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz5XZeyaI4VHBrrpnR1eBy1RewBf7ivCOCk9rh8aNunTTj3lrQ2yJiC2xoc3VRQfrNaHlyvA==
X-Received: by 2002:a05:6000:381:b0:390:f0f3:138a with SMTP id ffacd0b85a97d-3971e96bdd0mr11725346f8f.27.1742200810396;
        Mon, 17 Mar 2025 01:40:10 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9ccsm14496691f8f.96.2025.03.17.01.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:40:09 -0700 (PDT)
Message-ID: <df7644e4-bb09-4627-9b73-07aeff6b6cd9@redhat.com>
Date: Mon, 17 Mar 2025 09:40:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] net: introduce per netns packet chains
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <cover.1741957452.git.pabeni@redhat.com>
 <19ab1d1a4e222833c407002ba5e6c64018d92b3e.1741957452.git.pabeni@redhat.com>
 <Z9Su1r_EE51ErT3w@krikkit>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z9Su1r_EE51ErT3w@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 11:33 PM, Sabrina Dubroca wrote:
> 2025-03-14, 14:05:00 +0100, Paolo Abeni wrote:
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 6fa6ed5b57987..00bdd8316cb5e 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -572,11 +572,19 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
>>  
>>  static inline struct list_head *ptype_head(const struct packet_type *pt)
>>  {
>> -	if (pt->type == htons(ETH_P_ALL))
>> -		return pt->dev ? &pt->dev->ptype_all : &net_hotdata.ptype_all;
>> -	else
>> +	if (pt->type == htons(ETH_P_ALL)) {
>> +		if (!pt->af_packet_net && !pt->dev)
>> +			return NULL;
>> +
>>  		return pt->dev ? &pt->dev->ptype_specific :
> 
> s/specific/all/ ?
> (ie ETH_P_ALL with pt->dev should go on &pt->dev->ptype_all like before)
> 
>> -				 &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
>> +				 &pt->af_packet_net->ptype_all;
>> +	}
>> +
>> +	if (pt->dev)
>> +		return &pt->dev->ptype_specific;
>> +
>> +	return pt->af_packet_net ? &pt->af_packet_net->ptype_specific :
>> +				   &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
>>  }
> 
> [...]
>> diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
>> index fa6d3969734a6..8a5d93eb9d77a 100644
>> --- a/net/core/net-procfs.c
>> +++ b/net/core/net-procfs.c
> [...]
>> @@ -232,16 +233,15 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>  				goto found;
>>  			}
>>  		}
>> -
>> -		nxt = net_hotdata.ptype_all.next;
>> -		goto ptype_all;
>> +		nxt = net->ptype_all.next;
>> +		goto net_ptype_all;
>>  	}
>>  
>> -	if (pt->type == htons(ETH_P_ALL)) {
>> -ptype_all:
>> -		if (nxt != &net_hotdata.ptype_all)
>> +	if (pt->af_packet_net) {
>> +net_ptype_all:
>> +		if (nxt != &net->ptype_all)
>>  			goto found;
> 
> This is missing similar code to find items on the new
> net->ptype_specific list.
> 
> I think something like:
> 
>  	if (pt->af_packet_net) {
>  net_ptype_all:
> -		if (nxt != &net->ptype_all)
> +		if (nxt != &net->ptype_all && nxt != &net->ptype_specific)
>  			goto found;
> +		if (nxt == &net->ptype_all) {
> +			/* continue with ->ptype_specific if it's not empty */
> +			nxt = net->ptype_specific.next;
> +			if (nxt != &net->ptype_specific)
> +				goto found;
> +		}
>  
>  		nxt = ptype_base[0].next;
>  	} else
> 
> 
> (and probably something in ptype_get_idx as well)
> 
> 
>> -		hash = 0;
> 
> hash will now be used uninitialized in the loop a bit later in the
> function?

Thanks Sabrina! I'll try to address the above in the next revision.

/P


