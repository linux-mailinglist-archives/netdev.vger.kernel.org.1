Return-Path: <netdev+bounces-246063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B7CDDECA
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 17:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6EDA300B917
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23123314B7C;
	Thu, 25 Dec 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAsRQrP3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="doxlv3Ix"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685282F0C49
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766680050; cv=none; b=mKM37fapcns1u35YV5rW4u3Q3cevyy3T7Bq2DI7Svq5sAwlkKEaqDhiW+x9iciIMXUrh3S82jv950+EHTPIVPhDJq8xOgFyiEx6NwqW6yV/IuEBz5lr98XaiyYyEbJYRLYZt8sSyDnzJ6sbe3HHCWCdOAW2IW6JCKvfuox3xAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766680050; c=relaxed/simple;
	bh=vv1phZqix/ryOn4SSA6WVQ7/V1Efqn5k4N47N/zr0mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQtkKeKgOlleDQDVlZjZn4GlcuDpL32hvEQGIHcEtsqA5rVmLTcpnKYQrv+u7pn9ij/Ct0rGuMwj7pOjth1ekj1WhqxM41lzgYx35MiEMFDOSmfalBdspjGPAxDOX7nGDtGyqjE/vsaOLET0wI/weiVgcgKHHjzqht1L5U0NqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAsRQrP3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=doxlv3Ix; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766680047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/GZnGNU0TUGeQc/Z49ZORFqF8Kc+GJGvY+J18xzKb8=;
	b=hAsRQrP3lRR4Uj/KQ1EjgXVexVVqulmASfV2t+JVrzM5sA9ogM7AuPmaW38npJtWaDta6o
	zA7zHduR313VmfirhevAez6gjrW6OyIO2Q8AJ4jxGQ4f9yC/zd7TuZC1Hjn8rF0uowdxf5
	VsFhJNei2h39cydkWIqzMs20il+8RY0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-7Hh-MMhYNJGWNBOqEtYGEw-1; Thu, 25 Dec 2025 11:27:22 -0500
X-MC-Unique: 7Hh-MMhYNJGWNBOqEtYGEw-1
X-Mimecast-MFC-AGG-ID: 7Hh-MMhYNJGWNBOqEtYGEw_1766680034
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477964c22e0so45717655e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766680034; x=1767284834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/GZnGNU0TUGeQc/Z49ZORFqF8Kc+GJGvY+J18xzKb8=;
        b=doxlv3IxD+YSw65CkQlO2uiqVUK50Vy/6c1UMuJGMzFGFjv7qVBzHk3iyjmxzUOdJa
         R3l0wbeVw68jIwMQAm8ZZjp7UdWwzebKXJB70O5O9r94bl3Z4OiZRg5y19ra192B1lTJ
         Fu2U//l6Yn5wFkw24MWrStY3YTz5vTRMT322jw16Mrtj8CZhyobZpdFOfpZPjjjWTUx1
         tLqjq0Foiimwfv689lMMrUJ9ZvETUT4N6d27eGiVlPzxlWDlpYifvjGPOGgHEpU1uFVU
         WWSLDTZvLSdJiraBP1KblY3vGI+ERl1i9XY81Bc411PmpJ8/r2ykwTnfGtsMTEqewwjV
         vISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766680034; x=1767284834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/GZnGNU0TUGeQc/Z49ZORFqF8Kc+GJGvY+J18xzKb8=;
        b=f/IITY7Fdo1C9WLFN3B+qlvm9tl8DgU5cmK/0mNIeqMjt7AuAvfdFqPcvvNtXpDr15
         YZZy78WxRUZXZdsnTQvNHE0Zr0KYyvJyoNiwf00mQxdEFDTvOq4l9Ia29q7Bq2ddw6Ii
         0iHWe3SzrfyJ3OInrmDepZp475YWcocehAEn8vjDLdZPKPIyYPiktiuFhXV6gkbgAAid
         H2xETiemE1rGhd8+XZMMCQdV11XNOQn+TQW88jps1Tl4LRLjRU+Jl9I8bVG6RQDUEHPG
         E8firdM1gEwAys/YORwJovmw0HFeiutYyg96g8XjxuS5103WnNQo2kghYH7WkwETaALJ
         AInw==
