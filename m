Return-Path: <netdev+bounces-200848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BEAAE716F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1649A1BC3615
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0F22FAF8;
	Tue, 24 Jun 2025 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="QPfij7JV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="naA7swmb"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8BD47F4A;
	Tue, 24 Jun 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799738; cv=none; b=JzDMJjux1OlnWUeyqiJQVQj7xhqb+AwN99Wodp+5IyWOzGFXhQY7LloqwuSvouFT7YINCMm0oIZGWVeTZx0a1bKJvhvlHaxFvb/ck5gjKy2goJKhb1JQUzLRmLxHj1EFycvtwi9mZ4VqYveZ0pt2jHnehNOmhjZzgluDHzM82V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799738; c=relaxed/simple;
	bh=ASU6/7NepD8KZxYGypBu1bhJ2yU7up+jkKKFNlOq7ec=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=DaR9VDQRFEprhtC+I1/uuroBTpoagBvZEnVVAIdYWc4YjFLcD+aUXllK8KDDJPHnKcST4AEC7k7m+P3CgamhOj1eAiQQ6tDK9vi36dCm8RDHhaabIxQPH0sqbYgWeC1x1anD2Xc3cmXia7L+85uraExLmT9+0c4fPNl0/lEdbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=QPfij7JV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=naA7swmb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A31AF7A010E;
	Tue, 24 Jun 2025 17:15:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 24 Jun 2025 17:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1750799734; x=1750886134; bh=nbN+zVT0zH0crB+06m2zwk9mmqJuVd7i
	Um93BjCiMbg=; b=QPfij7JVqRmpPey+8yr93UbhMXbBXU22I89AK4ojjtX9kAzc
	7hjNqZgwMQj+opLBZXemXrSmuRXkFcMei6kLE4nKxaBZ8qBSHOrqiGtuM7gtwQcf
	YLJ8l6blcTkFn5N2Q1HplzGbjye7qfYlG0D6W+/oPf8VQkvBzTYtKoo5eBJOv9NY
	71bPVeXdDPQnHevJSF0qeqraPCqxED7CJCTGoGLhWyqRK1Ezq+6BSfqmfAo6I26M
	3yfsrXuA6LtJaEdIH5YFRY4GJU2kF6+ZjbYs1h+wcwNBZMmkmDrLicURO95/1ai8
	XmGiJqdHDhhWCZONH4auaFKnOHCX+fOBvs22IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750799734; x=
	1750886134; bh=nbN+zVT0zH0crB+06m2zwk9mmqJuVd7iUm93BjCiMbg=; b=n
	aA7swmbnNG2jR3VW3mEMSFRTjL2S2yCRTaiDQQia9Uk7PT4M3Tdqkswqnf2pL2RZ
	tKqZMpFvPuptcGrM8x9UaVFt3C4D912BAU89jzid4hyImTicsBdkfrq1uFaG9HDO
	+jsgEwH1KDpqRBbd8yxft9KyEQuMTAysuIFXmdgfkohLcWFHYmeH4nOkHOMSqU88
	vdEXDQzD12l2Tgjxl78qb1yvNpYVSet55YMp/47fMHLUIOCY+e3a+Gk46iZD4Cof
	9e8VN0c5VmyQn0MjkScNuF7ahuABmZiV75oyzQKt2tDZCpjzP/sGeFCTp+l3Qkb4
	7yaOc9xTB3nK6RwFIV1OQ==
X-ME-Sender: <xms:dRVbaElHA5UXHL9uV8_ug89xq67dnhqG4dQKJkPscTIEHqjqQrK0UQ>
    <xme:dRVbaD0Ms7F3iQ8jHP_cctErfBcXaLxa6Cd83NCEGOy9G5peJKtMjPTs4pONLnjV0
    cRM7QgIoNfdF-WbG2c>
X-ME-Received: <xmr:dRVbaCpc16v8LoMVVUhS40ILIyx7tdFwjTU8GT59hGYrMDyjJ53EqEkXDIceXuMrmnVLhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtjeenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeegfefghffghffhjefgveekhfeukeevffethffgtddutdefffeuheelgeelieeuhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehtohhnghhhrghosegsrghmrghitghlohhuugdrtghomhdprh
    gtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvggu
    uhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegtrghrlhhoshdrsghilh
    gsrghosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    hfohhrshhhvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgv
    thguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:dRVbaAlmG0-kBZWpOKqnAA7M9VIZnrd2LdTmJAQofX3ChFK8fvggOw>
    <xmx:dRVbaC1M5mZ4byQ7keQWkrdVtYWd9fXbxJ_KxKxCVFn6D5urnd5P4A>
    <xmx:dRVbaHt54XhwD3aFOLPMUreAuV28Fer1P_t_jKdbIbL8lmKsmGbzOQ>
    <xmx:dRVbaOXMJiV3au0wg71kdh9ao4dZXrj8UpmeEeI2XQY6l-sl8uStKQ>
    <xmx:dhVbaP9zmeSHfwO9XK957P0Dg95I4il2nJxEoXiCP9oSKN9vC8HcNAo7>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 17:15:33 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 575149FCA2; Tue, 24 Jun 2025 14:15:32 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 544B59FC54;
	Tue, 24 Jun 2025 14:15:32 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: carlos.bilbao@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
    edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
    horms@kernel.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, sforshee@kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] bonding: Improve the accuracy of LACPDU transmissions
