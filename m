Return-Path: <netdev+bounces-263187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BKzAbLTpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:27:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 718191EF66B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69D12301FBAB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C4A33F595;
	Tue,  3 Mar 2026 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gic1pb9u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12733D6EA;
	Tue,  3 Mar 2026 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540845; cv=fail; b=WiTFR5fMLSZBJMBolXGvRc3BYk7Du7n7CfW/q6uQ/RcFiGd5MZJ4Q0rg1iVSB2aZfUuCMiP29TAmNiAqF2eZzSdgifYXXrH6Su2s7sO1dncvQVDxM/OJe7buMIeA9NEEIqnLz1k9gGI3+YYpIJgE+yTeowlyRznFROW0abPctFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540845; c=relaxed/simple;
	bh=c1q0soraWJIcMOn9wH7IkyuYNeLir35YaSrwobXOGes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YJKja336NotOZQpDTXjXWm74gUx6kL2BXkvvZmY7kn35IM3IIfbfcKOJWfFnOBjvXEBWK5rZUG+zGB6Zl8Kle19UWwbeYjft58NamjtjdP6bJrsc96UqAdSnUIYsNAipL0ZVY4+P+wcaTrVBT7XVOKaQku4UuFjwUZZn/2RFGo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gic1pb9u; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772540844; x=1804076844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c1q0soraWJIcMOn9wH7IkyuYNeLir35YaSrwobXOGes=;
  b=gic1pb9u2my9TcVTxaRs/snMuXri9ALJdJR6keB4lHIshWEp+Vr3s0JJ
   Cq0VyaxPVNUMje/bXbtbSyvlpQ+P0zrmLr5pejjhbG71esh8KktqEhQGO
   3xYeB65lTbcCY6bJcVIhpwC57jakavn2ohkzce08Tn9iZtZ+lLEng5c05
   2A1sQEuiv0o7lytufGaRpMRFy+u6Vocrad9GW3vRQ3/tj6WLWtndcVnEU
   pMp6b7+V/EKaSD/BNaSua57QvKKTKa34JOvL0HJ9lPwJbU2fCnr8SC4RB
   yGidAZpalnMwEeZ0P1OytdMNxytiuM1RvVbKJDibeCeFXEamGvakNkfak
   Q==;
X-CSE-ConnectionGUID: LMlJJy6YRh6MCFfnW/+Wsg==
X-CSE-MsgGUID: 63jIXYUaRH2/3qXjS+JrJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84922140"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="84922140"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 04:27:23 -0800
X-CSE-ConnectionGUID: t4i3B2uzT+ipDXXwWNrM1A==
X-CSE-MsgGUID: 04DKC01BTQKsPnlh/fHibw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="220990638"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 04:27:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 04:27:22 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 04:27:22 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 04:27:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiiv2gVB+uZEVe1JyovRJJmdDBkLy659StyhPFLpBBaEq5hSQ5PPgIaoyZpYWLujP/GkDJmRunJ1RT0yBCr8A+aPpwguneQUjAvDw7dmR4K1NwUZnI3hOmdQc8oHT1ci/xBMuCk8/vNBSIdn2Bp7G6i7LIimb/iNIN5QKGfhzAGFMrWeTZBwlXFMfHucAO+z9n9ZqWLUvXD1DBuZcJ6pQLnoCXs3J4j9PZN0Tun7IKzNf7SrThmhUMJowwiN6bEi/WK+WCPopiFI//WHxWnDNGQKsfp7rEG1cMlJED1AwrPviwtfOBcrXKXvRg8lT60n+CzWDNRO5QmgK6Z4Yz3ZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1q0soraWJIcMOn9wH7IkyuYNeLir35YaSrwobXOGes=;
 b=W5qxKXcANLBimiDPLvG5BWqilRRgvv/HympWr5rQW1hB6E/Jkj9AE2uRuqkTzepHodaelWtVLaoWgP4LqpBdAdrTnGPFZ+6xzNNzMmdA11LaX9cP3OusphQM/TY9d9EN7Kt+MAy3jgEOPOqknv7+MwRYdYgNi2YvfK6883ZmaGvuaSjSFxYRRN7t2eci83zo9psyn0jIO8cZOzuibpaMwhg1kioFY7Oac99D1G5XzURzDXdezNCB8+m24l5WY/AEiFH+h/pRyMK7RdYpGv6ySTfaLqtVW1wZd6TB9vImXF2pKfmMaPSC20SFvH5XVp+d9bllMpmROlbizzEKLXFzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA0PR11MB8355.namprd11.prod.outlook.com (2603:10b6:208:480::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Tue, 3 Mar
 2026 12:27:19 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 12:27:19 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4] igb: Retrieve Tx timestamp
 from BH workqueue
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4] igb: Retrieve Tx timestamp
 from BH workqueue