X-Forwarded-Encrypted: i=1; AJvYcCX8wRCrh8kxIYw06k6IGHUGz+VSDklLFT4zyDBK2PElIG4ezi8kq0HaOJMfeo43huZxpS64pHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0V1wRaXuHvILu0MczuirTWe/5OvZTLfxxdyRqEVwBdj+roZU
	Is1B7xMflC7RKZuRaJ4ZNjWg7zMwav5o8NigglsiNMxgxDMa9V9Ap5mToBCkWVtgnSnSAYcF0VA
	pzPyl9efutDS/2UdH5wiPzCeRp9BqItclnqeTcm8Nt5UqyGbGp21aVQ5fLQ==
X-Gm-Gg: AY/fxX4vYWWMgK/W4uRLjcPhYJWrydXApnU9CSKbZfkF5Hn6J0RKZyKabJhOL7cgVw1
	TocFjdXL0zVy9oGWARYUylwWC45uFd+qVzWDSIiWTw6rgyoVbPQMAIORC9hQjtMhcuwS9TWuGUA
	ntWELrDA8dhLfW8EMUNOS8Q/UoECQg/lv1lkFj0dHDSCqGKCQPWnZEk+4O1v61PSsif8XWtNBjr
	Oez6CoJaVI10/UVkPRzaqUh8CP+5VOEsNVGGYfXbz/9zULXWMzEyR1XLOsb7UDkpDazrf4kQXyl
	jAmBmbrtGtuCjg0s1RyM7YpU3YFXCk2zMzbUfobvq+496CcHztle5LdWaSuKaYQB3qZPnoc1DgG
	Tic8RqBA+/tQQ7X3ARGqTUDdGjSYMD4DRNw==
X-Received: by 2002:a05:600c:8718:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d18b0ad6fmr209121155e9.0.1766680034036;
        Thu, 25 Dec 2025 08:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExHtOTrO6amFRMKKbbMC2la+j516gOLyPplDk/OSZh4gRdGY/ppOsxF00RFw07Xle4k8vO4Q==
X-Received: by 2002:a05:600c:8718:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d18b0ad6fmr209120785e9.0.1766680033471;
        Thu, 25 Dec 2025 08:27:13 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19352306sm344339415e9.5.2025.12.25.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 08:27:12 -0800 (PST)
Date: Thu, 25 Dec 2025 11:27:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
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
	bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251225112636-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
 <dd4d01d7-29a8-43b3-bb5b-f50ea384aadb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4d01d7-29a8-43b3-bb5b-f50ea384aadb@gmail.com>

On Thu, Dec 25, 2025 at 10:55:36PM +0700, Bui Quang Minh wrote:
> On 12/24/25 23:49, Bui Quang Minh wrote:
> > On 12/24/25 08:47, Michael S. Tsirkin wrote:
> > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > Hi Jason,
> > > > 
> > > > I'm wondering why we even need this refill work. Why not simply
> > > > let NAPI retry
> > > > the refill on its next run if the refill fails? That would seem
> > > > much simpler.
> > > > This refill work complicates maintenance and often introduces a lot of
> > > > concurrency issues and races.
> > > > 
> > > > Thanks.
> > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > 
> > > And if GFP_ATOMIC failed, aggressively retrying might not be a great
> > > idea.
> > > 
> > > Not saying refill work is a great hack, but that is the reason for it.
> > 
> > In case no allocated received buffer and NAPI refill fails, the host
> > will not send any packets. If there is no busy polling loop either, the
> > RX will be stuck. That's also the reason why we need refill work. Is it
> > correct?
> 
> I've just looked at mlx5e_napi_poll which is mentioned by Jason. So if we
> want to retry refilling in the next NAPI, we can set a bool (e.g.
> retry_refill) in virtnet_receive, then in virtnet_poll, we don't call
> virtqueue_napi_complete. As a result, our napi poll is still in the
> softirq's poll list, so we don't need a new host packet to trigger
> virtqueue's callback which calls napi_schedule again.
> > 
> > Thanks,
> > Quang Minh.
> > 
>


yes yes.
but aggressively retrying GFP_ATOMIC until it works is not the thing to
do.

-- 
MST


