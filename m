Return-Path: <netdev+bounces-141322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17519BA78F
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800232817AF
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8CE176AAD;
	Sun,  3 Nov 2024 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TSE9A/rV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4A1632E5
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660584; cv=none; b=es8lI+rTrEN2jXG7Ng//ooJzymqI1oAnJXuHrRFMxokl3rKOKEQeVoEc8MUjomHxVTmIwhUnU3NKHfLpCJNhahCjuvkuzwN8WuEJ731sZVKMk8rGzkgu1GCszX7LKsxjO/16fj43xWfPXIGEvXHFVraQJi6saeFfnGOqh86TzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660584; c=relaxed/simple;
	bh=gW1KBWQIkX1X09vI+tgytLmL9BA+goTcWkI99ezOJng=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gAtSV5h6hR2uPj/fZx3j7gtTzo8hV96f0LAFvt7dBTjEeMWq0OJqqdbuZzGve1B0PZv2OwsYqjZRTcG1Rw42d4nNVKC+MVl3IFz0fe6oG/L/BC24KPB62ws0yZNY40w+EAF2kD201PlXjQnN2raY7lP3lNZz05a11hVFdht586g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TSE9A/rV; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730660582; x=1762196582;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Bf/Q2WPImUDOFYhRIGclyFJlMAoCfx4nutIywiIEpsU=;
  b=TSE9A/rV7EAYB/OFynJbGTWLG0shIk89A2hIplZEaIjxJ0qUCsC4m0ru
   KwvFkfYiTVhRypQX+G26lLDSXEdEJZRtcQ/2bQD1ufKD/inExt4gZj2t/
   nCANXlw6f4IfS9bqGfY04qmOLWGEzjb+HEUGy8LkFCJCliMwyH+P3+MDa
   M=;
X-IronPort-AV: E=Sophos;i="6.11,255,1725321600"; 
   d="scan'208";a="142993748"
Subject: RE: Of ena auto_polling
Thread-Topic: Of ena auto_polling
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:03:01 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:27271]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.104:2525] with esmtp (Farcaster)
 id 216ff346-31bb-4ac9-8a64-aa3c9dc6aa15; Sun, 3 Nov 2024 19:03:00 +0000 (UTC)
X-Farcaster-Flow-ID: 216ff346-31bb-4ac9-8a64-aa3c9dc6aa15
Received: from EX19D006EUA002.ant.amazon.com (10.252.50.65) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 3 Nov 2024 19:03:00 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D006EUA002.ant.amazon.com (10.252.50.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sun, 3 Nov 2024 19:02:59 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Sun, 3 Nov 2024 19:02:59 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>
CC: "Dagan, Noam" <ndagan@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Thread-Index: AQHbLVmppitHFUIlRkm8t7vvfgMvhbKl6hqQ
Date: Sun, 3 Nov 2024 19:02:59 +0000
Message-ID: <b3df5db4bea6401095b908b3632bb09e@amazon.com>
References: <ZyZ3AWoocmXY6esd@gallifrey>
In-Reply-To: <ZyZ3AWoocmXY6esd@gallifrey>
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

> Hi,
>   I noticed that commit:
> commit a4e262cde3cda4491ce666e7c5270954c4d926b9
> Author: Sameeh Jubran <sameehj@amazon.com>
> Date:   Mon Jun 3 17:43:25 2019 +0300
>=20
>     net: ena: allow automatic fallback to polling mode
>=20
> added a 'ena_com_set_admin_auto_polling_mode()' that's unused.
> Is that the intention?
> Because that then makes me wonder how
> admin_queue->auto_polling
> gets set, and then if the whole chunk is unused?
>=20
> Thanks,
>=20
> Dave
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org
> |_______/

Hi Dave,
The auto polling mode was written as a fallback in case there are issues wi=
th interrupts,
it is currently not used by the ENA Linux driver, from Linux's perspective,=
 it can be removed.


