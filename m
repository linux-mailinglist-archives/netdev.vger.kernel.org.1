Return-Path: <netdev+bounces-286514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMFGJQiUAWq7ewEAu9opvQ
	(envelope-from <netdev+bounces-286514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:32:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F260A50A226
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59BD4301FA69
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB13B3B8BDB;
	Mon, 11 May 2026 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0+Ijr4d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A63B0ADF
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487972; cv=fail; b=ijba8Q+X2cOdMjRWjEIPRsEVzZZ/2Ofo6K/6YPudgrrO19w91c9ffDqd+7ykUpGHT96XfXrLzF2IziGmK9zNT753I0pDW82vL29wXk+MCb4/EzRhQ3U+z9pFrvCIURwMX8nouYpXKD8CeL7YIkIT0FUR3gw3x/HlxpWimEu3SQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487972; c=relaxed/simple;
	bh=Ze/wmFuD8sCFawPL6pGFbVdK4znuHV7iA0kuF+AD1JE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GdTVEQEpRIrafy/ZDbwxqUacKooqzqPq26ZMMwMYoxJ0R8A4w1IikG++8qhFnDC48xw9lREMvw8kdi+tNAl1SygJIkZMRS9LTdR6xihQrfV+mWjhOgr6dfWaSvqzgjbfeyscWXuZDVA5tWBlZXFumrK6gQo/ZbYQw7iUgX8Z8yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0+Ijr4d; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778487963; x=1810023963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ze/wmFuD8sCFawPL6pGFbVdK4znuHV7iA0kuF+AD1JE=;
  b=B0+Ijr4dSXEKT658EsBXR0gV1KkahP/OEfYH1rGFJSjFtAM0V1kdGeVH
   4tX0/mHXI4NrW/GmF8Au9HjJkwHamrExyxcToyLROPh0rzHT7EDEB8PBb
   qhcWo65GPTMYQqcxQVpmQaEb9yg/r+rtwZJX3ERJjahGc42hsVkNfc+PL
   n2HS0Wp7xQArq+aIm99e70FcCPiZcH2X72tCqfSoHiT9bvN+dmynVNoeE
   0y09SOgoAUPK5U4woqop9lCcqbDw+mXrnIIzmSOoE048QjzWZjf1504tQ
   YzGsK12bEYAnyBBftNoBN3zoDsUpgKElUjopcm+TesT01zlAqCX08GZht
   Q==;
X-CSE-ConnectionGUID: Y8pcXYT9RsezBA/v1pFeLw==
X-CSE-MsgGUID: yLttzwo1Sp6F5tW/LBA7Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="66900629"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="66900629"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:25:58 -0700
X-CSE-ConnectionGUID: KqmSBnn2RtCAfM1Mo47K6w==
X-CSE-MsgGUID: DhGTHj47SCuuiz2hCKLrAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242357791"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:25:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:25:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 01:25:57 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:25:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGQ6ENh4NyvMbnnWEF5jGEWX2IoXf/SuBFFAnlFYLY/B9N23i73KS/Nq687qxDmOrCKOXUpmYiHXgteWJB28d1OzGMN8jGnOVOPCwDer8Zo4DNHH0DVjhnkj+vhiiSTTQuPcqFdGdXA4CJHzLHKAm+CR6rZ7Gw/+fOYA8G4YSi5P4l1/GO+00Qweod8sY+6ohRTAS8xEDEdMhZBrGS0H3YMDcGnfoChlKS0LQXRsa/2m3E08ToBF5fpmOqV2Dr1UoLHGSgsg52/2u1riILgARI0kEOCE+t9zs0vy+J1gQwT862Ai4JNYA6rcONTf/hF0JHg4gX07TB4nzt9VbKtg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze/wmFuD8sCFawPL6pGFbVdK4znuHV7iA0kuF+AD1JE=;
 b=YUknoomlDaGYAPtujDZSJBiISO0QCPJQHvQWh1sfYPre54HaqhEHCc2Ew+sJ/vFSsvdnmqija+tyG+heA3qR8M1vn8GT8NjE8qFMkYwO8zDZBpPzXEf5QYGfwRJXDpyVvBl4d9Dv5yVdrHzw7YJaRy3KGJ65stnDV4566rayc0nsI1vhoRW05N4fFjcQQU+/QqVRYDeZ9YkgDG/knOfNQ229iDqFtzNiKiR12n6KYiV7q8ieSanKfAVLdizD9eNhoKKJcftBRXHs5Dtl6K3QVcpG3UblOG7v7xUBdqC2YIziekNtxD3NETevXTApCw366cpiimnkMD+naoofEqdWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:25:53 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.20.9891.019; Mon, 11 May 2026
 08:25:53 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/5] iavf: fix error path in
 iavf_request_misc_irq
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/5] iavf: fix error path in
 iavf_request_misc_irq
