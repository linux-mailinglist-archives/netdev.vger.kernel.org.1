Return-Path: <netdev+bounces-160110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042CDA18368
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9835F1882E8F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91D41F7071;
	Tue, 21 Jan 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LfPyl5rg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127081F55FA
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482145; cv=none; b=ueaNHDOp2orq73/KPCG4Dse24PKqTdgqSZpotSVQ9GNaMFzT2YHarQnq/vZAuMcr1WV0dEjZgnmxHw4L1VVXJ+2XJGx7nYt17pNs05cvny3hNuxRslosK/5pKCEz3jCxBozq/oGy8AM3r3LuytDaiLvLF4cWul3Dd1nOsVMpff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482145; c=relaxed/simple;
	bh=8MGMALB53GqE7pr90y8ipkSuziOt45gftdneWPyARRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4ZcvfIYCi/+9zwfXr8FH/fV/oZFy1Sf1WE2QV20NuYGYb8Lgx6trMs4g0yBL2x9EoIrpPsERdQx69mg6P5X6HXqkYoUpfC0/aBcXncMUnEnp2bkrnFwcB0AzH+AU4Gyoff3+cWkX0v4Jo5wy1d6Jja1FbPzqfGJ2woELb0YA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LfPyl5rg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2161eb95317so108126105ad.1
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737482140; x=1738086940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMp+ss6Wwfurnp42doFXEAGvsTfQgZrzB8Da9TV6zaI=;
        b=LfPyl5rgsPvy6zXcO6D4C7EaWDhA3YsYUt5s3PmXTXQNUBvRwT3X6VN5NPePPiTGHJ
         AasTMOxnZ3uhqGgFewGs8aJB2Pog45H924AQ9tCP+SKgxuFzyK8Al7ttkNph7aMgdrE6
         iG4080X6bku/uhVNzbbnUrKRv4hyWQcsrSu44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482140; x=1738086940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMp+ss6Wwfurnp42doFXEAGvsTfQgZrzB8Da9TV6zaI=;
        b=t8aLJyBg91tcijJSHqJJgTeQu/pGHBwPAS2vJzAyprYZ/2FpXe0J6o1JrD4z61JwOx
         H2PU/5VDoVQw10JGW7IFUUHaCeLv8+hw8Txtx4GlpzojlIvNK0YCK2wmvTdPlm7i/A4a
         mZ4GNOa0BNLAbooRh5hJrbgLf8NMKOeLx1VUH0GaaQZbhMvn4+jaVYsB7y4dUHqf5jKJ
         9/n4uDEZQq+ss6Yvd+2WQGHS5y5f0CdBB01+xEEOa0g+T+G4tbyrpE3eK9vIPD5eUOWI
         caL04V7uLd91WyE6X0xjUpoJ32yH5s/05LaEndOj6CUbSGIHl9TMjXT4c0BqsM+6UC1y
         npsg==
X-Forwarded-Encrypted: i=1; AJvYcCU1cKX+ZKwh/goAQU4StDkaqmLkibDBsQmFmFRTGZ+ryjxmB9Qq/lJPJyIRe6AQQ/MNBaYDwnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dIlwogDxO6Ndstpx7U6JlHdwt5n8ywfPt4fPxZ9B17Hy6S6l
	TbxUiywpw0WTrY2m3DIfeFJGvf+MAPG8FZ7bWeUdpooKguGURv3v2pEBheAlWSM=
X-Gm-Gg: ASbGncu9pDyd1XSDkFbuyGfOrlbE6KlQ5NHwlvV0QvRGCuBJKg7CT1JIoDCenvTCQE8
	FRuyryggTbDOuKKHba9VLFrMrpEQRFv1FgD9XmQAQbD/V/u19cLDEkKxLbOpubwgofMkw+lobux
	tqtqqaQBJbD4rsSK8l3otdes2OYikM16L+bH0IhRK1zX8Nc8YaEPL13KWSD2ltCmT3fGTR6nOEI
	+mkR/FE4ABs+SPt8coHjUU3i/SbWmAdBOLjPbaYw4qjFSbAxkXrPP6axxA2SmwzsK8/fh4dtXwp
	l8DtVYPhqHBua0PRk/Ui97W+rys2oLk7qabk
X-Google-Smtp-Source: AGHT+IEBgJwx8lqhufWVr68uCZoTqch8S1RN/wzFz2PZOPH5Pq/W0Y7Zk8vLb/9NhhAf19hQTQLs0A==
X-Received: by 2002:a05:6a21:4a4b:b0:1e0:c3bf:7909 with SMTP id adf61e73a8af0-1eb215ec91amr27186626637.41.1737482140313;
        Tue, 21 Jan 2025 09:55:40 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f0693sm9466532b3a.10.2025.01.21.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:55:39 -0800 (PST)
Date: Tue, 21 Jan 2025 09:55:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, gerhard@engleder-embedded.com,
	leiyang@redhat.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Message-ID: <Z4_fmIsLgs3nWvOm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	netdev@vger.kernel.org
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtaaScVM8iuHP7oGBhwCAvcjQstmNoedc5UTtkEMLRDow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtaaScVM8iuHP7oGBhwCAvcjQstmNoedc5UTtkEMLRDow@mail.gmail.com>

On Mon, Jan 20, 2025 at 09:58:13AM +0800, Jason Wang wrote:
> On Thu, Jan 16, 2025 at 3:57 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
> > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > can be accessed by user apps.
> > >
> > > $ ethtool -i ens4 | grep driver
> > > driver: virtio_net
> > >
> > > $ sudo ethtool -L ens4 combined 4
> > >
> > > $ ./tools/net/ynl/pyynl/cli.py \
> > >        --spec Documentation/netlink/specs/netdev.yaml \
> > >        --dump queue-get --json='{"ifindex": 2}'
> > > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> > >  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> > >  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> > >  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> > >  {'id': 0, 'ifindex': 2, 'type': 'tx'},
> > >  {'id': 1, 'ifindex': 2, 'type': 'tx'},
> > >  {'id': 2, 'ifindex': 2, 'type': 'tx'},
> > >  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> > >
> > > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > > the lack of 'napi-id' in the above output is expected.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  v2:
> > >    - Eliminate RTNL code paths using the API Jakub introduced in patch 1
> > >      of this v2.
> > >    - Added virtnet_napi_disable to reduce code duplication as
> > >      suggested by Jason Wang.
> > >
> > >  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> > >  1 file changed, 29 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index cff18c66b54a..c6fda756dd07 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> > >       local_bh_enable();
> > >  }
> > >
> > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > +static void virtnet_napi_enable(struct virtqueue *vq,
> > > +                             struct napi_struct *napi)
> > >  {
> > > +     struct virtnet_info *vi = vq->vdev->priv;
> > > +     int q = vq2rxq(vq);
> > > +     u16 curr_qs;
> > > +
> > >       virtnet_napi_do_enable(vq, napi);
> > > +
> > > +     curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > > +     if (!vi->xdp_enabled || q < curr_qs)
> > > +             netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
> >
> > So what case the check of xdp_enabled is for?
> 
> +1 and I think the XDP related checks should be done by the caller not here.

Based on the reply further down in the thread, it seems that these
queues should be mapped regardless of whether an XDP program is
attached or not, IIUC.

Feel free to reply there, if you disagree/have comments.

> >
> > And I think we should merge this to last commit.
> >
> > Thanks.
> >
> 
> Thanks

FWIW, I don't plan to merge the commits, due to the reason mentioned
further down in the thread.

Thanks.

