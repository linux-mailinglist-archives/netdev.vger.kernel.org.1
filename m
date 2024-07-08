Return-Path: <netdev+bounces-110021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC87A92AB1E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1EF1C215E1
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A6C3D552;
	Mon,  8 Jul 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WE4wOk9K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879812E75
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473907; cv=fail; b=XfU6DSz/bTSnbQEeXsQfrcaqyN3z/blm3sb38QdM6qqJT9kJB20DHaLcR4WgWmEmuT8p1BrHhAYpdyuLUZTDKAqgkTxmnSRvdWsPQgvrQDE87nZ0J5qVBIv8uJDoYQlAg8gFYDR8radapb+4iSUpsZEf/WDFhExnPvstApd+QM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473907; c=relaxed/simple;
	bh=IIgAkGS0z0b86dwgvVtLWtSenBdoKdU4x8zlCSbGF+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYBhYt6I3VJvaDYDLpgs+UGLI/AhSVhUTACUUqt5nSuVXQsfFEZC+B8zkhZrjTdNskidgoMdbrplpbp1bjv5A/5HKC3ajc8QFZ/+4wFukZ8/AUn9UbwH9ynbYMt1xpHqAfmJnQhPYEMNbZ5QisZuUszJd5sA2/axM4hOj2LAvH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WE4wOk9K; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720473906; x=1752009906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IIgAkGS0z0b86dwgvVtLWtSenBdoKdU4x8zlCSbGF+Y=;
  b=WE4wOk9K2uqLiPkYIbOIPLfERfldEwD38ro590JhXfLncUQteUwIl7wS
   XP9/UrD3e2ELV+g0JZPj20pjHSaqgD4kTYRfwX8t7mJ5eFas6lCjz3xO+
   TkfooxDRerqryq+jZh7qQDVIxW0pzPi0CtkxikPuQb9iFNR1gXp2UnVaX
   HeoCW39dB8wsMinKmOWTqDzCFfDSIt5LZljwDZ8XIGc3ZYGmcsB0nnH4Y
   Qp/ohTawIpZRfmOFoYTUnTtZDRMpRd81mUaZ2qPinwnCgpXTb0CCTYsln
   ef37B6gSf9UpABJRmkTDu6bfm/xkTpLYOc8DwhEtmQnHWkp8EItOCXUW0
   A==;
X-CSE-ConnectionGUID: qhhK+pXXQ7eEkHyAjPzOJQ==
X-CSE-MsgGUID: 12kKaCdxQ2Wp5/MyJYpt6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17905663"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17905663"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 14:25:05 -0700
X-CSE-ConnectionGUID: nZlJAPBHQzCDKWu5Qz86jA==
X-CSE-MsgGUID: Dpp3Wv+oQoWQV4Ibk/NSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="47514206"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 14:25:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 14:25:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 14:25:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 14:25:04 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 14:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzQRVGnNbtpIxT5FB+8QPzDjTFq32ukIicLympReRmBcT0Xo6+KmCqW/qHEGAC4IuEkbICrX018Oi8jKVxQ2Vb7He0GL/Uiegfm+U18M/jeVevcoK2cyqnEbXyriYW9Iban8I877rMqGfYLzlC94qMxIhpY9V/uTE23v3DO+9QU3wuhmdIuiMiGU1nKX8XmNWekGbV8HZ/XjA0I0Amm803GlmXGJlGHNc0DjQXUbApvZEcKoxKOg97mwwL+x9yKrBykusPXU9qVAjaeM7IErFQbgAok13ENh7+c1JMCPWY8WHPbLdU+iRYfR+AWpXhajWmI8QvOHlF6RXgsAgMZg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIgAkGS0z0b86dwgvVtLWtSenBdoKdU4x8zlCSbGF+Y=;
 b=gUoo8t7e36QI+plsUqYJ1QwPKYkcEBENLFlwyH842UZQ2jmRA0XbhqSTSMeTIx/cWQfs2sdGcXnoAGLm8NK57nbqYgE+aieS6rj2RLpl+0MB0HWbKHI4DnYio2bFRQlOE6dEudLRBryEyZkYS+rdafRK6c7+iN/9LkwCxs3EqGUDpqudpEqbs5AZlE5YMepq/kRHdnU7tuXtBCYVIdP42UY9GGdMS2hjmmF3XEBP5qoj2P3S1h5dOZxop3QiPF9CNA9Ie46/ufSCvFDkJ2tM3oWzfWlxYuhS5Ljt28f8NXArt/BlB8VnR/8mX64PYvH27Hz06p5XTvQF6/cNjHqghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 21:24:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 21:24:57 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, Simon Horman <horms@kernel.org>, "Pucha,
 HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: RE: [PATCH net 2/4] ice: Don't process extts if PTP is disabled
