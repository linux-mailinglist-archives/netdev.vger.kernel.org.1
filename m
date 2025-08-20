Return-Path: <netdev+bounces-215076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2259B2D0C4
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459DF7B221E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577C126C02;
	Wed, 20 Aug 2025 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbVI1ogZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498B5B21A;
	Wed, 20 Aug 2025 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650869; cv=none; b=a/TAS+WBu/ltMQptATySh4liiqbK2Wv7c6ZjTLMA6334R8BIyj7cTyA49ladPix6obv8RJMdEuCinOZVlQnZc1aJ5Eqb8AVrQaufHMG9Z6fQIY8d6JgK1yNfqBvgqgIHEAQuBfafJhfR0hcM1wRcGytQBbatbAEG+x526BLmhyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650869; c=relaxed/simple;
	bh=1+E+0RLIkF1BU08/kyPXFxLllod5BpcjqEX5oBS7jlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cs6yQHkdlYEX4jsMZA4lLK7vyghl6F7PIbKNiIEevfayrVReRAdMh0fHb01k2x5Kx2eKmgbTjFPXT8EHr7QtqiP8NFMlLPwL3kIgjUNMLFIepUYY507G2slVkacSr7Bl8P0QPUS1GHh0iYwCO5Re/zIEE3yqZEpyrNM140ZzSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbVI1ogZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF689C4CEF1;
	Wed, 20 Aug 2025 00:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755650869;
	bh=1+E+0RLIkF1BU08/kyPXFxLllod5BpcjqEX5oBS7jlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nbVI1ogZ918MUsyl4l+6xtswa/7wLikflSwqwTJxpKPKx/c5qgN2RT9pFJ6SZrsId
	 gzYd/jPYNwwoLCY3cbpy+4rEfcTBozkCgnsHLxm7Suq+sos2gHDKhsGWdZApNWD8nW
	 HzkdKJqFz6h0Dd0zuDjNl1jzYGpuIBsGh+39scokWkcoIF+rSDXo32NYdRHYZBilAy
	 uXq/A896YZRRTsj+ePdlknbZlbHmr5H26lvqxSKmlsafVQuFZdK3FlOV6Xm5Jq4D7t
	 DeAVH/0oGfK2mtoFWp19zd5/Gt9v3ypFkl7ZY2IqbxccmB2vqEKGMqEfdzIqSmc5UK
	 oKW5gXJ6ZoTjg==
Date: Tue, 19 Aug 2025 17:47:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: Manish Chopra <manishc@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ariel Elior
 <Ariel.Elior@cavium.com>, Michal Kalderon <Michal.Kalderon@cavium.com>,
 Manish Rangankar <manish.rangankar@cavium.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] qed: Don't write past the end of GRC debug buffer
Message-ID: <20250819174748.7d5869d3@kernel.org>
In-Reply-To: <2bac01100416be1edd9b44a963f872a4c25fda03.1755231426.git.jamie.bainbridge@gmail.com>
References: <2bac01100416be1edd9b44a963f872a4c25fda03.1755231426.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 14:17:25 +1000 Jamie Bainbridge wrote:
> In the GRC dump path, "len" count of dword-sized registers are read into
> the previously-allocated GRC dump buffer.

How did you find the issue? Did you happen to have a stack trace?
It'd be great to know the call trace cause the code is hard to make
sense of.

> However, the amount of data written into the GRC dump buffer is never
> checked against the length of the dump buffer. This can result in
> writing past the end of the dump buffer's kmalloc and a kernel panic.

I could be misreading but it sounds to me like you're trying to protect
against overflow on dump_buf, while the code is protecting against going
over the "feature" buf_size.

> Resolve this by clamping the amount of data written to the length of the
> dump buffer, avoiding the out-of-bounds memory access and panic.
> 
> Fixes: d52c89f120de8 ("qed*: Utilize FW 8.37.2.0")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_debug.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
> index 9c3d3dd2f84753100d3c639505677bd53e3ca543..2e88fd79a02e220fc05caa8c27bb7d41b4b37c0d 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
> @@ -2085,6 +2085,13 @@ static u32 qed_grc_dump_addr_range(struct qed_hwfn *p_hwfn,
>  		dev_data->pretend.split_id = split_id;
>  	}
>  
> +	/* Ensure we don't write past the end of the GRC buffer */
> +	u32 buf_size_bytes = p_hwfn->cdev->dbg_features[DBG_FEATURE_GRC].buf_size;
> +	u32 len_bytes = len * sizeof(u32);

Please don't mix code with variable declarations.

> +	if (len_bytes > buf_size_bytes)
> +		len = buf_size_bytes / sizeof(u32);

The way it's written it seems to be protecting from buffer being too
big for the feature. In which case you must take addr into account
and make sure dump_buf was zeroed.
-- 
pw-bot: cr

