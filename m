Return-Path: <netdev+bounces-218876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EF6B3EEF3
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC44E0EF7
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550A026D4E8;
	Mon,  1 Sep 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4S03Grd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9126A1B6;
	Mon,  1 Sep 2025 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756250; cv=none; b=Ybk72jVCUPTy2e4pUL5VFxxG+OP2Drr+QXzD/lLsoTyFBrhTwoOgfyVB0sBmY+P+tsD3+aXvGQBacBl95hpVN6LTUrCPM8fW/4Z4vWxQM6gOYdDQCwuseegpcGmMt4uW7DdEfMZ5f42za3LkkAdF1kR3qIizDnQ6JuFB+0IddYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756250; c=relaxed/simple;
	bh=OFdjaiOif/kiG2e1g8vLRRWu9ClQaShYFQD7zmgbTbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ip1TR4bpsLzAqdAaNlSGxGOb8B/UYzBNBS3+pcXnYDK7xjnsnWFLVrTFOyaBQ61wynep0mNDdKVBX2Oyaq2m6L6+byH/EvdjxCiUAhvrOVubnNaZ6CzP73oaAai5swhwUz8/aXZC9gXLwdPRwH0k2xj0eAjfxRoj5ZSTbrx5LB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4S03Grd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD96C4CEF5;
	Mon,  1 Sep 2025 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756249;
	bh=OFdjaiOif/kiG2e1g8vLRRWu9ClQaShYFQD7zmgbTbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K4S03Grd0NQGHuaRX9Cuj9fJhT5hRtNdJH9aLpuG7GbAXnFtsmcewy0YO243+uhZN
	 pq3tf7GBMB14auhJ6syiT3I5t72YIkfBUOwmrAPlPmh9JyY3iVFXjsu3x4UuY3Z68N
	 /uUSygZIgucIBmj8HeYYRVrIBH/YgGDH+beAfxGXXCXLVy0z04SPDkdTFK6/3YAd+6
	 S/up8vdqRNjtlU0AZHlJUYldrgHZ+hQDXxenheG0ygRw3yC23pb4/D4FLXEMJM9C77
	 OjFkmQxlpEW9l6mgvPuqLAoRnHj9Qap6fwrodXnR2eDbQWzhoBKXwyz363EbC/5r0Q
	 1FKqTyzjkc9pw==
Date: Mon, 1 Sep 2025 12:50:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: Fix refcount leak in
 mvpp2_use_acpi_compat_mode
Message-ID: <20250901125047.4c909ace@kernel.org>
In-Reply-To: <20250830091854.2111062-1-linmq006@gmail.com>
References: <20250830091854.2111062-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 17:18:54 +0800 Miaoqian Lin wrote:
> -	return (!fwnode_property_present(port_fwnode, "phy-handle") &&
> -		!fwnode_property_present(port_fwnode, "managed") &&
> -		!fwnode_get_named_child_node(port_fwnode, "fixed-link"));
> +	if (fwnode_property_present(port_fwnode, "phy-handle") ||
> +	    fwnode_property_present(port_fwnode, "managed"))
> +		return false;
> +
> +	fixed_link = fwnode_get_named_child_node(port_fwnode, "fixed-link");

Wouldn't it be easier to switch to fwnode_get_named_child_node_count() ?
-- 
pw-bot: cr

