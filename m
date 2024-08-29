Return-Path: <netdev+bounces-123337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A3D9648FC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6111F219E7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8353E1AE05A;
	Thu, 29 Aug 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M86qWT5C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A57718DF87;
	Thu, 29 Aug 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942915; cv=none; b=uxPq8OMfg1yasygZ35l26eT/WNXRT+jXcxLU5lpARODOjqIRbvYB8TDFuGMbWOUYb498mAEquk+zvfRRhjwkuDL0886NDnZ408zRDEAbDFO/IerMwjUZYgHNZ+zKAEsNXahiZnrWHyqVasq72+ytNb2Eh4EKeQ/O29qkSIFAD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942915; c=relaxed/simple;
	bh=9aoqy5nccnXyBftXLjR/AnO5Xsl3KEbrHNT6ttsg0gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOtil7tb0C4AoZic26B2YSj8WHwVI9NcadmZ6oxpYYNxXcEkO0ootTYTyfhBsd3KUbmE+haFgeJTYC5hk3PZuMuT19Dgy0aNQFde0l/HqTU+EJ52nAyztjRo6nbVXOm7TCAh4fIxRks3nur41pFBmEb0OELQ1IfCx44svZQRhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M86qWT5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D36FC4CEC1;
	Thu, 29 Aug 2024 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724942914;
	bh=9aoqy5nccnXyBftXLjR/AnO5Xsl3KEbrHNT6ttsg0gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M86qWT5CDR7KCl6DGLbfzkSlyurf3CPdJDx59XKp3TcH46OSOaNOUvr3NIYUEqBsT
	 WUna1+VHyZQ8BziQ84VqT7kSe+Q+lrpermrJqCJrK79zfDag5mmGNMf1QjGilcy+Ih
	 wxU6flgYTUCrkqMfI6gVYJ3wxnPRq/Jk01TuP/HzDhMktSY0/JB6tlxr31Ys2x7A1M
	 5gyWubVnc7r/XHopzl4Kh95MnZjJBA+rxKOeCL54nvlwbPGdAcbQ1pBXc4YiCw2YD5
	 PBuS2CMfLhpO83DuTkqMjMn79edbiMbxI2ol9PN97iCaeBzZ4D5Cjy2HCZxDPTWTXX
	 BkTCT3KW6O4/A==
Date: Thu, 29 Aug 2024 07:48:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bharat Bhushan <bharatb.linux@gmail.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com,
 lcherian@marvell.com, richardcochran@gmail.com
Subject: Re: [net-next PATCH v7 1/8] octeontx2-pf: map skb data as device
 writeable
Message-ID: <20240829074832.0f091f53@kernel.org>
In-Reply-To: <CAAeCc_=3vXvRgo1wxzHwSY6LJS-vUzeShSdJKLotYSuHBi-Vzw@mail.gmail.com>
References: <20240827133210.1418411-1-bbhushan2@marvell.com>
	<20240827133210.1418411-2-bbhushan2@marvell.com>
	<20240828182140.18e386c3@kernel.org>
	<CAAeCc_=3vXvRgo1wxzHwSY6LJS-vUzeShSdJKLotYSuHBi-Vzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 11:17:25 +0530 Bharat Bhushan wrote:
> > How did you test this prior to adding skb_unshare()?
> > Could you share some performance data with this change?  
> 
> testing using flood ping and iperf with multiple instance,

Makes sense, neither of these will detect corruption of data pages :(
IIRC iperf just ignores the data, ping doesn't retransmit.
You gotta beef up your testing...

> I do not see any drop in performance numbers

Well. What's the difference in CPU busy time of v5 vs v7?
You'll copy all TCP packets, they are (pretty much) all clones.

