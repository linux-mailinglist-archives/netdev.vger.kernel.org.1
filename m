Return-Path: <netdev+bounces-246064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05000CDDECD
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 941E3300B829
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA6B31DD86;
	Thu, 25 Dec 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViwvvIzH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PP772OAK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08963195EF
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766680073; cv=none; b=uNwjRMLQHzZziYyS5qEwtWMCB+qT4ODlnQ0mYmjo+vIeTy1kSgUkeQMxDGGvafXo2cJqUoF/loih3tMn2nMhkJjen+xSt2p3jT8zmLZBZTY1tuHxH66wRs7wxnie9QcPJ5Wlopproz2bST+jGjKqU2aqJbaL5zzVO8aLeq5ZZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766680073; c=relaxed/simple;
	bh=pktztNj0673p74dCRRu3x40mLqPXkmk8e3Tl7TzacCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONoKRXJ73v7aS6iFPE+Tag/m1sHDNJyYprMXChazmWZb3uAZxX4UCq4YU4DNNGSuM3L7Wzm3MTcUlb4tKfmODUo2/bf/LqyoLZlh8rKwAXWziauX4jSFIT1+zqKZydOvrfODHcO1SaEOMbNNej1e5zFyGs8fCgq6rBRMgjYKNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViwvvIzH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PP772OAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766680070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UMUN0jgR/zHl85fjFgxzwAhKsJq+HRQG2BMMWbhG4I=;
	b=ViwvvIzH4l9USK0MqwiZgj3p9yuaTbsDv0eGw5uPu8YIXETUVyFih42DEzvLCM9mIsIMGE
	WmQrew74vsfzjOlfFUqy/y0SxZ43DjBIbI4SsU0ZOGAr+R+58NjE8tNVPepbd2hdgD2hcg
	NK6Y3MJGa1+a541ck/RubenbxauRdKw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-rAQP-j2VPCKc_ScM7-jP5Q-1; Thu, 25 Dec 2025 11:27:49 -0500
X-MC-Unique: rAQP-j2VPCKc_ScM7-jP5Q-1
X-Mimecast-MFC-AGG-ID: rAQP-j2VPCKc_ScM7-jP5Q_1766680068
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fb8d41acso3231568f8f.1
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766680068; x=1767284868; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5UMUN0jgR/zHl85fjFgxzwAhKsJq+HRQG2BMMWbhG4I=;
        b=PP772OAKcOtmFibYki6IbInRu/s2BI5AcNS4l6G0TZ9zjPoKFBNy1OEwiR0d7FOSEi
         9mk2RlB9hl1X97ASRtLzHKf++6P8XVqMUBKqXkws1Vr/nkVfiGcLFYH7rSS/iPtPDp5t
         58ycmIg66zaWJdDvDZ2J4/WAaOZh4RNSu+6zVdnXTmdI0Lv6vr10uxxd6YWQCDBEI1xX
         BrNPEAP4sX8orcZhP9yzWSOZ5407Ywqe8BRm7J7lxOLO0eO+oc6HRQTpN1cPjExytOVl
         ihopMWNo8SnijyipNy5GIDuQiPlpngkgnwKRJFjm00GydKw0kCz942Csq8YAR4rMYGoP
         mNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766680068; x=1767284868;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UMUN0jgR/zHl85fjFgxzwAhKsJq+HRQG2BMMWbhG4I=;
        b=L9K7kGoilMJiscGV9n3xSx+/C7LJ3wE/XQ5PGR7Yobzo0SiYkVHW87Tdt1A4DYJkB4
         tORQG8HnHJM7D4+eaexjhZRfd7xMc0AZ/YdaLEJmSEhyg/Xg07ikF9N2j7ooRqWRAfHN
         Orn2se8isUn4SWNTV1TyWiW7D35yJWBqudMqMaUTSLr51+UD9NEiN9qIExP5gIR3OnIb
         3KkKe9GF+YFLfBgYkumb6nAFazRyxCQvSQNIF/faFOkN6B2gxpuLw2/ZA/BP5HiAdjG7
         gNYz2INCOdCLMwOzOftHQ3yCVgzaJ5+XXHrNoRUU3gnEdbwrYlf6LKy10KctAzYH0NeH
         6DRg==
