Return-Path: <netdev+bounces-153214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAC59F7343
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8C516B475
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315314659A;
	Thu, 19 Dec 2024 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3v3cOID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16049145A03
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734578028; cv=none; b=pSzMeWahvjfNyOVMNRN/vF6yEIlawEDtdvIsun6N09ZDWx9PW8aoFdb9zBDyYw1TCf9fJ761AJrBcN5ahpN+BVr+B5v4dc+sF1GBaeTz1xS3o6QBxvop3bkPFHEx3+NhS607WwAIzRax0hvgKbSvg0lAdl6mABM7teY3wr75GDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734578028; c=relaxed/simple;
	bh=FfaDlDTJqnU5Cq8U4WKvpTU2NQamWT3EVhq2p6v6UFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUm/mLzL0lgWjJrAlMNa14ydaVx9Hej7yZBPdlNaIO74Qrsx81WE4PHFdi4HZOWWp734PB53mqOjfgcf8fP6kCl9fV0yJtW7cMrk1sD8ktF1rAKGymnd7q3GxL5iNtuEaDs5yipSsJiNr7+gTofdf8WrGUdlJbV642ViPXQoIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3v3cOID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3ADC4CECD;
	Thu, 19 Dec 2024 03:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734578027;
	bh=FfaDlDTJqnU5Cq8U4WKvpTU2NQamWT3EVhq2p6v6UFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t3v3cOIDuWvLsZlgbv0uDeqWUXmk0aiM/yjglGwXrp++wdvwoBurqkIftIHqDMLL6
	 rxj6y6R7vSriWAxFbykOG5caAh5IEtdYkor/ghp4Q/T8ANpQBwoxxl4VkOks1kGY9g
	 +FcjvkROv8e8fHBm8mm8Zd+2EggMnp5nYtTbcA809ZSk2g8tc0bGOPwjzWuN52TnUl
	 sfIIABu5Dl6mSyr5BWff//laKtT6FtjD06ATr9BWtIlpy+dg7GStZdpBghtxbkzDKh
	 guLTW3CQm+rB0r5MBZGxl8Aivb9hnvw4V2PfjXdZVVQuU5+r3hD29vdNMcORUmfLxI
	 /g9w31zolPYKw==
Date: Wed, 18 Dec 2024 19:13:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next v2 5/6] bnxt_en: Skip reading PXP registers
 during ethtool -d if unsupported
Message-ID: <20241218191346.5c974cb5@kernel.org>
In-Reply-To: <20241217182620.2454075-6-michael.chan@broadcom.com>
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
	<20241217182620.2454075-6-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 10:26:19 -0800 Michael Chan wrote:
> Newer firmware does not allow reading the PXP registers during
> ethtool -d, so skip the firmware call in that case.  Userspace
> (bnxt.c) always expects the register block to be populated so
> zeroes will be returned instead.

We have both the ability to return the number of registers (regs_len),
and the regs->version. Are you sure you don't want to use either option
to let user space know the regs aren't there?

