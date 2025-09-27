Return-Path: <netdev+bounces-226915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A53ABA6212
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 19:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3063F189EF98
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC08420E31C;
	Sat, 27 Sep 2025 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Mx+uyaYx"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94A1632C8
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758993731; cv=none; b=sMmijSS+YK8+ExtCAXMc5rX9UGHnSXjBB01dgonTDMf9DJGmOpL96MXxO+r2oLq6iziBnqIIrFC6ci1xSrNYKrNQKLeUXcX1gizSBsJKDgBkVHrFnWI3k/P2MraabyxspADFJP2YF47q2I0mDPoRMytoBHVuFCHw1Pmkj52NDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758993731; c=relaxed/simple;
	bh=OI1rYEqLG5/ypQLadzodtjoVnYAu/pTE9/7CfRXYwzE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6OnoFlUn2ro4sqgI9+TiMnAGLCyqUvXJYu8tS4W0wCG/Y/Id+6L3nkQHwMZHpYUR7esu4v3dycX3dTZkN5jygoX2fWgVzwcDodor8bP6Juvo1jcO2iPvORZiKfLR8+m+vL3rtSTXz7RqaboYOAlQHyhQOujYKSlf9smMCmk9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Mx+uyaYx; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id A6A8D2054D;
	Sat, 27 Sep 2025 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1758993725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDurmd04BKVUELAoJuDk6KWuGDtTylZAERr3/9hXhOQ=;
	b=Mx+uyaYxwcW7GV6l1B7U6KdFn0mUJz6B+XfHl/RbUsxkBSYDqFw+Qx7zOdBU2utgMfigpN
	DG1wT15MtmYmyHeyYyLiwAfX+T2LOTFgoO+qR7UKDMKCafKLBcGyxUUmtRZTzFNPlw5Kwi
	73lYtl8ZgEWEJBdhDZWte3EfyIPM5lc=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 Network Development <netdev@vger.kernel.org>,
 Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject:
 Re: unregister_netdevice: waiting for batadv_slave_0 to become free. Usage
 count = 2
Date: Sat, 27 Sep 2025 19:21:51 +0200
Message-ID: <2754825.KlZ2vcFHjT@sven-desktop>
In-Reply-To: <1731a084-79fb-4bc6-9e0b-9b17f3345c4b@I-love.SAKURA.ne.jp>
References:
 <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
 <1731a084-79fb-4bc6-9e0b-9b17f3345c4b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3312591.k3LOHGUjKi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3312591.k3LOHGUjKi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 27 Sep 2025 19:21:51 +0200
Message-ID: <2754825.KlZ2vcFHjT@sven-desktop>
MIME-Version: 1.0

On Tuesday, 23 September 2025 16:45:48 CEST Tetsuo Handa wrote:
> On 2025/09/22 23:09, Tetsuo Handa wrote:
> > I suspect that batadv_hard_if_event_meshif() has something to do upon
> > NETDEV_UNREGISTER event because batadv_hard_if_event_meshif() receives
> > NETDEV_POST_INIT / NETDEV_REGISTER / NETDEV_UNREGISTER / NETDEV_PRE_UNINIT
> > events when this reproducer is executed, but I don't know what to do...
> 
> With a change show bottom, the reproducer no longer triggers this problem.
> But is this change correct?

Thanks for the writeup. Unfortunately, I tried to read this multiple times but 
you don't make it easy to figure out what the problem is.

Please don't take the following paragraphs the wrong way - I was just not able 
to really figure out what you meant. I have therefore just added my thoughts 
on each paragraph.

At the end of this mail, I tried to give a shorter summary about the interface 
states and what I think is the actual problem.

> Commit 9e6b5648bbc4 ("batman-adv: Fix duplicated OGMs on NETDEV_UP")
> replaced batadv_iv_iface_activate() (which is called via iface.activate()
>  from batadv_hardif_activate_interface()) with batadv_iv_iface_enabled()
> (which is called via iface.enabled() from batadv_hardif_enable_interface()).
> But that commit missed that batadv_hardif_activate_interface() is called from
> both batadv_hardif_enable_interface() and batadv_hard_if_event().

Why did it miss it? This is the plan in the mentioned commit.

What is the relevant effect which is creating the problem here?


> Since batadv_iv_ogm_schedule_buff() updates if_status to BATADV_IF_ACTIVE
> only when if_status was BATADV_IF_TO_BE_ACTIVATED, we need to call
> batadv_iv_ogm_schedule_buff() from batadv_iv_ogm_schedule() from
> batadv_iv_iface_enabled() via iface.enabled() with
> if_status == BATADV_IF_TO_BE_ACTIVATED if we want iface.enabled() from
> batadv_hardif_enable_interface() to update if_status to BATADV_IF_ACTIVE.

This basically says: Because of A <- B <- C, we need to have C to B to get A. 
But not really what effect this would have.

