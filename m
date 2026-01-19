Return-Path: <netdev+bounces-250946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F4D39C20
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5E4A30071AC
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B68520C461;
	Mon, 19 Jan 2026 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXLVBf6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C949F6BB5B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787193; cv=none; b=jg8tGlFErvpDoXWK995le5gtZFNwADAWjJwgwwdJwIq8X28mfkP2WnjNOKncKK+nR2HdHjbe3YT+uG650PGBQDV7N1c37VHxIl/tOJbA6xUh5dOIr+OVUA/wCTPs2SOjJvplt52CfoZyxfvr8K7dGGwdbxpKRvpAsS0RT0U956w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787193; c=relaxed/simple;
	bh=9lwQnZfXYoCMJq9YoeDIddxP7JrrS9jy7ARcqG3rVsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQqXLrqLA3F0TZiDKn4iRoUcrF3koqPYGOnRmjl4SeNGmBU2e/Z5BU5H8f2pCy6a8mdFn6Hnjfa/KJYz5ntj4G4e7eCfIiDszEJrAc3gm+/WhhCqg0X7W0xtgu25OFswF34o574NMPGC2VkS6CL7hLZKbgGixArTwKQIMqxcUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXLVBf6Y; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b1981ca515so4086606eec.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787191; x=1769391991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iehqn6j4OZ3OekVxEIvyv834zGJxoi7hUEw8UUQb3oQ=;
        b=LXLVBf6YYOVBb2EJvynvCsvocSPcUbJucbnKSvRjhXxVQ+wq6VqpwbTllrHU3z+59S
         E+RG93b1OR77EzlJ3fJa3dgpK2LHZQx0aWaAu0fLd6g+hsRs1mUcCWoDH3iEXfXoxyHv
         0OMGqq+6m+56kpdbSQzLtP/kTf5900RV4XSlSkW2WUKQTUK1g9hWs3d2yDD7s/hCdMq3
         ndLE9U9ATImtTyOvLEqIBREbV/BApQQ/8sirBRgdxHLQWx2dAllmcPJC2nRzZSJOyO7o
         vyhlmuLuN9fbOIayQlr/+VDGoyH4E56ctxFZuoTMk84NSmIHjh4CpZ3qtIW5OjvDa9gG
         El3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787191; x=1769391991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iehqn6j4OZ3OekVxEIvyv834zGJxoi7hUEw8UUQb3oQ=;
        b=d/08a7WdlmEAfqVpzW4371z0GzWUMX8izzL9dIY38KzKV6ReYMncjqgcjyJpsOIHQ7
         fz61VrT3W8EqqMskED0acEfp3AFm9NRZUXpkVnMJKSHmwuKBMbbP9wM7VKpt/icaeiG2
         QGlvoMNuornyAwvTtFVqX0On8h8f3Y6nIkwb2xbfMiyv6ZJYLqXAk1ksa/rI7eTvSa3w
         u1Sgbw5fh3fKkxRLZBhUmPDeJsOp8czwkPK3bloQCCSE/3dTQE6GM+1QErGMNKqsBmrj
         QYcB8TTxl8UGrmcphHDshVpcVer2vSAjxB5nRe0e5xFvgIbpWOWGLpTIcDmjPOTg+CL0
         nCBw==
X-Gm-Message-State: AOJu0Ywa8LYSIQpQBTDzSfTaYiZGtb5/7yS2szZPb0DNpITOLg7ZZ5Xg
	lAN2o604avTNmJbugLfFaryuC98txR4vqLnDwnzYQacxeTXufnEXXas=
X-Gm-Gg: AY/fxX6RAuMBhzulhKBq9H273inu6lCz4UxD3EFjulyrHk+MR59+m862hMIOak6Cfg9
	o36OKP9rO/3wv78uTe07iu8MV6vXWxZIPDs0bqTWT1BLw0JaSywMLWijPg7IFURCilHDbWcAgTf
	3WfHLYQuB4gJ46bJX2YZku/Q+gh24LExIbXkLawMMC5RQU2INlN0FtFTBIlh5axDexwl1gQl4sY
	ZpxEYG46PvvBBImhmkTaOAqCjQsgzA2QFchA2Dg8FiLmYlGnBMylgVuOJ1ePhe3BaP6RV52Hkiv
	0XNNsL0RBnMxXSZgKpqeEhH1EowJU5K5UogYIiNnhBTURk8VTgQM4qdClHAwVhVmr7M32uOJ417
	aJzkM+8PbiY5Le4CtWRVy0cflZeQVtfAaOXDWUfC8ILpUiW6Yohs5ydvdsKL6HHIYSgCpj/sVQ5
	PtneVjTo3Rt4kyLGAeI2c7DrIW2DTIekJtQ7yWY+hhH8Ep7y3SccaoayWnh6NQpS3h5BgsGeZxC
	/xG4Q==
X-Received: by 2002:a05:7300:a98a:b0:2ac:196:c0d1 with SMTP id 5a478bee46e88-2b6b40f3548mr8770944eec.32.1768787189383;
        Sun, 18 Jan 2026 17:46:29 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3503a30sm12482735eec.13.2026.01.18.17.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:46:29 -0800 (PST)
Date: Sun, 18 Jan 2026 17:46:28 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 16/16] selftests/net: Add netkit container
 tests
Message-ID: <aW2M9HHX0i_T9JPk@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-17-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-17-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
> program to ping from a remote host to the netkit in netns.
> 
> Second is a selftest for netkit queue leasing, using io_uring zero copy
> test binary inside of a netns with netkit. This checks that memory
> providers can be bound against virtual queues in a netkit within a
> netns that are leasing from a physical netdev in the default netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

