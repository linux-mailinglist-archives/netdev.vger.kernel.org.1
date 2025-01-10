Return-Path: <netdev+bounces-157238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD357A09914
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E2F3AAEFD
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E52139A6;
	Fri, 10 Jan 2025 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xK+Tp0qW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A82066E0
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532596; cv=none; b=PQoM/0NuHXQtAKAtIkjjAgGpB66c0JB10/WyV3CYNQuUYR7ZUtG9b93Fp0AAo+vdyx7OiA+x427CoN+wnFKbtMgcRpQlOhdmFcJjPum9W0J5vshQiQUvqVWWxHpo03h7yuKjmVaBu6Ov1E95iqjvdiw8+AJT+rX55d0McuzbsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532596; c=relaxed/simple;
	bh=7M67fgjgWwDPjHUmnUFC/paxK3Sga3PuNqI5ozeLSec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLzbi8T1MjGt8Td+jl3JIKtj8nQx5vkAgIIcbzSVRN4/Gri+oM4VxEEKoUVuLTlRyOFQBiyBsxP9/BUhhVW2HDA+adPNQPj3FEFgcEs/dDIYfaYcyMFa5nCk+NZtEZzsBDQqGiOytsjbTZq6+kouA050fdfHaYUQozExpBEWSvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xK+Tp0qW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21a1e6fd923so52595245ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736532594; x=1737137394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRbzH2nOwlMMhoBmCntBFb+NnLm0JyXLj2bjQzVua/4=;
        b=xK+Tp0qWcW8LeF7GWR7UM+gbdmQBK3BJWsqj4ZMxbIjYxeruE8M7MZsKan9kJmNW56
         xmqXyqtmXHJLxqevTSmeCk1cZSDE9cQBUERjptDmX2FMPq1/1AyANR8n6kqBpDNt/3FS
         lEdyPDiIoj1/5nRb3dgFeyt5HbFrqFC9BNsS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736532594; x=1737137394;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRbzH2nOwlMMhoBmCntBFb+NnLm0JyXLj2bjQzVua/4=;
        b=uVjyfuwQ8s/wR/B9IDjxlUWJldG3MJutzeow2FT9R0GpguUZFfGQCQ3mKMk5DQ07V3
         ATTcQvlZ2nrY7wf3IHBZR6eOfXQic5VBRUH3t+MSVUDtiwrh1Mkmnys7zA4st+9+7ofy
         RLvrTjf+WEOqdwAX9RDfaonQTMUeNp/gEEwsGq7gus3Xm5yLQcHilfjcRTIEel1R3szg
         Uk0/nwaZ81wj1cPGg6KJctHVzUl3Wu5APU3aouOPVlRBFHqevuYfhgXtepIeiPjmQxSe
         L/gy/SCF4dzC4xnWt3d5mvnXgt3jCb4rxEOiHk8WcPkCoHVJi4XAMBSKFTgsvmF4CBi5
         y7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9BeFlPqjp1dJXURZs5mGKni7XDwiiPid0Nc04uzBuSGzrJu1xbS3t24EdrZ1R+Z4f54i2PCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKiM893YCacfa2rhtWn2+qVM9pxgw2LW3y5s0a8gX0CJKojzR
	OLgt7W77xWyMoP/oJhg+4qNUErlO7XRi6robMo8F+ug/RVix16mHgI8NFSCBs7k=
X-Gm-Gg: ASbGncveHnyHCEt614cSHy5quakXGbouctcPGhBLBsKzRfLMF/mJ024s5w8YvgQHHXI
	KREmT6o8JCoAgKtGv+wEBVByghwblwGvJWeWW6NDxZ7ccq9DuF+7/u8HvKSYiMewSx/mzMuFGWG
	yaRLV41W2oRUcZRTccRa2Q7Ar903iyeyGKUGE6X6ZhGcpPF3zMf/1ag9ifFqPEiAI8I+3f8H65G
	tUCA+m8VzrkIacwBSwzilu8fXiiP+8dZ5EaqaE1RKmyqEtvWb+/iZlA255qAXn2Uoywa+6aSifw
	yi+yYTQntgZTrxInsU0IWbc=
X-Google-Smtp-Source: AGHT+IHguAxw5Aowf8G3tbIVFAQ+Et5r+A2AAoKfpmD2NyjcT6wy7942P0rnnFSmj1MMhBsJ6DrIDQ==
X-Received: by 2002:a17:902:d2d2:b0:216:3dc0:c8ab with SMTP id d9443c01a7336-21a83f3ee9emr171089505ad.9.1736532593943;
        Fri, 10 Jan 2025 10:09:53 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df57sm16360245ad.12.2025.01.10.10.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 10:09:53 -0800 (PST)
Date: Fri, 10 Jan 2025 10:09:51 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next] net: hide the definition of dev_get_by_napi_id()
Message-ID: <Z4Fib_xa93pxmhMG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250110004924.3212260-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110004924.3212260-1-kuba@kernel.org>

On Thu, Jan 09, 2025 at 04:49:24PM -0800, Jakub Kicinski wrote:
> There are no module callers of dev_get_by_napi_id(),
> and commit d1cacd747768 ("netdev: prevent accessing NAPI instances
> from another namespace") proves that getting NAPI by id
> needs to be done with care. So hide dev_get_by_napi_id().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jdamato@fastly.com
> ---
>  include/linux/netdevice.h | 1 -
>  net/core/dev.c            | 2 --
>  net/core/dev.h            | 1 +
>  net/socket.c              | 2 ++
>  4 files changed, 3 insertions(+), 3 deletions(-)

Thanks.

Reviewed-by: Joe Damato <jdamato@fastly.com>

