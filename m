Return-Path: <netdev+bounces-261642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJK/OEXnoGnVnwQAu9opvQ
	(envelope-from <netdev+bounces-261642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:37:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 451881B1414
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354523019820
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573325B311;
	Fri, 27 Feb 2026 00:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="XxQsvEM1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYDCc0wT"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973E13B5AE;
	Fri, 27 Feb 2026 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152613; cv=none; b=H9bj4So4UyzVlV6K4or2ysuHk+83qyTETKMjs6DSyCqb0AthGCbrQwZtSkvuZmdomgpYBoY7yEHNka/8CICYPd4rGRzM1Ob/jVeoW/XIKgI5rZ99JoU+U44YQMU6tqFJBRefL1f5bztJ8e1UqrCXlgQeVWUJ/qjxdanV2d7N4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152613; c=relaxed/simple;
	bh=o4j6xlT2I++wb1H/DSbUakhHMJnaCbFbAX+BkOQadUg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=fG/SsI6McQ/pVg+j30MgdcL8WzSoUR3oRvjYVdjmRkwcvuFvMOi9pkyv7T4jfvxDEc0Dge5znL/Cla9yFXbz0gNFt8QnDK8i98bMmSPiOFPpdyM1U5f5TuDjNoFNqQWjLLyy07n4Ppj8qv40vVWXiOhIisY4chYJrZ1OItQQAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=XxQsvEM1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYDCc0wT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F3DD7A010C;
	Thu, 26 Feb 2026 19:36:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Feb 2026 19:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772152609; x=1772239009; bh=cZWPtpK1wR62v3hNhnhEkbQvQC8jzjQm
	E3dVCg93bIQ=; b=XxQsvEM1tQauih7lH/F45pOTRnAtzFXp59U6ZSzkHHvfwXk2
	1POqK46P3sK7SFitgojBgQVxciuhzjrVZkUp8r66IZvbsaKh6csvmw/jq8cRbPhQ
	SuEl5XIrAhxRZdfZZim0h8pooFt071mTVPZKuSwXw66UAhixVOe5BzIBu0/st2Al
	YwpSpWtA4HiYx2A45GH4xZnEynnzqvrp2dJ6u5EhYieQSbt4syHa4vIhzZnjoHvY
	h2eKSfMnelQ52ZPMo1B6VyUNJizpvcR7NHNk4M4N6eLcPB0hgHUId+FjN1hjZja+
	XFVn6iRaHAeNTHcaKXvForB4fSuWReuydtD+SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772152609; x=
	1772239009; bh=cZWPtpK1wR62v3hNhnhEkbQvQC8jzjQmE3dVCg93bIQ=; b=M
	YDCc0wTpvQeGHpGBMGMy2Sn061dU3ET/f54OP74VNTeXKDY+iMc2LKgOH49x7HLf
	VyvlbnkFHo/ceNRbehPTfxN1wsENvknTFGK3ao4IVRZEthPPfc6hiOrz0XioaCob
	T82PGKU7d2vqKiZG2UgpPxxyHOBrrVLm2geBCR7MHRL5/b5OLDqExWM2Rn2YV17c
	kdg7SM4+hlvawaN2y5HRibIiomAt44qJYGI98SvkJgIo4E3elaXmu0Kw8A0P79ZI
	jMUy3Ku+xgvdwoxYLDjG6W4TE1G5G5cQEiTxbtkYeUftTEknuC94+kOEkUMUQnYJ
	sL+Vr+U/Iw7VBJj3ZXMpw==
X-ME-Sender: <xms:IOegaf420vyBgsBhyb_z5cFLDtywiib-qlt5TbO8etmxUd6nVwaYLw>
    <xme:IOegaRnqu4bdKtOT1NM2SZSg_h_7JhvTz5osE-NO_rH4rD7jZ0gYGya0VBqFk_-Wp
    Q4IQHgnnH7TCDuT8_M_ALXgmtgYArSvV8l0w2Ckszi6XJkzbS27noE>
X-ME-Received: <xmr:IOegaaUFTyneGD3aaqAJ9C3rAXsZBRub-wQ50ot07I51MWB-BLuL52WozdicikKvgo5Thg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepgeefgffhgffhhfejgfevkefhueekvefftefhgfdtuddtfeffueehleegleeiuefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhh
    rghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehmrghhvghshhgssehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhu
    nhhnrdgthhdprhgtphhtthhopehlihgrlhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:IOegaaSYmX2DVgJMxF_z_COESVrepRSYOPccNBVH68K6r8FqZxXjDg>
    <xmx:IOegaXCjMDBe8_pR-49AOVSi6fqssFz0yTIXgV3oyVV8opHTiPKEog>
    <xmx:IOegaSt-TDNTftGibsNZFxp-VF_i0cwgwg450J_4jJm6NMGRnHtJng>
    <xmx:IOegaV_i-kk7_hBVqSMiCF7kk2fg-JKUe0bT9i_ScsdnPm4Pddz1YQ>
    <xmx:IeegaQhz6OX8gCh8PBTFSDSAyRQ7wv4-XdYsJ7W1FvJF_5NS_A7NpPN2>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 19:36:48 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 05BA39FCB1; Thu, 26 Feb 2026 16:36:47 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 02DDC9FC39;
	Thu, 26 Feb 2026 16:36:47 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCHv3 net 2/3] bonding: restructure ad_churn_machine
