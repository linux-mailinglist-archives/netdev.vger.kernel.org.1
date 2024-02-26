Return-Path: <netdev+bounces-74907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E65867406
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A601F2965D
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C54F5B21C;
	Mon, 26 Feb 2024 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blRy128n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92C5B04F
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948652; cv=none; b=t/mLZN8fKg3YzvR0oTQ8KwUFrF08Hk+cOW977Ug/WTrXcE7Q+RA8NoTBjCWJBZ2SFnhp4e3IhX+gu/J7GdOf+UaSMzjcxHA3EyGdqtFYuuGpS3gniAmfAI6zurQoXeCWDauJ24Pa0Kg99ERT+sH5K+2wTXDQeqCYmVPx5WLOz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948652; c=relaxed/simple;
	bh=Foucft6WlPR2KyfAnFENVyW3MER3G1QZvKQCjZkxl/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD/heZlq6IbzZes0suyKHbCJ/koQZC2XSWLd43+/Y/rxIE9vY8NJVZb5WSecgLWYYn2wVu9TSrT59EuMpPBXXy60OyKMvaBv6fvwBFVFWeUQ9wpXZdfPrwX2Q9U40arqST/sCsoxILbx4kWv8DRDwuyI1gUdm6mAgBxHbP3wrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blRy128n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708948649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwTMNcm/OZxGXy6MTFKOugn5j6dLDR0+J9PuYt4fDWs=;
	b=blRy128nYHLdCZxG4jJoUa2ap2DEJ6w2mvf0PskQEkf6Zw2TlcFEzqM7dP9X1U5OMU7GwK
	ZJnc6kKoSMz5YJTmRmZ3XVoSiMlQyyEWh4xCEYFR1ApoxaN3LzloGzCNfnMFRgT9XXkU4i
	v/WcEsT+KkkxIxB38XQb/bDmLt6d99o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-dioU2XSaNtCmVimiccDvEQ-1; Mon, 26 Feb 2024 06:57:28 -0500
X-MC-Unique: dioU2XSaNtCmVimiccDvEQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e91f9d422so3876085e87.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948646; x=1709553446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwTMNcm/OZxGXy6MTFKOugn5j6dLDR0+J9PuYt4fDWs=;
        b=azexgWDDoE1zYq9l8dqy3mYH85YC4b4e6JlpU3uE5FaZ1TOuafE2mOpFZF5uLThPaw
         5V0XjX3iOdi4WUHtGeG0BmuTWxd+mCgtcmNLk7VSXXFhssUxjA5rLXGcu3rgGAjy12eF
         NKLh7hV5SQLih/083Q9Q9rdFCauNSF/1xOAxu4AWZOD52yQEogpPhiHQrfMVAjCmdb6K
         xCmBZtmUcT13O8zkVfWbbn+EW61M/DNXdAvekPwOaE6L+SCdkqphC2yUVaOGDlkCcyOt
         4yfj9+Bp7GjPZZLf+yWFOK7TiwRJcogpk8duMELqtdTWRNv00eivL20I7yEdm/D5ZXP8
         QkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/YmeJZapXV0ZUwU3Bkt/e3oQxGKq1htbp+/ACIgEkSlEBT1UCDKqLx7sdatr7AwugrzKpw5ymjrMSuJatDD/eqO6ylsGU
X-Gm-Message-State: AOJu0Yz8wj/ViauewX/knaLAXqx6871iuqzH9qjJJV/wsHnb8toywtDf
	2D2TV4YbdYGThWWBJ9F1qNSX5RERSN5rzaBk02iA63OXQaXQB+Y1CyIEFWJjQbK39hvjZUqfLTW
	+qgTWMwrVRGqab8lh4n0wT2yjpLN7Rl5oOSd4cQPZ1e2JIMfibGApZQ==
X-Received: by 2002:a05:6512:2206:b0:512:fbb0:3c55 with SMTP id h6-20020a056512220600b00512fbb03c55mr2652517lfu.17.1708948646537;
        Mon, 26 Feb 2024 03:57:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhlB+sQrxdk/wnezoDvCnQO/+FHCrT1btYEeq6+bycpFpncFqBUrdfh9u7XJ++FrnKpKlBAA==
X-Received: by 2002:a05:6512:2206:b0:512:fbb0:3c55 with SMTP id h6-20020a056512220600b00512fbb03c55mr2652497lfu.17.1708948646157;
        Mon, 26 Feb 2024 03:57:26 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b004128fa77216sm11737552wmz.1.2024.02.26.03.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:57:25 -0800 (PST)
Date: Mon, 26 Feb 2024 06:57:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Message-ID: <20240226065709-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
 <20240226063532-mutt-send-email-mst@kernel.org>
 <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>

On Mon, Feb 26, 2024 at 07:39:09PM +0800, Xuan Zhuo wrote:
> On Mon, 26 Feb 2024 06:36:53 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > > > what is dma_map_direct? can't find it in the tree.
> > >
> > > YES.
> > >
> > >
> > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > index 58db8fd70471..5a8f7a927aa1 100644
> > > --- a/kernel/dma/mapping.c
> > > +++ b/kernel/dma/mapping.c
> > > @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
> > >         return dma_go_direct(dev, *dev->dma_mask, ops);
> > >  }
> > >
> > > +bool dma_is_direct(struct device *dev)
> > > +{
> > > +       if (!dma_map_direct(dev, ops))
> > > +               return false;
> > > +
> > > +       if (is_swiotlb_force_bounce(dev))
> > > +               return false;
> > > +
> > > +       return true;
> > > +}
> > > +EXPORT_SYMBOL(dma_unmap_page_attrs);
> > > +
> > >
> > > Thanks.
> >
> >
> > where is it? linux-next?
> 
> 
> I see it in the vhost branch kernel/dma/mapping.c.
> 
> Maybe you miss it.
> 
> Thanks.
> 

which hash?

> >
> > --
> > MST
> >


