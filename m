Return-Path: <netdev+bounces-306309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AVAPBKTKT2q5oQIAu9opvQ
	(envelope-from <netdev+bounces-306309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:21:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 267C4733684
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="i/ncqXIg";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306309-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306309-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8CF8301DCEB
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8F383999;
	Thu,  9 Jul 2026 16:14:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4142DA32
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 16:14:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613665; cv=none; b=CEW2XtZNQd4UrKIfQ4+9dX2bK//h0INxKsc+5FrD/gpTogakNk5efKwg2sO064u7/2WHJk8OnSX7gSDD+DtbezI+dqyvSgO4Mx+/BJK07jtqdF+K4nogUtwiOALr0eu5prmpqA58NaFsByUZbRBl80u4vqXpnIYO0pZSpNhOyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613665; c=relaxed/simple;
	bh=X/QdVOHcwtPjC9ep19LYI+8j5R0gFX+vain61FL7feU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFS5B7VnheGRfLXm2gyp/Adr8E3TApR6FGpcnppziQgiTc56BjmKT7qj2XNElGI/kv/nC2ULyS01qNijL5JwSXQaRX0DTHAH7aVy6m81vkhqldJ0N065IPeq9tok85skjwV+vd/9GOhS/68Ooc77SJ9TlmdXGGxwWLih7iSzMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/ncqXIg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5C51F000E9;
	Thu,  9 Jul 2026 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783613663;
	bh=GdYKxyrukzOCUj5NQSUsx29G1+lE43S/PZWNMBMhcIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i/ncqXIgLcS0ZRhGdfko7ryWwaWdZmgd258KLZFRqbUFgkmQRIYJDSNZAb/HayKLo
	 9x7iSItpxeKmoRDy7khqeNEh+39ii/BGLkOPoqAxl5Z/wGP1ZlOrsHUkjqFZdLCIrT
	 4kq078RhGupfII20QpO28YAiri3d3tjx6zDkusit77oceuRrzD8/OdTXxpOdMWnGb4
	 b+x7d6gb67iZYQ3l8V8a+Y0tRaj/nN992aGSS2vFz5QbgE6rmDLj5KTk7j+0qCtcQ9
	 VAYfOfhC8VglQGMJua28zUCJeoMm8JnbnnczTAlIm8UEGLrO1/AdzVX4Uknx/DRYt2
	 m3BeAEx0a5TIA==
Date: Thu, 9 Jul 2026 17:14:18 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/3] net: airoha: rename airoha_priv_flags to
 airoha_dev_flags
Message-ID: <20260709161418.GQ1364329@horms.kernel.org>
References: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>
 <20260703-airoha-ethtool-priv_flags-v8-1-015ba5ac89ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-airoha-ethtool-priv_flags-v8-1-015ba5ac89ee@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306309-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:aleksander.lobakin@intel.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 267C4733684

On Fri, Jul 03, 2026 at 11:19:25AM +0200, Lorenzo Bianconi wrote:
> Rename the airoha_priv_flags enum to airoha_dev_flags and the
> AIROHA_PRIV_F_WAN flag to AIROHA_DEV_F_WAN. The "priv_flags" naming
> dates back to an earlier design that used ethtool private flags; since
> this series switched to tc qdisc offload for LAN/WAN configuration,
> align the naming to reflect that these are per-device flags rather than
> ethtool private flags. No functional change.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


