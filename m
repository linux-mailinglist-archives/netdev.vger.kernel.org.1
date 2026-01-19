Return-Path: <netdev+bounces-251181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D3FD3B233
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA25B31232CF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4EA324712;
	Mon, 19 Jan 2026 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Msk6umJK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBDA322DB7
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840423; cv=none; b=sMVgtwj78wR0S4NJDxt2+V6rGA8WkmmMbmhiw2eli8YgALJveccxlqf54s+94R/9j8lXvDh4mG4n+yCGb/cDPFVMOdnjuTxA/J2izhoGN4NyIT5tXKg4GqYHHqZj5EyCN5YDO3s8zGrMlg4jIddTZEur4U36NUQ361bRfzQopvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840423; c=relaxed/simple;
	bh=UisBZSBM9waY55KH5/IybAiNq6dwdcolMNYGlxgeJYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSN1peGLiBDSaOQ57RzRy2ZZeRoWtuWJv6DlEfOepIFxQ2eNG92IQIdKx5l45dPxz7XW8ets0+jk/7kpKOdUCY29484REgIzcWRsBIFBQLCJaPtGS2t+crUJK93fPIB82TXx67lxg9BTEMK9jYaKVcNNYquTW45sYmIv7vWDdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Msk6umJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CF2C116C6;
	Mon, 19 Jan 2026 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840423;
	bh=UisBZSBM9waY55KH5/IybAiNq6dwdcolMNYGlxgeJYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Msk6umJKMr9B4Wvq7F1JDvQHanGfrS3aF+zf4c+PshlQ3Woq90yi9+/QbsEYwX7Up
	 fT/QA8LWmkJo+T7ch6vdtNFK+hohwYYFWyUzsQIOp9QPKZrmXJhmL6gqleNV6AwFNx
	 9aApVTAmECilFaFve4ypaH1q7pVzv5Kku03yLC8sOFsW2dIw2wPxqzyLC0xjIRxMTU
	 XnKGBAMrBqKmkovcrPEXu1758UVGHiaZp8uzcOxZLDI/reM8fA4Rz4DB7nlYN2FKvM
	 fINf/BPA4KuH5wmpOHdPyEE5MuvwzEdDJgNxkiYjwuTNmCU5/2jWp1vLwXeh0rCgoo
	 u4/l6CrKl1l2Q==
Date: Mon, 19 Jan 2026 08:33:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: dsa: ks8995: Add shutdown callback
Message-ID: <20260119083341.148109c2@kernel.org>
In-Reply-To: <20260119153850.r7m7qf7wsb6lvwwe@skbuf>
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
	<20260119-ks8995-fixups-v2-1-98bd034a0d12@kernel.org>
	<20260119153850.r7m7qf7wsb6lvwwe@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 17:38:50 +0200 Vladimir Oltean wrote:
> On Mon, Jan 19, 2026 at 03:30:05PM +0100, Linus Walleij wrote:
> > The DSA framework requires that dsa_switch_shutdown() be
> > called when the driver is shut down.
> > 
> > Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")  
> 
> $ git tag --contains a7fe8b266f65
> v6.18
> 
> We are in the RC stage for v6.19, so this is 'net' material, not
> 'net-next', the patch has already made it into a released kernel.

The AI code review points out that the DSA docs/you suggest mutual
exclusion with .remove. Do we also want this to be addressed?

