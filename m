Return-Path: <netdev+bounces-299526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WjFJEw4kMGoLOwUAu9opvQ
	(envelope-from <netdev+bounces-299526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:10:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE1688262
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=UanuR174;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299526-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299526-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1C5630A26DD
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78261408616;
	Mon, 15 Jun 2026 16:06:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4DB408638
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:06:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539617; cv=fail; b=oqcMQZcZU17GMQb1/wtdndzr5cLj2L40TaAHomA6eGOEEymX9wpFnuP6FxxZYhn64A348+rD8SGZUTD8NgPB0ATPy0iPUP51x4j9m+j46twOukegw01j7Nvsl/xVzX1anQHRZgcXNXNO4i8/9ii9u7YG5E/7byCoEzAW7jPIZa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539617; c=relaxed/simple;
	bh=HBH4YWwcFGp2YJ3gM700XdoV40jSKW/ZP6KkkTbzWYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YH8kIDt9zRhGepsMNyP8e82wG9/QKDafll/I6spG/Wvu3xLXj/jrTfT6a45Im3iUdUOT976IF5nPjipOnOLqkkzEl5D1VOW8qF7lUz3M1aOwbv5QdrDEb3gVRKYbtFGtwo710d8S1MEW+55csOSDkchpS8hgnXM09pKRIdbg39c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UanuR174; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781539616; x=1813075616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HBH4YWwcFGp2YJ3gM700XdoV40jSKW/ZP6KkkTbzWYM=;
  b=UanuR174v1E+kJ8Q2WWD7AwLmlGegKEzxv6Hxr1JyqKvCPsV0NxIPMd9
   ouMUFie28Uh2VVn+8oLHjyGOo/NlhGzm4SF2w5p/xam6cf7POczwGqtcH
   XfMaGvMuVRx9UffNZ/FU+axanqLVzO2pFoa1PlQahbKyel0AONAkkgXgJ
   UVHXg4RjnrINj2rS1cz7ymKC1AHQj5XLjJf76BCboGLR/yzdy5bkoxaaV
   6w8In3to7AW2IZzsls6nq96rZ5e3LAMiHpHfNwukoH4zM8B9ehjB7Yoog
   F9mVr0IJMI+QVjUJKTLjTAA1Kf+h3vNrmIlFp9pQgWeFC79trrLMWtdXJ
   g==;
X-CSE-ConnectionGUID: shuRcQAYTVqC9kfZTMK41A==
X-CSE-MsgGUID: ADMXplmYSB+wYOp1KqC1ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82026219"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82026219"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 09:05:40 -0700
X-CSE-ConnectionGUID: jI2j2C/wSTmi3BrFjxxxZA==
X-CSE-MsgGUID: KlIeBn3NQf2BjjOtjAMXFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="252623131"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 09:05:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 09:05:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 09:05:39 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 09:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwVBNJeMmqWfle1oITJdwnd6mNCVfEIC16DB7hR3y6ryAERyDQnVawqvCIHQMfZwCBlMnWWTyByLgdJIrR/EE/p1Zw778EDPYA2Wplc8njtgQ0+Ki0tKaXm4Rhmll901nVMbWUHkBk0EN/jvg6lC37JRMts4tGZPXIEkEwkY1u7qjAQS0uHT0Xe0+aeIkhmctE5MnZ5u3nMDKG16fbC5Gv3nSQB+jHz3az3MB0+Hkmh+0CvB9AUbLzsYzYhvhlJkEgYT9zAyIzgvmlt6x4BNmeglMho1ZHexGHoqOtdYkEQEd0Kpk6jt5eye6F7mdUQtMxg4LklCPjyAkGHyYLVmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBH4YWwcFGp2YJ3gM700XdoV40jSKW/ZP6KkkTbzWYM=;
 b=fO9bwmCITsiJkH7E9tzWuG47GCZD52rEqMyf1jsrZhTCEr0LmGeVYC3Ax3bmlaSUchCd6U2K/VP2CeZjKKrinvOE/JpEkO2PAoMB4c8HfqjAhPbPCxX7JQ+NID1iWLTl0E4IktKz+EcGJ+MuOTTdAuBztV4NZKX5pB84SINrsNBhVb9+H+0Turw+QFjBVacgdi2Z7tLFNTmxNr/rU2Rz8M6wzr4psM03wC2T8SfMHHLmo0p1jAX+MrTkbpnphMnlx9r/Bbdx+sKUP0zgUzidLNRDBrzoBiPww5lgXXygu/ytcuYCRTKYzppiHk6qLDr9q5UJoGmJHVsIvUB+a7AB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 15 Jun
 2026 16:05:34 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 16:05:34 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/6] ice: extract function to
 allocate aggregator info structure
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/6] ice: extract function to
 allocate aggregator info structure
