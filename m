Return-Path: <netdev+bounces-282342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PjtDzne8Wn3kwEAu9opvQ
	(envelope-from <netdev+bounces-282342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:32:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C745E492F97
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD61A3013EDE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2553DE427;
	Wed, 29 Apr 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDSdjthw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09A3D091F;
	Wed, 29 Apr 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458740; cv=none; b=SRxrObPtvPM2roFmX4sbRG71V27e+yUy2jeatWiSK5JTxi7KFKqmTa3D9Fw7hD8psY8g4Y0bmAKvN8NiwOQyBfe2Bp6e+yDRfnyrrYISUjPqGA7uUfC7v0AOawAyX37SCiUlJ+2cYW6tTJ1BsDP5EKBK+d6zzGWpwWNLRb9lgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458740; c=relaxed/simple;
	bh=duAsDJqmbqNJ9PlYMKXHs5Ry2vjSnimCTEf03ja5FRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTKfUXvaNJ6rghLH0OKCyd3Y69+sOP5em7hrRuIf3D44uUVFb6bOsWdTGnky/JHex60076HeKCeDtGEXFaMvtLlkkBqIOBj579owqaIeC6+hMr9h6KQXywKcgt6fCJ6Vn2U457ZKMsyuVtd/FS8lRYChGYziAaCc9dB8YOQf4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDSdjthw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0034AC19425;
	Wed, 29 Apr 2026 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777458740;
	bh=duAsDJqmbqNJ9PlYMKXHs5Ry2vjSnimCTEf03ja5FRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDSdjthwmycI1JuMkY+YoDIMxrV1zeGppZFXcAlagvK0BOvUCw0EICd1Da+IjHAqL
	 Nl/cHxSqotsKTTxJZnMV5zmmfot+IhZebTQ2sZqZyVmgzwTnCBs7HiknXhpIJI6M6J
	 O14UMbwWo68lWQHPX24mFeirz8BK84v6OwGSU1IbHzNmiZGH/WH+cagv0FxNZqqY5k
	 Rr9MKZwVGMF89IjlZPsjFmV7I/JLRAmqLteA2SpIh/vtDMJDwHhCtw1UMaPvac1XKY
	 miLFtDFJHCPTjxdY/u3kh1A76JTASCGaYN1kzv0CUD2cwTrZ4qV6ZaSUs5eZJNDsWM
	 3j3wBk9RUb/BA==
Date: Wed, 29 Apr 2026 11:32:15 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Petr Oros <poros@redhat.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: fix stats array overflow when VF requests more
 queues
Message-ID: <20260429103215.GY900403@horms.kernel.org>
References: <20260427151827.43342-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427151827.43342-1-mschmidt@redhat.com>
X-Rspamd-Queue-Id: C745E492F97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-282342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,atlassian.net:url]

On Mon, Apr 27, 2026 at 05:18:26PM +0200, Michal Schmidt wrote:
> When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
> ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
> The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
> followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
> stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
> alloc_txq/alloc_rxq to the new larger value, but
> ice_vsi_alloc_stat_arrays() returns early because the stats already
> exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
> alloc_txq and writes beyond the bounds of the old, smaller
> tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
> metadata.

...

> See the linked RHEL Jira item for a reproducer.
> 
> Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
> Closes: https://redhat.atlassian.net/browse/RHEL-164321
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Assisted-by: Claude:claude-opus-4-6 semcode

Reviewed-by: Simon Horman <horms@kernel.org>


FTR: There is an AI generated review of this patch available on sashiko.dev.
I believe the issues flagged there pre-date this patch and do not impact
this patch. So while I do not think they should block progress of this
patch I suggest looking over them to see if any follow-up is warranted.

