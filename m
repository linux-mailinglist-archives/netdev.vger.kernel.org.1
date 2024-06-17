Return-Path: <netdev+bounces-104074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE2390B138
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE0288AC5
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643EB1AE867;
	Mon, 17 Jun 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efRwSvJW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729A19D09E
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630843; cv=none; b=U+ZNJBIWmaPAqC2uyMvqv856jGON2YmyeBwlgyEj1KsG7K/0RvhVxi64/fG6fp8fj2cD3S0w2TP2o7OBfN09gXmxF1L6gStz0KcbNbUtf7yUHgkWMmrVnUF7UM0F5Hog/33vrRfY7nECy20o85tt0h9lfqz9cIRajGE1Wqu01Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630843; c=relaxed/simple;
	bh=BVnGMwoCZw7PxuD/QNYyTuQeJ5mFD9HFP2ibNF1eTeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB5+3ksu5Pg6ePndygao6bwt6/P/7kx83l3kAv1iQRjHMewPbDugfuWSNx/BdIBhthrtyb4/u1Dhhsf4fR+50c5nW+iny09WXF4G84OCifTnUCnyRzB1+v31pitzGcPhf4jmUkZZMHOE4FKCKLUmL8ltnqKxZ76AsXyjbiQUlIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efRwSvJW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718630840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q84CXo0wUI7hBoP/Wd2wSAm0e9Fj0ilpl/ZCzDP0aQQ=;
	b=efRwSvJW9qHDH1FEdMhVveeBcjhCvMc231Ou9CT/6nztcd9BEhpCATJULnu8ygqVVzNW0E
	aCRHfDnaSZVqk2mfr+Buv1pDln/dtyemwSnAgDaBlY0xSFXD9UBMW84dgyx6JOPVq8IrYc
	9HbiGPxdhcidHTVpD/UhvbZmXlYASHM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-hWfmwwo1MgWtAUHQHbNNWg-1; Mon, 17 Jun 2024 09:27:18 -0400
X-MC-Unique: hWfmwwo1MgWtAUHQHbNNWg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52c8a4ef5e5so3475999e87.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630834; x=1719235634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q84CXo0wUI7hBoP/Wd2wSAm0e9Fj0ilpl/ZCzDP0aQQ=;
        b=hLz9Os/KxxFRXKFaaj3vi7kEHGfDFtElzoopgCIS2x3jhVfEnKYsmXf7MNDVfusLqi
         AK0kZ+lmJSiy8aw7Ld4ONlxFDd7Ie2bvib0Zo60X6Bbr++6s0dY9MYwcrg+DWzmG1YPK
         mo/PGyyb06EFnsVIkfejEE3ozCobIMtMpULvAW0HeaNDGxAMHtbxdmxKB7mMP1msX6KK
         NZkcn9wu+mDU1b9iQxCD/Dd36u3WkDWh9TcvDVLRCCJ7cnff7pX76+LXSq9xIeX69g+r
         3w1FGhQmWXVKVYbUGlokGFkNOJmvgeRHWPfBNBq9UYGh6GnQC42Rko49whc+HUAatCkj
         QlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3pRihNpm8sRNzdibesCSE4aAOadg5t6TkE7jfkIP6kW97wP1wuIksUiBRMfD6htSQmb8I6yqDd/3hz9A55f+iobhuQTAb
X-Gm-Message-State: AOJu0YwVNKxKvhREV3Av6kNauzpn9LDpZEHRCrqqAlN9rGYsphEc33Rn
	WZp0o9nHh3ImH1xSYd/MWMek8hAfAo0bYzvII6VGkB7ucTCA2MBadxvHp/LkfaEv17zM6kOoFaw
	HP8Ux31x40vj7/XV2oI1Wk8O5xn0XDAfvpbGhSKRp83vD//+VoDUExA==
X-Received: by 2002:a05:6512:20c6:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52ca6e64378mr6296642e87.17.1718630833654;
        Mon, 17 Jun 2024 06:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpnKGZZT8Zk3aPPgtEsPpln7bsKIoo+bG+Ridg0DdcuVdy5+34CRZh9UkBKQn9c7obciZzKg==
X-Received: by 2002:a05:6512:20c6:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52ca6e64378mr6296612e87.17.1718630833121;
        Mon, 17 Jun 2024 06:27:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7439:b500:58cc:2220:93ce:7c4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509348esm11832788f8f.17.2024.06.17.06.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:27:12 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:27:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vringh: add MODULE_DESCRIPTION()
Message-ID: <20240617092653-mutt-send-email-mst@kernel.org>
References: <20240516-md-vringh-v1-1-31bf37779a5a@quicinc.com>
 <7da04855-13a1-49f9-9336-424a9b6c6ad8@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da04855-13a1-49f9-9336-424a9b6c6ad8@quicinc.com>

On Sat, Jun 15, 2024 at 02:50:11PM -0700, Jeff Johnson wrote:
> On 5/16/2024 6:57 PM, Jeff Johnson wrote:
> > Fix the allmodconfig 'make w=1' issue:
> > 
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
> > 
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > ---
> >  drivers/vhost/vringh.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 7b8fd977f71c..73e153f9b449 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1614,4 +1614,5 @@ EXPORT_SYMBOL(vringh_need_notify_iotlb);
> >  
> >  #endif
> >  
> > +MODULE_DESCRIPTION("host side of a virtio ring");
> >  MODULE_LICENSE("GPL");
> > 
> > ---
> > base-commit: 7f094f0e3866f83ca705519b1e8f5a7d6ecce232
> > change-id: 20240516-md-vringh-c43803ae0ba4
> > 
> 
> Just following up to see if anything else is needed to pick this up.

I tagged this, will be in the next pull.

Thanks!


