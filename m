Return-Path: <netdev+bounces-131495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA198EA68
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC9A285369
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73C73451;
	Thu,  3 Oct 2024 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dz+np8HJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC9126C09;
	Thu,  3 Oct 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941029; cv=fail; b=pyqL0tBY1i4bLffvMkDlqqLmSbBCRWWG7nnha0Y+shRqsPMGrDiTAUoZcDbAl7TmrJ+HYq33oQgxZz490jZJnsQ7BFEZD4GSBi/5aHn5ySox/sYehyPQVzuBWpkCQszPsMoawjJiky6zukhxn+8XfwE+u+vZVriZEQ9a7ZFxq3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941029; c=relaxed/simple;
	bh=KM9VAk5eUYA0J6Pk7BwOthXB0auP18ztU3r56qgYLI8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANbw3az7HdTxcK3NaeiqQQ79SyKmjV23HB6qaM7Zw8+MeqbYtMw6fRx1L1FhxGk2yc+fyc+A4Y7qu6BvnXfjEBt/BKqGNAHOYVvre3Rg+B7iMwmyhOVEh3IJf5TuebzthbgDtgyjI+vA1Y/YgEQW/Y99cm4lUI3Wm3NSlyjhvA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dz+np8HJ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727941027; x=1759477027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KM9VAk5eUYA0J6Pk7BwOthXB0auP18ztU3r56qgYLI8=;
  b=Dz+np8HJN/rtlm1Lu0/3o+oCKWDrT1OTza1YsVA8iHYmBvcODJIFK7Dd
   NswSXLMRuIK5ybxGD8EGXlMJNLsEmp3HBgAgJ4Ye3xmZff2TovbETghFY
   noDqWgXpQ81F5jb/nDhar0xMDy54SwI/D3jqrFMnzPrE4bULaMW8OxW3M
   lcIfoyTOctilINVpGe19jIzfIR+plmVebCceKDEUjlgUus9z6VHuJV72+
   dNZRJB6g0B2zh+DzXcqRWhBPfgQCaLZX4D4xLAI8XZO6LdJnHxjEkIstP
   Ls67ZMTUhdAFjjnmwAMqYjTJ+JWSMayKpRYCVCBpLzOAEi1EaQC9T05IL
   A==;
X-CSE-ConnectionGUID: hSuYAr4hRIe3vW865TTojw==
X-CSE-MsgGUID: NSrFwFEsTG6ZNEdiDdipsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26634309"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="26634309"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:37:04 -0700
X-CSE-ConnectionGUID: 7TdLjO1XRdy6p6PIFtsWGg==
X-CSE-MsgGUID: dCZZYUxnQE+mjysIhJJD6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74582698"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 00:37:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 00:37:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 00:37:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 00:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaN2wpghhZnNR7bTJ0ei9TkxPt5GISbz9NAq3LWcVbrwuod3FKJtEha35nVbYanHw6iORpdosfE4QDFK9DcmeNelbYhqb+rN1Sm+sGjq9LTZ2MgnJINgLXkOMpqgqfwYX2ywDXqDkYHsRqGTA7psQFx/Mz/b0NZs8c5yPW/PSTAO91lBtq9OosJ2V7s/pHObrckdce0YsWsXLQ6s3FslvRIDdb6iZgQwReB7PmSX1iMkz8l+fsDl4CGDh/96klKtPlSLGw/WQJVaQY71gCL1PG/CnngRKIcUUEkwkuZNYuAZYbSUW4vTITOXpHTv561rtphlZJsYQ+ZtktKN/WUafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsXwHy2oDDTS2yqJJVKDtPQG0nEH18Vc+PVykUldEOk=;
 b=uVd8RexOfwKaEWevNbG6OPaY3BB+8L1WSsw2tzR9NuD5osfcyXp4nrbArq5YTKtg1ROShbdafrcQosO2pXYw9Ft60R4zDv22VfvVssdWmX8nTB7oJwVeH+Q+zMUzxMf5E/Rb2+i+lGJXKoIIH8xVP3s2rQYKeY0RZl9A2JaPqt9+lOqtHxMdIE3VmRPfvS9EPu2U4jWx9zsKkJyaICE+WmRNOCBnFsqmE8M4MhUytEZTTM62fqzzde8nKV5fO5wy2doQYTRC0akfmiqCWaf6qDZNjuhC/CH6RPiZzS44jK38o7Av+U0sObq+1mxONPurQRlOragPQZ4AhGsVQOXJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:36:59 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%2]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 07:36:59 +0000
