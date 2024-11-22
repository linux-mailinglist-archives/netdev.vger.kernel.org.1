Return-Path: <netdev+bounces-146855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D89D6505
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C8D280C42
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ACD16F909;
	Fri, 22 Nov 2024 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k8CKY1TA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FA187855;
	Fri, 22 Nov 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308332; cv=fail; b=eEp3lNyUSDVdYWZIZ8nRg+D1IPLq09J4MZZT0spganU4bMv7lOqPasQK6jJaImsaL2MglYNjRyNc10IddDwaW6A0M2F9r0cSGtBuvB38t0pBf1HZzQb43dAoXv2UtjQ8K/y2e6RjY2NiYUUiOHrkpynb4SJ4mq/gwksHo5Yn8Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308332; c=relaxed/simple;
	bh=ETVbxUkTU6yrzPvEMEhvgw+H+jzUrt0LZ88cKqljlSs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ipqOqVwnCPq4HSlybmB8tNx8kPLF2w5S89hHOOZZMl4Od1pXwF+c45K3ygycojmLCrd/O5Fkxm4lCnLWBd2Z6xa0uQfIp2mEGy1M9YCm5m5h1a4KnYZRdf8NY9zPVgIfAXdSI4NE+AqpTOeH/T91aeM3dcbcGC/31vir4xCIJV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k8CKY1TA; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1RVJ4QsngvDYSeYFk8Qf4yzy4oU7pTs+5LTc/763+U2MS9dOzA6nL9yj91ZhPKwgH2vzf2EdpFMreDtzQcKCAE4op9+r1L//uAUTSqDGe7DBEvFVT9jP79HRXQGkyxiFXV6aTFM1N2oFziu9Y1c5x4CHFrSWupKFw3d53qzAcVZYrItgM+gpz87CUjCVwBi0mhR9uue9RohGSTuTiPTvFgpkKXiTnh00bMbpjtmXdrmvJfs/HDK4SLHwRZCF7HtZ/k1EG0J8MYV2fBrRZrLpwHY37Bob5K94h/lKiqZmEQPX2oGQVI99HRuRa+BzOL7kxPswzZjYd8aM8kJD230Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGLHsEbDhvtsavkw9HodHY9z+6J5KBEOoROqOjY742M=;
 b=dSCn0Jy8InU46wUFnTpjkgX0tLa2rcKMLw8xOPqCVyeVkGymk1dkzQz7dyL172EzvFCJgQWLavfub4EaokVaB6Hihsl6gxr0TGtjiH/zoEob9a0Ny9EkN+pmaXFyOAiEP63Z324N/efpoURxQV9Mb9zUOC/SLnBUuQQUFxI1hzvtd/Pu/AIjXUOV1phwr4gEkE1j3gV8DW/Mh6Ifle3tygFqlsWVnGEmeVBHMyG+d6cYrAYt47U4xN9bfwhdgysoIIc8wTTmEGT3n9edfu2AcJ0in6eushG+Tg66Yb4KZgeDwhdflMqTENddT90IsfdRMth8rnqduL1FAQOsw9N87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGLHsEbDhvtsavkw9HodHY9z+6J5KBEOoROqOjY742M=;
 b=k8CKY1TAB/Tcn0t/XSJHMwBEM/dg/gfqBcGbWx3tWqEjFsy1UaO3PH2mwiPv8qrhMNcl+SjhJbZsDk83ymY+bOyfQHgbaY+pTwPnPpLHx+LnDdgU2WJrL0kzXW29UGvG8fHkNlN9fxE4hZkMW1LyeguoxNGT+Su8TIM0qR/kxKY=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 20:45:22 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::f9) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Fri, 22 Nov 2024 20:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:45:22 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:45:20 -0600
