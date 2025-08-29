Return-Path: <netdev+bounces-218381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA32B3C41C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE14A649D8
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC4321454;
	Fri, 29 Aug 2025 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwKIOQYb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785091F4C8C;
	Fri, 29 Aug 2025 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501866; cv=fail; b=GFfesjOa+83UmASUn71/uJPKXaexCKflk71gYYf6rKXEEzEwbxhZv7eo1ZQ5SAVBdsoK+UFXVk/6yWAMK3xQFOO4uq60D9qGgA8X2EVfJTNEgNA5ETlVBa22JRAxwlbB4gXnvfSje2S5B9JH+pizlYdooMtHO3FRPUaioO/KrYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501866; c=relaxed/simple;
	bh=7uR/WlJSeWsPW8n3dGRSaZVO1iR+e82NpQnpV9ULtVs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QE65myfAw5lLonv4z/bdfpbtOlmbVJBPItL4VsMFAy4ESxM8C1pXf7LP4yJULoKSTHvqFcItn8kvKDSsDofjmTz4L/b/OhH7NdXA+d1RruB5Ogw3t9lg6fp6qWg/NCgK6axTpbvTd7BzLT8hKJg6vIaSHpx//Ymm0yxLCXqfEjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwKIOQYb; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756501865; x=1788037865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=7uR/WlJSeWsPW8n3dGRSaZVO1iR+e82NpQnpV9ULtVs=;
  b=iwKIOQYb5zfyxAcau5A15v4bcYg6TnBTPFlTKRg2MKsXQbHsVKqvc0F6
   26fD+ny6p5PdhGY7nESJCwvUrKumHKYpbVDVUlzuhMdO825ksY6Suc2F9
   jj+UG1R5KqDriwQ1UhWtqlnwKmYW43zapI4FCmzds3oev8GmE2GKKUT1b
   TY1ch/XM1yrWWaTxTcbLZAzHmWpD/fQmt9+kd7kNXH9CtdnzPZ/ipDBV0
   StFjagEopHQYlwctcDxuMoX2BKHkHFelGmsZT3EtncRr+pjjHB0fFpAVq
   IqiHVSWB1CD+NPuyuKuTyh45OMZ7VC8UmkQglbVEGAjKJ66zzccF31Qu3
   Q==;
