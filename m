Return-Path: <netdev+bounces-239836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A44C6CF41
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 784AD4E2BFD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41FD314A6F;
	Wed, 19 Nov 2025 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dADm7Pga";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t2QSA986"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7E31159C
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534131; cv=none; b=QCMYVkcAGfUaeHxKpHK3tvEwe6lfH6sCrgFMHou05yl+Mff1qOQcuLzx17tIPDw5AIIsxQwWpsvy6ELu7ounwoCmjaQo5SrOPiRpqWVg5uJrfR5MbIkDT9397CaiZ7qIRaJs7kO0mA7V1ZpImQfj3Pe+MTRrO8eKjCREUk37HLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534131; c=relaxed/simple;
	bh=+oVkQPTDHbvSsq1poNKexqrG7BwcA2w2R129KKd8llI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7Ld+1QcTCRSwD3o6tCJSaWQXhX2XV+Fvt4CawJZCCB4sQnP9s8OC3X9MfoWrtfVb14teiH7OYliVVWTShfcFmm4s0zpeC5R0aZJpwiHPtvfuem6FxAvWzFiQKWDZfPt2KUW2YckBpfUtkURsWgKAR3ngksgeyNioSaz5/iEZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dADm7Pga; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t2QSA986; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763534129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ueGpvfIJmvL+t0ATYLIghMNkOHkFd1Xmr1KQZsIHm5s=;
	b=dADm7Pgat/lfMeFsfyx/9DhXq7AJyZskXpDL7CeQK31Eh8KgBJW8dHlaPe/Xm/2obDdyWP
	8FFGem6v9r/WIvjvsADQL4f8123MiG8GV7s2YiUXgfp+RhXsmVF1LHL07bUx9wR3EJXwPu
	wPzR9IvUdnU85RyA021ZyhBzbpfAPLk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-j6dtag86Ob20BzWActXezA-1; Wed, 19 Nov 2025 01:35:27 -0500
X-MC-Unique: j6dtag86Ob20BzWActXezA-1
X-Mimecast-MFC-AGG-ID: j6dtag86Ob20BzWActXezA_1763534126
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779c35a66bso25602365e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763534126; x=1764138926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ueGpvfIJmvL+t0ATYLIghMNkOHkFd1Xmr1KQZsIHm5s=;
        b=t2QSA986YmcBOOk+fOnR5JmGLU2ymvSitWdTiHZt6Iggu0OIC/hN8ZVa+2SCPUokGr
         KHwRI3QXANdBHSy9W74ZAMPv9fSlGTcSJqIJkK+c9B0ETAnBFGr8YPClIMz1XenHgwoZ
         H1uMJgb1G4100VWuVaYn9Lg4a18qCPu4w/k9gyvgaghOYmLUVk1aR4SECQnpfcHVPkfc
         aWNYqfmxXoFF0oVafs2wIW5Kbvo+ChbUpgjVdt9inyqI9lg0SfzeMzAOnobN96yjP/eV
         QKPQj96j/ghjkhU7rjprlK3gHJtG/RVYtD7n9btMWq61K+P3WKE3qNIH94YbVjhpoeaH
         ym2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763534126; x=1764138926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueGpvfIJmvL+t0ATYLIghMNkOHkFd1Xmr1KQZsIHm5s=;
        b=Io76wYE3t3gB9Vw3QJRznCawXiSENd7+CyE8mXoXbI5rkvEHBhaRKTypuPcL6N5Fgc
         eOTbiD/P7diO5n72b2pSMBn86Evmv4+Hr6hi0Ew14iSrqx/PYc1Q7WH/5C+iHKMa8da+
         +Fz+UhtzHH+2EN/3uZB82Nj0Uzqo1mXWE/45IA31ZLc6K0ozxLYe7cbQWa7NquAYsTPz
         aZz1+eJFMYvLkwwh0Tvd1oDsjWWLrpkQ98yzzbk5TtbhCVs5SXUzJBjBD3llPF0NcEw2
         nKrxS60qxzQfet+yFviamqVuWyav1ZwfJ4yJT7V+ah6zNbNu8A5U50dvY/J3VSrYdkSu
         QWyg==
