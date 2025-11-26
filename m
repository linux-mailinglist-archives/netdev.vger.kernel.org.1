Return-Path: <netdev+bounces-241793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3FC8844F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA0B93509D1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC22ED14C;
	Wed, 26 Nov 2025 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAdBuPRG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Laspvpj3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD030EF62
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138479; cv=none; b=LzMXBYG439lqKVxcddxkav0V31QO38MFhEsXIcBLpcdTxRbgYfpB2VCqp1h1woDMhsbANdca3AlcpmFwmBu3c5UNPNoyrPdXgMiV4tSgJcrIOtHP1R/uKtxF6CHghGPlmZT17cAPmW6S5vTCqf+rZus4zs1stkUxVmyAn65zWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138479; c=relaxed/simple;
	bh=6GBox+U71wd52Kw2/PdLyqreoI+ktndyD42jWbX4uFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XweV0pHjbYtd+CeXRplli+bn214MIt1IMb5ZWjJxTPnoWiP+HizjVjyQVRVRZgYXb7qVGzKsE52+t6LWIkdBVH2udM5Vkg7gth6sd+eIN6A6lLaTpgQwO7Sr+E3BLLWui8X95CZasvWtUfXbhbQLlA65EVXyiKIw9B0I6N7d8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAdBuPRG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Laspvpj3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764138476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARxIA8tdQWb99qoXW28PLnSr1NCprmRt1PGWJHnjSzg=;
	b=HAdBuPRGtRSDvJKDvwR4QcR/2SVYfZjBGfoFU6KInuMlggSjOK8NP0HheSXHP4zme+PjNf
	iNaua2o8hIT884UarlZQFjI+auUPsAPuJ5rY3BcRPYkKh4jFb4Kc8egUbnbmtJLiYVaskT
	fuCG0MQKusH3H3sxpGhhceb3ZZ2UAtw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-7LLktpd-PrWDIfmu6dQsmw-1; Wed, 26 Nov 2025 01:27:53 -0500
X-MC-Unique: 7LLktpd-PrWDIfmu6dQsmw-1
X-Mimecast-MFC-AGG-ID: 7LLktpd-PrWDIfmu6dQsmw_1764138472
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563a0c75so33530245e9.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764138472; x=1764743272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ARxIA8tdQWb99qoXW28PLnSr1NCprmRt1PGWJHnjSzg=;
        b=Laspvpj3X2vQMlf7eONaP0uEp8iI8cEklRxi9rYME1Ke09iAyhQFbFP85DLnUbkjTb
         hYevtAYaQVPBAc271d9zgt64yK6LwKG9I42NrD/sQ3KRFJyiYRiYoifiS05RzMUizjiY
         NeIEdBz96Eksy+9fO+yvK8HhzaRpbyZ0/DGz9oPG7YPXvljKkCZeyQYDb+5yG/7tbhQu
         fPkjBLqEteKvW5UP5eSiAR2q6j66mMTzGPA3uva6MZVtNm7U8/ALB7Zb8nNuPG6x5HXP
         XMs8cql4IO3EUQYQEu57ZdGY5YiA4qv/gxM4QyGBOktjbrid4DAcHn2rd+KL3Y8djLVE
         tYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138472; x=1764743272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARxIA8tdQWb99qoXW28PLnSr1NCprmRt1PGWJHnjSzg=;
        b=atUQQxNXruikIcM6w6fyB7BZVgJ7cPt8+rNBntTCsLi1OzkJaVXtp70/hf1YWi+YHw
         zdrBCngT3qYoJ1bnmqhRZpCQlXexUHIVyPdD3i7UohVGTZNPUwUDsj+VDrBokWu1A+R4
         snTLqS5/tDdQ74UxTxqvRo8Ev06SPvandle4VAIeQx9zVggVX7VPpbpEtfyNKwFKxn8U
         gItLh5M67SHqKmmHuGSTkzngA/yCjQNvHQK3MgiQkLILMWp2BKo+QSl61NxL8GmA1u6E
         1DalwDe5cIDmFwuATvlGeOwllUD8ObqP+JeWk3fsrQm19jsf8gQnxWufhDKlOHSQUwUs
         owBg==
