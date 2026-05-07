Return-Path: <netdev+bounces-285161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJKSBpU4/GmUMwAAu9opvQ
	(envelope-from <netdev+bounces-285161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:00:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B124E3D0A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C428E3007481
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49774332EBC;
	Thu,  7 May 2026 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="M2P/kzS4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HS4l9RL1"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396972DEA9D
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778137228; cv=none; b=lmXlxH/jgjcqN9AmTQG3F0rYhVCNGK0D6uX5ULsML1qfJ44hFHHspHLYlyK/IIo8SmDSJvXSuD6+8IbNXMkCepB7vA2hA+QNZ8MpSXECrBwzASHpp56oh2XGzHnNZ8u0IgdojFdovlp+jgxZD5MYSgiDDIttieICJyC5BI3eynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778137228; c=relaxed/simple;
	bh=jWn7QH3jWZ/H1/i6kYSqDI5OjW9j7M2oJvWYRhiMMMA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=jj3Orwa7f4Ui0KrcGwv0EY5+GSwViE6USIbOTQSd27z4fq7nqBEYjipdMJLPIcW1LmvRepaaZymvoSfK1vHeSxwQB0q7xiYoOJPLBnufX31gbOI9Zym3JGML9uWqrwn9N4A+aa+dHG2bg4Rf9rhb9ELQlaTGaDz1kCzvUfeBjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=M2P/kzS4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HS4l9RL1; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E77B17A0100;
	Thu,  7 May 2026 03:00:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 07 May 2026 03:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1778137222; x=1778223622; bh=WCdUX2LcYj8Hha2V70a7X7svVtDv9eR0
	XR5VIzhyMmU=; b=M2P/kzS4MfSJj4Rub2+jCIqNpsAcULDtAhxYHKib4YAz15Kg
	s1K4iRwhDNHmmmlOzN3JvqrHjWLp3N1P0Q2fKida/LLu/WwxeB3yGF3q+OSgEj80
	qR/0ZhTAQnJhNRDNZ5imjwmMV1+5UFBXZd93rSm/keKABxX2n3sE4i3n3fiqltOF
	hKioWEbpJHjjpFhoOH5ocvVw80jNe2JHWYdgCks2kn4zgKR7vok8WGVTuWTS8xGZ
	lO9L8xx3fSGnXOvWNW2eqHCRabpt9IYCZ0RmM99IPeP0ILT3zdAH9HcTH6W3Dd37
	kizJsB55o+6mjgL8VvR3reYqUR7zmhh9h3vkpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778137222; x=
	1778223622; bh=WCdUX2LcYj8Hha2V70a7X7svVtDv9eR0XR5VIzhyMmU=; b=H
	S4l9RL1dRt5rBu44ja687MhXG7YWnEhB3P0qKhvQESpis+92RPluA/lNDW1QUptB
	0N4wHflrEHl9atEY2KdhCFr0me/y4W+woNfU7b5upkr0tHK7nqnIxrYf/PNjx0TL
	Kz9t4X6NYHtUPdSsenCiFSvxUgCFEZIjxNbwhfv4geJOqEKs9duInFuveG0GtvNR
	zmmKvHJyQu0wZy8SVgWBg1FIqlP6ImIlQ5qqIHdCWavO9HXZSnH3AC9DIScUgFEB
	MXzOndg5sPW8zM3kG5MGLdEiUNUjWLFYGGp3EBuZbBxH7mLNT1vNEqeWLBhmk6Xx
	0lvaYWFCPvfxyXsr0+zYQ==
X-ME-Sender: <xms:hjj8afwJR_eOBdvxviVpbrvTF38FhhJttHzFU2oairNa9HRXwJ4n-g>
    <xme:hjj8aW9qAmKFQ8eKEyka4KFJ0ock_siphorr5PyWDQzaPt0pEYezwsavaGDAnBY8j
    SZTwRIxeJ_4eQQ55f_tSI0O3SfKPEVl3L4wepaOqq8jcPdgq-H71DQ>
X-ME-Received: <xmr:hjj8aU-Rc6mFHQAQixm1cQsFortcjyw3dJCiZOjq3jV9J6xCVkPAkxjEkrr7GDht9YOnfkl8gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeikedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnheptdektdetteelveektdevtefhleeljedtvedtieejtdehgeekffetkedtffehtefg
    necuffhomhgrihhnpehivggvvgektddvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhn
    sggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhouh
    hishdrshgtrghlsggvrhhtseeifihinhgurdgtohhmpdhrtghpthhtohepvgguuhhmrgii
    vghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghhvghshhgssehgohhoghhlvg
    drtghomhdprhgtphhtthhopegrnhguhiesghhrvgihhhhouhhsvgdrnhgvthdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvg
    htuggvvheslhhunhhnrdgthhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhk
    phhluhhmsggvrhdrohhrghdprhgtphhtthhopehfsghlsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:hjj8aVUc5Gip5Dg4u9MzLYrtibssSNDYQ8VtWj53uMNKP5S3RTMAbw>
    <xmx:hjj8aRdB1WUT4HR1iciCphgDfQ_pTYALFXTi1Prw16BKXwqRlOLFeg>
    <xmx:hjj8aeZ7RrdbuLO-ABcwMf3vdMQ073Nl9P8u3sjtj7XkLZHNixM8qg>
    <xmx:hjj8adPPjMWBpoQ5BQ3B6jWFZyem4ERR9VfHBm1kOn634lI_0qCRoA>
    <xmx:hjj8acfpcQ7sRlnbezkg_CafkAUR_ARZOLjsw6_GketNPQV4fSEfp5gE>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 03:00:21 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id BDE2D1C0373; Wed,  6 May 2026 23:58:37 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id BBA6E1C001F;
	Thu,  7 May 2026 08:58:37 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, stephen@networkplumber.org,
    andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
    pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
    shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v4 3/4] bonding: 3ad: fix mux port state on oper down
