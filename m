Return-Path: <netdev+bounces-38449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73777BAF7A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 02:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D77CF281FCB
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DBB197;
	Fri,  6 Oct 2023 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs0d6zN4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45413161
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 00:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403F2C433C7;
	Fri,  6 Oct 2023 00:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696550854;
	bh=B2CKgcUESG9sHzctWkCdF8yue1SaiZCavMR3sep1Cs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gs0d6zN487ejNGpSgbJuDZ6Blsq/jFUzEnBqN32luADSagqn+FRgCznCVraX4X/Mk
	 U2B380X9tv95jCX6WuIrloQXRbX+PTARGFJAzI7UeAgZ1frjOUejN89+eVJQQJ1qSx
	 EF/1IVbuFQ3zKhI3ktOD1Uc7qwDixONb6zI+ozYJzF8xnbsqFDifwiw/hmZuD34qSq
	 uxbeDeF7Bj/0cg33y21nSmFSnyPXBSMeQWMUDntcbhu11nEDsjUg+GV9f6tRRhxVW7
	 xn5ri9XTgkdMbjSBkB4I0JyFUlMHmVYtl/IJwA210+3uHt6/NJbeXXQCZOoxOhgTa3
	 MAXv4hRm0VXYA==
Date: Thu, 5 Oct 2023 17:07:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org
Subject: Re: [PATCH v4 net-next 6/7] net: ethtool: add a mutex protecting
 RSS contexts
Message-ID: <20231005170732.7cdc15ad@kernel.org>
In-Reply-To: <70e5af64-b696-dec1-1afd-730559b96bfd@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
	<b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
	<20231004161651.76f686f3@kernel.org>
	<70e5af64-b696-dec1-1afd-730559b96bfd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 21:56:47 +0100 Edward Cree wrote:
> > Can we use a replay mechanism, like we do in TC offloads and VxLAN/UDP
> > ports? The driver which lost config can ask for the rss contexts to be
> > "replayed" and the core will issue a series of ->create calls for all
> > existing entries?  
> 
> I like that idea, yes.  Will try to implement it for v5.
> There is a question as to how the core should react if the ->create call
>  then fails; see my reply to Martin on #7.

Hm. The application asked for a config which is no longer applied.
The machine needs to raise some form of an alarm or be taken out
of commission. My first thought would be to print an error message
in the core, and expect the driver to fail some devlink health
reporter.

I don't think a "broken" flag local to RSS would be monitored, there'd
be too many of such local flags throughout the APIs. devlink health
may be monitored.

> > Regarding the lock itself - can we hide it under ethtool_rss_lock(dev)
> > / ethtool_rss_unlock(dev) helpers?  
> 
> Sure.  If I can't get replay to work then I'll do that.

