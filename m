Return-Path: <netdev+bounces-179932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A1A7EEFC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6001896D2B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E721B191;
	Mon,  7 Apr 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a1Xo75wT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38FC21ADA2
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057074; cv=none; b=EbsNlO6fbK7eQAISVyZZkq0zwNz9SsleIhavXh0Vv0hQ+8eKZpfkMx8Y28PCmKZcsNb+nNlbEKbqiaoREZhGn4QrheN1eA7ANZb9HEuuySux2U5L5z2Vl/bFCmQUTjmLuzRhXTiznI1mKIKzFAqawCbTJJXhhd5JQjgkBNJ3+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057074; c=relaxed/simple;
	bh=xTL43nNFDrDG6rM5f5lLGZEsz176O8lWM5YqOEoPI3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dqMiPrSZbL4EYdWnY3QGtl08xmuS1Cp6RskKh7lZTjRzxCaGHPmg1aj3PRhOaypT7lPHIwxLtW3lQEOiZVxpgeYMv+rsJaOwM/L5S3ui+9RsYoIbamIstJEup21LgTBL1love/0RRI4uDrXRESSILNv+foRu59+LIGqTqaUgk0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a1Xo75wT; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744057073; x=1775593073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=du8R8CU6TAdCT8m0oHwb5CxA02hSERNis+YngCSvsr8=;
  b=a1Xo75wTab/xVWiOyhNzWEY9nWDuXM23z1RT0RJG3BeFr3zu3RYIYdQ/
   fpeUSr4eEh489olVHXaJb7hqlANNFtvkg4j1dzD3U7lIfRr6xvADhlg0Y
   v1d+4B1sGbUBXANQIC7AUn0qA8S/2slbrhsvpBIuqzUR3INGEE2UYNq1e
   U=;
X-IronPort-AV: E=Sophos;i="6.15,196,1739836800"; 
   d="scan'208";a="81597048"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 20:17:49 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:32673]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.242:2525] with esmtp (Farcaster)
 id c22b1ebe-0dba-4aed-b495-47c41dbde8fe; Mon, 7 Apr 2025 20:17:47 +0000 (UTC)
X-Farcaster-Flow-ID: c22b1ebe-0dba-4aed-b495-47c41dbde8fe
Received: from EX19D006EUA001.ant.amazon.com (10.252.50.148) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 20:17:47 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D006EUA001.ant.amazon.com (10.252.50.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 20:17:47 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1544.014; Mon, 7 Apr 2025 20:17:47 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>, "Allen, Neil"
	<shayagr@amazon.com>, "Arinzon, David" <darinzon@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Joe Damato <jdamato@fastly.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v1 net-next] net: ena: Support persistent per-NAPI config.
Thread-Topic: [PATCH v1 net-next] net: ena: Support persistent per-NAPI
 config.
Thread-Index: AQHbp9zcnSXHYYF96kKxfUKqw9tNtrOYoUXw
Date: Mon, 7 Apr 2025 20:17:19 +0000
Deferred-Delivery: Mon, 7 Apr 2025 20:16:36 +0000
Message-ID: <eaa93140a18d4b7f97cfc77aeb5e4b73@amazon.com>
References: <20250407164802.25184-1-kuniyu@amazon.com>
In-Reply-To: <20250407164802.25184-1-kuniyu@amazon.com>
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

On Monday, April 7, 2025 9:48 AM, Iwashima, Kuniyuki wrote:
> Let's pass the queue index to netif_napi_add_config() to preserve per-NAP=
I
> config.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Thank you for submitting this patch!

Reviewed-by: Arthur Kiyanovski <akiyano@amazon.com>

