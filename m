Return-Path: <netdev+bounces-128954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1F397C8EA
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21942858B0
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314A19B3D7;
	Thu, 19 Sep 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQK/+r/O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB419AA72
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748182; cv=none; b=OheR6UWuAOkOjzBYKp8bcfspYqukV3t61WvwmnaiU7e4q9B9XBfSUNU4CUqFI2qm+jIMgV6yzIHfdCpetEiH3OTcf1KQy6Nc9mqHhP06UD2n3aJGGr4Bjv8ox4TgWv0VGAb+apWzvufYoe4iKsH24sGJsgCHu31wUnp0lT8JZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748182; c=relaxed/simple;
	bh=8h7FfpZzbjTFptTnA/Z5o6GwaFEX7ZWJDqJwd67LE6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9xUMxr9ziBb3MRfXn6w7/lIhdXDpopoUpGbyQ6jKyw8hsXdoIpoBgpU6T2psuvvlSzivCcNPNjmwwOZ+jsj8Tr7O4KAhrlQr9Jk3SbdxA/5OZqLqK8dS1UrI/C7Jn64TB9343qltWqxQFEaJybVZpoEvpPFOEDUw1/OZDtxswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQK/+r/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CBFC4CEC4;
	Thu, 19 Sep 2024 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726748181;
	bh=8h7FfpZzbjTFptTnA/Z5o6GwaFEX7ZWJDqJwd67LE6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQK/+r/OHF9GbsIUMvKBZuSfh7EgjoyUP3Z8wjOxeCTMWxxbkzon97XcEq/WwH8dR
	 pL7IACEPTmo76JnpbQvOQggSS4cRBzAg61VabHLkLp/NmjP0+xD5xbQhRZESJPzgy2
	 9zb7Hr6Edmq0yLb2MSto0N1fE3IdJVc8aoPJJXUsvl1F5C1FGWAI7Art76CFpzQhot
	 z8fMIx4gjg6hR2FD49qCcw2VmqNC8h9SQXbl6xNCL8gh15PvP2/M+5MBgxAdrOWdSD
	 xWVlAqUxvy0Asn+InM0JmRGfolw7b+B3jA6WGhNHZOZtOOjBjc7qENbZmX9IMd9Poc
	 PsNFys0TR6tFg==
Date: Thu, 19 Sep 2024 13:16:16 +0100
From: Simon Horman <horms@kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] wireguard: Omit unnecessary memset of netdev
 private data
Message-ID: <20240919121616.GF1044577@kernel.org>
References: <20240919085746.16904-1-tklauser@distanz.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919085746.16904-1-tklauser@distanz.ch>

On Thu, Sep 19, 2024 at 10:57:46AM +0200, Tobias Klauser wrote:
> The memory for netdev_priv is allocated using kvzalloc in
> alloc_netdev_mqs before rtnl_link_ops->setup is called so there is no
> need to zero it again in wg_setup.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Reviewed-by: Simon Horman <horms@kernel.org>

...

