Return-Path: <netdev+bounces-190795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F36AB8D92
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D481BC7520
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D091DDD1;
	Thu, 15 May 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK3ihR9o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2400F41C63
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329579; cv=none; b=EnphLhN7G6b09+aI8TpkwyjwN6EYdUMH1/51O6Av5oUAAyPU8cr52uqc7N2KW+Wq5VKSAm/CDgf+p5+l39BhYV1xsrEytdq6AELcEbVykkR8fi69H+stVJ2C0felkskUQbYhpVxGNo2lMoaJSI4BA/2AYqnawPMdbKV3ErcVIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329579; c=relaxed/simple;
	bh=NkIgkifyqbwdtg7eix/D5lIYAi111x8X9jRARL8eKx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sexUURIS7V84AZZqP0tRMMlU+582eV+goI0CtOMMbQakuzVFkcHeqiG8JU0Uz0ORKL0HrxbDoWnwo7qJCLOAIwQK4ZDu9uFZITsrNuFOgVHJs+DXwC0o4/JGp10F5dOk+WP18c2n9ifUqMRQtLdlRnmnUDHknT/J7yKY99vHEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK3ihR9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B04C4CEE7;
	Thu, 15 May 2025 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747329578;
	bh=NkIgkifyqbwdtg7eix/D5lIYAi111x8X9jRARL8eKx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bK3ihR9oSFgXcdHhYr4D6sxwtQEYw2cVRaOi977iopqg8KACaIJcxWAmxMa4Dgm3o
	 H5FtTUvpY7T/rPbJkbVn6QFUZyPnHgVcTosYse+flGkK2RHCteBdKxhJGhCrllCd35
	 QyeGrshDX7osa1hV/l/679xMEMkD0Ok68PoXFLss5xa4g7y+2DyH3aRvBt9f/vNUDC
	 gc3kJTdeG+ge+w57Cske/h4RU+kZU2PzrQiGav5lP9If1xQds0QQ2b8wwbT/Jwmblw
	 3ccHV++zPEdPNDcTIHyTjllKWj0GMvrkOHlTvDaGeCDrkTlLyhjDS0Rejowmq3e4Mt
	 He/8mYj9b2nVA==
Date: Thu, 15 May 2025 10:19:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <gakula@marvell.com>,
 <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
 <bbhushan2@marvell.com>, <jerinj@marvell.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] octeontx2-af: Send Link events one by one
Message-ID: <20250515101937.72ae5ef9@kernel.org>
In-Reply-To: <aCYZLg2IohEbhMYY@3958e7e617f8>
References: <1747204108-1326-1-git-send-email-sbhatta@marvell.com>
	<20250515071239.1fe4e69a@kernel.org>
	<aCYZLg2IohEbhMYY@3958e7e617f8>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 16:41:18 +0000 Subbaraya Sundeep wrote:
> On 2025-05-15 at 14:12:39, Jakub Kicinski (kuba@kernel.org) wrote:
> > On Wed, 14 May 2025 11:58:28 +0530 Subbaraya Sundeep wrote:  
> > > Send link events one after another otherwise new message
> > > is overwriting the message which is being processed by PF.  
> > 
> > Please respond to reviewers in a timely fashion.  
> 
> Just want to know is it you or bot?

Have you seen me reply with the same text to someone else?
Oh, that's right, you don't read the list, how would you know..

> What is the time limit here?
> Have to respond within 24hr?

The review cadence on netdev is 24h.

