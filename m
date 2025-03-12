Return-Path: <netdev+bounces-174183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F3AA5DCA5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E19A16B31C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F29C1E8325;
	Wed, 12 Mar 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6vUk5Mk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354C1E6DC5
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782596; cv=none; b=i1pAgJvoYjpE8fdPwtUojB1wH2Zgq0rfnbhDGt/1WOELMwyYJ2Vgmy7VjmHj5Afhy9FkmJZA3WElRi+QtXvd+12f/+H0EfaT4h2Sz6s1VNqp2hAJTy0X0fq+QaolIJmcgriLkAZB131cr1/G+k1eWTsbn0WLi3wgBf4+LF/KfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782596; c=relaxed/simple;
	bh=9VVmIGcxidyJs88e/+KkoxUvyXMLvuHyHCKg19YPZkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SF66UavXD+w2gxls94GscHyFSDCfd+T/AhMM/+CkkyMBgSXUbrMFOI5mZVGCDzs6qzijE5CQCLv4BegZgHTv58C9kFHAPY5UoP2GF+1/7Krgzi+IeqWTdxz8j/w4smY5meKNCtDp5blv+aREebz7fSgRLyTuqPgjNRgw/xHJmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6vUk5Mk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741782593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7pk+LbgOlAquJC2Wn9rV0NyBPPZimR6XHaNxWQ/xtc=;
	b=c6vUk5Mk1mZkXBgLCFGVpdx7b3WQnnc+ytzstqJQzxT6fmd2lr0zYipHhs3KZdU3kn44g7
	jVZpVfT55e3SzrfbMoqADfWAxQbzKLHk7uygVn3jlgIT3ipSTClTvi5CQNWcdc1gqnStps
	lIKVFtvH1ByV608RUtNZt4XyGXYa3gE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-3qa-4zdbN3i0A4j9kf6tuA-1; Wed, 12 Mar 2025 08:29:52 -0400
X-MC-Unique: 3qa-4zdbN3i0A4j9kf6tuA-1
X-Mimecast-MFC-AGG-ID: 3qa-4zdbN3i0A4j9kf6tuA_1741782591
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-54995da5b1bso450846e87.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 05:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782591; x=1742387391;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7pk+LbgOlAquJC2Wn9rV0NyBPPZimR6XHaNxWQ/xtc=;
        b=KO6vuAd3o5wb+gySnAcOSeaB/GDZz5QT8xgmp/YEazKe5R3LGXELHoW1FlBh+LJiqH
         LrnsKzkCzLmD0w2Y1DuL+9FZkVJGQwgWdc8UUqhotNTxD0O8ENlHim7s0r0bxUiJAeyv
         W/3qaUmvxvK7KximTxYA5I5SZKDMKmGxxYS634p1TD2sWQlr9eQ5gwcgMcgFzKdqS87x
         etUhdaVqgEIn66IQNPUapPpEue2VlJ4dF9LASUVHKZwAqLUCZCA+gaeuZfaDx+zA1Bm6
         j7/h/vK88IscI72frTwImZcRWSG2j65Kp/Z8mV2GY7o4TDGe8mIrZ6GeU9XPYevKRga1
         CZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4cQCI2UId3y8ufKoebkUxSRmj1wUyO9sw6TQuJWfK9YAQux0hbRPK/iNdMar/mnn2EYgeEUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLg8aEaJy33J5HLjdTA6J+ZkLdRQ3qbWwFdrpt4xOy7jFwUMfs
	y8SsfQ265Oo7mylecVv5z8BDkgJm5gdPiq5b0ff/G1nVJRdzQUXMQdvodaVFDowADi/QP/XR6Th
	a4T7QiloKMAVSt+MtLKDWRkZiOdVTkC8hX6BPyUpQOsi+WFA22I5K2Q==
