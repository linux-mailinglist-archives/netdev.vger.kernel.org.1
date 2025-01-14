Return-Path: <netdev+bounces-158279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E908A114F2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5053A54C3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296121A95D;
	Tue, 14 Jan 2025 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qRAjLIo6"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDA215798
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895701; cv=none; b=c6jKX5tJl7WAvk6n5LCN6d2O7aKRLMMGm1e5aTc6FqSHkw3hom5HmPhx+mzNhka7xKrB49CWSZI0Ay8Wkhk1XCbiqkZ7u2x+ZqD2vauJ6yrm7btjBbHjj9IXUvjcfBWQ7gkVxSYwoDmuQy5E8+12DHhRmkHX12rnrgoyIQvmafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895701; c=relaxed/simple;
	bh=4Trh14FTujSrp5fcT2f4OE7lzQRLuNXQNkIUrlHItlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eT9R2afN1veA3TXB5kqxxAcHQUTQl05N5ULgXIF9D5Rsbslrdkin+EU6FHqvxgLXiYD2rnVbXF8ezL/l60r86QePc5F+P6ALIeuFdETH307uBg6lljCo9RC57fLqS0Vk+1ZJoSgxiYKaaaGiPb3NH+3SUh4kiqP5RPURiDx/VEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qRAjLIo6; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2245508b-a407-4c89-a3ae-3d74a6e2606a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736895692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAFUm8D7a2Uwh+6YLbEYXnPfHtAx5MFcNcrzlymGZl8=;
	b=qRAjLIo65pu8TxVzWkPxgd1R2aDMCX+aASKUwW+49NIf8D9oj+yFy6m8kJiGiMYq/zJxYo
	CkdFTmB35wn21geJcU2edkbcaJqYMdTXAjtNV+K2A1+Xk5BobI0DcWLpdV/c3uZhzDCGHD
	pBgNeTDOaj3StRqq/cdJPY3+YK8wuYE=
Date: Tue, 14 Jan 2025 15:01:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 net-next 2/5] net: no longer assume RTNL is held in
 flush_all_backlogs()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20250114205531.967841-1-edumazet@google.com>
 <20250114205531.967841-3-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jesse Brandeburg <jesse.brandeburg@linux.dev>
In-Reply-To: <20250114205531.967841-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/14/25 12:55 PM, Eric Dumazet wrote:
> flush_all_backlogs() uses per-cpu and static data to hold its
> temporary data, on the assumption it is called under RTNL
> protection.
> 
> Following patch in the series will break this assumption.
> 
> Use instead a dynamically allocated piece of memory.
> 
> In the unlikely case the allocation fails,
> use a boot-time allocated memory.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>


