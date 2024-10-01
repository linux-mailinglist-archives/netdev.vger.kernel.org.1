Return-Path: <netdev+bounces-130960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F01DB98C390
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C251F239E5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E041CB33D;
	Tue,  1 Oct 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qk5cyP8I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69181C6889;
	Tue,  1 Oct 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800840; cv=none; b=dGEEUPju4atBVVLvebMbZtH7Gj4T1FQ69Vj7H1RAdfY8Idiog135wOjWOi+tfu4tVtQVnBR88duEzrgzgL8RX3Qcsb9H8AyR4cyThDN0WbsUNmxX9WzAlYp5ny7DX/pmk9jO/k2Q7H8Y8mj7J6okOlZ08xWzRArxvcPkkNmDXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800840; c=relaxed/simple;
	bh=tbxltioe4UxqII6IuSYfH/91v2fHgWawjWBWpCfgAN0=;
	h=Subject:From:To:CC:Date:Message-ID:Content-Type:MIME-Version; b=scSzBqJAdKDo0hShmuyDpj5ZYI51m1MYFjCLenLro5wzzI77sfwqJLyZFqYfL1xH3ZdqnJicC4qiva71KR1f5s2nohImLUE8eFMRFKRYet2iTkFYHBIycOjsR78dG1ans6ONjYk2DMt70KHpdQXbd9yjcyLAX/TaU0nc3PQNTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Qk5cyP8I; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727800840; x=1759336840;
  h=from:to:cc:date:message-id:content-transfer-encoding:
   mime-version:subject;
  bh=KO17tWuInozhT9FEOOAQMiOIb+6ei9dI3CJktzYd7nw=;
  b=Qk5cyP8I62h0UNG/LIBDukN/qJNcJhRFpSaHTVkJQPz9eozYa4c/xLrt
   dOrvcuFZu04F/FSXQtmDK29oDsWrj5WeUQSClg6JXjb2RXlacPG2Wga3Q
   0V0J+PvJ7JoebeOs3859B6MdY/WqR7dQhjCC32WKmGpR6lgblt9SuPU9V
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,169,1725321600"; 
   d="scan'208";a="428014621"
Subject: RE: [net-next 2/2] ena: Link queues to NAPIs
Thread-Topic: [net-next 2/2] ena: Link queues to NAPIs
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 16:40:35 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:8929]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.202:2525] with esmtp (Farcaster)
 id 9f954259-33bb-494c-be66-58e8d88b93fc; Tue, 1 Oct 2024 16:40:33 +0000 (UTC)
X-Farcaster-Flow-ID: 9f954259-33bb-494c-be66-58e8d88b93fc
Received: from EX19D022EUA004.ant.amazon.com (10.252.50.82) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 16:40:32 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA004.ant.amazon.com (10.252.50.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 16:40:32 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 1 Oct 2024 16:40:32 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Joe Damato <jdamato@fastly.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan,
 Noam" <ndagan@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kamal Heib
	<kheib@redhat.com>, open list <linux-kernel@vger.kernel.org>, "Bernstein,
 Amit" <amitbern@amazon.com>
Thread-Index: AdsUH1BcZ3SdHNiaRde9tfYeD4nCcQ==
Date: Tue, 1 Oct 2024 16:40:32 +0000
Message-ID: <d631f97559534c058fbd5c95afcb807a@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> > > >
> > > > Thank you for uploading this patch.
> > >
> > > Can you please let me know (explicitly) if you want me to send a
> > > second revision (when net-next allows for it) to remove the 'struct
> > > napi_struct' and add a comment as described above?
> >
> > Yes, I would appreciate that.
> > I guess the `struct napi_struct` is OK, this way both functions will lo=
ok the
> same.
> > Regarding the comment, yes please, something like /* This API is
> supported for non-XDP queues only */ in both places.
> > I also added a small request to preserve reverse christmas tree order o=
n
> patch 1/2 in the series.
>=20
> Thanks for mentioning the nit about reverse christmas tree order; I misse=
d
> that.
>=20
> I will:
>   - Fix the ordering of the variables in 1/2
>   - Add 2 comments in 2/2
>=20
> I'll have to wait the ~48hr timeout before I can post the v2, but I'll be=
 sure to
> CC you on the next revision.

It's not at least a 24hr timeout?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/maintainer-netdev.rst#n394

>=20
> > Thank you again for the patches in the driver.
>=20
> No worries, thanks for the review.
>=20
> BTW: Since neither of the changes you've asked me to make are functional
> changes, would you mind testing the driver changes on your side just to
> make sure? I tested them myself on an ec2 instance with an ENA driver, bu=
t I
> am not an expert on ENA :)
>=20
> - Joe

I picked up the patch and got to the same results that you did when running=
 on an EC2 instance.
Thank you for sharing the commands in the commit messages, it was really he=
lpful.
Correct me if I'm wrong, but there's no functional impact to these changes =
except the ability to
view the mappings through netlink.

