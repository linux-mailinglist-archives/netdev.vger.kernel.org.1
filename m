Return-Path: <netdev+bounces-116747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC194B915
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 10:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1441C23D69
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989EF14533F;
	Thu,  8 Aug 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="L33wqI5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D3146019
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106091; cv=none; b=q4PyU5vLCz1UvSG0hb6SZpI1gWJGDPKRQPxyXKQx1NtkJNyl1Rb4uwaOZMDRzAvYrk+Hk3by22yxozqwOnoz/QhI+9IxFFV1q1ZdUjmlpjnKhZXnCV6Y3iaQI4WTgB88SkkGA6eY2yoGWoD4jlKyPndn5M7gJNNW4WUez5261rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106091; c=relaxed/simple;
	bh=E8ahB7jnkan/YWznrFB7n83kqiQtOdcxqbrJZ6IQ9I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1wCJFn4n4TWlAvpT5lznsx6iGUOkv0S5w8JXfuXn8om7rCrK6GyKunQV8IJluZDD3SZtsMg+K5KA5oCFIrb/eT3knSVxH0oupdpx/QxZz3SIyvkg2GOBqTgy11gDHBL0MuLSnJGJsQdubWr/XOnsrvxAYkgzQOSUcktw3cJggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=L33wqI5r; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428101fa30aso5033015e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723106088; x=1723710888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMyVywQb8vDAq8yqKAjxDJSLbsTFMH68OzT2M5QEc3c=;
        b=L33wqI5rpZrbwjx2ontygG1HZsiakRGqxZaqTGDiYNeA19CGhKeRMAch3Xg3yoAQUp
         iONMAwNoPF9bV1zx/5bbavF6VXxT8uqcF0hNjGpzj+YmdcB68Kkty4NmoAZw+9MkfpTK
         US2cvb0Zd6rxtih3gRBAG36E8h3SDJo1WDEkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723106088; x=1723710888;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMyVywQb8vDAq8yqKAjxDJSLbsTFMH68OzT2M5QEc3c=;
        b=tsSXdE5F3N8jVm0rNvy7EZvt2IRT9tMSlv2i1CCpFvoobWBZGtr6DG6YHrKiG9z84N
         RWbbmVyhAm/OxupAtg14OWpzWRPOYdp8v+sDk4wA4t2taDcVoDqWZwVhVC641l1GiuvK
         y/O6TsUE9Xh7UTOAzgvB9DJXEs2jSblyXNO/j+demWg/DtJHmExdSQ6J1Gd6fVl1lZeS
         8fB9IjxG6eE5CSJdLzcIlWzY1o9fidEvpZtuW0FFM5ZlUf3rI8FX8N6pbrPY9+0Kneui
         ei2y2EG6dQFYBFK5TH6UtaJEvRXFURPhfVXzdw7/RLqC553+L7vSxiOIpQaTNyT0RUn2
         mfmg==
X-Forwarded-Encrypted: i=1; AJvYcCXaxXh2Qeu0kYTGtJDsR52ExeSVEjLn7jFnpVMiPZ7vlPensWynmbMIATDsSYMT/me3TtsZGvw8XSuua09i3luP2U8Gh893
X-Gm-Message-State: AOJu0YxQZnqAtFNxW6NP+0FbD9jikbjBV5NVJ7SPTVkyPcUDwobePnga
	Noh+OmjDBOpM+XszTalgnr1UAPLz08T23Ru4J0Ldj4mZdO9cXlprRbbO8dkKZWY=
X-Google-Smtp-Source: AGHT+IFT4eAtZy1C2cFR4Q2FDL0LQc67lOoe7uGtjmlAA1RBNAoA9yj/C38JFOVh7omtehQgpbq38A==
X-Received: by 2002:a5d:5f42:0:b0:368:12ef:92cf with SMTP id ffacd0b85a97d-36d2755f1femr992329f8f.48.1723106087860;
        Thu, 08 Aug 2024 01:34:47 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27208e02sm1119786f8f.67.2024.08.08.01.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:34:47 -0700 (PDT)
Date: Thu, 8 Aug 2024 09:34:46 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com
Subject: Re: [PATCH net-next 1/2] eth: fbnic: add basic rtnl stats
Message-ID: <ZrSDJn3QnU8DZZz6@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	alexanderduyck@fb.com
References: <20240807022631.1664327-1-kuba@kernel.org>
 <20240807022631.1664327-2-kuba@kernel.org>
 <ZrOWM_F-BZRJEAAV@LQ3V64L9R2>
 <20240807093837.6aaa6566@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807093837.6aaa6566@kernel.org>

On Wed, Aug 07, 2024 at 09:38:37AM -0700, Jakub Kicinski wrote:
> On Wed, 7 Aug 2024 16:43:47 +0100 Joe Damato wrote:
> > > +static void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
> > > +					     struct fbnic_ring *rxr)
> > > +{
> > > +	struct fbnic_queue_stats *stats = &rxr->stats;
> > > +
> > > +	if (!(rxr->flags & FBNIC_RING_F_STATS))
> > > +		return;
> > > +  
> > 
> > Nit: I noticed this check is in both aggregate functions and just
> > before where the functions are called below. I'm sure you have
> > better folks internally to review this than me, but: maybe the extra
> > flags check isn't necessary?
> > 
> > Could be good if you are trying to be defensive, though.
> 
> Perils of upstreaming code that live out of tree for too long :(
> These functions will also be called from the path which does runtime
> ring changes (prepare/swap) and there the caller has no such check.
> 
> I'll drop it, and make a note to bring it back later.

I suppose you could drop it from the call sites and leave it in the
fbnic_aggregate_ring* functions? Sorry, didn't intend to cause you
to send a v2.

I think the extra checks are harmless, so if you want to leave them
that seems fine to me.

- Joe

