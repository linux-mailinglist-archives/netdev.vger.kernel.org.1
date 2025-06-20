Return-Path: <netdev+bounces-199922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB3AE2337
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 22:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A347A8825
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39F722A7E7;
	Fri, 20 Jun 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6Nn9R/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE918226CE1
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449618; cv=none; b=dV8YupUDCK2qc/EEJNJCvpEcnqVav4tnXu9LtF9lwZAG7l6Zmwub808TCz11nT992vy4X3l44meRqXQZH8Xh/34mP0nLBPB08RDLkhmyeE3gru0am8pAxVVBIlrSkiG1QocFnGRKxYV/jA7LS7TfMenkOxYCuSrGvg4m78vwi5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449618; c=relaxed/simple;
	bh=U6Ki+MEX6QmuGbePK0FZE6xjo4W7W+mLYmB9EcLHk0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbeUeWsbjXhn8gIgCYd3wOoGZJ4LVKOWqdo6zzGnk7iTYGG4H7sG4zS0ymQ+Q9o33XfIaH8g6SwAF0jp5ciVpxMopg+1Y/OF8SrJ+ZfGNeLfPSf+vnSVYmTygteqdXVH/IG6NXVL8g8R5u0w9i9tSqrxknltFLPfTbt45Pi0Lb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6Nn9R/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04477C4CEE3;
	Fri, 20 Jun 2025 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750449617;
	bh=U6Ki+MEX6QmuGbePK0FZE6xjo4W7W+mLYmB9EcLHk0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6Nn9R/j3umoi3kdPdLXfndG+mMhY9fiz4ajN9m5qiWlN9sLOq9HVYETxjyHOmuUU
	 IowK0onG6lBJ11NZzAfNDL+hvWZ0Acmf1O7cacDEXf1yHGwtyxDK8KRhDbwNl4xSHa
	 ZWKHEmO1TOv1wZcndKeHv1amT6sjDgt4ju9sOCFmdUKYNwDDx1z+7FzH8uX+I8X6os
	 iIuSEHb52avtQ9ayxO2U1djeRb7FLuznhU7lE6QMG3R8rC3785TF0jghBUwwWVyMBy
	 LeO6NrzAyzDM3w40TT6NEEdMdIT7X+0TG6GvsWL81zGnJOxcakdk7oOFWgIXai/A/u
	 gnNpmK5t6DD5w==
Date: Fri, 20 Jun 2025 21:00:12 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, saikrishnag@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH] octeontx2-af: Fix rvu_mbox_init return path
Message-ID: <20250620200012.GD9190@horms.kernel.org>
References: <1750255036-23802-1-git-send-email-sbhatta@marvell.com>
 <20250618194301.GA1699@horms.kernel.org>
 <aFVCoxgAnfH1aQ4x@48c69cc54dda>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFVCoxgAnfH1aQ4x@48c69cc54dda>

On Fri, Jun 20, 2025 at 11:14:43AM +0000, Subbaraya Sundeep wrote:
> On 2025-06-18 at 19:43:01, Simon Horman (horms@kernel.org) wrote:
> > On Wed, Jun 18, 2025 at 07:27:16PM +0530, Subbaraya Sundeep wrote:
> > > rvu_mbox_init function makes use of error path for
> > > freeing memory which are local to the function in
> > > both success and failure conditions. This is unusual hence
> > > fix it by returning zero on success. With new cn20k code this
> > > is freeing valid memory in success case also.
> > > 
> > > Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
> > > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > Although I don't think the problem is introduced by this patch
> > with it applied Smatch notices that the following code, around line 2528,
> > which jumps to free_regions does so with err uninitialised. This is a
> > problem because the jump will result in the function returning err.
> 
> Thanks Simon for review. I will send fix for Smatch error in
> separate patch later.

Excellent, thanks.

