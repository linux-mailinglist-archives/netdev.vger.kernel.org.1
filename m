Return-Path: <netdev+bounces-280519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG0+NsEM6WmXTgIAu9opvQ
	(envelope-from <netdev+bounces-280519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:00:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE54497CA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F009E30315F6
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90083A4535;
	Wed, 22 Apr 2026 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxwr75Ax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722D38947E
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880826; cv=none; b=kw64SSXOgWwbAfWNMewUIWCliX/H/2lEB82tcAgLr427//sTRfPSjC54b+vS9VG3i3TcYBqWCittu392Y75n1wNkB8OuUy+PHwWY5S8DeeEw3PJYCRNgWn6aa7FS2Q0t0mYLkgk+Qj86ysLbsdh1nEgJrE3AM2nd7zSySN9ARTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880826; c=relaxed/simple;
	bh=vRGM5fdnwN3r2o7+o8B0zJJEj14G3ujdB0md67BxS6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idmNgHQJRnp8v+Bbf68Sp7B0jsMWJylc+/iBzbz9TNqUwyYwyQDh15Bm6sl3qmWSWVufQg0GRb7PgzzKQZ08wvFdeoldnkpMhVyA6BRUMFr7s5pBwlU5GQ5SzKt2UE+OrGLs6oSUFLBXvs1Tx7tAGS8O4m9TmIWT70L8GjnMGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxwr75Ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38913C19425;
	Wed, 22 Apr 2026 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776880826;
	bh=vRGM5fdnwN3r2o7+o8B0zJJEj14G3ujdB0md67BxS6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxwr75AxlCyeiQ/LwDiYJ6l6jyirk+bWY/wjemxm4nLyAhfeSFsmFZQoPm7m0R9GL
	 vej3+9Nj2Jd5LStc2cSPmc+kenIkHE9nBndhc3a0qFRm6uiVEy9SOJfqvqM13+LdwR
	 mZIBjarJwqbv69bCv3XggOay062kWmunTFUuzl9Ghq9tUmNz3QL2Q/aST6YuYSVxJq
	 Omgw3s0SktvAZDcbYodie12zJcwkkTDwL5eeAyvwSn1xuRVJiAlSGsVlMi2k9L1Xsw
	 yEcMLMAdl8Owo0+xYUKThD83rIOoXDZKv9vPgTcZI/ThPZOK6qfv4y3dbtUBQ+FtCJ
	 /JNFVVan13Xuw==
Date: Wed, 22 Apr 2026 19:00:20 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH iwl-net v1] ice: fix UAF/NULL deref when VSI rebuild and
 XDP attach race
Message-ID: <20260422180020.GQ651125@horms.kernel.org>
References: <20260418090137.411506-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418090137.411506-1-kohei@enjuk.jp>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280519-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,enjuk.jp:email]
X-Rspamd-Queue-Id: 4DDE54497CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 09:01:15AM +0000, Kohei Enju wrote:
> ice_xdp_setup_prog() unconditionally hot-swaps xdp_prog when
> ICE_VSI_REBUILD_PENDING is set. In the attach path, this can publish a
> new rx_ring->xdp_prog before rx_ring->xdp_ring becomes valid while the
> rebuild is pending. As a result, ice_clean_rx_irq() may dereference
> rx_ring->xdp_ring too early.
> 
> With high-volume RX packets, running these commands in parallel
> triggered a KASAN splat [1].
>  # ethtool --reset $DEV irq dma filter offload
>  # ip link set dev $DEV xdp {obj $OBJ sec xdp,off}
> 
> Fix this by rejecting XDP attach while rebuild is pending.
> Keep XDP detach allowed in this window. Detach clears rx_ring->xdp_prog,
> so the RX path will not attempt to access rx_ring->xdp_ring.
> 
> [1]
> BUG: KASAN: slab-use-after-free in ice_napi_poll+0x3921/0x41a0
> Read of size 2 at addr ffff88812475b880 by task ksoftirqd/1/23
> [...]
> Call Trace:
>  <TASK>
>  ice_napi_poll+0x3921/0x41a0
>  __napi_poll+0x98/0x520
>  net_rx_action+0x8f2/0xfa0
>  handle_softirqs+0x1cb/0x7f0
> [...]
>  </TASK>
> 
> Allocated by task 7246:
>  ice_prepare_xdp_rings+0x3de/0x12d0
>  ice_xdp+0x61c/0xef0
>  dev_xdp_install+0x3c4/0x840
>  dev_xdp_attach+0x50a/0x10a0
>  dev_change_xdp_fd+0x175/0x210
> [...]
> 
> Freed by task 7251:
>  __rcu_free_sheaf_prepare+0x5f/0x230
>  rcu_free_sheaf+0x1a/0xf0
>  rcu_core+0x567/0x1d80
>  handle_softirqs+0x1cb/0x7f0
> 
> Fixes: 2504b8405768 ("ice: protect XDP configuration with a mutex")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has provided some feedback on this patch.
However, I believe the issues it raises are not introduced
by this patch and should not block progress of it.
I'd like to ask if you could take a look over that feedback
and see if any follow-up is appropriate.

Thanks!

