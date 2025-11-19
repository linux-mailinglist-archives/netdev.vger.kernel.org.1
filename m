Return-Path: <netdev+bounces-240056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 886B6C6FEB0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 044B02F7A1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46AB33A71D;
	Wed, 19 Nov 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDg5fWi7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="glKOEleD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0820233A6F3
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567930; cv=none; b=ChhdPNLsEy26TFqnONt1ywfH6/Ea5he7H7sDABpF0TU8v2VoYvcyJW5E45ciawHLdeZq6+noNtPoPRGxXZAqh+D44OLc2MW0MlJa9fRNWhA/v0g4rP7OamRxJ8GHngM5aupvvE5C7PEG8Rg65CsYdHArfOqHL9i723MyMA9UAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567930; c=relaxed/simple;
	bh=X4udLAHwgPyvvaRrmhlRMNdE0d5tTRvL7IqLthLvERk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asOTyPW9GS3Z7QMPZ3jYhn4vJyu3Xa4e9g4i17PAyl/pq+lFUTSOqvhsbxuy3w4YWDxN+lwLSzrvNdE5x3JHSE1vp3Py7Jfp0cUbF/E2GtVmbkM731R1DSlwguSkJKo6sggI+zGMwC6JLjczHORQUQ9PEiT0OEtO8RzGefGKMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDg5fWi7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=glKOEleD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763567928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+84WrDN67gNDUwrYEwopUhwZ+peiqwEB+pp0DqzG0k=;
	b=hDg5fWi7H/YbyAINn6+5p8vdRk2YKwwsBCJ8/dbF6drC0Cs3dGRtAbeA2T5Mvf52BmKhfu
	+r4JjBblrSBhAu7mnBRWItMQVYQhnwwbSo87eMoGi/shBd/C8SyiWkYEioF1gIncuYKf1a
	OfiDlcbd2c5ZOXbRfmYNwVg5GLseU+Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-BBC0XeZhNz2StG0v1HhyTw-1; Wed, 19 Nov 2025 10:58:46 -0500
X-MC-Unique: BBC0XeZhNz2StG0v1HhyTw-1
X-Mimecast-MFC-AGG-ID: BBC0XeZhNz2StG0v1HhyTw_1763567924
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563a0c75so41203665e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763567924; x=1764172724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+84WrDN67gNDUwrYEwopUhwZ+peiqwEB+pp0DqzG0k=;
        b=glKOEleDz1Eqt9dBl7SzaiE0ofFz2ofEuhWOT1ZweV7Q1QCBuCs5J4lY2I86JxYXWf
         molYXeWHkvLGdiYzJ5Uf24iNEpfHsfxVw0JBMIbDx7zn8hd4UCJOkA11nrDPyUW2eJ5A
         guvTCcxHzIUv+Qy+g6sKmIVFRKAWh+I6JTA6pzKt8kODaQrGvoyT3sMShCe+pYQcjFW0
         71LJc92tsOUOIAS2j/vbla2TajKFLNqp7KOviIQZa9GQw+fk9OO7u6H0zgY6eQ/QA8Jn
         s5MNHOe9bjrfJzxGXz0nShurig9Y5OmhGXzGnzIVPa5s+bZrkcw5YJM2GlGrpbdbjzJM
         fdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567924; x=1764172724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+84WrDN67gNDUwrYEwopUhwZ+peiqwEB+pp0DqzG0k=;
        b=PgJ86VD+s6laqMKUN2UxP5R6bRC31PdtYvDKpLvsUagcZOYCxJxvrJzeiDIGmSM5Wy
         ZPfsRL4uwGvFZQZV5WRyHo174dsNtY9iFepMGPXbJn6ch9J5sRvxWQSQOf0Hbf4IZSta
         8m7Ioyka8oFG1r/QsL0Or8R6Lke17xU1gD82X2aDMZYtm/7/2gHIzJIHDMNreLMl/HBn
         kvWR/sIOSo4ycsUzqKTzLfnWoj3NilImDona7Rx8aTqOT5jDes9izeZgJfM5r2fS8Rr9
         p/TcsY5l9KqaI6k7oqMxZSE7YTMNpGg0E7PF6HGAippFb9sRKf5WOa76FH9pkEtdji03
         ThcQ==
X-Gm-Message-State: AOJu0YzmLoLM/R8hNeRc4JRPb0bJYS2y+mFGBwHSj90243hqwJ0wwkBc
	O4Ea+legQoRNXomXPOmG32Gz/ZiBXxrjO7X0id5fEZtILgvuIGTk5zdjr/CnGKTe9ldXJeebEEg
	ouYNKmgsv0aToeyQLtrrr5+R5YiLNJeXG3t192XGDr0W+DX0tO8qsQUwclQ==
