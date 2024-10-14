Return-Path: <netdev+bounces-135136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C24FE99C6B3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697D8B24B05
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FA115B0EC;
	Mon, 14 Oct 2024 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwFUZOui"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99582158DD8
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900432; cv=none; b=XfQscemlpCe+xQzR9BcGHjkR9PUWH6uyYq8rm3ru1mdRABrLU2mqFNIIwmraVpZmHnVv4Wy2hTXPnMe7NWRZM3BhdPPq04w2ZxUgWUkAEslXHX42jK67QZV6XqDQ29SPTnWoE3HFU/A+A2aVbnZHU+NSmDN6WWOi+AgbpwYjTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900432; c=relaxed/simple;
	bh=AOYO1nqfzd2p/2L5E1KCttOr9dkTX6WpAatNEmQdtsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyuAj367ycP/GwIRLR/lRB/jiTowklOUFmt8yc2BmvQKm5w3MHuMbIc7twkmo6Fjjw34/DL7CtKQZvpoNeJjo/cxoJQ8WwB9tNiSo7vNeee++Unb5l1900++GR7ePz30tG/MkeYg3Lu6jYLyBoTvMvf0c/iNSjbOdAMvMUxCNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwFUZOui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728900429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Hb1WOmt9pWbQnwO9cKQur9sRAYIE4GJQUsNXDee6uU=;
	b=UwFUZOuiyszrndNqp6cgl/faGhIYl8cUdN0y6oTnVH9W4tTVY5ScCEtB5BDyzxC0efRpyO
	qKlMvLVesyvO4YuMt56b0R5SZQpWuJCifmbYuCnIOHtFFqukYPyfI57lhuIjC8l/3g69ai
	S9PvwLpm7HEEPaZuWTvF/89GU98VIm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-HnFqSHLwOT60RHCScekVEA-1; Mon, 14 Oct 2024 06:07:08 -0400
X-MC-Unique: HnFqSHLwOT60RHCScekVEA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4312acda5f6so10085425e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 03:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900427; x=1729505227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hb1WOmt9pWbQnwO9cKQur9sRAYIE4GJQUsNXDee6uU=;
        b=WUS6imD9ZQ7WsCatnERoc0NiPtzkJ8EoSXwjJET1e8NyDO9+E/19Q1h65voDxH5gyq
         N2ataR7nB+i+fAjP5NNZiwnkVjUzpViWoAXM00TIYStKlskSpz8c6lSPdp90a0e0G3tf
         ykYyR47hfQfxUSJB4VBe66iT7jjMDvDiH6CrVn21QYZI1JKoLxpVCX4Fl2XvK02vY3be
         iHoJsLT+U45gLk4oswHsnpIPmbxJ3LKNjJdzleAtuQ3YqrgBpHhafLvmHNMnHqE1msNg
         93a+Wz9WtMNTJgtmsqiBWt+Txy2VsovbVzo2Sw60+fUxBlVOH14kaUt/hQ739kEO1yqe
         giQA==
X-Forwarded-Encrypted: i=1; AJvYcCXmtrWeffrlsKj2tyLqn4FxNv3aEgoutZXzwctIS8zT3diXcwhQGm24tolIW6wRV+bUkAC4jSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGalS2YunM3pFcg81+JYj3et5aKxqal+lsApMHYTCMQmtHiun
	j8h29gxudaUFJ4hZjwSr1xcRNP7v0xWG1Owj9yz+3O4CjkJXeyvt2NEDQ2tHFdxwAD4RTrY1/CY
	lOPkXciS6enqzcy7JgvVwnu7yMAq1TmQIYjJQt6JrbVpCktOBMNVPgw==
X-Received: by 2002:a05:600c:358d:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4311df4236cmr95037445e9.25.1728900427293;
        Mon, 14 Oct 2024 03:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnwz8f2/PXCxuw1/TLZrYV1OXlFfmOwRpeB2gJl2AKxapYVqep+3JW9vo8ox2OTpXkBBxMhw==
X-Received: by 2002:a05:600c:358d:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4311df4236cmr95037155e9.25.1728900426901;
        Mon, 14 Oct 2024 03:07:06 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43118305ab8sm116309275e9.21.2024.10.14.03.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 03:07:06 -0700 (PDT)
Message-ID: <9d611cbc-3728-463d-ba8a-5732e28b8cf4@redhat.com>
Date: Mon, 14 Oct 2024 12:07:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/3] net/udp: Add 4-tuple hash list basis
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241012012918.70888-1-lulie@linux.alibaba.com>
 <20241012012918.70888-3-lulie@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241012012918.70888-3-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/12/24 03:29, Philo Lu wrote:
> @@ -3480,13 +3486,14 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
>   	if (!udptable)
>   		goto out;
>   
> -	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
> +	slot_size = 2 * sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
>   	udptable->hash = vmalloc_huge(hash_entries * slot_size,
>   				      GFP_KERNEL_ACCOUNT);

I'm sorry for the late feedback.

I think it would be better to make the hash4 infra a no op (no lookup, 
no additional memory used) for CONFIG_BASE_SMALL=y builds.

It would be great if you could please share some benchmark showing the 
raw max receive PPS performances for unconnected sockets, with and 
without this series applied, to ensure this does not cause any real 
regression for such workloads.

Thanks,

Paolo


