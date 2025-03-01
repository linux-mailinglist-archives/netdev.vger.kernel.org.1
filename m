Return-Path: <netdev+bounces-170890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB453A4A6F6
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 01:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB9A3A4DD5
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 00:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3CF79C8;
	Sat,  1 Mar 2025 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gpv7V+AI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7014A82
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788768; cv=none; b=rCFSeuY9kfotdx26sa9xZNb3ifwRbhCrPsz02cWezo5+LT/T7kzhCDOVvDPIPEDgc1V9DZCZmeFgNWjS8CbOMkiTZOpfLH2qwxhsRLNBoxpYofZXlaSKXbk8LKW+FCShWDneciEOImFcZETQTY0b2Ok7z/t6tkvqwpu0LybBSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788768; c=relaxed/simple;
	bh=jt+YgGSiFXOrJ2kMp5YlfSPDZmSqABt1Sm51ooGPve4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2vP2NaWnYGF3FcPU2KwrBuwaYqLHtLtGcHuqLQDl4TYulPK549lEI3zQzauSOAdvmgxOjzhBEHwrawyoqXOS+ECWhomKNG1goqwcHkdpcKun2FRIuA2Cvr3mLK1uyIH5Kl6To+EB06qMTmfCHufU25PIOVKa+NgPRq8m5GlgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gpv7V+AI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0a4b030f2so347897785a.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 16:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740788766; x=1741393566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MtjatnVjNgixbPBCXKK66vO3DHibToClD747DlzON4=;
        b=gpv7V+AIvU6HPQK/fWhrX9SypMpDstpd6Ga5Dge/1xDOpsTBmteK6W5UmEiu64Ob03
         qLblIWyexxvbqX9E5t126afmtuaEw3piR7Dlg81JINouWlTB+UsXubzFKIBi7uLDeZ/g
         VE+yTWEYQi+abKsSZJaTARDKtV8MXd4LOMuw/BA1quw07K9luLwUe9UQpANKm6rF0kAL
         26U1JQeLEQIPrlZU2n7U7cSSIlAY1pkz+ZLy/QrVFUID4/qp1czyWJvEztL9KGLZnNgA
         WLHF2RMGC0BD7e+UnvMA+19a63JE1AKnJd/kfEbA3F3M0VdajsmXaw41DpwKHUjglIgW
         6N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788766; x=1741393566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MtjatnVjNgixbPBCXKK66vO3DHibToClD747DlzON4=;
        b=ox4l1km8+cRiQ0kP9wWE91d6UhWieOhZqmhEXt3lhFO4TvloR3FfRqXH5u2cP7Fycp
         umoa41F+jSlP4VJ7Z6ow/7rfBtyaoar4K/kM4IGAFf5F97Bawvwd3M3+OBdZuVdsbi5r
         /FO/dQlmFR6CBLC/I5iY7lIBhd4NTmDUgUEIte94CCW+mwtXwzr9MmWEF40i48Zx/Hi7
         5eZFbgJNoaa0dpnj1cSUFLaQ0Kyd5K3ozxuqXEBGlyq/hYSGvAX1uyF00Axty4iJZYbP
         lU8urgC3J+ljmOC7hD2JkwdUQEj3UVGM7+ecwhCfB77bVzIu6Llmi7SPBAAUrX/N9L18
         2fsw==
X-Forwarded-Encrypted: i=1; AJvYcCWWuOC7/3aRuGxApjic88k5BkXUdifuLX2ry//LKNFrI7i6jcqY/JLOjJspfvM9pBECWApMxLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfuRcYV7lg2BPzD03hjF4KzqETqFqWSj4XWlxewJh32b7MA5pY
	3Gesbq166l/wpTse2UxJdumkgz77xNecAUh7qc2QgOMiTGbuzK0hSdhULczAExo=
X-Gm-Gg: ASbGncv3CoKpWY/MgeZlAKjlesgv77Dcc2BdU+ZLvBUuGeY8PjPJU88aoq3hInchsyx
	Y0H7CWRKOtcIk+pIiP01q3HuQbhqw80s7Dh0hi9WngOlXoTGxDl7oXkm3YFxt9WPJe+G4svl1kX
	8tOoho5b+ZOxok5iOW47eqtgeP4AoP+I8SNQDBWzmqqOMDt6GtqUVUjP6u4vOeP9tqcFpMsFta/
	io4vWGMHcf24O5CeYpFZaU/baNAHstqDLKSQA0TR0M/kah6MA3X3coJJTb7Qet2+lWu53nqDUMo
	x0vTaIuY+mxZSPxhLfZ2IRjzYnbTOSQXG8IgkPatZQi32xkWoLKNzgOb2IT5wpgf77sprYuSf0U
	wKMgTWqZ3553VbKj7Yg==
X-Google-Smtp-Source: AGHT+IEyduZmKmDeBUENZfmGzGgg3DhASjWA/ktGwI0e/xDC6fTyc7s+TOl/wjMJMYfdyHxWvUKlYA==
X-Received: by 2002:a05:620a:394e:b0:7c0:b7ca:7102 with SMTP id af79cd13be357-7c39c64d2cemr801166085a.38.1740788765786;
        Fri, 28 Feb 2025 16:26:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89765377csm27572316d6.45.2025.02.28.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:26:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAg8-00000000VLR-0rfV;
	Fri, 28 Feb 2025 20:26:04 -0400
Date: Fri, 28 Feb 2025 20:26:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: longli@linuxonhyperv.com
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch rdma-next] RDMA/mana_ib: handle net event for pointing to
 the current netdev
Message-ID: <20250301002604.GN5011@ziepe.ca>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>

On Fri, Feb 28, 2025 at 02:41:59PM -0800, longli@linuxonhyperv.com wrote:
> +	struct mana_ib_dev *dev = container_of(this, struct mana_ib_dev, nb);
> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> +	struct gdma_context *gc = dev->gdma_dev->gdma_context;
> +	struct mana_context *mc = gc->mana.driver_data;
> +	struct net_device *ndev;
> +
> +	if (event_dev != mc->ports[0])
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_CHANGEUPPER:
> +		rcu_read_lock();
> +		ndev = mana_get_primary_netdev_rcu(mc, 0);
> +		rcu_read_unlock();

That locking sure looks weird/wrong.

Jason

