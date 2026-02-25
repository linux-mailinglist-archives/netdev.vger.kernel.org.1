Return-Path: <netdev+bounces-260865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHN1LcfLnmnNXQQAu9opvQ
	(envelope-from <netdev+bounces-260865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:15:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B41959C5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECB89300F581
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F02BE65F;
	Wed, 25 Feb 2026 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWrjYKI9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9382BE7C6
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014532; cv=none; b=pdnmra0tDhPOLSidgRZjhwl5scs6gI+Ymw7ML9au6lruK6b4lszmiEHOJkVdjZOPtE3ooUs3GwsAeQ7CRf5yh/RsuU2pLmiLepOtkEJhL9mvQHT2dwYrl50uTZqWxEyPo5eFPKHh/jToAm/fJ046oxPxZNkk+AxzmDTNFOIItb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014532; c=relaxed/simple;
	bh=la5l3tmm9VgUaAKbSveODFwXjKNCLaluNNlPXBLN8HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6k6yCEndV0v2QWlf+gUGTlEbAbEB+sIHCOUGgeqEmp651geyTrHNgAntVUaPLVDtRijIcqJSe1MA0R+TgvyS+uq2HRLGyaE8MI/trcLZ2alrUKxmuL7LZvRc7RF1p4PP3Ht1unZliDuhSrPsQnSZXVEP7nYIswckNk7qWeD6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWrjYKI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5EEC19423;
	Wed, 25 Feb 2026 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772014532;
	bh=la5l3tmm9VgUaAKbSveODFwXjKNCLaluNNlPXBLN8HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWrjYKI9tt2sMnNPyFMBbpvE3NgZWgKknoOKEi67iRk5S2NxGftUPKohJHlBwCCnN
	 SJEquZYRQyCSL7WJ/gYD6jByRTuYhF6BxvXNbxEvQKnLeINU4xvGFDpYmuK/4tkUPQ
	 9PRMk6CxdQgtzc2soqUVeNFuwiYcIqtzlpYoyDz8zsDROUgGzvlFrmM97EaqbfvrrA
	 JkNGAQZZtH+4q7gox5Sxjig+e9OSJOf0sS44EUFqkOiNqUvD6g5PJRrF4wr9uKhKCS
	 6ibvy0IfEn7lbHjBuoyysL7Y+ZulICmk68KN+2sLIYg9GNY9wpeuWjBY6Zvdgdea04
	 nfNRdCS/V34zQ==
Date: Wed, 25 Feb 2026 10:15:27 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: fix interrupt coalescing
Message-ID: <aZ7Lv38VkVKNkxIs@horms.kernel.org>
References: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260865-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C9B41959C5
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 09:01:13AM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> While cleaning up the descriptor handling, I noticed that the accounting
> of transmit "packets" for interrupt coalescing was buggy in that it
> takes the difference of the two indexes into the circular list of
> transmit discriptors and merely subtracts one from the other without
> regard for the indexes wrapping.
> 
> This can result in a negative number or very large positive number
> which would have the effect of either reducing tx_q->tx_count_frames
> or making that very large.
> 
> Either way, the result is numerically incorrect, and could trigger
> interrupts or not trigger interrupts when required.
> 
> This series converts stmmac to use the circ_buf helpers, and then fixes
> this problem.
> 
> v2: move build fix to correct patch
> 
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 28 ++++++++---------------
>  1 file changed, 10 insertions(+), 18 deletions(-)

Thanks Russell.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>

