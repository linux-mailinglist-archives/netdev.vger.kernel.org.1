Return-Path: <netdev+bounces-224223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36270B82756
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA414721DCD
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF34D1917ED;
	Thu, 18 Sep 2025 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkWA9EoR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942538B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758157405; cv=none; b=EYzJywixJQp5GL47YyqZj2fKjqs8A6TdnDHGIblvb1HDetdaUU54xkV90gazrnnRUDfPayTkNXvfKee9L7wJyuK1KwtKjrslhRUoQXP90IuSHZgGR9n8R8X9IHPy1bMQURrjU2Kyt9pGs/TSpgaAhsPOoQkBHNWS9cnS5mu5NGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758157405; c=relaxed/simple;
	bh=9DRdLQgHV7FeZQubiPzd5qz/fROsolBm3SHhYXKUaEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQb10AYfD8eJcJuMG6l4P5XS8az0uGX6gyTrfJKAuxQY7go7i8NnZSKBcKfy5UfR/qrD5EBbp0bZfM3ekAUY0IsiSsttrEfsGpSlPRRKIs+8MuYimP6fn8vrzUuE0TvcxPY1Pg9OVL8NS4eiOlP0jwv5/H4mci6n4QdOKpE00uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkWA9EoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0511C4CEE7;
	Thu, 18 Sep 2025 01:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758157405;
	bh=9DRdLQgHV7FeZQubiPzd5qz/fROsolBm3SHhYXKUaEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SkWA9EoREcHxpq6kjCbXJkQdjx3Hkjcz6wxVLcVGkf6WvcFA/p0HY5bIXzhSFYNLR
	 JKNIMi+2Ul5tLyPI3hGqz8AW2TDJJWeeCDm3Nhzks0/ZGu7irJRFk9iV4/rONDBeux
	 ansQRE6iXql/r+E4Yy3DJhEZ3in3OyBLGts/geckTTs1LrHDk+mGHCiDS1/kE2WeqF
	 vY1CAQcpeWspBQZLVRPuL28Mny9QK/NUWBxXYvtAb4UXPd6/DHX4rnEbBSOApq1d+R
	 8nD9vQ3W/bfQeu2R8ProQq7rfYsBAVQ3jVHWFZSMaOKZMusx9KiL4bof30l7egtAwN
	 hDXWn/B/kvEig==
Date: Wed, 17 Sep 2025 18:03:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 00/10] udp: increase RX performance under
 stress
Message-ID: <20250917180323.19203388@kernel.org>
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 16:09:41 +0000 Eric Dumazet wrote:
> This series is the result of careful analysis of UDP stack,
> to optimize the receive side, especially when under one or several
> UDP sockets are receiving a DDOS attack.
> 
> I have measured a 47 % increase of throughput when using
> IPv6 UDP packets with 120 bytes of payload, under DDOS.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