X-Forwarded-Encrypted: i=1; AJvYcCWLC4bjlaixx/blZo5kVZUFeEzI5nnNKGgjI+vtAdgQTqKx/EmefMKCFV3RLBr2fJb6PiG3jMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwrmx3I9a+LIM+I/9IvVUYUnYbw7BPyGIINNIqQe0tU8WXlC1
	CUXpjSjzIaSjanoj0QudHdhxGUWp/Q/r78xdTdvkKpHertqpaygS4D02Ff/Boa6cfc/4Rxc8bEJ
	pll6CbpZdm/pl4gqi5GckGtBPnpl5Ne3JW3gO3CZaehTUaT9hcZPzIka6Kg==
X-Gm-Gg: ASbGncsjwPsla0tehfXuCw7k8mRg3P9FUg/ORpTG5liHSluUCGT8ofgAqFz5q8g96r1
	EN+Ewua6/CKiruSZJ4PgyLg/bERGCj4UM7ObSyB0y7Y05iZ8wcZvLRSV9ENxoOtCaLXUMrJhVA9
	4jWZzov1/BKHvOPbpLURqmkYzWzpX2CsaBJtIzHIyIieXOZ5UHVrY3ytqFLQMYt9j6O9Y9/H3Md
	kqn1RfTecRaWRsZ6ZbsfnO+emNSHgdOWohIg3pgztYK3133raUo7ydIJN6xpG0kK31YjckvR3FQ
	hYcXCnaW7VsOMe/mWfBRtZV0CqA8F7ggTL+ShoOmaOFaDh0Sp9bC1eglWT3si/kxfoCe/rOgmvt
	iC1Lga9ousBKwaqiWzPEByrzxJSVunQ==
X-Received: by 2002:a05:600c:4443:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47904b103e2mr53915395e9.18.1764138471839;
        Tue, 25 Nov 2025 22:27:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0f1u0T3jzKYGdUCWINkcBdum6zqYD5lZ2uzy8Z3cJxh7vJamCVyKXR4UerdY4GLIpXEKe5g==
X-Received: by 2002:a05:600c:4443:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47904b103e2mr53915225e9.18.1764138471351;
        Tue, 25 Nov 2025 22:27:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adc601dsm26881835e9.1.2025.11.25.22.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:27:50 -0800 (PST)
Date: Wed, 26 Nov 2025 01:27:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net V2] vhost: rewind next_avail_head while discarding
 descriptors
Message-ID: <20251126012023-mutt-send-email-mst@kernel.org>
References: <20251120022950.10117-1-jasowang@redhat.com>
 <20251125194202.49e0eec7@kernel.org>
 <CACGkMEuCgSVpshsdfeTwvRnMiY8WMEt8pT=gJ2A_=oiV188X0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuCgSVpshsdfeTwvRnMiY8WMEt8pT=gJ2A_=oiV188X0Q@mail.gmail.com>

On Wed, Nov 26, 2025 at 02:18:25PM +0800, Jason Wang wrote:
> On Wed, Nov 26, 2025 at 11:42 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 20 Nov 2025 10:29:50 +0800 Jason Wang wrote:
> > > Subject: [PATCH net V2] vhost: rewind next_avail_head while discarding descriptors
> >
> > >  drivers/vhost/net.c   | 53 ++++++++++++++++++------------
> > >  drivers/vhost/vhost.c | 76 +++++++++++++++++++++++++++++++++++--------
> > >  drivers/vhost/vhost.h | 10 +++++-
> >
> > Hm, is this targeting net because Michael is not planning any more PRs
> > for the 6.18 season?
> 
> Basically because it touches vhost-net. I need inputs for which tree
> we should go for this and future modifications that touch both vhost
> core and vhost-net.
> 
> Thanks
> 
> >


Well this change is mostly net, vhost changes are just moving code
around.  net tree gets more testing and more eyes looking at it, so it's
good for such cases.

-- 
MST


