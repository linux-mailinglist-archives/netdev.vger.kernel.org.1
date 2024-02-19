Return-Path: <netdev+bounces-72865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0191E85A01D
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD635281C42
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253EC24A09;
	Mon, 19 Feb 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wRDFossV";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kAJBqEpy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6B24A19
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336050; cv=fail; b=SzTfi2+3U6fy2/8NK+yRmHkx2Nn8BC9E2otkrHtXoL1oLv4dA4E0KdGZL17CwY7RnbuBtWUYPmvT1C+gE/Gb0R2iaiZ8Y9X+0EFA/PZx9p4Ga15fm8sJ0b0CMJOLF5X0jAPrekwDAZmGsHoIvutQZTceHu/e3Zq0JokwgvYqgpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336050; c=relaxed/simple;
	bh=yXVAz0Z6CRrJAnkUpLRf6IzQ1/ZwL0pL+ya4LJhwNxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GVyfK4UWtR64PhgkiB94d9OyNzQBHxPR6EpRfwWmRctJoZ6ocP4CNjlBoYehNUYNHk/QirsSYknSDb/kN0CNCsrtvRF5xSiuyde4EBPKksci/uU6M/cWzNsjyANDV/TfX2gg8ALQgF34t2GhKBkBjxKw1khPkHcjqF0+MEmRFTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wRDFossV; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kAJBqEpy; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708336048; x=1739872048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yXVAz0Z6CRrJAnkUpLRf6IzQ1/ZwL0pL+ya4LJhwNxk=;
  b=wRDFossVbxe01QdfLrViyJjxcdgTevpWbzGixhbx1NPTFN9369+57+LO
   F7ZsLCQ0rJOgRN0b4rgkxfZo0TrH4WjjIvfJv2wnPUx5Di+twmkCyFyy3
   Id4JaedXVBEMIJPXADaSV72UCvnpZKJ5hd9loDmorCt2+acpe+OcQgMGu
   UZcpca57/NOJTHSkAe8kE+PVaG9kJhRLRpbx4yHvzWh3dGJImNMTwoA7g
   GeJ18dGRyINM1N8aaMhb7MEZMDGK+Yi2nRCCGVAjwKCZkjEtoFHxiWHtG
   yS+kIDr1TN+uUlVLUsC3vauv3cFP18tKv9DgmJSjQWROzWQNEc8HuxM8j
   A==;
X-CSE-ConnectionGUID: gz7FyEQhS8GzErmIwxHN7g==
X-CSE-MsgGUID: 9r/nbzBCS4a1yeGfZlFD+g==
X-IronPort-AV: E=Sophos;i="6.06,170,1705388400"; 
   d="scan'208";a="247201337"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Feb 2024 02:47:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 02:46:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 02:46:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs7XXS5vN1PVrJ24ASiQtiIR5mlF9YwPtpBl5Vd2JZAByOOxkL+VvS65N6UNAJX8fFHZCG5RmbWS9LDRwdxlfaAWppfHR8D3zbdyiHwdN0orj36MXnh3Ku6L+ziys9jDQgnGt9AU+lze0FS9V/zJ1U62ekQBHqaYceUJ2+OjAbuOd2/FDuOG0fb0sD11m52/OzNba9qdCiGo5xg0NnEe49PeVyv+WQpFDfIt5+vP3tvcSfHKHUFc+i3UoiQIfGS7yY/ShXBXDnuI8d29OulquwHtxlNuh804bLF3EaSBAA/CFu4h1F1O/vUiYXheBBsogQz6rCJIzPmfJtav2S/Kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXVAz0Z6CRrJAnkUpLRf6IzQ1/ZwL0pL+ya4LJhwNxk=;
 b=j0xb9LNM/DwAKiGBUBhmcjRHRo9wG0UJ4novUnY6Uhg+QQeFE5jN9MLvCdqUvhA81RLcin0HSdTolIcklLzgdaPo04rBFPOTE6aPUTMPxUpmmkzXDs3h0s+0Drn/32GPUVLHW+dGrxYDS2THwsBFdibrXc4HJJCffqnj9RyWxsjabdr1GX24cNz9a50oVOWzRyv1d9i80k2TMwMs4oFm+c2BZEIdCwxeVe2BqWabpx+9SEBzKkSR4VUeVvkZPOjwpjHmqZtOW51O0BATp3X3W+tws3T38urUxy5FBlio4vZIkA5e9MFnSXOkia7/P1KGhDQNThC8HRoG2YxHuMM8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXVAz0Z6CRrJAnkUpLRf6IzQ1/ZwL0pL+ya4LJhwNxk=;
 b=kAJBqEpy2M11OmY1gy7gRgad+wSfV18JjqEkoEgSRC0Trq80ldQKsPWneSgrRHkwAqQchpZ9e1sBwhtSu4jeZ7/iGggTEIs2DWL4mEGX8CyDKmpol4TGV2xiOlQ1l6ZrDQhkCSATNz3Qk2+PxNYbPiZ3oCurmlBmIKqajJ3AgGjSI80vYk013TO3pupltVMRlnl9x1r6b31i99VbJpPRyLpxhpz0IcPJMJcr6OqwM/FdBY/I96AYswPDq4pN7HcDhSNY1w1G/dIfy0IgusK+1k3h+82KiohJ2DaCmWuU88gl60hZzodP5PpdX4h43CVcE8yErS2TL5/qDYevu+vixA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 09:46:54 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::51c7:3b29:947a:9e39]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::51c7:3b29:947a:9e39%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 09:46:54 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Topic: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Index: AQHaBcg0J9X87rlKy0y2G/CzXLB1SbEOPx6AgAPmdIA=
