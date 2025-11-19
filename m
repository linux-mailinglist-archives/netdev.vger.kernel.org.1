Return-Path: <netdev+bounces-239959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A55C6E8DC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAD5F4FD8AD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D0135BDBB;
	Wed, 19 Nov 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRs/DYzm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpFj9bVR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA932E697
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555707; cv=none; b=RJMxfubue+RLChQ9bRiobK0A5JguzBF8EJwf80NTJ/N9Bl3OGORfQvla+yi1iJfIfZzfPMPX1udRxVmrcJYEJhEyqyXKMP4j0DrM3taX7L8JQGZnYtAQvBDr860RAfa115rlwEUmV0+9syk/VMpRAF9o7xsiqwtrjWBWZmBBuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555707; c=relaxed/simple;
	bh=EPmrUepgE1rgeLfHqD5slhvdiL6tMO9t2cr77eQyKts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB/CiSlO8kuyJzyGhNWgAph3wKHjfvgFO1E/JkYtaJrERMsa/J6yZhE9tQTC5oZid5ox+3BC6417gLwYDMmZ9ybSXE/nonLrE/VqU95VY6U50klJHeDX6Rsx0hvUXVp6NH0oRV8OIHAIqitGsozjAEU9L9NptkttH5XIr1RXIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRs/DYzm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpFj9bVR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763555704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cX3V/Maq1P62aubbfEZMkx/73yOAMpSFaKpbQ5l618w=;
	b=PRs/DYzmakzqK5zZQGM+BoF0Zq69o69LYryDA5dH90NO7zTw7o4r1ernadGKJeIGZ5lH21
	OBboVYCbe8pq9PCDnwBBajjWJgH9SJHV6qlUtDkvJIDe5pdINlwsdc5RC1A1br3DeiHQGT
	YQoCjl9Ipt44e5eHTk8w7xnbwFuRmzA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-VfchgfboM4m3Szi6b8oPMQ-1; Wed, 19 Nov 2025 07:35:02 -0500
X-MC-Unique: VfchgfboM4m3Szi6b8oPMQ-1
X-Mimecast-MFC-AGG-ID: VfchgfboM4m3Szi6b8oPMQ_1763555702
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso5267025f8f.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 04:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763555701; x=1764160501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cX3V/Maq1P62aubbfEZMkx/73yOAMpSFaKpbQ5l618w=;
        b=OpFj9bVR2mnYp80kl8qp0X6YeSVRM2dAHTCcC1DsYOSQ2eyerDU+3vcQ5IjDq7wyup
         hUTOfNO8BCEusKNg5gqh4iopxldMu1KqiboKz89gT0luKEOfn6odTAMAjlXbhXqZS3RO
         pK0neFXyiZ/MUOhi0CPj5KMl+LZ10VfX4oayFir4/a3gOXd7eHB7QZlsRKhlPMcpGBXE
         UVMYUHIUZVH844kPNz+mZOXVk+ARphTnI+ISsnIQm4O7Jsdc8afWCElJWhLOhjBP3gPy
         NYko7Ezka0T/FTcjMqB+D+BRI50On2hFvn3quwTx/7rirQo2IoCzmJ+sekm+rm2GDaVB
         xiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555701; x=1764160501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cX3V/Maq1P62aubbfEZMkx/73yOAMpSFaKpbQ5l618w=;
        b=GaCdjxsN1PTVLhCVdKgJy5Ot8X9EEsISpHeWrcc4yLHOU+8ivChQActlPhySI5sejB
         apftTSkWF+/hPjapMvRy9DufIYCpZgaDVmYl5rqcz6+p9ZERm4w49KeCtQ+Tvir86Avj
         dxfCvlVbeAXxQYehnoauwShOv3a3qgLUTP7G4Tez2ZiwsKdZL18lKrBlpiaLNucXFTEp
         XI9qv5wzi7q64t1sBom1HuLuAEUVlQ3ZHdsau5Jc7JrvbCtkahU+DLKA48BzSxKr7RzR
         5fhq8vMunCf3qOdxeRGjAz8uZvr5roo2GAawTolpDLwKrqDw1jGobGu39umQJwmmdMAs
         F95w==
X-Forwarded-Encrypted: i=1; AJvYcCX4+GOmGhGi1aeGudvXUVypCDGOv3zWrTBrG2eug5N7MfZh5LDBHpe6vU8dbGSLE+apA4mKEko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Oc++JdWjNeyrZRLP0T8WGjWme3mRHMwJmeUSdjyemwHZcmmj
	rd9+VLe6aUyprWGR8mKlqC4ebfgxq5X8JF5HdQwKWU96MHbv2L55ywANDgk5wA4it4bZ/1XKW4f
	gwySfKfEuK+7JMr4po/JfSgVOO9uw8rlyc8uTlI5RuAJvZo8UEoLBG+3zzg==
