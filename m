Return-Path: <netdev+bounces-251198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1A3D3B434
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B04C3041367
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6275328B76;
	Mon, 19 Jan 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8cxGCFE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6B324718;
	Mon, 19 Jan 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843430; cv=none; b=pxM+EaO2wRhL3PcYVgPyZQjaOdaP2OCvc5DAjaxkdAFacuPZvuLdbmX9p/KnM4pawWF8l8VQUD2q67iBJXcT54dKIeMq9+VRNwany5MhpX3z05Rk3TwqCaqGvW4dkwEVzOyX0r5I7faAQVfFchyKq7ytCzRCq7AHVT0VRmXOBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843430; c=relaxed/simple;
	bh=FvKjt4MsrG/b4bAe0lEt5+tN0Y77/3/5IdzA5eYZ2Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6mJk3eL8xEMjvVZz0QizvmwSal/9WenuYSXkFkYU3Vu/5dk6IIlcnxZbeVJ4XzbxhogcwZHm7PWAAYE6SDc/OGIQQbAhFf7HSbR0VV83yhu8vNV4M5AR6aGSOSpF4ymOuq8aMbaY4m1J5BBdwuiEeQRhAWV+WcLwJnOpRA5K6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8cxGCFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A1AC116C6;
	Mon, 19 Jan 2026 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843430;
	bh=FvKjt4MsrG/b4bAe0lEt5+tN0Y77/3/5IdzA5eYZ2Uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8cxGCFEcMZVPdzG6eegsvcMOsUhmYz1SW42hH92A25Y8GyBR9nOPR4fkHI4ztMCR
	 r2uW4+YpAcWMexgf4QaQhaNPhIhocrwOLOXQxBwEz69+ZcPDV0RBHjvzHr9rfTHskz
	 kyGq+noFoCdHrQKpvAr59qvVr/+bgZTP2PttC0E/KaUuxc1Eik/zy1+jZxa6l7Kydz
	 WaCd8y9RyjB9KCuzdbwMwjoFBhdyNkQWWYKdZQkXRRdsYFhjfB7yp4GcDD2R+QLVSu
	 anjpbwaWvc08XylGw2gzTOyPr3Vjkfx+KkUstVUmeSsRMTqpcHe6bRdAtC8xLAsj2r
	 mQm6xAfubtVjQ==
Date: Mon, 19 Jan 2026 09:23:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Leon Hwang <leon.hwang@linux.dev>, netdev@vger.kernel.org, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Leon
 Huang Fu <leon.huangfu@shopee.com>
Subject: Re: [PATCH net-next v4] page_pool: Add page_pool_release_stalled
 tracepoint
Message-ID: <20260119092348.4e4b1f10@kernel.org>
In-Reply-To: <47152311-1357-44f8-ae12-61e4850e62c6@kernel.org>
References: <20260119102119.176211-1-leon.hwang@linux.dev>
	<20260119083759.5deeaa3c@kernel.org>
	<47152311-1357-44f8-ae12-61e4850e62c6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 17:43:20 +0100 Jesper Dangaard Brouer wrote:
> On 19/01/2026 17.37, Jakub Kicinski wrote:
> > On Mon, 19 Jan 2026 18:21:19 +0800 Leon Hwang wrote:  
> >> Introduce a new tracepoint to track stalled page pool releases,
> >> providing better observability for page pool lifecycle issues.  
> > 
> > Sorry, I really want you to answer the questions from the last
> > paragraph of:
> > 
> >   https://lore.kernel.org/netdev/20260104084347.5de3a537@kernel.org/  
> 
> Okay, I will answer that, if you will answer:

To be clear I was asking Leon about his setup :)

