Return-Path: <netdev+bounces-66247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453A83E206
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30BB285040
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5B02231C;
	Fri, 26 Jan 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="U+aJQH8+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3479219FF
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295352; cv=none; b=f4lfkif4rfUy7L9D7RU82oD62gOV5LgqnSr60jkXCfZpVqM3Ezap4lV270rrv0jUpv7llfRoiLtvW/eVqRxu5crG4tN/M5Fe5TEoHemKDOaouMGpgcc5pENiHfZpsbpz1IyLuS7YdFXwL4GGgCXoNAD+0rRRYUVxYAIQdtiBznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295352; c=relaxed/simple;
	bh=aU/V+h43gomF4mab08iOz6ZW0uoEImEOmYFUksMubMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhl14emRNVIP/XEjdKzDygZuGvIyk2OtCRlf2kBSmbw33e2+nlLzSCN55OLNBKIffUSXIm40nAVITWqtjvYvSIt/mq1xso6DrcyiObpKoSvqWw7Tq9RPBzbn4PN3RlrSSTHmYLQm2mS4Zko339O+H2ZkjrgWbDTihg9SghbUqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=U+aJQH8+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d75c97ea6aso5223965ad.1
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 10:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706295350; x=1706900150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyCZsPWtLiSG9YVDpzWzE6cYrxVCb3rjGkoT63S7DTY=;
        b=U+aJQH8+/dFzR0O23rpWjQOIMgKbzIeqvRSHc3Mrjtu14D7SFIfFCgQBtKilLFWsTV
         l6v0S1EZFNUWwaTuRF1I4G3VseZuyvc1oet1ym1HTztOKGQKzmffVbIaxGxR/UVgcFDC
         a2Gq/NTttECNNYCQA3w0VfMRvrVnaiw4CHVhyJe8eSPz9uSUaHPU1c5vOhiCxSVioEcu
         vILoCZ3RCRK8mUzmgxDwycDfaJWJG31iBKP1Bm+6QcIST/bfvePHalb0x1fchaAfVQie
         dO8HNe5yEOoFE7DHs4NlvhynUx6gKq2Rk9kwMEcQGYLynlgclzw3vP5YSxB48Tl9FoAM
         jXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706295350; x=1706900150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyCZsPWtLiSG9YVDpzWzE6cYrxVCb3rjGkoT63S7DTY=;
        b=hbeys4KXm1/NpFZYGZV1O05hQsnez6BIOO4rDiW+M74ty8H71F9u8GpCLqi8xgsUSt
         xzYlXIbajMh8ZCucnj+YA+88Rcs4logkGB2OUSwwAO0V1sRCEPraL9X/3GgOlrqv1fsa
         Lob+IRVbYBgrq0L0Xt8pKAxbTFK8fsu2ZKSgqcu67SNonLBjE+WmgCuACpDdaGvlWuRi
         blbxCU3eGy8q9wZ65MagJdwd1KtYmL5I5VsmQXLxr3S9g+9ijMzk5xjGpbzEv2Zn0YDT
         aKNNmpxZwSEJ8c/NMqRPpGfBTsCRnW/rv7ZroRH8HPVQWs0LcyNK36IL8FD4YbjJFe3M
         Sxnw==
X-Gm-Message-State: AOJu0YwxYIv0gOgxztDOQL2fwu1HsqNE1LsUD3K79LKgc02tq7UUeiH/
	HbAnNotm2FGCw4oTes3SVpc09SkNTReU/C63iSW+4ZA3dZONifbtgd+MVqEPjl0=
X-Google-Smtp-Source: AGHT+IG/dsGIeHZgc5SqjF3kiC1Aaj5XJ2xhZN7L3d0xyPP+rIWRoV4vk20ZLqwQyZxdr191VWX6pA==
X-Received: by 2002:a17:902:fe18:b0:1d7:658:9af8 with SMTP id g24-20020a170902fe1800b001d706589af8mr266907plj.56.1706295349885;
        Fri, 26 Jan 2024 10:55:49 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::5:c749])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902b60800b001d720a7a616sm1241677pls.165.2024.01.26.10.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:55:49 -0800 (PST)
Message-ID: <0e71321a-127e-474c-b494-9fdece2faef5@davidwei.uk>
Date: Fri, 26 Jan 2024 10:55:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/4] netdevsim: forward skbs from one
 connected port to another
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240126012357.535494-1-dw@davidwei.uk>
 <20240126012357.535494-3-dw@davidwei.uk> <20240125182632.47652d20@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240125182632.47652d20@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-25 18:26, Jakub Kicinski wrote:
> On Thu, 25 Jan 2024 17:23:55 -0800 David Wei wrote:
>>  	struct netdevsim *ns = netdev_priv(dev);
>> +	struct netdevsim *peer_ns;
>> +	unsigned int len = skb->len;
>> +	int ret = NETDEV_TX_OK;
> 
> nit: order variables longest to shortest

Thanks, I'll be more mindful about this.

> 
>>  	if (!nsim_ipsec_tx(ns, skb))
>>  		goto out;
>>  
>> +	rcu_read_lock();
>> +	peer_ns = rcu_dereference(ns->peer);
>> +	if (!peer_ns)
>> +		goto out_stats;
>> +
>> +	skb_tx_timestamp(skb);
>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>> +		ret = NET_XMIT_DROP;
>> +
>> +out_stats:
>> +	rcu_read_unlock();
>>  	u64_stats_update_begin(&ns->syncp);
>>  	ns->tx_packets++;
>> -	ns->tx_bytes += skb->len;
>> +	ns->tx_bytes += len;
>> +	if (ret == NET_XMIT_DROP)
>> +		ns->tx_dropped++;
> 
> drops should not be counted as Tx

Will address.

> 
>>  	u64_stats_update_end(&ns->syncp);
>> +	return ret;

