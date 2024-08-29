Return-Path: <netdev+bounces-123436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D422D964DA8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A46D1F22527
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9DC1B86CB;
	Thu, 29 Aug 2024 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3s9hF3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8951B81DE
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956145; cv=none; b=KjYf0ke8P2jRbB/EAK3pO8HqxPlcY+rQihNS8MtGw4jX0xt44Q0Z8o75x/nz4krurUWm4e6eVq9I5sqPJkjh61KghfW0EM870wlKrZT0b7Qr3DeP8MaKtPFbr9itzH/9Xc9JfOWv1yYvPq5+eqjpUgosjoLrdfnlp4tQoh74zQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956145; c=relaxed/simple;
	bh=uFlJynURVWC+M2UJehrQrk5CWf/a/Gwly+Kkpykmcts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTwZc41uCTC2qa9hX1Cw9WxEI4rMo8LluPSy/Zm2uo6+25MnKmNehf9OAhKXm6qaPnmiepGHZDnB7J10j/0UqcCCcT4y7PNKQzyie5pgvzxQ1VV1+9L02VwC7KgMGxuswxSDwhCSdgc3uyLod4cfv1rnpjE+eowg3j4vLD+EYwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3s9hF3Z; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8695cc91c8so101237266b.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724956142; x=1725560942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFlJynURVWC+M2UJehrQrk5CWf/a/Gwly+Kkpykmcts=;
        b=a3s9hF3Z1kRsUDVfWRJMlkEgoLOPouyvn8zpf5QacXuMkq1yjamUa83QTs0MyRhira
         btMci4O4coCdXBTrhroz8+GInCKRlzMo7Tuk10rKt1P8l7yXTeV3YUJT54lUA27iQLbn
         8xxp4gWSfo4tiu1QBeugA6Q6cGZcys/YqdCihvzgo07osaQnQ+NLJoPbxsfbjI/VNxVH
         iOuAbeEBUWqBligSBzrl6L2ZEqEFlx68VarpP7uVspS2bIGQgROTKPu3MwcuEVh60GQr
         w+Y2taID1L+oEituO7p4NT/rvdSFC5uf9pADP6g4ca5I/3ncew9qnS49uZec5wR4PWr2
         ODhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724956142; x=1725560942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFlJynURVWC+M2UJehrQrk5CWf/a/Gwly+Kkpykmcts=;
        b=Q5fU/lNhdlZc5x/9l2/YOLazMGyNzBCf9exv1RQYWPyzasKt79HTUkkpQntYTY7UMO
         wUS8GGOsaEV0jttFtxOk2FJr9998q/nE1QrHSXqBGKT+M1HqNU8LAs7tVY2AZP7crzVR
         PHIcpaq2c7qaQW6S+D9N0WYrg39kM4tpO7g+n1onxAgz+Z0NPRJdTx3YK3mSwrTrnbaY
         i/5aZZYM5kFpqKCroR/iVSDKr6ekBuAGup7KAVROVM2bwGXSRLNma/RZChiH0WnKxMCt
         SZ5hdeqU7m5b3JcjIu0kdAFXUR+6VZl/U9fCoHfQWxieM8zngQqNHIGkiOu8AdaeQFam
         2GZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqe+bTDT2lUqiVojHhZjZVMIWUiLM/dlXWzFu130DoJibVpH9zUxOX7pzVO8KE9rgjAg9YLsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrdPsjXhJtHILy3Bztq82NidgxOuAfHPUcn5jaxBWNRPYbLjg6
	+j/okdT7CsuusjXmyvq12FAKn+B4eJHxiz8gvOByMQwWl2IVFqGm1sWstnzhoL55y5pI9SJFGIB
	QZXhVp2Oep8UkRlwXdlg/9IXi5D9QD3hXUSj2
X-Google-Smtp-Source: AGHT+IEjCsZ5C7DEJGtuDAb8jQenH6fq4Xe9rcECFO/np82w+7fJUFxQQ/NSCKZtW9cfxdwYkeCFsnLIObrWOWS1Sd0=
X-Received: by 2002:a17:907:868a:b0:a86:9880:183 with SMTP id
 a640c23a62f3a-a897f789550mr277753066b.10.1724956141671; Thu, 29 Aug 2024
 11:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkYPzsr8YYOXP10Z0BLAe0E36fqO3yxV=gQaVbUMGhM2VQ@mail.gmail.com>
 <txl7l7vp6qy3udxlgmjlsrayvnj7sizjaopftyxnzlklza3n32@geligkrhgnvu>
 <CAJD7tkY88cAnGFy2zAcjaU_8AC_P5CwZo0PSjr0JRDQDu308Wg@mail.gmail.com> <22e28cb5-4834-4a21-8ebb-e4e53259014c@suse.cz>
In-Reply-To: <22e28cb5-4834-4a21-8ebb-e4e53259014c@suse.cz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 11:28:23 -0700
Message-ID: <CAJD7tkavjpYr54n13p9_9te-L10-wn6bc_uLkAozsuFWT31WjA@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
>
> Another reason is memory savings, if we have a small subset of objects in
> KMALLOC_NORMAL caches accounted, there might be e.g. one vector per a slab
> just to account on object while the rest is unaccounted. Separating between
> kmalloc and kmalloc-cg caches keeps the former with no vectors and the
> latter with fully used vectors.

Makes sense.

>
> > Wouldn't it be easier to special case the specific slab cache used for
> > the objcg vector or use a dedicated cache for it instead of using
> > kmalloc caches to begin with?
>
> The problem is the vector isn't a fixed size, it depends on how many objects
> a particular slab (not even a particular cache) has.

Oh right, I missed that part. Thanks for pointing it out.

>
> > Anyway, I am fine with any approach you and/or the slab maintainers
> > prefer, as long as we make things clear. If you keep the following
> > approach as-is, please expand the comment or refer to the commit you
> > just referenced.
> >
> > Personally, I prefer either explicitly special casing the slab cache
> > used for the objcgs vector, explicitly tagging KMALLOC_NORMAL
> > allocations, or having a dedicated documented helper that finds the
> > slab cache kmalloc type (if any) or checks if it is a KMALLOC_NORMAL
> > cache.
>
> A helper to check is_kmalloc_normal() would be better than defining
> KMALLOC_TYPE and using it directly, yes. We don't need to handle any other
> types now until anyone needs those.

is_kmalloc_normal() sounds good to me.

Thanks, Vlastimil.

