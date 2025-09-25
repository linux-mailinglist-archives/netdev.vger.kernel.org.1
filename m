Return-Path: <netdev+bounces-226494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE57BA104B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69A7174114
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B937315D56;
	Thu, 25 Sep 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0FJtEel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D625F988
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824939; cv=none; b=nbMSX2SrcgylInXkAOZqVdSK63wOB5W7dfnR8EN0op0aMsrYN1nLqqK2SYke9KoSHpbtIGNN0LAOgCLekqr+8SctnwHreXaxUfemuwAMQ86qkFTmDzgvML6pOZOSwVtQkLwYMHHlbXUcqyYG+cXnla9TowqCqTouKt1O/Y9B8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824939; c=relaxed/simple;
	bh=1nr6UiL0tyQ+0aJSlnfdUcMVSTpFvmIzYQrq5SrDkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5tbKD0OCGva9pRShinCPKLEaucHolPTFi6NiJRRLslODJDBUW8ad6f4u20ao5qPgJeMm/9OMeF7kRKyfMMaHLf04iip1LT6nO2y6vyOSA5fqCOqq5uBjAYFs/W0oyKuM4fDXy+8Hwsl7i/3L8rUudan+F/aWxReZueX5rYEukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0FJtEel; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77dedf198d4so1707871b3a.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758824937; x=1759429737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYnCr9LBwa+zohnNGGqjbDVQQNg+nC+1DZrTTslb0CI=;
        b=O0FJtEelN9f3ywD94qS7IBOG/bTa+mFdBm6hPWXTBRODyVS+VwKRUf5ZHma/ooTmKP
         Y1DpBqzNzFOesoKDvoaFrqRtOlFs72jhzdxHqfjgysCBsWZETH4Sc12phuBnX/mZV2TF
         3X7KhNK2WGYJjOUjxhDG6T34QvlK22g6YhFCRvhNtm4J+1PV69OfpMP1U5s6wejOvvge
         N6vEhl7Y90N5XQyRFqWQVLlwvH1UmMFjDHE4tLYZBdUEl0mjRCddLOeubZZGlFqFPky1
         dq/mV4OsAKHpNem9b1gU4n27P79sSlNP/n6jjf+X43NUYrjCzmsxoI3ZYsq0Vob1blGe
         zpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824937; x=1759429737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYnCr9LBwa+zohnNGGqjbDVQQNg+nC+1DZrTTslb0CI=;
        b=kzHtZsNZd2SV0QkbKn9su0pLp7AIBImVH8H+wWfVuAT/dJ1epL0/6f4EMXAtsM0Uu4
         sjREQX1BrgP835fhdq+MdilsBd3CpXhN0Ji7+x3HwI86Eexk2vf3Fqh2f8WRVkuCfjz4
         Rq8j0L7zMJgKXmDDLUV1XAMShHJs4n8EadOcy71mJrFW4WBQzUdvayirheP53VN4yva1
         HO2pWlhYMAU+OnQDitoVQK/FcDuIV2HzrJdogRrAVH0vp8jySMswQgAM+SQ60erss3fF
         EhuMTOVpfR4F6QvT74sCq8OZQ29kV42RcjQNIiARrUjWv9H+ECdrHMkJs2uYotnxIVa9
         9DpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu95miGm64WfLiC8MHGG5KVTT8UmW2olTfO5gaOC/pC7ebmEG9jrFlRB/c4LIKX/cFl+Zi8Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLyN4/IXHo+9b1JPs0Ng6/AS8+umVTs9Folu2Su2M0JzDr2cC
	mon7SwMdgdG/iDJ5kb1H7VqLKi+OTelsTgscfluActh9jvb8pejtWRMyvtO3
X-Gm-Gg: ASbGncvqeVJzEKJFaWyVW2p1q1T51/OLbcis9J+FK2ec8UD+RMsuYdBUiVmu/IvltZm
	3QBfOIcojsR3kCYwS/LrJQ0LZE2DXLxsBPYqtJBPw/9CXJhmwNpsfRPzbQ1qaRyPOKn7qdSM5iL
	AgKboWr6Jw24+ZoJiqZhSNeGcZrTxm9g5t8lWIEzjeFRWBsNvF/3IlnRBD/yieejhVRx/23X6bo
	2wWyrpzi+z7iXMhpHivz96GypNMMX+qKeidpUMG2h72QpihXyIGCQHV7rOw2oiXi8WTwS8CDaEv
	E6UnM7k8ibMg95BqZl30YeBwZ/Zl1wEptuYe9zUlJUgFYSaEmyzx+aQ3C/uV86r144GqPCuIOcd
	WiCJpH9mU2I7R034YnnNQ+AGKZWybuzA4gR5P6Rd2iSTJFDRxQoFW/KJnVQKwQ/CAcK6FcFCcPV
	0RzcyCqLLcgTV91TargYRNE+D8lnWJQnGBMl2yPoJuHOo3qTTsyUPWICNxyeCc7HN1Mnnh7Wp+H
	8fN
X-Google-Smtp-Source: AGHT+IGs7opWWff+bb7bUYaQzMzMGxk2nmquY73QNVXgVlvbPnuAJ5ZcfR7pxd/fm1x93mlovokxsw==
X-Received: by 2002:a05:6a20:e212:b0:24d:56d5:3693 with SMTP id adf61e73a8af0-2e7c44124e3mr4671670637.9.1758824937196;
        Thu, 25 Sep 2025 11:28:57 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-78102b23092sm2580058b3a.60.2025.09.25.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:28:56 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:28:56 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH v2 bpf-next 2/3] xsk: remove @first_frag from
 xsk_build_skb()
Message-ID: <aNWJ6KcLpdVNom82@mini-arch>
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
 <20250925160009.2474816-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250925160009.2474816-3-maciej.fijalkowski@intel.com>

On 09/25, Maciej Fijalkowski wrote:
> Instead of using auxiliary boolean that tracks if we are at first frag
> when gathering all elements of skb, same functionality can be achieved
> with checking if skb_shared_info::nr_frags is 0.
> 
> Remove @first_frag but be careful around xsk_build_skb_zerocopy() and
> NULL the skb pointer when it failed so that common error path does not
> incorrectly interpret it during decision whether to call kfree_skb().
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

