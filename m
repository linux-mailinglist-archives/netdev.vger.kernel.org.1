Return-Path: <netdev+bounces-135056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C6399C01A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DB91F232F7
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 06:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926E513BC3F;
	Mon, 14 Oct 2024 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q93u0woa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E033C9;
	Mon, 14 Oct 2024 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887753; cv=none; b=oK6PCAiQKc53Lxrff8cWap2K6LhlXaWP7wTxAqOUbA4oEqsYEAZ05+2SWM1qvCrxzJSkNhwsTFo4p6S9U8AgWiJM8xpGu4k8GObPkgnZAhnQ06VCQG2FZmDRGAiZj8wmz2RDw9gc/Nix3nUd6LKCzNs03QqDbpkoBHzmMZaNekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887753; c=relaxed/simple;
	bh=c2dldEwImcCdkCjsmThkQqhn6rCIzzV1kMDKmm4/Sl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTowLvhudWQ9FlL0y9HeYz4wAuVTItU5uKsnkpIl9qKckUqJE6/JN+H6l+KgL7oq35VmXceZTmYGj0Fy8BagtNIr382TRz5OmgE68hOOJBJ6Th/VoiBesBiw1P5Q1dqRUR6nGsamrYbHYY0CfKatUVzYQw/EfDbwv+Q3r0MSphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q93u0woa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ceb8bd22fso4457935ad.3;
        Sun, 13 Oct 2024 23:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728887751; x=1729492551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okTGDMk4YPdgJsXtmkY+DN9uCqBGI3OTCf7BpUSy0YI=;
        b=Q93u0woa3O0VMl3QpvV/vdlD1PcKIkBHPkRQq9RC8vNAEJmikCD3wtUvPgdKeU11ca
         AhQ7uy1p30el2Kr4NUx00HDI19K7b3mQX0sElfYWQIY+NoUDaD6ReBT4d/pznkE0tbLE
         IQYgXNjixhlatKUPmk+tlIjCl5Wt3fohRHNe3de9KQPfDhbaiSYPUXPngt5w3BQphCcE
         1r+Qsabg7cSBEIMHeJaMTedQ/qLS+7StMw2X/+7Lhw8EDItyRgY4GDjRVO70aKpQNDtx
         ASrhv1TN0jY8JncnibzMeUBBg7uD99EFnHf3B7wSkJ98s2hFVBc5NZvogvw8B3OugE0L
         zlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887751; x=1729492551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okTGDMk4YPdgJsXtmkY+DN9uCqBGI3OTCf7BpUSy0YI=;
        b=oQAHp9YrmVrW4BTJ+DQrpooEsuEUU7gCxBCZBeKG0i7xMIg9dfITUjIGKXcniT3jj8
         sRWQosDInsI+TSIVlkOYizBcto/M9mFCU8BgIqYR/UfkDwY2ZI6+kxungkUvx8DnRsHp
         7Bw1WawYy36yuxhFfE3cEXCml0pJUweQSksOFb1hhM/1kPSppYuMoahqHJTH8ccvFMsd
         EJM3DW1rI37+arA5g/EGby86CdehcCR353YAIxLiO+z1Vvw3X72jWdaeShWIVoD0e6d5
         my2nMxD7lkhwaQPLsyAr3HLVrKb48ObqNd3e0ymIi5qOJAUI5pWN5A6icaxArIeIjh8Y
         xIuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU24Ii2Pllkylu8OCknP00Ks/jjvrBmiNlyRtlL5jEKQpAHndJD8cl8unlbiXMs2Sm3B8FG248V@vger.kernel.org, AJvYcCUuoQvI/LM3/he1REX6kjloknHd+s9Gm6iQFFZW0s3eycXQOscwPgDqh2rO/kMJvtsFuh4BCnn56dYzIX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVHPDWzccHbkx3xyGpPvknLrxUTzmslWzBxWUE3bsZWlT0a2S
	g1828BN7nPLE/aKxq75sjiASnlS43qCE2OOXcsA2tRL4ou/ZtYiC
X-Google-Smtp-Source: AGHT+IHOH9g3wnh6yWrjAq3lOUnbhV7oz+QGKL/F/3PFnu7guCAt3IHSrMwCMyWwobvMd1ji/EWhLw==
X-Received: by 2002:a17:902:ecc9:b0:20b:61ec:7d3c with SMTP id d9443c01a7336-20cbb254364mr131026075ad.49.1728887751250;
        Sun, 13 Oct 2024 23:35:51 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33cd05sm59522105ad.245.2024.10.13.23.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 23:35:50 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:35:42 +0800
From: Furong Xu <0x1207@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <xfr@outlook.com>
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
Message-ID: <20241014143542.000028dc@gmail.com>
In-Reply-To: <d920e23b-643d-4d35-9b1a-8b4bfa5b545f@huawei.com>
References: <20241010114019.1734573-1-0x1207@gmail.com>
	<601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
	<20241011101455.00006b35@gmail.com>
	<CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
	<20241011143158.00002eca@gmail.com>
	<21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
	<CAC_iWjLE+R8sGYx74dZqc+XegLxvd4GGG2rQP4yY_p0DVuK-pQ@mail.gmail.com>
	<d920e23b-643d-4d35-9b1a-8b4bfa5b545f@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Yunsheng,

On Sat, 12 Oct 2024 14:14:41 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:

> I would prefer to add a new api to do that, as it makes the semantic
> more obvious and may enable removing some checking in the future.
> 
> And we may need to disable this 'feature' for frag relate API for now,
> as currently there may be multi callings to page_pool_put_netmem() for
> the same page, and dma_sync is only done for the last one, which means
> it might cause some problem for those usecases when using frag API.

I am not an expert on page_pool.
So would you mind sending a new patch to add a non-dma-sync version of
page_pool_put_page() and CC it to me?
I am so glad to test it on my device ;)
Thanks.

