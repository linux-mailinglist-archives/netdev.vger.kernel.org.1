Return-Path: <netdev+bounces-201270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A3AAE8B1D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE53AE7BA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B702D4B66;
	Wed, 25 Jun 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAUuB3il"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808529B8D2;
	Wed, 25 Jun 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870843; cv=none; b=MtwZ9shNbCBdHAjagKr+0xylmkHaHAtIiQG+8WVwCWGgapmcQ3HwNxKsrNX7ny3mBrWKVRrPeNMY6RqFr3zWymE8cnWZqSxVlr46oRLDnGKyNb6ktDxj8xykTjZurHqqvSs+d6i2gXvxHYpHbpjHLM/yudjx4yWjV1UMi8LYlHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870843; c=relaxed/simple;
	bh=aPBndkhU0szBl/yyozdzHv6sCe4/Iyvy8ufD1xZzuOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHyZamlA8BnC977N8gX4ppx+lJDasocFxa9/xQDaBJFFVM4YWmk4JzLeE8c8d1E/+87dnercGT4kSlHiqTy4yepOeD6Q03v4zRi8kHBTWC3uThaZHKVw1hVZAhyiLqwBJ3vSpblUb6D/dezvBJczjT7T4tCeTOqFuHoeVy6sLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAUuB3il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3314BC4CEEB;
	Wed, 25 Jun 2025 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870843;
	bh=aPBndkhU0szBl/yyozdzHv6sCe4/Iyvy8ufD1xZzuOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAUuB3ildS9YIRI1zWU4suFBTWHJwoIspAtUQKSKlGIk3McJAzG0QyyVDSjybD0aq
	 bIeHpP1mfKi/wCqv806aSohjJ9s2YCKdeI/t1v/L36QS7YIOMAtPeM0NwvjCA6SIQq
	 m3+YuCP1HK6y2Qfy3bpVkpXKeTQbwwvFuIZHTQoB3kLJxfNCW+cSt6yyEosAX/v6hI
	 1RiquTH5U5MUPAJctL21s7cjFoHNhxuIeYoYzhW34zvFTnYWUigK313N+xZcq3zUb0
	 S8h5eLf8r73g7tACAqaMILjyXDLqq3cPS0WFxqCzkbe9pwyGTLqb0ibmihHjaFjx/s
	 7mjEiqD6izBYQ==
Date: Wed, 25 Jun 2025 12:00:42 -0500
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	Tonghao Zhang <tonghao@bamaicloud.com>
Subject: Re: [PATCH] bonding: don't force LACPDU tx to ~333 ms boundaries
Message-ID: <aFwrOs73E03Ifr-i@do-x1carbon>
References: <20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org>
 <2545704.1750869056@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2545704.1750869056@famine>

On Wed, Jun 25, 2025 at 09:30:56AM -0700, Jay Vosburgh wrote:
> Seth Forshee (DigitalOcean) <sforshee@kernel.org> wrote:
> 
> >The timer which ensures that no more than 3 LACPDUs are transmitted in
> >a second rearms itself every 333ms regardless of whether an LACPDU is
> >transmitted when the timer expires. This causes LACPDU tx to be delayed
> >until the next expiration of the timer, which effectively aligns LACPDUs
> >to ~333ms boundaries. This results in a variable amount of jitter in the
> >timing of periodic LACPDUs.
> 
> 	To be clear, the "3 per second" limitation that all of this
> should to conform to is from IEEE 802.1AX-2014, 6.4.16 Transmit machine:
> 
> 	"When the LACP_Enabled variable is TRUE and the NTT (6.4.7)
> 	variable is TRUE, the Transmit machine shall ensure that a
> 	properly formatted LACPDU (6.4.2) is transmitted [i.e., issue a
> 	CtrlMuxN:M_UNITDATA.Request(LACPDU) service primitive], subject
> 	to the restriction that no more than three LACPDUs may be
> 	transmitted in any Fast_Periodic_Time interval. If NTT is set to
> 	TRUE when this limit is in force, the transmission shall be
> 	delayed until such a time as the restriction is no longer in
> 	force. The NTT variable shall be set to FALSE when the Transmit
> 	machine has transmitted a LACPDU."
> 
> 	The current implementation conforms to this as you describe: by
> aligning transmission to 1/3 second boundaries, no more than 3 can ever
> be sent in one second.
> 
> 	If, hypothetically, the state machine were to transition, or a
> user updates port settings (either of which would set NTT each time)
> more than 3 times in a second, would your patched code obey this
> restriction?

As long as the transition doesn't reset sm_tx_timer_counter to something
smaller than ad_ticks_per_sec/AD_MAX_TX_IN_SECOND, which nothing does
currently (and if it did it would be at risk of sending more than 3 in a
second already). The timer is reset on each tx, so no two consecutive
LACPDUs can be sent less than 300ms apart, therefore no more than 3 can
be per second. If a state machine transition sets NTT within 300ms of
the previous tx, it will not send another until the timer expires.


> 	For completeness, and to make this email as complicated as
> possible, I'll note that 802.1AX-2020 removes this particular
> restriction in favor of incorporating the 802.3 generic limit on
> transmission rates for Slow Protocols (of which LACP is one) to 10 per
> second (802.3-2022, 30.3.1.1.38) into the state machine (802.1AX-2020,
> 6.4.7, see "txOpportunity" and 6.4.14 LACP Transmit machine).  Linux
> bonding doesn't implement the 802.1AX-2020 state machines, though, so I
> don't think we can reasonably pick and choose arbitrary pieces from two
> differing editions of a standard.
> 
> 	-J
> 
> >Change this to only rearm the timer when an LACPDU is actually sent,
> >allowing tx at any point after the timer has expired.
> >
> >Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> >---
> > drivers/net/bonding/bond_3ad.c | 11 ++++++-----
> > 1 file changed, 6 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> >index c6807e473ab706afed9560bcdb5e6eca1934f5b7..a8d8aaa169fc09d7d5c201ff298b37b3f11a7ded 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -1378,7 +1378,7 @@ static void ad_tx_machine(struct port *port)
> > 	/* check if tx timer expired, to verify that we do not send more than
> > 	 * 3 packets per second
> > 	 */
> >-	if (port->sm_tx_timer_counter && !(--port->sm_tx_timer_counter)) {
> >+	if (!port->sm_tx_timer_counter || !(--port->sm_tx_timer_counter)) {
> > 		/* check if there is something to send */
> > 		if (port->ntt && (port->sm_vars & AD_PORT_LACP_ENABLED)) {
> > 			__update_lacpdu_from_port(port);
> >@@ -1393,12 +1393,13 @@ static void ad_tx_machine(struct port *port)
> > 				 * again until demanded
> > 				 */
> > 				port->ntt = false;
> >+
> >+				/* restart tx timer(to verify that we will not
> >+				 * exceed AD_MAX_TX_IN_SECOND
> >+				 */
> >+				port->sm_tx_timer_counter = ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
> > 			}
> > 		}
> >-		/* restart tx timer(to verify that we will not exceed
> >-		 * AD_MAX_TX_IN_SECOND
> >-		 */
> >-		port->sm_tx_timer_counter = ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
> > 	}
> > }
> > 
> >
> >---
> >base-commit: 86731a2a651e58953fc949573895f2fa6d456841
> >change-id: 20250625-fix-lacpdu-jitter-1554d9f600ab
> >
> >Best regards,
> >-- 
> >Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net

