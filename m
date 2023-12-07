Return-Path: <netdev+bounces-54755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C288808150
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 08:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF621C20C7D
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 07:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65F14264;
	Thu,  7 Dec 2023 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QQuwvC9U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A36FA;
	Wed,  6 Dec 2023 23:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701932585; x=1733468585;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=SXaE0jxYY1JnqLGQ+FtXfTHRRnIazmjY0HeKThSqzHQ=;
  b=QQuwvC9Urkjgro+rl8R0bKIUAGES2jD/ZxQ1lODNiVgziUwFbpDDfJCO
   ZKY4Cas/WaU2lOqEQf/vPT307qopdkxHHH3rR6LSb0A2tzoN5vsexwgap
   wRCk2ptwxLmprOO0o0CeDylvvrCkyutI2DGHTGdrSb50z3Ry1ASzb8Ys/
   M=;
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="689490897"
Subject: RE: [PATCH net-next v8 1/8] net: ethtool: pass a pointer to parameters to
 get/set_rxfh ethtool ops
Thread-Topic: [PATCH net-next v8 1/8] net: ethtool: pass a pointer to parameters to
 get/set_rxfh ethtool ops
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:02:58 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 29D8B49403;
	Thu,  7 Dec 2023 07:02:51 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:20385]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.90:2525] with esmtp (Farcaster)
 id 2082292f-9c21-48cb-bbf7-6b1cfbdc6572; Thu, 7 Dec 2023 07:02:51 +0000 (UTC)
X-Farcaster-Flow-ID: 2082292f-9c21-48cb-bbf7-6b1cfbdc6572
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 07:02:49 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D022EUA002.ant.amazon.com (10.252.50.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 07:02:48 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1118.040; Thu, 7 Dec 2023 07:02:48 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>, "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "horms@kernel.org" <horms@kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "gal@nvidia.com" <gal@nvidia.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>
Thread-Index: AQHaKJ02y/VPHsTkPk+svVtpsphWUrCdYuGQ
Date: Thu, 7 Dec 2023 07:02:28 +0000
Deferred-Delivery: Thu, 7 Dec 2023 07:02:04 +0000
Message-ID: <82af13c02b5b4a3b9372ee5b38221b4b@amazon.com>
References: <20231206233642.447794-1-ahmed.zaki@intel.com>
 <20231206233642.447794-2-ahmed.zaki@intel.com>
In-Reply-To: <20231206233642.447794-2-ahmed.zaki@intel.com>
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
Precedence: Bulk


> The get/set_rxfh ethtool ops currently takes the rxfh (RSS) parameters
> as direct function arguments. This will force us to change the API (and
> all drivers' functions) every time some new parameters are added.
>=20
> This is part 1/2 of the fix, as suggested in [1]:
>=20
> - First simplify the code by always providing a pointer to all params
>    (indir, key and func); the fact that some of them may be NULL seems
>    like a weird historic thing or a premature optimization.
>    It will simplify the drivers if all pointers are always present.
>=20
>  - Then make the functions take a dev pointer, and a pointer to a
>    single struct wrapping all arguments. The set_* should also take
>    an extack.
>=20
> Link: https://lore.kernel.org/netdev/20231121152906.2dd5f487@kernel.org/
> [1]
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---

Thanks for submitting this.
For the ENA driver:
Acked-by: Arthur Kiyanovski <akiyano@amazon.com>

