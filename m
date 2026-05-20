Return-Path: <netdev+bounces-290085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJKhBoU4DmpC8gUAu9opvQ
	(envelope-from <netdev+bounces-290085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:41:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9527C59C315
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 101693037DF3
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE8352026;
	Wed, 20 May 2026 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce+NKsSm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703834A3C4
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306873; cv=none; b=dpvR+9vHA9ePIWzvVhYNaGUZEDAUhsb8p97APJulCqzCWn78yalndQG60dGj61h8QUpiQycT+m+bQYbDCpx7R4H7KPJYHyEOJIDX5lInMO2CJM6+IRrgWlBIzsSyF33gIaZjMglrMfyKYC71oY2OVT8zXANPS/8zVhfBGL6s7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306873; c=relaxed/simple;
	bh=aB+z5ENZCHbOPB7WVjKyve84qWX2Al4grhne60hCxQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU2UBut6zIRAJhEMBz1WP2HxpSDofagg2IoccJy9UPir3A8XPQT0zV95ssNqZEJHDY/mI4uMGZCGummicNRsiPnZKV2PVG9JiNRKSTvGriOexRYm9Mg+h6hI5ktbBgsnvMX15LuF1sn+Bey6giSOBot3/Nz4nkgdm4smaOrF1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce+NKsSm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13C41F000E9;
	Wed, 20 May 2026 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779306872;
	bh=G+DkWppDiIQaaJG07hShhTboOcGlWOtoOML2qdJZ3YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ce+NKsSmWEcnyvxeORWtfGC3KmzFh5DypKUSWRbpoOICfiFU2pPuQAQS75q/X4ceN
	 H1BmJhOdFBBJ3nuO9k+r6kLBTPHY1MKZNHWzOpvtAko7DVvgLGSC0gezsJfqirOATZ
	 ZjgCc35CVlFrlExqfdTdFl9irm1wk30lxWxVgFt7cIN6x8GlY40xB6j/YIpOB9U4qo
	 kmgqJurQ0jVAk9Ms0Xq/nU2p6p3U/YZTX4f5PWQXEo95pPsHAxaQ+GDrBDpsgnX22L
	 V6pLZ5FbTSfmBiXnBQJGiLSCtEQGtCPL9GhmjxtK/8ZJpowleSfWceUhSDEKUkpMvC
	 /pKdNo2mORkPQ==
Date: Wed, 20 May 2026 20:54:28 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, hmohsin@meta.com
Subject: Re: [PATCH net 0/2] net: shaper: fix VALID confusion even more
Message-ID: <20260520195428.GA1506108@horms.kernel.org>
References: <20260515221325.1685455-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515221325.1685455-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290085-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 9527C59C315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 03:13:23PM -0700, Jakub Kicinski wrote:
> Sashiko reported another pre-exising issue in the previous
> batch of fixes:
> https://sashiko.dev/#/patchset/20260510192904.3987113-7-kuba@kernel.org
> 
> Turns out I over-esitmated the guarantees of the XArray flags.
> Stop using them completely.
> 
> Jakub Kicinski (2):
>   net: shaper: annotate the data races
>   net: shaper: rework the VALID marking (again)

Sashiko suggests updating the wording of the VALID flag
comment in net_shaper_pre_insert as part of the second patch.
But, TBH, I don't feel strongly about that.

For the series:
Reviewed-by: Simon Horman <horms@kernel.org>

