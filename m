Return-Path: <netdev+bounces-140062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D032A9B5233
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3F2284DD1
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86595205E2D;
	Tue, 29 Oct 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTrGfkap"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968D126C1E;
	Tue, 29 Oct 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228068; cv=none; b=VZOL/XRMhp4OT3ommSze72uPPh70WAp9iNIO8dInqwabrPfDGuKTPnSU9pEzE5NaZwUduucCZudDRs6JaoqFEnI67Kbhfvnjw83cZPCTx8cQkWPN8FA5X8+GxH2s8owvznjohIyW2UXV+wrEMaltyzQMRyGJCUFhjITwcPna+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228068; c=relaxed/simple;
	bh=wEEjOPEr3h7B9o1LpRfDYM55t3DpHZCmU0hPu24HW+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlO0p8XLSZzoHZjDDYiBPwHRWmggR6+RDeU1dZ0QLQjOX8csalu3XrbZgVe3BHCxBDlqQoFTpFjW9n8P2dUfZVY4zXGunGDocXwjbzU/cxTmD4g6R9V4w8D4VqG1vwg2L/nO2IFBnTrpxCFH1an3GP6+lcnS51ZdrQji15oTZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTrGfkap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160B5C4CECD;
	Tue, 29 Oct 2024 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228067;
	bh=wEEjOPEr3h7B9o1LpRfDYM55t3DpHZCmU0hPu24HW+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mTrGfkapY6L9v4bmqiFFk35IJxnUyw75R/jWD46g2NJ/67HXsofO8OO6GWReTTHPr
	 L4N9zpdbdEqK6oOtlc+WdXsMNd/wVaf+b21i6G10ZFxaFGiFQ4xRjUCc2Ma5QGR3BG
	 aCgM/TjIYepLidaSbT5x4DBckfYkLMCQUemPy6JEIx8BZ8v8AYBqXR3x7SU8m4hRsN
	 5UNBkdrfGZqr3unYxvaNm8qBffjaDBq+rzrjRU6VSoxVe4DI/+jbkk4NscMY+bKMzv
	 L8U1/nWO+Mn8cPFYS9CaYVRZR5jn2yboTvexatEPD9viIkt8TlPlql2Ah4G0lpSW8b
	 3BSXGp5KQt4hw==
Date: Tue, 29 Oct 2024 11:54:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241029115426.3b0fcaff@kernel.org>
In-Reply-To: <26d37815-c652-418c-99b0-9d3e6ab78893@embeddedor.com>
References: <cover.1729536776.git.gustavoars@kernel.org>
	<f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
	<20241029065824.670f14fc@kernel.org>
	<f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
	<20241029110845.0f9bb1cc@kernel.org>
	<7d227ced-0202-4f6e-9bc5-c2411d8224be@embeddedor.com>
	<20241029113955.145d2a2f@kernel.org>
	<26d37815-c652-418c-99b0-9d3e6ab78893@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 12:48:32 -0600 Gustavo A. R. Silva wrote:
> >> Is this going to be a priority for any other netdev patches in the future?  
> > 
> > It's been the preferred formatting for a decade or more.
> > Which is why the net/ethtool/ code you're touching follows
> > this convention. We're less strict about driver code.  
> 
> I mean, the thing about moving the initialization out of line to accommodate
> for the convention.
> 
> What I'm understanding is that now you're asking me to change the following
> 
>       const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
>       const struct ethtool_link_ksettings *ksettings = &data->ksettings;
> -    const struct ethtool_link_settings *lsettings = &ksettings->base;
> +    const struct ethtool_link_settings_hdr *lsettings = &ksettings->base;
> 
> to this:
> 
>       const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
>       const struct ethtool_link_settings_hdr *lsettings;
>       const struct ethtool_link_ksettings *ksettings;
> 
>       ksettings = &data->ksettings;

You don't have to move this one out of line but either way is fine.

>       lsettings = &ksettings->base;
> 
> I just want to have clear if this is going to be a priority and in which scenarios
> should I/others modify the code to accommodate for the convention?

I don't understand what you mean by priority. If you see code under
net/ or drivers/net which follows the reverse xmas tree variable
sorting you should not be breaking this convention. And yes, if
there are dependencies between variables you should move the init
out of line.

