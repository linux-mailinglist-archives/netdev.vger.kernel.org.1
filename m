Return-Path: <netdev+bounces-277495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNuPJsMv2WkOnQgAu9opvQ
	(envelope-from <netdev+bounces-277495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:13:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA53DAF0D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5731E301372A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0643E277F;
	Fri, 10 Apr 2026 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0rH0ePo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0BB3E1CE7;
	Fri, 10 Apr 2026 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841082; cv=none; b=oS7Ws7bSma6lSixk4xNwuUYwCAZ2T4sXHuPUNvMmT2pLk3lOsqjalX72oPcwWCkJyF4niumQQp92hv1VmSHnnVjWJ88FFsJUPtwqS+9i4Lct+UhXfj5+isxsBItClPpzXdZBrbw/T64pBBclgW7SuJgdx3eNJRgNg8bGEoG4T6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841082; c=relaxed/simple;
	bh=mYIUZtZFHM8V6Qmy0sNWVV3DPCWZTFkkWg/yAONmQxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHah0YWXhPbrZGljidot9YtA3AtjRc/qnVGzWdY71zApRw5Qrem0J2H4I/66C5zW9AQAQlWgKDORIj7B5KMrodm6Sw4lwKN0KrdP0z0On0OPjY6jAWVkwndMRjvTRBWxpRLiRry8H1F30SYq0JDfXB2C+3Ju8fyydXnpxnur+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0rH0ePo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E1FC19421;
	Fri, 10 Apr 2026 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775841082;
	bh=mYIUZtZFHM8V6Qmy0sNWVV3DPCWZTFkkWg/yAONmQxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0rH0ePoyvO/B/VkFb+zXG+KuUpPP+dre/Cxg+plqC4AK5CZqxvtoAG5wdjfdS+Ve
	 fneygN85mSDJDxFuzQ2SN9D9QYB2Anj3hVTUU4n59dxqEekO5mc9ZUWGqhRKTNNzgc
	 IrI4S3g2lPN2iWDLSx2CeuDh8HRwUY+E1R7S+r68/NHt/ydRH1bwBXGapAC08QkO42
	 esVKId8IsWfrj83on2bsrpm/Ej/yKjpiv/+KMXBMtlVe3GTojugRN00sUvib0vZOrj
	 0xJcOFf5eojqXucU8qeoV9QT+EFpacUG056Zm9q+nVN9EdpzFGJERkn2VpTXHLVmUe
	 kSTfoxIxp4WNg==
Date: Fri, 10 Apr 2026 18:11:15 +0100
From: Simon Horman <horms@kernel.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: linux-ppp@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guillaume Nault <gnault@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Eric Woudstra <ericwouds@gmail.com>,
	Sam Protsenko <semen.protsenko@linaro.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
	Jaco Kroon <jaco@uls.co.za>,
	James Carlson <carlsonj@workingcode.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH net v4 2/2] pppoe: drop PFC frames
Message-ID: <20260410171115.GE469338@kernel.org>
References: <20260410033627.93786-1-qingfang.deng@linux.dev>
 <20260410033627.93786-2-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410033627.93786-2-qingfang.deng@linux.dev>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277495-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,debian.org,linutronix.de,gmail.com,linaro.org,ozlabs.org,uls.co.za,workingcode.com,intel.com,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09DA53DAF0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:36:21AM +0800, Qingfang Deng wrote:
> RFC 2516 Section 7 states that Protocol Field Compression (PFC) is NOT
> RECOMMENDED for PPPoE. In practice, pppd does not support negotiating
> PFC for PPPoE sessions, and the current PPPoE driver assumes an
> uncompressed (2-byte) protocol field. However, the generic PPP layer
> function ppp_input() is not aware of the negotiation result, and still
> accepts PFC frames.
> 
> If a peer with a broken implementation or an attacker sends a frame with
> a compressed (1-byte) protocol field, the subsequent PPP payload is
> shifted by one byte. This causes the network header to be 4-byte
> misaligned, which may trigger unaligned access exceptions on some
> architectures.
> 
> To reduce the attack surface, drop PPPoE PFC frames. Introduce
> ppp_skb_is_compressed_proto() helper function to be used in both
> ppp_generic.c and pppoe.c to avoid open-coding.
> 
> Fixes: 7fb1b8ca8fa1 ("ppp: Move PFC decompression to PPP generic layer")
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
> Changes in v4:
>  Update Fixes tag as suggested by AI review
>  Link to v3: https://lore.kernel.org/r/20260409031107.616630-2-qingfang.deng@linux.dev
> Changes in v3:
>  Fix kdoc warning
>  Link to v2: https://lore.kernel.org/r/20260408024245.312732-1-qingfang.deng@linux.dev

Reviewed-by: Simon Horman <horms@kernel.org>


