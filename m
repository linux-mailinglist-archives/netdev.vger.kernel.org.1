Return-Path: <netdev+bounces-134726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFCB99AEF3
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E54B21BD8
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B31D27A0;
	Fri, 11 Oct 2024 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fmn7k/60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1321974EA
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687499; cv=none; b=jkoWE35iqPprU9BBtbalho/Le+8fPvL1PbkDyZDQOM85RcaYxEQg7xYAFw5jN96Vaqyv25+LdXMObCA8TpUGiLRy96d0cQzhstZRs+zPBwmvfFlzhUtCgRBVBgsKAAzKin9mJKKIx/rlU8GfomHhycPMM1X7ay1d1ZkyuLC82gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687499; c=relaxed/simple;
	bh=iSAfM0H141CAuibj0MuEb3igjCtQqYvlR+TupSIvZBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzj+DyzGcZbqNWe/HYqNcJYaSZovHxB8VRJ6anS9xM8bWo2FuEDVw3khv/RZlIGEdQFQ0ajDcsQ7gpCf5+ahL1k47Y4vI6/+gWixyNPv4WRWx5hzTQqSahVgM2dAftJch0Ezy9aNzfIvNrtx0jNG2RDxXhgceVlDrBmUf36KUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fmn7k/60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A490DC4CEC3;
	Fri, 11 Oct 2024 22:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728687498;
	bh=iSAfM0H141CAuibj0MuEb3igjCtQqYvlR+TupSIvZBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fmn7k/600eAsE61mY7Du1OTdW6v1ejhMe+O9P/fGZvhC+8M6fmIqWE0m1KKZzC4M9
	 Hf1hIQmk4hLXNydHczJ6Tjc60zxwtbTPTLUdZrU+fTPNVnl8oIrlKGUKtr5ZOTlCrI
	 HmGrMZeC4NYEVEjHva764OzaAd+poM/sCbNArmS7h/W2+qgeoeAZ2oRRAlPvAaw5iS
	 /nzK2B5pa6Slqwchn5JUTngi6fkrwUwppoHfsQPU2Uvq4V9/1xxdRq+u4+8nya7P5+
	 X3nPfsS+2u4b2D/vQsNAkiNCWpezmh7NRIgs5HBA/LlnlNSV6ouwiisCzYvJNGJiMT
	 pdYSlPFpPdlVQ==
Date: Fri, 11 Oct 2024 15:58:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3] r8169: use the extended tally counter
 available from RTL8125
Message-ID: <20241011155816.09e4e3d5@kernel.org>
In-Reply-To: <a3b9d8d5-55e3-4881-ac47-aa98d1a86532@gmail.com>
References: <a3b9d8d5-55e3-4881-ac47-aa98d1a86532@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 14:40:58 +0200 Heiner Kallweit wrote:
> +static const char rtl8125_gstrings[][ETH_GSTRING_LEN] = {
> +	"tx_bytes",
> +	"rx_bytes",

these I presume are covered by @get_eth_mac_stats ?

> +	"tx_pause_on",
> +	"tx_pause_off",
> +	"rx_pause_on",
> +	"rx_pause_off",

and if you want to add custom pause string you should first
implement @get_pause_stats
-- 
pw-bot: cr

