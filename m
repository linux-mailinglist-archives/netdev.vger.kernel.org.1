Return-Path: <netdev+bounces-175971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AC8A6816E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F8C42509E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755E5134B0;
	Wed, 19 Mar 2025 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MbRFQQP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62123595B
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343833; cv=none; b=DPhCnYwWCkNbzdkgAL52BpfG2yjjhh6+WJJABtS8p8073Uw+W5rXzfX9RvQ7Y/X4PFcjwDMVpjNMMs3Ag/84eM4fXqDAVzgSs5KFQWLywp1jFbngtQ0d9y0XmNFKGHjCBILFVGI1j5yaauY2BET5UmQj7sV15pR+i5F/oD2IdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343833; c=relaxed/simple;
	bh=lY1JAgJCfZO+LkrQvAcCYPLplPJGF2qf9+MccuprH3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S42IcFCLJYDVsiY22i4bJ9oBUngbbZUpjKy85k6Da+sxLROH6ptNRFhoEdvbxLoPKBwXokW6fjCOeFSUjpMh2noWzlJ5/u92zBsyfMSGduOUIrPLu4QiJGcFLITkYf22ZrETIr1qA5GV0qvBekNB8+zvd+PGum4VP+XTI4VN5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MbRFQQP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso2517a12.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742343830; x=1742948630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lY1JAgJCfZO+LkrQvAcCYPLplPJGF2qf9+MccuprH3E=;
        b=2MbRFQQPzYQNDM5acnz+Hy9SKzLzS8kWrfKRwcWMY4mNdNTWeSm9LLc2vkEcO9EJpu
         mnA6qQsG0ROqzmZUCSTGzeb8zsFNMXRXI2N9fPx4PzZ4Hh+cMuoZ8ZrE4jduk/oq8xoM
         pivibmP8gY704WHSFNstOkB7KjYZvvhtQ0NM68hz6asxL28eB8aP0riulQVEcbAanUyF
         Ol6VID6UHiWFlDCAmUhVM9yspdmzaTuTNwLJm2FCz2Y39x05fnZhNdQ6THKP3A5HGQsq
         hh23ejJMd9iuynmWr0mxOuKiSrxSdo0lsTko8BNl7htSsAKmuygmEqFhWxzWmBSRYZdY
         SIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343830; x=1742948630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY1JAgJCfZO+LkrQvAcCYPLplPJGF2qf9+MccuprH3E=;
        b=MzlAZOvwvwMuUfpUSFcKxHUnyCBXgGQFOYdV7C+yaGUvw+ceOJ1ydTJnK9PIM3rLAt
         AK43e8GNTPjBR+hJIyIsMYycHSWNUlnX1lts2zXqKGzIkUVs8AbO5I1h98Df6h/AA2b6
         prgPg0w+0YmMAQXq6rWQ9eubR7fSPuMp7AFFPHpy7EvMJoJnYq3H8youlAuN51t6BJDC
         jPtzQ5ulEYjiCMq3h+yUmmCzegOdmpWxzHUdPetCAMZVW16TsbNkmkLNP6qUkp/2Qq70
         Pr3eo+pMQ638b9jKOvQcB0LOhS8CxJ+5xaFZ1TkTV7DtR4numMeW36qiM0za3iy6O/dC
         EfEg==
X-Gm-Message-State: AOJu0Yz3YoMWKgFO7nFsOls0tu7w4BChpGkxlx48OJnaAULKeicyRpkQ
	akoETqlz4bdyUzZ0LBZAg73sHu6Q40lgRuKOcSVHrcWlhnT3nF39OHlmX5cSasdkYBCUwnuTjAY
	qL4VtZG23ruYOxiGNOPigfcYa1DjyNekYIJ7j
X-Gm-Gg: ASbGncvRZvLpWxSscyGpC8dPXobR9fq2tH+LVNGGHs1T202IXbhkYw8YGdfweqQInGA
	Btk7eR3WcfweKw+J0niUUd5easbnHDuKhBmNtpBg7/APaBJp2rIDRPIL1PlQ386ODk9OP6P4Mkt
	gGyJWYYrDKcfguDuPU6KRdFLcm8YPfJT+qnAx/2HI4a6TtUoCRE5hS3MGyTDw=
X-Google-Smtp-Source: AGHT+IGAg3gm6xcgEvpldHOk0wiidpIISM3GLbGX3jslKDaq2dx3VyAOsINBeODpxJOtk3JmOsjXiOlZ3gFLsRxiSPg=
X-Received: by 2002:a05:6402:b69:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5eb81b8c191mr22972a12.3.1742343829794; Tue, 18 Mar 2025
 17:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
 <CADKFtnQyiz_r_vfyYfTvzi3MvNpRt62mDrNyEvp9tm82UcSFjQ@mail.gmail.com> <08387a7e-55b0-4499-a225-07207453c8d5@linux.dev>
In-Reply-To: <08387a7e-55b0-4499-a225-07207453c8d5@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Tue, 18 Mar 2025 17:23:38 -0700
X-Gm-Features: AQ5f1JrOgO-zOChED-mTj4S7Sre5dsbE5gJlbFB8WjWgHzHsbNPXnhw507shlS0
Message-ID: <CADKFtnThYT4Jp1Nio8iW+uEdj8+khGmAYaLxW-w5LO4tnLZdkA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket iterators
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

> imo, this is not a problem for bpf. The bpf prog has access to many fields of a
> udp_sock (ip addresses, ports, state...etc) to make the right decision. The bpf
> prog can decide if that rehashed socket needs to be bpf_sock_destroy(), e.g. the
> saddr in this case because of inet_reset_saddr(sk) before the rehash. From the
> bpf prog's pov, the rehashed udp_sock is not much different from a new udp_sock
> getting added from the userspace into the later bucket.

As a user of BPF iterators, I would, and did, find this behavior quite
surprising. If BPF iterators make no promises about visiting each
thing exactly once, then should that be made explicit somewhere (maybe
it already is?)? I think the natural thing for a user is to assume
that an iterator will only visit each "thing" once and to write their
code accordingly. Using my example from before, counting the number of
sockets I destroyed, needs to be implemented differently if I might
revisit the same socket during iteration by explicitly filtering for
duplicates inside the BPF program (possibly by filtering out sockets
where the state is TCP_CLOSE, for example) or userspace. While in this
particular example it isn't all that important if I get the count
wrong, how do we know other users of BPF iterators won't make the same
assumption where repeats matter more? I still think it would be nice
if iterators themselves guaranteed exactly-once semantics but
understand if this isn't the direction you want BPF iterators to go.

-Jordan

