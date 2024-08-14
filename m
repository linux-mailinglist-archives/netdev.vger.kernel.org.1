Return-Path: <netdev+bounces-118304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFB9512F1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 05:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B98CB244CA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 03:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9EF2E651;
	Wed, 14 Aug 2024 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/AIsDFr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306F8485
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605071; cv=none; b=Y/gIx2cUYwBJyPqgfIALAGg+kO+Xj8pUBqAsGCbaBhguS6Hpn80RlIUMOLPIndZN2bpbfsI9WgJjpZm6wmv4F6aOWiFwvZUx0O00yROK9UondfeWOiOhDet24CxApVI7cA5275aYmHTZiLHmN8LS8XifoeYKS/U/HoE+jE+LuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605071; c=relaxed/simple;
	bh=4svmj07sHy1LTo1VzbZv5axyu77Ox0/sA1cAkYloLFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akLrdhia0D/GaRYXlzK5OKkxs+aqNQCDUFhcW7Z10MhW59WEDy1+pOWgRHcNuPV3gqx+OqG/pMXJx5s0GtJx3lwHxbX0CYo97wEWD0YQGMrvsGO2BE3QQ64Wzl/7mck+pYYsGo5hbUkV4AddA/8ms0RxgjtnHZp3htzYbXxseVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/AIsDFr; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db14cc9066so4102741b6e.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 20:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723605069; x=1724209869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ma9XMEMkvqkDTNdHIE1jnW7Yd0VgRjzDTQ7vQExuy8=;
        b=J/AIsDFr8Fhm8rSS7alLiVRKO/mMOl345ycMwFnFvKtA51acFCflgOVfqkKFH5Ugw9
         mwoUd60Vi1C5wf6iDaUEmE28t9NBOn4CyU0HdZg88ppL+vSSp22WzE/7VP66bqz0o8FW
         YtLoIXk6aMTTAz/sMYxpOvqdMb1UWVGdxKaxDGSjzy99nE8AWJ2PRr+rJ4b170ScJ6lI
         01YQU5v71vq8c0XRRhLX5lYD0gmkXVvMPxC1Ob7Lm6fdpvlnzujDeglrt8wniSmJHa2E
         RjC9fLvvZrllM67iDGq39hypHsCzufCdRLMiPN0J2VRrj+5AXvjgaBgX4EorndNxRjuq
         Vowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723605069; x=1724209869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ma9XMEMkvqkDTNdHIE1jnW7Yd0VgRjzDTQ7vQExuy8=;
        b=oT4xYI88NC7i2UE55a/p1EV2FpZ3WDsuNWP6YiiaAf6d+qAVCaYR717FdtW8S9+8gd
         bwznYuzcJTX88qnQ5H+2n66hgR8qXKEdtOKbwzhjpUO0qVIG+lnOcZUB+A91Gjf86ZOH
         iqGwpfoiTCIXL49e+qOTk6PucJRqrJ6JyzBJhpNTMpAyF3DG/RS+Xwx7ZmzWtpcWZZL1
         m0/XWHx0qvMcmZa3sC6kf7uXj1ogcAeyS7mm+sjhWseIT+sMXZPvm5S2/BknKppbX00r
         BsHOihGl1y49BPLpJLKWWlSMKZ6eWY0FzMisS/90c+eQpSKu4DH8pCzrgJzJG0W0/12P
         9C3A==
X-Forwarded-Encrypted: i=1; AJvYcCWjZQ8KYIAtF3S0ITPrKVb3gmhYQQ8RWEuSSt/oSxCccpilLH+qzlAaVp0BXgmqw8raSBhnrl84guWfDZWac9sYkdeRGOS4
X-Gm-Message-State: AOJu0YzJdjwj2k1RnNUXNZtoKR1qGRMI8pLT5Fm2AQF6xTFaI5N9Xj6t
	jKtx/YT2pkRaxqxbtwH18UeB1UbFvph/so6FzMB7fAkBspQPJTu+fFKm6m8mkCGpgA==
X-Google-Smtp-Source: AGHT+IH2PGrat5S7EpeWexqCLerPEi6q+sUhsPG1oiyKx8E6Q/TBPWj2r0PoNIHHTePAHqM1edcGVA==
X-Received: by 2002:a05:6808:11cf:b0:3d9:3e48:8af7 with SMTP id 5614622812f47-3dd2996a62fmr1449574b6e.40.1723605069248;
        Tue, 13 Aug 2024 20:11:09 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a53c45sm2177848a12.59.2024.08.13.20.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:11:08 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:11:01 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	"andy@greyhouse.net" <andy@greyhouse.net>,
	Gal Pressman <gal@nvidia.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Message-ID: <ZrwgRaDc1Vo0Jhcj@Laptop-X1>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
 <20240805050357.2004888-2-tariqt@nvidia.com>
 <20240812174834.4bcba98d@kernel.org>
 <14564f4a8e00ecfa149ef1712d06950802e72605.camel@nvidia.com>
 <20240813071445.3e5f1cc9@kernel.org>
 <ad64982c3e12c15e2c8c577473dfcb7095065d77.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad64982c3e12c15e2c8c577473dfcb7095065d77.camel@nvidia.com>

On Wed, Aug 14, 2024 at 02:03:58AM +0000, Jianbo Liu wrote:
> On Tue, 2024-08-13 at 07:14 -0700, Jakub Kicinski wrote:
> > On Tue, 13 Aug 2024 02:58:12 +0000 Jianbo Liu wrote:
> > > > > +       rcu_read_lock();
> > > > > +       bond = netdev_priv(bond_dev);
> > > > > +       slave = rcu_dereference(bond->curr_active_slave);
> > > > > +       real_dev = slave ? slave->dev : NULL;
> > > > > +       rcu_read_unlock();  
> > > > 
> > > > What's holding onto real_dev once you drop the rcu lock here?  
> > > 
> > > I think it should be xfrm state (and bond device).
> > 
> > Please explain it in the commit message in more certain terms.
> 
> Sorry, I don't understand. The real_dev is saved in xs->xso.real_dev,
> and also bond's slave. It's straightforward. What else do I need to
> explain?

I think Jakub means you need to make sure the real_dev is not freed during
xfrmdev_ops. See bond_ipsec_add_sa(). You unlock it too early and later
xfrmdev_ops is not protected.

Hangbin

