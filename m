Return-Path: <netdev+bounces-103434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA07908031
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633051F22437
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182863D;
	Fri, 14 Jun 2024 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UARQfXp9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA3372
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718325040; cv=none; b=fnwzZQ/IToC8fpkXD1DKKukv4JzTg50v9ZBiKCTTlfzjmCyicf97V7c5K0tshqHg41Q1RNS3plgBm64BgmyY5C6ti32mLWj1jl51KVv0p1CEaXq8h8miEP94KtIYg6T4+efpOpMSqtVdf3ihXT1R3e7YYjGMhqRZIHxM7egtvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718325040; c=relaxed/simple;
	bh=CjnICSpEpp3z19/6O/85G5R1rt8RSEso2VhrouL1Wcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GV3qEzP3wtkiMj1YKy7h6lSIapVu/cKVlYJIFIE+jc920wTdXsULsr8XAQ0yZ0okPnAL5hm2pSYnKyddtDgQCumEkuzq9brO7taiJBcSZINsJee2TEaF0Q1mkVV92OAfi147jAajuZ1ndQ5sJvmDuq5ekF35EZYPFWx3K3hz0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UARQfXp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F72AC2BBFC;
	Fri, 14 Jun 2024 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718325039;
	bh=CjnICSpEpp3z19/6O/85G5R1rt8RSEso2VhrouL1Wcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UARQfXp9IhIjUCpeVI2kuLPqITjuORwvQz9jM5b0VUM3c2Jzb8PC53x7q6ZexzmP/
	 pfFJh+8oJ8gIb2Vz3RNx8HvKuFJfxDbXUyav5kLnp+544BRMlcCgnCG+qifLGf3hLP
	 XmEgog3FOb6BhSt4tUieF4/ntjJdTBAFVRJph0MvJZC/+IR4kgI6Xqw0b4zc+36Eas
	 TCRPln//8YMSikXsuaSSk9U7wcFvIuGDrwtOzftrhGgXjZ5AYMLHqvzUGvKpYTs1C2
	 ALHFVJqnHHPCjBQdGwnBT+2dVrzKGQfNzHWr78tKiLRzdbuKkZC7dCFpv818J2bVPx
	 I49/Ss9lMWnJA==
Date: Thu, 13 Jun 2024 17:30:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
Message-ID: <20240613173038.18b2a1ce@kernel.org>
In-Reply-To: <20240611045217.78529-5-fujita.tomonori@gmail.com>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
	<20240611045217.78529-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 13:52:14 +0900 FUJITA Tomonori wrote:
> +static void tn40_init_txd_sizes(void)
> +{
> +	int i, lwords;
> +
> +	if (tn40_txd_sizes[0].bytes)
> +		return;
> +
> +	/* 7 - is number of lwords in txd with one phys buffer
> +	 * 3 - is number of lwords used for every additional phys buffer
> +	 */
> +	for (i = 0; i < TN40_MAX_PBL; i++) {
> +		lwords = 7 + (i * 3);
> +		if (lwords & 1)
> +			lwords++;	/* pad it with 1 lword */
> +		tn40_txd_sizes[i].qwords = lwords >> 1;
> +		tn40_txd_sizes[i].bytes = lwords << 2;
> +	}
> +}

Since this initializes global data - you should do it in module init.
Due to this you can't rely on module_pci_driver(), you gotta write
the module init / exit functions by hand.

