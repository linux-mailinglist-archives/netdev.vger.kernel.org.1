Return-Path: <netdev+bounces-160111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73380A18396
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D653A3C2E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F311F76C7;
	Tue, 21 Jan 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vMQpIwLi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24451F76BC
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482239; cv=none; b=MJqQIkXyuEU/vskYIE/5c5MRFOJfz2vwm7gR08TIqbQadlWKCpm5zHibLhKslX25arSVaYbobp6e7FBF7HefZke5aFN4uC2P/wt1KL2t3NKyAmaxQJ5V/BS1ij2MUY7ed2wEqaRVhK0AU3VgmlVVc8IJHp8JS6yAdBUrDL/xbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482239; c=relaxed/simple;
	bh=XSfquQqmKI2Gaj0dXpHAa/dbcT2l9u6zX+xrg1/pkZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9hsxBPj29JTFBmw8s+ajrNkkpqh63hCwotwijbKVnLn0oMuljruSFGq963fRvN0/MKfaS5P8KntFkp6TwH1rb6PYkkbljUTED01/8hr+d1q5TlK0j1mhheRPy5NxHQTbV0OV18eUyM5KwmNU/2gCXOaXeAjDyDcTDpDH6gHPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vMQpIwLi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so8070231a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 09:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737482237; x=1738087037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loeQ6r/We5SeCLLC6MzCpKw48tXiOliWFpYbk3PaSbk=;
        b=vMQpIwLic2YnOEti6++8MbNJMSeTdC7tnIySXSk/Q0nTwDZzUpzWM33SuObGd+p9on
         PK7cgg5K0/JGeAQwx0RuDUiYe2M9QzEPlW28PJFpwLIcXan7ufBXVmt3n0lIZI/vvotp
         JvYHGmQMP33O3ll0NQY9vg5jq87hjA7Qto2GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482237; x=1738087037;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loeQ6r/We5SeCLLC6MzCpKw48tXiOliWFpYbk3PaSbk=;
        b=vJGJc2sDeRUeohZkKO2gSZQ4ZF4eaOnisrZSYMLO96eSL2o4VA9anvFoeZSRv9JuJs
         QdjbkO98gfRFzcyvD11l0H84yGdlL43tTipY+BBKGjmkL7lHf+bxMVpfPgoK7+2zwXvs
         2w1h23L+IGXeRLLv/lL6epoB5RtVQSTuUpQw476PmCJgtFrtgl/kWagCMefqYwkom1+9
         M4G1rKZdWnx3OL2YwgjibDnNPcrY4oPGfRJHWcVBA5e9UCTHn43jzlJhivGrhv+PDpgA
         PvnIRtUTHJXdPEi5G3SgeMdbVkE81kR65rm3wQTgvIqKBLgSW5kjAkJsAAr57Wy65QX8
         PRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjxsE5dNkjIjaWyos92sHGD6uzRG2ltZiuJJLR3EwrvMJyn5OKXf0M4IucuRzG5fFEIIbEQM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVjZUTID1GYHLXdh96RAjO6FJ8jgI/Tcl4GFfkDU+GErD52W6
	e3xgSxLSwWoZbNtG4od+tEBRuYMZvRNYp8n6fYmvnWXQx9hIvxAWyOau0nQokpk=
X-Gm-Gg: ASbGncsHioAP9nyELaGOtLlFk8+jlUldXF4apZ4vDUvIKTuYkET5uGQJ2iUCYD8bYjn
	qOqTG2Q8HaUw6FszedNp98rjfIIFpBIaV3bcd0YShepGvUWk6BB9x3MIR4tK4eoIjRxoXrSsTHU
	ZyuUVaC6C8f4gv90ac8h9GEaDFt4TJjhUWNgMTYYoia5COITBA8q/rVY5VPLx+2X+xSYdlTuLnu
	Pqay/i1Q2VlYX7+R8VVq+sM3tCp5QRNV91T7IXSp6Re/kXyLMKxIBjtpiwh6eeL+RJlgCTS5TB5
	eMoyzN5t3v0x+D6E8/3MNiE/pENB9m4Yg2Lc
X-Google-Smtp-Source: AGHT+IF8nTdSqJGUknuS2lb7RP37aOhCWFkCHgx+4XdAmYkt2v6vsufE7wyH2eVz6huRJPSOUWyXXA==
X-Received: by 2002:a05:6a00:a0c:b0:726:41e:b321 with SMTP id d2e1a72fcca58-72dafbdacadmr27151527b3a.21.1737482237014;
        Tue, 21 Jan 2025 09:57:17 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8e89sm9472195b3a.109.2025.01.21.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:57:16 -0800 (PST)
