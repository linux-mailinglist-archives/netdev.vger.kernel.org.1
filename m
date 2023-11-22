Return-Path: <netdev+bounces-50161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD577F4BED
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938CF281221
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A257898;
	Wed, 22 Nov 2023 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5wdngCE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB814F69
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 16:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2E9C433C9;
	Wed, 22 Nov 2023 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700669174;
	bh=9I/Ut9u71+PZSt3BD8ueSHmdBqUbxN6PnGIDLfS3NH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5wdngCEsgj5fiBVq2+pZcHTCwEfzcRx5JUeKibug+ihVL1HRdqvpe1qBKarJgijC
	 w7CbUfywuMffM4xK+uOKTO9pJjKH/hsNUa2EakccjBNquavLBruUA0D5slk4XWP/xW
	 Q+sJ5z/wQ+9+IcndJi1lPu4VK2s4qVWwJ1ZWC0SUG1dj43qAhw6FJWx7komMl+4+Qv
	 6OBuJnDGorp6TC9aukAUfTs1KRfQql4yTt75/0C5D47ofFrUyFN5VmDfWGBKRFsC0c
	 TFs4Trk6yW1zCI6VOLkqp71aBYSesfAkVXW4IVCqt24Tyr4iCIEovxDrmBRIEp2/JZ
	 m018d+QJqjXYQ==
Date: Wed, 22 Nov 2023 08:06:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Subject: Re: [PATCH net-next v3 09/13] net: page_pool: report amount of
 memory held by page pools
Message-ID: <20231122080613.5a168d74@kernel.org>
In-Reply-To: <ee5c3780-2b0e-4db2-97d0-48659686c772@kernel.org>
References: <20231122034420.1158898-1-kuba@kernel.org>
	<20231122034420.1158898-10-kuba@kernel.org>
	<ee5c3780-2b0e-4db2-97d0-48659686c772@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 16:24:55 +0100 Jesper Dangaard Brouer wrote:
> > +      -
> > +        name: inflight
> > +        type: uint
> > +        doc: |
> > +          Number of outstanding references to this page pool (allocated
> > +          but yet to be freed pages).  
> 
> Maybe it is worth explaining in this doc that these inflight references
> also cover elements in (ptr) ring (and alloc-cache) ?
> 
> In a follow up patchset, we likely also want to expose the PP ring size.
> As that could be relevant when assessing inflight number.

Good point, how about:

          Number of outstanding references to this page pool (allocated
          but yet to be freed pages). Allocated pages may be held in
          socket receive queues, driver receive rings, page pool recycling
          ring, the page pool cache, etc.

