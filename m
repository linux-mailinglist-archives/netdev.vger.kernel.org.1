Return-Path: <netdev+bounces-43161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5547D19D7
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD2A2821C5
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A160319E;
	Sat, 21 Oct 2023 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3VDZ9xA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86506362
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1153C433C7;
	Sat, 21 Oct 2023 00:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697847289;
	bh=YXTE5L5fA4DtjK48ZI1Bd1g/kD6GO0hNTijaQNAvbwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G3VDZ9xAyQyAzk1+v9Km+i9kw3archkLvDkf/HwNfryZy7lBwNSoPFI7SkPcP0i00
	 YJDIYw+uWS0dK22b9GUkNxi/FgsDT26B84qhj28BoGre2vZHYTUh0qb0no4rP2fFUo
	 s3l55hMr9KROyjF6jGl5osb1lIasfVlBIjqsOxRgymbbm8hsKd1jqhUX9uttr0haf4
	 oGP8SI2WPaXZMErjrWttDE2ilMeBblmTPpcUOqsHUHMoyMNodpShqzsIbdt7/6e081
	 eGfO4XngbgyX7H3p2TU2PCp1VFAjtPYW2jqkNYwhYZx0cDIGmkmgFq5bB94yAAgqgW
	 dIV7xIc/9wvew==
Date: Fri, 20 Oct 2023 17:14:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Boris
 Pismenny <borisp@nvidia.com>, Eric Dumazet <edumazet@google.com>, John
 Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <ttoukan.linux@gmail.com>
Subject: Re: [PATCH net-next] tls: don't reset prot->aad_size and
 prot->tail_size for TLS_HW
Message-ID: <20231020171448.484dcf2a@kernel.org>
In-Reply-To: <979d2f89a6a994d5bb49cae49a80be54150d094d.1697653889.git.sd@queasysnail.net>
References: <979d2f89a6a994d5bb49cae49a80be54150d094d.1697653889.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 16:00:55 +0200 Sabrina Dubroca wrote:
> Prior to commit 1a074f7618e8 ("tls: also use init_prot_info in
> tls_set_device_offload"), setting TLS_HW on TX didn't touch
> prot->aad_size and prot->tail_size. They are set to 0 during context
> allocation (tls_prot_info is embedded in tls_context, kzalloc'd by
> tls_ctx_create).
> 
> When the RX key is configured, tls_set_sw_offload is called (for both
> TLS_SW and TLS_HW). If the TX key is configured in TLS_HW mode after
> the RX key has been installed, init_prot_info will now overwrite the
> correct values of aad_size and tail_size, breaking SW decryption and
> causing -EBADMSG errors to be returned to userspace.
> 
> Since TLS_HW doesn't use aad_size and tail_size at all (for TLS1.2,
> tail_size is always 0, and aad_size is equal to TLS_HEADER_SIZE +
> rec_seq_size), we can simply drop this hunk.
> 
> Fixes: 1a074f7618e8 ("tls: also use init_prot_info in tls_set_device_offload")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
> Tariq, does that solve the problem you reported in
> https://lore.kernel.org/netdev/3ace1e75-c0a5-4473-848d-91f9ac0a8f9c@gmail.com/
> ?

In case Tariq replies before Monday and DaveM wants to take it, LGTM:

Acked-by: Jakub Kicinski <kuba@kernel.org>

