Return-Path: <netdev+bounces-184252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8FA93FE2
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224F78E454A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78171FCF78;
	Fri, 18 Apr 2025 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jb38bB/b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB342080DC;
	Fri, 18 Apr 2025 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745015492; cv=fail; b=mSnTrXdmDSvjnF4BfCk81k0tHmd3jxXNstKWZ807Et+jjhmga4DXhxWx4H4GyKFsXeeBNSmb+vfMeiWOrQCbJhLpNfs5POPKnGqhLv89tSR3UlQu1vKmezSgmINZ+0w9FZr3qSrpN64xif7lN85Ctm3vahwvW9LgjdQQWfxLivE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745015492; c=relaxed/simple;
	bh=s6IRZHEveSGH/QL0BgHPbtVyCA+NWhwEWivVExt8LcA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d6nvGihbfWWHVfgCsJR/Qx1fhcvHwIEScbNbHgMIUnVFhiRB9kDcqLxrmYvLcglpVVoTORu4o8Y/zNVAzH+cLiY9ocsbo/ae5XCNgyjeBC6Wxo6JmmgE+c1QXV9RPwzChvWh3D0Hvfi+GwKt5SvBjQBPhceOwI5rr+AF8G6PHkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jb38bB/b; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de+9p27z87VsyvcJuKZP6turGh8P5H0ZrQedfoX1jsL7MWT4KYZinDuDdIcl9NVWF8MHBF1cevfZrYuyPTfiyzKFogYEoQ2dvNG87/u94XF27Yhat+LgvgcvXgpM4X5mtppLAMOIypYTAVtvCiPlP6jRRdXK14qN7iKwiRfEGNZsEJDLDaDj496jcYFuQa0lVJzA7BtV9bpUfMBDCq2IfJwvpKuI0XjT59pfA5fZwVWp6CbpyabFTjRqwuYLkFjIiwbI2eel8zxeRCtk4lTpp6fM6wrAeUlwxUCvUtTsGG8rc4aRPPvdy18xGirkN+bwfxAECsTE3xcLHIKrSG4PZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsuE45yW+Ptroq+G3t9FTvFwvHH56R3vKN0YJmIDW/g=;
 b=obuASIyuils8HTpasq9pNNYdvWdy5Dz2LIDZGXC0+EFyS1rrgjeT0IhaS5P/sF1ALzFPFF/Y6r/jg+87QuqBwjYZVYGC40fOt/mZgIW7Ydp7MfEKx+e07+lirw/y60ceRoabsdLAC9TDMgMrdY8bVRTdxqRIhWpG2noXN4/igz+ntUhoUZFe24LQEvcrep4Kiy/YCb0yR6wVDk/vyd3C1p5yMQm/T56hvUxmImrcDrp4oMCU5HTobzjIdRXlv0BRRhW3KQoWe2Lrfxi/FDURSHPkrCIHDiszRKbKd1rPz6OYgbiwxwvVtxTEDGZz51LJ+RnevrXa9Qo4CvPIGABK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsuE45yW+Ptroq+G3t9FTvFwvHH56R3vKN0YJmIDW/g=;
 b=Jb38bB/bOf7h0x7tkrcOnuaEIfgTEaHAoqzjY0mIphMk52n82OuCZTs+URHnsDMz51b6I2Ci9VFVzLcKRsFxgJvU3wertaA28c3ekezOpY3PY9F8hoxJ7aVNTQ8AySyfOJ8CnPGvQnust4IIvNPXdS6UUKiPBL2tIvciYV+OSMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Fri, 18 Apr
 2025 22:31:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 22:31:28 +0000
