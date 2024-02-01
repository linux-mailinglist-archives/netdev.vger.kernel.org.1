Return-Path: <netdev+bounces-67845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D38451DF
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DCF1F23865
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E71586D2;
	Thu,  1 Feb 2024 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qqhhIi+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD893FE0
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772297; cv=none; b=hOOc/Sw9dswrr5ZQE5IofPCcodqI3Ao+iIpu9kbMPDim0XkNa3qmNRK7nnbX8m76/VyQoHCU8EzoqZDfZaGzEueGbmmdanxSEqI64pMyoFf/uACbg4nqN5rCxzMB6ZCuBr2eD+GuHg/9Y83VmcDErdFu63xRXj22BF8G1FBCgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772297; c=relaxed/simple;
	bh=rt3xdToS1edrEqLARcHH3D4D0bQAx1em8WkrQGW9AHw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=scVYHmHSuQx7bkpKi3CGIO/Db2FXgWmZPUofejDRfKU8e5uzwx5m81xSHvOyjmO4BK09GfhjjqIX3qOhkF/EsOYUzJ/4r/Vlj6uAFI32XMVtmloXH+09arUF56yFNOf7//fb9WDvaTjbhka7KbE9KMp87sXDlknVjH+a9a8FiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qqhhIi+H; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706772296; x=1738308296;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=D6B6nIUhDm9/HFTW0ViOh2I+6P+OSFveiy5CYzSjRWY=;
  b=qqhhIi+HYkEL82FPTRATFtWl1AVBWR+u/p7MuFAXwQ8cSQja/hvvGPum
   WBwl5TRxnC7aH3PEsNG0oJCAu/40pv7Dsr2oyt4RwfVcb1lirW/rVjjrB
   N2DyhoFrnwkXw/8oxdWjXNfjL4ktfakmhROwEPJO/sIRFoWY36J5ePxhA
   o=;
X-IronPort-AV: E=Sophos;i="6.05,234,1701129600"; 
   d="scan'208";a="631270136"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:24:53 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:9420]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.233:2525] with esmtp (Farcaster)
 id fba90ec5-3aa3-4313-b7ad-83557396f1db; Thu, 1 Feb 2024 07:24:52 +0000 (UTC)
X-Farcaster-Flow-ID: fba90ec5-3aa3-4313-b7ad-83557396f1db
Received: from EX19D028EUC004.ant.amazon.com (10.252.61.145) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 07:24:51 +0000
Received: from EX19D037EUC001.ant.amazon.com (10.252.61.220) by
 EX19D028EUC004.ant.amazon.com (10.252.61.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 07:24:51 +0000
Received: from EX19D037EUC001.ant.amazon.com ([fe80::d0f1:b6b6:e660:ae67]) by
 EX19D037EUC001.ant.amazon.com ([fe80::d0f1:b6b6:e660:ae67%3]) with mapi id
 15.02.1118.040; Thu, 1 Feb 2024 07:24:51 +0000
From: "Bernstein, Amit" <amitbern@amazon.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>
Subject: Add PHC support with error bound value for ENA driver
Thread-Topic: Add PHC support with error bound value for ENA driver
Thread-Index: AdpU32temyuKTDgWRNqtQlnNzjS4cQ==
Date: Thu, 1 Feb 2024 07:24:51 +0000
Message-ID: <8803342f01f54ca38296cedafea10bde@amazon.com>
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

Hi Thomas, Richard and all,

In one of the upcoming releases, we're planning to add PHC support to the E=
NA driver (/drivers/net/ethernet/amazon/ena/)
To provide the best experience for service customers, the ENA driver will e=
xpose an error_bound parameter (expressed in nanoseconds),=20
which will represent the maximal clock error on each given PHC timestamp.
The error bound is calculated by the device,  taking into account the accur=
acy and delays of all the device's PHC components.

Based on our search, there is no similar functionality in other drivers, me=
aning there is no user interface to expose it.
We're currently exploring the best method of exposing this capability to th=
e user.
Our debate is between:
- Extending the gettimex64 API in ptp_clock_info
- Introducing a new devlink entry
- Updating the time-related ethtool option (-T flag).

As our device sends each PHC timestamp with an error_bound value together, =
gettimex64 is the reasonable option for us and our recommended solution.
We would like to ask for your recommendation.

We have already consulted with Jakub, who recommended that we consult with =
all of you.

For more information, you may visit: https://aws.amazon.com/blogs/compute/i=
ts-about-time-microsecond-accurate-clocks-on-amazon-ec2-instances/

Thanks,
Amit