In-reply-to: <341249BC-4A2E-4C90-A960-BB07FAA9C092@bamaicloud.com>
References: <20250618195309.368645-1-carlos.bilbao@kernel.org> <341249BC-4A2E-4C90-A960-BB07FAA9C092@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Fri, 20 Jun 2025 11:15:36 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jun 2025 14:15:32 -0700
Message-ID: <2487616.1750799732@famine>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>
>
>
>> 2025=E5=B9=B46=E6=9C=8819=E6=97=A5 03:53=EF=BC=8Ccarlos.bilbao@kernel.or=
g =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>>=20
>> Improve the timing accuracy of LACPDU transmissions in the bonding 802.3=
ad
>> (LACP) driver. The current approach relies on a decrementing counter to
>> limit the transmission rate. In our experience, this method is susceptib=
le
>> to delays (such as those caused by CPU contention or soft lockups) which
>> can lead to accumulated drift in the LACPDU send interval. Over time, th=
is
>> drift can cause synchronization issues with the top-of-rack (ToR) switch
>> managing the LAG, manifesting as lag map flapping. This in turn can trig=
ger
>> temporary interface removal and potential packet loss.

	So, you're saying that contention or soft lockups are causing
the queue_delayed_work() of bond_3ad_state_machine_handler() to be
scheduled late, and, then, because the LACPDU TX limiter is based on the
number of state machine executions (which should be every 100ms), it is
then late sending LACPDUs?

	If the core problem is that the state machine as a whole isn't
running regularly, how is doing a clock-based time check reliable?  Or
should I take the word "improve" from the Subject literally, and assume
it's making things "better" but not "totally perfect"?

	Is the sync issue with the TOR due to missing / delayed LACPDUs,
or is there more to it?  At the fast LACP rate, the periodic timeout is
3 seconds for a nominal 1 second LACPDU interval, which is fairly
generous.

>> This patch improves stability with a jiffies-based mechanism to track and
>> enforce the minimum transmission interval; keeping track of when the next
>> LACPDU should be sent.
>>=20
>> Suggested-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
>> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
>> ---
>> drivers/net/bonding/bond_3ad.c | 18 ++++++++----------
>> include/net/bond_3ad.h         |  5 +----
>> 2 files changed, 9 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
>> index c6807e473ab7..47610697e4e5 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -1375,10 +1375,12 @@ static void ad_churn_machine(struct port *port)
>>  */
>> static void ad_tx_machine(struct port *port)
>> {
>> - /* check if tx timer expired, to verify that we do not send more than
>> - * 3 packets per second
>> - */
>> - if (port->sm_tx_timer_counter && !(--port->sm_tx_timer_counter)) {
>> + unsigned long now =3D jiffies;
>> +
>> + /* Check if enough time has passed since the last LACPDU sent */
>> + if (time_after_eq(now, port->sm_tx_next_jiffies)) {
>> + port->sm_tx_next_jiffies +=3D ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
>> +
>> /* check if there is something to send */
>> if (port->ntt && (port->sm_vars & AD_PORT_LACP_ENABLED)) {
>> __update_lacpdu_from_port(port);
>> @@ -1395,10 +1397,6 @@ static void ad_tx_machine(struct port *port)
>> port->ntt =3D false;
>> }
>> }
>> - /* restart tx timer(to verify that we will not exceed
>> - * AD_MAX_TX_IN_SECOND
>> - */
>> - port->sm_tx_timer_counter =3D ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
>> }
>> }
>>=20
>> @@ -2199,9 +2197,9 @@ void bond_3ad_bind_slave(struct slave *slave)
>> /* actor system is the bond's system */
>> __ad_actor_update_port(port);
>> /* tx timer(to verify that no more than MAX_TX_IN_SECOND
>> - * lacpdu's are sent in one second)
>> + * lacpdu's are sent in the configured interval (1 or 30 secs))
>> */
>> - port->sm_tx_timer_counter =3D ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
>> + port->sm_tx_next_jiffies =3D jiffies + ad_ticks_per_sec / AD_MAX_TX_IN=
_SECOND;
>
>If CONFIG_HZ is 1000, there is 1000 tick per second, but "ad_ticks_per_sec=
 / AD_MAX_TX_IN_SECOND=E2=80=9D =3D=3D 10/3 =3D=3D 3, so that means send la=
cp packets every 3 ticks ?

	Agreed, I think the math is off here.

	ad_ticks_per_sec is 10, it's the number of times the entire LACP
state machine runs per second.  It is unrelated to jiffies, and can't be
used directly with jiffy units (the duration of which varies depending
on what CONFIG_HZ is).  I agree that it's confusingly similar to
ad_delta_in_ticks, which is measured in jiffy units.

	You'll probably want to use msecs_to_jiffies() somewhere.

	How did you test this to insure the TX machine doesn't overrun
(i.e., exceed AD_MAX_TX_IN_SECOND LACPDU transmissions in one second)?

	-J

>>=20
>> __disable_port(port);
>>=20
>> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>> index 2053cd8e788a..956d4cb45db1 100644
>> --- a/include/net/bond_3ad.h
>> +++ b/include/net/bond_3ad.h
>> @@ -231,10 +231,7 @@ typedef struct port {
>> mux_states_t sm_mux_state; /* state machine mux state */
>> u16 sm_mux_timer_counter; /* state machine mux timer counter */
>> tx_states_t sm_tx_state; /* state machine tx state */
>> - u16 sm_tx_timer_counter; /* state machine tx timer counter
>> - * (always on - enter to transmit
>> - *  state 3 time per second)
>> - */
>> + unsigned long sm_tx_next_jiffies;/* expected jiffies for next LACPDU s=
ent */
>> u16 sm_churn_actor_timer_counter;
>> u16 sm_churn_partner_timer_counter;
>> u32 churn_actor_count;
>> --=20
>> 2.43.0
>>=20
>>=20
>>=20
>

---
	-Jay Vosburgh, jv@jvosburgh.net


