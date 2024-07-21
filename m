Return-Path: <netdev+bounces-112331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4EA93859C
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 19:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ADD1F2116A
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0251684B4;
	Sun, 21 Jul 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="DxdA3grE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mRpgGMjt"
X-Original-To: netdev@vger.kernel.org
Received: from flow5-smtp.messagingengine.com (flow5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA94167D80
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721581798; cv=none; b=M0jKHBI8giE5ptKb5LHIYPsiGtLqC7ZObm6y3kBa5lYAM8gApSMd9gHwFZpUuT0LSIN/EhFg87pXeU1399Vdc5yj5lKB6bXxKhud8nEmtv6V3wkPkH5eZltEG5uqoXnyf2ekAMCZtgiKGQKN0N8GOd6xiAz25ipbuRkCCLAkECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721581798; c=relaxed/simple;
	bh=fHwRh365W0trx8Kh11cbHtel62Ylb4uDpgDsc+7DmJo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=KqDfuge5ay5zl7Sab/qxUH+az3cFBr6TkQB6WOoPKdRU5sWFRbVxgr94WF1bOJWsUeq0GggU4zBTyiJ3ak0La5cIhdT4IAPb3cWiWcilU332LST8evBO+U4G2o8WTVJFphF9PpYGEYnrtTCxP0gZBRLnE0kEY2VgD6gOouKwvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=DxdA3grE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mRpgGMjt; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id EF2F12001C0;
	Sun, 21 Jul 2024 13:09:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 21 Jul 2024 13:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1721581794; x=1721585394; bh=Qde/c+6Z/hkBxmXv+C8nC
	TTwpmLgGoegE+i4tHOFuUI=; b=DxdA3grEYdCEWjLgPYjlfz4fHgJxlOZOfeFqF
	9VrGLGN/6tKwj8PhXvFyT83LqOQdSSgyS2RR1yC1aFOl4EsR0S8u7gPTPSxpMbzt
	doEJCGHCBLgBGcWaFgkWNC4sJbgEfFBYkQSRQu8khJFBRFoVD3T/SMaznLkmDxVP
	DhUnv4jncnrOBflNYXrJEv74+0fdDTI0ABUJG2d7C+2sqnB+d8DZfoluey7FPEgg
	dwECw32ydBp3bIQLEjq55IMHTDTMx6BayF9CWvd/mNMZHmWjC6Z/7qwBGA+9djid
	sBfbZWPE3S6F3wjC8gWeT8P1foVny7OLMJsUUYU2IIKqJh9fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721581794; x=1721585394; bh=Qde/c+6Z/hkBxmXv+C8nCTTwpmLg
	GoegE+i4tHOFuUI=; b=mRpgGMjtvl99RUlSiUbmTiQBbSdAKbxUZWq6l3x+Kj/O
	RzcGItBT/O5UcHF+XwgCHZuqRINRCGVoOQ0+hqIXCz3E+5ggjHACeY3arIDWmCOs
	Szs49IOgSmtjADX5rxKcZluIfqHtZQPUSYyLEO7JVwucRNBciYQjLMTV3swMI1Iw
	swLCuthgBwJRYe57wNMTu5/ohtk4DnjmG3bMYRSXIF43Tpfdjk78b41tc0KpQfsC
	pqZ25liofmAqprptVP/upKOXmE/Ab0PwV6/Jr60jWsRZ5ZWWIwAzl7uPsdehSECW
	ED0TuTqqodCZ2HMQbFgB9HIvO1bB8GbLONRp7MDhWA==
X-ME-Sender: <xms:4kCdZvXm30bNSN0uL_TKlvQ1dESLuLuPl83F2kA2kf1wkw0dpW0xLA>
    <xme:4kCdZnmQp_4Uk8KzqM6W6CaRv27MahHEFRIkbZQ_s2ChPIRpI_xLlRnTUf-sO_I_2
    OLiOQ7Q5-lIy1HCr60>
X-ME-Received: <xmr:4kCdZraREQ5hpl5KRY-mBesGa4D3gVUqH_mBrsaAIlWYD8t_RElSw75NFfaVXifp2fsjcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheehgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgih
    ucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrth
    htvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffet
    feffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjh
    hvsehjvhhoshgsuhhrghhhrdhnvght
X-ME-Proxy: <xmx:4kCdZqX6DzMjQNljRmRJIOhqf1O7A6RJXXQVOBIub3suXXvVxECKsQ>
    <xmx:4kCdZpm6XXtQLRHfpBxatu9hEwYODxqbDs1ZHOPWmrng_wX94N8iiA>
    <xmx:4kCdZneFgPDQXOJVczHSLsv0MfVBT0-lMS50aUgGYNg8f_ZL15xWVA>
    <xmx:4kCdZjFP84x9OuAXX8m-cmGlEQF3qBub2nPLqXpR_yMn8kO0Mrn6sw>
    <xmx:4kCdZrmKmySuP9E0wpNcgNhVpDz9cAq5IU-V_gyE891ozC9TufNQ_vhG>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jul 2024 13:09:54 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id A90F39FC9E; Sun, 21 Jul 2024 10:09:53 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id A810B9FB97;
	Sun, 21 Jul 2024 10:09:53 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Johannes Berg <johannes@sipsolutions.net>
cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
    Johannes Berg <johannes.berg@intel.com>,
    Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next] net: bonding: correctly annotate RCU in
 bond_should_notify_peers()
In-reply-to: 
 <20240719094119.35c62455087d.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
References: 
 <20240719094119.35c62455087d.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
Comments: In-reply-to Johannes Berg <johannes@sipsolutions.net>
   message dated "Fri, 19 Jul 2024 09:41:18 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2730154.1721581793.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jul 2024 10:09:53 -0700
Message-ID: <2730155.1721581793@famine>

Johannes Berg <johannes@sipsolutions.net> wrote:

>From: Johannes Berg <johannes.berg@intel.com>
>
>RCU use in bond_should_notify_peers() looks wrong, since it does
>rcu_dereference(), leaves the critical section, and uses the
>pointer after that.
>
>Luckily, it's called either inside a nested RCU critical section
>or with the RTNL held.
>
>Annotate it with rcu_dereference_rtnl() instead, and remove the
>inner RCU critical section.
>
>Fixes: 4cb4f97b7e36 ("bonding: rebuild the lock use for bond_mii_monitor(=
)")
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

>---
> drivers/net/bonding/bond_main.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index d19aabf5d4fb..2ed0da068490 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1121,13 +1121,10 @@ static struct slave *bond_find_best_slave(struct =
bonding *bond)
> 	return bestslave;
> }
> =

>+/* must be called in RCU critical section or with RTNL held */
> static bool bond_should_notify_peers(struct bonding *bond)
> {
>-	struct slave *slave;
>-
>-	rcu_read_lock();
>-	slave =3D rcu_dereference(bond->curr_active_slave);
>-	rcu_read_unlock();
>+	struct slave *slave =3D rcu_dereference_rtnl(bond->curr_active_slave);
> =

> 	if (!slave || !bond->send_peer_notif ||
> 	    bond->send_peer_notif %
>-- =

>2.45.2
>

