Return-Path: <netdev+bounces-105152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB290FDF2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB53285AC6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED914482C8;
	Thu, 20 Jun 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToWXMKb8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B745C18
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869416; cv=none; b=oD8WWiBUpT+QGQg2WPzNUln0jYA16B+HyslcMZm1H4srmH0UVJ36cgk2aFOvTnO/ilY9wE5DW5kYV4O/GxPd3dXG6sQPtL4cD0bcOZjE4IMIqa0Xm3Mnz91VN9vJQBAVBYilEwsSWZgxnGlxU0KzfWyLTjg+mTuZJoHX7op4Hj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869416; c=relaxed/simple;
	bh=jyZP6zvozf8EbqUwf6ioCSVFEUju+1hSxjUKNLziRFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GegvldmlCb0uaYECOgCkPSfQQ64l8hbOmghlQuePyPgcTMtankm/brHRzG5AehtOXqbxLCXOx3X4V8hCozmHvEXJQdYO3AgFUm4aLXlfohu2PttfFKQEPeDsDELJxMM2DobW4csConrdrrV80eX5cBjAiHNXOdTPF6N5rtuhc90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToWXMKb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718869414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6IllHNP6pe8oet9dZhi5FEduxqCNmohu0Uxo5VF6EIA=;
	b=ToWXMKb8dTP7FvZj69BALMAszigAGqYqhUJ5BQZpmpPoXWNt/Rn9ZSLmAoK3WA8pRZMoQI
	YbWUSq8RLQ4szum8c72gdtWPzwy0rWn2nn0CehtE5+U2bOdYf0PSLurrAInkl0dPBtnTZ3
	FcMCkW69HwaBcpnaEadxxpsc8tIr0ao=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-gekIydb1NzehSYP7YYHnMA-1; Thu, 20 Jun 2024 03:43:32 -0400
X-MC-Unique: gekIydb1NzehSYP7YYHnMA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6f2662d050so23507666b.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869411; x=1719474211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IllHNP6pe8oet9dZhi5FEduxqCNmohu0Uxo5VF6EIA=;
        b=AAfMQM1N7Qz9d1vM69BuIyPc45oZBF5CWhAx9i8HzkknZmXjk0jXCjMzIWgiNYpXgs
         N4dWIRUwQKsGMJiybOGjEJCPQtGZg0KWQzqiS0xjiUjzXHMc9APHQVlUI7FJgi1Ecz3Q
         xRl2XDVEEV46DHm1SbYsa0areL68me/dYwVy4MAL0LZ6I4VqHrlmnH2hdGyR1vk/zCHA
         QilUpBr6SVwk4qB0gK+ZXU2/O+pIWLZBZJSa/x+WDQTJauAMYtrNIOPYAKfepKpGnjn7
         shFc/gUf0DRfcvBJg+nXMkC76T6hKN0AsaxSD6+MS3Pe8Ct/exWUwbSvkAhazDNJP4AC
         l5JA==
X-Gm-Message-State: AOJu0YzGy5770N2YZvSheGLK+FS+yEtgrRY8SpinQkxqS8QSx2FuBiiH
	RYjEBcU4h9MhcMKVUK6seUUMMfZaZQeW0/KDpOPkBLiziEZr8piBzbOuLl06rZ6WpLyvmogWe1s
	sVaWGsVdCjq31DVkHxbeXDKhC5p3QcrSLCa1akw/ZAAiTd6ZudFInYA==
X-Received: by 2002:a17:907:9848:b0:a6f:5a9d:37f9 with SMTP id a640c23a62f3a-a6fab77a6edmr237227866b.48.1718869411504;
        Thu, 20 Jun 2024 00:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeWTQ5qAdQ8c3nreJgA53fKPCnNOZO16YgYwi+9R7guaHTC2Qu3SHuZ9LaFmUL07kEgmfYYw==
X-Received: by 2002:a17:907:9848:b0:a6f:5a9d:37f9 with SMTP id a640c23a62f3a-a6fab77a6edmr237224366b.48.1718869410179;
        Thu, 20 Jun 2024 00:43:30 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42badsm737008666b.184.2024.06.20.00.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:43:29 -0700 (PDT)
Date: Thu, 20 Jun 2024 03:43:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240620034251-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
 <20240619014938-mutt-send-email-mst@kernel.org>
 <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
 <20240619041846-mutt-send-email-mst@kernel.org>
 <ZnKuafjQt-Y-VokM@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKuafjQt-Y-VokM@nanopsycho.orion>

On Wed, Jun 19, 2024 at 12:09:45PM +0200, Jiri Pirko wrote:
> Wed, Jun 19, 2024 at 10:23:25AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 19, 2024 at 10:05:41AM +0200, Jiri Pirko wrote:
> >> >Oh. Right of course. Worth a comment maybe? Just to make sure
> >> >we remember not to call __free_old_xmit twice in a row
> >> >without reinitializing stats.
> >> >Or move the initialization into __free_old_xmit to make it
> >> >self-contained ..
> >> 
> >> Well, the initialization happens in the caller by {0}, Wouldn't
> >> memset in __free_old_xmit() add an extra overhead? IDK.
> >
> >
> >Well if I did the below the binary is a bit smaller.
> >
> >If you have to respin you can include it.
> >If not I can submit separately.
> 
> Please send it reparately. It's should be a separate patch.
> 
> Thanks!
> 
> >
> >----
> >
> >
> >virtio-net: cleanup __free_old_xmit
> >
> >Two call sites of __free_old_xmit zero-initialize stats,
> >doing it inside __free_old_xmit seems to make compiler's
> >job a bit easier:
> >
> >$ size /tmp/orig/virtio_net.o 
> >   text    data     bss     dec     hex filename
> >  65857    3892     100   69849   110d9 /tmp/orig/virtio_net.o
> >$ size /tmp/new/virtio_net.o 
> >   text    data     bss     dec     hex filename
> >  65760    3892     100   69752   11078 /tmp/new/virtio_net.o
> >
> >Couldn't measure any performance impact, unsurprizingly.
> >
> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >---
> >
> >diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >index 283b34d50296..c2ce8de340f7 100644
> >--- a/drivers/net/virtio_net.c
> >+++ b/drivers/net/virtio_net.c
> >@@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> > 	unsigned int len;
> > 	void *ptr;
> > 
> >+	stats->bytes = stats->packets = 0;
> 
> Memset perhaps?

Generates the same code and I find it less readable -
virtio generally opts for explicit initialization.

> >+
> > 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> > 		++stats->packets;
> > 
> >@@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > 
> > static void free_old_xmit(struct send_queue *sq, bool in_napi)
> > {
> >-	struct virtnet_sq_free_stats stats = {0};
> >+	struct virtnet_sq_free_stats stats;
> > 
> > 	__free_old_xmit(sq, in_napi, &stats);
> > 
> >@@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> > 			    int n, struct xdp_frame **frames, u32 flags)
> > {
> > 	struct virtnet_info *vi = netdev_priv(dev);
> >-	struct virtnet_sq_free_stats stats = {0};
> >+	struct virtnet_sq_free_stats stats;
> > 	struct receive_queue *rq = vi->rq;
> > 	struct bpf_prog *xdp_prog;
> > 	struct send_queue *sq;
> >


