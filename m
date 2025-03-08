Return-Path: <netdev+bounces-173128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB27A577D7
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFF3177062
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154713D51E;
	Sat,  8 Mar 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXuqn6q1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8577E3A1DB;
	Sat,  8 Mar 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404156; cv=none; b=asFrM78GEkj2VwA1NjaC4GsgfiACLBcU4IyT9lcn4B9UOzSzao+ZdxlyZLR3YAL0WzGkuCkYYj2L2yn5P/+DuE/XirPebgwwoz+OOCXmeRKGhfvNHmaT7CDR7bYee2LSJ0X4KUBeL0Ni7HLrCd6nbtR4ZllTT59iFs/MmkjLJrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404156; c=relaxed/simple;
	bh=lm6Tg3uB6lgDPoKYW1Ax0jDR9m7yfSmWD6uCd+AXKOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbXha4gZiVIzFcbnX+4isnCeJ+jPCZr7sB0Gma6BrTxWc86JA8RwWhiJvix55l4Lec2dCM0c08mkHp2ijALkjuef+gPwSuD8FinJOWYQ84ajkAvdSBfjOmFY2FdYCdVWF3Zp0qSBGZv6IWcoO8Y5NKFQxIxNaJYBE5Z7WL/rEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXuqn6q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4F4C4CED1;
	Sat,  8 Mar 2025 03:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741404155;
	bh=lm6Tg3uB6lgDPoKYW1Ax0jDR9m7yfSmWD6uCd+AXKOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QXuqn6q1z+t5/+DpKDPYi4r1j/NRIi//G2Xtr75yPo+8E8X8sPX1JWcn9FhUJQP2Q
	 HA11M0UFwZhNGIvge2/YttfN6P7qMOsmgSd5ifdvk6dAEbcqPFPZaHstKPKNqcBJPu
	 DITKW2HFD3WaKfj+f4RS4L9mLZ70cRDho32zjsebEgFQFTZVou7QywiqrxS36bNkZv
	 kcQb6jW2d7tb4YMR7vMR6vda9kcxycA+rorVKgCP85/hSwFfi/MNWpqAtU/WBHKhqd
	 qkjwT+ZgFjzMCAhAxlwFyExSIQ5JLQ3V59SQjE6VYxNv3GAmBQIfBMO41E6ZIDRTGq
	 4VmkMtTqvJB8g==
Date: Fri, 7 Mar 2025 19:22:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com,
 xuanzhuo@linux.alibaba.com, almasrymina@google.com, asml.silence@gmail.com,
 dw@davidwei.uk
Subject: Re: [PATCH net-next v1 0/4] net: remove rtnl_lock from the callers
 of queue APIs
Message-ID: <20250307192234.2f8be6b9@kernel.org>
In-Reply-To: <20250307155725.219009-1-sdf@fomichev.me>
References: <20250307155725.219009-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Mar 2025 07:57:21 -0800 Stanislav Fomichev wrote:
> All drivers that use queue management APIs already depend on the netdev
> lock. Ultimately, we want to have most of the paths that work with
> specific netdev to be rtnl_lock-free (ethtool mostly in particular).
> Queue API currently has a much smaller API surface, so start with
> rtnl_lock from it:
> 
> - add mutex to each dmabuf binding (to replace rtnl_lock)
> - protect global net_devmem_dmabuf_bindings with a new (global) lock
> - move netdev lock management to the callers of netdev_rx_queue_restart
>   and drop rtnl_lock

One more note, looks like this silently conflicts with my:
https://lore.kernel.org/all/20250307183006.2312761-1-kuba@kernel.org/

You need to add:

#include <net/netdev_lock.h>

to net/core/netdev_rx_queue.c, otherwise the series together break 
the build.

