Return-Path: <netdev+bounces-281015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AndDmWV62m7OgAAu9opvQ
	(envelope-from <netdev+bounces-281015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:08:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2B2461266
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93EB130058CA
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C563D6475;
	Fri, 24 Apr 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyhAAQYU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D943D6CB6;
	Fri, 24 Apr 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046881; cv=fail; b=CyewRc8OrZjJbjb6AOHkf+t5MHO05sCB4eXJoQLm7Htp119auGL+q+rvSsNajRg36BVTQDuq+xPV+2iBZYesNnbfOSEDtnoDASRmUsnD8fowJdvv3j28JgcQhz9vzwYUKSrE/4+CMMZsBAs+77UaS/5eFXAw7s7Y3/V7rM3+3L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046881; c=relaxed/simple;
	bh=RdnrpqyiMdF2AQIXcG4NnRGCJODBA6wlMOI/vMtBYf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TgwlpAAiTTzAhCBvOKwsi+9jtF5oRbjgYHmQgt5I8or+YjZZm+9aU0OhItodGaJ1jU3oxKoIiHnCMPLM3FLC1teSXepvotmJtpG6KAJrHKvgCopPum4tSbYdm91SkxHOc5K+d6TycB1aLHT5fW3dqBN8+cN3P3dk1FKJ8X6s62w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyhAAQYU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777046880; x=1808582880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RdnrpqyiMdF2AQIXcG4NnRGCJODBA6wlMOI/vMtBYf0=;
  b=MyhAAQYUgcv71Ss26ups8N0ALRkSoEgImolybJoXNLb0vRh0AyqHGVZy
   YNUJYFCEZ2TmBmHnB1v1HeuPLR7qx/C/p/oAJ16Z8gsgBgJVOj9RE1mpx
   I2Ct848yDORrZOJFU6/DXiy+RmTEHAZ4bv25urJL1ayDhbeFwJLzgYS7J
   nQ4sKFG5hQ9GXQ8wdm91cnD9IPgl/7OV0p+pW58r764dJ391oaoZNdgsL
   Fipiy5KsKvACDyg1wYrXArIU1o3xHN/C/kunF9Avb7ya2xdQuQZ1YPq/J
   ++Ny2GQodDLrRSpJaKR+buiQPllAoWrUYKxDIz1pgLIq9qOhhfVA7i/lr
   w==;
X-CSE-ConnectionGUID: TyNQ9b09TlSkKO1KGSBnBQ==
X-CSE-MsgGUID: rC11MHnbQHGbPrbQ4ZfBFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="89413095"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89413095"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 09:07:59 -0700
X-CSE-ConnectionGUID: Vjiaz5BWQb+y37rwzkWKGQ==
X-CSE-MsgGUID: mOQs0NTWSLigvL6dD+zs5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="228650021"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 09:07:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 09:07:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 09:07:57 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 09:07:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpAsz5/2U/zsZQ1FZ1W+5top9RpUHaUvDeUv1+A/xbC4ti2TyEBLShOnLHNtp/OnzUUbb5GvegvNP0+hwxrMKr9CzGg/mmP8htxzWvxhqNfO0unCe5iGeq3mS7/snTCLDBHvs+mhdiTK0tM8TK1/4UYsw3KJEcDDEdIOp5QcnwvglXp/9CBu/tatdInVSpiUU4W0PNq0JDD0lJHQFzYLjKCveHw0VqIg5w9wrGE7ZfyHyDx0440V/GXB2i02g9o+kklBReax/DJTb/CS7fOdUC1+QkciM/gcGDrim5QO+N8NQO4YFO+PSEG6/DRXb8cUp1HdhPI5Rx0FGoha4Fh+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdnrpqyiMdF2AQIXcG4NnRGCJODBA6wlMOI/vMtBYf0=;
 b=aLDRFt2agWiW0FpBbvBIa0Ma1CVtr2qonUYluV2LKYSFV2l9anYVMVqmtHPlXaQu+oCyBCsZKBGCIo/D2AL1bRYCA1CwCbF/47EZpdZG4neXkQs17qmUQDOBPSbPlawr49j0diHr3SaHvnd5rhXdmmc8AVOeuz2w63YZiGmd9ydXnYVFpI8+AGkEdE1vBcNpHO/DDSHQvX+B2rKcqY7a9/MNt2qIk4UgmSyqNgkSMpCq0MmrLEJHb5JsEgBlR4TypvYwtdIJqQwmCCrkptass9BK4v3avvdEiZR7XX69eFX5KBVJG/B4vcTZnwDtZ2W6fB9OMx8cpiMfB0Dfhd5hEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF8B3F23403.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::842) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 16:07:52 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 16:07:51 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Li Li <boolli@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Brian Vazquez
	<brianvv@google.com>, "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] libie: log more info when
 virtchnl fails
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] libie: log more info when
 virtchnl fails
