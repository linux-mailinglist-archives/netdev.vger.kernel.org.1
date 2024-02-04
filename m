Return-Path: <netdev+bounces-68938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DE3848E60
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 15:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E024B21A1B
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E772231F;
	Sun,  4 Feb 2024 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHw07PGx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCD225A8
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056692; cv=none; b=FXB1+CxHWbpxiIqPGycAVLxloyT+U5Mm9kpSnDq3QjsLlpFqVaIjKCjQgOQajdLeem6355LDMi5L8Hhpefjzbq424go4KRFNJVH91kZ5zzX4P7a6Rq9Yj7YF5FkvIu9ZHYkzXgEZ81IBNRBa+L8hZAeB4UTQAXa0oX+Icgqu2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056692; c=relaxed/simple;
	bh=gCpB15Us/8TkBdNCL3SxQycgvy+3AfZ+DDRECsuq3fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amsPh3om6eDhvyT9hMig7QI902q63d9CIao8/w/QvhMqHOsVU/qQzWwI+xRPPx608b6z9Gws7STdbW1MKJ9EfZyqezLPc6ehoLom9eQcqRsZD156Bw6TouNMA/07eN5MpWui4dy22rMNSomax8k6pEgYRsxo6/cM5YB5sQBo8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHw07PGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08B4C433C7;
	Sun,  4 Feb 2024 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707056692;
	bh=gCpB15Us/8TkBdNCL3SxQycgvy+3AfZ+DDRECsuq3fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHw07PGx0b6rzcco83NcG0g8yYCBBrZAfVGo5INfoD4SpbiRfaIn8IkLatXaZguvv
	 1UAq57s1uh8XaWlQH6fBEJlNuNeGdCZ6hCBBYfdbl8o0DvRJwxs3KKYsiFbLgAfsJB
	 9id/0jmd9HEEkuestPF8wL1NSkAZ94KA2B994XYvFhXgjQ24ywnr/037RnEPAhuGaj
	 hnmIXhQm73d1Y+CFHfDs28XeaQcgMkwDAMOLCjTaTKrQ8kDuewM5KXLLLzAjX/5zJP
	 5HEIxUhIYqUsGuM06xIkyKLPu7e7HHz24ze0KKLqhEDJRxXORaRPJOInbGqlGjw0wT
	 9xj50wTfx9pMg==
Date: Sun, 4 Feb 2024 14:24:48 +0000
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Hamdan Igbaria <hamdani@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [net-next V3 13/15] net/mlx5: DR, Change SWS usage to debug fs
 seq_file interface
Message-ID: <20240204142448.GA941651@kernel.org>
References: <20240202190854.1308089-1-saeed@kernel.org>
 <20240202190854.1308089-14-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202190854.1308089-14-saeed@kernel.org>

On Fri, Feb 02, 2024 at 11:08:52AM -0800, Saeed Mahameed wrote:
> From: Hamdan Igbaria <hamdani@nvidia.com>
> 
> In current SWS debug dump mechanism we implement the seq_file interface,
> but we only implement the 'show' callback to dump the whole steering DB
> with a single call to this callback.
> 
> However, for large data size the seq_printf function will fail to
> allocate a buffer with the adequate capacity to hold such data.
> 
> This patch solves this problem by utilizing the seq_file interface
> mechanism in the following way:
>  - when the user triggers a dump procedure, we will allocate a list of
>    buffers that hold the whole data dump (in the start callback)
>  - using the start, next, show and stop callbacks of the seq_file
>    API we iterate through the list and dump the whole data
> 
> Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  .../mellanox/mlx5/core/steering/dr_dbg.c      | 735 ++++++++++++++----
>  .../mellanox/mlx5/core/steering/dr_dbg.h      |  20 +
>  2 files changed, 620 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c

...

> +static struct mlx5dr_dbg_dump_data *
> +mlx5dr_dbg_create_dump_data(void)
> +{
> +	struct mlx5dr_dbg_dump_data *dump_data;
> +
> +	dump_data = kzalloc(sizeof(*dump_data), GFP_KERNEL);
> +	if (!dump_data)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&dump_data->buff_list);
> +
> +	if (!mlx5dr_dbg_dump_data_init_new_buff(dump_data))
> +		kfree(dump_data);

Hi Hamdan and Saeed,

dump_data may be freed above.
But it is returned unconditionally below.
This seems a little odd.

Flagged by Smatch and Coccinelle.

> +
> +	return dump_data;
> +}

...

