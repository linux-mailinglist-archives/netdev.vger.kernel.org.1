Return-Path: <netdev+bounces-248528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711BDD0AA05
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C574D303A1A6
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559135E543;
	Fri,  9 Jan 2026 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+CtfG0W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896935E530
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968723; cv=none; b=WEFptlJxTw8iag9DlBNdOaE7el2lN5Reon8QmLHQP8ueZAL40WiCi+LlNpqPW0Wa+AOQe45ekmT/kV7ZXI4lX7dq4o+j7RLAj9Uh395GMNa3nqpIidLFbkHHaFQj8HoT0IrHLXiS9ILZmn8umDt2sjnveTBzPUQdVWT3BY3fKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968723; c=relaxed/simple;
	bh=UumQSJOV+VCq9TkjQKTGdudLmcHGaqk2UMC/BKKKT/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/hY6mP4keryHCEKPDZN9mm7COiQiui8mpE5cqftRRehn9VkVURHmqB0jj2e3vCF5mr7dQkeSyZNWjkBR1H5NkxHrFg1Qd0PRXmVsKje0bg8pL5YSbS+9diF7B0kWmYY2h6srCcYDyYVfZMeL+5Z1bW8PKuhmMHFAPt2wD7iQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+CtfG0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3106BC19421;
	Fri,  9 Jan 2026 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767968722;
	bh=UumQSJOV+VCq9TkjQKTGdudLmcHGaqk2UMC/BKKKT/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b+CtfG0WglygngMgLphN/OXFZw/wd+jI6nvSRngaql4mJ3MpjBVAdznBW99kwWzER
	 xUXsuuP6GL0XuziBw/K88vO7zFKgUKC0v4bXJqCVLmlV3EXnf0OSlJj0JwnS28BDYP
	 fM6l4Z/Xg9Ted0xNnTz61EBPy4lBPYKBerhpjrJS4guDqszNbbQApU4iznUq58ob2f
	 ZUBpts5momqiGKY7zqfVWPs1RSBGFcd8lZ/FTJasmuzk2i3DRBAoIj4u9qQ3VcFdSe
	 Mb2YQ5Tc3JkTOtsKkS0T2cN2XaKqOQlr+vXP36zhaev3tzcnqWAlqxHXGC0BCy9YMF
	 6SvN7unGlGR4g==
Date: Fri, 9 Jan 2026 06:25:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
 Vishal Badole <Vishal.Badole@amd.com>
Subject: Re: [PATCH net-next] xgbe: Use netlink extack to report errors to
 ethtool
Message-ID: <20260109062521.625088cc@kernel.org>
In-Reply-To: <20260109074746.3350059-1-Raju.Rangoju@amd.com>
References: <20260109074746.3350059-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 13:17:46 +0530 Raju Rangoju wrote:
>  	if (ringparam->rx_mini_pending || ringparam->rx_jumbo_pending) {
> -		netdev_err(netdev, "unsupported ring parameter\n");
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "unsupported ring parameter\n");
>  		return -EINVAL;
>  	}

There should be no \n at the end of the extack string.
Please don't use _FMT if there's no formatting going on.
-- 
pw-bot: cr

