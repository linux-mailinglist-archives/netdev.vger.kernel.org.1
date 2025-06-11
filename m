Return-Path: <netdev+bounces-196725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E34AD613E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE2D1E15C3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35330248195;
	Wed, 11 Jun 2025 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDJP3oC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D263247DEA;
	Wed, 11 Jun 2025 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677125; cv=none; b=MzrXT+lBnttSR8Og/iWKgzGw9b9HdJiavSlxAm9OeaRt5zMoAdmValsHPc6EDQsRnhhKlzNJMhwJheCkWi+xFvJ3FC+jYjeDIjnkRvBLwvpNeVXjj1MUs8DW0QXTjInDr49EXRvcBPfk6DMVdEmt1LqKa7BrVfc2l9lhqa3uSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677125; c=relaxed/simple;
	bh=p5G9hodyoqquGQv0FDJLWXP70EcteeuZIP/ixo9N4RM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8bWY8BlfegQtyReVnJgDGaBW/d5phhEr1+fdd7HQfjAzb1a6uJSPMsC8/aBnjPwNb59wOXGbf0HB89zD1eT3Im+WnH7X64aZxFKXMDpzrWyiAFOFJUdc7bPWALVsSfxj7qDZKWd2Qx8vQN2vjaLJMWWNewH8gNzfStjUx1K5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDJP3oC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516DCC4CEF2;
	Wed, 11 Jun 2025 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749677124;
	bh=p5G9hodyoqquGQv0FDJLWXP70EcteeuZIP/ixo9N4RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hDJP3oC0xQexyVhR/7d4PZtjUyHFBj0hP2HYXx5kEDYYvUG173CJ5Qfo9lSNM07Vy
	 8r4fFR37bDAD94oq9ai0JOuHFxKCjX9DM1WV9tXJ2vyuvxnD2Yb/KTTYCngc8baNOD
	 zCDftQ49uBaS114bnMk3PIOJ1lL24Gy3Qayqj4tB95uYkcB78ymm3dMweLJ82kKNKd
	 dtc7QTPlvNwUOBvQGGPLeiMtk9esKZhdTqF6DFrnNqzQt1wIXyCZKVQkjvo0a8HQFy
	 4Vj1cnFaQQ9k6P6zreTMcMj/Dd4Sdp5WL6VN582GftigXuql4dXcGDKFMiKL00CcNj
	 UIr2ywhn1x1Mg==
Date: Wed, 11 Jun 2025 14:25:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
 <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next] rtase: Refine the flexibility of Rx queue
 allocation
Message-ID: <20250611142523.67e7d984@kernel.org>
In-Reply-To: <20250610095518.6585-1-justinlai0215@realtek.com>
References: <20250610095518.6585-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 17:55:18 +0800 Justin Lai wrote:
> Refine the flexibility of Rx queue allocation by using alloc_etherdev_mqs.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 4d37217e9a14..c22dd573418a 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -2080,8 +2080,8 @@ static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
>  	int ret = -ENOMEM;
>  
>  	/* dev zeroed in alloc_etherdev */
> -	dev = alloc_etherdev_mq(sizeof(struct rtase_private),
> -				RTASE_FUNC_TXQ_NUM);
> +	dev = alloc_etherdev_mqs(sizeof(struct rtase_private),
> +				 RTASE_FUNC_TXQ_NUM, RTASE_FUNC_RXQ_NUM);
>  	if (!dev)
>  		goto err_out;
>  

$ git grep RTASE_FUNC_.XQ_NUM
drivers/net/ethernet/realtek/rtase/rtase.h:#define RTASE_FUNC_TXQ_NUM  1
drivers/net/ethernet/realtek/rtase/rtase.h:#define RTASE_FUNC_RXQ_NUM  1

This patch is a nop?
-- 
pw-bot: reject

