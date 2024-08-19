Return-Path: <netdev+bounces-119586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7F7956489
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37AFB22F6A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD114A605;
	Mon, 19 Aug 2024 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nz2MAlq0";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wg/ahV/S"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33115697A;
	Mon, 19 Aug 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052279; cv=fail; b=YDxocp+bVcuypCkEw3fJeB6TWcb196DKiIcmqgmJ7kZIukwDa/FEhswtYwk/JVrLMXB+w6Kwrfavp+Y3II8c4MCUzvVOEDvbmHxTboU8t+m2T8ggMHemms1ubrpLOu3My4xQQTd8LmdDjaTzVNO3JM77qkfBPzx/8pKqpYkesuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052279; c=relaxed/simple;
	bh=EFJfATLmukwDU0yktaIO4KvH9XnwoUw2cusV2l+3ejM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gwXKUUzVBe1CpV+cmtZeSIj8P2saDlDNiferLBdKD3zbzTt2Jau2xtSL6qzOOSMxA42X2LjvaYbo+ptDlzfIOS/TAX0qINKXbSVWbZV9RCnjj9MrD/xlJ1zY8s/uPC70sB3Fga9i4RdMe9RCO5mZtx4t9+/mmS/B7ZS1YnwMDb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nz2MAlq0; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wg/ahV/S; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724052278; x=1755588278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EFJfATLmukwDU0yktaIO4KvH9XnwoUw2cusV2l+3ejM=;
  b=nz2MAlq0/r+1V4CvD5c9oCmD6XF6Ct9Arx0xaukcRpvtt6EKqGCABylC
   4Rngx0yguwSZz1yP2CkR0XoNTxSvgVPA2yVL3N9MIiMeQUi0xKPkeT5Rr
   f5pLG17dNKUOxJf5UiAciLKDML0tmwz2z5gy9N/d23ygYexntEZmus8ay
   LWfQL/olWrcSpBMh2QnzPGm2UR0qsz6VmqEEU7UzfU3S6fOxQ1Qy9W5xp
   F84n5AFgG7rs/t76Fsy5xeX1Qlx4f7XdkReDwa9wX3GdeAxuzbtg8voZN
   TPTJMJHZetbeoTCIE01iRbHlOFnEinY068nSi9usLxIUIPF/6Vyis7hGX
   w==;
X-CSE-ConnectionGUID: 0a91AkZYTHemxxmYBrgTAQ==
X-CSE-MsgGUID: LpcxBn47Rcev6Z38A7bmPQ==
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="261567041"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2024 00:24:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Aug 2024 00:24:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Aug 2024 00:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJh2Buraw+UxaejP9pQJ8vpevD/yUWXn+/foDLxkVZZnF/hXkq56rxr/SiyFVM/mkJjl1ezTjg1LAJd4isMLLpkKCZODRGb5+x8R1AbxVoNtwBMpAOXDMIYO+nYejaUpkLXtKmyEn7d6C+v1P8RGwDM3f8j+VCjWRXaLpmICZDAL3MsX+aaOXk1p/MnbWOmNjvQDD7XTtCU6u9Y1km8q8QSVFz4bOoGUajycvTvI7N990f+cftljlnnT9qYsbrSTLgcP4Dt9AS5tiIV22pFDQFj2DFkhluw2AH3rTgMk72OJhL+6eAxufguxQ/w8NKzQZKbux4UHdrgRvBVEoGESiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFJfATLmukwDU0yktaIO4KvH9XnwoUw2cusV2l+3ejM=;
 b=Sb6FF1dcE1gzEa9Of4sEJwf2LVCIvmB92m2yIO03Eum29M0upimsajysc1ZfjuXw5XmWdCr6/c7jctjLV54fWj9PPC6Hdm1+58pZfoOq8H/NTXYEbsanENGfYB2nFJwmUVlMuBYaioaFf1TPoQWKA7tycc6B/2VxGu86B7BYwhzjnS/X4/l7dUMcsbpo2Hkle71lY6OoZ1+43iTcFC0BpgVke7FMQNQaU5+AgjWXOYAXdFwEtW6Ga4TWR2pV5/OM4SbOYJP05yeP5nc1cO1BtDhT9JjInITsJZjshrt7a3+iMeL1+WiOgd7wwB0ojb0N/037LWwhFosrLP5TSlEgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFJfATLmukwDU0yktaIO4KvH9XnwoUw2cusV2l+3ejM=;
 b=Wg/ahV/SpnvVhaoiTr6HNuRF9OReVOpLBpeUzQjL8tGwHVfr5uY2IkeLTqgcFouF6UzRcIpll+/PDOSV33CxQDp0Mx9YcwuyKY6n9vF+7FqY+ViZaNiTd1xTMm0iiQ2q8zJIaCasdl/No3wTVPEn5ioZFVO7GAx0gM7Dc1+T55yXFqrbdFkrBPWqZe/DCmdNQjlxtOhdY86oLMgpK+aPjVaO5qPZslmwORdW+diLU2Mq73q5Xiisc164RLQO6pSuHM9TlnvVKyH0jfpbqUNdNzR9KkXPu10dCTBgHPK9kNWcSfew6t6f067rZMIXMbFot4cX7z6ujdKVr+aupHZBSw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM4PR11MB8159.namprd11.prod.outlook.com (2603:10b6:8:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 07:24:12 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 07:24:12 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next 5/7] net: phy: microchip_t1s: add support for
 Microchip's LAN867X Rev.C1
