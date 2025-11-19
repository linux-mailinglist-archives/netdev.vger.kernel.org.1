Return-Path: <netdev+bounces-239852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4546AC6D163
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C03644ECDB7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F731B814;
	Wed, 19 Nov 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2kR5lpw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFWIEs5y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CA31A57F
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537017; cv=none; b=MazW11RsZMoBWmPV7TesEVoaxEI15d9WiLDIMK/2kMdwJNxrWqurvp1OamClG1gPVykq74xIPW1z90fRNfk7Nqhh2w/Y/sXrSlTiz2UwsURFzPhAQKihgsIJKauBT5UctnR3Ylhbn45LK73W92f9IARy1AHmxVB6oRUcDUnzge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537017; c=relaxed/simple;
	bh=UeoKVaThpoIS0BmQUgkdNS7le0YO6IkTWg/xw+UNc34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H54LdqLhCudEN/GfKJDBwktyUbLFk4QK6tPhfmplGWODeiOrYg6nh2Awwun4GZ8G2GgGPQw7f8BKj2NFZmUj16ZDk7VrhmRrCZByx/ucdUbO9QM/l4Bn8CZ0I+bs9Ri36slgVFqta13CVGwWSw3D9Kq48MZF4hGPNAdraOySHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2kR5lpw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFWIEs5y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763537014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=23htjdzLd7CrFgq1C+mI1+9hYzAjOf3Xisff2Ra8ZMM=;
	b=b2kR5lpwAClqoHIEvkEBPbCZIzxIM8dW+Ctn07XeJcIhZt+2Ll1YgjI+IRACl+6SgqN5Df
	ozT1dbIpHy1GCe7kGwRe/zyaMJh0FjGnh1FVMgOyWezehwDUc8VhuyvBUCCkN+woOxb3MB
	hqqePgkkuJD9ORGaOnRQkZljXmk6IPM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-2QklqjckPXS-jA2yuFQ9PQ-1; Wed, 19 Nov 2025 02:23:32 -0500
X-MC-Unique: 2QklqjckPXS-jA2yuFQ9PQ-1
X-Mimecast-MFC-AGG-ID: 2QklqjckPXS-jA2yuFQ9PQ_1763537011
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477632ef599so2335195e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763537011; x=1764141811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23htjdzLd7CrFgq1C+mI1+9hYzAjOf3Xisff2Ra8ZMM=;
        b=SFWIEs5yAPYy9qczBxB6Oj7RyG2jaUMWQmX+gLpPs0cPs4VxzlXHuzuGLhSrowWPAA
         /kuAGJf6LCRf657zjSjIxj8xHWFIu6yMX2r8o2GvGvo0ai7R1udrVCKI94KyMDlpx2XK
         DWdolw0+GcNHyRFeFA9ouHyUVsE71dUhHcWjr85ybYy2JbClA64ks9/p1Pnc8cOj7vTT
         3Y9rXT9N2zJKKFZ7ONgS0QUd26HPWI1CxSlF1jyCWZMc0EkANGVgDMqJrxcBuYRaxtqf
         yw+Pq+76h7yfUj2/UtOdUoeYCqP0AvCzCqtK97KOztQQGemwsFFC2BQ+FJDBmj7WLoYt
         sNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537011; x=1764141811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23htjdzLd7CrFgq1C+mI1+9hYzAjOf3Xisff2Ra8ZMM=;
        b=h8G35SJTt3UwuoZSDKHXWQ3MSKO206xLR9bWJalIuReGF5XAC9I3CUbku2yenyy3Mo
         htBb+QJsu2ECTocyRz3PrvAKyq8W4ptnq7euaSeSJVqj1GZctoa/F5yI3cvV2SP9NSV0
         0cA+40PPa7o8cA5Uxo6AvWFHA+2Hu2avKCfXjNdNEJDSbXynIsFX0eiq7p3+d8obXzBW
         88IfKJGGaxe7w2fgPGIRh7/2hrYVxjV6CMcWMvB2tdzdtCtUgEbLLN6jV9CmdPJIpxL8
         sMS173L0jzF7VuB5pS2i/a3JkmAOURH/dl9cRHMQ9IRFWsW8yPV+2j+ZyWUTwJu1FR5f
         F3Ow==
X-Gm-Message-State: AOJu0YwfjoqUM3QNr4agr1aIjpmtXNOqT2kFUuYaD6ipbAlBDKHMLarm
	gRf3ZZNzbQgg6l5FvKNNDC41XQd88Ffwoq2ytI8is+JB3b6HCGqAE8DIaYFtKKSDGzRbYUrIyih
	iKTomEcO2CQHT3j9s5gbPHHBcFNaIR6TWspiN2RryvzQ3pPcVnlvDntZSBA==
