Return-Path: <netdev+bounces-245257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ACACC9DDA
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58BFF3018407
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013D1A267;
	Thu, 18 Dec 2025 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNjn1GvF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A24171CD
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766016628; cv=none; b=IiPk+PTzJDoUrLOSsVX5SAJ2WN/Mc9H6fqsghdHhIFRRx8umk1bDzVMQKVZVIhTGlfWo+4F0L+jx0o8cHrY43Q65yOBKY6xuwHFG8WuNH+tHl6MfxnghDjK+n0JbyUUprTZwM9GmkL3obV5+kBpC8kt/of3yCpGuO4Yr+iGExq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766016628; c=relaxed/simple;
	bh=J5NyHXC+7Wm9QwKSKoWElXZBdxjlmPCyBCY86nHZirA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0+lvz4k2YukxjUlN/khxP9nS8N2uYp0C7sC2cpuQY0j+tXrn0Z8Umpy6hMJ0/G/yeNB/nnXQlH/ZzRA7VUqZiRlk+imAAZSZrEHQ9w3GrD+rRfiYg1DqmyXHM1OMqHRql4fm7toAz0qnNkQJIpgesFUqcv2DpSW2NoH2348Hu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNjn1GvF; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78c5adeb964so272527b3.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 16:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766016625; x=1766621425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3W89pyc3rg2AiFaQ7BjoDtkih3iRc+2gyLPHWeN7+U=;
        b=nNjn1GvFh4xqK36Ukpr1ShbbCAwjDPghqhXIol2sUEj7lgY43bsKSHkqdlIYCkk71X
         3An9DiXZhc3QgGdGfXjH0TxCvT6VKj7hcxGuvRPruMK5A+Vt5ICq7X5VAm9S0Eqnvh++
         4SuAvKaulAEoLdvdjNi7lHDpEVOwknD48rCTnO7CLSGT59WR4IJo5pRrlSZAvXwC1ogS
         tfuEwFd8bvho89+kFczWxVcvaFXygz2GZBYG3O+/8ZGzNt+TlDqOEpK1xaHRk61HFYSs
         yuSZH0qMZKeR7h8DQcB+oaicUTjYsteelz0xHe6Iho+CtvyjgvybyaPiWnsZ5KHkBQAL
         95tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766016625; x=1766621425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3W89pyc3rg2AiFaQ7BjoDtkih3iRc+2gyLPHWeN7+U=;
        b=D5teyERagaLNlD4YVd/noKb58d4wt+wd0a87PcLwYD9ury6Jx4QuNcGQ6Bn4pEs2a7
         0DCjD03k0GYWrYUmkaUNMo8fZp25BOp+FwNXz0Rufcfey/efXbWGY54Jhw9/KdV1jtGo
         P+s//pWtBhv3X37xGJ1TR4NWlgvxzGrdJKBsIFSieOLHNYQx//jhmRABeLiwb7eDwCy6
         GzxssS1MijhUrFItsDJcTRclshPns6quKsWIg6jEe3VWBVkTwUgeLuzLourCkgoWlC2Y
         gWFgyFiL213GSmbvOzrCbI0DrLtHbRPOMOPJGItMnchubXMCA6Bu83urUShrkPgKJ1xv
         9/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUEMA+tMUO8gafQPuofHH+P2QEluXFdiBWqevzp8wHu97rFpcBXtJsGHw92l4Mfig8GLTGuGNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscALLnpgtcerDwzSFNY7MOsLbAW4yMxcF7Sf69SFNgbSsNI4o
	GaFyuOQYKkJrJ+Bswk9A6mdsoEQ2/BL4EdnCNxBmJ5pu5ofQ6ik+trIZ
