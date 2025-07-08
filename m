Return-Path: <netdev+bounces-205028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E7AFCE69
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326E2169424
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED52E03E3;
	Tue,  8 Jul 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cszJyUFd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E820766C
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986789; cv=fail; b=NWGXegw8ICE8thVyyXVztMnzM/4QSinq+rw3ZRGEakzEYqaRETE7pGcxgnct39zMwPdXqRRsOIaMFp0k4cNbbfhMr8pXP0yopLhtw+A09DZy1hVGTt2/+uCZtAmwF1H44xI5nUUZBYe2Klbeq0qEbpkDjCFFxVl+QwbD58ew7bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986789; c=relaxed/simple;
	bh=dQcaIO7kjdj/squGAGMX4Vb7mQFcrPLNoL6FByIvclM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ms4aiX6UUBrL9UCPjg1tR3LkxiU13XVK7vPPsFHroeo3krXK55EpF8iSUqD9gDzQ8HAoGD+6sUTW878y7eAw/uyaFfU2dfFFktUMvv6o9BSYbE+K8u1TGA2Cvk8P/a+X9+IlF0bVWOhU4JFPVrrOWhB5/cPjz9n41ayeWtDWBpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cszJyUFd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751986788; x=1783522788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dQcaIO7kjdj/squGAGMX4Vb7mQFcrPLNoL6FByIvclM=;
  b=cszJyUFdUs89IwON2mGjHwx42l+kEAGKPeXOs9ibWk81Zd9hFOGTiQze
   KIWSmDK8r0BtPTvzIcOAYJ6quWSTS/DSUj0pW94RNRuf3cnpyws5gm40o
   SM9sSGKbu2TMlOQz+ffuyFEkJsZKs0qT1Fgp/UXPejBajXd9UKUt7iSsh
   +J3x7txG7WoNO14tQNGc2QyOiYI2cTkqi7MW9qNLj6RmzknGTBXBFKROz
   Ou12pdWPULUc3fWvXHXME20RrVM4xy6HqS0VSTjWbNvL5hIrTdUPKLdCB
   UYVmSHsnuL3CWs3Zj8brRw1tVdm6sQdd0DrrDlUyhbT1hYvSDSjl5BsNj
   w==;
X-CSE-ConnectionGUID: fJwlar/wTDmT1jnZFFP3Fw==
X-CSE-MsgGUID: 8v2K7ViuTEyh752asQB4+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54355353"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="54355353"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:59:48 -0700
X-CSE-ConnectionGUID: ZLj/MpviScyycwQycSqtGQ==
X-CSE-MsgGUID: Q8tSgBZ9SYCoGWOvp2iohA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="155138787"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:59:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:59:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 07:59:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:59:45 -0700
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by PH8PR11MB6801.namprd11.prod.outlook.com (2603:10b6:510:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 14:59:38 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%6]) with mapi id 15.20.8769.022; Tue, 8 Jul 2025
 14:59:38 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Chittim, Madhu" <madhu.chittim@intel.com>, "Cao,
 Yahui" <yahui.cao@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 6/8] ice: use pci_iov_vf_id()
 to get VF ID
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 6/8] ice: use pci_iov_vf_id()
 to get VF ID
