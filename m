Return-Path: <netdev+bounces-98426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5353A8D161A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B5F1F24EA1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE446F079;
	Tue, 28 May 2024 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0B6lyiP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAF73468
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884317; cv=fail; b=cjHerEVVuprDEZ8iIP9xsORSQKZXvR7vmqzBN2ynKELTiM9AL9pzeoaeacYFR8rXJ/zqV50ZMTnlc6/6m+WPXLtjNUMXeTI4trZLdmT5H4erPN24oSsZzrWKR0kLt7dYbDvwnem6NB5QnmgeDdF4jtB82qTQ5apKpygcyEYlCcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884317; c=relaxed/simple;
	bh=OpUkV9834DEgexXge1B3XM5o6ZO2trvmgonfmCAH7RU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IKnL13SylnyvMV4crI3F6Ein4A506FB4rQgJ0DHhJrepFJmskLA11KTXY/YszqNA+q55dGBcF+fBxJqs1XJbMAllbU9Hx1mqmzCiyZiHvqhHO1hlG0C6Rk+qHBvsmgxv1zRHTj6eGWfBhvmePwQfhumbsg0KrwKip9FmZan5v7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0B6lyiP; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716884316; x=1748420316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OpUkV9834DEgexXge1B3XM5o6ZO2trvmgonfmCAH7RU=;
  b=C0B6lyiPqpxm92jhX3Gikx37ScTkBvkkIlzgRtKzJeglJcf/O5PO3MNI
   vj4eimWYteiXi8BPoct2vjaCym9C3lU2a4/oZ9Gl1RxJq0pqsXmfeCNix
   xFFYl3P6FiFi3jNKHLfn3sX230OLgWCblobuAmL/TnQLTw4TRv6rb/0mM
   V0KsPMlHxXy29z/8FuEN2lW4F2+KeLd+lUB4unXght7v79QuuN/Jwvbo6
   FM0i+JhwDHMAK/OaJuGMaVakNMF+IFzmTODHpU2Xbs9BIKq9svPSmti8a
   YNII1yeX/1meO1lC3PSp8+7gdrahy7N3cOTvZFOaDpJHK6Pe+N53ndZkm
   Q==;
X-CSE-ConnectionGUID: DJ+pQ8/ERXSOHzp3nQq0vA==
X-CSE-MsgGUID: gjFN8n8cQgO0Ciurz3SSkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30719935"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="30719935"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 01:18:32 -0700
X-CSE-ConnectionGUID: rYbO0WdRRym8F42XY1IPzg==
X-CSE-MsgGUID: I+LWZmJbSt+LhDvg7qAzjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39819461"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 01:18:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 01:18:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 01:18:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 01:18:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNjE0gtYNmxmGLyw2jQWjv9DaInQ56uaZfT+lvcyiaGc0FoJQz90llc8Yrh980qmQHSFqjH37Rfmnn/dseav7e8U6Ko/C6wYEi/kQ5qgQ0jTxHLov6vDTLVUeEkqkVegxejp+mtdckzypaOCoob6PtZipcz5SkSyfPnHLE80CuscLxNwZdZx4u/Cps3J2OX8go3x1CvIbM497DvVQFbTpD4ga06tso/tYxXQWwX5/Yvv6bFSToI41FWSfgExzZoBNaZJIz/4n/6azKRE2YyUHlau6wKMok/Rn+BTcRU7FkBWDtu4xlNFl6OIc0ykd4JfTYylaC4CbBnfjFeXu1owKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ8oHVmeaKkvWkTpNKAIFTaE9fNyMzObccrJbk4nSSE=;
 b=cibAyzaDpWHIchOd7QZybdXU1A7JVVP4ZfEOq90cKtwoMiZ++Xib96on+4CrmcirWWVBYOqXtR5rg/5Y7PJLbsLZtgu494jncGquuoOXbAbVe0XfUTVYU9EBkaJk0QN2YkwT/HttvKo5Z7Kk4hizBPnDoPayA6iPwKxjITfBRSY8qpK4MPOg7HW9P8COi9e5uwGH3r26yc0Zs6eIl88SG2ZDmywXcAgZSfuSOdKCG3sSqJNJKnk7OqrCuZbw6KOcx0RECNOF9WxPIcV/aNWfUFXtZKi5IxJYOkbisVIxUb+7D5yGKATLN+1bIcMZCwM3RWXoCF0wPn2t9k/fZcqQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20)
 by DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 08:18:24 +0000