Message-ID: <917a9476-b499-48da-8702-8b2415bae00a@amd.com>
Date: Fri, 18 Apr 2025 15:31:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 4/4] pds_core: make wait_context part of q_info
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, michal.swiatkowski@linux.intel.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250415232931.59693-1-shannon.nelson@amd.com>
 <20250415232931.59693-5-shannon.nelson@amd.com>
 <20250417082156.5eac67e8@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250417082156.5eac67e8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::23) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: b42a79cc-8e73-410e-ff35-08dd7ec8c280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWp0VkFCMFV4QnJ4djVDMWh1c0poVDdJMjladkVIOXoya2t3clRtV2NvS1Nq?=
 =?utf-8?B?Wldmd0Q0QlVtTHMranh1ZzltZTlyYVRvWU11UTBZcDFZL2w2enZNYlR0TzBI?=
 =?utf-8?B?SS8yQzQ0UTVYV1hDWTdGYWR4YzN1MGJpMERSVUhFcFZVdUhPRTMrVExycXMy?=
 =?utf-8?B?R3grODI5ekVTMzZBeG1OWDFNLyt0QS9yWDFVQi9hSWt3V1VGS3NGUERrQ1Yz?=
 =?utf-8?B?ZTJkZG4zREJZMzVPM01XMWExWjUvVUtFVi9hajBDWEdLZ2tEc3BwbmM4QWNp?=
 =?utf-8?B?ZTNKQ0JKMmI1TUcxMnFBNHFXWG5seVNNcEhMa0pTY1JPZDZRek9aaEg0RFRm?=
 =?utf-8?B?c1FUZ1VyUkIzdFNVZkoycGxzYk8yZkRER0FSNVdoZ0xSaGw1KzFWRWY2T0lo?=
 =?utf-8?B?bEREQWdvMFpwR3FPd2Y0VzZsWDNteUNtN0lQY20xa1BKL1JCZFJhVHNMbW41?=
 =?utf-8?B?emw1NUkrSmdUSnZGZUd3VXFlbzNMa2VUZkxneFlDK3RXcWZJeUo4b0QzQUtV?=
 =?utf-8?B?bHUrSDZkNk1aQzZ5R3ZPWW1lcDFDMXNYZktPcVQ1WkczQmVJVU5QdnZiY3B5?=
 =?utf-8?B?Z3FPZmVzYmZsQ3N0YWUxaWhQWThsSzNXbGhGbGdoYVcwMTBSUXVGN1hBUWdW?=
 =?utf-8?B?dXBRUFJnNTBXR0xNMHFyTnZyRkVUNWZEb3JnSGVJVlBFdXJ1SmJDenRVVGND?=
 =?utf-8?B?N0xBMmdCSzlGVHp2VUx1YUwwUm0zNGdNVEo1NWpWa3NPM0lySjAxSVBwbGJH?=
 =?utf-8?B?OFdqN3NhTG9EdUpYYUMySkg5RWcxVWhzQVJ5dXJ5dmRUTE1wUHg3bUNZcXlB?=
 =?utf-8?B?QnRuYXFuS3FDSUdJbnlwTnA5SndzVndXY1RQU1FVL29acXlVYldLeGJEM1hQ?=
 =?utf-8?B?ekhzcFVyK3NXZUFtUlZSMEc1Ry80S1NhV0M4Z1pGeCtpendkSHdsV3lLQW9q?=
 =?utf-8?B?RnFUMFNJK0hNeSt5NlAvS2QvRWJwT3dsU2J5VFRjWHo0TnltcUszYzMvNnAy?=
 =?utf-8?B?dkxtbEVGbDRoN2RwQXVISWEyTzNxU1MzVHBXNFdjcjQ2bFlLcVhpWmc1YnlQ?=
 =?utf-8?B?QlEwZlkxeCtXc2I1eFFQS2VOdmxleDJPeVkxd0FnTWNoRlBsRFYvTTZYQVN1?=
 =?utf-8?B?K1pXZjBuVTM2cVlEcHpyaUJLa0pKL3l5bGNoc29GQWE0SFZ5OFo1dzNYd2hD?=
 =?utf-8?B?NDRETUp1eTFNMHd1Qm9DMEJ2WW1UNGFkMER3eElXTVJ6dmNwWUZQSTZIaFFo?=
 =?utf-8?B?M3ExYXNWU2Rpdlp0dmwvZ2ZrUE5Pb1NUZWdqaEkyM3FuK0lxV01ycytPcFJ0?=
 =?utf-8?B?RERVekRzYXJUd0dybmxCdWlvUmhUdlowK1p3UW9ZN25qOXpsaUxwUlhNNjZN?=
 =?utf-8?B?RVZmeERrUzdQU3NaSHRES21vRXlxRXJ6Z3ZpL0YzdjMzaWtrakdKTk5Ed3dz?=
 =?utf-8?B?RXhuY2locXJGNjhDWXZNd293T28ra2hXZGNjdzFBa3lQelZaN1VkT3F0ZGdM?=
 =?utf-8?B?cGVHRXlzTmY1M1VMR0d2OFR5UGtXK0NLWkxKcmxkMyt6Y1ZxYld3TndBaGox?=
 =?utf-8?B?Q2pncHNLd3A4VjVVTUQzcmc1UzhHdmVKcE9PcHRJT3RDZzdQNFg1RXFHbW5I?=
 =?utf-8?B?Y253T3BRWFk2UjZWelZpSnhIb1k1UGpRTFI2UjFjK1RTQ0R1N0ZvUGx2ejIr?=
 =?utf-8?B?ZjBzUXNqTk5iNlY1Nk9wN2FKT3hzeUJwNTRkUjFVZ1N1OHdPRXdHSVovTHFT?=
 =?utf-8?B?VzFRTkZIUld1aWJHTTdiN2xlQlhvbDdxcGtnN09JUmtUZTd4Nk9sdmh2NVhC?=
 =?utf-8?B?enc4ckVkbGErK2YwSmtVeWM4NGhvVEpITVpYR2lybDY5M0p3a0NESHkwK01S?=
 =?utf-8?B?cUxMejBybk5lQWJBOCt6ZlRnRjd4YXVUUmUrWkZLRjd5Nk4rcU9FNjhXZmZ6?=
 =?utf-8?Q?XcMJ4yFWS0E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmpRYmhHc20xblcweWVIb0IvTzRIRElTeUo0d2k5Z1lmMDZXTlVUREFDTkls?=
 =?utf-8?B?SVJ6Wm5hZ0hlcTVPdmtHL3I3emt1WmJYTitPbmhwZGJSSFU2SkEzUDNMcUhJ?=
 =?utf-8?B?R1VFV3dyWVh6ekN5M0xQeExsZ2FOSlB3S3k3VUFkL3ZHaXBBQVg5bWtjSTE5?=
 =?utf-8?B?QmZKNk8vY0JPSTBhbWpjYnpxQmQ2c1BlbHBHbGt3M2pickpQZFpGVGxZUW1k?=
 =?utf-8?B?UWVXT2s4Rk9mYUFrTUp1RnFjR3JLVmpLbGZKbTVQQ2RlVjBjSkk0UWxZZXda?=
 =?utf-8?B?eDhuUDBhcEN6bDZPVTA4MWZOUHM5cG1zbExGcnRMWWpQRGU5QzV0S1dvQUsr?=
 =?utf-8?B?NGVkTG1INGh2cmt4U25jNHQrU211UkhwWTlOR3UxQ2N1SDcwSUJ2NHFrS212?=
 =?utf-8?B?U25vSnhNNHRxSldlR2VCZmZoby9ETVdZT1Z5anl2dm9OTjQrYnB5UjMvSW85?=
 =?utf-8?B?Z0kzdHRmMkVOa2trbWtFdEI5Vk9wcjZtZTNWUUl3QXE3bDZjUmlSRzFBNlRW?=
 =?utf-8?B?bm03OGgwM0FaS2k5RkhqeXJtT1R3dEs2SUxnRFE5V0R1Rmh0cENPTVFQL2k3?=
 =?utf-8?B?NDJHTTZ4VmVlaE9ER1RGMUdEWGhKaEdNeituSW5jMHBKLy85blJFbkE4Yksv?=
 =?utf-8?B?RVRjS2hSeksyME54M1ZsS3gzaTZQcnIwVC9vaUpwU0ZiSHYvazZhbGJoQnQy?=
 =?utf-8?B?NG4vMDNVTnRRZEtVS1Z5UGtGNDVKZFpoSlBtZThIejE2cStoY2VweUZCNmVR?=
 =?utf-8?B?Sm9VN1NOYm1tdm5HWFc3cmYxZThXZG5yTEVZaHJXbTFjZDJoaHozSzlPeUJk?=
 =?utf-8?B?eHM4L3pMWnROSUZpcFN2UkxuQm53U21uVGNSd2o5RXREeCtycTdweldQU2lP?=
 =?utf-8?B?TG43YXJDUjdJMFJaQTdmdWlyWG1qR012UDZ5MXdJbWNEejZtMFBBaTBBSmdS?=
 =?utf-8?B?V1ZBVHZOTExOb3h5WFpCUTlqWmVmS1RkWk5IcEF3LzhRQ25DVGtpcjBKSEZN?=
 =?utf-8?B?a1hsL0o2ZW5RRXVKWk4valY1VUVnTzNTQm5qczVsczlCWE5CKzdDNWpLSWZ4?=
 =?utf-8?B?bEFXZm01Q2JZQlFZREdOOVhGMkt4T2VTbUZyTDlpUTl6SGc2QXpVUjZ4c2dN?=
 =?utf-8?B?aVFxbFRjcm1vcjdnOFhJam5BQXFZVkJTM2hZN1IrbThrS3cyaVE5VU5QU1ZY?=
 =?utf-8?B?NHFYSGVEVitjVWZUUEdkWDdiNEdxSEFFNzZrVXVjZnRiVFZjbkZubHZhY2dZ?=
 =?utf-8?B?QlV5aVd0bkF0aW9XY25leStzNUhZN1V5NFlVbHI5NUo0c085NnFuMFhMMFZU?=
 =?utf-8?B?ZWFNbDRPV1FMNjU1WnVQUTd4dzEvS1NqaS9NNlM5V1NNTXRsdThXSmlVblBI?=
 =?utf-8?B?d1lZNk1XUXNqLzVtVldCY3pSWUFSdzhLMjBHRlIrN05Pd3RPTzlnRzJkZFJ1?=
 =?utf-8?B?UmwvaGp2RnVrVnJFZEFoTDNMemljdFRoSmNFenVXMDM1VUhONmdiQnczMXIx?=
 =?utf-8?B?Y3F0OVRnYkdaSmlCVTFjWitmclhDT0l5N1BwbUdJZzBiU0xkTGN3cHdIa3ZT?=
 =?utf-8?B?U1h2K1QzbFIwV1lWVDdhNmhhS1YxeThQVEJKT3RtQllIQnpKNmNpMDNjMSsr?=
 =?utf-8?B?MC9hOWZmUEV5OFNFNDNoTG9SQ3U3ZGlpR0tpUGxRdE16bEdpRmd2cjJpK240?=
 =?utf-8?B?VjRuOE51aUVxQ0ZXd1hGV1VNOFhQSGcrVmljeTdaY2tLNUZlNm82MXo0Qlhj?=
 =?utf-8?B?UGMrbkM1U1dmaWdIc25RYUFqdGlXRm9nMlViZGxudSs1WHVaWWdEU2gyeWFH?=
 =?utf-8?B?VC82QXJuTWZLM2xvbkJ6ODFWQU5TQVgxNXZaeE1OWFo3ZjZxUEdibzlJV3pv?=
 =?utf-8?B?V1hsU3hjaUdWamg1WEZSVTk1cy9PSlJoYkhWOVRVMGptNDh3VzJvbU9PZjZW?=
 =?utf-8?B?WlJCWTYrUFVIKzdWOURRdjU4Wm9UYXZGMSsvOG10ZzRURVZ1d0V3MFpRdUxm?=
 =?utf-8?B?QkwxUTBLbWYxSVAxL0VJZ1hyUGtySmo4WUhEcktNdlcweXpKNHkrOFh6bHFG?=
 =?utf-8?B?b2V0UlJNY1lyLzZiOGRZNlpwR3ZSNEFyZFhSOUk5MCs4eW9uWDZTdVFVYlFU?=
 =?utf-8?Q?R/L7ABok3675ODHaEfm2uiYwK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42a79cc-8e73-410e-ff35-08dd7ec8c280
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 22:31:28.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UprR1m68RtlzYgii3RnUQSPYqLUYbxhFQQOhx4IIh8WdwhR9aloMo9Ww4Wc3USQ9wqJEnBSwkvUK6K9i5Zf4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451

