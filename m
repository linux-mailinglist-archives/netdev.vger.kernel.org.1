Return-Path: <netdev+bounces-132847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749BF9936F6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 21:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68811C2234C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCEA1DE2B3;
	Mon,  7 Oct 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSVGPFSt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9EE22098
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728327990; cv=none; b=qAbEEXEvbZJCeEW644vYKxsYKOF7mkizG+cdoMDst+Vw8G7aoYVOf7UeXfVuhW3LcQWFT9CQvvmvxF+Naue+XsJKoTU7ChZLu3hxcMtYqc/SHXAFSCf88x5oEOC8CgOHvd1jzVki5jJwnCXA6FyVvBV1wYQKe6kW3rPNILdrvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728327990; c=relaxed/simple;
	bh=3YvSkBIIv/DdCpocOOBB0QCAWfXHKDNfquxJXSsVEBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ls8YGCAjzHLVr4WYsnONakV0haT1pRfrHFkr+FsUPO84vCQ4WwOQEH1LLpoTUMmLVNejKj4M+cz0N0VvRXVtHOeQBsRrFh1zdR7quCn4+1LiLnf2BuphWGW76VG7OLtUihz7Y5QujJLq8Ph7vsLfVhxbzxxcqmAO6TNP2NFnjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSVGPFSt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so10138949a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728327987; x=1728932787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YvSkBIIv/DdCpocOOBB0QCAWfXHKDNfquxJXSsVEBs=;
        b=rSVGPFStCLqKjZk7XjggprD+hYo7/Cf+Ucp6fR5b9GlvAJWz7OIMVYYchjfVVvbGBj
         NSk4L/N0OjLbuisGZ9trfsf0C7ymdt3pbpaGgHV/xK9R17G9I7cxY4cPzCLvkGmzlbSp
         yWtIyciyvuiopbfIuP04u1ezMCjfk8SEKhGFbkGNrnkoGam917Q+gOncQ5cIZBSiCTwC
         IRi7Y952A2oPsdzN4BrSOSLKnN9+5Ea+TP7BzCajR3+pVWNoq35e3Sz/mUDurYmz8XTh
         cU1L+NxdSG6+X9dY/+MXQyYn+4qRdCvud0kxyW0NwMcdAGM/LvbuKCDu35d/j/gk+zak
         BYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728327987; x=1728932787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YvSkBIIv/DdCpocOOBB0QCAWfXHKDNfquxJXSsVEBs=;
        b=o+Yj/iHXfpsDftLAvOw2yl+0C3oKjezq4zx09sAAuLKNvRgdY06SYR6cPSNMlMFM43
         dOs8WIYB5AaYjBw/PCVvh/oh+np2HtUpffLL+Z0ftoj3Au+LZHhGBoETqqr0/5yztDB6
         n8uIJC6k3mQojYYziMWYqsnLqji2/IVhq0H2Wnqie3jnJdG9o/iETLrIT4oKxRGspO20
         1V0Mp5+Huaq2+r3/2DOCgQFb50EQYWnVe2PEA7Z5N+BkLdVO8/OZ1ebTRG1TnrMd1kZd
         SMRwXOU05HAyt3mU3KPiPmQRfKHKO2U5KvksVSibg42SJQL4+AqfWJ3D4jRQ9xtPpWrD
         F9IA==
X-Forwarded-Encrypted: i=1; AJvYcCVH8t1DdgCghi8rKrMPsqv1SBqzndxoytc9BsAf0i5nU0LXDhLSSyiAROy0glBQt8L2zB2c0UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7rF9sz4M0/RcQ7aAcCvxQbxUiW2e+DBcIxniVjStalGxDpMd
	Tasvt8x2ewHPSOD4F9BXkCYma0oBdcxSaSj4g/laKysW+9u9wz1NSCHce0ZNR3NYN4KSsLL3UhA
	Lu38VC1fS9pMn4HnAZSErH+OmgINwLicw6B0W
X-Google-Smtp-Source: AGHT+IGilSaTamOvz8HttKONalaEoJfF71Iisb4n3UFe7OTVAeAgUkLsMYXulqrTVnDXWPqbIW5OsgShmQsqNRyfLYU=
X-Received: by 2002:a17:907:7fa8:b0:a99:4e74:52aa with SMTP id
 a640c23a62f3a-a9967953d80mr53941166b.33.1728327987243; Mon, 07 Oct 2024
 12:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de> <20241007-igmp-speedup-v1-1-6c0a387890a5@pengutronix.de>
In-Reply-To: <20241007-igmp-speedup-v1-1-6c0a387890a5@pengutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Oct 2024 21:06:16 +0200
Message-ID: <CANn89iLDO4MUsRLWw-UOhYvTaP_Wn_jhByUCHTFCAHLv_kJSaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: ipv4: igmp: optimize ____ip_mc_inc_group() using mc_hash
To: Jonas Rebmann <jre@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Madalin Bucur <madalin.bucur@nxp.com>, Sean Anderson <sean.anderson@seco.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:17=E2=80=AFPM Jonas Rebmann <jre@pengutronix.de> w=
rote:
>
> The runtime cost of joining a single multicast group in the current
> implementation of ____ip_mc_inc_group grows linearly with the number of
> existing memberships. This is caused by the linear search for an
> existing group record in the multicast address list.
>
> This linear complexity results in quadratic complexity when successively
> adding memberships, which becomes a performance bottleneck when setting
> up large numbers of multicast memberships.
>
> If available, use the existing multicast hash map mc_hash to quickly
> search for an existing group membership record. This leads to
> near-constant complexity on the addition of a new multicast record,
> significantly improving performance for workloads involving many
> multicast memberships.
>
> On profiling with a loopback device, this patch presented a speedup of
> around 6 when successively setting up 2000 multicast groups using
> setsockopt without measurable drawbacks on smaller numbers of
> multicast groups.
>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

