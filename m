Return-Path: <netdev+bounces-86789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDF58A04C9
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AAC1C218DA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 00:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BBC7F9;
	Thu, 11 Apr 2024 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TNdumgyL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8BA20
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712795324; cv=none; b=vBnhRsjiNS1Ts5lseT2CMbbut7Riei1sVegxzmFsOop6Yeo65TMPBY2uEmJtqG6eqtD/fQ9+LXqlbR20LC6KKnJJCiPjvgYIBBZzxQwA8WpQJeQNWMfOxTRTrvbaRfqDEUH7rjwdikkU+4s/OSBE69spJ2gm/GCbYMwtdgvfLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712795324; c=relaxed/simple;
	bh=4hqN+wS2thh+oGDjzTUJI/gyJVxBKcWtbr9FZ40RT0I=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=BibxkR08lk0oA1QIFAEmzpYMRgBCxHgqAf7bApsF8R4ZargI59yvfgc61BkqEFFk1L8NSobFayypgcWOcg10LqiKJr9JYX7d5BWoZ6n5QchlbvBfRu2BcaHYRJxqmHPLVclNmvHZ0mCPPzOw+W9XwWyMqLhFRcHO1+7awBPJNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TNdumgyL; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EE7A540039
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 00:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712795312;
	bh=F4VCBnCYotDktB/zEPCYvW6FsCRcPbgq+XcEQsCePQo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=TNdumgyLp/MwevBAQBd1f09PC31XRoafc53TChHj/dD6VdXdP/J3cRsY0CfY/dRix
	 ZOk80jxiDNkK/8QF23tA2xStc/Y2KQ21GO46L9G30E5106Yjik9CjIbD/ExsTHrBu8
	 FjebtT21eUbf0RUWvpfRbyyH/ymk1L9ds/jXqlAngJ0HfWJXjCQdBF6t7izKXBACqx
	 F05MKXZTN1y55bC8rT6JgoYqEXZpSc07zeZRwg182brsb+8uvlfubhlAzyvGUu1f+G
	 4FGjZfW78cRbEfwII8CqULjeS0pNpt528t7OmNEcsARIBu6dpMNbhBHgL0KLUVw4bE
	 RX8BLBDxddP6Q==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ecbb44ddc7so6917256b3a.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 17:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712795311; x=1713400111;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4VCBnCYotDktB/zEPCYvW6FsCRcPbgq+XcEQsCePQo=;
        b=ttSPFRpB1uZI9PKEZ0Gw/XMzl+pP2TLuFGRtk8H1yskFnxen//GInXPaqKj8nHd6X8
         1wvOf83z79KVrzvb2zqOv/RcQp1HouRJ3K7TLjsiM9Cac7atEvO2AC1I0YBXCUtwKd+J
         985JlMFG12WA84BN+bjlMgN1H8ia5S8VyG1i6sRlRzGJJ1Bn+unsVDgIMsMq5Fdbq3T3
         8ze7ByNy6pAZcEQ2m3ZVLN9zKxtZjKJOjFzkggcgBzEu1UocHahQtYHijhIPi7rzui3j
         z4IeTeRElkuredes3PW+QG52otl0YObIaznr5gGIGReVzPdxvrfijuK0Fjj/QIgtVVmH
         7RrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtzf/ZgXp+Dg+wUuensBZ6vDzDhNYK0tq171SZYYhCVrxwvUR6uahPLMUqFe8hyw9YNVvcRgOzti8M1n+xDUtVJOmxwbUB
X-Gm-Message-State: AOJu0Yz1n5P7YBChruxqQBnJTVRV1XgjXyLZCkI0SlCmH/yaEJNAkYFY
	xIq9cZPoJnxPLLmVaCiNW5OUEj4/MmGGs5epEewzCGtJA2a+85wb8Jezpaz6ikGVbo2LF2aliK7
	upwqOGugGRKBQApSJm0e+FuZd5GKoF2I4fr0f5GQT9RP+6CyLlE4Aq205CXUs3zuBLuwdlw==
