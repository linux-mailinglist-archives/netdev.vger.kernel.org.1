Return-Path: <netdev+bounces-279142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LFfFQY/4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:56:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CBD414616
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8618300B46C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441AE3E7164;
	Thu, 16 Apr 2026 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="LsUdcEG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzzWH2rJ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB53E274B
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369409; cv=none; b=D8hmuj3/VQRnQphFB4R5Sx895rbGssQxfn3boM2aOoVOm8hC42Ti7IC1PSz6HEQzaL6Z1apYJJvZEuhkOPBOx1WcRmxNqGqvmwS+Uf14/0FqCMi2pJbA+Be/EkTA5w/8duq0J/3GQRUcWwXKcYBpgwS0l2mNdcNYoO3nT7a14nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369409; c=relaxed/simple;
	bh=CT/lVEJqV14A+kt0RProyLPsC6QpyGP6J17r+ozUCAU=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=MpCDA13z72/hkL09dgYifP3C5CfznDG8Xz9v5uZQZLrFDN4ITnGyDgvMsWKormJDN6yeQSu69dTWf25vz0FxPxB+XralnXrIZTVVckC8OtGpVtWvhrxdSw8vhwKgkAwjLMT7AlZf2BpkWbMGpcSMbFLGNmz4FyMkddyt6yHbJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=LsUdcEG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DzzWH2rJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 52797EC0143;
	Thu, 16 Apr 2026 15:56:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 16 Apr 2026 15:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1776369399; x=1776455799; bh=VDtMnB9tptIxx4RbJsZIoN6QMak4Srdd
	SgjDd7eQ9Cw=; b=LsUdcEG13AEfXSh0yuEmIC8qsE75FnZEOOHlf5Ln9rJfJyPy
	fEEa8wO0HbocEg5rCmCbig8LWJo5B4BueNx7Dr7TGte58ylJuE4q/1EK9f6Erq8O
	PlMKMpVeXzgQjdXomecTewZuyghHH35eSYIrQI3WJK/97w67Mh8C848uN4w3fE3Y
	GBdNLxGZCwy4JxgH9GfDLeOsxai9oXj+GUTLg0u289b0bZgMGFhevknKsk+C8ukG
	BeAHwPlPM4L/fUoDJwWOSRIc0wuJABX5rXq11APV1zOjYVzcNsaG3wUimAaoEzSW
	mM6HV75tNy1vjOsjOSRkkE7wNG2fpoIOje2HVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776369399; x=
	1776455799; bh=VDtMnB9tptIxx4RbJsZIoN6QMak4SrddSgjDd7eQ9Cw=; b=D
	zzWH2rJlm56uUqT1nJadWC0S9uS20Apd7yFSQmXvPuhGEKSfQHdckzzKH51DwPrY
	c6MC+IyQXX/F4hVxHk5p2Kkdvo2NaT2ajXvciimuWuwRaHOacA0mzn9Alm8gyc5T
	fAOqJYQR1QZtWV/RChLIRE47YqhJVpZouh2iGpIGteEScldMpI4otLdyAIWowYU+
	WJBhv5k8TIBE+ej/LOKKZgvztZmb/1hXSYh6NOooRkbrKroeuz8qbvV4BGKksqjP
	Nh5fRIF+xI1zTBDfTRwGbu/d0dr7PFzrGzUFhe9hd6LF3LNVDFKO60Mts90WfNmg
	Ql+5aQC8yiMvpkjxiypfw==
X-ME-Sender: <xms:9j7haUSwl2GQI9Ka7pZJrU6gkTnZ4wn3muWlfnDAS3Xjj_R7FWzkFA>
    <xme:9j7haeULb8T61oZwVDb6ldKpwlx3tO7mvaWCZBG0zDvdxrqK7IeZE7AWJ1LNgcoss
    _jDqYt-FDnGEhpmrGj7rgJS6fcpIo-tuD6mHbnrHFNzpwgKOEC5ow>
