Return-Path: <netdev+bounces-176141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06386A68EBE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD72A7A4466
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AD3155C88;
	Wed, 19 Mar 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul+QWaPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F178134BD;
	Wed, 19 Mar 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393827; cv=none; b=DH9NFgI0LKvvTTQTw14S3/G5pn6u1oIn0GSTl9Nr3B/Q0nubWvVOxsPgJD8F+vmOaoPJBku/Ymxne9cAHoPytRRvNHvmJeanigpTzs712wv3Y+LMYr7nAIVfTEiD+J0wNvfmMLUmXMQ6u6+eZSsPSnMSNczYz9PfyRELLJWmnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393827; c=relaxed/simple;
	bh=SZgZgjOKi8q48V+T+EuPhMfJGe10Z7y4FRnPXxKBK/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7doEJgHJd9cv7sFPvz62BRXB1DmxgekjZCc/ivUdIY1JYBPxev0bpWSDXujeGqGpDvTFdjyxrdYjG+h73KEL9MjRlbPZFRxyNIS2T0nrZPUZwAbTAushztPY0+sKNQR83F94PqcknVhqbFkBqusJfz6AHQScnIekqE0FK5eH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul+QWaPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6DFC4CEE4;
	Wed, 19 Mar 2025 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742393826;
	bh=SZgZgjOKi8q48V+T+EuPhMfJGe10Z7y4FRnPXxKBK/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ul+QWaPXdGOmm/uqkJGFNkNPjj9Qnm9bJR8CrPr/KVsEDZfxvDA8ejiJkALbfsUC6
	 wLKpt2ujWKp7NuFh+18eZb0wUMzjnMnJlqHHD1xVpbwmHEktopZdw5hJfD5kL+LkLd
	 H7bi7J5zwoaYOOret/fifvn7Ga/zZ85Unszj8fwjrPhiKdZQaAinqoXW1ggVC8llae
	 EBJxb5RzhBHnIsBb7wiJV7vwUz5mdzu81es56IzC1EgxruNe9WTJ813my4PPL4+Xb8
	 9Hl3yYV36hrWwL94UWRC/JXs6d6N23fT6eFnyB0dRUcLXW4Eiop5FiRYrtxVuSVF3U
	 4gno9LzUFSIRQ==
Date: Wed, 19 Mar 2025 14:17:02 +0000
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Sai Krishna <saikrishnag@marvell.com>,
	Meghana Malladi <m-malladi@ti.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Add lock to stats
Message-ID: <20250319141702.GF280585@kernel.org>
References: <20250314102721.1394366-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314102721.1394366-1-danishanwar@ti.com>

On Fri, Mar 14, 2025 at 03:57:21PM +0530, MD Danish Anwar wrote:
> Currently the API emac_update_hardware_stats() reads different ICSSG
> stats without any lock protection.
> 
> This API gets called by .ndo_get_stats64() which is only under RCU
> protection and nothing else. Add lock to this API so that the reading of
> statistics happens during lock.
> 
> Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> NOTE: This was suggested by Jakub Kicinski <kuba@kernel.org> [1] to get
> this as bug fix in net during upstreaming of FW Stats for ICSSG driver
> This patch doesn't depend on [1] and can be applied cleanly on net/main
> 
> [1] https://lore.kernel.org/all/20250306165513.541ff46e@kernel.org/

Reviewed-by: Simon Horman <horms@kernel.org>


