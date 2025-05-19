Return-Path: <netdev+bounces-191610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB7ABC6EB
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F84188C62F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64726656D;
	Mon, 19 May 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gaHdvqY2"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24EF1F2BB8
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678223; cv=none; b=TkJoQE9EYaQ4DW8eWLLANeJ6rNGEVLhl0jPlOU+M5FIQY/WMCLGI/70096lqOMHMlEjiWpcJC/ErCJnPemLzTx54i390N7qhLMj89Q4cz4QTxmh/4UI7Mc0bdB4jC9Xc1y5meF50EpnjM7LhwHRjfAWv0wfXNhDDE0OXjZxUM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678223; c=relaxed/simple;
	bh=LnYkAPd36XTGcadNiI+c6HhVZDT0kXBC/MH9tFxGy8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQa1rLCGhgYTVLTHIerNbx7NqKkzCXyaoJFBgZP3bgrKEsaFsj7ovGerktbpQUIZnve1gphg/Oii7vLW5ZfBhiHmLtfvCxRnMrRdAeXUmiUvJl5Htd93UOUdiBVkv8D5IjbEaBWYf7EORWh7ObrqR01vzFjU8iLClLXz216fiBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gaHdvqY2; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdfbbdca-001b-4ed5-92ff-40fd3a8e3341@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747678219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyMjGq7CIo1Ix6y7J/Aaf3P2JOQ8ZABmbRvvSeNXTAo=;
	b=gaHdvqY2JIJOTR1JlRCXgG+/mlzaSw8i0xZPPOWLqYrV6iHZ+ccjsICnzaPZpPTTlvlOZN
	aH+50Syp1uUDXoH4dA5AdjOxbhraOvIDQEhVn6YvuAO2xlzHxavxYYIEBIdvpbPUony6Ar
	fWHy5JZBBV7cAXL3OBsmijryUGvpnLQ=
Date: Mon, 19 May 2025 14:10:12 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v4 03/11] net: phylink: introduce internal
 phylink PCS handling
To: Daniel Golle <daniel@makrotopia.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-4-ansuelsmth@gmail.com>
 <5d004048-ef8f-42ad-8f17-d1e4d495f57f@linux.dev>
 <aCOXfw-krDZo9phk@makrotopia.org>
 <7b50d202-e7f6-41cb-b868-6e6b33d4a2b9@linux.dev>
 <aCQHZnAstBXbYzgy@makrotopia.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aCQHZnAstBXbYzgy@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/13/25 23:00, Daniel Golle wrote:
> On Tue, May 13, 2025 at 03:23:32PM -0400, Sean Anderson wrote:
>> On 5/13/25 15:03, Daniel Golle wrote:
>> > just instead of having many
>> > more or less identical implementations of .mac_select_pcs, this
>> > functionality is moved into phylink. As a nice side-effect that also
>> > makes managing the life-cycle of the PCS more easy, so we won't need all
>> > the wrappers for all the PCS OPs.
>> 
>> I think the wrapper approach is very obviously correct. This way has me
>> worried about exciting new concurrency bugs.
> 
> You may not be surprised to read that this was also our starting point 2
> months ago, I had implemented support for standalone PCS very similar to
> the approach you have published now, using refcnt'ed instances and
> locked wrapper functions for all OPs. My approach, like yours, was to
> create a new subsystem for standalone PCS drivers which is orthogonal to
> phylink and only requires very few very small changes to phylink itself.
> It was a draft and not as complete and well-documented like your series
> now, of course.
> 
> I've then shared that implementation with Christian and some other
> experienced OpenWrt developers and we concluded that having phylink handle
> the PCS lifecycle and PCS selection would be the better and more elegant
> approach for multiple reasons:
>  - The lifetime management of the wrapper instances becomes tricky:
>    We would either have to live with them being allocated by the
>    MAC-driver (imagine test-case doing unbind and then bind in a loop
>    for a while -- we would end up oom). Or we need some kind of garbage
>    collecting mechanism which frees the wrapper once refcnt is zero --
>    and as .select_pcs would 'get' the PCS (ie. bump refcnt) we'd need a
>    'put' equivalent (eg. a .pcs_destroy() OP) in phylink.
> 
>    Russell repeatedly pointed me to the possibility of a PCS
>    "disappearing" (and potentially "reappearing" some time later), and
>    in this case it is unclear who would then ever call pcs_put(), or
>    even notify the Ethernet driver or phylink about the PCS now being
>    available (again). Using device_link_add(), like it is done in
>    pcs-rzn1-miic.c, prevents the worst (ie. use-after-free), but also
>    impacts all other netdevs exposed by the same Ethernet driver
>    instance, and has a few other rather ugly implications.

