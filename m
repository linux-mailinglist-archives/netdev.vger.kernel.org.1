Return-Path: <netdev+bounces-108883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FF92623C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A242284C3B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58F017B51B;
	Wed,  3 Jul 2024 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD8DLqB7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AB17083F
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014702; cv=none; b=TZqo1ZSz3VKNPeAM/5NWko4W0DDrMqDZByF/UwIazDJm9LpvDskTf+ONwgLBbXtC2DYu/BY58oz2Vrux5Vbipk00m99Zw3aAwpe1eb0OyAXX+6W7NLn1Z7zatU6Wmn76HUuDSZHjGX8iIhjzfix5kVqz4ivuX7uRzP69JlQCH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014702; c=relaxed/simple;
	bh=vohJkRmDREtV7zK+r/OengDY8oZi5Ve1UW1v/rLhsDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mC5fRIyVDMtqhbawzZqfsupgpOFuubkiiInnjOhm4ovZSzwlwuX2ssr6ZgOCZ6wvn9qdFdN0rSRP2bz7t9UT6bxMOvGPwdzmLFRfJTbgSGuW63vtJcgz3IRwfxgHxigeNKKzRAbn1ZDpU2bLTZ844WLsWll+s7QTncpttogK7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD8DLqB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26D8C3277B;
	Wed,  3 Jul 2024 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014702;
	bh=vohJkRmDREtV7zK+r/OengDY8oZi5Ve1UW1v/rLhsDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LD8DLqB7sIyQpDcvj2fOhNE0aiNvDiO+0wcnO4jPilrgXMxSycI8fJ+24wvIXNw/f
	 aYdHpSOgaL4v59lmgrWUOYFjTSjK1eaOxNkAjaLTaXBEovgGS1hpS5DwVoVrt+QaK9
	 /Q1z7hnUF3qKjrXScqzZiZuqfIhM6CpLNolVniWX2WroVM+T90ssJdvJBGU6G6rJy9
	 WPWNNdokoLPAB2bT/ueDaQmQtrJGpHbGP4H6/zEUCynA1MbOZkd35/2l8P1IG6wbed
	 4wTuKJ71MGBSpmGD3mN/b3/3kpprPjK1olJ7pnqZJ+mnq44vkqnDSRfVoxRJO/Ju48
	 Oz6s3yeejgqrA==
Date: Wed, 3 Jul 2024 06:51:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com
Subject: Re: [PATCH net-next 10/11] eth: bnxt: use the indir table from
 ethtool context
Message-ID: <20240703065140.65abd1fd@kernel.org>
In-Reply-To: <04214959-8b0c-2e5c-5dc7-8426746b48b9@gmail.com>
References: <20240702234757.4188344-1-kuba@kernel.org>
	<20240702234757.4188344-12-kuba@kernel.org>
	<04214959-8b0c-2e5c-5dc7-8426746b48b9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 12:39:09 +0100 Edward Cree wrote:
> >  	tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
> > +	ctx = ethtool_rxfh_priv_context(vnic->rss_ctx);  
> 
> Not super familiar with this driver or why this need arises, but
>  would it be simpler to just store ctx in vnic instead of priv?

Yup, I think that should work!

