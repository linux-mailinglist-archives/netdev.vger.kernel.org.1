Return-Path: <netdev+bounces-246079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B4CDE6D8
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 08:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA68300818D
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9E274FE3;
	Fri, 26 Dec 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbB7AuTM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnCgc+lX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393C20125F
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766734670; cv=none; b=oV+ObdckapD2YQIRA5RjF9cQnknlWAJb9v4tf7Qpi+G5e5vz2I9H4FqXtPZ8H4Sb6j8lXCbgexMOont+/Gt362n/eDPmX7VobyRu6PKlE/90lKJVjbKB1hq4Wkv3oYMtH9jINOLoTv2WYd9f09lMcAv19t1B0B7P6T2Fkl2j9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766734670; c=relaxed/simple;
	bh=0rmvrB0jFA9AqaRU7FDxlBBzIIKJKv2DCijQxPr9ssk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgMRY631K5+8qpmqq8T+g8S1crog4Bs98n7DUIFYsT5NMjtMI9sky/wLkH8AESE9q3m0sh+EsbBxiBLf/qz2YrF6vnPtktO30FmysBlo1fhsVBI8pOTDBacEpM4fYWB6/Cdb3V1vaex15cCkIK/GNAA/VUbm8G7dSQ/GCaGPKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbB7AuTM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnCgc+lX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766734667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUh1KaOXjv2HvFwemQznNzF51XENR9Lh865zEQseUv4=;
	b=CbB7AuTMlsg6cj5qvAMo5StUAHfZuv2yHKqxN9BMgBT+AuMQXQacOBLSDVnH5vru9aycwg
	ULY6Uzxnr7Dp/yZu9XGqVe10kkUCz5haLZKoEakKxKYFd93POLROpB7VOUTKC+EDtghrTy
	55smT0tfcwgoU2UDNqGWQmYoEUtL+aw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-lQH2wMpvPxWDH_twxtuLGw-1; Fri, 26 Dec 2025 02:37:46 -0500
X-MC-Unique: lQH2wMpvPxWDH_twxtuLGw-1
X-Mimecast-MFC-AGG-ID: lQH2wMpvPxWDH_twxtuLGw_1766734665
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso96611105e9.2
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 23:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766734665; x=1767339465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CUh1KaOXjv2HvFwemQznNzF51XENR9Lh865zEQseUv4=;
        b=YnCgc+lXfH+0r+B2EAfv/hl36yrFbaf9AkldYe1iYNcfYhTD7DE3rYrMuZX5cUlNA0
         BrzTZw1tQmo1vhUi1dd9UFoXDgthxNEctISCYnfkPaJlKGZC+7uZGQUZEVBdlLMw0uG1
         6jZ5eezUCnu/CzCUZp7x6z8mHBUBz0qIsCQ5M3gJS8JBOh+Xb3xu/i4ZKR3gTGDNfAkl
         6Tg4bRbNxxD/Bn6inHm4bUedwMaZMI+HqcDGcNOZXeBsog68aC6FrtZ9SxeAymX+VN3h
         yMXtFIFM/693GQ7J9Wczx/GPuZAUTHA0ji1INh7fTSFTHjtCf9pSuYtU8od+ftsGsn4m
         l31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766734665; x=1767339465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUh1KaOXjv2HvFwemQznNzF51XENR9Lh865zEQseUv4=;
        b=u2wLY6Iq3OppHHR1VXb8VR8LY906FPUyxD2hkLbBUOHA68AX8OeKHIXPpSJbozSlQ2
         aJcqbGgKliGs3RhCvxpxCPnMcEoez0pICrWXdjUt09d4ke7jFlNJ2qFWP97rgdxSoxVv
         vQ+kBL5ld5qRw63oXkZMAuqFGh0iM10ra61zXiRFcN8fSCLYWN1kowg3+hf33rFlvjWR
         Gwn5jq6CLrEGCBA5EJGqouKqqOYxYNmmkcBlZUR3mfDY8dWswSAiqUKEHKFYJA5IkYIS
         xTB885jOVk92KiZlvEWoWsc7jJ4YDwSdv7dxr12OXqd1Hfai+Fyj7F9vzXRwLPftwnnN
         n59Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBTls4zcnNIQGcT2eeOinN0dcb+PKYviacur0sX2ruMozMssJ7hiychBB6JKR3qp9xqydI9zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyinqryI/HX1C4Dr119uE21vhKM4bYOt/KnVNC4lv/2ZI3eDl4h
	MPv5/JYhWv/ayIAy56CN/LP2e9juRZ+BsTvxAPuxVHJ1JqpBqEif3urkroU9FLzRmT2iCsU+stc
	akWoM62f4tEgduat5vOc2/2ihvFUOZffOs3sekk6gngZs55Gfw2bKcCJrMg==
