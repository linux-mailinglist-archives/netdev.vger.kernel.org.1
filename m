Return-Path: <netdev+bounces-111484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB128931573
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB45C280D23
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52318C34E;
	Mon, 15 Jul 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2Sl6GDY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E818C340
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049099; cv=none; b=CLDXoEbUbElGsJNBnUEKA2kG9wb9EYappO4z1M3jn73UOw6bq8utYNGgwHUcgK5XorFrsryXOd61WIChOqruvyF9qx4ZyupoMBgSRL0ysRCCU4AEFAf1Xo3G3XD+AXTA40jz1QZWhtEJF8DmUo7mZHQjv8FZ+JjB37nrWnBnF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049099; c=relaxed/simple;
	bh=m5KNutGUFFetKML3Vw7eD7EvygsIjEEnZyHmZw/zafY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3YMmmPCl3LAQ0SM2QyXc4fCh9qaHN4Z4O5YsyDLMXbPQA6ZrOyXH03r2CWMj1xG12yvoOQ5mkUaqXeiymFW3xYr/FEl/iQgkGUwMOotLRCcpLle5RdUupTx2aNSb1T9758mmgzyFkgk/DGW8QtIEN9qef0AS2kG3P/GJkukcOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2Sl6GDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BA0C4AF0E;
	Mon, 15 Jul 2024 13:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721049099;
	bh=m5KNutGUFFetKML3Vw7eD7EvygsIjEEnZyHmZw/zafY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S2Sl6GDYhcHmjcfKmy7sFTJ94Vvpa81aSRoKWLG+LMQVABzPHFyOPVXV2rzWCiyd+
	 C1739vHPwPbFGTDeZCTQc0dyejpZRLax4cjDU/D1q69jfXxYMurTE0HW6OFET6VkIX
	 Ednkhr1/DGHBjv+R+WDlzKimzdj+r2oGED3/OsycQW0o0QxNdnRAkvsiPYVcgokj5Y
	 FErtqvWc91fpKJYoMkLZhHOZ4E4OjuOVeIz9PPjVTdvXzOK6J7LM3hRxGw0pa8NxsY
	 Q2oZ22HHCCIid14AwZdM4lmk66s+6AUhPUmuGxR8DHGXES98B10v39RM0fdctvFqCI
	 slVBPUDPoabGw==
Date: Mon, 15 Jul 2024 06:11:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "Mogilappagari, Sudheer"
 <sudheer.mogilappagari@intel.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>
Subject: Re: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Message-ID: <20240715061137.3df01bf2@kernel.org>
In-Reply-To: <20240715115807.uc5nbc53rmthdbpu@skbuf>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
	<IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
	<20240715115807.uc5nbc53rmthdbpu@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 14:58:07 +0300 Vladimir Oltean wrote:
> Looking at Documentation/networking/ethtool-netlink.rst, I see
> ETHTOOL_GRXRINGS has no netlink equivalent. So print_indir_table()
> should still be called with the result of the ETHTOOL_GRXRINGS ioctl
> even in the netlink case?

How about we fall back to the old method if netlink returns EOPNOTSUPP
for CHANNELS_GET? The other API is a bit of a historic coincidence.

