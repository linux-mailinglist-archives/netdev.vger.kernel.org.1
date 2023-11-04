Return-Path: <netdev+bounces-46009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3DF7E0D44
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 03:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C09B21214
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 02:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14A117CF;
	Sat,  4 Nov 2023 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2wOE9wS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1371FDE
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 02:13:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C1184
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699064021; x=1730600021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L8N+fE6Y398cbHtS7wJrbnPc0aYqyUKdWDkt5dJTJjE=;
  b=V2wOE9wSJ6pt3eW16eYzbrNNa17byJ6U7oGOe/SWroQkIDGM4Rw68+2m
   w21ETevFVG1IL9k3e/+/QQPmG7npulVTMkbl4OBKLAq6k/x8NlB7d7c0Z
   UV8RqulbiMFeGSVr2zNITXbFdTX+ahDQ4Si3+gL+VoXWm/Oqu2KahJlKn
   GBOIfrseiMhW9k0YDKkbDL/7VgbMLkkTfEeeGQ9kI85LmOXpGphrh6vV8
   mc4QzGibZyYtIgJJlyLNRpEx+7MxOTi3uiOI5bXGkudzqwfyNw3yvnNcd
   6aEuDmKZck0sIKtHMULZ43VKb2RQQ0sDRkJJCsQwFpWoYam2vRftDM+10
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="368388110"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="368388110"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 19:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="761794484"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="761794484"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 19:13:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 19:13:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 19:13:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 19:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7JvoCSUduhPV6ajjw9wzLUJ7HLegzfUM10VFPwU4Bi4et9Y9vNGqdlMSsVuU/BeZNG+VN7cWDzA1j27azlDaaJ7hG68yUWLT1lFeXXk8SJSBhOE/0jSA5ge1Mv2FohmKb3gLOwpg70j7rsT5z9V7qzGHjBp0SWDO8+BKZZtT3qdEEVvEypwFaaTYorp6kZHqiS13Z0ujEW15jU4We08c2U9kmM2DgXBv/zRuuaYIoDqeDm0StfcXLsG7zJAE8znpLEZGsQ8IaFWGfM52ICePMD/SO8VulDdqpka5kfx6DcmnUCJ64aP5SrVg4yf99ckELFxbxdudNCRLY8qu/X0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8N+fE6Y398cbHtS7wJrbnPc0aYqyUKdWDkt5dJTJjE=;
 b=B0wlMG0DtbYCsoOqDGLT54rTu30XXfbDf6iwXjSgAuYJSo5y3evze02SOMt7HpliIiMvvvdJvln6ROVjwwyUPJzot+W7E9g6BjuVKvTBvmcYHhjntlupZtNqdiLjdBwc+YDMsMMzgOwd+xPhGpFWvfTDEBecKDnThk1dA17EEECO4Eh1EGWLo3OcEk6jmYnFeLkE7+2PLT7XHDqUOv1a/LugDoXmuPcqPn+xtAI2YJCfJV0bQ0PRQcruzS/xDCxpLpSilibnJFDaC23bWu1y4e0nUtfmc5I8nKhj+dq+yGLRTKnjV4B2RAbCAiIg6ViDuz6BNyjKSJTAmvGoznVCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5059.namprd11.prod.outlook.com (2603:10b6:303:9a::10)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Sat, 4 Nov
 2023 02:13:38 +0000
Received: from CO1PR11MB5059.namprd11.prod.outlook.com
 ([fe80::5525:b36e:a20a:28ca]) by CO1PR11MB5059.namprd11.prod.outlook.com
 ([fe80::5525:b36e:a20a:28ca%6]) with mapi id 15.20.6954.024; Sat, 4 Nov 2023
 02:13:38 +0000
From: "Nowlin, Dan" <dan.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	Simon Horman <horms@kernel.org>, "Brelinski, Tony" <tony.brelinski@intel.com>
Subject: RE: [PATCH net-next 4/6] ice: Add support for E830 DDP package
 segment
Thread-Topic: [PATCH net-next 4/6] ice: Add support for E830 DDP package
 segment
