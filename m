Return-Path: <netdev+bounces-283571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OvmdHecB92nZbAIAu9opvQ
	(envelope-from <netdev+bounces-283571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 10:05:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF444B4DB1
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B28B3003632
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B9346A13;
	Sun,  3 May 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="zzq5e9Ka"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89F21A0728
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777795555; cv=none; b=mW3NGRabE1VLIFETturx960KKFIYgvdss7+7M03qMd13a2yG57t/gq8cYekWRg3y0xIjEQX6fK05nNjMZHPpCogvLkNKzmmXgDiNmXE6zTN/WJi8ANAyQrr47sJwHC8aVoqJS11ZNbjniETuEWXH4dbQmIFq0X+xZiKvxbo6xNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777795555; c=relaxed/simple;
	bh=RLn6LaS3lmKnOXrMG0ofTgWnb/aqfSMFC4zyPClEBBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uut6sRDOKpAVTAo/M+K1P4jfaRYE9yNVHlX+Fwk4SE+7lzG9DmJylyq/8W1ElbNmi6P4pmSthsu2Y78R9gMvLeKdeIXy5xoYwqi/QZICvRrJ4/n6a88ICQgiByEcSHtzVr5OPT86SwHU8WkwNo3FJstXxbLx+dv9eZbYcmdWfnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=zzq5e9Ka; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7A05D1FF83;
	Sun, 03 May 2026 08:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777795545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzR8+k31T3dyo0vuNU9VsFopPI5PjBRJUMzt+T9FZaY=;
	b=zzq5e9Kap5VbFyzDbR2iwLtVyyJDPfdZepaW/Wx/mfpcMuskYQmaD41D0ch77+ZOgR8kU8
	xk5ER8I3cjMMw/UvFB2FKL2q2fwtM/HjoPt9CClwVLeCD61krsezhMCuXpSBdK1wwlRajd
	XMkwBCFqD9CwQjzoqaJTMvNCPXYeT2U=
From: Sven Eckelmann <sven@narfation.org>
To: Ren Wei <n05ec@lzu.edu.cn>, Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, tr0jan@lzu.edu.cn, wangjiexun2025@gmail.com
Subject:
 Re: [PATCH net v2 1/2] batman-adv: reject new tp_meter sessions during
 teardown
Date: Sun, 03 May 2026 10:05:35 +0200
Message-ID: <14078459.uLZWGnKmhe@sven-desktop>
In-Reply-To: <20260428183028.GW900403@horms.kernel.org>
References:
 <20260427064338.1526762-1-n05ec@lzu.edu.cn>
 <20260428183028.GW900403@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3119035.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 0AF444B4DB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283571-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lists.open-mesh.org,vger.kernel.org,mailbox.org,simonwunderlich.de,mandelbit.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,narfation.org:dkim]

--nextPart3119035.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Ren Wei <n05ec@lzu.edu.cn>, Simon Horman <horms@kernel.org>
Date: Sun, 03 May 2026 10:05:35 +0200
Message-ID: <14078459.uLZWGnKmhe@sven-desktop>
In-Reply-To: <20260428183028.GW900403@horms.kernel.org>
MIME-Version: 1.0

On Tuesday, 28 April 2026 20:30:28 CEST Simon Horman wrote:
[...]
> Hi Ren,
> 
> An AI generated review of this patch-set is available on sashiko.dev.
> Could you take a look over that. I expect that some follow-up patches
> are warranted.
> 

I have some question regarding sashiko.dev - not sure if you can answer this. 
When I get a patch for review (the the newest one from Ren), sashiko marked it 
as "Embargoed" and I can't see it in b4. I have no idea why this is the case 
and I am unsure what I should do in this case:

* ignore sashiko
* wait until sashiko lifts the embargo
* ...

Maybe there is some document which explains it further and you can just point 
me in the right direction.

And just a question from Simon: sashiko.dev is meant as read-only platform, 
right? So, no way to write a rebuttal for wrong statements, correct?

Regards,
	Sven
--nextPart3119035.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafcBzwAKCRBND3cr0xT1
yzy+AQCoHOxLYLXLW0CXpJXmp1UT5lwOd0umbXwMfALvhQEMWgEAkzoJrWTyqcGR
9O17fKZCPmU79ZR4xkK2e2USU5n/9AQ=
=MBZ2
-----END PGP SIGNATURE-----

--nextPart3119035.e9J7NaK4W3--




