Return-Path: <netdev+bounces-285067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H2UNTzE+2keEgAAu9opvQ
	(envelope-from <netdev+bounces-285067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:44:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE3A4E15DB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E79AD300BBA4
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4413BAD95;
	Wed,  6 May 2026 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6TIPh53"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969BD3B19C6;
	Wed,  6 May 2026 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107428; cv=fail; b=gwPups+L2f4s0whDSf6OJa3HqZXxWv2mZKegTRJA7BWJ1I2F3qun7F0ZaDiRTYsSMlKjqE2EsP3F1E7IhR/9a8ltP6F+BFYwqjG0BmcHcTsH1cVt9iBXMagCN0mOve9M7GPCq3xctTInox3cJk2C/SbCCnxS3uytl2tY4xEb1KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107428; c=relaxed/simple;
	bh=ow9BlXjNLakMKH8JJcCqZ8kfVixg9Pz6G4DfmBTVsFU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cgup62C2+a3mFFBL7QsZyier/kAvYEgjZspK81sry4NvQA8kqFvct8ZmE+Go2xMvdHTZPbXNlydkcawJkc5nPyX/lNJD6yb9ae+aP947dg1X7PXpwZ08MGaPqknm5UiAVuEL2tb2iYELFFQGdMRXgHaXE9v9DzIUBPbTKQC+Nmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6TIPh53; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778107424; x=1809643424;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ow9BlXjNLakMKH8JJcCqZ8kfVixg9Pz6G4DfmBTVsFU=;
  b=C6TIPh53hs81LXTv6l0JSjU28MIpv1CykVtiIM4bMzBiQ20i+ELURR1b
   O9BYxrEpf2+7y5H/w/8t/TFj9o9UxclwVcb/rUCqRBBseWR6BQHPXNqV3
   FuDWMxSbV+CIvX8mPqkR3Zekj3CQVv6YskFhY17lr4UdyHKuMRzfSU+35
   tOZveEtsr0EG7RS6Go72YYOPOoCIblswxNqfjawFHh+946RW9CqJyZCbu
   yYxuekl06pZ+SiO8OU5MoF9efPM5s0+5+hc+AHHM+67mm6DDb/eEWPZ9/
   qGWwmDijIs5HszRhj0sItFH4iqLFia+h00zPtMSGNzXsb9sMx4OAzGpMN
   Q==;
X-CSE-ConnectionGUID: 9D3g9TaqRBuRfnA27ZzjBQ==
X-CSE-MsgGUID: s8fwdk/qQZyToGYt9L+vZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89640248"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="89640248"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 15:43:38 -0700
X-CSE-ConnectionGUID: 6B8RdbRvR2CwxSMIqGcU7g==
X-CSE-MsgGUID: mCP9XNIKT8mjPcfQpgThfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="266650518"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 15:43:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 15:43:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 15:43:36 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 15:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZspGEBsvj+br4J6YOmC3w5z+Mt5+0emaOuioHgj/EMbRw6B9KcEk/lBNeZ0IrlO5avOWshF+APyycH6winp6vFWTHWp2NIRQtio/uS0Ektwis8smgApIY09ZdE8GdZhUoo6XkEGpMgSKQy1ESu7OATmOT57KNfflL6Uckit+ky2AdycCnoglaFnGo+NWaWBQOR7yY3SH3hwoGDIMtOI/qAu86PUTG+47NJsH32VWdlvxdnJpdEq+wwmjnBFdIUCnNEXuK3rUOkVlh6UKnVwmlE8/roc0kbMKp5jfmrk78qa39c9kQqPksc3fOI1bFVfuY9WkctpByCD6SYuHpOJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOTP+lTIJ6o6HcDSDU2GHWdZzRw39cQSOaVwv0ywKEk=;
 b=fsbKJIhkw6ofwsOFU5r0wK0vnL7aVMVe2P48l08vobp2jvT/GHT0nNv1akdCztlLXCV8TNZVRzb+V2H14vJbx8qLXr5KUcDo06fGWgmjShVG0nqlArOusgAHLsta+cX2xNi0KyH3Qbe3Nq5BCtD3na7eEgbOnmgGstjUp54eOCE7uLh8rRUVleTC9C+haSm9lViERTvDy9v8G2RDQvRLSPBeKRL5jKreGROHSszXbxXpKa23IVZ9eWR5mTPCHzILTmrXdsP7bIwGvZB7xlfJr6dZ8zUmVDCYPuTUdDae1UYb4zS7sE30eIgDku3FTjykC4OtbcBBbWwzSbxZvFuDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by SA2PR11MB4924.namprd11.prod.outlook.com (2603:10b6:806:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 22:43:28 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 22:43:28 +0000
Message-ID: <3d229a69-cdf9-4e89-af1e-454b6d6912bd@intel.com>
Date: Wed, 6 May 2026 15:43:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v4] ice: wait for reset completion in
 ice_resume()
To: Aaron Ma <aaron.ma@canonical.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<aleksandr.loktionov@intel.com>, <kohei@enjuk.jp>, Paul Menzel
	<pmenzel@molgen.mpg.de>
References: <20260429034849.1686650-1-aaron.ma@canonical.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260429034849.1686650-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|SA2PR11MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: 540ca098-355f-480a-994a-08deabc0e405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: XAWv978a9YfobYEf8fTtyp+EZ8J25OdNeHyi+7wddorkJb8irGJrwcVfPL/fkJEi1v/CpzMlmN4Eh/zMQtZWzDBGECZwEj05Oe/Wt/2ChcXa2od9Dy4slUq5HjCEauLahC7BvqNgY0N5vodT7mq3hKGaMr7MuAGDioPvi4J1C/HIFGL95GlP7kXjsDNar0SrEgtv2gJLEjm3OFrxTbV/9eCIW+3Vw2glfwv6mEGY1/VycOme9um10o+mjpNYj7s0qTH926bzH6ExjSmYRneOm3ifSYGFK52S4cLgM+ZFgx9vgNaMx3iop96E0NZp6/iXNfdxEl0VTqLkIpsAaMN1MpqLFrL2H7Vt09Uu2I9zd5gSVAVywPXPfQ/viSPLqdArusbS83yfE01ehur37DN9Bx5go6KA3/Kv6uWXWw/TrLyo9Fu1LomjemOpzrqh27lCtQ0d31GXzZNNeaeCZxUlcjr/VlTDB126PQv0tDsICgZzXibqzIPQFZ8bcLyFc8J8rw0mQ4DS0yW5P9IHQE95gFHylp2C9kyo/lh7mIydwXTgrakd5Lo1TXT61GyG6edcb/WIecvHMnU3D2vWUMTRGkUQdzZtqo7g8+szNIXs6FIB6HQpSgc6MiNQrxEBjteH0WY+1YHEPFrypwaZokOsuV1KnlYSylJCjBquA+RsRCrQzdcZlQt78ZmyiFqoEE2UroBp7tcuz9q/9q00Nkh+Yr3nu5SF8XEAvx/FGVgmE9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEorZXlVYXlCa0MxK1ZPV2VYcUdWaEtJN2VKRmlRMmkrWHFMZHBvSVFCUDZh?=
 =?utf-8?B?eS9SemRRaU1rVXRLaGlBTWIxRFk3STlJUTl1NzhVVzV1KzhuTUFkU3BSdHFJ?=
 =?utf-8?B?YlRsOG9tZVQxZW1QS1lLZE1KTkJoL3VWQzErdjVYcFV0YTlzZWVLUmVjWnFH?=
 =?utf-8?B?dCtNaUJvSzJvbC9pSU5DbU1NVE1BZFZlejVhaG1wY2NqOGROV3g4UWJxU3dH?=
 =?utf-8?B?dkJpWXlrV1ZFTkxKWjE5NEI2c2xaRXRFTkxYcXNJL0VSdmFMNFUyQTVLckIw?=
 =?utf-8?B?bEFiOFRMdm5FUU10SkF1NldmK3hoVk0wUXYrekJWbXgrQzdENTRHZTludmxF?=
 =?utf-8?B?V011RCt3MFBCU1pwM0owdXZ6d1lTT2JqVWd3d0RaSGIvcXJRVDAxQXQ0UXZW?=
 =?utf-8?B?azkyMEp2RTBQYjNrVjJEdjNvRG9SMWRWVTZHWGRvaWxLdW1rai9VdDFVY0RK?=
 =?utf-8?B?WTR4SXU2Q2M3RldQL0dCNmV6ZHdFYnZUc0M5QTUrblE1WUpFM3VVUDBLL3BS?=
 =?utf-8?B?M1dyVnhrczFiWFp1V0N6ZHN2bFA3Q29maVNXaUtBMlFiN09nR2FWZDlHbE5n?=
 =?utf-8?B?Q3U4eWFwdUUzbnBEdVNRdmxDa1I4UVhkdml6UTZxTlcrcmJBT2pGcng5aDB1?=
 =?utf-8?B?QXFZa2lha2pYSWFvTFp1dDMzVFVWNTdIcnFNdDNHL2FOYzJSMzkrNFRLNmxi?=
 =?utf-8?B?NXk0RWIzR1FXQk80Z3JQQ1pPeXhWMXFGWWcyazRUeGI5RlBjR3RZV3dQVVF2?=
 =?utf-8?B?Z2JpMC9jUXZET29GUC95NDRWbE1pMmorU0JxWWt6eVlSZWEyUXlndmRJUm1p?=
 =?utf-8?B?blpmRGorejdqdUtLZ2R5NlRDK1FUb2lBdDFUeVdsYU92QkpDNUdnOU5kZkNp?=
 =?utf-8?B?djkvNVE0YUhoWGhFSXBhQW9VTERFMEY5bUxUck1aMHlibmY5bFhYVVcyUEo4?=
 =?utf-8?B?Qm0zS0JpN1BzaHU2U0o5cUZnSWxiaWlWSCsrUVpXMGIzeUgxRTBVbmE0VzFr?=
 =?utf-8?B?OWdXSXp1NE9TVjFsNHlLT2FiSEF6RTN1OVNEalJlaE9WVTFaN0FLWloweDNY?=
 =?utf-8?B?OS8rYXB6MHhmRVVTYzFGTjkyZS9sWkxIL041eERSbjIrRmRyNFIwWGR0bUlm?=
 =?utf-8?B?eEVjMXZRUE9VZjU0VXVlQlN3Vkdjd3d6N1lsMnFld2wxUTB5OEJVanBRM2Y3?=
 =?utf-8?B?STdwdVB1VGNycVNlOHBDbFJBQU4rY0xXVVk4UUtNQjdWR0Fxb05RRzVOTU1v?=
 =?utf-8?B?VURsMDVhWEUzVUV0RHFQbEdDTmpkRENLbmFLNjA0QzB5TDJlaURNdFJpTjJM?=
 =?utf-8?B?ZVlzK0p4anVCMnNHd0ZBTCtzTklkYjlmVkN4aUk2QzRJU0RwQSsvN2djVW15?=
 =?utf-8?B?dTM5Z0VtL1R5ZnZZNGg2U3hqclhCMDZXcXZIeHIveXRwTmxPTUtMekpBSnpr?=
 =?utf-8?B?Szd1T1RMek9pMGU3V3c2d05jNmEwMWZyaU5lOG4xS0FPM0F3N2pYRDJySjJs?=
 =?utf-8?B?QXAzeWU5V2xxZDhFNzNqQXFWK2pQU0N5Mm1ET2hYZURwSXU1RmVCY2xVTExW?=
 =?utf-8?B?YzN5bTFQUGVDSGR5OHc1bm9BakM1SUdVR000akhVaWI0MTFxS2VtTWdIWGQz?=
 =?utf-8?B?Q1lBRkhDZDRsY21sWCtpSHptRTA0MlBmMnFtREFmUXVnc2o2OG02KytSTGpL?=
 =?utf-8?B?bU4zUEJVa3NkTW93OTFxK2c1UkV4T0IxYWgvYWFDMmZhMTlEc1hkemNpN2pB?=
 =?utf-8?B?V1c1VGVGTXM2Um5vWnlyVERVczBianlZaDhPcE5KcUUwQytoUjBQZS9admpY?=
 =?utf-8?B?ZERyYld1bHduOUlEeENTNjVNYUROeFpVZ1JyS2RSa3FDN1JBckJqeWFscStl?=
 =?utf-8?B?dWkvQVBsMjN6dld3dzVLaEZ3R3hibzU1NjFBakZueEI0S2xhWTlRQmh1YjdW?=
 =?utf-8?B?eUkzc0JETXpjWGRyVHNpMGcvSWZubUp6ellHUmVlR2xTeG0xVkUzZ3ZuMEZK?=
 =?utf-8?B?V2RCelRoWlNBOWtUbEFaY04yVWVqQk5JL3o2TGR5SGZqUFV5aDdzN0tzSEUx?=
 =?utf-8?B?ZjhwYzVlaS8za09ZVmZIMGx4Rno4NlpienJ6MTFneDNBdDhiNXZuTnQwTHBE?=
 =?utf-8?B?WTNVb1lZcFE3YW5hZXNkcE1mR00xdVNMYUxmRjM3N21hQmI0K21tajRoM3Ir?=
 =?utf-8?B?Z2Y5QXpMeVE2QVBvWStjbVc5cUVUOGVMU3IzNmRHbllkM01FN2kwdWF3aFV4?=
 =?utf-8?B?Q05oeW1TR1Nhb3l0OFlsNy9nZTg4VmhieWRxbnNFenZoUHNXVXV6cFRVTzk2?=
 =?utf-8?B?dVI1NTE0RW5KcitZbDQyaWVlcmVTVGJVSCtuNGJ4ZEFZS0oya0c0aFJmNnAy?=
 =?utf-8?Q?cAUnmnNQtcp8/71Q=3D?=
X-Exchange-RoutingPolicyChecked: PEXtiS896hja8/63p+uRZ7PIs0VxitKdt+wWyzuTe6ljdKhZNODEnufRc/ydgV1M9nsqaGaax0BFHdgLCDuMI7vPEc342R4eVpvJNyaLh5Tzy6kG4Qs2tvzWmUUEJZRyc5DY7m0gblvFZl/FPipYMxat0EDIC0LhEY63CopK0SdqxP5qZXVQSZoa5wX/4TjDL0HZ8v8Rp08dIdf41hfhnCzOX8Xyd8EIiKlek7cOmufwFTcu8rBxaAvJOGnbtgsio9V/q/ZaVXGdK45wfSkTYYlzL+doNMKzZRqr2cwCJBeuBaiwoEOYlWl0DtVV7BBIoWcrRFMqVEmPMtcHF/2bsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 540ca098-355f-480a-994a-08deabc0e405
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 22:43:28.2080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRyKaiIT0mXGZ3rjJKBu1uThJWr3Wnl9Swzt+qJh1BqQus1DZaNzTMHGhoKHSpB5Mm6FoQCXiBBSt7YL7TxR32iuVH9OzhvdfJO5oO1UopE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4924
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7BE3A4E15DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-285067-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,canonical.com:email,enjuk.jp:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 4/28/2026 8:48 PM, Aaron Ma via Intel-wired-lan wrote:
> ice_resume() schedules an asynchronous PF reset and returns
> immediately. The reset runs later in ice_service_task(). If
> userspace tries to bring up the net device before the reset
> finishes, ice_open() fails with -EBUSY:
> 
>   ice_resume()
>     ice_schedule_reset()          # sets ICE_PFR_REQ, returns
>   ...
>   ice_open()
>     ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
>   ...
>   ice_service_task()
>     ice_do_reset()
>       ice_rebuild()               # clears ICE_PFR_REQ, too late
> 
> Reproduced on E800 series NICs during suspend/resume with irdma
> enabled, where the aux device probe widens the race window.
> 
>   ice 0000:81:00.0: can't open net device while reset is in progress
> 
> Add a best-effort wait (10s timeout, matching ice_devlink_info_get())
> for the reset to complete before returning from ice_resume(). In
> practice the reset completes in ~300ms.
> 
> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> Cc: stable@vger.kernel.org
> Reviewed-by: Kohei Enju <kohei@enjuk.jp>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

This doesn't specify a tree target, but given the cc to stable and the
fixes tag, I think this belongs on net, so I'll queue it for the iwl-net
dev-queue.

Thanks,
Jake

