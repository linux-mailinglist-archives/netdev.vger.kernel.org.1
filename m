Return-Path: <netdev+bounces-278133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ls0HDoe3WmSaAkAu9opvQ
	(envelope-from <netdev+bounces-278133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:47:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C43EFD36
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E5B43053D13
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48E30C371;
	Mon, 13 Apr 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="UwwOGSGs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H670imC7"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B7314A6B
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098734; cv=none; b=NCFow4WgySBHrmjEsKugScN+fvmyzm1GfDNlOVQ4O+lGxMISvZUd+/2eB4GmEQL1WPRUirM2snYY6khMjimHrRHyHumFGkh7C4s6AKFreTXWGsv1X98yEhMbw8GKZfUfmEjDb6Hale4zVX/mSZyUECPEFsK/6wB1nvPxIHEPGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098734; c=relaxed/simple;
	bh=Qcsv+1oY4/5kNILT8HP1ckCCWZMveVQb3vS1lCAzijw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=H29j48srsodbVszbq9ssCDO9ItRA6/AE4cDBeCcvNRDgBvbUU9Er/W7f0KO4rzOUQSryVtxvKmRmj2nrwUZQ2Wm3CdhhV7leWvlrTflCyvAj8BRxcmiUpKo3pCtVU8pi6WK8YbLwUoXbCeIkwUzaq+kdowOO+Zi5UeOp4UfZORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=UwwOGSGs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H670imC7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5AFE140028B;
	Mon, 13 Apr 2026 12:45:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 12:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1776098731; x=1776185131; bh=rJRuYk/5e2LaPZhS2Sm56
	xWWfIqC8x5TuOF8tcSrC9w=; b=UwwOGSGsAmRcxKqVj474Oae4WefW0pwubXqTh
	l/hmIdZBhjxZpgyJsrb8VnY1TXJbvvj0WeW8qg14AbG+NHKHaP6KzmWxyhJ0lOx3
	qKFG6kyt4rtOONHSRN6ad9voTaMVF+VyfTCM6fIfFqpT3kC2PiVCBluc7bwzeJP9
	LmokXNcoMxAnZ4VFBQR1HpGv/oRHZMpEuYAJCnegof4Q4HDmjjK51jjX4wPpPpEH
	r5MGKGvnYzxiJG4Ep++g1oXaaSdyFDwp7exUUDnBU6n3F4dmmOfN4b8TTsKQEKAF
	dGW//NG7AJhCUgvos6eSVNqzTTy3QL0ZQvfH/+2YRVsgwhGmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776098731; x=1776185131; bh=rJRuYk/5e2LaPZhS2Sm56xWWfIqC8x5TuOF
	8tcSrC9w=; b=H670imC7whwi+O642Gb/0qO4hz81+Rm3cfS44rO3qeaKQVi2mZW
	uPf7gaPraF+xc6lPra6hBRvxe8HMHJ582dlvbQtbWMwdSrSZ0ahlm47GSab/BgWl
	d7rcCm2PnXXvYO2ZlJ6/FNJjVhGlstMIiJauDDfEAaGqazNv7fUlmM/YvpV0uxL3
	2qE9MSx1Nn2KooPKT6kuLTM4AoLKuwiZ4SeF612GrqYHtWIngNauG2MGDd5a8Ue4
	99vaswVg+vN63ZS/ocYz8x5moOwKzMoiyV12hrb3zmXDgjpW0nTdqG8MNVtvSMQZ
	hkfaJj2D9F+BW9FfDhk5zduJilcx8ihkjZQ==
X-ME-Sender: <xms:qx3daZDImI7BQLZT40XaA5DtfXQZ_pr9r-W52bWqP0XWHx63qUUPsQ>
    <xme:qx3daTP-pDPF9QL6-1BoUVz7J-LI6Z0w31DA8iKUpZhPmlyAglwVQ40xCMWuljyWn
    37iSihUFtLbAFfe8aKU4HCxqrjDVe0fI2lvpDUPnuscQoUj-IBPe3E>
X-ME-Received: <xmr:qx3daRAPG_sALmMS9ZVLJQ2jMk6bkDQUIXKPQ0ffxnkAqm2w9rFxFZwiVPnuh8cztuZWlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlohhuihhsrdhstggrlhgsvghrthesieifihhnugdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    mhgrhhgvshhhsgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnugihsehgrhgvhi
    hhohhushgvrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepfh
    gslhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qx3dac6h61gCqUASidhCAQeM1iQkNxc0sO5cbHzdBu9zKbg01YBYqA>
    <xmx:qx3daT5wnTaQ9feGCAB9Tq9diXYs2nd1NE1nMF-fyMK1WyjZ8T2SAQ>
    <xmx:qx3daWTnyITl8GOOmLX1aPzeH7_gBPOOo_VnMTYiH6cWsjDv27ZwhQ>
    <xmx:qx3daT9uENQFMOzSzXdUanw-JszNCBX91W3JvIMF7kqgkZbZoUVsng>
    <xmx:qx3daVy19MURzTMXxMAvwsi7o1jvRK28_a4QFc_iSAny02WcNKjj1gBH>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:45:31 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 3AEE49FB3D; Mon, 13 Apr 2026 09:45:30 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 39F329FB3C;
	Mon, 13 Apr 2026 09:45:30 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v3 0/5] bonding: 3ad: fix carrier state with no valid
 slaves
