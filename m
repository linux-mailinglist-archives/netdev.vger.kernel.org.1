Return-Path: <netdev+bounces-158950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77534A13EE0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F5160293
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776D22CA10;
	Thu, 16 Jan 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="x9pgjSWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE522C356
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043781; cv=none; b=KErCjFVoLPsUPDtLz66GC8BiG+v2kb5jg42KH93vGCPa+fh0qcCEqqRHSQJZLL2JT9MYY+BvmTKDeV5N91fqZl2qPqTmUP8IGuwX26HTd1wQmdo/nSuVJf8t+0B88d/TsMY9MeLiBr2bdjsFX3bbK4T44kFdJ/FmgZJRKkduB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043781; c=relaxed/simple;
	bh=6r93PtDxADKddNEKMIl2n1KK6HOXUzLNWsnmppK99mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9KoH2VpALBzugW7ENiuf5BBAEvH8T0q4wH0rOvwKoWWtZbNkr7SUqijAEGeRrnlwwSLnSEXcMIfHQVPmKR/R6S4dgew1Od5Ncz9IKDp4EpQJ5aXDzEdjTECYeWc6liwEVTyjc8MKZydLK5zKzX6UvG/3OkPf9wdew3blSm/Gwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=x9pgjSWt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2166f1e589cso26351315ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737043779; x=1737648579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3SvrDu0caDhzdAVkyBr9gYgBKDDR95aZo/K9YBI7/c=;
        b=x9pgjSWtwjVgsSC5qNmd77leknDz5rcQwbOWq1is71mOu02i6F/J54+wskLicLYhuF
         63dTvt5WXJN/HIxlANSI0mU2OHK2XkLOU84qeEw8mKr0faX1z5bjMwSdLK+uA/y64Wb1
         8utc+gb9dO/7YBxIe5AbO2a9/uADojuC/BX4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737043779; x=1737648579;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3SvrDu0caDhzdAVkyBr9gYgBKDDR95aZo/K9YBI7/c=;
        b=w3LOarQ+e+NSOFJsyQ/mun+UbMM/xvwJXOB0YQeWCNB/uPm6Kqfp3JskHt8OLyWJ9I
         YnqAHysdYrcH1GUq62Vs9PjvNRZyyvN8wkejyzNPDZxj4gKFpl5c8q7ZerQytItnjC0T
         6CKmmE7HPOLZG2EZv58VyahOtY0RbxHs0OjlsnFmEoLM00W4sQKUzs2UiG7eAJgLpavy
         f/zxEnFhtAQXOzk4+vCPu9XSVRJ1JLdFNTV0CwAoSIHzADOSPu7G64lWj6qYo06CXhNP
         XDAx4ttUfZ+CFtzg5cP+cpsgjPKeitkaq484t+apw48l+qO2kMRdPDT7Bhq4ESX1Wy17
         fxrg==
X-Forwarded-Encrypted: i=1; AJvYcCW/CZ/MfybC3B2Incai6rmZ/+EKK42NABcL1FTGpT3Cq29yIhIFPrtt+8IkoOZD1JqDWfbCbMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYfTisTTlbiJj4VRBEUZZsGGaJQVvFvG2OYBABnkoj1BvUOvdm
	bEpoFeKS5qkykGF2AZugdo0Iu89UI6e1dXp7xmFtZXPrSDpLjGyxC7xx6ZR1aFg=
X-Gm-Gg: ASbGnctESJiUGdGUIDHouEFp7pEdtK8mxpBcZkPzLfDBGIiTvHmBr/Gpl4hXYHI0Oja
	XH+CjTwucqF2HXUq7kJIwpVwPXFTC4Zx2oHuzwqJzNCgUPUDxFohhglcOE6nT1Zqe/vr28Xcdb8
	LSir0BHY/yaK6CgB1iOHSLxlaslLnjKoD7umbWwOl0nh5siy+80eIJ1yUoWdGfqt/Ecg0dTp9mG
	WwFjMLmUC1YrAPXDem6oTY+wWbksdDbFyJz8ehhlrzyF7L01nNnBxRZqaQZUMr/vms=
