Return-Path: <netdev+bounces-239773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C1C6C52E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94D1335426C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FB2144CF;
	Wed, 19 Nov 2025 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATcJlemq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E677082F
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517787; cv=none; b=q4MY8DSTS5lnYTP0eCCPNfarim4yhPb4ApZMLWVqQvn3k5ZSLjiu9+5pM1M/ZEo88NRr9lErqnjHa7t/afVXuCT9PeJvO02Gf7xfy9JuCijciOpIiTIozwbrH4ONG+6OgtcRnUnVgKhWyUeGzxWqgtnWTy5ZaluNIKNkrH25Kp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517787; c=relaxed/simple;
	bh=5nhtfB0RIOis2YnH3eagLd5TOrHHMCF1vrl4W+xmVlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgV3ZET4vHImvlrBWFtvWiv3m1WL/DhnZ+HjtVmyDg4hcdB81k9LLUwCO5HSB1QX1hzbRSN/lyP8ghIBlVPEUziTkvrNmHRu0+zE04jvEhEg6i939TOjZlASgFgZmHKCMNT/OvGfB0bqkm2aswQj6EBQKY36OsE42zU/0AN2jjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATcJlemq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0004C19422;
	Wed, 19 Nov 2025 02:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763517783;
	bh=5nhtfB0RIOis2YnH3eagLd5TOrHHMCF1vrl4W+xmVlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ATcJlemqPLzMOwn3vwMoavilqPdXCbXmBbv7Ajqu66a2D027BWK65YwICYazEr8aV
	 kxnd7DE0JounXhI1XxmRyVPNbs/AjgTlWXPgvVTpAtwCdRFwO0Vp538JY5YK/IbStf
	 TOnavGS/hyDBm3i3HysZ7Rvk5AWZCtWIHyyNZDByHuaFK1sbPwoUJwFnODbfcPR2yi
	 u6WrlZQ+qOErH2Tq0N5HVx+jYzk3Kw0fACMQNdAGlrXrdOmGu8UcStsWQo8Hsg7BJG
	 lqKTfQZQq92m/IuER2tAzY5dU4Euz3Ey40GYjyd7Aycd+wiG/OO/AoXg5Kg3X3O+X6
	 zC4mvGAftxO5Q==
Date: Tue, 18 Nov 2025 18:03:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Neal Cardwell
 <ncardwell@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] tcp: Don't reinitialise tw->tw_transparent
 in tcp_time_wait().
Message-ID: <20251118180301.4b118ea7@kernel.org>
In-Reply-To: <20251118000445.4091280-1-kuniyu@google.com>
References: <20251118000445.4091280-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 00:04:40 +0000 Kuniyuki Iwashima wrote:
> tw->tw_transparent is initialised twice in inet_twsk_alloc()
> and tcp_time_wait().
> 
> Let's remove the latter.

Coincidentally looks like inet_twsk_alloc() can be static

