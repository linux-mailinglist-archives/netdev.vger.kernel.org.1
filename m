Return-Path: <netdev+bounces-112610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D1E93A2B0
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F172836E0
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42CB154445;
	Tue, 23 Jul 2024 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tcrhIRI0"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26415252E
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744873; cv=none; b=ZFt/54Jmbm917Xk1bqqOmI8SB9OF2me3en12QhDTbFVMfyE57wvzVJUV3FeE98dxLOpQ47uI8jedobO2JTdUqhTCkes9YO4/fPRiabvhPE4QEuq//OZYFLy3+i/1WbOJewuZFMS6/WoLQSt3jzo3hZFmVT17b0rbq1jGMiwxkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744873; c=relaxed/simple;
	bh=aXlS1HR5N5l7PTTu6KfKXzGMtv0wg5hpbbIRVuRoQWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppgql3054MNhnqv7jZXAxIwdGZW6s3NBoRrP1UI/1rDG7nSv7Qo51q6l2pCcj9Fv8IXdUj8OSZEM4SNYn+GEDf7UhWdDrXonR2C6c1O76kOKOfBsNLMcgKpRKnkCnW9WHPajWKrXear1AA7UKuGnVfzQ8NOVy9GjhHjvny/d4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tcrhIRI0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aXlS1HR5N5l7PTTu6KfKXzGMtv0wg5hpbbIRVuRoQWI=;
	t=1721744871; x=1722954471; b=tcrhIRI0fxfnjF0NXfPVHMqr/rbHZbDfNhnxR553hb++G17
	S4LzhK0Kz9rsrCC5KSOxFpLMh6nWlof/hCG7gbMbO2l9GG/9L+qKB57gL2Ig7FJNj7DoCKGr3NCex
	3FTD6hMdaI8n7bFmpBnijLkf0wxPtpb5kXyyC0s9NRj26I1x0ltWu4nlE6GZt1cVPFP8nVNipm/ey
	ZR2wWUmao1LF75pwPeGbvwtKTeTVry3QRebmWAQ/uvddi69m3JtB78n4i/Rvx+chRGacr3+buSzyn
	c4sjmLn3AbcXQfHNM0HrPWwRPKhpfnrTj++EwMDBVflG6O0HCWp9YF9lZocW1JHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWGUX-0000000BOe3-0XcD;
	Tue, 23 Jul 2024 16:27:49 +0200
Message-ID: <ba309652e6ebc9ae154fe1f8cb1679216c5c07cc.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] net: bonding: correctly annotate RCU in
 bond_should_notify_peers()
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 16:27:48 +0200
In-Reply-To: <Zp-8qM7178LYGJ_q@nanopsycho.orion>
References: 
	<20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
	 <Zpo0_CoGmJVoj8E7@nanopsycho.orion>
	 <59de0f9b3c4f59f7921cafb2115478fed82b1c4c.camel@sipsolutions.net>
	 <Zp-8qM7178LYGJ_q@nanopsycho.orion>
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

On Tue, 2024-07-23 at 16:22 +0200, Jiri Pirko wrote:
> Fri, Jul 19, 2024 at 06:31:18PM CEST, johannes@sipsolutions.net wrote:
> > On Fri, 2024-07-19 at 11:42 +0200, Jiri Pirko wrote:
> > > Thu, Jul 18, 2024 at 09:20:16PM CEST, johannes@sipsolutions.net wrote=
:
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > > >=20
> > > > RCU use in bond_should_notify_peers() looks wrong, since it does
> > > > rcu_dereference(), leaves the critical section, and uses the
> > > > pointer after that.
> > > >=20
> > > > Luckily, it's called either inside a nested RCU critical section
> > > > or with the RTNL held.
> > > >=20
> > > > Annotate it with rcu_dereference_rtnl() instead, and remove the
> > > > inner RCU critical section.
> > > >=20
> > > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > >=20
> > > Fixes 4cb4f97b7e361745281e843499ba58691112d2f8 perhaps?
> > >=20
> >=20
> > I don't really want to get into that discussion again :)
>=20
> Which one? I have to be missing something...
>=20

The one that we like to repeat all the time about whether a Fixes tag
should be included or not, like in=20

https://lore.kernel.org/netdev/20240705134221.2f4de205caa1.I28496dc0f2ced58=
0282d1fb892048017c4491e21@changeid/

johannes

