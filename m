Return-Path: <netdev+bounces-190158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D06AB55CC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E581B420A4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A0F24397A;
	Tue, 13 May 2025 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWMfskZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C520D4F2
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142246; cv=none; b=jtyYicQW4lqYcESWP43FrH/ZafTrbrh3AzG482faNO8R49sU6IFfpbS/rjjyWYNUrsI5HaodPTkYipsoQel/caSrhKGQFU3rCOx7bvVURanGdEYpH1zoIhxemueCcuskVVfBYBNr9+WSZf1qzOYYwD1CNs1mcxkkFhbJ6DYc5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142246; c=relaxed/simple;
	bh=Fb+x8Xs5o9HycXwFBCoJ8kQrNH414riybeXH7lzWfUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3qFIc+9u2fJhp9SPPHvnkq1dhTPnD6P2fFDYE/YpC0xy/SzFs4yXhyzysdKutJL4tCyV512NzFo2+/HZ7XwC86tOWRbAKHqlmefW7gukCKwjr9FDrZ5PJLgCsfQRuj07AT2kycznADJbYE3sip2LFAgqbO0PudKjFMp+vvhcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWMfskZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7C3C4CEE4;
	Tue, 13 May 2025 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747142246;
	bh=Fb+x8Xs5o9HycXwFBCoJ8kQrNH414riybeXH7lzWfUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWMfskZKelxzp8LBShaUpEM6C+o1DtMON1fCMD+8raPArArTwuqHUe4W4e84SJ3/8
	 NJrRImGF1DCvDfbm+F8Lt/wDYkGTq2GqGZ6IgX9K4kieLN+fVxamRWfsx9qJT+LCtU
	 lhuPuEGN7krpopZLGEE2EK4VM1wRzX0hcGnaAjJ1w5m7oggg8j0zpShVW3ZJDz8gvU
	 1gwGCMSbiKI+p+9/dRpbK9j3wUKnw646G54uwEsDroshFI9EIvibZdTSyDCsKM6GBP
	 aAEK+G5DSteN7hgjGt1qka8L0s0ZKuMFYBgZyJ8H1VTPkLtowESXYA4CZMJi7jSuw6
	 9rRgJVWMI5Ojw==
Date: Tue, 13 May 2025 14:17:21 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Send Link events one by one
Message-ID: <20250513131721.GY3339421@horms.kernel.org>
References: <1746638183-10509-1-git-send-email-sbhatta@marvell.com>
 <20250512100954.GU3339421@horms.kernel.org>
 <aCHfZ_MxtfVmhXVj@90a8923ee8d1>
 <aCHxax9GgcLL-4Xk@37b358c748b7>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCHxax9GgcLL-4Xk@37b358c748b7>

On Mon, May 12, 2025 at 01:02:35PM +0000, Subbaraya Sundeep wrote:
> Hi again,
> 
> On 2025-05-12 at 11:45:43, Subbaraya Sundeep (sbhatta@marvell.com) wrote:
> > Hi Simon,
> > 
> > On 2025-05-12 at 10:09:54, Simon Horman (horms@kernel.org) wrote:
> > > On Wed, May 07, 2025 at 10:46:23PM +0530, Subbaraya Sundeep wrote:
> > > > Send link events one after another otherwise new message
> > > > is overwriting the message which is being processed by PF.
> > > > 
> > > > Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> > > > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > > > ---
> > > >  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > > > index 992fa0b..ebb56eb 100644
> > > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > > > @@ -272,6 +272,8 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
> > > >  
> > > >  		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);
> > > 
> > > Hi Subbaraya,
> > > 
> > > Are there other callers of otx2_mbox_msg_send_up()
> > > which also need this logic? If so, perhaps a helper is useful.
> > > If not, could you clarify why?
> > > 
> > UP messages are async notifications where we just send and forget.
> > There are other callers as I said we just send and forget everywhere
> > in the driver. Only this callsite has been modified because we have
> > seen an issue on customer setup where bunch of link events are queued
> > for a same device at one point of time.

Thanks for the clarification.

> > > >  
> > > > +		otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);
> > > 
> > > This can return an error. Which is checked in otx2_sync_mbox_up_msg().
> > > Does it make sense to do so here too?
> > > 
> > Yes it makes sense to use otx2_sync_mbox_up_msg here. I will use it
> > here.
> > 
> I will leave it as otx2_mbox_wait_for_rsp. Since otx2_sync_mbox_up_msg
> is in nic driver and we do not include nic files in AF driver. Since
> this is a void function will print an error if otx2_mbox_wait_for_rsp
> returns error.

Sorry, I wasn't clear in my previous email.

I was asking if it makes sense to check the return value of
otx2_mbox_wait_for_rsp() in this patch.

...

