Return-Path: <netdev+bounces-64935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C98381C3
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 03:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE452859A4
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9155C0E;
	Tue, 23 Jan 2024 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piHdwwXP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3854BC0
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973080; cv=none; b=r1iadTHXtk28cBpMlHozkpsCjsLZyWvAbQp3zUKdQc7AlJvCr7iick6mI43S+bjtC4f824fGgvALoU0i3rOktfiD7BaBdEJFTgQtP5Y3iAtn0ibfgr6oWRD59ymh6PXy9+2iIzOCcmmGMqBOxHMzaVKyPoKjzmD8ypmhAG686lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973080; c=relaxed/simple;
	bh=KZ7cJZHbXuJgg3EWBnTddmUBSAHkssfyRhBTAU+O7cA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVFQsiYyrfVweu0m9U3Hl1UoT4ZIeZl/AcjXAlgg1/i1gpcmV//6psLzZEEA5eqg6eR5SrR6D8B2bTC0yGgGuQ1bZnHZuS0+4h1d8hJgUwCjHLURPh7iEyrA0wYtzQMPNwu20aWiRwso2Vs5//4JPmNhWhV9izCU6xpUynywumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piHdwwXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D6FC32788;
	Tue, 23 Jan 2024 01:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705973079;
	bh=KZ7cJZHbXuJgg3EWBnTddmUBSAHkssfyRhBTAU+O7cA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=piHdwwXPso5jjukXk5Rq0CoYq/SSaOeV1ixmALULmJ9G3FyTw3R8TJSxhYpkOXy7v
	 hxcQFsa6nDnTBmK2u2yM3jqH0lVPkhK2ADKLKmBZ+prPTw4cfpakxmgno5tkWCiIRi
	 wKV/tYXe02PITGQkN3+gr2tKk98g0sDjPA9V+JXz0OrwnO2/bNRywW/33V0cD8hJ7m
	 LlOhAD0munffsIeaiB4k6RtCQGD+aqjn8FrcEw1S2li+rH2cUXgfT+gSbBLh7t3Ybj
	 Texo7puucEW8Gc40JP9ewZoC5kMEEn5+yGxY4pRmInXPKndQOC5rdHwu5d+8WxiN3+
	 BX5PWQa7jWPBQ==
Date: Mon, 22 Jan 2024 17:24:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS through
 policy instead of open-coding
Message-ID: <20240122172438.16196239@kernel.org>
In-Reply-To: <20240122190738.32327-1-alessandromarcolini99@gmail.com>
References: <20240122190738.32327-1-alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 20:07:38 +0100 Alessandro Marcolini wrote:
> +	__u32 taprio_flags;

nit: s/__u32/u32/ the __u32 version is only for include/uapi/ files

> -	q->flags = err;
> +	/* txtime-assist and full offload are mutually exclusive */
> +	if ((taprio_flags & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST) &&
> +	    (taprio_flags & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)) {
> +		NL_SET_ERR_MSG_MOD(extack, "TXTIME_ASSIST and FULL_OFFLOAD are mutually exclusive");

Maybe use NL_SET_ERR_MSG_ATTR()? There seems to be no
NL_SET_ERR_MSG_ATTR_MOD() which is probably for the best.
The _MOD() prefix is a crutch, IMHO, pointing to the erroneous
attributes is much better, now that we have YNL and can actually
interpret the offsets.
-- 
pw-bot: cr

