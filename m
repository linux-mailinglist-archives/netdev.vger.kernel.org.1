Return-Path: <netdev+bounces-98087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F068CF447
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 14:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16781F21234
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C353B669;
	Sun, 26 May 2024 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="beE39NXY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC679F6
	for <netdev@vger.kernel.org>; Sun, 26 May 2024 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716726952; cv=fail; b=JvA0AT1mzw0lqAis/Yfy24VjtlfcinIo4mGqz5f+UjM3wl68jVXeqjSKYiZ/r9Bq8sS/HaqPVStNmnsU4Yor5riEn1ZHC8+5wu2RjNFcd7xkcnfcYnZnYggEamC4LcVu6NfBZfE4C4PJvxVSvYZ2/Ddw6MseEte88RAtR5XBzEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716726952; c=relaxed/simple;
	bh=SMbTq37bmNpCD0hltgucsLCNbxFluqSqIXm/4YYBQP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lz1cQaySyaXuR3KrIg1YecnOorUzR+usZGlxxncgu3fxW1JQjRlDdPJ5SRz0tX5Plw/eIz3FVM6CQ92qzaYbIy+FuOaZC6qMtiymxKROOpOYcRFVJwHHF57bcWGqSTNjSuWRWZdOChSlG3AQsAfkPEGb8GDyZ0c1GRi7o5tObHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=beE39NXY; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJFY7cRMKN7+aOG8PN6RKu/AfNJtAnl/SxAlPoCR1VzB5lqkMyLcdgiLhUkX/Bg/4kTqFDVEFYc6B5EagieGQFjhuXCudt3gkpW9oubt2gJ7yz6tUotJU14xXVuHIWj7fdEbdWuolZbP6tH3NZEUhiP+He4jhr+CDi77JETTrf7xH+n81lJGnkIO/BN9VAPavq6X66wjwUTCNORpNDMfsI1AERk2QvVxRjxUJr3Ufk8S/WSBdemKCGBX6GXaYGh3YHFl/bHtwTjXjiOZL2B+raay+rGctQJVUdToC4Iz9j/1l3Q1w7rIPuInWMn6ZHdbou9VhvszXVlOav1rUgEyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZP+bwVw7xOtRNDMpZNykhiPSGMiB+FcTTxfKBsIgN8=;
 b=ReJixrNkPi9EeUK3jwm7bMfmW+4WahWgk+E4LZkZ1p6jVw5GV9z6mZVni7Dan5/5v11ARvnz9mXJDDz5d6hFncJtnQWl40sCpzZsUdCrFIC7aH5QAWGK+XqJx4mZWhY7LjO09wH75hUEPsr5HAELzdcXNQ/OFszQBIM5VN0sZiz7r9ZcFBQUguYyOwP7QKIkYYj5L9eTZET/CKe1hwnIY6BFAvlJj3C4+8vMSvZkFn9S5fIjqxp8SGZwYBnFA9E4ANRb2mX08ZutTSosAjr7Tzgi/6rEx7syHY+hqlPFGudfOKM7UCbKQ2X4oMKzdZ/pERMdzHtT1KxGIFrVrVPbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZP+bwVw7xOtRNDMpZNykhiPSGMiB+FcTTxfKBsIgN8=;
 b=beE39NXY7IN+/a5qN1/rGODDEamBivk8Mraz+qOnd2nnDqh7tAz8rxWl1oVpJzFNtP5Jm79p8FF+O8xnuywYa3wwTUYEoPQFh2gKv2wuyN0W6tjVft1FRa2c5efT9fdy+FIEbvTnHShtsdfpvNhHF4p1tS2TJw0ntiPq82qtWwQN0d1+LywsBANrIUswrOi3V9MPowyegjPLHgc2vEdroFQLSDfo6xMnxs98YiMgpnb/d8K2UlO3Xzd7sfwfg08YyS+zTu6MeqFEZ0yWU6bQIuGQi+w7lmHtNNJ+bUIdszjtRNlJxnfRxM3/OdqVEVqKs074B2MpvbkzBJfejOeKnw==