Message-ID: <e64fdb4a-f05d-4a99-aabd-221ed4376580@intel.com>
Date: Thu, 3 Oct 2024 09:36:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: v2 [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link
 when autoneg is bypassed
To: Qingtao Cao <qingtao.cao.au@gmail.com>
CC: Qingtao Cao <qingtao.cao@digi.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241003044516.373102-1-qingtao.cao@digi.com>
 <4f4baf9c-b9e9-4add-89d4-75f3150264b0@intel.com>
 <CAPcThSGqLiv-B+VUNtJoq9NsgtCWfiposknbJySkWzLJkC78dg@mail.gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <CAPcThSGqLiv-B+VUNtJoq9NsgtCWfiposknbJySkWzLJkC78dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0095.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::10) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DS0PR11MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 817d593b-e986-480f-4fd7-08dce37e2a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmFxZHNxWGxxb0ZmdnJGdVNhc1Y3aitkUytmS2ZUSjNKdG1FOThoL2M3aWgy?=
 =?utf-8?B?M1ZYbDUxa2hzVDJtL3dwUEtkNzlFcm5PMGh2WHQ1ZE1LRWhqRzZqb2xCczFN?=
 =?utf-8?B?VExDMVU3MHdicFRWM3Y2QXE4UWVCTnVKRnRyMmRBTk9WRVkxZXA0MjhtYlA1?=
 =?utf-8?B?UWlQazZoekZoenV4MEJucW5ha0U4aVVadmJaZUFObDZmaDhiR0dMOTYxRkNk?=
 =?utf-8?B?Ulg1K1ZLdmlSSFlvbTZEY3NWOWlzcG9rcE9MZStXd0hMcENMNWdNN0xaSTA0?=
 =?utf-8?B?NlQyL2tzbDNaUlNvR2VvUzRVQUFYRGRjNWdaTHgvQVR3aVN6Mnducit6NWI5?=
 =?utf-8?B?Z2huQms0SEw2WFNqTDVCTlVKOEpZRmpnelJxM0pPbmcrb3drUmRqR0JVQ1Ny?=
 =?utf-8?B?NzYxUE1rYU5TN1YwNjBiejBsVlZOT0JCbXhFY2Z0UVYwSmM2TUNNcm9xVzJR?=
 =?utf-8?B?MTZNMG54aTJKTDNab3dLbFB1QnZRR01reWU2SnI4L051Ykt1c2FzQnBNRGFO?=
 =?utf-8?B?a2lvMlJJSnphZEpnQUw0NGowemF4d0F3UVRzcFQ1N2ZIN3dWZ3o0alRHK1ZV?=
 =?utf-8?B?d1djcWl4QVhrV0pYZTd2UUtVZUpiK2RQRzFkclNMMTV6c1QvbytzSk5zVzUz?=
 =?utf-8?B?YTU4YWFFbWlYM2J2bm5zMXY1bGMzSnFXZ1VheDVUZkdTUzFIaStsaVhDQkl1?=
 =?utf-8?B?VXNiZzJxTE8zZmZMN01hTE5CR3JGSFVyYmp5b2JoeDR6QmN4UXp6THM4Rkw3?=
 =?utf-8?B?S0IwSjhRRW9JcWtYUWdoUDVHalFXREhqc1dMTTJYUHllK3hUT3ljZnJKOWs1?=
 =?utf-8?B?K1Mwci81dWdsTmtIQm9LZTh0NC85Sm1FOVVQZGY1TzYxdmN5RW8rcCtyZ1NP?=
 =?utf-8?B?V1VSUHBlY0xkK2dLVWpYWW9lalFDQlkzQ1ljbk05K3gzOFQ5bGVCTkowKzBF?=
 =?utf-8?B?SFNMRU1zY1lUWEZaTjVSai9HMGNIaEo0YjRwa1pjSWpYZmFGeHB5UDFoM3FL?=
 =?utf-8?B?SVdJcER0R3lvZ01JQmFlZHNhbnh1Ym14dXRYR1NyN3lzTzlrWnZwMmVKd0V5?=
 =?utf-8?B?QXFIYUQ2Y2pZQ1pIblYxTTdPSGQ1U3hzL3dZelhxUjEvNEI5T2pQamZDRjU4?=
 =?utf-8?B?Q1huQ3RPN3dLSDZFQU9ic1ZCOHJLUTNYeW5NUjF3eUNYRnBRanRtRXlkMmFP?=
 =?utf-8?B?RVVqV1k1bWJhL05aUXp0N01pQmh2YytMcXNFd2VnTDdsenVtRUhUSm0ybExZ?=
 =?utf-8?B?RUlzdVIwdjRSM2ZRMDJaODdEaTBrWHI5TTI5UEJkNzU4amJLOTVIc2xKbkdW?=
 =?utf-8?B?bmQxdGZFdUQyMDlEeldJUkNPQ2xTdTV0WmZFcXVWQ2F2NFZ2cHk0TWRBOWFW?=
 =?utf-8?B?ZERiWnNTU3N5c0tFckpybEdQa3I5QTMzb2VDekl1VDhxaXFvdEs4dFJmSDly?=
 =?utf-8?B?eTA0bUU4Zis1UEZNNklpRmlYaGwxL3JENlZHT2dvUzIrREJmRHFRdVdHeGVV?=
 =?utf-8?B?blJLaHN2TU5JdTgyTTcwbVdwL3R2eTFaQ3U0U0lrUU5aNEYydkU3NmlFdDZE?=
 =?utf-8?B?NG5YbWtUVEMyeEdQY01GUUFSQi82eCtET3hOUXVxSEprYUtsdTJqcldhQVlr?=
 =?utf-8?Q?PBlWyVe4InjUoeAmGUSC4MvV+C0H70I2SJqC8eQxt7G8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azYwWXcyODc0L2x4ZExmQ1IvSDcyUjV3VGk3WjlLRnQ5UlJQbDJBQWxmSDdk?=
 =?utf-8?B?MDNHTld4Z0Z4K0pkblBxd1IzaEV0VmY5aDJDc0MyVTMrVFhkeG55c0QzQURr?=
 =?utf-8?B?cHRGNDc3WVhmZG5DYzNvTURoSUw1bGpyQi9waEpXNU1tWEc3OEtYMFFEZ1lh?=
 =?utf-8?B?QmdoTkU5SXRvdDM0TWI4eVVNdnFON1EySjBFU0VmZ1h6WDcwY2p4a0svV1JT?=
 =?utf-8?B?cUplMmx3ckw1T0M5ZFdkOTA5V3hZTm40R29EV2RGVHdNcFF6VTFiOUJGMU1R?=
 =?utf-8?B?L2tZempveVYwNkV5QjU0VHBpVkRjTWZOSzVwVXVGemtOanIyWThIOXZqT0Ix?=
 =?utf-8?B?UFptMklUeXJZcjJHV1pWeHR5R29FOVpocU9hcFpBUE1SMENBbXhhY0FwTTh3?=
 =?utf-8?B?THduakFOUVI1MEU3WFJKK1I2UU1DdWl4Yjh3Szc3Sm8xTG9lT2Z3TUd6b3pV?=
 =?utf-8?B?WnZmVlRFQkJVZTVQTkRnc2NSSC9CSENWK3JkWXlLZEFxUkc5bDlINE8xUC9v?=
 =?utf-8?B?dU5yekgzTzJBSjJoNDFabmswQ2xTTno1UDFsanBDVnk5dkdKVWQ0WFJ3TFRB?=
 =?utf-8?B?ekpGMytTWmM4TzIxcnJqa2R6dUc5QSt1aytOa2FDdTlFR1p4blFBVEMxOHlX?=
 =?utf-8?B?cVk3dWp5WGgvVDhMVXl6N1ppS0xRcTlwRWlNNHRZMklpNkJjV2k2UWx3WGtl?=
 =?utf-8?B?ZElzS2lXU2M1aFVmOHpjekxLRDFESVhwR2k2WDJpVDZ4Q29tZElMRnJoSzJV?=
 =?utf-8?B?NHdNOUs1ay9JWTQxdGtHbGZSQXlNZFUrend0YWhsVXhGTVh3TVVVbEZMTXRp?=
 =?utf-8?B?R0RUaXpqblF1ZmJ6MUZTRVUrc1l4RDN4Y1RXSGJPanVQQ2RpM1laRXdOTlhh?=
 =?utf-8?B?cWk1Y2IrclpKbzZUVUJaKzBkMzBKWjEvL05LcHVieDZzcDFqVjBET2JZWlhm?=
 =?utf-8?B?SGpuWXlKL3l1d2pCa3Z2T1hxSVVoTE13NS9uZWlUdXZkTUxGbUlrNDBTUis1?=
 =?utf-8?B?RUZCQ3NWdnd0c2NleGgyVFRzNmY3VXVDZ1JTWFNIc0FNTHZNaG5lVUdmUFFn?=
 =?utf-8?B?Q0xRUk1iR3grcWp1WmFMU21PWUVvN0RHRnNYZWgwS0xVeEhFRVVXS2ZWdlIy?=
 =?utf-8?B?eml1ekJjUndHZ2ZucG5oNGlMVjV5ZFR4K2tFNWd2ei9vSnN4TnlUZjVocjFv?=
 =?utf-8?B?WktKSFdDUWhBWmR4M08zVXVsand5K3kzcE1rdFdGdVRkcU5IZnpBNHcvcWdZ?=
 =?utf-8?B?cnpSWCt0OWw0OGRid2VweThsMmdYUTljY1dWL1M5amx2b0JPTlg1U2ZwMThE?=
 =?utf-8?B?bTFsaHYwVFZhZnlrT0hwTXpFUC9UaE5pMGJMcFEvczdvb2dJa2dZNi9GY3JE?=
 =?utf-8?B?R1VPdlJ4NFhNKzR2ZGtka0NCT0lSczEzY0NIbjV1VzdPaUJDMDkxV2FxNGVa?=
 =?utf-8?B?cWVOVEdmRXpkT0NORFZDaDQ0TURpZThvRGdDbklpUGdmMnIydzlSV2ZiWHNY?=
 =?utf-8?B?Mm5SMkhIQ2wycThadEtqSmlVakRaUko0M3Eya2VsaXZqYldOTXV3dXZ4WlpR?=
 =?utf-8?B?U2wvTEJzanV3a3dYS2p4VG1PSzIxS3M2aHlxMm5wZmtkaGR2Z0c2NE9QUWor?=
 =?utf-8?B?TENQY1MxdDh5RFVBc3BaWm85azdOYW51UW5QM3BSVUJpUmJxUXdPSURDbVhD?=
 =?utf-8?B?dG9oQVNZd0UvckJBYWh0NVBTaE14ZENNTXllQWRtVngvWGRUd00zRm40SXNH?=
 =?utf-8?B?UnB0SVc1bjRCbGtzQWVYZzFVM0NZeUJrbDI0R2tKZU52OHlCT3gxcWJFRGxj?=
 =?utf-8?B?angrZnpLb3crK212OWdhcGZHUDNCZUs1S0c1ME00aWdpMWk1cWJUc3BCTGoy?=
 =?utf-8?B?OGNHV0gveU55QkJudHVHS3BXWjZHVEpyWDZzdXZuelZIMTZaR2d5anlGZnB0?=
 =?utf-8?B?cCtNTnowMStsR2k3bXFpVGVjSGV5R2FDSVljeStXS0VKNWRnNmZWTE9BVUtz?=
 =?utf-8?B?S0dWcENXOWY4a1dicytHaTFzMmVqbEpGOTR4QWNWc1dlTWluNlhYTFBLKzFK?=
 =?utf-8?B?UzZJTWRidWpJVjFrNHZzbHFxM0pBbjZBN2JabWlQNnRwVnZIQW1BT040bUtI?=
 =?utf-8?B?eFZGdEhLWmFISXJxdTlKVURMaytka01vTVRNZTJwQUVJUnpXdmt4aEZVeXR3?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d593b-e986-480f-4fd7-08dce37e2a48
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:36:59.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyz+eevzRYSN3drVMXofN08FOTiNxvC6tbPF5bckgYVMZ8iUEX9fAZEgf+MqU3T4v0mH8ibjfh6RFrWB3CpIsr4OIXzNaxKNx+RLheLVPl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com



