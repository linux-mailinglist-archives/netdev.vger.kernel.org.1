Return-Path: <netdev+bounces-112121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56893520B
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0319A281528
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2A364A98;
	Thu, 18 Jul 2024 19:12:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074D8C06
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721329968; cv=none; b=F5g6R/FvD+kzblt2HGqDnEtaeKgi/tBYptoF1781uzZKoiWlFzR5in4NjxUe62AbusHFhByjDg/Irp23j4S3Gd++t+WywMy9baD7BsIB0kXx6Fb7CU4HRn3EtK0fMQ0jwG717dauGgz099VlJrMQrzYBBFpBx7p+Epwb0po5kZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721329968; c=relaxed/simple;
	bh=BupNy/PDFraDwEeROVjCxk0ipGImbcyOVNmjL88SN94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F29jrzZssWLMDj9PHY/4dPP6R3X/Pltb6M1SBUFOeHRrM6nw47ZSMiTFXD3spNsfcTjDVRV1zElmrJJkLzKmn7cS8gDK6uq4vOhINzvqb2sAUgsvSIyg19jzQe7SrJZpH+/726PSSCWeXa16t0Wt7WpztDFn3CegAgzcChpNeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eefe705510so13780471fa.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 12:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721329965; x=1721934765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vT4HPcA/4dNNBAsVvPHu3KPmNWVE10YHz7F8Le8fhs=;
        b=enKyEM9zZtpA6Q8h0HwprEpin4iA+rG5a8Hvgmyp+5+cUD6nASJySLl1xoqIesnGhc
         JVTuEo1p0LhrUWbOJpNRrT2owGaCorccQ1VgoohP3zf4O4gqCiSlETnjbSnvUuP5c3Cl
         fJrA1WIHaoo24O67j4UTpFCsf3R6+pWDJcMlfLJVMAWqSvwd0NBkaAbiZ1023jX98UWZ
         LSCzjHIRUa+/M7a0tEIQSxoBtWmS6qdNm3dnAqEdp7tCws6d1Q3JcNLndG/PFbZGUez2
         y+E5f54NKuNdEBeXH7kSO6lor+TLsmhvZaXJL5w2oisaV9UIEvF4T6bqJcJxlIbp5ImM
         8RgA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVB8MQBAsgVXcmF9fLJBJgRfxwUnbIn4qJ3RbFAe311/INZ63CTh99ce4ZaNPRXYd1JXNa9NyABKXFu09L4a8K6V+VL2i
X-Gm-Message-State: AOJu0YwaGWpp5QjfAYjwCxKNnEjEjXHSzRwvqorVkqX1OMBgNdG5cAP3
	BPlAy8rG2CkVkGnaW35aCmP45ZoW6HmP239V5bsmA2vtpDTgbeSHrvOysg==
X-Google-Smtp-Source: AGHT+IHwL5lpFOWIAP+9TH1uYgKnDNHAggMMHAjFhc1vL9wDv1o76q8zNJJpIBEosg82vyUv0aqFxQ==
X-Received: by 2002:a2e:a545:0:b0:2ee:d8db:5bcc with SMTP id 38308e7fff4ca-2ef05c9afabmr28510631fa.29.1721329964736;
        Thu, 18 Jul 2024 12:12:44 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a2b6d358besm207180a12.34.2024.07.18.12.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:12:44 -0700 (PDT)
Date: Thu, 18 Jul 2024 12:12:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: mlx5e warnings on 6.10
Message-ID: <ZplpKq8FKi3vwfxv@gmail.com>
References: <Zpet0KnLyqgoPsJ4@gmail.com>
 <dad86bed4c22fcedbd280b4a5a5ad8e8298419a5.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad86bed4c22fcedbd280b4a5a5ad8e8298419a5.camel@nvidia.com>

On Thu, Jul 18, 2024 at 11:00:00AM +0000, Dragos Tatulea wrote:
> Hi Breno,
> 
> On Wed, 2024-07-17 at 04:41 -0700, Breno Leitao wrote:

> > Sharing in case you find it useful.

> Thanks for the report. The output, it is very useful. The problem seems to be
> that mlx5e_tx_reporter_timeout_recover() should take a state lock and doesn't.

Right. I've looked at other cases where mlx5e_safe_reopen_channels() is
called, and priv->state_lock is, in fact, hold before calling it.

So, independent if this fix the problem or not, it seems the right thing
to do.

Feel free to add a "Reviewed-by: Breno Leitao <leitao@debian.org>" when
you send it.

> I wonder why this happened only in 6.10. There were no relevant changes in 6.10.
> Or is it maybe that until now you didn't run into the tx queue timeout issue?

I don't have a reproducer for it, so, i just got it in 6.10. Maybe just
a coincidence?

> Would you have the possibility and willingness to test the below fix?

Sure. I have two hosts running with your patch, but, it is hard to make
them timeout.

Let me know if you have any trick I can explore and force the card to
time out.

Thanks for the quick reply!
--breno

