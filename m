Return-Path: <netdev+bounces-201253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A6AE89D0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED576176420
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6276255E23;
	Wed, 25 Jun 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="P7gGTM7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kky8lQQB"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF8782864;
	Wed, 25 Jun 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869064; cv=none; b=QPrXrYgt4R4dMBBImWb0N/aVM0aSAfInd/W/sK/1SaNMlRtdCm/kusGMrCk2AxWnufBkqFCZnh4vVmiGGRL4Z6rsg4lhKqYOGNcs1IZv+RaxDGENh+syhD6YXjpJDSOECSivgLWZ8fwxSxcuMUqxM9GKZToRERwXF+UU7OXufPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869064; c=relaxed/simple;
	bh=e5rPs2f8VzLeR4ruwzzUAJHpHqv2jxxM/dhCmy/xM1c=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=SAojaPPEdJdr9saAWMCaO4vt6vGN3gwOKRDo47nQaVm2Nlq4RGHTuAAWZSQNqRVgmXmk6c8E6aclMqHTKBtY/WetfRh4dOFNJb+/nTSSNjU/J75mzQRCmxdFAyyp4xMFk3ogMqxihMjWknabn8twi5PDzAFANEjf7KzzfF2BCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=P7gGTM7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kky8lQQB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A05E7A021F;
	Wed, 25 Jun 2025 12:30:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 25 Jun 2025 12:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1750869059; x=1750955459; bh=gn5mgacS9yby6OOdchPND
	abDPrGtXN9QDzbZk+Lowcs=; b=P7gGTM7FxZ6pHq+AO2NGcA6gbCkW/h0sxozr7
	LOPnxuW1IuaKtYl1lrqDAmFqIYX11fsl0B0ZKsOa7qNfFWVLOFxHYypPokXzom+J
	SgdUSRpqLxEJTrer8y7NpW+8Vlal2xUhIMiHfGYnQz26OaL4Im2tHLhjch+ZRgVC
	SGli6wVefRWhjlTextvP3zceqPp/1ZFtpIUAFM8N1mOG63GCSpsMMo2QVLdnWwTc
	8BsnK/nCjXCktZu2b87q25Jfwn2nrspwxb6EZ68Uod9dqWz1Xi2U5efBpE7KHhGl
	A7deEzWlInpjnAuo/A9AnjS4BHOYHPAFeLPMF8VPBSdrOid5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750869059; x=1750955459; bh=gn5mgacS9yby6OOdchPNDabDPrGtXN9QDzb
	Zk+Lowcs=; b=Kky8lQQBqRWpRpSipgmC0zErnhPv87GiRy22ShjLt158yPxp5Wx
	T9qaufhIBrReYJzMhfOOAX4T0/hfzWRnv5pHMAsPGh3EOIp2wYyr9bB3c09dCqec
	5ZwHUW65R9UNWJ8ihik0VChmy03ydrDQ8b+VHtMov8cqEo9Y/GonSN3chFNuqpSb
	7PmDWHXTeRpl9IAposjTtpeZJH1At+QioE1fCz6+hEdpUWIrIA0OcIE60Zc3jzg6
	8sMyKFxeRxZx6LGaoSSxsEEXSkydmCPqFdNO3e4xML5EbhUxLxoOVb+P5343e5av
	YuwAciPZIrVdJXIu5VuL+gRGbxMaHpYpPUg==
X-ME-Sender: <xms:QiRcaKfUZmG94GC1tQqIVRVA8XilqXnaMcFzU1z3OlaQW5crS-arvQ>
    <xme:QiRcaEOxwP_rNOjWoK7pqX5b_zmK3hqpKxA4nrcQGLxA2KNc7f5SE-y3j8qLfxDNn
    YR7gCm2VUI8DRT30eI>
X-ME-Received: <xmr:QiRcaLgDcn9GhvsLtK_bCUN8Dab5sxQ7jKDMkKkYX_cintlh5apxjlstwbpcPtJTWnvYAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehtohhnghhhrghosegsrghmrghitghlohhuugdrtghomhdprh
    gtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvggu
    uhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegtrghrlhhoshdrsghilh
    gsrghosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhfohhrshhhvggvsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QiRcaH9RZvUp6ZHLpGI1yDzmmK2Axi09-wUqraoz6P_BJmaDpxLfNg>
    <xmx:QiRcaGuRIOn29IZ4oAE7_fmuLeKDDkqK5CNImsJXn02HFyGxFOywWQ>
    <xmx:QiRcaOGoDt-4se70SCGUgiDDNqqWULyIekECh1D3eKA1iK0wIhysFg>
    <xmx:QiRcaFOfAWU888bY-PN2P4kTnxUAgcMWysBLvfegzvUZmXyL6q72rg>
    <xmx:QyRcaJliR6hdj7wa3L_mpSPXGYoM690ANxBMfwLd4I2N3zfDz4vK37DA>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:30:58 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id F0D159FCA2; Wed, 25 Jun 2025 09:30:56 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id ED0949FC65;
	Wed, 25 Jun 2025 09:30:56 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Carlos Bilbao <carlos.bilbao@kernel.org>,
    Tonghao Zhang <tonghao@bamaicloud.com>
