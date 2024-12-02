Return-Path: <netdev+bounces-148024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7049DFD7D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71BCBB22539
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF7D1FBCAB;
	Mon,  2 Dec 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjOr6S7a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE81FBC84;
	Mon,  2 Dec 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132715; cv=none; b=sEmfzs14AM/3/C5zQ5aTTz8urlmnq0WOSmlbZQlMRK7q+U2I7rjbL/VAajrJ73kuAG5eEvhznkkuyHKne+S3jcbG2EB1siBAVSWWtKsZ+XqXe3+IJC0TQyqg4kKc9yESBHEoFRMAbCJ3uh9gCjWvvgvGCZqgb+nbd8IXOvZmPLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132715; c=relaxed/simple;
	bh=51xoLAkhTufBIA9HOpl57rXM2Uu/lZB808CkH/uV66M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpzjEQbeZ0y9y1W1q+AYK3yUlom4NIttllmsAGZ3nDy1xKHXMbyyq/5oKhqJEBZF928of01LDdb3+Cf0VEKnk9FJp+/nLxYqDrn92PnhrRDid716Ia+/VTBLMRWuqc7fPp/LQlSpaWyRHZThP9xVDWI0opBKxwqEis90AnGufAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjOr6S7a; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4349fe119a8so4782195e9.3;
        Mon, 02 Dec 2024 01:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733132712; x=1733737512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=51xoLAkhTufBIA9HOpl57rXM2Uu/lZB808CkH/uV66M=;
        b=DjOr6S7aWDbFzmbrhXMWNGod93s5pKEoiqTndnl4KhmpvMWfEfiBA1uG+/QVx85Z7W
         ut8BZjcgGXQDgmhPhdgKM02foWbNrDJnIaPgMARxgJszqLIOWpYq9jXiTiCiml8q70tt
         /ENhaDaI11YmLpLmniB35f5xlXvmX1KfPNJtb39NznX2+hOES5D+oySF5D2o3ivcSwiw
         clKK9BYGCMERaLAs0OHE0YMVx/Q7A4W1BfbHHytl/t7Rdglsm3KkCVogW0Ko7rfB7koo
         n1pcexkuaoSp3Qcxwk5FQTDVgoEKjZs9Bs0HvKPHdJ5GzvlxF8CBOu1idflS36ffIHaU
         yMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132712; x=1733737512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51xoLAkhTufBIA9HOpl57rXM2Uu/lZB808CkH/uV66M=;
        b=ReZPYDGranpmG94ykxKin+AC9XKblabEkSmTahriSijDZ/a+5HKS0tpkgs72sSv2+y
         quQkX5PeF7oSFQccnh6Lrcd+Xtxclvc+rv6tXjWEAd2z5TCJmh+zn1UD4SKoAb5P1mL+
         yDMpIMe4hQoKGAQhKmu0eV6y+I4ItPCEkqImAvjhfc6dibCAzN3WRa+QwdBDi5GnrOkD
         dQiuOVjJWYC2L4gKgxmZER5K1jWHTRE6boVe9Rb5uaJzEnlwOji5eAgwvzVwAMFLCv2T
         4gcojwIDdslqFANseO71ql+TisPCwHVy5E7hJ7DIyEGojL71AFmxpAcb5/ekFn+XutCU
         Updg==
X-Forwarded-Encrypted: i=1; AJvYcCWzVmKucNJAWFAGj2tp5t5ui0dO5+61mBmas0OYZhaoBUvLzHFZOMaWtAt4hHPIZ7saQd1XcjV1@vger.kernel.org, AJvYcCXPKCXqmR3AUZhqNGquo4g4eSpjGUZSlWu6/zjWunO870LsSXMrnioBrbmlLOPx3ifw00Mm/sQ+6E/oRdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYY9Tr4tO8aPYhDYkfcbhkG2CYCDYC56Cg/RCT11c5epm38qZ
	ebbSeqct0BsdkyLmj2P8nskmzm/zYKdm4VQHUG7Wk6TEHSiMikTa
X-Gm-Gg: ASbGnctbZjx6g/d+fwWn1TfBGyoOIHThX6yQpKZA85pyH3SJ2vcuM6ZwUPnuTUuFC5L
	p3aa7F2P+Pz2YgoyUkUHsRWOFPh4Kw8euYR813l536gIzEmVxXXc9CHQifTzi5qgZoYCRsRrC7a
	2a9Uom4cCPPyn6l5TSTDEBcp7KDCD1EcoNXpNbH/LXGNrt7hTDE7i9+iVZ75YJ/Df1g0aObSOIq
	ddgsuUpEJ8Gx+sJj+NCmMfs0Oedu2QIviHwtP8=
X-Google-Smtp-Source: AGHT+IEuYclXXR09MY6JDK/i4V5elV4W4dMYdC9NzyCywPNjEmhe1DHbKBV1L8OOEQIsAUAfxTCvVw==
X-Received: by 2002:a05:600c:3b16:b0:432:dc5a:b301 with SMTP id 5b1f17b1804b1-434a9e0fb94mr79126665e9.8.1733132711740;
        Mon, 02 Dec 2024 01:45:11 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa763a59sm177491135e9.11.2024.12.02.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:45:10 -0800 (PST)
Date: Mon, 2 Dec 2024 11:45:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Andy Strohman <andrew@andrewstrohman.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dsa: Make offloading optional on per port basis
Message-ID: <20241202094508.4tpbed2b4amyvbsi@skbuf>
References: <20241201074212.2833277-1-andrew@andrewstrohman.com>
 <Z019fbECX6R4HHpm@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z019fbECX6R4HHpm@nanopsycho.orion>

On Mon, Dec 02, 2024 at 10:27:25AM +0100, Jiri Pirko wrote:
> Why is this DSA specific? Plus, you say you want to disable offloading
> in general (DSA_FLAG_OFFLOADING_DISABLED), but you check the flag only
> when joining bridge. I mean, shouldn't this be rather something exposed
> by some common UAPI?

I agree with this. The proposed functionality isn't DSA specific, and
thus, the UAPI to configure it shouldn't be made so.

> Btw, isn't NETIF_F_HW_L2FW_DOFFLOAD what you are looking for?

Is it? macvlan uses NETIF_F_HW_L2FW_DOFFLOAD to detect presence of
netdev_ops->ndo_dfwd_add_station(). Having to even consider macvlan
offload and its implications just because somebody decided to monopolize
the "l2-fwd-offload" name seems at least bizarre in my opinion.

