Return-Path: <netdev+bounces-165646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB039A32EDE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D4A3A2ECE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D548260A49;
	Wed, 12 Feb 2025 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp6hL2vz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAE256C74;
	Wed, 12 Feb 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386127; cv=none; b=eCAgmb6qLq2sjfUJKV3w3red+ny/zh52Q4ztw4bJor0zjOEv4AVOjAWrO+pgf1mJYGo/XhRaVzcGIgCh9E7j9JskVy39r+PCDZr2nLKqn1aGsGDe5j94AtztaQ+uoCRETO72Xd0T+pxfNSfuPHkSU6s0qTfdwffVuPyt0PvT2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386127; c=relaxed/simple;
	bh=x5cUHjS8wcKrs320uyZQTcHrj2ZRAkm8TZUlxtqk/EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDvzuRCtQRJLNLvBZGzc8UFcRw6NbRpixY76/sOwBe2uJLuO/oX03GTRBgtD3ES3FZKYTWqyj+L042WeuQUxIjYsRiqCaUzd84AOx8g6g3NqmF3oujek1PZSZgnZzyc5mpHVGM9midhFi49H2XwiLJfMnMcyKrR5qn+7lYygQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp6hL2vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827E1C4CEE2;
	Wed, 12 Feb 2025 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739386126;
	bh=x5cUHjS8wcKrs320uyZQTcHrj2ZRAkm8TZUlxtqk/EE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qp6hL2vzkBW9A+Ejh5TgvnFwNfr5cJQChn9ZcLXDoISL2pleLBjSCUVNTaH3g8vgI
	 GJVAJzkS0oUhNfLJ25P2TgR5NOkPLo4Sz4Wv12uLUQ1+guLLszeQcJt77dktTz4usv
	 8HlxYQTrfUlmWh2Wz33RfE6sOf39K0jkRVpLAGbm3zmLjkrsxcU4MDj4O0JbICPaI0
	 dAjX941NqfxX3kzrGCKRmJ0VTqoF6+2QMu5Mogg+W3T/yWskcbYKXjumLMNXhmiZ5F
	 ya6qNHFmbW0xy/+FDKExuGgBTRQEKKTHM3DM6NrwwKRAhDu0yDhyVtt8fEa8U/NElV
	 Rb1ntn3LDhRrA==
Date: Wed, 12 Feb 2025 10:48:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
Message-ID: <20250212104845.2396abcf@kernel.org>
In-Reply-To: <dbdcff01-3c46-47f2-b2db-54f16facc7db@gmail.com>
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
	<20250211003203.81463-1-kuniyu@amazon.com>
	<dbdcff01-3c46-47f2-b2db-54f16facc7db@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 19:54:16 +0530 Purva Yeshi wrote:
> > The 5 lines of the 3 sentences above have trailing double spaces.
> > You may want to configure your editor to highlight them.
> > 
> > e.g. for emacs
> > 
> > (setq-default show-trailing-whitespace t)  
> 
> Thank you for pointing that out. I will ensure to check for such
> issues before submitting future patches.

To be clear - please fix this and repost this patch

