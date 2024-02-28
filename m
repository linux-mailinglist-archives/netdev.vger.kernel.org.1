Return-Path: <netdev+bounces-75555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A4286A765
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3294D1C214DD
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732B20322;
	Wed, 28 Feb 2024 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCd9DSKu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC31CFB9
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092567; cv=none; b=vAJaMCmXx2KFHgcXK70K0UE6qc/OmZEOqGCFMB2GNU+rVR5a81qPk0cbyQ2/v9jAj4FtHy30xJTF2f6YSKDmCqoiGhFDSFZG0bIfv+yCQeYaf/sxFItW9/WatdakinEnxqZ29810ldBqFNL9PMNU70HEagU4ZFJjUyLBpVzxFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092567; c=relaxed/simple;
	bh=2xCgTp6fCImhCx7cAeEgtMAKgYNpI+C5vcxhUNzgpEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0ZEGIdgTatg9v2W9B5tgpnIPX0LyVYDKXtQtoKu+xxKtUIqyELDl0VNrnFJba6+nQM6J/+vTRZZfQgJkTDL2ey0L/jpkKK/aLVTQWYDqMlK36zywdXtXGGiAfeUxxcpTqmp+B1bapVZZtHOpGlKNYW7t8DzGS8qT7aE/T/3jNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TCd9DSKu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so3324331a12.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 19:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709092565; x=1709697365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/e2quJEGxF05KoEh9/cnn0SsZvV6fR4cvvu5PLPbKOw=;
        b=TCd9DSKuNSl4WV5KKD/nhNhI6C9d5vYhpihlyL/5uticS73bE+TYObrDly1XUlHdi6
         2hs5TvCQykk0w0EePGb03JczOI6s8a45RdTl3qU3FhXguAx6mDG7cBBJrENK19XDSgHa
         YYqTAIKOKJQMr7siQcrT+dk4ZN6x4WBUdeLs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709092565; x=1709697365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/e2quJEGxF05KoEh9/cnn0SsZvV6fR4cvvu5PLPbKOw=;
        b=TsOHmi79P4uT/ZnTkE0e0SpW8JbKFuwNsZbYrMkymehp+VJvHhq8/t6WwAiTy2qYXI
         JAbALXP0UfgqSy81SzOlAiPFM8kVILSaxAqNK5psd1hqVA0vZunxoP1Bj4lSNBomKM6L
         zj6kjh/OlMd6anjG84yVBNmnMcA6SKSJlwRBeVEPCtZ/eifPk4c9fmoxpVXIfrJGMPO2
         ixTc2lvVAsfdUyRrnYwWSGwOhC+cF0ODrZ7Nvif1eLDDBfI0zgDI0+jtWddIZOo1Vm3/
         aEZY7msSCSp8utlBmMFd6BFiCdr53GiYRi06mSPH5KlOro0yVCMunJskTZwOgn8HJyVk
         Q8ow==
X-Forwarded-Encrypted: i=1; AJvYcCWc8j2z/OcSgQRa4szPsXhbIiE18oFKRM/uS7N5PKyTnrgjzLkP0iqRlkg0XMx59JNkg4Hl4sk8H2jWBmhruCG/OBVGd+5u
X-Gm-Message-State: AOJu0YznWLQgGxXsa4utVRgkyuyIOFtedP4hRWf0PGogykVKKFTIFCf6
	CqSqkNKKZLzLTFVdpHlzCzbB6P/xD2gRIJ+x5FkbT+jvxnr2raYDVp8HE1PzZA==
X-Google-Smtp-Source: AGHT+IFZQyMV09FwEHOnQxGHkW1cHYYqFBAF9QInQ4HAviNlWVNZfPzcomZcyBnBMs30t5YvFWZ2dA==
X-Received: by 2002:a05:6a00:3d54:b0:6e5:3b52:d4bc with SMTP id lp20-20020a056a003d5400b006e53b52d4bcmr7644617pfb.15.1709092565053;
        Tue, 27 Feb 2024 19:56:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a62f24f000000b006e535bf8da4sm3937561pfl.57.2024.02.27.19.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 19:56:04 -0800 (PST)
Date: Tue, 27 Feb 2024 19:56:04 -0800
From: Kees Cook <keescook@chromium.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>, mlxsw@nvidia.com,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH net-next 7/7] net: nexthop: Expose nexthop group HW stats
 to user space
Message-ID: <202402271953.18758AD3@keescook>
References: <cover.1709057158.git.petrm@nvidia.com>
 <001978ea519441f0295912034d00dd1af9eb5b93.1709057158.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001978ea519441f0295912034d00dd1af9eb5b93.1709057158.git.petrm@nvidia.com>

On Tue, Feb 27, 2024 at 07:17:32PM +0100, Petr Machata wrote:
> [...]
> diff --git a/include/net/nexthop.h b/include/net/nexthop.h
> index 20cd337b4a9c..235f94ab16a8 100644
> --- a/include/net/nexthop.h
> +++ b/include/net/nexthop.h
> [...]
> @@ -214,6 +217,17 @@ struct nh_notifier_res_table_info {
>  	struct nh_notifier_single_info nhs[] __counted_by(num_nh_buckets);
>  };
>  
> +struct nh_notifier_grp_hw_stats_entry_info {
> +	u32 id;
> +	u64 packets;
> +};
> +
> +struct nh_notifier_grp_hw_stats_info {
> +	u16 num_nh;
> +	bool hw_stats_used;
> +	struct nh_notifier_grp_hw_stats_entry_info stats[] __counted_by(num_nh);
> +};
> +
>  struct nh_notifier_info {
>  	struct net *net;
>  	struct netlink_ext_ack *extack;
> [...]
> @@ -685,8 +687,95 @@ static void nh_grp_entry_stats_read(struct nh_grp_entry *nhge,
>  	}
>  }
>  
> +static int nh_notifier_grp_hw_stats_init(struct nh_notifier_info *info,
> +					 const struct nexthop *nh)
> +{
> +	struct nh_group *nhg;
> +	int i;
> +
> +	ASSERT_RTNL();
> +	nhg = rtnl_dereference(nh->nh_grp);
> +
> +	info->id = nh->id;
> +	info->type = NH_NOTIFIER_INFO_TYPE_GRP_HW_STATS;
> +	info->nh_grp_hw_stats = kzalloc(struct_size(info->nh_grp_hw_stats,
> +						    stats, nhg->num_nh),
> +					GFP_KERNEL);
> +	if (!info->nh_grp_hw_stats)
> +		return -ENOMEM;
> +
> +	info->nh_grp_hw_stats->num_nh = nhg->num_nh;
> +	for (i = 0; i < nhg->num_nh; i++) {
> +		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
> +
> +		info->nh_grp_hw_stats->stats[i].id = nhge->nh->id;
> +	}

The order of operations using __counted_by looks good to me: allocate,
assign counter (num_nh), access flex array (stats).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

