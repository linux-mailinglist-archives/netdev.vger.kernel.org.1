Return-Path: <netdev+bounces-63056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8255A82AF3F
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 14:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D351F2291F
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15FD15E89;
	Thu, 11 Jan 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olppppiJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFE171AE
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 13:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094CBC43390;
	Thu, 11 Jan 2024 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704978706;
	bh=dEUoOzbDSUs2ajAA/+VFBTHK/an89vyrW+ZYe9968ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olppppiJwdWh9QNKijoUO5xiB1QNBaAzpx2fhXu6wY9rgbnfiUGNinohXzzdJ7Us3
	 I7raQAFAkz8S6GFodC3upVdpqyRX3hOh58IPnArlpnbbTM/P+6IRaljZAho0KVceLZ
	 pDH8IEFVYs8OjirJ3nbQiiM0W+X515VBo/A+EydDH1Eph2/8fZNZO8lF7a7xR+l8rm
	 qTC7nVpWaZQKoh1o5qvu8YLNvt29031s/YIZ8KqnEc33Y1olBuqQ41PE/3MUY1RS+M
	 NbeY2KaYs5tZk12maPdisQ4HNNz/WV5Ekb1q41TqqvOsvmnrS7trtRpbBP9rHZuQXq
	 q3+GN9SphHZ0g==
Date: Thu, 11 Jan 2024 13:11:42 +0000
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, ivecera@redhat.com,
	netdev@vger.kernel.org, Martin Zaharinov <micron10@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net] i40e: Include types.h to some headers
Message-ID: <20240111131142.GA45291@kernel.org>
References: <20240111003927.2362752-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111003927.2362752-1-anthony.l.nguyen@intel.com>

On Wed, Jan 10, 2024 at 04:39:25PM -0800, Tony Nguyen wrote:
> Commit 56df345917c0 ("i40e: Remove circular header dependencies and fix
> headers") redistributed a number of includes from one large header file
> to the locations they were needed. In some environments, types.h is not
> included and causing compile issues. The driver should not rely on
> implicit inclusion from other locations; explicitly include it to these
> files.
> 
> Snippet of issue. Entire log can be seen through the Closes: link.
> 
> In file included from drivers/net/ethernet/intel/i40e/i40e_diag.h:7,
>                  from drivers/net/ethernet/intel/i40e/i40e_diag.c:4:
> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:33:9: error: unknown type name '__le16'
>    33 |         __le16 flags;
>       |         ^~~~~~
> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:34:9: error: unknown type name '__le16'
>    34 |         __le16 opcode;
>       |         ^~~~~~
> ...
> drivers/net/ethernet/intel/i40e/i40e_diag.h:22:9: error: unknown type name 'u32'
>    22 |         u32 elements;   /* number of elements if array */
>       |         ^~~
> drivers/net/ethernet/intel/i40e/i40e_diag.h:23:9: error: unknown type name 'u32'
>    23 |         u32 stride;     /* bytes between each element */
> 
> Reported-by: Martin Zaharinov <micron10@gmail.com>
> Closes: https://lore.kernel.org/netdev/21BBD62A-F874-4E42-B347-93087EEA8126@gmail.com/
> Fixes: 56df345917c0 ("i40e: Remove circular header dependencies and fix headers")
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Hi Tony,

I agree this is a good change to make.
But I am curious to know if you were able to reproduce
the problem reported at the link above.
Or perhaps more to the point, do you have a config that breaks
without this patch?

