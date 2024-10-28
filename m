Return-Path: <netdev+bounces-139635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E629B3AFD
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5FDB215FE
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833D18EFCD;
	Mon, 28 Oct 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P31/bBZ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB33A1DB;
	Mon, 28 Oct 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145814; cv=none; b=UXxTcA78yg8gIFOoRC9XgvcwF4RGnwGo9XpYMqj+gwpx817wmBzDZVBJJkD6bWuSJgp/EBk89mxeF+y0bORXqDM2dhuzZoEaROwLvOQD6pWIpPcuvYyD7ZGrNyE6LzX3zHFDvpIxwmud44fhh9CBkdGNfg0F1Nl9dWhETVH6ti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145814; c=relaxed/simple;
	bh=yGd4atcho1v3wFqcdp4aYJLn6q8PeepThD2IydWRhq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IN6LzvV4gtz9mt/VkG8mk/2RW3rnDDPZoptFyFJqq2U2a3f1K86Lquk86meprGmZ68pwHiWltR3YjRmm8kQOw7C7E+xo4+/cIBPx5ivVS4o4o+KQlpZvUpaw5z18dGp/JNiDsshcgNlA8mxMc1xYHS9Pv36nkPrCZf67P5qJ51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P31/bBZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698EEC4CEC3;
	Mon, 28 Oct 2024 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730145813;
	bh=yGd4atcho1v3wFqcdp4aYJLn6q8PeepThD2IydWRhq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P31/bBZ3FKkhLqRoI+J9ao6XDcNbpD7D72lXYgxmdGc2aZsSnl9JXTMpN0WMTKcwE
	 8Z6ONNzqO+aVigSIunOA7GSx0NRw6MSNTQ1Ll9Im5S9EUJeBsHoSTpx0Z0Ipy7chij
	 fvsXDHIEZBK0Osc1J4qJfHR4TUvZAvxoOqv5/OgBXT213T8KcsWEM68UgR3i6Lmx57
	 BR6W9FAmDstxvlUyAhS20f9bpxBksNFyQlY3vEYnO1t7N0Yo7Yx+yAWMGBAH4ia35T
	 TN+fNrhb2YXTrVXLgNL+uP00ZliVeBnb10bvlavpR36/lAX50Hs3wD9N46rjF0e95B
	 oyV+fuzz4XSew==
Date: Mon, 28 Oct 2024 13:03:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sched: etf: Use str_on_off() helper
 function in etf_init()
Message-ID: <20241028130332.2822b1bc@kernel.org>
In-Reply-To: <20241020104758.49964-2-thorsten.blum@linux.dev>
References: <20241020104758.49964-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Oct 2024 12:47:59 +0200 Thorsten Blum wrote:
> Remove hard-coded strings by using the helper function str_on_off().

Use of the common string helpers is a bit subjective.
Let's leave this code be.
-- 
pw-bot: reject