Thread-Index: AQHaB4wfaGVwM4Lo2UWUzb7H1Tkq5LBoqVSAgAB26ACAAFYQ4A==
Date: Sat, 4 Nov 2023 02:13:37 +0000
Message-ID: <CO1PR11MB5059DAD2C742BBA1E3584BE397A4A@CO1PR11MB5059.namprd11.prod.outlook.com>
References: <20231025214157.1222758-1-jacob.e.keller@intel.com>
 <20231025214157.1222758-5-jacob.e.keller@intel.com> <ZUT50a94kk2pMGKb@boxer>
 <ee6eb20a-fd68-46dc-8985-fc0531cd2eb0@intel.com>
In-Reply-To: <ee6eb20a-fd68-46dc-8985-fc0531cd2eb0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5059:EE_|PH0PR11MB4805:EE_
x-ms-office365-filtering-correlation-id: 2d19d122-c77a-4f89-bea9-08dbdcdba822
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z1wLrYNf7mgODKg9aaHBRnQsgKrRmXQQg/qOCumO9nka91tJkDWqU9npcErMOXXsY3WgdQKyIgpNMemEsMbPiLUbkKRBCYkx+svFAZDeReYR13LkhwsM3dsxTdx0R3tEqzwMVNhHKKoLeidsIpc1DqdS5dUdF1befaFSNTbzyJ7at9liaSzEo6i5ErI6bi+HcjLx2en2f/tjXFF83+mxw+SxwYaZrOZTys+Q2dpCRCRVZIDNBmRsUAVqrj5g9r/tagzOfjYYcjBDie4wTdeYp6jqbSTvjhYh0ae1ly9IVsoq/3sQu3FbvB/EnDlSrA4HY/Hi4DBTmNnsnckMFeWW+aQxemhh2PS9RSUrVuYlhb6OnioPgmFzmmB3qiEju4ywnZIyzpFkzB6VFLqG4uVRcxlbzo374TOTC/LiDb9xa5ryPsUQJFb+yF99+SQODoYKe72oGfCbRkH1hGtLjgIyYEgGAMySpbHuj88bmGhdQTl4sBvcEPTAyJMvTkINh5hSIipTpIMacrAgEVHeeLRwJ7t6xRI0SJf2kfw5pWptReUshvewAYSWRWZNpLwLix772mBAcqoddJpSNFpM17riuW6DBcVN/myfOf4ldHZTqN9kAvnb1A/sI1tVoW38je3V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(9686003)(26005)(55016003)(38070700009)(38100700002)(86362001)(33656002)(82960400001)(122000001)(83380400001)(8676002)(71200400001)(2906002)(6506007)(53546011)(64756008)(7696005)(107886003)(4326008)(8936002)(66556008)(66476007)(52536014)(316002)(6636002)(66446008)(54906003)(110136005)(5660300002)(76116006)(478600001)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WktuUGxNWlRLbDZWY3VLM0k5bGdWeFdqc29aNm02NERJd2s3TDMxNThuT3ZR?=
 =?utf-8?B?YmZVajVUclpZU1hVcGNDUmE5RWtheXJwUndqa3JPUGxwQmlaUCtWOUNndXdt?=
 =?utf-8?B?V2hvQ2dLSHlGd0xWUnJ1SnFYRnl6Nk1Wd25pSmJEaEV5YXpKRVhHb0QxNzkz?=
 =?utf-8?B?MFhxV3pxOGwrYXRwVUpYNlhGamZoRkx0ZWpiVWZSczVFaUhXZlFWaHU0QlJD?=
 =?utf-8?B?cEJjSWxhbXl5YkZ5dTJMNWJoMjR3RnZHZkw3Y0RpaE9rUWZGcCt4aFhBMmdL?=
 =?utf-8?B?VE1PNy9lWjQxcjdpZjMyVWVkTzMvYnJLU0ljNU16SElndDVxT0E5ZlZ5Vmpk?=
 =?utf-8?B?KzN2VUpTTXBIbFFDazAwUzV1ckJaOHpUUlFIVVdONC9WNERsR1FhT2ErbmE4?=
 =?utf-8?B?L2dzYWF5MS8xNHEvb2FXYXdaYVR1K1pVOVdPUmZHck9rUTZ6VWtYZjExQW5W?=
 =?utf-8?B?YjBOaG52SDNQY003Z3E3MU1HbVFoNEZwZ2pLVTdESU9UOFhDVm44di9UbjN3?=
 =?utf-8?B?QkxsdCtweThRMm43R1F6bGZWL0pPRnlISzRaaFVOQTFvTWtPNWVjNHRXOURB?=
 =?utf-8?B?clFNL0ErcThTRUVCQjhlMGQ3UlRaeURzN2FpWU15WTI4clYraEpPejZrRlBG?=
 =?utf-8?B?L29WV2pheXR0MjVzNVBYUTJjWlJvUlNONDBDcWJnWEFjRk5SWkVTUmlNVGFp?=
 =?utf-8?B?MzZJVFI0Z0lQSmE5aDdrM3JYTklSM2NjNElMTXFRSytnTHFKTU41a1RnSTNG?=
 =?utf-8?B?dC9RN1lTNkJvcnV5S01ISHc0cVVKZWVhdEVFOG1SSS9STDRKMXZ0NndTdkRC?=
 =?utf-8?B?bDNkRzRnWE9aMDArb1B2VWtMR0VVVEJiQWxKUDVsNUl3QWlvVTVVL0owU2lZ?=
 =?utf-8?B?dVdVNkJhcWZXd0p6K1ZmMnQxbitpMlRzN3JvaE4xUnZFNDZLWmZOZHNEZTdp?=
 =?utf-8?B?cHRXd0tIcFkvQk1veHBiVlg1V09kUXNlQkh4YzU1eHlEajJUUURYUmtPRG1k?=
 =?utf-8?B?ZlBJNWd4aE13RnRjNDI2aDhOcVd2cEVSTE9ZUDhTTmxHcVZ6N2FYS0s5aHJy?=
 =?utf-8?B?QUJRemRyYzNJSG5FY3VhUHJlWWFVK1BVdmM0QVNKOWZOTnRFRk9RSHRNd1NZ?=
 =?utf-8?B?OW9XL0hDMkxGaEdUZVV2QzYrTE42TTAxcHhpOWFhUDVCOThmKzdkQUZSL0E0?=
 =?utf-8?B?MlIvNVZXdkxyRVRHTHk0RzZEOFkvNnlpUUE1MWFjeDZiV1VLODZhQ2R4ZDZz?=
 =?utf-8?B?ZjlnUk9wOGR0TVdiSnpSbG53MWFVeW1vem16a0hrZXE5cGZ1b2l3aFVqUjl0?=
 =?utf-8?B?MzlMWktmeEFNNm93TTNRQ1I3QjYyVWc5ejYzWUk4TnlOUkEwL28ycnlrMDl3?=
 =?utf-8?B?V2hNNmJRSEMxRm9MWjVHaXY5T0RuM28rbzJMRktEZEYvd3B0dmlDWFhnUTZE?=
 =?utf-8?B?QWdPRnVkTUk2alVuTW1XV0JQQ0o4V296K3dZa0ZvMzFJQW5seGJYS1JJNlBl?=
 =?utf-8?B?NWhEbjUva28zNWV4QkVnc3VKNHpvUDZJM0dyLy9sUE9QcVhTQXVIMkhnV0Rv?=
 =?utf-8?B?THNBNDhaUWxWVngzZkk4aE8wZU04V1I5aDd3VHYzWnhBMlIwdm53L2E1a3V2?=
 =?utf-8?B?MDcySkZiWkFRVDlGZmFQRnE1QzBqRDladXZ4ajRORHF4dUNnY1U2WFQxa3Fm?=
 =?utf-8?B?eGtlQXV2Qlpta1k1T3ZXeGM2L0U4dEtNcjc4bC93aWZqY2N3eUxRbXdSalN0?=
 =?utf-8?B?MXl3OWhJcHZybUpsUTU0M3h6UDh3bllhK1lia0Nxb0ExeVgvZnB3ZmZuaDFk?=
 =?utf-8?B?WGtRdngySUJzajhzYzlTVmhvK2YzMjFsVmZ1aDNlcVRFME5YbXdZamF3N29U?=
 =?utf-8?B?NVpCY3R0dVYvSExWUGRpSzRqNTkrVERwamNoczBRdG5KRlMvbk04SCtKb2RV?=
 =?utf-8?B?UDNwZWRHZjQrMmNGblowZVhsRXppRE10WnM0U2RBVy9oVkxCemFVZ1owN3V0?=
 =?utf-8?B?Rndaa3lTY2I5M25IRjlLWjMybDdSamZHR1VyOVFzOTNsZWRqdlNNcGxOTFI0?=
 =?utf-8?B?cVNHQTRob0J1bWJGTGo4M0dHaHp5a1BwU0FPeEpWNGI1a3ZYTGc5R05iQmkv?=
 =?utf-8?Q?BTpWSN76ta1bdzRHio0bcsNvY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d19d122-c77a-4f89-bea9-08dbdcdba822
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2023 02:13:37.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIG4UKoVorW5hIwgsyovGnVBibRq31c3zwIyPLzeJca2OVlOhpx6jBjMUqRjGoGTO4ZGvfv2hE+wUXKHHJbKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com

