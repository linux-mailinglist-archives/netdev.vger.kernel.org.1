Return-Path: <netdev+bounces-99403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C78D4C4A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE041C20AB5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4474183064;
	Thu, 30 May 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTW9vYR3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408817C9E5
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074576; cv=none; b=N46CFsds/QmOrytgjMjxbltzYDt0tBTq6SyVvP5xPIzUS86Eh4CoD4kJ/fz2YmgQ9hq4cpvOD+kjzdA9C+f2NU/fxDmGWxY8Fr2gTGXodafBls6xd+4y9Q+lLEy1ug8rRHnrDr0yJ0tWipGk6ZTIEUIz00EFraxsiVr/QZJo0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074576; c=relaxed/simple;
	bh=lYNJdQ0V3/Gcp7v8u0m6JSo1A8R6lWx78f/B4BWszTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAKIb9sjd2O4XEa8yx71X5BKfCJH6cvWNYb1FsKS11hVUjpVHz5pEAK7TKrW4P7a1ZvTGj0oqLchKif9Jq8xbtKWgReBTDpis0C71DRmRjhZkDfFE5UUpMJlEg8KI2vh+Q9fZ8l+PrUknyaskHVD3s+5/cihYsDILO+NlXYWKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTW9vYR3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717074573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9nGi8qNIfkniqpWSI+fxCxi2UDSD2WgUFS9bKLvDdI=;
	b=jTW9vYR3bpm96/kRmGJsCsI9OaMp09f1E9th5/SQX5XxqUrX9PQ0Ze2+FzbjNY5+YsFN/N
	Fyto3O933tJR/o9PEkRuOHMwN9xSmQN6VRGcnGsEKYfMf3k/x/hUOpdjeOy4g1pGtUCGYF
	l+EQgYp1aE3E/cwR9rHPIo4S7+J9cqY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-4nRwJwVjNhyg0EtyI1Va7w-1; Thu, 30 May 2024 09:09:32 -0400
X-MC-Unique: 4nRwJwVjNhyg0EtyI1Va7w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dca12cca8so339371f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 06:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074571; x=1717679371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9nGi8qNIfkniqpWSI+fxCxi2UDSD2WgUFS9bKLvDdI=;
        b=AtWmPRH2Od4PHJBjizAOO7fWp6Ppok8ckxcJNMKSeU4MWxMEf2Exy6aVgHz4imus7e
         DN+gln9dXqkzDFZUV+EqCMD+dtL7NpExWkvBQ07w4CMxxhjDYE+q421n00wUHXkRpIuw
         yNT4iXn+VmG1v2EuT+hTmd3ett7eWjLmIgSsmJN9ziKCHjXhD5wncek1nSNLYMAVxpgd
         15EWJbacp8qUl4wiQvDdYrvkwGoidAh6w38hWFd79mRfnZYO06kQ2RrlWet2DCQThTvz
         2X09idJJVoZwWvqsxRlW/NJIcK8mqHnuBsNdc+DENfI58dhoVYlaQFEhU72UtCDLT/EH
         +mlg==
X-Forwarded-Encrypted: i=1; AJvYcCU/K3g8WDQOzaqNVN6p3FtBW7W+CcuhcEe6N+PNmT3inOTvdiDushGJqjTgbnWGE4wsw73M1IlB4bNGbfkC3mMRl+9yTLhf
X-Gm-Message-State: AOJu0YyfmrPb7ZFeToixMELnmAZaqyLN4kVPuJdp7qBmGF3FrilcnqrG
	ZzbLcS9jCeASzluotaXNCAaOhhAJwb+nEDCZlhFEmV1ktqlhWXnqLJKUJjSuDJ8Z884cBTslq7e
	QLQlzhxaZdaLOR+/44gPPt8os08SROR/jI6nSEufs80cEDezH00fgbg==
X-Received: by 2002:a5d:550e:0:b0:354:df32:69da with SMTP id ffacd0b85a97d-35dc7e3e081mr1620582f8f.14.1717074570901;
        Thu, 30 May 2024 06:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBO25tbyDOl41OKFzuynZI6kqQwz9TH+1XUOCoEVIPxL3Ze93yMi/uikbyOHQnO8vRDvDBBw==
X-Received: by 2002:a5d:550e:0:b0:354:df32:69da with SMTP id ffacd0b85a97d-35dc7e3e081mr1620530f8f.14.1717074570198;
        Thu, 30 May 2024 06:09:30 -0700 (PDT)
Received: from redhat.com ([2.52.145.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127065907sm25070785e9.16.2024.05.30.06.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:09:29 -0700 (PDT)
Date: Thu, 30 May 2024 09:09:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH net-next V2] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240530090742-mutt-send-email-mst@kernel.org>
References: <20240530032055.8036-1-jasowang@redhat.com>
 <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>

On Thu, May 30, 2024 at 06:29:51PM +0800, Jason Wang wrote:
> On Thu, May 30, 2024 at 2:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > This patch synchronize operstate with admin state per RFC2863.
> > >
> > > This is done by trying to toggle the carrier upon open/close and
> > > synchronize with the config change work. This allows propagate status
> > > correctly to stacked devices like:
> > >
> > > ip link add link enp0s3 macvlan0 type macvlan
> > > ip link set link enp0s3 down
> > > ip link show
> > >
> > > Before this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ......
> > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > After this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ...
> > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V1:
> > > - rebase
> > > - add ack/review tags
> >
> >
> >
> >
> >
> > > ---
> > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-------------
> > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > >       /* The lock to synchronize the access to refill_enabled */
> > >       spinlock_t refill_lock;
> > >
> > > +     /* Is config change enabled? */
> > > +     bool config_change_enabled;
> > > +
> > > +     /* The lock to synchronize the access to config_change_enabled */
> > > +     spinlock_t config_change_lock;
> > > +
> > >       /* Work struct for config space updates */
> > >       struct work_struct config_work;
> > >
> >
> >
> > But we already have dev->config_lock and dev->config_enabled.
> >
> > And it actually works better - instead of discarding config
> > change events it defers them until enabled.
> >
> 
> Yes but then both virtio-net driver and virtio core can ask to enable
> and disable and then we need some kind of synchronization which is
> non-trivial.

Well for core it happens on bring up path before driver works
and later on tear down after it is gone.
So I do not think they ever do it at the same time.


> And device enabling on the core is different from bringing the device
> up in the networking subsystem. Here we just delay to deal with the
> config change interrupt on ndo_open(). (E.g try to ack announce is
> meaningless when the device is down).
> 
> Thanks

another thing is that it is better not to re-read all config
on link up if there was no config interrupt - less vm exits.

-- 
MST


