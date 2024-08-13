Return-Path: <netdev+bounces-118101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB816950817
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DAF28287C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFC19E7F0;
	Tue, 13 Aug 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfaEzYDU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41D1D68F
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560463; cv=none; b=PncyXHHE+pugaFq28R8oIrVu/VkL6U9SufAoXiZKiWHtnEPAKF/KiClwXe7cyWqEH4osSnOPG4bVhGhF9mTSPQcwFpz9RZX0QhnY5Flaoj9g4tfQdYBGfSZwqwclwU8AVr6oku0YpLF8S5zeOoQDb5erwYfzFwzIw7xLIKJi3rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560463; c=relaxed/simple;
	bh=vNoQyQ69jOTeUwCRe5gs83H66nHDO/iZ9XXvIpU6Hr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsRpUPyfv8bVf5t+ujQy9W788VkZqnOYhTQLgGMEJ2wL4FyGSA0Lq5AVj1yTRjPbPS6T8/LVHMX4SeKNq5JYhxW5kHF9VljHZMLCtw2wacZJQylqnpXdDo9KbgmaaNDjuFixn0afFWeq53/yXSAKfMX+MNwhr3CxnMm5bsJhn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfaEzYDU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723560460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7AiXXlldbl+lcXs1/TWWNJQEUfoGjk1oc3byyTn5sdU=;
	b=RfaEzYDUTVfqoaqUCLNp1Ot3WTSS7/kagD3uiqoJrO+j6bfTHfMix/bZkk7tukwLb6VgPG
	VVpwZ/NvWxarGVsKMgyoKAwuTkLdvMRNoe9ZvyumB0F6wuoNh5Du9PBH9nEmaJOSjEQtPy
	nOCMa/ap3uB2NHjOqYSd+r3K1aPA0/Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-QqAJPHOtP2ya8kuPYUjcww-1; Tue, 13 Aug 2024 10:47:38 -0400
X-MC-Unique: QqAJPHOtP2ya8kuPYUjcww-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428fb085cc3so10405015e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 07:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560457; x=1724165257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AiXXlldbl+lcXs1/TWWNJQEUfoGjk1oc3byyTn5sdU=;
        b=b9zREjzoLesQBdzaRoKk1ah96TR3EYQUrofg4XQdNIvj/k0LpcRfZrRz4f3GrppZw0
         hnzaAM/KZWo3vAz9aPDPNivfj6pWmq//KhSm2guRVxL1+Yu+pIGo8oT9mXSiGv/sX40h
         q5buSnHqHDq7gnnuXBjolPjqHSEkcq7Dgy+zjx5nG6uT9TGDwnHGhUq7Mrd7zfkSMVdv
         R8/1diBf/4G8keU3GIBe3Q8ZPsZjwADlISdXzmtGP/k7clUuu3u0U5Lf9+xtRm6GFHyt
         sgNqP6IBSC+DXuY15jnuc33U4I7Ckn+6ASsUZN/bphG8aCuMEhsSLlnhKkar41wkldDN
         iFWA==
X-Forwarded-Encrypted: i=1; AJvYcCWDah1+6rEp9Mz82c/BA9Vp1S2ExmBvro+WLk7azEPIp4b/5B4Y/T9cRKxg6laFgGT3jIq/Ko+IOSYFZAHBg0kUk3Y6KYQI
X-Gm-Message-State: AOJu0YwPpy7/pidM6w27DuVcnA7tSEICdSAflMFiLVtLCBXBRvAZ3Sx6
	yWMKT2gm9goRIAaLpkVMHELHA7Z4gXtTZZE2KaC0kghf7fPAX9ShSjbqeTc8kZST+PBMfajtvdy
	lpO0Krdzr4PUDtJyHOZUP8DRvYKKlLTRlEsmU9AJXGQ/SN1Cns/jvUQ==
X-Received: by 2002:a5d:6c68:0:b0:362:1322:affc with SMTP id ffacd0b85a97d-3716fc5c018mr1251922f8f.5.1723560457440;
        Tue, 13 Aug 2024 07:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHItdWOMY4Ai5tafZIYyeVS/bBCeBkPEeWYC3qb6TH5L0cY8Jy/n37i/ioKtUsCtj10WNojBg==
X-Received: by 2002:a5d:6c68:0:b0:362:1322:affc with SMTP id ffacd0b85a97d-3716fc5c018mr1251913f8f.5.1723560456951;
        Tue, 13 Aug 2024 07:47:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110::f71? ([2a0d:3344:1708:9110::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36ba72sm10599790f8f.16.2024.08.13.07.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 07:47:36 -0700 (PDT)
Message-ID: <eb027f6b-83aa-4524-8956-266808a1f919@redhat.com>
Date: Tue, 13 Aug 2024 16:47:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <ZquJWp8GxSCmuipW@nanopsycho.orion>
 <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
 <Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
 <74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
 <ZrHLj0e4_FaNjzPL@nanopsycho.orion>
 <f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
 <20240812082544.277b594d@kernel.org> <Zro9PhW7SmveJ2mv@nanopsycho.orion>
 <20240812104221.22bc0cca@kernel.org> <ZrrxZnsTRw2WPEsU@nanopsycho.orion>
 <20240813071214.5724e81b@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240813071214.5724e81b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 16:12, Jakub Kicinski wrote:
> To me using input / output is more intuitive, as it matches direction
> of traffic flow. I'm fine with root / leaf tho, as I said.

Can we converge on root / leaf ?

>>>> subtree_set() ?
>>>
>>> The operation is grouping inputs and creating a scheduler node.
>>
>> Creating a node inside a tree, isn't it? Therefore subtree.
> 
> All nodes are inside the tree.
> 
>> But it could be unified to node_set() as Paolo suggested. That would
>> work for any node, including leaf, tree, non-existent internal node.
> 
> A "set" operation which creates a node.

Here the outcome is unclear to me. My understanding is that group() does 
not fit Jiri nor Donald and and node_set() or subtree_set() do not fit 
Jakub.

Did I misread something? As a trade-off, what about, group_set()?

Thanks,

Paolo


