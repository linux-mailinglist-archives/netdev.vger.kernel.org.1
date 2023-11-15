Return-Path: <netdev+bounces-48115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A237D7EC954
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB06280E1D
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3493BB4F;
	Wed, 15 Nov 2023 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2HmI5/J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1BA2E64F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 17:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA66C433C8;
	Wed, 15 Nov 2023 17:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700068002;
	bh=Tlfp2N2A2Hj49oZ8goM0ixR1B8LdhTFDoiNDx/3SHSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2HmI5/JXx9FJ7u1uteyztnrAQVC+Qt3F3smUFmZ8/j1N+ODQoBMkZ99alJhmXFvD
	 QSfGzEWEN9i4WEECeDFvEYprZwQduuGsFyawEMOFzhFtnnDHqw1SkAQd/Uu+9+5Ymf
	 tJ97fsvqAh1eA8AexgC+b8aJbZE2calIT0jVuK3YGmP/oQTEybJqkWAccEGXGJyCMg
	 dAbQMZzI1lYwswn1toi7Zb+/QL5xJDEIoqqc7HDsFQtxP/XpfoH3hfFmJVwX2+wVbH
	 m67p0qiYuWOqn9TRhA6FCye8gn2YRvGUeo5F8KawC9FosgNvO4i/gRxIw5Nni3TBfL
	 DfIyBZ0YQvBnA==
Date: Wed, 15 Nov 2023 17:06:37 +0000
From: Simon Horman <horms@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] s390/ism: ism driver implies smc protocol
Message-ID: <20231115170637.GR74656@kernel.org>
References: <20231115102304.GN74656@kernel.org>
 <20231115155958.3249645-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115155958.3249645-1-gbayer@linux.ibm.com>

On Wed, Nov 15, 2023 at 04:59:58PM +0100, Gerd Bayer wrote:
> Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> you can build the ism code without selecting the SMC network protocol.
> That leaves some ism functions be reported as unused. Move these
> functions under the conditional compile with CONFIG_SMC.
> 
> Also codify the suggestion to also configure the SMC protocol in ism's
> Kconfig - but with an "imply" rather than a "select" as SMC depends on
> other config options and allow for a deliberate decision not to build
> SMC. Also, mention that in ISM's help.
> 
> Fixes: a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/netdev/afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org/
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>  drivers/s390/net/Kconfig   |  3 +-
>  drivers/s390/net/ism_drv.c | 93 +++++++++++++++++++-------------------
>  2 files changed, 48 insertions(+), 48 deletions(-)
> 
> Hi Simon,
> 
> this is version 2, that removes the unused forward declaration that you
> found in v1 per:
> https://lore.kernel.org/netdev/20231115102304.GN74656@kernel.org/#t
> Other than that the patch is unchanged.

Thanks Gerd,

this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

