Return-Path: <netdev+bounces-133797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524C99712E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A7B1F28B34
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EC1EF0A0;
	Wed,  9 Oct 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qX+vngfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943EC1E3774
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490263; cv=none; b=hTmGlqmqS2GCj6vrb6iWKEI5Avt3o8ev29bKNHP8OaI9/JsSW/gpyKQngZS5uHGkcncugDhQpT19C9Ne67xk9UDBivAA3B1xtgkI2VPdEL3bgjdKTIhyfsV2TEzHAqsGk2zPD2cX7Az6JSkWowf3g0EVce+BEYRdx5NvGH5xqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490263; c=relaxed/simple;
	bh=zANFezMWP2+5q5bmkKxoI9X7WP4yh2qlJmN4E+p/Y84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHUj63K2lhtDRn0yk6mLmWvz6mmEAb/aFxfJyPWHv9TJ3Qp+g71KAA6kuBsiyoEtZOb9hcLGbu5WSu537/Y7B7xswowYGaHGiFBBnWbgJ/6JccwOCrL8g/BMZtMDz6Zpx9xKV1Ar05DWfuIXIee8lSWFPRcFA6uZHLTStiQ1n70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qX+vngfH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so818761a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728490261; x=1729095061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtXs4iF/9F2CS31HIMaUn1FvWQbkNyZLOgfzOvfZXyI=;
        b=qX+vngfHxT8nfTdvmzNV23uCKosgxtaIGlMU7ZSc4aZOvs3mN1Ueef7jETw37/kAeH
         q3FMS2tYXN2mGCIq1trgxE1bM965kxz91rF/73JYFcSs4RQRXmvB2gbVft4TMYpeuHTp
         ficYYmVDb3uS0rhrztytFC3aRbQ7+3R1+0HWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490261; x=1729095061;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtXs4iF/9F2CS31HIMaUn1FvWQbkNyZLOgfzOvfZXyI=;
        b=kCQqEuaT6nuM6urpuBEjVpIhgDIBYh0e5c3xlH7Fujx6iayxYzoSYLDj0TE+9SWn+d
         CT6k/E1qS32KyrXpaYtVGO70x9w2dj13/NVEV7Dbf4prQV9R0cxy9Tx4pQTauz1dh5kb
         k00YMKnwKGUYsRuatwJ0o7GtKa40bENn2I8RjLUJQPqkfz/ySbi4zIcQ2gx2TdG9GMo4
         iSDGBHusH9tfocQw0tItRqQagjGn4iIPtBPpwux62z8pA3P8/iCccUklbDQmJj1jdxz7
         9GN3YGVJH8toxvPS8382UV8rq0fXh+iD8iN6ueyLI7wtexLpA1ADVZ9kHVv/5FqzKNVT
         G1oA==
X-Forwarded-Encrypted: i=1; AJvYcCUcHIWX22nUHI6Se1rC14gH3ziDPacGiRsU5d9gugOEuBkXggqDlbdGGZk3XJ+bBgX2T+vDHV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CS9+CXLRDNIHTd6trcj6Tr5A9of6nK0Xm9aXdCCB0lsMoNm+
	Ir/uYcRHMzpZeORexVxB/bHvMRbbKTbtSbJMoB1NQTvpGxMd0AUBibwWQUHWqak=
X-Google-Smtp-Source: AGHT+IHTg2+f3IdBv1fcsA80tBDzA6RmSZRzhHaqnJWAgKV498Pzezumy2Bn2Ldpaw3FKOWuRhv3Dg==
X-Received: by 2002:a17:902:f54f:b0:207:794c:ef24 with SMTP id d9443c01a7336-20c8047ac5fmr2361365ad.4.1728490260727;
        Wed, 09 Oct 2024 09:11:00 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c64406853sm13503205ad.134.2024.10.09.09.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 09:11:00 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:10:57 -0700
From: Joe Damato <jdamato@fastly.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
	netdev@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH v1 00/15] io_uring zero copy rx
Message-ID: <ZwarEeIaMqgx_VLP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	io-uring@vger.kernel.org, netdev@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <ZwW7_cRr_UpbEC-X@LQ3V64L9R2>
 <6a45f884-f9d3-4b18-9881-3bfd3a558ea8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a45f884-f9d3-4b18-9881-3bfd3a558ea8@gmail.com>

On Wed, Oct 09, 2024 at 04:07:01PM +0100, Pavel Begunkov wrote:
> On 10/9/24 00:10, Joe Damato wrote:
> > On Mon, Oct 07, 2024 at 03:15:48PM -0700, David Wei wrote:
> > > This patchset adds support for zero copy rx into userspace pages using
> > > io_uring, eliminating a kernel to user copy.
> > > 
> > > We configure a page pool that a driver uses to fill a hw rx queue to
> > > hand out user pages instead of kernel pages. Any data that ends up
> > > hitting this hw rx queue will thus be dma'd into userspace memory
> > > directly, without needing to be bounced through kernel memory. 'Reading'
> > > data out of a socket instead becomes a _notification_ mechanism, where
> > > the kernel tells userspace where the data is. The overall approach is
> > > similar to the devmem TCP proposal.
> > > 
> > > This relies on hw header/data split, flow steering and RSS to ensure
> > > packet headers remain in kernel memory and only desired flows hit a hw
> > > rx queue configured for zero copy. Configuring this is outside of the
> > > scope of this patchset.
> > 
> > This looks super cool and very useful, thanks for doing this work.
> > 
> > Is there any possibility of some notes or sample pseudo code on how
> > userland can use this being added to Documentation/networking/ ?
> 
> io_uring man pages would need to be updated with it, there are tests
> in liburing and would be a good idea to add back a simple exapmle
> to liburing/example/*. I think it should cover it

Ah, that sounds amazing to me!

I thought that suggesting that might be too much work ;) which is
why I had suggested Documentation/, but man page updates would be
excellent!

