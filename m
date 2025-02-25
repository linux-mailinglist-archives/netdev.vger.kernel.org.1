Return-Path: <netdev+bounces-169553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153DAA4494D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420E28804E1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ED71990AF;
	Tue, 25 Feb 2025 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="idziDElY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D08166F29
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505939; cv=none; b=Sz6StBaQB1Iw8p2Un6oQ/cyfgHiPUiokWSPwIaO+OEmZ78nH2MpO77/4idhfUAYRY4cJOXMHyTlU3xEen7KZm6NJ+CbeIZKRBia1yF5wjOTlchkuPDJIbLrNsSHdTFQAWtsB86lY7vrBsb3taIrk0kgzfA2HCg+lxGeLUz5+plg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505939; c=relaxed/simple;
	bh=W87YAmKLEl+cyi/f6yzuW6we5mhm3MfFAOG4vy9oY0k=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLkcrTdjfJ9sH3SWUWRDUG5IQxpv9GQAbHatRfWK5YA8v9cJxVTjVE0Iq/aHCVGYKGpedIOTd+LehqhbJmfthbEfotd/p+PqcqTx+L+D9tYODw2wjSfzpJpE8jPlcLTwlPjjJGAtj2pGAPq+qzIXtwsDoTeGS9+pGGaM9c0Cwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=idziDElY; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740505938; x=1772041938;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=CKYWtVn25OeGvUU9iYkLcns1jel+z2F41byCYvhFENs=;
  b=idziDElY79w29KI92st3E+vK0TCWzFA96RdCKAtBTY0sF+CfupntQc09
   4hHJRK7Our/LZe66S4vHEWKg40QvvxH/vvwNDfNJDoi2R6nqHIVfF188G
   /eEvH2xDMtBeYMWBv6XC5McACyhxDrDJ8Hb0UJ8T6pJhNR58DVUJv1T/E
   o=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="475210603"
Subject: RE: [PATCH v7 net-next 4/5] net: ena: PHC stats through sysfs
Thread-Topic: [PATCH v7 net-next 4/5] net: ena: PHC stats through sysfs
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:52:13 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:14938]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.13.123:2525] with esmtp (Farcaster)
 id 041e7e7c-f77e-4232-8e88-c3dde653a7ae; Tue, 25 Feb 2025 17:52:11 +0000 (UTC)
X-Farcaster-Flow-ID: 041e7e7c-f77e-4232-8e88-c3dde653a7ae
Received: from EX19D022EUA004.ant.amazon.com (10.252.50.82) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 17:52:11 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA004.ant.amazon.com (10.252.50.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 17:52:10 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Tue, 25 Feb 2025 17:52:10 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
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
Thread-Index: AQHbgjSY2YmZf3/qrUmDalvDVwEGQ7NRBoEAgAdQ/bA=
Date: Tue, 25 Feb 2025 17:52:10 +0000
Message-ID: <fc701e7bbc63491cb8dec5c7bc86e4e7@amazon.com>
References: <20250218183948.757-1-darinzon@amazon.com>
	<20250218183948.757-5-darinzon@amazon.com>
 <20250220180812.10b6de7e@kernel.org>
In-Reply-To: <20250220180812.10b6de7e@kernel.org>
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

> > +static ssize_t ena_phc_stats_show(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               char *buf) {
> > +     struct ena_adapter *adapter =3D dev_get_drvdata(dev);
> > +     int i, rc, chars_written =3D 0;
> > +
> > +     if (!ena_phc_is_active(adapter))
> > +             return 0;
> > +
> > +     for (i =3D 0; i < ena_stats_array_ena_com_phc_size; i++) {
> > +             const struct ena_stats *ena_stats;
> > +             u64 *ptr;
> > +
> > +             ena_stats =3D &ena_stats_ena_com_phc_strings[i];
> > +             ptr =3D (u64 *)&adapter->ena_dev->phc.stats +
> > +                   ena_stats->stat_offset;
> > +             rc =3D snprintf(buf,
> > +                           ETH_GSTRING_LEN + sizeof(u64),
> > +                           "%s: %llu\n",
> > +                           ena_stats->name,
> > +                           *ptr);
> > +
> > +             buf +=3D rc;
> > +             chars_written +=3D rc;
> > +     }
> > +
> > +     return chars_written;
> > +}
> > +
> > +static DEVICE_ATTR(phc_stats, S_IRUGO, ena_phc_stats_show, NULL);
>=20
> In sysfs I'm afraid the rule is one value per file.
> So the stats have to have individual files.
> --
> pw-bot: cr

Thanks Jakub, will change  in v8.


