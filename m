Return-Path: <netdev+bounces-156383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A349A063DB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DA83A6BF5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B294200B9C;
	Wed,  8 Jan 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpR5lS9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CD200B95
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359106; cv=none; b=WYjadLCXtrsaRbNNYLPZkXV0vdF75ny6nQINqfzTsWhUk8e33ipMGK2BNsYs+FEIzCqvDPUWE/EHziCoCjeKtpDHEjxPBXnoVqv4+LPSYLG2E1kSehN4OwNodXH+EPb8bcoPAtyZmHTnHjG2tLixsznWEXMeNM2iGAEdg8RzECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359106; c=relaxed/simple;
	bh=1TqktO2aGf1HNufMxqap1XeH6czqDwwUSKIrfA+QpLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnJ77L1R0IRO9Hjz3HDToQq3V5BSlXGXWxG8RYdGQ5j4ZVwzGqsLTXuZxuNk67khHP00Df/HLL+0f2kVeCj/LXfN2blha9FYlHjSwQc+/tZgcHlxw203ZtqCRW6tjwCqXJqKTUpoGOAuAtM53HMiuV/RXMW4WCuIfxxFsg+84DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpR5lS9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD8BC4CED3;
	Wed,  8 Jan 2025 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736359105;
	bh=1TqktO2aGf1HNufMxqap1XeH6czqDwwUSKIrfA+QpLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZpR5lS9vqMHVT5kD9CPssiPIejR723ylTJKlW2Ru21TboIoaKNQroBxR5r9FJNzLe
	 Jzd/DRhcFgEX4DY88Eq84qBoDAJlIkbUhGBtKorG58/eRpQoIft29H2pHTEqrAl2HC
	 Zafm6c+Hin/O7kKHMuR3RMmXpPSKNL2HqjTlPz8Afz85m+Oq8bPyhUpbtPK/vwDGGL
	 iKgTRLy5gTDoa9Xh0p1zA8MOFVCuQksXp6fLmPQcrElv5PjYE1s0W+f1f64aJrBCqt
	 a6/QxNCvna+qKeama/LUDMaMA8X/ZhRxA1hmj7HQ/uep88GCEcWRrJC+dLN/Pq8sKX
	 PmQpAto+C5Fvg==
Date: Wed, 8 Jan 2025 09:58:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: ast@fiberby.net
Cc: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo
 Leitner <marcelo.leitner@gmail.com>, Shuang Li <shuali@redhat.com>
Subject: Re: [PATCH net] net: sched: refine software bypass handling in
 tc_run
Message-ID: <20250108095824.605224b3@kernel.org>
In-Reply-To: <b9e81aa97ab8ca62e979b7d55c2ee398790b935b.1736176112.git.lucien.xin@gmail.com>
References: <b9e81aa97ab8ca62e979b7d55c2ee398790b935b.1736176112.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jan 2025 10:08:32 -0500 Xin Long wrote:
> This patch addresses issues with filter counting in block (tcf_block),
> particularly for software bypass scenarios, by introducing a more
> accurate mechanism using useswcnt.

@ast, please take a look?