X-Gm-Gg: ASbGnctm6yL6ddwQ+YeP762jIy0jUpvac/BIfQ+iRp9qNh7CxF0yQab+PMN/5W3ISIn
	14h79qUfHmxdTrQnsI6FRi5Al0n8rzUZmqoIt63cBVqiEaKxIH+nJEiAd3EBTHvbsyN8TVlfa9s
	whEQk6eXLg+DA48kj69kWf/scHWoYTyje3p/q2MGRjfDs/c2vha4uAdgkv8xy2WB0TQQXy1anA5
	+3UYo4k47TOnzSevw4Jle7JmuY8gs0sLqPSnK4WW+/OfoQHN7OgKj52wWDRPuxuQrDVzWGBWHgm
	hdDQEoNdhHarErIFGeQEX6bCLM2lDVN9i6cRfjiBjeOh3nJECbUPzp07fBXYA8JExfNFbkdiBGs
	LCZ4tvxpuoeDNnuZfrU9F3aVv7TyjIA==
X-Received: by 2002:a05:600c:8b21:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-4778fea84f0mr197459295e9.19.1763567924228;
        Wed, 19 Nov 2025 07:58:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMAURnwpj6ZTjgxBRwe6+8Xyy9ZKG8ZdRRqABNi1mzDn3MCPcvLn2k8HQ1gtbcXROoEePaxw==
X-Received: by 2002:a05:600c:8b21:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-4778fea84f0mr197458765e9.19.1763567923712;
        Wed, 19 Nov 2025 07:58:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1037d32sm52400545e9.12.2025.11.19.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:58:42 -0800 (PST)
Date: Wed, 19 Nov 2025 10:58:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119105743-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
 <20251119013423-mutt-send-email-mst@kernel.org>
 <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
 <20251119022119-mutt-send-email-mst@kernel.org>
 <e80a7828-f42f-4263-89c1-66512b2dde6e@nvidia.com>
 <20251119023904-mutt-send-email-mst@kernel.org>
 <c88f7798-996e-402c-97fe-1f8cc8ec172c@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88f7798-996e-402c-97fe-1f8cc8ec172c@nvidia.com>

On Wed, Nov 19, 2025 at 09:45:15AM -0600, Dan Jurgens wrote:
> On 11/19/25 1:41 AM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:33:31AM -0600, Dan Jurgens wrote:
> >> On 11/19/25 1:23 AM, Michael S. Tsirkin wrote:
> >>> On Wed, Nov 19, 2025 at 01:18:56AM -0600, Dan Jurgens wrote:
> >>>> On 11/19/25 12:35 AM, Michael S. Tsirkin wrote:
> >>>>> On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
> >>>>>> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
> >>>>>>> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> >>>>>>>> Classifiers can be used by more than one rule. If there is an existing
> >>>>>>>> classifier, use it instead of creating a new one.
> >>>>>>
> >>>>>>>> +	struct virtnet_classifier *tmp;
> >>>>>>>> +	unsigned long i;
> >>>>>>>>  	int err;
> >>>>>>>>  
> >>>>>>>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >>>>>>>> +	xa_for_each(&ff->classifiers, i, tmp) {
> >>>>>>>> +		if ((*c)->size == tmp->size &&
> >>>>>>>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> >>>>>>>
> >>>>>>> note that classifier has padding bytes.
> >>>>>>> comparing these with memcmp is not safe, is it?
> >>>>>>
> >>>>>> The reserved bytes are set to 0, this is fine.
> >>>>>
> >>>>> I mean the compiler padding.  set to 0 where?
> >>>>
> >>>> There's no compiler padding in virtio_net_ff_selector. There are
> >>>> reserved fields between the count and selector array.
> >>>
> >>> I might be missing something here, but are not the
> >>> structures this code compares of the type struct virtnet_classifier
> >>> not virtio_net_ff_selector ?
> >>>
> >>> and that one is:
> >>>
> >>>  struct virtnet_classifier {
> >>>         size_t size;
> >>> +       refcount_t refcount;
> >>>         u32 id;
> >>>         struct virtio_net_resource_obj_ff_classifier classifier;
> >>>  };
> >>>
> >>>
> >>> which seems to have some padding depending on the architecture.
> >>
> >> We're only comparing the ->classifier part of that, which is pad free.
> > 
> > Oh I see a classifier has a classifer inside :(
> > 
> > Should be something else, e.g. ff_classifier to avoid confusion I think.
> > 
> > Or resource_obj since it's the resource object. Or even obj.
> > 
> > But
> > 
> 
> Did you have more to say after that "But"?

Ugh ... donnu how this got here.

> I did this, also updated the
> commit messages and included refcount.h.

thanks.

> > 
> >>>
> >>>
> >>>
> > 