In-reply-to: <20260226125331.28147-3-liuhangbin@gmail.com>
References: <20260226125331.28147-1-liuhangbin@gmail.com> <20260226125331.28147-3-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Thu, 26 Feb 2026 12:53:29 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Feb 2026 16:36:46 -0800
Message-ID: <941081.1772152606@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261642-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,jvosburgh.net:email,jvosburgh.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 451881B1414
X-Rspamd-Action: no action

Hangbin Liu <liuhangbin@gmail.com> wrote:

>The current ad_churn_machine implementation only transitions the
>actor/partner churn state to churned or none after the churn timer expires.
>However, IEEE 802.1AX-2014 specifies that a port should enter the none
>state immediately once the actor=E2=80=99s port state enters synchronizati=
on.
>
>Another issue is that if the churn timer expires while the churn machine is
>not in the monitor state (e.g. already in churn), the state may remain
>stuck indefinitely with no further transitions. This becomes visible in
>multi-aggregator scenarios. For example:
>
>Ports 1 and 2 are in aggregator 1 (active)
>Ports 3 and 4 are in aggregator 2 (backup)
>
>Ports 1 and 2 should be in none
>Ports 3 and 4 should be in churned
>
>If a failover occurs due to port 2 link down/up, aggregator 2 becomes acti=
ve.
>Under the current implementation, the resulting states may look like:
>
>agg 1 (backup): port 1 -> none, port 2 -> churned
>agg 2 (active): ports 3,4 keep in churned.
>
>The root cause is that ad_churn_machine() only clears the
>AD_PORT_CHURNED flag and starts a timer. When a churned port becomes activ=
e,
>its RX state becomes AD_RX_CURRENT, preventing the churn flag from being s=
et
>again, leaving no way to retrigger the timer. Fixing this solely in
>ad_rx_machine() is insufficient.
>
>This patch rewrites ad_churn_machine according to IEEE 802.1AX-2014
>(Figures 6-23 and 6-24), ensuring correct churn detection, state transitio=
ns,
>and timer behavior. With new implementation, there is no need to set
>AD_PORT_CHURNED in ad_rx_machine().
>
>Fixes: 14c9551a32eb ("bonding: Implement port churn-machine (AD standard 4=
3.4.17).")
>Reported-by: Liang Li <liali@redhat.com>
>Tested-by: Liang Li <liali@redhat.com>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

	I missed this last time it was posted, but reading it now I
think the functional change looks good, but I question the usefulness of
including the 25 line ASCII art version of the state diagram.

	The standard is publicly available, so a comment saying that the
state machine logic conforms to IEEE 802.1AX-2014 figures 6-23 and 6-24
should be sufficient.  Anyone seriously checking the code against the
standard will need to read the relevant text, so they'll be looking it
up anyway.

	-J

