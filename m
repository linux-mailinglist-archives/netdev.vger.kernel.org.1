Return-Path: <netdev+bounces-255850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLMPACqVgGnL/gIAu9opvQ
	(envelope-from <netdev+bounces-255850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:14:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADA8CC3FC
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6ABF300F190
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFA5364E8C;
	Mon,  2 Feb 2026 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyG0SSXP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857922B8B6;
	Mon,  2 Feb 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034252; cv=fail; b=aIznFkqGVBRzg4EZ/f9CbKS2Zf/cZsVgzvy/A0tTIfZ+RE2iLRVDo0ksHwO1mrWR+KQD4HbUAwLNYJvC4YQqu1EYz5zvdO7GTuGJYU9xsxxL225fs1ehYP2GgOiG2uxbA9cCKf3fQZg5Y9yFd1uEkjtS+IwvRRAVjn8/ZYqCLvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034252; c=relaxed/simple;
	bh=jVcaoS9iWkcJY3d0mH7gKPO+IK9FOBEc0w0pVlbE4/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fCaIM1K/d0KOpfUoLSD+vzsvA3IX16oZXSLkuAGdRdBqDhMLOZM1ZsKT/VbKarsuZZ/Txlmh11IEoGkix3XClcn/uFS5Gkjjy8bioBxoFlPzC1M6sY3RwSoJQimlKD6KONEjq2buR3FAfL8EeNq82ih8rynySNL9ll4WPuPvNxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyG0SSXP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770034250; x=1801570250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jVcaoS9iWkcJY3d0mH7gKPO+IK9FOBEc0w0pVlbE4/8=;
  b=RyG0SSXPbVini8XWn5hM/MP3I+zaaYHGBitXmk7n4KnlqYBMbWVeN4+U
   l6XgyzlIofpyDPCyEkaNQncYNAvrqr2FL5bQCGNnc2VeojYSCrtRlgFYJ
   3gQ5gIRflnMVMM5dwL2Dp+rLD2KBljMCF6wFqCWsbS9XVudWjd9uGElLq
   l4VkmLnGg/r++YPpii695irtKbbuOJ4EzHrfyJbwdLgPSnwpToRvFsPQP
   Q33KsDFdTNSztYl3TL1jBn9276VIg53XOzcGCNIXYNVn663P0cPNUajrK
   7aa4MbMZhERYNP5FiMXTJ2cjgsq3Kt/yluKV8a5V0BvViwQP+Syg54HrA
   Q==;
X-CSE-ConnectionGUID: 3OxhDqwXQMui0/OwY/Rs7A==
X-CSE-MsgGUID: WGp9gFrURJ67npDBy8tzxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="82298139"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="82298139"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 04:10:43 -0800
X-CSE-ConnectionGUID: CAPhFYL6TdWB+wm6P5dUjw==
X-CSE-MsgGUID: uiULswSFSWGs7e70hzOeEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="214442675"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 04:10:44 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 04:10:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 04:10:43 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 04:10:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAliMBgIE/GTPlunD1nQRZ2KnIOJ/DVnWCj9IeVHivVa/68pZBjrVDqt4vrZCHpfJi0LBNb8Q6BG+5o5mKXwztjf4SgkUkVtuV1nRrKSa3TLw003Xi0iBVMBmu48KfU85EVCc3QIkygM6sHUMGtuwppqb0spgKjLIeZF6ZAdsYy1Gm0BJ8Ssb8gFCfSxJiGrHGESUb/MQlYQFgHn1hNtO/S8emviG/2TyVtSWAsmkrsLesTYNDEIyf5PMwi9r+4v9Q1R14vNuN2U1xRfN201eLvdCJmekerDTpxUiQNLoDD/7aRYn9/4iLtwTwbFP+/XfbHLSNkP2QpWQsmc3ZpCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL/83UdFv0UD0ZSGoGmEIJHVdtF2XQJZJXb8kP/0Nj4=;
 b=C7bw1rQpBLYYQHuRzvIUsTNCBE/9A5C0iZRsqf0FeM6Eky/olvYTJZ0ZSuYz/JQhS/9rcUWXDxcmzUhuefc2RY/l3oHUl+7q6r90+13JPw8PjqItWbf8UdF3trKkGc6GRdtahatZnMzcYCPnVwkgLstAowqRTJpxFi73R9JM0rKIB8U8HUHHbaSsDKbZEJogoitzFnn+nar7BpTXQdHN4QP3bLblC/8n1NGGgDRaQac7HxMasBBz7FA4sH4g7R97l5nv3WK8Vl97rKMzGyIXeRtql/fUKsVEPDh3YSS4N/FtVHRrmNrNSjGB6UisKJZVmd2d/O5nIuJitBlpEe3MsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6769.namprd11.prod.outlook.com (2603:10b6:510:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Mon, 2 Feb
 2026 12:10:39 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 12:10:38 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Schmidt, Michal" <mschmidt@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Michal Kubiak <michal.kubiak@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: fix crash in ethtool offline
 loopback test
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: fix crash in ethtool offline
 loopback test
Thread-Index: AQHclC1NjSH1n8HQjk2OPytOV5bhGLVvUWDg
Date: Mon, 2 Feb 2026 12:10:38 +0000
Message-ID: <IA3PR11MB8986234C9E57E6A57FF408D8E59AA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260202101755.315528-1-mschmidt@redhat.com>
In-Reply-To: <20260202101755.315528-1-mschmidt@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6769:EE_
x-ms-office365-filtering-correlation-id: 4a54d297-d72e-47b4-7a21-08de6254143d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?pTFEWbMKSgQ+1hszZ03q3JirSvF/fSOWvhhmjR0G8OZPk1PWGi9zFy9U9x/e?=
 =?us-ascii?Q?OFUzh9RFRcwkFHJ7qLqbdJmHWYJL/WX0gNqRDR0plEXJWQT/Iw0jJs+SXTuS?=
 =?us-ascii?Q?1uGC8fkwJXQtvWKy4ieGV+FKNZhLSC1DfjtrU4VgzAcSXMhk0SNgVCJHXdIM?=
 =?us-ascii?Q?t27Fmt8XUNZ4iZ39mSlmnL77XZK9ujYwSeNJ1aM3zLocZMC8O7nVNX5M58xr?=
 =?us-ascii?Q?B3siRq0dPS7E3J2Agtecmc38QkW++oBAY47aMIvI6X1H1oQRvr0qu3rzHYUb?=
 =?us-ascii?Q?ixaQ1Ks20d5aV9wdqA9LsstjyWLAXo9QRLzOI3g9oPDGg01ZBuhQ7d08OHfG?=
 =?us-ascii?Q?wgs3VDwetv2L6903SMXlGThi9VtFzy32t/ZP2cD+0SkSEBDuKpTA2jwyqlz7?=
 =?us-ascii?Q?X1fLGqURutV9n5ZzN5NLsYcWU2YbCTN3tb/jtVIz2xccda8jSE6LpRamq4Cg?=
 =?us-ascii?Q?yJ2bR0Nzlunnvx9kMXwdDuWJyFSU+n6Fubji+TWkGBAfHw8lyc/9UdF+bGDZ?=
 =?us-ascii?Q?nFaeM9E3w342wl6PPzNKA92wLZA1w+0cLcldq6z/6rCJcCZbX1SrHAKdIyV8?=
 =?us-ascii?Q?go6THW+onY+G3bYLZWMl2rPsqFITTx5uyUAD7vGgZ4kPvOiFw0tjy7/UqS3C?=
 =?us-ascii?Q?0qJ/RjNu9oQFTexunryuaFOsSqe4ieRaoKHR6eipFnEQCfmNYU1yIsFOy/sA?=
 =?us-ascii?Q?gAjL0tZUxcKHJHL/Q+3WAovvzjx1QV+u3/yfjx4eQqVHc08z4x0rkAebHRwj?=
 =?us-ascii?Q?18PcwDEhCjsx9y3HTLQvgRUUsx4kMT97tFSZtLJjtzU5054QTfnNJBKNddqm?=
 =?us-ascii?Q?ufhfeQaZWpUlyJ3tUTNMhBnVYA7Njx7ewkPVrif6mIkAmb0/dTsPPM22W9yq?=
 =?us-ascii?Q?41lGHCzL1epiBZtIOjS91utpw3LSfFzZmnNL3khYlGDPNSqPSC5Q0ZydfZVS?=
 =?us-ascii?Q?4UOtBo0xgBn76q7nnm1BtHs78X/QaeWHVxPRUjnqi0MPKB83yeAIOD8nt2PV?=
 =?us-ascii?Q?s2FkQBJUtAxoBzw5CYROIpxn1FL1X8wL/lZ0wmHya2m3iSIZMJhKW8vel1Ej?=
 =?us-ascii?Q?RW8UMtqf4ycxP5L51SU2Ff8nsDzg0w7MAfZNJxrAG+dZIkmNZzdvhfGfQP+h?=
 =?us-ascii?Q?Cmr13X+snkxRGDdD516cGY8baTQVItH10y3sOQ6G4K0OU8EDDP16/22RfuzE?=
 =?us-ascii?Q?gjstJy4Ct8D/albKNTNAcx0W7OL+BzLnfYAcUPs6IYPQWpUB7tgXhVAEA1q4?=
 =?us-ascii?Q?WcmkdEbmXGOlx+8f8OA9+z+7A+AhezdS5hDH1GqQwU9svlGCaWV4KhQFHyEd?=
 =?us-ascii?Q?vtEk+KOqMHTUuAgMyc0INns+xo0QlCImIJNTaT9BLEuOmuLs9FkWbAAlq6Yi?=
 =?us-ascii?Q?MQAk7LElbMO8Ydv4DbRFOCAhYqWJ5GzIc1HDlpRSP3Efn+AzAltLDrAbQK1g?=
 =?us-ascii?Q?KXJ+jB6cON8fIf4q/9vuwACn0pH/Qn7Kfto2StFpmheY7b9qCwBXUV6+hI0j?=
 =?us-ascii?Q?bsSOmwaU4+Y8fyQ3BrVaXdfirpDAxG/w6nC99w04iD5mvNy0nAvGhXvqQU4q?=
 =?us-ascii?Q?l+tHkMp/mGZ1ZNrgqa1+JJM2+tzHcEDTtfZHQqmS/ALZEvG7QEHrRuGO1v8P?=
 =?us-ascii?Q?5i5SLx4g4JR8YF8dbTQOtiT1m/4I1MdNpWrmtNA0zqYW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ySuXUDvOtwVvym5NV54VBW0l/cqdlxNjMjaAlwYWlmsDudPCUXrur8hynqjU?=
 =?us-ascii?Q?j8N36QKG3VoAIf5kto6mlplqrfBB1cORd6OqBFRbNpW6TGoxM6ZNcSIXG+ji?=
 =?us-ascii?Q?7Giiol2wAl/MD46jqtaJCHaqfWSvV+Cs9AAAUE9nIkm+JBI++jbIHbZINo4Z?=
 =?us-ascii?Q?1psIm1UZuwOT1wn8bbSn4lOCLgLAfNDiywCpBtYIIRFAdvBRd5EM6uKB066X?=
 =?us-ascii?Q?Q5wb8wb9Dc7+kFZs3PCsQQRIktGp0m4kCRJvHMRZ5fTEL5iYPsrQsWEXEvn9?=
 =?us-ascii?Q?BJUHfyOMgwIo23BvFtiWgtGMZOho3Hg/8aDWxCUcExs6ebYtaDmKQC6fy8tH?=
 =?us-ascii?Q?R6uYGmvQCxZaPu7lX11uJ7nXet/RBY0xU3ehCPvgCBAKJBp0OVILZDq7x0Ik?=
 =?us-ascii?Q?vYGcEbreU9h+vZGLrjpQ+R0QUl7fvVsR81AFUZrKFCAnvng3MmobrToz7AUJ?=
 =?us-ascii?Q?2e74SuN+rJOq+sXq0RGn7xPdpW1blykLemSyVSEX7KfdyluDxkF/VuN3PowW?=
 =?us-ascii?Q?2FRVbA/ARj3zt5h0G4dr69LVjS+BIHMguIr4wffEGFCPqIxT11dW7mP5F9Ks?=
 =?us-ascii?Q?KLLzebvppe0TLr9I1gPyA0GGdw0ScJY5i1V4P+R1Z6hLGy9JM6Pa6MQSgQhv?=
 =?us-ascii?Q?MkQ/otd2TzU3VPyEexjCas93Bnp61O2ZGrpBCoYCV+a6Dy1RvbzEUziVtRAQ?=
 =?us-ascii?Q?aHEVHCyCI9MrDeFHYuU7ybPZJDARgHoFp3rwVXovU3ZmHdTH2P7NahLze3F6?=
 =?us-ascii?Q?c/iSyP6K/bvUnuDF2XiXRx02ra0XoeCOKswNrGn31cRdlSeMGuZMbw4ef0mm?=
 =?us-ascii?Q?Z9ze2CDldZYARJOFA0S1u9t0Gr8OCOwFrCP/+eX6CM2Zt3fZPyAT78bIH3wc?=
 =?us-ascii?Q?v8k5dZlZ8oPD6nUWU3PipLIdpILqlQJZh47YM1ds4bXCKDe40sQuQ7e0oJ5p?=
 =?us-ascii?Q?knBd3pFwzfyYMNysTQbxP3e458p1+Cvp8tLUdg/uXzikhvVx+UfT+T0LKxCG?=
 =?us-ascii?Q?S6UofoX1nkllGIp1SuJ4+JMDZHegOe6haNdxChFsUu3ER6y0aDed70m92AcH?=
 =?us-ascii?Q?+QessP3KBaIqt9Hk1dZmSVhE6SijBFZOCCnx2txKQZyf0zIilklcgZlyKhaq?=
 =?us-ascii?Q?VH5tvH8GqpmYDgX0t5WXJ6iHao938hLwXlrJWPFkyb9dntd9hO214VXb6LyI?=
 =?us-ascii?Q?aPIso0e3gqF1PygG2djKinDwKx9UPR0B4ZoNaundHDTtp1ZL8fRhVzdeJMXj?=
 =?us-ascii?Q?BVO+aiP+YZQO7dAHd8u7zz+xIhBoI1JWMeX1CpaRoOGakm+8bI8wcI5dYFSQ?=
 =?us-ascii?Q?azA7I4Ci6s4OmVicSDTgkPyU/KenA2yC5KKOI6/j8qx+kUQeWOD7jPEPDO7F?=
 =?us-ascii?Q?eHt1o0VI482+c1Sl5sOK3u63gI0Jz05yvDWyLJ44EpWU3KpnxEH7ccx6WU3q?=
 =?us-ascii?Q?IFuZLI6xOIjZIK3VqQR20gU1Xi4rypAm+G2gW7ksp9NRyYe3rCDqd6dB4ivK?=
 =?us-ascii?Q?8u24HiYRQYKaGeoC4tcR5b3FEyMX+AylgoswsJHJMJU0OktzjYUAPwFhgs/L?=
 =?us-ascii?Q?6ibv61AIcyYX8eFljURrFJDP743XhEpZBbyUXV0Ws5gFrYVb8kyWbVyacmqB?=
 =?us-ascii?Q?lIfNm+dUXjxy8kmzr0xX1jGO7b8uJRRgeJ/Zcg6zonlf4OBkGYXB40dHJ3QU?=
 =?us-ascii?Q?gXlLYM8tLZDSAMr90ZDURBCbhbPXnycO/cXIH8TwCAtWKqjOGqQgf52eosrM?=
 =?us-ascii?Q?+o3nMBaPnA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a54d297-d72e-47b4-7a21-08de6254143d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 12:10:38.9386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86Zv8/1towLSB5qPZyuds1VUV0a1K6WSZOMuLgxRvusuBMuD2Z8qCzz+6srVP4dBkmp3YKf1JBGw52IXX8uSM2rSPi6j+YSSziLEk+GfA0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6769
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255850-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,lunn.ch:email,osuosl.org:email,davemloft.net:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6ADA8CC3FC
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Michal Schmidt
> Sent: Monday, February 2, 2026 11:18 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Michal Kubiak <michal.kubiak@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] ice: fix crash in ethtool
> offline loopback test
>=20
> Since the conversion of ice to page pool, the ethtool loopback test
> crashes:
>=20
>  BUG: kernel NULL pointer dereference, address: 000000000000000c
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page  PGD 1100f1067 P4D 0
>  Oops: Oops: 0002 [#1] SMP NOPTI
>  CPU: 23 UID: 0 PID: 5904 Comm: ethtool Kdump: loaded Not tainted
> 6.19.0-0.rc7.260128g1f97d9dcf5364.49.eln154.x86_64 #1 PREEMPT(lazy)
> Hardware name: [...]
>  RIP: 0010:ice_alloc_rx_bufs+0x1cd/0x310 [ice]
>  Code: 83 6c 24 30 01 66 41 89 47 08 0f 84 c0 00 00 00 41 0f b7 dc 48
> 8b 44 24 18 48 c1 e3 04 41 bb 00 10 00 00 48 8d 2c 18 8b 04 24 <89> 45
> 0c 41 8b 4d 00 49 d3 e3 44 3b 5c 24 24 0f 83 ac fe ff ff 44
>  RSP: 0018:ff7894738aa1f768 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: 0000000000000700 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: ff16dcae79880200 R09: 0000000000000019
>  R10: 0000000000000001 R11: 0000000000001000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ff16dcae6c670000
>  FS:  00007fcf428850c0(0000) GS:ff16dcb149710000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000000000c CR3: 0000000121227005 CR4: 0000000000773ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ice_vsi_cfg_rxq+0xca/0x460 [ice]
>   ice_vsi_cfg_rxqs+0x54/0x70 [ice]
>   ice_loopback_test+0xa9/0x520 [ice]
>   ice_self_test+0x1b9/0x280 [ice]
>   ethtool_self_test+0xe5/0x200
>   __dev_ethtool+0x1106/0x1a90
>   dev_ethtool+0xbe/0x1a0
>   dev_ioctl+0x258/0x4c0
>   sock_do_ioctl+0xe3/0x130
>   __x64_sys_ioctl+0xb9/0x100
>   do_syscall_64+0x7c/0x700
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   [...]
>=20
> It crashes because we have not initialized libeth for the rx ring.
>=20
> Fix it by treating ICE_VSI_LB VSIs slightly more like normal PF VSIs
> and letting them have a q_vector. It's just a dummy, because the
> loopback test does not use interrupts, but it contains a napi struct
> that can be passed to libeth_rx_fq_create() called from
> ice_vsi_cfg_rxq() -> ice_rxq_pp_create().
>=20
> Fixes: 93f53db9f9dc ("ice: switch to Page Pool")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c    |  5 ++++-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++++
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 15 ++++++++++-----
>  3 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c
> b/drivers/net/ethernet/intel/ice/ice_base.c
> index eadb1e3d12b3..f0da50df6791 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -124,6 +124,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi
> *vsi, u16 v_idx)
>  	if (vsi->type =3D=3D ICE_VSI_VF) {

...

>  		/* clean up the resources and exit */
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

