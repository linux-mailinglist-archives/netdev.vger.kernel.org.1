Return-Path: <netdev+bounces-146119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57F9D20B3
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DF6280FCB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F80155743;
	Tue, 19 Nov 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BBz3ObX9"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876F153835;
	Tue, 19 Nov 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001011; cv=none; b=ImjXatCtMmylbw6TMDeTcODAZ5aLe6tLSDmlyuyUsNNxLicxlhZR1mz9LMevJ7NEl5eGOS+fZnn5HPrSeWVV2KvIHxX2ElLUVwQOdJNTHaYcqVCm9Y6wMLfGbkQBjlgMzuUJIKqpLZo8+0R5iqO8L4mjk9970B+XgUty7q0BIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001011; c=relaxed/simple;
	bh=d4OaiI5kLQh+XV/WQ/3I7TdWOIfQRGs51zSzG5mKpxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GK/EeRlcEtOgxjJRzGmJWIxs55ts0BP0fSFrxUSIVOmX9Pd2+AJh0GQ4PXAE2SqO5VijqkBuNzfTbuaHwnxjdvdEqnbGMCLNkaP3gbldXD1aeoezssW08ypD4GMvHKOUmXbivM5LssIFHwmyLUCoQCypH3TE6UtU/0ozxcsZ9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BBz3ObX9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AJ7Mk9R22078163, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732000966; bh=d4OaiI5kLQh+XV/WQ/3I7TdWOIfQRGs51zSzG5mKpxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BBz3ObX9AKklulWfVXllvHdMWecTxw3oZgOwK/Pp4OJgf8Lsrnjrpa/FeVWXrmpYK
	 TqyERxp4MFT8uv+qEARe3WelNukFTESYPChpAPPHXeDedJbI2Q7d95ofCYBFRkMN/x
	 d2dBAG1BgY8ks1oxwq6+0nQ9M61EEVtgJpWAG2a4tQKcigPZejhgzGoAsj9bBDw5LZ
	 a3kDuI293fH6x5ZWGB9HQmqNHNLB5DNSMvvdtE9mDA82IGsd633HEVwPwYV+09nuPz
	 L9ykBuqgWKfnKCPVbzMuCRzwSz2OOPvhO0WFnKKgw21E2KO6dQ3rFxCJ2+Jl39vBp2
	 1gCx6oRG4oBWg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AJ7Mk9R22078163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 15:22:46 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 15:22:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Nov 2024 15:22:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 19 Nov 2024 15:22:46 +0800
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
Thread-Index: AQHbOW/NBxXm0bSy4UegwMBfAsYEBbK8XWoAgAHO/AA=
Date: Tue, 19 Nov 2024 07:22:46 +0000
Message-ID: <7c1a67a1ec7b4b1eb4965575b625a628@realtek.com>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-5-justinlai0215@realtek.com>
 <Zzsh3AjTAnQoKKTl@localhost.localdomain>
In-Reply-To: <Zzsh3AjTAnQoKKTl@localhost.localdomain>
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
> On Mon, Nov 18, 2024 at 12:08:28PM +0800, Justin Lai wrote:
> > Add defines for hardware version id.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase.h      |  5 ++++-
> >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
>=20
> The patch is addressed to the "net" tree, but "Fixes" tag is missing.
> Also, the patch does not look like a bugfix it's rather an improvement of=
 coding
> style with no functional changes. That's why I doubt it should go to the =
"net"
> tree.
>=20
> Thanks,
> Michal

Hi Michal,

This patch introduces multiple defines for hardware version IDs, rather
than addressing any issues related to the function logic, which is why it
does not include a "Fixes:" tag. The reason for isolating this change in a
separate patch is to maintain a "single patch, single purpose" approach.
Additionally, these defines will be used in other patches within the same
patch set, which is why they are included in this patch set as a whole.

Justin

