Return-Path: <netdev+bounces-148495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288319E1D42
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA17283551
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0EB1EE031;
	Tue,  3 Dec 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="LAayiy7q"
X-Original-To: netdev@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626321EE00E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231681; cv=none; b=GFAQnZ501XAQ7ShFPJ1waDdPWue+D9Bil9QaWrE8JJ2YCREPEbyiTMR9buunsNdjMvJx9W+aOFho4rHcw/HlFxI/hewjQQNyXoHEhzSjr672U+t9FvZizZqBl646EmwEepHwTAZHTetjtJD1AfgPt9gDrC+RcWj2BAORKahCJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231681; c=relaxed/simple;
	bh=R9wjQxLHnh9MCYkoa9/5GAlgdqfEmAhvBuy38flYIbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0bDOYhUCe5tvvnSV3wisExzqC7PRkC+ZmnZqB+XXDFcASX4IBLvGASCiLJTSrFiPNFe6kWdvF5tw9i9rwOBkWnHFVAy6+eS22C926x3S0s+6CSRw8h8CeZKPUn23sWKW6m78ce9eyCxl9so8JsTrd8qxQGzCkNbCU3PUW9+wJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=LAayiy7q; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=LAayiy7q;
	dkim-atps=neutral
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 036C239
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 22:14:33 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2156cb2c3d2so35561865ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 05:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1733231672; x=1733836472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTgFAUWmOx2CtV94fUahIjI61rn2jl+/rJHyu2/g+Xs=;
        b=LAayiy7qUqLO4UBnGLJoPzVyEFQ7uL15c/EPEjK+leNYaXOOEniHN3fVKknzpM2fR3
         l439bwq1OQ4Pj6L6K7GRhraO3qZEAjyFysMoIx5NmMowtZGn0Cqb6CTzPhGRgwEcvBxo
         bsxbZntMJt+ZxAwMRz+9ZQgmzLKlC5HM9aIrdVpF1kzQdUfiGtzFKoLeL6LX54W0/3Dg
         FfpWzRKe/PYniIMOgCrgI5LBbYfzOUmHuV9LwejahkRL/BOphQPKB+EmxL3AME085GXf
         bR2txRBk/BDKAQFIFbssdjTfThUk5VNFH1IRqgixUIX045gebeA2HM2aisj9UPAjNic/
         B6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231672; x=1733836472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTgFAUWmOx2CtV94fUahIjI61rn2jl+/rJHyu2/g+Xs=;
        b=uzMpNR/g677SPXT72JzTqEW0qMj3tXtn7g1cAn17uabzA0rzet9MgMwNA9zl6Bx33Q
         cItbwKH23i3ljmdED6IHxazgp+vfZhjWKlC/2afAyUvpNsrGeBsq2e5r3GglFe4cmtmj
         4o0Kcgu9tyzIS/RHbR+yQyv37NrRs1XkswvSdR+y3PpuVh+3/SszzRm+KOJEtK9+nx3u
         lPbbAFYA0IdfDwH+15GeiE8lCobY6+/Sp5A87NPuFFJbJopyfuNP8ArImwZd19TAdmVw
         s/H7FXGYNezoyKTHtHtfxaWr941uv+L7viZgBWtQW7hycfhwSC/y57DME9r8aMlpxB4+
         qhdA==
X-Forwarded-Encrypted: i=1; AJvYcCUt9Gg/SJLnV34z67zrxIz5HHD9SECDDQ+XpocVfxALbpjItFO3j5vy7FO4+4ZF0vl3l6XKlBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGX6QVAhjVIeZPMZLda7746RuzpABwxXhvGJ9EjGjsL8Zf6QzV
	/AzpSZcnSuCmPbVjKqpIAjHhndisTf4+vycRn3clRM537mgRo1OMqjNJpZwhtyjCCmuPFClgaLV
	Lr14m5Aw4JEN8xRwgyNuux5ThbDDxB3kOLYcZjrkdvXG08twIb10RKbE=
