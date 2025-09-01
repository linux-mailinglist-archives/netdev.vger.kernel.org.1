Return-Path: <netdev+bounces-218874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E00B3EEA7
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5594859CC
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933CF342C90;
	Mon,  1 Sep 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxvEDCAN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEE341ACB;
	Mon,  1 Sep 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755977; cv=none; b=KYbghHtczhzeGzaZ8uRY85GC35AFmtSKh5trtmrzDhtpjsLAFNz5cGhGX5mdqdBOTPFqmJ5PwGlV3zjEG8vEDnz/+mNY2qzm+UD2e5UzNKevDHkPNV/8VlIQE97DC1lixd15okJSNBrwl7k6Zc/7AkFYiHwTgank7u+VRYG4SM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755977; c=relaxed/simple;
	bh=ZRakmcIHvH3f1B8RfyE9ZrQBrbqMERiw45E9xr2Ei08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7VqFspuP++1IDD+1Ssg80hvr36L7XMZeeVi528LqTp/1Sd7Vdq3SJjrRitjghlrLuYUfm6Gg+enhDpEyVW8cusshuYt1NMEAhodEPD/BH+uOheQJobz9IXymsA8ZzCSF74Cxsg+RyratNElJsT+4jXVBNHtQaGoavXcdCkgzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxvEDCAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A71C4CEF0;
	Mon,  1 Sep 2025 19:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755977;
	bh=ZRakmcIHvH3f1B8RfyE9ZrQBrbqMERiw45E9xr2Ei08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NxvEDCANFCg4HqSlMCXmTgHyHef+ufLbqMwojmG4GVg61BL79pZ2hr/Uc3txc3o25
	 EJTn1olTO/roupsUd88oHI3D5SwwjZgoFMIO2mcLloKeWMWdd3AI+wQj8Xq0Li6Q5s
	 pwUq6BFEf1eQoXCnx0awGWsjqdygTLqaygHYkd+6xJf/Htc9dQ0CJ+3YbJtT+BE3IU
	 gozEuxkChZdv8fOYr99iJJ3fSplcr+xryzKYHYjrkfWy9GA2w8C05MrDGxUMgQGbpH
	 PITutXYblzBzhcCEUgcz+WupY261tAm5F3h5mQnxql4Uq6zV0S65TjoGJKGDu8ZvWM
	 LC7CklprNex6Q==
Date: Mon, 1 Sep 2025 12:46:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Helmut Buchsbaum <helmut.buchsbaum@gmail.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: ks8995: Fix some error handling path in
 ks8995_probe()
Message-ID: <20250901124615.10afb6a0@kernel.org>
In-Reply-To: <95be5a0c504611263952d850124f053fd6204e94.1756573982.git.christophe.jaillet@wanadoo.fr>
References: <95be5a0c504611263952d850124f053fd6204e94.1756573982.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 19:13:59 +0200 Christophe JAILLET wrote:
> drivers/net/dsa/ks8995.c

This file got renamed from drivers/net/phy/spi_ks8995.c in net-next,
this needs to be regenerated against the real net tree.
-- 
pw-bot: cr

