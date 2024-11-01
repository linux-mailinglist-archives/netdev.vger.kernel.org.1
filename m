Return-Path: <netdev+bounces-141006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A056C9B90C7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B931F22BCC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3D919925B;
	Fri,  1 Nov 2024 11:56:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8719C551;
	Fri,  1 Nov 2024 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462183; cv=none; b=NSFRv4W03y6t6QRO8FOXnaDOZWtf8u6gHa+C3qqBtGcJRaB5fbfszmIFblVQ2Z102yil3DA+rY29Uo0DEo4UEhfWpJrEtHaUjxuF7wW2oQxuq5xVlb/jaUqWz+G84cNeD9AfUZuNjw3BW0z8h01VWRIope9NXaYHuNNiHHt3rKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462183; c=relaxed/simple;
	bh=s3mRhUBLzG6II+f2MFjYnoKEBlX/GUiolu8MCtHvOV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSqvCvWO3JToxXUT0su7At3u2X9UwR13yIWxBBGJd5BoDJGDeO8p9dPronRBIzi9nFTYMXat+Fu8HmV3/3tWex81Hp+N/z5FH1M0NvnCu00Gfj3QrKGtE57PwAylRbAoPbRKWe1cuPoKInzOe1j8gO1y2IbvNXsvMu+uvghYGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso266939766b.1;
        Fri, 01 Nov 2024 04:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462178; x=1731066978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcVlNuXyLXQ6dJnnJUO7Zf0OqMY1vXQ2neUbYLXDYD0=;
        b=pFqQzft5j195A3klZ44+Mqi0tYMIj0sa9TPj4mMphecDJQKMVe2qok9LTmu/ci9+cD
         zLIHFgjblnh7SMlN93WlaQb3KNOcknBT597jueZCUagkjqKvsxRTWZ/9v8lSheZ7OVhP
         7c/+LG9i7U/Tu5j+GSBceQVErCxzOhLkALdG/Am6Bxfx2qG/VOSTtF+FRXVmNcdJGCxV
         4MJ5/RsoU/x2DahVb7CKrZaotBl6Y2+fXySDIF2C+fFIorb1qIkFL0yAVzB/vv3a3sTa
         KFx0kcCgNTp0XCSw7rStjs1HrzgIvv16blgo728mYYxYfTeNHfa7aZ9H2SXhNav+sVtQ
         oszA==
X-Forwarded-Encrypted: i=1; AJvYcCVCeczeWn81R+bykGS7p2wsUvtAfym1zvBAHGTKtCnD/P4+ZXdL20kM5NG6fl9tUZ5vZMyb0Xg+@vger.kernel.org, AJvYcCXo+Njl2PSTb2sE/iwVutzwUHuO8mAEJGHcrYTLr1+6t6VlpkzTJJf5LOuUC3JetvnpjunBwVPS79sgWb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzW85LRymmAfA/8ZUi3xocPIWJOKIrLj9Izj+PVfbVjoQYjJdv
	xtr/WgUQCdnn3P7aQvvN1cflvt66J3vNJxRtV6qSoDPTlu5DhQtL
X-Google-Smtp-Source: AGHT+IE0xu850NYn+eqYgJ8toILmL/29YaflkYpCEyhytDa4TERgTK+W7EyOikivBCaHskawYPHdag==
X-Received: by 2002:a17:907:948c:b0:a9a:17b9:77a4 with SMTP id a640c23a62f3a-a9de5ed3c96mr2288981966b.20.1730462177806;
        Fri, 01 Nov 2024 04:56:17 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5649441asm172587966b.7.2024.11.01.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:56:17 -0700 (PDT)
Date: Fri, 1 Nov 2024 04:56:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com,
	jiri@resnulli.us, jv@jvosburgh.net, andy@greyhouse.net,
	aehkn@xenhub.one, Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 2/3] net: netpoll: Individualize the skb pool
Message-ID: <20241101-calculating-paper-potoo-beb116@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
 <20241025142025.3558051-3-leitao@debian.org>
 <20241031182857.68d41c6f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031182857.68d41c6f@kernel.org>

On Thu, Oct 31, 2024 at 06:28:57PM -0700, Jakub Kicinski wrote:
> On Fri, 25 Oct 2024 07:20:19 -0700 Breno Leitao wrote:
> > The current implementation of the netpoll system uses a global skb pool,
> > which can lead to inefficient memory usage and waste when targets are
> > disabled or no longer in use.
> > 
> > This can result in a significant amount of memory being unnecessarily
> > allocated and retained, potentially causing performance issues and
> > limiting the availability of resources for other system components.
> > 
> > Modify the netpoll system to assign a skb pool to each target instead of
> > using a global one.
> > 
> > This approach allows for more fine-grained control over memory
> > allocation and deallocation, ensuring that resources are only allocated
> > and retained as needed.
> 
> If memory consumption is a concern then having n pools for n targets
> rather than one seems even worse? 
> 
> Is it not better to flush the pool when last target gets disabled?

That is an option as well, we can create a refcount and flush the pool
when it reaches to zero. This will require some core reoganization due
to the way the buffer are initialized (at early initi), but, totally
doable. In fact, this is how I started this patchset.

On the other side, it seems a better design to have a pool per user, and
they are independent and not sharing the same pool.

In fact, if the pool is per-user, we can make the whole netpoll
transmission faster, just dequeing a skb from the pool instead of trying
to allocate an fresh skb.