X-Gm-Gg: ASbGncvFmZOEHV9pKnUvyfWbKzDJaKiJuS+0sT3+JhFZvXeIhRZMB2mIitUEf7c3DTX
	VowMVVexnKRimbpr81jPkGMY7L5XW6wWU3IfwppHpReoQXx4PCXAlbhEy7nmgsoR48WDxt2nUcC
	awjoUUb1C9ZZZciRTexSqJqp5bydb2yI1YppV+IamSaRWgI3tZtZXlrIRmDVyHxcErhzAxFNvHu
	nT3qLKMkdbrh2+dwEjWD0QazLwi+v20T70EIAag0ffWIEW2Wz9i9oezc3QhMrkfuQgrhQ3dyZhe
	oc9q/NxQMatdD4DBYf783O0fvHcoGpzb6A==
X-Received: by 2002:a17:903:22cb:b0:215:94eb:ada8 with SMTP id d9443c01a7336-215bd26a30amr30756775ad.51.1733231672034;
        Tue, 03 Dec 2024 05:14:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi8YdzPeQ8tKvgYIo711a5eTzDv9gQAvy3Di8eBCEMJXtRmjzXlBTMFJHzTrwQxS4epjiUZg==
X-Received: by 2002:a17:903:22cb:b0:215:94eb:ada8 with SMTP id d9443c01a7336-215bd26a30amr30756405ad.51.1733231671662;
        Tue, 03 Dec 2024 05:14:31 -0800 (PST)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905f2bsm95147905ad.93.2024.12.03.05.14.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:14:31 -0800 (PST)
Date: Tue, 3 Dec 2024 22:14:19 +0900
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
Message-ID: <Z08EKwZ3DNb11x_B@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
 <Z00udyMgW6XnAw6h@atmark-techno.com>
 <e53631b5108b4d0fb796da2a56bc137f@AcuMS.aculab.com>
 <Z01xo_7lbjTVkLRt@atmark-techno.com>
 <20241202065600.4d98a3fe@kernel.org>
 <Z05FQ-Z6yv16lSnY@atmark-techno.com>
 <20241202162653.62e420c5@kernel.org>
 <Z05cdCEgqyea-qBD@atmark-techno.com>
 <20241202182935.75e8850c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202182935.75e8850c@kernel.org>

Jakub Kicinski wrote on Mon, Dec 02, 2024 at 06:29:35PM -0800:
> > Half of the reason I sent the mail in the first place is I don't
> > understand what commit 8a7d12d674ac ("net: usb: usbnet: fix name
> > regression") actually fixes: the commit message desribes something about
> > mac address not being set before bind() but the code does not change
> > what address is looked at (net->dev_addr), just which bits of the
> > address is checked; and I don't see what which bytes are being looked at
> > changing has anything to do with the "fixed" commit bab8eb0dd4cb9 ("usbnet:
> > modern method to get random MAC")
> 
> We moved where the random address is assigned, we used to assign random
> (local) addr at init, now we assign it after calling ->bind().
> 
> Previously we checked "if local" as a shorthand for checking "if driver
> updated". This check should really have been "if addr == node_id".

Ok, so a zero address here means a driver didn't set it, because the
ex-"node_id" address was no longer set at this point, and these would
fail the 0x2 check that worked previously...

The third time's a charm, the ordering part of the message just clicked
for me, thank you for putting up with me.


> > As far as I understand, !is_local_ether_addr (mac[0] & 0x2) implies
> > !is_zero_ether_addr (all bits of mac or'd), so that'd get us back to
> > exactly the old check.
> 
> Let the compiler discover that, this is control path code, so write
> it for the human reader... The condition we want is "driver did not
> initialize the MAC address, or it initialized it to a local MAC
> address".

(I was reading that '&& !' wrong here, having the check negated in the
helper is much more clear and it's required to keep the two anyway...)


> > Or if we go with the local address version, something like the
> > following?
> [...]
> 
> Up to you if you want to send this.

Thank you; after thinking it through today I think it won't hurt further
to send so I did.
Almost everyone involved is in Cc, but for follow-up it is here:
https://lore.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org


Thanks,
-- 
Dominique

