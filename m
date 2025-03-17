Return-Path: <netdev+bounces-175390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB2A659BF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3DB1896D7E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2A1A00F0;
	Mon, 17 Mar 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXWjDHjA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBDA48;
	Mon, 17 Mar 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230921; cv=none; b=sg/JEHLYZ5a4cLjghxBvwnG3zsUNUx0SP93n1XIWNQp6unebZD48OSgGmrRAJ7yPYi7wCQYd4b70HlF184/1sUC3t7VhfxqQiVWP/1FbXG/JsMEXdgOz21GopXO3uyHvfp9r3qraKiWPKfI8rwNJXfGKAk9Rk8L4IHcSqIYMitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230921; c=relaxed/simple;
	bh=x/mGAkrV+8U34K+5jMdXc/eUYG9sUfn3SkW/CtmeZXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD6mzkpvtjn7PEHLwI6KmKLXkBDeHUU15WibuVehQbxLs1Vo6dEQjUE3sIs10U55TjJoWX+x46MQgfBD9IBUHt5LA4F/QG4Kx3xcJoBcak9IEeSM0dg0gOYaZ8E+5/+cM+fMXyK1f8uiu6xrgQ5WqNM9lxmfJ6WiratVCmqccHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXWjDHjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970C2C4CEE3;
	Mon, 17 Mar 2025 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742230920;
	bh=x/mGAkrV+8U34K+5jMdXc/eUYG9sUfn3SkW/CtmeZXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXWjDHjAQFJe8AyUlboM8EDsbGsI17LHbp41AxpboHEAeN98Ipu+r2oayp08t8UtW
	 XqG42w5KElVvK7Q+P4xrFXnbGIRvFf6BIg20Zcwty/Z+qVcQwiBvQ8YHbVP1AvqkYY
	 E2d4w7TbmD8UVSQgMYSfiJUHx+42w8E5HxwCZHb3/CDJqmdbX8+5wMpGe+kDJHEhlw
	 L9ijnqFj5FKc+wF09fwVT5XKhB1dNY6HSPN8dWHwxl6UOlPSgr0f3ewg3shFuSv8pL
	 llh1wIQLTV/v8K8jtkQzphsFTQ5djNE/QKPl906ptEVZ6spMGcjtR+XA+2vVi2eW1J
	 FDf9ctn+TtMuw==
Date: Mon, 17 Mar 2025 17:01:54 +0000
From: Simon Horman <horms@kernel.org>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"morbo@google.com" <morbo@google.com>,
	"justinstitt@google.com" <justinstitt@google.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH v2] octeontx2-af: fix build warnings flagged by
 clang, sparse ,kernel test robot
Message-ID: <20250317170154.GF688833@kernel.org>
References: <20250305094623.2819994-1-saikrishnag@marvell.com>
 <20250306164322.GC3666230@kernel.org>
 <BY3PR18MB470761F0063CA2AA4481DF7CA0D12@BY3PR18MB4707.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB470761F0063CA2AA4481DF7CA0D12@BY3PR18MB4707.namprd18.prod.outlook.com>

On Tue, Mar 11, 2025 at 08:57:22AM +0000, Sai Krishna Gajula wrote:

...

> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > > b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > > index cd0d7b7774f1..c850ea5d1960 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > > @@ -591,7 +591,7 @@ static void rvu_check_min_msix_vec(struct rvu
> > > *rvu, int nvecs, int pf, int vf)
> > >
> > >  check_pf:
> > >  	if (pf == 0)
> > > -		min_vecs = RVU_AF_INT_VEC_CNT + RVU_PF_INT_VEC_CNT;
> > > +		min_vecs = (int)RVU_AF_INT_VEC_CNT +
> > (int)RVU_PF_INT_VEC_CNT;
> > >  	else
> > >  		min_vecs = RVU_PF_INT_VEC_CNT;
> > >
> > 
> > I think that in the light of Linus's feedback and the subsequent patch that
> > demoted -Wenum-enum-conversion from W=1 to W=1 this is not necessary.
> 
> Ack, will ignore these changes which are flagged by  -Wenum-enum-conversion

Thanks,

FTR this should have read "from W=1 to W=2"

...

