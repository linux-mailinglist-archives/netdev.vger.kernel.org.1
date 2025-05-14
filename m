Return-Path: <netdev+bounces-190540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CDEAB7700
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7473AAA9F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F95B20FA81;
	Wed, 14 May 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngbg75ky"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8011F76A8
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254392; cv=none; b=k0ENUF8q7Mpf/Hv9xFHDbczqPQwKUtucz+GTy8tS7MXXA+4eW3HQ8cyQ+Jo/15rQFA1VY0rYmjK2VeCN8KtlMRLxBIjJ4bHo3uTkc/wigSMmAOJDoQYD51LWpJY/Oov/WfNtmBmvU2ozPThyqbpA3yHl04msGkIGN/OQkWYvRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254392; c=relaxed/simple;
	bh=DmWHjz6rANoZleFeJLIqpTlR/Je0gc31Akf39y7ov6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFR1L1Ts9KRM7eurqZNdjtbOb4dvK8vzOV1DkpiC7DP++JKXhRW2r75gtE76UTtTyZfFUZjkSezerT+ufwT2Z8NBYgLdiegDkxBo//Tl3CXzO7HABWV6ebJBXUs9nrzYK3D3q/4DNLprqkLOaSWFlfwmh1Iw4RG+NFUgQA8dJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngbg75ky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E3BC4CEE3;
	Wed, 14 May 2025 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747254392;
	bh=DmWHjz6rANoZleFeJLIqpTlR/Je0gc31Akf39y7ov6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngbg75kyfPlntu70m50b/cghTeYlZi1Dfmf+W4iceLbBnD3rV9gtdg61SgweHEycN
	 2WUnJt1Yv/VrSDzavq3EjKiMGvg0y1+MAqepDzISn7sUPpEA1ef1xbMp/zNPHUzI04
	 i5Bi5P+filbYyY0cQUgPLtLcl8hXZrFFdGdDpauEr+yB5qBRVUq05cFWHtntYLlQAi
	 9SXpqyRutipr0OEH9cTeIChYcuWctaT/lIoP4kE7waW/e90Cj9A/mFDENXwybGHi7Z
	 eDWdwwL3oB49/93IuOYlLH/Hx2Na2NoTPzSrF1H0TND4LKYgfOqWFy0/rqKTibpCo5
	 NcgGY4EsHeXHw==
Date: Wed, 14 May 2025 13:26:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Rick Jones
 <jonesrick@google.com>, Wei Wang <weiwan@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 00/11] tcp: receive side improvements
Message-ID: <20250514132630.004218a3@kernel.org>
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
References: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 19:39:08 +0000 Eric Dumazet wrote:
> Before:
>  73593 Mbit.
> 
> After:
>  122514 Mbit.

Very exciting, obviously :)

I hid it from patchwork temporarily until we figure out 
the BPF selftest issue.

