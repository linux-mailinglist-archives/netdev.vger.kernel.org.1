Return-Path: <netdev+bounces-37813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203297B7437
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 95104281144
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5537D3E487;
	Tue,  3 Oct 2023 22:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43962224E8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 22:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261DFC433C7;
	Tue,  3 Oct 2023 22:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696373007;
	bh=P9+3h53DxqmjxSGM6n93lGmt0Puqp/z5dcxCLS1WDnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BV9UcaP+hpFCnN6I9ENoevhcCLjhYTmYkkTHvkZ7qT3q1yIOZ98ANL+SXHfo7mzRb
	 7zgNftxObRPKY49gRz7tKnuh4BIQm/4VubbU7y7z+0n1Fv41KiY7MdBRGrs5ad8Bl+
	 TQhg6JuSB9C37B/Zf4wnluiEOAm7u3R0H1Z0L9lE/rpnHkxB0jAcVl62S2NArkiZCr
	 5ygtHz4EYQty6Jqd9nQrYGM0bVAWzQOKo0IrvwnqcoCXsdCQFWxwChtCEnKQA31z7E
	 vX0gevM+gdjc2x33GbNGLauYLuvVAnWa9zoi5zkt63mT+2C3XBwkhDnkC3yGjAxxex
	 t1BN62AP7U3IA==
Date: Tue, 3 Oct 2023 15:43:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, "Lobakin, Alexandr"
 <alexandr.lobakin@intel.com>, Arnd Bergmann <arnd@arndb.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Alan Brady <alan.brady@intel.com>, "Sridhar
 Samudrala" <sridhar.samudrala@intel.com>, Willem de Bruijn
 <willemb@google.com>, Phani Burra <phani.r.burra@intel.com>, Joshua Hay
 <joshua.a.hay@intel.com>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Subject: Re: [PATCH] idpf: fix building without IPv4
Message-ID: <20231003154326.213e9c81@kernel.org>
In-Reply-To: <1430f3d3-4e84-b0ec-acd9-8a51db178f73@intel.com>
References: <20230925155858.651425-1-arnd@kernel.org>
	<1430f3d3-4e84-b0ec-acd9-8a51db178f73@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Sep 2023 10:05:03 -0700 Tony Nguyen wrote:
> Also, a pending patch for this [1], however, this does look a bit more 
> efficient. Adding Olek as he's author on the other patch.
> 
> netdev maintainers,
> 
> If this is the version that does get picked up, did you want to take it 
> directly to close out the compile issues?

Sorry for the delays. Should we not add a !INET static inline wrapper
for tcp_gro_complete()? Seems a bit backwards to me to make drivers
suffer and think about such a preposterous config :S

$ git grep tcp_gro_complete -- drivers/
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:        tcp_gro_complete(skb);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:              tcp_gro_complete(skb);
drivers/net/ethernet/intel/idpf/idpf_txrx.c:    tcp_gro_complete(skb);
drivers/net/ethernet/qlogic/qede/qede_fp.c:     tcp_gro_complete(skb);

We have 4 drivers which need ifdefs already and the number will only
grow with GRO-HW spreading.

