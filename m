Return-Path: <netdev+bounces-103237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45CE9073B3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0016A1C2484F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF1143C67;
	Thu, 13 Jun 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLBEeGDU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A54143C5F
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285369; cv=none; b=JMQJ6fjmJM4X4R5h07WDUsaWZBH7PP8S4xj8RWFzBgKPVzBvu2wOx6UwGem4pQWaEE4k6WdWZvZVSQXt4IazP1d0+RicPFpTw/yxppDjUVjx/yW9k7GckiWUikqGUtrQWnOCF4OBN5ayVYAKGe9WTo0wzBmBpIG99HaET92n/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285369; c=relaxed/simple;
	bh=y/6lvxGpK+xbtb+TeeYjV44MeXO6XzehBj1ECKqs7qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOD69X9Euk5gPMlyz0YO5Re/5AhildWVbfgiknmjcUZOJv9igebSP3cZFdHnABHFwepzwNJY3fjReNx5lC0+7SCYOvVSlVQmvYSZjXNwdI1qLVxweCfNdp9djVa7tuLvU6e0ymEhs8rRvzmgcyDo5PpNK9V82UVokkLZdANSr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLBEeGDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94948C2BBFC;
	Thu, 13 Jun 2024 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718285368;
	bh=y/6lvxGpK+xbtb+TeeYjV44MeXO6XzehBj1ECKqs7qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLBEeGDUobWrEwZ+cnJQ3Zr12Au783N+PpzVy0BdGlnIlF9s3LA7bp5p5k7A57+Yx
	 bxiTHlMp6hven2r31WHTnlazDqa8D8Ju6kaGzntBSXFspMGUaMsKCoIsLI2NfaD5K1
	 OM02AmehjLLcaS2oYN3Fvfar0JeYD0P5uKayhN+kBucBF6RrLC1JaiFtG0TayZyf7D
	 oNJgYIbPqGkALV2c95kEAdY5yRpN3JepzVkbpb9VPIoVb4pvTUb2G3mi3vAtptU+kM
	 qKfGowptVYOieP5fNS7iaA6gfAeupivcfqrs/rYQPFbTL+yucBHgRd55DvgD2X/f/w
	 g/PYlAIo/a+sw==
Date: Thu, 13 Jun 2024 06:29:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>
Cc: Linux NetDev <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: Some sort of netlink RTM_GET(ROUTE|RULE|NEIGH) regression(?) in
 6.10-rc3 vs 6.9
Message-ID: <20240613062927.54b15104@kernel.org>
In-Reply-To: <CANP3RGc1RG71oPEBXNx_WZFP9AyphJefdO4paczN92n__ds4ow@mail.gmail.com>
References: <CANP3RGc1RG71oPEBXNx_WZFP9AyphJefdO4paczN92n__ds4ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 14:18:41 +0200 Maciej =C5=BBenczykowski wrote:
> The Android net tests
> (available at https://cs.android.com/android/platform/superproject/main/+=
/main:kernel/tests/net/test/
> more specifically multinetwork_test.py & neighbour_test.py)
> run via:
>   /...aosp-tests.../net/test/run_net_test.sh --builder
> from within a 6.10-rc3 kernel tree are falling over due to a *plethora* o=
f:
>   TypeError: NLMsgHdr requires a bytes object of length 16, got 4
>=20
> The problems might be limited to RTM_GETROUTE and RTM_GETRULE and RTM_GET=
NEIGH,
> as various other netlink using xfrm tests appear to be okay...
>=20
> (note: 6.10-rc3 also fails to build for UML due to a buggy bpf change,
> but I sent out a 1-line fix for that already:
> https://patchwork.kernel.org/project/netdevbpf/patch/20240613112520.15263=
50-1-maze@google.com/
> )
>=20
> It is of course entirely possible the test code is buggy in how it
> parses netlink, but it has worked for years and years...
>=20
> Before I go trying to bisect this... anyone have any idea what might
> be the cause?
> Perhaps some sort of change to how these dumps work? Some sort of new
> netlink extended errors?

Take a look at commit 5b4b62a169e1 ("rtnetlink: make the "split"
NLM_DONE handling generic"), there may be more such workarounds missing.=20

