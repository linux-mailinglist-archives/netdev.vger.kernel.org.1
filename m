Return-Path: <netdev+bounces-114106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F0940F79
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7211C22A79
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2A1A01B7;
	Tue, 30 Jul 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsQfo002"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E151A01AF
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335351; cv=none; b=VNCFuUUeQ3kE48QgG6oO5/PIgPwIh73UtNXJobiMASJwFYxYQS4u5wfJLPeJPJ3RZgirqtk5KGbDW/WgDcgmQTz1byn5GeOyqqwgqfPAfH9kCkh1RrE/YVTrGmMMV2Uutd8VWtFbTO45nmYPpVE6iiPlW/EVNo+a6gaLbS046sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335351; c=relaxed/simple;
	bh=+EXiI6Hi4bCwpc12uz2sKT7AB87QLqFQRMBMmdEGR+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk9zoqC4IlnAC/N1FywODbY8GYynO4P9FGV3oQsc0hlmyPSYQ3H2OojaCuzPbURRK3YyphtOzercsCVs4t4Dfzh2O24kNPolxj1iwpJZBWy6F5EUMgq4DSOvsNz/1qXr5WZeEvPVxuVqUJrRIOP9qmwYuiIwP+9nBlb74vsLaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsQfo002; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A3EC32782;
	Tue, 30 Jul 2024 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335351;
	bh=+EXiI6Hi4bCwpc12uz2sKT7AB87QLqFQRMBMmdEGR+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsQfo002tyk4otb6TmwUkFBd/hQaIYNdPZ73pCpa//ZnAKeQf5TpZGDUBIfwcNtke
	 txt5rjnGoiDm0m+YWJoCXeTgu6d0MnyjQgCI4Wz3Pq2EHSuWOLC84DAtqBb72W2pMy
	 Pv6f5uafRXRxBkQ1mc1x8yv3xT5mcSa+j1CZ6pNy7bkWmqwqIHbutSaNybD3aTybNv
	 aHo7P6X0OcOKTiuNp8MIWs5ipznnVXaxbElubXDsHONRsWsdVqkXH6eNMy85dR8qy4
	 dJrDjwU3GDGI5R2+xACIK8WOspG6QP7jmEI6rFBEG1spx4CfSbsYTgmKnjdokqNBlE
	 OFZtAwB6ljg9g==
Date: Tue, 30 Jul 2024 11:29:07 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	hkelam@marvell.com, Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH iwl-next v5 13/13] iavf: add support for offloading tc
 U32 cls filters
Message-ID: <20240730102907.GZ97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-14-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-14-ahmed.zaki@intel.com>

On Thu, Jul 25, 2024 at 04:08:09PM -0600, Ahmed Zaki wrote:
> Add support for offloading cls U32 filters. Only "skbedit queue_mapping"
> and "drop" actions are supported. Also, only "ip" and "802_3" tc
> protocols are allowed. The PF must advertise the VIRTCHNL_VF_OFFLOAD_TC_U32
> capability flag.
> 
> Since the filters will be enabled via the FD stage at the PF, a new type
> of FDIR filters is added and the existing list and state machine are used.
> 
> The new filters can be used to configure flow directors based on raw
> (binary) pattern in the rx packet.
> 
> Examples:
> 
> 0. # tc qdisc add dev enp175s0v0  ingress
> 
> 1. Redirect UDP from src IP 192.168.2.1 to queue 12:
> 
>     # tc filter add dev <dev> protocol ip ingress u32 \
> 	match u32 0x45000000 0xff000000 at 0  \
> 	match u32 0x00110000 0x00ff0000 at 8  \
> 	match u32 0xC0A80201 0xffffffff at 12 \
> 	match u32 0x00000000 0x00000000 at 24 \
> 	action skbedit queue_mapping 12 skip_sw
> 
> 2. Drop all ICMP:
> 
>     # tc filter add dev <dev> protocol ip ingress u32 \
> 	match u32 0x45000000 0xff000000 at 0  \
> 	match u32 0x00010000 0x00ff0000 at 8  \
> 	match u32 0x00000000 0x00000000 at 24 \
> 	action drop skip_sw
> 
> 3. Redirect ICMP traffic from MAC 3c:fd:fe:a5:47:e0 to queue 7
>    (note proto: 802_3):
> 
>    # tc filter add dev <dev> protocol 802_3 ingress u32 \
> 	match u32 0x00003CFD 0x0000ffff at 4   \
> 	match u32 0xFEA547E0 0xffffffff at 8   \
> 	match u32 0x08004500 0xffffff00 at 12  \
> 	match u32 0x00000001 0x000000ff at 20  \
> 	match u32 0x0000 0x0000 at 40          \
> 	action skbedit queue_mapping 7 skip_sw
> 
> Notes on matches:
> 1 - All intermediate fields that are needed to parse the correct PTYPE
>     must be provided (in e.g. 3: Ethernet Type 0x0800 in MAC, IP version
>     and IP length: 0x45 and protocol: 0x01 (ICMP)).
> 2 - The last match must provide an offset that guarantees all required
>     headers are accounted for, even if the last header is not matched.
>     For example, in #2, the last match is 4 bytes at offset 24 starting
>     from IP header, so the total is 14 (MAC) + 24 + 4 = 42, which is the
>     sum of MAC+IP+ICMP headers.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


