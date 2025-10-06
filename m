Return-Path: <netdev+bounces-227974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F6BBE512
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 16:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343FC3B14EF
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB02D5932;
	Mon,  6 Oct 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Umv09Hpo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434432D4B52
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760447; cv=fail; b=rrDgEAwf2zYHsVJG538qAc847k8hUg1QJ0cKJw3BsA6Mby7xzKxLO4Eg0ldIcpFuhDPIEuVxG8ywZ40QdTOxluZw3JB+2TnG+kAnAU0oY2gVihnsH+h6vOSjo4WFzQL9iPea7CbN/qXLdaxRdnRmVSFDUb8qlAjq21yTiEcqsWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760447; c=relaxed/simple;
	bh=2Jetveu7pRcmI0N22KRu7/9IwuCXGM1aFdRBiGUvssA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lQ+7BtBzXj+vO4kz8ESBRjH0UzD5nJ7xNgEPI50YnvPJ/B7ue9fn/EozSFb0p5O+U9KhDlshD4qN/EPLyb2eSH/lenVx2eGmAE6754JdclXl7sjPEQMBClQ90kvC+kwZ+pd2ttdptVFJyTbQvCsBVW2rMo0iX03M0hLItZM6UHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Umv09Hpo; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759760445; x=1791296445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Jetveu7pRcmI0N22KRu7/9IwuCXGM1aFdRBiGUvssA=;
  b=Umv09HpoPLb+ixd7y5aOt4cNnLk8EY2ZgKE2mP9gqC+r4lFU5uWmAv+S
   4LgM7SGlrHgUtSIQbTXMUDD74cP0s5vZvrJButE1XOj9TaJrRkn7Z9vXY
   PDZQ9ayenwPFE+1ssDQIuC7Xon+ufU4QjZwCF8ZkK5wqFpxXi2m/nKt7y
   4EFzIVREF5VUAzRkIleNHr7/hYogaPJQQcLzW9niZYiBnIEsOYYrdwf+6
   O+ooBp3JdHyz/TetfZbse8YhQTto5OeUjZYMT0xGz71RAhwVYAkjgahEO
   tMCg8Cz10waYQizlnuVaIJLCDC6nXd6EuE85eKjpS3JztO/a0e9IHJIsa
   w==;
X-CSE-ConnectionGUID: XqW04xTLSoaeMvAA0R/fOg==
X-CSE-MsgGUID: GGWfjNy5SNymdJscwbwZ+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61139962"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="61139962"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:20:44 -0700
X-CSE-ConnectionGUID: 963WXelTQA6kfughLpEV3g==
X-CSE-MsgGUID: PSzQnIEGQqGZQoGG06HtBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="180302665"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:20:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 07:20:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 07:20:44 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 07:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtXT3sHHaXq2x/10SIpzCaDUKoH+UgDzQv1ooyNhMEbQYkJTZHfKQNS4OHU0NcRiCVsWMvRfu6m/OB80+LV7cfqYADO2VYWX9b2KUaodBKayRpsoCZ+XrSqOD7wxw6CYkuxpqQpUL8ZB/1Ts7cembhVnpBRQAwHQuh66pa4gftIpCzKlVulDRjspYUuZk0Hma60213MNz5UFfrBrRsuW500saez01Kxg94OiAZO8gy5Wkgwyq7cHRylzVEHJOqST8H1cNXs4ifUwVy7I79PGJ0nN0UYAxA/e/O7D3U1qcfV/S2q7xFzDX27JReNanjLyQ0mU/RPD3+kvJkqtmwtmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Jetveu7pRcmI0N22KRu7/9IwuCXGM1aFdRBiGUvssA=;
 b=Ahh/ne+ft8xeXihOaYzMT62fMnhlE23a6geJ3amhBOuuXwkxwYa7xKhUsGcxydagbMByclDnzKq+eIKzKyTrfbo0mYioyzIkkyxqwyhA7ftoXKaT3QgJ6Y3KG2YORcxVFs6eDjLMIXhA/nWdDoXt1U8zcOH3rjSDjyhDGh9/XzdUL2gWhyYgDwMGwqOmizqyL9uVLAK4aeMJtPZ6DlEHpthFtm+NCo1CVZMWxfx/1QTfrPtCUTykddRQ64dlJiJYUMEpdt+ucO7FiT9/kzfI7PEGvHaDfY3dlaAkaaWa/Wi6xWK81/ng5oU8Ji2IqnQjnOk8tABQ84UjKkc2CBJ81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA3PR11MB8920.namprd11.prod.outlook.com (2603:10b6:208:578::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 6 Oct
 2025 14:20:38 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9137.018; Mon, 6 Oct 2025
 14:20:38 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <enjuk@amazon.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Auke Kok
	<auke-jan.h.kok@intel.com>, Jeff Garzik <jgarzik@redhat.com>, Sasha Neftin
	<sasha.neftin@intel.com>, Richard Cochran <richardcochran@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "kohei.enju@gmail.com"
	<kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1 0/3] igb/igc/ixgbe: use
 EOPNOTSUPP instead of ENOTSUPP
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1 0/3] igb/igc/ixgbe: use
 EOPNOTSUPP instead of ENOTSUPP