PiBPbiAxMS8zLzIwMjMgNjo0NiBBTSwgTWFjaWVqIEZpamFsa293c2tpIHdyb3RlOg0KPj4gT24g
V2VkLCBPY3QgMjUsIDIwMjMgYXQgMDI6NDE6NTVQTSAtMDcwMCwgSmFjb2IgS2VsbGVyIHdyb3Rl
Og0KPj4+IEZyb206IERhbiBOb3dsaW4gPGRhbi5ub3dsaW5AaW50ZWwuY29tPg0KPj4+DQo+Pj4g
QWRkIHN1cHBvcnQgZm9yIEU4MzAgRERQIHBhY2thZ2Ugc2VnbWVudC4gRm9yIHRoZSBFODMwIHBh
Y2thZ2UsIA0KPj4+IHNpZ25hdHVyZSBidWZmZXJzIHdpbGwgbm90IGJlIGluY2x1ZGVkIGlubGlu
ZSBpbiB0aGUgY29uZmlndXJhdGlvbiANCj4+PiBidWZmZXJzLiBJbnN0ZWFkLCB0aGUgc2lnbmF0
dXJlIGJ1ZmZlcnMgd2lsbCBiZSBsb2NhdGVkIGluIGEgDQo+Pj4gc2lnbmF0dXJlIHNlZ21lbnQu
DQo+PiANCj4+IFRoaXMgYnJlYWtzIEU4MTAgdXNhZ2UsIHRoZXkgZ28gaW50byBzYWZlIG1vZGUu
IEknbGwgYmUgc2VuZGluZyBhIA0KPj4gcmV2ZXJ0IHRvIHRoaXMgY29tbWl0IG9yIGlmIHlvdSBo
YXZlIGFueSBvdGhlciBpZGVhIGhvdyB0byBhZGRyZXNzIA0KPj4gdGhhdCBJJ20gYWxsIGVhcnMu
DQo+PiANCj4NCj4gRG8gd2UgaGF2ZSBhbnkgaWRlYSB3aHkgaXQgYnJlYWtzPyBBIGZpeCBtaWdo
dCBiZSBwcmVmZXJhYmxlIHRvIGEgZnVsbCByZXZlcnQgaWYgaXRzIHNpbXBsZS4NCj4NCj4gVGhh
bmtzLA0KPiBKYWtlDQoNClBhdWwgYW5kIEkgZGVidWdnZWQgdGhpcyBhbmQgZm91bmQgd2hhdCBp
cyBoYXBwZW5pbmc6DQoNCiogUGFja2FnZXMgdGhhdCBkbyBOT1QgaGF2ZSBhIHNpZ25pbmcgc2Vn
bWVudCBhcmUgbm90IGJlaW5nIGRvd25sb2FkZWQuDQoJLSBBbnkgcGFja2FnZSBiZWZvcmUgb3Ig
ZXF1YWwgdG8gMS4zLjI1LjAgZG9lcyBub3QgaGF2ZSBhIHNpZ25pbmcgc2VnbWVudCwgYW5kIHRo
dXMgd2lsbCBub3QgYmUgZG93bmxvYWRlZC4NCg0KUGF1bCBhbmQgSSBoYXZlIGEgcGF0Y2ggdGhh
dCBmaXhlcyB0aGlzIHByb2JsZW0uDQoNCkNhbiB3ZSBnZXQgdGhlIHZlcnNpb24gb2YgdGhlIHBh
Y2thZ2UgdGhhdCBpcyBmYWlsaW5nIHRvIGRvd25sb2FkPw0KDQpSZWdhcmRzLA0KRGFuDQoNCg==

