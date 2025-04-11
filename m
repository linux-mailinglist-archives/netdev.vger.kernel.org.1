Return-Path: <netdev+bounces-181449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355DCA85081
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5B23BCAD3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B24C7D;
	Fri, 11 Apr 2025 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYPjEYTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F236D
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331332; cv=none; b=NiVgqrhnRObFO7Q9Wi9npsbo6Hk0ssn2Eev8rfBTOFUe1UAssLWN0pbufGdtLd+DFZQl1xmP8nA3cGtp73Z49l+jAl6UWt9V5ftRQGFFOsDJQLAmyBzVvYpfICp/ZtwArfgkWWm7EdxUajNigW/Hzmml1pherKVk93EwhMj/Fnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331332; c=relaxed/simple;
	bh=+sP4QBaVnDWoVGNVY06qPkgl3rKSdN6Re2uP7qPW27U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMgFz5tDEt0Npc36e7NkmYpuO5ouOx/t3c7XRCDL0JJeMTZf9YmLoYmvaM7/uPMQUF84J08jp9w3e5kNPt0hDe91L+FeqMHOiX48yH3wNvCX4pSnKU1i/O6gISPaVd0UYW6wATkD2X3RKxJUiU2UikmDgCDbkPhLd8padKd7keU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYPjEYTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADB2C4CEDD;
	Fri, 11 Apr 2025 00:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744331331;
	bh=+sP4QBaVnDWoVGNVY06qPkgl3rKSdN6Re2uP7qPW27U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RYPjEYTFuL1H5+Iy/0ISguOKD79Kjk4A404JaUFc3aY5AfJD1D3X9l3u5GlwUvh7u
	 OOT4cMVegG9jcrZk/qNZy8FQbrnJIYl7CMPEzt9NPfj2jNye6NSFyikj2i1hRwTlUr
	 a0gE+n99e9t4tMhdmmnzq0mihEKcqQvIWiJ7B21Eg9ipFKQIxjed/a5VXRuYMrnLp4
	 RcywnCgi7Ajb2H2oFG25Mg+BARezKhos+MAotfYpoFa85vF8YTX0EPuhblXFsAR1ey
	 TLFWi1likOBA3nJy9tZ+CCT6fp0jMariLdAQ86eFMoVGFw0krBAe0Sa+KnZK9pesIF
	 QgCauXMkL1vWw==
Date: Thu, 10 Apr 2025 17:28:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next] io_uring/zcrx: enable tcp-data-split in
 selftest
Message-ID: <20250410172850.55752f0b@kernel.org>
In-Reply-To: <54a8a9fa-9717-435e-9253-40f3a0a7f779@davidwei.uk>
References: <20250409163153.2747918-1-dw@davidwei.uk>
	<20250409170622.5085484a@kernel.org>
	<54a8a9fa-9717-435e-9253-40f3a0a7f779@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 19:06:13 -0700 David Wei wrote:
> > You should really use defer() to register the "undo" actions
> > individually. Something like:
> > 
> >          ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
> >          defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
> >          ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
> >          defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
> >          ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
> >          defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
> >          ...
> > 
> > This patch is fine. But could you follow up and convert the test fully?  
> 
> I'll send a follow up, one to switch to defer(), then another to call
> tcp-data-split on.

Thinking again this should go to net, rather than net-next.
I'll apply it now, but just letting you know that the follow up needs
to wait a week for trees to converge.

