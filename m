Return-Path: <netdev+bounces-229639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70986BDF20C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D991887342
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B782C3268;
	Wed, 15 Oct 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0L1Wcu+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E12877FE
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539204; cv=none; b=qMJUjkiB7Qcu33aAByuBYeEb4liRij7kU5bYCRB5oPwNMukUssLX81Tx6xm02TbBfOhOUyrvXyhjQx1wpxZ06lMpV6z95Q28EHuASr4GwkRBSY/gG9iyXVw5YoxcekiOJUHMh5H2B7qbIrGW/OpZGKP4SxJnW559hMxp7AM12q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539204; c=relaxed/simple;
	bh=q9g44yLq2HL1ssyKywQKGD9xdbiHCv5IVH+5NdQ+CW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4hD3bnVs153iZUMNwaswe1dkEx1vW0oNYQ8Z7OufqESgyZayfdpcS+T60RnuGxF+/lbUd8+QR7bF+wTBZo991+EMVKk4fP6HlVrTJ8OdljumE7Iusy/cwIF3LlxopK+m0HMp+KbeJ4YsJF10gTuxmlJYbJBzXOQ9Igoo0YxClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0L1Wcu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C33C4CEF8;
	Wed, 15 Oct 2025 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760539203;
	bh=q9g44yLq2HL1ssyKywQKGD9xdbiHCv5IVH+5NdQ+CW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0L1Wcu+fX5hKxRi2JGl4NDo64Itsitppfa2zbQmUm/fsrki664b5v0ZtQrlPm1o+
	 B9WAaSSeiye2ikzpGxQSYxM2K/Ycq9TNn3pLNeaXVodL6K7IeqqKmpmxr+wqSAnNZO
	 H8FerpWcM4wa4tC36a6tJoYfbbWv3aetF9jLJopVVcLPy2vzQCt+YWTMY5iAA9aNTm
	 E7WHHCCa+xBve68DplUF0h8VKmxf7KQjXDrxaqsgRYuWq0K9LV0a+G2bSlYhY90+kb
	 A57BkmNrZpQd8vE8q4JWgvDYXK1SaDRJSB+A1Ap6B0uzAPiL38xMRS9wdw8M7hRX9f
	 Z7PfNDchE6u8w==
Date: Wed, 15 Oct 2025 15:39:58 +0100
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
Subject: Re: [PATCH net-next v2 2/7] ti: icssg: convert to ndo_hwtstamp API
Message-ID: <aO-yPsHE3-BeNJ-t@horms.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014224216.8163-3-vadim.fedorenko@linux.dev>

On Tue, Oct 14, 2025 at 10:42:11PM +0000, Vadim Fedorenko wrote:
> Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() API.
> .ndo_eth_ioctl() implementation becomes pure phy_do_ioctl(), remove
> it from common module, remove exported symbol and replace ndo callback.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


