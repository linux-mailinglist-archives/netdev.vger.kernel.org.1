Return-Path: <netdev+bounces-37725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC17B6CF8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5E70228132C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E434CF0;
	Tue,  3 Oct 2023 15:22:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A375DDC7
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA801C433C7;
	Tue,  3 Oct 2023 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696346546;
	bh=GATpp7gLk+9vH4S+ZsqxKEXorMVjpzl17S6e9IMF6Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pF3Rw9+BWoA4AVvAYwySQBDtgOoPjaC3ODX2YvtSeXexKph9UTnOh67F/rOXiNKcu
	 Rr8O8rOryG+loxf9SkMsrQn9UZd6kcOjzxNt+JhL4NMJpZbMbzcH/SOuyObrYEtbfP
	 hhfhk2m/dVqjAqUpGBGndaFQQrFDO9q/2gEQmKga67JXPYRjartMQ3GW8a5DcF+9Ga
	 J1fwawlMj+ePJPr8lw4fb0uOVnJ0c4zE2NmDrspjjz3nHUr01PivBztSIZBBcXwkc3
	 kOWtyJHG7cnFS40UvaGEUJ9NUbraApDPg7ipkcl/5eYdLpKKsEn2ebTq2JcOdZJVpt
	 SdRiS2dqR01ig==
Date: Tue, 3 Oct 2023 17:22:22 +0200
From: Simon Horman <horms@kernel.org>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: qca8k: fix regmap bulk read/write
 methods on big endian systems
Message-ID: <ZRwxrixyhOT29C47@kernel.org>
References: <20231002104612.21898-1-kabel@kernel.org>
 <20231002104612.21898-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002104612.21898-2-kabel@kernel.org>

On Mon, Oct 02, 2023 at 12:46:11PM +0200, Marek Behún wrote:
> Commit c766e077d927 ("net: dsa: qca8k: convert to regmap read/write
> API") introduced bulk read/write methods to qca8k's regmap.
> 
> The regmap bulk read/write methods get the register address in a buffer
> passed as a void pointer parameter (the same buffer contains also the
> read/written values). The register address occupies only as many bytes
> as it requires at the beginning of this buffer. For example if the
> .reg_bits member in regmap_config is 16 (as is the case for this
> driver), the register address occupies only the first 2 bytes in this
> buffer, so it can be cast to u16.
> 
> But the original commit implementing these bulk read/write methods cast
> the buffer to u32:
>   u32 reg = *(u32 *)reg_buf & U16_MAX;
> taking the first 4 bytes. This works on little endian systems where the
> first 2 bytes of the buffer correnspond to the low 16-bits, but it

nit: correspond

> obviously cannot work on big endian systems.
> 
> Fix this by casting the beginning of the buffer to u16 as
>    u32 reg = *(u16 *)reg_buf;
> 
> Fixes: c766e077d927 ("net: dsa: qca8k: convert to regmap read/write API")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index de1dc22cf683..d2df30640269 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -505,8 +505,8 @@ qca8k_bulk_read(void *ctx, const void *reg_buf, size_t reg_len,
>  		void *val_buf, size_t val_len)
>  {
>  	int i, count = val_len / sizeof(u32), ret;
> -	u32 reg = *(u32 *)reg_buf & U16_MAX;
>  	struct qca8k_priv *priv = ctx;
> +	u32 reg = *(u16 *)reg_buf;
>  
>  	if (priv->mgmt_master &&
>  	    !qca8k_read_eth(priv, reg, val_buf, val_len))
> @@ -527,8 +527,8 @@ qca8k_bulk_gather_write(void *ctx, const void *reg_buf, size_t reg_len,
>  			const void *val_buf, size_t val_len)
>  {
>  	int i, count = val_len / sizeof(u32), ret;
> -	u32 reg = *(u32 *)reg_buf & U16_MAX;
>  	struct qca8k_priv *priv = ctx;
> +	u32 reg = *(u16 *)reg_buf;
>  	u32 *val = (u32 *)val_buf;
>  
>  	if (priv->mgmt_master &&
> -- 
> 2.41.0
> 
> 