X-Google-Smtp-Source: AGHT+IFXQCdp082WWpGcpuSjSz2khkKE+kq+/Zwi6NgiDuGp4et1L72GBvo6pH6pxi/Ft6I0r1EIJg==
X-Received: by 2002:a17:902:c408:b0:21a:8839:4f4d with SMTP id d9443c01a7336-21a88395835mr395241215ad.6.1737043779271;
        Thu, 16 Jan 2025 08:09:39 -0800 (PST)
Received: from LQ3V64L9R2 ([65.133.87.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd02b954sm221289a12.52.2025.01.16.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:09:38 -0800 (PST)
Date: Thu, 16 Jan 2025 08:09:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: gerhard@engleder-embedded.com, jasowang@redhat.com, leiyang@redhat.com,
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
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Message-ID: <Z4kvQI8GmmEGrq1F@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
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
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>

On Thu, Jan 16, 2025 at 03:53:14PM +0800, Xuan Zhuo wrote:
> On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
> > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > can be accessed by user apps.
> >
> > $ ethtool -i ens4 | grep driver
> > driver: virtio_net
> >
> > $ sudo ethtool -L ens4 combined 4
> >
> > $ ./tools/net/ynl/pyynl/cli.py \
> >        --spec Documentation/netlink/specs/netdev.yaml \
> >        --dump queue-get --json='{"ifindex": 2}'
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> >
> > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > the lack of 'napi-id' in the above output is expected.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  v2:
> >    - Eliminate RTNL code paths using the API Jakub introduced in patch 1
> >      of this v2.
> >    - Added virtnet_napi_disable to reduce code duplication as
> >      suggested by Jason Wang.
> >
> >  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cff18c66b54a..c6fda756dd07 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> >  	local_bh_enable();
> >  }
> >
> > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > +static void virtnet_napi_enable(struct virtqueue *vq,
> > +				struct napi_struct *napi)
> >  {
> > +	struct virtnet_info *vi = vq->vdev->priv;
> > +	int q = vq2rxq(vq);
> > +	u16 curr_qs;
> > +
> >  	virtnet_napi_do_enable(vq, napi);
> > +
> > +	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > +	if (!vi->xdp_enabled || q < curr_qs)
> > +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
> 
> So what case the check of xdp_enabled is for?

Based on a previous discussion [1], the NAPIs should not be linked
for in-kernel XDP, but they _should_ be linked for XSK.

I could certainly have misread the virtio_net code (please let me
know if I've gotten it wrong, I'm not an expert), but the three
cases I have in mind are:

  - vi->xdp_enabled = false, which happens when no XDP is being
    used, so the queue number will be < vi->curr_queue_pairs.

  - vi->xdp_enabled = false, which I believe is what happens in the
    XSK case. In this case, the NAPI is linked.

  - vi->xdp_enabled = true, which I believe only happens for
    in-kernel XDP - but not XSK - and in this case, the NAPI should
    NOT be linked.

Thank you for your review and questions about this, I definitely
want to make sure I've gotten it right :)

> And I think we should merge this to last commit.

I kept them separate for two reasons:
  1. Easier to review :)
  2. If a bug were to appear, it'll be easier to bisect the code to
     determine if the bug is being caused either from linking the
     queues to NAPIs or from adding support for persistent NAPI
     config parameters.

Having the two features separated makes it easier to understand and
fix, as there have been minor bugs in other drivers with NAPI config
[2].

[1]: https://lore.kernel.org/netdev/20250113135609.13883897@kernel.org/
[2]: https://lore.kernel.org/lkml/38d019dd-b876-4fc1-ba7e-f1eb85ad7360@nvidia.com/

