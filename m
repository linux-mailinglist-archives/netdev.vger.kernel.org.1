Return-Path: <netdev+bounces-55613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE2080BA83
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FAA280D56
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC2D8BE6;
	Sun, 10 Dec 2023 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPxycj5O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D18BE1
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 11:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB93C433C7;
	Sun, 10 Dec 2023 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702209110;
	bh=8hTdvcrbcL4qIM6aKdbSw/ub3cwrRNRrsKXQOdmxI6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPxycj5O5P8obRqAFQ1tUfB/BjKIMpVQ3AwaD55Ua5e21OMrZVIcdcqnvvEvC2KLK
	 asPtbqD+AIlhzC6JR+sbjBhTJSfhiu8+oaDT2sQWy6c1lshihVAJlZ0X1huMs/iuDJ
	 qwDTeOQhuVvYWSh1xhXWVLd0oQqB3oi1IXjrfu1jPHYxcVHefsU76y8VoCRNKSlLuT
	 tidBxjdSDzJAUs+OW+NAz7gltROlX+D+ZwDKXFj+kQmEmdlkpPsyGEQdiZJ1RaYyrc
	 GZMihaMgnEF8EeZtalLTnglYRsUBVAcogVBVOpucgLcG8gMZ7p/lh77kQ5jVO3UPT0
	 Jm4Uf3xGs27Ig==
Date: Sun, 10 Dec 2023 11:51:45 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 2/2] igc: Check VLAN TCI mask
Message-ID: <20231210115145.GJ5817@kernel.org>
References: <20231201075043.7822-1-kurt@linutronix.de>
 <20231201075043.7822-3-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201075043.7822-3-kurt@linutronix.de>

On Fri, Dec 01, 2023 at 08:50:43AM +0100, Kurt Kanzenbach wrote:
> Currently the driver accepts VLAN TCI steering rules regardless of the
> configured mask. And things might fail silently or with confusing error
> messages to the user.
> 
> There are two ways to handle the VLAN TCI mask:
> 
>  1. Match on the PCP field using a VLAN prio filter
>  2. Match on complete TCI field using a flex filter
> 
> Therefore, add checks and code for that.
> 
> For instance the following rule is invalid and will be converted into a
> VLAN prio rule which is not correct:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan 0x0001 m 0xf000 \
> |             action 1
> |Added rule with ID 61
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 61
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        VLAN EtherType: 0x0 mask: 0xffff
> |        VLAN: 0x1 mask: 0x1fff
> |        User-defined: 0x0 mask: 0xffffffffffffffff
> |        Action: Direct to queue 1
> 
> After:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan 0x0001 m 0xf000 \
> |             action 1
> |rmgr: Cannot insert RX class rule: Operation not supported
> 
> Fixes: 7991487ecb2d ("igc: Allow for Flex Filters to be installed")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


