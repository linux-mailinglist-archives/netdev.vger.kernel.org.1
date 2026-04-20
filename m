Return-Path: <netdev+bounces-279860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LvSFMlf5mkqvgEAu9opvQ
	(envelope-from <netdev+bounces-279860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:18:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E770C430F10
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C6F3293262
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304433A9FF;
	Mon, 20 Apr 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksmEw8KY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C75331A78
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700583; cv=none; b=jmWo25F46YA32EXJlNTU0FWXv+0okuWWW6TvBFI7oVu7pGP2a3hsR9+j3LxRoH/cQKw0Cp2Z0eaAjN/J0l87LBfTGiEDU/KaX4HjE/I1MRfqm8b1N/4YGIf+WL6KTKSnI11l2XMEtmt2ebyfTGsbVCitXMV/X2DXnrv8iPDQGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700583; c=relaxed/simple;
	bh=9Qgqeri4ieAdo6+5MWuNmYIp4MCTl3DLSaPutxRqWfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTvga64kYBZdnkfEEYtmdFqiezo90n6R7nHNdO2fNUbvqwMt6DIuUz/k5hmtUVarQ1KrfUfeie7operY/EKnDrBmAlzxmoREAWnFyN31yq9cAM4mJp7HYfSKy3YN3XXkBFVxG8+S1IwsNofjf2fH0d5VaIH+vxrOgijISGLB5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksmEw8KY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37D6C19425;
	Mon, 20 Apr 2026 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776700583;
	bh=9Qgqeri4ieAdo6+5MWuNmYIp4MCTl3DLSaPutxRqWfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksmEw8KYLFBEBK2tCdF7SXGEKmpxM7ZICe3lhvRKln9sXBeFa2xWxzLFjbC5vrc13
	 /WbPEX4nslhLuPVukFOPgxQiWh5raYTvk3f+21U1GLBrIyhe+B05EMYDrgo1N3hrlQ
	 JkYk+tUCAhA29Y6fn8UCJiw6xLCidkOv6vXTr3p9XGs1J6vmnh2AjGXW8LEiyFjZaT
	 uHuqXIP4CqZtieutBJ7lO/MyogE32IXEa7NFgXQ+L4jZmJp5bqONbZdibB471R6oGv
	 k1fOEYGPzteio9nK9ycuEf7mAZiYKqr5YhQWPlrUY7n+YBqvp6ELPuvez97WFtyOfI
	 j8qUoiy9mbmMA==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	jan.glaza@intel.com
Subject: Re: [PATCH iwl-net 3/4] ice: support RDMA on 4+-port E830 devices
Date: Mon, 20 Apr 2026 16:56:04 +0100
Message-ID: <20260420155604.576318-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417062954.1241900-4-aleksandr.loktionov@intel.com>
References: <20260417062954.1241900-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279860-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E770C430F10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: support RDMA on 4+-port E830 devices

This patch narrows the RDMA capability check to keep RDMA enabled for E830
devices configured with more than 4 ports, as they do not share the
limitations of E810 and E82X devices.

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2509,7 +2509,7 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
>  		caps->maxtc = 4;
>  		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
>  			  caps->maxtc);
> -		if (caps->rdma) {
> +		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
>  			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
>  			caps->rdma = 0;
>  		}

Does this leave the diagnostic message further down out of sync with the
new condition?

If the device is an E830 with more than 4 ports, RDMA remains enabled, but
because the dev_info() call just below this block is evaluated for all
devices with more than 4 ports:

ice_recalc_port_limited_caps() {
	if (hw->dev_caps.num_funcs > 4) {
		...
		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
			caps->rdma = 0;
		}

		/* print message only when processing device capabilities
		 * during initialization.
		 */
		if (caps == &hw->dev_caps.common_cap)
			dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");
	}
}

Could this cause confusion by logging a warning about RDMA being disabled
when it is actually active?

