Return-Path: <netdev+bounces-301147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZO5AFC9UOWq3qgcAu9opvQ
	(envelope-from <netdev+bounces-301147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:26:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490CF6B0B43
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:26:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=IpWMWq0O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301147-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301147-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70CDB30095CA
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E2F376A17;
	Mon, 22 Jun 2026 15:26:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E2C3750BC;
	Mon, 22 Jun 2026 15:26:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141993; cv=fail; b=g7opGUCCQ7Dl/GR13mekJklWqqcziyAHCs8Lsh0/iA6qYrWXCXAH85mE2uvGhv3DdvcqlqElylahtEfIiIMZIZYzmKTih83P+2zfI/9NAlX79oK97he0RXdYLyUcGqAZTBpCLWlyK4YsmqS4tdFNImCzwv6XnJoTTbT76YKEILI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141993; c=relaxed/simple;
	bh=OlaImcEB0IJSRVE/NGIrZf8ZiZPwCb3VR0ola6wvQQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rBX8BBGNo/dw9ikq4mXFScHecdi1rjKi4RvCRuZ901ZaE5oyUdldypwLBqZhgGMGUZ712uokiG7SiJF3TC7GkAYUyWA1huUhq/42kw0xuexBlGkJECFqdTlbUOK+a+X7uPGi+g7jRJE6rJFC0T9s5VWveBT1MiReEt6+Wt2/rgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpWMWq0O; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782141992; x=1813677992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OlaImcEB0IJSRVE/NGIrZf8ZiZPwCb3VR0ola6wvQQ8=;
  b=IpWMWq0Op2JAkn4w/3tJWwNEzC70iTQlovV2+jZdz+kAdsg1AN0OkyrO
   WBRdq5CxKNm9HqOJNmFEPuih1jhLmnJeSqHcH+9L90yyX/xzDacdA5RPs
   +44TFS9sGTLPjOiG68vBt+WoWXbRYxrGHfoJZPN6Ee66tk1SehXEDcvmF
   a7gevVXsO2gBLbZtwqrsNEoE6KNGOBz6AWGD0UVOSmisv4FALA5VqPlRf
   hvig+gGY2UTEYgd+8QrgNp0ojGsqkZlTVFDP0o8pcVHH6+MIMty6Jv9lZ
   aMuVnP0ouaaEFdE3IQyASquELBCnjTmI+ekpBJW6rqgLEg7iCUWuTgSnj
   A==;
X-CSE-ConnectionGUID: s1rVgWjHRfC40sbsjcsAlQ==
X-CSE-MsgGUID: bVRcL9OqR+SSLWaPrHV9qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93470351"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="93470351"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:26:31 -0700
X-CSE-ConnectionGUID: sBLmH7d2SSWMA8E2iLFmNQ==
X-CSE-MsgGUID: DhjJXhRES5WAxfQ/prZyGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="272955661"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:26:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:26:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 08:26:30 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDmMhzufX7+4Cyb+GZj1yA2g6nFTyMa3awN+xvKZE+Wf3WCGFxfoJuXIzU3IcxDb8d0URYlYsBqpz69jbqgNXX8FxakKazZ9hi8a+6FA86nmWWhnKwg/noNuwPKInK8NiSE17NfPQ0lK6dxFqYBVATd5JdmlfaG2EMh+5eXo61buhKVAN+kILo81ssvC4RQ2YuaR8DW3OnIqcNDTxZRMlF9y1EopTnJQklXLWfWoMd9X+B8fiLxUFHC7BoyMRaPgRqTLJf9pA5oZ2qgHyhnqg8q85vmHMNigGDGu3mR7+FUlrp4CC6jIkRWdnwqtEPD9A29FFUNNyosVZbmS7AiyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQE5Lp8PN8ZXCOXVoDVtiKz1mY/sxztnn43Ec0CvuHc=;
 b=HGdmvoXmZvp1mJsQFia8eMYXoj0lEFjcpHc6uEFz5tqqUuMVk+SFE8HM9BYyTp3HECJe7/TOmHWpSeQtG+QwpBO23MoHExMMF7og9/7TY29rBF3S2u93ZFpuhMzeVYock3IarT2dzhNxM+m6lvttTLT6AggNVQNsK+fCDDEdBV1uMML9E0ttGwZkx1Ld9/PlTGMLeccgiE/t2d/vpAYavUfMbP7W5BYrGrchfAeO93YA7J7FgVYE24Jpqz5fchDX+vqfxhmxDMtOmHBfYdQWlaDYKXpPb8sGVPq1iUK/AqCRRj/I6o8qJc+/QfRZlN8h+O4/KYPUZnagpWKMG5rCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5939.namprd11.prod.outlook.com (2603:10b6:a03:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 15:26:25 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0139.011; Mon, 22 Jun 2026
 15:26:25 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ding Meng <meng.ding@siemens.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "wq.wang@siemens.com"
	<wq.wang@siemens.com>
Subject: RE: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp reporting
 when NET_RX_BUSY_POLL is disabled
Thread-Topic: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp reporting
 when NET_RX_BUSY_POLL is disabled
Thread-Index: AQHdAlp8KXrwVKL24k2wQS0p2anLe7ZKsgbA
Date: Mon, 22 Jun 2026 15:26:25 +0000
Message-ID: <IA3PR11MB89860AC4A5FBB899A502B2EAE5EF2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260622041718.6106-1-meng.ding@siemens.com>
In-Reply-To: <20260622041718.6106-1-meng.ding@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5939:EE_
x-ms-office365-filtering-correlation-id: 702b0275-a60e-4c4c-ce05-08ded0729f82
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|921020|38070700021|22082099003|18002099003|56012099006|5023799004|11063799006|6133799003;
x-microsoft-antispam-message-info: E8hnUj+Hr1tPT33wPSYbkaIyudCAYa6WHLa9IFCzKTGZyoWFtIpd5w5VIvOF592WkZQMJNGvrW/CINZIMr9WnSWqvTqxU0OZ76qdV+QF35kgIxuB8e4MyBtd/xG7Uu3P1tt8Sd/Ilz6DWBPv0prjOurQ1ZrChDqSFZTUBkdnmQyfxkDtH0F9of7PshBWjpPdKfPnjdu2seDHTlBHi+z/tH8r5FbVBLsNoD+D0G1Yn+0LbSKF5dgvjNhv+MFeGMxtXX4t7s+yzwfpBsGbA6GSSaVLU4xjlHeYsLJf8ABs70p4xlLFNNjqgPgt7e0J9i5ssRxtXthH/WxX6NaOe+fHbIP20UpNzG4Seu5n4nPDul5Mz3C3ErsoMtMUnanygW9p74LCWl5tT6ApNywGEQLBpCeDAdwNIfRcY2vUrUj4JI0ayXmB7AloJcFbZQm1LoVTPDHsZa8p/cGe7SxJkn2RTVL50sZY4bDwV8ktzvlnrbL/ysnVoDn0OTM/DTBNAGJqMvf3uOGHTFLLx4x8POe7Lwdof0trVo2gBIXlPwfRlB+lIIHiKGLMgeWYaYe2vivETJx9dE3VQRC+HmQWS9e4nmNN/bJUSP718DMz8RT2TFy2Ynuo1YWVaeheF0EReHq3TDSov2VHOZUVwUaGho+2jkR31ogoRL0SN3wK5Zi13koqf3ciYR6dsqqw1U2RCd1oqxyC+5gTp4QrR3Y/3dhgCOBOjQA7pknwkvZqOrpa2h1qnLmWaqcQV6lnFAueKRdl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vZpHzyPhqxSK+s4v4VgvohOda04utSZb0YCe1iilMZxTeq3iHFNZpqZqqrzm?=
 =?us-ascii?Q?1Ce7VJl2vqUf08LSoNKgtpAAtCSQi+/wPsDlHERzSuZG2zny6Y8etBST31wV?=
 =?us-ascii?Q?r78iT4OW/e+z0lP5Fcq2kU6NzU/wJtas2xTSbYeOP65UBtMC+MGQ7EStA7r4?=
 =?us-ascii?Q?5yxDf2MUKe5fZVFkVu5JOaBAk8x+9TgU4zvDnVTUPgOH8ZQCGhmXIs+8GgNC?=
 =?us-ascii?Q?Wja1nebMFQZm2yc/qyxPhi12uqfWTOyCOGokngfpfk5aQ3XmFomx4kN++P0u?=
 =?us-ascii?Q?NWF9FGp/8B9EKjIoYCIpwmuVHN5Ww+tWH5APcsrnUbqmEc1TZn5JZVSdvuUz?=
 =?us-ascii?Q?jGYw2RPpVmNQSL159jftaBb1j63FyGYFqzU3F1FcNhUgo6uf6SPg8Gggkq2R?=
 =?us-ascii?Q?ZByw/CuSdNvEULfAcexlWJx8H+efH1eRtXjjkKus/JIWISmzee5YzmX9LCem?=
 =?us-ascii?Q?zMv97RFcZ5C2x2Yqt00vpsfLerMQjaoqtBt//jqHRSn0jcMP8p66mhOq5qfX?=
 =?us-ascii?Q?X0/R3kH+hgVQXXg56Fd3XAmPDjAGqUO4wvOoUgmWJlZDuGHp1/vUk8pvGlzj?=
 =?us-ascii?Q?Mdx3MUqlQUKW9FhqZ7dUm8bV8+nuRxP5lOYHw9LrlbSsyGHmtNBLQMQe0mdK?=
 =?us-ascii?Q?KtUssd22VGEpZIVtvuKYIEYqlLvWe6aiAMr7NfYcZMqY3PlJkiw3DhYIWtul?=
 =?us-ascii?Q?gmXiKVkwc50qwN2vmgKutjJks1pR5fZfK5oM1PZL/EY0WauGe2rQZjpnjvnD?=
 =?us-ascii?Q?GN8pI/W/F1TK3NXimsA967+wd1jVh7vo715RWjHR0VTP9IeEyEmXklnMDDjb?=
 =?us-ascii?Q?axwZVR1AVcj/DbTVngEFRJSAX7ffdFmsD9HuS0AkMB8Pw36GxzayaUtPk0KZ?=
 =?us-ascii?Q?i9oADXOvr2I/aFlnuPOw7oEDcJf185LljVo/p5npS7u9eVvKUsljNIWEZMnz?=
 =?us-ascii?Q?hcz41at9umJuMQyvrWu4ZPnEQCM1yWX8A6mBz1w8uuJ0PdSUPjQqk7xq/2DA?=
 =?us-ascii?Q?BZFhh2B4jDM1QgNtqZTn23j9BY1RxTz28jRI0r7MJ+ZoMPQ0QKxAhM4OQWSh?=
 =?us-ascii?Q?wc83E/t6AI9iGP6Zfzomhg30ga6tDbfdM2n8QI2FLKm975jFrlxWa/q584Sm?=
 =?us-ascii?Q?y215Eo+yGHBH+7nSXKWB08m231ouc7pqKGfHUNduBlqqwFHJnIQk3BRw9FXu?=
 =?us-ascii?Q?fmiM938QBo4ddTU5txle+/t9bj5y9tZqWoqROP43l2cH8ltLOEVhpOcXElV8?=
 =?us-ascii?Q?EvVqJyWHTldYQTt/AggpsvVhhbJpiXs/JhLCzF61kNxt6m2CVNvoA+S5Pt62?=
 =?us-ascii?Q?qvKBz4N3TayJ6vU7JuniCiFwMtwjdjPpZJ/3UtwBIt+TyWR/t6zEibU8CsLq?=
 =?us-ascii?Q?STHRxE0gVO+S3lV9XR2k98rk/XhfvN09O2QnMQqCv7wkHsmzNsgr2kp1pJnS?=
 =?us-ascii?Q?0RtmmHDPh5gh8p2VzIlpatgmgp1S/YJHWk4OSdhce/D2udfLp+42oQwf6r4f?=
 =?us-ascii?Q?efCv1IcGM/2HaOr4G3Wqb1h9q5r5TW0CDE42n8zGxz4xy1aOn2KNvUUYVDof?=
 =?us-ascii?Q?zTSfY4IM6Q0ztKRq4uI/0GxeO9yCA30sg9ILja25xtn8WekEHCVzFUaK5cO0?=
 =?us-ascii?Q?DnsBShZZhh/97EfNUjvfHrYIUQX/zn3YtOT2KZcUuWMaK4g2A3h8FLJDIJx4?=
 =?us-ascii?Q?Z4z8i9SPEYL0emqk253vN5m+IByrCXdrm1kS/DL7ayB0M7aJmaTYQ6CqkNok?=
 =?us-ascii?Q?Qu6DSvWxwJkM1o9bBxxRo53uuW/gs44=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GhWdAFcV0ASxM4h/O4NJccUgz/fklGAbsRLwMDAcwE56U0V8AYE+n3EDh1cqc+24fpQQbD5SmZNvZiQjz7ZeQc+WuJ4b1qu1r4KegJKzkdahJxeo2nZF5Xzb8edWnyXuTDYgkrbamPhyBgiZLrjes7RBXbqXIAjXT9+FnNuhKO8dkmu/N6lGVlAmYomQj5jCTazCUYHT/8Z8ZHZ1G4znOIbwQFs+NfcRZLed+0dHZ7JyObY17wKqanoXbvxu9RhdRP1+XDvLNlQTbhpZLapsSwYQvlShlzkz1/72B0fgsIItZAUXQFV5x6B3eHYL35tDmfrTxq6E9nJ/BlfLpQN+Ug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702b0275-a60e-4c4c-ce05-08ded0729f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 15:26:25.3941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nz9gck/kg9k819q1TGC0cyEdP2lE7QCto/A6uSgb+mRJgrvGMDG96Fy4zjwTRLIhis5mNOs5+oBUVc9KcUg8aQXGAMGlVJI/z1CT0K16/aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5939
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301147-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:meng.ding@siemens.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jan.kiszka@siemens.com,m:florian.bezdeka@siemens.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:wq.wang@siemens.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,osuosl.org:email,lunn.ch:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 490CF6B0B43



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ding Meng via Intel-wired-lan
> Sent: Monday, June 22, 2026 6:13 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Kiszka, Jan <jan.kiszka@siemens.com>; Bezdeka,
> Florian <florian.bezdeka@siemens.com>
> Cc: intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; meng.ding@siemens.com; wq.wang@siemens.com
> Subject: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp
> reporting when NET_RX_BUSY_POLL is disabled
>=20
> When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
> from the NIC no longer works as expected.
>=20
> This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the SKB
> NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
> fails to perform its driver lookup, and the igc driver's struct
> net_device_ops::ndo_get_tstamp is never invoked.
>=20
> Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
> a field that the driver has not populated.
>=20
> Fix this by populating the hwtstamp field with the correct timestamp
> in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
>=20
> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
I think, because it's a fix, it needs Cc: stable@vger.kernel.org

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> Co-developed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> Signed-off-by: Ding Meng <meng.ding@siemens.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 38 ++++++++++++++++------
> -
>  1 file changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 8ac16808023..1da8d7aa76d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1992,7 +1992,26 @@ static struct sk_buff *igc_build_skb(struct
> igc_ring *rx_ring,
>  	return skb;
>  }
>=20
> -static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
> +static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
> +					 struct sk_buff *skb,
> +					 struct igc_xdp_buff *ctx)
> +{
> +	if (!ctx->rx_ts)
> +		return;
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +	skb_shinfo(skb)->tx_flags |=3D SKBTX_HW_TSTAMP_NETDEV;
> +	skb_hwtstamps(skb)->netdev_data =3D ctx->rx_ts; #else
> +	struct igc_inline_rx_tstamps *tstamps;
> +
> +	tstamps =3D ctx->rx_ts;
> +	skb_hwtstamps(skb)->hwtstamp =3D igc_ptp_rx_pktstamp(adapter,
> +							   tstamps->timer0);
> +#endif
> +}
> +
> +static struct sk_buff *igc_construct_skb(struct igc_adapter *adapter,
> +					 struct igc_ring *rx_ring,
>  					 struct igc_rx_buffer *rx_buffer,
>  					 struct igc_xdp_buff *ctx)
>  {
> @@ -2013,10 +2032,7 @@ static struct sk_buff *igc_construct_skb(struct
> igc_ring *rx_ring,
>  	if (unlikely(!skb))
>  		return NULL;
>=20
> -	if (ctx->rx_ts) {
> -		skb_shinfo(skb)->tx_flags |=3D SKBTX_HW_TSTAMP_NETDEV;
> -		skb_hwtstamps(skb)->netdev_data =3D ctx->rx_ts;
> -	}
> +	igc_construct_skb_timestamps(adapter, skb, ctx);
>=20
>  	/* Determine available headroom for copy */
>  	headlen =3D size;
> @@ -2686,7 +2702,7 @@ static int igc_clean_rx_irq(struct igc_q_vector
> *q_vector, const int budget)
>  		else if (ring_uses_build_skb(rx_ring))
>  			skb =3D igc_build_skb(rx_ring, rx_buffer,
> &ctx.xdp);
>  		else
> -			skb =3D igc_construct_skb(rx_ring, rx_buffer,
> &ctx);
> +			skb =3D igc_construct_skb(adapter, rx_ring,
> rx_buffer, &ctx);
>=20
>  		/* exit if we failed to retrieve a buffer */
>  		if (!xdp_res && !skb) {
> @@ -2738,7 +2754,8 @@ static int igc_clean_rx_irq(struct igc_q_vector
> *q_vector, const int budget)
>  	return total_packets;
>  }
>=20
> -static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
> +static struct sk_buff *igc_construct_skb_zc(struct igc_adapter
> *adapter,
> +					    struct igc_ring *ring,
>  					    struct igc_xdp_buff *ctx)
>  {
>  	struct xdp_buff *xdp =3D &ctx->xdp;
> @@ -2760,10 +2777,7 @@ static struct sk_buff
> *igc_construct_skb_zc(struct igc_ring *ring,
>  		__skb_pull(skb, metasize);
>  	}
>=20
> -	if (ctx->rx_ts) {
> -		skb_shinfo(skb)->tx_flags |=3D SKBTX_HW_TSTAMP_NETDEV;
> -		skb_hwtstamps(skb)->netdev_data =3D ctx->rx_ts;
> -	}
> +	igc_construct_skb_timestamps(adapter, skb, ctx);
>=20
>  	return skb;
>  }
> @@ -2775,7 +2789,7 @@ static void igc_dispatch_skb_zc(struct
> igc_q_vector *q_vector,
>  	struct igc_ring *ring =3D q_vector->rx.ring;
>  	struct sk_buff *skb;
>=20
> -	skb =3D igc_construct_skb_zc(ring, ctx);
> +	skb =3D igc_construct_skb_zc(q_vector->adapter, ring, ctx);
>  	if (!skb) {
>  		ring->rx_stats.alloc_failed++;
>  		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);
>=20
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> --
> 2.47.3