X-CSE-ConnectionGUID: Ltq9VIdxSRSP9BBm+W8w7Q==
X-CSE-MsgGUID: rAGWNS+NTdmqBtxafKEJDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="62613923"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="62613923"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:11:04 -0700
X-CSE-ConnectionGUID: vkmkPi3BQEGyWpuaTjknxQ==
X-CSE-MsgGUID: l3LtdgmOS4qgpgISt0IS8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="169766359"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:11:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:11:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 14:11:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKwud3H75ooLuYfnZ61c2ZdkM/wpQIXfrOUuVNAqd1j9yf3bcFY/taQJei36exQHMhgkhxg8Y8ShwORnW2W94n6iDeMUtFamKNYKuc8JNEvTUPfrBsF/f+rrgx2+vz5Sk3aMx6vN8MaACtdtnE+SCV670PeLIeEH418K9Nqo0y0igbkUAt8YI/64PNFJQrdjMYG6E3IM3pG2QzpUD/L3VWBSs22CGFHeHzHpc0RuC5PF5YF07FZRHjsiKpM4HEOStYIbCktAAEHQvS1ViY8LMLh01wSwqeym1cAaPMB+3D/k6ttS9iTI9TkxhJ9IJEJclnQvy4J8ts3ec8CuXBIqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvMN0I/mdH7XGtQNUexDPftHs7iZP8sQvwSqJ9H/yF0=;
 b=RVVJs/jOZ2sANl/m9gipW97uHZAR7/BKaFmucbf/8FC7sed5qYfAFdXcdqpIrJpwCm/axnRAUcUxjPsEOVQxXXNtza21K2zwDc6NmP89LQF+Kdg9VqERw988izvu3vxkkde2Bi43M4dydA4Yyo8FYaafKIBucDKXVz8vqaQjOnt9gFTrelaO7Wpx8fPwgG875faS8jq0h5YSBWwSWMYXU7arERSLwHpnmMWfEQbPEcXKBibA2C7cUf6iyK0F1ApTXlVObWLAcdP5MI8LO5A9vjNdeDdH5ExopE6xFICDhMz4giRWu7ezWHnb0FpfqqF4OG2aYn/Cmf6OZs74uAvFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6903.namprd11.prod.outlook.com (2603:10b6:510:228::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Fri, 29 Aug
 2025 21:10:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 21:10:48 +0000
Message-ID: <d90e41fa-ee7d-4934-a139-b138866a076e@intel.com>
Date: Fri, 29 Aug 2025 14:10:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: Convert APM XGene MDIO to
 DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Iyappan Subramanian
	<iyappan@os.amperecomputing.com>, Keyur Chudgar
	<keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250829202817.1271907-1-robh@kernel.org>
 <20250829202817.1271907-2-robh@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250829202817.1271907-2-robh@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------YmmxsAA725pDztm9PaDxnqJe"
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eac3c76-078c-4f4d-3d68-08dde7408723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzVRdHZUNVlvZnZJdXdWMC9DRkhaUDV5by9xeGJybjg1L2UreEhkVDdnSUxU?=
 =?utf-8?B?MExEczRHWVBFMCtGMm9oR1ZoWVorYVQya2lFN252bG9rK0FHUkx2UGhBYWRI?=
 =?utf-8?B?Z2kzclg0eVRjSnVWWUcxV252ckJWMFhDZzkzNGw3VlR4Yk5ScFR4NWkwS25C?=
 =?utf-8?B?TDJEc1VCTEI4bm5Td3lqTUZoQmNjdUNXeG1xUDNPak1aLy83Q1l3NlZ4SFQz?=
 =?utf-8?B?U3FhOU5OR1VrTDBtL0xiVElpT1c5M3pPMU95d0V5djlQb0xXUWVwcFJPNWVJ?=
 =?utf-8?B?eW0xb0s2VlF1SVR6RnB0V2wzdjEvbnYxcm1NVlgwVUtEcnBRSXRLYnROc3lu?=
 =?utf-8?B?WG41OUVEbzhNNFpocTNsd0Q0T1piZ0xTM2EyM1NGd3luMHFBQlMwUWhqZytS?=
 =?utf-8?B?OTdnclBoT0RDaXZyMU1PNHJJeERaTGtBdlA0YlhIYlRKaU9oNXhvTXlzd0Vz?=
 =?utf-8?B?Q2xScXRBandoaUZQV3lHT2o3U1hHWC9pS3I2TFpybENGcTkrT2lXK0twelV4?=
 =?utf-8?B?WGJmQUcxalAweEViV25YdU9FenE1U1BEeHh5VkJkZWpqMm43WFFrZ2RvTkEy?=
 =?utf-8?B?Rmh2NXdzQUtpSk1RRnJHNGkwaUlJSGxHSjBrV3hmclZ6WU9SOFpraU1hdTBO?=
 =?utf-8?B?YjJ4bHFIbEdZWGNXSWlVRDdHOFJ5cXp6bEVQNS9mNjdhVkRzK1c3azA3RVdN?=
 =?utf-8?B?SFpwbjNhSE9wSEhvak5hYzlHc1JrcXZ1a0Jtb0NHOGNUYnhGMnFEcnFPODlW?=
 =?utf-8?B?OGxhSHphZ1UxQ2h3NFc1TGdrSnAxVkxJNUZPNXRUMkg0WmVGbDdyWWlyVndW?=
 =?utf-8?B?c1lzTWI2MEpKT0h3UVFmSzgwNFhWTTA3MjFVcmF4aldBZFNpdS9VbHZSZDhj?=
 =?utf-8?B?S3VYK3IrSVBiT2ltWUtDdDFQdFRMandaMFZMdXBtVENVWWhrM1hoeUc0SE5k?=
 =?utf-8?B?RStmUmsxaU9rWStjOStNTUFsTUVwTC8yZ2VMR1JaSnZnNE1Jak9vNFhmQ0gx?=
 =?utf-8?B?SlpnbTNXVjlUbkpjVVZuWkFhc3FFcFE4WnA3eDZndVVlU1Awc3FkMWp3ODhK?=
 =?utf-8?B?eWVoNTd0R2FzWW5lRXo2R2c1dlJ1bk9JUVhld1A1K055OGo2YlA5U3dsRWZr?=
 =?utf-8?B?eW51dlVVTVFXWFRLRXBkbVRjU3l5U0FOMi9NM05RQ21tSDNNMlFOWE5kekxL?=
 =?utf-8?B?d21aOEQ1L1VjRVo2ZTMyZnhJYUE4a1JHeHRTdDZtbnQvbXQvRFFhRGU0L1dh?=
 =?utf-8?B?bWZFZzZVNU1IeUlDa0xiZG1rWU9QU2F3N0E4S25acjVmS290SVVWUjMvOE1a?=
 =?utf-8?B?cFd1dFJKZDBaTDhtZlNGVXM5ak5FMitXNXQ5V2lzZHRqc1Z3Q1dySWFnekRp?=
 =?utf-8?B?cTB1Vit3bElqNENheCtvNDZsZnkydUY3MjA0VDJSTFNRVEFLM0UwbWcvSDBl?=
 =?utf-8?B?aW5GZHhvdHlUWS9XMGpMTXJ3R2NvV0xXQm9lQnJXV0EveHU1azB5WkpQMmhZ?=
 =?utf-8?B?UjNxblBQK29iOHBTaU96a2xJN2tGdkUyeG1mM0hhYUdFbkpnZ0VMZy91bEQx?=
 =?utf-8?B?clNNbFdEakdDSWhpc0hxOGZZSkRBZ2JqRFZ1bFVSbnlHRDk1dHJqc2ZDRWov?=
 =?utf-8?B?ZGtUN0lxOU82RlpEY0NiR21GdDhOM1FaYzgxOVVUL3NNUmphRlVSNXg4cTZ1?=
 =?utf-8?B?U0dhalVIczlBekpjd3hVNW1oNVUyem84eDgwNlh0VXlBeWY2dEFiZVlJTTl3?=
 =?utf-8?B?akdMTUFwbGl4VGZVV1dENDF2bW1JOXZzYXZZU1BZL3JPeTNlK3BtWlJ5RVBl?=
 =?utf-8?B?SHhVblIxc2tCMjA0MzhTb29zRHFmVXRPY0p2QThQbXliNklkQ0p2d0ZVcyth?=
 =?utf-8?B?VDVQWG5KVGNodEVyNE1wYVJiM050UzVJNExGSlJEOC9PUmVyUHFTV3puN2pq?=
 =?utf-8?B?QVY3OVoyVml1K00wcjEzNCtpalhsWVE3Qm5lN0ZvVlEzZm5CNDYyemt2L2JV?=
 =?utf-8?B?RUhFcmVBd1JnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHVmYWtwMzVDU3IxMElDMU1seUNGYmNxc1BXa0FjNUJEOEltZ1lTeFNtWVh2?=
 =?utf-8?B?TVRvWVNlVloyOG5ERDZYV0lVay93U0JqN0ZIVTNscHVFRzk1aXRDMDA1dllj?=
 =?utf-8?B?ZXJwc2JJeTZmbWhtZ3VYN3ZScFZkMFozUFFTV3VSbmhVZUVGSFhma3NvQ2lM?=
 =?utf-8?B?ZkFiNWN1QVJjNCtMalFpQTNzL3VJUTkzSmZ3R1dQMlhhYURCbXBEbk1yS0lF?=
 =?utf-8?B?VEdKTkNmWmN1R0dicnJWVTNXUjlFbDQrZXJnSTVXa0N1aldqQWh1dmtxTDNx?=
 =?utf-8?B?Z1dnQ09rcWZLQ2J2WVZYZko3OWpSNXdQbnUxMExueW4ycEVyblhkMEs1dUJx?=
 =?utf-8?B?Qmxod3VvLzZmMHlnWW9nTUlEeUtCTUc2aWI3NXFmUS9lNGM3SzJDM1FaWjFB?=
 =?utf-8?B?dWpJaEdmb2ZMNHhEWHdPQTRFYTNXQzRITXYyNFRzd1IySnB0Y0o1cUc0TTEv?=
 =?utf-8?B?NTZnZ2hrbG8xYys3VWh5RWsrOWVQcU04cWtjMFZMUTUySHc2SDVMcXhIdk5C?=
 =?utf-8?B?dmR2VjZweUJQZE9abDVZSGFqTGM4eUdiR0ZxUFQ2bDFJQ1hyaWRkSFVyVDRN?=
 =?utf-8?B?Vy9OVFRKK29nS0hIYXRlMFZjQkRsYldFNEtweHpBaE9oTFdrZWQvQ05WOXhO?=
 =?utf-8?B?R3RQMTlReXdRMHFsQk5hMFF6MENVdDArdWlvdStyb2MzakdFRXNTMDA5NWdB?=
 =?utf-8?B?dDljcUd1czVwQmh0TUIxTG4yVDhCc1pTZkRldWs1ZElDTmdySW9Lb1ZQaEp6?=
 =?utf-8?B?YWJtRTR5UnhIWkI2dUU2eUtpZ21NT3RzS09VVVFtanBENC82eno4OVFUTnRT?=
 =?utf-8?B?aXY5d2w3RmdINCtwNlpzYVNSME5Pb1FFdThaTWxBQnBETXBEMm1XZzFjbldY?=
 =?utf-8?B?VGUrY2Q4cFRNbWlPYmxEeEQxNmRDUFJ0ckxEQWpZSlBNYzUwaUZJZ1B1QVZu?=
 =?utf-8?B?Tm50Zk9NdExOMnZGNnhIOFRuWmtjMW5MbkU2cXBCM2I2cVR6b1pqYUJHcC9N?=
 =?utf-8?B?SmRWYk93bTRmSEJ3Z29XWXlYdGsydFpKWEpEam1RL1A3VFljbkNXMkI2a0Zn?=
 =?utf-8?B?aXc5ZDNvV3hEckFjeDhrWlQwUlk1N2dJTzJycXpzcC9pSitLZkNCbDlFMjJP?=
 =?utf-8?B?Z0dWdk9GS1c2aXJHQ0NvVVNVbTYvVklGVzluWEt0UnVkN0tNSFNGVDNHWDFr?=
 =?utf-8?B?S0xTVDRlUkJDTzEyczBOZWVESUh1Y0N2cTYwVkx0L2R0MFQwcjJNd0R6YWx4?=
 =?utf-8?B?Y2hQNGdWSXFocEZnMkJGYTJUT3JqMnp5ekNlcFVYWkE4RVo1blBPVzdqL2tL?=
 =?utf-8?B?L2J5Tm53aktFYldqNnBBUC84cmFDV2oyVHB6ZWJ3TVlsTjhHQ3BFaHpWbUJV?=
 =?utf-8?B?K3ZCeXBOQ3c5MUlKMXBpbTB4Mm5RSXlGQWRJTDZLZ1J3M2lHbTJHTHQ0YWxG?=
 =?utf-8?B?YkdXZkdGSTBhNjArSlUxK3NyWGs1K2Y1Z0NWREt6ZWhrUkhBQVpFNm5oV1Na?=
 =?utf-8?B?UXVVQzArVytSb3hoYk5XbzZqS0luVURtTGxKRisxYko1NlRXcnliZzdlNXJn?=
 =?utf-8?B?a2VFK2phRUxqbkFZanBwdDJOQ05pRHRFMHBqVHJ4cDNoL20wVk5kczhYclVt?=
 =?utf-8?B?bEtzVXUwQWJIRndvaXNIMkNQcHZXeE5qaWhZLzFyZXpFbWdjRDJvTHFuS3pY?=
 =?utf-8?B?QlJKYXg4OFlXbUtvd00xa1dWbFlQKzFjWkltWFpTMjR0NU1sdnNQSCttMmhL?=
 =?utf-8?B?TVU2RjVyL3VEVjJpU1lrOGpsU3kxeTdGMzdJTVdodlNVbnU3ZDM3WjcvVWV6?=
 =?utf-8?B?SG5BdkVlSTJqVENXWDdjSzZCOE5aUzFPbjJNQVJUNHF6ZWJ4TTJYL255cThL?=
 =?utf-8?B?T1NUUGVzQkpzeXpqN0xxMHFaWVhkY2UxOTNNZEFKcElmRVBJM2JFY0dUSm1l?=
 =?utf-8?B?TkliQjFMak1ZejkwSHpYZWhJWEhuRmx0YmY0TGZBaVY0d29rYk1QM0M1TGZI?=
 =?utf-8?B?b05hSnpHVVlDQnJ3NjV5N0dkVDdIN05KTjQ4M1FyZXhqUlV0ejA3d3kwaUNv?=
 =?utf-8?B?RzBsUUh3SDF6UHp5bE9taTlGd0lUc2MrV2RBRk5acWF3YlpNc2Q5TWM1VnNy?=
 =?utf-8?B?TUhJZXRSRG5icEtpK3NoNEdISzZHa0QzbncvU1l3cG9FWDd2Q3ZjQkZpbVV1?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eac3c76-078c-4f4d-3d68-08dde7408723
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:10:48.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92IgcoKAcpyJ+GZdowIiI3lGm+Bsu4GLxOIdZs9ckCIPdkop1ijhKmxPo8a4lPRBFrRJ3ZbdQ2h6RpJGJUOO4R8n2/RN1jVKVMK2yGvtVZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6903
X-OriginatorOrg: intel.com

--------------YmmxsAA725pDztm9PaDxnqJe
Content-Type: multipart/mixed; boundary="------------mCHXmMXCZq8XgeVFpYZy4ZK3";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <d90e41fa-ee7d-4934-a139-b138866a076e@intel.com>
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: Convert APM XGene MDIO to
 DT schema
References: <20250829202817.1271907-1-robh@kernel.org>
 <20250829202817.1271907-2-robh@kernel.org>
In-Reply-To: <20250829202817.1271907-2-robh@kernel.org>

--------------mCHXmMXCZq8XgeVFpYZy4ZK3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/29/2025 1:28 PM, Rob Herring (Arm) wrote:
> Convert the APM XGene MDIO bus binding to DT schema format. It's a
> straight-forward conversion.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/apm,xgene-mdio-rgmii.yaml    | 54 +++++++++++++++++++=

>  .../bindings/net/apm-xgene-mdio.txt           | 37 -------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 55 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/apm,xgene-mdi=
o-rgmii.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/apm-xgene-mdi=
o.txt
>=20
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------mCHXmMXCZq8XgeVFpYZy4ZK3--

--------------YmmxsAA725pDztm9PaDxnqJe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLIXVwUDAAAAAAAKCRBqll0+bw8o6BIj
AQDeTYdO374b1KZJqmcay9fTKFAI/cOFqiVgAKXVNwpneQD+JyOU4+oI/6H2e0upAb189CR57qCG
hzAW02gGU455XQw=
=lYs8
-----END PGP SIGNATURE-----

--------------YmmxsAA725pDztm9PaDxnqJe--

