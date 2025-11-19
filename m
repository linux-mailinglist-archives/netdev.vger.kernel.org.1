Return-Path: <netdev+bounces-239857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA32C6D343
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A042034F386
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167E2E228D;
	Wed, 19 Nov 2025 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBpkLD8D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fD8zyC1a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ABE2E1EFD
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538104; cv=none; b=T8VJ3jeqqsmYo28pIQBp8UaTI/HSJ/Lo3erFv2Tx1Sqre82+lCsablR2wJ7ndxvWdua7dL42Ai8LwrXtlRyXkdSo+4yenpQcYmjqg0W129Wgg7/JZcJL+ny6fx7VYmaVYga1/WR570/8+JbcLy3eNv4geQOdyG77u2SiMCI9h4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538104; c=relaxed/simple;
	bh=Rduaa7CN9Qw5BaMjtN4lzqTBc8GdxZg1gPgXNcu1FIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4XIV3qpsfP9hu1/v+2Uo68oLAAv0cBXoRlX3T6v5qdVd0csuvShOPF9VHnOwRFt962nIq1bSylxKpfLb8X2Adidb66WspCjz7p4U3WO3YQp47oQeZlaNXXJ4//qnBcRHXXMRjg5VeDHOoDvZ+6cbfAVXulgYpOs2BoVoJdA3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBpkLD8D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fD8zyC1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNw+TI8JRzSFMPaBmMloxZr+ia2tyTaUh+yioCK5LjQ=;
	b=HBpkLD8DDX3RUZAcQFljwwr8kKadXyF5ZM5646ytRHXPoksoRFdi3hxIzPCLU/ciNGUVc3
	WcxvP/8GtzHLasKGTUDGEJsT9WUhjUJFYE/IYnlTF93bLleaTIi4AsGUC6SbpxTj+KfVan
	U8jcVLO/GOkQy/Iz9ueoUVru+/kK/+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-hmJfiiWHPaGjgbjHNdPuAA-1; Wed, 19 Nov 2025 02:41:39 -0500
X-MC-Unique: hmJfiiWHPaGjgbjHNdPuAA-1
X-Mimecast-MFC-AGG-ID: hmJfiiWHPaGjgbjHNdPuAA_1763538098
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso75999675e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763538098; x=1764142898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNw+TI8JRzSFMPaBmMloxZr+ia2tyTaUh+yioCK5LjQ=;
        b=fD8zyC1aaVu7zxokJKo+g4sOW4x+Am2GuljGeRye43AkvYspcPUynIxM9E54tl2DRR
         w3tn8GylvOUUo9HL8YmlYsJ7aYQs2GhxNzesgsuoOkw08S+ZkhU6I9LZzyJ3H9A/3XFV
         cgAFMB+RKASCCCXTAob6sbcvf2H47KArKExMWhIkQSjTBAmLWKtWFK3VQmzWzSY02Clr
         KjdPXTXiDW5IfJlhyOUkapsmwuo1GigaGX4ySiCDEDpS0ugmZwmclHZJdKt7N9ZsjD6+
         mShKoIwKf9CGrh+ECfQQSbMkEHzGaJes2ZaQvwAON1GXbM/GKuTCgA2km94L4K+d8dG/
         lXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538098; x=1764142898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNw+TI8JRzSFMPaBmMloxZr+ia2tyTaUh+yioCK5LjQ=;
        b=SWeZscHelGw2STrV48vx3NHSIsbbYsOBayPO+IOildbfRltWsum1oH15K7vhXVKzA5
         5tdstdz2KFG5/lPID2j3zQmIXAi6Wxg7b6vDi8f37kS+G1sIfqWd+y4I7y96wmUoB/Vl
         FSzljzwxm7uuHe86ZgCH56284RS/HHyCXkvPGXN6PzdFhElbY/vAd1dRTN6756gCb3j6
         6a/JRkmvN2nw2RtLFoYvUtIwJ0bGl5tb+zT04ko/sXSrqo6Y48jxLKWheLaIx/jhH+i6
         mwev8AmdKSztYLEKtWwe7h3rASfOOJ9MmT0ueNquQFbjocGECinA8iaB4eJmmyQBsgf9
         xXAQ==
