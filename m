Return-Path: <netdev+bounces-196556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF100AD5438
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8660D7A7FAE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D1425BEE4;
	Wed, 11 Jun 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPLHyVGY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F42417F9
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641999; cv=none; b=I3mg2+KmdRQBkYvqoDP5I998+egECQ6spKSIisaacSQ96FF5G+sOQOHuYomZsNfVtgSwvu7zVYWnkDYhE8HMCT41FOX9H9f/TY79a0bN+LmfTvJmMpJ3xP4PwOEVGrpFoX8wPGVTjTtY/n6vB4smowNP3pq40GGJe1SOuVk28Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641999; c=relaxed/simple;
	bh=QPPFuoZ3d4W5VV8HW1sVSL7jX4Xs4dHXPiQH8dRGzic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atQuEUTw3T6uLbkwXRAA5KPsPErrnVSfe2xwltpnlbBWLQqH2SbTVWPavjPyajLCpW478gJMGNm9lmHEPCRNDWYM9bbg3zEdOah0HYqNYKYrt8R1dKqy5vaaPwv3ezOEOCXfpXiB/9xcD4y/hXqqS6gIQDTgTFwhh9z2QuyF4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPLHyVGY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749641996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyBz4kAiu10VL86LEJ1Vf5IRYzjxg7iBJOh/zIIAubM=;
	b=UPLHyVGYmJ+in/z5NNMRkrR8n2N1Jzvy6Lk3Rmy3RGbw7TI9+TNVpzz5oYiU8gDkrvBrmL
	i7IHKdM1HPN89nuAqGZITexUZGYYGuwww7hePB3cGSpmjDBZU6h7JiFCIYU/JbjTI1/OKI
	co/Z+4Ouo6dxQoDy58vUdE5hmDZUwnY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-BOCxLpRuP8-WQoi9n_8X4g-1; Wed, 11 Jun 2025 07:39:55 -0400
X-MC-Unique: BOCxLpRuP8-WQoi9n_8X4g-1
X-Mimecast-MFC-AGG-ID: BOCxLpRuP8-WQoi9n_8X4g_1749641994
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so4287812f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641994; x=1750246794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyBz4kAiu10VL86LEJ1Vf5IRYzjxg7iBJOh/zIIAubM=;
        b=XanB7cj8LraMq/BaPYMrbSUI3A6UxLlk8dhUCjBq+lXRUzhnSTSy2IPxL/tEZblehe
         mySR0VmtG99Dl7GmVCGoEd1+iX6qbzWmkfJSKJ+HC/vHG6RoZ0GSURWZJbz7hQ38BGSZ
         wPak0UyR0+ncA5CH2MIXVlcGmo4Pm+clmoNam8ZzMMswcWjWZIsToja1b6M77kix0Qux
         Kv5bbv7y6xYjPQivuWd3hA0gWMoaG5idYh/xvjIlan/Intt8f8k1cZqDaLRysr4MgXp7
         JP6XJoA5TQ/9izHBMyO1TGW0tUog2mDwmciZWC8GNbd27ClPzU+CFzqeEB2HALTMit1r
         54hw==
X-Forwarded-Encrypted: i=1; AJvYcCVIq+yVIsofKmjpBJYdmjCcTlIP0usH9ttjV4T7X/fDwUQZkJE709LKXWEVGHRID5bRjKEPKQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMkO9SeM9co8zWWscpqeOI2BXbIYioafkQlOWBhxLGvflvJABV
	NQgyOBJsJPaWhwRudqyXVfupwOORtsGDp6+xqw247V0DIVB0XO1R0kRVSV11C2+sM+WG8eEyVrc
	vJZA7tQuaL19VnWuklX2UlnqHug3MPj4qoboHFUxu5Bcd9coI3lOJmL1hNg==
X-Gm-Gg: ASbGnct3Urp17hES06frMhMk3o8CqR05U5GTQhU6LbEhziVYzbEKPy3fNAmJGES+AUa
	ymlPzfOqNk/UaZVvbxKKa/tw/or2NmC4ma62Cti5ewSwhGLyBCLysss543gvxpbhjqb8qnTocgc
	CqA041zJVBzX9GUY5az3+4Sj45AtReQdv5GRiDesnmaLUVfly/b2aRTeDSPYDRC3yDDcIZfkFLQ
	crHRWvkvvBBHniIbMOlabOT9RasamPDPWrkDh8HpIqv/SY7XzldLw99P/GVTdKSMWJmQfQes/78
	JAkzssPuOblFcj3TtMJwM9fbrzF8IG22CSSN7p+MfXg=
X-Received: by 2002:a05:6000:430a:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3a558a31835mr1993894f8f.47.1749641993872;
        Wed, 11 Jun 2025 04:39:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRUBKlfDmwu/XPXakdq33ilj8R46WG1+OEU6DJFMDzXj+rsrCDUY8YS9lGv5cDnB6ADuhUxg==
X-Received: by 2002:a05:6000:430a:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3a558a31835mr1993872f8f.47.1749641993479;
        Wed, 11 Jun 2025 04:39:53 -0700 (PDT)
Received: from localhost (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4531fe85260sm31418165e9.0.2025.06.11.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:39:51 -0700 (PDT)
Date: Wed, 11 Jun 2025 13:39:49 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
	davem@davemloft.net, linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 6/7] can: add drop reasons in the receive path
 of AF_CAN
Message-ID: <aElrBfTYkepfUxD-@dcaratti.users.ipa.redhat.com>
References: <20250610094933.1593081-1-mkl@pengutronix.de>
 <20250610094933.1593081-7-mkl@pengutronix.de>
 <20250610155039.64ccdbda@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610155039.64ccdbda@kernel.org>

On Tue, Jun 10, 2025 at 03:50:39PM -0700, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 11:46:21 +0200 Marc Kleine-Budde wrote:
> > Besides the existing pr_warn_once(), use skb drop reasons in case AF_CAN
> > layer drops non-conformant CAN{,FD,XL} frames, or conformant frames
> > received by "wrong" devices, so that it's possible to debug (and count)
> > such events using existing tracepoints:
> 
> Hm, I wonder if the protocol is really the most useful way 
> to categorize. Does it actually help to identify problems on
> production systems?
> 
> AFAIU we try to categorize by drop condition. So given the condition
> is:
> 
> 	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) 
> 
> my intuition would be to split this into two: "not a CAN device" and
> "invalid CAN frame". 

hello,

yes, that makes sense: I will post a follow-up patch soon.

thanks,
-- 
davide


