Return-Path: <netdev+bounces-94021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B218BDF70
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398841C20ACA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027714EC45;
	Tue,  7 May 2024 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/QV+/dJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9E14E2FE
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076667; cv=none; b=g0tUJENtM3AD8kLySllK3xZlw9/jwR84UJHJFEZKbN7rTI8eM/GVon1X4ZU6dt4wNkjCzWuOfDZkuVarSpWf2Z279vZk7sS9NfQ0MN0rXWWWLW35S0KDmo+oVL/Sqy3rniFC1DWnVRgZ7PaelWl5rL3UU3dMXa2PI38aT4sky7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076667; c=relaxed/simple;
	bh=pzN0QEsi5vW51SAWCGgbkaOsqw5VvfmrBvJ7uOk7Djk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoSpNGvVpO/yzhlLJApDtEGqZr/EXQbeD1KOgmTAYl8kqybXESr6ZalgwAGZCUkBnp8/urAgBTNzK8jcSVkjah4jumGROwnzFH2jFLiocsJoIkoXbbF9Rn5I/1EX1cbVep03BX0sBYVaJeGcfh9l1a4vBg1UIXFJz0Xz4oRf+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L/QV+/dJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b782405d5so31413785e9.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715076664; x=1715681464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRkoNOEv8gPHcq2P5UAKWS8B3jCr0cVjdP20g/cY62k=;
        b=L/QV+/dJ7j42rpb8HLhc0HWVdxhS7FBN4FcTW8z4HzQMBAtZd12/MRDlMr+jaXVhzL
         0gq/MQ7+jLEYc9cXq5ZI8qVm5dmGHd4lXhCx5oSmAD0wyZZQTsSuXF4gd404OL8BZBbU
         NMNIDoHbQWmAD2yy3JzA91DkbwbwNVAbUX0r+L4MbGiVBI7s6a3ZUCMKxkp0+OxABgo8
         zEx47alEjrFV90mEneAac+26I4rlI/tvAjw2gjNCdKnrV612+JYPFHP54nvbeNXLU/ko
         if/JwpXjx7qxNClmWzw1EiUuY8ZdYzT6tnHBXmxbvyLUXLL9M9qQrmvW9b9uwssiE4zL
         4CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715076664; x=1715681464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRkoNOEv8gPHcq2P5UAKWS8B3jCr0cVjdP20g/cY62k=;
        b=DLXIoaQWmDetvWkC+Q1M41BeKV5LDKnjrbW5FlZ5f7REGhr29MFXtgujwPuPzEhHxJ
         z/pJ7XKIFCiiFhVMOzerI/nUe+GvHBMJ0jNgLyZ/+ZAV+4yjYgQqBNQ1OPaA/KzhCMFz
         2sl2Q8FD5bAmhgoDBkgjm33FUWGS8t0nhT2AMaHsV4jqlyD1ojfDZcnYpb2X3aG9ZrB8
         hhlUDUPw7GGdqqi17uhlRdWMt5io/eyvWVu9ceRhdwC+Owza3zMezfUIspZ+f3mltPVq
         lQUQyzmlQQl8bIGyTsV2AK6mN0Rod783fmjfV33P98RT3Bdi1cJBQXljewJ6tkQ7xKSB
         KqpA==
X-Forwarded-Encrypted: i=1; AJvYcCVn7wjK1P0zcpHnX4V4oDy+5qNRQM52bwLZQtSBWOFAWXqNXveHSZcDqJ5yDRWOgqFj18HqQ4hKQZcGPUgsl7YPJIMeg02W
X-Gm-Message-State: AOJu0YxSIs6/J9eWtk5ghAd006iby38IqmP/nd6fMZNEptAS8ZGiXfHs
	xvRRmMHoNetZZm5oRljGgcSP5KMFGaEwlpVX6SldIqkSTp3kwrQ90Z80nhcNhV0=
X-Google-Smtp-Source: AGHT+IHQFXd45hAfqA6n0d5ImUefQlbvL7vaRViI8Nu6Qp2CarjGeOlr7thOVlNJO6zr1Os/EEcwqg==
X-Received: by 2002:a05:600c:1553:b0:41b:e94f:1e88 with SMTP id f19-20020a05600c155300b0041be94f1e88mr13064142wmg.24.1715076663825;
        Tue, 07 May 2024 03:11:03 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b0041c14061c71sm18935780wmq.15.2024.05.07.03.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:11:03 -0700 (PDT)
Date: Tue, 7 May 2024 12:52:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Duoming Zhou <duoming@zju.edu.cn>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	jreuter@yaina.de
Subject: Re: [PATCH net v5 1/4] ax25: Use kernel universal linked list to
 implement ax25_dev_list
Message-ID: <5863f2fc-ab8e-4f6e-873e-2667bc0a2e4b@moroto.mountain>
References: <cover.1715065005.git.duoming@zju.edu.cn>
 <bd49e83817604e61a12c9bf688a0825f116e67c0.1715065005.git.duoming@zju.edu.cn>
 <20240507092917.GA1049473@maili.marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507092917.GA1049473@maili.marvell.com>

On Tue, May 07, 2024 at 02:59:17PM +0530, Ratheesh Kannoth wrote:
> On 2024-05-07 at 12:33:39, Duoming Zhou (duoming@zju.edu.cn) wrote:
> > The origin ax25_dev_list implements its own single linked list,
> > which is complicated and error-prone. For example, when deleting
> > the node of ax25_dev_list in ax25_dev_device_down(), we have to
> > operate on the head node and other nodes separately.
> >
> > This patch uses kernel universal linked list to replace original
> > ax25_dev_list, which make the operation of ax25_dev_list easier.
> > There are two points that need to notice:
> >
> > [1] We should add a check to judge whether the list is empty before
> > INIT_LIST_HEAD in ax25_dev_device_up(), otherwise it will empty the
> > list for each new ax25_dev added.
> >
> > [2] We should do "dev->ax25_ptr = ax25_dev;" and "dev->ax25_ptr = NULL;"
> > while holding the spinlock, otherwise the ax25_dev_device_up() and
> > ax25_dev_device_down() could race, we're not guaranteed to find a match
> > ax25_dev in ax25_dev_device_down().
> >
> > Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > -ax25_dev *ax25_dev_list;
> > +static struct list_head ax25_dev_list;
> >  DEFINE_SPINLOCK(ax25_dev_lock);
> >
> >  ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
> > @@ -34,7 +35,7 @@ ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
> >  	ax25_dev *ax25_dev, *res = NULL;
> >
> >  	spin_lock_bh(&ax25_dev_lock);
> > -	for (ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next)
> > +	list_for_each_entry(ax25_dev, &ax25_dev_list, list)
> >  		if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
> >  			res = ax25_dev;
> >  			ax25_dev_hold(ax25_dev);
> > @@ -52,6 +53,9 @@ void ax25_dev_device_up(struct net_device *dev)
> >  {
> >  	ax25_dev *ax25_dev;
> >
> > +	/* Initialized the list for the first entry */
> > +	if (!ax25_dev_list.next)
> > +		INIT_LIST_HEAD(&ax25_dev_list);
> if you define ax25_dev_list using 'static LIST_HEAD(ax25_dev_list)', you need this conditional check and
> initialization ?
> 

Ah, yes.  That's the proper way to do it.

regards,
dan carpenter


