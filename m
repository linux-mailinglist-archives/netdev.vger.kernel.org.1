Return-Path: <netdev+bounces-255774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG66OEtbgGlj7AIAu9opvQ
	(envelope-from <netdev+bounces-255774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:07:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A0C97CA
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93E3D30265BD
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349BA308F03;
	Mon,  2 Feb 2026 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtP0n92J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8B2FC007
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019205; cv=fail; b=Xr93JcDheyRDeUJEgU3dVPQeM/kk/hMqyY6QUSJjlmZzDqLHR70w8/hnYRuv87IvvRYtFLDS9ApmvrvDEuxrZumALtvbed/2eXjiFYkssmf7ZoOYpaACeWVuCkwo44mtds6nzqoTWONsb0LTgBYHD2IXnaVwqbQ/Av/plnAQejo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019205; c=relaxed/simple;
	bh=pgjBlU+shqbz0J3/Bh4WCf9yKNrX7iXlewvLe+dR11M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M3xHLlgjzeKBAE114X01VYmImLDTml5ijsrFbTmr07jrAEPg7yLwYOncsP33NNHQuOLF1V5krMmUyPO5XBU+k9HVNL+tkXNJsCL4gBb0qJ+ZAyvI2YAsQx5LW/WPI7DPRQB5b3GUx3IPDax+Rv3a0sUg8XePEsnfbOdhOTme9eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtP0n92J; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770019204; x=1801555204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pgjBlU+shqbz0J3/Bh4WCf9yKNrX7iXlewvLe+dR11M=;
  b=gtP0n92Jjt2Xu9ZpBxcoRsJ8OeI5SKHthUVoTKN8BrbiBrhAP9BDGcHH
   yAXXaYkc4xDoqYWmQqV6wGWchuJ0VwKgL5fsCL6Wxf4oRHldRF9uTdBJf
   YcSkj/KT1CYXZoQeeX2BpHzcN8LQpjTjuGD5tYBPj9Nw+w0lxCWSX14df
   fKWQUDm35WJgiK2ljCbBLTFmZQv6QgQSaWzsAn+Wb5Ci2VX3r1iC7StPW
   jEdaDuxXKqJDEsesSr/TXNMSp3xrj5Edyqnz/D8gactSqAxWGLn/cNuHE
   6JLg5nCfWYFcpPo9z/PQV+nmV4uqkXJgFE5CMcdqrSTwr/jfCXYflZqIs
   Q==;
X-CSE-ConnectionGUID: BUMl5XlhT3euzB6HnAGoTg==
X-CSE-MsgGUID: EM1TysSdR2mP+WkCAfoMHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="88751436"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="88751436"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 00:00:03 -0800
X-CSE-ConnectionGUID: qQ/3epwFSkqFoPcxflS6SA==
X-CSE-MsgGUID: sVZRU/S4Tsm/vCqVd1kydA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="213550943"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 00:00:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 00:00:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 00:00:02 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 00:00:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5SQCDwMuyQ4LMldNCL3BOjVXa/VkodlKzlLazt3N3kiykHliGVsWRnEHizIrIX9etsIAwr5HvT9nthADcw2AcrrI85RYleRpLg4YKxCidf3CGC363l3f9E+QYNQdUr8Af/NPikNy4/SIPWG8Yw5ycD69aZ7IoF3vaFPFp8tH1z84ZDm5GcAzHi3g70p/y1OPuRH1B1Y/lHWl3OdH+u2zi3rY18AN8ogppqTqYVlFXL/9VPTeI887PtK3/JkRUN6aMNrzZI9XsXECkzEj3KF5j0mv170AVzU8JIXAEinN2xK3TKvVSD62MkXwc/+QRrv4W2LRE/WyXGettY9NvcxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKAADmoOO8SQkeUJYqt6RpXuPcp1cMlYFxBKvpQUSbQ=;
 b=vaNXE4YErBTgkaiPo8K2jtfkK6RCPBoEUK+OkGg9bBZHgBBgcRz2eD9h/M30Xy4le36SlVLfu/u4xnIn2IOi7eHJzE/PMdnvmh1Eqc7G2bKxQKenirHjvmladC9amb2ZGmEPEltFzQUXWr7NdkJks8+Jo57HPLnfp3emxMN9OkwvOHJX79GsCNdMWjRMvrHg2ndKHqGDKU60zztNi+nzSH+VQOuZtRDlweP5zkoPSemn71MlfBMPiJXtDLY59mxJ4aN3dyz+uxvPM2OrTCWFwXXzd2Ft0lDysyJNPhN/W28A3xaoAwwrJDTu3tpbBzF9MhybPohvtSi4NFFWFU6ZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM3PPFC3F0DB79B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:59:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 07:59:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lifshits,
 Vitaly" <vitaly.lifshits@intel.com>, Simon Horman <horms@kernel.org>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [PATCH v2 iwl-next 1/3] igc: prepare for RSS key get/set support
Thread-Topic: [PATCH v2 iwl-next 1/3] igc: prepare for RSS key get/set support
Thread-Index: AQHcks8Hemhp0uzvwkyT/L2MZ2BUvLVvDdXg
Date: Mon, 2 Feb 2026 07:59:55 +0000
Message-ID: <IA3PR11MB89866EDA0E5756FBE635AF8DE59AA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260131163037.88108-1-kohei@enjuk.jp>
 <20260131163037.88108-2-kohei@enjuk.jp>
In-Reply-To: <20260131163037.88108-2-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM3PPFC3F0DB79B:EE_
x-ms-office365-filtering-correlation-id: c45cc436-681e-4c63-19a0-08de62310d6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Z3hzx9UxKh8Y2SvBa6F1eMMdhnJJRskFYcsnH4amNJJzMVqA46vFArUvQ7ye?=
 =?us-ascii?Q?T25aDFYHW2fB3wOnf8YWUY/3MQnztKZm3eUhYgWesuNX5XC+C6SI/YWVFrho?=
 =?us-ascii?Q?8WMbHOYNw1vUoDji8rDXVqK25Atu20raxy9gRRMomqqdQMfjVAWgRu0P9qW9?=
 =?us-ascii?Q?RwnGNATW15PVLOSLLUyr9u8Z6BWLbgp5Gw2Qzd3TdvErg1enSmJuIHr0gq2Z?=
 =?us-ascii?Q?WyAHzZNIj2FeqTF3p02utuZSxSg7zOnuZmhjXtexD3SomCPHvB653f7R/xGz?=
 =?us-ascii?Q?zkchdsi9Q+fS9GLdXlZHRqL78APF/n7kaPs39k7+xOYbKkIh7P0Bnl2KqLad?=
 =?us-ascii?Q?Ac6Z8mVNc/NAX060ToPFSjHWodV6EtpM46BHDqY+ZG5xh2HKYSWnkPUhHFjS?=
 =?us-ascii?Q?74EOnkRpJxMp7f30w/Cpfg62nFBwGvGFQw5+Ks3uwOLhGWUBgFwkkRE9WP/J?=
 =?us-ascii?Q?JJ0cDCiU6ad6Bbc8SVH6D1zN8VadkG6tG2iLCgWfEV9BvibaBe3lvQPe2fWd?=
 =?us-ascii?Q?AsyyF1pgLEWLAuwWiP3sQa7zh5sOHYbCL6fR0MLX4V3n1cIDeJ2IvUi5wFXC?=
 =?us-ascii?Q?H8/mSH8T3O/08DheNxRSRWsu8Vyv4/zsF1IfObavyTZjeDPW+t5dLWMx4Ysm?=
 =?us-ascii?Q?t7sySPJPs6XAVL5kiEa+gP1uZi4qqevUw36KddLx6SIoPu6vIz++pRZs7Y8o?=
 =?us-ascii?Q?/NVSbf5qnttzI5Sg7S4/Ycya8d7pmsbE2MFVu80TdzEA/4QPqDETo1l2fMLX?=
 =?us-ascii?Q?TMYoItfQ/OzuSf7BgfIiZma2FWnMNVjwT3pBC1QWF+Fcfv5/5WQy+pTCZPQW?=
 =?us-ascii?Q?NCop7R/sII2mokU6QFO+pVz0XVVBOMCmq5ivZbwtexpoXxySkvAL4r8DyCu2?=
 =?us-ascii?Q?Te/x3sfVPNU4xqpwqvgunIl64PLfjWMA0JBkakOIW4kyEcFV55CdCbpPu7vq?=
 =?us-ascii?Q?gbo/u9TQ5qKX56+uDrZU3yyqR9sHAtMwX0rqaa7F1y8nngy03XrwJqY6A3aR?=
 =?us-ascii?Q?515YR3BH0NqYkw1SRWKZBlBo92gYzjrRWqzJir+SFE4c0F6tb1PdM+/3OCs8?=
 =?us-ascii?Q?VK2qTQ6cRgXzXT+FUYfxEJk2wl9O/XaOb0wbfE6x9O1NsHCkt+mSGcYaJxx8?=
 =?us-ascii?Q?0pu9Fmzbk1aCApQlI+OVUH0ZkdTXgl9wfD3YwfLWmXKf7w4X5D2bvShlyOA2?=
 =?us-ascii?Q?4T/XaMG/30uX8fz4f/IFoeuzTRtTftzL+3nsAs7C9CEaPzIcgLb2Q1OnT7UQ?=
 =?us-ascii?Q?VOXuKhRwWPSf+SnnB4quRNciCdMN+y/riYKDboQVnILF5bwWvQvO0D38cOf9?=
 =?us-ascii?Q?RqO8EEInVZFUdDY4dQQqK2GrgKKHhragjHxWQvPAU9mIwJbiW1A1RIsNNJOv?=
 =?us-ascii?Q?UIGkudKD1NvNjAbqBrq7xG+0VomN3S+qu/Rl3sfFlLl2FoLUFFwkgJjMvGpC?=
 =?us-ascii?Q?FHoZu3ATviq0lJ/SkGtMouIVfcL6PgoBO4hhP/B+t0dO9JqDnqKN/OrV7zbz?=
 =?us-ascii?Q?Vyn2Ub1I+eAc2WSuPgu48rBVOrZSQrrHCl6iiWESWguq8sHDFh10ljiDYWZE?=
 =?us-ascii?Q?b2MhzZ9a/NQH5attnM5btY4FahYXZEw2BHkWjN8BrM6Rd5r+WGuPwFv04hHb?=
 =?us-ascii?Q?sed6xFrre+BOgVcBLXi5Qcc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zAWk6vbN1Vu8L6SOq3jZokxvywcUvMyOGVPz7qPtGVMowCxehBoLzdsHbS7F?=
 =?us-ascii?Q?xjG39IukvoEN+gDau8KfcMl3DZDvVMKLXFLVgVDUf5xa65+lwYAVAmiYOXft?=
 =?us-ascii?Q?ypQrEyxyQuzWZHqkFlIGGW8DSlBwIFtkY3CA336abka1aEBOfPH4KSbBfD/F?=
 =?us-ascii?Q?2+T3Osc7vQRTiqrd78ytQRnIE7UhYv3JsJQjo0QV/ET+jt0Q/1Iy68uv8IRh?=
 =?us-ascii?Q?JBS3RMVUnEadpsGNLzuuWvNEBaDPaKJ6euSlTQI2Bpfg+SFeRYQvQLYyknbS?=
 =?us-ascii?Q?Iy9lOr2vdWK+ipCCPd82VBbVhhBDs2PCkRoOF4Lk/Q/FCFMZf7rMe8Ae9NnQ?=
 =?us-ascii?Q?5aS0AjTChOZQ5QnSNmfFXacMR2EJ3nkeOIEQWYp1Rhnraw4BKC8yEyeA51Y8?=
 =?us-ascii?Q?w5Mj8S22h4fFvE6/mqdwxJRDHZ7lK3q/rxtbQ7XE/Y7j40dgo+fG51yVVTNg?=
 =?us-ascii?Q?uWX9P/soq0Y7nq/5QN+S3oW2icZ32RCxdbsU9eTeJrNJ3kYBW8p4faOe4mLk?=
 =?us-ascii?Q?Eq9UHroXziaETLzN3xBYq1gqP71cHSxMiJQzhKIWdWN7bHhOOU9gULckjEEG?=
 =?us-ascii?Q?CZUKKnHem42lrEftd3S/FgpYynKHjqZFRTU1A+95LU5UgoaH1DSYFfIQiEok?=
 =?us-ascii?Q?1yETPE+gILLy0ZslByIb4EYWXlN+NPSn5BJnQS2wjhpWr8Hw+OrC/iuZaiu7?=
 =?us-ascii?Q?mcfuHAnF7IMiDrgJfmOK5hGv6HE18RXdl7dakHxcZhlu45/rnO+lWqyQVLhb?=
 =?us-ascii?Q?IOEoKb6z8ZyJCRBjALry1UFhqq9bvw4KQ4s/bjt0XxZotnS7JParYWOohLjw?=
 =?us-ascii?Q?NVznQtReuWRkZ0EimQiKxmhz734PUnJHxgS2bZVOvJlrYeElyq30CYoO2Srp?=
 =?us-ascii?Q?VwmxnYycHEAK14Ra/OJxSGg+gp8fuxV2EwCUddWFvlCaOK/yN/0df6pItp8R?=
 =?us-ascii?Q?lDcKtyKXLWNRog5lxhM7pXM4wtvcI5jHmfSXt0Dh+fdMgurhppf9i2lvB2Eg?=
 =?us-ascii?Q?A/XgmiwQ1crkZTwRquGqIoq+cn4KHBxmLjq29eNzT9AH7v5Ef9RO5taUMu46?=
 =?us-ascii?Q?+wEAdzAl0/SNRC/SHkBabQT/Br4MElpsluGQu+xw/W/BTqoQignXdGZ8m4oZ?=
 =?us-ascii?Q?pfhOPlpYqwD5lSzdiGetiIrZg2prMPn0GZFftWeg+g8ywBKIexVGhkHdww/L?=
 =?us-ascii?Q?Ysesdx7s0bX9rVVPge5pjkA7cDxjo8XvunSDlBVHR0CHTxINRmMISi4EWrYF?=
 =?us-ascii?Q?INezqKBHigV186wEltvqfWJCZyU6oclaN4pktGX5f4Om3qcuDe26eDHGVHg7?=
 =?us-ascii?Q?9b/aHZx4Ft7PcdyGIbdr+rIc2V1qN+8bk+OCARmmwrfWgXRCwjwDNJaYSATy?=
 =?us-ascii?Q?PKq5fen5XcFHVDSQpUph8Nh2mU5l/LQAzGzsRbgIU7i/MjQEqlFmPO1UoVr2?=
 =?us-ascii?Q?N6IRZ5w5R4y2CxYCmiaj42xQpUwJCjR9Wcm/DJKDrbr34kNuKiVT7hbRcJ2F?=
 =?us-ascii?Q?7jzuVaHHWDHC2ss0nBDxnx/01oPHpzca13x99kNHaG5rVyzYOChF27JS4Yil?=
 =?us-ascii?Q?FhKspcrk7bXG4NrXatxEPOCiXAbXeiFpyh2bzkx4VzmltmBA2JV+bzX+S/JC?=
 =?us-ascii?Q?UajdN5CoKCZ8/xD0segOlUMYR6h5ZksJgIe9pY3yqJtpGkXP2SYDi0xUVBDc?=
 =?us-ascii?Q?u693qLGEuafgX0eDkzffxtzM/ytwdZHYpaB8LIQq2hH/8+05q06iQyIYo22M?=
 =?us-ascii?Q?5QwjE9omog=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c45cc436-681e-4c63-19a0-08de62310d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 07:59:55.1064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAZhN1viiFOBLOKLEaSwmVVxHdUWU8UEkcbeM9rqP6k0oBno8aeNZS0klN4jyhqiLz4cCZYrPUNUottQDEQHvml/c7hRKpwKbiS7VLH19SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC3F0DB79B
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255774-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:email,lunn.ch:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 288A0C97CA
X-Rspamd-Action: no action



> -----Original Message-----
> From: Kohei Enju <kohei@enjuk.jp>
> Sent: Saturday, January 31, 2026 5:30 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Lifshits, Vitaly
> <vitaly.lifshits@intel.com>; Simon Horman <horms@kernel.org>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>;
> kohei.enju@gmail.com; Kohei Enju <kohei@enjuk.jp>
> Subject: [PATCH v2 iwl-next 1/3] igc: prepare for RSS key get/set
> support
>=20
> Store the RSS key inside struct igc_adapter and introduce the
> igc_write_rss_key() helper function. This allows the driver to program
> the RSSRK registers using a persistent RSS key, instead of using a
> stack-local buffer in igc_setup_mrqc().
>=20
> This is a preparation patch for adding RSS key get/set support in
> subsequent changes, and no functional change is intended in this
> patch.
>=20
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  3 +++
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 20
> ++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_main.c    |  8 ++++----
>  3 files changed, 27 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc.h
> b/drivers/net/ethernet/intel/igc/igc.h
> index a427f05814c1..dd159397d191 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -30,6 +30,7 @@ void igc_ethtool_set_ops(struct net_device *);
>=20
>  #define MAX_ETYPE_FILTER		8
>  #define IGC_RETA_SIZE			128
> +#define IGC_RSS_KEY_SIZE		40
>=20
>  /* SDP support */
>  #define IGC_N_EXTTS	2
> @@ -302,6 +303,7 @@ struct igc_adapter {
>  	unsigned int nfc_rule_count;
>=20
>  	u8 rss_indir_tbl[IGC_RETA_SIZE];
> +	u8 rss_key[IGC_RSS_KEY_SIZE];
>=20
>  	unsigned long link_check_timeout;
>  	struct igc_info ei;
> @@ -360,6 +362,7 @@ unsigned int igc_get_max_rss_queues(struct
> igc_adapter *adapter);  void igc_set_flag_queue_pairs(struct
> igc_adapter *adapter,
>  			      const u32 max_rss_queues);
>  int igc_reinit_queues(struct igc_adapter *adapter);
> +void igc_write_rss_key(struct igc_adapter *adapter);
>  void igc_write_rss_indir_tbl(struct igc_adapter *adapter);  bool
> igc_has_link(struct igc_adapter *adapter);  void igc_reset(struct
> igc_adapter *adapter); diff --git
> a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 3172cdbca9cc..1b4075e7e8e6 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
I think here should be added include?

#include <linux/unaligned.h> /* for get_unaligned_le32() */

Isn't it?

> @@ -1460,6 +1460,26 @@ static int igc_ethtool_set_rxnfc(struct
> net_device *dev,
>  	}
>  }
>=20
> +/**
> + * igc_write_rss_key - Program the RSS key into device registers
> + * @adapter: board private structure
> + *
> + * Write the RSS key stored in adapter->rss_key to the IGC_RSSRK
> registers.
> + * Each 32-bit chunk of the key is read using get_unaligned_le32()
> and
> +written
> + * to the appropriate register.
> + */
> +void igc_write_rss_key(struct igc_adapter *adapter) {
> +	struct igc_hw *hw =3D &adapter->hw;
> +	u32 val;
> +	int i;
> +
> +	for (i =3D 0; i < IGC_RSS_KEY_SIZE / 4; i++) {
> +		val =3D get_unaligned_le32(&adapter->rss_key[i * 4]);
> +		wr32(IGC_RSSRK(i), val);
> +	}
> +}
> +

...

> --
> 2.51.0


