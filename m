Return-Path: <netdev+bounces-227134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02495BA8CD2
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 11:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D1917411B
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9212F1FCA;
	Mon, 29 Sep 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFkX9Y9L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEC2F1FC8;
	Mon, 29 Sep 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139986; cv=none; b=iw/P5BO+5wJWPrBCisBLLaWpls3Xd7GPSn9cfNgpd2FBY0hUg3D58XWLTfEuOE2FWICgfaS8or8rtcqvnIXGpMxD+6pnA7EezaJ0/dQmgOKpGaXvwiDnMLUMpbmloxrlZ8QQdEYJyIIlkeHR1nQ5+d8GHNGn/INmoVffi5eHRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139986; c=relaxed/simple;
	bh=DagTvSp+7YAi/LuUfSuuyOhuhMMN85uMrXt9yNyDwXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAneaCyzAvSAWUlRr9WtN6mH2GZbZ8QV8OwbZgxnF9rLGcuLgwWGBtox6OsojbgKvZK6cQgPEMzhWM98zdBKWMyNKhJvoYr+XL5Eg4i8IEf0AJHB7BC1PGWWz7TgjoV/UXmkHo1tln8K6+9XLgfH8WlIgxS50PBP/exNU1lpTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFkX9Y9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A624C4CEF4;
	Mon, 29 Sep 2025 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759139986;
	bh=DagTvSp+7YAi/LuUfSuuyOhuhMMN85uMrXt9yNyDwXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFkX9Y9LmfhlZIsnhFCcBpQYWmHlN1hgAkA65NoJ3iTOFffL1Ksn+Z1wDxHLViegX
	 QT94NEK4623YNH9tvzBP+SxfTveBPGx23MKdVdFUfrlRaCAqmIFSNZ2f7qEG8iKg8J
	 GFifAnAKMBvrEgBy8pO1V7oOi7Q7CUe2EJhv6wipIH9Fpdi2OPfvvbCl6HIrgd0fUd
	 WC744hLtq89xwhKChBHzJOPTlKsziojJywxf3ELq9AyzP7PP8l2Aw8JOZ4CX944aYx
	 wbtuLfKkkfqmxa46WVFUnHgPzESiKLzCt1Kj8/1RdfV7r3RVI8OIXFQ5NU+cTuO44T
	 t3CVC6fdKceZw==
Date: Mon, 29 Sep 2025 10:59:42 +0100
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
Message-ID: <aNpYjvpr8xixDUM6@horms.kernel.org>
References: <20250926150853.2907028-1-nm@ti.com>
 <aNa7rEQLJreJF58p@horms.kernel.org>
 <ef2bd666-f320-4dc5-b7ae-d12c0487c284@ti.com>
 <aNbCgK76kQqhcQY2@horms.kernel.org>
 <08a13fb0-dd12-491e-98af-ef67d55cc403@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a13fb0-dd12-491e-98af-ef67d55cc403@ti.com>