>---
> drivers/net/bonding/bond_3ad.c | 96 +++++++++++++++++++++++++---------
> 1 file changed, 71 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad=
.c
>index c47f6a69fd2a..68258d61fd1c 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -44,7 +44,6 @@
> #define AD_PORT_STANDBY         0x80
> #define AD_PORT_SELECTED        0x100
> #define AD_PORT_MOVED           0x200
>-#define AD_PORT_CHURNED         (AD_PORT_ACTOR_CHURN | AD_PORT_PARTNER_CH=
URN)
>=20
> /* Port Key definitions
>  * key is determined according to the link speed, duplex and
>@@ -1254,7 +1253,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, str=
uct port *port)
> 	/* first, check if port was reinitialized */
> 	if (port->sm_vars & AD_PORT_BEGIN) {
> 		port->sm_rx_state =3D AD_RX_INITIALIZE;
>-		port->sm_vars |=3D AD_PORT_CHURNED;
> 	/* check if port is not enabled */
> 	} else if (!(port->sm_vars & AD_PORT_BEGIN) && !port->is_enabled)
> 		port->sm_rx_state =3D AD_RX_PORT_DISABLED;
>@@ -1262,8 +1260,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, str=
uct port *port)
> 	else if (lacpdu && ((port->sm_rx_state =3D=3D AD_RX_EXPIRED) ||
> 		 (port->sm_rx_state =3D=3D AD_RX_DEFAULTED) ||
> 		 (port->sm_rx_state =3D=3D AD_RX_CURRENT))) {
>-		if (port->sm_rx_state !=3D AD_RX_CURRENT)
>-			port->sm_vars |=3D AD_PORT_CHURNED;
> 		port->sm_rx_timer_counter =3D 0;
> 		port->sm_rx_state =3D AD_RX_CURRENT;
> 	} else {
>@@ -1347,7 +1343,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, str=
uct port *port)
> 			port->partner_oper.port_state |=3D LACP_STATE_LACP_TIMEOUT;
> 			port->sm_rx_timer_counter =3D __ad_timer_to_ticks(AD_CURRENT_WHILE_TIM=
ER, (u16)(AD_SHORT_TIMEOUT));
> 			port->actor_oper_port_state |=3D LACP_STATE_EXPIRED;
>-			port->sm_vars |=3D AD_PORT_CHURNED;
> 			break;
> 		case AD_RX_DEFAULTED:
> 			__update_default_selected(port);
>@@ -1379,11 +1374,41 @@ static void ad_rx_machine(struct lacpdu *lacpdu, s=
truct port *port)
>  * ad_churn_machine - handle port churn's state machine
>  * @port: the port we're looking at
>  *
>+ * IEEE 802.1AX-2014 Figure 6-23 - Actor Churn Detection machine state di=
agram
>+ *
>+ *                                                     BEGIN || (! port_e=
nabled)
>+ *                                                               |
>+ *                                      (3)                (1)   v
>+ *   +----------------------+     ActorPort.Sync     +-------------------=
------+
>+ *   |    NO_ACTOR_CHURN    | <--------------------- |   ACTOR_CHURN_MONI=
TOR   |
>+ *   |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=
                        |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D|
