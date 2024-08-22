Return-Path: <netdev+bounces-121080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10395B943
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B6B1F22198
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921C41CB13F;
	Thu, 22 Aug 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc8pbmem"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B013B29B;
	Thu, 22 Aug 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339109; cv=none; b=gASsiQxoJ64t1IUS2MaAQ3iP3qHkiXbvntWGfzho/MADTaf9EmCIgev9wvYCJex6xIHcMCUnYkAmQSyNaE5wa7NTQukKqrnEppKC7dmAKqQLXV5urgjS9Xc5XPy11Rt6ue21JIwuagMPQClbg87TaTCwMmHuO3fDZoxgBg458qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339109; c=relaxed/simple;
	bh=hD8e4H3JznJv0TT4KF0hqzeIpemBNlZ6QGmsJ2lE89M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpoY8Ra0+TDBn85tYla85HTI9S1d0bjX0Y315nDNCW1u3n1LwSUW7yPfYSBwsr2dCwfRXpNp07RHCBshNKhZaIourdQckPCWgevkqJSybFZ8/0eMf5BgNHTtVCoLdaYhLKIqmd8eMX/yjWZp0Zxwp3w1bgeKGQ3BA7jR8Hc7qBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc8pbmem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83146C32782;
	Thu, 22 Aug 2024 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724339108;
	bh=hD8e4H3JznJv0TT4KF0hqzeIpemBNlZ6QGmsJ2lE89M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cc8pbmemqLA9k9UK7u5YfdomCqF5iWqXHZgaonSRk7S8UAaC5i6/1hL2Wo8EJI5aQ
	 ETND/E57AA4xHaSS8TkK7rUsJi+XLm6QuiIKGeRMacCpMgYMubjrEhulABuyXbPZVh
	 JJEh5w1fz6TfrmSWsk/l+NecOFdenydds83xzqzziL8h8svQDLjbfLy4pKoeNT2C/U
	 uqfv8g6NYiO8Kbr9QnZLtC51U3kQ4HEav9bbfl6LIQzXllOC/GGSG6tAm7P/YyAUwj
	 JkfyPIJ4OQN2DHeyTAw+0UNYsaXk5z2BEsZJdw2NC7SrCRXQKqvgvFy0pRtCcSU3vU
	 7sFfvo8tUq2/g==
Date: Thu, 22 Aug 2024 08:05:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jinjie Ruan
 <ruanjinjie@huawei.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] net: dsa: Simplify with scoped for each OF child
 loop
Message-ID: <20240822080507.6c7fe63c@kernel.org>
In-Reply-To: <d44d2e53-6684-4fe5-bcc3-60d387044b63@kernel.org>
References: <20240820065804.560603-1-ruanjinjie@huawei.com>
	<20240821171817.3b935a9d@kernel.org>
	<2d67e112-75a0-3111-3f3a-91e6a982652f@huawei.com>
	<d44d2e53-6684-4fe5-bcc3-60d387044b63@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 16:39:38 +0200 Krzysztof Kozlowski wrote:
> Jakub,
> Scoped uses in-place variable declarations, thus earlier jumps over it
> are not allowed. The code I was converting did not have such jumps, so
> was fine. Not sure if this is the case here, because Jinjie Ruan should
> have checked it and explained that it is safe.

I see, thank you!

Jinjie Ruan please repost crediting Krzysztof more.

