Return-Path: <netdev+bounces-146387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189A99D33B7
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBDF1F23E21
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034FB15B97E;
	Wed, 20 Nov 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="asGOkefe"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B01157E78;
	Wed, 20 Nov 2024 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084841; cv=none; b=MjXglJSacvIg0sLNbFHEfZIIZfWenGBXM7sLyeBIR14AL5hE8OB7NbpLIPqsU1dYxLEFqJ9AXsItUCDd3dYwchbh+aitZs7A6mEP17UK94GEPbZFzsyCk8JToG41T59bBWkPrDHWyzvOH8eQfGjfDvt9tPTHS9FESSnsewvasqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084841; c=relaxed/simple;
	bh=AQHav6mq9jxb1m5+yTFlphJaUhWsChLctAm9ANCkOKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r2ZKFrxPMEwmtJcI9b51kzdrkdeVPGf2b/KvX0KHM7HFBKyLunaoKQQdyiATsst/hkWa64l14O87fCTWWZaelib6fXWkADvNAu5A3GRMHX1X/5BraZM7275cDxdODr6xDs1VloAFH9Qm1msSjCtkTMluvE6lmzwQxU+w+TowjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=asGOkefe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK6e7sU53657917, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732084807; bh=AQHav6mq9jxb1m5+yTFlphJaUhWsChLctAm9ANCkOKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=asGOkefe8ykStiyCN1wnzNQEwOGZsMb0yJoQEB9yCP+JBQugbJvJPmbu/uq8GrUDC
	 tv3Y2kZnQZk0JBnBOlujjG/fsTAf9PF6utydKZdK5ccVS5w3l5LJu7qEgdHHrOAwCH
	 Ug78t65S0qIO4QrECZbiADFkNJ2c8NcmERmeqlZzMfxGF9+jasrXpsm9GTUwxjqcAk
	 VuyZP0adXly6+Fh7WVXqsvE0hijoxnz+PCrsWmy5a0z+zsqxfRveZMCBKDy5IlooqI
	 nJvphtPmbSrWf5Kdmx7YeBT0tTD5gTrYjDcI7rZweOjKDFFvCCpSCfqfzvBgT5sj2C
	 UvdyqklMUS0/g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK6e7sU53657917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 14:40:07 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 14:40:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Nov 2024 14:40:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 20 Nov 2024 14:40:06 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Michal Kubiak <michal.kubiak@intel.com>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net v3 4/4] rtase: Add defines for hardware version id
Thread-Topic: [PATCH net v3 4/4] rtase: Add defines for hardware version id
Thread-Index: AQHbOW/NBxXm0bSy4UegwMBfAsYEBbK8XWoAgAHO/AD//8cGgIABwMDA
Date: Wed, 20 Nov 2024 06:40:06 +0000
Message-ID: <3fc55df5a3e84743a93a16f4a8807dfe@realtek.com>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-5-justinlai0215@realtek.com>
 <Zzsh3AjTAnQoKKTl@localhost.localdomain>
 <7c1a67a1ec7b4b1eb4965575b625a628@realtek.com>
 <Zzx2ccp65u+AkxHt@localhost.localdomain>
In-Reply-To: <Zzx2ccp65u+AkxHt@localhost.localdomain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>=20
> On Tue, Nov 19, 2024 at 07:22:46AM +0000, Justin Lai wrote:
> > >
> > > On Mon, Nov 18, 2024 at 12:08:28PM +0800, Justin Lai wrote:
> > > > Add defines for hardware version id.
> > > >
> > > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > > ---
> > > >  drivers/net/ethernet/realtek/rtase/rtase.h      |  5 ++++-
> > > >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
> > > >  2 files changed, 10 insertions(+), 7 deletions(-)
> > > >
> > >
> > > The patch is addressed to the "net" tree, but "Fixes" tag is missing.
> > > Also, the patch does not look like a bugfix it's rather an
> > > improvement of coding style with no functional changes. That's why I =
doubt
> it should go to the "net"
> > > tree.
> > >
> > > Thanks,
> > > Michal
> >
> > Hi Michal,
> >
> > This patch introduces multiple defines for hardware version IDs,
> > rather than addressing any issues related to the function logic, which
> > is why it does not include a "Fixes:" tag. The reason for isolating
> > this change in a separate patch is to maintain a "single patch, single
> purpose" approach.
> > Additionally, these defines will be used in other patches within the
> > same patch set, which is why they are included in this patch set as a w=
hole.
> >
> > Justin
> >
>=20
> Hi Justin,
>=20
> I understand the purpose of the patch, however the patch is addressed to =
the
> "net" tree. Each patch sent to "net" tree should have "Fixes" tag, becaus=
e that
> tree is for fixes only.
> You may consider sending the patch to the "net-next", (which is closed no=
w
> because of the merge window).
>=20
> Thanks,
> Michal

Hi Michal,

Thank you for your suggestion. Upon further consideration, I agree
that the addition of the hardware version ID definitions should have been
implemented directly when fixing the related issue. I will make the
necessary changes accordingly.

Justin

