Return-Path: <netdev+bounces-242613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A173C92E81
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E543A9750
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8517334371;
	Fri, 28 Nov 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVH83LPJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96A285C98;
	Fri, 28 Nov 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764354279; cv=none; b=TtKUu8lzXfDyss5MExfrMm8+oCePP+koAsaEYgxzr0YShwzrVdwvMC+jeFTnaX8L4Yt/Fd+yp62Vo+jfDXYmwt9ecydPSZf2sTWZirRFjGcKbodz/aDQG0bMbPNVW693lcWLNCMgljjZZqt0jD2pMWz+ERyABqgDaYx+Ea6QFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764354279; c=relaxed/simple;
	bh=csOAuQjqPwtupHuMiDQshiKp9MzSDrOVqgMXNAU9tNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1PyKrfpJX3dna7FK4NFuNhDq4RgPFFyIGejRzDGS3RqUQLyfaI0jQfjOeKz7ceqMT28F6Y0OkUkHG6El1bBvLEOvDkQWstAKQzlCddXpOs0vq74CMhYwYWB0cBn2B7AEFuiaGs/X59gaqv+pQ0DmwGxtlR3KYiOZKHozGeyJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVH83LPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA4C4CEF1;
	Fri, 28 Nov 2025 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764354279;
	bh=csOAuQjqPwtupHuMiDQshiKp9MzSDrOVqgMXNAU9tNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JVH83LPJHN44T8O/zzp46qEcRGuTNGhz362mWTErzxaC5q51+SA5bJ2MH3vIZD1/c
	 cd3WsRTGhNngcJOjnKmBki02YhzpstOjc/d2wkFW+Decx8aiZm1LAzWQUT+DhvqdVY
	 Ydlutf2i2u7MM31YtBNyy3nTnyhkgdM0pvJIW2i7fmZvwAzmdHqOBcEsF0sxKrMd+C
	 0XiFwNr8WVMNw+fUQOyEXt47Ha3m6FYM2ggMcBMChPl712w+BsKhhxZr7SzZr5o+bd
	 c1hNBWG8COzS3XaIB+wViDWQ+pOZVDvChfUkBMgO00ZyrVKq5S4tbT5poopCfiY16M
	 CbzG6hwuhUO6g==
Date: Fri, 28 Nov 2025 10:24:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Richard Cochran <richardcochran@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
Message-ID: <20251128102437.7657f88f@kernel.org>
In-Reply-To: <f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
	<20251030121314.56729-2-guwen@linux.alibaba.com>
	<20251031165820.70353b68@kernel.org>
	<8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
	<20251105162429.37127978@kernel.org>
	<34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
	<20251127083610.6b66a728@kernel.org>
	<f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 14:22:21 +0800 Wen Gu wrote:
> > Could you go complain to clock people? Or virtualization people?  
> 
> I understand that the PTP implementations in drivers/ptp aren't closely
> related to networking though drivers/ptp is included in NETWORKING DRIVERS
> in the MAINTAINER file.
> 
> I noticed that drivers/ptp/* is also inclued in PTP HARDWARE CLOCK SUPPORT.
> This attribution seems more about 'clock'.
> 
> Hi @Richard Cochran, could you please review this? Thanks! :)

It's Thanksgiving weekend in the US, Richard may be AFK so excuse my
speaking for him, but he mentioned in the past that he is also not
interested in becoming a maintainer for general clocks, unrelated 
to PTP.

Search the mailing list, there are at least 3 drivers like yours being
proposed. Maybe you can get together with also the KVM and VMclock
authors and form a new subsystem?

