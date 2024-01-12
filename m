Return-Path: <netdev+bounces-63353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5382C5DD
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 20:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146221F2173B
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFB715AE7;
	Fri, 12 Jan 2024 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb2Cm4Xi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB015AC9
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 19:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E296C433C7;
	Fri, 12 Jan 2024 19:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705087672;
	bh=/htuLTQELgiq2v9t2djukaAwxAo9F9LALpfsK5RHuVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jb2Cm4XiRM0rFTwhfu9xiC+nda1zDdFa8R2+umuEDwKAzexXPyeRvw6j12kM0CUyi
	 YcRjJDXCsA8C7rHMGAhmL58WK9CkwprJ+x6JbjNP17V7wgFiaADKpuPbFty64Qsfeq
	 ocggNifBBhmrOZZxTK56qPHONTAYfdApr6TBnMD8iJH/iGDcEPVzhZJ27txvUoGrUZ
	 ElNIzk7JfvdbotQIuACUmkZYFxJMrWD/Xjuyon+wAoLRWPAoFlTXl6Vv+zAy5qeffO
	 PuiQnZwTcKhfVwcmvt6NkqCvTUTLOHrUMtd1Zb3Jqv98Yk5o3rgxRWgP7t07X0JRt2
	 Glxr6i2QJLcIQ==
Date: Fri, 12 Jan 2024 19:27:48 +0000
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, ivecera@redhat.com,
	netdev@vger.kernel.org, Martin Zaharinov <micron10@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net] i40e: Include types.h to some headers
Message-ID: <20240112192748.GB392144@kernel.org>
References: <20240111003927.2362752-1-anthony.l.nguyen@intel.com>
 <20240111131142.GA45291@kernel.org>
 <81e01a6b-2dd4-731a-570c-58944c5fc9b0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e01a6b-2dd4-731a-570c-58944c5fc9b0@intel.com>

On Thu, Jan 11, 2024 at 09:00:30AM -0800, Tony Nguyen wrote:
> 
> 
> On 1/11/2024 5:11 AM, Simon Horman wrote:
> > On Wed, Jan 10, 2024 at 04:39:25PM -0800, Tony Nguyen wrote:
> > > Commit 56df345917c0 ("i40e: Remove circular header dependencies and fix
> > > headers") redistributed a number of includes from one large header file
> > > to the locations they were needed. In some environments, types.h is not
> > > included and causing compile issues. The driver should not rely on
> > > implicit inclusion from other locations; explicitly include it to these
> > > files.
> > > 
> > > Snippet of issue. Entire log can be seen through the Closes: link.
> > > 
> > > In file included from drivers/net/ethernet/intel/i40e/i40e_diag.h:7,
> > >                   from drivers/net/ethernet/intel/i40e/i40e_diag.c:4:
> > > drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:33:9: error: unknown type name '__le16'
> > >     33 |         __le16 flags;
> > >        |         ^~~~~~
> > > drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:34:9: error: unknown type name '__le16'
> > >     34 |         __le16 opcode;
> > >        |         ^~~~~~
> > > ...
> > > drivers/net/ethernet/intel/i40e/i40e_diag.h:22:9: error: unknown type name 'u32'
> > >     22 |         u32 elements;   /* number of elements if array */
> > >        |         ^~~
> > > drivers/net/ethernet/intel/i40e/i40e_diag.h:23:9: error: unknown type name 'u32'
> > >     23 |         u32 stride;     /* bytes between each element */
> > > 
> > > Reported-by: Martin Zaharinov <micron10@gmail.com>
> > > Closes: https://lore.kernel.org/netdev/21BBD62A-F874-4E42-B347-93087EEA8126@gmail.com/
> > > Fixes: 56df345917c0 ("i40e: Remove circular header dependencies and fix headers")
> > > Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > 
> > Hi Tony,
> > 
> > I agree this is a good change to make.
> > But I am curious to know if you were able to reproduce
> > the problem reported at the link above.
> > Or perhaps more to the point, do you have a config that breaks
> > without this patch?
> 
> Hi Simon,
> 
> Unfortunately, I was not able to reproduce the problem. Since it was
> fairly straightforward on what was happening, I made the patch and Martin
> confirmed it resolved his issue.

Thanks, I agree this seems straightforward.

Reviewed-by: Simon Horman <horms@kernel.org>