Thread-Index: AQHb4J/shJXOiVAisEmP3Y6AZOoNxbQocIpw
Date: Tue, 8 Jul 2025 14:59:38 +0000
Message-ID: <IA3PR11MB8985E041208546CD2E945EDA8F4EA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
 <20250618-e810-live-migration-jk-migration-prep-v1-6-72a37485453e@intel.com>
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-6-72a37485453e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|PH8PR11MB6801:EE_
x-ms-office365-filtering-correlation-id: 7679d9a4-4ed1-495e-86bc-08ddbe300f72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?LzRSQkZzMkI4aFNQTDN1T2U2d0hvRGRFbXNIK0Rud2FzZ0NGTmNzejFHT1ZX?=
 =?utf-8?B?RHNXWDQxcTFha1UvS2ZxRGNOMUszZ2xJTlJYZlI3N0tkUnExa3M4c0hqZ3RF?=
 =?utf-8?B?cFgveHk4cVZKc1htaDc5U0FuQnlhTnl2endacSs4dzZVdUxxcC9yQ1lMY2NJ?=
 =?utf-8?B?M3g3MitTZWd0aDNJMGxpV2QrdjhOelVHc0V2N3lTb1g1MVQwNHFzMUVhY3li?=
 =?utf-8?B?ZmJ5blVPYThyRWZ3RVNwdzhTVXZBUzA4TldHRnZlZndrLzQyRlljN3lRWXIy?=
 =?utf-8?B?cDdKOWY1NlFhQ2o4bWRXdlFiZm1CTmlVOTRDeVA4Vm4rNDFzQW43VmJ6L1Rw?=
 =?utf-8?B?T3BqOWdZaXUzMmZGVVdPOHNSbFVmbVdoMHYyLy94YUtsL2YxU3A5N2dreHhK?=
 =?utf-8?B?SXBEUnRuMXYzdEI0SlFnNHRpUWloVVBVZVRYOU9SUjM1MmIvek1WNmNDK2dB?=
 =?utf-8?B?V1crQXhab2p6anFsNzZkQ1hMTUVsTDhWVlRRUjJUVDR1aml4T0JUNlNtWW9h?=
 =?utf-8?B?TERlSFlsaFBvcW1leVJ3d3lBZVRYWG5BL0dycWtrZkp2UytRN1N0RU5lLzdi?=
 =?utf-8?B?WHpOcW5LdC9Nb01pajAwY0k4WStwS2x2bmtvV2xSWjJwNWQwY0JqL2pkdTJI?=
 =?utf-8?B?bnRORzVOdzZtTGE2aWg1eVdFWXcvRkwvMi8rQWRZU0dkR1BYMzJNdTNlY1ZB?=
 =?utf-8?B?LzAxMHJCQWxRa0o5ZGxlNkttMEFrUk05VXU2clVnUmpxbEFydFhYSUNoQmYx?=
 =?utf-8?B?elBUaHpWYjdoN2ZpSDQwOCszS0xOeWpGdXBRdTBPTGJ0RXhsSkRNVitmRkhh?=
 =?utf-8?B?ZGV1ZlRjYm0rSXRzblQvMEdtajhGNGY0U0ordWYvRlJ0UVNsOEhzM3pZcC9h?=
 =?utf-8?B?UnVUdTV0UGRPbGZKZVY3cHdFeFk0OVFxS3lKL20wcmZ2djhVVUROaFo4RGNG?=
 =?utf-8?B?RFNsTE1yeFBlSWZCOVJQYWhUNUJQZHZsclpVRjRLRmg2NTZvL2RzS1VvdHR3?=
 =?utf-8?B?bjk2cEdMYndpQkFmSzdDQVY0NEgyYWE3Z2NxQ3VjSCtjWjNiQUh6aXozbnBn?=
 =?utf-8?B?UWRKdEtYdk1mVVJLUzJpdlVkZ1pML2JhY2l3d0g1SHQ4VTlqTTBUWXVCaHFI?=
 =?utf-8?B?aC9vaHpLK1pVQXJpOUlHMkdJLzJZeDJIa0owWTZzWWlRazZtbitzU0IwRFV3?=
 =?utf-8?B?aXVhZFdUSFZ0dDluTGw3SVpwekQ0eTRwV2JSL2FST1ZJS3ZOTHl4L0N0WlNP?=
 =?utf-8?B?b0dYc05NN0JvL3dXdmVZVVhCTzgyTzFJOWx5dkpkd1kyYnhTazg1WEZSekto?=
 =?utf-8?B?REl2Z0xQTlRaMHFBK1pqRUg4WTNLVDhpMXRZelR2OVRqWW9yeWI4dnUrMTVr?=
 =?utf-8?B?V0FFT3VxM0ZuaG1FRk1QTm9paU92M05zaXRzRDFSRzF3KzlOZ1RpMmpWTHZa?=
 =?utf-8?B?SmlRbGx6YVJmMEg0NGo3MnBBb1gvTno2YUZzb29xMzBaVU5tSmxHY3o1ZUsz?=
 =?utf-8?B?clB0VDlYdWR4NGlXSEFPRDJuNFhFai9lK1pxa3Z5c09mU2w4QnZzT0g3Qi9q?=
 =?utf-8?B?TnN5TWNEa0hCOUhjNXAvc1UwZXAxWnBCbUxUZm1yK0FHQkVEbkJnTEd2TFRM?=
 =?utf-8?B?MEhLZHlXb2dGTDZYRDJ2R1dsZlRKcWhEYlE0Zk96V3FzbGR1akZCengweG9L?=
 =?utf-8?B?RU1Vbmo3NTBnZ0QvQVhLU1c2VHlaRHdPK3VwYi9zOGplYUxvdGMyZTBGY1B4?=
 =?utf-8?B?dHRqQm5hUzAreFJHREZkTEtOTVlQRW1EODdaMko3UzdVN2Y1R2FBR2M4eU9W?=
 =?utf-8?B?YmF2N0E0cStneXBkbXV3Mmp6NzZjWHNaczdJZjhwMkYzSmlORUJhekpDYmU3?=
 =?utf-8?B?QXAzT2s1RzlUR2QxdkRGYm9MV3RST2NHcXZKd2IvaTJlNzREUnRxUGxNalhq?=
 =?utf-8?B?RTcva0Z5dDNEbExBR09Id0FmdkFSbURLL1NNZzg2Ukc0RlJ2MVdrb3pFR2dP?=
 =?utf-8?Q?Zsn57i9ukfZ78QBMARb1PsSDAh2TvA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVhsRVZQcjJHa1JiazJDT21IdTNISnJ2eDlWdGUxZCtMOUE1VmcyYWp1aTRM?=
 =?utf-8?B?ZFQ2bG9kZGpHc3M2VmdTVUtlNE9RRlhZMXlTRS9SVFg4b25KNkJTb0FqYmRT?=
 =?utf-8?B?THdMcHA3aU0zeEhmeVZGc3ZKTk5LUmtvcU96NFl6b0ErRVVzNjE4Zk81TFdY?=
 =?utf-8?B?TGVLWm1TV3dHQVRWbTdaM3JVUWRUUXVidHFudDNGdTRDOHJIZDlqTkwrSmZt?=
 =?utf-8?B?YUo3RVNJNWYzODdYejJoam5rdndjc0JmRllUUDY0T0c3TVB0c016VUZLOGNh?=
 =?utf-8?B?QTBLR3ZsTFdnT2FYYlNncnNldFFWS1gxM1hBcTZMV0JBSEtKUlNMN3hpUUZY?=
 =?utf-8?B?YkJ4ajlUWXZ4d0ZIU08vT0dzU2ZMU2hiNGY0NmtwMHMxNXV6aVVSQVcvSmU2?=
 =?utf-8?B?eGovcUVtS1RVNWRrL1cvTlFoQlpCSSs2eGloWjg3bGFYRGFGQ1c4L2g5bkJx?=
 =?utf-8?B?WEhuQ3E5ZWpsbk1yOGpKRWx6L2VGelVVQWdkVWxUR0c3V01kalEvaVplVXZ4?=
 =?utf-8?B?OFl5b1lLSTc4dVA4MlBhZUNuTnhmRHFwdDlFblhTMytjK0tQYlRNMTNPamhj?=
 =?utf-8?B?MVhIZ055Z0ZTbVcwYnlxZ2lUVWJ5Qy9SNGY2NWxmRzNSakhWUjEweFBlTllt?=
 =?utf-8?B?T0x6U1RLcTZUenVXTUdaMS9qQmlnelcwbUZnTXdwdXRGU1J5RnRtMytPamI2?=
 =?utf-8?B?eXlqdUJYaWlBOWppQ0Ywd04wWjcwUVRiZ0daejhkTkhqSy9zUi9SdDMxTElu?=
 =?utf-8?B?cXdQaEJEMW5MaS9kR3g0UWdUZGNEWlN5M2ZKOFdzOWNXSkMzaGhZamVkRmlS?=
 =?utf-8?B?WWxiMVpsVVlwdVYvVTV6WmtFTVBsNWdrMnZieHZDZmZxVUl6T3h4QVVDVEli?=
 =?utf-8?B?MkxjRVpCd2gwdTRod0c2WEFjZUVvUWY1RWVocmd3ZTdIRldGbmttZk8vM1Jm?=
 =?utf-8?B?ek5UMDF1TjRGSXlidkJCMDJjS1VHdWc0eCsvcG9pK2VwNzljS21jZk1uRG9X?=
 =?utf-8?B?OEcxUjJESWdlR1RYQ3ZCbmJMd3hLVUcxZG1teUQ4RE1aUXkyMGVnbXpicSts?=
 =?utf-8?B?Q0kzWkdvYzI1ZFk5ZE15YzBEM25tcWx5YUJuaWtBZmlDNnJURlF3Y3craEQw?=
 =?utf-8?B?RklOeXZhNEZxV3VUTWxrUXZpSEdvM2FwMFZKTUpsT0NuaWd6WEJIWWRUazdK?=
 =?utf-8?B?Q2xVTTBieEdDZmVrRWJJLytFYzY0SjcwakY2Mi96VTNvU0xmWmpMT2lxTlpr?=
 =?utf-8?B?bGZBTmxSL2RUUTdqVGI3TEZVMnZ3VTB5S2o2R2gxN2JCSzN4M2RjNytHb2xD?=
 =?utf-8?B?L1VET1AycFMvY1d4bS83bUZvZDU3eVVTcVJZU3NsZnNzK3M0andRaVRaUkc2?=
 =?utf-8?B?WXBXVmtJTE9Qbk9RakRSb3lhSG5RZGlseGdaMno0dFpoa2ZyVlpObTJPaWRi?=
 =?utf-8?B?R01BOFJiMXBQa045V2hvdjIxSm04eTJvV2RqaTFxbFpVM1FQblAzZzdvTlh3?=
 =?utf-8?B?am9xOVpra2JZQ2NqR0Qrb0FXb0g0VGtCQUNOZVJGVG43YXdERTZMTGZ4UGdP?=
 =?utf-8?B?RWtsRVlqTjFuQ0pDVDNIek9jT2hhaFZzclh4WDE5MzZueWVUZGxtYWVzOUdI?=
 =?utf-8?B?dEJtdFlqbHBNbUYvSUhBZXB2WDBkZUlXUitLSVdJZUxpdkc0eWN1SUpRMFA3?=
 =?utf-8?B?S3VGclFNVFpBUkJma0ZVaDRDakF3dUFpMmVDc2NRc3c4QlIvQkJzdE91Z010?=
 =?utf-8?B?a1puWW13c0U0K0xPR2tLajVaNERsMUZjR3F3emd0cndRcXNGY1MwcmpnejYw?=
 =?utf-8?B?RmJYVUR5dHpIVHR5SUxuN2Z1S0xHVWg5dU50SzVwc1hGSmUzSEhNWGQ1V1Rp?=
 =?utf-8?B?T3I3YkNJQUZ5TkExTHFKck1LSGRBRzY3cDlrNnNHVE5VN05XSnhieTRFR3JC?=
 =?utf-8?B?MG13QitvWHM4NVJ6OTVraVBMVW5qNllBaUFFbzBmWW1OWmZuN1EwTXR2R2ZM?=
 =?utf-8?B?S3ZUVGwvTjlieVhJclBDRzdpMHZ3dXJFMFhCdjBZR2FwK21NN1NRbzFRYmt5?=
 =?utf-8?B?cmt0MnU5UWNoV201cFVtckI3Z2h4WStkQ0c3aXU2QUNNOEcyMDhyam95bkRC?=
 =?utf-8?B?WjVqWkhRV2thNG9MQldBNG9uaVNVcERETkEyZE5oMitSeThtMTNKUXh3Zjdq?=
 =?utf-8?B?Wnc9PQ==?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcrqDrpiXjIQS/GJ15/p2GDTnyXdmSSJmvwoLasaqWcw/CkA0UK9REjWe69QzedRC/MZ/Pjb03FLEv+vdUDe0xRl1AXKaE7cZWs1h3ae8PsqJ2wkGJtX11i0YbqHzCN1WxhhVHaFya1A/VFYe21mmaFFYYfVMGrAk6+ee5IuxvH+l4SLA0C+nH+doZSsq3L82vhLHG/rTzM7FRiz0eQO6LSE57TxJ+BUKWYu096KsM5Srr8/GVstpfnB5AfQ+n2Mj/epNzC7QJ6PtyTSmV8OmbP8oCafnT+NC/2370C0FtsUowRIqbQpgSXMIOMnaYQH+YlGtiAVRBHjCUxzJXYR4w==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rvygc4tpjn5hGHiZiENry200m0YuYgsNeWPoOVwzglk=;
 b=gj9NOAc6a5DLJADuxXln6Q7MB8hRJ3u17ZVroGNvPT83fYYXLSeeAa8rrWR+UpcEPPZ90OICyLcVCw+OXwtJeMyqh1hgKlA2AY6stwMd+kj68qHiqGGo+cTZRLslMu6bJatX4SfHvsnSGulAnrgPU12Bwh+JdYSe/KvVFRbWz43yE0zS/qFm9lTsToIqGklfVXSBX18oXWGgsvbqfilfFjOL1eJdzTmnSza3I7n9mr7bZp/tThFVIc/1OcK6HiDnfpdBqBgUESH6gDOlsn/Anc7Z1AVn4+v/aBpHxQIHW80tOWK7Q1qdEH2TKTzasJAy1CYCDxQLiwF89jzb2x5DGA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: IA3PR11MB8985.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 7679d9a4-4ed1-495e-86bc-08ddbe300f72
