Return-Path: <netdev+bounces-169555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB80FA44936
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396D03BB169
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1719993B;
	Tue, 25 Feb 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HuTK/Fk+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1314F9C4
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506011; cv=none; b=XPoE5xifsAq+j9sV8Cob4AIRUPq0N+qYQm59uygd9ZpSwQwaUqrPy0u0j12rpbztCdwEjM4DKp3DzR7D6uxOK6X9uB9lIF9U2615SNd2atTSaMfuZylIXUzzoWrD5MKjumwYBPLt22X8WQa06j/EghfAyglfI9dloTp6As4RVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506011; c=relaxed/simple;
	bh=2aOM906+3hyJ0FMFSgPDacZPxXA7tPP73eMAwY4IRzU=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=izcA0InrfAzk+kO7Z07dv8C7JgSVDj9hDJ5hvyg5ttLj/aV/xXcUCNkxyuX2qsAJKgfo5nKT1D5s7TJef+fc3XdQ+IPPSW4ImV4qWE14c8EcksFTqXLlopTsUh3+BrOP15y0fUTDvxY5ntInWIWcOn537z7PQQvi5R4Gl7mEXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HuTK/Fk+; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740506009; x=1772042009;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=j4UI7YuMtjTGMb/1QpuMHTA5XJ93q9VNuMXjYYMYv8U=;
  b=HuTK/Fk+lZd0TuIwsw65hzJQHy0gP2wtjqMOHkNMkafsNEaRDSiR8Iqn
   O4rPCHV3vQFItO5bUBmV40b7vEmQYGJjs7pcS67gIrIQEulKUJ3vouHfM
   3RV+oqIOSR9Ciq5EC2efhqAu91wqfAWVE3sWpchkBciDyOJhZwIWtqaFM
   8=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="25928283"
Subject: RE: [PATCH v7 net-next 4/5] net: ena: PHC stats through sysfs
Thread-Topic: [PATCH v7 net-next 4/5] net: ena: PHC stats through sysfs
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:53:27 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:47044]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.30.133:2525] with esmtp (Farcaster)
 id a1f908e3-96cb-4dea-99fd-e63b57665d59; Tue, 25 Feb 2025 17:53:26 +0000 (UTC)
X-Farcaster-Flow-ID: a1f908e3-96cb-4dea-99fd-e63b57665d59
Received: from EX19D006EUA002.ant.amazon.com (10.252.50.65) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 17:53:26 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D006EUA002.ant.amazon.com (10.252.50.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 17:53:25 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Tue, 25 Feb 2025 17:53:25 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Simon Horman <horms@kernel.org>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.co.uk>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Allen, Neil" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Thread-Index: AQHbgjSY2YmZf3/qrUmDalvDVwEGQ7NXzb6AgACJ3tA=
Date: Tue, 25 Feb 2025 17:53:25 +0000
Message-ID: <c650369bb0394184951161eb34772a1a@amazon.com>
References: <20250218183948.757-1-darinzon@amazon.com>
 <20250218183948.757-5-darinzon@amazon.com>
 <20250225093851.GJ1615191@kernel.org>
In-Reply-To: <20250225093851.GJ1615191@kernel.org>
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

> > The patch allows retrieving PHC statistics through sysfs.
> > In case the feature is not enabled (through `phc_enable` sysfs entry),
> > no output will be written.
> >
> > Signed-off-by: David Arinzon <darinzon@amazon.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_sysfs.c
> > b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
> > index d0ded92d..10993594 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_sysfs.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
> > @@ -65,6 +65,52 @@ static ssize_t ena_phc_enable_get(struct device
> > *dev,  static DEVICE_ATTR(phc_enable, S_IRUGO | S_IWUSR,
> ena_phc_enable_get,
> >                  ena_phc_enable_set);
> >
> > +#define ENA_STAT_ENA_COM_PHC_ENTRY(stat) { \
> > +     .name =3D #stat, \
> > +     .stat_offset =3D offsetof(struct ena_com_stats_phc, stat) /
> > +sizeof(u64) \ }
> > +
> > +const struct ena_stats ena_stats_ena_com_phc_strings[] =3D {
> > +     ENA_STAT_ENA_COM_PHC_ENTRY(phc_cnt),
> > +     ENA_STAT_ENA_COM_PHC_ENTRY(phc_exp),
> > +     ENA_STAT_ENA_COM_PHC_ENTRY(phc_skp),
> > +     ENA_STAT_ENA_COM_PHC_ENTRY(phc_err),
> > +};
>=20
> Hi David,
>=20
> Some very minor nits from my side:
>=20
> Is seems that ena_stats_ena_com_phc_strings is only used in this file and
> thus should be static.
>=20

Thanks Simon, I also saw it in the compilation warnings in patchwork.
This code will be modified/removed in v8.

Thanks,
David

> > +
> > +u16 ena_stats_array_ena_com_phc_size =3D
> > +ARRAY_SIZE(ena_stats_ena_com_phc_strings);
>=20
> Likewise for ena_stats_array_ena_com_phc_size.
>=20
> ...

