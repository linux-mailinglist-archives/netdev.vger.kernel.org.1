Return-Path: <netdev+bounces-79483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A7D87974D
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 16:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C11C1C20FEE
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2C7C096;
	Tue, 12 Mar 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrydpL/+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402C7CF0E
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256611; cv=fail; b=Y1FuLlOBHQIyI+TMlTjKvu4VNfAZROPpZdUW2BfSUXgZJMYWo0WF7i6sfsgbUpaYeYqf+f8WU6twIeu4pfmO2FypPixjTt6Pe526euAya9R3d6Nwq0mqWTkdq05HQoXqMcfy38Sceg1UTnfXY7HcFvPO6qVrj279XEtwRqr9EkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256611; c=relaxed/simple;
	bh=4g0e3YT0ZmVQIfvQ6c9+8vVuMriLeed37qyKWr3jyps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iulo8weud7q3qmNcaAYd27EaAUbFF++CcoF2LsexWinct8Ui6wJ/CF4BI8lD2sje41NYVmsEcCqG05XtkPu9WGJx4zsDPf2ow6C8Yrl6TDdGjg9h3lOwGTYPy1mPiakcD7bomPWAOBylEPT7GrtjTrhEYXqDFzguNyr8o0MpEO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrydpL/+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710256610; x=1741792610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4g0e3YT0ZmVQIfvQ6c9+8vVuMriLeed37qyKWr3jyps=;
  b=UrydpL/+b2ehnFHAKcYrliBbAPJpnE+911L2wx93IBHbc6Us7WukaT3O
   947GxtndgcHEY4ySCoxh++L+jbcU6OLpIeLfAZYq4Qw+AYWFqlqgAlciY
   fTF1WxKZMXSBY50UV1CI6yUq2b26/GyholYtYd6Gp8CzHfZqQqBkWkq0G
   1x0/3GUbR86BfVJx3joOB11t2vxIzK5BX5ME5KVmClCjh1Cgohfz1o622
   6u5OUOeuMLUQMSieC2muM/zHxkfEbBYKezb/CBEb0/lJ6oIvW6Rfe2B+/
   Q6ZO8XB4o9JXtC4E5A9av6lW5wcDaefH04DePQr0GysHe60X74jKyTnwV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5141345"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5141345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11478267"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 08:16:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 08:16:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 08:16:46 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 08:16:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdLPF4u11zm3mXhDMsm0Pq4kfnfcfowMPdB5Z0/Im5Wk1Ys0Sb4obnFIrcaRZ1nbPePjDzWA08oNSguz9fvXxG/gvnbrnTNIYM1GzsUlU/018VJFi1+24yIXbootF4NYExOrbnAklMq+nSVGKgpTc3TULv6Hi/T3a3qQKVAfNnEHQ5XTT836QHr0RitOvQIb86DCsCvAHyaAO68llb0xDlp7QNysNRjyVGIjZbgfT1KbpCCH2e4eyB2c6evZaStMAWmnNNtjsAri2QlDNcAjJ/GmGqtKUPemzsOF1lod724qh2sruqffM8IXARjTwulr6nxHw6KPWMJDKkAlrVEqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbzy1f2nWkNuZ4DwdraOIKEJM7/0iYZ73um/Ruh5gtU=;
 b=AHk+DEK5+EndDwHSRkxE6V6mPTU2i90L6J0q3PB+G4WJizqRII79HvUnntJyNmPAsi69KGvcYHjDYfH7/e1E8uaiVy+o6Yh/vRbJSKhdMiGB3YW6nUWVTeRE2Feye4Jwzt79XM5ANT4zIc3C3jgClXiAvHjetwb0GZN0JDN0Qwp3zvMH2UxBEOXLVH9c8A1nrgJG0JI8Jwd/HyIeCBYbqVRkyWE18/zvQFQPh0iSMcAr+WJ4W/rxfx6hz9rFRXMAqb0HgnMEGH2aqQLqIfMGZ0chPdfQl+Elq9MQpOUheZgsf4O3gvrc1oBoAiW9FIOwLqSSNVfDIFTYpeoyEgtWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by MW3PR11MB4601.namprd11.prod.outlook.com (2603:10b6:303:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 15:16:43 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7386.016; Tue, 12 Mar 2024
 15:16:43 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "horms@kernel.org"
	<horms@kernel.org>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "Elliott, Rob" <elliott@hpe.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix memory corruption
 bug with suspend and rebuild
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix memory corruption
 bug with suspend and rebuild
Thread-Index: AQHab1Fa6MyEPvaLYEuyNBD5raiWqrE0QSEQ
Date: Tue, 12 Mar 2024 15:16:43 +0000
Message-ID: <CYYPR11MB84296F0E205598814A792099BD2B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240305230204.448724-1-jesse.brandeburg@intel.com>
In-Reply-To: <20240305230204.448724-1-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|MW3PR11MB4601:EE_
x-ms-office365-filtering-correlation-id: bb743eb3-6e10-4904-4ee1-08dc42a76d2a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qB6JsGrQIuvE3oc/ReXmTuERmELOcKDz4HDxGXgfDLwXDMlvQT9VBEbkdzFVLjvCOKtJSJLB4V34P9JpkEr6kNFkuz5zqpxnRNBUsLi4+h40IHcw0S2GP2gdx1q49ATF4nNqyfhZgraXNhzC7QBICgzFEi9/rbPuxnLqIXU7bB7dP3liuD3RvIYW/end6DiL0H36IKQYOnnbpen4t/8JBPk3blLBI9QJAA6baD7oa6rLtWQyxU5AnV6+5D6TMnPVDUtVQ4HCFgxITyy2AwNRvNTNwdfnHRVi6SYAkiqVRQ18LxTpob24r0DHqLg04hwGXYki0qzGSdA5pIO6Ycr5KIT+pPJ43dHutdd975nPng42OmeIQbvDwkiGUE2VVnD9aVfVoZ6i3Q//+J1d8LCek3anTPjtpeMDQow6RIEHlnVEIt06OgzpG05b1xnHUE8taji+HsGTUmclZ2ABhDAKzNY8XWeoWAtABvGZxR5E4WYeGpttypDBK6CH2MTN3HmW0Tz6vHpZ4DpeVEcAp+/IpLpIvLsS7h2mYFLki459wtpfaYRR4oybJAHJ4zq+U5wGCOHdyHNX7tkztAghp4DkBYWS2MvDj2ETuILm/45ytx/++tGJqLxSOUn1y5Q5Lx6eJf+nvhRRCSW8wdqAQqkB/3T5aVA96VFxQVQjqfTgfQJShZK0oAK3b7n+E+SRXReHIDKvIhkRn9D+OQ/+IRGnfJvalg8M6X28Bg6hO/rpwT8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TA3UscvZ/z5m5qFrM/7cy3DeLNA76MfRlHR+ZAwXFEX0KpH0o8fNTeKy/HCh?=
 =?us-ascii?Q?8jzaSzMqVlBcFx8EEfWhRpx9PBHlOCzgZfhLVs7WRthfl8uuRN7L+73B7IOb?=
 =?us-ascii?Q?kzUaFKgIH1jnz2x5zNSeTMLVsnOot/r5spo970lvbNseZE67y3THnm3ATb/E?=
 =?us-ascii?Q?mRscJcbQp8yTExXkIBVA0QPJ1Ms2x+zCoK8yABrf4IEfC1RzK1L3D39C1YcJ?=
 =?us-ascii?Q?Tr+As9xChePXwdqD5DmrniyQj6bJCK2a9f3kljTgKEyx1+GLja4UI8E8Z0J0?=
 =?us-ascii?Q?NjOS7ya6dLRRXArKg4wHDaWwME/uarXMsmDw3Ovm4/aBxzN+DLEuXiL32bDd?=
 =?us-ascii?Q?U3arTvLOve4McC2N3Yydt+x7a1Kf1WljnzREF+z4X+5qpOfSbAktlHCTaQsP?=
 =?us-ascii?Q?prY4yRvUNFd0XVdQSzCC2brgBjA2CDZztlHRBNrDmHzWOapEQv+eBfmzHJTj?=
 =?us-ascii?Q?5JemaL2Uq82ZD8BngkYUetI6eWmRfHYIl1qO7sGJTvjqKpPI3kS6X8M+bgkB?=
 =?us-ascii?Q?74ai8CROlRAB4+15LmwRogH04PV8zHPUg6kh8U3DpOjziyz+jnq66pgt2/Dj?=
 =?us-ascii?Q?bdMv7M/N4Ub+E4cMDbdMeRdMFwoIQ+aJl+m/dac1qhdAndOwxeriigMmXRor?=
 =?us-ascii?Q?Vgb/cxjFLuFoL+EAzXC7lbrg6M1dq+CuefcvFf5YxqOSgclji9YfGHxCDuN7?=
 =?us-ascii?Q?Bqqb+t5x+pWMlxv1CXCJeNIqq2Npj1GhDUJWzEYt/ddTSlFAUkD4v/w7wGHz?=
 =?us-ascii?Q?KZ7cEqCqEDHRVyclh8K4BcGN3uP3DihDnjzKSM5g9TSfSzHviD3Aq2puuAV3?=
 =?us-ascii?Q?6dsxUTjg0JkUWw51xSZ7EeCDuV2dDUk8jEhibbxMvpEO58rEqZoQDsm8ZpVz?=
 =?us-ascii?Q?YxWXEvR7nw6/bDQobAZ07VtoSWOqOjCU6xtRe2VEpeYoOT8o/idqJIdiOfqu?=
 =?us-ascii?Q?W4EHs1prIkJbQRGMrLzTTgEaJ3WHufGs6/FnMGvWxWlhNHKGPSe6SKMVPoxu?=
 =?us-ascii?Q?krWMMRNUzqLZZMRolgBf7TleWbsOOnRJ/VwODBznIR7CLAosFyFDi/9EcGRx?=
 =?us-ascii?Q?9HOmXzyIlcOS5X9suwBgNsCPQXGRnX92tTdfmrKTZ9vc64/8a0boKOJ6T3s5?=
 =?us-ascii?Q?+z7j+vguhTGtkTYR22YxNuWPBeczEtcXcsln2suIN3Vi4+EjcbdC4paLzLa1?=
 =?us-ascii?Q?6prJHwnZgXBujnnZ6mNT/N4Xq76bV2jKeRukHN7VqCsHSJxzVPcqZv5U6fjX?=
 =?us-ascii?Q?Up0wPj/MQ118QVu9KtquAnIq2N6nbR5Z2xZuEtCkr2VHmL44Up5Z8Oxx6yKn?=
 =?us-ascii?Q?EWlmFR2NcKvUZsGGrTTgyD8YVn1ebNh9AhFeWsZCAsR/FniifXJCSDxfY+7P?=
 =?us-ascii?Q?HD8gPyS4ogrzxQRfUPt1uITPlljrQFk8uNXJO7thcxBsFnYntL7ErUusr3Bd?=
 =?us-ascii?Q?JtVQcvPXz/L9IvICmdCNTul9ry2uf4FIrYw/v5x1ZfrbWNqfwnpxQsI23/MG?=
 =?us-ascii?Q?0gl4B0bfR/SKeUSJc5/28tBeSMXaG0/ayBw0pZUxArGdxVoF+/rj0qk0blru?=
 =?us-ascii?Q?YMB/3/bMVmob9WvqZtZzBoXDDETYSPdlZL/VgJBs6K8ukEQLm0pK/9zoMKKj?=
 =?us-ascii?Q?7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb743eb3-6e10-4904-4ee1-08dc42a76d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 15:16:43.7837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: johoNJtxUSBp+tYxKYv1wPHWGu9QV9UF03GIjiclaImRhjrvSAYfYBfbus2y9VywLfqEWimLqhbhuRLFRvW2BT+hI5NKFSaOH7CyN0AVJ/j/S6qa1dWYzxPMCyiKKntk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4601
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Wednesday, March 6, 2024 4:32 AM
> To: pmenzel@molgen.mpg.de; intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel=
.com>; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthony.l.ngu=
yen@intel.com>; horms@kernel.org; Michal Swiatkowski <michal.swiatkowski@li=
nux.intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redha=
t.com>; David S. Miller <davem@davemloft.net>; Elliott, Rob <elliott@hpe.co=
m>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix memory corruption =
bug with suspend and rebuild
>
> The ice driver would previously panic after suspend. This is caused from =
the driver *only* calling the ice_vsi_free_q_vectors() function by itself, =
when it is suspending. Since commit b3e7b3a6ee92 ("ice: prevent NULL pointe=
r deref during reload") the driver has zeroed out num_q_vectors, and only r=
estored it in ice_vsi_cfg_def().
>
> This further causes the ice_rebuild() function to allocate a zero length =
buffer, after which num_q_vectors is updated, and then the new value of num=
_q_vectors is used to index into the zero length buffer, which corrupts mem=
ory.
>
> The fix entails making sure all the code referencing num_q_vectors only d=
oes so after it has been reset via ice_vsi_cfg_def().
>
> I didn't perform a full bisect, but I was able to test against 6.1.77 ker=
nel and that ice driver works fine for suspend/resume with no panic, so som=
etime since then, this problem was introduced.
>
> Also clean up an un-needed init of a local variable in the function being=
 modified.
>
> PANIC from 6.8.0-rc1:
>
> [1026674.915596] PM: suspend exit
> [1026675.664697] ice 0000:17:00.1: PTP reset successful [1026675.664707] =
ice 0000:17:00.1: 2755 msecs passed between update to cached PHC time [1026=
675.667660] ice 0000:b1:00.0: PTP reset successful [1026675.675944] ice 000=
0:b1:00.0: 2832 msecs passed between update to cached PHC time [1026677.137=
733] ixgbe 0000:31:00.0 ens787: NIC Link is Up 1 Gbps, Flow Control: None [=
1026677.190201] BUG: kernel NULL pointer dereference, address: 000000000000=
0010 [1026677.192753] ice 0000:17:00.0: PTP reset successful [1026677.19276=
4] ice 0000:17:00.0: 4548 msecs passed between update to cached PHC time [1=
026677.197928] #PF: supervisor read access in kernel mode [1026677.197933] =
#PF: error_code(0x0000) - not-present page [1026677.197937] PGD 1557a7067 P=
4D 0 [1026677.212133] ice 0000:b1:00.1: PTP reset successful [1026677.21214=
3] ice 0000:b1:00.1: 4344 msecs passed between update to cached PHC time [1=
026677.212575] > [1026677.243142] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [1026677.247918] CPU: 23 PID: 42790 Comm: kworker/23:0 Kdump: loaded Tain=
ted: G        W          6.8.0-rc1+ #1
> [1026677.257989] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBS=
TD, BIOS SE5C620.86B.01.01.0005.2202160810 02/16/2022 [1026677.269367] Work=
queue: ice ice_service_task [ice] [1026677.274592] RIP: 0010:ice_vsi_rebuil=
d_set_coalesce+0x130/0x1e0 [ice] [1026677.281421] Code: 0f 84 3a ff ff ff 4=
1 0f b7 74 ec 02 66 89 b0 22 02 00 00 81 e6 ff 1f 00 00 e8 ec fd ff ff e9 3=
5 ff ff ff 48 8b 43 30 49 63 ed <41> 0f b7 34 24 41 83 c5 01 48 8b 3c e8 66=
 89 b7 aa 02 00 00 81 e6 [1026677.300877] RSP: 0018:ff3be62a6399bcc0 EFLAGS=
: 00010202 [1026677.306556] RAX: ff28691e28980828 RBX: ff28691e41099828 RCX=
: 0000000000188000 [1026677.314148] RDX: 0000000000000000 RSI: 000000000000=
0010 RDI: ff28691e41099828 [1026677.321730] RBP: 0000000000000000 R08: 0000=
000000000000 R09: 0000000000000000 [1026677.329311] R10: 0000000000000007 R=
11: ffffffffffffffc0 R12: 0000000000000010 [1026677.336896] R13: 0000000000=
000000 R14: 0000000000000000 R15: ff28691e0eaa81a0 [1026677.344472] FS:  00=
00000000000000(0000) GS:ff28693cbffc0000(0000) knlGS:0000000000000000 [1026=
677.353000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [1026677.3591=
95] CR2: 0000000000000010 CR3: 0000000128df4001 CR4: 0000000000771ef0 [1026=
677.366779] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00 [1026677.374369] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400 [1026677.381952] PKRU: 55555554 [1026677.385116] Call Trace:
> [1026677.388023]  <TASK>
> [1026677.390589]  ? __die+0x20/0x70
> [1026677.394105]  ? page_fault_oops+0x82/0x160 [1026677.398576]  ? do_use=
r_addr_fault+0x65/0x6a0 [1026677.403307]  ? exc_page_fault+0x6a/0x150 [1026=
677.407694]  ? asm_exc_page_fault+0x22/0x30 [1026677.412349]  ? ice_vsi_reb=
uild_set_coalesce+0x130/0x1e0 [ice] [1026677.418614]  ice_vsi_rebuild+0x34b=
/0x3c0 [ice] [1026677.423583]  ice_vsi_rebuild_by_type+0x76/0x180 [ice] [10=
26677.429147]  ice_rebuild+0x18b/0x520 [ice] [1026677.433746]  ? delay_tsc+=
0x8f/0xc0 [1026677.437630]  ice_do_reset+0xa3/0x190 [ice] [1026677.442231] =
 ice_service_task+0x26/0x440 [ice] [1026677.447180]  process_one_work+0x174=
/0x340 [1026677.451669]  worker_thread+0x27e/0x390 [1026677.455890]  ? __pf=
x_worker_thread+0x10/0x10 [1026677.460627]  kthread+0xee/0x120 [1026677.464=
235]  ? __pfx_kthread+0x10/0x10 [1026677.468445]  ret_from_fork+0x2d/0x50 [=
1026677.472476]  ? __pfx_kthread+0x10/0x10 [1026677.476671]  ret_from_fork_=
asm+0x1b/0x30 [1026677.481050]  </TASK>
>=20
> Fixes: b3e7b3a6ee92 ("ice: prevent NULL pointer deref during reload")
> Reported-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: fix uninitialized coalesce pointer on the exit path by moving the kfr=
ee to the later goto (simon), reword commit message (paul)
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


