Return-Path: <netdev+bounces-191192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72072ABA5E8
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595DC1895A91
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C222309AA;
	Fri, 16 May 2025 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+EbV0ze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F41ACEDC
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747434707; cv=none; b=IQ6Oj5zDsgqb/yjaAn2K41sIL1vh0axyoag+yFoWOU5VAaUo4QPUZ1Sx7EzBCHKlinxAbDiJfPPkTrkv+t6mRhr+GQTXPsxaT9RYwW9SpNcSxjVcRUo9KQBJIuJDytXZ9aHeXqy88sn4+NM/JsbR2Rl//1F07lKt2EajGiI8Sm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747434707; c=relaxed/simple;
	bh=j1TzjQ6x1h5RRusIRAxCzoJzqDcMuofCLRpeIjOayrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ducRFSf84Gd02Zu1Al8Ej+4JnDrYUKYjonzVK+nyHFSYunE+ombqeVXVl5XKVV/ULczQd4TntQueiLqM5DMQp5V/fUy4iKtJqmmXdBdluGUvnSkqA6fb1iOKXmUjoItvZOkjRcX5rid8l0PgFnxtJUodjQLHai8TcNwsdFdzQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+EbV0ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D998C4CEE4;
	Fri, 16 May 2025 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747434707;
	bh=j1TzjQ6x1h5RRusIRAxCzoJzqDcMuofCLRpeIjOayrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+EbV0zePfMiLNAhwB0s7/x9bwNJR2vcrhn/I2aT7tJGVpWA6MVSE//HZBr0jeZjj
	 +A6ef6qY2CX0FVj4alj5UydwsenwRG5VTQ9TYeri39YfxkoOOvwKB3IHItpRTey4nG
	 huoxrqqAN5fApQCaTdcBLIUMJvOiYdplK1yiPhORKSa2fmU+2DK1TOZ21taEtOIfPT
	 HoElvP4nY0OPDIxcI4lI75L7eJI7mjUjmGbq8KZOYSaXt8inHEvE5c4JcYavj0u/J2
	 8QmoV3MUhv3CU3P9RlUMcT6ZDtUyI8NSRueNwFLhy9y2n10iIWinhJ/jQnSKWHJdh1
	 iV+6WyOUmGIZQ==
Date: Fri, 16 May 2025 15:31:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, Boris Pismenny
 <borisp@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <20250516153145.602fc02d@kernel.org>
In-Reply-To: <2537c2gzk6x.fsf@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
	<20250430085741.5108-2-aaptel@nvidia.com>
	<CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
	<2537c2gzk6x.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 17:47:34 +0300 Aurelien Aptel wrote:
> The offload works by calling the iter copy functions while skipping the
> memcpy (see patch 3).  We think the unreadable bit is getting close to
> what we want if it wasn't for the skb_datagram_iter() check. Maybe the
> bit could be unset at a later stage but it's not clear where.

Getting rid of the hack in iov_iter may be for the best, actually.
It's pretty ugly.