In-reply-to: <20260408152353.276204-1-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Wed, 08 Apr 2026 17:23:48 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <707534.1776098730.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 09:45:30 -0700
Message-ID: <707535.1776098730@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278133-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A42C43EFD36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>Hi everyone,
>
>This series addresses a blackholing issue and a subsequent link-flapping
>issue in the 802.3ad bonding driver when dealing with inactive slaves
>and the `min_links` parameter.
>
>When an 802.3ad (LACP) bonding interface has no slaves in the
>collecting/distributing state, the bonding master still reports
>carrier as up as long as at least 'min_links' slaves have carrier.
>
>In this situation, only one slave is effectively used for TX/RX,
>while traffic received on other slaves is dropped. Upper-layer
>daemons therefore consider the interface operational, even though
>traffic may be blackholed if the lack of LACP negotiation means
>the partner is not ready to deal with traffic.
>
>The current behavior is not compliant with the LACP standard. This
>patchset introduces a working behavior that is not strictly
>standard-compliant either, but is widely adopted across the industry.
>It consists of bringing the bonding master interface down to signal to
>upper-layer processes that it is not usable.

	As I've said, I believe that the current behavior is compliant
with the standard, as IEEE 802.1AX-2014 6.1.1.j, as we've discussed,
says that (to summarize) links that cannot participate in Link
Aggregation ... operate as normal, individual links.  The mechanism by
which that takes place is not defined, and we, in my opinion, are not in
violation of the standard by selecting a bond member and making it
active.

>This patchset depends on the following iproute2 change:
>ip/bond: add lacp_fallback support
>
>Patch 1 introduces the lacp_fallback configuration knob, which is
>applied in the subsequent patch. The default (legacy) mode preserves
>the existing behavior, while the strict mode is intended to force the
>bonding master carrier down in this situation.

	The above notwithstanding, I don't object in general to an
option that says, essentially, "require that only LACP-partnered ports
be made active."

	Also, after reading through the patch set, I'm comfortable
calling the entire series a "fix," i.e., suitable for net vs net-next.
Most of the changes are genuine code fixes, and the addition of the
option is less a real feature and more of a change to better manage
connectivity in edge cases, so I'm fine with that being called a fix as
well.

	-J

>Patch 2 addresses the core issue when lacp_fallback is set to strict.
>It ensures that carrier is asserted only when at least 'min_links'
>slaves are in a valid state (collecting/distributing, or collecting
>only when coupled_control is disabled).
>
>Patch 3 fixes a side effect of the first patch. Tightening the carrier =

>logic exposes a state persistence bug: when a physical link goes down, =

>the LACP collecting/distributing flags remain set. When the link returns,=
 =

>the interface briefly hallucinates that it is ready, bounces the carrier =

>up, and then drops it again once LACP renegotiation starts. Unsetting the=
 =

>SELECTED flag when the link goes down forces the state machine through =

>DETACHED, clearing the stale flags and preventing the flap.
>
>Patch 4 fixes a side effect of the second patch caused by clearing the
>SELECTED flag on disabled ports. After all ports in an aggregator go
>down, if only a subset of ports comes back up, those ports can no
>longer renegotiate LACP unless all aggregator ports come back up.
>
>Patch 5 adds a test for the bonding legacy and strict LACP fallback modes=
.
>
>Louis Scalbert (5):
>  bonding: 3ad: add lacp_fallback configuration knob
>  bonding: 3ad: fix carrier when no valid slaves
>  bonding: 3ad: fix mux port state on oper down
>  bonding: 3ad: fix stuck negotiation on recovery
>  selftests: bonding: add test for fallback mode
>
> Documentation/networking/bonding.rst          |  33 ++
> drivers/net/bonding/bond_3ad.c                |  38 ++-
> drivers/net/bonding/bond_main.c               |   1 +
> drivers/net/bonding/bond_netlink.c            |  16 +
> drivers/net/bonding/bond_options.c            |  27 ++
> include/net/bond_options.h                    |   1 +
> include/net/bonding.h                         |   1 +
> include/uapi/linux/if_link.h                  |   1 +
> .../selftests/drivers/net/bonding/Makefile    |   1 +
> .../drivers/net/bonding/bond_lacp_fallback.sh | 299 ++++++++++++++++++
> 10 files changed, 415 insertions(+), 3 deletions(-)
> create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp=
_fallback.sh
>
>-- =

>2.39.2
>

---
	-Jay Vosburgh, jv@jvosburgh.net

