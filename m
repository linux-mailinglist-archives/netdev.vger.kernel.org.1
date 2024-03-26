Return-Path: <netdev+bounces-82215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCADC88CAFB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07221C25E21
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529421CD32;
	Tue, 26 Mar 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ye/nFUpE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFE1C6A0
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474409; cv=none; b=l806qqGc6/PFmeBZXg96QXWtc/GOD9SxM0N0DAAzUtsebUBaO0kA7XTFowqw3VxzbcbBl1ryq5efNpFQtZDwMgxDNa8yUfpBbllyjguN++0jt9ydOE7tRFsUXY2uLjvZ4KT0Ikzt+zjzc543/LZixujU/qc4gpj11Vr7jpd4aco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474409; c=relaxed/simple;
	bh=373Fk+gGLXUIiv9G2GR/Cr1Ybl57zRv6b5lFQRQwErM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AU8rUaZ8/gVwgeK4RyNaHDnuFK+UBMHlvIjCv9DRGYglrxpW8A2qMNA0yZ2k5q7oSZjqarxfHgnAo92hHj8maSOs3QVJXXEvWA3CLzMS2qBTEdbUm83N8yLmAudwRtKWm4BckvOIWsMd82vZWB7aGgAHm5IogkFRTOhZr904mrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ye/nFUpE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso5330522a12.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711474407; x=1712079207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWPWLHAav+gD8CE06li3dolCMFsmOMr/5bRUqq0thYg=;
        b=Ye/nFUpE6651ZdWpqbRSMnZNBjGZN9MDrx8aa/Z9R95X8lfvAft1a7Z4f+WF1FPo/E
         V+u88gM7sy0StWASAKqB3fN3S/oE+0iWmnVcIT5XK3UHd+n/vCEMG6rC7DxowQlBZ3E0
         OTfHbSoMr9D3RB0K6R33RllkoTlXCsmMpUGLs1AuTF71bz9CbmnmrzRzaSmljqI07YAt
         OUOQxYZxdGp7WOAeHrm1+8pMSjHZQ5CB2dWupikec7Z66oaAMArtf3tK+jwlDPpfK4bm
         0Mpw7BALe4eVmEOzAZGziL+Ar+jpsJT1FdZA+EbnHnQI9qMnpP/KjBP26MaawREy3NSv
         n44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474407; x=1712079207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWPWLHAav+gD8CE06li3dolCMFsmOMr/5bRUqq0thYg=;
        b=ln3a/beoLA+CqwWaQL3MGruoPmcv0yY8t89y89h32Oa1U8m7DTF2eyAPbK5z+E+xtr
         4AIFzHkHTvgVY8/9XUQKn6f2kGARXIN8/oBOdb+ZOpPbAdpMEPEcAvANGiNv3P8nZ4FF
         E+mwclr2hR7GF6sSh0BdyJmK14BMC8YgSOkY+YDxCTSMKt7vySN+OiyAn432tZzj+8o4
         cOHtyUmG8YvrXwgASjn2xgvA+zSATUFKjy/5JaO4M0n8n696ednzjABrlEwVKbilFQY3
         4H2w7HKGuAwOwnxQoH5shPTzZ2NRTJXreh0JfWjpWQVshL4aMl5N+oLCK4AazLP26Oln
         o1+A==
X-Forwarded-Encrypted: i=1; AJvYcCWLIqF8SQq7KFsj2pyFadfHM6BapjwYmOkdeUPJ7kdd1O9cHTlS0hUDsD9u/EKOga33iYj3GpNJOo/jqWNvgZnppbE47nrN
X-Gm-Message-State: AOJu0YwGFjOIPx6f7dnL9nqExIO4OPsAsyZ1N+Z7PsD4R+iiNiVmiBMS
	ZtNgkr2Pij/pliOIW/m5kf4e9sFGxm1hALCmC0Usou7z2zb3/mskrongTmUjMgB8Gw==
X-Google-Smtp-Source: AGHT+IHSyVSndrBR5svSkVkwwB5Blc3qxA7f18B4jw9SEzmcX6jxP/csrhhHHn3Hd9JUiD45u3MnKxM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:1c3:b0:1e0:a1c2:2681 with SMTP id
 e3-20020a17090301c300b001e0a1c22681mr232639plh.3.1711474406763; Tue, 26 Mar
 2024 10:33:26 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:33:24 -0700
In-Reply-To: <6602e8671ecd0_1408f4294cf@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325223905.100979-5-johannes@sipsolutions.net>
 <20240325190957.02d74258@kernel.org> <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
 <20240326073722.637e8504@kernel.org> <6602e8671ecd0_1408f4294cf@willemb.c.googlers.com.notmuch>
