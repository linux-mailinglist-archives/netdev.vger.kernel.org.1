Return-Path: <netdev+bounces-30824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCBE7892CE
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163B128196A
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63FD381;
	Sat, 26 Aug 2023 00:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802637F
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 00:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC56C433C8;
	Sat, 26 Aug 2023 00:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693011298;
	bh=/yywbGq6ACHFhnVK1HEPC1x6NEHvjwMXNT4AE6QpBpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TeWq8O4es9uTN7wHQKmtKLZwe41v4hN/Yrigp2WZf+YdtRtAkvpx+lCIkdJ6DWI4w
	 4SoI9qSjI0htVCG97rEOx2Q9EDFJGrVIgAtJ55IA+v2TQIKIS87jMQGfe56DAQ/ZBS
	 TKKIfmiDlD2ca3U65flk4CUWZmzx6s2ya6dfGt18eKdHpG4NNFA0lzlwXlEiHi8/aK
	 ALCxB4Ot3xFqCu5zaK60qeIygX4zimv17ukrTDXw87qPUXdJ5ssl1dtzXHojB2xQuD
	 U2x7nyJk3PlMEEepqJeGXjFghAbpd6JierHd1P9vgQc6JUi4mTzh3HxiPoWtw10dwL
	 lC3qhVSTYfuNw==
Date: Fri, 25 Aug 2023 17:54:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "idosch@nvidia.com" <idosch@nvidia.com>
Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Message-ID: <20230825175456.44051773@kernel.org>
In-Reply-To: <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230824085459.35998-1-wojciech.drewek@intel.com>
	<20230824083201.79f79513@kernel.org>
	<MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 11:01:07 +0000 Drewek, Wojciech wrote:
> > Can you say more? We have ETHTOOL_MSG_MODULE_GET / SET, sounds like
> > something we could quite easily get ethtool to support?  
> 
> So you're suggesting that ethtool could support setting the maximum power in the cage? 
> Something like:
>  - new "--set-module" parameter called "power-max"
>  - new "--get-module" parameters: "power-max-allowed",
>   "power-min-allowed" indicating limitations reported by the HW.

Yup. Oh, nice you even CCed Ido already :)

> About the patch itself, it's only about restoration of the default
> settings upon port split. Those might be overwritten by Intel's
> external tools.

I guess, the thing that sent me down the path of putting the control
in hands of the user more directly was the question of "why do we need
to reset on port split"? Why is that a policy the driver is supposed
to follow?

