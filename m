Return-Path: <netdev+bounces-136903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 214739A3921
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394491C257DC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576A218F2DA;
	Fri, 18 Oct 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dYqEW/3a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27A18E758;
	Fri, 18 Oct 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241539; cv=fail; b=p4hkNdTsRNruBWw8BVBtsQbjlVcatgZsP/CWq0k5GxEsEbkolowdNfTZ/r8BRYfvBDOJM7xrihWAfjEAGPflK/qp38DN7+jZntlxfrHySrFHY/xLMErcuD2F79ocmFFZ4RnMmEKIPOM51HE5c9oH+IeqfrIvadLgRMkwGrqwCBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241539; c=relaxed/simple;
	bh=xs/O2XYQs3/1wyRbK6asC5M13ldsBP8hbsdioCz9cpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FIKRIE7RR5xQO8Hp/wbz1EvC2tM2HjTld2L+ZbcxPGvMvbXXl+VrS9QsScmW9m36rCHl2Kcrtj+GdrmRiLB/hJdSVuwLC2NYJw8QgqYhPDFm2YvkLOrNS7qFQtgsxkad2TFX+kGSE3konDLXAsWJN5oIg50HtG7E0Phm1Ct9jW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dYqEW/3a; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZM+hOfTusSBpeRzFYE/IwRIBN0tfN/WlOzK0ZFPgwdLgdvW51lzcENhjmzDPw+pQmCWfgtRqCEt5nDVvw99XQvATOGDd2KUA4INEbkElnf9ssA1gaYXqfZ6uhzfILirZpUJLxgaAkKt1681cMUOt0YEyvepzDXSwvbghuNlYv/pVvMkxtTX8cPDosFxM80a5s6CtzsGXZ7C1yu4pYTf+to5P2bL6JRT/9PBpzwlz3AZc2gyEeW/WYzDki4ZkSFT7jREjW2WAQxOCqRILuipH0DfJOTEVBFLRUk/KErgGjlqsRXKv0Pz5FQ+uI7Cpr0n36+dmghwIXz/GC0Qtwmvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yce8PcWcTcyrgdr17KNZ+CUl8G9luzS//n0ke0rGclI=;
 b=VvASc2XerheNe9KBEK4G0ZPfo2bjrgJ22g2OkV3cwsQY15d3LDbcrjGliBMWAjw9Ev7BX5oJO2hQUCdgKt7l+rEEXkFeGK5hPHrItWdsHee0uj7HL+ZM7ViA3NFeNCavfnRS+cGl9V0bw/eVwRJYkveGBYpvGVVVKwnhkilHULBplr9Q1EeN4ORGSsCs9+Iitu2wbhrNo8r+rmItsY54T8b4jSh9pnEagABf31q/bSmF26FBQBO558vT+nVOH0onakv/wLhMgmDPC+DAY7PRI0iGBqVKp1l87+CK081io/wcpWRyttTq+h9y65NgqZ6VeA2kgW75ipJohzi/gl9PPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yce8PcWcTcyrgdr17KNZ+CUl8G9luzS//n0ke0rGclI=;
 b=dYqEW/3aSbDWKZX5IzH9MJOw2JwBgLWhmM63nLsw5YXjNznbeuKZii52P+PG4Fkz6/RV34E4QFpZWvEFfFp1OgL8dKRokdGGUnlEKR1U0XJtyVYKUoehXcvKH5GbMyTsb0/1MGNIyYUg6xSJcyC6n9XdAplbeqBDbbIgTK+Jxu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 08:52:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 08:52:14 +0000