On 10/3/2024 9:14 AM, Qingtao Cao wrote:
> Hi Mateusz,
> 
> Please see my inline relies.
> 
> On Thu, Oct 3, 2024 at 4:54 PM Mateusz Polchlopek 
> <mateusz.polchlopek@intel.com <mailto:mateusz.polchlopek@intel.com>> wrote:
> 
> 
>     On 10/3/2024 6:45 AM, Qingtao Cao wrote:
>      > On 88E151x the SGMII autoneg bypass mode defaults to be enabled.
>     When it is
>      > activated, the device assumes a link-up status with existing
>     configuration
>      > in BMCR, avoid bringing down the fibre link in this case
>      >
>      > Test case:
>      > 1. Two 88E151x connected with SFP, both enable autoneg, link is
>     up with speed
>      >     1000M
> 
>     checkpatch.pl <http://checkpatch.pl> complains about this line, it
>     exceeds 75 chars allowed for
>     commit msg. Please adjust.
> 
>      > 2. Disable autoneg on one device and explicitly set its speed to
>     1000M
>      > 3. The fibre link can still up with this change, otherwise not.
>      >
>      > Signed-off-by: Qingtao Cao <qingtao.cao@digi.com
>     <mailto:qingtao.cao@digi.com>>
>      > ---
>      >   drivers/net/phy/marvell.c | 23 ++++++++++++++++++++++-
>      >   1 file changed, 22 insertions(+), 1 deletion(-)
>      >
>      > diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
>      > index 9964bf3dea2f..e3a8ad8b08dd 100644
>      > --- a/drivers/net/phy/marvell.c
>      > +++ b/drivers/net/phy/marvell.c
>      > @@ -195,6 +195,10 @@
>      >
>      >   #define MII_88E1510_MSCR_2          0x15
>      >
>      > +#define MII_88E1510_FSCR2            0x1a
> 
>     Please use GENMASK_ULL for creating mask.
> 
> 
> The serial interface autoneg bypass mode and active status are just two 
> separate bit in the FSCR2 register, instead of complicated masks, so I 
> think BIT() serves them right.

