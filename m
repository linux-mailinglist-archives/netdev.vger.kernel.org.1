Return-Path: <netdev+bounces-123642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88F965FAC
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C421F21C88
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9B18E742;
	Fri, 30 Aug 2024 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1JvMv/G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108C165F05
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015314; cv=none; b=aVmyUvjT3lng/0OfW4i3WWJE/rJmGRfey5jUE4plgfkDbT939YUb5k3LsLszAnH23SgWM3suusUV7e1Yo5bBotd+/2Lbf7NzPj75lIGRBWcM/rUGn1fAL3j+PmfVsocSstIONkyG54gM1oqoeFRzhM8ho7ha7UqhcNbixcBBIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015314; c=relaxed/simple;
	bh=eLnZqicmtCQKlRZ8xAIGLhNAqAVt+BgBaCShmxd7hDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llybiHuKXuFkmOjqHRHb+2chn3hk+jJShbr1lJ34jIO+/TWzBNFzg3yWxKF/N2jkaoruPLtWC7H/998l8EuW7Mh7MWoYT7U0Vi7pMml8GhLW/79rpHFKLn0cXBcsYY1ope7vRs1UCAf7qzrqCxECvFWmkjvkiKtta/RqeJl31NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1JvMv/G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725015310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtZsySWr0Uts/1vJErtWiomtH6ZwuZ1nWNATGG6eHx4=;
	b=e1JvMv/Gz5NNl90AZ08zHdSQs6fvoCbKURwwUdab0ve9BCaPKRTM4sev5fJ4O3MsWVhsQ2
	2kkmVI+dt8wNn0EGOqwFQ4MAzsk3XSBrPsCSmKcm34xBeKI4OQJAZNKikMefsEUHMehgw/
	M7NhtDg0q7N65vAsc8EfZzNMr9q8hnU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-j50Gll3JNc6gDwInlJ70NA-1; Fri, 30 Aug 2024 06:55:09 -0400
X-MC-Unique: j50Gll3JNc6gDwInlJ70NA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428e0d30911so15781655e9.2
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 03:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725015308; x=1725620108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtZsySWr0Uts/1vJErtWiomtH6ZwuZ1nWNATGG6eHx4=;
        b=S1LzBbkG8PfpO3XHSdAQ8pzrjqlVunb4OFSie5zTMZ//eDGwaPr/7/s+z/iPD7jDWS
         q+IylN2ezj3Vgrr4wi5NpAunwaYyI7wrCvwZaLYWMgxJyo0CgB375NdAkvuA0CWqaOhe
         EfYR9hlpqKiEXiDyoaFA86B/sQTya3QXagCpTIy19ni9GqbfBRLlQW2Fu6BaWrNkWrI9
         sJGIug+wJzVjaxcCKa7AojkO2PpznAFI4/Xz1u1CxpfTJcwUQH9NZ56ECqodxVzSt6eH
         556SudVohZhkKz0Mzf0Bo2BFJ8p8iGqOGOnKF59xQNCgBoU9yRRjVxQ5mpAenFRVS156
         9Ekg==
X-Gm-Message-State: AOJu0Yw1apGQIEN7rT97ze3dZJkTRiEx/BEkpgL+5ZVQfi+u2Dfz9shW
	0y/MGdLBEiLGHOzWiVdiInx75mR6cQiiETSrCLT40/K7OhQAOGj7imRX+rOZGkOUqbuZSrQxP5o
	IA2qVHaaD8i/2NL5mBvT6KBvocJJIWfAJvYR/Dv+HvhrJkDLTKAdQkw==
X-Received: by 2002:a05:600c:3109:b0:42b:ac55:b327 with SMTP id 5b1f17b1804b1-42bb0294255mr47363195e9.12.1725015308443;
        Fri, 30 Aug 2024 03:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1jgU2jMHGVYGRQqKFicsetGdz8wMGNd0ADUz/bZL/M5eztgwj41fTE+Z6tKeSrD/xmXLXPQ==
X-Received: by 2002:a05:600c:3109:b0:42b:ac55:b327 with SMTP id 5b1f17b1804b1-42bb0294255mr47362945e9.12.1725015307862;
        Fri, 30 Aug 2024 03:55:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b53:e610:b3b7:eca4:eb3c:3f1a? ([2a0d:3344:1b53:e610:b3b7:eca4:eb3c:3f1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba7f9f3esm14381635e9.0.2024.08.30.03.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 03:55:07 -0700 (PDT)
Message-ID: <57ef8eb8-9534-4061-ba6c-4dadaf790c45@redhat.com>
Date: Fri, 30 Aug 2024 12:55:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter
 <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com
References: <cover.1724944116.git.pabeni@redhat.com>
 <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
 <20240829182019.105962f6@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240829182019.105962f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 03:20, Jakub Kicinski wrote:>> +/* Initialize the context 
fetching the relevant device and
>> + * acquiring a reference to it.
>> + */
>> +static int net_shaper_ctx_init(const struct genl_info *info, int type,
>> +			       struct net_shaper_nl_ctx *ctx)
>> +{
>> +	struct net *ns = genl_info_net(info);
>> +	struct net_device *dev;
>> +	int ifindex;
>> +
>> +	memset(ctx, 0, sizeof(*ctx));
>> +	if (GENL_REQ_ATTR_CHECK(info, type))
>> +		return -EINVAL;
>> +
>> +	ifindex = nla_get_u32(info->attrs[type]);
> 
> Let's limit the 'binding' thing to just driver call sites, we can
> redo the rest easily later. This line and next pretends to take
> "arbitrary" type but clearly wants a ifindex/netdev, right?

There is a misunderstanding. This helper will be used in a following 
patch (7/12) with a different 'type' argument: 
NET_SHAPER_A_BINDING_IFINDEX. I've put a note in the commit message, but 
was unintentionally dropped in one of the recent refactors. I'll add 
that note back.

I hope you are ok with the struct net_shaper_binding * argument to most 
helpers? does not add complexity, will help to support devlink objects 
and swapping back and forth from/to struct net_device* can't be automated.

[...]
> Maybe send a patch like this, to avoid having to allocate this space,
> and special casing dump vs doit:
> 
> diff --git a/include/net/genetlink.h b/include/net/genetlink.h
> index 9ab49bfeae78..7658f0885178 100644
> --- a/include/net/genetlink.h
> +++ b/include/net/genetlink.h
> @@ -124,7 +124,8 @@ struct genl_family {
>    * @genlhdr: generic netlink message header
>    * @attrs: netlink attributes
>    * @_net: network namespace
> - * @user_ptr: user pointers
> + * @ctx: storage space for the use by the family
> + * @user_ptr: user pointers (deprecated, use ctx instead)
>    * @extack: extended ACK report struct
>    */
>   struct genl_info {
> @@ -135,7 +136,10 @@ struct genl_info {
>   	struct genlmsghdr *	genlhdr;
>   	struct nlattr **	attrs;
>   	possible_net_t		_net;
> -	void *			user_ptr[2];
> +	union {
> +		u8		ctx[48];
> +		void *		user_ptr[2];
> +	};
>   	struct netlink_ext_ack *extack;
>   };

Makes sense. Plus likely:

#define NETLINK_CTX_SIZE 48

and use such define above and in linux/netlink.h

Thanks,

Paolo


