Return-Path: <netdev+bounces-70404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B284EE97
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 02:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495221F25A7B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 01:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99C393;
	Fri,  9 Feb 2024 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddto3vTX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD741366
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707442178; cv=none; b=Qw8HXhLS7Z8p/I422i37DG9WApybHv1Lg/qJiQzYwtgtFYVw7HHOVsnLo8dNyuPSMA7+hOwzeB2RvshfBv2REdAmH+GEVuxtcFwCUwtVi8HmRdcVVTLQePnyt/o7r07ikPXpZm/eQDvsBqh1d4wO/7MSXOfiyGVOvmwXfPfvT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707442178; c=relaxed/simple;
	bh=E1uHWYZxIg0dq3ErzWq9VNZOaOaXafENLMr/irQAI80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlEHLUpFAPWvcD0kB5EERkptMzfYkVkxgcS4b51pXgTPUNOub6HX0wBRrv0d1lXqTwH6wVifhtoZG5cQwF5ARO3sIyLkYLlA5HtEDbe9djVRL3ZEU/6kN5hlHd80qqAohqN/XaFyHE5ZR8E2Td+GWGKnHy88+PWw68NubMrDtEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddto3vTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658D2C433F1;
	Fri,  9 Feb 2024 01:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707442178;
	bh=E1uHWYZxIg0dq3ErzWq9VNZOaOaXafENLMr/irQAI80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ddto3vTXSSB+rZlBv7tzUkADabTfNNDSfa0uiifC6PpU4GJ/mVowYeMD7wUNCouf1
	 E3rOUrPRUFnPbISIlZECLkdQwsQlZMklP5UND7vgEPNkKuT2crvvp3CqZDNEaI8t77
	 MvBAdLMxlafaXFGfPDGVVL2bZGORYCMcm2GnhUzjnV21oJZQVtUgh0PCHQH3WxZtBl
	 RaIr7Js9y6ZsAOaoryWNgaYcTtksjHI57JJdEsl/Jlra0PysyjDEFhenkGryxQFIeS
	 DbJLDW7pEFDyLm8P3Dq+tST5l/IkxCZwgsLr/HSDVi4QTPJtb1ywRrE+QsqOURt4Uq
	 wyO1b3ZHA/5ug==
Date: Thu, 8 Feb 2024 17:29:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, aelior@marvell.com, davem@davemloft.net,
 manishc@marvell.com, pabeni@redhat.com, skalluru@marvell.com,
 simon.horman@corigine.com, edumazet@google.com, VENKATA.SAI.DUGGI@ibm.com,
 drc@linux.vnet.ibm.com, abdhalee@in.ibm.com
Subject: Re: [PATCH v8 1/2] net/bnx2x: Prevent access to a freed page in
 page_pool
Message-ID: <20240208172936.7a8b7fb8@kernel.org>
In-Reply-To: <056b4e86-a894-4a4b-a8dd-81f440118106@linux.vnet.ibm.com>
References: <cover.1707414045.git.thinhtr@linux.vnet.ibm.com>
	<90238577e00a7a996767b84769b5e03ef840b13a.1707414045.git.thinhtr@linux.vnet.ibm.com>
	<056b4e86-a894-4a4b-a8dd-81f440118106@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 13:18:14 -0600 Thinh Tran wrote:
> Fixes: 4cace675d687 ("bnx2x: Alloc 4k fragment for each rx ring buffer 
> element")

The Fixes tag should be on one line, without wrapping.
Please post a v9 with the tag included, as a new thread.
Don't use --in-reply-to on netdev (sorry for so many rules..)

