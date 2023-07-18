Return-Path: <netdev+bounces-18753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98DB758898
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BBC1C20EB8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1C017724;
	Tue, 18 Jul 2023 22:38:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF64168BE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 22:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73162C433C7;
	Tue, 18 Jul 2023 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689719896;
	bh=RXO+gAcZm+MhRenqy65hhkLUzlwKRVhTNDHhFXVPjjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WC8frNZQi3mlQRwzd/1B/o58REsGjVM4bTqKYDGfIE0sdXtSivhP2CyO9GHwyZmUh
	 /fSMjJcqo48S1vnfEmmBEuLJHAJPEWExHLr/fGVg72zBItMXT5mcrGyyeTxbsSA84F
	 6LENyGcMmgizG0XyhLIpTWGmW5LNVmvAW2H++ihnyl/GFL1ab+KbX6AQgQGzKV14bB
	 C7ttE95UTAd7KsoYwEkaDtSAZr6mZGfIVkXp1QrwAzNbs+XmOJRAl2Qpf1itgUpGdz
	 7Xh0infj6g0F2qtc/JkRPt1YQH30JhSn8B77F32PIysiR197GoqrB8XClTi6/Qu1MM
	 4FL5RdcE/3Bqg==
Date: Tue, 18 Jul 2023 15:38:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>, Haren Myneni <haren@us.ibm.com>,
	Nick Terrell <terrelln@fb.com>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Richard Weinberger <richard@nod.at>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 05/21] ubifs: Pass worst-case buffer size to
 compression routines
Message-ID: <20230718223813.GC1005@sol.localdomain>
References: <20230718125847.3869700-1-ardb@kernel.org>
 <20230718125847.3869700-6-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718125847.3869700-6-ardb@kernel.org>

On Tue, Jul 18, 2023 at 02:58:31PM +0200, Ard Biesheuvel wrote:
> Currently, the ubifs code allocates a worst case buffer size to
> recompress a data node, but does not pass the size of that buffer to the
> compression code. This means that the compression code will never use
> the additional space, and might fail spuriously due to lack of space.
> 
> So let's multiply out_len by WORST_COMPR_FACTOR after allocating the
> buffer. Doing so is guaranteed not to overflow, given that the preceding
> kmalloc_array() call would have failed otherwise.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  fs/ubifs/journal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index dc52ac0f4a345f30..4e5961878f336033 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1493,6 +1493,8 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
>  	if (!buf)
>  		return -ENOMEM;
>  
> +	out_len *= WORST_COMPR_FACTOR;
> +
>  	dlen = le32_to_cpu(dn->ch.len) - UBIFS_DATA_NODE_SZ;
>  	data_size = dn_size - UBIFS_DATA_NODE_SZ;
>  	compr_type = le16_to_cpu(dn->compr_type);

This looks like another case where data that would be expanded by compression
should just be stored uncompressed instead.

In fact, it seems that UBIFS does that already.  ubifs_compress() has this:

        /*
         * If the data compressed only slightly, it is better to leave it
         * uncompressed to improve read speed.
         */
        if (in_len - *out_len < UBIFS_MIN_COMPRESS_DIFF)
                goto no_compr;

So it's unclear why the WORST_COMPR_FACTOR thing is needed at all.

- Eric

