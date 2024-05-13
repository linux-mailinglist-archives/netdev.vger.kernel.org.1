Return-Path: <netdev+bounces-96188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8E8C49D8
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B791C20BD0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2BA84DF4;
	Mon, 13 May 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iKd+8fwn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119484DEF
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641405; cv=none; b=JD1e9n0mxS2mclNtbOQuSwHK41AwSIs/x5DGk06TXd7KZHeS8d0sgMBO7M6aZjKmy4TWmB/ckeNeq/VgVdWJd5j4mCwEw8hAEDOUUy/RhFPRU10GzWWY0jZcNdbkuaDAS2ZdPkFnfPDuxjUJWnE4AodwrM9R/KoakpbIU8vwFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641405; c=relaxed/simple;
	bh=/9z5Va8BoS10Zw3lv3iW17W4Qhvjzu7IIUUc3s4u6+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXoLLozU08CD7CLSeX+LVzm1XpXudLY3XBmCTnKsL9S0yGDSCVd3Qp09PTx9fzUtfMt5FR2b7SJVELanXdx3XCJunwgDmdfFgZ+Jq1fH6ZmgaJXpzXyWrLBFNLvlvrQDTAIiv4sIvKsYW3tn1ACaei3TMk8uMR4u8vVQTjCxm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iKd+8fwn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f4521ad6c0so4053219b3a.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 16:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715641404; x=1716246204; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eiIURfigbv4jfMYVn+cegJe5X/kgu+BloNveVda8Z54=;
        b=iKd+8fwngYQ1a9VzFZ1uGEVrJHwiOLeTu0PzsbV4jUJ3bNunb/Hrd+Ob/apHhpW9F1
         PpcyDeGKKTuX8Lbk4hb1N8fYWGHFp+1iCvt0CyhdE9tdaQXsjtG0FFvDIhbHWsu/qMpI
         mJx6tYUMvvYeQwFfnDSL/KByxX7SdP9uHyOlVaXU1p2xFGcaTMInakp5Z9YwdclpkCsL
         vp8ZFSDahv/9sI/5ChJXUPBeS2g5a2ttW6IgLxquW0ahKsdBV0wo97d708G81TM5vp0D
         oncFWNnaT9SS/8tJqd018OMRbp+87vuaFtRFBHrDWi4BjiWVAulZ4HPrpxPyJoo1SpE1
         Ay4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641404; x=1716246204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiIURfigbv4jfMYVn+cegJe5X/kgu+BloNveVda8Z54=;
        b=hbjNYbUzaOtViWded4rcCCLxOaHZ6rMQDLEpAnpcr99p1kSdVcvKrsqj8czyv+xBhD
         GATm5fCG+VLoIoB5toFgSyPpry3aHoKKErDiGC3Jy9RQk+zWIUq1S5bbLSxYuMiKvH04
         uBmroH4sWHw8WJWEUXrqNP5H3ZE3hD9cYWBZYl6Jy0KJfOrQ510TAJkgFll43RiUQOyu
         L7dXoEkPX3fefqn526AGcX808mvhTEg1INxz+0hpKbHmMoWeQsErYrgDY+aBgRs/m3uT
         Zhgu2Jdt3xwnJOB56WQNujJoRoS6J4VlHDnfHdanMazEdDL2KISP0vtkgd+Nep7GCU8K
         GyLg==
X-Forwarded-Encrypted: i=1; AJvYcCWYfQIMZNYXYfH03PiynPfle1FrW/SJh31/hPem55x0yCnkrhUyh4zyarunlcR/CxuJuqqIzJgn/B+fcOShorjKWxoQeU/M
X-Gm-Message-State: AOJu0YzY7s/mCFTEpPagrZzas+baIK63ah2Jys0nzxmxrEHfkj0xNwiI
	JdrwcqZWsqV3uarO6IM/pkQLLaaBPvIBT175dLRFzf6zjYuyOTzJBy8Qst0w9L8=
X-Google-Smtp-Source: AGHT+IGZZ05t4FHBsyrm+Iw0NDc4I2GEzxI8XRqc94KzZJOwLZEC+KqvVPk0Pm01zm+C+DAs6jMXHA==
X-Received: by 2002:a05:6a21:6da1:b0:1a9:5e1f:8485 with SMTP id adf61e73a8af0-1afde1180a2mr10908731637.31.1715641403754;
        Mon, 13 May 2024 16:03:23 -0700 (PDT)
Received: from ziepe.ca ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a665c0sm7877475b3a.3.2024.05.13.16.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:03:22 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s6ehW-0001ej-5J;
	Mon, 13 May 2024 20:03:22 -0300
Date: Mon, 13 May 2024 20:03:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
Message-ID: <ZkKcOogJpI0PU2l3@ziepe.ca>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513125346.764076-1-haakon.bugge@oracle.com>

On Mon, May 13, 2024 at 02:53:40PM +0200, Håkon Bugge wrote:
> This series enables RDS and the RDMA stack to be used as a block I/O
> device. This to support a filesystem on top of a raw block device
> which uses RDS and the RDMA stack as the network transport layer.
> 
> Under intense memory pressure, we get memory reclaims. Assume the
> filesystem reclaims memory, goes to the raw block device, which calls
> into RDS, which calls the RDMA stack. Now, if regular GFP_KERNEL
> allocations in RDS or the RDMA stack require reclaims to be fulfilled,
> we end up in a circular dependency.
> 
> We break this circular dependency by:
> 
> 1. Force all allocations in RDS and the relevant RDMA stack to use
>    GFP_NOIO, by means of a parenthetic use of
>    memalloc_noio_{save,restore} on all relevant entry points.

I didn't see an obvious explanation why each of these changes was
necessary. I expected this:
 
> 2. Make sure work-queues inherits current->flags
>    wrt. PF_MEMALLOC_{NOIO,NOFS}, such that work executed on the
>    work-queue inherits the same flag(s).

To broadly capture everything and understood this was the general plan
from the MM side instead of direct annotation?

So, can you explain in each case why it needs an explicit change?

And further, is there any validation of this? There is some lockdep
tracking of reclaim, I feel like it should be more robustly hooked up
in RDMA if we expect this to really work..

Jason

