Return-Path: <netdev+bounces-40649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CD57C826E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1102828B4
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD711192;
	Fri, 13 Oct 2023 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQm5urXr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C36B101DD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349E8C433C8;
	Fri, 13 Oct 2023 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697190437;
	bh=ZTHQLEd5HGEI+DeXZK06FUuQEPMMgcSoIzW7I4de2ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQm5urXr4O/MK2MIIdd0AQPylnoufT7i4+RbK2RJ2JB0yfvBc2r2Lx2q2vE5f1Rnf
	 aA13q7sDTyho4sTrD86k4BGfofG20oN0da8H3CFEZE42yxYHQPioN2+yWs/1gRjCsf
	 u1E3F37v7vrdwLKIpUzp+nAbvHwaGpE+xb94ZdV7kSDF7AUvxNejNj6cnSktu2NdAf
	 EUnnMiC1JDtlFlR/lTMSrfZl3oa25MDwIAYF7RV4fr7LUlqNeIUmniZ/qAFIT7rcFA
	 /R3TwgUnaH+Sp2KaAid4FSS/s3IRvQCWPaYioAhsrH2dbqxuz9X75I7rohd3HvUuQ4
	 FoAbvDQ/VPHyg==
Date: Fri, 13 Oct 2023 11:47:12 +0200
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 00/14] net: tls: various code cleanups and
 improvements
Message-ID: <20231013094712.GB29570@kernel.org>
References: <cover.1696596130.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696596130.git.sd@queasysnail.net>

+ "David S. Miller" <davem@davemloft.net>
  Paolo Abeni <pabeni@redhat.com>
  Eric Dumazet <edumazet@google.com>

On Mon, Oct 09, 2023 at 10:50:40PM +0200, Sabrina Dubroca wrote:
> This series contains multiple cleanups and simplifications for the
> config code of both TLS_SW and TLS_HW.
> 
> It also modifies the chcr_ktls driver to use driver_state like all
> other drivers, so that we can then make driver_state fixed size
> instead of a flex array always allocated to that same fixed size. As
> reported by Gustavo A. R. Silva, the way chcr_ktls misuses
> driver_state irritates GCC [1].
> 
> Patches 1 and 2 are follow-ups to my previous cipher_desc series.
> 
> [1] https://lore.kernel.org/netdev/ZRvzdlvlbX4+eIln@work/
> 
> Sabrina Dubroca (14):
>   tls: get salt using crypto_info_salt in tls_enc_skb
>   tls: drop unnecessary cipher_type checks in tls offload
>   tls: store rec_seq directly within cipher_context
>   tls: rename MAX_IV_SIZE to TLS_MAX_IV_SIZE
>   tls: store iv directly within cipher_context
>   tls: extract context alloc/initialization out of tls_set_sw_offload
>   tls: move tls_prot_info initialization out of tls_set_sw_offload
>   tls: also use init_prot_info in tls_set_device_offload
>   tls: add a helper to allocate/initialize offload_ctx_tx
>   tls: remove tls_context argument from tls_set_sw_offload
>   tls: remove tls_context argument from tls_set_device_offload
>   tls: validate crypto_info in a separate helper
>   chcr_ktls: use tls_offload_context_tx and driver_state like other
>     drivers
>   tls: use fixed size for tls_offload_context_{tx,rx}.driver_state
> 
>  .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  43 ++--
>  .../chelsio/inline_crypto/ch_ktls/chcr_ktls.h |  36 +++-
>  include/net/tls.h                             |  21 +-
>  net/tls/tls.h                                 |  12 +-
>  net/tls/tls_device.c                          | 101 ++++-----
>  net/tls/tls_device_fallback.c                 |  23 +-
>  net/tls/tls_main.c                            |  62 +++---
>  net/tls/tls_sw.c                              | 198 +++++++++---------
>  8 files changed, 244 insertions(+), 252 deletions(-)

Thanks Sabrina,

this was a nice set of cleanups to read.

Reviewed-by: Simon Horman <horms@kernel.org>


