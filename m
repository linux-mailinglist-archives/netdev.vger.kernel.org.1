Return-Path: <netdev+bounces-278422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBzgDJYo3mmSoQkAu9opvQ
	(envelope-from <netdev+bounces-278422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:44:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB16D3F9875
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D6A23011C9A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB93A3E0228;
	Tue, 14 Apr 2026 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LU9BhU9A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72E3E0224
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167060; cv=fail; b=M29r+UqVO+jUbAHDGgOpv4ChLabcLiwKdCOIdyxNHVlxq5gy8dTVBZf+AUsyxaVExSN0NcWJhgnmaNxztU85AmeTIjT5Cc3/eFq4nOfmZdiPXzIv7D/4MY5Vun6wpj42D1RZ4ieVf8Ct36JZbHRpddeMAfbPvl5pLlXpQ3CMS7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167060; c=relaxed/simple;
	bh=4Ry1zqIJczr8awQT7Y4Rfwmk/odxaHuopKvSt4BKKNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B02+cWd2piK/Ih84G9/nRoMxwYMo365X2SWvJQdek42iHbBgSuXLnL+LR0r70sdzxqXMe4ziExsOdS9hzsKeUVoFSswJweSUsEY1IfZPSkZNm/TXvlQVYbc+S+qouVznohTDyLznr5C+9EF2vNfy81yxSyoZ0roGHNwY02E4JbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LU9BhU9A; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776167059; x=1807703059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Ry1zqIJczr8awQT7Y4Rfwmk/odxaHuopKvSt4BKKNo=;
  b=LU9BhU9A6OAVox0h4uoDk4A+2Ba8jew4oQk9G2Ti2WOJ+Fk8hielXScl
   2EPAiUuRymHFAg8DV2hQZ2Q8TcRDoaSevWJtbQ3fYUhh5tg8hcYqIVq0O
   3m9XoXyiITp4VJfFW9tA+zsbZqJqdCPrIuuoYn8n3SXqiyO9ppeJ/sAkK
   u5ch4aruRg6yktc2dCQYsPSBxwca7nna7iJ5UQXRaWQErF8Y+FcXv7TF6
   zfXXb1NjCvmMBJA2e3Jp8cL879R8awhiMiYUVUAv+4Pjm+/BhRp3Oql1Y
   yDCSLmzBc18RnnPGJYFFIUi2jaX12pZ/F/JZGLtyYnfV2EXwCkE7vumt1
   w==;
X-CSE-ConnectionGUID: rX/1VFKnR/e7b8d5bfyZWA==
X-CSE-MsgGUID: IYduLJ0mSsGCUirJPCjjxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="64656912"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="64656912"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:44:19 -0700
X-CSE-ConnectionGUID: YpaQR9bVQv6Zs3MaoEQdSA==
X-CSE-MsgGUID: F8oF5zolSriD5yhAVJOI6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227418921"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:44:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:44:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 04:44:18 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:44:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ia6EOT5B4WSzbxOcppwRfN7ypDOGDRNfeJPghIY8OXYKJR7jmtTbYAyf7k/nzIvC7cq/Mg0f38EE/lq38GHSfzErgBWXaC2mkl9QzN9YGB5uRkvhFpljgHiC8jREjtvli0F7Ux9r9YGOHR2ZznrKJkUcbdq0l+hg51tfRneNM4FnBmqNiBOU3TTowsNFuNHOkfm0uqt5g+3cbA4Fa+DUMVWrZCy0hyO4owt9UkZVuQItwZEe4uw8P0iuEu098GSRHQ4jeZ4PlVbgiwgna645AHuKZkoJ7zb5vTCnK9UTzE5SwpeAqcTBS+rCZg750ZwAniStrhRpwofAiD6HKVqTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ry1zqIJczr8awQT7Y4Rfwmk/odxaHuopKvSt4BKKNo=;
 b=LnzZoPoZ+vf8PAPBBP10f2PmZ0/fAg7oyfwYc1va5TkUCtZGtr/9wF2vKiliGi/sgN1NMY/0+CzFTmz4YCjhtsjWV9ClEvHWV67gHVzXJjZXddqYkcWzglKlZCXkrNjudVDWabFAItmDYjiRGSkjyDjKnucO+8CWvIXmXtzF4/x1stllkyo79fUuUhIxXldY5j22PvPLLk9DWkyHmYBaSetlC/Kspe1s6sXh2nelvpsCDKKns8XphBi/nVjDsQ8Y5UfOlvBxiV3JqadogA3bH0RQHELeYAo1CpflZtL71Js3eMrYUe4ErtZs7evYo3ABloYYxjShT/xxcul14zoXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by DS7PR11MB7929.namprd11.prod.outlook.com (2603:10b6:8:e5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Tue, 14 Apr 2026 11:44:10 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.20.9745.019; Tue, 14 Apr 2026
 11:44:10 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Szycik, Marcin" <marcin.szycik@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] ice: call netif_keep_dst()
 once when entering switchdev mode
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] ice: call netif_keep_dst()
 once when entering switchdev mode
Thread-Index: AQHcx2IRzsWFPFUIRE+ld79JF8Bh+rXVOPyAgAlALAA=
Date: Tue, 14 Apr 2026 11:44:10 +0000
Message-ID: <IA3PR11MB93014842883BF4BE5B53D3F98A252@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260408141429.2798589-1-aleksandr.loktionov@intel.com>
 <d87f554d-ef86-44c7-9585-0a3806cc5752@molgen.mpg.de>
In-Reply-To: <d87f554d-ef86-44c7-9585-0a3806cc5752@molgen.mpg.de>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|DS7PR11MB7929:EE_
x-ms-office365-filtering-correlation-id: 8dd357da-6ae1-44ed-448a-08de9a1b24b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: aIiNEoOL8L+4Xya+NNy8u9fXTY+6SEw7UHNLya3+0MMHMsEBKo0V6a545ft0qIua4VZ89Q3W1wh3oy0s+HnNLniro7Te2LysPD14v4gyKrv9asaciM6cPmVFNRdKBY+nwHGqTILzTmL4ucGs0evm103Wx9q0FmkCnylbdaCPWsJWap4VzFaXshjXoc5e2Va1cvGkhcJ1OuuN7R+Hua8QhuONuVAWEr43Bx1pMEEX60xd4krF7sw1gx+vsFs39vS2+IMZLwTQYMQRCyaPKIQZSISPPwF+TTd4Oi7iCv4tMZk+Wkv37NoflMSZFrXMmDPChrE17yLkFrKo2J1shFLuXhRNTOm3NDBeYE81kJCOUri+VEOf9xpPreohdAj8mrzuy/RYO9cND/DwUeZhaTGyrTLsLSL2Jqqg0MahzgiE9eWDCF3Fo+DuI/MKvMrfnX3pqDFMkoEnCDUNAQkoDmJfr+LCpuYarhi4P1d6Lk3xj6VYpxlOr5Yn+l/1vGPXPkUVGlg3n/BiShGTe0ZCY4rtrbrUJdPFEv7j1Hy1xWxENhmO4W7x+MHlIWFKGDfj6CmDGL65l051QsSyud18i86UUqe+VVD9SZKPo19urvHhvS9H8BayclQhhB9+bMJysIwCFHWtYGpKpVz+jJaWe6JADQM+keh8hneaoj6jYigK5NQLUU/j2gbdd2Dg8OmcIdQbGshAosGXptTTYlWCSAKCk6Vk6ap533KEZJ2s6IMMl8Qua7KcL+LJmdDrJ1Ad0CONKtv8hYXXEXr2kj8RA/EOIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWxaUjBkbVEySU9QS05iYzJERHJZbmZoVTdybkFrNHNJNmNueFFLQUZiaisr?=
 =?utf-8?B?UWtSc1hDbGoxR0pLY3ZPL0hUZTNWQ2FkZkpNelV1MmY5M3lHemFqekR2VmZ1?=
 =?utf-8?B?YWEyc2dveGRwYXB6YkNwZytqVnZ4WnBKa0NjZksrYk40amMwMnN3R1phaW56?=
 =?utf-8?B?ZVEyUWdiVldOZUNoU2N1UE03YzJkQ1VHZW40WCtTSUdwREJPRUsvU3pwTDNx?=
 =?utf-8?B?OW1OMmhLbUtiblg1N3dWRG5yeU1VRHU2eGdpc0dobTh3eVo3cnVBZmhxN3M0?=
 =?utf-8?B?WU5oVmxKaEp4WGw2NTlEVlRGOWhMOTNMNEJOTld1bVBLcWRnUFF0dDNJV1FK?=
 =?utf-8?B?MzlJQ2JydjgxTmd3aVhQaGZTMGN6S2JmRWpQdUdGWmZuWVBmWklHTnRpK0p0?=
 =?utf-8?B?UjFDVm9JM3BZUm1wUlh6RDhIbHlkVUFoZE1aQnovRy9tUXVWOCtHaVZOSlJz?=
 =?utf-8?B?aGE4TnM3NFZTTldONUxjamdjUnRKMEtGbzJ0ZzkrakU1ektLcklROVNDM0JG?=
 =?utf-8?B?N2E2eUtEVmdnWGtLdUFSWm9Gcld1SzhveUFUUytlRkM1bUlncGlhbENUNXo4?=
 =?utf-8?B?SEErU09odFFUc3NibjUydWpyVEZLVEFEY3huamtxcG5GTk1OVFFLblN6aXM4?=
 =?utf-8?B?UzFwWFlxZksxbEh2cVUvZllhdG8xTlVPblNrV1pTMVErYldWRFlsa3lNcUZS?=
 =?utf-8?B?UWF3SkdxQzNYZFdoVWpEdW1ibVRnQmtBajM1WUZJWFIyMUhZendveTF2eFN4?=
 =?utf-8?B?THQ5UmkzK0NTbXY4S01odERRQUZ2NDFJNUdvcVM2UGx4YjV2eUEwbDQrRFFD?=
 =?utf-8?B?dGpURXVTay9pMGhBR0ZUeGlmL2dxaGdqbjdwRUVCbDJFbkJZOHFJRm9vam96?=
 =?utf-8?B?ZDBNanJEOU1tTDF1dDRnUHFGN1N3bGQwVVBsZ01aY2ViODltcEdnSlNmZm1z?=
 =?utf-8?B?UmJiNXZGYmE4NHhwZ0FXdldjNXVybzNTSEhFWXF4Wm9ramNEZklYUHE0RkRZ?=
 =?utf-8?B?Z3JEdm9ldnc5SFplMHFTd0svaVdhZDF0UUxXL1JsM3VpbjlRMzl4aXUraHZp?=
 =?utf-8?B?SU5YRklUUjVET0o0UVJBaGVSVlFuUVhsemRLV1ptS2Q3cXJtazd6eUpiKzIv?=
 =?utf-8?B?YUk3c1VyREJjYXJEUjQ0TlR2WEVKRjBCMDliZ3NnZE9kd000VUtBTG9ONUtZ?=
 =?utf-8?B?eWdrWEtqbjZ2ZDF6YTkzRXU1QjhmeXVEeTg5UXFzaVVqd2xLUGRxemk0TlFC?=
 =?utf-8?B?NXhMeEswdGhSSXRqVHpxcGduUEFLUlRaUlJSaVI2U2ZaaVdCa0sxZTRIYjN4?=
 =?utf-8?B?NFZzYVNZSjczYVp5N2JUOGlISDBtNmgrcEVzNFVtUFBzVm1aajJxYVZlbnIr?=
 =?utf-8?B?ZkVTUFlieXlNdnp5N2JTa0QrZzZGZ3BBOUxYWWNPVmRDMXh1Tjc3aUJqZm5h?=
 =?utf-8?B?QmN3VWgvais1T2FoU3oyT0FhRExTMSt3RHRHa2tQZHJKRTdJaXQyc3NZZ0k1?=
 =?utf-8?B?eXJjUDdlR3dTckNkOXprSXJXZjdsRUFhVFhIR1ZWM3kzbEJvMCtEenJPa3N3?=
 =?utf-8?B?c1IwTnFBazhkN1lRZkJsYlRCTGZNNmdUcEdDVUp3T0N0ZStEU2hCS2VNbXU3?=
 =?utf-8?B?ZEtub2tVVWV6R2g0VEN0TStZc3lxbUNZVXd2cDFvNk9KUGhwaklEY2U1RUNY?=
 =?utf-8?B?amhOekh1OGNrSndMYVhFY0VDYndCMVBuSHIyczVjR0I4RGo5bmw0WjF3dTVs?=
 =?utf-8?B?N3lvZ3dab2VoRUNDbHJjTE11K0tWTzJYRzg5aGNOcW1HeTB6bjJXdVp5VzdH?=
 =?utf-8?B?bW9KdDUzbi83UjZYY2VpZzkrWDVNWTZ3QjRaT3N6UGZHSldZc0lyWXV3aFNw?=
 =?utf-8?B?UitmeTlqa21RSFlNTWl0bDFxa3BZZXljRlplUVFUV1BFNVlLRyt3alhKZTBw?=
 =?utf-8?B?M3hPRloyUGZNQzBySEJSTStHb3dsM0xBNDNNZzhOdisrNU5UUHVZM01hOEpv?=
 =?utf-8?B?enNtKzRXRkNHV1ZBTnhVOTR1aWxCQlZXVkFzSm1Yc2RrVnVIN2VsSU9YV2xB?=
 =?utf-8?B?cFdiMmxTODVQTWZmWklzMDVneVg4UllyZnNzYkxEYVNYY29xNVlQUnoyeU5N?=
 =?utf-8?B?YTY1TlVjZFNPSm5raEZwZnM0NStPSm1hZFZONExQN3dmV1lMRGhuc3phajdu?=
 =?utf-8?B?ZEY5cC9hTVMrZFY4d1gvYmhLY0M0OFljTWhuYlJCbGhpS210NXB3eTZsS2Qy?=
 =?utf-8?B?OWlraHozRlhlTkNRRHRmdmd6bjh0ZlVXS043Wmk4VmpKdVFGT1AzYmFhS0pw?=
 =?utf-8?B?YWo4bTQ1VFRpNHM2aXh1ejFDRU1sZVVoOHBzdkdqVjNDZ01xRjBjUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JaktIJLE0wCbEmvPB+gSInBuuG6ZArGgluHQl1VMPzOHvbUJlL04JoGi1avCB0m22crS6xijKKQPCebxrC8gVeb3I5XmsVpU54Pcuxq6lpqxSGaQirrvQiCHH3hNHbHcsdK593cl/MVZqDsmwC4LrxG3FZb3izRqL6MXvDBq89XAFAQ18w7+W+JGyeKMKkgWcTPvd41e44BVZp9jDyRDx2Du6MqvyK/qYnkaUAZ9CjSdwqwNTuzUQKzc5hoHXhiVuccN28kuTIAZf74eFG4RnWgr42Yr+he8f/cy2MYKI25yRWWgsDqCoC/NxZOTXc/ASsltM1BNlM54p2xaRMcmqw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd357da-6ae1-44ed-448a-08de9a1b24b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:44:10.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NArSZZzV2agkg0MZdrvx7vWistVssdL6vzXeeyzsK9faaCHr9qrYYqVuz0A99xR5NAuXjHFUmFUfGYKOkESBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7929
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278422-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,IA3PR11MB9301.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,mpg.de:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patryk.holda@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EB16D3F9875
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBQYXVsIE1l
bnplbA0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDgsIDIwMjYgNDoyOCBQTQ0KPiBUbzogTG9r
dGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiBDYzog
aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IE5ndXllbiwgQW50aG9ueSBMDQo+IDxh
bnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFN6eWNp
aywgTWFyY2luDQo+IDxtYXJjaW4uc3p5Y2lrQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtJ
bnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2Ml0gaWNlOiBjYWxsIG5ldGlmX2tlZXBf
ZHN0KCkNCj4gb25jZSB3aGVuIGVudGVyaW5nIHN3aXRjaGRldiBtb2RlDQo+IA0KPiBEZWFyIEFs
ZWtzYW5kciwgZGVhciBNYXJjaW4sDQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2gu
DQo+IA0KPiBBbSAwOC4wNC4yNiB1bSAxNjoxNCBzY2hyaWViIEFsZWtzYW5kciBMb2t0aW9ub3Y6
DQo+ID4gRnJvbTogTWFyY2luIFN6eWNpayA8bWFyY2luLnN6eWNpa0BpbnRlbC5jb20+DQo+ID4N
Cj4gPiBuZXRpZl9rZWVwX2RzdCgpIG9ubHkgbmVlZHMgdG8gYmUgY2FsbGVkIG9uY2UgZm9yIHRo
ZSB1cGxpbmsgVlNJLCBub3QNCj4gPiBvbmNlIGZvciBlYWNoIHBvcnQgcmVwcmVzZW50b3IuICBN
b3ZlIGl0IGZyb20gaWNlX2Vzd2l0Y2hfc2V0dXBfcmVwcigpDQo+ID4gdG8gaWNlX2Vzd2l0Y2hf
ZW5hYmxlX3N3aXRjaGRldigpLg0KPiANCj4gSXTigJlkIGJlIGdyZWF0LCBpZiB5b3UgY291bGQg
c2hhcmUgdGhlIGNvbW1hbmRzLCBob3cgdG8gdmVyaWZ5IHlvdXIgY2hhbmdlLg0KPiANCj4gPiBG
aXhlczogZGVmZDUyNDU1YWVlICgiaWNlOiBkbyBUeCB0aHJvdWdoIFBGIG5ldGRldiBpbiBzbG93
LXBhdGgiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmNpbiBTenljaWsgPG1hcmNpbi5zenljaWtA
aW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtz
YW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IHYxIC0+IHYyOg0KPiA+ICAg
LSBWZXJpZmllZCBGaXhlczogdGFnIHZpYSBiaXNlY3QgLSBkZWZkNTI0NTVhZWUgaW50cm9kdWNl
ZCB0aGUgcmVkdW5kYW50DQo+ID4gICAgIHBlci1yZXByIGNhbGwgdG8gbmV0aWZfa2VlcF9kc3Qo
dXBsaW5rX3ZzaS0+bmV0ZGV2KSBieSBjaGFuZ2luZyB0aGUNCj4gPiAgICAgdGFyZ2V0IG5ldGRl
diB0byB0aGUgdXBsaW5rIFZTSSBpbnNpZGUgdGhlIHBlci1yZXByZXNlbnRvciBzZXR1cA0KPiA+
ICAgICBmdW5jdGlvbi4gQmVmb3JlIHRoYXQgY29tbWl0LCBlYWNoIGNhbGwgd2FzIG9uIGEgZGlz
dGluY3QgcmVwci0+bmV0ZGV2DQo+ID4gICAgIHNvIG5vIEZpeGVzOiBwcmVkYXRpbmcgaXQgYXBw
bGllcy4NCj4gPg0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9lc3dp
dGNoLmMgfCA0ICsrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9lc3dpdGNoLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2ljZS9pY2VfZXN3aXRjaC5jDQo+ID4gaW5kZXggMmU0ZjA5Ni4uYzMwZTI3YiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2Vzd2l0Y2guYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXN3aXRjaC5jDQo+ID4g
QEAgLTExNyw4ICsxMTcsNiBAQCBzdGF0aWMgaW50IGljZV9lc3dpdGNoX3NldHVwX3JlcHIoc3Ry
dWN0IGljZV9wZg0KPiAqcGYsIHN0cnVjdCBpY2VfcmVwciAqcmVwcikNCj4gPiAgIAlpZiAoIXJl
cHItPmRzdCkNCj4gPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4NCj4gPiAtCW5ldGlmX2tlZXBf
ZHN0KHVwbGlua192c2ktPm5ldGRldik7DQo+ID4gLQ0KPiA+ICAgCWRzdCA9IHJlcHItPmRzdDsN
Cj4gPiAgIAlkc3QtPnUucG9ydF9pbmZvLnBvcnRfaWQgPSB2c2ktPnZzaV9udW07DQo+ID4gICAJ
ZHN0LT51LnBvcnRfaW5mby5sb3dlcl9kZXYgPSB1cGxpbmtfdnNpLT5uZXRkZXY7IEBAIC0zMTIs
NiArMzEwLDgNCj4gPiBAQCBzdGF0aWMgaW50IGljZV9lc3dpdGNoX2VuYWJsZV9zd2l0Y2hkZXYo
c3RydWN0IGljZV9wZiAqcGYpDQo+ID4gICAJaWYgKGljZV9lc3dpdGNoX2JyX29mZmxvYWRzX2lu
aXQocGYpKQ0KPiA+ICAgCQlnb3RvIGVycl9icl9vZmZsb2FkczsNCj4gPg0KPiA+ICsJbmV0aWZf
a2VlcF9kc3QodXBsaW5rX3ZzaS0+bmV0ZGV2KTsNCj4gPiArDQo+ID4gICAJcGYtPmVzd2l0Y2gu
aXNfcnVubmluZyA9IHRydWU7DQo+ID4NCj4gPiAgIAlyZXR1cm4gMDsNCj4gDQo+IFJldmlld2Vk
LWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiANCj4gDQo+IEtpbmQg
cmVnYXJkcywNCj4gDQo+IFBhdWwNCg0KVGVzdGVkLWJ5OiBQYXRyeWsgSG9sZGEgPHBhdHJ5ay5o
b2xkYUBpbnRlbC5jb20+wqANCg0K

