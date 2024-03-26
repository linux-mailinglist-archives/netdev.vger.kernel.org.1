Return-Path: <netdev+bounces-81872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F2688B762
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E561F3FB86
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891775A0EA;
	Tue, 26 Mar 2024 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWE8Fx2/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A657314;
	Tue, 26 Mar 2024 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419790; cv=none; b=cBmgjCPXfXhJmtJgtMxg/poiX7IpauhZAAw3Rfg0ujl+ZykcPmZp6z9mxAokrsNboS2yzQNLx7Ue1ZaoLjxSbvYT8H+STiiUlE5oUNX2QzzS9HCpPASTRImRYjiN3fOIeilO80kiDWUgxEctg/+kpuGe0vyp9+qBQ+YkEJVJI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419790; c=relaxed/simple;
	bh=rLJrlM4Vj3ruWzRskldOfk/gPLlOLe1L+G1vTxKZdrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3M7ctdev7t+hC63uG1h9z/ADaJlhpvTnLrKZM9v/HgPNdhLtG+y8+B1zVEpjIIBNnMI1Xg70IzUatnY/WORoX6L9RX0WRSlkKG3Y7ch6YkQQ3qREz+d0vg+lfysAOOQM0SAbQGVYaI+E5dCVA1rpcxBi9E1tCYG1rRDmWm9gFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWE8Fx2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524B6C433C7;
	Tue, 26 Mar 2024 02:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711419789;
	bh=rLJrlM4Vj3ruWzRskldOfk/gPLlOLe1L+G1vTxKZdrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QWE8Fx2/scMC3CnONx0ZLGfWc2rbLmoseGGGizauI3ApPd01Jj4jgRM8tmF+2vIcB
	 6t5PzG0hTfn3xh5ZMJDDoSUqrc5ptRHccEh7yXXtmUFnsAybVK533aEmJ7zYjzxTgF
	 FM/q2FMWabtNTrdN6Znu4TU2btX1KWbjSXcjsOnGNY5QUc9fCfheMMbXIIZJXLA01r
	 50b/gf6myFShjss80DVQtEo9uZ7EiKygAe9f3e+M2isMdyKIXNlm1UczA9miPPMXUc
	 3lrX7O9fgu81y4HJfmAlo2G8ZkIXpUVXBeizfZxsnZdHQnlVLHfTOD+pzKOaQnqj66
	 4Uc7RYyiHDcng==
Date: Mon, 25 Mar 2024 19:23:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, rostedt@goodmis.org, pabeni@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 0/3] tcp: make trace of reset logic complete
Message-ID: <20240325192308.22e6924c@kernel.org>
In-Reply-To: <CAL+tcoAXCagwnNNwcP95JcW3Wx-5Zzu87+YFOaaecH5XMS6sMQ@mail.gmail.com>
References: <20240325062831.48675-1-kerneljasonxing@gmail.com>
	<20240325183033.79107f1d@kernel.org>
	<CAL+tcoAXCagwnNNwcP95JcW3Wx-5Zzu87+YFOaaecH5XMS6sMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 10:13:55 +0800 Jason Xing wrote:
> Yesterday, I posted two series to do two kinds of things. They are not
> the same. Maybe you get me wrong :S

Ah, my bad, sorry about that. I see that they are different now.
One is v1 the other v2, both targeting tcp tracing... Easy to miss
in the post merge window rush :(

