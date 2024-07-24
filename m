Return-Path: <netdev+bounces-112741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E30693AF29
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 11:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13A41F22DC7
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA6114B960;
	Wed, 24 Jul 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pVB1+fpw"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261217E9;
	Wed, 24 Jul 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814130; cv=none; b=XIUFlsoUA+K3mQu/iYdaMSqV6q3MxKW/b3Fd8LlQF2TTBIB6m2Rnyc2fk2e+H5DMFCRVixBdfTDIBcG0Wm4BNaDxWi9UHGGQv88AOWOjloIFzdrMqlbqjSLGOlxsc2R2unDV2rmOGw7LYWme98Re+wTHpyaVv/oX84wwYlUrhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814130; c=relaxed/simple;
	bh=d6lknC36oKogXdApJcBUQrgBQD4KOdiyVDNEH9y7WtU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BiQHZ2Ud2/epqU/Eydwa+WA7b0FLmb/Ez4HbAmbXYg3sTK0L9XRFW7eZOaQ+ibACWIZguG+h8cxkXZOy55Qhqe+H4kkz46gK73NBzqwobk3DdFi8W4tSMZqHstK5LTXWTelxPP+L71HMlqLVaOxg/xY0ccYeodFNxiYmI8Exud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pVB1+fpw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=d6lknC36oKogXdApJcBUQrgBQD4KOdiyVDNEH9y7WtU=;
	t=1721814128; x=1723023728; b=pVB1+fpwMb4Be+jGHnmeCgpqnVcMPzW0LdzjGm4KTy7Ttlt
	3R+xa8GjwnuBM1DFC2R4sJEecq7oTGUlXtHTSEnYrGtGzkWIUKw2+jz6rSnLFEcmn5+HWsOW12ez3
	B6J01LDRT6wDJt7SGUmZlXA5MJ4wY75NScSgbuJAWXT1y21FWovEDosx+OscbCKJN3/kNrgxlG6Uy
	JZOBfsWhTRsp37E008UfSAXnu2emrmkVZlWopsap8kGyU/UCJoosQIXNC7SLArRgE6bxETIsnK8lI
	XEpAfkg4uKEhxfQquE84Tm+HM3QrtuwFcesIx++FUlGiDF7Hz2w2HpavnFCvmyEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWYVT-0000000DO05-2a1S;
	Wed, 24 Jul 2024 11:41:59 +0200
Message-ID: <0042d3c7d695ed7b253ccbc7786888dc3b400867.camel@sipsolutions.net>
Subject: Re: [PATCH net 1/4] net-sysfs: check device is present when showing
 carrier
From: Johannes Berg <johannes@sipsolutions.net>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 24 Jul 2024 11:41:56 +0200
In-Reply-To: <c20dcbc18af57f235974c9e5503491ea07a3ce99.camel@sipsolutions.net>
References: <cover.1721784184.git.jamie.bainbridge@gmail.com>
	 <066463d84fa14d5f61247b95340fca12d4d3bf34.1721784184.git.jamie.bainbridge@gmail.com>
	 <c20dcbc18af57f235974c9e5503491ea07a3ce99.camel@sipsolutions.net>
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

On Wed, 2024-07-24 at 11:35 +0200, Johannes Berg wrote:
> On Wed, 2024-07-24 at 01:46 +0000, Jamie Bainbridge wrote:
> > A sysfs reader can race with a device reset or removal.
>=20
> Kind of, yes, but please check what the race actually is.
>=20
> > This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
> > check for netdevice being present to speed_show") so add the same check
> > to carrier_show.
>=20
> You didn't say why it's needed here, so ... why is it?
>=20
> FWIW, I don't think it actually _is_ needed, since the netdev struct
> itself is still around, linkwatch_sync_dev() will not do anything that's
> not still needed anyway (the removal from list must clearly either still
> happen or nothing happens in the function). This will not call into the
> driver (which would be the problematic part).
>=20
> So while I don't think this is _wrong_ per se, I also don't think it's
> necessary, nor are you demonstrating that it is.
>=20
> And for userspace it should be pretty much immaterial whether it gets a
> real value or -EINVAL in the race, or -ENOENT because the file
> disappeared anyway?
>=20

All of which, btw, is also true for patches 3 and 4 in this set.

For patch 2 it seems applicable.

I do wonder if ethtool itself, at least ethtool netlink, doesn't have a
similar problem though, since it just uses netdev_get_by_name() /
netdev_get_by_index()?

johannes

