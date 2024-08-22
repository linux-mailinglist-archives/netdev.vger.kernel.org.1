Return-Path: <netdev+bounces-120759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0DD95A8AA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E91D1F21A6B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168F11D1319;
	Thu, 22 Aug 2024 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPzo+eSL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EBF2C9D;
	Thu, 22 Aug 2024 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285899; cv=none; b=CwzVLvqar+rvNRp67QQ14ity0t05r5A7a7mOKgd6hpbTr5Veaon445STkjsnhw1cZPXBEeWa0n6thbWwTMry+r/ANEQC+ANhC8s5dpIkZ/7iGt6CmXfi7qUtK7bkvlZPw5z1ntuzJ+/IeeywNh2t1e3sTHEfDNOhfmq7GPXp0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285899; c=relaxed/simple;
	bh=UCzzcz/7p6yhahLyZ3cfnaKtx+utRTP0yW4s5S9UUis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LilYfyLtGNE/lc1uWXnqf+TsB6VaT5+r56puHa5VNQ2Lfe2FFQoxfF5rGFWScHHoNW1e4+RvqIi+79ZUliCvuyk4i4KYeXVYBSuEcf70Y6yhHqov7EiS3Vudd8kSmdPhWWkO72JwoLFTeMxc9vPtpA/knq2GLg4xaXVU0B+t0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPzo+eSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF400C32781;
	Thu, 22 Aug 2024 00:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724285898;
	bh=UCzzcz/7p6yhahLyZ3cfnaKtx+utRTP0yW4s5S9UUis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KPzo+eSLrWXOtj4Zzygir32ZCgy8cBsSdmHEbAyHdnfMeefHSdJb3BjdxigqdOX4U
	 l55WdtRz8snUNhz1Q5mJdsAAfGaDjQOxkg0R+6j/50V2HWh7kzAcFUdv8Vw3tdQrx/
	 fTaAPDRO1KKU48gzbbH4cCe2izRO6Pt9gBb+wiseMoY0jGkD+GeIiYcpX2rxu4Njp4
	 v7gineW6cltFXpVDCMtkU7WUwWJRztHk9Ek3mXZLYs32i+57dgcjO9pNYFAVqYUJoU
	 /6bRmbhAhE1dOvphuHvRzWCmpLQs8KjNUfPb0sJHcmbt369YP6Wj7RKuyhxP1oIZSX
	 UZa/R/FqC2Tig==
Date: Wed, 21 Aug 2024 17:18:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] net: dsa:  Simplify with scoped for each OF child
 loop
Message-ID: <20240821171817.3b935a9d@kernel.org>
In-Reply-To: <20240820065804.560603-1-ruanjinjie@huawei.com>
References: <20240820065804.560603-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 14:58:04 +0800 Jinjie Ruan wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.

Could you add more info here that confirms this works with gotos?
I don't recall the details but I thought sometimes the scoped
constructs don't do well with gotos. I checked 5 random uses
of this loop and 4 of them didn't have gotos.