Thread-Topic: [PATCH net 2/4] ice: Don't process extts if PTP is disabled
Thread-Index: AQHaxyGQiPXhLLMyBUap1HQ9HzP987HYxBEAgBSnyYA=
Date: Mon, 8 Jul 2024 21:24:56 +0000
Message-ID: <CO1PR11MB50894BA120B90043BEA857F6D6DA2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
 <20240625170248.199162-3-anthony.l.nguyen@intel.com>
 <b120a258-87b8-42c3-9b5e-ef604f707d0c@amd.com>
In-Reply-To: <b120a258-87b8-42c3-9b5e-ef604f707d0c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DS0PR11MB7381:EE_
x-ms-office365-filtering-correlation-id: 3ca52230-0243-401a-9a8d-08dc9f946a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RkNoUEZqaW1DM3ppdWF6a1pKQXljNTNqeE1uSFRJYStSMUR1YmRWZy9HYzFD?=
 =?utf-8?B?VGgxUjN0MHk3VTdiWDBEdVdCYTVjRTFmalpUcHBxMEZkMmhCL1RQS05rN0la?=
 =?utf-8?B?S0x0aGdSdUFDajh0VDdyTkpseEhqZUpkWWNIUkhOeEVvNnp2YTdRZGFzSWNz?=
 =?utf-8?B?ZjZlZnhleFVUbGdrRGRmZ1JvQldrSjBGTUIzZ1F6S0N3NjBGczZVMHVmb3pJ?=
 =?utf-8?B?MjVBd2ljRlJxOTcxVWNFVXN5SXNMOUhrNGZiVS9HWnZTQ1Q0TjlmNGp1MTB2?=
 =?utf-8?B?dkF1RmMwZmdoOUtCRkQweU5PK0N5eEpZa0pJWWdjc3ZkOUdJWVhWWVNETXdo?=
 =?utf-8?B?c0ZaQUwrYXpCeW5lZkF2bHJVTkZKclFnQ09la2hKV0ZuWUFpNEFJdzYxYll0?=
 =?utf-8?B?T3JKdWhaY2RoclJ3ZFc2Wm1sMjdzcHN0aG55T1hqVnhxdDZyTVhadzlXS2Qx?=
 =?utf-8?B?ekllL3VDRDY5NFVNTkJnZmx2N3dlNGdqaXNIWTdtQ1ZBMkhaMlY2V2txZ2RF?=
 =?utf-8?B?YW1pL1dBYWNLKzYyQzcxTktqQVdxRldkNkxrclBnWnFYSGNJUkdvTjJpM2Q2?=
 =?utf-8?B?OWlhTWYwRkRUQ2V2dFpzdnB3eVBFWWVhSDY5eGcwMERjK0xVZEl1ZGplMGQ1?=
 =?utf-8?B?Z04wQzVaeURtMUZNZjluR3REOEFsZm5HZ3g5aU05SitWZTVqdEI4TllWbTlF?=
 =?utf-8?B?QUY4cythcE1HKzVtWENxVlVlYTdPaWV3aGN1eWlKS0pmaUNSeTZ3Y0FsUWlK?=
 =?utf-8?B?bkU2TFlSL1pnZzhBR29hUWhGeFR1TXU5MEhUaWNEc0hsM1JlNkZJUXErY0pB?=
 =?utf-8?B?QUFhRFZvbmtIdm4ra2Y3THc1WDdWVndSWDdpa3ducXdkVTZkQ3FpU2tyUzN4?=
 =?utf-8?B?M2ttbCs2NWtQdjF5dE0zRzBRcU85Z3h5WFBSeUxkNlVKcDE2U00zanZyazBX?=
 =?utf-8?B?SUQrbGZTWjRJR0FCcDRLK2dNNUloakk0OUQ1Rlc3MGFjTW8xUmJDK09zaW1a?=
 =?utf-8?B?cXQ4enR2ekp6SjJtN2pKUnl1NlRLZk5pSmZSMTVSUjU2bndhczhwOCt3NFdv?=
 =?utf-8?B?TlZzM0MvZm9qTG5QNnRxU3FOZUo0S2NwMUliQ1plcDgxUlBJVGp6UWRic21K?=
 =?utf-8?B?RWQ2dXB2WG42VkpKTG1XMTRxQ1Z1bXhzQ1ZhZElsdytnc3hMRFBmc3V6THhj?=
 =?utf-8?B?dkRqVVIzYzNpRW9vRGZLNzlwNnlCemdTMEduZklDRWNqL2VtTGtEcXl6dUhi?=
 =?utf-8?B?ZCtMY2JSckZndG9LSzAxZGY5NnJjMlQvLzFOeWMzTm1GdlYrN2hUM3MvZ01m?=
 =?utf-8?B?RktMNlg3R0pEaUtLaXJkTzFpL1FSUDhlMHJncGRiN2RrMnJKMUpJVzNlSXhl?=
 =?utf-8?B?UndhdElub0NQS3F6VGpCMU1peXk4MWJXNjYwZXRocHhwcFJTdG92MDdZRTQv?=
 =?utf-8?B?LzNUMGR2R0ZjWWhJd1YrYTZDbDNFNWx5Njl1dFY3THp1K09CTGI0K2pmQ1JR?=
 =?utf-8?B?NmdrM0RCUjVmSURxa0RjTnplR2tKMzBZdGsxeXFMcXorL3VWaitUaFE0dnpj?=
 =?utf-8?B?NklTN09nbVh3MEpZRmkwTURuWm1RTnZ2ZDVkbThjUXpnNDBxS1B2UEpMaGdv?=
 =?utf-8?B?S0F2akNrNFl1MVBXRmZmRURRTnluZFA1cDk0allhQ3M2R3JselpvK1pNMTA0?=
 =?utf-8?B?QWpkckJhNnlpY21SdVI2MlRxWGVsTmVoQThrVkRsSHlnWnZncnNBUTJLZlpS?=
 =?utf-8?B?bzlqUCtid25kUnk1b1hMMS9yaDVoMm0yZEVtVWxXNCsyWDdjUFJLVnEzVEF4?=
 =?utf-8?B?aFdFdFVJVHhwZ0NHUWxDREtKcEk4aVREM2I0L2RLdUh3djlkaTNPbnBCWHp3?=
 =?utf-8?B?ZW0rOXdFYVVIMHdKSEpvUU03SnpXMmo0Z25Vc0lwYTZxaEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTdkVTlaSG5aTGdKb3ZMZForV1hOLzNoa3VZMnYxSHNpZUM4anczQ1ZVQllj?=
 =?utf-8?B?N1lPYnl5bHBvUHZKSEg3U0F2TjZtemFqUU42WUtDbXZwV2QzK0RjSkIyUUdv?=
 =?utf-8?B?MHZaRkh3ZVlacUt4Y2lhR201NWtYQ3lJdVM3U3EzZEtjVFMxdmM3VXF2MEI2?=
 =?utf-8?B?eE5QNFBqUnhROXd0ZkFRcDVOZGZRQitaOUg4eHVYQXpEcFRKbS9XY1JTVTdQ?=
 =?utf-8?B?elFvQWVmY0Q2QjZiSFpqRjFjMkc1bDFiQkUwRnpDWDB0NDZYZWdsR0FZcWRq?=
 =?utf-8?B?TzMvMHM4Nk9Ia2w2QkpLcHRuaE1YeFU4VVZqU2EweGc4SVh0Zm9lWnlCdDFr?=
 =?utf-8?B?ek1KMWp0bmYySGorenROOTdiT1lLdXEvTjd2SVBEcGRiWVJOLzNsMmVKYVYw?=
 =?utf-8?B?TExsRE41SnNrQ2laRlVSRGxXelFzOGMyZ2VjREZZa0xOM3BuSUx6TXo3czhv?=
 =?utf-8?B?ejAvVUR4UU5TTjEzVVFpQ09EQmdOcVo4S3puUjdGaTdYL2pqSVVpTVdBWmp3?=
 =?utf-8?B?aW4zYVZmZWl5b3h0ZGJoSTVZTjIzM0lBL3h6ZDdaSHlGZXAwYlNYY0tnRDJS?=
 =?utf-8?B?dHJXOHRlK0s1WDJxYUZNdEI5ZEQvRWtlelJ4MStZWjhqazNVbDduVi9lY0Ev?=
 =?utf-8?B?RzhmVmJkRFcvMlArNCtKaWFhNmczVmltd2crQTAxU3hBbVEyb2x3REhQUEgy?=
 =?utf-8?B?aWRtaVc2TjVuSXA0SVpyNUV2c3RhWGhQTElrZ1N5bEMrQ1pGUGZxcHlqVlFn?=
 =?utf-8?B?a2I3UFVvNk4yaE1TeFltemVLUTFZa1lhZXJ0V2V6M0lXcmpEc3QrMmVJbmk3?=
 =?utf-8?B?V2RnQXVRWnVzZW5hc3pLWmIrZHlpbHUrK00xR1VEbklFMFUvbU1GeHBiUmUy?=
 =?utf-8?B?cmtRdGd1TjhTYU9aYVA5bW83R3dIMXh0T2F1bjVBUndiRjR0MkdIWGxqUmxU?=
 =?utf-8?B?ZldUb0VDc21jaWNZRXBSN2hvVlJjaXIrZWpjREsvUkhUNEZnMWpiNDhNRDJt?=
 =?utf-8?B?TlpnWFZub3I0WEgxakZZR3dYcTVsK3RDY0grZ2RuakVoMW5GeDgrekg5TGtS?=
 =?utf-8?B?aWFTcmFvbmtHQm1TS3c0MmxGVXhwMGVwTEt3aFh1OEZ2bFQ1dGIyRnBpSjBo?=
 =?utf-8?B?WmJqa3dCL09IOExybzcxU2s5VEI4TkllZnZXMzBaNE15eThPYlJ0cGUySnRM?=
 =?utf-8?B?NDh4RUw4aXNOSXRKRkYrM2ZDZmhQTDR4RU4zekZQdzNGeTg2TDBJbjZvbHI2?=
 =?utf-8?B?ZFh6T3lJZ2dZdDJUK3hRWG53QmlWOGtIVFYxdnV0R00xUThQY1l3UCsybkJt?=
 =?utf-8?B?WHZ2Sm9sRFNlcGZ3SU9wT012TjNVM044UEdvMWtoa1hOeGdFRGxvM2F3cjlz?=
 =?utf-8?B?ZHVESHcxN1hCbFdyb09SdG9Qb0RhY2ZURGlGU0hKdHo0ZnVxTjY4L2NkeXln?=
 =?utf-8?B?czVPVVdwMktnNmZVKzVYdksySElhVGhlREFDVllyTVQ2eUNaVkpGeHhkSm41?=
 =?utf-8?B?OGgzMDJqRjJFV3hqN0NxMEl1MElkTTkreXJNWDlhNisyMTlOdTlrSzROcldn?=
 =?utf-8?B?N3hUZ3o0WW5Td2ViUEFLL3Ftd2hhY0hVeFg2RmgyRGlCM0NseWFadGlHd3gv?=
 =?utf-8?B?NmZ6TE5UYTRIVVdyZ3JZM3grVnZzTzdNZ3Bwdlh0TnFtVHJiZDJydkpkVVFQ?=
 =?utf-8?B?bGZnNitwOERLOXNJeG81cGYwMnppUzd5K3l2d3ovRjZmZzRQTkhGTnJSRG1V?=
 =?utf-8?B?cmU3OVhWNDdSVmpYQ2VHTGFQN2VKMThISWFWQ0xMWWVwTnVma09tWTdhWDdh?=
 =?utf-8?B?aHZaQmtwbmRCQTluankyNGVTNTlJRkNwRGZVWUNsLytkcmt5Rmtwd3haRm9G?=
 =?utf-8?B?Sm11TVlYeXh4SWdDelY1NUZVcitsdEMrOU84NVhObTZmOEdiYzNYSTJTQXB4?=
 =?utf-8?B?UU9SY1kvTWMxSURURVl4MlVMOHlGcXBhOVNKUXN4VnZHWEdrNy9Mc3BkLzhw?=
 =?utf-8?B?S3lFNE9hZjJrajRDSmpTenorL0FlVkxCSWpYQjNSTmFIUFQ3SW5PZFB3WkJK?=
 =?utf-8?B?bVJnS1ZFc1g5UGhVU2ZGaFBvckg3RXZmSEt4WTNvbFRkRzFDblc3eTFPZUFF?=
 =?utf-8?Q?K9f6Y1fXI01WyA/lQAcIK9aJ2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca52230-0243-401a-9a8d-08dc9f946a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 21:24:56.9077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkmaqmzEeTpsk5HRKQqQZF6WtDdrXAp1RWo61dQ06QEEr/KrrljDvcTtU8phGBtgcGU34Il1YfLFSLHHFA0wcaL+Z7iOcltmlnLFFkMeIUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7381
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmVsc29uLCBTaGFubm9u
IDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDI1LCAyMDI0
IDEwOjU4IEFNDQo+IFRvOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRl
bC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUBy
ZWRoYXQuY29tOyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IHJpY2hh
cmRjb2NocmFuQGdtYWlsLmNvbTsgS2l0c3plbCwNCj4gUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5r
aXRzemVsQGludGVsLmNvbT47IEtvbGFjaW5za2ksIEthcm9sDQo+IDxrYXJvbC5rb2xhY2luc2tp
QGludGVsLmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47IFB1Y2hhLA0KPiBI
aW1hc2VraGFyWCBSZWRkeSA8aGltYXNla2hhcngucmVkZHkucHVjaGFAaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIG5ldCAyLzRdIGljZTogRG9uJ3QgcHJvY2VzcyBleHR0cyBpZiBQ
VFAgaXMgZGlzYWJsZWQNCj4gDQo+IE9uIDYvMjUvMjAyNCAxMDowMiBBTSwgVG9ueSBOZ3V5ZW4g
d3JvdGU6DQo+ID4gRnJvbTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+
DQo+ID4NCj4gPiBUaGUgaWNlX3B0cF9leHR0c19ldmVudCgpIGZ1bmN0aW9uIGNhbiByYWNlIHdp
dGggaWNlX3B0cF9yZWxlYXNlKCkgYW5kDQo+ID4gcmVzdWx0IGluIGEgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIHdoaWNoIGxlYWRzIHRvIGEga2VybmVsIHBhbmljLg0KPiA+DQo+ID4gUGFuaWMg
b2NjdXJzIGJlY2F1c2UgdGhlIGljZV9wdHBfZXh0dHNfZXZlbnQoKSBmdW5jdGlvbiBjYWxscw0K
PiA+IHB0cF9jbG9ja19ldmVudCgpIHdpdGggYSBOVUxMIHBvaW50ZXIuIFRoZSBpY2UgZHJpdmVy
IGhhcyBhbHJlYWR5DQo+ID4gcmVsZWFzZWQgdGhlIFBUUCBjbG9jayBieSB0aGUgdGltZSB0aGUg
aW50ZXJydXB0IGZvciB0aGUgbmV4dCBleHRlcm5hbA0KPiA+IHRpbWVzdGFtcCBldmVudCBvY2N1
cnMuDQo+ID4NCj4gPiBUbyBmaXggdGhpcywgbW9kaWZ5IHRoZSBpY2VfcHRwX2V4dHRzX2V2ZW50
KCkgZnVuY3Rpb24gdG8gY2hlY2sgdGhlDQo+ID4gUFRQIHN0YXRlIGFuZCBiYWlsIGVhcmx5IGlm
IFBUUCBpcyBub3QgcmVhZHkuDQo+ID4NCj4gPiBGaXhlczogMTcyZGI1ZjkxZDVmICgiaWNlOiBh
ZGQgc3VwcG9ydCBmb3IgYXV4aWxpYXJ5IGlucHV0L291dHB1dCBwaW5zIikNCj4gPiBSZXZpZXdl
ZC1ieTogUHJ6ZW1layBLaXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEthcm9sIEtvbGFjaW5za2kgPGthcm9sLmtvbGFjaW5za2lAaW50
ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+
DQo+ID4gVGVzdGVkLWJ5OiBQdWNoYSBIaW1hc2VraGFyIFJlZGR5IDxoaW1hc2VraGFyeC5yZWRk
eS5wdWNoYUBpbnRlbC5jb20+IChBDQo+IENvbnRpbmdlbnQgd29ya2VyIGF0IEludGVsKQ0KPiA+
IFNpZ25lZC1vZmYtYnk6IFRvbnkgTmd1eWVuIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMg
fCA0ICsrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jDQo+
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYw0KPiA+IGluZGV4IGQ4
ZmY5ZjI2MDEwYy4uMDUwMGNlZDFhZGY4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3B0cC5jDQo+ID4gQEAgLTE1NTksNiArMTU1OSwxMCBAQCB2b2lkIGlj
ZV9wdHBfZXh0dHNfZXZlbnQoc3RydWN0IGljZV9wZiAqcGYpDQo+ID4gICAgICAgICAgdTggY2hh
biwgdG1yX2lkeDsNCj4gPiAgICAgICAgICB1MzIgaGksIGxvOw0KPiA+DQo+ID4gKyAgICAgICAv
KiBEb24ndCBwcm9jZXNzIHRpbWVzdGFtcCBldmVudHMgaWYgUFRQIGlzIG5vdCByZWFkeSAqLw0K
PiA+ICsgICAgICAgaWYgKHBmLT5wdHAuc3RhdGUgIT0gSUNFX1BUUF9SRUFEWSkNCj4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gDQo+IElmIHRoaXMgaXMgYSBwb3RlbnRpYWwg
cmFjZSBwcm9ibGVtLCBpcyB0aGVyZSBzb21lIHNvcnQgb2YgbG9ja2luZyB0aGF0DQo+IGFzc3Vy
ZXMgdGhpcyBzdGF5cyB0cnVlIHdoaWxlIHJ1bm5pbmcgdGhyb3VnaCB5b3VyIGZvci1sb29wIGJl
bG93IGhlcmU/DQo+IA0KPiBzbG4NCj4gDQoNClRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIGJ5IHRo
ZSBJUlEgd2hlbiBpdCBnZXRzIGFuIGV4dHRzIGV2ZW50LiBEdXJpbmcgc2h1dGRvd24sIHdlIHNl
dCB0aGUgc3RhdGUgdG8gc2F5IGl0cyBzaHV0ZG93biBhbmQgdGhlbiBjYWxsIHN5bmNocm9uaXpl
X2lycSBvbiB0aGUgbWlzY2VsbGFuZW91cyB2ZWN0b3Igd2hpY2ggd2lsbCB3YWl0IHVudGlsIHRo
ZSBtaXNjIElSUSBoYW5kbGVyIGNvbXBsZXRlcy4gRnJvbSB0aGF0IHBvaW50IHRoZSBzdGF0ZSB3
aWxsIGFsd2F5cyBiZSBub3QgcmVhZHkgYW5kIHRoZSBmdW5jdGlvbiB3aWxsIGhhdmUgY29tcGxl
dGVkIGV4ZWN1dGlvbi4NCg0KPiA+ICAgICAgICAgIHRtcl9pZHggPSBody0+ZnVuY19jYXBzLnRz
X2Z1bmNfaW5mby50bXJfaW5kZXhfb3duZWQ7DQo+ID4gICAgICAgICAgLyogRXZlbnQgdGltZSBp
cyBjYXB0dXJlZCBieSBvbmUgb2YgdGhlIHR3byBtYXRjaGVkIHJlZ2lzdGVycw0KPiA+ICAgICAg
ICAgICAqICAgICAgR0xUU1lOX0VWTlRfTDogMzIgTFNCIG9mIHNhbXBsZWQgdGltZSBldmVudA0K
PiA+IC0tDQo+ID4gMi40MS4wDQo+ID4NCj4gPg0K

