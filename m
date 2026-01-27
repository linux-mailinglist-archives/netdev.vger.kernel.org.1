Return-Path: <netdev+bounces-253719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJHPBPZdeGlwpgEAu9opvQ
	(envelope-from <netdev+bounces-253719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:40:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DB90780
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 498CD301DEFD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82832AAAA;
	Tue, 27 Jan 2026 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lwiKF+Iw"
X-Original-To: netdev@vger.kernel.org
Received: from iad-out-010.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-010.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.197.254.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69729B78F;
	Tue, 27 Jan 2026 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=34.197.254.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496049; cv=fail; b=Cuq8yqgCwPSnTi0wJvgCnD2MXHCgqtF0ndOquiXoe0rvudh4tEbSFtgWqGQSPrx+pzJqdkb9PI0M4cXEpvq1ISqYfLrVX/E6Jc8QD3qA/slMJkIvna0+s9kihUXAHkfIMS4MiHxOJ55/I/+YjySMUGnhbZFg0V9VBXRmvccqD24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496049; c=relaxed/simple;
	bh=6QHvYN3wp7Wa3iHub6/ewArSyI+cS2LRBHPC/mSIOvI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S3HbwrMaJbRz3098e97sugRvxldpLHXL3mp+BH93KHZun37V4x64zWtsXnzlWuzykUG5l1qWPWmO8cy744C8P58eVb3Pt66vlMOiJtrzAjLcNbCKStqISHikvxgWeZuuUFMUnLGuOxdw1OxYKJw4eJGoBJ5bh/2TBl90LQrpAqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lwiKF+Iw; arc=fail smtp.client-ip=34.197.254.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769496048; x=1801032048;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=6QHvYN3wp7Wa3iHub6/ewArSyI+cS2LRBHPC/mSIOvI=;
  b=lwiKF+IwN3RAPUlhN2ckXZ50uxcKKA2LhREwaAzACTOeGbJ/VJw4uUql
   +znQoWZHsOgg7Lk8kQNJz/8j5NPs+8Yw+Z5/G2EnQJZfchqxng0ZZlxY7
   SKgWhKfKNGsezdZkYorDXfs2pHB08RTsN2brq1GhBB8h5dcExK2B56En5
   kZGDe0yr1+ygY8irgwB2+r1C+0144Lt78C04eY0cEopSI0ikl+ZyuRU8Q
   je1MdHQ577qbCtHMvXBb6eYkQpjM7MXUKvblS0P/qKpT6A3kEw/DjAPVB
   k/EtkN1bmpyOsUmIIh1R1pyFk+mMMHlzywKtFSHe/oZnIQTMMeReiZiFd
   w==;
X-CSE-ConnectionGUID: cup87IV8QFWlkvPqIP5GuQ==
X-CSE-MsgGUID: rR7B9VRmRICf4zddzQJ1ug==
X-IronPort-AV: E=Sophos;i="6.21,256,1763424000"; 
   d="scan'208";a="10513790"
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-010.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:40:44 +0000
Received: from EX19MTAUEC001.ant.amazon.com [52.94.133.134:12313]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.43.130:2525] with esmtp (Farcaster)
 id cbc05ac5-6b72-4980-adcc-76edfe9ecacd; Tue, 27 Jan 2026 06:40:44 +0000 (UTC)
