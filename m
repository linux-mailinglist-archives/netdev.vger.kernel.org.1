Return-Path: <netdev+bounces-225654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86ABB96819
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CD43ACDD7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0222566D9;
	Tue, 23 Sep 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="PXnQhrKC"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFB257830
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640302; cv=none; b=EY6dnMkdKinBFYKXUxPRuHHjlo3YZYUAfGvD8NBvKG7qaAfoD9BH7nvwV0bZkU/4NfevtdFaCnzolUd6f07G2rVyMUMWtr5rAO2EmCKprOfv3wMq1QAErcr9x59HUPJyYFmyo7jfa4OkLfvaHEdkfyI1VouamcGBILCkj9bfOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640302; c=relaxed/simple;
	bh=8mDY4B6x16UubM1tHpDfz+ZOAPsKZK8nodQkPM692b8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvm2F6+TframrHzmkV2vyKhWmISVNY1P3ZIZ+SX9JltJYUOd01wn6VXc7dulMSwFAP4mwYi8ewKJi16SMXmPbKCggPSMjpU3zX64F0yEN0Kn3NGKdfqH75PNoHNDrAA9onsoTpcWoNPJGy8tbY9nV43Ir71cX97iYf6f8mrTYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=PXnQhrKC; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0D936202C0;
	Tue, 23 Sep 2025 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1758639698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDVbKqKVUc5DmX8sOGrhbARykAzUGRNjOAhzic4Sfuo=;
	b=PXnQhrKCnFtYlmEDJzZ9+z3cE3eDa0vCOBrgIR6i/FKGZ8/9mHIlauZE2wNiDkXdP/AUkQ
	e7DlHM71Jjke3tSO8DUvl3ojTpZS9K4OQ0KVBwDchfi84RMqpNGCENkvy5KVwKvtpzaPYx
	wNnMlZoW5KNAGry6HnHCUq+Hphz2YFc=
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
Date: Tue, 23 Sep 2025 17:01:30 +0200
Message-ID: <5043679.31r3eYUQgx@ripper>
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
Content-Type: multipart/signed; boundary="nextPart4681830.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4681830.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Sep 2025 17:01:30 +0200
Message-ID: <5043679.31r3eYUQgx@ripper>
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

Thanks for the debugging. I have some doubts that the move is correct - but I 
need to check this in detail when I have more time. Unfortunately, this will 
not happen before the end of the week. I hope this is ok for you.

Regards,
	Sven
--nextPart4681830.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaNK2SgAKCRBND3cr0xT1
y2JoAQDPsuCJHcvYYlRKtGScm5x4vRhLsNIfo4Z8Y1dycx2lnAD/ei2Tqec/sy24
hydpmxkXRLcP2Z3IWUmTqwHTpIlT7AU=
=18Wp
-----END PGP SIGNATURE-----

--nextPart4681830.LvFx2qVVIh--