Thread-Index: AQHc8iT7IHNpML3r1kG1LwVvonQ8/7Y/0mcQ
Date: Mon, 15 Jun 2026 16:05:34 +0000
Message-ID: <IA1PR11MB624129AD19DA99F335909AE28BE62@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
 <20260601-jk-cleanup-vsi-aggregator-nodes-v1-3-36d6ecbe5ede@intel.com>
In-Reply-To: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-3-36d6ecbe5ede@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SJ0PR11MB5772:EE_
x-ms-office365-filtering-correlation-id: 5dc405dc-00dd-4c87-c264-08decaf7ee97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: LvoWshRKcKd1E3W0RMaWM4PZ9+T7/BpzQY5jRxhIqe34nlRf3XgnhQMLZGrxMOQi1m989erFGJINfj3Hrqi95dU/MmTIjICfUk1G29C54iSKp0c7AkogS+xWcI7AM/mR36JghdXd6lnHRdVF34jfuhF5UXbF+/QzXsAeR/B4+HwNeXpMWhlZjtu94NfUqH7SQej/mmYywkMnd/zU7csZUulVT8ZqsrZAuI+dchrLkI3JC3MsFv0pvO5x5wj9HWccOe9/NlHqblrbRga3bgVCtEXA5HSHZIvwTrBs2uOQmDhyZNeyA+krH8VuY1LXLqgU3hPF6Z9Osh4aJcRdq/rnfc9aT83HzojGJ/afP/ptgOt+3lzgfZF+ml0tMEZE98RAFlwOWaePt+UFwTvuEHWDtg3EuY8db4K/H4qheEpV7LUxjlzRb1oXpQvt67cGBRNrdvrt4081oOupnJ1N9EbtXByZZGg/ws9QHuLEwLDNPX/6PfIN78iTF6ASwk7utAeeaV9Rg2cr1vjvwp9kY1wVY1ftM/VPFZdKfjOdzAsBqU9a28VnY37kNEkCySfkmFR5LQJkxRAqVd6kfV4eHyhRAKguV/2aEfEm6pZIUSupLXvYU4oQWTOY7kjmFLj8yXNYR7/APmbyBuMldtcHVbSwLLhlCAe6HY+gUlnTFdbmoM4m8KK8cIkZpE6kzPVYVC5lnqjPUXJ8vBnx4xO1BvSTspQCuI8jlGIp11Yoeuxe82jR96WMxLwCfFkd7RMKwHtW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c21CVVRjMWlPdWZhZm0xbFRKYmdOdDN2VmVsc29Jb0gyMmw1TERwQm1ib252?=
 =?utf-8?B?MXBjN2trQmtraVJiREtMbEZFYkhrZW0xMjk0T1RpK3h3a0owaGRzTDNWNnRi?=
 =?utf-8?B?VFp5MVZoY29hQ1pUekRxVC90ckMxbzhNNTEzTkFJTFoyVnhxbHM5STFWOUwz?=
 =?utf-8?B?ZHkxZEdsQkR0UXNQZDhscXBvUytJZDRyanViVmwzYVIyRFRIM1FaaktScVAx?=
 =?utf-8?B?QnNCT25DZ25QWWM2YWxVSEtyamxtV2dBS0ZKOFpQK2gwU2JRT2d1UWtETllO?=
 =?utf-8?B?R1l4U0lreU1sN3puWERIbFZyckVoUmVMUDBHa0NYT0JzVkRuMEoxdGtrVFk0?=
 =?utf-8?B?TzZIVll1dWF0ZzBOSzJSZlJ2a1lZMzNDL0tJOTk0QTIveE8zNUcwWjlhUXow?=
 =?utf-8?B?MjBHVlNIQ3IzVW42KzY5dTI1b0RYcFRPdFJ5dFdTOUZ2eGdTVFU4TjBmRURx?=
 =?utf-8?B?RG9NalNxOS9VOHpKa3A4Mm5RWWdVNlNmVC93eHdJa3l0VGMxNlk1Q21YK3RJ?=
 =?utf-8?B?RFRlME5HZDlobGhlZnA0eEQ4bDhjaERzTkVyUTdTQVN2b2dkRU91UzdpVEN2?=
 =?utf-8?B?WWo3OWhUWUkvcGs5MTFBeE9NZG03UzNjQVRMTlZWd2NoaFNmelFLMXBDSUFl?=
 =?utf-8?B?ZDV1c0hQT0NndFE2cmhreTRvUERGOG14Y2NTVkc2SzlEQkN4UHJPb0hJNHIw?=
 =?utf-8?B?cE8xUnJ6OVFqZXVaSDBmQ2puOWF4WEk4dnhnZk5WSDJHeUJrMXQyS2wwUzdj?=
 =?utf-8?B?dGtJWmtRMm56T3VaUUJzWFR2VjB3VVkrMmdiV0tqQmpJSWx1MVhiMWcvMG9T?=
 =?utf-8?B?dXpYWmhHd0RFZEI0ekgvRmY2VVJpLzFXQTZXVTJWUXUvc09nQlgrYVR4OC9N?=
 =?utf-8?B?YmJ4bDM3Yy95d1I3ZnpUckUzT1FUYzNPekRwREYxUGNrNzI2VXVUaThnSm9L?=
 =?utf-8?B?MFQ0VzJHbWRkMU5LdXVSZkFHcUZzejhhekxVL213VlFSTUhrNzErRy9TVjN4?=
 =?utf-8?B?QXEvQk1GQzhjNm02TkJvSFBvQ3BkS2pEaU5oNW1Bait1Ni84L28yOXg1NEor?=
 =?utf-8?B?NmNTZlFYT2g3UUp1bGk5RHVURHhEUVdlSUlNUFdzTi92UDROVEExN2Nidmg2?=
 =?utf-8?B?VzBxZEh4SjIvS3FRR25zbkhhVWVUNmZJeUdmS2RaV2hCU1FsVUhFazVIdW9J?=
 =?utf-8?B?Zml2MTlrc0Q3QXJjZkxaVlZQVW5xVk8wbGRjSVVvekVjeHpJQ0JPUXQ4SFVI?=
 =?utf-8?B?SjJPb3VSUmdIdUc1R2FicWYyaDBkYS9XZE1GVk1wTXZrcWVBdTZmVzBzdkVI?=
 =?utf-8?B?eHZhR0t1eXZCUUJGYy84SytHVjE5cThvbm5odWU4V1JIVXlKNTlhVGZSK0J4?=
 =?utf-8?B?QnJBcmtxeUhKaTRDZFpabWtpVVp5ZXRuU2t6RUdhK1ZlMkczb21NeWhTeWdN?=
 =?utf-8?B?UlRGd1Rpem42eFRXSWdNNlQ3MWRYaEZuK2dJUHVmNjRqTFdQUDB5RzZreXdx?=
 =?utf-8?B?QWZDS3hCUE9ibURMMnlwQ29TSVBONGN2aXo0UlBWTVp4ZzZUM25nQzJhTFda?=
 =?utf-8?B?b2xtcGlDWE5kd0J4cU16dmtOWVNhTE1pdmhodEVqdXdva3NNOEtxNHFKZTBD?=
 =?utf-8?B?YjkwMjlLazRqaXZRRDhZV2w5Uy9NVGhqSXdZbzI4VzY3QTM0QWxwZUtKNENr?=
 =?utf-8?B?WlJsT2Y0NHlxQlp0RDRMN2RVNFA3empIbi9MQTBEOFZwWTNpTkhNWk9mdHl5?=
 =?utf-8?B?SjNmczd4czlqOVB3TjQvUzlXeUJkQ0dxVzNrb3ErSk5YTExvZytpa29ZdHlk?=
 =?utf-8?B?ZGdmUjM3RmpvaEZlTC9Pc0lPK2paV1JuVkxET1hiVS96Sk5GeWNzT1lGTkNn?=
 =?utf-8?B?ejh6WVczOUdINTEzbDRFV1A5YW1LcW4xTzA5V1FERHZpSmxLWjU1ajhoL2Nx?=
 =?utf-8?B?NG0xY3Jsc2dLSDlJakppRHY0dGV6cGxrT0kyeFVETnRrYWVUekREVUMzbWxS?=
 =?utf-8?B?R0dOS1hPQXNaM1pqOHVvSzFpenovOVFGalhLK1orTXRSeXRMMVZ6NjFUYktU?=
 =?utf-8?B?LytkK3pOZnYrOEVNanY5RE00UTJ1OXhuS2ZWWGMzejRvdS9FR2FBQ3huU0s4?=
 =?utf-8?B?ZnR5enJrRVNIa0EzRGVXWjkvTFppRklJbU9yQVVPQU1jUS9GV1hTMS9vdXky?=
 =?utf-8?B?WlQwdzdlR0xiaEdoSG81TEtWUnpIeGF3YXJGb1ZTTGttdjJDeVQzR3NXN3RG?=
 =?utf-8?B?cGhiYlZ4ZTdKSzZjUTZwdVJZd2VnV1hKSWFWcVZKU25Qb1RjM2FpUExtL1V2?=
 =?utf-8?Q?R9GW+Qvo/MGam1HgP6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UWMF5x1w5kYTGRXRvCNK/XjCfdJH2EsAJpnTVH+gWqfpcLnbd7PxnEN5iWzvFPGomsvVfwlT1yr3t7UKKqBu+EMwqEn0GZI7p+CO/BL5Bmk3sQ3H8DXH6l6eVLfjSLWg+S9daaYsI+FyBOphOoj8FWUjcUMDwHrYiM+bJZURYy7CSUPf9z9sYI3WM6Dfuop85nqcnx038f/tK3665GBNkkMQSvc6QpQIMyt7Pow0QlTdwHQUwejP2Z69XmcVvrsT6YeqkFKEph0wfV/lJ0PCg0z7BE/ImTwjMIRUOokKuyT5+TDlfAA3Pjg/PxBs3dZBzW9mebS8s2tjaWWCQaWkDA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc405dc-00dd-4c87-c264-08decaf7ee97
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 16:05:34.1358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWadYoSuP3vNAG0ZK5RUr+aW50jCO87q3HjcnSHrOtxYUQWTLJxrq3AUEt+wvf8nSQ0D0dbrfc+5qHWbyQryfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA1PR11MB6241.namprd11.prod.outlook.com:mid,osuosl.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92CE1688262

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMDIgSnVuZSAyMDI2IDA1OjQ0DQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGlu
dGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
Tmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPiBDYzogS2l0
c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IExva3Rpb25v
diwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEtlbGxlciwgSmFj
b2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFs
ZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFu
XSBbUEFUQ0ggaXdsLW5leHQgMy82XSBpY2U6IGV4dHJhY3QgZnVuY3Rpb24gdG8gYWxsb2NhdGUg
YWdncmVnYXRvciBpbmZvIHN0cnVjdHVyZQ0KPg0KPiBBZGQgYSBuZXcgaWNlX2FsbG9jX2FnZ19p
bmZvKCkgaGVscGVyIGZ1bmN0aW9uIHdoaWNoIGFsbG9jYXRlcyBhbiBhZ2dyZWdhdG9yIGluZm8g
c3RydWN0dXJlIHdpdGggYW4gSUQgYmV0d2VlbiBtaW5faWQgYW5kIG1heF9pZCwgaW5zZXJ0aW5n
IGl0IGludG8gdGhlIGFnZ19saXN0IHhhcnJheS4gVXNlIHRoaXMgZnVuY3Rpb24gaW4gaWNlX3Nj
aGVkX2NmZ19hZ2coKS4NCj4NCj4gVGhpcyBpcyBkb25lIGluIHByZXBhcmF0aW9uIG9mIHJlZmFj
dG9yaW5nIHRoZSBhZ2dyZWdhdG9yIG5vZGUgSUQgbG9naWMgaW4gaWNlX3NldF9hZ2dfdnNpKCku
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwu
Y29tPg0KPiBSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rp
b25vdkBpbnRlbC5jb20+DQo+IC0tLQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX3NjaGVkLmMgfCA3NCArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gMSBmaWxl
IGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPg0KDQpUZXN0ZWQt
Ynk6IFJpbml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29ya2Vy
IGF0IEludGVsKQ0K

