Return-Path: <netdev+bounces-73886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5CD85F0D5
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 06:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43411284145
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 05:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF79A7483;
	Thu, 22 Feb 2024 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cGGE53z9";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="7YU+ZY/E"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B84C8A
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708579072; cv=fail; b=ASQlPxI/OfwjdmEWKfb8GEXJRZFv54eM64ejaTotLapTk7XWFmCkDCg1bXIRH7gtxFOFHhlfDN4ugnlwW4zdQqpVeGn3GM7Yd6tEqo7R4gCDuZYAQYNlMvuUGFwGAiSFN1FtKmjhtnhJBdSMgqkejPeNIkfsyAXcp0k2etxEESY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708579072; c=relaxed/simple;
	bh=VZO0AAzC+fMTjnLwt/ASnJrc9f/MZMwc2f9aT0KyLLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nCwrYguuhm+EuQqnXwJ2V/kG+WjGAtRWNooxnCvw75ciE3yfloCYtYuekCgIX6mzCKwPeGfsunyT+OyhB+8ghelRxCNy9xtsJrTnG9djBWcWwK3KOdaJ5yU26v+jQ39uM9BGpF6NKk6z/pSn69/JyEc0Bxa0yqpJxNrJ/t5nYQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cGGE53z9; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=7YU+ZY/E; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708579071; x=1740115071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VZO0AAzC+fMTjnLwt/ASnJrc9f/MZMwc2f9aT0KyLLE=;
  b=cGGE53z9Z6zcfUYjPGujhWmaE6/ooMWYs7Yy9gwf2PnPtMeZs5j7qigY
   vJ3KqBv3NaTN8UC5cF/ny3+3fLzacclN/KPmq4YIe+85qnf6d+HAlIXJG
   fvsQScLQMdkgHTwf8qVYcphQzjRVK3gCUh4Xz9VNZ5cVM/5LspcbjwJTa
   tx77Udf4gAeNnnry7/tV0wg/bztrNK4QNIzKUUF8LR8lhuKaomQ5JKRnl
   BQsil2QINqvz/W0xHQLfMSzUos/sEcHTmZNjmYjceOmagmT7nPH7M+SZC
   u7/4aVMszVIzpDp2iiZbenmAreKlTpbPKg224WuyTTmAxFgRfpdGOXyZq
   A==;
