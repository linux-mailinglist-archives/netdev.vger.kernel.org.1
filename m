Return-Path: <netdev+bounces-93401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE18BB885
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 01:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D0F1F24465
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 23:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E084DF1;
	Fri,  3 May 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WqEWKVn3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804AB59167
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714780425; cv=none; b=ml/YYuVwdsZpyTReteg2n1kh+LSBSf99RU/LmFRshgopxenjc5rHTDWHNNAuNLMJ/f2F+PJhr5wVR5c2XoqMifKvmBvQ+EVHNhxXxscT695DbgW2XL5MtNZWIA2f2sKdQrSqowwlmwyOUmsjfNq/GYoGY2d9D0T6tvMNmL3PPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714780425; c=relaxed/simple;
	bh=xhq22uzQmypOoVpCkNFBLHGOvrAtFOUR8wHYL+PkZa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS3gmuGMGeiGAJvvi+xoqeagJi9PGPocEBTgpUtT/wyR4IRlbec5pmIHnunDkgseMF4xxjxsR/24BZQ/P2ND4SXyYaCs2JOEBKEDUJG9tT+3cnWna9HsZuCoZJsQDnecPs9/AYPxeLM+pbKnL/2jbQrgXqvGNJhws7EWg79jT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WqEWKVn3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so156055a12.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714780424; x=1715385224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5avDtjhLdQj9IgYkItzDxuI0WthI0sSdax4HN8vbOzQ=;
        b=WqEWKVn3W+NdCaa/KQbuSm0SpLbqAEwi3Ny5Lw+Vv/KPxNlz/dEFifveE+gVytI7i0
         URRpdHFX1XyuxYGbbr7Ne3wjZCiG77EEuF1kbUvqGyNwef3Fz401LKepq1AqG+m4Dmys
         LhE4gXaKxQ8bdlVSlHqwcLktjIyZhIDsH9VP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714780424; x=1715385224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5avDtjhLdQj9IgYkItzDxuI0WthI0sSdax4HN8vbOzQ=;
        b=W6jlpqPcMJd9154wJfRKpAYYgLrUks6SlkNhhkr5ehvgy51FRhBg5GBj93fhUEMr1h
         lNHZZcu5VqlLco6MVp1ourJFHbfUNkpKN73g6H3g1ddlk/JOL12bQp+fTe284M3vdowz
         dcFvqNA4r5YRAoTYiJnjBgTwtwi1HV3mM4JM4+RqITCiiG9rFcpL2zbo9C9m8TKx61kT
         tY+Kb2jJ5f//C+SGAgi7nxBEVI1+6+qHW5hVFbbObbvHjQCROQexd8XESFwVdTNl5yKL
         /AQrGQN70uhlLevMm0BDVznpx8IUEdkJgt0yYtd2xO+3CFSlyUsfQs5nBBbcPcDr9gCA
         odzg==
X-Forwarded-Encrypted: i=1; AJvYcCXUjPvgZPL2Xd1pSYEzACejRSIvjT/7XrVm1jGUjL/5y/spPwQpdDIkbYJFgaX+xdhyAefb2bLwNL0H1HORviAKO8umZ12d
X-Gm-Message-State: AOJu0YyBstNEJIrrPcqYjtozigYrZ0wj+vJ2WAqQT0z/7cv8tHC7eTQO
	UTkjHSSzcWDOmjYfB904iLAAVo6DzOfzkEBHldGJ54C8BIqEXaN75LRBoNgMNlw=
X-Google-Smtp-Source: AGHT+IFs7xIHfqq9Lj6Fqlq3My9vl2wwYg+s9bmVBnuUhEqmAlP9X3ekQ4lmIBlGbrA0NaWexsKkag==
X-Received: by 2002:a17:903:41cc:b0:1eb:49cb:bf70 with SMTP id u12-20020a17090341cc00b001eb49cbbf70mr5271667ple.62.1714780423773;
        Fri, 03 May 2024 16:53:43 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ed6868e257sm765764plf.123.2024.05.03.16.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:53:43 -0700 (PDT)
Date: Fri, 3 May 2024 16:53:40 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com,
	gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
 <ZjUwT_1SA9tF952c@LQ3V64L9R2>
 <20240503145808.4872fbb2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503145808.4872fbb2@kernel.org>

On Fri, May 03, 2024 at 02:58:08PM -0700, Jakub Kicinski wrote:
> On Fri, 3 May 2024 11:43:27 -0700 Joe Damato wrote:
> > 1. it includes the PTP stats that I don't include in my qstats, and/or
> > 2. some other reason I don't understand
> 
> Can you add the PTP stats to the "base" values? 
> I.e. inside mlx5e_get_base_stats()?

I tried adding them to rx and tx and mlx5e_get_base_stats (similar to what
mlx5e_fold_sw_stats64 does) and the test still fails.

Maybe something about the rtnl stats are what's off here and the queue
stats are fine?

FWIW: I spoke with the Mellanox folks off list several weeks ago and they
seemed to suggest skipping the PTP stats made the most sense.

I think at that time I didn't really understand get_base_stats that well,
so maybe we'd have come to a different conclusion then.

FWIW, here's what I tried and the rtnl vs qstat test still failed in
exactly the same way:

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5337,10 +5337,25 @@ static void mlx5e_get_base_stats(struct net_device *dev,
                rx->packets = 0;
                rx->bytes = 0;
                rx->alloc_fail = 0;
+               if (priv->rx_ptp_opened) {
+                       struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
+                       rx->packets = rq_stats->packets;
+                       rx->bytes = rq_stats->bytes;
+               }
        }

        tx->packets = 0;
        tx->bytes = 0;
+
+       if (priv->tx_ptp_opened) {
+               int i;
+               for (i = 0; i < priv->max_opened_tc; i++) {
+                       struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[i];
+
+                       tx->packets    += sq_stats->packets;
+                       tx->bytes      += sq_stats->bytes;
+               }
+       }
 }

> We should probably touch up the kdoc a little bit, but it sounds like
> the sort of thing which would fall into the realm of "misc delta"
> values:
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index c7ac4539eafc..f5d9f3ad5b66 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -59,6 +59,8 @@ struct netdev_queue_stats_tx {
>   * statistics will not generally add up to the total number of events for
>   * the device. The @get_base_stats callback allows filling in the delta
>   * between events for currently live queues and overall device history.
> + * @get_base_stats can also be used to report any miscellaneous packets
> + * transferred outside of the main set of queues used by the networking stack.
>   * When the statistics for the entire device are queried, first @get_base_stats
>   * is issued to collect the delta, and then a series of per-queue callbacks.
>   * Only statistics which are set in @get_base_stats will be reported
> 
> 
> SG?

I think that sounds good and makes sense, yea. By that definition, then I
should leave the PTP stats as shown above. If you agree, I'll add that
to the v2.

I feel like I should probably wait before sending a v2 with PTP included in
get_base_stats to see if the Mellanox folks have any hints about why rtnl
!= queue stats on mlx5?

What do you think?

