Return-Path: <netdev+bounces-159489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D88A159B7
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 00:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FA518858B3
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC61A76B6;
	Fri, 17 Jan 2025 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeByrOAy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E21195811
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154842; cv=none; b=dPQ3h07IACnfcMSGUUAPHG6a5AwOhelq6dKZ12HOlooWnKayZjy8D5smAzuFlSjWXNGG5HL0hVbtS2wgvn70OemOr7940TlVBbSRoBkSROpSV0W99Ny+g7vS96Ttnv0Jbeye0N2NzgiLAsoLPF5OF5yFK9hov07q7BI46Bt7c2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154842; c=relaxed/simple;
	bh=EMmsz4Guk7K0RltZtX/TLPY7POqiLi0oydB9aoWegtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrpjLuWIPMMEs/SHM2miuW1B8cVAZ2XmyOpUohD//igOZ43hjjfCXtfAMVXrnMUv9OrrbRwneAPEZCeN6dQ5eLSOUg4+beq76ROWlWuPcK2dRbyatevRTxoMo0Py5754nPQwWmVzpgd5JFZNC8WoPYzvvwJv6l2yYAsZ3MflpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeByrOAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22138C4CEDD;
	Fri, 17 Jan 2025 23:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737154839;
	bh=EMmsz4Guk7K0RltZtX/TLPY7POqiLi0oydB9aoWegtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eeByrOAy8QVzXaLyB3aS0KO/1PCs/GW9QGMoRJQYSPhFyAop/GgvDJsGBDk3PbrfF
	 1MSohtRZz6vxUVGPo8dROir17S+G1Xfe5CuUdVc5heMWdFKCRA5AHPIrMosXbXIIPK
	 fn2nqJ8Ui+S1ilPJCN9RPxWjhlbF3x2AjWmgIClinWWYZW/DLmi1nolR43AwZGfZvh
	 kigqmVBGk3sc63iplGnLLBZ3KjheNsFesYk0bJxTJypBw7CDLxWC8n49EskjGLAAyX
	 Hh4csrcQJeWaHBS8Gwn5V6KU16rbr1rUVBOO6QeYi6xf+D3YpDncaxjr9RVCkhp8zC
	 sTaCCgHAZJPMg==
Date: Fri, 17 Jan 2025 15:00:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 eric.dumazet@gmail.com,
 syzbot+85ff1051228a04613a32@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] net: destroy dev->lock later in free_netdev()
Message-ID: <20250117150038.1f009a20@kernel.org>
In-Reply-To: <20250117224626.1427577-1-edumazet@google.com>
References: <20250117224626.1427577-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 22:46:26 +0000 Eric Dumazet wrote:
> syzbot complained that free_netdev() was calling netif_napi_del()
> after dev->lock mutex has been destroyed.
> 
> This fires a warning for CONFIG_DEBUG_MUTEXES=y builds.
> 
> Move mutex_destroy(&dev->lock) near the end of free_netdev().

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