X-CSE-ConnectionGUID: YsDaq6+ARUSjzU4tc1gIpw==
X-CSE-MsgGUID: FwQvxjjITBK6mhX43H8+Ww==
X-IronPort-AV: E=Sophos;i="6.06,177,1705388400"; 
   d="scan'208";a="247383459"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2024 22:17:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 22:17:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 22:17:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdAEMo0LJC0g/M3AE8dL5HemHXc9cwLvInF+iJCRMhErnoXbNdwXyHNujGNlSQiXSXE8wtNQAZAGf1K/QQLLmZgcEtEcKokuKYhgF7Ns+lsQrXFSCS67RQcqGczRCsViLrwWCQCwUt32VxDDxwytUzYYf3JrV6xWwcr6cXJABEl+BMd6+PkcvmW6k/N4xl7I3OURFrdtArq5NJm/0oVNU19kipYOKooPghLI+nX40xb8JbtpPLAbkUg1ESgf/7W2i+boBTT3dkKeYvN8sD9Ica8FA++wbcgfOijcIyi/lQBXfNUMYS4GQvksC2DOGz/20h6zWLVorJNr+i/91zxRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZO0AAzC+fMTjnLwt/ASnJrc9f/MZMwc2f9aT0KyLLE=;
 b=R2L5J1Yye3QHm0MnNu6vetGomGvrToFD9CAIaLhnN4PeIAWsE/iqOfNhggrT5Ez8hJ/H21xWNGgOG8TAv+bOq+2ChTtHDJm8o3lkBkKis+mzgttPZ5cO9Pb9tp+30dpoarJ811jDD142g9P/rIOyoKzyYUqeA7fbJ9BsmhbzlZIToLaJOXRb12sAhOUiisyqwU7wOTjROC+2n6m+YUvkWEO45CwXTm21WMOQOzU+xYDZZr0N7XiHgWXAb4xdrLIJbqwGAEkI9qwjEjNxS4kmX8YVtXVMLEC6+BwZuHius8vU9gRtLvxeIxd4ulkU6sDw5MMd0NLizMs6NWBUtOqL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZO0AAzC+fMTjnLwt/ASnJrc9f/MZMwc2f9aT0KyLLE=;
 b=7YU+ZY/EEUNhK0Hq2+9U1Ib+maLKn4YCQ1AYkbu7x0DAI3uvPa0PE6TNmDmnVYw7qreQ5G60iw5CEDjw6DMe1eIoiI+Rwu7XzJpmOGJQQlQc0oNM/41sjYJFiicoQd2IZhghAFn7SsSL9MiMZgJWGKNbQJsH5fstKwHGyIzjXHGVWYD4DIqmVj7GXoGFswCh0CVmfHkBBuOC4LWjC3eO60rIh1QZfDArjLBRO5S2HXDOsXOPxr5ivl1kKNg282yvoWdUhV5zvjdyM+n3XRwlXyU5JOijjBTgkimldX4wgcmWdyec3DPHl4EhWS3lGC/5ghpMpgjOWMuiXY31viuwcg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 05:17:30 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::51c7:3b29:947a:9e39]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::51c7:3b29:947a:9e39%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 05:17:30 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Pier.Beruto@onsemi.com>, <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Selvamani.Rajagopal@onsemi.com>
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Topic: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Index: AQHaBcg0J9X87rlKy0y2G/CzXLB1SbEOPx6AgAPmdICAAE9bgIACiV0AgAB3HICAARvnAA==
Date: Thu, 22 Feb 2024 05:17:30 +0000
Message-ID: <874d171d-9ac2-4937-85cc-9c8e076cab44@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
 <5e85c427-2f36-44cc-b022-a55ec8c2d1bd@microchip.com>
 <e819bb00-f046-4f19-af83-2529f2141fa6@lunn.ch>
 <cbfbf3f6-45b7-4f40-bc05-d3e964e55cc7@microchip.com>
 <BY5PR02MB678696DBEF2A6A5F5E61A02F9D572@BY5PR02MB6786.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB678696DBEF2A6A5F5E61A02F9D572@BY5PR02MB6786.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|BL1PR11MB5525:EE_