Thread-Index: AQHcNr4WJT0vBZ1dFk2Kyc+uNvEGxbS1KyUw
Date: Mon, 6 Oct 2025 14:20:37 +0000
Message-ID: <IA3PR11MB8986A8AFF1DD5204A9D20932E5E3A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251006123741.43462-1-enjuk@amazon.com>
In-Reply-To: <20251006123741.43462-1-enjuk@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA3PR11MB8920:EE_
x-ms-office365-filtering-correlation-id: 3649023e-5e36-43fa-d168-08de04e385af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Q0VuAzcgNc/gSlujEHSBeXBNFGk+xcJRVygnlnMJj8hPjbmgP4ZlIRz0LH8+?=
 =?us-ascii?Q?jpUWXUvhehi/cG0lC3LQ93DYYNGK7TGxnvQsyRo9ovu9YHF+v9tGTEFTHAKu?=
 =?us-ascii?Q?zUvC4+x26R89zngkrJhJgxNqBAzpj/FUyTNImC3PbTlunrUhwywcGy2T0uxJ?=
 =?us-ascii?Q?logJqrV9ckXe27lrFT7sBa2Jvt8o9uBSW08xobRhWN1aDysUWnAX6Sxolpc4?=
 =?us-ascii?Q?3Ecs09oywl0YCiAU0PvS/1hLTFgkUnHLP+lqEwohwrUalPoAZnxvwQ2L215v?=
 =?us-ascii?Q?gg6oRKuIo1grh9u3pdLXiM44NJWcneEL9aMnwdet0KgzRvXpbMnh93TY1QUF?=
 =?us-ascii?Q?c0tUjMniCqCMu7NfflCmdi+eQU6Ny5m+NtjrSH/XVCVXiC2DwU8lEcVqqPFl?=
 =?us-ascii?Q?4kHoBLpIhAZXrEfr7sZ33p8PsKGcBGastuKPJrm6VmU02M3xsQZfvqQiOHcg?=
 =?us-ascii?Q?kvsnn+G56M+RSEABJ2g7eJwF4hWTJIJeuNzowPZJ01TdsZnjxJOwnqWJ/GV7?=
 =?us-ascii?Q?PzCHTWlv6Jc2cbth+uk47siT3QSFBtJ3IpJpw1+vcl/STTD/UPkELB2QnF4J?=
 =?us-ascii?Q?NyxVHuFwnrUQ0n30QRICN1Fkbz4mcXLRfnyt3XvnZzPzItZ/0Mrx3eQLGrkW?=
 =?us-ascii?Q?z5rBdueohmguioTGUauSKsjw40P1gOrWfj0XENx+NM5Ip7SIi9ZOlGqRkAOY?=
 =?us-ascii?Q?U6J6K2fdoQC0IMjvRGA8xuIM5t1x6f/WtgfNbp4AeSodqvJQbVwZB1nlukqS?=
 =?us-ascii?Q?0f1wDOUXliRq0oQAaHJX1ietJm+qrbl1ZjY/CQl8dAt2NwB45BGcz0ELcL86?=
 =?us-ascii?Q?mincvzj7okcfCsQzbAtE1otgVTSOnLYtjMJCXR1CJBy644PgH1B0oASTdci9?=
 =?us-ascii?Q?rj0Pr7jfLzqXctn8apBjZ4wwTMseEutGG0KHSqG/Cw62INx83AG69AxCpmRU?=
 =?us-ascii?Q?o9WW3Lk0dgOrb9kgaBf7PHNiFWU+TZY4KNtWgxxzIBrOt0e6+dSo/7Kgg1A0?=
 =?us-ascii?Q?ZQ4aAP0RDd08jKDGb4YDGLEA/i5N8+eutcGrBj3mgaDJSXk0ZSIvSXUwtoM/?=
 =?us-ascii?Q?yHhMMw9dOgaJnchLfmCsrQGwDglYHIfGU+iPQYTUrwSv2Zh5rngziDKfPvMK?=
 =?us-ascii?Q?B2kNdfsxLgfkpzKLC/w/IudsAagqAv/V11pxrC4GvsrR4vAFYWIHNCQfV/4M?=
 =?us-ascii?Q?eIe3dwGJZm+CXl3VRlT68Huf2DgggUYdoZElyocnZhbFQiQ3s6t5SMguls5L?=
 =?us-ascii?Q?MTZHiU5QCphHz5preq/AgdnmhfeMMDvD65yKOupAEUXLILxbwL1RBHvmydY+?=
 =?us-ascii?Q?Bey4uMulaOxGfUiPbd550k1Z87BByP9gMHLEsaugGgEywB4cJUCM3d+2tVIG?=
 =?us-ascii?Q?4Z0uF+qq2T2koHlUB6XvrgTNWxLpWB5br5LPY0JuCxX5YWQDoYCD8grZqzIJ?=
 =?us-ascii?Q?BriTltjOmI2ro9KvlqPCaIxpl7zQH8gbfBqddkSPOlTNvgF1F+/8TU+synCa?=
 =?us-ascii?Q?6Lo6UMpd/lOxHoN24gmFKDkY0pMMFSCFOLAH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FVJu1iq6PzEuWL4uvoPHcjhrFiPCnc1XxqbPFy0G2zIbye0O+TCyQ85PEk08?=
 =?us-ascii?Q?NoZ0HPl3F44PtU+yostBFupGhzSzXgKUcHPl2PHuuWW+PZHxFSuq/2MUhI//?=
 =?us-ascii?Q?wJ/QyG/C6hNCNwIOiT8SxAkmarSBkyaExLZfndEzQgtTbpbGbhv+Cm0KJFQC?=
 =?us-ascii?Q?hJv0pG0X9TZf+7/6acy6hUGFvR0GSMkEOs9+N9a3+F8hUeEgsbS9juGD5FUR?=
 =?us-ascii?Q?tQnBLO0R0Xn6oJgT8CODPVutRSu8QeevLm8ugqI8Lq9OzPYbMM1QTGcdXySv?=
 =?us-ascii?Q?TTL8I7rHYSbgeWU+xN1v4ZQEtWoLWh46urUhKQaKUswC27RQ4NfRHqAptXrs?=
 =?us-ascii?Q?/u1zuG6usapQ5joCbu96XvkpmLFgb3iv+xvfOiD2wYskAQ4ZtgYOIfhPoLry?=
 =?us-ascii?Q?pZVTJfFGV1m+NWtN0lH9bfuz3BfhqYlxA6C/qFF0Eu6th98s3MYgUpIqpNal?=
 =?us-ascii?Q?JO36NjJd2an4ww8f9zNVTHtWnNEzr4xF5KUpkEYEg35loh+ZSIX43qb0tyLP?=
 =?us-ascii?Q?bBu6hmFvIp+EWPM5NDF1Q9L+oIgAsj5oOwUJlcvQy6bwpwEJHmSVXo/7Xf2N?=
 =?us-ascii?Q?nu3/CyusUlLCSco51bJLnxgjTcXaTsXw/QipVYlLB9kXAgr/navTYhA61jTV?=
 =?us-ascii?Q?iVtE416GzbnrUKMyckOAoz0rflhhBTeGwYQRaUR5hI1YA2eqieKRTQeh6Xf5?=
 =?us-ascii?Q?sgEux0/wbKkAPDuK/aYH9sqEOlpNBPdJBE9lNipdBr8SdUFZngRAIFmGfZ1b?=
 =?us-ascii?Q?pGf+MoXpNVxeSSro1X9Wq+xoYH0DOq+kgZQM8mFoPmwnMtJAIakt+eJfCi13?=
 =?us-ascii?Q?Teu3VviVctfKMKKuPuJUN6Mc6jRmVVSeD7V3Z8k+Bsh5lIQO9fci/5t8en7s?=
 =?us-ascii?Q?igVZ/9czS0WqQdWswECDpWf75L6vKmdKT3Qup7IdHjvyX0f+Dw218JPVWwix?=
 =?us-ascii?Q?R/MdKW7z/6gRlaI66DTAEjQNy/ZV8xtq1jKWXnB8bW4ki6dnu+82idLQN01g?=
 =?us-ascii?Q?Myf+wjTRXxd8ugoB50SRoASiRyjbsLExibTDLv/oCBp77PF9m2j6Qh35zPfj?=
 =?us-ascii?Q?RsdnFiEk6Qa9fVcwj6YIqrC+qm/5Wlb8BHOCHu+viMHvHu6HiIuEIVIMVWb6?=
 =?us-ascii?Q?SZLxJV9jwKUO9IcKVmlpgovwqdpA+nmfeaBDf20Rl7RC+FXoDploaZeHvQ0v?=
 =?us-ascii?Q?q6O8UQf9K8KGI1dm8/9Ppa1RelRjJbDU4hbxvKNs7uEYR/XPlgNr+MGD/KNu?=
 =?us-ascii?Q?bnFi99FPuedfTKKECkZ32nE01TVFd6tSenr7q2BWhCpI9vlXcgClVSLQnXcL?=
 =?us-ascii?Q?9m9OvrfKXa1p8LxezrTCgUzXYPN348+FLE3vZp7ju4t5FDHEq2dutxmtg15G?=
 =?us-ascii?Q?UiqT7mF9z8je+MT0l6E5yb2kOGuzPKtILJq/4cb7e90+BXO+LhFG8U8KzA7b?=
 =?us-ascii?Q?b6fQUq71THXDkaeAd2+fAN512pwyVWirK88yi4PZdBrNn9gXgUoUVMEF075S?=
 =?us-ascii?Q?H2dmxUGQ0P9r43Bb9CXG/rnDRsL1x2rqUFtbhdIKMBJTMzvZt2h/SAQOUd3O?=
 =?us-ascii?Q?TWAMma9aNwaJ29+8Nn17K280od45CtZ7fgFPeSJacunorQlAX6Hr1sRQbt8/?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3649023e-5e36-43fa-d168-08de04e385af
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 14:20:37.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1QOiYJOK6CaHC9s45PA/VwI+5RKUHvqaYnI49Q4zCcqRrXavPr+4GQT1sTqtYY8W8ExTSeeA9TNsNCUHpNTLT50uoF7Vt5rpkwG0rWMuvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8920
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Monday, October 6, 2025 2:35 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Auke Kok <auke-jan.h.kok@intel.com>; Jeff
> Garzik <jgarzik@redhat.com>; Sasha Neftin <sasha.neftin@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; kohei.enju@gmail.com; Kohei Enju
> <enjuk@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1 0/3] igb/igc/ixgbe: use
> EOPNOTSUPP instead of ENOTSUPP
>=20
> This series fixes inconsistent errno usage in igb/igc/ixgbe. The
> drivers return -ENOTSUPP instead of -EOPNOTSUPP in specific ethtool
> and PTP functions, therefore userland programs would get "Unknown
> error 524".
>=20
> Use -EOPNOTSUPP instead of -ENOTSUPP to fix the issue.
>=20
> This series covers all incorrect usage of ENOTSUPP in Intel ethernet
> drivers except the one in iavf, which should be targeted for iwl-next
> in a separate series since it's just a comment. [1]
>=20

...

> --
> 2.48.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

