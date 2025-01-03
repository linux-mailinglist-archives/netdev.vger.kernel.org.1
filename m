Return-Path: <netdev+bounces-154858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537E5A00221
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15637A1A73
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 00:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBBA4315A;
	Fri,  3 Jan 2025 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnzCuyzm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1B2A1B2
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735865235; cv=none; b=hIvSUnydSQ4RTzDr5ZdjssBz4BcWgtKB7009dySONBZidMFvD7bH+IzbX1Mdda/xdfys3bN1l71Eo/Rnrxpxkg3GV44Y4t+oWMx7QT7Neg/UYL0BuFUBxnoabDRvxspB7WTaxBPU5zOxB+n9MCZmdA0sQnitoFVkrOmn7gdqoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735865235; c=relaxed/simple;
	bh=UX4FeqvCro/KHO4kAxTQyUcuKdYuR8GFxEUecfIwdvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It35+cs66tY7zIcgQ77Wh/Rrhtybgm1FlzNPCt3KffkSwezMKSVfXqgm4FH1U8AXqOV8r8svnp6XUsTmYNPX35X0qEYSgB2gLjxt4iFkOXlr8ehMzlV/9YbxhRowRu7dz1BqY2hb83JMvphYWI65ogCkrW6aHhBqK9y7WBKUYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnzCuyzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CD7C4CED0;
	Fri,  3 Jan 2025 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735865235;
	bh=UX4FeqvCro/KHO4kAxTQyUcuKdYuR8GFxEUecfIwdvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lnzCuyzmRvMm2FFhalMSSITHBR6E+Ryni8VIy8TYEoIlS5d4vYItb/gf3QsKGfmNe
	 6Fuc2/lR1m0F9sZ3JXkkb4yCAUBhnaFMhHhBv1c/Tj9nq1gcHiZpGLvmX1DsbB6Tmq
	 e9/HjdWsvvk9JNyJz48bY70VFuJNEWgSIFErj6FpsBvOOa4WwdZkXq0RwGGYdJINdL
	 2vFhQc8fQ/K1mlBNT1HqZptGdy6TL3D2g+QG4Cgf6+1g0XlcuOLcBjJ0TYnVw35Wai
	 iGLKVdAJNpxjPMC1xqsbKMwplOAozTvPUGusbx5GcOysduHLADsdfr0WAtpJzqWhAu
	 4+eZfzd7+gxsQ==
Date: Thu, 2 Jan 2025 16:47:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Add support to do threaded napi busy poll
Message-ID: <20250102164714.0d849aaf@kernel.org>
In-Reply-To: <20250102191227.2084046-1-skhawaja@google.com>
References: <20250102191227.2084046-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jan 2025 19:12:24 +0000 Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busypolling.
> 
> This is used for doing continuous polling of napi to fetch descriptors from
> backing RX/TX queues for low latency applications. Allow enabling of threaded
> busypoll using netlink so this can be enabled on a set of dedicated napis for
> low latency applications.

This is lacking clear justification and experimental results
vs doing the same thing from user space.

I'd also appreciate if Google could share the experience and results
of using basic threaded NAPI _in production_.
-- 
pw-bot: cr