X-Gm-Gg: ASbGncsBmAaXYIfTKkOFvkHsDLgE2xB9iBlldt/0jHwY2YzBdkTVXGACN77F5Ml+lY2
	2NmImtbfz5/1Vsr76rpslDUzhRa8HQ0rkw6K5/LCT98B/9ez1/bhBVEB+fXqke5xAPI1KiMWBlQ
	txQxjsB8HV56xPyqbq7HPcq6gj2EIViUYIZjUzmfoP4fXtn9x0JtJfUmeW29CIrUDsq046oBYWS
	bSG37POjIT6Xg+BdCp7bCeUYCH63XvP6WxlVxBDHQ3jsu1XMDZyCVsejswT/vn9eoh0zIXPxTZ/
	MozdWRQi9Ksp
X-Received: by 2002:a05:6512:e99:b0:549:5dcf:a5b with SMTP id 2adb3069b0e04-549abd08731mr2644446e87.4.1741782590725;
        Wed, 12 Mar 2025 05:29:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjJrzor8jtnebcwTkuyeyRjFD8cyh7O4lj1779PdhFVKzSD6QGqr8mlsRAu1eMIL6/2mEJnQ==
X-Received: by 2002:a05:6512:e99:b0:549:5dcf:a5b with SMTP id 2adb3069b0e04-549abd08731mr2644431e87.4.1741782590224;
        Wed, 12 Mar 2025 05:29:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c29adsm2098172e87.215.2025.03.12.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:29:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8C8B118FA68C; Wed, 12 Mar 2025 13:29:46 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>, Stefano Salsano
 <stefano.salsano@uniroma2.it>, Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
 Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] net: lwtunnel: fix recursion loops
In-Reply-To: <fb9aec0e-0d95-4ca3-8174-32174551ece3@uliege.be>
References: <20250312103246.16206-1-justin.iurman@uliege.be>
 <fb9aec0e-0d95-4ca3-8174-32174551ece3@uliege.be>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Mar 2025 13:29:46 +0100
Message-ID: <87y0xah1ol.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Iurman <justin.iurman@uliege.be> writes:

>> --- /dev/null
>> +++ b/net/core/lwtunnel.h
>> @@ -0,0 +1,42 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +#ifndef _NET_CORE_LWTUNNEL_H
>> +#define _NET_CORE_LWTUNNEL_H
>> +
>> +#include <linux/netdevice.h>
>> +
>> +#define LWTUNNEL_RECURSION_LIMIT 8
>> +
>> +#ifndef CONFIG_PREEMPT_RT
>> +static inline bool lwtunnel_recursion(void)
>> +{
>> +	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
>> +			LWTUNNEL_RECURSION_LIMIT);
>> +}
>> +
>> +static inline void lwtunnel_recursion_inc(void)
>> +{
>> +	__this_cpu_inc(softnet_data.xmit.recursion);
>> +}
>> +
>> +static inline void lwtunnel_recursion_dec(void)
>> +{
>> +	__this_cpu_dec(softnet_data.xmit.recursion);
>> +}
>> +#else
>> +static inline bool lwtunnel_recursion(void)
>> +{
>> +	return unlikely(current->net_xmit.recursion > LWTUNNEL_RECURSION_LIMIT);
>> +}
>> +
>> +static inline void lwtunnel_recursion_inc(void)
>> +{
>> +	current->net_xmit.recursion++;
>> +}
>> +
>> +static inline void lwtunnel_recursion_dec(void)
>> +{
>> +	current->net_xmit.recursion--;
>> +}
>> +#endif
>> +
>> +#endif /* _NET_CORE_LWTUNNEL_H */
>
> Wondering what folks think about the above idea to reuse fields that 
> dev_xmit_recursion() currently uses. IMO, it seems OK considering the 
> use case and context. If not, I guess we'd need to add a new field to 
> both softnet_data and task_struct.

Why not just reuse the dev_xmit_recursion*() helpers directly?

-Toke


