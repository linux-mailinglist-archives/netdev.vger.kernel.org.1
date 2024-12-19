Return-Path: <netdev+bounces-153450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED79E9F809F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B4D16E114
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4118A6CE;
	Thu, 19 Dec 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvLxKsAl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76821155308
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626873; cv=fail; b=p1DeMRuvyTxWLgOxt2WROqssSVZisXXQJBKPBkOKoSIsFC0dos5+Xv3x0LAg621h2FuWGDQYNnInJvfKUM/sQO6Rx7hUYyQOQfmRrRgDMzUSR9ZpbWS/9/I5rPVtpd/kYuDzNaklZEQSb9XdT1geRGz3c2NyizHVUpUlz7tjE/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626873; c=relaxed/simple;
	bh=OxllJGkYUCV9nxmW87WfK+sN3o9f2a0w+pByOO8tHEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=taxbQpHvGsd4ogE7eTDdfTR6wHxur98RPt5ZmbRXeBtPEcspgecUGA+224YbSNc3qbi9ttTXt24q5AAVm35nxjkqmsJWAGIzbTO/a2fzcnhXAn5Q5wNqzE3m0eUYQE/0F96mAHn0roh+6hjr29JTl1DHlB8ovO7Z5a6ubxCTVAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvLxKsAl; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734626870; x=1766162870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OxllJGkYUCV9nxmW87WfK+sN3o9f2a0w+pByOO8tHEc=;
  b=dvLxKsAlOdYVqfzjtNQdlcQ3IUK3H5nnVJNYp6AlhXQlrz738b3JoIgX
   Pqa1ETsCtQ9Nhiwupfkf0oTEqklkX+4C4dwk7fp3iiMr2pcJ0P3TRbrUh
   zkjbMtbaLYP2JtWlO0Hge4087MXfaMP5t+qhFtwi/ApYAFSMVIzW2mUqD
   dZIeeo2oBRSh91y3vBQhJLZFr2Ass3Jr0D/9WsO0MXTl+c062wWJTKKbH
   4R5UOaHLNpcXPe2aj6OAc3WP7SXsoDYLJWXnF1p+k7ccq+sIIPHr55y9c
   EwSEGXInTa/PCsEqqptBYH18jnLvhkjwpGYMaXf1ySdPjlLip2PqtEM08
   Q==;
X-CSE-ConnectionGUID: 7Q1UsKr9TtiNI3GaC35r8A==
X-CSE-MsgGUID: WtcXKmX0SZKqvhTdAm6kPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35363599"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35363599"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 08:47:41 -0800
X-CSE-ConnectionGUID: IPNLp/6/SG+Xkw31xb4Cog==
X-CSE-MsgGUID: AKB9NmY6Sp61z2z6PoqZqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="129061872"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 08:47:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 08:47:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 08:47:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 08:33:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6t+nuvhdT23Q/xjO5x+GbQB1/7VPF1F2/vW3oX5tNi4sAf/JI5TDiYRVMZtcYHclbYoaABurY8XfYeVaf1xCHs+BmxDropfpUaumXfhF1WkC9+llbECB5WSKEelsnM89BPLZmQ0VznIt4+voA8f/wpUuHdJeYJImwLQs4GUl97kBjfHUuUmVSoKCyZvNh4+Gu7OxsG+Mkf9YqPTWd6XO7D2fMCq88UlFoK+1bIKSuamNcNaiHIrfoWd6CCzlTRQw5dYn7JRsqnRnnVftjzDjqGc3JdAP2Iqb50WYpNwBMLOwNZsHW1pEliW3shU9TZTCCKpor4tPrgUCvB9X+ayJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLKxbk6eEM6xdmRPkv25NpB1m45ZP8AxeT+rLEK8FmM=;
 b=kz9TFuNNl9/jTWE6WLRC/S+FY4BhJ37//QY8EnpMkLfJg5e7xRld6CBKj7afTAcvZUP3S79Vvu0GtrtKTwT4X+tILoSgUSqR3UIlEA+TYWu8XBFSo52UfI7vejZlBg8JMijB8tx+euMmCv687Nwze1eIADHq6KDqouWvmBrJcHKBnPJHRKYfZS0kZwUOoogLkELc8/1xDJRUn7mNh/Wt6ksAm6r3Ng4+mfFISDIhurRmAN0PY8F9A8ipI1bUdE8IzLZ2hCeQp5ZvwbcaTlosJql8TDd1LB757p1lfe3FvsSxeiPmENjn23agevSNSGWVvVzVObJ2+tflvOZor+kLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 16:32:18 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 16:32:18 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "Olech, Milena"
	<milena.olech@intel.com>, "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"Korba, Przemyslaw" <przemyslaw.korba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix incorrect PHY
 settings for 100 GB/s
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix incorrect PHY
 settings for 100 GB/s
