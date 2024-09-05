Return-Path: <netdev+bounces-125415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E36A96D0BD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141C3286A0B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472AF193418;
	Thu,  5 Sep 2024 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3Ztp2qj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23283193411
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522574; cv=none; b=mtPQ8vm1lwuvl6szaummTCuoG7TcXPE1FDc1UC67Q3moprhw3yNio4O32HdABh3fMx6dzQzcTA9fYa+Idt5xxAateFP6lIJLlhDmWGUSi8DWW5UuDLBzVtV4IaqLxGJ6YV6qY+G+cFTBLw29h2JgYMcWJsGp2F0PpkZyqu0ngBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522574; c=relaxed/simple;
	bh=xwiuni+n1BJVom1NONH702zH8eQ4TSzhXg9N833wVT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpSAeTPkb+tYcJczqAYirlyTNwNQLNXMRYyt3ieoVV1AZc0EFNnxVvz6GpBuGwq4tpaQ61f6+TFLZ9BYmPnREfsMorF0q4JQuGgyTl+3EELpnmjQVO5aJitvhPKlgBVbC3c9fDnDaG8O8tnWKIwIrC7zTTBEtUVbV3S8rFehL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3Ztp2qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34358C4CEC3;
	Thu,  5 Sep 2024 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725522573;
	bh=xwiuni+n1BJVom1NONH702zH8eQ4TSzhXg9N833wVT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3Ztp2qjrolfB52nMCUULSOjJrwRcEr3KpxMKbz9mT4vWL07MHeb6jIFVncb4QTw8
	 BS4O4Q82fA0q80JIL6CX5PKlxcFqh3JdtUB45Teh84T2jLVRvKYa/Ecao4JYhY2MsZ
	 dFrCGgi9QAV3iscN+xprwQWz/JmD0LQE2UMTEx7/IcF+k4Q2oKAHm6DE8RxPk+tSbT
	 BV6PJkrlDazA5ll8b4Q70rbfY7KMj4gJGkmdj46UAQ7ObLRsaKawPyzRLFyUvmHVS1
	 V9BOhTsY3bceXXOBUvn+ZhmCRuPCCQ/mL1UD1F2l4ghP6CIs4R6nd+QvSPoC/gmzJ9
	 PUTakVeoxMdTQ==
Date: Thu, 5 Sep 2024 10:49:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240905074928.GR4026@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <CADsK2K9_MVnMp+_SQmjweUoX1Hpnyquc1nW+qh2DDVUqPpEw8w@mail.gmail.com>
 <20240903190418.GK4026@unreal>
 <CADsK2K-vMvX0UzWboPMstCoZuzGsFf2Y3mYpm4nNU4GAXDum3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADsK2K-vMvX0UzWboPMstCoZuzGsFf2Y3mYpm4nNU4GAXDum3Q@mail.gmail.com>

On Wed, Sep 04, 2024 at 10:41:38AM -0700, Feng Wang wrote:
> Hi Leon,
> 
> I'm looking at the MLX5 driver to understand how the SA information is
> used. In mlx5e_ipsec_handle_tx_skb(), it appears we might leverage the
> current MLX5 implementation to verify the xfrm id.
> https://elixir.bootlin.com/linux/v6.10/source/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c#L271
> 
> During the mlx5e_xfrm_add_state() function, the xfrm ID (x->if_id) is
> passed to the driver along with the associated xfrm_state pointer.
> Therefore, by checking the if_id within the skb tx function like
> mlx5e_ipsec_handle_tx_skb(), we should be able to demonstrate the use
> case effectively.
> 
> What’s your opinion?

Packet offloaded packets don't pass mlx5e_ipsec_handle_tx_skb() because SKB is
treated as plain text and not encrypted.

In order to support this feature in mlx5, you will need to do two things:
1. Create rule which matches x->if_id in mlx5 flow steering, while
creating SAs (see tx_add_rule()->setup_fte_reg_a()).

This register is used in the transmit steering tables, and is loaded with
the value of flow_table_metadata field in the Ethernet Segment of the WQE.

2. Set x->if_id from SKB in flow_table_metadata to allow HW to catch
these packets. It means change mlx5e datapath to set this value from
SKB.

The first item is easy, just move setup_fte_reg_a() to the right place,
but the second one is more complex as whole packet offload assumption
that we are working with plain text packets.

I'm not even talking about eswitch mode, which will bring more
complexity.

Thanks

> 
> Thanks for your help.
> 
> Feng