SRCU neatly solves the lifetime management issues. The wrapper lives as
long as anyone (provider or user) holds a reference. A PCS can disappear
at any point and everything still works (although the link goes down).
Device links are only an optimization; they cannot be relied on for
correctness.

>  - phylink currently expects .mac_select_pcs to never fail. But we may
>    need a mechanism similar to probe deferral in case the PCS is not
>    yet available.

Which is why you grab the PCS in probe. If you want to be more dynamic,
you can do it in netdev open like is done for PHYs.

>    Your series partially solves this in patch 11/11 "of: property: Add
>    device link support for PCS", but also that still won't make the link
>    come back in case of a PCS showing up late to the party, eg. due to
>    constraints such as phy drivers (drivers/phy, not drivers/net/phy)
>    waiting for nvmem providers, or PCS instances "going away" and
>    "coming back" later.

This all works correctly due to device links. The only case that doesn't
work automatically is something like

MAC built-in
  MDIO built-in
    PCS module

where the PCS module gets loaded late. In that case you have to manually
re-probe the MAC. I think the best way to address this would be to grab
the PCS in netdev open so that the MAC can probe without the PCS.

>  - removal of a PCS instance (eg. via sysfs unbind) would still
>    require changes to phylink. there is no phylink function to
>    impair the link in this case, and using dev_close() is a bit ugly,
>    and also won't bring the link back up once the PCS (re-)appears.

This works just fine. There are two cases:

- If the PCS has an IRQ, we notify phylink and then it polls the PCS
  (see below).
- If the PCS is polled, phylink will call pcs_get_state and see that the
  link is down.

Either way, the link goes down. But bringing the link back up is pretty
unusual anyway. Unlike PHYs (which theoretically can be on removable
busses) PCSs are generally permanently attached to their MACs. The only
removable scenario I can think of is if the PCS is on an FPGA and the
MAC is not.

So if the PCS goes away, the MAC is likely to follow shortly after
(since the whole thing is on a removable bus). Or someone has manually
removed the PCS, in which case I think it's reasonable to have them
manually remove the MAC as well. If you really want to support this,
then just grab the PCS in netdev open.

>  - phylink anyway is the only user of PCS drivers, and will very likely
>    always be. So why create another subsystem?

To avoid adding overhead for the majority of PCSs where the PCS is built
into the MAC and literally can't be removed. We only pay the price for
dynamicism on the drivers where it matters.

> All that being said I also see potential problems with Christians
> current implementation as it doesn't prevent the Ethernet driver to
> still store a pointer to struct phylink_pcs (returned eg. from
> fwnode_pcs_get()).
> 
> Hence I would like to see an even more tight integration with phylink,
> in the sense that pointers to 'struct phylink_pcs' should never be
> exposed to the MAC driver, as only in that way we can be sure that
> phylink, and only phylink, is responsible for reacting to a PCS "going
> away".

OK, but then how does the MAC select the PCS? If there are multiple PCSs
then ultimately someone has to configure a mux somewhere.

> Ie. instead of fwnode_phylink_pcs_parse() handing pointers to struct
> phylink_pcs to the Ethernet driver, so it can use it to populate struct
> phylink_config available_pcs member, this should be the responsibility
> of phylink alltogether, directly populating the list of available PCS in
> phylink's private structure.
> 
> Similarly, there should not be fwnode_pcs_get() but rather phylink
> providing a function fwnode_phylink_pcs_register(phylink, fwnode) which
> directly adds the PCS referenced to the internal list of available PCS.

This is difficult to work with for existing drivers. Many of them have
non-standard ways of looking up their PCS that they need to support for
backwards-compatibility. And some of them create the PCS themselves
(such as if they are PCI devices with internal MDIO busses). It's much
easier for the MAC to create or look up the PCS itself and then hand it
off to phylink.

> I hope we can pick the best of all the suggested implementations, and
> together come up with something even better.

Sure. And I think we were starting from a clean slate then this would be
the obvious way to do things. But we must support existing drivers and
provide an upgrade path for them. This is why I favor an incremental
approach.

--Sean