Message-ID: <22262215-54de-1a36-056b-5854ff05ccc1@amd.com>
Date: Fri, 18 Oct 2024 09:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 22/26] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-23-alejandro.lucero-palau@amd.com>
 <4b699955-8131-48d8-a698-999d90523261@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <4b699955-8131-48d8-a698-999d90523261@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9675a2-2966-4048-f25f-08dcef522951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVFpazVQWnZEMi81Y1pSaWdrRzc1a0dhT09BNkhScGp0LzhFODV1ek15VC9E?=
 =?utf-8?B?QnlBWjFPWEpPRTJZNTFWWlQ4NnV5QTl0WTJsaTlrMVBpdnB0WXk4endDZ0lH?=
 =?utf-8?B?RGRUYmtGMlZ2WHVIdVBYMk9hUTJKTVk3dXUzZlN4NHVmN29sa0hKM2NQSTI5?=
 =?utf-8?B?T1RVbWpja2tXbDUyUkllTkp3ZlNhSHlQa3FIMlp6c3U0OERKV2NOMmdEYkZh?=
 =?utf-8?B?cjY2WlJ5c0laVFNjai9jd1YvVHpLb3dhcjhEN0VoVUk1WHplOVppZGNvajFn?=
 =?utf-8?B?R1ZvS0lGWHhlSlZFU29NUk9PUTFnN1JJSjBKeDZGaEE2VUdQVk5RNWNROVpp?=
 =?utf-8?B?eG9JQWt4Z0F1UDlITFc3LzVEMm9lVUVOMkFSa0U0RXQ4SVQ5MTUvWDNrbFJW?=
 =?utf-8?B?MndnZ3hWZ1E1R3ZOREdOaXZJSTdzRzJmT2Z4YnN6b1J5Z2VBWEZ1ZmdKR05Y?=
 =?utf-8?B?d0craWsvcEdRK3FYVisxYUF6ZE9OMTB4UlRmZVRkVTJRODVGMDJPMm1GRVdn?=
 =?utf-8?B?a3ZLVEZtSFRieERVd2NTWmRoWjJkZ0M0QXpMM3hPS2hQTmZ0cVU5eGVCUjEw?=
 =?utf-8?B?OUM3Mjlha3dpTy91OUFtSXJKK21odTRBTmoxdXpRNmNrVmZPNnVRa1AwNFht?=
 =?utf-8?B?b0JsMG9SNmlpUlFnU2pPbDZZWngxNXNOUTNJMmdveDdnMzM3SUt1TkFNdEdF?=
 =?utf-8?B?K1QvRFVicWxrdW1DM0JhM2Fkdi9TMUJySS9YYS9iRDBWeS85NUgyVTJ3KzY3?=
 =?utf-8?B?bnFTenNFaWVlcVdEQmxVOEJGVW9QTlVJZXhtcGhTZWlYckd6a0xLVzZtLyth?=
 =?utf-8?B?ME5tT0xFSXVhTlN0cXVwd3RlZEFzWVB0V0dITUgvZFdybndxbnRnOVNqOEpB?=
 =?utf-8?B?Uk1EV0hPMGRQaHBvVDE5OTN0QkYzVFlGRGdDcVJYQ0poZ1JCRVVVamlSelM1?=
 =?utf-8?B?UFREY2lRYUJrR2JxN3prbDF3Sno5ODN2dXBWb2JTYWM5bHZJMUYzNE45T1d6?=
 =?utf-8?B?dWZXU1NRQ3NOaXh2Y0k4bXQxYXhBYnIza1RmSGhiam5GMWdHVHpCaFhMRy9V?=
 =?utf-8?B?bE1meWpJdGJoeFVoeU9qTUdoNEU3cFFWVi9nUjgxbFJ1V2x4dENzeHhuNWQ0?=
 =?utf-8?B?Zm1CR1pwbCtibWNZWWJXSFBTRVc0T2ZNT0xEQittRjIvMDIvcGhkL2tjOUdq?=
 =?utf-8?B?R2tlRUlYRkZmMDBOUnZvYVlGNEc4VXJ5ajV0QjNZRlJjSk9FOXFzcGFiSTFN?=
 =?utf-8?B?NVcrRDRTdE83Uk1zNVc5RnVwemJieDJmM0o3R1psYkp0TmJjWVd5UE5MbWNh?=
 =?utf-8?B?SDZjVXQ2NzVXSkwwbk1RSFZkYlcxcktSYTFqR3NocWlsbXpWdFNHR1dWOExC?=
 =?utf-8?B?SHlSMEdtY1JEYlhKWHNaOXNMK1JLMGxFcnlPR3NJOTI3di9jZnNmbS9xelM1?=
 =?utf-8?B?V25PbXZmTEE5NTFBRittQjVqdCtxZy95WEc1c3l5ZzJ0WkpKMmd1dXIxMlhF?=
 =?utf-8?B?dVEvSmdGVm9uMTkwRnFhb3Mvamh2WDVYb1Q5cTN3MElrT0hhSFVyYWIreStW?=
 =?utf-8?B?STVCbk9sUnEzSHZMbVVUeDNTTG5jeERzeWJuM3dDam1uM1RkQ1BXYXRreENR?=
 =?utf-8?B?bjNrYjlSRlMxcVk1MkJwM0ExYlVnRHNIRDdpbFI4NDZsT2xMS0N4b0JKSzY0?=
 =?utf-8?B?UjBFVjRnVm5RMXlVdGszcWIyWE5mUCtZWnRZcUVFS1NCUW56bnR6VHZoSXBX?=
 =?utf-8?Q?rUOJiN8Q7nVa0ys/2IwWak0ayErx9i5TcP9WcfJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WStqeTJNKytqc05lWDlkUmR2M2ZqTG43aXZ2cFpxN0oyUWZtZ0Rrc0Q0cnJN?=
 =?utf-8?B?c3A1eXV6VEZsTmFjRjNVUVE0VE0vZkMrMGd0dC9pVndUcGYrZmwzS2RoWEpn?=
 =?utf-8?B?eVN1ckk0bVlRaTJHMENTaXpud0c4NE1sQ2VTN05wR0dqa05YYjRGZXNkTTFO?=
 =?utf-8?B?a2lPYjE4NjN6blhzaTFzcEtscmJqVFpBMVhSWm4zWlFndGs5L0FIKzhTc0wz?=
 =?utf-8?B?NjIvVVllVXVIdnYwUThrNVVEeWlBdVY1OTdGRnRxbElCNW96b0RIWGZ1Yk5h?=
 =?utf-8?B?SkNyb29PMFNzRFhHdWY2UVhwazJ0UXptWjd5bXltQUhZcStPQ09IU0VNTG5R?=
 =?utf-8?B?ZDlKUXZja2U2VFFSd1pZU2pBTDg3TVdXOC8rcjBYUi81dWp2M1RyRGRZOGk2?=
 =?utf-8?B?ZzZ2Z0EyZU5tZmpFN09zWEhqOUZVYUZRSjRpNUdoYWRqeVByQnVGTnpHcFcw?=
 =?utf-8?B?UjdYZDBxUUVCbTJxOHg0MjcySnpidWRtTUkxUXkxdUk2SEFCNWNrVFd3SEZU?=
 =?utf-8?B?VHludmczMTdzdFU2dms4dEFnMWVRbUg0c0xwc2hUdmUvYVA3U1FCTG5MZVNR?=
 =?utf-8?B?Q1pEOHgzaXpOQThKV1VYUGhRbEVGUVh2RnE4TldhM0g1dzIzUzY3QmNUNFZK?=
 =?utf-8?B?SlFwVkx3dG8velU4UWhHZkIxa2dxays2WTF0ZmNhK0czSXF5anErMUtNVDBy?=
 =?utf-8?B?SVlHNitxblk4T2tLdkszUDhYY1E4VVlqRXk0dGZ0VFVFM3B2ZnJSQTlEYUgv?=
 =?utf-8?B?Y3d1QXJNbS94azluVXJLcE5qaW5zZ0lzS0h3RmJraUpmVkUzMkNLaWQ0L2J5?=
 =?utf-8?B?ZnBmb213VThWUlJVaFd5TzVxZUEySk5CWHR3Q0lXS251cDlLa3dtV2ZQQkZI?=
 =?utf-8?B?Wk81Wkc5aWJxRFF3d2VMblBBWGtxSE1HMmUydWRuai9NKzlUd3VTZHBNL0Zw?=
 =?utf-8?B?TTYzNCtnV1FBRk1CUHNyMWJZaVNweVBFNnY1b29oN3pDSGl2U0FPcWxHeDR5?=
 =?utf-8?B?cGJka0M3MkpYempURW8xdnFmTDhyNnIzN2drb1pUSlA5NHpqNUp3ZjlxVGcy?=
 =?utf-8?B?OEJaSVUySndFR2MwSWR5dS8rVG9oeHBKUTd1YjE1ZWJwcWJyR213eG8vVDY4?=
 =?utf-8?B?clNNVUNCM2pXcGNvMDJET3dqb1BObldobEp2NnF6ZmJXbUVKVDNmampoWE0w?=
 =?utf-8?B?ZEoydG5wL0dSNXFlVExVZ2FKbEcvQkk3TldKZU1OUXlvc2Vzdi9WZlZ4SUVy?=
 =?utf-8?B?azhMN0FId3VtSlEzQ1owQ0FQcjVIVlFacnM5aTJtNy9kTjZWWUx6ZTV3QUJT?=
 =?utf-8?B?Uk5hWmtzb0R1R3JJSXgydURPSjE1MERicUV4TVF0MUlpa2Vja2g4d3lNM2M2?=
 =?utf-8?B?VkxKbUFSc0RDaGZFWGd5MGc2eGVHOXF0QlNKTnlmaWtaVlJVcEZMT1Q2Y2VW?=
 =?utf-8?B?RzZJMzgrVHRTREc5VjViN01QcnR3MDk5dmZRbUJpcHVMUFRrZnVUKzd6bkpM?=
 =?utf-8?B?Q2hCTW1nVUM3S09SL3Q5cTRzUng5TTBRaXVjcUpvZGlhQzZvTXJCdmZTNWo3?=
 =?utf-8?B?NzhqNGIrcm02Q2Qya3U1OWlYOWNmQnVTajU2VjluSlpQN241VytNNXhsQVQ4?=
 =?utf-8?B?djJ5VkVZUDJvbWtFMEYyVnRSUUllc1RJWmt3cFBCZWN6b3RoVEptVjRJdHFO?=
 =?utf-8?B?NDFlakhEVVpVWUt1YzAvK2syWGo3MGVFZkdET1NBN3Bac0Z3cWdLSENFK0tT?=
 =?utf-8?B?UVJ6NVN1cUp4N3pCckNtd1R1TnV5RktsZWVmVWhTQnhDOGdabXpqcTFZb29G?=
 =?utf-8?B?QVNzSElZWEZYQ1RpLy9FVkpHaGVtaXlaSVdNTXlkZit4UGp1YkxzQWtqTjFj?=
 =?utf-8?B?eFdpYnlCM09Id0tXbkNZVUd1SFFVdE5IQ0NUVUxIak13a24yRG5MQWsySTZJ?=
 =?utf-8?B?REovaUJRMXJHcGJEOVg2eW9GeXlvaGpYUDlaQisxSmh5cUlLakNVZC9SUStl?=
 =?utf-8?B?ZHh6emg4M3FIUTRIZ3pRbUtkVms3aUlaS3NxRDF1clpGbER2bmhGS1VnWkQ0?=
 =?utf-8?B?cERwNW1wUDMwVzY2VlhadExTVlJPaEJSYU12SC9wNFJjNytnblh1cnk1dVdT?=
 =?utf-8?Q?ap10gPA++nGzXFv34yGATr5zQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9675a2-2966-4048-f25f-08dcef522951
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 08:52:14.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeumhoZeDBJ+c+HsDhySdcezpRFaruQPckyUZ6nTw0Jc6wVZAdx2TQlZnuyeHd2b7N+TWBCeuVSvQdm/fEZ+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773


