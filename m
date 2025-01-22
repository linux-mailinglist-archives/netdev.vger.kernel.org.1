Return-Path: <netdev+bounces-160266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1274FA1912E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31C13AB367
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BBF212B11;
	Wed, 22 Jan 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sC48L8mT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB3211A2B
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547992; cv=none; b=OiE2renCTT9szSTtW827BcKTfL086jEWZGa9Fw+rV0dT3tQh6w+Fc0yqi8AqRTfC5KsRbC1sT2/eWAF/Trs7RfPDvL1cXiWPtqh42W0NbBIcJfjeFzZWohhV2tcniPFlNB4jnlEFai1zKFIzgbQhjeLdlgvMaCAH+NN7wZ5WvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547992; c=relaxed/simple;
	bh=qK19eq+tbbytGTRDZBmWlq9uhY7R/pZ9YUTINdgzGYI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPR45xzDV/MIYaXQTdHYQywaIjo6GcowHi9f5P128dOlpjFL0FlMGXDLFKb1Nn75BoNNldZfz7k3tzuI9Xl4Se1+SWV/zdD7e8RST3Zu0swSLgQNLp84Wq5+XHNX79qQxLe30G4DIUQkA+d/Y0lWml0BeboPev81cRdJN3ofBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sC48L8mT; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737547991; x=1769083991;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=qK19eq+tbbytGTRDZBmWlq9uhY7R/pZ9YUTINdgzGYI=;
  b=sC48L8mTVixjDYyrFSEPhiTSW8r34zVU+2VBdybq8KH0TqZm7SHRelyR
   L73zB+qDCOsZdyebUvd0VwDS1MRGg1cLmy4ghDsfVXGXXuIkaZH9iKGoA
   8xUvI/nD/r/F4HlKc7EYG0c1zL8dexcIn2Df35DaOfeZz87VIyJXi5afu
   4=;
X-IronPort-AV: E=Sophos;i="6.13,225,1732579200"; 
   d="scan'208";a="59621093"
Subject: RE: [PATCH v5 net-next 0/5] PHC support in ENA driver
Thread-Topic: [PATCH v5 net-next 0/5] PHC support in ENA driver
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 12:13:06 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:3769]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.172:2525] with esmtp (Farcaster)
 id 03a338b2-a08d-4494-ba34-64d9d7da591d; Wed, 22 Jan 2025 12:13:05 +0000 (UTC)
X-Farcaster-Flow-ID: 03a338b2-a08d-4494-ba34-64d9d7da591d
Received: from EX19D004EUA002.ant.amazon.com (10.252.50.81) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 12:13:05 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D004EUA002.ant.amazon.com (10.252.50.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 12:13:04 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.039; Wed, 22 Jan 2025 12:13:04 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Gal Pressman <gal@nvidia.com>, David Miller <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson,
 Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Thread-Index: AQHbbLdOl+GEsMbIXU2oCJBaxUPoCLMip62AgAALmLA=
Date: Wed, 22 Jan 2025 12:13:04 +0000
Message-ID: <00c2a1c7d4b54306ad0e083736decaac@amazon.com>
References: <20250122102040.752-1-darinzon@amazon.com>
 <b1e4436a-c19e-4060-bd85-4328e586e68e@nvidia.com>
In-Reply-To: <b1e4436a-c19e-4060-bd85-4328e586e68e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiA+IENoYW5nZXMgaW4gdjU6DQo+ID4gLSBBZGQgUEhDIGVycm9yIGJvdW5kDQo+ID4gLSBBZGQg
UEhDIGVuYWJsZW1lbnQgYW5kIGVycm9yIGJvdW5kIHJldHJpZXZhbCB0aHJvdWdoIHN5c2ZzDQo+
IA0KPiBzeXNmcyBpcyBhbiBpbnRlcmVzdGluZyBhZGRpdGlvbiwgaXMgaXQgYSByZXN1bHQgb2Yg
ZmVlZGJhY2sgZnJvbSBwcmV2aW91cw0KPiBpdGVyYXRpb25zPw0KDQpIaSBHYWwsDQoNCkl0J3Mg
bm90IGEgcmVzdWx0IG9mIGZlZWRiYWNrIGZyb20gcHJldmlvdXMgaXRlcmF0aW9ucywgd2UgYW5h
bHl6ZWQgdGhlDQpwYXRjaHNldCAodG9vayBzb21lIHRpbWUgdG8gcmVsZWFzZSB2NSkgYW5kIGRl
Y2lkZWQgdGhhdCBpdCdzIGEgbWFuZGF0b3J5IGFkZGl0aW9uDQp0byB0aGlzIHBhdGNoIHNlcmll
cy4NCg==

