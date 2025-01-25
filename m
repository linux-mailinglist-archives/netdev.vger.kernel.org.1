Return-Path: <netdev+bounces-160893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E8A1C044
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 02:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968FA3AA6D6
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 01:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944943AA9;
	Sat, 25 Jan 2025 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXGwPtBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257C225D6
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768695; cv=none; b=EXy6WOq0Jej0p+hWSjtLbvowwo8ItDLzwoeTOjzXf3yi4z1cLlT6M8ONQtfwNbByKB6EBDxpkTo8dNHihOVamMegFMEqHdM5G2C3bT/mGjQD5e/pztLm+qX7ilCVXJcoFJk2Gd8fx4ZIgnTM3ghgG+moJi9dOpeh8uTsaCpZ5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768695; c=relaxed/simple;
	bh=L4HinUtnG+RcrHddq8h9enNvJrwbGIUMuL+myTghpRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfkSynWH7wrMSGOKaJRuLucLF4DujQVZixuCmiOgzgdRvN4LEdZTs6LdGG8c24dsZCkVPxH4rnL6I/PLzQsfW8GLtTX8OZ7Cl72aeiZhqaqG0xQNdGwsGyNIxo5P0MGnk2WaesInTeLvLWOy4jUFFLYrFqdVE/nbOaT+EU/vhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXGwPtBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126C3C4CED2;
	Sat, 25 Jan 2025 01:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737768694;
	bh=L4HinUtnG+RcrHddq8h9enNvJrwbGIUMuL+myTghpRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXGwPtBGXvuMwtyQuYFSl/Xmx+FNv/bUR2ErcRakcI6TR0myNQJC2xl3yTsKDEkzv
	 FwY8oJu0rgaCNJDgvwaQG1wLxfPHsqndqXwdtfoB3SQgwM1CtIm5pPjsCwZ3X0BUTD
	 iQsRKrqNFzc8h7B9aQtIwFOIggQ/KNpcQzAKfmCVvqLu4PNoiwZylwSq2guGdm/rs5
	 txOPtspYwhA6SFIBi6v/ZCPKtwRpzGl4JhY34B899XoSOGljJpEOSov0Zf4ekcODIp
	 xYsyWi01AJVf/aPWML2BWmIRxh0OoXIj9V15oYmlPIEMHqpZLoVWUK/f81itpcG49l
	 3gF+TAvSKbpyg==
Date: Fri, 24 Jan 2025 17:31:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, asml.silence@gmail.com, kaiyuanz@google.com,
 willemb@google.com, mkarsten@uwaterloo.ca, jdamato@fastly.com
Subject: Re: [PATCH net] net: page_pool: don't try to stash the napi id
Message-ID: <20250124173133.71b4df3c@kernel.org>
In-Reply-To: <87r04rq2jj.fsf@toke.dk>
References: <20250123231620.1086401-1-kuba@kernel.org>
	<CAHS8izNdpe7rDm7K4zn4QU-6VqwMwf-LeOJrvXOXhpaikY+tLg@mail.gmail.com>
	<87r04rq2jj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jan 2025 23:18:08 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > The reading paths in page_pool.c don't hold the lock, no? Only the
> > reading paths in page_pool_user.c seem to do.
> >
> > I could not immediately wrap my head around why pool->p.napi can be
> > accessed in page_pool_napi_local with no lock, but needs to be
> > protected in the code in page_pool_user.c. It seems
> > READ_ONCE/WRITE_ONCE protection is good enough to make sure
> > page_pool_napi_local doesn't race with
> > page_pool_disable_direct_recycling in a way that can crash (the
> > reading code either sees a valid pointer or NULL). Why is that not
> > good enough to also synchronize the accesses between
> > page_pool_disable_direct_recycling and page_pool_nl_fill? I.e., drop
> > the locking? =20
>=20
> It actually seems that this is *not* currently the case. See the
> discussion here:
>=20
> https://lore.kernel.org/all/8734h8qgmz.fsf@toke.dk/
>=20
> IMO (as indicated in the message linked above), we should require users
> to destroy the page pool before freeing the NAPI memory, rather than add
> additional synchronisation.

Agreed in general but this is a slightly different case.=20
This sequence should be legal IMHO:

  page_pool_disable_direct_recycling()
  napi_disable()
  netif_napi_del()
  # free NAPI
  page_pool_destroy()

I'm not saying it's a good idea! but since
page_pool_disable_direct_recycling() detaches the NAPI,
logically someone could assume the above works.

I agree with you on datapath accesses, as discussed in the thread you
linked. But here reader is not under RCU, so the RCU sync in NAPI
destruction does not protect us from reader stalling for a long time.