Date: Tue, 21 Jan 2025 09:57:12 -0800
From: Joe Damato <jdamato@fastly.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	jasowang@redhat.com, leiyang@redhat.com, mkarsten@uwaterloo.ca,
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
	open list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Message-ID: <Z4_f-PNEdmBaMkhP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	jasowang@redhat.com, leiyang@redhat.com, mkarsten@uwaterloo.ca,
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
	open list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
 <Z4kvQI8GmmEGrq1F@LQ3V64L9R2>
 <f8fe5618-af94-4f5b-8dbc-e8cae744aedf@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8fe5618-af94-4f5b-8dbc-e8cae744aedf@engleder-embedded.com>

On Thu, Jan 16, 2025 at 09:28:07PM +0100, Gerhard Engleder wrote:
> On 16.01.25 17:09, Joe Damato wrote:
> > On Thu, Jan 16, 2025 at 03:53:14PM +0800, Xuan Zhuo wrote:
> > > On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
> > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > > can be accessed by user apps.
> > > > 
> > > > $ ethtool -i ens4 | grep driver
> > > > driver: virtio_net
> > > > 
> > > > $ sudo ethtool -L ens4 combined 4
> > > > 
> > > > $ ./tools/net/ynl/pyynl/cli.py \
> > > >         --spec Documentation/netlink/specs/netdev.yaml \
> > > >         --dump queue-get --json='{"ifindex": 2}'
> > > > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> > > >   {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> > > >   {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> > > >   {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> > > >   {'id': 0, 'ifindex': 2, 'type': 'tx'},
> > > >   {'id': 1, 'ifindex': 2, 'type': 'tx'},
> > > >   {'id': 2, 'ifindex': 2, 'type': 'tx'},
> > > >   {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> > > > 
> > > > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > > > the lack of 'napi-id' in the above output is expected.
> > > > 
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > ---
> > > >   v2:
> > > >     - Eliminate RTNL code paths using the API Jakub introduced in patch 1
> > > >       of this v2.
> > > >     - Added virtnet_napi_disable to reduce code duplication as
> > > >       suggested by Jason Wang.
> > > > 
> > > >   drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> > > >   1 file changed, 29 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index cff18c66b54a..c6fda756dd07 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > >   	local_bh_enable();
> > > >   }
> > > > 
> > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > > +static void virtnet_napi_enable(struct virtqueue *vq,
> > > > +				struct napi_struct *napi)
> > > >   {
> > > > +	struct virtnet_info *vi = vq->vdev->priv;
> > > > +	int q = vq2rxq(vq);
> > > > +	u16 curr_qs;
> > > > +
> > > >   	virtnet_napi_do_enable(vq, napi);
> > > > +
> > > > +	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > > > +	if (!vi->xdp_enabled || q < curr_qs)
> > > > +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
> > > 
> > > So what case the check of xdp_enabled is for?
> > 
> > Based on a previous discussion [1], the NAPIs should not be linked
> > for in-kernel XDP, but they _should_ be linked for XSK.
> > 
> > I could certainly have misread the virtio_net code (please let me
> > know if I've gotten it wrong, I'm not an expert), but the three
> > cases I have in mind are:
> > 
> >    - vi->xdp_enabled = false, which happens when no XDP is being
> >      used, so the queue number will be < vi->curr_queue_pairs.
> > 
> >    - vi->xdp_enabled = false, which I believe is what happens in the
> >      XSK case. In this case, the NAPI is linked.
> > 
> >    - vi->xdp_enabled = true, which I believe only happens for
> >      in-kernel XDP - but not XSK - and in this case, the NAPI should
> >      NOT be linked.
> 
> My interpretation based on [1] is that an in-kernel XDP Tx queue is a
> queue that is only used if XDP is attached and is not visible to
> userspace. The in-kernel XDP Tx queue is used to not load stack Tx
> queues with XDP packets. IIRC fbnic has additional queues only for
> XDP Tx. So for stack RX queues I would always link napi, no matter if
> XDP is attached or not. I think most driver do not have in-kernel XDP
> Tx queues. But I'm also not an expert.

I think you are probably right, so I'll send an RFC (since net-next
is now closed) with a change as you've suggested after I test it.

In this case, it'll be simply removing the if statement altogether
and mapping the NAPIs to queues.

