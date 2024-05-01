Return-Path: <netdev+bounces-92775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758308B8CD5
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169FE1F25D45
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D212F5A7;
	Wed,  1 May 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIkdiXQq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75E12F5A0
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576612; cv=none; b=ESIt6qDP3ZF4/aK7bpFhSQydtFzVTSrekuIFo+dj/UyC7/o7MJ0gMbkyAAgpJp1ojzrVeELRlAnZ0nouCnzgOk4gw+mVKCW9KvCpVyeNsJPV6Ds6mI5vIVc3p58+BjXVeIzxcs9CWWYDNi4pJ/BTdZ5G6o+oe3rsv0swdHtQbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576612; c=relaxed/simple;
	bh=k22FaEAVfJHfDcs2F+vKI10My4stBKgwPWyrp4BCf5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX1ko93Z4tuazQUsn/1+EjGC10uYoVInql/uf1WVYUkbkQ75L/LX2GY6srB+Nkh6QeX8gqnkODEdAQ49Z64hpKWeZ099WZnzcqXrx7Tyr4YyUm8oCoCthbX+nKzJ3QcRGk/djU77OFPwlvfs9l7uUcSqnWD8xP7/RY3LgbYW3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIkdiXQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A7CC4AF19;
	Wed,  1 May 2024 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714576612;
	bh=k22FaEAVfJHfDcs2F+vKI10My4stBKgwPWyrp4BCf5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIkdiXQqjuMLZmU+2Sv5eOKo9nnwzWDq2UR0KJsSQgamc6Tir8itvByJcuk2bQLSe
	 wXqzNWb27RhTkqibICjBeqp/9QVHu4kc/haZ71lJpG9PPSyg426bJnCfkaj4NMqtSE
	 6SBZKHQEtQ00VmkBzZParmBPonhiFw/xUJLG7oIi4rT23OWtWMFusLbb6z187CHYzF
	 eGTZ2UdnVNvFTok5JTEyl+Auh012v+gSvVs/nNT/xo5QrM/7mwcfmTavkWzL3BRLyv
	 os1VjktuvR0n3ReMPXvKTcjDD1h8Q2oOP94jdciDi0S+NHY6juCFlDrAi6ZTVSxL3m
	 GbNxofBrJT9Tw==
Date: Wed, 1 May 2024 16:15:17 +0100
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>,
	tipc-discussion@lists.sourceforge.net, davem@davemloft.net,
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	Tung Nguyen <tung.q.nguyen@dektech.com.au>
Subject: Re: [PATCH net] tipc: fix a possible memleak in tipc_buf_append
Message-ID: <20240501151517.GT2575892@kernel.org>
References: <90710748c29a1521efac4f75ea01b3b7e61414cf.1714485818.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90710748c29a1521efac4f75ea01b3b7e61414cf.1714485818.git.lucien.xin@gmail.com>

On Tue, Apr 30, 2024 at 10:03:38AM -0400, Xin Long wrote:
> __skb_linearize() doesn't free the skb when it fails, so move
> '*buf = NULL' after __skb_linearize(), so that the skb can be
> freed on the err path.
> 
> Fixes: b7df21cf1b79 ("tipc: skb_linearize the head skb when reassembling msgs")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


