Return-Path: <netdev+bounces-280867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P/SCV566mkUzwIAu9opvQ
	(envelope-from <netdev+bounces-280867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:00:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA806457172
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 290E63026A86
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B0347C7;
	Thu, 23 Apr 2026 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="BTHmVdEL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GptQVbTV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837AC41C6A
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974424; cv=none; b=K8BGgHkAApZsRJ1luWg88z/GKat90EQBnQ8yNbwqwVR6QO0koSdJlRjuw2zpStB5oSCALt11dlC9dgO9YkJsFlKTxdObHa7o1ulFku97yRY1QMo7PbAFEkkZG6u7cnJC+WfDenQ1qGkq/Z8rC88Z98Nt0yqM5KwE4M19V8hTbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974424; c=relaxed/simple;
	bh=JeizuQ+l2+m2lSdUGjQRJMU3BvFEg63y5dL7zJeFgkY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=i3lQIPGXcLOqngpTgrsuR3biCxEWfLN0cXZ4Kfjnjw1YpAWT/59SE0O0KgucKQpgRHJpIsEns1V+W6o4tYpkZQWYXK+Gz0a4fwf82j4h7pWBV9poLxZAkfqEqkl37yQuT40TWUV/rTiC7bq9s0ZM3P3zlR6VCVN/A67TqwoarWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=BTHmVdEL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GptQVbTV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 497081D001E5;
	Thu, 23 Apr 2026 16:00:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 23 Apr 2026 16:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1776974421; x=1777060821; bh=LM/BnhWpCxlYh5DLx2EVy
	EFuBVywPRg0z9F1xWHQ5L0=; b=BTHmVdEL6mOTIFACKK1RjzjdQNEoDcftVX01u
	VJOAz1ar3gz75xHz6RnsYDVS2B6F2lYa4RknjLxmST+ZOncRrUMgB7wwDW31Sr/N
	QUJQPxQMwCiPCb4IExcnGS3oHMmevbS+8N9qFMeynLBc4Z0sWZvJs1m+1A3eHqyS
	x9Ogr7O/XiA4Hqm3RWyyC9FUa/Z1c3jXaRRL8TtpR/xLelH7UyTUqXdugAh3Seu2
	JHUzAxBmhIsx2MELnZffGKyb96P1ytCIcppqH4KDliMltycIrDl9oPUSVvKHn2D3
	xOoyBtiJGDPx0aSLjhBEh9VU1p9c9ualPJ7sICk0m4IQDKOBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776974421; x=1777060821; bh=LM/BnhWpCxlYh5DLx2EVyEFuBVywPRg0z9F
	1xWHQ5L0=; b=GptQVbTVLmzBTUc7lN6gpQIea+dVHXAIEgEYQvw1rvyvjwRFACV
	4jSEBTpxdjpz3cy+7fq8KyjLLk5p5VLeF/4zpbvtN5zW2xat9vNvn3K0ITvdhzP7
	7d4WX94CBUu9jmRvDUydAZCOabjch8AZ1Cxy8Ye2mZ4lNgJY1Hq7gExeTpasVDOf
	HwHCIWZ1CFR+R/d8yv9ICx9ZiaBM1ypajJZyNpmzMVGdva0yguwPSvASXATmGzho
	F+oH7RtheoWUs5ZF6edfm5icyZZmrNyQ3B0FjSQ9vdcbXafTlR0g7Rq+6MJuBKiH
	urtlvxLl/n9tsVIyB1I9khRUII3w0TjgZLA==
X-ME-Sender: <xms:VHrqaTM3MB4-x36gMl9AX7X_Ks5ZwSxt9Br4_ErXG3Dvmaoeguv9lg>
    <xme:VHrqaWJjlQtcDKHjBHhUnJV-cNVUIuFkvG6ET6b6DX0mvg6sn7D5GQKIWHb4T8vQ8
    6NMRJxtGlQDY_i4VKCM6acrvar08hwUC1yQI9jy-TC6LYeEZkJY93Sl>
X-ME-Received: <xmr:VHrqad0euEn2n-LaF57HLMBSSewTqCALxJ_DwiLchLKwwEYwNN8apbc7IRq9xtzH9PIMgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlohhuihhsrdhstggrlhgsvghrthesieifihhnugdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    mhgrhhgvshhhsgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnugihsehgrhgvhi
    hhohhushgvrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepsh
    htvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepfhgs
    lhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:VHrqaSU4VEtMW6TvlHjIaIdu-dQcsotZ4QXATOg80ymjCL7pMSVXNw>
    <xmx:VHrqaXNpt4yUy63erbZ4ayzU5Dy_y36uKSqq8ooj9g-ZjcH3zVZzhA>
    <xmx:VHrqad0KvpkSDCeQYOIYhG4Irk3zgzuujeYi8_LczPibZzcEx536Bg>
    <xmx:VHrqaTRJNK3RJArmz4p0mBl3YhFav5ylbfTVisLXFqoAeVClEnNNXQ>
    <xmx:VXrqaTQhAXGk_ZTiP0Unm3HbXkaFt_PfsSHAZKE3Nos-u2_KYdtJwZdZ>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 16:00:20 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 4F8539FC47; Thu, 23 Apr 2026 13:00:19 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 4C67E9FB62;
	Thu, 23 Apr 2026 13:00:19 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, stephen@networkplumber.org,
    andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
    pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
    shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v4 3/4] bonding: 3ad: fix mux port state on oper down
