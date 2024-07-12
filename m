Return-Path: <netdev+bounces-111143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E38930074
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7D71C22B1D
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB241B28D;
	Fri, 12 Jul 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkp29Xrb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA8199B9;
	Fri, 12 Jul 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808705; cv=none; b=il4h+j7uiGErIHBB3feu6juh2sF7QW8MhNvoe/WPGtwHSchy0XGCdG306e2awK1m12gLl3kSBZhoSB5TuTyvIAlh8ulLJ5VFNm42/zRpbAXC02S7VZO8B77/Ge79bW8haDksUwIWTXhPo8Ks0sd5kpoBa3nD3jQAWB0+BIvtyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808705; c=relaxed/simple;
	bh=ytl+qStaRWN5MPeht2osE5k7c1v2pdGtsE/PG/Q9fKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh7oVWpCd4K+s2mHx4jkl0vo1JzVQ1eIMpIaC1OqPNO+EuI+iUqGqdzmT0UfcobfsGNr2cQfEIqW7vyNsQNyDicNBOcmT90JuYPxw7rQShnS9ZpR0+pU2oRWSQAUB0EQJvQvaCJbCPHHMf3Uituw8ZhtP0Q/HLVz5S0bBqdkXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkp29Xrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BD8C32782;
	Fri, 12 Jul 2024 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720808704;
	bh=ytl+qStaRWN5MPeht2osE5k7c1v2pdGtsE/PG/Q9fKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mkp29XrbxcqHLsGzQMqRDt+UshPx80sQJAAbC6kedDSZG/c+8nw9MdUJ+mNBofwES
	 3ASApV0Bi+4XQoLYA3+hRDe0Kl6z7fHTJfx6Dr6EteL5hATAvhjdNkLkOfVT1xtC/X
	 V5A9guIMdLudBqId16fK24grWQjNZgdifbT1gJRzWoWJsIz4LQMEugPr/VWKYQDkl5
	 2I6lZZwcPGY8x+oPpkPyT8YWcOhaZMStCXh4zBBl8bbs+SZsBU2yBAxN17mfX+90tg
	 1rzemFkzHAZIQI+BX/zcIeXylfsjQCxoJSoteUlJ2FrW6R7Ngt1fuaLXFjv9fEynEv
	 H6/MpTUNMBQ8A==
Date: Fri, 12 Jul 2024 19:25:00 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvpp2: Improve data types and use min()
Message-ID: <20240712182500.GE120802@kernel.org>
References: <20240711154741.174745-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711154741.174745-1-thorsten.blum@toblux.com>

On Thu, Jul 11, 2024 at 05:47:43PM +0200, Thorsten Blum wrote:
> Change the data type of the variable freq in mvpp2_rx_time_coal_set()
> and mvpp2_tx_time_coal_set() to u32 because port->priv->tclk also has
> the data type u32.
> 
> Change the data type of the function parameter clk_hz in
> mvpp2_usec_to_cycles() and mvpp2_cycles_to_usec() to u32 accordingly
> and remove the following Coccinelle/coccicheck warning reported by
> do_div.cocci:
> 
>   WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead
> 
> Use min() to simplify the code and improve its readability.
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Simon Horman <horms@kernel.org>