x-ms-exchange-crosstenant-originalarrivaltime: 08 Jul 2025 14:59:38.3315 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: wuOF5mqQgnc03qOa2ItgEU0Vo00UXiZ4+AXbiJIs8rb8vVfi8io6qJmJxO8rYacw3J7h6RddV8i2f4BcU7PeaPMgtTmxLD1th202L523rvI=
x-ms-exchange-transport-crosstenantheadersstamped: PH8PR11MB6801
x-originatororg: intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBKYWNvYiBL
ZWxsZXINCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMTksIDIwMjUgMTI6MjUgQU0NCj4gVG86IElu
dGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc+DQo+IENjOiBL
ZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7DQo+IENoaXR0aW0sIE1hZGh1IDxtYWRodS5jaGl0dGltQGludGVsLmNvbT47IENh
bywgWWFodWkNCj4gPHlhaHVpLmNhb0BpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+Ow0KPiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlz
bGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFU
Q0ggaXdsLW5leHQgNi84XSBpY2U6IHVzZSBwY2lfaW92X3ZmX2lkKCkgdG8gZ2V0DQo+IFZGIElE
DQo+DQo+IFRoZSBpY2Vfc3Jpb3Zfc2V0X21zaXhfdmVjX2NvdW50KCkgb2J0YWlucyB0aGUgVkYg
ZGV2aWNlIElEIGluIGEgc3RyYW5nZSB3YXkNCj4gYnkgaXRlcmF0aW5nIG92ZXIgdGhlIHBvc3Np
YmxlIFZGIElEcyBhbmQgY2FsbGluZyBwY2lfaW92X3ZpcnRmbl9kZXZmbiB0bw0KPiBjYWxjdWxh
dGUgdGhlIGRldmljZSBhbmQgZnVuY3Rpb24gY29tYm9zIGFuZCBjb21wYXJlIHRoZW0gdG8gdGhl
IHBkZXYtDQo+ID5kZXZmbi4NCj4NCj4gVGhpcyBpcyB1bm5lY2Vzc2FyeS4gVGhlIHBjaV9pb3Zf
dmZfaWQoKSBoZWxwZXIgYWxyZWFkeSBleGlzdHMgd2hpY2ggZG9lcyB0aGUNCj4gcmV2ZXJzZSBj
YWxjdWxhdGlvbiBvZiBwY2lfaW92X3ZpcnRmbl9kZXZmbigpLCB3aGljaCBpcyBtdWNoIHNpbXBs
ZXIgYW5kIGF2b2lkcw0KPiB0aGUgbG9vcCBjb25zdHJ1Y3Rpb24uIFVzZSB0aGlzIGluc3RlYWQu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vfc3Jpb3Yu
YyB8IDEyICsrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9pY2Vfc3Jpb3YuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9p
Y2Vfc3Jpb3YuYw0KPiBpbmRleA0KPiA4ZDc3YzM4NzM1N2JiYmEyN2ZiY2VjNGJiMjAxOTI3NGQy
YTJlYjk5Li40YzA5NTViZTJhZDIwYzM5MDJjZg0KPiA4OTFhNjZmODU3NTg1ZmNhYjk4YiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9zcmlvdi5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vfc3Jpb3YuYw0KPiBAQCAt
OTUyLDE3ICs5NTIsMTEgQEAgaW50IGljZV9zcmlvdl9zZXRfbXNpeF92ZWNfY291bnQoc3RydWN0
IHBjaV9kZXYNCg0KVGVzdGVkLWJ5OiBSYWZhbCBSb21hbm93c2tpIDxyYWZhbC5yb21hbm93c2tp
QGludGVsLmNvbT4NCg0KDQo=