X-Gm-Gg: AY/fxX5vPgjQnbsdl+i2EdLIU/tRq+76b/I/b38pVv0TczbeNRVc4sGU3qh/2wUdM6O
	+z+tWVT3UVWUZ1R3hMIqFRW5aF4jMZ4mJW6iCcB//79y9suWZGae/tg+hjCgSOb+pl9WiO1Yk26
	+GWpIZS2sg21AvfTG/6zdC1Koo84QznqO3+N+AvvtTfkfhIIARaDLboN0XXYmCnzb0WmaylktNC
	9R+Yvs+iJ++Zedne0Bb6rVHt9YBNIrBB3x7NTXtIzkrWpI4xuOSvMZjT9JMNAPM8/Pr3t5GGBG4
	9zvyJ68GSdGDsGYqDQt4b4i5GtAU3Y7CXuBUeIySlNOVAhImdWzbIWx/VvOpDtQUJVx1sUzR8sW
	ILFrkq1pQ4CrusMUgRutk4u92pcCGI1Oz5zHhYu6oiVJqdeuQmReG5QzvFIgh2fM/4gtXaZrhMP
	/W5OUm07I=
X-Google-Smtp-Source: AGHT+IH2XIrCa3obcmS9LSxT+b2x4iIbstcTGrPYEvranoS2UiwzkeKdXa5tDCty5uxlxz7AlyzCTg==
X-Received: by 2002:a05:690c:7088:b0:788:1086:8843 with SMTP id 00721157ae682-78e6694fc4dmr179993397b3.2.1766016625556;
        Wed, 17 Dec 2025 16:10:25 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:52c0:aec0:bf15:a891])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fa72bfb0bsm2440077b3.53.2025.12.17.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 16:10:25 -0800 (PST)
Date: Wed, 17 Dec 2025 19:10:24 -0500
From: Yury Norov <yury.norov@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 08/16] bitfield: Simplify __BF_FIELD_CHECK_REG()
Message-ID: <aUNGcDLfe2AhWgkh@yury>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
 <20251212193721.740055-9-david.laight.linux@gmail.com>
 <20251217102618.0000465f@huawei.com>
 <20251217223155.52249236@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217223155.52249236@pumpkin>

On Wed, Dec 17, 2025 at 10:31:55PM +0000, David Laight wrote:
> On Wed, 17 Dec 2025 10:26:18 +0000
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> > On Fri, 12 Dec 2025 19:37:13 +0000
> > david.laight.linux@gmail.com wrote:
> > 
> > > From: David Laight <david.laight.linux@gmail.com>

...

> > > ---
> > > @@ -75,8 +59,8 @@
> > >  	})
> > >  
> > >  #define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
> > > -	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
> > > -			 __bf_cast_unsigned(reg, ~0ull),		\
> > > +	BUILD_BUG_ON_MSG((mask) + 0U + 0UL + 0ULL >			\
> > > +			 ~0ULL >> (64 - 8 * sizeof (reg)),		\  
> > 
> > Trivial.  sizeof(reg) is much more comment syntax in kernel code.
>                                      (common)
> 
> Hmm. sizeof is an operator not a function.
> Its argument is either a variable/expression or a bracketed type
> (I don't usually put variables in brackets).
> So 'sizeof(reg)' is nearly as bad as 'return(reg)'.

Please re-read Documentation/process/coding-style.rst:

3.1) Spaces
***********

Linux kernel style for use of spaces depends (mostly) on
function-versus-keyword usage.  Use a space after (most) keywords.  The
notable exceptions are sizeof, typeof, alignof, and __attribute__, which look
somewhat like functions (and are usually used with parentheses in Linux,
although they are not required in the language, as in: ``sizeof info`` after
``struct fileinfo info;`` is declared).

So use a space after these keywords::

        if, switch, case, for, do, while

but not with sizeof, typeof, alignof, or __attribute__.  E.g.,

.. code-block:: c


        s = sizeof(struct file);

Do not add spaces around (inside) parenthesized expressions.  This example is
**bad**:

.. code-block:: c


        s = sizeof( struct file );