Thread-Index: AQHcqwPAOpguvVRYokaeeWCq7MJElrWcu57g
Date: Tue, 3 Mar 2026 12:27:19 +0000
Message-ID: <IA3PR11MB8986D118CB47CD29283D8654E57FA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
In-Reply-To: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA0PR11MB8355:EE_
x-ms-office365-filtering-correlation-id: 99cf5268-4beb-472e-678f-08de79203686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: PYZknpXFyTAGz6B+Xpw42puy3w0Um5XdPlfbj+20nIEoDqSOK48rNchEIQAkYZOUenQohU1QosJxu+u4Vgw/YyniwGr/Y1UYM2XLxRTeqICk2l+VRLU7RmBJoOu3Igo4C4f2TQSkHxmyw6G2s9i4m8xJNUUb7lPaBxyjT14iT/1NlpCZq37zmrkjMTgfSaPnEm/2igzskrdViUkho6HE/8BtBrTtiY+fryOxYv8xVvidPnrPnlYx3AchRV/snyL2DpXXd5WpeXURq9w5wqYu3IdqFOhkaavequjjW9vGXLoiF+PGUMNfm5q6Cy6Jgu+zlSLVl1ThbPvEeg8oUQMNHoiUoEmo2lYh5ShszVKbc/Od+2sJAY0i10S5B5a0UFJ+ZdqTNrg6JPwqA4lmc+3Mzigc0kdjkvI86jAM9UIYsRpLP64oOymz4zcEZ1vBjWGp/fLRYycQG5rKyE+VRSyHCii1FHVJQTTSX8TP0txORt4ixSoubP9khnWQg+929i8CxYtX6Tjnk9k3eoN9+1+1kKBiwNC/kJk1WAHLX1N+Mn7kLQqYar1j9eWSSEiJ6jBSYHn8aPp52vOIXKD6gUv2G2OLV+mdUU0eRjzvXXtbiTefaJEZgayxrmrnl2pWSVUUYQJ0iVUKXgzae0nHe3muhAFof1M8iO+7iqH96ivuZsvgBy+Uyp7udagNbkNy2pNhL4x0AZuG8QbyBAttUCQtvP4/L5fXG/gIIctp+q5vagXzjh5/RCw3xsKshWzfjT1s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2RBenB3c2pUR1ZMRFYxQW9Yc0R4aFN6V3dvYnNBQ3JiZXBEcWd3Z1dwczZO?=
 =?utf-8?B?YmhpSmxWQkxUQi9GYXg5YWh4V1plVU9Fd2dZR2QvZEo5TVM4aEorbGphcDdN?=
 =?utf-8?B?UCtDdlRuMkJqQ1Z3RGJ0UU1SQXhlQ1lPNGlZVXovVWtTb0VySEFuNzJFS3Er?=
 =?utf-8?B?UXVmTkdJWVVYeWVRWEVaWW5QbW1EYVFETEtzbzdMRGVnWGVRU1hIcVk1Rjhr?=
 =?utf-8?B?aXo0RURnTVkwT0ZiRDhMWERxek9FblpOTlJpaVV1eGM3d2lmWk53WFN4L3NO?=
 =?utf-8?B?TVF5SnZYU25UY0FiSnJDYldxU21CQW10RnZZM3VqVXY3WW4xdkdVQTJTUXdv?=
 =?utf-8?B?d2RndVI5SXN4SFVWYjlNTTV2Z3Jpb1IrT0RteEZnNVFLclVueFp0V25OQWpX?=
 =?utf-8?B?WExZZnhseCsrRnJiUy91NnhudnVoNkRleG5TdVptMzlWZDU3dVlzQm4zWlhw?=
 =?utf-8?B?djltUmlYYTE2bTRUZ3B0aHUvV3NnSU5pSEhrNnpUWjRtVjROL1ovQUxOdmJm?=
 =?utf-8?B?aFEyYWFtS3VGY1BoQ0JXcDJ0Rk91UUZydlVnVDZIcDFNUFl4WTFMMG5rQmI2?=
 =?utf-8?B?amdNMnEwd0gzeWJmckVkejFFaFdhaHJiZ2R5cHErUzNUNjVjbWVpb2xISzh1?=
 =?utf-8?B?YkoyQ3oraGVuSHhuT0hJc1dPYlpZMHRVaHBRVUpCb2ZWeHd4UWI1UFFnTHZI?=
 =?utf-8?B?cmVKZEFpdG9xT0hSYldqeDErNGdVbldqNHpEQ29wQ2k0N2ZmeXYwZkVUYk9o?=
 =?utf-8?B?UmlqVWdEMGtlTHk2OHBTVTdaK09xTEFYb0hpK2R5bDRvSHZNWlNUNzJDa2Ft?=
 =?utf-8?B?NEZCQUxYTkVlbjBpNWlRVWE1Zml2T2E5YWZRZ0tzWnJick9LTnVLSWh6dFRZ?=
 =?utf-8?B?RmV1MktCQThGWFB5ZDdDTTdFV3RUdEpHTS9zcDZTZlcrTk5oRGhFamU1b0xZ?=
 =?utf-8?B?c2JIOFhSTW9mT2Z0dytTelRQTmVDWmQ2WXU0bUxKNFdoMU11bitXVS96MUwr?=
 =?utf-8?B?WmpoMERzVk0xd3FDU3lEa1NvbkRUN3FWcHZrMXFrRHJQSklVTm45ZUpHTzdW?=
 =?utf-8?B?ODhvL3pPUHp1dnlScVpzLzRzUW4vaFlRMHo5OGUveUxuR3krc0VkV1EydlhG?=
 =?utf-8?B?NnBvQnN0ME5nMmhENHhIYXRtTHZQZ00vZXBRb0lWbFBNMWxGRzN0bWEzUDVo?=
 =?utf-8?B?ckRtT1UzNDFjM1IycnkwbXNFOUJIK0Vkb2RqeEFFc2ovYVhLdHFNK01GeG51?=
 =?utf-8?B?NFl1V3R0eWVhWTFuNUwrWVBjcEZGUDBrbjJTUkRkRndQM3pHYzNVWTNiN1g0?=
 =?utf-8?B?OHZyak9KSkRTMUdwWEtUVmp4a3l4aFZUTVJFTHcwdDZHZEZzL1gyR0ZTaE9h?=
 =?utf-8?B?cVJrU2R0VVBKTEtYY05VeGYxbTl0VEtqZ3BkVVBGRVRqUzYwZW50SnZ1Ym10?=
 =?utf-8?B?QnhhYTNzTHFmNlVvcjFwcFVLL3ZET1FIaXpkR2pjQjlBT0FpVFNIZ0x6L2Fs?=
 =?utf-8?B?bHd0eXJPSG9Od2pycXZ4dXg0Z2NoODhlRXdudFpGdzUxOStwY0t5blNqR2pJ?=
 =?utf-8?B?aEcwMnlMNXZHL0YrN1d4M2N3cUM3a2w1aDhCL2lGbzJjQU5yVEVGSG4zdVc5?=
 =?utf-8?B?M3BoWm1jNUpNZEdjUk1heDJ0QnordHg0N3JNVVBQdWFMUFg4Tm5DbkE2UWRD?=
 =?utf-8?B?dEc3N2JaaG9PRXFZVmhoOHIyVDM0ZDcrQlhNTmtzNHQ4TW1IYUtHbkVNUE9M?=
 =?utf-8?B?UjFOcmJCSi9zLzhXZUU4MmN5NEt6Wk81WkRJV3FTZXM1TVBPYWhNYUhMOEMz?=
 =?utf-8?B?czljWHlCYnVTVnVKSHFYaTcvTjA3L3phQlA0SCtuUWpFS0diRDlQUnFHZWl3?=
 =?utf-8?B?QU9ISmgrbWpUZTk5endLT3Z0UjlPUDA1NEVHRUkrVEVNS1N1dnlhekIvd2pI?=
 =?utf-8?B?OExKT2FtcEd6M2hHUDJhcGJ0OGFmNVp5QlJsdXhadVZTNGJjU2s1bG1CdHR3?=
 =?utf-8?B?a1ZiRFE5R2NxSGp4c1Z0Rk5TMGpuNkluUjRzSVRTLzg5UVdQQmo2K1NNdGll?=
 =?utf-8?B?Nmx3Z3U2Z3hqN2wyWmFXSFNjRkxqVk8rOUZXdlNxeGdnaHg5TEpxRDBIMkpY?=
 =?utf-8?B?alE5WlNXTWxIdVBNWHRGWjlCVzB4aXpjbmhNNVJoeVViM2ZEd2JnS0RKaTk3?=
 =?utf-8?B?VUNHamdFU2ZJTzBPcXJjYTd0YTYxYW1HeTBqaklMTDJMUFVrbHd1dXdXOWMy?=
 =?utf-8?B?V082WG10a3V5TmZjLzYzZzZwcTdBQm1qaDZXTjZYMEplZDFEclhHZUt0OElT?=
 =?utf-8?B?OEZ6aVBvbVFYbVA3ZDhMcEJqOEM2Z0RsYzdDc0ZTNzdxVlZQOHVtYXQ0L1Zi?=
 =?utf-8?Q?X2Xk62le7TSscPVg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r9f7IvXNzLHNxFNR5Iijx64x/ELh+TEOJuexXVK8UXMFNjxIgw5wQpJGxF73pjI+RLYpmYgFd52P48aI4PWFc+fv3mqLInaB5b2r3YyfPJBJBXTddNLJjYJdGRfjAVeLn4HkwJXISk6XR3mH4dtwrbk2gsZu258j1WZSAXmxc3LtMJX5LwPGfE9qCd1/vTbBss9UgCdU7QaprfzN+YfLBGaFxkU2dfPdKfC1DD/XVdyeA9jdgJfFeZ6NZtHzWKdvgLuCimL+YuVTT0ul3m1hyYXkH97kQQ3InrQGp0FLbFij39igZuH1ayh98Yp55qck09uacT2bkprkNpv258j3CA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cf5268-4beb-472e-678f-08de79203686
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 12:27:19.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYSFJt7LxU0/w2ie59o+XradarXj2gnSvCdTfKA7hyVi0T71IesGxeFVHgUCC/cPsrkspRLyRQgTMrXgY1HEgKh9WeSWbgJGWjg46pGoh3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8355
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 718191EF66B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-263187-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[molgen.mpg.de,linux.dev,intel.com,vger.kernel.org,gmail.com,lunn.ch,google.com,lists.osuosl.org,kernel.org,redhat.com,davemloft.net,linutronix.de];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgS3Vy
dCBLYW56ZW5iYWNoDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDMsIDIwMjYgMTI6NDkgUE0NCj4g
VG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6
ZWwsDQo+IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+IENjOiBQ
YXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPjsgVmFkaW0gRmVkb3JlbmtvDQo+IDx2
YWRpbS5mZWRvcmVua29AbGludXguZGV2PjsgR29tZXMsIFZpbmljaXVzDQo+IDx2aW5pY2l1cy5n
b21lc0BpbnRlbC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBSaWNoYXJkIENvY2hyYW4N
Cj4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47IEt1cnQgS2FuemVuYmFjaCA8a3VydEBsaW51
dHJvbml4LmRlPjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5kcmV3IEx1bm4g
PGFuZHJldytuZXRkZXZAbHVubi5jaD47DQo+IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xl
LmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOw0KPiBLZWxsZXIsIEphY29i
IEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEpha3ViIEtpY2luc2tpDQo+IDxrdWJhQGtl
cm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBEYXZpZCBTLiBNaWxs
ZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yDQo+
IDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQ
QVRDSCBpd2wtbmV4dCB2NF0gaWdiOiBSZXRyaWV2ZSBUeA0KPiB0aW1lc3RhbXAgZnJvbSBCSCB3
b3JrcXVldWUNCj4gDQo+IFJldHJpZXZlIFR4IHRpbWVzdGFtcCBmcm9tIHN5c3RlbSBCSCBpbnN0
ZWFkIG9mIHJlZ3VsYXIgc3lzdGVtDQo+IHdvcmtxdWV1ZS4NCj4gDQo+IFRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uIHVzZXMgc2NoZWR1bGVfd29yaygpIHdoaWNoIGlzIGV4ZWN1dGVkIGJ5DQo+
IHRoZSBzeXN0ZW0gd29yayBxdWV1ZSBhbmQga3dvcmtlcnMgdG8gcmV0cmlldmUgVHggdGltZXN0
YW1wcy4gVGhpcw0KPiBpbmNyZWFzZXMgbGF0ZW5jeSBhbmQgY2FuIGxlYWQgdG8gdGltZW91dHMg
aW4gY2FzZSBvZiBoZWF2eSBzeXN0ZW0NCj4gbG9hZC4gaTIxMCBpcyBvZnRlbiB1c2VkIGluIGlu
ZHVzdHJpYWwgc3lzdGVtcywgd2hlcmUgdGltZXN0YW1wDQo+IHRpbWVvdXRzIGNhbiBiZSBmYXRh
bC4NCj4gDQo+IFRoZXJlZm9yZSwgc3dpdGNoIHRvIHRoZSBzeXN0ZW0gQkggd29ya3F1ZXVlcyB3
aGljaCBhcmUgZXhlY3V0ZWQNCj4gZGlyZWN0bHkgYXQgdGhlIGVuZCBvZiB0aGUgSVJRIGhhbmRs
ZXIuDQo+IA0KSSdkIHJlY29tbWVuZCAiZXhlY3V0ZWQgZGlyZWN0bHkgYXQgdGhlIGVuZCBvZiB0
aGUgSVJRIGhhbmRsZXIiIC0+ICJleGVjdXRlZCBpbiBzb2Z0aXJxIGNvbnRleHQgc2hvcnRseSBh
ZnRlciB0aGUgSVJRIGhhbmRsZXIgcmV0dXJucyINCkJ1dCBhbnl3YXkuDQpSZXZpZXdlZC1ieTog
QWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQoNCj4g
VGVzdGVkIG9uIEludGVsIGkyMTAgYW5kIGkzNTAgd2l0aCBwdHA0bC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEt1cnQgS2FuemVuYmFjaCA8a3VydEBsaW51dHJvbml4LmRlPg0KPiAtLS0NCj4gQ2hh
bmdlcyBpbiB2NDoNCj4gLSBVc2UgQkggd29ya3F1ZXVlICh0YXNrbGV0KSBpbnN0ZWFkIG9mIGRv
aW5nIHRpbWVzdGFtcGluZyBpbiBJUlEgcGF0aA0KPiAoSmFrdWIgS2ljaW5za2kpDQo+IC0gTGlu
ayB0byB2MzogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYwMjA1LWlnYl9pcnFfdHMtdjMt
MS0NCj4gMmVmYzdiYzRiODg1QGxpbnV0cm9uaXguZGUNCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+
IC0gU3dpdGNoIGJhY2sgdG8gSVJRLCBidXQgZm9yIGkyMTAgb25seQ0KPiAtIEtlZXAga3dvcmtl
ciBmb3IgYWxsIG90aGVyIE5JQ3MgbGlrZSBpMzUwIChNaXJvc2xhdikNCj4gLSBMaW5rIHRvIHYy
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwODIyLWlnYl9pcnFfdHMtdjItMS0NCj4g
MWFjMzcwNzhhN2E0QGxpbnV0cm9uaXguZGUNCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gU3dp
dGNoIGZyb20gSVJRIHRvIFBUUCBhdXggd29ya2VyIGR1ZSB0byBOVFAgcGVyZm9ybWFuY2UgcmVn
cmVzc2lvbg0KPiAoTWlyb3NsYXYpDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI1MDgxNS1pZ2JfaXJxX3RzLXYxLTEtDQo+IDhjNmZjMDM1MzQyMkBsaW51dHJv
bml4LmRlDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWlu
LmMgfCA0ICsrLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9wdHAuYyAg
fCAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdi
X21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jDQo+
IGluZGV4IGVlOTlmZDhmZDUxMy4uOWZkMjlmZWRiOWY1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYw0KPiBAQCAtNjU3Miw3ICs2NTcyLDcgQEAgbmV0
ZGV2X3R4X3QgaWdiX3htaXRfZnJhbWVfcmluZyhzdHJ1Y3Qgc2tfYnVmZg0KPiAqc2tiLA0KPiAg
CQkJYWRhcHRlci0+cHRwX3R4X3NrYiA9IHNrYl9nZXQoc2tiKTsNCj4gIAkJCWFkYXB0ZXItPnB0
cF90eF9zdGFydCA9IGppZmZpZXM7DQo+ICAJCQlpZiAoYWRhcHRlci0+aHcubWFjLnR5cGUgPT0g
ZTEwMDBfODI1NzYpDQo+IC0JCQkJc2NoZWR1bGVfd29yaygmYWRhcHRlci0+cHRwX3R4X3dvcmsp
Ow0KPiArCQkJCXF1ZXVlX3dvcmsoc3lzdGVtX2JoX3dxLCAmYWRhcHRlci0NCj4gPnB0cF90eF93
b3JrKTsNCj4gIAkJfSBlbHNlIHsNCj4gIAkJCWFkYXB0ZXItPnR4X2h3dHN0YW1wX3NraXBwZWQr
KzsNCj4gIAkJfQ0KPiBAQCAtNzA3Niw3ICs3MDc2LDcgQEAgc3RhdGljIHZvaWQgaWdiX3RzeW5j
X2ludGVycnVwdChzdHJ1Y3QNCj4gaWdiX2FkYXB0ZXIgKmFkYXB0ZXIpDQo+IA0KPiAgCWlmICh0
c2ljciAmIEUxMDAwX1RTSUNSX1RYVFMpIHsNCj4gIAkJLyogcmV0cmlldmUgaGFyZHdhcmUgdGlt
ZXN0YW1wICovDQo+IC0JCXNjaGVkdWxlX3dvcmsoJmFkYXB0ZXItPnB0cF90eF93b3JrKTsNCj4g
KwkJcXVldWVfd29yayhzeXN0ZW1fYmhfd3EsICZhZGFwdGVyLT5wdHBfdHhfd29yayk7DQo+ICAJ
fQ0KPiANCj4gIAlpZiAodHNpY3IgJiBUU0lOVFJfVFQwKQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9wdHAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2lnYi9pZ2JfcHRwLmMNCj4gaW5kZXggYmQ4NWQwMmVjYWRkLi43YjQ0ZjkwOTA2
MzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfcHRw
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9wdHAuYw0KPiBA
QCAtODMyLDcgKzgzMiw3IEBAIHN0YXRpYyB2b2lkIGlnYl9wdHBfdHhfd29yayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QNCj4gKndvcmspDQo+ICAJCWlnYl9wdHBfdHhfaHd0c3RhbXAoYWRhcHRlcik7DQo+
ICAJZWxzZQ0KPiAgCQkvKiByZXNjaGVkdWxlIHRvIGNoZWNrIGxhdGVyICovDQo+IC0JCXNjaGVk
dWxlX3dvcmsoJmFkYXB0ZXItPnB0cF90eF93b3JrKTsNCj4gKwkJcXVldWVfd29yayhzeXN0ZW1f
Ymhfd3EsICZhZGFwdGVyLT5wdHBfdHhfd29yayk7DQo+ICB9DQo+IA0KPiAgc3RhdGljIHZvaWQg
aWdiX3B0cF9vdmVyZmxvd19jaGVjayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+IA0KPiAt
LS0NCj4gYmFzZS1jb21taXQ6IGEwZThjOWE1MDYwZmJkYjcyZmNhNzY3MTY0NDY3YTNjZjJiOGZj
MzANCj4gY2hhbmdlLWlkOiAyMDI1MDgxMy1pZ2JfaXJxX3RzLTFhYTc3Y2M3YjRjYg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBLdXJ0IEthbnplbmJhY2ggPGt1cnRAbGludXRyb25peC5k
ZT4NCg0K

