Return-Path: <netdev+bounces-20699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287CA760B2F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E883A1C20CBC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5BD8F65;
	Tue, 25 Jul 2023 07:08:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931351C37
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C13C433C8;
	Tue, 25 Jul 2023 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690268893;
	bh=8ZO+dQLtUiBc7Ah68ZPlpmAFo7aFZA5cxmTFAGgJ4qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tz1wvA2lxwAsPqVJtqbtnialvr10PrdMB1LuHZw47XVu1YM0unJi6kQQF1HczgJAC
	 UgCBGXe3vZUin1qlo5WT/CIIDHxsIwhiSfQOVdm+fbtH0LQleRIJ+PKVGgfNRODelI
	 Vn1hCwrXUEOBpUffiR2rRiCZMyPpXB1MXEfAN1XQ=
Date: Tue, 25 Jul 2023 09:08:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dianders@chromium.org, caleb.connolly@linaro.org,
	mka@chromium.org, evgreen@chromium.org, andersson@kernel.org,
	quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
	elder@kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipa: only reset hashed tables when supported
Message-ID: <2023072538-corned-falsify-d054@gregkh>
References: <20230724224106.1688869-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724224106.1688869-1-elder@linaro.org>

On Mon, Jul 24, 2023 at 05:41:06PM -0500, Alex Elder wrote:
> Last year, the code that manages GSI channel transactions switched
> from using spinlock-protected linked lists to using indexes into the
> ring buffer used for a channel.  Recently, Google reported seeing
> transaction reference count underflows occasionally during shutdown.
> 
> Doug Anderson found a way to reproduce the issue reliably, and
> bisected the issue to the commit that eliminated the linked lists
> and the lock.  The root cause was ultimately determined to be
> related to unused transactions being committed as part of the modem
> shutdown cleanup activity.  Unused transactions are not normally
> expected (except in error cases).
> 
> The modem uses some ranges of IPA-resident memory, and whenever it
> shuts down we zero those ranges.  In ipa_filter_reset_table() a
> transaction is allocated to zero modem filter table entries.  If
> hashing is not supported, hashed table memory should not be zeroed.
> But currently nothing prevents that, and the result is an unused
> transaction.  Something similar occurs when we zero routing table
> entries for the modem.
> 
> By preventing any attempt to clear hashed tables when hashing is not
> supported, the reference count underflow is avoided in this case.
> 
> Note that there likely remains an issue with properly freeing unused
> transactions (if they occur due to errors).  This patch addresses
> only the underflows that Google originally reported.
> 
> Fixes: d338ae28d8a8 ("net: ipa: kill all other transaction lists")
> Cc: <stable@vger.kernel.org>    # 6.1.x
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/net/ipa/ipa_table.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)

You sent 2 different versions of this patch?  Which one is for what
tree?  Is this in Linus's tree already?  If so, what's the git id?

confused,

greg k-h