> But when IFF_UP is not set upon creation, batadv_hardif_enable_interface()
> does not call batadv_hardif_activate_interface(), which means that
> if_status remains BATADV_IF_INACTIVE despite
> batadv_iv_ogm_schedule_buff() is called via iface.enabled().

It must stay inactive when it is down. But the periodic OGM scheduling is 
still needed to have the OGM queued for active interfaces.


> And when IFF_UP is set after creation, batadv_hard_if_event() calls
> batadv_hardif_activate_interface(). But despite "Interface activated: %s\n"
> message being printed, if_status remains BATADV_IF_TO_BE_ACTIVATED because
> iface.activate == NULL due to above-mentioned commit.

This is not necessarily true. It will simply be switched to BATADV_IF_ACTIVATE 
with the next OGM because batadv_iv_ogm_schedule is rescheduled all the time.

> Since we need to call iface.enabled() instead of iface.activate() so that
> batadv_iv_ogm_schedule_buff() will update if_status to BATADV_IF_ACTIVE,
> move iface.enabled() from batadv_hardif_enable_interface() to
> batadv_hardif_activate_interface().

Why do we need to switch to this state in the first place? I didn't find this 
explanation here.

If I would add your change, we would suddenly have multiple scheduled OGMs 
again, right? Because it basically an oddly written revert of 
commit 9e6b5648bbc4 ("batman-adv: Fix duplicated OGMs on NETDEV_UP").


If this would actually the problem, why would the BATADV_CMD_GET_NEIGHBORS 
request be required? I would have expected that following would show the same 
problem when the switch of the state is the problem:

    rmmod batman-adv || true
    modprobe batman-adv
 
    ip link add batadv_slave_0 type veth peer name veth0_to_batadv
    
    ip link add batadv0 type batadv
    batctl meshif batadv0 it 1000000
    ip link set down master batadv0 dev batadv_slave_0
    ip link set up address 00a:a:aa:aa:aa:aa dev batadv_slave_0
    ip link del dev batadv_slave_0


Let me rephrase what happens with the state of an interface. Just so we are on 
the same page:

* an interface detected by batman-adv is starting with the state 
  BATADV_IF_NOT_IN_USE
* an active interface has the state BATADV_IF_ACTIVE
* when an interface is added to a batman-adv meshif, it is first set to the 
  state BATADV_IF_TO_BE_ACTIVATED
  - this is done by batadv_hardif_activate_interface()
  - there are some dependencies to the UP state of the netdev - see below
* the transition from BATADV_IF_TO_BE_ACTIVATED to BATADV_IF_ACTIVE is 
  algorithm specific
  - IV: scheduling of the OGM buffer
  - V: "directly" after BATADV_IF_TO_BE_ACTIVATED is set


The transition from state BATADV_IF_NOT_IN_USE to BATADV_IF_TO_BE_ACTIVATED 
only happens when the interface is actually UP when .ndo_add_slave is called. 
Otherwise, batman-adv postpones the call to batadv_hardif_activate_interface() 
until the NETDEV_UP event is received.

As mentioned earlier the B.A.T.M.A.N. IV algorithm implementation is (in your 
reproducer) responsible for switching the interface state from 
BATADV_IF_TO_BE_ACTIVATED to BATADV_IF_ACTIVE. And it will only do 
this when the interface was actually in the state BATADV_IF_TO_BE_ACTIVATED. 
There is a comment above the statement which explains the details.

And exactly this "delay" makes it more likely that operations are started 
while an interface is in the transition state of BATADV_IF_TO_BE_ACTIVATED. 
Simply because the periodic OGM scheduling isn't triggered immediately - it 
continues with its normal periodicity.
 

The question would now be: what is the actual problem? For example, with 
following change, the problem also seems to be gone:

diff --git i/net/batman-adv/originator.c w/net/batman-adv/originator.c
index c84420cb..f82dce20 100644
--- i/net/batman-adv/originator.c
+++ w/net/batman-adv/originator.c
@@ -763,7 +763,7 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
+	if (!primary_if) {
 		ret = -ENOENT;
 		goto out_put_mesh_iface;
 	}


And now we are most likely on the right path... primary_if is holding a 
reference to an hardif and therefore also a reference to the netdev. And the 
error handling is only taking care of releasing the reference to the meshif 
but not the primary_if.

I will later send a fix for this with you and 
syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com as Reported-by. Is this 
okay for you?



As said, earlier - I am really thankful that you worked on this. So please 
don't interpret this as a harsh criticism. I just had really big problems to 
figure out what you wanted to say in these paragraphs. I usually prefer 
something which is easier to consume.

Regards,
	Sven
--nextPart3312591.k3LOHGUjKi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaNgdLwAKCRBND3cr0xT1
y1/bAP9WR/IIecQQNCzjq7Q+Q6kHMUDV3XLmuRMILorEXz7eNwEAzO9erC22pv0F
GNR9W6TiWohnrKG3+DlV70zNZ0eQbw8=
=XxEI
-----END PGP SIGNATURE-----

--nextPart3312591.k3LOHGUjKi--




