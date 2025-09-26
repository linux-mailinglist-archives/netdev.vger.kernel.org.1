Return-Path: <netdev+bounces-226747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39235BA4B0A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0921C203B1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA73244661;
	Fri, 26 Sep 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXjCDoU7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421F823DD;
	Fri, 26 Sep 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904965; cv=none; b=NbJOOteZ9ekkIrcl9HB40Zg0i5zOK5VV0EJScUAB3ZKJIlfN0f7vwq0u9IeU4/Q+gz6dFXIqEu9kQT9uQr2yvtcgvsUl5PGbf5J5VPayK8gZHYU+YcymFYtBjse4O1vyDotIZOt5LShOdHqqQn8U7yZQAcZkxr/S/H8kgv/D5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904965; c=relaxed/simple;
	bh=EkEGdQzRoQHV/+qgTce+eYgdmMYG6X7KUjwNyIGarvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlPT6xwXdADAi4TPv8lhrLuUDBrGtTJEc9/lwbqsA1BJNlYZG25nEwYmTo2FE01UMyfXC6H14ZTm99/Ndd1IJAC23iCMzmRHqGfnYgJz3HAtw++hKAt3t4mKi9s9TPk7ZDsAEp4E3rckjZPy2kf3J+XiqcTJurZ0A7H3oZ4FEpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXjCDoU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48F8C4CEF4;
	Fri, 26 Sep 2025 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758904964;
	bh=EkEGdQzRoQHV/+qgTce+eYgdmMYG6X7KUjwNyIGarvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXjCDoU7UvglbHeWZlcgdKM51GzyfPYJ50WZcIvbOLT5FgCmiMLvkmFCrrO4aoEAR
	 N7NOisYGIWkXtNetrrSAdLSkg6F2zt6DfYtYNr/WkAduuhS7F005fGtwqKzLQ3CqzC
	 UsJkGx6shKRqXks1NKpSK27vt3p4abdEdL8Z9tLqTUwulM7xEkD8QwPCxmLZLVHgS+
	 udPJey5RoIhrJXpW5qUbVNZ2yTVt4JuDowuoXEGhOmoqPX3ZOJr+nGUiG71EYLK4UW
	 rVa6y4cBKsruTw5cCfCgqDCAPrETY3n9SkZsf4o0A4sIMXgGXN1uCtSCBl3sOgwnDR
	 TeGph+6DY7wTg==
Date: Fri, 26 Sep 2025 17:42:40 +0100
From: Simon Horman <horms@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Nishanth Menon <nm@ti.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: netcp: Fix crash in error path when DMA channel
 open fails
Message-ID: <aNbCgK76kQqhcQY2@horms.kernel.org>
References: <20250926150853.2907028-1-nm@ti.com>
 <aNa7rEQLJreJF58p@horms.kernel.org>
 <ef2bd666-f320-4dc5-b7ae-d12c0487c284@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2bd666-f320-4dc5-b7ae-d12c0487c284@ti.com>

On Fri, Sep 26, 2025 at 09:57:02PM +0530, Siddharth Vadapalli wrote:
> On 26/09/25 9:43 PM, Simon Horman wrote:
> > On Fri, Sep 26, 2025 at 10:08:53AM -0500, Nishanth Menon wrote:
> > > When knav_dma_open_channel() fails in netcp_setup_navigator_resources(),
> > > the rx_channel field is set to an ERR_PTR value. Later, when
> > > netcp_free_navigator_resources() is called in the error path, it attempts
> > > to close this invalid channel pointer, causing a crash.
> > > 
> > > Add a check for ERR values to handle the failure scenario.
> > > 
> > > Fixes: 84640e27f230 ("net: netcp: Add Keystone NetCP core driver")
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > ---
> > > 
> > > Seen on kci log for k2hk: https://dashboard.kernelci.org/log-viewer?itemId=ti%3A2eb55ed935eb42c292e02f59&org=ti&type=test&url=http%3A%2F%2Ffiles.kernelci.org%2F%2Fti%2Fmainline%2Fmaster%2Fv6.17-rc7-59-gbf40f4b87761%2Farm%2Fmulti_v7_defconfig%2BCONFIG_EFI%3Dy%2BCONFIG_ARM_LPAE%3Dy%2Bdebug%2Bkselftest%2Btinyconfig%2Fgcc-12%2Fbaseline-nfs-boot.nfs-k2hk-evm.txt.gz
> > > 
> > >   drivers/net/ethernet/ti/netcp_core.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
> > > index 857820657bac..4ff17fd6caae 100644
> > > --- a/drivers/net/ethernet/ti/netcp_core.c
> > > +++ b/drivers/net/ethernet/ti/netcp_core.c
> > > @@ -1549,7 +1549,7 @@ static void netcp_free_navigator_resources(struct netcp_intf *netcp)
> > >   {
> > >   	int i;
> > > -	if (netcp->rx_channel) {
> > > +	if (!IS_ERR(netcp->rx_channel)) {
> > >   		knav_dma_close_channel(netcp->rx_channel);
> > >   		netcp->rx_channel = NULL;
> > >   	}
> > 
> > Hi Nishanth,
> > 
> > Thanks for your patch.
> > 
> > I expect that netcp_txpipe_close() has a similar problem too.
> > 
> > But I also think that using IS_ERR is not correct, because it seems to me
> > that there are also cases where rx_channel can be NULL.
> 
> Could you please clarify where rx_channel is NULL? rx_channel is set by
> invoking knav_dma_open_channel().

Hi Siddharth,

I am assuming that when netcp_setup_navigator_resources() is called, at
least for the first time, that netcp->rx_channel is NULL. So any of the
occurrence of 'goto fail' in that function before the call to
knav_dma_open_channel().

> Also, please refer to:
> https://github.com/torvalds/linux/commit/5b6cb43b4d62
> which specifically points out that knav_dma_open_channel() will not return
> NULL so the check for NULL isn't required.
> > 
> > I see that on error knav_dma_open_channel() always returns ERR_PTR(-EINVAL)
> > (open coded as (void *)-EINVAL) on error. So I think a better approach
> > would be to change knav_dma_open_channel() to return NULL, and update callers
> > accordingly.
> 
> The commit referred to above made changes to the driver specifically due to
> the observation that knav_dma_open_channel() never returns NULL. Modifying
> knav_dma_open_channel() to return NULL will effectively result in having to
> undo the changes made by the commit.

I wasn't aware of that patch. But my observation is that the return value
of knav_dma_open_channel() is still not handled correctly. E.g. the bug
your patch is fixing.  And I'm proposing an alternate approach which I feel
will be less error-prone.

