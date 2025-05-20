Return-Path: <netdev+bounces-191908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AB0ABDDB0
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3757B1560
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7D824BBF3;
	Tue, 20 May 2025 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S33aeYEk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0F22D4EF;
	Tue, 20 May 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752298; cv=none; b=QCkbyFyZyGrZoZdq3RlJLaI3PfBgZ5pPrWvs4bEO6OOQVoBO3NsKX8x/7hxvy32wq4rdRlREX2M9b/DvlaB5zmL1Oq06jzyExClCr5wLx/+aeIvbVIm3tcOCBc8egU/2AQB6HSypHp3ayYVP+O/wqtzqrrSbfejx0HgyvapyAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752298; c=relaxed/simple;
	bh=bCqjLkWpMiwgQti/Pl18SKEvQadAmmDXATN9v9huzmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD3FYoTegUew7HWhdtJH51ZWbBxOVexA/AIt+fgbrbqMiHh8uQkDW4X5MimvqRscFGXh38HpqKbn9qF1Ikg2x1V+YI6/9F1rL/JinUC7OnIK1fb5t47FkkQ1CO7B/05qEd8HaXWwrAHLP3gVcOPggi3ssw0SyZ5DBqQvUJzsrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S33aeYEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FD1C4CEE9;
	Tue, 20 May 2025 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747752297;
	bh=bCqjLkWpMiwgQti/Pl18SKEvQadAmmDXATN9v9huzmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S33aeYEksfvg534co7C9RS9iJi8QdjDcztvVXwF4BQNx4FxOS/B1LfbE4mnkzn0pq
	 Z2rId56EEcxd6CiT74k5cHhkZK27cTZoHv5vj6EOU49Fm5le0e/jvtmRlbFELPt/tP
	 8JgX0RjY6mFkF70S7YZZuXqib9JquQkm7dwrmeN8QH3oomTLvZ/WbXsOGczuLSZ8JF
	 +WAz+QZqNe7ZWwaUcIrL0jsuQM60CQc/XFOyQD/ii1M84tTQK7n+YNZklFTbEf+ei/
	 l//QPw8569M1Acgpijh7z0sSinMQeGr04jRbKWwu15CSK5NRwI9839ywLb5I+AxOCo
	 ngaStGprNjI+Q==
Date: Tue, 20 May 2025 15:44:53 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v3] rtase: Use min() instead of min_t()
Message-ID: <20250520144453.GY365796@horms.kernel.org>
References: <20250520042031.9297-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520042031.9297-1-justinlai0215@realtek.com>

On Tue, May 20, 2025 at 12:20:31PM +0800, Justin Lai wrote:
> Use min() instead of min_t() to avoid the possibility of casting to the
> wrong type.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> Reviewed-by: Joe Damato <jdamato@fastly.com>

Thanks for following-up on this.

Reviewed-by: Simon Horman <horms@kernel.org>