On Fri, Sep 26, 2025 at 10:28:47PM +0530, Siddharth Vadapalli wrote:
> On 26/09/25 10:12 PM, Simon Horman wrote:
> > On Fri, Sep 26, 2025 at 09:57:02PM +0530, Siddharth Vadapalli wrote:
> > > On 26/09/25 9:43 PM, Simon Horman wrote:
> > > > On Fri, Sep 26, 2025 at 10:08:53AM -0500, Nishanth Menon wrote:
> > > > > When knav_dma_open_channel() fails in netcp_setup_navigator_resources(),
> > > > > the rx_channel field is set to an ERR_PTR value. Later, when
> > > > > netcp_free_navigator_resources() is called in the error path, it attempts
> > > > > to close this invalid channel pointer, causing a crash.
> > > > > 
> > > > > Add a check for ERR values to handle the failure scenario.
> > > > > 
> > > > > Fixes: 84640e27f230 ("net: netcp: Add Keystone NetCP core driver")
> > > > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > > > ---
> > > > > 
> > > > > Seen on kci log for k2hk: https://dashboard.kernelci.org/log-viewer?itemId=ti%3A2eb55ed935eb42c292e02f59&org=ti&type=test&url=http%3A%2F%2Ffiles.kernelci.org%2F%2Fti%2Fmainline%2Fmaster%2Fv6.17-rc7-59-gbf40f4b87761%2Farm%2Fmulti_v7_defconfig%2BCONFIG_EFI%3Dy%2BCONFIG_ARM_LPAE%3Dy%2Bdebug%2Bkselftest%2Btinyconfig%2Fgcc-12%2Fbaseline-nfs-boot.nfs-k2hk-evm.txt.gz
> > > > > 
> > > > >    drivers/net/ethernet/ti/netcp_core.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
> > > > > index 857820657bac..4ff17fd6caae 100644
> > > > > --- a/drivers/net/ethernet/ti/netcp_core.c
> > > > > +++ b/drivers/net/ethernet/ti/netcp_core.c
> > > > > @@ -1549,7 +1549,7 @@ static void netcp_free_navigator_resources(struct netcp_intf *netcp)
> > > > >    {
> > > > >    	int i;
> > > > > -	if (netcp->rx_channel) {
> > > > > +	if (!IS_ERR(netcp->rx_channel)) {
> > > > >    		knav_dma_close_channel(netcp->rx_channel);
> > > > >    		netcp->rx_channel = NULL;
> > > > >    	}
> > > > 
> > > > Hi Nishanth,
> > > > 
> > > > Thanks for your patch.
> > > > 
> > > > I expect that netcp_txpipe_close() has a similar problem too.
> > > > 
> > > > But I also think that using IS_ERR is not correct, because it seems to me
> > > > that there are also cases where rx_channel can be NULL.
> > > 
> > > Could you please clarify where rx_channel is NULL? rx_channel is set by
> > > invoking knav_dma_open_channel().
> > 
> > Hi Siddharth,
> > 
> > I am assuming that when netcp_setup_navigator_resources() is called, at
> > least for the first time, that netcp->rx_channel is NULL. So any of the
> > occurrence of 'goto fail' in that function before the call to
> > knav_dma_open_channel().
> 
> I missed this. Thank you for pointing this out.

No problem. These error paths are tricking things.

> > > Also, please refer to:
> > > https://github.com/torvalds/linux/commit/5b6cb43b4d62
> > > which specifically points out that knav_dma_open_channel() will not return
> > > NULL so the check for NULL isn't required.
> > > > 
> > > > I see that on error knav_dma_open_channel() always returns ERR_PTR(-EINVAL)
> > > > (open coded as (void *)-EINVAL) on error. So I think a better approach
> > > > would be to change knav_dma_open_channel() to return NULL, and update callers
> > > > accordingly.
> > > 
> > > The commit referred to above made changes to the driver specifically due to
> > > the observation that knav_dma_open_channel() never returns NULL. Modifying
> > > knav_dma_open_channel() to return NULL will effectively result in having to
> > > undo the changes made by the commit.
> > 
> > I wasn't aware of that patch. But my observation is that the return value
> > of knav_dma_open_channel() is still not handled correctly. E.g. the bug
> > your patch is fixing.  And I'm proposing an alternate approach which I feel
> > will be less error-prone.
> 
> Ok. If I understand correctly, you are proposing that the 'error codes'
> returned by knav_dma_open_channel() should be turned into a dev_err() print
> for the user and knav_dma_open_channel() should always return NULL in case
> of failure and a pointer to the channel in case of success. Is that right?

I'm ambivalent regarding the dev_err() part. Because the error is always
the same. And I'm not really sure that logging it adds anything. But if you
do go that way, please consider using %pe.  consider using

Regarding knav_dma_open_channel(0 always returning NULL, yes, that is my
suggestion. Of course the callers and anything else that uses that
return value need to be audited and updated as appropriate.

Thanks!

