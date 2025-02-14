Return-Path: <netdev+bounces-166456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3EA3609E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F6D1887379
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9CD264A9F;
	Fri, 14 Feb 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuOCaxlZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89086346
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543927; cv=none; b=IrOPZvduRUNoPcLXYiPGGNINkc40dK/eWZPzbwaPMCjGtVzh6r6Eija6KgJnklxJjcmj471FrZLZsGq8PZeOcPRzhMzeqtk2rvk0OIfQD3uqlf9zM1aJYJPVgSpJOuQBPnUoI1FXdJoOHSvhVKm5Pg0kiTB5k2kZW9pbwkKH3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543927; c=relaxed/simple;
	bh=Q1BvrEPn5e3qlCebvb+y6tAiKpOlvgzd7uVAFGfHIgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXZckvtvxN18i8ZzLfGslItcCNTMgnAbKUoqejuAmJR0pkpWkFtxQEsfeZ1TB4Cuvl1j63jBwZvliMU/c/+OY13TmhahrVGqIBPnrYLVdgmdH6LD+V30P3B5XVBLrTb9OzVyXH/I7nFUadKZKK+p5IBWkv1hwNj5AG+Mk9c3uE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuOCaxlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F59EC4CED1;
	Fri, 14 Feb 2025 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739543927;
	bh=Q1BvrEPn5e3qlCebvb+y6tAiKpOlvgzd7uVAFGfHIgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DuOCaxlZGgq7KCC9F+TN6anoQGYGrWADb6oylpkCNxwFK5fBGUq44PIwu1NxMwkQP
	 e1u1Gt9jCq8xNE6+BdJD6bhJUwtcR7sH+HAeaBL6feRp6syGSZsYqLGp3LHCI868QF
	 ww6rpxoErEd6xh38UAgX/K7Ntn1sIyKi2E7ixmMooVtJHdF4T1Fp0bTsNh+tH1eUPn
	 6eWyfAxuPvULPgGkRHN2D+x5vcSJCAQLMxJ0BIO0DQcio+h7xO79HQ8jtOYoxAMOu2
	 GcS4KHl73jpga0rnoBTx4RdzJfspnwzrbkyYC7ET+1//rsIY1qOlkaRBCzg9Yzz8h/
	 JHjeV56kZk85g==
Date: Fri, 14 Feb 2025 06:38:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, willemb@google.com,
 horms@kernel.org, Ziwei Xiao <ziweixiao@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v3] gve: Add RSS cache for non RSS device
 option scenario
Message-ID: <20250214063845.5a9d2988@kernel.org>
In-Reply-To: <20250213233828.2044016-1-jeroendb@google.com>
References: <20250213233828.2044016-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 15:38:28 -0800 Jeroen de Borst wrote:
> -	return gve_adminq_configure_rss(priv, rxfh);
> +	err = gve_adminq_configure_rss(priv, rxfh);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Fail to configure RSS config\n");

coccicheck says:

drivers/net/ethernet/google/gve/gve_ethtool.c:915:29-61: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD
-- 
pw-bot: cr

