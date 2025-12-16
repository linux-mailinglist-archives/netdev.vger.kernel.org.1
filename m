Return-Path: <netdev+bounces-244918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A9CCC21EB
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1FB83056797
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C65258ED4;
	Tue, 16 Dec 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUgP+C3T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D476495E5;
	Tue, 16 Dec 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883877; cv=none; b=WYmOG2m/KmCj3YxCxuYZcL161dHDZYYz+TglPB50rKQuFs0A5dWsNksHkzbhgHPP13Tbv5VEr0k/6B5R9EOI9oJnqJNHDeaAyUgh64YXRgI6ZrcwPhsZGno8UQFI59/B9WRyeo53yWwGQAED5bd8Sqd6ag5iNDFhf+gvRp2Fw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883877; c=relaxed/simple;
	bh=BEuyTtqDMx5h6ORSf5bINsSWI5dnWXm/xlwkK4G19o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcSirAduAthsOBbC7ehRtWCQZ6l5iHfEroVx6nBD3TVtpJVHYeGA3BT6tOHZwiFq5i658y/zeD6F3xmtYdRYnI6Z5fGpBH+TYfKOjuoRfQunaf1C9eH9GCFxuAaCH/Wgfo7nB1+oyy5f7kdrGJ8V03oE5Gr4+hUabnWd3qBUUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUgP+C3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5598FC4CEF1;
	Tue, 16 Dec 2025 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765883877;
	bh=BEuyTtqDMx5h6ORSf5bINsSWI5dnWXm/xlwkK4G19o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUgP+C3TQCnh0T0x7P6XIawOktkqlkoFmYWHg2zPYbezHdiEX66U/xMxZ5u+cYdgY
	 wD12921OTJMHrtObMspiLFnmRFIxNX+HDrrPbgmTSTpyQYScmaS6nQrypaL6ko1eU4
	 vgCdQ4qJxpgJzXlx6qiKoxCUO14TaVJJzSMj8MGd0JvAwjWGeDGxSrJ0AZDJvY35cb
	 MnPbmFydEGSRM6GTUZUCG2NmOfWKm50Iyx1sUxbjuM4w4A93wBn0sCreaEAhp/mY6g
	 uB5TiyOeYoABu8U4LDJAcfccXhDs6LZilKo1hIajaI9KDSt3zWG+c977C+7MEJnYiQ
	 UTh9WxbID3ZbQ==
Date: Tue, 16 Dec 2025 11:17:52 +0000
From: Simon Horman <horms@kernel.org>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Julian Vetter <julian@outer-limits.org>,
	Eric Dumazet <edumazet@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] ipvlan: Make the addrs_lock be per port
Message-ID: <aUE_4PUVISMm4ycL@horms.kernel.org>
References: <20251215165457.752634-1-skorodumov.dmitry@huawei.com>
 <4a0b0695-f13e-4611-a6a5-524b4967ff6e@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a0b0695-f13e-4611-a6a5-524b4967ff6e@huawei.com>

On Mon, Dec 15, 2025 at 08:00:52PM +0300, Dmitry Skorodumov wrote:
> I'm working currently on some selftests/net for ipvtap for some kind of test (test calls "ip a a/ip a d" in several threads), but I'm unsure how to proceed:
> 
> This patch is supposed to be a "fix". But selftest - obviously not a fix.
> 
> So, I'm unsure how to send a selftest for this.

Hi Dmitry,

I think that in cases like this - a fix coupled with a selftest for the
fixed problem - both the fix and the selftest can be included in a
patch-set targeted at net.