On 10/17/24 22:49, Ben Cheatham wrote:
> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
> So I ran into an issue at this point when using v3 as a base for my own testing. The problem is that
> you are doing manual region management while not explicitly preventing auto region discovery when
> devm_cxl_add_memdev() is called (patch 14/26 in this series). This caused some resource allocation
> conflicts which then caused both the auto region and the manual region set up to fail. To make it more
> concrete, here's the flow I encountered (I tried something new here, let me know if the ascii
> is all mangled):
>
> devm_cxl_add_memdev() is called
> │
> ├───► cxl_mem probes new memdev
> │     │
> │     ├─► cxl_mem probe adds new endpoint port
> │     │
> │     └─► cxl_mem probe finishes
> ├───────────────────────────────────────────────► Manual region set up starts (finding free space, etc.)
> ├───► cxl_port probes the new endpoint port            │
> │     │                                                │
> │     ├─► cxl_port probe sets up new endpoint          ├─► create_new_region() is called
> │     │                                                │
> │     ├─► cxl_port calls discover_region()             │
> │     │                                                │
> │     ├─► discover_region() creates new auto           ├─► create_new_region() creates
> │     │   discoveredregion                             │   new manual region
> │◄────◄────────────────────────────────────────────────┘
> │
> └─► Region creation fails due to resource contention/race (DPA resource, RAM resource, etc.)
>
> The timeline is a little off here I think, but it should be close enough to illustrate the point.