Thread-Index: AQHbRk+jqDLPux5ANU23EEkMwWNRjLLrvJsg
Date: Thu, 19 Dec 2024 16:32:18 +0000
Message-ID: <IA1PR11MB62418B1498A80CDB1BC3EDB88B062@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20241204132218.1060616-1-przemyslaw.korba@intel.com>
In-Reply-To: <20241204132218.1060616-1-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|BL3PR11MB6435:EE_
x-ms-office365-filtering-correlation-id: cb19bd7d-0f9c-4e2e-1f90-08dd204ab459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8cWA1TrnyMx/BIhBieYWPQjniA+evk70efpY6Qe9kw0Ltsf2OJ7ZimeveUxG?=
 =?us-ascii?Q?BAVLaG6wPCJuk0X/ZA30+4J1HbwNnwmiaJidaxgEurJNBn/1wIyo9OnA5O90?=
 =?us-ascii?Q?KtFU/UCs5PNhnvLIhUbNS2IQ9gtpinBLxcqCEtvxdqcaHzeuJJy3YuH3XdYu?=
 =?us-ascii?Q?43VxvVp1vyUG0sfeyu8c+eAgXzlxpPTcqOGpp/U++Vb2MFtED6uP7txeRJkw?=
 =?us-ascii?Q?MNCfwAkRNjA2BnDkiG4+zLYQjQ5EAEfOTASb9M6cUYj5B/aFfAo7mCKCk+qp?=
 =?us-ascii?Q?ILlFcJE9F8q4INdh0eSEB4gWWNCS8S76sb1Sd6YbU2+1z4Oux//lbvq48Txl?=
 =?us-ascii?Q?ZDuDSfJMXKei77urgxGBJm1p1RUriVYNmhNSTkaN05w2A5j/bm6lI4OiozaU?=
 =?us-ascii?Q?v7nE2tey9Vt5/mgChPrfKbimH1z1A2yhHsp2kcTVMO5K9m7XSV0on7sQ0fbz?=
 =?us-ascii?Q?slAWDEc7J9n/MHZ2JxbAzpbnoUguhF3ozu32BwChb/8LzUnPU2b5GmxNMWNT?=
 =?us-ascii?Q?2dCDwClJw/xeYxb7qRvXqL197+GYfUzzKGTv0cJZx94Jo14/SbVUVos0iVnn?=
 =?us-ascii?Q?bPL1DPPs+XtsLvXfgvUEbk6LNhdH5EnQTGlay5m9Uokvy2KFiaHRydJnAz3p?=
 =?us-ascii?Q?tbzb0T64Ui9JVmpmXm0r0qq6tvsu+iOIrKcgoQW/yUBQ+vNysQXLEWKa/RkY?=
 =?us-ascii?Q?xFI6HCqPdDqYu3OwP+bulYuEsM9/HM6V5D/7GpAX5YqgrjOzUjnorEQkIyqA?=
 =?us-ascii?Q?S6rPBZI1em6III2TCgzkzRcgGO7TxV0llwt6hRpDsGghF+UsUeDPJggiZ+tW?=
 =?us-ascii?Q?2fQNUoVz7vOzn6LEcwyxdvvW2fj2RidvxkXJ+wLI3Z8U0OoDQnqVdTzzmoJp?=
 =?us-ascii?Q?2qwS+/fC5yV452Gd0hP08VFrWRJgHrBXrMeh2vWrIkHK6UrfO2ByjskKc72Y?=
 =?us-ascii?Q?w0EZlDsSNnWXWA9d6WRliUr/lHG8vNWk1BXH/UgFfdvpxwXOVgH+WY+ElzWi?=
 =?us-ascii?Q?IzBM9NC2ObBvaGe3lI5VfRkUFzO66A43xMiXTiy0AFnUSROSM4qrWt4x4Amq?=
 =?us-ascii?Q?URXtUMklFLr9WNgMqaI+bwSbgnp24qU5XPG1RTqVqlZCcaXUa/NEpzLgsK4Y?=
 =?us-ascii?Q?xr5GoG8lSRg3RMqfOoVdj61u+hvZFLOK1Uny6acpN9PRn/MXeI/sHHvNZVVh?=
 =?us-ascii?Q?X9WFlTYnbe2f41ipPFS/iR1gtZcG5KhD1dWz3qVHQy/SBkQCaiacJ+9YssDT?=
 =?us-ascii?Q?zppDRT5S26yUCD0cccpk8VjCxrjpMauNx4/Hw+tQRJODrOszKL8Q03biYioD?=
 =?us-ascii?Q?H4MfWVnOJAprY4n83yDV77NczDB5ZjI50+BkIrSf6adLt2Sw6tj5U7pRYiKM?=
 =?us-ascii?Q?KNsIFaREhCEPujy37Tw0YYeY5ZfJbxH8Dz40S4C8Rt6cImViBkDIEV8E8ctT?=
 =?us-ascii?Q?itnaFN3QekLnXhVHXDxkd6Y8n5sfMXoM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fxVThWB+I6THNnXMJyr8XgnDNGhc4weKXrbwaUsM6Q7+9zI0So2uta/y/8BX?=
 =?us-ascii?Q?il82i6Ucijr6Ko3UZeu1G0n8WZeAMLmYPbdG14haS0NCPzQC8T+E1GQa+pPG?=
 =?us-ascii?Q?AuEk45iD8GgtrWyv3SZkTo4iav/05vnqqKt/20hC1jM10Ce1r+dJxtWrranz?=
 =?us-ascii?Q?qoKKp4cx/VBm6genCR/8N/E1hfvn2uVZ8QkYKbF+23cA9Af9gC6Bxm1zw/rE?=
 =?us-ascii?Q?5orpkYquhPry39YOw/LHLo5W7tERrMmSPWid/GIi/1uDhCwav0GnThBrIUJa?=
 =?us-ascii?Q?wx+hcgHqApW9++2Z4RRnw7j+dgEkl0X3R5pHtDc3ipDBPEybKvBN2S9XrpWe?=
 =?us-ascii?Q?jNa9Hf+wygqGpLpv38UFOH2LMa+KyrlcLLjtp5zWI3kr4J0ZdMFA3Efsgl3c?=
 =?us-ascii?Q?L6x/r6pH9/WRmMB1kr9QynY/r9E5GTUs+prDS9tMS83KqvBr9AzniY9gwdbf?=
 =?us-ascii?Q?yLvCZGYrdaWwSlxB+6ilZHk08I3sZ3E+ipW/vbnrvx6ai8I7bRw6/38e9bby?=
 =?us-ascii?Q?ce8GksUI45e7fcgeeRmmNbd6RmCZZMywxUxTceGasr9fRk/y/DZfyqk0cGaK?=
 =?us-ascii?Q?Ndwk1IR3ek55tYtsCBz848rZz7V2ttCqBX+lsaus/oQKf0vtHKjOuh6a3Er8?=
 =?us-ascii?Q?tW6IMDu5sGe7uUzbKPkG0kkkhD8Zahy64M/NVve9FyLcF113JLM/GdPQiFfE?=
 =?us-ascii?Q?Xin9jvHWvM54vARFIPFl2IKDcLDvkmWB9U5UNmqhewkHh7JEOU+to1UPS6iU?=
 =?us-ascii?Q?/ewADVZltPQMTiFT9RiuNUdT8mOk2OvSi8gD+vEg8JDicBtNnKVZZ2EYtcoT?=
 =?us-ascii?Q?1h0A7UELBUOiTObaMkSLHROIEmgl6LF/KnPP9G+RPUVQG4cFY9zjGqXROmx1?=
 =?us-ascii?Q?jwaBrMErQn6fueP+DAyYz2jWIMYI+KvaS6wD2CSSDqttOaJ4EC/A/BPlRnOo?=
 =?us-ascii?Q?XuTfCPZ820I3Cm0sJDs0iKT5ilV1629IK5SmOiwUrph4jnBHjmb58rEPEqwv?=
 =?us-ascii?Q?tb83qTIbctCNaYu84M1EaSHqDian6rum2xwiOEhVgDweai8ZmwBDurK8zJQj?=
 =?us-ascii?Q?bDKPhU8AXVmFYambC1eMXhRRq3t0V5OumSIN4hdwEZPTvDEvaHCtG8ng9VDP?=
 =?us-ascii?Q?A8T6fkzbNPP0ASEMxx7FCBGdglyFx/wx9biGwlRdS/1wlKcMCIBA8junO/eN?=
 =?us-ascii?Q?puFBbaaAEw7B/AhVV425AbCESUf6YXk65VzNBrgVfjxyNUPe3ej94ypO5qpP?=
 =?us-ascii?Q?momh97wgKgyF++lyvfAzfYWESKA7ZH73GznMbLym0u8C6WQFkndVIHZyAn3z?=
 =?us-ascii?Q?ptl4hWti6kULx3g/ROpalubYf+HAlHlKw+cqoDWRfkcGHex4OdVD0QQqGB9T?=
 =?us-ascii?Q?xD4k78DE/Wn9Ppq9GN/UtkA+J1tDf121eU8lU1tNMG6o4WxVWQ3yFLQv1hVZ?=
 =?us-ascii?Q?7YMkzRqErHetgsMc7jaGTihQ9FLh8U47bdl75S48mnOhL2qjobxsoVclr7Df?=
 =?us-ascii?Q?yzvZRJTEKxkJmDW2Zz/65CnuU5ATac5gG0KBI+cZLJ16vcCkH+9wjynvD8R+?=
 =?us-ascii?Q?seslDT1O24AUvakswleJuawfihyQNgyLQFGcDtpt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb19bd7d-0f9c-4e2e-1f90-08dd204ab459
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 16:32:18.1450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kV/Uk1DR/JmxwTR67H85x1y15uJbPli0flVZj+jFy7kKauiFpQb1o8vssMNnTzMz0SPuNzLpd9yDLliMnGqlug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemyslaw Korba
> Sent: 04 December 2024 18:52
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail=
.com; andrew@lunn.ch; olteanv@gmail.com; Olech, Milena <milena.olech@intel.=
com>; pmenzel@molgen.mpg.de; Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix incorrect PHY sett=
ings for 100 GB/s
>
> ptp4l application reports too high offset when ran on E823 device with a =
100GB/s link. Those values cannot go under 100ns, like in a working case wh=
en using 100 GB/s cable.
>=20
> This is due to incorrect frequency settings on the PHY clocks for
> 100 GB/s speed. Changes are introduced to align with the internal hardwar=
e documentation, and correctly initialize frequency in PHY clocks with the =
frequency values that are in our HW spec.
>
> To reproduce the issue run ptp4l as a Time Receiver on E823 device, and o=
bserve the offset, which will never approach values seen in the PTP working=
 case.
