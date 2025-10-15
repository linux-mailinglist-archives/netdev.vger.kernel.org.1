Return-Path: <netdev+bounces-229547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08891BDDE83
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA71C3AD400
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5B31A801;
	Wed, 15 Oct 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKoNui74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639982C237E
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522738; cv=none; b=nYGaaZQXVolLI0Igz7IbF7kXYCOIs5r7P42LDxeO2bA1NuXUPKbeoW2CsPhU02fBthunRq17AzVSeQ1MKwpoosKNtDNiMlsXsgU7BS1yVB8bnBD6OB4LZugucceZnsqzbsWg9pTr3612g62gnvhFdiRSqjH6SZA/GuNq0clJ/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522738; c=relaxed/simple;
	bh=92fgc6wjIMGw7LTmauWhWBOHs4s7IIEuiYJcbbf25TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLE7vWopTkU8NAf6yOSPgxCn9RWG6z5CgMp0EW5jNHLMVoKkzwo9ZZAxR21Wyr+F0BWHIK+1hoNZJ6OlzcJgWYVXTefQa+1ZTpHDMJMi/QWjnIOegitNLgmKJzqd4yAQ87ys/nEKw/il4m9SR9HZu0b66wFEkWHsUbc2UXyfahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKoNui74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041D7C4CEF8;
	Wed, 15 Oct 2025 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760522738;
	bh=92fgc6wjIMGw7LTmauWhWBOHs4s7IIEuiYJcbbf25TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKoNui74xqk+3x18X7WSMNzENqhdSjbg2U3n1jFzELWmU38YGvHUUH+4L8oIuV0aj
	 01YMHDBbjYspSsKhKz3qsPtKFQ4vXyou8Owvhb/Telo3u44wL74/lbQxD1m0qnvtjb
	 FmgxMb7NKF/BtzIKaRr1Ho83usqEVLAIa+N1IpMOz9RqJRmH3S623YzL/+DluOOCXK
	 eNBkA/ZfIognNBi72k2ti7frnXFGVk1eIgfRoKIeIJUjxED+FhxV2dRmZMYtSMvyai
	 YDTyxOq+7TkRFa/ELMOgI6zhKJB22jJAVF8v5AW3fNpjDiby410n3IbDK2wNLgqeYc
	 d0tWG+MxEX6Dg==
Date: Wed, 15 Oct 2025 11:05:32 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] cxgb4: convert to ndo_hwtstamp API
Message-ID: <aO9x7EpgTMiBBfER@horms.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-6-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014224216.8163-6-vadim.fedorenko@linux.dev>

On Tue, Oct 14, 2025 at 10:42:14PM +0000, Vadim Fedorenko wrote:
> Convert to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> 
> Though I'm not quite sure it worked properly before the conversion.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Hi Vadim,

There is quite a lot of change here. Probably it's not worth "fixing"
the current code before migrating it. But I think it would be worth
expanding a bit on the statement about not being sure it worked?

...


