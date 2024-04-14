Return-Path: <netdev+bounces-87688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B48A416E
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 11:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDFA1F214A9
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68AD225DD;
	Sun, 14 Apr 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTDvmFLu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E270225CE
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085787; cv=none; b=e1kkOfKEi7N/s/jQ7KTljHUn/O9j//FnGqwqTWMHMlIBObvgxpiPIf946JCuqBOtUZSC1CEN7fLUOBaX7pDV0k6kmSNf1Oqfdb+w9O0GmMr2tJj+MvyGzThJLoQICI3Pa3EUkUOnIexTRgCLlm+n9Hq0aTdH6OPHyUH3IB7Spnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085787; c=relaxed/simple;
	bh=mx81azu7WGqDtDaPoKpPXOlm5ztzVujTkyngWrhVR+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKTMa4mg0PgQJUnmyH3clVyI4SV5cs+hVu3x+Z+PAYXU9DRssAjY3gqOumL8W/8GqaNe5lKA0e6/nHcz7XCjqnjQGxWoY8eFDgu0fv1+mMvRX8V8M53kDeFMt19MneRCVj/1ySlqm64rrMGxPnHA4kJd6zOHKNEdRYFGk/sdKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTDvmFLu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713085785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDn9p0oKJIowoxHQ+QZq8N5Xvgpd2J6FJtOvcnaAQTg=;
	b=cTDvmFLucsv6BAwvVTWGcaWjPl7jBhSdEmsipvS2uuXlIf5lYiHgBWwHQn8kQwdS3DUZLo
	SQkvspX7IXon7VqjeWXnL5pnImbG6VzQReMQY+IBpiHBe39OzwHNZyr0jzc0vwThgr5yf9
	MTw+tbfvH/1ZYV27eOfeMcnrmiFOgGA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-r2jQ7u3iMBmkLG19Q66fwQ-1; Sun, 14 Apr 2024 05:09:43 -0400
X-MC-Unique: r2jQ7u3iMBmkLG19Q66fwQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d6ef704b35so18304111fa.2
        for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 02:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713085782; x=1713690582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDn9p0oKJIowoxHQ+QZq8N5Xvgpd2J6FJtOvcnaAQTg=;
        b=Cc9BidXGVqX672A58ngIGyoZrUOpRQxzGeSzmh51dSMOAtJOlxc73Hha1KJnlDthej
         BmWSHCb1qVrIV2RABoaghEAffq2QYQt+1Rr7Wh0jzVganN8DMcXxXYgvqPasKVPO0UPq
         hT6W+wbrCIGmGSiW9YIqmNkW4DS4vcBxpDcRTD0R1NHQiCtCRf7ijuadFVBUQHr9zmRd
         0o8yCGRWwtxd3xd05r1xdoW8TEVuGlI5knF7mba1GQiusKA2a/M4buutNVHECRIVhz1h
         j+MqV1vDl4cg08j0bJr/iDGYLl2sF3lXVC4vQ/db0wL343TBuFoQPe5kA8jw64rAvx5l
         Tt5A==
X-Forwarded-Encrypted: i=1; AJvYcCVY0dGeIr3wazyddb3onb7jFyt/CAOUttggD7XcGGSdRVkvEQgTWfu9qpeEl63sntngRFWObFWGiWsW64qSPBkk0VEJo6Rk
X-Gm-Message-State: AOJu0Ywqm6Cb9i/e4q6KoyeYI9pv8ka2nUvUymhYgwL6HnMqKd5NNgrI
	yOVtuSBIN8nYxWxr2aykdiJsLuTQGTKbqxRfdgbi8uObqkJFXMFBdqfJm90BeKInWT0DLkPlKz1
	ylXEVBwXePprubibBbFDCiryIN+vo9Yu0cASjm4irc+2TWuLKTprL6A==
X-Received: by 2002:a2e:3509:0:b0:2d9:ecc1:6d56 with SMTP id z9-20020a2e3509000000b002d9ecc16d56mr4549905ljz.11.1713085782019;
        Sun, 14 Apr 2024 02:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnvXuyxDizZiI5lyVmq1CswBaXk7vrRoCt8wmpz3FQXQtnkzsP0CH3Qy864TeyyCiCUv5HDg==
X-Received: by 2002:a2e:3509:0:b0:2d9:ecc1:6d56 with SMTP id z9-20020a2e3509000000b002d9ecc16d56mr4549901ljz.11.1713085781463;
        Sun, 14 Apr 2024 02:09:41 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c4d0200b0041668053ca9sm10311768wmp.0.2024.04.14.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 02:09:40 -0700 (PDT)
Date: Sun, 14 Apr 2024 05:09:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240414050922-mutt-send-email-mst@kernel.org>
References: <bd27d4066f7749997a75cf4111fbf51e11d5898d.1705350942.git.christophe.jaillet@wanadoo.fr>
 <20240414043334-mutt-send-email-mst@kernel.org>
 <a7eceabf-12cb-41ff-8e2b-f3b21d789c17@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7eceabf-12cb-41ff-8e2b-f3b21d789c17@wanadoo.fr>

On Sun, Apr 14, 2024 at 10:59:06AM +0200, Christophe JAILLET wrote:
> Le 14/04/2024 à 10:35, Michael S. Tsirkin a écrit :
> > On Mon, Jan 15, 2024 at 09:35:50PM +0100, Christophe JAILLET wrote:
> > > ida_alloc() and ida_free() should be preferred to the deprecated
> > > ida_simple_get() and ida_simple_remove().
> > > 
> > > Note that the upper limit of ida_simple_get() is exclusive, buInputt the one of
> > 
> > What's buInputt? But?
> 
> Yes, sorry. It is "but".
> 
> Let me know if I should send a v2, or if it can be fixed when it is applied.
> 
> CJ

Yes it's easier if you do. Thanks!

> > 
> > > ida_alloc_max() is inclusive. So a -1 has been added when needed.
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > 
> > 
> > Jason, wanna ack?
> > 
> > > ---
> > >   drivers/vhost/vdpa.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index bc4a51e4638b..849b9d2dd51f 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -1534,7 +1534,7 @@ static void vhost_vdpa_release_dev(struct device *device)
> > >   	struct vhost_vdpa *v =
> > >   	       container_of(device, struct vhost_vdpa, dev);
> > > -	ida_simple_remove(&vhost_vdpa_ida, v->minor);
> > > +	ida_free(&vhost_vdpa_ida, v->minor);
> > >   	kfree(v->vqs);
> > >   	kfree(v);
> > >   }
> > > @@ -1557,8 +1557,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> > >   	if (!v)
> > >   		return -ENOMEM;
> > > -	minor = ida_simple_get(&vhost_vdpa_ida, 0,
> > > -			       VHOST_VDPA_DEV_MAX, GFP_KERNEL);
> > > +	minor = ida_alloc_max(&vhost_vdpa_ida, VHOST_VDPA_DEV_MAX - 1,
> > > +			      GFP_KERNEL);
> > >   	if (minor < 0) {
> > >   		kfree(v);
> > >   		return minor;
> > > -- 
> > > 2.43.0
> > 
> > 
> > 


