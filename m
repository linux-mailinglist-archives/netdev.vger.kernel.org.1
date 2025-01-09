Return-Path: <netdev+bounces-156825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3614A07ECD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D923B3A77C0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF233191F83;
	Thu,  9 Jan 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ILDrE8nN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDDA188722
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443935; cv=none; b=a3WxMxqItQYX574u5zXCWQXLprOGX0jP64HS71i1M8ySn3NaTSs/3S5hpXnol70IXdkKdveyN0E/sXQCsoxWfE7ymM8KXCcQPp+aFZatBQYbqp3ZwC9Zl2nBs5hTYCp63vGy0F807MUcT2YyiYVgnY7EhRYbk4g+W1pmh/H17ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443935; c=relaxed/simple;
	bh=RHcvY5vh/w5Qf1apu2pIUveQ5r1BQ1uATyGEk7bzDHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeEfVftzLR2LM1+rl3rzxqUX2jgNxpwLqOS69LD2KkgG2Adfm7pHU3OxeR51aQyP0wCQTu+6QuGUHrc3ZRE4Lc9+YYo03H9cc3RvBDd+RNqYmgtWz5esKIffrPOc6sqVqjw4D+dHj3WKdasJIvu12vD7Ue1kkoap6gKsz84yDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ILDrE8nN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163dc5155fso20247015ad.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 09:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736443932; x=1737048732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UNh3XSymBqQsn+VyrNiirXx9s/ikn0z5oyEbF5eRfg=;
        b=ILDrE8nNC0esu8HcD/pSJw/nIlQpS6AXjll9w4mZlCNtts4jdrMyPNp6sKHg+GQyc5
         dZfqEntRltSjM+4wzaZyfhf+8mJSl+U4hIzhiY2iGlErO/vf7oWaVAVVhMZE/dqbiO0T
         5ZVMkGQtujwtArCyuR0JgKSuC8MnS6ynW+Ei8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736443932; x=1737048732;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UNh3XSymBqQsn+VyrNiirXx9s/ikn0z5oyEbF5eRfg=;
        b=Zkuy/mk5pQylVYuo3RaRpUVQW8t8nMLQo2h5+tra0vxFjoi/tpNNg7Ed8/vQod2+dX
         RPoYW44V3uIf86GiPol4Htu8fv/RdLUrAruEy5gc0C1GOeiW/ffYvOxPYa7JGww0CP2O
         irqXGgWxGMoEfsRRS+sWk1u8VIFWYClVS6u2X5x7k2zaG8wlDz6OSqPceyUQjSwifwtU
         1xdANhCgT1/7L0MMNGw5wWrgfoBzAsVgLH3nzN/O2xmAUefbJAavIDQWqOQzN0dpXO/M
         CwrC5iyw1jozB8YAwt/fuYEMMznb2n0n49G6T/hH+Gb74b9tHEUwpSkGO8TL44hFRMaI
         osgw==
X-Gm-Message-State: AOJu0YzVaODgc4v5JGjVXWUUaanBjqN9GEai9V4f/SQAHXsTtW+GI+ya
	IA3JNWl9XE7zonbTyyGbXk0LSSczfIZ3oxIB7OwZ8SO6N/lTJMMcpQbjqMi9wnU=
X-Gm-Gg: ASbGncu+kkqCzKQrUk5T8M0FE3yJU1qdMH2mANLKIVwE7RuopU/TfDbVqpW3fHsfHdm
	hdxrD4hoWy4I4Dz5CeNoW+ORnmgNFo6sUm+x9AxUspURhLSgDZm+I1zCRSS1vHjXpZ6hQij4rYm
	fZDKsbALMewHAFXiHsQhnHcni22nkjWTjGjOdzUia0bTomk2OA4p46gSntAWOJFHL4EbtHzT/Q0
	odZ+ThBBtZlbOeF5IOE/yDaaEDHrpTlm5ojoDYTuNExsvgYunDLWv0XfherqtaRL/ziZpRy4M82
	hUm/eSjKn3uPEUSUND2QW28=
X-Google-Smtp-Source: AGHT+IG7/4G/oFkDNNnhgkJMtk6EtVQoD1RUklEhY7FF8vplHNOXWAQR/POf4R2MiUbUDfOIGJjYtA==
X-Received: by 2002:a17:902:f706:b0:216:69ca:773b with SMTP id d9443c01a7336-21a83f4b2bfmr119702625ad.5.1736443932488;
        Thu, 09 Jan 2025 09:32:12 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21a7f1sm476895ad.124.2025.01.09.09.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:32:12 -0800 (PST)
Date: Thu, 9 Jan 2025 09:32:09 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	mkarsten@uwaterloo.ca, alazar@nvidia.com
Subject: Re: [PATCH net] xsk: Bring back busy polling support
Message-ID: <Z4AIGWGVrEfk1yvE@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	mkarsten@uwaterloo.ca, alazar@nvidia.com
References: <20250109003436.2829560-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109003436.2829560-1-sdf@fomichev.me>

On Wed, Jan 08, 2025 at 04:34:36PM -0800, Stanislav Fomichev wrote:
> Commit 86e25f40aa1e ("net: napi: Add napi_config") moved napi->napi_id
> assignment to a later point in time (napi_hash_add_with_id). This breaks
> __xdp_rxq_info_reg which copies napi_id at an earlier time and now
> stores 0 napi_id. It also makes sk_mark_napi_id_once_xdp and
> __sk_mark_napi_id_once useless because they now work against 0 napi_id.
> Since sk_busy_loop requires valid napi_id to busy-poll on, there is no way
> to busy-poll AF_XDP sockets anymore.
> 
> Bring back the ability to busy-poll on XSK by resolving socket's napi_id
> at bind time. This relies on relatively recent netif_queue_set_napi,
> but (assume) at this point most popular drivers should have been converted.
> This also removes per-tx/rx cycles which used to check and/or set
> the napi_id value.
> 
> Confirmed by running a busy-polling AF_XDP socket
> (github.com/fomichev/xskrtt) on mlx5 and looking at BusyPollRxPackets
> from /proc/net/netstat.

Thanks Stanislav for finding and fixing this.

I've CC'd Alex who reported a bug a couple weeks ago that might be
fixed by this change.

Alex: would you mind applying this patch to your tree to see if this
solves the issue you reported [1] ?

[1]: https://lore.kernel.org/netdev/DM8PR12MB5447837576EA58F490D6D4BFAD052@DM8PR12MB5447.namprd12.prod.outlook.com/