X-Received: by 2002:a05:6a00:4f90:b0:6ed:21b2:cb17 with SMTP id ld16-20020a056a004f9000b006ed21b2cb17mr4674258pfb.4.1712795311284;
        Wed, 10 Apr 2024 17:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5/L/uzH+//yIu6fr0UBU0ImWdwTakYCbJxf+PxSkmDm78mD23xQ7PVneRCe4oDKvciIAC+Q==
X-Received: by 2002:a05:6a00:4f90:b0:6ed:21b2:cb17 with SMTP id ld16-20020a056a004f9000b006ed21b2cb17mr4674238pfb.4.1712795310662;
        Wed, 10 Apr 2024 17:28:30 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id p13-20020aa79e8d000000b006ecfd0bf326sm238533pfq.99.2024.04.10.17.28.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2024 17:28:30 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id DB5BE604B6; Wed, 10 Apr 2024 17:28:29 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id D518C9FA74;
	Wed, 10 Apr 2024 17:28:29 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
cc: Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: 802.3ad: Avoid packet loss when switching aggregator
In-reply-to: <20240410175052.25ac7638@samweis>
References: <20240404114908.134034-1-tbogendoerfer@suse.de> <21529.1712592371@famine> <20240410175052.25ac7638@samweis>
Comments: In-reply-to Thomas Bogendoerfer <tbogendoerfer@suse.de>
   message dated "Wed, 10 Apr 2024 17:50:52 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20446.1712795309.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2024 17:28:29 -0700
Message-ID: <20447.1712795309@famine>

Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:

>On Mon, 08 Apr 2024 09:06:11 -0700
>Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
>> Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:
>> =

>> >If selection logic decides to switch to a new aggregator it disables
>> >all ports of the old aggregator, but doesn't enable ports on
>> >the new aggregator. These ports will eventually be enabled when
>> >the next LACPDU is received, which might take some time and without an
>> >active port transmitted frames are dropped. Avoid this by enabling
>> >already collected ports of the new aggregator immediately.
>> >
>> >Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
>> >---
>> > drivers/net/bonding/bond_3ad.c | 7 +++++++
>> > 1 file changed, 7 insertions(+)
>> >
>> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond=
_3ad.c
>> >index c6807e473ab7..529e2a7c51e2 100644
>> >--- a/drivers/net/bonding/bond_3ad.c
>> >+++ b/drivers/net/bonding/bond_3ad.c
>> >@@ -1876,6 +1876,13 @@ static void ad_agg_selection_logic(struct aggre=
gator *agg,
>> > 				__disable_port(port);
>> > 			}
>> > 		}
>> >+
>> >+		/* enable ports on new active aggregator */
>> >+		for (port =3D best->lag_ports; port;
>> >+			port =3D port->next_port_in_aggregator) {
>> >+			__enable_port(port);
>> >+		}
>> >+  =

>> =

>> 	I think this will do the wrong thing if the port in question is
>> not in a valid state to send or receive (i.e., it is not one of
>> COLLECTING_DISTRIBUTING, COLLECTING, or DISTRIBUTING).
>> =

>> =

>> 	As it happens, this situation, except for the case of individual
>> ports, is handled just below this code:
>> =

>> 	/* if the selected aggregator is of join individuals
>> 	 * (partner_system is NULL), enable their ports
>> 	 */
>> 	active =3D __get_active_agg(origin);
>> =

>> 	if (active) {
>> 		if (!__agg_has_partner(active)) {
>> 			for (port =3D active->lag_ports; port;
>> 			     port =3D port->next_port_in_aggregator) {
>> 				__enable_port(port);
>> 			}
>> 			*update_slave_arr =3D true;
>> 		}
>> 	}
>> =

>> 	rcu_read_unlock();
>> =

>> 	FWIW, looking at it, I'm not sure that "__agg_has_partner" is
>> the proper test for invididual-ness, but I'd have to do a bit of poking
>> to confirm that.  In any event, that's not what you want to change righ=
t
>> now.
>> =

>> 	Instead of adding another block that does more or less the same
>> thing, I'd suggest updating this logic to include tests for C_D, C, or =
D
>> states, and enabling the ports if that is the case.  Probably something
>> like (I have not tested or compiled this at all):
>> =

