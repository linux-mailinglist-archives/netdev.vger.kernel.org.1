Return-Path: <netdev+bounces-15469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E2747C86
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 07:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050671C20920
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 05:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5E2EA5;
	Wed,  5 Jul 2023 05:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71DED2
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 05:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036C5C433C8;
	Wed,  5 Jul 2023 05:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688535570;
	bh=nFQs5cTYuPOJh3r7igwUDZnsJ+CtGitDkjQDXqqvwWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMQpu1Olo+hPa/ure2yfSzB6W+lU51hs8oLP5LZYOXbwUOQf4YU3waL3ciPI344MA
	 6JnUqRNtDzwGQvC+GarMjeEXxWKbLswFmpmVe9HTn0oYqh8C71ePOQZGsttfX39J5c
	 r9e0TVIwa/UdKVEaLWVXCxykRSVpbDvprtXHd58iCKV265H4FxjKPgG9AVvUu0gBlB
	 7glXl9QwT5WDE3lwvGnS1ZMDBgHkOuqpcreFDcuL6ZjyNlCQBVbndehQSgKqMBFg1D
	 dEIMEFfg1/t4QtwPzleqnxyx90Bx1YQX+f0HXvHpxLLLZuQM65eSw74QWZarcIroBg
	 /oQY4veRy8m6g==
Date: Wed, 5 Jul 2023 08:39:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	borisp@nvidia.com, saeedm@nvidia.com, raeds@nvidia.com,
	ehakim@nvidia.com, liorna@nvidia.com, nathan@kernel.org,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net] net/mlx5e: fix double free in
 macsec_fs_tx_create_crypto_table_groups
Message-ID: <20230705053926.GF6455@unreal>
References: <20230704070640.368652-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704070640.368652-1-shaozhengchao@huawei.com>

On Tue, Jul 04, 2023 at 03:06:40PM +0800, Zhengchao Shao wrote:
> In function macsec_fs_tx_create_crypto_table_groups(), when the ft->g
> memory is successfully allocated but the 'in' memory fails to be
> allocated, the memory pointed to by ft->g is released once. And in function
> macsec_fs_tx_create(), macsec_fs_tx_destroy() is called to release the
> memory pointed to by ft->g again. This will cause double free problem.

This is perfect example, why it is anti-pattern to have one global
destroy function like macsec_fs_tx_destroy(), which hides multiple
class of errors: wrong release order, double free e.t.c

> 
> Fixes: e467b283ffd5 ("net/mlx5e: Add MACsec TX steering rules")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

