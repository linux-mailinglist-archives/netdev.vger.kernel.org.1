Return-Path: <netdev+bounces-16570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9392674DD7B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F991C20B8F
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E014290;
	Mon, 10 Jul 2023 18:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8014A86
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3609CC433C7;
	Mon, 10 Jul 2023 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689014322;
	bh=fv0im7OOKhu0ZHpC2ngHTz9yoPg8xIv9FEQrluCM8SA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8JOQyM/6oOYwJYitkD5Q3rSTU1pZ6eUvfNap1vFj0x1Xd8xkx998HB4v9nwUN9wo
	 7wIlI+hlVsw1UbzZIiytE+XFyRF6YLq/X65c0q4oKI66MaE3skfKYLdR+uMM/baFjB
	 fYPpDFRVqmK3E5wbcJ1EWtCKbYjo0iVe9+TaS2Kx5oxAtkFpnl7kHuDCgxmZUSdULe
	 36ZAZeeDVQtO0Hr+lgeNDWY1H+Fd0JgN7r8kzRMABqStvNrfD4DJHSCvFtoD4QzLX3
	 NVR3jC8DFZ6G14vFHt7PWlw79IYBToRyeAjcUrbhFAX+snKh1b3pnJ0OWymjiq8FZc
	 rfCw+1GKsf2Qw==
Date: Mon, 10 Jul 2023 11:38:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Liang Chen <liangchen.linux@gmail.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230710113841.482cbeac@kernel.org>
In-Reply-To: <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
	<20230629120226.14854-2-linyunsheng@huawei.com>
	<20230707170157.12727e44@kernel.org>
	<3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Jul 2023 20:54:12 +0800 Yunsheng Lin wrote:
> > And the include is still here, too, eh.. =20
>=20
> In V4, it has:
>=20
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -33,6 +33,7 @@=20
>  #include <linux/mm.h> /* Needed by ptr_ring */
>  #include <linux/ptr_ring.h>
>  #include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>
>=20
> As dma_get_cache_alignment() defined in dma-mapping.h is used
> here, so we need to include dma-mapping.h.
>=20
> I though the agreement is that this patch only remove the
> "#include <linux/dma-direction.h>" as we dma-mapping.h has included
> dma-direction.h.
>=20
> And Alexander will work on excluding page_pool.h from skbuff.h
> https://lore.kernel.org/all/09842498-b3ba-320d-be8d-348b85e8d525@intel.co=
m/
>=20
> Did I miss something obvious here=EF=BC=9F Or there is better way to do it
> than the method discussed in the above thread?

We're adding a ton of static inline functions to what is a fairly core
header for networking, that's what re-triggered by complaint:

 include/net/page_pool.h                       | 179 ++++++++++++++----

Maybe we should revisit the idea of creating a new header file for
inline helpers... Olek, WDYT?