Received: from CH0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:610:e6::17)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Sun, 26 May
 2024 12:35:47 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::8) by CH0PR03CA0282.outlook.office365.com
 (2603:10b6:610:e6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28 via Frontend
 Transport; Sun, 26 May 2024 12:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Sun, 26 May 2024 12:35:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 May
 2024 05:35:42 -0700
Received: from [172.27.34.245] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 May
 2024 05:35:40 -0700
Message-ID: <c51bef25-e8c5-492d-bb80-965b7f8542f7@nvidia.com>
Date: Sun, 26 May 2024 15:35:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic triggered while removing mlx5_core devices from the
 pci bus
To: "Berger, Michal" <michal.berger@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, <moshe@nvidia.com>
References: <PH0PR11MB515991D1E1AB73AFB7DCBD03E6F52@PH0PR11MB5159.namprd11.prod.outlook.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <PH0PR11MB515991D1E1AB73AFB7DCBD03E6F52@PH0PR11MB5159.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8a5a94-92d4-4437-38c4-08dc7d805e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmV6K2hScFpVY2UzMWVTbVhKYTMwRDJyNUlUQTJnRnVoQmJuUVhTM0Mwdy94?=
 =?utf-8?B?TGdNK1I5SVN1YkM2bFMwQU8xRTVOc0ZVMVpQLzMzZE01S3ZBVkpHaHNHbURx?=
 =?utf-8?B?cll5TExIYndJcmwra3lPbEZ0RkJNZ2FENHFDMkM3SkxPcVZGRDF0TkF1T1hS?=
 =?utf-8?B?U2dFRDIxWHpGcGNVYjFNTmNmNHVFeFJ1THdwUzJSRlRodWQ1MlQya1F6NVJB?=
 =?utf-8?B?MVpReGd5MW4yVjZ2eCt1Szdib2xudUtGU3N5S0VsVEphWE9zODk2aTl6WnNQ?=
 =?utf-8?B?bGluTGRDcjdLdFQzQUxlZllkWDQyZHp6NjhaaGdUZGNzRU1saHVLcjBFWHN5?=
 =?utf-8?B?YnhucTdJTzlrVTZTTWIvYncwaVU4Vzh6MG84QzltUXl5S1JwMExhWkdMYjlv?=
 =?utf-8?B?Vit1cm5BbVJhbWM0MmhLbXZxVVA4VVF3bzBSTVdwQTRHTHkrbjU5NWZLcm9Y?=
 =?utf-8?B?SG5xQ1VpSHVtYkpGVHA2NDJnd2ZveCtueHdRME1wZmVDdzVoTldiL2M3dXZN?=
 =?utf-8?B?WDk2V2hDaVMvcTFPVXlpZGVrN1lNL3BKNkx6ZGU0S0lLTmp5cUI1YkxsdW9r?=
 =?utf-8?B?T2RtTTZTaTRUanpXdHpubHRkd0FkODdXSWgzU0Vnd3VGaXNLUjRFL1BqVVVY?=
 =?utf-8?B?MWhnREYrYTNJV1hxNWYvYWU2WitiWmtMNms5OHVPTWswcHNxQ2pWNkRxcUJV?=
 =?utf-8?B?NnF1cy9iYVJPRFZBTzZ6TlhWS3J4bFJEeUdteDZtd2MwMjBOUmdSeWQ0d1Nx?=
 =?utf-8?B?c29zM3RaN2pxZ1dyUzZqMEJ0NTJ2YUZJNWMzY0FkYmdpSE0vSjF1d1FENUc5?=
 =?utf-8?B?V2ZDdGhwOVJ6NENTTm01cXVLM2JJVXlzMTVzL1RIaU5Ra3hmTWc3emU5cU5t?=
 =?utf-8?B?SzBXUTJQZTUzYVh4T1BqakU0YzBhZWZmeW5jRzR6ZCtkSkJxSXh3aUVndExr?=
 =?utf-8?B?elM3RU1MeXdzSGJjQVlrODlFL1pLM2VoR2RQQS9HNDg1UkxMYStSelp6YUFS?=
 =?utf-8?B?Y1c5eGdNcTV6Unl2d0dWSXpPNERlMTZaaW9HaG1nSTl5VUM2TEJsNUFkbjAy?=
 =?utf-8?B?bUg4dmxUdEpuc2czTjRDR2RvUW4zVUdvRUlsUm0vZHhuV0RnbFhxc0xKTHBx?=
 =?utf-8?B?N2prZ2tNNnlDMWw5ZzBRem96YVpJVmxSVlZ4S2dtWk80dytyTlVJTEMwM2tz?=
 =?utf-8?B?Tk1SUWZsQWU5RThVMVF4cklSVDZ3VXk1QkNSeUJueDk3ejIrRFFkdlR1ODRX?=
 =?utf-8?B?WnhBS2xyU2d1ekkyeHl1UUVCdytYUWw2Q3FXOHk4RkVNaEVKeWk3MEFvRXM2?=
 =?utf-8?B?MTY4YnRaN2Y3VFRqQWlkZWs3STQzTTJid25sU045QWFYNmFyVUY1UWpRS2t3?=
 =?utf-8?B?enBDeFZpZnZMeGFuZ0ltT3ArbFV6bG9wOUpJQWFIdVo1ZTBMRWZWMHJ0UlJV?=
 =?utf-8?B?TGFMODZNQXNsaFlqelprOVNyUjh0aENEbzFzbE5BaHZUQVBJbTMvNWVhUzJy?=
 =?utf-8?B?b1d6TDVudVRmQ2NYV25Ub2VvVnp2YWM4Z1IrOXA4em5KMWZkRW9LK3pmajFC?=
 =?utf-8?B?OWphZjU0OWtEdHN0RS9mMmliZVh3YWdWYmtCZzFWMStiT3JuTlhReW1aQWF3?=
 =?utf-8?B?aU9PQU5sOStHTjcyV3llc0pKT3VhRDdQVHFxcEVyN1JXNllWZ29xMWZzV01N?=
 =?utf-8?B?MnRFTTBSMXpYUEhGTnp1Z2JETjkvUFA5SGZhTzJLL01pVXVkaWhmS2hCdi9E?=
 =?utf-8?B?ajhrSERneTN0S2d5QjhaMkJQSEtFcDdpaG5iZUViNW5uaXppcnp5dGFzT2Rs?=
 =?utf-8?B?QW5NVURLVWFKd0llVkR3VDNQZTdma3MxVndsRzRmeHY2UEpqTnMzempSU3Z6?=
 =?utf-8?Q?5yFkaJFYwc4ez?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2024 12:35:47.1601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8a5a94-92d4-4437-38c4-08dc7d805e69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

Hi Michal.

can you please try the bellow change[1]?
we try it locally and it seems to solve the issue.

thanks
Shay Drory

[1]
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c 
b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 6574c145dc1e..459a836a5d9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1298,6 +1298,9 @@ static int mlx5_function_teardown(struct 
mlx5_core_dev *dev, bool boot)
         if (!err)
                 mlx5_function_disable(dev, boot);
+       else
+               mlx5_stop_health_poll(dev, boot);
+
         return err;
}



On 24/05/2024 11:07, Berger, Michal wrote:
> Kernel: 6.7.0, 6.8.8 (fedora builds)
> Devices: MT27710 Family [ConnectX-4 Lx] (0x1015), fw_ver: 14.23.1020
> rdma-core: 44.0
> 
> We have a small test which performs a somewhat controlled hotplug of the net device on the pci bus (via sysfs). The affected device is part of the nvmf-rdma setup running in SPDK context (i.e. https://github.com/spdk/spdk/blob/master/test/nvmf/target/device_removal.sh)  Sometimes (it's not reproducible at each run unfortunately) when the device is removed, kernel hits
> Oops - with our panic setup it's then followed by a kernel reboot, but if we allow the kernel to continue it eventually deadlocks itself.
> 
> This happens across different systems using the same set of NICs. Example of these oops attached.
> 
> Just to note, we previously had the same issue under older kernels (e.g. 6.1), all reported here https://bugzilla.kernel.org/show_bug.cgi?id=218288. Bump to 6.7.0 helped to reduce the frequency
> of this issue but unfortunately it's still there.
> 
> Any hints on how to tackle this issue would be appreciated.
> 
> Regards,
> Michal
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
> 
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

