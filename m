Return-Path: <netdev+bounces-138398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82B9AD52B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 21:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2EAB2308F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E91DE4F7;
	Wed, 23 Oct 2024 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgr/wcQb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD31D9A68
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712827; cv=none; b=lt+uYscc3a5tOwWhadqGWone1f5pYFw6tHqgpNyH8PYDfFEaFagJjrXwp+LiRqPzaoHE9sst3U/FnbDS4kPRznTaR7nBpoZt5i6l7wEucVrtQ0XNC7HBuog2juQbO297sin3l1jpMXsCLQ+Nw289UgOqnWUCJACJH5VaCTQTVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712827; c=relaxed/simple;
	bh=ct7Gfhli20LzfoiXmD0U2KRYlADy43btBmMmXtXVDKU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k1H6y2EIKA3+IzrUrh2T1mqn7JPhieXHA5x4j4EBOiJjgdmkZZsFUh2tMtBxLjyX19G6iZnFTPQtHF8erQ4A+xKJEduuKLszSwbG9yTfh0tCkFjo8vSJ9snkGA31q1pXDLrGY1s5S8N015ube3M57dmodmVv2yNnPox+MtyKVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgr/wcQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F4DC4CEC6;
	Wed, 23 Oct 2024 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729712826;
	bh=ct7Gfhli20LzfoiXmD0U2KRYlADy43btBmMmXtXVDKU=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=Qgr/wcQbNEVBX+/nK+Nnw/kXn87ZWwclY4BKF4aVYgbIHGFg0vW4dyf+dbhB/eFzG
	 90hd+ui75SFtOSicVp+NWThyraAv7CNqIfV1QeYymMNPbeoukgLUQbySlTs3KcEvb+
	 PIn/v8rPxy6lpuPiD9+AQ+bY+zwormzLIOjkPmOEbwM3cDJKD6qsnMT26YoZ9feNlH
	 ycpyW9dphL2HqBpIwO+rk/4BuES+oFC5CwxFJrXv3zBp2cSDCmQOkOplJJDtsMjTnu
	 pVoBzZx96U9lhtbfzN9HfF3ZGiw4Wg7GIzosDebj5HLtjM+nQIU9bZduuvWZyxv1Pj
	 6srtQ+sLz7Gmg==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Wed, 23 Oct 2024 22:47:00 +0300 (EEST)
To: Stephen Hemminger <stephen@networkplumber.org>
cc: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org, 
    dsahern@gmail.com, davem@davemloft.net, jhs@mojatatu.com, 
    edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
    dsahern@kernel.org, ncardwell@google.com, 
    koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com, 
    ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
    cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
    vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, 
    Oliver Tilmans <olivier.tilmans@nokia.com>, 
    Bob Briscoe <research@bobbriscoe.net>, Henrik Steen <henrist@henrist.net>
Subject: Re: [PATCH v2 iproute2-next 1/1] tc: add dualpi2 scheduler module
In-Reply-To: <20241023085217.5ae0ea40@hermes.local>
Message-ID: <76bef0ad-2d27-aa2b-fe5e-02ab5c752793@kernel.org>
References: <20241023110434.65194-1-chia-yu.chang@nokia-bell-labs.com> <20241023110434.65194-2-chia-yu.chang@nokia-bell-labs.com> <20241023085217.5ae0ea40@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Oct 2024, Stephen Hemminger wrote:

> On Wed, 23 Oct 2024 13:04:34 +0200
> chia-yu.chang@nokia-bell-labs.com wrote:
> 
> > + * DualPI Improved with a Square (dualpi2):
> > + * - Supports congestion controls that comply with the Prague requirements
> > + *   in RFC9331 (e.g. TCP-Prague)
> > + * - Supports coupled dual-queue with PI2 as defined in RFC9332
> > + * -
> 
> It is awkward that dualPI is referencing a variant of TCP congestion
> control that is not supported by Linux. Why has Nokia not upstreamed
> TCP Prague?
>
> I would say if dualpi2 only makes sense with TCP Prague then the congestion
> control must be upstreamed first?

Hi Stephen,

In any order, there'll be similar chicken and egg problems from the 
perspective of the first comer.

The intention is to upstream Dual PI2, TCP support for AccECN (+ the L4S 
identifier support), and TCP Prague. The patches are only sent in smaller 
subsets to not overwhelm netdev and all of them are available here right 
from the start:

  https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

...As you can see, TCP Prague is among them.

While any of those 3 main components can be used without the others due to 
how the L4S framework is architected, the practical benefits are largely 
realized when all the components are there (and enabled which is another 
big step upstreaming alone won't address anyway). So in that sense, it 
doesn't matter much which of them comes first and which last, but it 
explains why they tend to crossreference the others [*].

Implementation wise, L4S identifier support bits are required by the TCP 
Prague patch so TCP support for AccECN/L4S has to be upstreamed before TCP 
Prague. Dual PI2 does not have similar implementation dependencies to the 
other main components (AFAIK) but if you insist on including it last, I 
don't see big problem with that.


[*] There's leeway within L4S framework so that Dual PI2 or TCP Prague 
could be replaced by something else that just meets the requirements.

-- 
 i.


