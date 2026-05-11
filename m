Return-Path: <netdev+bounces-286715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EXHAln6AWrjmwEAu9opvQ
	(envelope-from <netdev+bounces-286715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:48:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A597511879
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133153065CBA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228B402BBA;
	Mon, 11 May 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+chN3i9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF81402BAB
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514047; cv=none; b=cmkOPDEgFCIxLsJChVhEJMRq3WH5wr3OrmDMXJzZO4EyqRQF7HC2gafo0baINp4B+OX2eQMI/CY/11gEI1DF69/o6IzqW6yhiY3weIMQ/eFHsS/CYRKfcqpZPHiiHn6UPBXKOTnjxNvQ9UbD3D62DSLl+/foDZAM+akSnT8ToAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514047; c=relaxed/simple;
	bh=kMyxVFHBsTENAImGfysO/vdBf+qJS/bcyql+j8HczTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esg0Yt21bOUFqVnwlUhp0+kzaC7USvoSLRnTF8bqnnsVLYap47jrFwIn8jCI1rssMbp1X6QZPSsMcpqzBZ+IFQ223pvqxYGWncrJkKLoAgznYpAn/NkDQN7h8bN5k13TIStfZ2LzRJmhcuoKAssdAOI098SdJgV/KouzktVZar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+chN3i9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECEFC2BCB0;
	Mon, 11 May 2026 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514046;
	bh=kMyxVFHBsTENAImGfysO/vdBf+qJS/bcyql+j8HczTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+chN3i9ViZ7leomzi38CgzYvReG407/tsMJ6BPiS5NrTI93fdTcUvW3Utxw63crK
	 hLZ90JHMtJa7Tgb8bDPrsgvn3VVh827FJNz1LHHkPy07ii8h6KWsKimQN6SMP4kUcN
	 3qHuYbwdK3VrjzLz/3ZC/8DXzqEdldWhnapacgGOZ8BqXMhaQE9zMelYd+apSVjVzL
	 HftwDDfk43tgLzRzWvct0D0VJa86uw9+MVUSNx+DCzvwACPNPm5xmmYgOmwc4wGY7a
	 yLFlMQL9x2mqMciRTQw280fXeva/UYVK4QS1GKDMAYGWWZt+XaCwVSbiVmp3SntaFh
	 ExBrQpgzyz+jg==
Date: Mon, 11 May 2026 16:40:43 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 6/8] ixgbe: extract ixgbe_restart_auto_neg() to
 avoid code duplication
Message-ID: <20260511154043.GC27589@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-7-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508031226.3601800-7-aleksandr.loktionov@intel.com>
X-Rspamd-Queue-Id: 5A597511879
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286715-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,intel.com:email,sashiko.dev:url]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 05:12:24AM +0200, Aleksandr Loktionov wrote:
> From: Jakub Chylkowski <jakubx.chylkowski@intel.com>
> 
> Both ixgbe_setup_phy_link_generic() and ixgbe_setup_phy_link_tnx()
> end with the same three-line sequence that reads MDIO_CTRL1, sets
> the MDIO_AN_CTRL1_RESTART bit, and writes MDIO_CTRL1 back.
> 
> Factor it out into a static helper ixgbe_restart_auto_neg() and call
> it from both sites.
> 
> While at it, also check the return value of phy.ops.read_reg() in the
> helper and skip the write on failure.  The original inlined code
> ignored the read result and would OR MDIO_AN_CTRL1_RESTART into a
> stale autoneg_reg value (left over from the prior MDIO_AN_ADVERTISE
> write) and unconditionally write it back to MDIO_CTRL1 if the read
> failed.  This is a small behavioral change: on read_reg() failure the
> restart write is now skipped instead of being issued with a
> potentially garbage value.
> 
> Signed-off-by: Jakub Chylkowski <jakubx.chylkowski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FWIIW, the AI-generated review of this patch available on sashiko.dev
flags that similar problems wrt write on failre exist earlier on in
ixgbe_setup_phy_link_generic(). It may be good to address this area
more holistically as a follow-up. (I am not suggesting increasing
the scope of this patch/patch-set.)

...

