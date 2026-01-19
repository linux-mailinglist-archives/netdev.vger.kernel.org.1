Return-Path: <netdev+bounces-251183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F4D3B3C6
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8EC23138C34
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526B5329E49;
	Mon, 19 Jan 2026 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNdag6Q4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33B2DC333;
	Mon, 19 Jan 2026 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840681; cv=none; b=pUY+9GKJZQwAaaGfDFPgfssKiZZQsX7+L2RwI0HcGXdOuKYKYuo/2DhT3AOdh27B4YKEJw5qtcJDtr609fIQQWhlBeb0otXTKeu3FPlphuU1UqpYnWYAg+Zf2NPZbf4E5gOoIl11XVnkLKrBHJJFRZmGaTloH8K1m1L4cxE+cxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840681; c=relaxed/simple;
	bh=6/bsTBTtsVmOU6fHbUlSb+w0De5KxZ7QdY7r++zX1go=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpFqP6KMzvpP1IARboTAD+NzISHYxzAMVYbuQNxA8GJTgDwgwGl/BPZQi1hzHARSD9HI2FviKiQapQ9kwAURkNVXZhQIooesE/gPz9RWqGtVljfAj3nGa06yXO4zXwgs/JLfGxmNL0ba2IAOykbKaIIHqkq71umKLXescuWUAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNdag6Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B1C116C6;
	Mon, 19 Jan 2026 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840680;
	bh=6/bsTBTtsVmOU6fHbUlSb+w0De5KxZ7QdY7r++zX1go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bNdag6Q4SY66xfpb38F01mNNzPt9osUxYd48ITeT8r6zuzEARF4yCoxZiugJmpzQF
	 cTm4BFwMnjtidVppkvOh3eYrWcLcsa5Wbt9u0myBRaY8uuNirAkkc1znxXjKMZu+0v
	 6tFUTT+iaI6oBx4qoE1EJWXXukBkNgppfki2zJj2wCcaCdgx+uiG2pIaqh/BsYWHpe
	 o8hC5RVNuosVlSHYR1IHaj6Yngx0zUPvSsxtlHm2UZ5JPifdQQvhEO78KeHOe4B490
	 su0k4HHftLq88LxQ4sF3mtG5UwJ1zo5/CUob4xrDvAeOCjj+0JWGfbi5QQOzuJunkH
	 GsrBO6ZxRdiOA==
Date: Mon, 19 Jan 2026 08:37:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
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
Message-ID: <20260119083759.5deeaa3c@kernel.org>
In-Reply-To: <20260119102119.176211-1-leon.hwang@linux.dev>
References: <20260119102119.176211-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 18:21:19 +0800 Leon Hwang wrote:
> Introduce a new tracepoint to track stalled page pool releases,
> providing better observability for page pool lifecycle issues.

Sorry, I really want you to answer the questions from the last
paragraph of:

 https://lore.kernel.org/netdev/20260104084347.5de3a537@kernel.org/
-- 
pw-bot: cr