Interesting.


I'm aware of that code path when endpoint port is probed, but it is not 
a problem with my testing because the decoder is not enabled at the time 
of discover_region.


I've tested this with two different emulated devices, one a dumb qemu 
type2 device with a driver doing nothing but cxl initialization, and 
another being our network device with CXL support and using RTL 
emulation, and in both cases the decoder is not enabled at that point, 
which makes sense since, AFAIK, it is at region creation/attachment when 
the decoder is committed/enabled. So my obvious question is how are you 
testing this functionality? It seems as if you could have been creating 
more than one region somehow, or maybe something I'm just missing about 
this.


> The easy solution here to not allow auto region discovery for CXL type 2 devices, like so:
>
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 22a9ba89cf5a..07b991e2c05b 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -34,6 +34,7 @@ static void schedule_detach(void *cxlmd)
>   static int discover_region(struct device *dev, void *root)
>   {
>          struct cxl_endpoint_decoder *cxled;
> +       struct cxl_memdev *cxlmd;
>          int rc;
>
>          dev_err(dev, "%s:%d: Enter\n", __func__, __LINE__);
> @@ -45,7 +46,9 @@ static int discover_region(struct device *dev, void *root)
>          if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>                  return 0;
>
> -       if (cxled->state != CXL_DECODER_STATE_AUTO)
> +       cxlmd = cxled_to_memdev(cxled);
> +       if (cxled->state != CXL_DECODER_STATE_AUTO ||
> +           cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>                  return 0;
>
> I think there's a better way to go about this, more to say about it in patch 24/26. I've
> dropped this here just in case you don't like my ideas there ;).
>                                                                      
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/region.c | 147 ++++++++++++++++++++++++++++++++++----
>>   drivers/cxl/cxlmem.h      |   2 +
>>   include/linux/cxl/cxl.h   |   4 ++
>>   3 files changed, 138 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index d08a2a848ac9..04c270a29e96 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2253,6 +2253,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>>   	return rc;
>>   }
>>   
>> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
>> +{
>> +	int rc;
>> +
>> +	down_write(&cxl_region_rwsem);
>> +	cxled->mode = CXL_DECODER_DEAD;
>> +	rc = cxl_region_detach(cxled);
>> +	up_write(&cxl_region_rwsem);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, CXL);
>> +
>>   void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	down_write(&cxl_region_rwsem);
>> @@ -2781,6 +2793,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>   	return to_cxl_region(region_dev);
>>   }
>>   
>> +static void drop_region(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +
>> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +}
>> +
>>   static ssize_t delete_region_store(struct device *dev,
>>   				   struct device_attribute *attr,
>>   				   const char *buf, size_t len)
>> @@ -3386,17 +3406,18 @@ static int match_region_by_range(struct device *dev, void *data)
>>   	return rc;
>>   }
>>   
>> -/* Establish an empty region covering the given HPA range */
>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> -					   struct cxl_endpoint_decoder *cxled)
>> +static void construct_region_end(void)
>> +{
>> +	up_write(&cxl_region_rwsem);
>> +}
>> +
>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>> +						 struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> -	struct range *hpa = &cxled->cxld.hpa_range;
>>   	struct cxl_region_params *p;
>>   	struct cxl_region *cxlr;
>> -	struct resource *res;
>> -	int rc;
>> +	int err;
>>   
>>   	do {
>>   		cxlr = __create_region(cxlrd, cxled->mode,
>> @@ -3405,8 +3426,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   
>>   	if (IS_ERR(cxlr)) {
>> -		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s failed assign region: %ld\n",
>> +		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__, PTR_ERR(cxlr));
>>   		return cxlr;
>> @@ -3416,13 +3436,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	p = &cxlr->params;
>>   	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>>   		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s autodiscovery interrupted\n",
>> +			"%s:%s: %s region setup interrupted\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__);
>> -		rc = -EBUSY;
>> -		goto err;
>> +		err = -EBUSY;
>> +		construct_region_end();
>> +		drop_region(cxlr);
>> +		return ERR_PTR(err);
>>   	}
>>   
>> +	return cxlr;
>> +}
>> +
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> +					   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct range *hpa = &cxled->cxld.hpa_range;
>> +	struct cxl_region_params *p;
>> +	struct cxl_region *cxlr;
>> +	struct resource *res;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>>   	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>>   
>>   	res = kmalloc(sizeof(*res), GFP_KERNEL);
>> @@ -3445,6 +3485,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   			 __func__, dev_name(&cxlr->dev));
>>   	}
>>   
>> +	p = &cxlr->params;
>>   	p->res = res;
>>   	p->interleave_ways = cxled->cxld.interleave_ways;
>>   	p->interleave_granularity = cxled->cxld.interleave_granularity;
>> @@ -3462,15 +3503,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	/* ...to match put_device() in cxl_add_to_region() */
>>   	get_device(&cxlr->dev);
>>   	up_write(&cxl_region_rwsem);
>> -
>> +	construct_region_end();
>>   	return cxlr;
>>   
>>   err:
>> -	up_write(&cxl_region_rwsem);
>> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +	construct_region_end();
>> +	drop_region(cxlr);
>> +	return ERR_PTR(rc);
>> +}
>> +
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	rc = set_interleave_ways(cxlr, 1);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
>> +	if (rc)
>> +		goto err;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	rc = cxl_region_attach(cxlr, cxled, 0);
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		goto err;
>> +
>> +	p = &cxlr->params;
>> +	p->state = CXL_CONFIG_COMMIT;
>> +
>> +	construct_region_end();
>> +	return cxlr;
>> +err:
>> +	construct_region_end();
>> +	drop_region(cxlr);
>>   	return ERR_PTR(rc);
>>   }
>>   
>> +/**
>> + * cxl_create_region - Establish a region given an endpoint decoder
>> + * @cxlrd: root decoder to allocate HPA
>> + * @cxled: endpoint decoder with reserved DPA capacity
>> + *
>> + * Returns a fully formed region in the commit state and attached to the
>> + * cxl_region driver.
>> + */
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_region *cxlr;
>> +
>> +	mutex_lock(&cxlrd->range_lock);
>> +	cxlr = __construct_new_region(cxlrd, cxled);
>> +	mutex_unlock(&cxlrd->range_lock);
>> +
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	if (device_attach(&cxlr->dev) <= 0) {
>> +		dev_err(&cxlr->dev, "failed to create region\n");
>> +		drop_region(cxlr);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +	return cxlr;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
>> +
>>   int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 68d28eab3696..0f5c71909fd1 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -875,4 +875,6 @@ struct cxl_hdm {
>>   struct seq_file;
>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder *cxled);
>>   #endif /* __CXL_MEM_H__ */
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index 45b6badb8048..c544339c2baf 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -72,4 +72,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>   					     resource_size_t min,
>>   					     resource_size_t max);
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder *cxled);
>> +
>> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>>   #endif