Message-ID: <135eaf81-8f2a-4a86-a227-eb6b5476ee50@amd.com>
Date: Fri, 22 Nov 2024 14:45:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 11/27] cxl: add function for setting media ready by a
 driver
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, "Cheatham, Benjamin"
	<bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ae3233-c384-4d0d-5c7f-08dd0b3695f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VExoN3d5NlFMWXluY1JoQ3g2cGh4N1FGV1lwUEZYUDBtbkh0azhDdkhIemtl?=
 =?utf-8?B?ZTFaQTlyNkFFQWxIQUpMQWhCQ21oOUN5NlFSck4rVXB2REllWENKN0U4dzg5?=
 =?utf-8?B?S0QxeDJkdVZ1NFRVOE5EY1RicjhvTE5CeVNsSHEzQTdwYjg5K0phNTBUQzMx?=
 =?utf-8?B?WjJZTXBieE1LdG9pamhmRWV1bmhXR1h2RFd3bk5JdWQ4S1NvRVh1MW5nZEVq?=
 =?utf-8?B?OWVhVVBQaFdab1REcGJSa0kxRjQ1QXVPbmFEUGJtQktFNmxIREpKcGdHMmpO?=
 =?utf-8?B?ZFhrTkR5Zk15S0JJeXh3NHFsd2tXVi9DM0pwTUQ1bUlUZ1BjajNBa05HZWRk?=
 =?utf-8?B?T2oveDdBSk5aeGlrOExuVkNlRk9IaTBVNStuYWJhYSs4TDAvK09vbC93aGs2?=
 =?utf-8?B?ZVpqaUltL2RKNXlab3hPNFFTZWhMS3RkeWhpUW5zSUlCOGxKTTNNbVpzVE1T?=
 =?utf-8?B?MDVUUlY0YTBLNFZMZC9PSk0xYmFNNFZJQm10UDhtS1ROdFAvVm91d2ZJNDVC?=
 =?utf-8?B?QlhRang2cTVVSytjVis1UlRwVk8rTUgycEFOWm1SeHhsekYvTmNFa2YybmZl?=
 =?utf-8?B?bDA2c2ZYM0dEelIvWGlHQ09peWxtZ0s0M3ZQOHB2NHZKZ1NLaFh1YU5YNmZj?=
 =?utf-8?B?Y0RHSkxPdmhhejRwc1BDK2kvNGY4bnAzb0FEa3ZVQmsydGFhKzhWOE5qN2ly?=
 =?utf-8?B?cnlPeE5nZTE2MnpqcHNjb1l3blRqSjlHTHRBV2ttNlFzMXFPbXpzdklSR2NL?=
 =?utf-8?B?UWdSZUVCbXQxMENCeEJFbjUwUWJJTGFtUXZRM1JsMUhTNW5RRDRIbXNmSmcv?=
 =?utf-8?B?c0Y1MVFxQVFBQ3VYSGNkQm9WV0VFZlgxbXAxMTZxNWxzS1BVUEUxUVRHVXZX?=
 =?utf-8?B?OVZSRHpUMDcyNW56cHJ5d25HaldITGVhYTVjcStWTDlFMzFjWWxOOURicVJz?=
 =?utf-8?B?VlM1VXlQRUpJaTRrNHpiZjJjd2VDNlUxMk5CTk1ZRm9VN3MxajhvMVBVaWh1?=
 =?utf-8?B?aWFoRjNGRHdYOHkzWDIzb0drZ2cwMHhNTS9IZEppWmtQcWxhSURUNk10TmlQ?=
 =?utf-8?B?SnNVVGdHdGFaQTZnV3lYSWFDeFVpMDJCWHZZTVZEcWJZRWxrQnlUWTQrNFNl?=
 =?utf-8?B?Sk11Y2p1eXNhTG96V1RUYVFDTVp6cHREdlY2QnJTVzJsZmpmN3hzSmlkZWdj?=
 =?utf-8?B?dXNoUkN0T2ZnT0EvVHpYZGJkbk9VKy83YmZydnptLzgvNnZwMlRBV3liT1M3?=
 =?utf-8?B?cm44YlBuanhGOHVlSXNzTTEwTWRtNDRWbmxaZjRLUEM4R3BxL05SazUvVDll?=
 =?utf-8?B?MDRFMzFUL1ZqTE9vd1JZVklvRWgza1FFRFdhRFp3RWVzTUZCRDZmRktURVRH?=
 =?utf-8?B?bUU2UHpTNXRmeU1NTm1pdm1oQXlqeUkwOXBQT0FaMTV0QmIzUkRyVnhiNWV3?=
 =?utf-8?B?aWJ3WkdEZVNocnJwQmNXdncwdVB2SVp3ZjVhTHVueUVIUjBueDRicWtOeWJX?=
 =?utf-8?B?YlFGUUpRUHMyZlBqbGlBMHFWT1lPK1JaSkI3STdvZUxDN29semRTQUJXcUVL?=
 =?utf-8?B?Q2FlcFE0eEdtbm96UW1MbG9CSnI3eWxCVEl0ekl5SGVlTHFMczlyRXVWaWdk?=
 =?utf-8?B?ZXpZWHZxbEFnUzNuYkFlcWZzejdTakhhK0VZbWZuRk5MMmpOeWNDeVM3SmQy?=
 =?utf-8?B?TDN3S1RvV3RpTzRML3pGZXpmZHFUTGFJbzgxQ2hKR2hiYm5iZjJYektlS0p2?=
 =?utf-8?B?L3BpYi9JV2F4WkNWWDcyZWRUZDFxNEROS2VhVVZwbjJPWElnWFNGbjhYUGls?=
 =?utf-8?B?TEMvcGpPUlVlVzJHTC9hZC9oR1g2MWFURzU1L0dGTnZDbHRmRUlXTU9XWWtG?=
 =?utf-8?B?ZXF3U3NwNStCK1l2VnRmQW9FeGRqREgvVFk0RGdYUkJMYy81WlZxUER5dE1M?=
 =?utf-8?Q?H0+XBlFHxaOPdA//62FnxqwKDvxtEGor?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:45:22.7656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ae3233-c384-4d0d-5c7f-08dd0b3695f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A Type-2 driver can require to set the memory availability explicitly.

Little grammar nit, I think "may be required" reads better. I would also say
why, for example: "... set the memory availability explicitly due to the
possible lack of a mailbox".

> 
> Add a function to the exported CXL API for accelerator drivers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---

Actual patch contents LGTM, so regardless of nit above:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

>  drivers/cxl/core/memdev.c | 6 ++++++
>  include/cxl/cxl.h         | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 7450172c1864..d746c8a1021c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -795,6 +795,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
>  
> +void cxl_set_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	cxlds->media_ready = true;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index e0bafd066b93..6033ce84b3d3 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -56,4 +56,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>  #endif


