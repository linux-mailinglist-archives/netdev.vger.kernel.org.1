Return-Path: <netdev+bounces-132501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB11991F38
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A73A1C214F1
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2679345BEC;
	Sun,  6 Oct 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lcjVIQWF"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9971B5AA
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226863; cv=none; b=MgAuxA3niYPvnyNUpLrvcVn34ocuk4wWdeQpCmiBGHHXyBbD+gtP2uxxbcboeYYnA6Wb2MBrgQ57xuptl0uySW+92smAP41xFvP899INzFUbCZIEXSe1+bTO5aVRIKRsdu1ocfPd36zULxvJj0+4SkAVPVtHxgyjiuGbcahFf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226863; c=relaxed/simple;
	bh=IVVn+aHPlgPWC2L7iy3TGGjfMiEf/Gi+4txVULwb9gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4ALTwnDZ8AU/24InHqntbBdGF4I34ykmW93G/wL6GfOgJbArW+G2H2jcNnvAaifhVY1bgazbIpaDTFivfr4HETCQiqIRqpeOLjYsYXUED+iczh/RlrKepl06rmDeFlO+q0p8hC2TRAgA25xttpiPI0tmuBhymIJtcj5xxepcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lcjVIQWF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 080D1114013A;
	Sun,  6 Oct 2024 11:01:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 06 Oct 2024 11:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728226860; x=1728313260; bh=st2FgEJTGcKxSx4GfbpM2pSbbAFF
	gnKn0Q7Ni33qC0M=; b=lcjVIQWFMZaK2d25RDKHBcbEFEbUas3AZt3rHJ/eF4mO
	VYA9oWsmSdAzT6f0w5cI/OUgIQNO4ryQCDW7BmVaUtxCAFjBa87drp8wu89gBPJ/
	A6nGzzE1R9UQVWyeNO1A49R1CRbqGuEpZrjjZjlbFF3tU5sVSEUry15dohe+3dvO
	wEaOyoWx6hukKRmUGMsP6vk0xxPiZ1oFE0M1EdipMzSp/uCinyi+kB0g13ZrAotl
	RHkTKm6ZaYI+k6wqXOwmS4cSqFnuUSbViY9KRxfFP6SwjseAQZBOf5k+WtlMW2ZR
	9DParHxxiO1BebJcTWyg8dPBHxZYQBU3fUMUlJuk3A==
X-ME-Sender: <xms:K6YCZxWEQHClK0aja278EZliMmmWKpWNTrw3zhC56LPdBtW_ckAyAA>
    <xme:K6YCZxk3dQNKTYyR4eLPIAP-7sXtOfv3xOTcXCwM2xCDrrdZeQKcuTE6AhSttjRx_
    x4OQCzO6SW50iA>
X-ME-Received: <xmr:K6YCZ9ZD1TiVzndwj3OkNbFzLEkXSQ8c8qTUjPs_GbViPMfXTHTsgh8dMW3S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvjedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhihrghnrhgrhiesuhhmih
    gthhdrvgguuhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:K6YCZ0WS6y9JUfm3gn-44KyErCb_sOU78XR0NHedGSlvZXusBwcZHw>
    <xmx:K6YCZ7kJl_bQg3Re_IGXj58GHmXpFedpM8bXhBE58ttXpjz5D2rX3w>
    <xmx:K6YCZxf2fZbJXuvUhTfweFFrxzV4ooo2p9uDODZx63lRCTY2O1v1Jg>
    <xmx:K6YCZ1EDjIByaaSh34g7wRTALwWddvXczV75oBuIIqtX64V6RBw3_g>
    <xmx:LKYCZzvBhpeXYwzvPx61trOfgC0GKl6kmKzZvpJHp7MjDOofvqMjg80J>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Oct 2024 11:00:59 -0400 (EDT)
Date: Sun, 6 Oct 2024 18:00:56 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Ryan Raymond <ryanray@umich.edu>
Cc: netdev@vger.kernel.org
Subject: Re: IP Forward src address cannot match network interface address
 Inbox
Message-ID: <ZwKmKDUXfSdqIhM_@shredder.mtl.com>
References: <CAFd0U8WBDCzoKrV1FR-tqpXF6bFhMK+5oxC=tVuaBfKg7EmE4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd0U8WBDCzoKrV1FR-tqpXF6bFhMK+5oxC=tVuaBfKg7EmE4Q@mail.gmail.com>

On Fri, Oct 04, 2024 at 11:57:00AM -0400, Ryan Raymond wrote:
> Hello, all
> 
> I am working on a Linux networking project. I have two interfaces:
> 
> tun0: Address 10.1.0.1
> eth0: Address 141.14.41.4
> 
> I want to write to tun0 (from userspace) so that packets are
> transmitted through my virtual network and out eth0 onto the internet.
> I can do that easily if I say that the source address is something
> random, like 1.2.3.4, but if the source address matches any interface
> (e.g. 10.1.0.1, 141.14.41.4) the packets are not transmitted.
> I think this is a routing issue with RTNETLINK, since you can also
> test this with route:
> 
> $ ip route get 1.1.1.1
> 1.1.1.1 via 141.14.41.4 dev eth0 src 141.14.41.4 uid 1000
>    cache
> $ ip route get 1.1.1.1 from 1.2.3.4 iif eth0
> 1.1.1.1 from 1.2.3.4 via 141.14.41.4 dev eth0
>    cache iif eth0
> $ ip route get 1.1.1.1 from 10.1.0.1 iif eth0
> RTNETLINK answers: Invalid argument
> $
> Does anyone know what to do about this?

Try checking accept_local and rp_filter in
Documentation/networking/ip-sysctl.rst

