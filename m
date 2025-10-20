Return-Path: <netdev+bounces-230897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255EDBF160C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCE718A5FCB
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5275E314B81;
	Mon, 20 Oct 2025 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdfbC0C2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B00314A74
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965067; cv=none; b=jBpHtzl3fYh4zBWWKeFEZ+NbHWXu1yMUMYS4oWC09mRU0flVN8XbnMYu6isdPSmNPhDFGwB4FRiZflbU5jbMc++8tm/p37u1SqMnNZ2zn4Kk6E/VasiRetMDojuQlp21DzXfMmpk4B0u6A4pFRwcWffRtp0nsZPKt/NeTiUYWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965067; c=relaxed/simple;
	bh=G6FcO278eXFT1tgC313pIvONzjhfMvpa/sUOSVlAXKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V40wNEAUPRHNTwiJOYb1Gl31yz7LJlH5r3vPln36G32RGGwteOr9J0INqABPqu/NRMrY8NqC4oMqSRGAbTMSG9IiShYIVl26Pb91ZlDpU1ip21HaAA7KRj6PVt7+qF8cQunlXOyVwCb9l5C5y8KH/jWcvnc6kUphbwjCFD2d00c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KdfbC0C2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so40199665e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760965064; x=1761569864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ao5LTkpyunEEEJuwR6nh8mnIP8EeLv+acAjQyBGn0U=;
        b=KdfbC0C2Sce4zHSEmbnnbyWcAGIkJoui8k91GIIXvf9QEwmDeqkzykh3ylXyuwxxlq
         DP7IKSnC2RpA88JxKrbqc4uA8FF8cFtW9mWngA+dPoriONy1wDUASCsvbzDwxN9TrYZk
         cbW+dm+U0zWVY7zu5W32u+oVuisiiwvIx304AfzRHVMKHmxP9G12yGdUHCAUMRFsyXHQ
         5rhidWP7CTHW844P8sgRiljMMBMKLS7MaN/K//oocxYInqH0oWzndPdCQMpk+pdmJ0/N
         vyx+Xpn8isd6yRxsTOiZVU5s+d8msOYEEWtAf8KAM2GGXi7eff6mhjJJd7UAfWpbjU3E
         qDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965064; x=1761569864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ao5LTkpyunEEEJuwR6nh8mnIP8EeLv+acAjQyBGn0U=;
        b=SBA7gce5NwF9r8f4ZvSrcfg9Lv4uwKL1P4e++JOdYHctbRJy5acwanceUt4a6ySPtx
         udYggnQw+q6YZKKUsyPvTh862SR56IbdsezL0lQnP+9XIZx5BGK1o+ElwEXkTFwRR2qx
         Wc9raXK6d/kScWCal193Z38sNeMQRRqoTA7ofMWeJUg1OrlPv0M/U0d6e0hHg34XzHl1
         tj5FofA7uRgBep/ptcHEAkGhYEOb+XVFqxN5DE3FGs7jVpiC6ifkt7utYSzey0s2fMu1
         /5ZXF/laxR1Udf5tVWQrkiY32NyHR1RPOle65/GNw5JZIiZalM40JGnrebLAEAh1fwY9
         Z0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUlEpjI1V/smqc8XfdL7CTmXl8xfSORzuXQqL0ZcZdq4kqH+suG8f0YVQ3vlTeFQf2me8guZPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtKOQk3Rw21jqlpBv5azMxj/pwxQpkvt3F6yjAofx5h4x6tYp
	rQsxzb71MoYRw2C6CejcIQqg7j9VGGqgoeb0CCnyPnMz+yxR6vGHXYw6+8O8UKbPxOs=