X-Gm-Gg: ASbGnctmZcCvBDF96dsuFsdsVljdJD6xQpCLEak5VoaBWMyc6E5B/qdgM3vItrLo+/Y
	+0N9SsS47KCDFq/9+r3AkD59EqluoQC6liRIwRcTbB1e5cVvte48BOH1k+DkH8w/dAi+Br2a50v
	Cbpqi6ic9AdcQltHgwLyz2O0XlGX1DUoe7eJxXZuUT5+EASNZ31gC/2wTn53Ds9pJzlYKJrtb0a
	hBKIwm7GclGdueiJa2h0cR9TobqmmnNUzzueawObsMqrKuKnZ2+FiwRdOzL3nkcW5US3tcw9bq0
	17B4Fqxvs7Idpnmp7w7R6wsOF3iR+3cuaTe9XaiALHlzy8qkyLwroWOGcnhScxtpVFn/KrU+kHw
	gOq8024xfX/3muX2/Dp9m9f563BH+GA==
X-Received: by 2002:a05:6000:2c05:b0:42b:4177:7135 with SMTP id ffacd0b85a97d-42b593721efmr18718640f8f.41.1763555701517;
        Wed, 19 Nov 2025 04:35:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZDtCaU9W4jbuIEbB8KCRjqHZi966/jHceca8fTLxnbGRC0wWJ1uQzXqWj/dl06f43gIEXkg==
X-Received: by 2002:a05:6000:2c05:b0:42b:4177:7135 with SMTP id ffacd0b85a97d-42b593721efmr18718600f8f.41.1763555701078;
        Wed, 19 Nov 2025 04:35:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f174afsm36933997f8f.33.2025.11.19.04.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:35:00 -0800 (PST)
Date: Wed, 19 Nov 2025 07:34:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v5 2/2] vhost: switch to arrays of feature bits
Message-ID: <20251119073155-mutt-send-email-mst@kernel.org>
References: <cover.1763535083.git.mst@redhat.com>
 <fbf51913a243558ddfee96d129d37d570fa23946.1763535083.git.mst@redhat.com>
 <4204ed4b-0da1-407f-84e0-e23e2ce65fc7@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4204ed4b-0da1-407f-84e0-e23e2ce65fc7@redhat.com>

On Wed, Nov 19, 2025 at 12:04:12PM +0100, Paolo Abeni wrote:
> On 11/19/25 7:55 AM, Michael S. Tsirkin wrote:
> > @@ -1720,6 +1720,7 @@ static long vhost_net_set_owner(struct vhost_net *n)
> >  static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
> >  			    unsigned long arg)
> >  {
> > +	const DEFINE_VHOST_FEATURES_ARRAY(features_array, vhost_net_features);
> 
> I'm sorry for the late feedback, I was drowning in other stuff.
> 
> I have just a couple of non blocking suggestions, feel free to ignore.
> 
> I think that if you rename `vhost_net_features` as
> `vhost_net_features_bits` and `features_array` as `vhost_net_features`
> the diffstat could be smaller and possibly clearer.
> 
> >  	u64 all_features[VIRTIO_FEATURES_U64S];
> >  	struct vhost_net *n = f->private_data;
> >  	void __user *argp = (void __user *)arg;
> > @@ -1734,14 +1735,14 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
> >  			return -EFAULT;
> >  		return vhost_net_set_backend(n, backend.index, backend.fd);
> >  	case VHOST_GET_FEATURES:
> > -		features = vhost_net_features[0];
> > +		features = VHOST_FEATURES_U64(vhost_net_features, 0);
> 
> Here and below you could use directly:
> 
> 		features = features_array[0];


Ah. Good point.


> if you apply the rename mentioned above, this chunk and the following 3
> should not be needed.
> 
> [...]> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index 42c955a5b211..af727fccfe40 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -308,6 +308,12 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
> >  	return r;
> >  }
> >  
> > +static const int vhost_test_features[] = {
> > +	VHOST_FEATURES
> > +};
> > +
> > +#define VHOST_TEST_FEATURES VHOST_FEATURES_U64(vhost_test_features, 0)
> 
> If you rename `VHOST_FEATURES` to `VHOST_FEATURES_BITS` and
> `VHOST_TEST_FEATURES` to `VHOST_FEATURES`,

This one I don't want to do, people tend to copy/paste code
and this is not what devices should be doing.

> the following two chunks
> should not be needed.
> 
> Thanks,
> 
> Paolo


