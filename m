Return-Path: <netdev+bounces-259689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCzmHVopmGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:28:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6071663CD
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B07130074D0
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387BB32145B;
	Fri, 20 Feb 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRnXlNje"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4F32274B
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579734; cv=fail; b=EKpX+t+Fuw5JdQO+8PJc7EpkrXDXv/MYSsdOxnKgqWDKq7wXttBjF4E9dypt/u3gRF3umh4YbCRO3VgXMdlo9FZmaessLnYOoeIKywqnUWloysRXCpHbu1kXuxMX81d4/NniaypUSbLEfwLs+Uwh4WAD1AA7s+MIP5Nt+8LCB/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579734; c=relaxed/simple;
	bh=wbd6aSDe0aAmyxM/tvoUZjPmfvlWYwk5lseqI2WPTtA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ibJCUkrP7rV19OiWd7PAYLluTSFeWlDz7/u++wHqwaMIcsaV0OqWt+2eOC6m/Mg9CjFHSWLtH43DOdRDkGqjXLf6ACtQdAe/e2Lt8b+ho76/yg5CvM8hpUA8qQGAMbwYYZIRCGXBgzFkyJE1UhS4MGSq93e8NsXwMsvQxNSFsgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRnXlNje; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771579732; x=1803115732;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wbd6aSDe0aAmyxM/tvoUZjPmfvlWYwk5lseqI2WPTtA=;
  b=SRnXlNjecSCo6fw4VxqLTW4jwKrITq4G/+6J7adycqH1osuKh9HJdS7E
   mbIkSiDFavOH3bdIRs7avFjeVmb8Bj7puYL+pc8l1X2LDSd7juE6NjemI
   jBe4g9zFOHly2N2UOdpA3NycMLN41kYbHAUxCsjtHEUc6aBZ2ezXibyk4
   m+dfJznpY40RWXcLA/fLWtAeJQBxQQbqEhYkdkrQ2f3oZaP41B6FCi2nx
   Y9GTKU1nps9YnEdviyzuzOQ4bPA3wbjpC2VvxyO1u+v4uHKwVJQHMM8hs
   Zj6/f9Plx21nzcp5B2/y8MheOSVXhje5fHBW7iiYU7GATNCSm818uT+tH
   A==;
X-CSE-ConnectionGUID: yU4b/ifiSkCknisWPW4MCQ==
X-CSE-MsgGUID: 1dww7tRgQjCn7JQ8CJoIfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72733747"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72733747"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:28:51 -0800
X-CSE-ConnectionGUID: ESj7JihSQFO5yzb0IAsnOg==
X-CSE-MsgGUID: 2PfjAhqXQG+mQ8jiL0/h6Q==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:28:51 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:28:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 01:28:51 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:28:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am8Dfw9FYvOQVMbmngLPP9SGQguiVXyTSM6RbHKPKlpFIOi9szxUlaOhTbWfdBONhCXAIHNDbEsAtTDKGzTT/WFTMgMtP2HbdpEsAkN8gepxyrsrR9mRnC0BXNSjByMysMIgJFFkJqs8I6oI0lx60UIayuuDKMpryLLDpfWLOR0WKrlTSY1vvKVHLhoxMTnvFxhPBhwy37V47IyqzI5k94PPHbmGWPRAx4jJ4jKi+9U3XfV1zqw3UPMjdQ+IW1dd4tn9kQvYwpuzMAwzgvmUaPPP/jui8ZcsJVANQ3fX6Zkh0U0idNMFJLN2rKrQ+PdCpwVizoSplysPRK/tIdwEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbd6aSDe0aAmyxM/tvoUZjPmfvlWYwk5lseqI2WPTtA=;
 b=Kkj6/WAqxLjelsmrNhoZ/1Q25PzGIZfrrYLRirjJXebKupOGtrwVh2gLZOc//zlxnOOY8mDDYEifotB8rwC0nd+Zf+ZCz5JsYYSLpb4jw+D+gJcpkThplrNRyXbuWbfNUHjoYdk31UtfHCAGYqMSyDvCwMKBwvAK4rLF/lbMYOmQLDj7XhRciQBRUygDxVs+BM++QDY9QmtSUEPs0U80O2rGu0Ufsbyxfk/G3s+rbzxxwjsTRgIgRjZ/QLVHvkLwuplqHXrlabMWb8tuZ5U7smR8+Lk6zfCWAtujOqXGjEgF34Dl/NqamqFBHijs1CvjzowPhAKOlCRVM7mn2U+f4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:28:48 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:28:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