X-Gm-Message-State: AOJu0YwjrSuCVt/gmROvQGeRZx5vju1+mAW6pBT5q49Z/eFHAq+DkarF
	WT+aL3d7K4F4DlhHGpMCJow7ae0EbQWNTRY326rrTL9bUU+ZKnBk3LP0rcSgR5bfbNxl9hz0nQ4
	pfpb3TYZUHkBOJuCxv/PcshDhaC8g+9n4hm0Msd1G08iHVAZ84fxCD7ozBg==
X-Gm-Gg: ASbGncsC4eQIwY2tcdim7ukfdPCvzg6Nvh3suV4qVEVMyIx/SlUvQxZPWJUap+DefTt
	K0BHFCSkaooWZJZnE3Hbg2sZLeZmCREA6pCY5CaXYrPP4Qci9Ss2P4cAM/KDUnWD7+OZh/kwoeb
	w09vELR7DBuxrzKKeSDjTrW5GrrIfxFgQGFlVmKc0lyIwqg+tpk380QfsoYzTbkFMqacJOMp5cW
	PaESt3n7wolHjGf8+BnM+eDIrtx3TIUpeRYnBAWgxNbGK4GKyDnTFxVnFB7rEkJUPwi68eyfVfT
	0EevVyeQ+hdIY1Lu0BDXKWBL62m2lLRmo5Lda281BcY9IPjh54YxclShb2izE3SvF0uwGh5Gn9c
	M5rwwgapzbRlcGpqp/pQDP8qvTq0SXw==
X-Received: by 2002:a05:600c:4fcf:b0:471:1717:411 with SMTP id 5b1f17b1804b1-4778fe9b299mr193383325e9.24.1763538098132;
        Tue, 18 Nov 2025 23:41:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsA1eiU5vS1jcJpwG7e4L/TuGO11v1CAxE8UCnKZxrzTCuQDYJ7t3csAArneU0iBm5h3nt7w==
X-Received: by 2002:a05:600c:4fcf:b0:471:1717:411 with SMTP id 5b1f17b1804b1-4778fe9b299mr193383025e9.24.1763538097716;
        Tue, 18 Nov 2025 23:41:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10804c8sm32620725e9.15.2025.11.18.23.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:41:37 -0800 (PST)
Date: Wed, 19 Nov 2025 02:41:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119023904-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
 <20251119013423-mutt-send-email-mst@kernel.org>
 <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
 <20251119022119-mutt-send-email-mst@kernel.org>
 <e80a7828-f42f-4263-89c1-66512b2dde6e@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80a7828-f42f-4263-89c1-66512b2dde6e@nvidia.com>

On Wed, Nov 19, 2025 at 01:33:31AM -0600, Dan Jurgens wrote:
> On 11/19/25 1:23 AM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:18:56AM -0600, Dan Jurgens wrote:
> >> On 11/19/25 12:35 AM, Michael S. Tsirkin wrote:
> >>> On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
> >>>> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
> >>>>> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> >>>>>> Classifiers can be used by more than one rule. If there is an existing
> >>>>>> classifier, use it instead of creating a new one.
> >>>>
> >>>>>> +	struct virtnet_classifier *tmp;
> >>>>>> +	unsigned long i;
> >>>>>>  	int err;
> >>>>>>  
> >>>>>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >>>>>> +	xa_for_each(&ff->classifiers, i, tmp) {
> >>>>>> +		if ((*c)->size == tmp->size &&
> >>>>>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> >>>>>
> >>>>> note that classifier has padding bytes.
> >>>>> comparing these with memcmp is not safe, is it?
> >>>>
> >>>> The reserved bytes are set to 0, this is fine.
> >>>
> >>> I mean the compiler padding.  set to 0 where?
> >>
> >> There's no compiler padding in virtio_net_ff_selector. There are
> >> reserved fields between the count and selector array.
> > 
> > I might be missing something here, but are not the
> > structures this code compares of the type struct virtnet_classifier
> > not virtio_net_ff_selector ?
> > 
> > and that one is:
> > 
> >  struct virtnet_classifier {
> >         size_t size;
> > +       refcount_t refcount;
> >         u32 id;
> >         struct virtio_net_resource_obj_ff_classifier classifier;
> >  };
> > 
> > 
> > which seems to have some padding depending on the architecture.
> 
> We're only comparing the ->classifier part of that, which is pad free.

Oh I see a classifier has a classifer inside :(

Should be something else, e.g. ff_classifier to avoid confusion I think.

Or resource_obj since it's the resource object. Or even obj.

But


> > 
> > 
> >


