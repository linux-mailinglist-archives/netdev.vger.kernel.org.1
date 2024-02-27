Return-Path: <netdev+bounces-75183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 368E08687D1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 04:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97B51F22C32
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 03:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBCC1B94E;
	Tue, 27 Feb 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GmBdOgU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098F1CD3E
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005028; cv=none; b=UT70uZfFURVvUdWwh34oc5JXjC72/fxacJxWyICg08uplFp2wejyS0ShvaizjpXAGJ3/mBMRRec8r1V3mFlAQ1N/jeRoQLfHAusU8IVJ/NvvbpP4NUaHAldR8Xiesrkl1ai+U3ndeCsUIX0uPAS4XsgON2qJQRpqjIYT8dIJhIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005028; c=relaxed/simple;
	bh=4lA62rj3GO0A97eTbyhP/mDzLzQp/zygOyWT3dBG+Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SZv4ZzNlRZBaNNdXagHEdHjoTBYE9hdoxVxYqL1hFkbJjoeZPDnz0mzeP36+dCei0hCixGVne6QKA0E6nQXOV6Zh+PwoNrOQPirMEIasCgKxHUpBuEpSAHpEga2QtcfLMTECGFRPXGywejqyXAykhEXAavQt+7g6jCj/N/nqjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GmBdOgU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2992c1d4e7fso1499985a91.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709005026; x=1709609826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKkRNXjECqDt/aCnhJ0E9UJXfe2puolPyBMF28/gyzQ=;
        b=1GmBdOgUwev1AgqV+jLjYzP1SG229OyFlLjt9uuGbhuQXLbIAxVz6WhfCyIFpLRZ8g
         UQlOg7VW+fhUVhfBA1j5E5iX/jzNg7O/qOi0V3XwHDvloh21TSI0S2RjBFJirrNf8BOT
         igXSqStdOy5g0Spb5SCi/RlWfUCVNXCGTWvXmrYtjZL60wjtkRZ5E6OMDh+Wzi7Y/OqY
         2T4rr+AeN4navB45ufMHafvyM9g7z7oPJvWgAZQoeCA+XFloFww+46kQLZxKgxqGoA5a
         VItEpPAMqdaYSt8By5ijl884nk3YpAPqfNnW3JDdMaOqn0t0xvZCuszAPmttinx52hW9
         Iy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005026; x=1709609826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKkRNXjECqDt/aCnhJ0E9UJXfe2puolPyBMF28/gyzQ=;
        b=L/Lt4tnLWngF9fMn8DwIgy+p1/AG9aYe+hzCPrcaslimfj3jlk34WIixAZ+EURxZmf
         xU28ry4sT+dWFDQgQoeNB8ENCTwpYlLR6ahGsOI8VqtlzwSyWVXhIWlKI2PGwgmy+LD7
         FFy9+klT6eAdI4imeeE7e8AW5BC7p151pDUyHcI3mlb6pk9+kChaukxe3zu9pGFTZD8G
         32oVhtbYIBRqPtkSAd9h5YJ/XF3xYD5/XOGSQdyd9RmL5M3qgRGe6VPp0RU2fX5l8RqU
         zU1ZeaUgmNFLFG5QSJGa0xARpzrH93yzhJuzLsT2hc/7Wvl1dxyywXM9ZLB4sM3k2+og
         5aXA==
X-Forwarded-Encrypted: i=1; AJvYcCXMKsoPJ1a4Id4kev0hr7Juqz1ChiV4rt9ivIfTVxflDWnG0wMfochQCiud54pZkud14HrUj4MV6GqZoTJLf+Sh+we8lCKq
X-Gm-Message-State: AOJu0Yx1ey4U2BlUBmCKUi8ojnGyXPeFoUjuxitjlzRuQ9aHq/saSlb4
	9EOdg4TTTb/Hs2ttaOE5SIi4uziD/l6eJKOACH2j09lpQUiTyNEB0Qnc7ApOzcWWMA==
X-Google-Smtp-Source: AGHT+IHZgHe1F8rc+IWRt0nHWktsEmVCdgGWUaH2T8ki9nv/6UToSPWwuirEZXgWaDPHQ+LVI8HJGA8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:8804:b0:29a:aa7d:e7e7 with SMTP id
 s4-20020a17090a880400b0029aaa7de7e7mr22307pjn.2.1709005025812; Mon, 26 Feb
 2024 19:37:05 -0800 (PST)
Date: Mon, 26 Feb 2024 19:37:04 -0800
In-Reply-To: <20240226141928.171b79fe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226211015.1244807-1-kuba@kernel.org> <20240226211015.1244807-2-kuba@kernel.org>
 <Zd0EJq3gS2_p9NQ8@google.com> <20240226141928.171b79fe@kernel.org>
Message-ID: <Zd1Y4M7gwEVmgJ8q@google.com>
Subject: Re: [PATCH net-next 1/3] netdev: add per-queue statistics
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, amritha.nambiar@intel.com, danielj@nvidia.com, 
	mst@redhat.com, michael.chan@broadcom.com, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="utf-8"

On 02/26, Jakub Kicinski wrote:
> On Mon, 26 Feb 2024 13:35:34 -0800 Stanislav Fomichev wrote:
> > > +  -
> > > +    name: stats-scope
> > > +    type: flags
> > > +    entries: [ queue ]  
> > 
> > IIUC, in order to get netdev-scoped stats in v1 (vs rfc) is to not set
> > stats-scope, right? Any reason we dropped the explicit netdev entry?
> > It seems more robust with a separate entry and removes the ambiguity about
> > which stats we're querying.
> 
> The change is because I switched from enum to flags.
> 
> I'm not 100% sure which one is going to cause fewer issues down
> the line. It's a question of whether the next scope we add will 
> be disjoint with or subdividing previous scopes.
> 
> I think only subdividing previous scopes makes sense. If we were 
> to add "stats per NAPI" (bad example) or "per buffer pool" or IDK what
> other thing -- we should expose that as a new netlink command, not mix 
> it with the queues.
> 
> The expectation is that scopes will be extended with hw vs sw, or
> per-CPU (e.g. page pool recycling). In which case we'll want flags,
> so that we can combine them -- ask for HW stats for a queue or hw
> stats for the entire netdev.
> 
> Perhaps I should rename stats -> queue-stats to make this more explicit?
> 
> The initial version I wrote could iterate both over NAPIs and
> queues. This could be helpful to some drivers - but I realized that it
> would lead to rather painful user experience (does the driver maintain
> stats per NAPI or per queue?) and tricky implementation of the device
> level sum (device stats = Sum(queue) or Sum(queue) + Sum(NAPI)??)

Yeah, same, not sure. The flags may be more flexible but a bit harder
wrt discoverability. Assuming a somewhat ignorant spec reader/user,
it might be hard to say which flags makes sense to combine and which isn't.
Or, I guess, we can try to document it?

For HW vs SW, do you think it makes sense to expose it as a scope?
Why not have something like 'rx-packets' and 'hw-rx-packets'?

Maybe, as you're suggesting, we should rename stats to queue-states
and drop the score for now? When the time comes to add hw counters,
we can revisit. For total netdev stats, we can ask the user to aggregate
the per-queue ones?

