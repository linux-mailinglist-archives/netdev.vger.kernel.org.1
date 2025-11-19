Return-Path: <netdev+bounces-239980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E532C6E990
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E24F92E95C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953F35C185;
	Wed, 19 Nov 2025 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyBNZwEk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7C/e5Ox"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8C354AF1
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556543; cv=none; b=bK0ba6L25QfbUa8TLD9q8lDBMululp//apE8WDZtetqC0+BqW1JhGpFIrllPMQaiA3Js0QxwzWVe9vkrrJLbXQ5sbh3VD5ujiBL9o30QbMIye1QiJ+mqkK3LEfw5/44UesFJ9tlZgH2XZsjpA2gUegJflXoRfnCn2cMFbUbNafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556543; c=relaxed/simple;
	bh=UZNBewuvwkPWj+bu4O3n8vX8SbsHsZYXgD064ZW+wME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWj9lf9qcXSt0cE1xfvh+wN+hC4r1bTLp+o0imjCg/LsKFgBkW9q/AaaGTPSxfnridlpmaF7E4MiJxQa1InEiwsQpEydOF5FkUZ2OBASQ0DkEJDSZpuXVvxyUUokwkvGBK84unH/ubdpHG6nRRyfpBZSLjqQAzxd83drZ8azqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyBNZwEk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7C/e5Ox; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763556540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efzFAXa6AqvKlr68xmTUgqr7OrHhr6l1HfrVAauk7zk=;
	b=XyBNZwEk4nm5xu8Yv7jWIJ/bNwmTNI3iLJ5GtfGLmr3CQ1uu36W5hfNm/vUytmf2Rj/3RQ
	/F8MMMGYrS6Tr4PtgsIqo8fc1QpsNBJSNeEt8Mu+TZ/6nAyxarHPA7tY+KK8e489BYw+by
	vEvuO8js/hzEO7r8ZtWVWo3kNUEwheU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-ZMhEo3FQMUuC8guTeysVCQ-1; Wed, 19 Nov 2025 07:48:59 -0500
X-MC-Unique: ZMhEo3FQMUuC8guTeysVCQ-1
X-Mimecast-MFC-AGG-ID: ZMhEo3FQMUuC8guTeysVCQ_1763556538
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso40958505e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 04:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763556538; x=1764161338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=efzFAXa6AqvKlr68xmTUgqr7OrHhr6l1HfrVAauk7zk=;
        b=C7C/e5OxFboNzS8m1t5dKea5dZs0Nqemx5VNAyS4V2udOfYctUTj2De0vzprMRklfA
         n3w1Mgd3TzD+NnHKap47yfCXshuADswNZhBjdS5qSODybS5FAOpg6k9f31+v9Mog2g9A
         YHqc3dmZuEZ0SSZocHliCffdTUluxvJ+/3rHUi6olkh/k4BhILq29ruCCEphYB4ChMtz
         ftlIA1IXwMgRJoIWAWH8U6pK8wcgkcZGxdr2uZfmWFIs/zfWGAWckGcvF5U1dYqmLryG
         UQoarNVJZbwkOtckDW5yHCMhPJXb9OCo1yUfjTj3TvrtncLybSNM9tNlI4NdGpBUnSjD
         +OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556538; x=1764161338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efzFAXa6AqvKlr68xmTUgqr7OrHhr6l1HfrVAauk7zk=;
        b=oua3u8rKvXP+SUT3U0hz2r7yvyoo4bz7CIkTE2hC2AwYeFahHujz8UN6pOkoGA8nIL
         KwFtk4/zqS8AAWr5Xp5yx0S8pm+D6uuZQlUHYaVjbgZOmzD0lbMS+rH3AhNET03miY9E
         cQ+UFJHogpzZbG5+Hqy8fUNlaVYItJ1iQbeNkoLeeCnqFOTH+XP9Utv2elij/D8N+TBk
         Kkw/c+bkEK8l9bT9Klk/e2OOYrcemJ5lsYFRP+DafK49SCiRazB/CoZJ9Sz9YJECBEqY
         mkW5X4vQmi2G0iXIaLmgNkAEzvYJm2NAQaJ17h5SWOGVSWWf+YZNu+odphS75YZKq1PE
         y9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVMd7hB5zMtMKMALu0C7TGYeO+37nvd0wIHfvapgLA8Vzj5/jgmA1zU4AcXc0gcudfthOFuc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkXFyu5cIJDxw4KWy20u7oBgg3GLQhSo0BnjwtW091SuDekJn
	dgE4lxA+SXqsbr5awVUyGKuXCrtOZJmLt5xplC9dzJpu7RHsT/CSIHDHNqBrFk2vMiqOCZNaqdU
	sOCsfauOq1Kn0jtk/RpLRc0SZ6AXmIU+eKCyDqrQcyQucnPnxEU8H0ztLvQ==
X-Gm-Gg: ASbGncsBj0JRXhvgdhdGZb0EtQhbGUwg2CFV8f62ZDbi11UKISDSC9K2D+umGJuOqq9
	xi6PUUBPOhXtVtaWvv0Dts5eUZYvM6RcFsPmd32U6/wAInYSf2+Ua/cSYaWmBSVfxeeHimac6oP
	EwkNFz8UMMebAuu00fzcNSDECRhSzJFAu8NMJAbuYMp0f1hNHMFGgYzX/RL3egttRSMUGcz5xdc
	jnxZr1UQCkrJwvgys/WjDmV1hIkHEhSISmTTz28VOZaQCaKYbJGmuEWloUHczM3Vmg9ZJ+VBgNJ
	7VkyODuyv2OF4rU3c4AJr87NIcAwZyp873tOucsqEHBvbHvVoxwCC+TW0Gx1Ynlwz2M4PC+P3Ap
	UEu21Lpg3qHOUAK4EY/cxaAOkTEvEuw==
X-Received: by 2002:a05:600c:45c4:b0:477:7658:572a with SMTP id 5b1f17b1804b1-4778fea84d9mr173008215e9.20.1763556537874;
        Wed, 19 Nov 2025 04:48:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3vS0uApFcgFVlL2gt/R9GTQH3kJDQoD3RSC3xgY4lk5mLnK8+RM+7y+ofmIidRok8jpEiHw==
X-Received: by 2002:a05:600c:45c4:b0:477:7658:572a with SMTP id 5b1f17b1804b1-4778fea84d9mr173007825e9.20.1763556537409;
        Wed, 19 Nov 2025 04:48:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e19875sm38753245e9.16.2025.11.19.04.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:48:56 -0800 (PST)
Date: Wed, 19 Nov 2025 07:48:53 -0500
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
Message-ID: <20251119074746-mutt-send-email-mst@kernel.org>
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


Oh this is really nice.
I did exactly this and the diff is smaller while the compiler
was smart enough to figure it out and the generated code is the same.

Thanks!


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
> 
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
> `VHOST_TEST_FEATURES` to `VHOST_FEATURES`, the following two chunks
> should not be needed.
> 
> Thanks,
> 
> Paolo