Received: from PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf]) by PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 08:18:24 +0000
From: "Kuruvinakunnel, George" <george.kuruvinakunnel@intel.com>
To: "Kubiak, Michal" <michal.kubiak@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kubiak, Michal" <michal.kubiak@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Rout, ChandanX"
	<chandanx.rout@intel.com>, "Sanigani, SarithaX" <sarithax.sanigani@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix XDP program unloading
 while removing the driver
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix XDP program
 unloading while removing the driver
Thread-Index: AQHap7ACqG40lTnvj0Cc2RFCnuTUBrGsX44A
Date: Tue, 28 May 2024 08:18:24 +0000
Message-ID: <PH0PR11MB5144F5F3C881AEC517DD94BFE2F12@PH0PR11MB5144.namprd11.prod.outlook.com>
References: <20240516164108.1482192-1-michal.kubiak@intel.com>
In-Reply-To: <20240516164108.1482192-1-michal.kubiak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5144:EE_|DS0PR11MB8205:EE_
x-ms-office365-filtering-correlation-id: c373689a-20ed-4cd4-7c04-08dc7eeebe72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Kjh7yjX/Jphkb4gVl5Xh1WTKAZI2KQyKbdcr/KZP7rHqBl3XIpOyND/rNRdq?=
 =?us-ascii?Q?Y69JpwI7NPKBWhdWW8A929D6XJVu7plxS4bhwXkmIU215AhCdD3xCTS+xqe5?=
 =?us-ascii?Q?vEPVxGra+ejO3+uZwO1u8JDOHBF6ktgjf0Xl7/1yVbN4KGM8WAcpGe+wa/XK?=
 =?us-ascii?Q?sUjdFXKpX4ArB6ZYySITmPFNEVnLQawQUzvaF/i86l33pErIGuJHHX/KeO55?=
 =?us-ascii?Q?cyg5kD/jUQylxhnPzpJ7UouYfW2CLO5nlQZ9OlVt5w2+RC+fAVirE9DiTMeQ?=
 =?us-ascii?Q?U2TQB2QMp1KQH5os5MnFh3pIBij3ViWebkiLg+d9qRY+mO97l5VrT/D8CsvP?=
 =?us-ascii?Q?/HQDVhFKVbc+hIuy/NL9UECzEg1kVoGICAposL6Wh3wGU/8MMxO1QHDKGxfW?=
 =?us-ascii?Q?CS84OWnL/WLyu+jNPv/pmjIsrP3VaCP9DRPKQEaoLJfAJNSq4YPkRPC5s5FH?=
 =?us-ascii?Q?yoHvN70rKQ47+Lz94zycXQNfdfn2lAM53VkCvswHWZ4cWIX/XbKwPPeLZ4ca?=
 =?us-ascii?Q?e46AlgxlS+RcUVaMCxFCcYH4zRO+XyudWO+sd2SPK+3xfDJ4C6sDbuPyUC+Y?=
 =?us-ascii?Q?n2+Rc3RtQyfvzHQT7yjOlfpa5AlewTWeFSr3SWOmedOiKTPVeegL8Gg0quuE?=
 =?us-ascii?Q?gDscXEzKu3vbl020fYfFUXUG1QCplYGW+ewOFSfVuR0L19WyYaXbI1IhipVl?=
 =?us-ascii?Q?jhHStLL2fXo0UnVU3vRw9BKEuOPKC72Iu4suQi3TaKfHmhVWQxTpmTFGoXLl?=
 =?us-ascii?Q?OoB+2380YCa1/YGFNGQ0LL2a3Mvm8wHh5APq9trBm8YLjdfGp3zt2JmMTT63?=
 =?us-ascii?Q?D3bejscoNyxP9z2RxWXRz9k6d94LP6MNXyzEq2u0OKUERb85vNDiJMXxRmQF?=
 =?us-ascii?Q?GkxhbsSPI2RjXG8ZknX8b99F8gaA43zLvrPw0qtLTY0W8XQuo1i1P0dMYEc7?=
 =?us-ascii?Q?JezK70+3kC9HRvmqppNAx/YV5LfKIli/1ldDHTcq+2wAJEKa2Huw5fKcdX0K?=
 =?us-ascii?Q?ucpqeO1pCcJdywzmQ1rFjQHlX70WM+FRA1MiLDrti4uSl1oKnGzqR30Sk76H?=
 =?us-ascii?Q?fB7KxDBeUjzt1Dk8UZsvvwU+oD02bkcNcCmfN4fd4Xk4SpUOCku21fJ/SnUk?=
 =?us-ascii?Q?a/hqfc3c5QQ5wxMD9KN7am5MA0skanDAFKDP4aMfKiBC/Uy9D2FJTcn8y/Bk?=
 =?us-ascii?Q?q7pR8zyF6qGRVGYi4pOtm1kobp7RK6IOKo4wbjZwJoTBHYcMvUXrM09B1Nj7?=
 =?us-ascii?Q?HUlvs12Jp7tZ2qvAZ/K35CJ6mv4VMkhr5Yce+LS0Chb0XmdzT8mPSlK640Vt?=
 =?us-ascii?Q?GmY5W+u6Emyn/1y7afvNkwHwaxxsYfzWa0KctsUQLnAmTQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5144.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vh2fKlEXXilDUuOfjMNGhLdW+i3DTztUOOuaDX3mdV1sewmNPmJ2/SLNMo79?=
 =?us-ascii?Q?rgcU1pOZdCNEy5X4V84n8tJKG0r3u7zkNqTHky8hcroJqn7wv4b3/co4COfq?=
 =?us-ascii?Q?EenZShgxPbUJnQBpA+ykzl/r59rPPc90yhuW4eQRU+c5IZbxFvB4Nt/dIkBz?=
 =?us-ascii?Q?7kSLLLmSROQEQCApKGO7yQTE6XUw+hpUynq3fbmFXCmsVKHEiXhVLLCWmEwb?=
 =?us-ascii?Q?6+AsSXvL9cifm92Vnl3RYzWyaEmJk+FqIXcl89LRf+SFGO+JwdJC8lbsTXdJ?=
 =?us-ascii?Q?kTGkwnBRW4mUbl+0I8Ta3AdK5yRXL66XEni88qvPNVr7EQV3rbuf9UHTHOzs?=
 =?us-ascii?Q?loamyHOi+LrKlku1IJ9qg7yF+RbxMBSWBfeHL69DzKU8KaoEvXspmGg0Y3bo?=
 =?us-ascii?Q?G2vTW5FHSk1MWURSAwG5rgUXPyalvtx+VoUCZ4ULVy2xtU1KmidYLY8vtqWJ?=
 =?us-ascii?Q?iFCD1H1otAQHtao39AKh+eZCd6BJuEFcEzYN7raV0O+tNEk3o4PAUpKih3v3?=
 =?us-ascii?Q?mQpK0JYVs4OobrMwzdGw/qFBSX+XdPyzGDjcziODv0y+GlR7zZWk25OFaInQ?=
 =?us-ascii?Q?XVAnLXhi9JgnEMkJEvezflcn2y/HmS5TWHBvsSJ2Ws1LwOYEw4GrF8gO8752?=
 =?us-ascii?Q?GlYBC8VL7CKZGNvKHrKCTKS9pLcxslNlGXGfXcAu7TGGymsYzDiLpz5Obp74?=
 =?us-ascii?Q?V//1xYIhwQz0UatKflTboMEjLfBNNDMbQ7NyKNKSUWvbPCz+1zU9b8AIFKF5?=
 =?us-ascii?Q?38EINtGKBGm3bxQHLUY3xciKC1MqITgzOC5teTaw477sGEN3qd896PhaGOpB?=
 =?us-ascii?Q?nbNSntNTKazHp/qOxyBrVqtm/YtPm5Vq+BliSe8GkJIxvTdTUa/bjHMjxKc1?=
 =?us-ascii?Q?YHDxKly0nBVsFUozH6iu14nnW0ArK/49HgZIe0W3M4tu4p9/V0mP8wtvsDJm?=
 =?us-ascii?Q?RUtqLiRJEziH8CBTCzMPTbWywXeuf4ovDY3bNnCYCEwQls9u/7KPuYK69KkU?=
 =?us-ascii?Q?iNBWuhc+1R7mzQomhBoeFjls+XY7j2vfeUQr54jdlNRSuxh8MjQ8QrAKO7S3?=
 =?us-ascii?Q?kWjxu8cPgocr1ulBUoNpinRltoTjg3PAhBTfpaBGECOg6htsINj2hx+IhQ96?=
 =?us-ascii?Q?K4B3N/Wkykoljw3ega/a73ecCij2WiYvawieCtk4IkyqochYjaaEp07pUmVt?=
 =?us-ascii?Q?cyS9jfEaEqfkN1jP2gxJVWZaGYGYNrikInrl80aZX/BlNzPJmgmpgjodlSkw?=
 =?us-ascii?Q?EnEs4j9Hn1VgbVr3u09PbMBy62wzRwE1WiDctH61UpjobYfMobq7SOb/rKh1?=
 =?us-ascii?Q?gTwCUfFCZA8Up9gMZtnxOXYrViDsLRgf82zS9l97/aW7+W8g9NXz7U7lW/13?=
 =?us-ascii?Q?lU6AJSPmqsXn8ZlI1nKY7uLKCmr+bX+XcPU4hpqrw5BD1fBX8wC1fIvYed06?=
 =?us-ascii?Q?Wmy/wt0YT0ceJfDDMqvMMg+YIZ3YamnSuznK1vb0XtV1BMTekBGAapDc8FOI?=
 =?us-ascii?Q?PbtUuUXl90MAU3DBrr+GWqE8SZTAaiwETF7Jp6CRreJ3MAhS5fbKdlX19M7O?=
 =?us-ascii?Q?vdgEIZonHL7rSDlMR9L67DO/ivfWLVrAAgNInXxMchv7zOZT7XV1T4w1nchA?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5144.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c373689a-20ed-4cd4-7c04-08dc7eeebe72
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 08:18:24.1675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+Tb/PwbjWvbWAoew4MVd65H0Z3qH5M1QEw6GVeHbQi8YOvmp4Ulv90Qo7dOwgh7GjJ5Z7XycFBeXhPV+FELM3Ikr/ktgwtW2PmZ02h7Ubs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8205
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Kubiak
> Sent: Thursday, May 16, 2024 10:11 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; netdev@vger.kernel.org;
> Kubiak, Michal <michal.kubiak@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix XDP program unloadin=
g while
> removing the driver
>=20
> The commit 6533e558c650 ("i40e: Fix reset path while removing the driver"=
)
> introduced a new PF state "__I40E_IN_REMOVE" to block modifying the XDP
> program while the driver is being removed.
> Unfortunately, such a change is useful only if the ".ndo_bpf()"
> callback was called out of the rmmod context because unloading the existi=
ng XDP
> program is also a part of driver removing procedure.
> In other words, from the rmmod context the driver is expected to unload t=
he XDP
> program without reporting any errors. Otherwise, the kernel warning with =
callstack
> is printed out to dmesg.
>=20
> Example failing scenario:
>  1. Load the i40e driver.
>  2. Load the XDP program.
>  3. Unload the i40e driver (using "rmmod" command).
>=20
> Fix this by improving checks in ".ndo_bpf()" to determine if that callbac=
k was called
> from the removing context and if the kernel wants to unload the XDP progr=
am.
> Allow for unloading the XDP program in such a case.
>=20
> Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>

