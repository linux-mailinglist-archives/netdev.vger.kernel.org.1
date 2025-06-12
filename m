Return-Path: <netdev+bounces-197034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E42AD767E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99AE189664B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB6298CDD;
	Thu, 12 Jun 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgmPRL1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F0298CC7;
	Thu, 12 Jun 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742391; cv=none; b=QZb6+wDTXTnlNidwAKDCtQPB9jo8WkSbE97rJsqZBGckD8frwWGf2Gm7n+glCji5A9DQTwJgcE4+gsHRnThdd/IKN+akqrUPyMxyEuN74NW56HvJRS9Vn1p1zvp/rwRuzMSwcnftSgglfcdTaHffbuUId67ZdXlibwLF+icPI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742391; c=relaxed/simple;
	bh=G5zzOUC3sJWmNEzmJf+R0AbhG6YXRm+OEvsMcVDdwEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr9+TEBKGhZ68YbG25R8BxcqtmrUVLct/Ib+qG/EfLQMgD5XyKIa2fUH7DDpH1ahU4rU7ZEBBVCQfW6HKXe0AqGZlIkfMAKHixAgctaRFWCBD/oTHaBtFaV2N7PN5+u2B8OZ1W0t0Hx6/hDuOk8PT6gFrtDuMb+mmIbVaC+vcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgmPRL1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD55C4CEEA;
	Thu, 12 Jun 2025 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749742391;
	bh=G5zzOUC3sJWmNEzmJf+R0AbhG6YXRm+OEvsMcVDdwEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fgmPRL1aZRnyCUkbREqrMNF6B3UZ1LJhoB01DRegITWBseKlTLmc3kvza3cXFRX1u
	 cVU6AEyzUDss62q6KEaSNR6BabqvSk7mWCqX55O5RDFrmjCtZ7U14Ymkff6kfmDh2b
	 8BfgpGHkSVwUyOhLiVRanQWUGJC3eGIgHpwyV97BzPk5qgy15/zB+9NaBaP9Lp+/im
	 nS6hX1nBaq4YaqBSyhRoFbbe5/0ghpShFfmy6SP5BeYRrR8WnGzgx9y7JB/FzO2wl0
	 VNXbqDOmsVfAzYnY22Y58DCeoRNcleMrgkDqYpTTo2T2DV3Hj06O4GyxpdkPLKYmfi
	 6wdpwvH6/LsOg==
Date: Thu, 12 Jun 2025 08:33:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Jian
 Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Hao Lan <lanhao@huawei.com>, Guangwei Zhang
 <zhangwangwei6@huawei.com>, Netdev <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH] hns3: work around stack size warning
Message-ID: <20250612083309.7402a42e@kernel.org>
In-Reply-To: <34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
References: <20250610092113.2639248-1-arnd@kernel.org>
	<41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
	<a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
	<34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 21:09:40 +0800 Jijie Shao wrote:
> seq_file is good. But the change is quite big.
> I need to discuss it internally, and it may not be completed so quickly.
> I will also need consider the maintainer's suggestion.

Please work on the seq_file conversion, given that the merge window
just closed you have around 6 weeks to get it done, so hopefully plenty
of time.