X-Gm-Message-State: AOJu0YxoVwe0z51jvFYCjYYCRBMDxgqJZweLs1aVqLSGOeZdX3yhBCq7
	E1YoAhYVDC1tU6je8/vSuKfnqOkQddtIi6AtuPHs3StqBs9MA/K9T79ABl/w71FsKKCmkANqFPC
	T6dKMn6KmlXXmnncR64J5mQhIcP/VGsr+iTSnPD5wldnu8slLs2QHSnlvGQ==
X-Gm-Gg: ASbGncuESsM+98Ip+gxYA65YzNe+OY/YGPP+SHAFFb1M24v7bsgV6yE2QWBs4xavxUI
	r7lFXK3CgrBSIlO9hbpDx9Tlo/xUPIYPmZquY8L4SQsjOUSX/G8CBlj10H1ERCteGn8TXrpxR7D
	+vrLMDZoSlImNy7WDCd8li2Ahg8ExsOwan30h+sHmmcW7ham2kNymVMaf8DsyKWxSbT5Wq7ASMo
	fZ0nVW4r5Xw8qujxO9f21dUNz4/+iO4tm44Ej9HEBNYOxA12TZvUXwckELgums4ftinJIEHtUcZ
	T8Cj7Ua3QpMtW9ymss5ufdvZdDH4jO6tF60+QGWrYWFv7oBEfDw3e50TXz4ebGAzTHKYiMmR+Cs
	vgQy2b/hRmkRt3V1ZqERXiC1bFj9fOw==
X-Received: by 2002:a05:600c:4707:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-4779eb89abfmr113079865e9.8.1763534126080;
        Tue, 18 Nov 2025 22:35:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFAIsJXBhVayBFWWtgtLbt869+S8X6nXeewdbwIoRf0oNDair5E4OaoLGnaQ10CFIl/p4R4w==
X-Received: by 2002:a05:600c:4707:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-4779eb89abfmr113079575e9.8.1763534125670;
        Tue, 18 Nov 2025 22:35:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d21591sm35170495e9.2.2025.11.18.22.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:35:24 -0800 (PST)
Date: Wed, 19 Nov 2025 01:35:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119013423-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>

On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> >> Classifiers can be used by more than one rule. If there is an existing
> >> classifier, use it instead of creating a new one.
> 
> >> +	struct virtnet_classifier *tmp;
> >> +	unsigned long i;
> >>  	int err;
> >>  
> >> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >> +	xa_for_each(&ff->classifiers, i, tmp) {
> >> +		if ((*c)->size == tmp->size &&
> >> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> > 
> > note that classifier has padding bytes.
> > comparing these with memcmp is not safe, is it?
> 
> The reserved bytes are set to 0, this is fine.

I mean the compiler padding.  set to 0 where?

> > 
> > 
> >> +			refcount_inc(&tmp->refcount);
> >> +			kfree(*c);
> >> +			*c = tmp;
> >> +			goto out;
> >> +		}
> >> +	}
> >> +
> >> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
> >>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
> >>  		       GFP_KERNEL);
> >>  	if (err)
> > 
> > what kind of locking prevents two threads racing in this code?
> 
> The ethtool calls happen under rtnl_lock.
> 
> > 
> > 
> >> @@ -6932,29 +6945,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> >>  		      (*c)->size);
> >>  	if (err)
> >>  		goto err_xarray;
> >>  
> >> +	refcount_set(&(*c)->refcount, 1);
> > 
> > 
> > so you insert uninitialized refcount? can't another thread find it
> > meanwhile?
> 
> Again, rtnl_lock.
> 
> 
> >>  
> >>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
> >>  	if (err) {
> >>  		/* destroy_classifier will free the classifier */
> > 
> > will free is no longer correct, is it?
> 
> Clarified the comment.
> 
> > 
> >> -		destroy_classifier(ff, c->id);
> >> +		try_destroy_classifier(ff, c->id);
> >>  		goto err_key;
> >>  	}
> >>  
> >> -- 
> >> 2.50.1
> > 


