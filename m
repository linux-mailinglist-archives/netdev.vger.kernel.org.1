Return-Path: <netdev+bounces-275011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id auqiLXOyz2lczgYAu9opvQ
	(envelope-from <netdev+bounces-275011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:28:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D78E393FF8
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EB12301A16E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 12:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9E371894;
	Fri,  3 Apr 2026 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbmE9LQf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853736B05E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219311; cv=none; b=BK83iPXoyfVQE1VnGKPP+m4mL4pcEEgTvymmuawU+KehbmPz/fsgkuT55O6hx5SfObmdPoLgwy8LJGKC81oGzvyClO/z4S6yySXK6lNGOouC6qsQivtGjeyDQYwwzj7NjA75dgTEtKpX/yiZ+SSwH4zK2ua0n6JobrDw6s4Zvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219311; c=relaxed/simple;
	bh=F8iAS6pGjjZT/iyWHDVcTqPA4wqEVTbdVw3IDnLF1gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN3bx5XlUZ7t35zS75+J2CARduaBG0SOWHYk/JG9aZa11+0291mwd+EYUJoWI4FNGJrr6N+KF3ojtLJmDfgoz/LWcmOfXoCUsOVy21Mop6U0KNrBt9ZD+99Yl6C5YDtkmcIjuh+uHVMMczbM5d2qWu8g+1hnYnHjAQ7b3H/1cP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbmE9LQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB730C4CEF7;
	Fri,  3 Apr 2026 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775219310;
	bh=F8iAS6pGjjZT/iyWHDVcTqPA4wqEVTbdVw3IDnLF1gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbmE9LQfsSQmlOrk1+mqZopEkGj6UWlRErrTj/zoKIqPbXRnvOVtJoPvk889CM3dW
	 K/I40NZC5kkc2UmIF9hR6uKWDoL2I36noxC86NJnHEPwSMuBOBREPiO6b663fIvvy5
	 r8HyljcB/XAr05GemW855eifOOYWl9z27l/UiHAIzXncPBXJLo2MTDtQWS9WcdBBUK
	 97Z2j1ppg18/H9Te41Kq49R+d4TfhHoaW8AA5e7B97phIsTImSRadc40I65fsXUKQE
	 FcGs2rLBvhDfla91t++y1hfFo1qedsBPU8Sfe6VbRO18aKGI86IdpH2Iest4rJAuiN
	 HE2pocYfAMkkw==
Date: Fri, 3 Apr 2026 13:28:27 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
Subject: Re: [PATCH net] ice: fix setting promisc mode while adding VID filter
Message-ID: <20260403122827.GA85281@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-5-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275011-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 1D78E393FF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:23:28AM +0100, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> There are at least two paths through which VSI promiscuous mode can be
> independently configured via ice_fltr_set_vsi_promisc():
> - ice_vlan_rx_add_vid() (netdev op)
> - ice_service_task() -> ... -> ice_set_promisc()
> 
> Both paths may try to program promiscuous mode concurrently. One such
> scenario is:
> 
> 1. Add ice netdev to bond
> 2. Add the bond netdev to bridge
> 3. ice netdev enters allmulticast mode (IFF_ALLMULTI)
> 4. Service task programs promisc mode filter
> 5. Bridge -> bond calls ice_vlan_rx_add_vid()
> 
> Crucially, ice_vlan_rx_add_vid() fails if ice_fltr_set_vsi_promisc()
> returns any error, including -EEXIST. This causes VLAN filtering setup
> to fail on the bond interface. ice_set_promisc() already handles -EEXIST
> correctly.
> 
> Fix by adding the same -EEXIST check to ice_vlan_rx_add_vid(): if the
> promisc filter is already programmed, continue without returning error.
> 
> Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