>> 	if (active) {
>> 		if (!__agg_has_partner(active)) {
>> 			[ ... the current !__agg_has_partner() stuff ]
>> 		} else {
>
>moving it here will run this part on every call of ad_agg_selection_logic=
(),
>but it would be only relevant, if there is a switch to a different aggreg=
ator.

	True; that could be tested for, though, as the original
aggregator is stored in the variable "origin".  This is probably moot in
light of my comments below.

>> 			for (port =3D active->lag_ports; port;
>> 			     port =3D port->next_port_in_aggregator) {
>> 				switch (port->sm_mux_state) {
>> 				case AD_MUX_DISTRIBUTING:
>> 				case AD_MUX_COLLECTING_DISTRIBUTING:
>> 					ad_enable_collecting_distributing(port,
>> 							update_slave_arr);
>> 					port->ntt =3D true;
>> 					break;
>> 				case AD_MUX_COLLECTING:
>> 					ad_enable_collecting(port);
>> 					ad_disable_distributing(port, update_slave_arr);
>> 					port->ntt =3D true;
>> 					break;
>> 				default:
>> 					break;
>> 		}
>
>I've tried this in my test environment and it doesn't fixed the issue
>I'm seeing, because the port of the new aggregator is still in AD_MUX_WAI=
TING...
>
>The issue is that after bringing the bond up it happens that the bond lin=
k
>is up, but no slave can transmit. This happens exactly when the aggregato=
r
>is changed due to timing of the received lacpdu. So if enabling the port
>in AD_MUX_WAITING is wrong, what are other ways to fix this problem ?

	Ok, I've looked through the code a bit more and I understand at
least some of what's going on.  I recall testing this some years ago to
insure that failover between aggregators functions correctly, although I
don't recall looking into loss rates during the failover.

	First, I'm not sure why your port is in WAITING state, unless
it's simply that your test is happening very quickly after the port is
added to the bond.  The standard (IEEE 802.1AX-2014 6.4.15) requires
ports to remain in WAITING state for 2 seconds when transitioning from
DETACHED to ATTACHED state (to limit thrashing when multiple ports are
added in a short span of time).

	You mention the issue happens when the aggregator changes; do
you have a detailed sequence of events that describe how the issue is
induced?

	I also see a potential issue in the handling of READY_N and
READY, although I'd need your test case to determine if it's an actual
problem or just something that looks odd but behaves correctly.

	As for the rest, if your issue revolves around failover between
aggregators in an established bond, then I'd expect the ports to remain
in ATTACHED state when their aggregator is not the active aggregator, as
the state machine logic in ad_mux_machine() won't advance beyond
ATTACHED state in this case, e.g.,

static void ad_mux_machine(struct port *port, bool *update_slave_arr)
{
[...]
		case AD_MUX_ATTACHED:
[...]
				if (port->aggregator->is_active) {
					int state =3D AD_MUX_COLLECTING_DISTRIBUTING;

	When an aggregator's ports move to COLLECTING, DISTRIBUTING or
COLLECTING_DISTRIBUTING state, the link partner will logically expect
that it may send and receive traffic across the ports in the aggregator.
The standard permits an arbitrary number of aggregators to be active
simultaneously, but bonding isn't able to operate more than one
aggregator at a time within the context of a single bonding interface.

	If this is the crux of the problem, we could potentially change
the state machine logic to run the complete state machine on all ports.
This would need to insure that the "inactive" flag logic works correctly
if ports of an inactive aggregator are in C, D or C_D state.  This
should operate similarly to how the inactive bond interfaces are treated
in active-backup mode.  The LACPDU packets should already be passed
through by bond_handle_frame(), so the question would really be whether
ordinary traffic is handled correctly on the inactive aggregators.

	I think the main code change would largely be removing most or
all of the tests (like the sample above) against aggregator->is_active
in ad_mux_machine(), ad_enable_collecting(), and
ad_enable_collecting_distributing().  I haven't tested this at all, this
is just my speculation from looking at the code.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