>
> Reproduction output:
> ptp4l -i enp137s0f3 -m -2 -s -f /etc/ptp4l_8275.conf
> ptp4l[5278.775]: master offset      12470 s2 freq  +41288 path delay -300=
2
> ptp4l[5278.837]: master offset      10525 s2 freq  +39202 path delay -300=
2
> ptp4l[5278.900]: master offset     -24840 s2 freq  -20130 path delay -300=
2
> ptp4l[5278.963]: master offset      10597 s2 freq  +37908 path delay -300=
2
> ptp4l[5279.025]: master offset       8883 s2 freq  +36031 path delay -300=
2
> ptp4l[5279.088]: master offset       7267 s2 freq  +34151 path delay -300=
2
> ptp4l[5279.150]: master offset       5771 s2 freq  +32316 path delay -300=
2
> ptp4l[5279.213]: master offset       4388 s2 freq  +30526 path delay -300=
2
> ptp4l[5279.275]: master offset     -30434 s2 freq  -28485 path delay -300=
2
> ptp4l[5279.338]: master offset     -28041 s2 freq  -27412 path delay -300=
2
> ptp4l[5279.400]: master offset       7870 s2 freq  +31118 path delay -300=
2
>
> Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> Changelog:
> v2:
> change commit message
> v1:
> https://lore.kernel.org/intel-wired-lan/20241126102311.344972-1-przemysla=
w.korba@intel.com/
> ---
> drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