X-Forwarded-Encrypted: i=1; AJvYcCXlyO5oDKD6x5McC+ltRU4tNqAhkQZSkBzyYYjfFtJ9x2HBaZMnEKb32e/Myf0lyR0/8vxhMl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqYc/77BM41Uk9hIcddf0NikuaTTQXA2QMCtAoe7HMxXFZnV2g
	wjN9NHRDeg4faODzv+BRC9Hy30rINZALRdYhxwFa1pQOicq9ei66jPJ3H8Xjr5R9RLYCwncEqDD
	eX7YM2y4ysBHaVPfMB339KJJgG+nfPr3C/HP9Meswg0YGafK3ohFx+haehg==
X-Gm-Gg: AY/fxX4A2S12VpejRFH8FFAVVYgcCTsg+RK3BYSIdKyjGvhVEhlg8Wt7Ou3dnfZcLez
	w1doPq7H+yyRqEOFbiVNo1MTebBn7AGcQg+OJq1+SKB2rrdfdtH+6y6wmnkO90AzqHbQoxWsuLk
	QjocXqLsd6dKP3i7499M6VdM/BOatEP2PyI0uS8HzUBGtQtoObIoC5OgIoSUq0hdH3oloQIb1MD
	V+iEpDG5mXkjPCWy7V+elAlPqfIcZk55UAeWSJJ/gDOHo+Da8CJ4foEfdhFjM3HEKQtwwjVnl9+
	PUk710YF1ie9psgB06xsLQjNG9M1W+u8qaYcWRha6bNZpuZND0tB/WV8+dbst7ZcjFdVs+4Q0nZ
	BRbSC/damnR81khns+FLKICsaWggXp418ng==
X-Received: by 2002:a05:6000:2504:b0:431:5ca:c1b7 with SMTP id ffacd0b85a97d-4324e4cbcc1mr25712988f8f.23.1766680068266;
        Thu, 25 Dec 2025 08:27:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0R7k5H0uEZzPtgL/lcx5+ScBj7pHtcQ6qqyBP2A8tSvsgvH85v5c3f94zJFXpkNhGRCz/xw==
X-Received: by 2002:a05:6000:2504:b0:431:5ca:c1b7 with SMTP id ffacd0b85a97d-4324e4cbcc1mr25712964f8f.23.1766680067805;
        Thu, 25 Dec 2025 08:27:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm42036674f8f.27.2025.12.25.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 08:27:46 -0800 (PST)
Date: Thu, 25 Dec 2025 11:27:43 -0500
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
Message-ID: <20251225112729-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>

On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > >
> > > Hi Jason,
> > >
> > > I'm wondering why we even need this refill work. Why not simply let NAPI retry
> > > the refill on its next run if the refill fails? That would seem much simpler.
> > > This refill work complicates maintenance and often introduces a lot of
> > > concurrency issues and races.
> > >
> > > Thanks.
> >
> > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> >
> > And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
> 
> Btw, I see some drivers are doing things as Xuan said. E.g
> mlx5e_napi_poll() did:
> 
> busy |= INDIRECT_CALL_2(rq->post_wqes,
>                                 mlx5e_post_rx_mpwqes,
>                                 mlx5e_post_rx_wqes,
> 
> ...
> 
> if (busy) {
>          if (likely(mlx5e_channel_no_affinity_change(c))) {
>                 work_done = budget;
>                 goto out;
> ...


is busy a GFP_ATOMIC allocation failure?

> >
> > Not saying refill work is a great hack, but that is the reason for it.
> > --
> > MST
> >
> 
> Thanks