x-ms-office365-filtering-correlation-id: ffc2f973-84e8-47a1-2a89-08dc3365918b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12JBUb4dVpo6eoLCo0cHGMg0FLBpBfak/PHbsgrEK/kFHygJ8f8J2ap6Ry1IN5gHfjxL1l2HEldOKJXaeEndKYmQ7zx+Mb+zr5VRfUy4ENlYFOj8NS/Bv+SInNtvEnie/aOkxOgGTSTfq6T4KmMVRwAA2e321DOlhz/YdBSHwIU7zssMglwnG4xbcD7hE4UcGEUxqbwMzd7GsoU83Hs5RxQDcK9OV5SsbB4cPTE+yRrX6pTBCPljOtCxMq++hSL6m6BsfXghPceLVPG8IL8v9/OrbGMT5OBQKH4faydqrRgUmiN4rr6SFXGHz8RZ/GWbmJlQDR0fTfSfruk3n8W30YvvUYiQd9I9HIP2bGBxf6bZRBbhba6NnnCJdXunH7UREr77d2bVy5lrMuhjLhAVDPnMB7ryWEdbCwKiv6jqIoz0Yliq0X7x1X6Fk5pv9uTlbiTtQZpzWkJPPOz1o1a+Haevdt73pZhDK/TA66tSfmaGkn32xo/Fu8FjYPrxaGCjQZNsXbHvtPus9Rk7ubq1M54jzNKGQOAGKXKajoMBWplutchNVAGGSosGIkPsLEcE6L+6vZdjfQZrUhrRI/lgqHmF1M5uHg5NshPO2EJcGgqhKyDO/5yKGL3K+V8Qx2iF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnZGMGFla2tVV1pwMERXSmgzLzdla1BMdS9ZRGlZNWtBQ2o3MG02UWdIMngy?=
 =?utf-8?B?ZGZ6SUpMQk8yeVJoZ0dPNTdLRUZLNnRzNGs3STdpc0NSMGZ1aS9meU9aQ2dM?=
 =?utf-8?B?REJmK0t4N1B0S2lVLzZ5alRnU242SHNvcG1adHlwTEdXbDBRNFRJOUNEcTZ2?=
 =?utf-8?B?K2gzaC9QNnpML0VKdEJGcjl6ekxJTTdmV1FsMDlEZzVnUEtlbEdJZVIveE9K?=
 =?utf-8?B?cXFaR1hJWkoyVTYxR3NvcjU4VUFrVWRDUmFKUUk5c0o3RlpGcmZQdUtZYzJp?=
 =?utf-8?B?c09kVkZ2WFNreGFZK0o4M1plL3l6WHNSY091VmYxeENzZFB4REVnS0V5bnNs?=
 =?utf-8?B?Rkt1U0VZRGJwMXY2SmxBM3BjS3FyVWNUY3RDUU1iSWJXTEg0dUJNMUZKNkh4?=
 =?utf-8?B?OFZ1VmZuZ3k2YTlVUzZWdzFlUU13YTZxMmRjZExvRENyZGNJa0lZc1ZHNDBJ?=
 =?utf-8?B?UzgvSEtBdVF6N3M2OHVJUDcySHoxcUVkZkxCQWZKOWpRelUxK1lnaTVpRXZI?=
 =?utf-8?B?MloyeEE2T3lDUTAzYUpVZ1Y1ZlBqciszMTlDSml0YVFsMGJObjQ1MDQ3aVFG?=
 =?utf-8?B?cmU1RUcvdy9Db1lXaWNNYWF6OFZQMUZ1blJ1TCt3a3FBUm8rV0toZSsyT0g3?=
 =?utf-8?B?OEZrWU5Nb1VrdXRSSXRhcDBsQzR6Wi84b0R1Nk10SlJmVElJa1U0Vi9jWnpP?=
 =?utf-8?B?WTNzaGhSZUFUdnVQbWk1aDZhVFNZb3U0Wjk4dG5TRFdWMHZ6Z0NvTGw4N3V6?=
 =?utf-8?B?TVFDWTBoMWI0TjVjWHJGdE4wZHNMZmQzQTVyN1RrV0dxTVBNMHpkbE5LWG8z?=
 =?utf-8?B?cHAweGJzRUJ4REtkeXgzNTZ1ZGoya21SK3hNcStWcVBFVVRwSFgwQ3VtdWdv?=
 =?utf-8?B?WnVxRjdxVXdjaEIxM2Z5cm8vSVNodk03aEQ3RElBbnBOV2ZvWW5lV2FXR3U2?=
 =?utf-8?B?SVdpeUJrYnFZd0p1RWVWTFVDWDBobHhlVjN0NVVJd1Q0d1RCMWtITTlyQVgr?=
 =?utf-8?B?TDF6azd2S1Bsa2swRVZieTlzMkF1blJoZTBJcVdLODlKM3RZZkJuNDhXWWlQ?=
 =?utf-8?B?V0ZqWlpadkpMb0gzUUM5QWd2SVovTU9lMXMrOG83Z00vRUZPUG1KaEVrMXUz?=
 =?utf-8?B?NkdoRUx2V1EvZkxqUHZlQyt1VUVFTXlyUmJwc2pYaXFsbytpNWVJd3NTT3lY?=
 =?utf-8?B?NVZSS0tnNGtuOW9zYUMwYWFlaXVyUHZaUVlnaTRLNVlrTnRBSzhYaHdJZWh3?=
 =?utf-8?B?cDI5bnNqU0xzN0FUdkJqQjl4VFlENkZ6VEkvSGo4OUlFWjA4YzQ3TFdMRTJx?=
 =?utf-8?B?bTFFWUlkME43bVlzYVdZMFhUVWFCYUhzM2I5MmlNaTBWWnh3cGdRYktnWm5E?=
 =?utf-8?B?Z1BQanVsblp4N013c2NIR0tGTHhjUjJYKzVza0Exdmk5UzZJTnllVHFBNkI4?=
 =?utf-8?B?TS96ZllkN0tseWlLZlRuT0VEVUQyYVp3MWNLRjlWYXpGUUd6VTRjbzYyYzhO?=
 =?utf-8?B?ZDR6OVhtOGhLSkdhZG5MNWxJMVVOZEZLZHNkczB3dUFpZGtKbHluNnpISnhV?=
 =?utf-8?B?WmozWVBHbk83RHNkM1daMEtaYnVaVEJJU1B0SXVRbVRid0ljUk00dU9UNHhI?=
 =?utf-8?B?aDJmcTdHakNqMkhabDBIRVhmMUhZcDNuV1NhUjdNVFAyOEhtTGxEamlGRjZ2?=
 =?utf-8?B?YUtqdzYweVE0LzJCK1FHU0tvYXZsM0FUSk1lTnJnNE41RmxUZnQ2Z0dubEF2?=
 =?utf-8?B?dmdMc0lOaVRSL1RzOU1Ib3lvTXVyNkY2R1NJalpkVTd0Y21mNEU3TlcxZUpv?=
 =?utf-8?B?R1pTTVdMcUx3ZENqRHBDUXVTZHowM205SHhRK0JHdC84b1c4bk1qb21EZFUw?=
 =?utf-8?B?NHFrTUZmd2wyNmpDbHY3T0NPRWtQNVg3ekkyUms4bWo1Z3hTV1hHNElIK3BI?=
 =?utf-8?B?QitVWG9tVFpxNUNrOG5zbnFPVGNPM1RITngvNHJhTEdWYUY4NjFxWCtQZ1c4?=
 =?utf-8?B?YURNR2R2QmFIWEJSTDBxTnArb0VPaEJyT0JJbVdoa1VWR2dzalhqQ0ZtTzkz?=
 =?utf-8?B?SHlXZXlqQkcxajRmaHRENTBuS1kxVUwyUFlGcmVNSG1XaENNVjgzcS96dUhC?=
 =?utf-8?B?cjliWDlGMDJEVzIrM1BBYjRXSEJNeHdxUnNXU0NKcERQYkhobzFFT1hUbmJl?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD9350A10860D04593EB9012998AEDD9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc2f973-84e8-47a1-2a89-08dc3365918b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 05:17:30.5713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAmTaHfkDbWr3VYN3OQdi+41wxBEyjLBq+xXrGI4soEyfNU7I9XBFNNAWEHasBWTDDPwqO2V/lyWUiD8dF9aSxRN/qTnugfiPuLp/+a0CrnnuF6U6ssTig3aJ05BYMNY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5525

