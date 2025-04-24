Return-Path: <netdev+bounces-185662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F7DA9B44D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA294C0887
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A028B513;
	Thu, 24 Apr 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="MEhiU7RS"
X-Original-To: netdev@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5C27F744;
	Thu, 24 Apr 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512750; cv=none; b=ktn/RZFJ7xXG9CybSvVppZsh9dbt3p4EtBU/dnYCGHgm2vOGl1w+tALAhl6jpkNpHZEwZMtZzzBfZBsowJvV53szcrMKUeLAWUkY6oY2M1jCfMla23f3mMIEwXMeK3aVXgo2lVqmcD4ORuIl0f1sGiluRwPA69EoxyXCCdDLrx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512750; c=relaxed/simple;
	bh=m4YGeBqf8Mkv4bC7YmvzT9g0zGADmjZ2P38yIYVVAcA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=chA7xm63eFNtNdnjoVEvFSqBIfWNOclA5kP+udpurthp62hcaTolh7sHZvCMWkH0J5Wm35sH5mXL8evqlwsT7T06qWqqagH7yemmqnlKvOTV0/s04OIDeb04wjpr7v45e2I7oid5ZuHrOkOp2NYHBKCV9BNOkXyhktUFc8P/jv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=MEhiU7RS; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1745512748;
	bh=m4YGeBqf8Mkv4bC7YmvzT9g0zGADmjZ2P38yIYVVAcA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MEhiU7RSYK+eNRChd2WM6mSdgvzxoWywJoLNJxkEmSwZo0uFLJ1mEJ0tKEeZTn1cz
	 5vIkXGwiuIJWa3ez3vPZCUoZMCvpgCswr2ueTqX0iWAjnlbbRWvCNAjA4BVOUttG8/
	 6j7Ir7IGuYKKIBJ5Z3hhFrfxObX9zOgy4WnDR3Uk=
Received: by gentwo.org (Postfix, from userid 1003)
	id 403164025D; Thu, 24 Apr 2025 09:39:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 3EF44401F6;
	Thu, 24 Apr 2025 09:39:08 -0700 (PDT)
Date: Thu, 24 Apr 2025 09:39:08 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Mateusz Guzik <mjguzik@gmail.com>
cc: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
    David Rientjes <rientjes@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
    Tejun Heo <tj@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
    Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
    Vlad Buslov <vladbu@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, 
    Jan Kara <jack@suse.cz>, Byungchul Park <byungchul@sk.com>, 
    linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the percpu
 allocator scalability problem
In-Reply-To: <CAGudoHEwfYpmahzg1NsurZWe5Of-kwX3JJaWvm=LA4_rC-CdKQ@mail.gmail.com>
Message-ID: <cd7de95e-96b6-b957-2889-bf53d0a019e2@gentwo.org>
References: <20250424080755.272925-1-harry.yoo@oracle.com> <80208a6c-ec42-6260-5f6f-b3c5c2788fcd@gentwo.org> <CAGudoHEwfYpmahzg1NsurZWe5Of-kwX3JJaWvm=LA4_rC-CdKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Apr 2025, Mateusz Guzik wrote:

> > You could allocate larger percpu areas for a batch of them and
> > then assign as needed.
>
> I was considering a mechanism like that earlier, but the changes
> needed to make it happen would result in worse state for the
> alloc/free path.
>
> RSS counters are embedded into mm with only the per-cpu areas being a
> pointer. The machinery maintains a global list of all of their
> instances, i.e. the pointers to internal to mm_struct. That is to say
> even if you deserialized allocation of percpu memory itself, you would
> still globally serialize on adding/removing the counters to the global
> list.
>
> But suppose this got reworked somehow and this bit ceases to be a problem.
>
> Another spot where mm alloc/free globally serializes (at least on
> x86_64) is pgd_alloc/free on the global pgd_lock.
>
> Suppose you managed to decompose the lock into a finer granularity, to
> the point where it does not pose a problem from contention standpoint.
> Even then that's work which does not have to happen there.
>
> General theme is there is a lot of expensive work happening when
> dealing with mm lifecycle (*both* from single- and multi-threaded
> standpoint) and preferably it would only be dealt with once per
> object's existence.

Maybe change the lifecyle? Allocate a batch nr of entries initially from
the slab allocator and use them for multiple mm_structs as the need
arises.

Do not free them to the slab allocator until you
have too many that do nothing around?

You may also want to avoid counter updates with this scheme if you only
count the batchees useed. It will become a bit fuzzy but you improve scalability.