X-ME-Received: <xmr:9j7haWQHumiQ3pxUrjMPUUfZYqQ11zDlvyVdHFGobjT8SpeMKyrdaBs0wFINCOEPRaSKxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtjeenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeetlefgkefhkeduteekffeghefhgefgkedvvddviedtgfefveeuteetgeetjefgveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggp
    rhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhouhhish
    drshgtrghlsggvrhhtseeifihinhgurdgtohhmpdhrtghpthhtohepvgguuhhmrgiivght
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghhvghshhgssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegrnhguhiesghhrvgihhhhouhhsvgdrnhgvthdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtug
    gvvheslhhunhhnrdgthhdprhgtphhtthhopehfsghlsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9j7hae3-fXL3ZgjwQ_QWD5aNSJ6chz3HC9UR1aDcKdK11yqqe6MdGQ>
    <xmx:9j7haedQSNfrO3kirliXfbz-gg4J8D-3niXeuy7aI7uwILtdOjtaQw>
    <xmx:9j7haeNzcGL2Due9o4C7ep3dRL9-4Y7tY3_AZQi8-yJ21X2EgJMd1w>
    <xmx:9j7haaWyAzUQNCWBL1B9Y5GBU8RkED53KoSUbk6TDNPfxCh-B2CFwA>
    <xmx:9z7haQaFkWsw_5GGrf1GqYYdb1iMkWDTN5AL9oW6kaPwB6IwzLq9pXFo>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 15:56:38 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 45B4F9FB64; Thu, 16 Apr 2026 12:56:37 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 4353B9FB3D;
	Thu, 16 Apr 2026 12:56:37 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v3 2/5] bonding: 3ad: fix carrier when no valid slaves