In-reply-to: <20260417140505.3860237-4-louis.scalbert@6wind.com>
References: <20260417140505.3860237-1-louis.scalbert@6wind.com>
 <20260417140505.3860237-4-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Fri, 17 Apr 2026 16:05:04 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1142167.1776974419.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 13:00:19 -0700
Message-ID: <1142168.1776974419@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280867-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jvosburgh.net:dkim,jvosburgh.net:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CA806457172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>When the bonding interface has carrier down due to the absence of
>usable slaves and a slave transitions from down to up, the bonding
>interface briefly goes carrier up, then down again, and finally up
>once LACP negotiates collecting and distributing on the port.
>
>When lacp_strict mode is on, the interface should not transition to
>carrier up until LACP negotiation is complete.
>
>This happens because the actor and partner port states remain in
>Collecting_Distributing when the port goes down. When the port
>comes back up, it temporarily remains in this state until LACP
>renegotiation occurs.
>
>Previously this was mostly cosmetic, but since the bonding carrier
>state may depend on the LACP negotiation state, it causes the
>interface to flap.
>
>Move an operationally down port to the Mux WAITING state and clear the
>Synchronization, Collecting, and Distributing states, in accordance with
>the 802.1AX Mux state machine diagram.
>
>Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>---
> drivers/net/bonding/bond_3ad.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index 9cf064243d58..bc2964ea11f5 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -1053,6 +1053,8 @@ static void ad_mux_machine(struct port *port, bool =
*update_slave_arr)
> =

> 	if (port->sm_vars & AD_PORT_BEGIN) {
> 		port->sm_mux_state =3D AD_MUX_DETACHED;
>+	} else if (!port->is_enabled && port->sm_mux_state !=3D AD_MUX_DETACHED=
) {
>+		port->sm_mux_state =3D AD_MUX_WAITING;

	Technically, this is not exactly following the state machines.

	The mux machine should transition to WAITING from DETACHED when
Selected =3D=3D SELECTED or STANDBY, not for !is_enabled ("port_enabled" i=
n
the standard).  The check for !is_enabled happens in the receive
machine, and it would transition to PORT_DISABLED state (which clears
Synchronization).

	I'm not sure if this is actually an issue or not; I need to read
the relevant bits again to make sure I understand how it's supposed to
work.

	-J

> 	} else {
> 		switch (port->sm_mux_state) {
> 		case AD_MUX_DETACHED:
>@@ -1200,6 +1202,11 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> 			break;
> 		case AD_MUX_WAITING:
> 			port->sm_mux_timer_counter =3D __ad_timer_to_ticks(AD_WAIT_WHILE_TIME=
R, 0);
>+			port->actor_oper_port_state &=3D ~LACP_STATE_SYNCHRONIZATION;
>+			ad_disable_collecting_distributing(port,
>+							   update_slave_arr);
>+			port->actor_oper_port_state &=3D ~LACP_STATE_COLLECTING;
>+			port->actor_oper_port_state &=3D ~LACP_STATE_DISTRIBUTING;
> 			break;
> 		case AD_MUX_ATTACHED:
> 			if (port->aggregator->is_active)
>-- =

>2.39.2
>

---
	-Jay Vosburgh, jv@jvosburgh.net

