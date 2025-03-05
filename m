Return-Path: <netdev+bounces-171926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F6A4F72D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 07:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDD816D1A4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 06:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BA91DB34E;
	Wed,  5 Mar 2025 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IauZXBEZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658713D279
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156473; cv=none; b=sW6c1U2ofeQ4KauzGYtn+/3V5+2FQYNEKbEn6sTLl3H+AsnwLbIpH59h8bLQVAnnRvpiQ+UgVxPNK/W6d1r62del95nOUFDhZwpAWyhoHlqojZTdRyiZ51WSSL7rDQodF5JZL5TUYIItuX+XenmylW6XQjc/rT6RfKo7S9f/d1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156473; c=relaxed/simple;
	bh=aJSZQiTh1KpDDVuTdHSfK1OKAt4PyYYDwGV+6XuZlSA=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmTA3fx57BN2FDIhB33Yes0BDMyoCZk1jxSukmTjyf7wamC8DucbgZ3jWouDW+x3Ag9QjVynM7/M4GnxgmR1jBBnYrjghpNkKtSGVP40dNlO8TY5LSDesNxQVkxBUIzW3Yu6US8f+sDMN5YLJ6maQjqowijezyDqwlspeHt7K8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IauZXBEZ; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741156473; x=1772692473;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=aJSZQiTh1KpDDVuTdHSfK1OKAt4PyYYDwGV+6XuZlSA=;
  b=IauZXBEZjA2tLf1rk6Ir4xoUwIpTicUWeBv6mM54KCHCd7kveFcyKffD
   FE9bS8XM/y/p4F9oCP4n4OGn/GvP1fbfs1oveFQjbu25mnQoWS6NcrK5i
   0BrZbH7wSHlB8/SZlZ9WLADZIR2auzUD1u536qNoXy/I1YUKwdrE8frGs
   M=;
X-IronPort-AV: E=Sophos;i="6.14,222,1736812800"; 
   d="scan'208";a="472167334"
Subject: RE: [PATCH v8 net-next 0/5] PHC support in ENA driver
Thread-Topic: [PATCH v8 net-next 0/5] PHC support in ENA driver
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:34:28 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:34722]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.247:2525] with esmtp (Farcaster)
 id 48c97144-8185-4a37-9c29-64c5b3b44188; Wed, 5 Mar 2025 06:34:26 +0000 (UTC)
X-Farcaster-Flow-ID: 48c97144-8185-4a37-9c29-64c5b3b44188
Received: from EX19D006EUA002.ant.amazon.com (10.252.50.65) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 06:34:26 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D006EUA002.ant.amazon.com (10.252.50.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 06:34:26 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Wed, 5 Mar 2025 06:34:26 +0000
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
	<amitbern@amazon.com>, "Allen, Neil" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
Thread-Index: AQHbjThdNi7IRTryXEO/DgdN2yH217Njl/WAgAB+u8A=
Date: Wed, 5 Mar 2025 06:34:26 +0000
Message-ID: <5a9dcc79ec4d415c870999ef6914d44c@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304150019.129a0182@kernel.org>
In-Reply-To: <20250304150019.129a0182@kernel.org>
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

> > Changes in v8:
> > - Create a sysfs entry for each PHC stat
>=20
> coccicheck says:
>=20
> drivers/net/ethernet/amazon/ena/ena_sysfs.c:80:8-16: WARNING: please
> use sysfs_emit or sysfs_emit_at
> drivers/net/ethernet/amazon/ena/ena_sysfs.c:61:8-16: WARNING: please
> use sysfs_emit or sysfs_emit_at
> drivers/net/ethernet/amazon/ena/ena_sysfs.c:125:8-16: WARNING: please
> use sysfs_emit or sysfs_emit_at
> drivers/net/ethernet/amazon/ena/ena_sysfs.c:95:8-16: WARNING: please
> use sysfs_emit or sysfs_emit_at
> drivers/net/ethernet/amazon/ena/ena_sysfs.c:110:8-16: WARNING: please
> use sysfs_emit or sysfs_emit_at
> --
> pw-bot: cr

Thank you, Jakub.
Will fix in v9

