Return-Path: <netdev+bounces-119967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033E4957AFF
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ED8282C30
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06D217BB4;
	Tue, 20 Aug 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy4jsgGJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4FD51E;
	Tue, 20 Aug 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117583; cv=none; b=FfK2awrfggYbvRAXxv3SqlCbMhC2HT/xwO7wGQ1VvXQIoeU5GiQ06IwLO3ywtyE3EydhRG3SKfIs+k/N6iyvcYiKrBikhTWeRN74JszPzF6evoBs7dmSWTrsV4Iu6I8imDGkC8sGS/6GTIGKUVUup6IQFlP6Qwpzcojy3PRQQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117583; c=relaxed/simple;
	bh=Tdqug5IeAAWe7rMOk6UxGjNRhUc56LQEVOagI1zSIR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P153rUjWVDKAzhHqpAy1uTO6yjG1QmYkU8lzjFZUNY1aK/VP+BqiFrUlnlpXiVa6a+5XSdT3qPxYZhsC4DHq4tVXEJ8mPb3DjcjFhUiENeimriwBntk7kY0QtgGNJ7pyztQZZJQyZApi12FzIRtkTa4f2K3qfr933OPMTZbc3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy4jsgGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97C6C32782;
	Tue, 20 Aug 2024 01:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724117583;
	bh=Tdqug5IeAAWe7rMOk6UxGjNRhUc56LQEVOagI1zSIR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hy4jsgGJsQEZNS17PMtGRSoNhD35Eeg2haJmwbzRdcIR49CPQrw34zkyxcRwIn0l/
	 po/6/AjYjHC/59IAbOTrHgOto7vWAaCV9DQrmJ3IeajmCB4PHMOrTy6jlT0w6iE6Nw
	 Ilr34miXrfPit3rnoohbKeVjgptKmhlzj+i/xeqAMwgyRwAqAv2TvPlCzBYAMqhLJT
	 6wBfpq+4Ic1yXbV44vv2QEO9ZNb7I0+jpWt9sM5FE4KB6wmmjBzBkinrObxSdmeTFw
	 5LvJYwosrRQTdtHTejzBNprKcIgGXLQ2GoYCyMJl5hykrtGGvnXzfZedyCwoEKoRBI
	 R8455drrYeNJw==
Date: Mon, 19 Aug 2024 18:33:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/5] net: xilinx: axienet: Fix dangling
 multicast addresses
Message-ID: <20240819183302.26b7a352@kernel.org>
In-Reply-To: <20240815193614.4120810-3-sean.anderson@linux.dev>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
	<20240815193614.4120810-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 15:36:11 -0400 Sean Anderson wrote:
> If a multicast address is removed but there are still some multicast
> addresses, that address would remain programmed into the frame filter.
> Fix this by explicitly setting the enable bit for each filter.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Reviewed-by: Simon Horman <horms@kernel.org>

Again, I'd go for net.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 0d5b300107e0..03fef656478e 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -170,6 +170,7 @@
>  #define XAE_UAW0_OFFSET		0x00000700 /* Unicast address word 0 */
>  #define XAE_UAW1_OFFSET		0x00000704 /* Unicast address word 1 */
>  #define XAE_FMI_OFFSET		0x00000708 /* Filter Mask Index */
> +#define XAE_FFE_OFFSET		0x0000070C /* Frame Filter Enable */
>  #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
>  #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */

There is a conflict with current net / net-next here, because of
9ff2f816e2aa65ca9, you'll need to rebase / repost (which is why 
I'm allowing myself the nit picks ;))

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index e664611c29cf..1bcabb016ca9 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -433,7 +433,7 @@ static int netdev_set_mac_address(struct net_device *ndev, void *p)
>   */
>  static void axienet_set_multicast_list(struct net_device *ndev)
>  {
> -	int i;
> +	int i = 0;

Consider renaming i to addr_cnt ? or addr_num ?