In-reply-to: <CAJ5u_OdK8kw5+7ZV0WwQHZOF5w+8rHXwgvsB5CDm5Ha0oSd0cA@mail.gmail.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com> <20260408152353.276204-3-louis.scalbert@6wind.com> <707939.1776099707@famine> <CAJ5u_OdK8kw5+7ZV0WwQHZOF5w+8rHXwgvsB5CDm5Ha0oSd0cA@mail.gmail.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Wed, 15 Apr 2026 19:53:50 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 12:56:37 -0700
Message-ID: <874193.1776369397@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279142-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 83CBD414616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>Hello Jay,
>
>Thank you very much for this detailed review.
>
>Le lun. 13 avr. 2026 =C3=A0 19:01, Jay Vosburgh <jv@jvosburgh.net> a =C3=
=A9crit :
>>
>> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>>
>> >Apply the "lacp_fallback" configuration from the previous commit.
>> >
>> >"lacp_fallback" mode "strict" asserts that the bonding master carrier
>> >only when at least 'min_links' slaves are in the collecting/distributing
>> >state (or collecting only if the coupled_control default behavior is
>> >disabled).
>> >
>> >Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>> >Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>> >---
>> > drivers/net/bonding/bond_3ad.c     | 26 ++++++++++++++++++++++++--
>> > drivers/net/bonding/bond_options.c |  1 +
>> > 2 files changed, 25 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_=
3ad.c
>> >index af7f74cfdc08..b79a76296966 100644
>> >--- a/drivers/net/bonding/bond_3ad.c
>> >+++ b/drivers/net/bonding/bond_3ad.c
>> >@@ -745,6 +745,22 @@ static void __set_agg_ports_ready(struct aggregato=
r *aggregator, int val)
>> >       }
>> > }
>> >
>> >+static int __agg_valid_ports(struct aggregator *agg)
>> >+{
>> >+      struct port *port;
>> >+      int valid =3D 0;
>> >+
>> >+      for (port =3D agg->lag_ports; port;
>> >+           port =3D port->next_port_in_aggregator) {
>> >+              if (port->actor_oper_port_state & LACP_STATE_COLLECTING =
&&
>> >+                  (!port->slave->bond->params.coupled_control ||
>> >+                   port->actor_oper_port_state & LACP_STATE_DISTRIBUTI=
NG))
>> >+                      valid++;
>>
>>         Do we need to test coupled_control?  I.e., can the test be
>
>With coupled_control enabled (default), the actor allows traffic from
>the partner only when it reaches both the COLLECTING and DISTRIBUTING
>states, i.e., in the AD_MUX_COLLECTING_DISTRIBUTING Mux state.
>
>With coupled_control disabled, the actor allows traffic from the
>partner as soon as it reaches the COLLECTING state, regardless of the
>DISTRIBUTING flag. In this case, COLLECTING is set in the
>AD_MUX_COLLECTING state, while DISTRIBUTING is only set later in the
>AD_MUX_DISTRIBUTING state.
>
>From the perspective of upper-layer processes, a carrier up state
>indicates that the link is fully operational and capable of both
>collecting and distributing traffic. These processes are not aware of
>the distinction between COLLECTING and COLLECTING & DISTRIBUTING
>states.

	Ok, so to the upper layers, carrier up means "can both send and
receive," however...

>>
>>                 if ((port->actor_oper_port_state & LACP_STATE_COLLECTING=
) &&
>>                     (port->actor_oper_port_state & LACP_STATE_DISTRIBUTI=
NG))
>>
>
>If we want to allow collection to start without waiting for
>distribution to be enabled, then the carrier must be asserted as soon
>as the COLLECTING state is reached.
>In that case, this test would not be valid.

	...here, are you saying that the bond should transition to
carrier up as soon as it's able to receive, even if it cannot yet send?
Won't that break the upper layers that expect carrier up to mean that
they can transmit?

	My presumption in suggesting the test logic is that carrier up
is the first meaning, that the interface can both send and receive, and
therefore has both _COLLECTING and _DISTRIBUTING.

	-J

>In practice, I can only test for LACP_STATE_COLLECTING, because
>LACP_STATE_DISTRIBUTING is always set together with
>LACP_STATE_COLLECTING.
>
>>         To my reading, ad_mux_machine will set _COLLECTING and
>> _DISTRIBUTING appropriately regardless of the coupled_control selection.
>
>I don't agree. See:
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/net/bonding/bond_3ad.c?id=3Dv7.0#n1090
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/net/bonding/bond_3ad.c?id=3Dv7.0#n1202
>
>> >+      }
>> >+
>> >+      return valid;
>> >+}
>> >+
>> > static int __agg_active_ports(struct aggregator *agg)
>> > {
>> >       struct port *port;
>> >@@ -2120,6 +2136,7 @@ static void ad_enable_collecting_distributing(str=
uct port *port,
>> >                         port->actor_port_number,
>> >                         port->aggregator->aggregator_identifier);
>> >               __enable_port(port);
>> >+              bond_3ad_set_carrier(port->slave->bond);
>> >               /* Slave array needs update */
>> >               *update_slave_arr =3D true;
>> >               /* Should notify peers if possible */
>> >@@ -2141,6 +2158,7 @@ static void ad_disable_collecting_distributing(st=
ruct port *port,
>> >                         port->actor_port_number,
>> >                         port->aggregator->aggregator_identifier);
>> >               __disable_port(port);
>> >+              bond_3ad_set_carrier(port->slave->bond);
>> >               /* Slave array needs an update */
>> >               *update_slave_arr =3D true;
>> >       }
>> >@@ -2819,8 +2837,12 @@ int bond_3ad_set_carrier(struct bonding *bond)
>> >       }
>> >       active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggreg=
ator));
>> >       if (active) {
>> >-              /* are enough slaves available to consider link up? */
>> >-              if (__agg_active_ports(active) < bond->params.min_links)=
 {
>> >+              /* are enough slaves in collecting (and distributing) st=
ate to consider
>> >+               * link up?
>> >+               */
>> >+              if ((bond->params.lacp_fallback ? __agg_valid_ports(acti=
ve)
>> >+                                      : __agg_active_ports(active)) <
>> >+                  bond->params.min_links) {
>>
>>         I think the original comment is better; if the new option is
>> off, it doesn't require collecting / distributing state.
>>
>>         -J
>>
>> >                       if (netif_carrier_ok(bond->dev)) {
>> >                               netif_carrier_off(bond->dev);
>> >                               goto out;
>> >diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/b=
ond_options.c
>> >index b672b8a881bb..d64a5d2f80b6 100644
>> >--- a/drivers/net/bonding/bond_options.c
>> >+++ b/drivers/net/bonding/bond_options.c
>> >@@ -1706,6 +1706,7 @@ static int bond_option_lacp_fallback_set(struct b=
onding *bond,
>> >       netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
>> >                  newval->string, newval->value);
>> >       bond->params.lacp_fallback =3D newval->value;
>> >+      bond_3ad_set_carrier(bond);
>> >
>> >       return 0;
>> > }
>> >--
>> >2.39.2

---
	-Jay Vosburgh, jv@jvosburgh.net


