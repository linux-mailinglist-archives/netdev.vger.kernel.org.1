Return-Path: <netdev+bounces-88435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1039B8A72F5
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929F7B21E07
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0BE136987;
	Tue, 16 Apr 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci6chIBa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F41134CD0
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291560; cv=none; b=X8n9WgGoF+S0IJDGrK+FyBOpS9Vdy1d4RS/ZnluOYQHy07rkxMzTSrdmzNNvmiQX8hoBE0Sxwj1cIEDLYQuP1uJWgZR2w8boD9/n2x2r4c5utrq5PCb00fRP9Mxn49mUxan+Em746zpjRwU+UoFJ2VDDhEi4sxW5Ky7dvZIZngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291560; c=relaxed/simple;
	bh=ai2Bho8AFME/7JVEMMMJGJqVQGucXhYyV52GWU/hvus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDAuAePWi44k7hFSJieJOyZQyS8tugSAQR0DAvpGUmuRlzzYPaZ0jBWZ566nxFc0fcJ8zxo6YXI6NdtRuM5r6hUMKsuZSyyEk152OA/zRpKaYkGxO6MgvqyX7450+ZPM35T0O682ywU4BhXpSae3zMoQYePLyZHrVN8oamxc0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci6chIBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF56C113CE;
	Tue, 16 Apr 2024 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713291560;
	bh=ai2Bho8AFME/7JVEMMMJGJqVQGucXhYyV52GWU/hvus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ci6chIBaXF8i7aQ050QAWRLIbsNCMnreeexqK7wyeeKNYwlB4kI0n1YPOKD4WSeEk
	 +OCJzldmQKD6moSQ4OF7Wb4GOgxKZ3ga48btnGRI+OS1RdRZrLL3/1uyCqo+b81jb7
	 EAmf1DAWAUY7Ne75unCxZS/jM1yM/6Pva3OYieN6lWYvX94TfFMNLI2Xbb/hgx9tL8
	 vAGeqSwFLX07daAH6/IPBnf1DzerheQ5QSnXvX1cgxhkrXQcCtNTdlYzWZG4uHJTyW
	 tEcyrpJkxyk1RmvrOmTYDM08jmwn9XJs9lRhUl7OnvCFpLL4SL4r+ffeHSJ4ZDxYTU
	 292Zvn/xrGXLw==
Date: Tue, 16 Apr 2024 19:19:15 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 01/14] net_sched: sch_fq: implement lockless
 fq_dump()
Message-ID: <20240416181915.GT2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-2-edumazet@google.com>

On Mon, Apr 15, 2024 at 01:20:41PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, fq_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() in fq_change()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_fq.c | 96 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 60 insertions(+), 36 deletions(-)
> 
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index cdf23ff16f40bf244bb822e76016fde44e0c439b..934c220b3f4336dc2f70af74d7758218492b675d 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -888,7 +888,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
>  		fq_rehash(q, old_fq_root, q->fq_trees_log, array, log);
>  
>  	q->fq_root = array;
> -	q->fq_trees_log = log;
> +	WRITE_ONCE(q->fq_trees_log, log);
>  
>  	sch_tree_unlock(sch);
>  
> @@ -931,7 +931,7 @@ static void fq_prio2band_compress_crumb(const u8 *in, u8 *out)
>  
>  	memset(out, 0, num_elems / 4);
>  	for (i = 0; i < num_elems; i++)
> -		out[i / 4] |= in[i] << (2 * (i & 0x3));
> +		out[i / 4] |= READ_ONCE(in[i]) << (2 * (i & 0x3));
>  }
>  

Hi Eric,

I am a little unsure about the handling of q->prio2band in this patch.

It seems to me that fq_prio2band_compress_crumb() is used to
to store values in q->prio2band, and is called (indirectly)
from fq_change() (and directly from fq_init()).

While fq_prio2band_decompress_crumb() is used to read values
from q->prio2band, and is called from fq_dump().

So I am wondering if should use WRITE_ONCE() when storing elements
of out. And fq_prio2band_decompress_crumb should use READ_ONCE when
reading elements of in.