Thread-Topic: [PATCH net-next 5/7] net: phy: microchip_t1s: add support for
 Microchip's LAN867X Rev.C1
Thread-Index: AQHa7L5w3HY4X1NmWkqybGgD5y9wbbIoaU4AgAF7fACAADv5gIAEF1MA
Date: Mon, 19 Aug 2024 07:24:12 +0000
Message-ID: <7e1b0c30-6d15-4e83-8975-9f6c2ee244f5@microchip.com>
References: <20240812134816.380688-1-Parthiban.Veerasooran@microchip.com>
 <20240812134816.380688-6-Parthiban.Veerasooran@microchip.com>
 <20240815144248.GF632411@kernel.org>
 <3235fb9a-62cf-4f9a-b21e-e0b881c79c43@microchip.com>
 <20240816165541.GB632411@kernel.org>
In-Reply-To: <20240816165541.GB632411@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM4PR11MB8159:EE_
x-ms-office365-filtering-correlation-id: 09466da9-a1e0-4fcf-af8b-08dcc01fecb2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0RlQUF0SDArbThvNG5OMGxZaS9mREcreU9SS0V1OGY3MnlnUi9DbWlzb1U0?=
 =?utf-8?B?VWlRYTRMUThuTi9XaFROc256bDVLQytyaXVqeHRmMVFmSEtGL01wcWJtbmJL?=
 =?utf-8?B?MnpVVHE4aHFRVk1MUGNDbytieERYT0ZlM0trTThpUVJjay9SbGp2RnE4MnZk?=
 =?utf-8?B?ZEVBU3JONWhpTGlKRGxBem1kNXBKbGZKaTY3YkdUcEpyTWVsVExvTHpGYVlB?=
 =?utf-8?B?c0RxT1ArU2xyRmJUSmdYdmIxTE12MlVyNVlkaVJmUkRYRlpIQ3ZQSWZ2MytE?=
 =?utf-8?B?L0NmWGsxZmFOUCtTUjFxa2M1S2RYK0Zxa0dqanVzOHA4WnVlOUlCRHRVRlJH?=
 =?utf-8?B?b2k1K2RDZXVTb3RMZnlPdzFDM2ZmVHJZQVJVZDA5Wmk3bnB4T2ZZMklFd1V2?=
 =?utf-8?B?S0Z2SG53ZHpSdHpvZ1JQRTV1RDlDaEVqc05UMVFyYkwvOWJtYlR3K2JuTzly?=
 =?utf-8?B?MGNMM0NaYVlpMmROdlBmNG9vNWgxZDMwQlhEMmRGeU1yN01LSVNRMTBRYnZj?=
 =?utf-8?B?VkVKMlBRQURITDFZOUEyWDVXSVVZay9oZ1FEaUxyYmZNdHhTUkU2MHAxU2Ji?=
 =?utf-8?B?RXJUakc2WmczSjNYT0h5SlJDNW9MblpZU1Z3cXBKZHhuaTVGQWRaR0NJUVRX?=
 =?utf-8?B?REV2aEJoSklvWWNmSE5CczJDU3BmK2FGbk5mWk1Dc2x3NTNxVmVZSGxmVXFm?=
 =?utf-8?B?SU5hMGN2Wk9yenJsQUVvT2xsVnpXdzNyYW1wQ2hSVzljK0FhSEwxY2JUVXNF?=
 =?utf-8?B?em9mN0lDYlNEV2xHOGJtdzFOMnV4bG5DeVF2VXZCRmFRbVlZcjlTTXZIbXVx?=
 =?utf-8?B?Z2F0eTZ4cnhDRG1GSit1dVJmb3RKY25yRmxZQTRoK3FVWUVYQ2lzYkoyMk1P?=
 =?utf-8?B?czdHemQzOTdpWWJZNUpRS0dlY1JTbVUwWlA2MDJNLzRZV0taMHFwQnJCaGNW?=
 =?utf-8?B?dTRGbWFRSHQ4TkRCSGNPS053dUdYUW5IMndFL1VTT3JiYzdORkVPRm43dTAx?=
 =?utf-8?B?YURPZ0EwTzl2SFlQdUgvYkdxaEhDTWpLdGFkcHZEcHZJWGhBeDFneExmWC9D?=
 =?utf-8?B?MFVzK09raFhVT3VVM1hxVnNYSkFscnR5ckJCQ3NSekcxc2c4Rmh2cTg3SEUv?=
 =?utf-8?B?Ymw2MmsrVFpXYVJ4UDY3ZnJZV3NHenI5UWJyVWoyaDJSRm9SSlNoKy9taG5w?=
 =?utf-8?B?b2ZvVExHcU1QLzZ4UHpMZ1RWZTJNUHJaeUMweXhGUWFqaXpZZ1FQRGx2Z1du?=
 =?utf-8?B?U3d5Q1RZVjlUc3VQYXFzMmxGcFJYdVlRdXk5akdBL2Q2S0s5NzF3L3lpZlg5?=
 =?utf-8?B?YlVKLzdpcDJlR2JtYWNnZUcvODc2TkNIY0JLcEhpQzA3L0x3RGt0WStCbHBl?=
 =?utf-8?B?SVB6eWRDUG83Zkw5RndWK00vVHpZbUlzSlo2REdFeGlGcko5VERVQTdWUVhK?=
 =?utf-8?B?NGFtd081U3VwR3RMbmtwUkFBUi8yaGFpeTJ0MXRPMGtlaHJjY3RseVl6NmEz?=
 =?utf-8?B?ckRFUTFJNXJvejUwV1h1YnVHNkNiSnpWUkFzeG9Fb1BjOE1FVFBpQmJxbDRD?=
 =?utf-8?B?dU52OU5KSVFSbXhmd3ZGaFNCcTRGNFd3ZG11OUN0YWZNZFJmZnZrSGdKYmZm?=
 =?utf-8?B?Z1lsQ2lrT0htZEtIRU40a1NJb2lNYlFvWk9PajNEaDYyQ2NNRXJsQkRoNERu?=
 =?utf-8?B?RnlLeXNMMHRFVnp2TjlhSFhMdFlWZUlVQnhUMHpEdGhHd1N0c0hGZEZsbXEr?=
 =?utf-8?B?Vkw3cDQ2VnkxQmdGbVVjT2k1clRHMlZLTlRGREowSjliRzZUcHJEclY2VDlB?=
 =?utf-8?B?MVBJVTBnNVZCbGh6Z2dCREFJOTFyVVlWSFM4VmI2WWNzUHJIc3pZRHRQeUJS?=
 =?utf-8?B?azRWNHpOdVZ2MjlMNHdOK3BEa0pYbjQySUVmNmZEU0pTZlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmhZRHU5cjVxc3NHaE0zMXZ4SDY5V2srQ1A1dXBlVGxDZ3JUR2ppTFdBdW81?=
 =?utf-8?B?TUVKOElqNldCSllZMmpMaHBiTjJMYzFYSEFHeThWcTYzd3dodUF0SU8zanhj?=
 =?utf-8?B?VEs2ZFVheUdnZkhQNkppQmpVNWk5a0ZFRFR3eXNNb3V0VTJxMUM3V2x0NkxW?=
 =?utf-8?B?OWJBV3FMYldVK3JKVlI4cXBFUUxhc1B1UUxsVG9rWjV0U0hXYXZFYmdXYk03?=
 =?utf-8?B?WlhOZXhtMHRXaGhPMTZtbHR5aDcrMXVzMTJ6VXV2K1AxU3RDQVdWTnl1Mld5?=
 =?utf-8?B?anBBQ3FXRFRkenJ0M21jb0xDQlcrQlpXOHB2ZVhEUVcyYjd0eHhuTGZhNk1q?=
 =?utf-8?B?aTVjaGZmaWltVkZ5ZHgwLy9wY21saFpQaUVwWDRSaUUwV1piekpCcmtrclZC?=
 =?utf-8?B?Q1hQRUE3UmZYbGZ3cVBnYUZyZGJTcFdna0JRU3hMdEo0OFRhUkgxNTMzYW8v?=
 =?utf-8?B?SXFhc3pLVnFIdFNiaVVmQm5MSXpHd0t4NXR4by9pcWN0TG5QY0pncTRnanFT?=
 =?utf-8?B?Y0MvS3N0WHVOb2xBN0lCV1pEWUQzN2V6bXB6QlRkUEVpTENzN2FuZjhVWmxz?=
 =?utf-8?B?TTJtRHNDUUNvNjFyQWxBTi9DTkVPVE11cmplUjQ0NWF3N3dGNzVwMXhlazdZ?=
 =?utf-8?B?OTMzcWc3M3U2ZFd4OFZsRGcrdzE0NzZIWXREL2trY0QrSUk1NGFkNkhDcGJh?=
 =?utf-8?B?VkRXclhNSzE5RmtkMEVkano0MnRrT0R4dE8zcVBiTDQwUENlVW1lRXhma2JE?=
 =?utf-8?B?Y1ltSnNLc29OWHVqaHZSTTFxeXN5WHZpbGQyMkFLdk9SYUcxeFVpWWQ5a09I?=
 =?utf-8?B?VEtqMHMzcW9SUGJ2U3RQQkZwZ0FnV1JpK3Y2b1JYa2N3QmdrK2NPMWY3cDNL?=
 =?utf-8?B?SUNLYlg1UHhSVU1Dd1JGUG9IR3pSQ3Z5STgwbGg2d2N3UzdLWWdKUkxJYndn?=
 =?utf-8?B?MklpQzVuS1ZPRFZ3MWpBdStrc0daK3hOYjVEYk1SNHpVV2pLb1YwUHFhZXkz?=
 =?utf-8?B?eC9NWkdnSmJvemQxSEZXeXRJZkJiZXhSSitoanFiUFl6YTFMTEJLaTNEaEQ3?=
 =?utf-8?B?VjhBdXhZWDVwRzB1Kzl1a3RFVkRBcDFhTndZckR2KzczS0VjL01WNlRVM0V2?=
 =?utf-8?B?TXpxN3ByZnJVMjZjY0s2TU55dUlZVDZJeHU5cFl6MExTZFlUanNELzJwSldJ?=
 =?utf-8?B?RzhyUmRpZFBzOWVzbmVCYTB6Y1ViUWhsYnoxaHpKaUc3cndISWZ4MnVySzlK?=
 =?utf-8?B?bWJnZXU5YklMYkE4RjlhUUorcmc5Z05HL05YUUpzMXpCcDd0V2t6Q2VOMS9S?=
 =?utf-8?B?SHJvL01xMzBOSTJuTDRDVi8xOTdqa3pPeW5yVEdXVEZpVHJUNlVUUGJoN1ZT?=
 =?utf-8?B?SHAvT1JoQWE2RVRncmtJQnpEZVZBQ3UzQ1FMUWwvT2lFalBSSk1hWFBXWWpD?=
 =?utf-8?B?UDlWdE1NODY1bUhjRm1JVmhnWTZiTjFoc3Z5elBXRnZCdG9tSkJDa0F3d0x4?=
 =?utf-8?B?SWVncHZrWXZNcG5sRWJZVWhESmdKY2FTR2M0NnpsMVFSeTQrMURxR05pSW9E?=
 =?utf-8?B?R3ZFK1BKUnk2RERXSEE1N3JsUmJGblFRcDF2M0o4enlhblVUR1Y0NVBMVTNX?=
 =?utf-8?B?NnBVTi9Db3FHWC9NdVZXZnJDZmhweVJXaVpxTHlSNGFpZjNHdFRsWW8xZ2VC?=
 =?utf-8?B?bWRXUHA1RzhwVU9wY3pJTjdOWVJMZkQrWjlRSDFnZFhRdkdROEpVMlgvTWc3?=
 =?utf-8?B?OWcwRU5sNURyMHIvYzlkMDAzNEZpUG9PWVpuRXhmUGlRWDlCSEJkR1VWWERP?=
 =?utf-8?B?b1g2WVR0c2tHTGxXa2pHb0tCVXdFMVhWNXVQVDVTTWFwamxYdnhQcEdWbU5q?=
 =?utf-8?B?MGdINDBPNFJScXExUm1Rc3dkQ2xxT2dvandQUGdZNGd3N2VGWUlyM2xnQ1lO?=
 =?utf-8?B?ME5VZlZzaWc1Y0U4MlVSbW5QWndVaTcwZEJSbFVqYzRQNXdlYjVEeEJ0QWhq?=
 =?utf-8?B?cDFHMEc5anYzZzBuMFJNbkdmMElPYThudUZkdUM0cTRMR1ZSZVcrQmpIQnNV?=
 =?utf-8?B?VjZVRnBSUkFBaDBLb2dRWVc3bENJeEhwS3pnbHRGaS81NVpHSVp4VDRyU3JY?=
 =?utf-8?B?bVhEQllXUndNVkh0TUo0MGhGZjI0Z0hTMjF5OE45Mng1ZEJ5SGMxNzhtWHNU?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF468DD3A3C6F243BDB4E8BB9FC67D84@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09466da9-a1e0-4fcf-af8b-08dcc01fecb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 07:24:12.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEkeUglTJe66DiTqflEgP7Gmv9GkBTfsgnbXUSmIgHnmftLSAgadMPhM/USAdoxWtohakjX6+b1DBav+gA/3rf+qaAMwL0n599iUFQICI+yDAwdoN/+XEcv46+L1PnG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8159