In-reply-to: <CAJ5u_OdCjZJLYr8OhfskTxavuW83dYSFx1_bTto9wezTn60nfA@mail.gmail.com>
References: <20260417140505.3860237-1-louis.scalbert@6wind.com> <20260417140505.3860237-4-louis.scalbert@6wind.com> <1142168.1776974419@famine> <CAJ5u_OdCjZJLYr8OhfskTxavuW83dYSFx1_bTto9wezTn60nfA@mail.gmail.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Tue, 05 May 2026 18:10:04 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:58:37 +0200
Message-ID: <97981.1778137117@vermin>
X-Rspamd-Queue-Id: 93B124E3D0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285161-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,jvosburgh.net:email,jvosburgh.net:dkim,messagingengine.com:dkim];
	RSPAMD_URIBL_FAIL(0.00)[ieee802.org:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>Hello Jay,
>
>Sorry for the late reply. I=E2=80=99ve been busy with another project these
>past few days.
>
>Le jeu. 23 avr. 2026 =C3=A0 22:00, Jay Vosburgh <jv@jvosburgh.net> a =C3=
=A9crit :
>>
>> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>>
>> >When the bonding interface has carrier down due to the absence of
>> >usable slaves and a slave transitions from down to up, the bonding
>> >interface briefly goes carrier up, then down again, and finally up
>> >once LACP negotiates collecting and distributing on the port.
>> >
>> >When lacp_strict mode is on, the interface should not transition to
>> >carrier up until LACP negotiation is complete.
>> >
>> >This happens because the actor and partner port states remain in
>> >Collecting_Distributing when the port goes down. When the port
>> >comes back up, it temporarily remains in this state until LACP
>> >renegotiation occurs.
>> >
>> >Previously this was mostly cosmetic, but since the bonding carrier
>> >state may depend on the LACP negotiation state, it causes the
>> >interface to flap.
>> >
>> >Move an operationally down port to the Mux WAITING state and clear the
>> >Synchronization, Collecting, and Distributing states, in accordance with
>> >the 802.1AX Mux state machine diagram.
>> >
>> >Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>> >Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>> >---
>> > drivers/net/bonding/bond_3ad.c | 7 +++++++
>> > 1 file changed, 7 insertions(+)
>> >
>> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_=
3ad.c
>> >index 9cf064243d58..bc2964ea11f5 100644
>> >--- a/drivers/net/bonding/bond_3ad.c
>> >+++ b/drivers/net/bonding/bond_3ad.c
>> >@@ -1053,6 +1053,8 @@ static void ad_mux_machine(struct port *port, boo=
l *update_slave_arr)
>> >
>> >       if (port->sm_vars & AD_PORT_BEGIN) {
>> >               port->sm_mux_state =3D AD_MUX_DETACHED;
>> >+      } else if (!port->is_enabled && port->sm_mux_state !=3D AD_MUX_D=
ETACHED) {
>> >+              port->sm_mux_state =3D AD_MUX_WAITING;
>>
>>         Technically, this is not exactly following the state machines.
>>
>>         The mux machine should transition to WAITING from DETACHED when
>> Selected =3D=3D SELECTED or STANDBY, not for !is_enabled ("port_enabled"=
 in
>> the standard).
>
>The MUX machine still transitions from DETACHED to WAITING; this
>happens a few lines later and is unchanged.
>
>The relevant code is:
>
>} else if (!port->is_enabled && port->sm_mux_state !=3D AD_MUX_DETACHED) {
>    port->sm_mux_state =3D AD_MUX_WAITING;
>} else {
>     switch (port->sm_mux_state) {
>     case AD_MUX_DETACHED:
>          if ((port->sm_vars & AD_PORT_SELECTED)
>              || (port->sm_vars & AD_PORT_STANDBY))
>          /* if SELECTED or STANDBY */
>          port->sm_mux_state =3D AD_MUX_WAITING;
>          break;
>
>My change is for NOT is_enabled AND NOT AD_MUX_DETACHED.
>
>> The check for !is_enabled happens in the receive
>> machine, and it would transition to PORT_DISABLED state (which clears
>> Synchronization).
>
>I agree with that statement. However, clearing Synchronization is not
>sufficient: the purpose of the fix is to clear Collecting and
>Distributing.
>
>I noticed that is_enabled is defined in the 802.3ad-2000 standard, while
>Port_Operational is defined in 802.1AX-2020. I am not sure about
>802.1AX-2014, as I do not have access to that version.

	Did you mean 802.1AX-2014 instead of 802.3ad-2000 here?

>The 802.1AX-2020 standard uses a different MUX state diagram. Compared to
>802.3ad, the ATTACHED state has been split into ATTACH and ATTACHED.
>There is no longer a WAITING state; it has been replaced by
>ATTACHED_WTR.
>
>The new standard says that the MUX machine should transition to
>ATTACHED_WTR when Port_Operational is FALSE and the current state is
>not DETACHED.
>
>So, in my opinion, the change is correct, at least with respect to
>802.1AX-2020.

	I'm concerned that mixing versions of the standard will cause
issues, precisely because the state machines vary between the 2014 and
2020 versions.

	As the standards are not explicitly backwards compatible,
bonding should conform to one version, and in my opinion the version
that makes the most sense is the 2014 edition.  Bonding is already very
close to the 2014 version, while compliance with the 2020 version would
require significant changes.

	The 2014 edition is freely available from the IEEE, for example at:

https://1.ieee802.org/tsn/802-1ax-2014/

>>
>>         I'm not sure if this is actually an issue or not; I need to read
>> the relevant bits again to make sure I understand how it's supposed to
>> work.
>
>Please confirm what you want me to do: should I keep the fix as it is ?

	I see that you've reposted the patch series, I'll reply there
later when I've had a chance to study the details.

	-J

>best regards,
>
>Louis Scalbert
>>
>>         -J
>>
>> >       } else {
>> >               switch (port->sm_mux_state) {
>> >               case AD_MUX_DETACHED:
>> >@@ -1200,6 +1202,11 @@ static void ad_mux_machine(struct port *port, bo=
ol *update_slave_arr)
>> >                       break;
>> >               case AD_MUX_WAITING:
>> >                       port->sm_mux_timer_counter =3D __ad_timer_to_tic=
ks(AD_WAIT_WHILE_TIMER, 0);
>> >+                      port->actor_oper_port_state &=3D ~LACP_STATE_SYN=
CHRONIZATION;
>> >+                      ad_disable_collecting_distributing(port,
>> >+                                                         update_slave_=
arr);
>> >+                      port->actor_oper_port_state &=3D ~LACP_STATE_COL=
LECTING;
>> >+                      port->actor_oper_port_state &=3D ~LACP_STATE_DIS=
TRIBUTING;
>> >                       break;
>> >               case AD_MUX_ATTACHED:
>> >                       if (port->aggregator->is_active)
>> >--
>> >2.39.2
>> >
>>
>> ---
>>         -Jay Vosburgh, jv@jvosburgh.net

---
	-Jay Vosburgh, jv@jvosburgh.net

