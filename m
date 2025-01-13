Return-Path: <netdev+bounces-157913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5124A0C49C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222527A322B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086D1F9A81;
	Mon, 13 Jan 2025 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JPQNZ3u+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AC1F9421
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807042; cv=none; b=pX7vGA7aLr66UFXG0qvd5muYl+jqdQazbRvq37rQ/FZ2/CeporK20R7w7LKu7QHdQ6nA/a75MqDLuGgTDQxKzkDHMEWAhiFFJuUrY6XzE+0zizx2YnVT+bJ94Lh+ZGKKGZrrsc3FxaUJIcf7eHwBjmfJSY4sbc/0CZs0ry+ulR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807042; c=relaxed/simple;
	bh=jraBJYaNKuM4ks66r89Q9Cssxz1SfOAZy8ZJzGHSuiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFE97+XOnU/1TeRMgh6Sjh+ekWEH9N8dX7WWeiRk+jB5hdPHngYJQ8AYX41kjCLb1R4jjxUjmxMOYZNgueM+o/JHV1PNq35BQKZNwm04eNbHCF9r4Z5534z5ITvEpZStee9yDSOT9xKSn6nlrP1ZjYCQqcTlIyH4h0iarIVDkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JPQNZ3u+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216401de828so79485595ad.3
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736807040; x=1737411840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWEGafjI92owQD2zGRSWReNV8vxv3omjYwC2PJyLuQg=;
        b=JPQNZ3u+FRYRqNxkQjMQQ3zMG5dahbsmzaqNUVPLxz7BdHg0yhm/8dqGpLhdB5vGXO
         4KnNTfc9Zdkv+Zfys8xwydnHEVY7l2UUHmPXJnDCdMfHZ18fRYZmnt6j+3BzvrhnKQQU
         b4bNqQZcxS9JspyVuFcnW4J+ippb3QF0HflWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736807040; x=1737411840;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWEGafjI92owQD2zGRSWReNV8vxv3omjYwC2PJyLuQg=;
        b=BUitrXPbJR8qgmwy6ZW8WnaVSfTLs+pnspDGzNTnK0rcjTy4xKPiN1SZOaQwtXJh5i
         MYxzq0dqj6th/4JUY0Nr30wDPT9kwe1kiE8mEoJZdHcQTL4RB5eipm7jIFPWgx9XMK3b
         FblqeC/ECk4I2lezCBUFeg4wMg3Qrf4iLu60K1v+ylOaAaeeyCFCVbRHaMloluZK/YGT
         x5ZwNT7vyiyFO0vCR4IuZNWuu/RHWgO09s+TNWA7aKSuy+AR9GKUJiEwsD8FtCmoNKam
         g+bhSWxcmNjgBFhCeNdEazx73+4EeSc/UVfcJI4zh9b3o7R1LcDAEHFH2vvVwhnx0Sop
         2Ulw==
X-Forwarded-Encrypted: i=1; AJvYcCWDSyAi4nia7Cc6g+vcKOVurFCU6wrdYlvb6zRCpGJCIIYBLAvuhk48wzZja0qqHxXycD7E6jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZzOYMEbYXxW0SKsb+AXNmO4ciMuuKq8qj1FIyTQXrcfHnJJX
	rUIITovl0tfLEfV6s7jSHF12aFyzRKuSn+zpp8HkHjSSTXRfIXak7nRJHzGJO1A=
X-Gm-Gg: ASbGncuHJCdA38ZfCnr64T1aHeTON97JM/LhseQXDKbMs5+ceNv5c5FjOtZFINExlb7
	Q9yENbfUfy4oHzvcZXERZ2FsyOmxDu/yibNw3P90cVYR5CP945KtjO/8zPSfHIiUhtueW0tiXXS
	ktJm1G39Y6oSn3PhwO/L6RmJWs8M2eAgXWepcgKx61q8q7sneZA+8K8llx3RFgUX3frPxlzEjCF
	zc+K6Vj6j/4ZzKuE3y/xtzOqN42cH/bTn5aEPYcm4t1uJNn9MoG3WK2ijXFB0vpRTf1WjupiMgh
	GIzCpgWtSqLWwRbSau/Vkvc=
X-Google-Smtp-Source: AGHT+IGRopay+m4MXKSpsww/HEMIYf2K6aGjf/90wlXRRh/leJG1vGjE3JADPcrdleil3GS6FrlG/Q==
X-Received: by 2002:a05:6a20:2594:b0:1e1:94a2:275c with SMTP id adf61e73a8af0-1e88cfa740amr33957317637.18.1736807040166;
        Mon, 13 Jan 2025 14:24:00 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a61f7sm6511552b3a.175.2025.01.13.14.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 14:23:59 -0800 (PST)
Date: Mon, 13 Jan 2025 14:23:56 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
Message-ID: <Z4WSfER6O6n3hxXh@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250110202605.429475-1-jdamato@fastly.com>
 <20250110202605.429475-4-jdamato@fastly.com>
 <CACGkMEtjERF72zkLzDn2OKz3OGkJOQ+FCJS3MRscJqakEz9FYA@mail.gmail.com>
 <Z4VNrAI794LixEXt@LQ3V64L9R2>
 <20250113140446.12d7b7d3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113140446.12d7b7d3@kernel.org>

On Mon, Jan 13, 2025 at 02:04:46PM -0800, Jakub Kicinski wrote:
> On Mon, 13 Jan 2025 09:30:20 -0800 Joe Damato wrote:
> > > >  static void virtnet_napi_enable_lock(struct virtqueue *vq,
> > > > -                                    struct napi_struct *napi)
> > > > +                                    struct napi_struct *napi,
> > > > +                                    bool need_rtnl)
> > > >  {
> > > > +       struct virtnet_info *vi = vq->vdev->priv;
> > > > +       int q = vq2rxq(vq);
> > > > +
> > > >         virtnet_napi_do_enable(vq, napi);
> > > > +
> > > > +       if (q < vi->curr_queue_pairs) {
> > > > +               if (need_rtnl)
> > > > +                       rtnl_lock();  
> > > 
> > > Can we tweak the caller to call rtnl_lock() instead to avoid this trick?  
> > 
> > The major problem is that if the caller calls rtnl_lock() before
> > calling virtnet_napi_enable_lock, then virtnet_napi_do_enable (and
> > thus napi_enable) happen under the lock.
> > 
> > Jakub mentioned in a recent change [1] that napi_enable may soon
> > need to sleep.
> > 
> > Given the above constraints, the only way to avoid the "need_rtnl"
> > would be to refactor the code much more, placing calls (or wrappers)
> > to netif_queue_set_napi in many locations.
> > 
> > IMHO: This implementation seemed cleaner than putting calls to
> > netif_queue_set_napi throughout the driver.
> > 
> > Please let me know how you'd like to proceed on this.
> > 
> > [1]: https://lore.kernel.org/netdev/20250111024742.3680902-1-kuba@kernel.org/
> 
> I'm going to make netif_queue_set_napi() take netdev->lock, and remove
> the rtnl_lock requirement ~this week. If we need conditional locking
> perhaps we're better off waiting?

That seems reasonable to me and I can wait.

Please CC me on that series so I can take a look and I'll adjust the
v2 of this series to avoid the locking once your series is merged.

Thanks!