Ach, sorry, the GENMASK_ULL usage is not applicable here.

> 
>      > +#define MII_88E1510_FSCR2_BYPASS_ENABLE      BIT(6)
>      > +#define MII_88E1510_FSCR2_BYPASS_STATUS      BIT(5)
>      > +
>      >   #define MII_VCT5_TX_RX_MDI0_COUPLING        0x10
>      >   #define MII_VCT5_TX_RX_MDI1_COUPLING        0x11
>      >   #define MII_VCT5_TX_RX_MDI2_COUPLING        0x12
>      > @@ -1623,11 +1627,28 @@ static void
>     fiber_lpa_mod_linkmode_lpa_t(unsigned long *advertising, u32 lpa)
>      >   static int marvell_read_status_page_an(struct phy_device *phydev,
>      >                                      int fiber, int status)
>      >   {
>      > +     int fscr2;
>      >       int lpa;
>      >       int err;
>      >
>      >       if (!(status & MII_M1011_PHY_STATUS_RESOLVED)) {
>      > -             phydev->link = 0;
>      > +             if (!fiber) {
>      > +                     phydev->link = 0;
>      > +             } else {
>      > +                     fscr2 = phy_read(phydev, MII_88E1510_FSCR2);
>      > +                     if (fscr2 > 0) {
>      > +                             if ((fscr2 &
>     MII_88E1510_FSCR2_BYPASS_ENABLE) &&
>      > +                                 (fscr2 &
>     MII_88E1510_FSCR2_BYPASS_STATUS)) {
>      > +                                     if
>     (genphy_read_status_fixed(phydev) < 0)
>      > +                                             phydev->link = 0;
>      > +                             } else {
>      > +                                     phydev->link = 0;
>      > +                             }
>      > +                     } else {
>      > +                             phydev->link = 0;
>      > +                     }
>      > +             }
>      > +
>      >               return 0;
>      >       }
>      >
> 
>     So many levels of indentation... Couldn't it be merged somehow? I do not
>     know, maybe create local variable, store the current state of
>     phydev->link, then set phydev->link = 0 and restore it from local
>     variable only if (fiber && fscr2 > 0 && (fscr2 &
>     MII_88E1510_FSCR2_BYPASS_ENABLE) && (fscr2 &
>     MII_88E1510_FSCR2_BYPASS_STATUS) && genphy_read_status_fixed(phydev)
>      >=0
>     ) ...
> 
>     or other way? Now you have 5 (!) levels of indentation and almost
>     everywhere you just set phydev->link to 0 depends on the condition.
> 
> 
> Thanks for the feedback, please check the v3 patch just sent.
> 

I will take a look but a general rule is to wait a little bit longer (at
least two working days?) before sending next version of patch. It is
mainly to give a chance for taking a look by others. Thanks

> 
>     BTW. We put "v2" inside the tag in the topic and specify the tree, so
>     instead of:
>     v2 [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link when
>     autoneg is bypassed
> 
>     it should be:
>     [PATCH net-next v2 1/1] net: phy: marvell: avoid bringing down fibre
>     link when autoneg is bypassed
> 
> 
> Thanks again, also improved in the v3 patch header.
> 
> Warm regards,
> Qingtao

