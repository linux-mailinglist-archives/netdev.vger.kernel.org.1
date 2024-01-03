Return-Path: <netdev+bounces-61345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB39823799
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 23:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1E9B2138A
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788C1DA40;
	Wed,  3 Jan 2024 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knI+w+SJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5341DA3D
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 22:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AACC433C7;
	Wed,  3 Jan 2024 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704320216;
	bh=4yG1RM6b8MssAz2wDMDWD1yEEfnNE+i4e2Et5B0292E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=knI+w+SJ5M+FXls7Fw4yHflTjBlKpFWqtOqE+bW2Wxlvdz2jODyRxxr1h+sAKf2y+
	 srpGb5o26mJ053amnxUdDX9PWr/22gxORcd4Ep/NiXXA/gMDJlMFMHGDMLFgHWyeNq
	 2IjoYxv8OC3mmzIDflAru2d/+eHfncwsFBjP72GJeraGwYgbTVTUlazwL/qTKqQRdh
	 1fqeKl5Mhv7I+ib/wZRgLEr8DXhd6hGRJWR6MvdXbJqZGh1CmnCE0FtwKXjPZ739Ze
	 OeK64Z76oomzKQX7vu8jc6vni3hzr12rHVTev9JyErj1xC/rfNjgAZO/+4EXpPeD/U
	 O1HbDoL/X7/Hw==
Date: Wed, 3 Jan 2024 14:16:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <corbet@lwn.net>,
 <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <vladimir.oltean@nxp.com>, <andrew@lunn.ch>, <horms@kernel.org>,
 <mkubecek@suse.cz>, <willemdebruijn.kernel@gmail.com>, <gal@nvidia.com>,
 <alexander.duyck@gmail.com>, <ecree.xilinx@gmail.com>, Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 2/2] net: ethtool: add a NO_CHANGE uAPI for new
 RXFH's input_xfrm
Message-ID: <20240103141654.44ac19e9@kernel.org>
In-Reply-To: <34b00cfb-d1d7-4468-948b-a44591dc5923@intel.com>
References: <20231221184235.9192-1-ahmed.zaki@intel.com>
	<20231221184235.9192-3-ahmed.zaki@intel.com>
	<20240102160526.6178fd04@kernel.org>
	<34b00cfb-d1d7-4468-948b-a44591dc5923@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 08:40:47 -0700 Ahmed Zaki wrote:
> On 2024-01-02 17:05, Jakub Kicinski wrote:
> > On Thu, 21 Dec 2023 11:42:35 -0700 Ahmed Zaki wrote:  
> >> +	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
> >> +	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))  
> > 
> > This looks fine, but we also need a check to make sure input_xfrm
> > doesn't have bits other than RXH_XFRM_SYM_XOR set, right?  
> 
> I wrote the xfrm as a  bitmap/flags assuming we can have multiple 
> transformations set. Not sure what future transformations will look like 
> (other than RSS-sort,... and discussed before).

Ack, but right now the only valid inputs for the kernel are
0 (disable all), RXH_XFRM_NO_CHANGE and RXH_XFRM_SYM_XOR.
We need to reject all other inputs. If we accept random
inputs without validation we won't be able to use them later.
Refer to many LWN articles about how some syscall didn't check
that unused flags are 0 and now they can't allocate bits.
Because some user space was passing in garbage.

> Else, we can do the check you mentioned or may be better to have it as 
> enum (which would give us 256, not 8, allowable transformations).

Given that RXH_XFRM_SYM_XOR is 1 we can change the exact semantics
later. All that matters is that we reject unsupported for now.

