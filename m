Return-Path: <netdev+bounces-170906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB6A4A815
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 03:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB986177F4A
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 02:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211B35958;
	Sat,  1 Mar 2025 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaUdawIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8169F1EF1D;
	Sat,  1 Mar 2025 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796081; cv=none; b=Oh52/MAuaOz3YZ9LgWBIfbZDdSbI2tPCPB3ZWq8MB8bXgn5zzK2MC/Dxyy5p9ziibTqLy32J5D8CZ+bFSFH10U/VH/OBHH3gSXCsNE813mBCS2DwPcZ61xwYJ0EXUG9p8uUn5CCse8oNf3CfHxBZmf5fv60eSKPgLaScRKXYvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796081; c=relaxed/simple;
	bh=r0Ii5ibMD5WADHE19H4KCYex435RPMYJLz0UOJgqFXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVnA8YeXABxYafGCqlrOABLK1A1+RGaq6ZZUZDK0ZycDtBqMFWHnS30QR5MYO30EokNdxekSivR41PoqufxH51l4MAW4h50Ow083Nwst8UropL5RgrpKn/SzbX2c6iQMrWJMwLyQjQPCdj0sQKkNTZi77zualowqUh3WaPafunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaUdawIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60181C4CED6;
	Sat,  1 Mar 2025 02:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740796080;
	bh=r0Ii5ibMD5WADHE19H4KCYex435RPMYJLz0UOJgqFXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NaUdawIaVPmLjIhu0UPwW7Qc1zEeHnMxU9NDvOJ3ZwP1bLChZ25Kk6FKBwBiroux2
	 xHMvA5XWoKQ0viWXynP5cDQwTuquRerYzlvKa+vfSi25cRSs1BFfsmygyAjMd6JBq0
	 yCxLO748Ue7dXVGl+qxsSjglawarcNvP1R1iEyuu9b3DdDKhV+UPgguEXhwB6Sz6sh
	 lQIqwSyjgq7HMwefc02Doff+Pokc5m7xqTPlqsyT1pP0WXS6BvwItC3Ga4r5uaSJPu
	 Ytx2J5+hpipuib3P3+EtuLtzNl1ECxuE3k6oEJt3hqCr8IZuHEjIEwEGYLQw/J1QSc
	 vrJb9ZvGgUHww==
Date: Fri, 28 Feb 2025 18:27:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
 gerhard@engleder-embedded.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <20250228182759.74de5bec@kernel.org>
In-Reply-To: <20250227185017.206785-4-jdamato@fastly.com>
References: <20250227185017.206785-1-jdamato@fastly.com>
	<20250227185017.206785-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 18:50:13 +0000 Joe Damato wrote:
> @@ -2870,9 +2883,15 @@ static void refill_work(struct work_struct *work)
>  	for (i = 0; i < vi->curr_queue_pairs; i++) {
>  		struct receive_queue *rq = &vi->rq[i];
>  
> +		rtnl_lock();
>  		virtnet_napi_disable(rq);
> +		rtnl_unlock();
> +
>  		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> +
> +		rtnl_lock();
>  		virtnet_napi_enable(rq);
> +		rtnl_unlock();

Looks to me like refill_work is cancelled _sync while holding rtnl_lock
from the close path. I think this could deadlock?
-- 
pw-bot: cr