Thread-Index: AQHcyxeH6XNQjcNIdE+Fr+k09WPXKbXc4hiAgCvHPGA=
Date: Mon, 11 May 2026 08:25:53 +0000
Message-ID: <IA3PR11MB8985A677535A94094B79C02F8F382@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
 <20260413073035.4082204-3-aleksandr.loktionov@intel.com>
 <2a90e151-2e7e-409d-9123-1e261c1a24f9@intel.com>
In-Reply-To: <2a90e151-2e7e-409d-9123-1e261c1a24f9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH2PR11MB8816:EE_
x-ms-office365-filtering-correlation-id: e59afa15-3fce-4bf8-c014-08deaf36eaee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: QbJQFqxkoEdnGpUK8hBCt9f5DqCPH4NMYBJgrGG+ogMnAcZjcslEW6Kha0bkdJQsGlqfBBI5a7qPSKZVOBv9fKFBLiogKSphqW0aS8JOqJOBwMIfVTD5uQCOm6gaxncbnRMz9y6JBKSYHqu0Gu15ajRQ+VTqNrTr8IuoK4pFuOWOC6w8gECkBog1PBzHdNTMnhgXDUN2reNG8uvu552JMoVeRzlWU+/4fBLnu4Wv4zFZnzzwulUzzpH2oXI/xylv6DAzvBcRSwuocm8thfiT9Rin+xCn4YBXOdwd69EFDwO5N/0qcBc3nAoc8l399SdJS2HNYvgm1r184AXS7UTRubguC0TBiCk66g3xRXQQuec4+60RD9qdO9lt88YvepkS3fvf8Fb+moupeC+v8VSp3Sk+82a92aK0bl7BD6FEnPRGFbwBvCk0DOtl/nppOZgFPHK+HCbf80BuHEIy7Y1jdgTpTNjD3V3ldz6AltlWwGWq9LzvZbKzWRctYWckwSS7mooWWiOTyw1izyzs70i4je/nk86hgcXPjffPDQb7wVEZH824bv2FzSuzpOqHknErmwoS5DHKyp8bkL98+zDKd51YlwUHAefzqyX+x28SriOWJR48Ed8gdArdLrW8u0BSKnAr6/OrhfuAP4DBgSkxhMphvFylCITcksh9qDZ8x4dN7aalQa8gJgJIN/0L9zhn0CSHUWGZ8y1EFrD0sRQo7r3wM04jhZ9DrmhMnUKJB2IHBJAY41UlWKBTA0doKrAg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGx3QTNaRXczcThxZ3FUMUh6UHVLaGR6ZUhLa3ZPK0szWjMzdk9TWHdvYnNB?=
 =?utf-8?B?UWduNDYxckpTNC9UZlNzVHdjZzlhU3lNcVRKTGVjSWM0SllyOTFuUUt5MUtl?=
 =?utf-8?B?L3dEbXU4blFiNStMNjcxbmowS2tYUEY1RWdDei9OY1JkU3graXFCR2N4NTVz?=
 =?utf-8?B?YzJ3SW14UnN4TzhiMVJGTDIrcXBNNVVWcldhdmdmMmxVbmdYZzZxNzhFNEdD?=
 =?utf-8?B?RzdVNUhIZnJYV3haN1FPTVBUMG1tZUxUQVhwUEZoUHRsS1d0N3hpaHRiazBU?=
 =?utf-8?B?UzlHakZkdkkzK0RRUGJIS1F2MFVxWmxndkpnb00vaTRrb0tEWFVnb2hRTFFi?=
 =?utf-8?B?ZVFiQXVISTd4UVlwcFJRK2pvUURGSzErMVRYb21wVW5RQTlzdGlmdGpPZlE5?=
 =?utf-8?B?RzdybDd3SmJYOFkvQURlV3B2TVVjZkg4aHUwcUlwa09BZ2UyYlQvcHhGdlRD?=
 =?utf-8?B?bnUzRmhMVG1GK2pFSTdwckJ6TUlJTmFDSUhkVDFEc3lKSi9kTTFDWU8yd05X?=
 =?utf-8?B?NDFMcHVibFg2RkI1T1FkR1NvMjVyRWNIcGMrNFl0MXJqcFdQanVOeHJsK0Y1?=
 =?utf-8?B?RFppamFTaUlkZy9ib0g2bFNqUjQrQzcwMUg2YXRENkQzODVXeGszSWhXSEVL?=
 =?utf-8?B?OER1N2pYUFZZQStHQXE5dFhSUjJ5MzgvRzNlUXFGRXlJTGFuYVRpcDIra2VQ?=
 =?utf-8?B?RDRiUUFOblpxL1prOVc1Sm1LcU51MFl1THhndnhvZXpoUEpiZmFEV2hmWFpU?=
 =?utf-8?B?b2UxNnNjOXd5WXY1WlVxUmxURVN1ME9HMGZuSEpUUEpVWkZNY05zTkFYcHhp?=
 =?utf-8?B?cmxsVzcyM25JWnZndWk0RXZHTUl1STYrQjh2WjBMUm1xcXRqZlhnam00YWtY?=
 =?utf-8?B?YmVncmg2SEZvSU0yeE9yc0dLaUZmcHJJdVpGRDlJU29hYTNWREFQVnFiOTVX?=
 =?utf-8?B?OWY0RmlnbTQzenZzQXdidG82VEpmV01yUzNxaFR2VlJDVU1zWmpxMEhjUFVX?=
 =?utf-8?B?ekppSHpyVUszeXZMTmI1bE1ORGZCMVlzc3c5NDQzMUsvcm9tN0YvOTNBNVpa?=
 =?utf-8?B?eVdHVGxHZVFhakRvODV3UkxiVHpRUUd5QXZNR0FhakNqUFVTaHFSSU5SSWh0?=
 =?utf-8?B?OGtQczNBdU9pbXdEMFE2M2k1OFRVUVNzNFpUYnpWQ1A2Z2VEZjdaa25CMkJY?=
 =?utf-8?B?ZjhYK2RjZ1hLczZvclY0TDhTUnVQMlljMnpaVnFLT0hJU0JDUVhoREZRbHpV?=
 =?utf-8?B?Z0c5amdxTWRxR0pETFlUYk84KzZPVTJqRWJXNFZ1b05NOGlaTG84NXJmVklp?=
 =?utf-8?B?aWRaQVVGQ2R6Zzg1RzN2LzgrY2NvaFE0QWV6c053Umx3aU5rZGpsNzVvZmh5?=
 =?utf-8?B?c0gvc0EzcUJHMjZZNkNIMUV5SzRlM1VrT0M3T0s0dElZcHN4VXFMMWtFemxB?=
 =?utf-8?B?TzBTZ3BQcXNianREeVFiVjI4M05DdVhScXhVYTlHM0E4YkZrUk1iRHRqVVox?=
 =?utf-8?B?VFpFUkRFR1ZESE03djFtSEdlK05IMWllUk15S1E2ZDI1d3pEUTNua3hUKzNk?=
 =?utf-8?B?YUxhc1psVFg0eE5UR1BKd1M1d21DeGVZM2h4eXJOWlFNYkcwaUk2c25FSTRu?=
 =?utf-8?B?MnVJaEx2S2R1SDhmOHVmdHhnVUNtY2ZpVWRnL2RFcXNMRUlBeEFJSm9VMGQ4?=
 =?utf-8?B?ZVhiZU1EWHB4ai9ja0xHNDZxZ3BaRWRDMnZNSTBSa3Q0eHdNRmUrcVdIM3I5?=
 =?utf-8?B?VFFJVlpBbnhsN3NpV3NSU0JCNzk1bWdZeVVVM241VDVOM3BPYXl3a01mN1Fr?=
 =?utf-8?B?NEVsblNFQ2FFQytCSXBVVkhabExKZ21qTzd3MStUNDE5L2NRRHgyK1N0MTlW?=
 =?utf-8?B?RitjTi9CRzVleHVKOFNnRHd0UGNmNk4xelVyN2IrR29DbnFJd0tEOUtvM2lX?=
 =?utf-8?B?RGxNMitSODdMdW1uMjlkbEJYa2V6ak03OFIzNldKKzVOWUt3Yml0T1BuWWFr?=
 =?utf-8?B?M3lhVDczWWFXMVlpV0J1cmQvQUplNUtIbzVZNlRudHpEL2xaNlh1MHJOclFk?=
 =?utf-8?B?NmFIZWFCbDV3RU5qWFQwOVdaYlMvYTBCT3FGZDV6THdJUHFTb21PbkVVaEpi?=
 =?utf-8?B?Sm5maSthM044UVFwanJmdWpxb1owK1hiWG5nTzA5ckVjencwSTNDT3BIUFRM?=
 =?utf-8?B?UWtKb1h5MzkwNE1TNWRLcTN5aFZuelpOY2hoY2NqOVV0dG95Y0ZhUXdkZU1L?=
 =?utf-8?B?aDB5YS9lWG9LSGUrSU5BVm5tdDU5ek9tck8xZ0FIZkhHVlVZM3VaWWVOczhM?=
 =?utf-8?B?YjBQTGR3alZ5QmtzQkhZOU5HOHNQMDk0ams5L0UrMVNzenB0R2JCdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NJvV03xI+I9OsPY4Y2jCAs0Rrdj3wZBXFcZ5pQrFr4pM44bQUiehttZzOqW9FZhartbeInga54bNFeHM78ETxlsedNYtUiybswJWP8TWQRT+TinOt3NN4zcHe3VLBuY2YhVtcNfatd8iazSm2UmKQkD3/te37E96YbsnwesUnPAyE37ob96+IC819+vt1SiyE5DWRnpOWuIRD0mDqVCJ85VtHPhBrDoJzzjmwA+s/ZzfQyqvOnhdgtvEamiWFY12H49/rCPzKfOq4uILY+J+r/ws/cLfOwwdD3ZLqJzI4lS8s81fxqt4gCr8mKHZrJZ4lXg/9V0VmgJiDIMa6zWB7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59afa15-3fce-4bf8-c014-08deaf36eaee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:25:53.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhpPjjibexirlbaBn8P2KjiiCLSrYN1Hs97S9NIKc5nATwKOPsJEXOMT1+nGyvKoapTNxmDh6D5u72vvRSpl6txmFw6SZrj1ZNbcPdT+Nv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: F260A50A226
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8985.namprd11.prod.outlook.com:mid,osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBQcnplbWVr
IEtpdHN6ZWwNCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxMywgMjAyNiAxOjUzIFBNDQo+IFRvOiBM
b2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+IENj
OiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9y
ZzsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXQgMi81XSBpYXZmOiBm
aXggZXJyb3IgcGF0aCBpbg0KPiBpYXZmX3JlcXVlc3RfbWlzY19pcnENCj4gDQo+IE9uIDQvMTMv
MjYgMDk6MzAsIEFsZWtzYW5kciBMb2t0aW9ub3Ygd3JvdGU6DQo+ID4gRnJvbTogUGlvdHIgR2Fy
ZG9ja2kgPHBpb3RyeC5nYXJkb2NraUBpbnRlbC5jb20+DQo+ID4NCj4gPiBXaGVuIHJlcXVlc3Rf
aXJxKCkgZmFpbHMgdGhlIGludGVycnVwdCB2ZWN0b3Igd2FzIG5vdCByZWdpc3RlcmVkIGZvcg0K
PiA+IHRoZSBkcml2ZXIuIENhbGxpbmcgZnJlZV9pcnEoKSBvbiBhIHZlY3RvciB0aGF0IHdhcyBu
ZXZlciBzdWNjZXNzZnVsbHkNCj4gPiByZXF1ZXN0ZWQgdHJpZ2dlcnMgYSBrZXJuZWwgd2Fybmlu
Zy4gRHJvcCB0aGUgZXJyb25lb3VzIGZyZWVfaXJxKCkNCj4gPiBjYWxsIGZyb20gdGhlIGVycm9y
IHBhdGguDQo+ID4NCj4gPiBGaXhlczogNWVhZTAwYzU3ZjVlICgiaTQwZXZmOiBtYWluIGRyaXZl
ciBjb3JlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW90ciBHYXJkb2NraSA8cGlvdHJ4LmdhcmRv
Y2tpQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9tYWluLmMgfCAxIC0NCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX21haW4uYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWF2Zi9pYXZmX21haW4uYw0KPiA+IGluZGV4IGRhZDAwMWEuLmFiNWY1YWRjIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9tYWluLmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfbWFpbi5jDQo+
ID4gQEAgLTU4Nyw3ICs1ODcsNiBAQCBzdGF0aWMgaW50IGlhdmZfcmVxdWVzdF9taXNjX2lycShz
dHJ1Y3QgaWF2Zl9hZGFwdGVyDQo+ICphZGFwdGVyKQ0KPiA+ICAgCQlkZXZfZXJyKCZhZGFwdGVy
LT5wZGV2LT5kZXYsDQo+ID4gICAJCQkicmVxdWVzdF9pcnEgZm9yICVzIGZhaWxlZDogJWRcbiIs
DQo+ID4gICAJCQlhZGFwdGVyLT5taXNjX3ZlY3Rvcl9uYW1lLCBlcnIpOw0KPiA+IC0JCWZyZWVf
aXJxKGFkYXB0ZXItPm1zaXhfZW50cmllc1swXS52ZWN0b3IsIG5ldGRldik7DQo+ID4gICAJfQ0K
PiA+ICAgCXJldHVybiBlcnI7DQo+ID4gICB9DQo+IA0KPiBSZXZpZXdlZC1ieTogUHJ6ZW1layBL
aXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiANCj4gbmV4dCB0aW1lIHBs
ZWFzZSBDQyBuZXRkZXYgb24gSVdMIHN1Ym1pc3Npb25zDQoNClRlc3RlZC1ieTogUmFmYWwgUm9t
YW5vd3NraSA8cmFmYWwucm9tYW5vd3NraUBpbnRlbC5jb20+DQoNCg==