Subject: RE: [PATCH iwl-next v3 0/2] ice: implement symmetric RSS hash
 configuration
Thread-Topic: [PATCH iwl-next v3 0/2] ice: implement symmetric RSS hash
 configuration
Thread-Index: AQHcokr/dbRH03GKPEO1IaqAERv9YbWLUf/A
Date: Fri, 20 Feb 2026 09:28:48 +0000
Message-ID: <IA3PR11MB898651A6A7524E4D4F0838AAE568A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260220092618.719906-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260220092618.719906-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL3PR11MB6484:EE_
x-ms-office365-filtering-correlation-id: 82c6214c-be76-4229-d7ee-08de7062739e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007|7142099003;
x-microsoft-antispam-message-info: =?us-ascii?Q?L58+rIaJOboXHrdjVYV+HsUf4DrmjNUR8565PHrIHNL66P4b17a4VmGb4DHL?=
 =?us-ascii?Q?YbBIxFMaaKOHblofiUm3o8f6+PTv3T/28NFlY6HMpqJ/qaanZ7CCkya3p/j5?=
 =?us-ascii?Q?N1SeGG6s6kBgW7ofvmMxZSkLIMFaUJ1O49/v17hXaHs3bFH0MnDT+ZijOHQn?=
 =?us-ascii?Q?7p65lxRis5h23q20xxb05afODVi6hf8nws65YblmTnCY4DTwEiVm0itKcI03?=
 =?us-ascii?Q?VUReNZyjeTCL62/qh/iV8qsr6ujZL5GDBaEfuitE5MGKbDx71LeKSH1qmxoA?=
 =?us-ascii?Q?LzW6ju/eumUbfXUuQS5tMVxNmQPPfSnNlEsohgbT7ZotBrgVs4hUVxWxAeas?=
 =?us-ascii?Q?8Oy5zSm0Lc6363DuQ/oISMcihcirEThwqYgPtKSBnpAjQGF/TelpvDlinWji?=
 =?us-ascii?Q?s51AQD0y/r/YnWF6jzc89Vlkf2KxExuAAgpvBHwNc0rQaiPk0DN/Vk2cL8j9?=
 =?us-ascii?Q?AFcj1d7lTYc4luigJLm6NMMt45DMdqj4mJKHVEdWMHNtD4eWd59S0SeogZLl?=
 =?us-ascii?Q?N6vA9GCGti9/IYUABU23KNaDIk1Q+kLjY2ejountyAgCkoJnKhRFfoA0Bhen?=
 =?us-ascii?Q?iMkNuwC1z63/C1HRj9Sc/xa4peQVmHizxeeU4cpHYQMtfhBbT+CyzbiFSUOx?=
 =?us-ascii?Q?lSH9FVerVp6/Y8fWpbyVatZKlIP+y5PWbHn+DCEKWibPD8VuUy9lizTg5MHc?=
 =?us-ascii?Q?eWy7jEeSK5+m/MvFKNu6/5a7LdoPJ0Rl0g3tdOFsZNJLFImPryAhx5E5NEjV?=
 =?us-ascii?Q?ZOAehQ9oiyPLampxf5t4vx5CiPDhWcfYgdxZfFeuTq1zl5HYBN8eKoHPEL6D?=
 =?us-ascii?Q?JD4j6AXZeN8gombAT6adGjL/PK7DlsiM57UuyK1hwxVhVuyjNU+DJojtpZp+?=
 =?us-ascii?Q?480GGhDwIkddB+CeexO6qkFxJ4wVfg5D40MmmomU3S+CvA3XFz4w0/UQPUVm?=
 =?us-ascii?Q?H6pkK5pOqJgBQIZXaqm2qQDcMJUCh4sZqUL4la7swvOWA2SSMIMI2p1yB4X0?=
 =?us-ascii?Q?XZrw26cfNC6iGSCK/UJKKipLAcJ7Fy4i3JzDc7Udoos4NiE6qZVa6bDfN4Yx?=
 =?us-ascii?Q?YuZ3z+L4uKm9KUFqGc43woLvO/bCT6F/FKL48OgRLfPTuIlDUEK2lvvMdexM?=
 =?us-ascii?Q?18V6XqcxdQ5SFXU7zai7n69uG58K3biO+S3TEAEz97YN4acg8Yg57K3od819?=
 =?us-ascii?Q?JF8qyMH8tsbg8X98uNEhLmOZChvQ2wBPAiu7/aR6WdWZ8xwbUMO/lu+mbuiU?=
 =?us-ascii?Q?rfdLKP3ZSSUzmBbiZIbaQiT1tPtfxTd0pYt1KJqpQnE2zLazpqC1WOoU4Q+a?=
 =?us-ascii?Q?niUkdLWmYsJvVXh9hzA6K30yg7JwQL/rw4ZmFiy/QPVNJze4Z/QveA/02CYy?=
 =?us-ascii?Q?JtZzTtPMxTbwiWRPF9VBEzirU+8+Y8O7YOsnSDB4zyUsPB7oi+pkClA3saH1?=
 =?us-ascii?Q?OeDNt9RfhOK8yNLLg/qbcQcg669gJvSuS62IQ73zOpvdjEvYDoNlThUEDxMl?=
 =?us-ascii?Q?sTSDl3KvkJsp+lxFloR7sVbMtAhABKuv7blqWDH3MLROMmwsytvzqNAa/Gtc?=
 =?us-ascii?Q?o3Qn2Pp2+wILP6JkcmEBhKgjYYfTj2XG+KT3A/q6I/7iuKXGK/FTswRJ1TLB?=
 =?us-ascii?Q?LTz7yZqZfMFdm4C3Nbqvm9o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007)(7142099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BuBmFKPAeifSm9Z4Zu9gG8/UCrOnUgxAP40B5XkoP/inMno/2DT1iVqYpp3L?=
 =?us-ascii?Q?tMpZwzVok0ZpSSR3FUjxqbLS+B8qvZzHJ+2iOgQZjf21DAOv42GfUhGXiUKi?=
 =?us-ascii?Q?0leNqFlb//gBGdsa6MadUPWoMkBOHS+AondlbZ8kni4dJ+DDs27Xfrlgbqko?=
 =?us-ascii?Q?1FWxo/O7rJPNw100Y1eUOx8oWTwJrT2zA6k2+j1yZHi/URSigKZ2C8wLUgjn?=
 =?us-ascii?Q?nBo5qjYvglm9Kx+NWISgWpeKeOE03vvHkxjKErSFXbUS7kiHPEMb5SVboJ4k?=
 =?us-ascii?Q?89FRQ9fwCwoFyIewtydYuSS7qleFiiomyKBlsGnOWOfMPimbZjnSzjUJYPye?=
 =?us-ascii?Q?14l6kOHxmuGOclAaA1/WTgqgh5lsTS2SZ0NjtXYC0PUd2Q1bHrcypMwjVCMK?=
 =?us-ascii?Q?9IKIg/rxPU9xB63H0GtgxptflOHKv0OyafdlR1jfQz2qJjDpRRzZo6s6ZIeI?=
 =?us-ascii?Q?wZO2RigzG+nnllSkvALrmMsw3aTMyTwEJ0DIGwqbfje9Oj40h+q6/UYGlECj?=
 =?us-ascii?Q?GEg2/eW5bc19E5tahUZEGMn/WxjvX05hXjQJfAFyO7gm8y+Ks2vN4XHcv+fD?=
 =?us-ascii?Q?vhXiYQC+mRXUMd0qYSeaVUXxuPfdh6+AuqWlTHkgROwU2lMNhQpVgSfzbA0X?=
 =?us-ascii?Q?5h3wuMcoxP3rMcEKE461Y8YrL867/rRa2cUVDx0uaxvV5wosIvEVyODQOol6?=
 =?us-ascii?Q?DNSe/88QkRr9YzywRb878eBdEX2OnXOjf0GtjkC49iwEL2Mpfy+YiQ7ZSf9R?=
 =?us-ascii?Q?N5y97mhr91m7ToFqvLwNEx/NiGm5E6zlDaHiwhD1IrlqWSeVwqc+o5cyy+v9?=
 =?us-ascii?Q?QC8UpK2hFWgoRGfA9JAvQXssbkdul9+bfrS4uLbpmbeTzL/CvafK139dg2+f?=
 =?us-ascii?Q?1Dz/2on2GoOf3O505T+ZzoU6nDz7TagxsFCAjfMI91AnNk071mQgzlhFK4NP?=
 =?us-ascii?Q?+oJ02lPF0Uy8iooZ7SM7vttjz6HYZJXl3kbmgFJnR/7//uDm5g5TAtoGiFth?=
 =?us-ascii?Q?cm7fbfBOG9Ud3i8F+svE6ez9Ef0MmPI1pz9Jr6z+AEMa5YPpynCk9zFfjvnb?=
 =?us-ascii?Q?AdARIxjfWoCxiK7HrGJ8hmRpa++TNDRA4f0229Z6Itztqb2exwHb4NCTviqu?=
 =?us-ascii?Q?mx5eOt1+p9tZVLGLBZbG14Vc31nz7taDhJAlFQL4PfyjmIdHxfqMx2tLhJzn?=
 =?us-ascii?Q?l4mfyNeEg4iqmUWqiUbAp8IMY80P5oVFsyiSqeLs6PC8m7img3VGDNyRvWer?=
 =?us-ascii?Q?TtWhTux4KUjVXsQEcO1wq3ppqxjLN2meb8V0ym95ryv+n1L4hRa7r4ucYoBd?=
 =?us-ascii?Q?nO4/UxrkJmY5ETT/uOwu+uOC9ylBjnrMFh2tSH/8pqmTF941ae4pkOZBM9o9?=
 =?us-ascii?Q?yeIg5rEXyEeVNixMqpv4JpG9GZyma5Gagseszsa0dNESLNQEpW/K5pf22g6i?=
 =?us-ascii?Q?vQ9x3csxwQ+YQFWN2A1GV3LrSvVly312B7ovu+HjWkonX+FoIO9jdZisOUPV?=
 =?us-ascii?Q?zkS0JL1P7CQJvOS+QJN4JL24iCHretZf1hqJO4mj98Ux3JjN2W3qU8U4oo9q?=
 =?us-ascii?Q?TBaMwxASNuTW+3LrP9KWW6gcJZznWKtcmEDv8L3khdDm6AR36F4AYT8SQTR6?=
 =?us-ascii?Q?T9NLofbjoYWQLy7UxcRJ1VV4G4jzqBQkQHmn2F9Y4PIrn3LamJqGSdc76YBM?=
 =?us-ascii?Q?yDwUxwuQrS+CTwve5IxPyABCAq6T+BkzvJ1xjpnvjaIn31TsUibqLy46twz9?=
 =?us-ascii?Q?JAUpcONTeQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c6214c-be76-4229-d7ee-08de7062739e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 09:28:48.1964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KIHKw2/RZLwpj+0yjdP7Y9g0KZB2X9REcfAG0i3QQpK8z07yyYMAz/dC7+5LbmQX+PZgcBM0iV1CZxeHlCUcZt/zi1YQdvA4pR4eS125/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6484
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9A6071663CD
X-Rspamd-Action: no action

Please ignore this email.
I had personal e-mail issue.

> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Friday, February 20, 2026 10:26 AM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v3 0/2] ice: implement symmetric RSS hash
> configuration
>=20

...

