Return-Path: <netdev+bounces-278424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNDaN4sp3mmSoQkAu9opvQ
	(envelope-from <netdev+bounces-278424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:48:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8A3F9977
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E357305E8E5
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424F3E1230;
	Tue, 14 Apr 2026 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTRt92/B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413434A788
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167142; cv=fail; b=azVW/eMWJuQH5jvyFj+P1WhPAtngenYuB4wJmbFDcfhAfGlPz4oYV9Z1f6K8LijhDFzEo4SALE0nF/FaaFhrl0Tr3n4GkHS5yNLz8nEi/VpOcSC9T9MuQUgAmfkRGrTJnavr1TPSCPMW+oO246qTM84dNU0b/riu64+PuCvuB8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167142; c=relaxed/simple;
	bh=zP1LWKe1lxcfBXtVsCISJRPsMgqkrgKvgZUqUk98kkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P1v5B/7IG47qOXC47PH7zoI4PROKaqm1n24jhbIGHN9DNpwmabxhfSzZQ200dgwj70/sbLjDKiySRUN1ASFIHBam3OoK2dSiR9a9TrBPN3WTpWl8CW0xkeDij79gq4wAQOwA0qrBmrhzyPmSSolTXFgoqnfedr6Gq4fZWgae9II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTRt92/B; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776167141; x=1807703141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zP1LWKe1lxcfBXtVsCISJRPsMgqkrgKvgZUqUk98kkY=;
  b=VTRt92/B2aSb/JwJA73gi2pStagZPLJwW2VTa5b/5v8/GnKn9mM6KL7R
   UurwYCDA4qHZEy62kcAhBZOz9dXCZ3/+931UVKiDNXagKNakv94VqQhD0
   RTzd3iyRkUIhu0YMBHbGlexRDkLImhz5louPUxV05lE+ot6r/nngVS2GS
   /cwiJu0WS2ik77GAzxjuNldfQFCbS1Q8PtUkCGRA7qx0U/yJk8Q0QAPkR
   dynO+a+wmCwO6JI6XiF37EdDaHdp6gPXIQYp7dqdHAQhyThLNat19lN2a
   wzKUy+FEMjRzZkVSY8FOx0+r8iuxNu65/4IslE/gqUHegsDQzQr3pnR0M
   Q==;
X-CSE-ConnectionGUID: U4g4UL58TTm/1al0onHecA==
X-CSE-MsgGUID: AMV2Be+TTh2vFcFR1+hUEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77001975"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77001975"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:45:40 -0700
X-CSE-ConnectionGUID: /0gz2fVPSH6uam7rjQSGkw==
X-CSE-MsgGUID: tAdvroJGTd64II4Bn7xBcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235007407"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:45:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:45:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 04:45:40 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:45:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDiDdxFdm+RiZ+k8sV2X8DceJihc5xl4U3cumENhHyBbV66eHfToXyf09CbFR6UA0bEKNl17oJTMqUuhQwKYI6njL3t32Ck4DDcA7RB0at1W6oE+A8vyNAqDgtGeIU27rvIoLPyNNFzb9/1ZmxUIW5LdjRJVwFJUod0msOrfQcFcosxtMCPCbha1XnHK3jOIY2F1Q5+b7R5QisdtwejOemkr3g5y/X9DK8HMUuhEPklrxySnUnDE5ZfVoAmdQ4KCDAYC8SPlAC2PtBzCxn3Q00M9aiK1/EchqLI5Dn0azk/oKqoqlF5pK2+6WQ/6MLiEpDVUzLFdoHjhTIYMCI02GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhH1nBoj919tKhNgi8JnWXAiOMZRCxMxpfEWf2uJJTk=;
 b=Akb401rqVEIYxvRbWZkhAMZE46qmN2GxufzqpFHzK9vOr40rh2mqwVB+dbv+Ya7iya9zcDUwwAfTP7mlRvalTRoPSuBdSLuYLdNDh2IVZ3YwOvPIhLDIByj4L70kSSW+Kgqsb0Wfe5N1C+PCEL3TvAux1sg9e9yPhCX+OwLlKjHQV3u5VeLQ+FUyPTeFx5nf4AUwrz+HtjBaP2qusXkGkgUymKHDuA62bovm2vZ2M3kovOngzE3zuo2BTDeydUCd3JqrGyY8pf2WinHAg+2PgdhzOZzxKdg5NUo2iqmlzBtwZPlRBt+U5ldH//IXmIBo+43bYuJh+NeZ6slax+mTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by DS7PR11MB7929.namprd11.prod.outlook.com (2603:10b6:8:e5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Tue, 14 Apr 2026 11:45:31 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.20.9745.019; Tue, 14 Apr 2026
 11:45:31 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Kohei Enju
	<kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 2/3] i40e: add support for
 bpf_xdp_metadata_rx_hash()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 2/3] i40e: add support for
 bpf_xdp_metadata_rx_hash()