On 4/17/2025 8:21 AM, Jakub Kicinski wrote:
> 
> On Tue, 15 Apr 2025 16:29:31 -0700 Shannon Nelson wrote:
>> Make the wait_context a full part of the q_info struct rather
>> than a stack variable that goes away after pdsc_adminq_post()
>> is done so that the context is still available after the wait
>> loop has given up.
>>
>> There was a case where a slow development firmware caused
>> the adminq request to time out, but then later the FW finally
>> finished the request and sent the interrupt.  The handler tried
>> to complete_all() the completion context that had been created
>> on the stack in pdsc_adminq_post() but no longer existed.
>> This caused bad pointer usage, kernel crashes, and much wailing
>> and gnashing of teeth.
> 
> The patch will certainly redirect the access from the stack.
> But since you're already processing the completions under a spin
> lock, is it not possible to safely invalidate the completion
> under the same lock on timeout?
> 
> Perhaps not I haven't looked very closely.

We have another patch under consideration that does something like this, 
but we're not sure we're happy with that patch yet, so haven't pushed it 
out yet.

> 
>> +     wc = &pdsc->adminqcq.q.info[index].wc;
>> +     wc->wait_completion = COMPLETION_INITIALIZER_ONSTACK(wc->wait_completion);
> 
> _ONSTACK you say? I don't think it's on the stack any more.

This worked, but digging a little further through other examples I see 
how we can more correctly use init_completion() and reinit_completion().

sln

