Return-Path: <netdev+bounces-68182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E6C846074
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CBF28B503
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFA0652;
	Thu,  1 Feb 2024 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Azsz4CIo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A012FB26
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813770; cv=none; b=PEm59Iljdvs8RvVvUYuxWqu/5OUUpK0QUTtSgHJ2HJft/6lxqwsQmARpty4240wjgGjbeHjbX8msLIAw3ky+MPhjURPlxNqGJ1cpDgkITmFNGyMx5BBZLhc4IpGXPzHU5M9b2pJ8HW6vDudMgGfeIYKQ9hqdx7165oeQmTHTOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813770; c=relaxed/simple;
	bh=mH2FzGPCA28ujNe+qh797xx+pN06pPM/iKRcTP3O59c=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PmmT/Iwi3Kk4bYJk8gDzsL+gtS80AP4MTVHdcYoa/maeDuKrK/ph0BBy43Z2ENF1sqz+YY34wmw7mCG/FnuF7j/pSVNPFOEX3Qp0IZ13NROG3ciXl0XfT8kjJN10HHHdIWLoqfA/JLO9DL+ZWs0MEKac7ehWl38eZCrt2rX7CQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Azsz4CIo; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706813770; x=1738349770;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=X9Xn+iNXljN6NBveUAap03sGl95cTLt8ChaSFHMrKnA=;
  b=Azsz4CIokeknC1EUePewKJ7c/l1RVFyI/i9Q9+IndgVx+5/+4gsSiia0
   GZ7Qu1ZKHWDLZWqzhBmfKxRXycaTeena750XJaU0NYr3FrVj5gnDEGoOz
   OHXNKT948JphoqEc9jIft4QcZnWlH/B01lpCmhGSa6Z9YLbu5EFhY2miu
   o=;
X-IronPort-AV: E=Sophos;i="6.05,236,1701129600"; 
   d="scan'208";a="631406804"
Subject: RE: Add PHC support with error bound value for ENA driver
Thread-Topic: Add PHC support with error bound value for ENA driver
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 18:56:07 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:31423]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id dff1a957-be01-4f54-8fc3-85678d6811e3; Thu, 1 Feb 2024 18:56:05 +0000 (UTC)
X-Farcaster-Flow-ID: dff1a957-be01-4f54-8fc3-85678d6811e3
Received: from EX19D028EUC001.ant.amazon.com (10.252.61.241) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 18:56:05 +0000
Received: from EX19D037EUC001.ant.amazon.com (10.252.61.220) by
 EX19D028EUC001.ant.amazon.com (10.252.61.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 18:56:05 +0000
Received: from EX19D037EUC001.ant.amazon.com ([fe80::d0f1:b6b6:e660:ae67]) by
 EX19D037EUC001.ant.amazon.com ([fe80::d0f1:b6b6:e660:ae67%3]) with mapi id
 15.02.1118.040; Thu, 1 Feb 2024 18:56:05 +0000
From: "Bernstein, Amit" <amitbern@amazon.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Dagan,
 Noam" <ndagan@amazon.com>, "Arinzon, David" <darinzon@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>
Thread-Index: AdpU32temyuKTDgWRNqtQlnNzjS4cQAPnlQAAAdKGHA=
Date: Thu, 1 Feb 2024 18:56:04 +0000
Message-ID: <5ff61605e6424624b252cbbc2f9cbe4f@amazon.com>
References: <8803342f01f54ca38296cedafea10bde@amazon.com>
 <ZbuviFaciTADMkMk@hoboy.vegasvil.org>
In-Reply-To: <ZbuviFaciTADMkMk@hoboy.vegasvil.org>
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

> On Thu, Feb 01, 2024 at 07:24:51AM +0000, Bernstein, Amit wrote:
>=20
> > In one of the upcoming releases, we're planning to add PHC support to
> > the ENA driver (/drivers/net/ethernet/amazon/ena/) To provide the best
> > experience for service customers, the ENA driver will expose an
> > error_bound parameter (expressed in nanoseconds), which will represent
> > the maximal clock error on each given PHC timestamp.
>=20
> > As our device sends each PHC timestamp with an error_bound value
> > together, gettimex64 is the reasonable option for us and our
> > recommended solution.  We would like to ask for your recommendation.
>=20
> Sounds like gettimex64 won't help you.
>=20
> You will need to extend the socket time stamping API.  That is how time
> stamps are delivered to user space.
>=20
> HTH,
> Richard

Richard, thank you for your response.
However, I forgot to mention that the ENA driver currently doesn't support =
any socket timestamping.
It only supports the PTP hardware clock infrastructure, which is exported u=
sing the clock driver.
User space programs can control the clock driver via the PTP_SYS_OFFSET ioc=
tl.
Therefore, we can only use the basic clock operations of ptp_clock_info, su=
ch as gettime/gettime64/gettimex64.

Thanks,
Amit

