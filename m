Return-Path: <netdev+bounces-51383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BE87FA73E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778691F20F1C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A33FB0B;
	Mon, 27 Nov 2023 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApaAD5lm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BA3FB05;
	Mon, 27 Nov 2023 16:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34DBC433CA;
	Mon, 27 Nov 2023 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701104153;
	bh=z8KCkkZNLqEq+EoG4f1wJkwaMH1lYNHFYV6XyQ+Y8LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ApaAD5lmJaaOwDNmhqKgvGY1DEd0Ta8O46rH9L9dM4TmWKob8VQU9/x6KvoLB58nY
	 oWVPsrBHAw91L66h5i7JWdvBhC8rnAA1dgU4AK25IuzIEEAC52DdIURCACc7IFDeTd
	 H+hh4iOD5KIJtwtKSmO7VZ9OiaW98JtC03jXSfiQk2Sar5O8YuhznNTNVhTvtrly9F
	 iukymwGCI6hMhf6P9vaBSb4mEvXh957GZX2NZscQixT8wBio47kB5wkQmden2dMxmQ
	 gqjEDOFHKdU00wjYwy38Cb+Jnxg8VG4j/2mPfugCr2Bm6lTEDhBc+Yc2BMDtNTIcpD
	 u7AI9jciuTBvA==
Date: Mon, 27 Nov 2023 08:55:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree <ecree.xilinx@gmail.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <corbet@lwn.net>, <jesse.brandeburg@intel.com>,
 <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
 <horms@kernel.org>, <mkubecek@suse.cz>, <willemdebruijn.kernel@gmail.com>,
 <gal@nvidia.com>, <alexander.duyck@gmail.com>, <linux-doc@vger.kernel.org>,
 Igor Bagnucki <igor.bagnucki@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
Message-ID: <20231127085552.396f9375@kernel.org>
In-Reply-To: <4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
	<20231120205614.46350-2-ahmed.zaki@intel.com>
	<20231121152906.2dd5f487@kernel.org>
	<4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 07:14:51 -0700 Ahmed Zaki wrote:
> >   - First simplify the code by always providing a pointer to all params
> >     (indir, key and func); the fact that some of them may be NULL seems
> >     like a weird historic thing or a premature optimization.
> >     It will simplify the drivers if all pointers are always present.
> >     You don't have to remove the if () checks in the existing drivers.
> > 
> >   - Then make the functions take a dev pointer, and a pointer to a
> >     single struct wrapping all arguments. The set_* should also take
> >     an extack.  
> 
> Can we skip the "extack" part for this series? There is no 
> "ETHTOOL_MSG_RSS_SET" netlink message, which is needed for user-space to 
> get the ACK and adding all the netlink stuff seems a bit out of scope.

Fair point, yes, that's fine.

BTW, Ed, this series will conflict with your RSS context rework.
Not sure if it is on your radar.

