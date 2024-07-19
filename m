Return-Path: <netdev+bounces-112248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80653937B10
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 18:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31191C21D55
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096D127E37;
	Fri, 19 Jul 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A0SwgJwB"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33CC2F30
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406688; cv=none; b=auDwE0EU9RVUE+RNlbnpYpZ2ERlIjbX3NyuEUQoW+rgavXHjD2ZdhoMI93ctnskluw74XCKTCGNr+oPB2UKFfxrztiR/vbkRF4uJEAetIqidrdJX1iUmnyTWG0LSAIsWdo03K7xFPqqt1Sb9hrE0nE+ZPLonEH4Df7MRCSY7g+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406688; c=relaxed/simple;
	bh=jDJU5pe/iOUxD+qkXAn8EfURJmvuQjQGGs9PBoMsWMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RtIK3xyrtVOCBJ25EXvjIiwF2VSOjnSjjArH4JbF5aL1qVVkngQqcBPju5Zxze1//ijGW+MmUDqqqBs2Yv0Kz8V9gQ48lG9++hSlFTjfouU13LmBsVs49RBV2gaTg3CYz2GiZPugmbxyUCnSnwP4Y6oPWiOypBoDo52r6fHQ5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A0SwgJwB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jDJU5pe/iOUxD+qkXAn8EfURJmvuQjQGGs9PBoMsWMo=;
	t=1721406687; x=1722616287; b=A0SwgJwBmvJCB3P43tU8XWosrAogxjzlNq2nxpXvZZSV0id
	cfqlv7QJfYkl5Byoe7ANRCWChoF1vT1v6jzzqKExDpqnYc4Vsn6vX6VaSdPFPmresV1uqdUlTid/6
	+D8QUhRMIzXCfeekKR8rYr9+HiqspINl2wStaCrv0fhC/Q+VH9A41IeVrepebUBYkt8dPnFhYMa7s
	EalV3NqUdyQKkO34iRbx4uYZU6hDzZgldo4bJ91HEEne3RF/mGAmqVLih69/XKoth4pgt098D01hx
	UrAUlL4ydc3K0hp2zsGQ5Ej5Y7Abo8QJ0kAF6R7nlGQJ4F8MtdUa92fm7S8k1YKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sUqVt-000000041Sc-2Yrt;
	Fri, 19 Jul 2024 18:31:22 +0200
Message-ID: <59de0f9b3c4f59f7921cafb2115478fed82b1c4c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] net: bonding: correctly annotate RCU in
 bond_should_notify_peers()
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Jul 2024 09:31:18 -0700
In-Reply-To: <Zpo0_CoGmJVoj8E7@nanopsycho.orion>
References: 
	<20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
	 <Zpo0_CoGmJVoj8E7@nanopsycho.orion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-07-19 at 11:42 +0200, Jiri Pirko wrote:
> Thu, Jul 18, 2024 at 09:20:16PM CEST, johannes@sipsolutions.net wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > RCU use in bond_should_notify_peers() looks wrong, since it does
> > rcu_dereference(), leaves the critical section, and uses the
> > pointer after that.
> >=20
> > Luckily, it's called either inside a nested RCU critical section
> > or with the RTNL held.
> >=20
> > Annotate it with rcu_dereference_rtnl() instead, and remove the
> > inner RCU critical section.
> >=20
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Fixes 4cb4f97b7e361745281e843499ba58691112d2f8 perhaps?
>=20

I don't really want to get into that discussion again :)

Thanks for looking!

johannes

