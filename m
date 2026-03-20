Return-Path: <netdev+bounces-270046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNI3AwmhvWkM/wIAu9opvQ
	(envelope-from <netdev+bounces-270046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:33:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB832E00AC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91CD6305C327
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7B3F65F0;
	Fri, 20 Mar 2026 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7E0ALlx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC43EE1CF
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034890; cv=none; b=Q2QUVRigonH0n7S0xNaG3KxoMahTmJInci9dcm/AFLyO9AoVccGZNrW9xPbn2ffgpJ250FuMNaX+0woh04BxWG4jsDMR5WZUkBtAotQmxyllG4RSq96XriAdZssEuFC29Wxk3s9lb+V9D9VRHyipTRQ5Qc3Ry5uYimc14wjVD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034890; c=relaxed/simple;
	bh=hRCyxeO+q0UWavMXDa0++bIl1kG/fqO+nKzwc907+eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOBOBDunczTNEb2mTm+KDWBZwgqPPq7fjF0RtgRw/buGYs7e5FX/K52MP+QvplBiMA7KyOn2GrL3/yIGQJmO23xhjb5phAMXGRRr5S6DgCyaUORUuq4tB2aH4In3iQIK0TLM1dPF8ehKgJBlJ3RIvtUKk1O/ekTg0FImA9sodTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7E0ALlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C283AC2BCC6;
	Fri, 20 Mar 2026 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774034890;
	bh=hRCyxeO+q0UWavMXDa0++bIl1kG/fqO+nKzwc907+eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7E0ALlxYyOyPYGw7aZp0bTZ1fpK6livtLn3GPHRL2jNvow0C/lU+5onFW94aYrSR
	 rvI7nJkwF9PNs3ursmjCZ8X58o5wWth5vYg6RmRK2riQ9WofOtx/IA1LYLoojrGVNq
	 bjrw4K33mGSXnpCtFczZEfjgKWulwgUCHcP1dEKwGJoDLP6mPP5z+9XOVZ1Mdv4c2i
	 jR5A0FqqtwGBSTnxPO89QtG4ISN72idMT5PkfrrBwu0kMz22s09Bz3kqIfFY/ldfc9
	 M/TZaP50oJ7WS0hd5KQze81bGMdlL8h1S8MdErmf6UCFDxvq2SsCh7GsfyMU6XiDKZ
	 o22EauwjlkIig==
Date: Fri, 20 Mar 2026 19:28:06 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
Subject: Re: [PATCH iwl-next] ice: fix allocating excessive memory in
 ice_create_lag_recipe()
Message-ID: <20260320192806.GA167844@horms.kernel.org>
References: <20260320050529.422444-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050529.422444-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270046-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 9AB832E00AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:05:29AM +0100, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> For some reason ice_create_lag_recipe() allocates an array of 64
> struct ice_aqc_recipe_data_elem elements, while it only needs one (1).
> Fix it, while also using kzalloc_obj().
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This doesn't seem to be a bug.

So think we can drop the fixes tag.  And, it might be best to drop the
"fix" language from the subject and commit message.