Subject: Re: [PATCH] bonding: don't force LACPDU tx to ~333 ms boundaries
In-reply-to: <20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org>
References: <20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org>
Comments: In-reply-to "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
   message dated "Wed, 25 Jun 2025 11:01:24 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2545703.1750869056.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jun 2025 09:30:56 -0700
Message-ID: <2545704.1750869056@famine>

Seth Forshee (DigitalOcean) <sforshee@kernel.org> wrote:

>The timer which ensures that no more than 3 LACPDUs are transmitted in
>a second rearms itself every 333ms regardless of whether an LACPDU is
>transmitted when the timer expires. This causes LACPDU tx to be delayed
>until the next expiration of the timer, which effectively aligns LACPDUs
>to ~333ms boundaries. This results in a variable amount of jitter in the
>timing of periodic LACPDUs.

	To be clear, the "3 per second" limitation that all of this
should to conform to is from IEEE 802.1AX-2014, 6.4.16 Transmit machine:

	"When the LACP_Enabled variable is TRUE and the NTT (6.4.7)
	variable is TRUE, the Transmit machine shall ensure that a
	properly formatted LACPDU (6.4.2) is transmitted [i.e., issue a
	CtrlMuxN:M_UNITDATA.Request(LACPDU) service primitive], subject
	to the restriction that no more than three LACPDUs may be
	transmitted in any Fast_Periodic_Time interval. If NTT is set to
	TRUE when this limit is in force, the transmission shall be
	delayed until such a time as the restriction is no longer in
	force. The NTT variable shall be set to FALSE when the Transmit
	machine has transmitted a LACPDU."

	The current implementation conforms to this as you describe: by
aligning transmission to 1/3 second boundaries, no more than 3 can ever
be sent in one second.

	If, hypothetically, the state machine were to transition, or a
user updates port settings (either of which would set NTT each time)
more than 3 times in a second, would your patched code obey this
restriction?

	For completeness, and to make this email as complicated as
possible, I'll note that 802.1AX-2020 removes this particular
restriction in favor of incorporating the 802.3 generic limit on
transmission rates for Slow Protocols (of which LACP is one) to 10 per
second (802.3-2022, 30.3.1.1.38) into the state machine (802.1AX-2020,
6.4.7, see "txOpportunity" and 6.4.14 LACP Transmit machine).  Linux
bonding doesn't implement the 802.1AX-2020 state machines, though, so I
don't think we can reasonably pick and choose arbitrary pieces from two
differing editions of a standard.

	-J

>Change this to only rearm the timer when an LACPDU is actually sent,
>allowing tx at any point after the timer has expired.
>
>Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
>---
> drivers/net/bonding/bond_3ad.c | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index c6807e473ab706afed9560bcdb5e6eca1934f5b7..a8d8aaa169fc09d7d5c201ff2=
98b37b3f11a7ded 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -1378,7 +1378,7 @@ static void ad_tx_machine(struct port *port)
> 	/* check if tx timer expired, to verify that we do not send more than
> 	 * 3 packets per second
> 	 */
>-	if (port->sm_tx_timer_counter && !(--port->sm_tx_timer_counter)) {
>+	if (!port->sm_tx_timer_counter || !(--port->sm_tx_timer_counter)) {
> 		/* check if there is something to send */
> 		if (port->ntt && (port->sm_vars & AD_PORT_LACP_ENABLED)) {
> 			__update_lacpdu_from_port(port);
>@@ -1393,12 +1393,13 @@ static void ad_tx_machine(struct port *port)
> 				 * again until demanded
> 				 */
> 				port->ntt =3D false;
>+
>+				/* restart tx timer(to verify that we will not
>+				 * exceed AD_MAX_TX_IN_SECOND
>+				 */
>+				port->sm_tx_timer_counter =3D ad_ticks_per_sec / AD_MAX_TX_IN_SECOND=
;
> 			}
> 		}
>-		/* restart tx timer(to verify that we will not exceed
>-		 * AD_MAX_TX_IN_SECOND
>-		 */
>-		port->sm_tx_timer_counter =3D ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
> 	}
> }
> =

>
>---
>base-commit: 86731a2a651e58953fc949573895f2fa6d456841
>change-id: 20250625-fix-lacpdu-jitter-1554d9f600ab
>
>Best regards,
>-- =

>Seth Forshee (DigitalOcean) <sforshee@kernel.org>

---
	-Jay Vosburgh, jv@jvosburgh.net

