Return-Path: <netdev+bounces-230054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8FBE3544
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0458546011
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEEC32BF46;
	Thu, 16 Oct 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S88QvCmK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC93277B1;
	Thu, 16 Oct 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617304; cv=none; b=E54bq2yKrZXcR+XUejcZ+wxhUai288FHHt9UvrqQ/YNjHXxn8IycK32fQ1qC8hujH0O6GJOZWl3OI4aiPAtRedSoUS+1hdMYzbejUcUyW+PxQ4HU7VdImKvtaDsmJ/UA3qEk0V5GZMkiMXYr/tufFlY+O6Qf/nL6OdHXsgobu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617304; c=relaxed/simple;
	bh=B1TGXw1L6qQfCcImzs8S4QE/igsMCkjArNRXrhUVLLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKSWMxq9mjl9tG02sawgB5vaC5ykyVPWoQbYCQYodybEzvbcVKogJAtrXVpu/uVH4DAv+BHDAZNt9sTmY2/21wguSCfecrPkuWBR4GiG6AZkNyYJJcy6PerGGpEYNwMnryOylwm8A+tRWRcr7fwchfOiuvEEmvp4v9IR+mJPOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S88QvCmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE67C4CEF1;
	Thu, 16 Oct 2025 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760617303;
	bh=B1TGXw1L6qQfCcImzs8S4QE/igsMCkjArNRXrhUVLLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S88QvCmK4feAx0AtpyRsTM+oE4AM3tLj/GJH4DDVj1BtVKgeonPy7KLqQVhmJ5wDs
	 9gsJzcpARnrLMTEmJXbEgv3r3tL0MshWn+99qNwiD2Dlnn4nwPBheJiWxi3W/qZocR
	 185lNlOTXMNVtMKGLnTRFYUyiR1aYb84J03yLUWFgHA0vjA0EbMQ1wchw5ABSk1qoV
	 lVWJP35pBTntnZZI+iyGJBBCUlLIfIU26eyjODL+bzAiO2y1vFZtQWppv9PlTXFTLA
	 HwKkSUfBFrvFnde3pw0CZn7aYTql9B9pPMBIJ8J9zuNVLRMWBN9CELzm60FRgH/wzW
	 sh7Ou8np3BzoQ==
Date: Thu, 16 Oct 2025 13:21:37 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dan Nowlin <dan.nowlin@intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>, Jie Wang <jie1x.wang@intel.com>,
	Junfeng Guo <junfeng.guo@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
Message-ID: <aPDjUeXzS1lA2owf@horms.kernel.org>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
 <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>

On Wed, Oct 15, 2025 at 12:32:02PM -0700, Jacob Keller wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Consolidate updates to the Protocol Type (PTYPE) bitmap definitions
> across multiple flow types in the Intel ICE driver to support GTP
> (GPRS Tunneling Protocol) encapsulated traffic.
> 
> Enable improved Receive Side Scaling (RSS) configuration for both user
> and control plane GTP flows.
> 
> Cover a wide range of protocol and encapsulation scenarios, including:
>  - MAC OFOS and IL
>  - IPv4 and IPv6 (OFOS, IL, ALL, no-L4)
>  - TCP, SCTP, ICMP
>  - GRE OF
>  - GTPC (control plane)
> 
> Expand the PTYPE bitmap entries to improve classification and
> distribution of GTP traffic across multiple queues, enhancing
> performance and scalability in mobile network environments.
> 
> --

Hi Jacob,

Perhaps surprisingly, git truncates the commit message at
the ('--') line above. So, importantly, the tags below are absent.

Also, the two lines below seem out of place.

>  ice_flow.c |   54 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Co-developed-by: Jie Wang <jie1x.wang@intel.com>
> Signed-off-by: Jie Wang <jie1x.wang@intel.com>
> Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c | 52 +++++++++++++++----------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

...