X-Farcaster-Flow-ID: cbc05ac5-6b72-4980-adcc-76edfe9ecacd
Received: from EX19EXOUEB002.ant.amazon.com (10.252.135.74) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 27 Jan 2026 06:40:44 +0000
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19EXOUEB002.ant.amazon.com (10.252.135.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 27 Jan 2026 06:40:44 +0000
Received: from DM2PR0701CU001.outbound.protection.outlook.com (10.252.134.239)
 by EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35
 via Frontend Transport; Tue, 27 Jan 2026 06:40:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTrOlTgQvlaMdl/chPdIOtNUr4KO+5moIw0wzUUDmtXb9k9iUKv1g29iP81KMbm2BkC9AnVN92t75V1kpSd6iI89RJFA8vjaW8PKFr0Q8QfcVRY+8G4swx7pE4BiM0uUZ6HvS7rY/19hDL8fQsMT6YtwhuVuG+KJLdT5cvoeo8JgEmSvLnLRHRLuAC2B1NfN/osz+3T+CoytyvR/+KA2xUKNnBODiwjd/v7X7RZC5CWinwTD7LYzWPTvuqGLbSg8mciGaF+mpo/cg+83aAuCDhn8aAudF5ir92YdNXE4tMQQ58oDBPcgry00PV/XFqvRCp2bz95M8yzTyHc6kfWYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QHvYN3wp7Wa3iHub6/ewArSyI+cS2LRBHPC/mSIOvI=;
 b=h1YAucOFW7Sa0JY6Gs54SKDKwqFEDHHNj+jha2xAOwgQfruAgPr0nAbgLQ5+Tnn0fQsLtf6MJXbyD2mWULW95TbFjVtwwyxEn8INoZQDsk0qXdpCOJomi07iB0GJLLzFiTktSPUR9QYAeCLEZK6BIphikdc76/RuJK3AVZF1iJzCbAJ4WJnv+rQ8gTfm6KWZFJWhkTSMd8cru0ZPrWXHPjNsp3EdfhWmXpKP/Rm2EMY8FPBAtkAFUVgmzAKroi2exTchPuNf2h3Nl5ncYERb7r8D07+pi1DeNuGadtr5FWSNQyRxdxYqGZkJlYhPTjbyh2RVPcFj+W6X9R6Z05WqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MN2PR18MB3685.namprd18.prod.outlook.com (2603:10b6:208:26b::7)
 by MW3PR18MB3689.namprd18.prod.outlook.com (2603:10b6:303:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.6; Tue, 27 Jan
 2026 06:40:34 +0000
Received: from MN2PR18MB3685.namprd18.prod.outlook.com
 ([fe80::b80a:2a8b:75a9:7e85]) by MN2PR18MB3685.namprd18.prod.outlook.com
 ([fe80::b80a:2a8b:75a9:7e85%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 06:40:34 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: "mmyangfl@gmail.com" <mmyangfl@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "mmyangfl@gmail.com" <mmyangfl@gmail.com>, "Allen, Neil"
	<shayagr@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "Bernstein, Amit" <amitbern@amazon.com>,
	"horms@kernel.org" <horms@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "leitao@debian.org" <leitao@debian.org>, "Enju, Kohei"
	<enjuk@amazon.co.jp>, "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [RFC net-next] net: ena: Use u64_stats_t with u64_stats_sync
 properly
Thread-Topic: [RFC net-next] net: ena: Use u64_stats_t with u64_stats_sync
 properly
Thread-Index: AQHcj1fWH27CYFZt50m4r6LqZqeegA==
Date: Tue, 27 Jan 2026 06:40:34 +0000
Message-ID: <FFDD6CD9-5100-49E6-B3B8-F38099043E87@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-01-27T06:33:58Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=1a5dec78-16bc-4394-9635-0d984b828aff;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR18MB3685:EE_|MW3PR18MB3689:EE_
x-ms-office365-filtering-correlation-id: d1cbbfde-2367-4a69-7322-08de5d6ef946
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WjR1R0gyM290bGQ2UmtqdmRJOTFXR2txaTg1eWJqemk1TFBkZTAwT3JmejBv?=
 =?utf-8?B?Zlp1ZWtJeFgwMGN4cFVpSko5d0JCdmdnSk9UcXpMcVlYWTFwWWJ1dmd2aU8z?=
 =?utf-8?B?UXJUV3hFVGdoSCtTZXFwbWFveHJpU2dSQWdJK2J1U01idktqNzBXNWVGN3Bm?=
 =?utf-8?B?TWVycHJmcjhwZFhNb1U5TmpxelZIREdGT1AxRm81eGJoTUp1Y3hWTC9QdWJS?=
 =?utf-8?B?VHpTOEZQN1ZSRUw1NDlJd1dxWk40QzcvdEJLL2VWMDlOeGtWUFlmSGIvWlIw?=
 =?utf-8?B?eXo4TUpSSGUrSGZDOG5seHIxTmxOR1R1N0l5OUQ3Tm1ScnVoRExIRXByWkVj?=
 =?utf-8?B?REhOV1o2SmZYY21QTy96WDM5Wm1JTVBnR0g0alpVVzVhemsrcVl3dTE5QjNo?=
 =?utf-8?B?L1A3WFJOLzdqVmVYMDRPWStaM2FucmppUU1FYS9JNWdRRTdTeDEwc3dDN2Vi?=
 =?utf-8?B?dzYvWWdxOEkyQ3lzRkdpYktKT3hHK1JOTXhXakVmMFpBWmIveDltN0cvWUZG?=
 =?utf-8?B?dERwK1Q3KzBMcEVjM0VLNXFYQllhbHl0Zm5HNkxYYVM1L2p1SDNmS0N1U0h3?=
 =?utf-8?B?K0J5d2hmVmVhNjFsSytpeXhDZCtzU2h2T0dEazlKK3F0MlJlV0N3TDY2SWIw?=
 =?utf-8?B?VlJVZVRSaGVmSDJENm1MY2dObEJlcDZjYkpJK0tEekQ0dUJEYVV2SVF4OFhq?=
 =?utf-8?B?SDJhaUI3ckhpWExpSHdwakFTeWRmdjY2ZFRDb3dmT2pHV2w3aUpNL0lxTEU1?=
 =?utf-8?B?ZGkvanJ1R2RFNHRBUUc5UythdEJ2MmJ4djVXZFBrbWVjNDdoSVhpWjBneFRC?=
 =?utf-8?B?bUJEWkFja0pqL3p4UnlTV1dNa2RlL1ZqaVdmTVM3aXorSXRGbGVVQm1KSTdt?=
 =?utf-8?B?OGI3akpjdDA2TUxRWXp0NWZEQVk5NHdEQ2NTSjBjbGh2Ujdjbld2RmZBdlNE?=
 =?utf-8?B?QzhrS1RwK3JVN2Fxak9VRWEzbGh0TWdpbDNPYUFETHp5Z3BEYTB3S2FZUmM2?=
 =?utf-8?B?VnV0ajZaYk9SdjNpdlBqcmFUOW8yeFR0bW82WGc2b2NXbk92UHk2UHZOVVZp?=
 =?utf-8?B?YVh2R2NObU95ZDREbkRWeVBFZE1wMEEzVHMyd1E4RURacFJtdDVleFg2dmZH?=
 =?utf-8?B?eks1UVVhVkRoNmVtWmk0VWRqS01IZUVnRlJqdjI0QlJGeWZsdnljdlR6d01s?=
 =?utf-8?B?SWxDR3hHaE03Z1pXMlgyT2lzV0tWbmJ1TFJXcTV3SFF4NmFZa1ZQOXNYR3Na?=
 =?utf-8?B?aStwaCtadlpSVWpzZ3BCWHRYNGxXQnFJMWNxTXZxWno5MHpMczUreFBrcitx?=
 =?utf-8?B?dWdQSXplV0hROGRYUlVISjZ1OWZOYVdiSlNicEh5Z00vTHBXQjFnSW5ka09L?=
 =?utf-8?B?MDkrMjYzbzNqZUpDeTRmMDVqTHJEM1ppL28wdXY4VHYyTTYreGxFeFJDMXR1?=
 =?utf-8?B?eTRPTXRZOW1IdWo5VktpNW1JalVMcWJrOHpEWEp1OGNyd3RsSk9pck05eUlw?=
 =?utf-8?B?YWlDUGZsY0FxeHJCN1lMU2lmWGNueTJGNW8yd2lKYkJXMzljLzlzWERaVUts?=
 =?utf-8?B?dlYwVTFXWG5Ydm1JcjNpTzF0a0Rlcjk3VTE1MFZBWCtmSU5DVEZQbzFWaWMy?=
 =?utf-8?B?WjVRKzFkcUtYUngwNmF3TGw4czA4eDIxVk9IM0hEWElteGtaK2VYMWM2WWlv?=
 =?utf-8?B?azJ4Nno5Y2g5aTdvNDcwTUZzc1dkdkVCUHdDR205TUNPdTlITXBTaDBvREds?=
 =?utf-8?B?aU9QK2h1em9uNnNyMXRhRDB2Ky9CQ3NvZnlzUW5yaEs3ZkVFeGt5cmlLRFE2?=
 =?utf-8?B?bHhPaWUwL0RUczQwQVUrZTdIZ2dWZjlMZXFXZDdkMFB3R0huc1p0K1pOMlh6?=
 =?utf-8?B?Y2dpSWhINiswSVRTYUloOWQzM3d2anpNRmpzQm9ZYXBFdVRWSjlwTDA4dnhz?=
 =?utf-8?B?T2V3TTR3OGR3c1Z1bmRsbGhqM1ZIaGQrY3RIT2Z1a3d5RnYzcGZmNTZ4YVRy?=
 =?utf-8?B?VHl2NVRmbFZxVEtWb0FkSzJCT21pR1BxK1QyVkQxaGE5ellmTE5aS0dtV0Ni?=
 =?utf-8?B?L09oZVZlMnNjTm9VaTFUd3ZEU2lqNWFwYUwxbDNjWGVxSWROQUMwT3hSK2JP?=
 =?utf-8?B?bzJ1RFF2aGI4UDk2aTlPRFRxUzVxRUpEaVZsRGNaNlFMNmdIMU9hSU1NZlEv?=
 =?utf-8?Q?lfT7cT3qvuSOQ/rhbkDr9tU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3685.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWRpT0NzbWh4bkszQXlNM1pEUjV4RVE5STE3cVZsSWdmV0ZYMWF4YW0vMG93?=
 =?utf-8?B?UWJhSlRjc0I0TzBhMm5qRkU2eE95Wk94bWZaSythQWQ5WmpySkdUSjRzckg3?=
 =?utf-8?B?MjdGQUZYQ1lhc3BLbWlBZ1JJRWczWDR1UkNCclBJdFVDbFFxNEZxL0luS04z?=
 =?utf-8?B?SDNzYWNNMDVOZDJBQTdJYUJCK1NhNFZpTlVybHRvdnczcVNmNHNRSUphVHBj?=
 =?utf-8?B?a3pFT0svcExFTjY5dkQySTJnejJrTW11Q3hac0pNbUxhQU5XQWo0YkxGTU53?=
 =?utf-8?B?eTlHdWFUdnJTT3Vaekp4aUdUbjRETE5LT0FJN3ZRcVhqYitlRGNubTEwSFVY?=
 =?utf-8?B?dDdMYzlHaFd4UDJ6ald4YTlWendqSkxyeStUay93VDVMOWxPVkFCRjJVSEFK?=
 =?utf-8?B?M0VBcXFrQnA2bS9nNTlmN2lxaHJmY2RwYTdPRlZWdkRhR3g5UVVONFhDREVK?=
 =?utf-8?B?THJlaU9vSmZkNGlZTmY0czNyQkRaWEorQ2o1SnpjUUJLa1NMRXQ0b21QREJN?=
 =?utf-8?B?TFY2NDBOSlVPREMvWGhjdGtFYWt1L0lnb3pLK2NGQ01NOWtNNHpDOWJiRGR6?=
 =?utf-8?B?VkpPdlVOYnBjazExMHBORk1zTnhvQTNqV2EwL3NIM0ZqT25XY0g1cW4zaG1p?=
 =?utf-8?B?aFd3OWxWTzI5bGtMdDlwQnp3cHBDU28veXdKd1pOb01nQmVCN1pGOTZUUnl5?=
 =?utf-8?B?TXVUU0loMitNcDl5NytEWEpzVGkrRnhIWXJHb0plMnMvL3prUnJORnk2SFRR?=
 =?utf-8?B?aHVWeUROR2FmRlFmNzFjRGFsTWNVQnpURWdOV0dNdjJJdEYvYXlkaDV3YnpG?=
 =?utf-8?B?Y0JsMlVZdWdML1FlR1ZqeWoyUkJ3ZUdpQm0xb0JkWmY3Y1czSHAwR0d3MjUv?=
 =?utf-8?B?Rm1oUTRKb1NlZ3lyTHlSYVdIRTdoZDhKcFozWDYxY2ljSnhDYmJVTSs3QVpB?=
 =?utf-8?B?bjNEUUl5bXp5dlNQVHpyaTE3bUlDV3BqbzZ3b1A0NzBENUQwZGRMcWl5UDMw?=
 =?utf-8?B?dmpQZ2QvZjIySTJpbkN6RHMxQ3V4M2o2RVZnRzZWZ3VVSnpna1ZiUWkvNi9N?=
 =?utf-8?B?ZVpkMHJ6WkRNVUNZR1ZUb091dlIzZGxna0M1dCtmcmVUdlRXdmdpalBsUENp?=
 =?utf-8?B?Y095bWR4VjVncUV1bXp4MHl4M0ZsRzZiUXMrR2tzZ0ZyMkVTaHRpbTh0TzNY?=
 =?utf-8?B?Y1FBUmlLNXpsc0J3Y2dBQmg4OXNrOTQwTjNHSU5CZnRyVHNPdmJLcktaU0J4?=
 =?utf-8?B?S1grdVk3dDd5bWd6T00ycDlJZXo5WjU2cU1GOSs2N1NkR3k5cW1tcU5hSGhQ?=
 =?utf-8?B?ZWpVakdkdklLZjNoVDVsbENqVk1oVjJVbVZQM3lNcU5vNnZRazhYSWw1Q0NT?=
 =?utf-8?B?ZjlVMXBrZ2NHTHUvSy9xNVgrNzBUWUR4N3pteC9sZW9hcXIrM1VJcktTT0l3?=
 =?utf-8?B?aDdVcVp4QlhiSXUzR2RTSUd5Rjk4ZXVNV2RLSGhLbzdpMzF1eUhuSXNodUha?=
 =?utf-8?B?QkNDMzBKc0ZZVjVSK09jelJRRVZIalJJUVJtbWhTQWFvR051OEF6TVNUSlZM?=
 =?utf-8?B?bEhJT2NRYWUwUlE1Vk5MK1VJWUhCVVNCVEF0RVcyWnBvRVlzdGkxbnlrQS96?=
 =?utf-8?B?WHpqSmVPaDB3NnlZZVk3MFZyVkMyL2NjRkViK3NubTNPZjBXdkh3NGNrSUdY?=
 =?utf-8?B?N0pxNnJ3TW9nYTRwUDFrdlFZZytxSEtRSGFWV3RIc0tWVGhtVkRWREwzS3R5?=
 =?utf-8?B?bFlZemRzdngwa0lQU29ZSmNIekw4ZXBkMTVLTGxzUlhqdGM3WHRIaElVbDhB?=
 =?utf-8?B?S3cwWFlucTVFeEIxN3pZYnp2UVdtZTMrOUhJUlJudTQzaVhHRWpYVFlQKzJh?=
 =?utf-8?B?bkJtSU9SMTRnWG5LaXo5VkhtNUNwN3A1UzcxWG9JR0lRZkt1QWErV0RmMDlY?=
 =?utf-8?B?SVdia3I5S29vOFR0VzI3cU04UmRDVGtCL1lwMTJsdE9saWo4b0ZTQjlqbFUz?=
 =?utf-8?B?dDZadXBuTzNWaU04Q0FVREtOVDlHbTI1eVBtV01nQTZPU2dibXp5c2FMazNt?=
 =?utf-8?B?c1JSaHFyZ01HUklNejBKMVFCdkdYdE52dDNSS2VGaDFWajFxZEdlL2NzWnN5?=
 =?utf-8?B?MG9EVXU2cWdVeU94ZTk1dnpya0VkNEhORG5kOC96UkppZVBUWnFLa1phTkh4?=
 =?utf-8?B?WVp0bTVGMER1L2RhYjVPM1FXMVJjelVlVUpBSWEzSnZWOHFyL3h6UlVOTlVS?=
 =?utf-8?B?Q042R1QxZjNscE51OWtBV25QZnE4b3l4bm5BcnBhdm1TS0lBcUtzeDEzTk0y?=
 =?utf-8?B?ZXRjV2VtdllPTnRqdE1rVVZRTnRUZUxIQkticzN2OVV3NzkvcWoxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3342D397FF547543952C3F4CA88A8D00@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3685.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cbbfde-2367-4a69-7322-08de5d6ef946
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 06:40:34.2898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndJLmF6wSUiDlrCB16oxm90RCBxKWxDO6DVxos6EcXhBOsPSyzGXi34RfAj2daDAbftbO06dkSIYz4DVVKtthw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3689
X-OriginatorOrg: amazon.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.56 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253719-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[amazon.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[darinzon@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,amazon.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,debian.org,amazon.co.jp,intel.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 813DB90780
X-Rspamd-Action: no action

SGkgRGF2aWQsDQoNClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUgcGF0Y2guDQoNCj4gT24g
NjRiaXQgYXJjaGVzLCBzdHJ1Y3QgdTY0X3N0YXRzX3N5bmMgaXMgZW1wdHkgYW5kIHByb3ZpZGVz
IG5vIGhlbHANCj4gYWdhaW5zdCBsb2FkL3N0b3JlIHRlYXJpbmcuIENvbnZlcnQgdG8gdTY0X3N0
YXRzX3QgdG8gZW5zdXJlIGF0b21pYw0KPiBvcGVyYXRpb25zLg0KPiANCg0KV2Ugd291bGQgbGlr
ZSB0byBydW4gc29tZSBxdWljayBwZXJmb3JtYW5jZSB0ZXN0cyBpbnRlcm5hbGx5IGJlZm9yZSBz
aWduaW5nIG9mZi4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBZYW5nIDxtbXlhbmdmbEBnbWFp
bC5jb20+DQo+IC0tLQ0KPiBSRkMgQ29tbWVudDoNCj4gDQo+IFRoZSB3cml0ZSBzaWRlIG9mIHU2
NF9zdGF0cyBzaG91bGQgZW5zdXJlIG11dHVhbCBleGNsdXNpb24sIGhvd2V2ZXIgSSBjb3VsZG4n
dA0KPiBmaW5kIHRoZSBzeW5jaHJvbml6YXRpb24gbWVjaGFuaXNtIGluIHVzZSAoZm9yIGV4YW1w
bGUsIGVuYV91cCAvIGVuYV9pb19wb2xsIC8NCj4gZW5hX3N0YXJ0X3htaXQpLiBTaG91bGQgdGhp
cyBiZSBjb25zaWRlcmVkIGFuIGlzc3VlPw0KDQpXZSByZXZpZXdlZCBvdGhlciBkcml2ZXJzIGFu
ZCBpdCBsb29rcyBsaWtlIG5vbmUgYWRkIGV4dHJhIHN5bmNocm9uaXphdGlvbiBvbiB0aGUgd3Jp
dGUgc2lkZS4NCkFkZGluZyBleHRyYSBzeW5jaHJvbml6YXRpb24gd291bGQgZGVncmFkZSBkYXRh
cGF0aCBwZXJmb3JtYW5jZSB0byBmaXggZXh0cmVtZWx5IHJhcmUgbWlzc2VkIGNvdW50cy4NCg0K
WW91J3ZlIHN1Ym1pdHRlZCBzaW1pbGFyIHBhdGNoZXMgZm9yIG90aGVyIGRyaXZlcnMgYnV0IG9u
bHkgY29tbWVudGVkIG9uIHdyaXRlLXNpZGUNCnN5bmNocm9uaXphdGlvbiBmb3IgRU5BLiBJcyB0
aGVyZSBzb21ldGhpbmcgc3BlY2lmaWMgdG8gRU5BIHRoYXQgZGlmZmVycyBmcm9tIG90aGVyIGRy
aXZlcnM/DQoNCg==

