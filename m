Return-Path: <netdev+bounces-275045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNO5FtrCz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:38:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8EB39495E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B8573013EF7
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA63B27C7;
	Fri,  3 Apr 2026 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtP4DPq+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78403AB286
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223394; cv=none; b=jvzW1b5HzLKxG2uNvF6OPmv+11433KIYi9fxUEcdGoi6oUDD5GqIfk4IzXY+ELMvjzG4WS1n2VBxMBW5u/2OhMpdbhu2w/woPXb54x5uWz8dM1CalquWu5rq/KMw+7uXwO5RaTgaI8HT+sp4WlTpFtGAgfTI1msUsgYJ5UgZ7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223394; c=relaxed/simple;
	bh=ZwehJ0cfzWa1ZDciwDC6ku8OtW6tyhu80bL6r2pUeBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxfg+9kCYHyXrfcLIktJcFgzEgtbvWRm5Aq9Xo5+fj+6l0Z82QW0fqqNSwK2D1orlom7TVzo5cCDJ+pBQTWeaukNBPSgKYc9bolS5Y6yrQvW2Rw7FMAS7D1wdt5+ljrlQIWyi7B0JWcZn7Y5ez/GFge72fI7ou1vuhIIQMJNyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtP4DPq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7CBC4CEF7;
	Fri,  3 Apr 2026 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223394;
	bh=ZwehJ0cfzWa1ZDciwDC6ku8OtW6tyhu80bL6r2pUeBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtP4DPq+DJ5BpMoipIhL3ue/oxwnt/P8be9NMrmbuMBtAEEYoBZ0WXrIvCM+uGT+7
	 wTmuVpCKuEoiHMbdYcmUxYzqN+AAKcCxmIDxHl4BaarYzYcvWdlX1bWU0cC1sH0ycQ
	 AO7vPHBTqILV5bZ6cVDn1F9yUk5+pFKoZwkQ4aYZBVjWTsrStyATIlJHGTKnhCxw9Q
	 uZj0q+XYTKQ3gDISIG5CoCsMTZ/L9xf51SZFIEnfVd+TVFA0IBEpSVoNh14zF0+G1q
	 RNL695RPDxSK/YImMYRFFe7Huo72y4F8n5I2RjS/Gw5v72t+fAq+Yi35rBeEvBEPmL
	 XdUK18A/Yhf+w==
Date: Fri, 3 Apr 2026 14:36:31 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH iwl-next] ixgbe: add bounds check for debugfs register
 access
Message-ID: <20260403133630.GD113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-2-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275045-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: BC8EB39495E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:30:36AM +0100, Aleksandr Loktionov wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Prevent out-of-bounds MMIO accesses triggered through user-controlled
> register offsets.  IXGBE_HFDR (0x15FE8) is the highest valid MMIO
> register in the ixgbe register map; any offset beyond it would address
> unmapped memory.
> 
> Add a defense-in-depth check at two levels:
> 
> 1. ixgbe_read_reg() -- the noinline register read accessor.  A
>    WARN_ON_ONCE() guard here catches any future code path (including
>    ioctl extensions) that might inadvertently pass an out-of-range
>    offset without relying on higher layers to catch it first.
>    ixgbe_write_reg() is a static inline called from the TX/RX hot path;
>    adding WARN_ON_ONCE there would inline the check at every call site,
>    so only the read path gets this guard.
> 
> 2. ixgbe_dbg_reg_ops_write() -- the debugfs 'reg_ops' interface is the
>    only current path where a raw, user-supplied offset enters the driver.
>    Gating it before invoking the register accessors provides a clean,
>    user-visible failure (silent ignore with no kernel splat) for
>    deliberately malformed debugfs writes.
> 
> Add a reg <= IXGBE_HFDR guard to both the read and write paths in
> ixgbe_dbg_reg_ops_write(), and a WARN_ON_ONCE + early-return guard to
> ixgbe_read_reg().
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This feels like a bug fix to me, assuming users can
cause out of range access using the debugfs 'reg_ops' interface,

If so I think it should have a Fixes tag and go via iwl-net.

...

