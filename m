Return-Path: <netdev+bounces-119620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA99565E0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C093B22930
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A5D15E5C1;
	Mon, 19 Aug 2024 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGVTENhX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90415B542
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057018; cv=none; b=pvlr4IofwOQoZZ+It1u2AEXifDxOcnXRSguXYvHz255OPE3JyqPmPCqltJOlUhnmnOjUihpw22bRy6d8F+FDfZr1NZrDY8KIKCa1tDSB5p0udgsFByGfpdj22mPliNeqoXbXRj6CIWmAXN9OLs4/ZLu5YqZzAFvhdcxRnQUl8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057018; c=relaxed/simple;
	bh=672vwonkWcbTlUEWQC6soBEHXcCCzUpCwbWElcbg0Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd7i5LT/cGf1MitdMH0aw3E9hPSoqKQKmIJjP23lK9RYejQrexGCM0Ipk69irUw7K+6jbfNi219WivgCqso3Qe1vFI1RFVJkZiEM3jZy52VrRUlr/xyfi5c10C7jHohVINqsgxOaCyAMwJo/tcLNv3yi3pHKDoPblBBcrFmKASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGVTENhX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso3415080b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724057016; x=1724661816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sLmqovx/iGBJhRelLlJeJ6IUKAw+fknnsGuj8noDdk=;
        b=TGVTENhX/a9dwS00bk7caGllBcyHY5/RJTNDLng+vtJZd6O3XMk20YfjJsEG+46Y5X
         nz7B6iWPZQTY0hfjNBezX0QrlXwMOyt5AjYojCETlQo5+9C7UlwSKWd9pkk+45CyF5lZ
         OgSQEvQDmycb38D+ztlk4gMJyjwqQtZBitK2zJ3rIYx8kEDv1/0gXHPd7oe0+4zHND+/
         oLUgvfu96gy6kiR0BHrzl3tpgmAzL5Bttnv/ZElWYTSXeOk4/K4dY/ESxh9gEPAbD9ij
         huFKp3ZRFKWsuAbmsMaNCOuYdwSUjXwv1AUMxMR+TSRGz+zpepf8u10AT5WkFT7LzFo2
         DNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724057016; x=1724661816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sLmqovx/iGBJhRelLlJeJ6IUKAw+fknnsGuj8noDdk=;
        b=IbJak3Dzfp0svAlELpV8ktqD2aItRTZgS+GMwO4BzyCdbiSBXxoDwu9jpPzuhbBMpR
         vV6yxBBgnPaFvHb+reN33X0d9PPykDUCZnOnIuELBhxfQTrrx1upV0HIb1RCp+VOvCQJ
         xBxwokaRqd5iHVMZi57OkE5DFiKa6TbM/Y61hbyd87zQg09XcHFtYvRByfeMcQzTZKZG
         LQLRLQRMfBuhU6piqtRWls0Fj7RCMRLpcxQFGVtD8PcuOKBmnwj9w9s0r/p49lg9DdhK
         O0k4CjAM8RmBY+Azj+enHvG3v6Mns0ry9AOlNfsr/ahzAksDOG/VcKfMjn4DpE+xp1yD
         V5aA==
X-Gm-Message-State: AOJu0YzXCWKnGzuWyxak9R/6e1s7C70OLZh8nD5kIQAcObrkq1Bmk6lB
	OvuXgNr5eF8OlEsoqBmz2zEh+nr+1b+RDzDLmFmgN3aw8doMcaixXo91421PuVjLYA==
X-Google-Smtp-Source: AGHT+IHStIexQgOOoMePJJ1su+1fI6eQVcdGzeYUGQOPxUfAsCPFEJ4ecBNH78Ac6bKFsDWa9ba4PQ==
X-Received: by 2002:a05:6a00:9454:b0:70d:34aa:6d57 with SMTP id d2e1a72fcca58-713c4dd32d6mr11998714b3a.4.1724057016476;
        Mon, 19 Aug 2024 01:43:36 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e4c6sm6208566b3a.76.2024.08.19.01.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:43:36 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:43:30 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCHv2 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <ZsMFspiLZojq3EIO@Laptop-X1>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
 <20240819075334.236334-2-liuhangbin@gmail.com>
 <a60116a2-bcbd-4d0f-9cfb-7717c188e26f@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a60116a2-bcbd-4d0f-9cfb-7717c188e26f@blackwall.org>

On Mon, Aug 19, 2024 at 11:02:14AM +0300, Nikolay Aleksandrov wrote:
> > +static struct net_device bond_ipsec_dev(struct xfrm_state *xs)
> > +{
> > +	struct net_device *bond_dev = xs->xso.dev;
> > +	struct net_device *real_dev;
> > +	struct bonding *bond;
> > +	struct slave *slave;
> > +
> > +	if (!bond_dev)
> > +		return NULL;
> > +
> > +	bond = netdev_priv(bond_dev);
> > +	slave = rcu_dereference(bond->curr_active_slave);
> > +	real_dev = slave ? slave->dev : NULL;
> > +
> > +	if ((BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) ||
> > +	    !slave || !real_dev || !xs->xso.real_dev)
> > +		return NULL;
> 
> No need to check !slave again here.  !real_dev implies !slave and
> vice-versa, if it is set then we must have had a slave.

Ah yes, I missed this.

> I prefer the more obvious way - check slave after deref and
> bail out, similar to my fix, I think it is easier to follow the
> code and more obvious. Although I don't feel strong about that
> it's just a preference. :)

I don't have a inclination, I just want to check all the error and fail out.
If we check each one separately, do you think if I should do like

	if (!bond_dev)
		return NULL;

	bond = netdev_priv(bond_dev);
	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
		return NULL;

	slave = rcu_dereference(bond->curr_active_slave);
	if (!slave)
		return NULL;

> > +	WARN_ON(xs->xso.real_dev != slave->dev);

Here as you said, the WARN_ON would be triggered easily, do you think if I
should change to pr_warn or salve_warn?

Thanks
Hangbin