T24gMjEvMDIvMjQgNTo1MSBwbSwgUGllcmdpb3JnaW8gQmVydXRvIHdyb3RlOg0KPiBbU29tZSBw
ZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJv
bSBwaWVyLmJlcnV0b0BvbnNlbWkuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQg
aHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgYWxsLA0KPiB0aGFuayB5
b3UgZm9yIHRoaXMgZGlzY3Vzc2lvbi4NCj4gDQo+IFNpbmNlIHRoaXMgZnJhbWV3b3JrIGlzIHN1
cHBvc2VkIHRvIGJlIGEgYmFzZSBmb3IgZXZlcnkgcG90ZW50aWFsIE9BLVRDNiBNQUNQSFkgaW1w
bGVtZW50YXRpb24sIEkgcHJvcG9zZSB0aGlzIGNvdWxkIGJlIGEgam9pbnQgd29yay4NCj4gU2Vs
dmFtYW5pIGFuZCBJIHNwb3R0ZWQgc29tZSBwb2ludHMgaW4gdGhlIGNvZGUgd2hlcmUgd2UgY291
bGQgb3B0aW1pemUgdGhlIHBlcmZvcm1hbmNlIGFuZCB3ZSB3b3VsZCBsaWtlIHRvIGFkZCB0aGUg
cmVxdWlyZWQgY2hhbmdlcyB0byBhY2NvbW1vZGF0ZSBhbGwgcG90ZW50aWFsIGltcGxlbWVudGF0
aW9ucy4NCj4gDQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIHNoYXJlIHdpdGggdGhlIGdyb3Vw
IHRoZSBsYXRlc3QgcGF0Y2hlcz8NCg0KSGkgUGllcmdpb3JnaW8sDQoNCkdvb2QgdG8gaGVhciEg
WWVzIEkgYWdyZWUgd2l0aCB5b3UsIGxldCdzIHdvcmsgdG9nZXRoZXIuIFdlIHJlYWxseSANCmFw
cHJlY2lhdGUgeW91ciBlZmZvcnRzIG9uIHRoaXMuDQoNCkFzIEkgYWxyZWFkeSByZXBsaWVkIHRv
IEFuZHJldywgd2UgdG9vIGRpZCBzb21lIGltcGxlbWVudGF0aW9uIGNoYW5nZXMgDQpwcm9wb3Nl
ZCBieSBvdXIgaW50ZXJuYWwgcmV2aWV3ZXJzIHRvIG9wdGltaXplIHRoZSBwZXJmb3JtYW5jZSBh
bmQgDQppbXByb3ZlIHRoZSBjb2RlIHF1YWxpdHkuIEFsc28gd2UgYXJlIGluIHRoZSBmaW5hbCBz
dGFnZSBvZiB0aGUgaW50ZXJuYWwgDQpyZXZpZXcgYW5kIHRvIGF2b2lkIHVubmVjZXNzYXJ5IGNv
bmZ1c2lvbnMgYmV0d2VlbiB0aGUgdmVyc2lvbnMgd2UgZG9uJ3QgDQpyZWNvbW1lbmQgdG8gc2hh
cmUgYW4gaW50ZXJtZWRpYXRlIHZlcnNpb24uIERlZmluaXRlbHkgdGhlIG5leHQgdmVyc2lvbiAN
Cih2MykgaXMgZ29pbmcgdG8gaGl0IHRoZSBtYWlubGluZSBpbiB0aGUgbmV4dCBjb3VwbGUgb2Yg
ZGF5cyBzbyB0aGF0IHlvdSANCmNhbiBnaXZlIHlvdXIgY29tbWVudHMuIE15IHRlYW0gd2l0aCBv
dXIgaW50ZXJuYWwgcmV2aWV3ZXJzIGFyZSANCmV4dHJlbWVseSB3b3JraW5nIGhhcmQgdG8gbWFr
ZSBpdCBoYXBwZW4uDQoNClRoYW5rcyBmb3IgeW91ciBwYXRpZW5jZS4NCg0KQmVzdCByZWdhcmRz
LA0KUGFydGhpYmFuIFYNCj4gDQo+IFRoYW5rcywNCj4gUGllcmdpb3JnaW8NCj4gDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNy
b2NoaXAuY29tIDxQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4gU2VudDog
MjEgRmVicnVhcnksIDIwMjQgMDY6MTUNCj4gVG86IGFuZHJld0BsdW5uLmNoDQo+IENjOiBkYXZl
bUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBh
YmVuaUByZWRoYXQuY29tOyBTdGVlbi5IZWdlbHVuZEBtaWNyb2NoaXAuY29tOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBIb3JhdGl1LlZ1bHR1ckBtaWNyb2NoaXAuY29tOyBXb29qdW5nLkh1aEBt
aWNyb2NoaXAuY29tOyBOaWNvbGFzLkZlcnJlQG1pY3JvY2hpcC5jb207IFVOR0xpbnV4RHJpdmVy
QG1pY3JvY2hpcC5jb207IFRob3JzdGVuLkt1bW1lcm1laHJAbWljcm9jaGlwLmNvbTsgUGllcmdp
b3JnaW8gQmVydXRvIDxQaWVyLkJlcnV0b0BvbnNlbWkuY29tPjsgU2VsdmFtYW5pIFJhamFnb3Bh
bCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IG5ldC1uZXh0IHYyIDAvOV0gQWRkIHN1cHBvcnQgZm9yIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQx
eCBNQUNQSFkgU2VyaWFsIEludGVyZmFjZQ0KPiANCj4gW0V4dGVybmFsIEVtYWlsXTogVGhpcyBl
bWFpbCBhcnJpdmVkIGZyb20gYW4gZXh0ZXJuYWwgc291cmNlIC0gUGxlYXNlIGV4ZXJjaXNlIGNh
dXRpb24gd2hlbiBvcGVuaW5nIGFueSBhdHRhY2htZW50cyBvciBjbGlja2luZyBvbiBsaW5rcy4N
Cj4gDQo+IE9uIDE5LzAyLzI0IDg6MDAgcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdw0KPj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4NCj4+PiBIaSBBbmRyZXcsDQo+Pj4N
Cj4+PiAgICBGcm9tIE1pY3JvY2hpcCBzaWRlLCB3ZSBoYXZlbid0IHN0b3BwZWQvcG9zdHBvbmVk
IHRoaXMgZnJhbWV3b3JrDQo+Pj4gZGV2ZWxvcG1lbnQuIFdlIGFyZSBhbHJlYWR5IHdvcmtpbmcg
b24gaXQuIEl0IGlzIGluIHRoZSBmaW5hbCBzdGFnZSBub3cuDQo+Pj4gV2UgYXJlIGRvaW5nIGlu
dGVybmFsIHJldmlld3MgcmlnaHQgbm93IGFuZCB3ZSBleHBlY3QgdGhhdCBpbiAzIHdlZWtzDQo+
Pj4gdGltZSBmcmFtZSBpbiB0aGUgbWFpbmxpbmUgYWdhaW4uIFdlIHdpbGwgc2VuZCBhIG5ldyB2
ZXJzaW9uICh2Mykgb2YNCj4+PiB0aGlzIHBhdGNoIHNlcmllcyBzb29uLg0KPj4NCj4+IEhpIFBh
cnRoaWJhbg0KPj4NCj4+IEl0IGlzIGdvb2QgdG8gaGVyZSB5b3UgYXJlIHN0aWxsIHdvcmtpbmcg
b24gaXQuDQo+Pg0KPj4gQSBoYXZlIGEgZmV3IGNvbW1lbnRzIGFib3V0IGhvdyBMaW51eCBtYWlu
bGluZSB3b3Jrcy4gSXQgdGVuZHMgdG8gYmUNCj4+IHZlcnkgaXRlcmF0aXZlLiBDeWNsZXMgdGVu
ZCB0byBiZSBmYXN0LiBZb3Ugd2lsbCBwcm9iYWJseSBnZXQgcmV2aWV3DQo+PiBjb21tZW50cyB3
aXRoaW4gYSBjb3VwbGUgb2YgZGF5cyBvZiBwb3N0aW5nIGNvZGUuIFlvdSBvZnRlbiBzZWUNCj4+
IGRldmVsb3BlcnMgcG9zdGluZyBhIG5ldyB2ZXJzaW9uIHdpdGhpbiBhIGZldyBkYXlzLCBtYXli
ZSBhIHdlZWsuIElmDQo+PiByZXZpZXdlcnMgaGF2ZSBhc2tlZCBmb3IgbGFyZ2UgY2hhbmdlcywg
aXQgY2FuIHRha2UgbG9uZ2VyLCBidXQNCj4+IGdlbmVyYWwsIHRoZSBjeWNsZXMgYXJlIHNob3J0
Lg0KPj4NCj4+IFdoZW4geW91IHNheSB5b3UgbmVlZCB0aHJlZSB3ZWVrcyBmb3IgaW50ZXJuYWwg
cmV2aWV3LCB0aGF0IHRvIG1lDQo+PiBzZWVtcyB2ZXJ5IHNsb3cuIElzIGl0IHNvIGhhcmQgdG8g
Z2V0IGFjY2VzcyB0byBpbnRlcm5hbCByZXZpZXdlcnM/IERvDQo+PiB5b3UgaGF2ZSBhIHZlcnkg
Zm9ybWFsIHJldmlldyBwcm9jZXNzPyBNb3JlIHdhdGVyZmFsbCB0aGFuIGl0ZXJhdGl2ZQ0KPj4g
ZGV2ZWxvcG1lbnQ/IEkgd291bGQgc3VnZ2VzdCB5b3UgdHJ5IHRvIGtlZXAgeW91ciBpbnRlcm5h
bCByZXZpZXdzDQo+PiBmYXN0IGFuZCBsb3cgb3ZlcmhlYWQsIGJlY2F1c2UgeW91IHdpbGwgYmUg
ZG9pbmcgaXQgbG90cyBvZiB0aW1lcyBhcw0KPj4gd2UgaXRlcmF0ZSB0aGUgZnJhbWV3b3JrLg0K
PiANCj4gSGkgQW5kcmV3LA0KPiANCj4gV2UgdW5kZXJzdGFuZCB5b3VyIGNvbmNlcm4uIFdlIGFy
ZSB3b3JraW5nIG9uIHRoaXMgdGFzayB3aXRoIGZ1bGwgZm9jdXMuDQo+IEluaXRpYWxseSB0aGVy
ZSB3ZXJlIHNvbWUgaW1wbGVtZW50YXRpb24gY2hhbmdlIHByb3Bvc2FsIGZyb20gb3VyIGludGVy
bmFsIHJldmlld2VycyB0byBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBhbmQgY29kZSBxdWFsaXR5
Lg0KPiBDb25zZXF1ZW50bHkgdGhlIHRlc3Rpbmcgb2YgdGhlIG5ldyBpbXBsZW1lbnRhdGlvbiB0
b29rIHNvbWUgd2hpbGUgdG8gYnJpbmcgaXQgdG8gYSBnb29kIHNoYXBlLg0KPiANCj4gT3VyIGlu
dGVybmFsIHJldmlld2VycyBTdGVlbiBIZWdlbHVuZCBhbmQgSG9yYXRpdSBWdWx0dXIgYXJlIGFj
dGl2ZWx5IHBhcnRpY2lwYXRpbmcgaW4gcmV2aWV3aW5nIG15IHBhdGNoZXMuIEkgYWxyZWFkeSBo
YXZlIHRhbGtlZCB0byB0aGVtIGFuZCB3ZSBhcmUgaW4gcHJvZ3Jlc3MgdG9nZXRoZXIgdG8gZ2V0
IHRoZSBuZXh0IHZlcnNpb24gcmVhZHkgZm9yIHRoZSBzdWJtaXNzaW9uLiBXZSBhcmUgdHJ5aW5n
IG91ciBsZXZlbCBiZXN0IGFuZCB3b3JraW5nIGhhcmQgdG8gcHVzaCB0aGUgbmV4dCBzZXQgb2Yg
cGF0Y2hlcyB0byB0aGUgbWFpbmxpbmUgYXMgc29vbiBhcyBwb3NzaWJsZS4NCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gUGFydGhpYmFuIFYNCj4+DQo+PiAgICAgICAgICAgQW5kcmV3DQo+Pg0KPiAN
Cg0K