>+ *   | actor_churn =3D FALSE; |    ! ActorPort.Sync    | actor_churn =3D =
FALSE;    |
>+ *   |                      | ---------------------> | Start actor_churn_=
timer |
>+ *   +----------------------+           (4)          +-------------------=
------+
>+ *             ^                                                 |
>+ *             |                                                 |
>+ *             |                                      actor_churn_timer e=
xpired
>+ *             |                                                 |
>+ *       ActorPort.Sync                                          |  (2)
>+ *             |              +--------------------+             |
>+ *        (3)  |              |   ACTOR_CHURN      |             |
>+ *             |              |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D|             |
>+ *             +------------- | actor_churn =3D True | <-----------+
>+ *                            |                    |
>+ *                            +--------------------+
>+ *
>+ * Similar for the Figure 6-24 - Partner Churn Detection machine state di=
agram
>+ *
>+ * We don=E2=80=99t need to check actor_churn, because it can only be tru=
e when the
>+ * state is ACTOR_CHURN.
>  */
> static void ad_churn_machine(struct port *port)
> {
>-	if (port->sm_vars & AD_PORT_CHURNED) {
>-		port->sm_vars &=3D ~AD_PORT_CHURNED;
>+	bool partner_synced =3D port->partner_oper.port_state & LACP_STATE_SYNCH=
RONIZATION;
>+	bool actor_synced =3D port->actor_oper_port_state & LACP_STATE_SYNCHRONI=
ZATION;
>+
>+	/* ---- 1. begin or port not enabled ---- */
>+	if ((port->sm_vars & AD_PORT_BEGIN) || !port->is_enabled) {
> 		port->sm_churn_actor_state =3D AD_CHURN_MONITOR;
> 		port->sm_churn_partner_state =3D AD_CHURN_MONITOR;
> 		port->sm_churn_actor_timer_counter =3D
>@@ -1392,25 +1417,46 @@ static void ad_churn_machine(struct port *port)
> 			 __ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
> 		return;
> 	}
>-	if (port->sm_churn_actor_timer_counter &&
>-	    !(--port->sm_churn_actor_timer_counter) &&
>-	    port->sm_churn_actor_state =3D=3D AD_CHURN_MONITOR) {
>-		if (port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION) {
>-			port->sm_churn_actor_state =3D AD_NO_CHURN;
>-		} else {
>-			port->churn_actor_count++;
>-			port->sm_churn_actor_state =3D AD_CHURN;
>-		}
>+
>+	if (port->sm_churn_actor_timer_counter)
>+		port->sm_churn_actor_timer_counter--;
>+
>+	if (port->sm_churn_partner_timer_counter)
>+		port->sm_churn_partner_timer_counter--;
>+
>+	/* ---- 2. timer expired, enter CHURN ---- */
>+	if (port->sm_churn_actor_state =3D=3D AD_CHURN_MONITOR &&
>+	    !port->sm_churn_actor_timer_counter) {
>+		port->sm_churn_actor_state =3D AD_CHURN;
>+		port->churn_actor_count++;
> 	}
>-	if (port->sm_churn_partner_timer_counter &&
>-	    !(--port->sm_churn_partner_timer_counter) &&
>-	    port->sm_churn_partner_state =3D=3D AD_CHURN_MONITOR) {
>-		if (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) {
>-			port->sm_churn_partner_state =3D AD_NO_CHURN;
>-		} else {
>-			port->churn_partner_count++;
>-			port->sm_churn_partner_state =3D AD_CHURN;
>-		}
>+
>+	if (port->sm_churn_partner_state =3D=3D AD_CHURN_MONITOR &&
>+	    !port->sm_churn_partner_timer_counter) {
>+		port->sm_churn_partner_state =3D AD_CHURN;
>+		port->churn_partner_count++;
>+	}
>+
>+	/* ---- 3. CHURN_MONITOR/CHURN + sync -> NO_CHURN ---- */
>+	if ((port->sm_churn_actor_state =3D=3D AD_CHURN_MONITOR ||
>+	     port->sm_churn_actor_state =3D=3D AD_CHURN) && actor_synced)
>+		port->sm_churn_actor_state =3D AD_NO_CHURN;
>+
>+	if ((port->sm_churn_partner_state =3D=3D AD_CHURN_MONITOR ||
>+	     port->sm_churn_partner_state =3D=3D AD_CHURN) && partner_synced)
>+		port->sm_churn_partner_state =3D AD_NO_CHURN;
>+
>+	/* ---- 4. NO_CHURN + !sync -> MONITOR ---- */
>+	if (port->sm_churn_actor_state =3D=3D AD_NO_CHURN && !actor_synced) {
>+		port->sm_churn_actor_state =3D AD_CHURN_MONITOR;
>+		port->sm_churn_actor_timer_counter =3D
>+			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
>+	}
>+
>+	if (port->sm_churn_partner_state =3D=3D AD_NO_CHURN && !partner_synced) {
>+		port->sm_churn_partner_state =3D AD_CHURN_MONITOR;
>+		port->sm_churn_partner_timer_counter =3D
>+			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
> 	}
> }
>=20
>--=20
>2.50.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

