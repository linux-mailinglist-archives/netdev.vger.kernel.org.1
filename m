Return-Path: <netdev+bounces-82144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005DE88C6C2
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC67B242B0
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C4113C3E0;
	Tue, 26 Mar 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBV7sZta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CAE763E6
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466602; cv=none; b=fnj9eFj9RqXeaUOfbQEoY1KqTMRPV0S1L84E4s7MkZyXvK5DQ6u/t6OEdoFTr9zHRtheV4i84Rj5ZztzrKqQDKblfbOyJausQQXBwqOaqXgs6/+FBE+kfhOz/jYO8Dbvag6Z8g4Cc8FXN1DBb836dBZGy23D9U3iXDxh+CTNVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466602; c=relaxed/simple;
	bh=rgVyp+y2gQ3R68sBlqkf50YJlA2c0rrAoXXPG4GQ5Qg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gu9PAtEjao+VmqmJacwCO4p0SEv6GD0wFcqXBm11Whxt/CiTy3TAklZPg3w6qpiLqGIl9z+2eFoEMni58i/JINstK7QdlKNIVzq8hXQHqFU+xTnYAOdiUcE6W2KnVv47pxl6lFOhHC+YjYmmiq0xVwAreDxiW7Kf9Bopk3S7xwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBV7sZta; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430c41f3f89so49582701cf.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711466600; x=1712071400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=171x83l+ahLVp7SFOrquDIhPP+v5e1CVKqpqWTE/6os=;
        b=VBV7sZta6q9Wvd+aFsQzZm5sAlOoUnthPC1JEdK0Q6mVIN2EiArCueIrteaqXEWIgT
         OwG6Sct3ZWfk95Do+lvyp0jW9t2jE4Q4QWScGf2hgyHOC3DIQ53WuY5xJ+p/AIDTavhV
         sjCokbeOIKwkbaW32bRXuDM7yt8zDd/rnLSh/XlMroGmudsicvtQkptGihS9RtAmT/Nd
         DtZ+UFo5HVhxc6t5XtyKRBKN7kWmkri95IO3HXhxBeGynGMDo2s64C7FaUzOsUVBSPQc
         4kE0Re2X7EUsyOUmmsE1yNCAJaxkACo0bY8KXyBKZmTFef95WmxuPRZLhADwRKwNppL2
         pJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466600; x=1712071400;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=171x83l+ahLVp7SFOrquDIhPP+v5e1CVKqpqWTE/6os=;
        b=DywhLhT/R48Y3ypjh2LYxRJqz7HKAPPVIPSiiLurTaMkFyNwrOWVo94H0GW3j43m45
         SsmGwwwp2siPaCArr1IUjUI5d9/w1BsiLtpkgzTzF615bBR2Hjj3dzdg7L5zIAxCxYHS
         msqDZ9RLZxLQkzzZFWLz0fDRE7QUPaedfi8bkmK78788NlZGh4PViW8gzB7RIYWF5xuY
         yH17uuFwAN6WcwDk/Y3boBl+h5cAQF/dKP6kEUmxRk13bR0Y5EUgBQa0/aj1RUSCc3vK
         i/m4nX8VykFsmQ0JC9H7wJdL+86BO4quN5QB6R1BBmkzkVGLJvmwTUTgDRZAryBwAQZ0
         n6PA==
X-Gm-Message-State: AOJu0YxzXGfYQumQzj1jwstP/rJVTI93jVtLNxKTwfE5sIPMYqiKdFxT
	xIlHY3JnuSAyHrwNCKB9OcnG+acHTncUkDLOqe96XwpcVtrrZ+4R
X-Google-Smtp-Source: AGHT+IFZGFNAqPSDp6+2sWFIxy/+cmY6Q/iXGRpE0x+h+hitUWqLhH3rZydH2fRvXGRLl1Q03Srn5g==
X-Received: by 2002:ac8:574f:0:b0:431:3fff:b3e1 with SMTP id 15-20020ac8574f000000b004313fffb3e1mr2671617qtx.31.1711466599718;
        Tue, 26 Mar 2024 08:23:19 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id bt11-20020ac8690b000000b0043167d8c57dsm1132120qtb.56.2024.03.26.08.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:23:19 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:23:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org
Message-ID: <6602e8671ecd0_1408f4294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240326073722.637e8504@kernel.org>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
 <20240325190957.02d74258@kernel.org>
 <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
 <20240326073722.637e8504@kernel.org>
