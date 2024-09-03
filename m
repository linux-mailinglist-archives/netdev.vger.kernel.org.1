Return-Path: <netdev+bounces-124608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC33196A2CC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88904281FE4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DBE190482;
	Tue,  3 Sep 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGtZKJbl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601618BC1D
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377456; cv=none; b=qCSb9FHbH72189QzjxHhTbsKd1MGf1JwhUWyBif7WF4Aq5xREsRDICxG8+94LYJHTarigpogHpFvFimgcXpWK6DIe+Ms7siyq54GDIZ+xjc2g2X8EXdGU+hWyD3bnpsiFqXzzbRug3qjcBrWomk66ji/naYNetdFZ5hDhTjFls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377456; c=relaxed/simple;
	bh=QKL7T23eOmpx0ncia0gxjxee1jMJITNA8J38BLxSqEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmD5jgn61G+rwjqXGlfJjoASo7a91+kjC9Y18KJEbmu/kNyiCR9LLkIRs2DWmWjgVSdzEPJegG2HGwlyuhPDEqrhv6OBXSu1USwCHRt5uPW6WNcYdeG67au4v4svk2dgw1ZdsXcyP8GxkBjdvyyOn2LOVWVOqxCq55ZcC4xXHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGtZKJbl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725377454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41LwG9J0jEj5MI1kd/57QFYm33Z7yteqSZryg8JUVGs=;
	b=CGtZKJblfUUNGhtt8VCzpbRu1DlHOIagFa5Hh7MgJY2cfZPeAl1hmpqCF5VPHMJQ58RfC2
	MaFGryMZUSRwW1xl5HGgV7D5o5/Jq4A3n25NdFBXJBpHiFN5RkEuiM8iToFcKevoTw72px
	yrmug0DXSj3j8DCSjVwfWHaXzXrOjxI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-tUI0deZfPiedSWwhS4g2Ww-1; Tue, 03 Sep 2024 11:30:53 -0400
X-MC-Unique: tUI0deZfPiedSWwhS4g2Ww-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c90d24e3so2131648f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 08:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725377451; x=1725982251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41LwG9J0jEj5MI1kd/57QFYm33Z7yteqSZryg8JUVGs=;
        b=IqW/VAfvSF1QRGO39qV+zLo2nEkct/JJR1rEAV6blTTMDxI6q+5TOOfrnqA34cw0+g
         oTOkek9IRaIDUxVcopLWpIgjrY4Gf0QVmS/mR5eSqHIgVNobbRfusp+8sYuJOO4WbgEl
         0vftf1sROZB0NnV+wQOKyTCXhHJ7GCRGgJPSJbGuCNBTWISZritPDo2fsGlHvSij+Jhq
         bQGJUh9EjPbIsHVikyACJYfs2lJjiLHln1K1dU3/3hpEVXLGXULRL1TgNRG0FpY/hvEL
         c1DExXWNlfT2AuDrRy9uh31cnATohgA2HNUJEMoemd2FUBOWXWAO6uqqTG81XmP5cbqK
         nokQ==
X-Gm-Message-State: AOJu0Yyn2n9z53EbRy/GEkGod9hESWKJVu7TBsUNZorWCQ23XRZghMZp
	Px4F4w4t0wsDcMUN+zBpSLiYJR9l8NGCM5HlsyC7UpmbULcw9yT1EijvVtrRZeRnwaAO7giqK5V
	rC3PLO1csSylCojTDjc5ybH46bFGU6ZijmA4Tp+nhvEk9V7jBSiCm0ZDRjHL9Eg==
X-Received: by 2002:a05:600c:45c4:b0:425:64c5:5780 with SMTP id 5b1f17b1804b1-42bb01ae2d7mr145960645e9.1.1725377451629;
        Tue, 03 Sep 2024 08:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC4r5hbeS8XxdAzpp3KnhURpRcqoezBApkRp2yNLXXHu4FnjNAfPRKB9JZ96biQS36a26cuw==
X-Received: by 2002:a05:600c:45c4:b0:425:64c5:5780 with SMTP id 5b1f17b1804b1-42bb01ae2d7mr145959925e9.1.1725377450734;
        Tue, 03 Sep 2024 08:30:50 -0700 (PDT)
Received: from debian (2a01cb058d23d600f5dfa0c7b061efd4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f5df:a0c7:b061:efd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb239sm179049045e9.5.2024.09.03.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:30:50 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:30:48 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org
Subject: Re: [PATCH net-next] ipv4: Fix user space build failure due to
 header change
Message-ID: <ZtcrqPPEiX/L+2i6@debian>
References: <20240903133554.2807343-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903133554.2807343-1-idosch@nvidia.com>

On Tue, Sep 03, 2024 at 04:35:54PM +0300, Ido Schimmel wrote:
> RT_TOS() from include/uapi/linux/in_route.h is defined using
> IPTOS_TOS_MASK from include/uapi/linux/ip.h. This is problematic for
> files such as include/net/ip_fib.h that want to use RT_TOS() as without
> including both header files kernel compilation fails:
> 
> In file included from ./include/net/ip_fib.h:25,
>                  from ./include/net/route.h:27,
>                  from ./include/net/lwtunnel.h:9,
>                  from net/core/dst.c:24:
> ./include/net/ip_fib.h: In function ‘fib_dscp_masked_match’:
> ./include/uapi/linux/in_route.h:31:32: error: ‘IPTOS_TOS_MASK’ undeclared (first use in this function)
>    31 | #define RT_TOS(tos)     ((tos)&IPTOS_TOS_MASK)
>       |                                ^~~~~~~~~~~~~~
> ./include/net/ip_fib.h:440:45: note: in expansion of macro ‘RT_TOS’
>   440 |         return dscp == inet_dsfield_to_dscp(RT_TOS(fl4->flowi4_tos));
> 
> Therefore, cited commit changed linux/in_route.h to include linux/ip.h.
> However, as reported by David, this breaks iproute2 compilation due
> overlapping definitions between linux/ip.h and
> /usr/include/netinet/ip.h:
> 
> In file included from ../include/uapi/linux/in_route.h:5,
>                  from iproute.c:19:
> ../include/uapi/linux/ip.h:25:9: warning: "IPTOS_TOS" redefined
>    25 | #define IPTOS_TOS(tos)          ((tos)&IPTOS_TOS_MASK)
>       |         ^~~~~~~~~
> In file included from iproute.c:17:
> /usr/include/netinet/ip.h:222:9: note: this is the location of the previous definition
>   222 | #define IPTOS_TOS(tos)          ((tos) & IPTOS_TOS_MASK)
> 
> Fix by changing include/net/ip_fib.h to include linux/ip.h. Note that
> usage of RT_TOS() should not spread further in the kernel due to recent
> work in this area.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


