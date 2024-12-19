Return-Path: <netdev+bounces-153398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0879F7D79
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A104616223C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D742322576E;
	Thu, 19 Dec 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUWOEHqu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0622540A
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620394; cv=none; b=QTGnJqUN/V2kzqrZhTdM4b3nqQRMjwWhp6MbhJVQpD0suFIZCTa4R7vzi0qM21rW7rcIrwCLwkRyFruqCfnZoSxqC7fapum6BSzcYOWs6kaCsHxjnvZqB3dhgOUlwpElCQEy2Nk9J53sY1++c2zXAYSv6Kc6WRBIfn+vCIa6kD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620394; c=relaxed/simple;
	bh=78lelRYgUnyfQgdhg67b6jOoAH6Eo0jdvNLmkOzCREQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODxA2LzVqa9f/u+yvJJf/Q25m2C9VyEzvuPKJAVkrdA3qGSIQA3JOoLdkMBlB7NtuoQL52TS4jeYPdQcIDqzNyUkFc7zQzjShRWJ7XXTSZRzfbL8dm83vkimIJKgFCBwIqD/PrjmfRkPDVzQkBs9PXZxXNFNXS1hmY3vH58ErLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUWOEHqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4BFC4CED0;
	Thu, 19 Dec 2024 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734620394;
	bh=78lelRYgUnyfQgdhg67b6jOoAH6Eo0jdvNLmkOzCREQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sUWOEHquI0jWbFspZ6hqOu4zW1u9Kjh0WJEJeEb/rWbo8v9pz67lT+RLqCpYkDcOP
	 NQnd1z2ycwj8p9kHMksTbJwCoJ/Bm4/5gWy7x0axXguhz9lCTLi8/jEfqGlE/PdyDf
	 AlXZNHmpD94v5dtVfBv/9e80r+9WsE18e6ylarELcjZYXCElQFwUxETBlRpj/c7P1I
	 8iUBiFFi1lZPtHpcvFQ5rNN/vOMoK8S2ktltccvtWZnoUf3o1lT81dSeaqEK/lJ2mt
	 fRiW7vfIorE1M4dgpVPBPKqmgF9V29Iv0Fk2hoqxE6YCvE5YUKZZvhQxqcE0BHziPY
	 n5ZOVLOuc4EPw==
Date: Thu, 19 Dec 2024 06:59:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next v2 5/6] bnxt_en: Skip reading PXP registers
 during ethtool -d if unsupported
Message-ID: <20241219065953.73e08f77@kernel.org>
In-Reply-To: <CACKFLimq7juLHbEs9gbuzRm7mFGvD62RsgrXdxr-fmj5e+zBbw@mail.gmail.com>
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
	<20241217182620.2454075-6-michael.chan@broadcom.com>
	<20241218191346.5c974cb5@kernel.org>
	<CACKFLimq7juLHbEs9gbuzRm7mFGvD62RsgrXdxr-fmj5e+zBbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 22:57:09 -0800 Michael Chan wrote:
> > On Tue, 17 Dec 2024 10:26:19 -0800 Michael Chan wrote:  
> > > Newer firmware does not allow reading the PXP registers during
> > > ethtool -d, so skip the firmware call in that case.  Userspace
> > > (bnxt.c) always expects the register block to be populated so
> > > zeroes will be returned instead.  
> >
> > We have both the ability to return the number of registers (regs_len),
> > and the regs->version. Are you sure you don't want to use either option
> > to let user space know the regs aren't there?  
> 
> The existing bnxt.c in userspace since 2020 always assumes that the
> beginning part always contains the PXP register block regardless of
> regs->version as long as the register length >= the length of the
> register block.  I guess we didn't anticipate that this PXP block
> would ever be changed or FW would disallow reading it.

So if you bumped the version the existing userspace wouldn't care but
then you _could_ follow up and update user space to ignore these
registers when version is 1?

It's alright, it's just debug, I got curious recently about how little
use the version field gets. I'm not sure anyone has a good idea on
what to do with it.

