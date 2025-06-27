Return-Path: <netdev+bounces-202092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEFFAEC35A
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 01:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A003BF4E7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04872290DBB;
	Fri, 27 Jun 2025 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrCbdU8W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAD39855
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751068783; cv=none; b=QwQ+Ylx7FtoAeFWdrVhG5+eh1SP3c4lcs48Nfph6H2uOJZ2TqaisHcYjQAp0GNimRSzvfO22JUqCzGVbRd1KigeCXrHFKmhwhpU/Cvi6lJ7IR7g8qGwazyfR0HgfORwjxYP5K0f1UHpYgFF97mVS2HSIh89DmTDjLH41HrDOcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751068783; c=relaxed/simple;
	bh=QtmK0i+OKTdGI3GvhhCSxurmlToLaHtIE1Y2Nulq//k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOOk/5pR3eA+oekjS7+B9nbDoe2CLIpc0wqFJmOoBjsJdkNUNKc+pkI/syZQSZ5HOZ8jKcGpTV8t7IBVmfEMY6CZ8ayoP3udRDPMNCvdVtsJa36vbUS+s3/z6N49zNMBAyw4U523ZUstTHszz5JHfIhwCOqrCugbWO/jRNrbLJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrCbdU8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADC2C4CEE3;
	Fri, 27 Jun 2025 23:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751068783;
	bh=QtmK0i+OKTdGI3GvhhCSxurmlToLaHtIE1Y2Nulq//k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mrCbdU8WLf8nwn42Ol85DpV5etbXUMjwv+iXuvMxv+2xBLlNc17rfL4yXgO4WvLuL
	 LoSparAH8uQvdm7gV8PpU2rFuNd3kJE26Xru4+ODxDMeYgsvWlOzfUJZhUUci7JE9k
	 6K1YoeJvfZWLfL8jOLdOHROCThR2O2e9/cSnqr33ALO4ZwAjen833sBahi8evnuPlQ
	 Z6+VYodomFzmCKA8TSmvoNIFKbor/TtcNnD7/jSYK703WyAkFZ/a63PZe6yM/Ue+lm
	 eJ6x8XTPoYbnIWonpvALSxNLciJwJv2rTViIESUEqA4VavzdORFZOjtsBLor+OAyDU
	 xbWddGjOVJqbA==
Date: Fri, 27 Jun 2025 16:59:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <hkelam@marvell.com>, <bbhushan2@marvell.com>, <netdev@vger.kernel.org>,
 Suman Ghosh <sumang@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Check for DMAC extraction before
 setting VF DMAC
Message-ID: <20250627165942.1f70a6da@kernel.org>
In-Reply-To: <1750851002-19418-1-git-send-email-sbhatta@marvell.com>
References: <1750851002-19418-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 17:00:02 +0530 Subbaraya Sundeep wrote:
> +	/* Check if NPC_DMAC feature is set in NPC. If not set then
> +	 * return from the function.
> +	 */
> +	mutex_lock(&pf->mbox.lock);
> +	req = otx2_mbox_alloc_msg_npc_get_field_status(&pf->mbox);
> +	if (!req) {
> +		mutex_unlock(&pf->mbox.lock);
> +		return -ENOMEM;
> +	}
> +
> +	req->field = NPC_DMAC;
> +	ret = otx2_sync_mbox_msg(&pf->mbox);
> +	if (ret) {
> +		mutex_unlock(&pf->mbox.lock);
> +		return ret;
> +	}
> +
> +	rsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
> +	       (&pf->mbox.mbox, 0, &req->hdr);

This is too ugly. Cast it to a void pointer to avoid the super long
line.

> +	if (IS_ERR(rsp)) {
> +		mutex_unlock(&pf->mbox.lock);
> +		return PTR_ERR(rsp);
> +	}
> +
> +	mutex_unlock(&pf->mbox.lock);
> +
> +	if (!rsp->enable)
> +		return 0;

Please send as a fix, and factor this out to a helper.
-- 
pw-bot: cr