SGkgU2ltb24sDQoNCk9uIDE2LzA4LzI0IDEwOjI1IHBtLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCBBdWcgMTYs
IDIwMjQgYXQgMDE6MjE6MDJQTSArMDAwMCwgUGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hp
cC5jb20gd3JvdGU6DQo+PiBPbiAxNS8wOC8yNCA4OjEyIHBtLCBTaW1vbiBIb3JtYW4gd3JvdGU6
DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiBNb24s
IEF1ZyAxMiwgMjAyNCBhdCAwNzoxODoxNFBNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4g
d3JvdGU6DQo+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBMQU44NjcwLzEvMiBSZXYu
QzEgYXMgcGVyIHRoZSBsYXRlc3QNCj4+Pj4gY29uZmlndXJhdGlvbiBub3RlIEFOMTY5OSByZWxl
YXNlZCAoUmV2aXNpb24gRSAoRFM2MDAwMTY5OUYgLSBKdW5lIDIwMjQpKQ0KPj4+PiBodHRwczov
L3d3dy5taWNyb2NoaXAuY29tL2VuLXVzL2FwcGxpY2F0aW9uLW5vdGVzL2FuMTY5OQ0KPj4+Pg0K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPFBhcnRoaWJhbi5WZWVy
YXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9uZXQvcGh5
L0tjb25maWcgICAgICAgICB8ICAyICstDQo+Pj4+ICAgIGRyaXZlcnMvbmV0L3BoeS9taWNyb2No
aXBfdDFzLmMgfCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+Pj4gICAg
MiBmaWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+Pg0K
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L0tjb25maWcgYi9kcml2ZXJzL25ldC9w
aHkvS2NvbmZpZw0KPj4+PiBpbmRleCA2OGRiMTVkNTIzNTUuLjYzYjQ1NTQ0YzE5MSAxMDA2NDQN
Cj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L0tjb25maWcNCj4+Pj4gKysrIGIvZHJpdmVycy9u
ZXQvcGh5L0tjb25maWcNCj4+Pj4gQEAgLTI4Miw3ICsyODIsNyBAQCBjb25maWcgTUlDUkVMX1BI
WQ0KPj4+PiAgICBjb25maWcgTUlDUk9DSElQX1QxU19QSFkNCj4+Pj4gICAgICAgICB0cmlzdGF0
ZSAiTWljcm9jaGlwIDEwQkFTRS1UMVMgRXRoZXJuZXQgUEhZcyINCj4+Pj4gICAgICAgICBoZWxw
DQo+Pj4+IC0gICAgICAgQ3VycmVudGx5IHN1cHBvcnRzIHRoZSBMQU44NjcwLzEvMiBSZXYuQjEg
YW5kIExBTjg2NTAvMSBSZXYuQjAvQjENCj4+Pj4gKyAgICAgICBDdXJyZW50bHkgc3VwcG9ydHMg
dGhlIExBTjg2NzAvMS8yIFJldi5CMS9DMSBhbmQgTEFOODY1MC8xIFJldi5CMC9CMQ0KPj4+PiAg
ICAgICAgICAgSW50ZXJuYWwgUEhZcy4NCj4+Pj4NCj4+Pj4gICAgY29uZmlnIE1JQ1JPQ0hJUF9Q
SFkNCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMgYi9k
cml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3Qxcy5jDQo+Pj4+IGluZGV4IGQwYWYwMmEyNWQwMS4u
NjJmNWNlNTQ4YzZhIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlw
X3Qxcy5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMNCj4+Pj4g
QEAgLTMsNyArMyw3IEBADQo+Pj4+ICAgICAqIERyaXZlciBmb3IgTWljcm9jaGlwIDEwQkFTRS1U
MVMgUEhZcw0KPj4+PiAgICAgKg0KPj4+PiAgICAgKiBTdXBwb3J0OiBNaWNyb2NoaXAgUGh5czoN
Cj4+Pj4gLSAqICBsYW44NjcwLzEvMiBSZXYuQjENCj4+Pj4gKyAqICBsYW44NjcwLzEvMiBSZXYu
QjEvQzENCj4+Pj4gICAgICogIGxhbjg2NTAvMSBSZXYuQjAvQjEgSW50ZXJuYWwgUEhZcw0KPj4+
PiAgICAgKi8NCj4+Pj4NCj4+Pj4gQEAgLTEyLDYgKzEyLDcgQEANCj4+Pj4gICAgI2luY2x1ZGUg
PGxpbnV4L3BoeS5oPg0KPj4+Pg0KPj4+PiAgICAjZGVmaW5lIFBIWV9JRF9MQU44NjdYX1JFVkIx
IDB4MDAwN0MxNjINCj4+Pj4gKyNkZWZpbmUgUEhZX0lEX0xBTjg2N1hfUkVWQzEgMHgwMDA3QzE2
NA0KPj4+PiAgICAvKiBCb3RoIFJldi5CMCBhbmQgQjEgY2xhdXNlIDIyIFBIWUlEJ3MgYXJlIHNh
bWUgZHVlIHRvIEIxIGNoaXAgbGltaXRhdGlvbiAqLw0KPj4+PiAgICAjZGVmaW5lIFBIWV9JRF9M
QU44NjVYX1JFVkIgMHgwMDA3QzFCMw0KPj4+Pg0KPj4+PiBAQCAtMjQzLDcgKzI0NCw3IEBAIHN0
YXRpYyBpbnQgbGFuODY1eF9yZXZiX2NvbmZpZ19pbml0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlk
ZXYpDQo+Pj4+ICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPj4+Pg0KPj4+PiAtICAgICAgICAgICAgIGlmIChpID09IDIp
IHsNCj4+Pj4gKyAgICAgICAgICAgICBpZiAoaSA9PSAxKSB7DQo+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldCA9IGxhbjg2NXhfc2V0dXBfY2ZncGFyYW0ocGh5ZGV2LCBvZmZzZXRzKTsN
Cj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCkNCj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4+DQo+Pj4gSGkgUGFydGhpYmFuLA0K
Pj4+DQo+Pj4gVGhpcyBwYXRjaCBpcyBhZGRyZXNzaW5nIExBTjg2N1ggUmV2LkMxIHN1cHBvcnQu
DQo+Pj4gQnV0IHRoZSBodW5rIGFib3ZlIGFwcGVhcnMgdG8gdXBkYXRlIExBTjg2NVggUmV2LkIw
L0IxIHN1cHBvcnQuDQo+Pj4gSXMgdGhhdCBpbnRlbnRpb25hbD8NCj4+DQo+PiBIaSBTaW1vbiwN
Cj4+DQo+PiBTb3JyeSwgdGhlcmUgaXMgYSBtaXN0YWtlIGhlcmUuIEl0IGlzIHN1cHBvc2VkIHRv
IGJlICJpID09IDEiIG9ubHksIGJ1dA0KPj4gaXQgc2hvdWxkIGhhdmUgYmVlbiBpbiB0aGUgYmVs
b3cgcGF0Y2ggb253YXJkcywNCj4+DQo+PiAiW1BBVENIIG5ldC1uZXh0IDIvN10gbmV0OiBwaHk6
IG1pY3JvY2hpcF90MXM6IHVwZGF0ZSBuZXcgaW5pdGlhbA0KPj4gc2V0dGluZ3MgZm9yIExBTjg2
NVggUmV2LkIwIg0KPj4NCj4+IFRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0LiBXaWxsIGNvcnJl
Y3QgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IE90aGVyIHRo
YW4gdGhlIG1pbm9yIHByb2JsZW0gbm90ZWQgYWJvdmUsIHRoZSBwYXRjaHNldCBsb29rZWQgZ29v
ZCB0byBtZS4NClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4gSXRzIGJlZW4gYWxtb3N0IGEgd2Vl
ayBzaW5jZSBJIHBvc3RlZCB0aGlzIA0KcGF0Y2ggc2VyaWVzIGFuZCB0aGVyZSBhcmUgbm8gb3Ro
ZXIgY29tbWVudHMgZXhjZXB0IHRoaXMgb25lLiBTaGFsbCBJIA0KdXBkYXRlIHRoaXMgZml4IGFu
ZCBwb3N0IHRoZSBuZXh0IHZlcnNpb24gb2YgdGhpcyBwYXRjaCBzZXJpZXM/DQoNCkJlc3QgcmVn
YXJkcywNClBhcnRoaWJhbiBWDQo+IA0KDQo=