Thread-Index: AQHct8RNicFmVNmfNUG+tqJLYo0fo7W2/fiAgCea0FA=
Date: Tue, 14 Apr 2026 11:45:31 +0000
Message-ID: <IA3PR11MB930138CA5C21E57FABF5D4CB8A252@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260319171650.5815-1-kohei@enjuk.jp>
 <20260319171650.5815-3-kohei@enjuk.jp>
 <IA3PR11MB8986D3E4DF65EC87E23A6C1BE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986D3E4DF65EC87E23A6C1BE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|DS7PR11MB7929:EE_
x-ms-office365-filtering-correlation-id: 2e731702-780c-41a3-3aa7-08de9a1b550d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: cd8BV/SR2BXTxZv7kFcgAFOuUR/6vtiwxCKfMw8kHc9MQ786ykgpmyShtNpS2zisGQsRr6URMD2q9frHHQijgCYYTwVdTi5qDegDGg1TFiMq3kNtJ19O1w8yESEOwlFgXax98cpnjFq8w2s6ya2CDabgG662mRYsy5/d5G7rsJgJPdsNLsfb2DoAWF1Bik2cJm1T4uDva+KY5phKyjl3kZZ7FSVRk8zUuz6EoXRM/v5ta39Tmd2OHbbucYbUN0ZJOYYmgNO+muiy3/1i0GL1PxYTAxEZcWK8mraiNZuF82oLB6T2hwlyg5ZMFmq4oEYP/2fEcdFtupIEnP+CYUiBzMI05qt/pUv8CzDoQyPnTvcx78j11zQN5v+baGtrGV4OSiuIhJQsmVwQaM8XQ/Tuu9TEh0Ms2p0p+csHg7ay9WzjyNIBJ1tLF9ZDwUHD2BUtwTh3o/K3TSos0mmOQy0Yot4diCiUlaEuMMNy+4J7mLJvz7+EZAAa4WiN/q3QtT2px6l9cmZWDj/zrRsFTuZ11rnGo843bvAcFFUwh6UK8GJfyq3N84lSHkaWXEI8YDLSlY+7ijEInFfrgVOmxgC6/OkNHJDdXCdSclhoJr6kLofwNfwHThpKQ7Xy0PNF35+CX5prtxC+35T9AkWm+LZBp7TzJ05Axdm4BTkmL76hd/lar3vO+udqObTpNzVqZpVpOqrxuHRvdq3Y/uTWsjme7liENmnxXctepGjYfNBKP9H6AKkQcqM7SreWxloH2aQVlYnzlnB4W3D1lSQd1V8ZKAAzaAdD+INaLdEEFK+kx9I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tM479CloF/MTxDA8CBHFNBH5bSEwgN2QNnQ177xwfiMuZ+rshMxXWq6ScB?=
 =?iso-8859-1?Q?vfgN9me4tU71Gr7q0ApyYT8dLjYIU7Bz2ifStl4G6MLUuGJhXXqDXRp09/?=
 =?iso-8859-1?Q?fCLL3zxtq7lnVPDb+g0SXFs4IgCmsAOiOX1nG0/Wj9Shqu05Q7oEDjWucw?=
 =?iso-8859-1?Q?tU/bG/Udghb+q9XJ0QMGsWgg03nzX8HI1ZEbehXtME6oVaFYKE7oa2p88A?=
 =?iso-8859-1?Q?YYoFEXuzCNmIunh+Jp5wdJjtPvdelp/GOmdvsMAEawYkR4gcnzLxASAPXS?=
 =?iso-8859-1?Q?+S2/w6CGOv3kUfku4WztvSaA4X0iNkaaE5CYDLBEi9YiRKhWLnxSVt9DLe?=
 =?iso-8859-1?Q?GLkxrpKFF3ZGrdIQ04RmLSfGOp1H2yLZ22vaukgMzi/8jMkTMa/NyeB5dL?=
 =?iso-8859-1?Q?djDGklhwbzXcn0AiiI+IJ+qezmBt7C5FtWkMZ5rXep503i1FpkvJX+yhs/?=
 =?iso-8859-1?Q?/CN4FLvAmVivFy6kEacpgVR5DPZiAJdT9+M4cpOP/kzyIy766n3yWxDaUa?=
 =?iso-8859-1?Q?pzHiE90iB90WZj8qYAL+TgZ5F7U0P1KfH0OBrCil/gQdh5aKRUsCKjzJAb?=
 =?iso-8859-1?Q?8fxF3PSwr911gKkk11YL5+9BujzhONnKOnsHS3+RVBsti3sLHT7sOnrI4A?=
 =?iso-8859-1?Q?BAnvxjhv0WWv8P9qQtqW8IxDD+iPB+gNo4B8Kvcs5foEhhV5sGo2nTb1Qg?=
 =?iso-8859-1?Q?ejLfSJiXS0rJohO7c5FfqBEEC9ffTIXfof3j2yPX4XhEmCiD+jYZ3tTmBQ?=
 =?iso-8859-1?Q?5bnG1p+ahR4vS/CdSB7WCYeQqXIneaaVRcLfl0ff8Jf2KYhydyevKcYhFq?=
 =?iso-8859-1?Q?E6Qt19sK/4bwkMnIQRfqPLBe9y5bFe2ciDDsa/fE2dJKUEEZ4bU4aqsImt?=
 =?iso-8859-1?Q?+fCQ5j1r7/dTR7Hz3ekT4G7ohxQLhYQtvo12zEAFIi151qaa3lajLxV1L+?=
 =?iso-8859-1?Q?aWlPL+Ja7jsy3bfj+jmsuy/KBeA4lXx20gwnRqMcWDJp2DRWYYxfqEK+aN?=
 =?iso-8859-1?Q?y1JsZKXxzuF3NpZRfeyZvLZ55FJs0/38kDSU4O4vASj2m0XfhmRJ5FGSGU?=
 =?iso-8859-1?Q?etpEALESwjGwxJGfY0p7aTq4f+DSsrzA5FrBTkfYXIAa42tapl3+ybGWnP?=
 =?iso-8859-1?Q?o8YdibqaR4VfhnRnT8LlzlnSsYhtkW+NaWRa+MSfyetFJ03Y59IWSTWhXk?=
 =?iso-8859-1?Q?I1jDE4aYMywr1EDbITvZ2qo0gONxvogypHyei+HQFmyxTXW9n6WST+Cc/U?=
 =?iso-8859-1?Q?Pvu5Cz1360WpKI+lyf18bfedUWaOLos9WE85D2aWg8tl85Bt9bR7KAsZNW?=
 =?iso-8859-1?Q?o/K3R5A+XyNPMoVtuJ60i7qJ5nJPX1bcBiJJyJue0ScDTKpb6Cs8lDroA4?=
 =?iso-8859-1?Q?lf+JGctdkksAXXajSE20LC074PKLqEnHswx1chu6JdqBPENczHL32oTpAp?=
 =?iso-8859-1?Q?lnwzfpRGJtUBViI2ANfjCcF83dD8kLCtdIsJ6LMJWSmk0O2/Z/Zeoj8MmV?=
 =?iso-8859-1?Q?iaHKhVmnHDk5lC8zUFBBbDuw9XvggVxe/c23pP/hdhv8aKCgEVpQClc5jJ?=
 =?iso-8859-1?Q?JjItIR6wD1d7AcEIQwkJMU43k7GuV0Ih2T0hf1o/tf5p8py7B7rB6bjGYQ?=
 =?iso-8859-1?Q?BbrLRxm5nAFYeREpSZRnxLOs0aWe23BZDxNFeWNfNlhOFPdkJvckQgtpLo?=
 =?iso-8859-1?Q?4NcoTJVO/8kPxGkQD1JyLd3006O5vmD2L9vnuALxTzN3iS2hCfVWNyq1jb?=
 =?iso-8859-1?Q?CuXsGnnqeB+vo+blBkp2R5KEakTjbdOxHU5BwEyGQlG/QemSXZ/5qxVl76?=
 =?iso-8859-1?Q?xjJZyjkgHA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bL2pxmKN0Jc3LeqIf0oS9QWy+6kKik45RBG13b8v+1fR6A1NqqDfLxLVoWBKk+0tAUxzgJVmwPw9o6ICoe9xRPogtnAfQ96j/wBX+mxRSWClV99tRA4wrz+hdAUEQ0StyFhdQGnrKQApcjx1kfkGfR4m6OtCyVHJQSzNtvfHjvISDaef42G2BhcYTNG23IrkmegKt9T+HdbjD5KtLk1bJdj9xWer8eolNjRg7O/3V6Wu4qJcJJ3PhA8crwn07kcTcVM79XBNNX/JWSy8MKMrgcDLVfh8dffewF/F3vNluTYz9dKOunmEare/Fvbhcr2/l2yQyPWcjKpIrYpzs08U7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e731702-780c-41a3-3aa7-08de9a1b550d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:45:31.4881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxslDXQYPyO7VW9cEXzgSdcMs0cggnPpcO5mcFgRhuB/ugiMwfg7rNfOad+nPDtdkzmA0KSH8o/CYL0YG7+MHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7929
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278424-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB9301.namprd11.prod.outlook.com:mid,davemloft.net:email,intel.com:dkim,intel.com:email,enjuk.jp:email,lunn.ch:email,osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patryk.holda@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 33D8A3F9977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Friday, March 20, 2026 7:57 AM
> To: Kohei Enju <kohei@enjuk.jp>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; kohei.enju@gmail.com
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 2/3] i40e: add support =
for
> bpf_xdp_metadata_rx_hash()
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Kohei Enju
> > Sent: Thursday, March 19, 2026 6:17 PM
> > To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo
> > Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Kohei Enju
> > <kohei@enjuk.jp>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v1 2/3] i40e: add support
> > for bpf_xdp_metadata_rx_hash()
> >
> > Introduce i40e_xdp_rx_hash() which takes the same approach as
> > i40e_rx_hash() to extract the hash from RX descriptors.
> >
> > Tested with X710 adapter using xdp_hw_metadata, and verified hash
> > consistency between bpf_xdp_metadata_rx_hash() and skb->hash.
> >
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_main.c | 30
> > +++++++++++++++++++++  drivers/net/ethernet/intel/i40e/i40e_type.h |
> > 5 ++++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 7966d9cb8009..6b7e34b16a8d 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -4,6 +4,7 @@
> >  #include <generated/utsrelease.h>
> >  #include <linux/crash_dump.h>
> >  #include <linux/intel/libie/pctype.h>
> > +#include <linux/intel/libie/rx.h>
> >  #include <linux/if_bridge.h>
> >  #include <linux/if_macvlan.h>
> >  #include <linux/module.h>
> > @@ -13585,6 +13586,34 @@ static int i40e_xdp(struct net_device *dev,
> >  	}
> >  }
> >
> > +static int i40e_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +			    enum xdp_rss_hash_type *rss_type) {
> > +	const struct i40e_xdp_buff *ctx =3D (const void *)_ctx;
> > +	const union i40e_rx_desc *desc =3D ctx->desc;
> > +	struct libeth_rx_pt rx_ptype;
> > +	u8 raw_rx_ptype;
> > +	u64 status;
> > +
> > +	status =3D le64_to_cpu(desc->wb.qword1.status_error_len);
> > +	raw_rx_ptype =3D FIELD_GET(I40E_RXD_QW1_PTYPE_MASK, status);
> > +	rx_ptype =3D libie_rx_pt_parse(raw_rx_ptype);
> > +
> > +	if (!libeth_rx_pt_has_hash(ctx->xdp.rxq->dev, rx_ptype) ||
> > +	    FIELD_GET(I40E_RX_DESC_STATUS_FLTSTAT_MASK, status) !=3D
> > +		    I40E_RX_DESC_FLTSTAT_RSS_HASH)
> > +		return -ENODATA;
> > +
> > +	*hash =3D le32_to_cpu(desc->wb.qword0.hi_dword.rss);
> > +	*rss_type =3D rx_ptype.hash_type;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops i40e_xdp_metadata_ops =3D {
> > +	.xmo_rx_hash		=3D i40e_xdp_rx_hash,
> > +};
> > +
> >  static const struct net_device_ops i40e_netdev_ops =3D {
> >  	.ndo_open		=3D i40e_open,
> >  	.ndo_stop		=3D i40e_close,
> > @@ -13788,6 +13817,7 @@ static int i40e_config_netdev(struct i40e_vsi
> > *vsi)
> >  	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
> >
> >  	netdev->netdev_ops =3D &i40e_netdev_ops;
> > +	netdev->xdp_metadata_ops =3D &i40e_xdp_metadata_ops;
> >  	netdev->watchdog_timeo =3D 5 * HZ;
> >  	i40e_set_ethtool_ops(netdev);
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h
> > b/drivers/net/ethernet/intel/i40e/i40e_type.h
> > index ed8bbdb586da..16a65c6e5153 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> > @@ -4,6 +4,7 @@
> >  #ifndef _I40E_TYPE_H_
> >  #define _I40E_TYPE_H_
> >
> > +#include <linux/bits.h>
> >  #include <uapi/linux/if_ether.h>
> >  #include "i40e_adminq.h"
> >  #include "i40e_hmc.h"
> > @@ -699,6 +700,10 @@ enum i40e_rx_desc_status_bits {
> >  	I40E_RX_DESC_STATUS_LAST /* this entry must be last!!! */  };
> >
> > +#define I40E_RX_DESC_STATUS_FLTSTAT_MASK                   \
> > +	GENMASK_ULL(I40E_RX_DESC_STATUS_FLTSTAT_SHIFT + 1, \
> > +		    I40E_RX_DESC_STATUS_FLTSTAT_SHIFT)
> > +
> >  #define I40E_RXD_QW1_STATUS_SHIFT	0
> >  #define I40E_RXD_QW1_STATUS_MASK
> 	((BIT(I40E_RX_DESC_STATUS_LAST) - 1)
> > \
> >  					 << I40E_RXD_QW1_STATUS_SHIFT)
> > --
> > 2.51.0
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0



