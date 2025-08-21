Return-Path: <netdev+bounces-215701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017F0B2FEEB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921B864571E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A608276022;
	Thu, 21 Aug 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7/9iRdj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3F28504C
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790239; cv=fail; b=iFQqVyBM9PvsqEFrVSBO15GRfOTMO96ibo3pYCUdy3P2fMrvZeltfpnOP8DAEb5S7v16kPx2YmVJzG+S0PmJcYlQf8a1M7XgDK5L3PT49UaKzJErfBfehM1flXbMaNB9/R7y2RFtwnBgjJzHlMcfWFVVYkzxajbs3ZAct9oAyiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790239; c=relaxed/simple;
	bh=gqKbE4/REAiizkZx6IHb5gnZ2vHAlw5sUKSg+vgb+To=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M6VYwNP6vNBYV8lNYEKCTWm07PyY75jNPJM0wcMQ4SX4cn8tuPiyuQz7coIJD9Bbp4YLhSpCZ8jE7NmMLQjSloC9IDbxuLukt1mqJsfDYUYErJ1t8qsNywWPg+7ME/eLQDhdyf4kz4D9fR8mO+yqw8EsU1kuph9CaozKD/AH/CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7/9iRdj; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755790238; x=1787326238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=gqKbE4/REAiizkZx6IHb5gnZ2vHAlw5sUKSg+vgb+To=;
  b=W7/9iRdj+uykHreId/PlxK7lnXK3iohrgdgLkqQiePJEVOqHHZY/nbIu
   rPINk4FckMYtlafreQePhyEaOVTzW3PmZ7f4sYQb52zDeH+Fe4aSdNWKu
   khiTmZPIr9gdpbHn4LgqY61v7rNzqgqELJowaGGvnmdL+unQ5zKwxoihH
   U2qAV/GS+fq+OMZQTr6htZkbXo648p9PIYZ2d0xRLi0Jt8LY4E3zZ9GzE
   +V3dE1aDPmVmk1hNLzHTXKOuP2VueKyX1af9eRKL6RyweXaCk2+iG1zPS
   NjSaDBuaVMInbaO29Km6283QWQGlffdjneulR6qrzgaJFlk9+qNHcpQUM
   g==;