Message-ID: <ZgMG5HGWSmS2KbBr@google.com>
Subject: Re: [PATCH 0/3] using guard/__free in networking
From: Stanislav Fomichev <sdf@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 03/26, Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Tue, 26 Mar 2024 09:42:43 +0100 Johannes Berg wrote:
> > > On Mon, 2024-03-25 at 19:09 -0700, Jakub Kicinski wrote:
> > > > On Mon, 25 Mar 2024 23:31:25 +0100 Johannes Berg wrote:  
> > > > > Hi,
> > > > > 
> > > > > So I started playing with this for wifi, and overall that
> > > > > does look pretty nice, but it's a bit weird if we can do
> > > > > 
> > > > >   guard(wiphy)(&rdev->wiphy);
> > > > > 
> > > > > or so, but still have to manually handle the RTNL in the
> > > > > same code.  
> > > > 
> > > > Dunno, it locks code instead of data accesses.  
> > > 
> > > Well, I'm not sure that's a fair complaint. After all, without any more
> > > compiler help, even rtnl_lock()/rtnl_unlock() _necessarily_ locks code.
> > > Clearly
> > > 
> > > 	rtnl_lock();
> > > 	// something
> > > 	rtnl_unlock();
> > > 
> > > also locks the "// something" code, after all., and yeah that might be
> > > doing data accesses, but it might also be a function call or a whole
> > > bunch of other things?
> > > 
> > > Or if you look at something like bpf_xdp_link_attach(), I don't think
> > > you can really say that it locks only data. That doesn't even do the
> > > allocation outside the lock (though I did convert that one to
> > > scoped_guard because of that.)
> > > 
> > > Or even something simple like unregister_netdev(), it just requires the
> > > RTNL for some data accesses and consistency deep inside
> > > unregister_netdevice(), not for any specific data accessed there.
> > > 
> > > So yeah, this is always going to be a trade-off, but all the locking is.
> > > We even make similar trade-offs manually, e.g. look at
> > > bpf_xdp_link_update(), it will do the bpf_prog_put() under the RTNL
> > > still, for no good reason other than simplifying the cleanup path there.
> > 
> > At least to me the mental model is different. 99% of the time the guard
> > is covering the entire body. So now we're moving from "I'm touching X
> > so I need to lock" to "This _function_ is safe to touch X".
> > 
> > > Anyway, I can live with it either way (unless you tell me you won't pull
> > > wireless code using guard), just thought doing the wireless locking with
> > > guard and the RTNL around it without it (only in a few places do we
> > > still use RTNL though) looked odd.
> > > 
> > > 
> > > > Forgive the comparison but it feels too much like Java to me :)  
> > > 
> > > Heh. Haven't used Java in 20 years or so...
> > 
> > I only did at uni, but I think they had a decorator for a method, where
> > you can basically say "this method should be under lock X" and runtime
> > will take that lock before entering and drop it after exit,
> > appropriately. I wonder why the sudden love for this concept :S
> > Is it also present in Rust or some such?

It's more of a c++ thing I believe: https://en.cppreference.com/w/cpp/thread/lock_guard

Not that anybody is asking my opinion (and my mind has been a bit corrupted
by c++), but guard() syntax seems fine :-p

Rust's approach is more conventional. There is a mtx.lock() method that
returns a scoped guard that can be optionally unlock'ed IIRC.

> > > > scoped_guard is fine, the guard() not so much.  
> > > 
> > > I think you can't get scoped_guard() without guard(), so does that mean
> > > you'd accept the first patch in the series?
> > 
> > How can we get one without the other.. do you reckon Joe P would let us
> > add a checkpatch check to warn people against pure guard() under net/ ?
> > 
> > > > Do you have a piece of code in wireless where the conversion
> > > > made you go "wow, this is so much cleaner"?  
> > > 
> > > Mostly long and complex error paths. Found a double-unlock bug (in
> > > iwlwifi) too, when converting some locking there.
> > > 
> > > Doing a more broader conversion on cfg80211/mac80211 removes around 200
> > > lines of unlocking, mostly error handling, code.
> > > 
> > > Doing __free() too will probably clean up even more.
> > 
> > Not super convinced by that one either:
> > https://lore.kernel.org/all/20240321185640.6f7f4d6b@kernel.org/
> > maybe I'm too conservative..
> 
> +1 on the concept (fwiw).
> 
> Even the simple examples, such as unregister_netdevice_notifier_net,
> show how it avoids boilerplate and so simplifies control flow.
> 
> That benefit multiplies with the number of resources held and number
> of exit paths. Or in our case, gotos and (unlock) labels.
> 
> Error paths are notorious for seeing little test coverage and leaking
> resources. This is an easy class of bugs that this RAII squashes.
> 
> Sprinkling guard statements anywhere in the scope itself makes it
> perhaps hard to follow. Perhaps a heuristic would be to require these
> statements at the start of scope (after variable declaration)?
> 
> Function level decorators could further inform static analysis.
> But that is somewhat tangential.