Thread-Index: AQHc05i825tHGOMIxEqOum4XlilsCrXuYX3A
Date: Fri, 24 Apr 2026 16:07:51 +0000
Message-ID: <IA3PR11MB898659D8A18DF05024CB56BEE52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260424031545.3777023-1-boolli@google.com>
In-Reply-To: <20260424031545.3777023-1-boolli@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF8B3F23403:EE_
x-ms-office365-filtering-correlation-id: dd3a4b0c-6b96-4319-942d-08dea21ba334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: a+dqy7IV/Tp/hkjzeCBGnxA/XwEwp29EdwIAY+Sx24+WgkNjNGedShxkXcCMQGya9x4SPn9ktBURNufIo6ROutafqEzk0qi7ba0R6o3r6QA5Bkrui/EhBlW8jFanJ2M7DoW4ihVBZhMigsoTZvaZ1blCXgntWlYpMI6Nm2LpY2SDhmYJwhQ8F0JmFi0359LExywQ+aBvBwz+b//DSLjogLDIA1dHwxFu5iptqPNeVdFae1IdlFdeRB5+foDbgddSDEHMvUUTy3pyuXA9wAqjC8kni3qN+NNncOpR/7ukuu+Uz6UXFQkKdCRvT7KEHpleQmucxW+lW6Yegg0GgdwSlKwrllaMseFa5CBbV9okMhmgBiAr5OKMCqLYIL+Ky5r5jgyMyJeO1/m9T5VMtc8pv2OLanY44l3+ktSNk4c5cqC2Oni0e0GwwCCkO1pzw1TZjBYGdhGZlqtEx0gw/1bmSHnFe+7nVqw4mm59Us3azcH2S+ZZj7dFgCuGYxnjUDXUGPuRDF2AIzqWpiD0YRYhRlPHd++60YUU2Tth5bwabXG0+lmzOudN4e5xc4tflDnV0baomWFXPMFVgZKVHcJse0Uw8Hv8FSfmRbrA/IJAL4JmjXpA57X3fNEDeNuGgysYoEOgMFp9Fv1phQQmOOK6fJR6F/Lk3GCb2XdZQDtJy99k51fLr0JvLgQSdbqUgLogQpBJ7+E6pMyy8kq/ULxL7bKwk+xfGBgTyw6Tacw4hF6MqjYomM5oaP5O5AA6Na4hdN7X8qzpEP5Jo4LeIIz8AvBgUoLBvnA6cJf/RYPKwqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVFFV1lqaGtTTFhUcUFXbERQTE5rWVJPSHM3ZTl4VEJZejBORnN1NGhWUCsz?=
 =?utf-8?B?K0Q0NzZua1ZXZHlXQU9SMXNqeU4zZ1hZTE9yNk00YzZQNVgvL3ozTERGbGYx?=
 =?utf-8?B?WEc1THRIeXVqQVJNM1ZjRHhBdkFqbzU2NEZ1V2FPd2NXQnRGanZ4NU9lWFlx?=
 =?utf-8?B?M2lweWpCVXNiQWk1MkJPaUM0VzZTdmlzMkpZdXBnN1pvODFuZnVCeUU1U3Vz?=
 =?utf-8?B?QjczeWg4azJGUFBTTFQya0prK0VvVEZDQWVpZDI3V1I1aklXZkkwNUtmb1Rw?=
 =?utf-8?B?czZOMG9mVkZESmQwUWVXTXk2eU9DbzNJWG92djJwYzhodFVjdnMwL284NnFy?=
 =?utf-8?B?K2s4UWZ2RzBRdE1ETFRiTHoyU0lWVHJVSWx2WFZGRy9La0NYeE01aFkrSjg1?=
 =?utf-8?B?UTBKeDYyTW8reG9yRGlZN1BYTkJsd0xDTDRNZG1PL0xPZE5sdnBUWDZ4OVRV?=
 =?utf-8?B?Z1hiaEd0RUtZTlM5Q0h0MlYrbHRLVmpmUnVEY0VPOVhkZGZqSmF4VVp0NTZy?=
 =?utf-8?B?c0VWNDVQcWRTTGMzVnMwQVA3MDlNdGdvKzNQTHB6WEJMSTFvUnNxUXVMbk1F?=
 =?utf-8?B?ellkUDVBMDVwbkVtU2pvTERIdWxwa0hjTzRvNUZ0amJZOFd4M281dk9XREVo?=
 =?utf-8?B?dWV2MC9QcFd3S1JJN1cyRXZOT3dPVE8yYjFONFV0dFB5Q3BNWDdCWUNoOVNO?=
 =?utf-8?B?azk2cnFLVXU3V3JKNmRvZHM3ZmJwU2djK1VQQTBDUjdXZHpKU3RVMVdrVkdO?=
 =?utf-8?B?aVVUMEllYXQ5dVFwcGRZVGFBZXh0ZUNKOENTNE5qUk9KbUJJN0Y1MjUzMlpj?=
 =?utf-8?B?OExOOUlhL0NBSTlNZlRHcjJFVXk4b2tNeCtsVWxMWTFPVzBkbEdVOW5YMGZS?=
 =?utf-8?B?WmlJNVRyamw2T3MrcVdLRDB5YUdaekRHS04ybnJjYWU0QWVXcTIzTGx2ajJL?=
 =?utf-8?B?Z2JXWXlCNTNLcmhualZJMDI4ZzZhSDJTcFhCNmJYRTNqdkFtdHV4OTFNYmJW?=
 =?utf-8?B?WTdtanczV2JoM1Q5alpPSlNjdE9QSitLeForTzdXbnpTKzRYendmR2hnNnJJ?=
 =?utf-8?B?dElrc3RKaDJkb0dxN05DNDBJMGFzdUxkY1BRVkdFRElpSGZnQVNPWnNUcXg3?=
 =?utf-8?B?ZndkbGF3dDVGOHVrWGhBNkZkSVd5anRkM2xTTWpDcEp3VmJrVk9VVXduaTh6?=
 =?utf-8?B?Q0xkUm1pa3pTVDVWOEJ4QVNVTzBQRHZ1NkVrVVZZRExmN2YvZlRRRXk0dDVB?=
 =?utf-8?B?ZkdKWk00dkhjZVExaW9yRWpqVzFCWklrSUgrMjhwZTBQVTVSc2g3d1BsVE1x?=
 =?utf-8?B?SU1HV2pYbDYyUVNrQjR2YUhCR1YyRFp4RWNMeGdSMnhvMDNkUXptWU9HTTh2?=
 =?utf-8?B?WS9KT2d5VE52STRtSFdxMDRvaG1ZTXNNMWtPeEVYVEdITzlJNE1ZNzNxQWhY?=
 =?utf-8?B?WGw4SUU0bU12UkhwWHpoQ2F1a3FTMG9LSkwxcFdYbXRrcEplL2d3bTJTYnlu?=
 =?utf-8?B?TUEzV3R0aVR6U3YxbWhJQk9nbXVsM09ZZWYrSXhydFlYZXd0a3R4UXdYVm5G?=
 =?utf-8?B?UGo1dVViZGtPRzNsdWk3ckh1R2tsRGFna1dLRHFQdjlvOThJbWpJbzZMY1BX?=
 =?utf-8?B?SEE4Q2U2QlhsWm91Z05pZXpHVzRyOEd1VkUyTlFnVjFRaGFTekNJWHEyM1dh?=
 =?utf-8?B?bjdJb3VaM3liKzBQWUZCWUJsYVJieWpKQk1vcDlsMzZUQnlEV01rOHVLRXE5?=
 =?utf-8?B?TVIxRDhJeEczdnhLVnZqeVZnaXFXWkEyNnNCZ0JWSEJYZ2J3c21rZnBXdmRP?=
 =?utf-8?B?SDVrazV2TWNqTjhDM3R3U21nL1ZzN2F1VW5FOXp4c2IvVFU1aUJFc0FaR3Vw?=
 =?utf-8?B?L2pYcW1NWlpGd0pIQXU4b2dhc1ppZ29KeGlRSWRmenB5L0Y5Wm1Zclkzb1R3?=
 =?utf-8?B?eGMwQVpnRjhLSEZrTEtOT3A2ZG5sYkhLV3hRaWYweU9taXA5cnNkMTJHaUpI?=
 =?utf-8?B?WUpXZXBlc2NlckJRQ1ZHN2FFcHV0L29TUWt3clF6MTZvTFg5TEN1VzJGVEhJ?=
 =?utf-8?B?SU9yRTk1UE9LRlFnN2pxOXB2V1ZReVE4cVZTWkJWMnk3aGlHSm9JcXlkM3pl?=
 =?utf-8?B?Syt3R0swZmRaNmIreUszQmh5OEtpbTZZa0lCT202QllYUWRJbmFvU3dQYllR?=
 =?utf-8?B?SVFlVUdXdWhSK1UyN3dpdEYwY2lPNzlqWTg5aUlEM3BOdW5ub3gvd3NZK1NY?=
 =?utf-8?B?YnJXdU5HVmRVMG1uOWl4M0d6QkVBMElNaXVOa3Z3aWdpRGtwZ1dzOEJFVnFo?=
 =?utf-8?B?Qnp4QlkxZEtPRU1BOUhnNkVOaWVKbEgzVmFzSkN4SjVLMEJkMzVyZlBQbURr?=
 =?utf-8?Q?+AGmL0V3MB+wVjKM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Iif7wyXvqdVQhIjFHqIZutubrBj99HrkPfisGl7HEIkgGn0Y/vnDrSpt2nUiEMQXZDMs9hl2n6iVpJ79pQCU1t48ux6mpH1LqJafm8hh10Zp0f/2Wd9hHzjHMluLyPESqSWWtCeHvixRZnxnegmxk4oM/jxG2aTgd0ZO2TRSOpNrQLRRAdV8HwPxl5qS4y9Piy2pOkNVK5qCJlkvwUuipTyWMhqhuatvq4jsbtTc7PIHSh8iBNPS0Q/ApT06InfRKCTUJCtUk8PSeG+/d73c5ArqdoHofgAcwTxb7J+a4BjHFBt3Ux6PNBl3C/EoHkjqeQ/9ArLmj3uoRTldsT6iNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3a4b0c-6b96-4319-942d-08dea21ba334
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 16:07:51.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLz2uppDteRK+6GG+0uq2jRDemJueDsT0IJPUIH2fusyL7n9n7o19zHFMfrZ5X1yhx+NxxqIU753/lmMlA8gQ8QN2cmtO/2V6ea/rJQLaDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8B3F23403
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8F2B2461266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281015-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTGkg
TGkgdmlhIEludGVsLXdpcmVkLWxhbg0KPiBTZW50OiBGcmlkYXksIEFwcmlsIDI0LCAyMDI2IDU6
MTYgQU0NCj4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNv
bT47IEtpdHN6ZWwsDQo+IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+
OyBEYXZpZCBTLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29t
PjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERhdmlkDQo+IERlY290aWdu
eSA8ZGVjb3RAZ29vZ2xlLmNvbT47IFNpbmdoYWksIEFuamFsaQ0KPiA8YW5qYWxpLnNpbmdoYWlA
aW50ZWwuY29tPjsgU2FtdWRyYWxhLCBTcmlkaGFyDQo+IDxzcmlkaGFyLnNhbXVkcmFsYUBpbnRl
bC5jb20+OyBCcmlhbiBWYXpxdWV6IDxicmlhbnZ2QGdvb2dsZS5jb20+OyBMaQ0KPiBMaSA8Ym9v
bGxpQGdvb2dsZS5jb20+OyBUYW50aWxvdiwgRW1pbCBTIDxlbWlsLnMudGFudGlsb3ZAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHRdIGxpYmll
OiBsb2cgbW9yZSBpbmZvIHdoZW4NCj4gdmlydGNobmwgZmFpbHMNCj4gDQo+IFZpcnRjaG5sIGZh
aWx1cmVzIGNhbiBiZSBoYXJkIHRvIGRlYnVnIHdpdGhvdXQgbG9ncy4gTG9nZ2luZyB0aGUNCj4g
ZGV0YWlscyBvZiB2aXJ0Y2hubCB0cmFuc2FjdGlvbnMgY2FuIGJlIHVzZWZ1bCBmb3IgZGVidWdn
aW5nIHZpcnRjaG5sLQ0KPiByZWxhdGVkIGlzc3Vlcy4NCj4gDQo+IFRlc3RlZDogQnVpbHQgYW5k
IGJvb3RlZCBvbiBhIHRlc3QgbWFjaGluZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpIExpIDxi
b29sbGlAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9s
aWJpZS9jb250cm9scS5jIHwgMTUgKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2xpYmllL2NvbnRyb2xxLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9s
aWJpZS9jb250cm9scS5jDQo+IGluZGV4IGViYzA1MzU1ZTM5ZC4uN2VhYTc3NDEzNjIxIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9saWJpZS9jb250cm9scS5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2xpYmllL2NvbnRyb2xxLmMNCj4gQEAg
LTc2Miw2ICs3NjIsMTYgQEAgbGliaWVfY3RscV94bl9wcm9jZXNzX3JlY3Yoc3RydWN0DQo+IGxp
YmllX2N0bHFfeG5fcmVjdl9wYXJhbXMgKnBhcmFtcywNCj4gIAlzdGF0dXMgPSBjdGxxX21zZy0+
Y2hubF9yZXR2YWwgPyAtRUZBVUxUIDogMDsNCj4gDQo+ICAJeG4gPSAmeG5tLT5yaW5nW3huX2lu
ZGV4XTsNCj4gKw0KPiArCWlmIChjdGxxX21zZy0+Y2hubF9yZXR2YWwpIHsNCj4gKwkJZGV2X2Vy
cl9yYXRlbGltaXRlZCgNCj4gKwkJCXBhcmFtcy0+Y3RscS0+ZGV2LA0KPiArCQkJIk5vbi16ZXJv
IHZpcnRjaG5sIHJldCB2YWwgKG1zZyBvcDogJXUsIHJldCB2YWw6DQo+ICV1LCBtc2dfY29va2ll
OiAldSwgZGF0YV9sZW46ICV1KTsgeG4gb3A6ICV1LCBpZDogJXUsIGNvb2tpZTogJXVcbiIsDQo+
ICsJCQljdGxxX21zZy0+Y2hubF9vcGNvZGUsIGN0bHFfbXNnLT5jaG5sX3JldHZhbCwNCj4gKwkJ
CW1zZ19jb29raWUsIGN0bHFfbXNnLT5kYXRhX2xlbiwgeG4tDQo+ID52aXJ0Y2hubF9vcGNvZGUs
DQo+ICsJCQl4bi0+aW5kZXgsIHhuLT5jb29raWUpOw0KPiArCX0NCj4gKw0KPiAgCWlmIChjdGxx
X21zZy0+Y2hubF9vcGNvZGUgIT0geG4tPnZpcnRjaG5sX29wY29kZSB8fA0KPiAgCSAgICBtc2df
Y29va2llICE9IHhuLT5jb29raWUpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gQEAgLTEwMTEsNiAr
MTAyMSwxMSBAQCBpbnQgbGliaWVfY3RscV94bl9zZW5kKHN0cnVjdA0KPiBsaWJpZV9jdGxxX3hu
X3NlbmRfcGFyYW1zICpwYXJhbXMpDQo+ICAJCXBhcmFtcy0+cmVjdl9tZW0gPSB4bi0+cmVjdl9t
ZW07DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+ICsJCWRldl9ub3RpY2VfcmF0ZWxpbWl0
ZWQoDQo+ICsJCQlwYXJhbXMtPmN0bHEtPmRldiwNCj4gKwkJCSJUcmFuc2FjdGlvbiBmYWlsZWQg
KG9wICV1LCB4biBzdGF0ZTogJWQsIGlkOiAldSwNCj4gY29va2llOiAldSwgc2l6ZTogJXp1KVxu
IiwNCj4gKwkJCXBhcmFtcy0+Y2hubF9vcGNvZGUsIHhuLT5zdGF0ZSwgeG4tPmluZGV4LCB4bi0N
Cj4gPmNvb2tpZSwNCj4gKwkJCXhuLT5yZWN2X21lbS5pb3ZfbGVuKTsNCkZvciBtZSBkZXZfbm90
aWNlX3JhdGVsaW1pdGVkKCkgbGV2ZWwgaXMgbG93IGZvciBhIGZhaWx1cmUgbWVzc2FnZXMuDQpX
aHkgbm90IGRldl93YXJuX3JhdGVsaW1pdGVkKCkgaW5zdGVhZD8NCg0KPiAgCQlyZXQgPSAtRUJB
RE1TRzsNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAtLQ0KPiAyLjU0LjAucmMyLjU0NC5nYzdhZTJk
NWJiOC1nb29nDQoNCg==

