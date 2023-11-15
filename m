Return-Path: <netdev+bounces-48120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E38D7EC9BB
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A5C1F2112E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CA3D3B7;
	Wed, 15 Nov 2023 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcESovtN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F77E33097
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 17:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1213FC433C8;
	Wed, 15 Nov 2023 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700069706;
	bh=o+IurAstOibF2RuOKRlGkX2YVTAnKEoC1eORsyVB0Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcESovtNiiDztQBGwdBr8ouxz/+okMvfLjyE2VrIIqASuCA2lnFF0De1vg+i65ia2
	 XL/4Uf21moXtFKpvONFXqMh9HfS0Jl9HRU1s0rT4MJab6u1p32jACmabaZH+7NXTYg
	 9pgYIVMn0KmMIdLdQSIQ5t1c7WStQSa0iRdEsvLl6RKMT/TyJr2Ccf8G7dG1zuWMpr
	 TlWIw13Yz43EjbPqTEeVqT2/BWjniRG1JEXXkDPkpsd55diZ/NJmmcrAT81pjrLxsK
	 fKih6Z0cTxqB3UbbA77YTRatBiUW83WUZguEu5/3Nn7P8FhUKWKJiL/jaFBpvsFamJ
	 yMVPQNdrP/WTw==
Date: Wed, 15 Nov 2023 17:35:02 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: improve RTL8411b phy-down fixup
Message-ID: <20231115173502.GT74656@kernel.org>
References: <f1a5f918-e9fd-48e6-8956-2c79648e563e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a5f918-e9fd-48e6-8956-2c79648e563e@gmail.com>

On Mon, Nov 13, 2023 at 08:13:26PM +0100, Heiner Kallweit wrote:
> Mirsad proposed a patch to reduce the number of spinlock lock/unlock
> operations and the function code size. This can be further improved
> because the function sets a consecutive register block.
> 
> Suggested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 139 +++++-----------------
>  1 file changed, 28 insertions(+), 111 deletions(-)

Nice. Less code and fewer locks.

I manually verified that fix_data matches the code it replaces.

Reviewed-by: Simon Horman <horms@kernel.org>

