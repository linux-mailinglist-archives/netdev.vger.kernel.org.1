Return-Path: <netdev+bounces-166138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936FCA34BE8
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5A97A1915
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5312036FD;
	Thu, 13 Feb 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sg8eA3Pe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5A1C863C
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467776; cv=none; b=RJFXQtMG/nn/naSLBxFY+oN3yulzDJ/4l7/5QOf8ccdo8ccfY10TxszufV/waywnAPGFf2eV9oZSkIaphAs7gwUAxWreTfjRyYFr+gnpg3QRlzMgVsTJ5SXkf5FWoIZ43HXsnR4zUYDnt0R81ec1hyfcAHrAzYYeNxm3SZ6mfyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467776; c=relaxed/simple;
	bh=beEHYWfLW8uB+WEzhiwbEsKkojCix3lQoBcLZIbMJmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYf5rTBhI5ZiUXZiQZKezHV3s7KtFQgEFyuttMetPHVRADwoSIpX5cJEmTYWK1zK0HZCZPTkcptmLaDWtzK9BnN0ANtZNwIG98jPHgLXNmbgiOIJSD5AZq5pVi0Qfk8l0enIRBaPY+0BaC0CJhTEPqmqYMuWP3tViPS7OWvxWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sg8eA3Pe; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so1842266a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739467773; x=1740072573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxxFFdHrx4/pEU8chDYsT/kU3Mey57G9R2YibujipWM=;
        b=sg8eA3Pej11OUxc8yccdtcrbkpU0snbWxY6NpBVJ7qWu+Xcfk6s84XM8hA/0TMYqHy
         icRJSz7MX1del+O8/3NLqpgl7xQUxU4xtg0zN/j5R+h/4XqOX/qAyLHgPxzKUvZMHrzB
         VjZb8O6JaiU0EYeG+C9tyxavobPBiAg6ST/VQbqMlJewBqrayOEF8LeEgXkAWCqMm0Yl
         YHQ5SALSkAT1PI15RopCbpdMk+pnAAFll88jfnOl3uRCcqVk0qf8NGaUXezqOCSH8VuX
         lDSXUsGaL//05dGCd870RKC3YT50WqHR664HcfJ3pExAri0VFYqhsWdu8j9Bfph7518K
         AAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739467773; x=1740072573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxxFFdHrx4/pEU8chDYsT/kU3Mey57G9R2YibujipWM=;
        b=b3fZvTVYZw2vDEmhUWpkRTK1EfKSdccrIUHlvalo1FRoOtAZVapx8xnvyEIuoEGtr9
         so61CM6eIIdRqXRMDNzKff9+NIiru8JzUWssoihJJj/XFawcOkLCkhDJr6ke06tTXo7O
         7d6/aZOIc0uZzzEcxYsz6N3j76vtRWrcDJQ1bIe0DNP10ckDFHg4ZDNxR/vOVmj6fr5I
         s3HSs4LkgTy5bBrGkdy+LEt8LSlx1bHm6fxX5AuSxpwQvtEavMhEw0gEAKx31hI9OW3T
         PFJPXHRSAFxFICgsXyEV6ZX+A38kyaz4uraCNzfv6owa8XkSoa38Wm+mXpWr2XJBywb2
         ZIsw==
X-Gm-Message-State: AOJu0YxbFBZ8U+SLiD9ymjjKSK1Bh8F0Eq94AI4SXEQemy54Jls7tzQp
	b5EEVNw0I3WL24o1/Km2Fr3bZOCjYsR+eX3fM9Jf/OtUFxKKYdC7uum+6UEE2jP2oZ7iJkU7iQ5
	5tutg+/ChPAcSR4NhlINrChthZJwSDO8xjQuo
X-Gm-Gg: ASbGncsFcSKcHqeHgEm0+6gqsjTZx9L5WNC49riUPesdYvBo2Y5YMliVB2D0EL5RONJ
	q0MPRJ/y9UT8UvNu88vizz3xkYa4Vx49sQJNtRbym3nTFFsBsyBuPQyxtQ412gfm8S7Ffo6+jew
	==
X-Google-Smtp-Source: AGHT+IEnc+n3yFYlhIOPv071hPzEGKuco0va2tIo22Ttk1SmKZo9OEqVXQeOv0crrmOfciMX/nJ7w3Ianh6R9lkkSeE=
X-Received: by 2002:a05:6402:3593:b0:5de:5946:8a01 with SMTP id
 4fb4d7f45d1cf-5dec9d6731fmr3506421a12.2.1739467772931; Thu, 13 Feb 2025
 09:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
 <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
 <504a90ea-8234-4732-b4d0-ec498312dcd9@redhat.com> <CANn89i+us2jYB6ayce=8GuSKJjjyfH4xj=FvB9ykfMD3=Sp=tw@mail.gmail.com>
 <12199ed2-ca9e-4658-9fc0-44e5b05ca7c3@redhat.com>
In-Reply-To: <12199ed2-ca9e-4658-9fc0-44e5b05ca7c3@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Feb 2025 18:29:21 +0100
X-Gm-Features: AWEUYZneaePz4OCi4M3MOUoH9UomRgkvYTbve7DqBu3dbVcbl6RPqkuTiH1pIxg
Message-ID: <CANn89i+oxrDhKG+wM0TKkyyhXyYCMZBNYyY9aYAfFBDt3X35eg@mail.gmail.com>
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 6:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/13/25 2:44 PM, Eric Dumazet wrote:
> > On Wed, Feb 12, 2025 at 11:08=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >>
> >> On 2/12/25 9:47 PM, Eric Dumazet wrote:
> >>> This patch still gives a warning if  MAX_TCP_HEADER < GRO_MAX_HEAD +
> >>> 64 (in my local build)
> >>
> >> Oops, I did not consider MAX_TCP_HEADER and GRO_MAX_HEAD could diverge=
.
> >>
> >>> Why not simply use SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) , and
> >>> remove the 1024 value ?
> >>
> >> With CONFIG_MAX_SKB_FRAGS=3D17, SKB_SMALL_HEAD_CACHE_SIZE is considera=
bly
> >> smaller than 1024, I feared decreasing such limit could re-introduce a
> >> variation of the issue addressed by commit 3226b158e67c ("net: avoid 3=
2
> >> x truesize under-estimation for tiny skbs").
> >>
> >> Do you feel it would be safe?
> >
> > As long as we are using kmalloc() for those, we are good I think.
>
> Due to ENOCOFFEE it took me a while to understand you mean that we just
> need to ensure GRO_MAX_HEAD and GOOD_COPY_LEN allocations are backed by
> kmalloc to avoid the mentioned issue.
>
> I guess eventual nic drivers shooting themselves in the foot
> consistently doing napi_alloc_skb(<max small cache + 1>), if any should
> be fixed in their own code.
>
> I concur using SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) as the limit
> would be safe.
>
> Will you send formally the patch or do you prefer otherwise?

Oh, please go ahead, I am busy with other bugs, thanks !