X-Gm-Gg: ASbGncs12jBc09oEs7pEag/xXpYx1r2caWc4k3gRPhVyMlErJaKajwkOxvqEyluTMW4
	M1qQfQ1TfZvt8rLuhbuTmJ/qDgERVbRGtFJc4mjNu++7P8xOx69Q9Maou757ZzP4aunYuqE5xZx
	Y+IOwSHw4DqQZ/tZS/VJcr2crqElnZDCli5xkdYlMqDAg+9TijCNa3HdPnWQugRWDQsyvyIi6UV
	TKr7JmyWo6omNNBUGALbXO9iJHyk4Chy1xVcWejrB1P29SLJghDf5FH66/NuvuYB/MQVC/zPxJT
	L2kGEkPoGIYW9oZ7Ai+xzhJsU9lPeON/mPCkQPCfxOsDRmWmoCGfD5Y6HMJ+MUtxsCJX3r8Reo6
	L8JTyvlD4On9PdO+scQHaUSv+UMRwfg==
X-Received: by 2002:a05:600c:4fc5:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-477b18bfd8cmr13534705e9.6.1763537010901;
        Tue, 18 Nov 2025 23:23:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQR3DkjRdizuys9xaYXsd7FSoVfMu1xxaJXLCWb85B3LwKqZ9YyACG2JrVZv0aHRQqlwGMfQ==
X-Received: by 2002:a05:600c:4fc5:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-477b18bfd8cmr13534285e9.6.1763537010412;
        Tue, 18 Nov 2025 23:23:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9741cbfsm34529655e9.6.2025.11.18.23.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:23:29 -0800 (PST)
Date: Wed, 19 Nov 2025 02:23:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119022119-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
 <20251119013423-mutt-send-email-mst@kernel.org>
 <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>

On Wed, Nov 19, 2025 at 01:18:56AM -0600, Dan Jurgens wrote:
> On 11/19/25 12:35 AM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
> >> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
> >>> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> >>>> Classifiers can be used by more than one rule. If there is an existing
> >>>> classifier, use it instead of creating a new one.
> >>
> >>>> +	struct virtnet_classifier *tmp;
> >>>> +	unsigned long i;
> >>>>  	int err;
> >>>>  
> >>>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >>>> +	xa_for_each(&ff->classifiers, i, tmp) {
> >>>> +		if ((*c)->size == tmp->size &&
> >>>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> >>>
> >>> note that classifier has padding bytes.
> >>> comparing these with memcmp is not safe, is it?
> >>
> >> The reserved bytes are set to 0, this is fine.
> > 
> > I mean the compiler padding.  set to 0 where?
> 
> There's no compiler padding in virtio_net_ff_selector. There are
> reserved fields between the count and selector array.

I might be missing something here, but are not the
structures this code compares of the type struct virtnet_classifier
not virtio_net_ff_selector ?

and that one is:

 struct virtnet_classifier {
        size_t size;
+       refcount_t refcount;
        u32 id;
        struct virtio_net_resource_obj_ff_classifier classifier;
 };


which seems to have some padding depending on the architecture.


> > 
> >>>
> >>>
> >>>> +			refcount_inc(&tmp->refcount);
> >>>> +			kfree(*c);
> >>>> +			*c = tmp;
> >>>> +			goto out;
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
> >>>>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
> >>>>  		       GFP_KERNEL);
> >>>>  	if (err)
> >>>
> >>> what kind of locking prevents two threads racing in this code?
> >>
> >> The ethtool calls happen under rtnl_lock.
> >>
> >>>
> >>>
> >>>> @@ -6932,29 +6945,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> >>>>  		      (*c)->size);
> >>>>  	if (err)
> >>>>  		goto err_xarray;
> >>>>  
> >>>> +	refcount_set(&(*c)->refcount, 1);
> >>>
> >>>
> >>> so you insert uninitialized refcount? can't another thread find it
> >>> meanwhile?
> >>
> >> Again, rtnl_lock.
> >>
> >>
> >>>>  
> >>>>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
> >>>>  	if (err) {
> >>>>  		/* destroy_classifier will free the classifier */
> >>>
> >>> will free is no longer correct, is it?
> >>
> >> Clarified the comment.
> >>
> >>>
> >>>> -		destroy_classifier(ff, c->id);
> >>>> +		try_destroy_classifier(ff, c->id);
> >>>>  		goto err_key;
> >>>>  	}
> >>>>  
> >>>> -- 
> >>>> 2.50.1
> >>>
> > 


