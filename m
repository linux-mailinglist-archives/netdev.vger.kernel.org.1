Return-Path: <netdev+bounces-159718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F9A169B5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5D997A12D0
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E63191489;
	Mon, 20 Jan 2025 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FhsPJuQS"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0A189B91;
	Mon, 20 Jan 2025 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365848; cv=none; b=Hv9nmzMKNwkrYUEAnJmnf4z37Lflhg6Pgw/7ajJBffBdPsEf8Xv6UxJqBWeKSwEK/RrSi48dzmYNou6HUvFhuMHo99aL/h0mU6dl5rQEfUbA5YQLtSr2p/QEb8JfLTPAou7Cp8dq9pqWBwhBaN9FL51pBSn3bGdh/7u83u33ogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365848; c=relaxed/simple;
	bh=5+ZsQB6AOuuYy94vT7MetNCAPphFT0a2qJuh6sOyqpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgnyNB04Ll5zk3VAhmYDr2yuDwML2ci78uO9nvEjLQbvZJav6jC49qFC+JXwYAg95XCtodsN1/gbTFD9L13xRQ0yDtJnDIa39ThqmCC4Nv/SVn5LQsmlEs18SIT60BEZblcOhiFh30VH5RCYjzA83GVl3v/4pIXc+P3BVBQ+fDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FhsPJuQS; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A97220009;
	Mon, 20 Jan 2025 09:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737365845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMf1rpkaGy/deBLQSLFJGdUxccYCefiauh9Lod6ccUc=;
	b=FhsPJuQSK9y3YRwBKVP41AAqw8eqIu7hXUBpFRS0QjhBscPYR/ScYMdJHMft6QmFYqpsfx
	Xqaqmze9ueFf5BZEG6FLyZUv7B+aalPrurw2E3cPYilDOsZMB88TryI7p6U0U9R1M/onvY
	wlRNbaSOFe02UIN+XB62YKI4Ld8KCF3GQ5iwXfsLgvFLcLwgl9L0GUYpROl68ObAyir4Ho
	kkUy/Y7cx+/pcshAAbfVhNCLj/IGvwpNAH5aSmvliLdPCE1OyCfCTRmHv3f6DMVXf4nhfq
	J1q/2r5Ui/HXIHWFr9ftXxK1nOX8FZvfr4KZQvMndtnYsKwVtaZyftQ5uOapWw==
Date: Mon, 20 Jan 2025 10:37:22 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250120103722.706b5bc8@kmaincent-XPS-13-7390>
In-Reply-To: <20250117190720.1bb02d71@kernel.org>
References: <20250117173645.1107460-1-kory.maincent@bootlin.com>
	<CANn89i+PM5JLdN1meKH_moPe88F_=Nsb3in+g-ZK5tiH4PH5GA@mail.gmail.com>
	<20250117231659.31a4b7fa@kmaincent-XPS-13-7390>
	<20250117190720.1bb02d71@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 17 Jan 2025 19:07:20 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 17 Jan 2025 23:16:59 +0100 Kory Maincent wrote:
> > > If not protected by RTNL, what prevents two threads from calling this
> > > function at the same time,
> > > thus attempting to kfree_rcu() the same pointer twice ?   =20
> >=20
> > I don't think this function can be called simultaneously from two threa=
ds,
> > if this were the case we would have already seen several issues with the
> > phydev pointer. But maybe I am wrong.
> >=20
> > The rcu_lock here is to prevent concurrent dev->hwprov pointer modifica=
tion
> > done under rtnl_lock in net/ethtool/tsconfig.c. =20
>=20
> I could also be wrong, but I don't recall being told that suspend path
> can't race with anything else. So I think ravb should probably take
> rtnl_lock or some such when its shutting itself down.. ?
>=20
> If I'm wrong I think we should mention this is from suspend and
> add Claudiu's stack trace to the commit msg.

Is it ok if I send the v3 fix in net-next even if it is closed?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