Subject: Re: [PATCH 0/3] using guard/__free in networking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 26 Mar 2024 09:42:43 +0100 Johannes Berg wrote:
> > On Mon, 2024-03-25 at 19:09 -0700, Jakub Kicinski wrote:
> > > On Mon, 25 Mar 2024 23:31:25 +0100 Johannes Berg wrote:  
> > > > Hi,
> > > > 
> > > > So I started playing with this for wifi, and overall that
> > > > does look pretty nice, but it's a bit weird if we can do
> > > > 
> > > >   guard(wiphy)(&rdev->wiphy);
> > > > 
> > > > or so, but still have to manually handle the RTNL in the
> > > > same code.  
> > > 
> > > Dunno, it locks code instead of data accesses.  
> > 
> > Well, I'm not sure that's a fair complaint. After all, without any more
> > compiler help, even rtnl_lock()/rtnl_unlock() _necessarily_ locks code.
> > Clearly
> > 
> > 	rtnl_lock();
> > 	// something
> > 	rtnl_unlock();
> > 
> > also locks the "// something" code, after all., and yeah that might be
> > doing data accesses, but it might also be a function call or a whole
> > bunch of other things?
> > 
> > Or if you look at something like bpf_xdp_link_attach(), I don't think
> > you can really say that it locks only data. That doesn't even do the
> > allocation outside the lock (though I did convert that one to
> > scoped_guard because of that.)
> > 
> > Or even something simple like unregister_netdev(), it just requires the
> > RTNL for some data accesses and consistency deep inside
> > unregister_netdevice(), not for any specific data accessed there.
> > 
> > So yeah, this is always going to be a trade-off, but all the locking is.
> > We even make similar trade-offs manually, e.g. look at
> > bpf_xdp_link_update(), it will do the bpf_prog_put() under the RTNL
> > still, for no good reason other than simplifying the cleanup path there.
> 
> At least to me the mental model is different. 99% of the time the guard
> is covering the entire body. So now we're moving from "I'm touching X
> so I need to lock" to "This _function_ is safe to touch X".
> 
> > Anyway, I can live with it either way (unless you tell me you won't pull
> > wireless code using guard), just thought doing the wireless locking with
> > guard and the RTNL around it without it (only in a few places do we
> > still use RTNL though) looked odd.
> > 
> > 
> > > Forgive the comparison but it feels too much like Java to me :)  
> > 
> > Heh. Haven't used Java in 20 years or so...
> 
> I only did at uni, but I think they had a decorator for a method, where
> you can basically say "this method should be under lock X" and runtime
> will take that lock before entering and drop it after exit,
> appropriately. I wonder why the sudden love for this concept :S
> Is it also present in Rust or some such?
> 
> > > scoped_guard is fine, the guard() not so much.  
> > 
> > I think you can't get scoped_guard() without guard(), so does that mean
> > you'd accept the first patch in the series?
> 
> How can we get one without the other.. do you reckon Joe P would let us
> add a checkpatch check to warn people against pure guard() under net/ ?
> 
> > > Do you have a piece of code in wireless where the conversion
> > > made you go "wow, this is so much cleaner"?  
> > 
> > Mostly long and complex error paths. Found a double-unlock bug (in
> > iwlwifi) too, when converting some locking there.
> > 
> > Doing a more broader conversion on cfg80211/mac80211 removes around 200
> > lines of unlocking, mostly error handling, code.
> > 
> > Doing __free() too will probably clean up even more.
> 
> Not super convinced by that one either:
> https://lore.kernel.org/all/20240321185640.6f7f4d6b@kernel.org/
> maybe I'm too conservative..

+1 on the concept (fwiw).

Even the simple examples, such as unregister_netdevice_notifier_net,
show how it avoids boilerplate and so simplifies control flow.

That benefit multiplies with the number of resources held and number
of exit paths. Or in our case, gotos and (unlock) labels.

Error paths are notorious for seeing little test coverage and leaking
resources. This is an easy class of bugs that this RAII squashes.

Sprinkling guard statements anywhere in the scope itself makes it
perhaps hard to follow. Perhaps a heuristic would be to require these
statements at the start of scope (after variable declaration)?

Function level decorators could further inform static analysis.
But that is somewhat tangential.