X-Gm-Gg: ASbGnctt36abUis5+/6WICaDPRAbG7ybfODB+ARv3JOpcygDPm06XUMBKx4YGeLKiPq
	BC5IRTCMCE9F+bv4RGMNGvWYw0mbOpUrQ9ab6VuiCrB6xJs9/wJJNsUCrrN1GndXvr3iKzvZaqn
	Cb+F+WrxK1D9a+bAur3gbFnAs0dLg7Dw7Hj9024RJe08w9WaJR245miPBlRYxQDttBQS21nyV1t
	LitA9ClWKtjstxQGrM3rBKDYvyZH7ZsQthwP6pInyny6siZeh+xUyBMuf/1I6Qs1MY/Dtm7UrUE
	DxpblGQJJxWWA1e4f3qEZHEeErihkaBDgAwhnOVsqmc2grPg+BkctP7xh6tb2Da/3knSS5nP6A/
	qu1LCg5Jj8S0vuzT+U/WruyVtKQtxJLxDPpc6WzmVCSc49bz9UC+9CyLP0N+493oz+f0yh1K3HM
	xCDNey5c82G/GMO5Q=
X-Google-Smtp-Source: AGHT+IHAzHSoaXW9FTqisoxwWWJ86QeGPH0Qn2VpgfeKv1K2ScSIldv6hbmEjlnUGO1KIv2vK/3+YA==
X-Received: by 2002:a05:600c:3e07:b0:46e:450d:e037 with SMTP id 5b1f17b1804b1-4711786c560mr102540425e9.5.1760965063585;
        Mon, 20 Oct 2025 05:57:43 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471556e17afsm140881935e9.17.2025.10.20.05.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:57:43 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:33:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] netrom: Prevent race conditions between multiple add
 route
Message-ID: <aPYsDVBMUQ0X_ulN@stanley.mountain>
References: <aPYKgFTIroUhJAJA@stanley.mountain>
 <20251020110244.3200311-1-lizhi.xu@windriver.com>
 <aPYqRJXGhCNws4d3@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYqRJXGhCNws4d3@stanley.mountain>

On Mon, Oct 20, 2025 at 03:25:40PM +0300, Dan Carpenter wrote:
> On Mon, Oct 20, 2025 at 07:02:44PM +0800, Lizhi Xu wrote:
> > The root cause of the problem is that multiple different tasks initiate
> > NETROM_NODE commands to add new routes, there is no lock between them to
> > protect the same nr_neigh.
> > Task0 may add the nr_neigh.refcount value of 1 on Task1 to routes[2].
> > 
> > When Task2 executes nr_neigh_put(nr_node->routes[2].neighbour), it will
> > release the neighbour because its refcount value is 1.
> > 
> > In this case, the following situation causes a UAF:
> > 
> > Task0					Task1						Task2
> > =====					=====						=====
> > nr_add_node()
> > nr_neigh_get_dev()			nr_add_node()
> > 					nr_node_lock()
> > 					nr_node->routes[2].neighbour->count--
> > 					nr_neigh_put(nr_node->routes[2].neighbour);
> > 					nr_remove_neigh(nr_node->routes[2].neighbour)
> > 					nr_node_unlock()
> > nr_node_lock()
> > nr_node->routes[2].neighbour = nr_neigh
> > nr_neigh_hold(nr_neigh);								nr_add_node()
> > 											nr_neigh_put()
> > 
> > The solution to the problem is to use a lock to synchronize each add a route
> > to node.
> 
> This chart is still not right.  Let me add line numbers to your chart:
> 
> netrom/nr_route.c
>    214          nr_node_lock(nr_node);
>    215  
>    216          if (quality != 0)
>    217                  strscpy(nr_node->mnemonic, mnemonic);
>    218  
>    219          for (found = 0, i = 0; i < nr_node->count; i++) {
>    220                  if (nr_node->routes[i].neighbour == nr_neigh) {
>    221                          nr_node->routes[i].quality   = quality;
>    222                          nr_node->routes[i].obs_count = obs_count;

Should we call nr_neigh->count++ if we found it?  I guess I don't
really understand what nr_neigh->count is counting...  It would be
really nice if someone added some comments explaining how the ref
counting worked.

>    223                          found = 1;
>    224                          break;
>    225                  }
>    226          }

regards,
dan carpenter


