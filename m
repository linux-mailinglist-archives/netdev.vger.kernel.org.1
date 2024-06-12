Return-Path: <netdev+bounces-102982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18CD905D44
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 22:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76103B23831
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7DE84FCC;
	Wed, 12 Jun 2024 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huobXJrg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418AD84E0A;
	Wed, 12 Jun 2024 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225738; cv=none; b=V/4poGo0e3WLly2QthMqXkelINCSaXGbKooe4A45L5S5088zA95u9bUcMicglqPd93K0QudvNsQRTt6ghjr2ISxyXfrNjEemuK6PqEArugyQMyx3UE8Y+j0KPJsO+gm6V3bLnSZvZ2QzHgOYT9m3WBW+vWo6o0inJgO0Y4jXH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225738; c=relaxed/simple;
	bh=v1P+P+YFwm6yIg5m6hXLMue0W7Ky6KUxstxWP05Zhqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLorlAWxSNaZ20cUrQk1JFMbZnZM6igo7M5+tfUV7884FFHxDMczEVkMYaEHTwglwAVUL0EEl/XcEN0Anx86nTWMC4+mwcyUhgA8hlVtQlsDCIDAlehgk5Z4aT62FX2pdgryQeww2aPpMX1RnyTvvzPmjUOGqQHbVT03X6Z12mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huobXJrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895BFC116B1;
	Wed, 12 Jun 2024 20:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718225737;
	bh=v1P+P+YFwm6yIg5m6hXLMue0W7Ky6KUxstxWP05Zhqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=huobXJrg2rfoU2egffD+9hL2uwCgqgJoBhTG4J9RkBp8PdS0klDO8N6Ap3uSb/Dqb
	 cW38+BySrYAv+wsgjf1dKGICUM5/EBTxOPaNZ7+ExnWeXuMkIVA8H6cJEk8k3omvTz
	 zMbGmdqchem6df/E8jwoxh3jKD4A5MYSIkISfw+/Opw9EydULEIM01v/wEjHhwvjBq
	 enZRb8H0h6XlbkDgWjZCsnKqMZ0EKewe25Ef/5rDPK6CihMDf8F4pr7vu8tRXwrbG3
	 t6MPLKd5hWWKdce1AfAVmuzcyVSXaN6EZTOLABA4B5kDwQYXG+iFSm4NGrChzVxy/0
	 nEChTUmDgMKtA==
Date: Wed, 12 Jun 2024 13:55:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Mina
 Almasry <almasrymina@google.com>,
 <nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-next 01/12] libeth: add cacheline / struct alignment
 helpers
Message-ID: <20240612135536.08c2eb34@kernel.org>
In-Reply-To: <8aa33911-5e34-4a03-90de-81f42648ab5d@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
	<20240528134846.148890-2-aleksander.lobakin@intel.com>
	<20240529183409.29a914c2@kernel.org>
	<8aa33911-5e34-4a03-90de-81f42648ab5d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 12:07:05 +0200 Przemek Kitszel wrote:
> Given that it will be a generic solution (would fix the [1] above),
> and be also easier to use, like:
> 
>   CACHELINE_STRUCT_GROUP(idpf_q_vector,
> 	CACHELINE_STRUCT_GROUP_RD(/* read mostly */
> 		struct idpf_vport *vport;
> 		u16 num_rxq;
> 		u16 num_txq;
> 		u16 num_bufq;
> 		u16 num_complq;
> 		struct idpf_rx_queue **rx;
> 		struct idpf_tx_queue **tx;
> 		struct idpf_buf_queue **bufq;
> 		struct idpf_compl_queue **complq;
> 		struct idpf_intr_reg intr_reg;
> 	),
> 	CACHELINE_STRUCT_GROUP_RW(
> 		struct napi_struct napi;
> 		u16 total_events;
> 		struct dim tx_dim;
> 		u16 tx_itr_value;
> 		bool tx_intr_mode;
> 		u32 tx_itr_idx;
> 		struct dim rx_dim;
> 		u16 rx_itr_value;
> 		bool rx_intr_mode;
> 		u32 rx_itr_idx;
> 	),
> 	CACHELINE_STRUCT_GROUP_COLD(
> 		u16 v_idx;
> 		cpumask_var_t affinity_mask;
> 	)
> );
> 
> Note that those three inner macros have distinct meaningful names not to
> have this working, but to aid human reader, then checkpatch/check-kdoc.
> Technically could be all the same CACHELINE_GROUP().
> 
> I'm not sure if (at most) 3 cacheline groups are fine for the general
> case, but it would be best to have just one variant of the
> CACHELINE_STRUCT_GROUP(), perhaps as a vararg.

I almost want to CC Linus on this because I think it's mostly about
personal preferences. I dislike the struct_group()-style macros. They
don't scale (imagine having to define two partially overlapping groups)
and don't look like C to my eyes. Kees really had to do this for his
memory safety work because we need to communicate a "real struct" type
to the compiler, but if you're just doing this so fail the build and
make the developer stop to think - it's not worth the ugliness.

Can we not extend __cacheline_group_begin() and __cacheline_group_end()
-style markings?

