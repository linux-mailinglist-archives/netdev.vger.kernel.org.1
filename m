Return-Path: <netdev+bounces-148258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5829E0F5A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499DF282F9B
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF531DF98D;
	Mon,  2 Dec 2024 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="TsBMBvrs"
X-Original-To: netdev@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989F2C18C
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733182803; cv=none; b=Lh857IxTUXfgetdyVoxfo8VXgS+Ygzvi73QWW71aaAlJg7zwPoN4DfQZzgiBcWf1nrx9ptczUYj9XuC+5SqUJ/mFY6BMcKjQxLI9wYYect8XTKXZ0g1CiTBCUIN97sFVpItOlnHhFyeINz0IWo86dyXOmjZAZl+q/aqXIeH8pPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733182803; c=relaxed/simple;
	bh=4gjAVY4OYuN50ODxCgl16+VftGhCCo/MUzXgNFT7wZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGAJ7kuM6btrxtTaJ8GXOPzX3CkqDOj1HQwV5sbpv1LelBD29c8iQdEQO7r1Jlc1K1iL/waXkHjpdHV9wFnhHluhsyYIPGOByWfV3O3BLLJmUUGvy3wbzPk9Ry8k7fKQbofII+Lo+PBYQkKL83Us9MujURt4vPP4nd+wnO+NzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=TsBMBvrs; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=TsBMBvrs;
	dkim-atps=neutral
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 6E754A5C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 08:40:00 +0900 (JST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2156cb2c3d2so29001875ad.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 15:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1733182799; x=1733787599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A57IVvMQMWpZURImpjt3A/mUfeqlUYJ7SlKp08jMs20=;
        b=TsBMBvrsrNaYm6nJFseiRhLZXP0UrLiH+b3WAbbWFNORLeqgJ2ZAJ08h0WPQU+z40F
         xjijansele6XeVWK+H1jtlnWExwAburOgTFTCRsYblp2kZII3ywrHMQc4b+XBux+6yOr
         Gj4wbWMFE2D9UmSDvycn4iF9NTi7EPDa3emGAW7jO0niCM72JFNrd9r2yuarsadPNggP
         dUpDFSRejOKCRWIqnPZkd3fllbed0OmyAEIYA/fEad/gCF5xA/GjIu4ZGxbpwGrYHB8e
         t7WunsLK757oDH+HnPWeXjFG2r44T1YfVt3ZR6CY159XlprYVx5EyF+YCEj2vz3hNKvh
         zypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733182799; x=1733787599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A57IVvMQMWpZURImpjt3A/mUfeqlUYJ7SlKp08jMs20=;
        b=IXL0jbx2qkhiPJS9oemKn6zWGKqu0HPhNNw52uLIuJnyXVPuR0tYUUnZUK3529p2QQ
         Zq+/2u2Aj7rspuxGirBxEa2rBMsO8ylHv+CLyfWD5DBnmOhKgW8GxqS8QhF0vKkdLy/7
         d6eIshDExp+oHZoi7awjlA250s48xYOwhR4/vMFmexuB4l+NF9B8TonijXTisa50zcRy
         pP5WYiu8ggV004sw/VRjAHFNvDylKKIHpNdR1YMIdQ6+L8E/hAdKTpsb4woCQGPWB8Dt
         2KyUtp3tAjH540nUV52Pkk9TwoztTOSXIXBNLaT8DASA1bXc0vXi5/wLtr2g/vPYqkID
         z6eg==
X-Forwarded-Encrypted: i=1; AJvYcCVokP3aZ05u9oXpcQdeEmvvswt8L4ErWCX9GruAoHHBRDjA7ackUdHnqdbZ2n16YYGsNtKjbkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTIBbUNkPrgHFdaXFfa5EdPQZnEGJQhsawej9VvRLEm2Dk1lT
	Ng9WnTQOQkU7YMhiw8IGDAIp8+DFeGFZRBDmhA5aM3zHodnZSRqhd+bAPrPy28jKY4wfZFH2mJt
	Gxg7o9z1MaYZef389ee5kDslqDaGbVGUoqC2Z6G+YHSMwpu5fMJjyxR0=
X-Gm-Gg: ASbGncvPoj0JWy29j4TmK4xs0+Htd0LJw3JPcpasnSse93POPBbDkJqYS4CUaU8t1Zq
	ttSc+9QfhHAEqA7K1mMuuMr1zn4nUg+BcB5/Pv558InlIIG5eXQRoDSJjOKIfiJcfuFdwn3pY0T
	E/IWHnqMCgJco3OhT7dZvZsVsuVFsHmrYz/jS18aWb84jFVvt2qARSRIAerlSxBqPVdYH3bNiig
	GirkjCUoPHxbImChCiJOa42qgQyKFTXfC2XNOBy9tte3+8+kNsnjyMQUcCn/Otfd+C1+nAy1/FD
	Bks7uZyqlWhze1lg3BywETPBJ0kDRxv5EQ==
X-Received: by 2002:a17:902:e743:b0:214:f87b:9dfb with SMTP id d9443c01a7336-215bd21460bmr5675275ad.30.1733182799370;
        Mon, 02 Dec 2024 15:39:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSpv35whPLoYVIW8MOIAvFy4eJtv1taQ80g25b5fafKIkmE78plxhee1SHI5mTvk3cqSdymw==
X-Received: by 2002:a17:902:e743:b0:214:f87b:9dfb with SMTP id d9443c01a7336-215bd21460bmr5675005ad.30.1733182798959;
        Mon, 02 Dec 2024 15:39:58 -0800 (PST)
Received: from localhost (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154e33e47dsm56875505ad.158.2024.12.02.15.39.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2024 15:39:58 -0800 (PST)
Date: Tue, 3 Dec 2024 08:39:47 +0900
From: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Laight <David.Laight@aculab.com>,
	Oliver Neukum <oneukum@suse.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <Z05FQ-Z6yv16lSnY@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
 <Z00udyMgW6XnAw6h@atmark-techno.com>
 <e53631b5108b4d0fb796da2a56bc137f@AcuMS.aculab.com>
 <Z01xo_7lbjTVkLRt@atmark-techno.com>
 <20241202065600.4d98a3fe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202065600.4d98a3fe@kernel.org>

Jakub Kicinski wrote on Mon, Dec 02, 2024 at 06:56:00AM -0800:
> On Mon, 2 Dec 2024 17:36:51 +0900 'Dominique MARTINET' wrote:
> > The new check however no longer cares about the address globality, and
> > just basically always renames the interface if the driver provided a
> > mac ?
> 
> Any way we can identify those devices and not read the address from 
> the device? Reading a locally administered address from the device
> seems rather pointless, we can generate one ourselves.

Would you want to regenerate a local address on every boot?

This might not have a properly allocated mac address range but this at
least has a constant mac, so the devices can be easily identified
(without looking at serial properties)
.. I guess the generation might be made to be a hash from ID_USB_SERIAL
or something like that, but if the device already provides something
stable I don't see any reason not to use it?

(With that said, I don't see anything in `udevadm info` that'd easily
point at this being a modem point to point device under the wraps..)

> > If that is what was intended, I am fine with this, but I think these
> > local ppp usb interfaces are rather common in the cheap modem world.
> 
> Which will work, as long as they are marked appropriately; that is
> marked with FLAG_POINTTOPOINT.

Hmm, but the check here was either FLAG_POINTTOPOINT being unset or not
locally administered address, so to keep the usb0 name we need both?

>             if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
>                 ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
> -                (net->dev_addr [0] & 0x02) == 0))
> +                /* somebody touched it*/
> +                !is_zero_ether_addr(net->dev_addr)))
>                       strscpy(net->name, "eth%d", sizeof(net->name));

i.e., something that didn't have FLAG_POINTTOPOINT in the first place
would not get into this mac consideration, so it must be set.

My problematic device here has FLAG_POINTTOPOINT and a (locally
admistered) mac address set, so it was not renamed up till now,
but the new check makes the locally admistered mac address being set
mean that it is no longer eligible to keep the usbX name.

... Would this check just be fine without any mac check at all?
e.g. anything that's not flagged as point to point will be renamed ethX,
and all non ethernet or point to point keep usbX.

-- 
Dominique

