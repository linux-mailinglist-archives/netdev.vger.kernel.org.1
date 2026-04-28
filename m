Return-Path: <netdev+bounces-281849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bg9CU+48GlwXgEAu9opvQ
	(envelope-from <netdev+bounces-281849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:38:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E554548602E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67038346EC0E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A986A44B690;
	Tue, 28 Apr 2026 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K7ZXU0pL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FB42EEDE;
	Tue, 28 Apr 2026 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380918; cv=none; b=PBUXw2oD+QnztDbi6IibjpSmAOjvo/1tASHwJ4p4yfKfyylPr1ab4ihXpUoXHFY/Cv9NQdcO4Ti4nK7+Dh2U1EOJFmF56CFWorBzi1apawVu2PUv3KAhaNEJCyqKlkKO2o05xGHJS/YGZAluQiUWq+eTQdQIIqR+U1KsRVwgRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380918; c=relaxed/simple;
	bh=a1ZZm/Iozun+ZbTEhHDPr3ej5NSHii1BqGtjixoOkL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StQ+mXeVju8FAudw6zQw9mSu0ZKuo7bfZh6lI0AmkBoEEJxgCnbciXalUmAbsqmfI41Mrk3g2LfQ2WHDR5DQCC8kXEdzYi6F9CSWXXqFTo/wazsDk0ITtHqJs8lzUv+A/neXQLoNiww9daYRVPEeFg7z60WiZ3UQFsIVwLWJXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K7ZXU0pL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fUaCObTGRM6UBfBvOpQYGdHAf6QVLe7Kbol2ukJsrC0=; b=K7ZXU0pLa/LfeR89XUrfMS/bCU
	o7bgwA7P2X0VpFw48MCbjA5Fs5VkQu9jWOnqrQWYJDc311ji5jHvvtzaEOMVv2A4MRylDBBpELMzO
	jdOn63t3LxkOQv+x4FGwD1Mg/xDpCHow4Rk/Cz7g/qMhNPyYJBGd9lR3zGdnHJKNS+Xc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHhxq-000Kod-J7; Tue, 28 Apr 2026 14:54:58 +0200
Date: Tue, 28 Apr 2026 14:54:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Berman <benjamin.s.berman@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: thunderbolt: enlarge RX/TX ring and set NAPI
 weight for sustained load
Message-ID: <e6a249d5-8b11-43cf-89ee-14d436c70cf8@lunn.ch>
References: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
 <20260428015521.3454006-3-benjamin.s.berman@gmail.com>
 <20260428074253.GP557136@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428074253.GP557136@black.igk.intel.com>
X-Rspamd-Queue-Id: E554548602E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281849-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,anthropic.com:email]

On Tue, Apr 28, 2026 at 09:42:53AM +0200, Mika Westerberg wrote:
> On Mon, Apr 27, 2026 at 06:55:21PM -0700, Benjamin Berman wrote:
> > The default TBNET_RING_SIZE of 256 and the NAPI_POLL_WEIGHT of 64
> > implicit in netif_napi_add() are too small for host-to-host Thunderbolt
> > networking under sustained bulk traffic.  Running NCCL all-reduce over
> > tb-lo on a three-node chain (two TB3 endpoints plus a TB4 Maple Ridge
> > transit) produces rx_missed_errors at ~1 % of rx_packets on the transit
> > and ~0.6 % on the endpoints, with rx_packets stalling against a peer's
> > continuing tx_packets.
> > 
> > Raise TBNET_RING_SIZE to 2048 (8x) and use netif_napi_add_weight() with
> > a per-NAPI weight of 256 so tbnet_poll() drains more frames per softirq
> > invocation.  With matching sysctls (net.core.netdev_budget=1024,
> > net.core.netdev_budget_usecs=8000) rx_missed_errors stays below 0.005 %
> > over a 192 GB all-reduce workload on the same hardware.
> > 
> > Generated-by: Claude Opus 4.7 <claude-opus-4-7@anthropic.com>
> > Tested-by: Benjamin Berman <benjamin.s.berman@gmail.com>
> > Signed-off-by: Benjamin Berman <benjamin.s.berman@gmail.com>
> 
> For ring size I don't have any objections. The current ring size 256 is
> arbitrary and at the time seemed reasonable.
> 
> For the poll weigth there is the comment in netdevice.h:
> 
> /* Default NAPI poll() weight
>  * Device drivers are strongly advised to not use bigger value
>  */
> #define NAPI_POLL_WEIGHT 64
> 
> But if you see improvement using 256 here I'm fine with that unless the
> network folks advice otherwise.

I just did a quick sample of other drivers which change the NAPI
weight. Of the 10 i looked at, 9 reduced the weight. Only one
increased it.

I would like the core netdev people to comment on this, before it is
accepted.

Questions which come to mind:

Why is the polling not happening frequently enough? 

Is it frequently swapping between polling and interrupts?

Is there interrupt coalesce going on, and the coalesce time set too
high, so that by the time the interrupt fires the ring is full? Can
you play with ethtool -C?

	Andrew


