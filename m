Return-Path: <netdev+bounces-214486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26A2B29DA0
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59C42A3D9C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8853530DEB1;
	Mon, 18 Aug 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyQYtfoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC83074AE;
	Mon, 18 Aug 2025 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508923; cv=none; b=pkbwIeVebR0kAMjkplDmYb7zN8N2DUA4TwH8ufHL0vOQorg8TsSVj+Vz2ffPiYZogpYE1bri1qYNAHVGz+Q3/qXdX3DU1ASiV9XoZYhvY8+Oq+jEWDZLIkjb7+ZvQ8hUAl0Qwo3HG9FLUHfNVFsKxKxzcxJSR4Q9YIZURRl+e7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508923; c=relaxed/simple;
	bh=35ExYHNkSOFl+vIDqv8fU+bcX6NCYN9Sw9qjqiUvNJw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JTo5MJ+iYVwos5KOP7yAuwdOzONg9ZEJuuWdRpT6cUDntViDpV6Ga0LO/dh1yQgTKYjm98YZsU0rEHOL7ZWU6NtibokbFClgGA5UHM0UvqaqH+xV0hk/hT/tC5s7P/oH9W8VR2w2jutdI/dvA9ijpRIAgwzZhXKmVt1DolcuNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyQYtfoY; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-53b09878addso3597821e0c.0;
        Mon, 18 Aug 2025 02:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755508921; x=1756113721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i8EHdDnh/5DdxWcY1M48VGjMphp0rLN8Gdmw8dmd2w=;
        b=JyQYtfoY8Y8LIhE8XGuiIg/fwhfVf3GF/cmN2OWx2rkHIV0ixiCRTNPv37UU1rIUUn
         YfN5NlW59TbrNalpmm930LKBoQ3iKipP4uX4SvK4yGHPtuM+A3gHu4DUr5SY0jLNQqZM
         1Ypuf/Mf14yJHf5orNhqb1jWLK7qur4gPz7J+6fwQ3/qi7nZpsciEqizthyvlU9eHE10
         vrRqqI/HOfimJnW+atWRo3gzR9GVZ6kuQ9K/oDSi1rqgyqNG1s5vAZ1y/AG0EeD1aloY
         mkkWjbjC4rsTtdB3zZkEYK0Ke/6hfDosDVMSidv/gZ43+TFkFTZOde/ilveph245wx0x
         cQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508921; x=1756113721;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4i8EHdDnh/5DdxWcY1M48VGjMphp0rLN8Gdmw8dmd2w=;
        b=GdE19m95hI0WGWLfVBk9DuyYUHpFECegZfoibxCtaxT6D2/K0K4gGT7UDM8TJtLUsw
         xojoXTSeSEhWlZ46BZ8Y/1XOGAyagE4HGSLPeb39zHGToE/D9rcUkXNYsQP3dqBPMtyZ
         PMPffuBLjRCwp0T/drPOSZVIoKGRwRleayS3v82aUzTjCbasp+jHrieLPmpL/JNpcGiU
         NtbNLcuXYdksWi1+GBolwzzceW+mXmqUcaXtgwkeY3CFO6n4bmwUZAI39VWu3MQTE2gj
         PRAqDHDTLXuI39fmDV0PxarE7KH+9SSCUrkOkKN0DuWtzbnFaeF3MdkWDvxJ1DOVMKd8
         VFCA==
X-Forwarded-Encrypted: i=1; AJvYcCUilDfzEsxtx/f344EJoXlCek8fqRWoxxzCM6gkMCqgNgJ0ASHCgB3ZlidwhJguiih3O13omH1v@vger.kernel.org, AJvYcCUw9hNxyBLlyY8C0cJKRazu6TwdwAuGguT1WAo3qEdxjcuHeH5BWweCFhdC4brk8A8MADFhwKdXhgmE+jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyafrQPGvkuM5Mc25o7cVbJxVHX+zUuJV9hMAB/Oo5tthnVOP2/
	df1bFrFaaNhS6ruTjiCFU9y0xvFvCzhfm8oRJWf9kaf2H+tewK1kHxQy
X-Gm-Gg: ASbGncsi6ft3W+SVH0OvR4hjubWeoHwklWiPt1efu6z8mC97ubuJUbLJZjJbcw5ln4U
	eXhoYX5YpARDZKnQsvGn77Z5hC9OI5QgwwV57w9lrdXWnDzwbPokkGb/6l8BwfB9vjkLUi4a/Hk
	kocOFfSaBbIt6seppVEj0/AroU2Dss5DyJdrdX3bCvkJP0tkADSJZQRnuKC+567xOke86pvejyl
	gNDvtlys41+SXevorx0uUg1645juWVwKO9I+KenEhC70sR7pvEolY+AUcjMDTyJzj5xp2w4G1oC
	IkqDW687XU6FXXqETJFrJkkuV8pLOrHliXeeYUoC8zNPVNCTqZ5+s+3UGAg0w9LKYIVffCcsUFi
	Qtr3Vn4xqFvUb7prr+QXc/ywCaPQarFmyKgFwWj9dvYSJfObsOiNd/95xk7DA2anCDKYr/g==
X-Google-Smtp-Source: AGHT+IH8FYwREhyqacv9UB0VgYQu7743NkG4uUNESFFnzPKV4gB3XG5F0ca/b2TSYW5gJp37+nmmXQ==
X-Received: by 2002:a05:6122:e6b:b0:53a:dcb4:79be with SMTP id 71dfb90a1353d-53b19d86818mr4321378e0c.4.1755508920640;
        Mon, 18 Aug 2025 02:22:00 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53b2bf26276sm1884859e0c.32.2025.08.18.02.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:21:59 -0700 (PDT)
Date: Mon, 18 Aug 2025 05:21:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.45acd8edbab1@gmail.com>
In-Reply-To: <20250818071334.240913-1-jackzxcui1989@163.com>
References: <20250818071334.240913-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v3] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> On Sun, 2025-08-17 at 21:28 +0800, Willem wrote:
> 
> > Here we cannot use hrtimer_add_expires for the same reason you gave in
> > the second version of the patch:
> > 
> > > Additionally, I think we cannot avoid using ktime_get, as the retire
> > > timeout for each block is not fixed. When there are a lot of network packets,
> > > a block can retire quickly, and if we do not re-fetch the time, the timeout
> > > duration may be set incorrectly.
> > 
> > Is that right?
> > 
> > Otherwise patch LGTM.
> 
> 
> Dear Willem,
> 
> While reviewing the code, I suddenly realized that previously I used 
> hrtimer_set_expires instead of hrtimer_forward_now to resolve the situation when
> handling the retire timer timeout while run into prb_open_block simultaneously.
> However, since there is now a distinction with the bool start variable in PATCH v4,
> it seems that we no longer need to use hrtimer_set_expires and can directly use
> hrtimer_forward_now instead. Therefore, I plan to make this change immediately and
> resend PATCH v4. Please take a look at it then.

Having a conversation in one thread that is not concluded yet and
already starting another thread makes back and forth communication
a bit difficult.

I'll take a look, but just send a v5 after 24 hrs.

