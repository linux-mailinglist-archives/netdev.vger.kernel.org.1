Return-Path: <netdev+bounces-101886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B67E9006CF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14E228996A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD8196D99;
	Fri,  7 Jun 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwSdjwlX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66619309E;
	Fri,  7 Jun 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771205; cv=none; b=Y97B2Nx8GGaOrnN/wW/AmtkAL2gZdwy4wt+1fZedwef/MB/L86AxRBjyGDEkpB9AyuBG7BX9vWqI6bmvweHhWmP5HyxbIH7Lv1e3jbrPIRb46SFguQOUVTDlrU8Hrs08zmpx/glvIlO3NIzJ0zBuzHnnlRDjNG/AIxsnVUkBLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771205; c=relaxed/simple;
	bh=I6gDSg7VhqM9/5mk6lCNJ/fsbvIDwjgfk9iO0qxF0lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7Y6Y9VEAIQOX0EB9DvBLbfV8JkScPc5f49gIvapTPJ1ymPp/AqIGuuZQ3BUS5ZH4SCNKkr/1X3okTIwm5UAooMBpLWZHCmeu1C32lap6f4a2TVzT9E8DW2Pv8YUOejRRIszm/pH+1nvOwazTUUO+D0KTHsP/UsopdLi/Lz6fj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwSdjwlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10870C2BBFC;
	Fri,  7 Jun 2024 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771204;
	bh=I6gDSg7VhqM9/5mk6lCNJ/fsbvIDwjgfk9iO0qxF0lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwSdjwlXSkOw7OEdLjP8/jJKkzIHgodn6+dTidEMo51evGFWGs4RTIhGOhOnZDkYX
	 Aq3LV7RRCQVF/gc2q8Gk1kKxnTAuPfGJUuATgAeszWmh9od3o5LUYzYRamPCFpKjOc
	 cxK8MjhoJVTUQRFyWf3T0OziPyQq93Sf1uCNlbPtQr4asB+rg/rXONnxb20dQoe+ir
	 EKWnYDcumFMXWvSSt82/RTMLIedJxuL4kVkoVlmQWl0Y5x3eMur6jU4SrIUDg7oeE+
	 Er6d4Av8gd1HVva/D9gVChOH26nfrpqLJSR3rS+lFjC6eraov9Ktvtv9pw2ZOulJkO
	 E6EOaLr13QTdg==
Date: Fri, 7 Jun 2024 15:39:59 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: Hariprasad Kelam <hkelam@marvell.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588
 being cleared on link-down
Message-ID: <20240607143959.GE27689@kernel.org>
References: <20240607081855.132741-1-csokas.bence@prolan.hu>
 <PH0PR18MB4474DC325887DE80C1A2D7F0DEFB2@PH0PR18MB4474.namprd18.prod.outlook.com>
 <8be22ec7-0d91-46ba-b45e-4499b547a8d3@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8be22ec7-0d91-46ba-b45e-4499b547a8d3@prolan.hu>

On Fri, Jun 07, 2024 at 11:12:56AM +0200, Csókás Bence wrote:
> Hi!
> 
> On 6/7/24 10:32, Hariprasad Kelam wrote:
> > > FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which makes
> > > all 1588 functionality shut down on link-down. However, some functionality
> > > needs to be retained (e.g. PPS) even without link.
> > > 
> > 
> > 
> >      Since this patch is targeted for net, please add fixes tag.
> 
> This issue has existed for "practically all time". I guess if I had to pick
> one commit, it would be:
> 
> Fixes: 6605b730c061 FEC: Add time stamping code and a PTP hardware clock
> 
> I don't know if it makes sense to add this ancient commit from 22 years ago,
> but if so, then so be it.

Thanks Csókás,

The practice is to use use even ancient commits in Fixes tags,
as it indicates how far back backports should go in theory,
even if backports don't go that far back in practice.

