Return-Path: <netdev+bounces-272495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BOIAIpcxmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:31:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA4342930
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BC4F308EA76
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72963AA4FD;
	Fri, 27 Mar 2026 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3/6Hxm+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD613A759F;
	Fri, 27 Mar 2026 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607369; cv=none; b=e34cSO5ZnVExl1rD6VP8R8IRzBi2kLNLL4yakPo+FyLQxmvlh05AKw0w7ZICerKxL6R4nXM0/9lxIWcrTH/ZdkQaiqcer2duKGHRgsHgB1cDqrv3D5qn0AQKyRQH3OV7d8kNC7vKYxIaEXMMGCGzefWfAnstMONVA8Rp6FSAMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607369; c=relaxed/simple;
	bh=KJvE2/bPrNGOPxsHw5kAvsJmyAmIFF2r2alqDrMrz1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZiQIq+v19DDpgrMkcnG+LH49Lai+uMDkzU/nesvpUvw1pDGFt3yQ4gfLK9f/93NpkUINIC5fd7qBJ6L6voALQcOqNZPQA84RckU/d1nakRAbIghWP8X5L7JnpDF75kjaKyytL4EI5Qqm4wnC2lYP5YuVwHSO+Y8ii2rEEF/ohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3/6Hxm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE01C19423;
	Fri, 27 Mar 2026 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774607369;
	bh=KJvE2/bPrNGOPxsHw5kAvsJmyAmIFF2r2alqDrMrz1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3/6Hxm+5+mlvJOdbUTrhgx0o1IMGa0JWOLr81OqS4ZfTTZh5HaZtIsrBvTumBeBs
	 iF9bW+Gn+a1O5FSOvpU/EP5LojF8Moz/lKangXJnakIRPieO8VfgX7Nfg+2oiY/7Oc
	 ZphGb7PIx5Vpv/Mbpt59RagLz47CV2yZXiV+BWVSvlif9KJ1RQ2PB+PFBTSuFVjxM6
	 S7m9sM00nZhp2JyuuBw5NEowKFqcF7w5FSMMuqLYXtuHhxWYqVCxVg0YLu9IhLGp5Q
	 ldZuOWaZQpMOsPEfYJFKt7IY/NB5ON/0GqGQZpZ64lR7aCK0tEGqe88g1EB9XQxjQi
	 iHoZGH4kf4kVg==
Date: Fri, 27 Mar 2026 10:29:24 +0000
From: Simon Horman <horms@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, m-malladi@ti.com, jacob.e.keller@intel.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: fix missing data copy and wrong
 recycle in ZC RX dispatch
Message-ID: <20260327102924.GF111839@horms.kernel.org>
References: <20260325125131.53399-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325125131.53399-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272495-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 9DCA4342930
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ Meghana Malladi

On Wed, Mar 25, 2026 at 12:51:30PM +0000, David Carlier wrote:
> emac_dispatch_skb_zc() allocates a new skb via napi_alloc_skb() but
> never copies the packet data from the XDP buffer into it. The skb is
> passed up the stack containing uninitialized heap memory instead of
> the actual received packet, leaking kernel heap contents to userspace.
> 
> Copy the received packet data from the XDP buffer into the skb using
> skb_copy_to_linear_data().
> 
> Additionally, remove the skb_mark_for_recycle() call since the skb is
> backed by the NAPI page frag allocator, not page_pool. Marking a
> non-page_pool skb for recycle causes the free path to return pages to
> a page_pool that does not own them, corrupting page_pool state.
> 
> The non-ZC path (emac_rx_packet) does not have these issues because it
> uses napi_build_skb() to wrap the existing page_pool page directly,
> requiring no copy, and correctly marks for recycle since the page comes
> from page_pool_dev_alloc_pages().
> 
> Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi David,

Thanks for the update.
My understanding is that this addresses the review of v1.

Reviewed-by: Simon Horman <horms@kernel.org>

v1: https://lore.kernel.org/all/20260324211402.342474-1-devnexen@gmail.com/

Some points to keep in mind for the future:

* Please include a version number in the subject when posting versions >
  This helps a lot in tracking things.

  Subject: [PATCH v2] ...

* Please include the target tree. As a fix for code, which I asusme
  is present in net, in this case that would be the net tree.

  Subject: [PATCH net v2] ...

  Otherwise it would probably be the net-next tree.

* Please CC all relevant parties. In this case that would
  include Meghana as he provided review of v1.

* Please consider including a changelog, along with links to earlier
  versions below the scissors ("---")

* b4 can help with most of these things

* More information on the Netdev development process can be found at
  https://docs.kernel.org/process/maintainer-netdev.html

...