X-CSE-ConnectionGUID: Ti07KxKnQIyAjvIAz3JQJw==
X-CSE-MsgGUID: jso5aAqYTJK6QaD7zmvNLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58231441"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="asc'?scan'208";a="58231441"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:30:33 -0700
X-CSE-ConnectionGUID: cv7WuXzSRNK6fmR7Z6Mapw==
X-CSE-MsgGUID: uuyOjKLvQcCKuU/X3fn2sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="asc'?scan'208";a="167950998"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:30:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 08:30:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 08:30:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.79) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 08:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoVlV1nNHvNl5jecl3kORNzsnb/dLCWHtgp1ixCST+Q13G3r9wInC+EgsxyiVMlEJJ14Ex2ab5Z4Csg4Cq4aD2nBw9P/Oc4sbkPAHNT3u9PWdysXrOupdcrwtBNyad1eSN46su36Z/6t+83EB42F6xL8A4U3UsBWwAfruMmT3tJBYvTGCBEJ6HumZ0r3LOru7LsNd3R+oWZO1GSvK84Yp8CMdxVJhW8AW8WdXLYPD6MdLSUs2+Qc0ByTNaDbkU6UU1JYNdpssaSqFIP8EPcikMTOHXaElumOF9d7JJb6bBPNw686jBRacxzLg5WmwjABVUxyvi4zK5NguK+r3ew/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjSrY2MMZMtpnmzWJsxXaNyxQdYRkzT9DCF9t/8xEYk=;
 b=F6YrHKW5hSBvwX9bEUo1xlDUg+4D4CYivQLAHHJtX/zMoi8GVo8E3qzQCT/zIItfSUXa+ftlqcJsMaIVXN63AJnWFZDunxIHpqFPAN4fpr+wIF6nOXSRuHamMZBSt/oP1YV2IVhYfcpDQBIPUw2mBVUxFSB6WlU50ubwd3i901g4mnSC7IZXPzvZdaqDLrjy4BuMIwv0Oo1RLO2x1rRRw/bOpnVa4G9KdVZg8J/uyBR5eBuWjjq+Yy2xP5dgHCKMGLZgMU+iJIe9oXYD+RgGQVPQqiEJyBMejFdTn15nUN8RV/kdMpzRGqV+Lu/LrmpjjsIGdKkbvRsJsP6DqG6dfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5301.namprd11.prod.outlook.com (2603:10b6:208:309::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Thu, 21 Aug
 2025 15:30:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:30:27 +0000
Message-ID: <c7ee1e4f-9e1f-43c4-9fc2-0bc92f682aa4@intel.com>
Date: Thu, 21 Aug 2025 08:30:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
To: mohammad heib <mheib@redhat.com>, Simon Horman <horms@kernel.org>
CC: David Hill <dhill@redhat.com>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20250805134042.2604897-1-dhill@redhat.com>
 <20250805134042.2604897-2-dhill@redhat.com>
 <20250805195249.GB61519@horms.kernel.org>
 <6133c0c5-8a1a-48c3-9083-8cd307293120@intel.com>
 <20250808130115.GA1705@horms.kernel.org>
 <CANQtZ2wffk6jUTTMYFgTYxWQBc=hmw7nAkbYB2kxt-1ihUP9Rw@mail.gmail.com>
 <f5c3b451-0a8d-4146-8e47-be2c7e2d6284@redhat.com>
 <6d7fdf16-3ed8-47b2-a872-164f1b6d5937@intel.com>
 <24473594-c77d-44f5-9311-57d67c558cb7@redhat.com>
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
In-Reply-To: <24473594-c77d-44f5-9311-57d67c558cb7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------ssoBO3YmpHPlhmWp1feYsxZx"
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: 310deab2-3410-465c-8002-08dde0c7a79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlkyVE9RSlVQbTN2WVNYN1VtTC9ldVhGNm9pSkEvOW43VzFsVmRUT2JxYXpW?=
 =?utf-8?B?MTl2dGpvdC9YWDhlRHNMRDYzSTRLMzdhM3JjcFQvN1p5MElxU255Um5oazU0?=
 =?utf-8?B?ejlmZ1ZESG9xQmtyc3dBVnBJdExiUnhVeVpsWGE3QUVHK0VBTmdpQ25tY0c2?=
 =?utf-8?B?V1JXRHlGSlhhMlJGNkVON0liQ1VRbHFPbmlSQW9xa2NjeDN5dEhCVUdKU2Uv?=
 =?utf-8?B?bGdHWm5oVHFadllQM1dqbThkbE10SElQK1AyRzZpWllTYUNGc2lMQXVrWnBr?=
 =?utf-8?B?UDNUWVB3UlltZW8vQjdvc2tBaVV6VG4rUU9LVlNxVlljcXdLTW9ZemkxUUp1?=
 =?utf-8?B?ekc2M2thWGhxU2s5djNhT2pIUy9TdEJlbVovK3RqM2xhM2V2cG1EQldCbmNm?=
 =?utf-8?B?OTRXVFN2RjBtR2RLWGNHdTY3NWFqSFdjYWxSSEw3dWRneGtZOG1wZTRVS0VW?=
 =?utf-8?B?cmpMMm9SblE1T0g3UG9aRWM5cjduTWxaRUFaajVyaHFhSzVYaFpFMVkxaEc1?=
 =?utf-8?B?QmptNTN4eXZFczdkNGZPbWZxQTh6MWNOd3l5bjlIN3BMT2JDR1FqQjl4MTFi?=
 =?utf-8?B?dUNmYVE4QWJtbVNQQ29qZWR2d1hUSm14UEhPR0VZQWVFQkRiV0swMnQvVTZY?=
 =?utf-8?B?ZFZ3QUN5K0NZeit5eGJ3WUM4S20yZmhMOTNpd1BFVnFiZngrRHVlTVlObGdT?=
 =?utf-8?B?MUMzR01VUjNKNyt2THI0bTlPRDQzcXhIai9DR3JvUzRqdnU0UGJvV1QvK09F?=
 =?utf-8?B?bVJ6TUE5cDVCZ1MzM1pmRElFalpZWGZDcmZWZTl1c05taVl2RXhJeFh5OTNz?=
 =?utf-8?B?ZkpZLzFkZWNXcTZEZ0tuUzNMRzhubFpCdHpkNWdLU2xzVUlpK3ZrWk4rcHdD?=
 =?utf-8?B?bXc5VHpmZDF1RDRNK0RHYjRRMmVSZ3c4Vy8yQ0N5VnBYNERCK3RIU2hTajdE?=
 =?utf-8?B?K1VBRDdDcDN2K2s5QVNJQWVRNDRSckFnV1B2YTY2UmpZTUxIdTExWUJpVElX?=
 =?utf-8?B?VnJ5cWl3WkY4QTJyaW9iOXhWYUhteGtyRzR4YXNwS2R2ZWZXL1cvNHArb1hW?=
 =?utf-8?B?elUxWUhidTMzMnVkMDV3N2FUWlRqNzdCMFpCdm9uL0ZVUEVKMUpTemZ6dzVW?=
 =?utf-8?B?VEtFUHhiMjRtOTVkQXg2ejlzZ1pNK2V3Rk52KzZhMHc0WFZ4RlZGV1hqUS9s?=
 =?utf-8?B?QUo3YnpBSHZGUCtpRjgwRWZobkkvbjlaR2VqaFh5RkRsVkNmSVBMbFFCaENQ?=
 =?utf-8?B?L0JFTGJUZU0yNDcrU2k3RlB0S3drQjdkUE9IcURTWmg1d0E1NFcxZnJNWmFr?=
 =?utf-8?B?bTFlUTZ5MWZLTXpDSVJYVCs3SHZBLzg5QjZ0VEJNQWFsS1JOV2JCTjI3L3pZ?=
 =?utf-8?B?dkNjaWhvc2VwUU1lV2ExWjdsYlJ0eVpFWUdMS1BkRFlUOG90SG52bGJKM0Fk?=
 =?utf-8?B?SlhKQk8zc1kwZjlYRk9JL2ZYRXYxSnlIQnJZbERYUWkxZ1I0WldEVnZYNEJs?=
 =?utf-8?B?VEdTa0txd1d4VDBuMXhPeTVRQ2lqM05Lejk1S21lT3B5M2R0d1NEd3NFRmtx?=
 =?utf-8?B?WnBVUk1hZGVpMzNWU3c1YVhKNXlvZStyRnVsS3BTbERyTDZrWHRwRFlxOFhm?=
 =?utf-8?B?UFMzaVljZjNhVW1xVThOYlFEV3VTZTV3S0VpRDV3WTVYeTZPeVJjVXo1VnE4?=
 =?utf-8?B?aGlmeERvK096NFdTNi9KZXZKd2d2bnpWZTU3ak5TTlh4dHZRalFlMVBlckt2?=
 =?utf-8?B?T3BYT3pMWk9tV2U2cWtWR3FjaWFINFBVTFliNmMyd3Nkb2R4eS9HbC9OVkli?=
 =?utf-8?B?Z1pNRzFwcytUWnEzRjFZakVWNUtxQUZxR3dwOEEzek5tNDJIV2pOM3Z6NTAx?=
 =?utf-8?B?ajZHY1JMdXZKWnNPQThpbStnd09XTGkyZ01sQ2dEemJ0d0Jvbkl0OFd4dE9a?=
 =?utf-8?Q?GxR/m7x+YzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUt4ZXpnc2RER2x6OVhxNG1xUjZWYzRJNVdlYitKaE8vaXZGYjFFWkttK0g1?=
 =?utf-8?B?S2tFUEFxQ3E2dlg2R2UyRnZ2cDNMeVBIYWp6T05wUFhnRGdkTW1Mc1Jid1RM?=
 =?utf-8?B?cTZvczdBWmV3SXBzRFdjU1g1dFJ1OXhwUmxSTldNSXhZY0Z5VG1ROU5reDUz?=
 =?utf-8?B?OXE1cElwSE54S25CTVlqYlhrOThVb2VrSmtXSmU0YjdITkVoOTgyR3UwUDVT?=
 =?utf-8?B?K1lQM0Z3eGlwS1MvdkxpWHB3VGM2SkdDWmgreGhnOENxVDRuVlBGdGhWNExq?=
 =?utf-8?B?L3ZXVVdFekJtcVJGeXB3cVJYRm1TR29jem13alBpb21uL2lFdURGOTBnbjh0?=
 =?utf-8?B?eURuNUJxSzEwZkJDNFQwQ1hQRHZEd0MvTWUzL1U1Rkk4YVJZQUpiMDZ1MzdN?=
 =?utf-8?B?VnlIMENpZkdMK1FDYi9XMDYzWWoyQkY2QkdEYlNjbU50R1R6VG5xWExXdFhD?=
 =?utf-8?B?aXFiM2NITllxdTNDbFIyS2MrYjFycTNWSHJPd1V1WG5vZlhBeFUzYURYZkJj?=
 =?utf-8?B?Skl1ZVN3UnlnNklvcEFMaTFEYy9Vckc4WkFJTTNQS00rVlBOZFErQUkwcXBt?=
 =?utf-8?B?cTFPaCtKcjVib3NqcmRvNHVscHBic0FzR0VjcWtGcXgvYWk2eDcvMEZQZVBM?=
 =?utf-8?B?YXU4akg3QVFiZkRiRzBoY3V1YW1sZ3hXSmVuY1F0c2E4SXJzVjdObW9Ndzlr?=
 =?utf-8?B?YTdFZzZhTHpXYkc3N2U2Q0U0am5yTjRSNVduNDR3enZvK2lXTjNXeFZWcDFW?=
 =?utf-8?B?YWx0L3NWWlFmUS81bkg4VEF1VjhmT0Q4cjd0TWYwK1grV0hQRVN3Z2p5Mk9v?=
 =?utf-8?B?WFdKL0hFNThSQ0FBQ2wxMisyYU9PSENFbHlpdXM5UnBwRDBGSUtxN25oV2oz?=
 =?utf-8?B?Z0o2N1k4bTV5b0IwTkZsUjJ6ZG56ejlSZ3pWZGpZeW5rNEMrQlpaQ2dpaStR?=
 =?utf-8?B?QnJuT21FVFdsOE5WN09TTFdjTlFxWmwxUVZ3enZQTU9WUnFENTNNZ2VUd05m?=
 =?utf-8?B?RHhqb3JPSjBZdnlLQTlPZFB4blFZTHA5NU8ySGRvMVhTSXJnWE96Zk5SaDk5?=
 =?utf-8?B?ZjFPRGhLNVcxMGNubkZKYXRVcGx5dC96b1Q2SStySnJpWk9RT3N1TmI0enQ4?=
 =?utf-8?B?OHRPdkRuYUR5NmVxY3YydlFJWlhaUW4rdWVLK0lybzRoSzY4U0pYMmVJeGN5?=
 =?utf-8?B?eFdqeGhBL1pVRXV6Nzh0K08zOTMrRjh4blJmSVhFVGh1WE9oNUc0b2l5VUlV?=
 =?utf-8?B?S3pTSXJpWUo1U1Jlek84Q1RWUGNsaE0zZGR2ZWNRVUFKblFWcW1PNWZwemlx?=
 =?utf-8?B?NEtUbEZubzhGRnBBNU5ES0F4WGdVL0Q0QUR3aEhwS09qMWw0MkNoSXVtd0k2?=
 =?utf-8?B?SEFCNk44S2toRXZhcVN2THkwazZkcTlvU0ZUSFZySE5pZS9ZRGQxZllGUFlR?=
 =?utf-8?B?T2NvQTh5TVlPRklSOXpzdngxcGZJUzdTanZENGJUNG4xdmdpL2Jid1NqMzdE?=
 =?utf-8?B?Mnl2NVRtNzUvbkxaWU5ZRXhodE91cnN4ajJ6ak01bS83aFBvb1RMdlBwNXZv?=
 =?utf-8?B?Z2czelBLVkxjVmJJcWJUcTBDcXdUMEd0L0ttUVUxUGZybkdPM3ZsUUxWOXEy?=
 =?utf-8?B?akdsZE82WnpoM3NpZFk3SElQVXFQWWZvaC9oVElJdld5V3JJaUN2dlpxUlk1?=
 =?utf-8?B?YisvTDNod0ViTFV6K3grcHZ1dHpreHlRZ3dtcWF0ZnpLL0RXSEdPMnpOSGJE?=
 =?utf-8?B?QWU5dHQyNUcxc1l3ait4c0xDNVdGdWEyQit3YXNNZ2FJMWxXakNNV1RFL3Fx?=
 =?utf-8?B?Y2ZNckdMTzYwVDYrNU5FRWNlcFBseTdtcEEyRHNyM05aU0Mxbm9wbFIrNVhj?=
 =?utf-8?B?b3dYWE5jYWtZckt2TTNMMHFtSDRFRm85SHI5UG44b3FDRnRnM1hOdk83cGJu?=
 =?utf-8?B?cmpKakpKcjZBK2ZaU3ZHOG1xb1dyR01LUHlJQ1lFeXJsb1RUQ0c2d2tmVG90?=
 =?utf-8?B?SWlJYkpkNnBuNmk2RHkxUk8xdkFvNzI4TWZYK0FzNHJKZ1VqRHVEdm9ydWRV?=
 =?utf-8?B?UXQrVGNIQUpMZDNMcThCR280My81YlJlYVp0dm8zdWNxNUFqcEU5ajJ1VjVP?=
 =?utf-8?B?NVEwZHJXNncrZFdFWWI3dzNSMnh5MXpoZ0QxRHVjSEdPVGY3RGRsUHVmdElk?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 310deab2-3410-465c-8002-08dde0c7a79c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:30:27.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQfvwqYQQNxLEPUjc7A/Nr8aSdjWiBh+0FJDxUECyz1FyaKX7l9PK0A/NgLrigD2KiwUz2wE4lIco7JGdLwcCx6krhfF/+eNS7aHkXtZG8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5301
X-OriginatorOrg: intel.com

--------------ssoBO3YmpHPlhmWp1feYsxZx
Content-Type: multipart/mixed; boundary="------------HJMc0U0pazzz1YXezAM00Nrf";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: mohammad heib <mheib@redhat.com>, Simon Horman <horms@kernel.org>
Cc: David Hill <dhill@redhat.com>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Message-ID: <c7ee1e4f-9e1f-43c4-9fc2-0bc92f682aa4@intel.com>
Subject: Re: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
References: <20250805134042.2604897-1-dhill@redhat.com>
 <20250805134042.2604897-2-dhill@redhat.com>
 <20250805195249.GB61519@horms.kernel.org>
 <6133c0c5-8a1a-48c3-9083-8cd307293120@intel.com>
 <20250808130115.GA1705@horms.kernel.org>
 <CANQtZ2wffk6jUTTMYFgTYxWQBc=hmw7nAkbYB2kxt-1ihUP9Rw@mail.gmail.com>
 <f5c3b451-0a8d-4146-8e47-be2c7e2d6284@redhat.com>
 <6d7fdf16-3ed8-47b2-a872-164f1b6d5937@intel.com>
 <24473594-c77d-44f5-9311-57d67c558cb7@redhat.com>
In-Reply-To: <24473594-c77d-44f5-9311-57d67c558cb7@redhat.com>

--------------HJMc0U0pazzz1YXezAM00Nrf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/21/2025 2:58 AM, mohammad heib wrote:
> Hi
> i defiantly agree with you Jacob
>=20
> maybe to avoid removing the params in the future we can=C2=A0implement =
it=20
> this way:
>=20
> Instead of a simple boolean parameter, we can introduce a *numeric=20
> |max_mac_per_vf| parameter*.
>=20
>   *
>=20
>     If set to |0|, the driver behaves as legacy (no per-VF limit).
>=20
>   *
>=20
>     Any non-zero value enforces that maximum number of MACs per VF.
>=20
>=20
>=20
> This design addresses concerns about removing a parameter in the future=
=20
> because:
>=20
>   * The parameter can *coexist with a future devlink resource-per-VF
>     implementation*.
>   * if a hierarchy of resources is added later, |max_mac_per_vf =3D 0|
>     could automatically defer to the resource values, while a non-zero
>     value can act as an override.
>   * This numeric parameter is more flexible than a boolean and easier t=
o
>     extend or adjust at runtime (via devlink in the future).
>=20
> I think this is a reasonable *short-term solution* that preserves=20
> backward compatibility while allowing for a *long-term devlink=20
> resource-based design*.
>=20

This seems like a good approach to me.

Thanks,
Jake

--------------HJMc0U0pazzz1YXezAM00Nrf--

--------------ssoBO3YmpHPlhmWp1feYsxZx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaKc7kQUDAAAAAAAKCRBqll0+bw8o6HZM
AP9sJM2hoTcPEY6NNSfevuC6kz9S2/3nA6wl+5Hl6q+lDgD/WkTIrUFJvzah9O6ypnEqG3lvHEsl
NSqnO6Nvpfnpzwc=
=Gqj/
-----END PGP SIGNATURE-----

--------------ssoBO3YmpHPlhmWp1feYsxZx--