X-Gm-Gg: AY/fxX4AeEBr4/r8yRgoxC3JvqzDH6v8aAfbcpmm0L2jbKm3k/No9tB7B0na+YSF77v
	cYC646pFtDQ+t5+a1KrOky1+fVbuoDaLbJVJp6f0PzI39fgvuJQGb1bQPsVYldRTmJ4BNyxBq4/
	8EwNVzhcERrHi/q3kApfpdqg0tSjvj9cIknqQFB0sQieXudxjCyUs6+fPivTf/uBUOc8x40UP8Q
	rIuboCRDHz/5DMomLzo2bSHAeu5vH5SMU8YKwL+7gyUlFld0Gl2FjYDUhBjRgKJvGmEThthSOOX
	FwlZG/ueB+z7mkbTkWeD7KvpypT8ooMGt0C+fmLqOHkE0JHcx+q4wQW6LooKq1HCKvdc9Oe2BD7
	cBj8lfFJzkp0JSMaC+XaoZUfriJT8xcONTw==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr226258665e9.34.1766734664669;
        Thu, 25 Dec 2025 23:37:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpsFWjeude7gy71vuh6vSWasoySUpj/LvWEgjphgTCKyVNexu8UQ8V6vCGw/Jfq9ZpZj/RgA==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr226258395e9.34.1766734664223;
        Thu, 25 Dec 2025 23:37:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193522cdsm363228075e9.4.2025.12.25.23.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 23:37:43 -0800 (PST)
Date: Fri, 26 Dec 2025 02:37:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251226022727-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org>
 <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>

On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
> On Fri, Dec 26, 2025 at 12:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > > On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > >
> > > > > Hi Jason,
> > > > >
> > > > > I'm wondering why we even need this refill work. Why not simply let NAPI retry
> > > > > the refill on its next run if the refill fails? That would seem much simpler.
> > > > > This refill work complicates maintenance and often introduces a lot of
> > > > > concurrency issues and races.
> > > > >
> > > > > Thanks.
> > > >
> > > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > >
> > > > And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
> > >
> > > Btw, I see some drivers are doing things as Xuan said. E.g
> > > mlx5e_napi_poll() did:
> > >
> > > busy |= INDIRECT_CALL_2(rq->post_wqes,
> > >                                 mlx5e_post_rx_mpwqes,
> > >                                 mlx5e_post_rx_wqes,
> > >
> > > ...
> > >
> > > if (busy) {
> > >          if (likely(mlx5e_channel_no_affinity_change(c))) {
> > >                 work_done = budget;
> > >                 goto out;
> > > ...
> >
> >
> > is busy a GFP_ATOMIC allocation failure?
> 
> Yes, and I think the logic here is to fallback to ksoftirqd if the
> allocation fails too much.
> 
> Thanks


True. I just don't know if this works better or worse than the
current design, but it is certainly simpler and we never actually
worried about the performance of the current one.


So you know, let's roll with this approach.

I do however ask that some testing is done on the patch forcing these OOM
situations just to see if we are missing something obvious.


the beauty is the patch can be very small:
1. patch 1 do not schedule refill ever, just retrigger napi
2. remove all the now dead code

this way patch 1 will be small and backportable to stable.






> >
> > > >
> > > > Not saying refill work is a great hack, but that is the reason for it.
> > > > --
> > > > MST
> > > >
> > >
> > > Thanks
> >


