Return-Path: <netdev+bounces-226973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF61BA6A5D
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 09:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A428C3A6A49
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD872293C44;
	Sun, 28 Sep 2025 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ekcqcMPH"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AAF4F1
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759045819; cv=none; b=DA/qcxR5FFRX8NhAQx3L6PbsjiuHk+vp7VWGdUZ0kSVfbAPA0ePRI/tldL9IzZV0gKQphT85MmoRQ8axk3RGMXCuZN19nacsdiKUyyyvcCJvcKCw4aHhVSohX0h8RLGH0Ii4afuDkJ25/CmRKGgrNVNWTCGfUl5xzixcSRtseJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759045819; c=relaxed/simple;
	bh=8zwhdAT5sii4bC3jrrsmTyH+Ny/08hZ1oE+9IrhKlcs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icmytWWA7KaiGa6a0QSY5/TpwSAfdl0WRLSS+oUXmMwlcALJvD4NLEqW3v1C0RmoyIbuiTirqC7BfvNDZCcaqFVrEuR9WHSjGgP531HCRDzqVzJuH+c9alYL9kCxQvgmkB7IzK4IfetKZZB4AuhO5K5/c0LqhrVYlxOt+CtV48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ekcqcMPH; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3FB6020EC2;
	Sun, 28 Sep 2025 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1759045813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nB0ZMVuZr2JHPPFgW1Unq44brdPP7xx9CNItiimsCZU=;
	b=ekcqcMPHOzkYt3yXGhY+atCZe4Fxp+CdJHlsxTeIy0aQUXuBVXcXwOxD2zOurkhatIz2s4
	1z+QLSbxDdzMQryNlk266z/etCO2Y0aGwOHeAivfGPybBmD22gn/a5gCZ/1ZOrme6Mypwa
	rhDc2qexHPAzdbHRo7lpml6ibf6EtXU=
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
Date: Sun, 28 Sep 2025 09:50:02 +0200
Message-ID: <2450943.NG923GbCHz@sven-desktop>
In-Reply-To: <9f999251-8132-414e-9ea1-f83ecc41dfdd@I-love.SAKURA.ne.jp>
References:
 <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
 <2754825.KlZ2vcFHjT@sven-desktop>
 <9f999251-8132-414e-9ea1-f83ecc41dfdd@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart879527330.0ifERbkFSE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart879527330.0ifERbkFSE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Sep 2025 09:50:02 +0200
Message-ID: <2450943.NG923GbCHz@sven-desktop>
MIME-Version: 1.0

On Sunday, 28 September 2025 03:06:05 CEST Tetsuo Handa wrote:
> Thank you for responding quickly.
> 
> On 2025/09/28 2:21, Sven Eckelmann wrote:
> > The question would now be: what is the actual problem? 
> 
> Sorry, my explanation was not clear enough.

It was long and contained a lot of things - but not what the actual problem is. 
It is necessary to read a lot of inline calltraces with subclauses - and then 
by reading between the lines, we must figure out what you actually wanted to 
say.

It is no problem to not know the underlying problem. But all these absolute 
statements, accusations and overly detailed statement made me think that I am 
just too stupid to get it and you must be right.

> What I thought as a problem is the difference between
> 
> 	netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, "batadv0", 0, 0);
> 	//netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, 0, &macaddr, ETH_ALEN);
> 
> and
> 
> 	netlink_device_change(&nlmsg, sock, "batadv_slave_0", false, "batadv0", 0, 0);
> 	netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, 0, &macaddr, ETH_ALEN);
> 
> . The former makes hard_iface->if_status == BATADV_IF_ACTIVE while the latter makes
> hard_iface->if_status == BATADV_IF_TO_BE_ACTIVATED (because batadv_iv_ogm_schedule_buff()
> is not called).
> 
> This difference makes operations that depend on hard_iface->if_status == BATADV_IF_ACTIVE
> impossible to work properly. You can confirm this difference using diff show below.

This is again (in my opinion) this kind of (odd) absolute statement again. 
"impossible to work properly" - this sounds like BATADV_IF_TO_BE_ACTIVATED is 
an state which you cannot escape. And that functions/operations depend on 
BATADV_IF_ACTIVE. Both statements are not really true. 

BATADV_IF_TO_BE_ACTIVATED is a transient state and some algorithm depending 
code is responsible to automatically get it in the BATADV_IF_ACTIVE state. 
This is somewhat important here because the first time I read your second 
mail, I was under the impression that something in the reproducer showed that 
the state would be stuck. I searched rather hard in the code but couldn't find 
the reason for this. Only much later, I decided to ignore all this and look 
what the reproducer is actually doing. And also ignore commit 9e6b5648bbc4 
("batman-adv: Fix duplicated OGMs on NETDEV_UP") - because it was impossible 
for me to reproduce it on this commit.

And regarding the functions/operations which "impossible to work properly": 
called functions must "work properly" independent of the state. Just what 
they are doing as work can be different depending on the state. But maybe this 
is a case of "glass is half full" vs "glass is half empty".

The problem is therefore that some function broke this "promise". Your second 
mail (and the patch) was then basically saying "BATADV_IF_TO_BE_ACTIVATED" must 
not exist and we must directly go to BATADV_IF_ACTIVE. (Even if this is in my 
opinion not the right statement) it never said why it must not exist and what 
broke because of "BATADV_IF_TO_BE_ACTIVATED".

The inline calltraces with detailed statements in subclauses make it 
harder to digest. Some small high level statements like 

"I don't know exactly what the underlying problem is but skipping 
BATADV_IF_TO_BE_ACTIVATED in batadv_hardif_activate_interface() seems to work 
around the problem. I suspect that some function is not handling 
BATADV_IF_TO_BE_ACTIVATED correctly. Maybe some kind of race condition between 
switching to BATADV_IF_ACTIVE and executing some specific code. Here are my 
detailed notes:"

would have helped me not to get stuck too long in the interpretation of 
paragraphs. But at the same time, would have given a lot of pointers in the 
right direction. But maybe I would have been stuck anyway - no idea.

Anyway, I hope we found the problem now and thanks for the help.

Regards,
	Sven
--nextPart879527330.0ifERbkFSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaNjoqgAKCRBND3cr0xT1
y9m2AP9zRfPoLfv/wRBSat2mfNow7negQymlLIHciFrlhp2rtwEAnyVyDoxTT9i5
5s8TyBYZJG6NFxFWKvIkbuasC+XR5Q4=
=t2sP
-----END PGP SIGNATURE-----

--nextPart879527330.0ifERbkFSE--




