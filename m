Return-Path: <netdev+bounces-192731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B611AC0F03
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2556B7A2D0C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E828D8EE;
	Thu, 22 May 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iRSi31es"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3528DB58
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925740; cv=none; b=o/5LsuUGDxr8SY55Z29bEr/pwQ5RD/zGRFdmF/HodbqnEIpXVosbG77NW1MIxNgpPuzyvMiPqPi3X1ne+hq8z7WCPjwHvt36mL5mVpZThN7dAK3yNNoMzgY+s7X7QcJSfqX2ny5YqznXJ3e2Z3w19x9N2rYR8LPZI1JPNCthz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925740; c=relaxed/simple;
	bh=e3pZ//oX0zG7RU6zMKZJ8niUMHM55nsr+Mg4q8xjB/k=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1hEZ9tCRdD95I4HnNEFe6Q3i04DUf1t6Dvq2ecUPht61Bqjtd+rivy8rZNfDX21HzAeYOIznyo6trvgEilZIH/6xQBJzNnsOBLaZ4SRUqtCtMVwHlGrfLQAFbJN50rlntWvsmylvR7P3Geq9zDB7uRAl9kd0ITe1+jqva/XOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iRSi31es; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747925740; x=1779461740;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=MKri9EjMJyXz7BsqgNUGvs9McbTJp2YY+CES4POmFOU=;
  b=iRSi31esFtajgH8rfLP0772LfiFHe7+gYVr/PHmqmhQkeJzrQONd/rEX
   Y2aEaIxoxIEBfJY9K5sns/3a0MtfUnXYC39zDRLAFhING+UdBySrsU2Vt
   tpHfSJO5VsxuIBlEEVO9CN4LklESGjZmpjg6GyT2WMn/hPuvccuy7PVw5
   KGp9YBqRDrKfSo6bb3R9YmJ8On6dXCLs9FHRK0boojIF4Twn8GfYY64f+
   5mHdQmCjeydAQKQEy6ssvSS8Z0ie6ohcGEBlbKI/X9zwIksoeZ5fC6y/Y
   7ccpo8sFu7N2FLlsUX+CrAoIffb4Au1AdNe+CsE2ig9YjZmeWEDE28wfp
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="747499676"
Subject: RE: [PATCH v10 net-next 4/8] net: ena: Control PHC enable through devlink
Thread-Topic: [PATCH v10 net-next 4/8] net: ena: Control PHC enable through devlink
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 14:55:37 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:51364]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.17:2525] with esmtp (Farcaster)
 id 285f3b98-930e-4dd0-b23b-d9fc2a41d0c8; Thu, 22 May 2025 14:55:35 +0000 (UTC)
X-Farcaster-Flow-ID: 285f3b98-930e-4dd0-b23b-d9fc2a41d0c8
Received: from EX19D010EUA002.ant.amazon.com (10.252.50.108) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 14:55:35 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D010EUA002.ant.amazon.com (10.252.50.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 14:55:35 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Thu, 22 May 2025 14:55:35 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Allen, Neil"
	<shayagr@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>,
	Leon Romanovsky <leon@kernel.org>
Thread-Index: AQHbyyB0M9vwly4JDkatslAI5bthobPerL2AgAAGR3CAAAOigIAAArCw
Date: Thu, 22 May 2025 14:55:35 +0000
Message-ID: <6469535d9f814e238b371f56e91da4ad@amazon.com>
References: <20250522134839.1336-1-darinzon@amazon.com>
 <20250522134839.1336-5-darinzon@amazon.com>
 <aq5z7dmgtdvdut437b3r3jfhevzfhknf5zr5obaunadp2xkzsh@iene76rtx3xc>
 <11eaa373bb894946bc693d9a1e112ca5@amazon.com>
 <76xnvcmdkohjxui2e2g7xe4b4iaxiork5e3k4n6inniut63a5s@6voxc4okdixd>
In-Reply-To: <76xnvcmdkohjxui2e2g7xe4b4iaxiork5e3k4n6inniut63a5s@6voxc4okdixd>
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

> >> >+enum ena_devlink_param_id {
> >> >+      ENA_DEVLINK_PARAM_ID_BASE =3D
> >> DEVLINK_PARAM_GENERIC_ID_MAX,
> >> >+      ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
> >>
> >> What exactly is driver/vendor specific about this? Sounds quite
> >> generic to me.
> >
> >Can you please clarify the question?
> >If you refer to the need of ENA_DEVLINK_PARAM_ID_PHC_ENABLE, it was
> >discussed as part of patchset v8 in
> >https://lore.kernel.org/netdev/20250304190504.3743-6-
> darinzon@amazon.co
> >m/ More specifically in
> >https://lore.kernel.org/netdev/55f9df6241d052a91dfde950af04c70969ea28
> b2
> >.camel@infradead.org/
> >
>=20
> Could you please read "Generic configuration parameters" section of
> Documentation/networking/devlink/devlink-params.rst? Perhaps that would
> help. So basically my question is, why your new param can't go in that li=
st?

Thanks for the clarification.
This is a topic that has been discussed in the versions of this patchset, s=
pecifically in https://lore.kernel.org/netdev/20250304190504.3743-6-darinzo=
n@amazon.com/
Other modules in the kernel enable PHC unconditionally, due to potential bl=
ast radius concerns, we've decided to not enable the feature unconditionall=
y and allow customers to enable
it if they choose to use the functionality.
As this is a specific behavior for the ENA driver, we've added a specific d=
evlink parameter (was a sysfs entry previously and changed to devlink in v9=
 due to feedback).

David