Date: Mon, 19 Feb 2024 09:46:54 +0000
Message-ID: <5e85c427-2f36-44cc-b022-a55ec8c2d1bd@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
In-Reply-To: <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA1PR11MB8541:EE_
x-ms-office365-filtering-correlation-id: 044c5888-87dc-49cb-b897-08dc312fb4a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0K4fRG26I/eA3TxWMYKMM80N8hSeDUtvohQB2zk2veTfr3+nl3YXcjKlOvxRph+cG19xpfJYgn7APHVgNnD6y/kXNiOn8rUu2rbFh8C63NbnFAYvAVyGJ95XhM6dfj2Y+7QV3B5AUHXT5Jdgk5JHp1daAJw9RspfMz+d9Z8jBxJsrDTLo6RJJmXFkFqKcW/V6yhVyt2n6YbWtsjc8MCv2PC4xk1i8DJ5XEOVwUl5+7xM9TNe0iwVKS7kqa4jsbvlU0V0NpG8/oZnzsa50nmQ7gpPSeLZl8pA5MPZsheEIaSHqYWAo4gdUmnKqsRympu1Ko2wasrwn+PwB1WjIZsbmIqNnuKWCgCF8VmM1ex0EdARoAkB/mBD45DHcqQxFA1EcBZvYSnI0KJxwlcKOUAoEpYvNwsGsSeNWZqYO2dESLSslyw/fif2pUkv2zXU25cW7VKtHXqmRGcbl/PcdZaZFfMb5GxnDi3XJCkOX9W1/npdyzrpNWncvKThxDM+FVB5WuSMQ6E6IfBFfkoujwbZEUx2ve1KlKPlnSSvWlvuoZZbSSt/bgi8qBikaGtKPM0RsoebMVVAEJVGFFC/W1WVRfmwNeIckchQHHEoE2rT3leMO+b7dTATzThaJFaKd4Qf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(54906003)(71200400001)(316002)(31686004)(5660300002)(2906002)(4326008)(6916009)(66946007)(66556008)(91956017)(64756008)(66446008)(66476007)(8936002)(76116006)(8676002)(86362001)(31696002)(41300700001)(6486002)(6512007)(38070700009)(36756003)(2616005)(26005)(53546011)(6506007)(478600001)(122000001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlIrNEJTWjFYaDRZZzFjMmd4N3luUjZsSzV3R0MwbG5kTk9yNG0xSnlWUGZL?=
 =?utf-8?B?cDNKNTVjUmdxM3lLb0pYcFAvZnVtTkJvSTRuRG5HVTZsUnc4WUMxc3RCZWUx?=
 =?utf-8?B?L3hSYmRyVGswTkw3b3JsTWZsKzVLTkFGS0svQ2RSMHRIR1RlSkZ0RkNod3Zp?=
 =?utf-8?B?bHVjODhtSDVUaksydDZORkY2SEhpd0JMMjM3SmZDV21KeXhieUg5UUN5TkdR?=
 =?utf-8?B?NDUwS3o1ZmFycWpCOU1JS2xZbFJqS0MzMXlaOFB5VkI2dnlELzIrcXBHT08y?=
 =?utf-8?B?aTJoWGg2QXIxekpPdXFwUWZlNm9nM2NZNWhHa3h5R25hbWI5YWhZMzRIUFhi?=
 =?utf-8?B?ZEFZSHY3aVhZK0ZjUXRHbnQzUjh2WTlRcDZYbTVTOG5YOVVJeGEwaW14djcv?=
 =?utf-8?B?UkhiR0tmcldhNWZja2pGU1BjcWNNS3o2UUJHQ2g1dVZmdWVvTTVWUmw5d0E1?=
 =?utf-8?B?TFJQY1JNMU00cXVwY0pnSkluclJuejVtT05qZldFQmg2MVNVNXVoUUYzLytZ?=
 =?utf-8?B?cWF2MTlsWm0rcDZYME9lYXJ0UzAzV2l1UDMxa21pZHJWbTdMMTRvRUVlYkVF?=
 =?utf-8?B?c3YyWEtzd0NWKy94YTZYZzdqRkVpdzhlSms1ZHh1SmxFK1NYZ0l5UFNEV0lL?=
 =?utf-8?B?eDV0TFRNYXYyQkZpT2F3eFA3dzYvTVlHTEV2d0tXdHNyZmhWc3J0YnJ5ZjV4?=
 =?utf-8?B?V1I3eHRzZTV2T2R5WVpBYkRndzR5NzQxbzM3czhGNnhDVjJTOWszbml0eTlJ?=
 =?utf-8?B?L3JlUitkaXBFUE04YW5McjRpd1ZNaEgybWp3dnBWcVFwdGpESytHdFhjaXlx?=
 =?utf-8?B?eFQzVUk2SmZhQmg0STVVdTJ4YTZXRXlZTFU4ZWI4SS9mQWdDZTZjN1Zjc3B0?=
 =?utf-8?B?RVdNOGM0MUJETmhXUXpBUTJMZTBpRk5zYy9ZUFIwS3pJeWJHMFZ0NkU0cUVF?=
 =?utf-8?B?L0k0d0Z5ZDd4cy9xT09IeVhST1dOVTJUSHIvVEl0RUkzMEZXdnZUTjF6dnhh?=
 =?utf-8?B?NUtlcmVIdWJhbmRLOER6OS9PcjlZMS9NQTJ3ay81SjE0NjRFcEJFZVhsdkRK?=
 =?utf-8?B?Sm11eitaT0pjRFQyYXZQeGNOYjlHZkVaRXo1ejJWYmJSZ011WUc5dUhDdXc0?=
 =?utf-8?B?MEtWU3h5eTZGRVdMWHYwSUVMZEhEYW5Wbk1DZVRCd2VPZ1Y4ZFgwRXUzbWlE?=
 =?utf-8?B?VklHcnZabTY3NEpaQ3dLaEhwdVJGeERPU1NQamJMREZ1UGpqMWl1VjNGQ0Jk?=
 =?utf-8?B?OFRtMENMNDMrZmU3bjBxRW1nRzlub05WUkcvckFRZlR4RGc1T2RpRE9kam9i?=
 =?utf-8?B?ZFdaaDNrV3lOQ1VBcDlsdmU5eWkyL25kaHZBWXdyT3NVbFZYbkZiK1JOQ3hR?=
 =?utf-8?B?dk5wOVVIMDExTUpGVy9TOGNsa0daZE9pZVV1aEFCWVNoMER1V0wrTFpHQ3pu?=
 =?utf-8?B?Y0ZaOGttTlVtS2xLVHRGRng2OVRkenJ1cTVYV2hLYmgxUk84Nmg4LzVhYXMw?=
 =?utf-8?B?SUZPMWVZRzNRbjdjN3hpb05QazBwVDR4czQzVlRrRnlHdzhsRGJ0a1ZuK0Rr?=
 =?utf-8?B?czY4VTlQSjJpNEZ5dkxMbWxHRk9QTEtrNHlaQUtOclo1eXFOZnFYM1hUN0Mv?=
 =?utf-8?B?bFpvMjBSaDdmMTZVWjBGcXRLY25oMnp1OHc4T3N3ekcwMjNJRGM4ZVgvSHRF?=
 =?utf-8?B?OWdaMmw3cU42L21tMDQzZUJNWmd6N1ZKL3dsTzhFcG1PSHdDTDNrYkFFamUw?=
 =?utf-8?B?eVVpdTZtMTJ2dGFDaHNtZmZmNHVweWpzZmQvSlV3MDNVSkZFKzd6NFRtU05s?=
 =?utf-8?B?Q3E4YzJSdE5lUlR2ZUFmZ2ZmaGdySXN6N3F3NkRGckVpU1VaRTZkMHMvQ3ln?=
 =?utf-8?B?bXloWUZBbHgzYkNYUWhlQ25nSU16RXJJTm9aaDNMNjFTR1ZTMkpZZHhDMVdB?=
 =?utf-8?B?SXF0UzRFNWZjTlF4SFdadk1nM2NNa2VqMUJpeHIzNC9Ic1RkNDNWaTF0R21J?=
 =?utf-8?B?OHRLUVZieFlQTlZDeHVtbVQzdGNMSDc0aXFaaElZYlJidUIwWWFiZlFocm9P?=
 =?utf-8?B?Q09LZ1lLZ21vZnI0ZWg5V1g5WXJUNVZTSUtqb2Vna3lSa29IWWZDYi8vNGxJ?=
 =?utf-8?B?TzdJUEFtNTNnc3JkOGR6Z3dXNGRSOWVDRWxyOWVmUWhxU3picEJWMkVLc0My?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B068A8CF8EC473419E538865F7A3A20F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044c5888-87dc-49cb-b897-08dc312fb4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 09:46:54.3486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myFSao4xtVm8/sWeDfuujStQpPup9Tok/7JlvYeo7/QgDp8LT6aBKLQS40K9Vzz5/Te/3Cb/Vi57aeBvapiTK1BibjmBzc0mB16ZINMQcn1QbMEBXjJLijKAfd8sCL9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541

T24gMTcvMDIvMjQgMzo0MyBhbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBPY3QgMjMsIDIwMjMgYXQgMDk6MTY6
NDBQTSArMDUzMCwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBz
ZXJpZXMgY29udGFpbiB0aGUgYmVsb3cgdXBkYXRlcywNCj4+IC0gQWRkcyBzdXBwb3J0IGZvciBP
UEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UgaW4gdGhlDQo+
PiAgICBuZXQvZXRoZXJuZXQvb2FfdGM2LmMuDQo+PiAtIEFkZHMgZHJpdmVyIHN1cHBvcnQgZm9y
IE1pY3JvY2hpcCBMQU44NjUwLzEgUmV2LkIwIDEwQkFTRS1UMVMgTUFDUEhZDQo+PiAgICBFdGhl
cm5ldCBkcml2ZXIgaW4gdGhlIG5ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC5jLg0KPiAN
Cj4gSGkgUGFydGhpYmFuDQo+IA0KPiBPbXNlbWkgYWxzbyBoYXZlIGEgVEM2IGRldmljZSwgd2hp
Y2ggc2hvdWxkIHVzZSB0aGlzIGZyYW1ld29yay4gVGhleQ0KPiB3b3VsZCBsaWtlIHRvIG1ha2Ug
cHJvZ3Jlc3MgZ2V0dGluZyB0aGVpciBkZXZpY2Ugc3VwcG9ydGVkIGluDQo+IG1haW5saW5lLg0K
PiANCj4gV2hhdCBpcyBoYXBwZW5pbmcgd2l0aCB0aGlzIHBhdGNoc2V0PyBJdHMgYmVlbiBhIGZl
dyBtb250aHMgc2luY2UgeW91DQo+IHBvc3RlZCB0aGlzLiBXaWxsIHRoZXJlIGJlIGEgbmV3IHZl
cnNpb24gc29vbj8gSGFzIE1pY3JvY2hpcCBzdG9wcGVkDQo+IGRldmVsb3BtZW50PyBQb3N0cG9u
ZWQgaXQgYmVjYXVzZSBvZiBvdGhlciBwcmlvcml0aWVzIGV0Yz8NCkhpIEFuZHJldywNCg0KIEZy
b20gTWljcm9jaGlwIHNpZGUsIHdlIGhhdmVuJ3Qgc3RvcHBlZC9wb3N0cG9uZWQgdGhpcyBmcmFt
ZXdvcmsgDQpkZXZlbG9wbWVudC4gV2UgYXJlIGFscmVhZHkgd29ya2luZyBvbiBpdC4gSXQgaXMg
aW4gdGhlIGZpbmFsIHN0YWdlIG5vdy4gDQpXZSBhcmUgZG9pbmcgaW50ZXJuYWwgcmV2aWV3cyBy
aWdodCBub3cgYW5kIHdlIGV4cGVjdCB0aGF0IGluIDMgd2Vla3MgDQp0aW1lIGZyYW1lIGluIHRo
ZSBtYWlubGluZSBhZ2Fpbi4gV2Ugd2lsbCBzZW5kIGEgbmV3IHZlcnNpb24gKHYzKSBvZiANCnRo
aXMgcGF0Y2ggc2VyaWVzIHNvb24uDQoNClRoYW5rcyBmb3IgeW91ciBwYXRpZW5jZS4NCg0KQmVz
dCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IFRoYW5rcw0KPiAgICAgICAgICBBbmRyZXcN
Cg0K

