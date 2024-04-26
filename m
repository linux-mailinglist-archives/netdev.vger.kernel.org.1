Return-Path: <netdev+bounces-91504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508718B2E7D
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 03:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032531F234DA
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 01:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FEEEBE;
	Fri, 26 Apr 2024 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTo33jvT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80417C2
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096618; cv=none; b=PW+ocIX++X28V2AgoFbb7zF71VQLw4RpAMerE2biJFhWmczZmGGg3mW1ZPcACcjrfq2laoeSqQ6i8LM7rszVLnvYe142gIb+hCwYuexFQBmYzCnxNmELFbF7ncrnOQ23/W6/rq1rcvmb0wjfCay72086qZ8pHYc2g4tY7jaeq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096618; c=relaxed/simple;
	bh=tuViYu7Tm2HqOyts9R3r9Cz566SZObqSwBFbUnSA3DY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qnzviyw9+U4/TikBeoxpSWly/bv0c1Gj9bQvtKqSUSz2pRs/ga/4CKUJc/gY0FjTJATl9+2HsX74kocn2eK7ewy8dOthv0Ic9dp7ffuzxhWZLHvHaSkz2lES/kEQo2gwawyzpFjO+0Jw35B51eksBC/8Leh2+MRqAL1PStVjqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTo33jvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D66C113CC;
	Fri, 26 Apr 2024 01:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714096617;
	bh=tuViYu7Tm2HqOyts9R3r9Cz566SZObqSwBFbUnSA3DY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PTo33jvTo0rrocE1NUkhT4w6rcYBLtQIZA3e8BgHeY+oNwbB6DTyV1yy5imlKm4RI
	 MMdpzrZvq6Tp1AtKEadWzW8TkIutfa0Q3zbX4VTwlcZTxGKpKqMl9w4r5Rx0tR9JY7
	 ADlv52f12C31af5GM2sIA0qNzXDCQs+Yh8bE2pdS9Z50iF/rNmDqXdBDPL4neEsRSi
	 EiyU0fbrtuAmga40He5cQAxp6zsnViHQYu7+tL+yM7t0PQCLl1ujbin+XLsgJzskOY
	 HfyF8O7jwMGQOb7oWPg9wEnC0iDDfd73Fd9Bf34QgxQo+GDZOYnlzvbhOnkiWtp2of
	 NxoOMaHPXva5A==
Date: Thu, 25 Apr 2024 18:56:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 1/2] netdevsim: add NAPI support
Message-ID: <20240425185656.452b31b4@kernel.org>
In-Reply-To: <20240424023624.2320033-2-dw@davidwei.uk>
References: <20240424023624.2320033-1-dw@davidwei.uk>
	<20240424023624.2320033-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 19:36:23 -0700 David Wei wrote:
> Add NAPI support to netdevim, similar to veth.
> 
> * Add a nsim_rq rx queue structure to hold a NAPI instance and a skb
>   queue.
> * During xmit, store the skb in the peer skb queue and schedule NAPI.
> * During napi_poll(), drain the skb queue and pass up the stack.
> * Add assoc between rxq and NAPI instance using netif_queue_set_napi().

This one LG, FWIW.
-- 
pw-bot: cr

