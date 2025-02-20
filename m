Return-Path: <netdev+bounces-168168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BAA3DD90
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEF717D51F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663CC1D54CF;
	Thu, 20 Feb 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVsIe6gL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F358DF58;
	Thu, 20 Feb 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063553; cv=none; b=oNfKvCFLO3COk/oYHL2O9Xdg++dFaHtybFBx1C454/AddohLkKaxdrkrBIYkQQZqX+HoB5PTSgHBlF8F4rqZRiJqezhajG06cKnF6qmZC4PnGIGqvDg6w2lqLu4yZ8e/r7eiW1LaDNuZd9v+upLmotU+XTq1P8DH9wlZtdkxe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063553; c=relaxed/simple;
	bh=MMP4FPdql5WvdX7WzGJ+wFCey1YYR03dzrTF6bOjS4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldmckyYvY35+VeXkcjvvCcrsYXqjBoMssOQjeln4iM0hF2pkyMw/UGCfaSPPgQkABDQPBtuNFgmm7EodjM9xFrYUfaKZ812/eOK2f5xYv+DYEz0MX6fT6jPGwwKbQstSkMllIvSqri2GT+JhcZ+VTDpvwWJdverVhbPm5cvixYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVsIe6gL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502E7C4CED1;
	Thu, 20 Feb 2025 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063552;
	bh=MMP4FPdql5WvdX7WzGJ+wFCey1YYR03dzrTF6bOjS4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVsIe6gLh44Er3lzRLeU7F8t7GIvXkwR8HbpyvlSBMeF6ASi3Vl5zUWAVzgnNh0LR
	 j8MsM5fXaa71DGyotHPKEeKQbISsPzMIZrIdiHxj9gznqVetKT84qQ0M6ZJiXMSRTp
	 xR4JAl5FQdFwyjGENu1XYev2TriOH4zFyhcsINnEoKjayIp6/6xJF14ZuOdl0TYFdW
	 levFZirHbooVXRqFI9jG+S0UKT+1PGbV7XDXTtZ6ERjFsvFNIxmxkM+PZagdXo9ZhY
	 hRNHXJUdCl2S43sFrfcrQIqnpi7EBUZf1llOh4gUzu1q4q/BFNXPE70rbzivAAM0Zd
	 WARI+64HtNNyA==
Date: Thu, 20 Feb 2025 14:59:08 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: Re: [PATCH iwl-next v4 6/6] ice: enable LLDP TX for VFs through tc
Message-ID: <20250220145908.GD1615191@kernel.org>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
 <20250214085215.2846063-7-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214085215.2846063-7-larysa.zaremba@intel.com>

On Fri, Feb 14, 2025 at 09:50:40AM +0100, Larysa Zaremba wrote:
> Only a single VSI can be in charge of sending LLDP frames, sometimes it is
> beneficial to assign this function to a VF, that is possible to do with tc
> capabilities in the switchdev mode. It requires first blocking the PF from
> sending the LLDP frames with a following command:
> 
> tc filter add dev <ifname> egress protocol lldp flower skip_sw action drop
> 
> Then it becomes possible to configure a forward rule from a VF port
> representor to uplink instead.
> 
> tc filter add dev <vf_ifname> ingress protocol lldp flower skip_sw
> action mirred egress redirect dev <ifname>
> 
> How LLDP exclusivity was done previously is LLDP traffic was blocked for a
> whole port by a single rule and PF was bypassing that. Now at least in the
> switchdev mode, every separate VSI has to have its own drop rule. Another
> complication is the fact that tc does not respect when the driver refuses
> to delete a rule, so returning an error results in a HW rule still present
> with no way to reference it through tc. This is addressed by allowing the
> PF rule to be deleted at any time, but making the VF forward rule "dormant"
> in such case, this means it is deleted from HW but stays in tc and driver's
> bookkeeping to be restored when drop rule is added back to the PF.
> 
> Implement tc configuration handling which enables the user to transmit LLDP
> packets from VF instead of PF.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


