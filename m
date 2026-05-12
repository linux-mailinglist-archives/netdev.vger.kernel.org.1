Return-Path: <netdev+bounces-287038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NfNBLL1AmrpywEAu9opvQ
	(envelope-from <netdev+bounces-287038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:41:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C10BD51DEED
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78BE93024FA9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4424A3B6BF9;
	Tue, 12 May 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vlkpQRy6"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA928A3F8;
	Tue, 12 May 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578851; cv=fail; b=XaHYQbqJxx2WeBeeuccT5XawKtuth/F/h+x3mO5rDLV+XzbsuMDHJlJ4zfmfNn7rhKrLEw9WcnhqIgWehgJNeOakvnZdlreHZl4H323F6Ku/mDMRQHxN7V6hgCcrF/XiKlKWrpYZ5dvrhDplL6b7TOFp+83LgDKR635Pp/VMh2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578851; c=relaxed/simple;
	bh=b0B0wPMuMuZ96XUH/hwkC+HhF4yGAmdezmVNxq4cJGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HcKmc/AcjWQyZUJGMr48bRc7Y50yBifZax3of4rBbAqZo7Y0wJTmWRizJIGbd4xypCI/277zS5Ow4dSBMYITllsMl1fMDooDO3NyEW/z6iOXo5kZyNIZqxpaOeW05KQsWXBXSMmmnVwSOUrLrB3LW514yIQp/vHLp28QFjwrNwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vlkpQRy6; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrDBar3SdUR/s8D3q91KQV3Vh78kEUPUZhtA9I/ftwBRXh4IFZcLkzWjuAdH08P/jLBEX+D+mTIwWeZddoM17F+kFLx4t4MJxqiMgG3LkuNdIMFxaSviYqMxp6QLk/Cxq/Q/TfepWJG5f1dWmZv6hYDQEbqYpbRQ8DDj06WW5fOJM7AICebh3dH9j+NdB9uiPe5eXdpq/xwa7IPreWz2bxdWePxeFYwPp3rjT5JHcT3QIBFlnqShmXc/1y/O+NRsX0rdbpbmmgSWYA3ZP2nmWovDcw4mvhmCkDLy9s1baJCoAfx7r2vvxgz+pOnjePbXruktHSbgiGDzqZ7Y/YhXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peE4IcDbXY9F4wtUsC9WhQF7W1PjKBnz0AgPBFJR+Bw=;
 b=QrZSMpGLTMa3DbLYq/+7d0SlEIPwyQ11CKOxp6h0a3xCiX/GjfWF6TiSXlHmLsIOlmQiEQA0IeUEjM4+sINmhPr7fAYIGLCf4noL+GRt+byxLQ+mjwj8WUxwGoFBjn8HqlGxZrwl7zuPU4mit9FqkB/QzBV3HqKInHeDk1PnPxXLEij8zFXxji+UQ/KEE0CHZxUSz+suNM4WAvOsDboBRGxWx9JX6SB9EtDq0LNVSAHsJswCO7e6Tt5cQuJ+CdI8uRytOoRjs8VSD4aIZkDOI/DzkgWQ+kHslt+MgQaEmPoCTBLDb1zMr6en/fTsq1x2VkmStR9m5ennuoaYVmF25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peE4IcDbXY9F4wtUsC9WhQF7W1PjKBnz0AgPBFJR+Bw=;
 b=vlkpQRy6iuqbUF3TYTyvGNdR3UyCsH+qPuMpSA9E+i54DSpJ7PWzAu0xWDNypzzFroRxGzvAGOvlX606iUSxZvUpOqUaLmV427EIs4NnuNF8M3AZsGjngTuRAJGO0+Oo0GTLaMcEmcggDZVyxAC+3nJ12LaAsIyj6TvMPCZHxLo=
Received: from CH3P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::18)
 by CO1PR10MB4804.namprd10.prod.outlook.com (2603:10b6:303:90::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:40:47 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::34) by CH3P221CA0019.outlook.office365.com
 (2603:10b6:610:1e7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Tue, 12
 May 2026 09:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 09:40:44 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 04:40:44 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 04:40:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 04:40:44 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C9eblj1179617;
	Tue, 12 May 2026 04:40:38 -0500
Message-ID: <6a1f411c-d7ed-463b-abf1-277d8cc0c184@ti.com>
Date: Tue, 12 May 2026 15:10:37 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ti: icssg: Derive stats array lengths
 from ARRAY_SIZE
To: David CARLIER <devnexen@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Roger Quadros
	<rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Jacob Keller
	<jacob.e.keller@intel.com>, Meghana Malladi <m-malladi@ti.com>, Kevin Hao
	<haokexin@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
References: <20260512060627.3781329-1-danishanwar@ti.com>
 <20260512060627.3781329-2-danishanwar@ti.com>
 <CA+XhMqykBWcMdk+iNnOtUxM4MX6jpDyUwfuAVZFbjAShO9_v7Q@mail.gmail.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <CA+XhMqykBWcMdk+iNnOtUxM4MX6jpDyUwfuAVZFbjAShO9_v7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|CO1PR10MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 95725563-dba7-4401-f5dc-08deb00a8a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qliQV+g1iv50Bhs6QymB+nhUqXV7U4tioPtB+rtcRA20ZVkrz3Xc4NOeCY22c6jybTBLnFo+hrNAkpZOKEdwOWe1hCb8+UNts4fvIXZI9HN1+SY8f0JpCM35eeIsfdX35tIGQgwOwIwRKj+bYKd/BYoo33yCzilQsRKKIDbbkcQ+7x+MDHR2HF5BWBlAS7FSLku4nPadGLmCgp56xWTvT6iZZjBCACDSU4ylhCBzI+SuflAtbljdr3FlGfI1uy9srvV5fhxu+z1WQmZAri8WEhfLoz3oCChlwanE7yXxJXwQvbNAHZ64zs/QEG9yxGwq1IGLbMZ8GEe9Suza6em8Ya4tx4SGS3XCm5fXD1CDNI3a7dmUkwnHGuYbPwofwQAai5Y8Uy1wEDP2r3RShtvcUEpzzh/cRxHg1lYCUEF3g3RcD7GDNGTyVDxuTlZj5kqoXTiSe59RxpLbKWmRF6wWlRPkuLdKF/Sj7niFXDzcenn22aUzQjq17bYWOh9b3qXZarkNWiI3ntKSDu6GD+lj6KWxPs9nbeTteCNATv3VZgrzG8358mKkz8uErknR1nSnb4FPKo+1Cr6Fqj/8SeWVVDPkLGTfWdTE2a1m4M4jNE8G5lCleLHqc/zpKMvbV0uigvChc134luJXTWZYJq6ldgf8BdDKfnRt7Euip6tQipjNctvsMUl+1O6IG6Xfc+t5
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SXsDK1hGUber3gTqBg4IZ618FhfJJ7ypPPhIMnrFYJQY9YqCj9RevWV5aQ3zol+FrdBEWL+GP0eVepjnegkkJTOJ8fHcNy9qaR2DbsZoirmlZ0OEbh1aqcEm8ghyEUA/ypD1K3wmHFNRq59YYCLKrafRkPcJ6m+l7BCSvAUc5avnlFqEWnDu89fGOaikhd2Qw5XPJovkh8vzWD9L2MlgaoV1xnx+ugoycavdrQtBAg7NHR9j3n+HtAcj7THfcXZ7CekhbwrOJK/HzcxjCPOOYzDMDh+q7aTeMQSx5VO/7pW1B6aswORUaK5hpjP4eSu/vHWDswEIPEVxSslC53NDBD+T1A36VffypA0rp/RlMTqKBaLHG+3yEK769boZDx4Oqkg/qkoLQbqi5y+GflII0esItK8GQP/S4DLIhSVo6U366Uw9F7L2gyb9v/xjyTF/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:40:44.8323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95725563-dba7-4401-f5dc-08deb00a8a47
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4804
X-Rspamd-Queue-Id: C10BD51DEED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287038-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,intel.com,ti.com,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Hi David,

On 12/05/26 1:28 pm, David CARLIER wrote:
> Hi MD,
> 
> On Tue, 12 May 2026 at 07:06, MD Danish Anwar <danishanwar@ti.com> wrote:
>>
>> Replace the manually maintained ICSSG_NUM_MIIG_STATS and
>> ICSSG_NUM_PA_STATS constants with ARRAY_SIZE() expressions derived
>> directly from the corresponding stat descriptor arrays, so that adding
>> new entries to icssg_all_miig_stats[] or icssg_all_pa_stats[] no longer
>> requires a separate update to a numeric constant.
>>
>> To make this self-contained, break the circular include dependency
>> between icssg_stats.h and icssg_prueth.h:
>>
>>   - icssg_stats.h previously included icssg_prueth.h (transitively
>>     pulling in icssg_switch_map.h and ETH_GSTRING_LEN).  Replace that
>>     with direct includes of <linux/ethtool.h>, <linux/kernel.h> and
>>     "icssg_switch_map.h".
>>
>>   - icssg_prueth.h now includes icssg_stats.h, giving it access to
>>     the ARRAY_SIZE-based ICSSG_NUM_MIIG_STATS and ICSSG_NUM_PA_STATS
>>     before they are used in the prueth_emac struct and ICSSG_NUM_STATS.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h | 3 +--
>>  drivers/net/ethernet/ti/icssg/icssg_stats.h  | 7 ++++++-
>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index df93d15c5b78..e2ccecb0a0dd 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -43,6 +43,7 @@
>>
>>  #include "icssg_config.h"
>>  #include "icss_iep.h"
>> +#include "icssg_stats.h"
>>  #include "icssg_switch_map.h"
>>
>>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>> @@ -57,8 +58,6 @@
>>
>>  #define ICSSG_MAX_RFLOWS       8       /* per slice */
>>
>> -#define ICSSG_NUM_PA_STATS     32
>> -#define ICSSG_NUM_MIIG_STATS   60
>>  /* Number of ICSSG related stats */
>>  #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
>>  #define ICSSG_NUM_STANDARD_STATS 31
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> index 5ec0b38e0c67..b854eb587c1e 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> @@ -8,10 +8,15 @@
>>  #ifndef __NET_TI_ICSSG_STATS_H
>>  #define __NET_TI_ICSSG_STATS_H
>>
>> -#include "icssg_prueth.h"
>> +#include <linux/ethtool.h>
>> +#include <linux/kernel.h>
>> +#include "icssg_switch_map.h"
>>
>>  #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
>>
>> +#define ICSSG_NUM_MIIG_STATS   ARRAY_SIZE(icssg_all_miig_stats)
>> +#define ICSSG_NUM_PA_STATS     ARRAY_SIZE(icssg_all_pa_stats)
>> +
>>  struct miig_stats_regs {
>>         /* Rx */
>>         u32 rx_packets;
>> --
>> 2.34.1
>>
> 
> One thing that caught my eye: icssg_all_miig_stats[] and
>   icssg_all_pa_stats[] are 'static const' arrays in icssg_stats.h with
>   ETH_GSTRING_LEN name buffers per entry. Right now only icssg_stats.c
>   and icssg_ethtool.c pull them in. After this patch icssg_prueth.h
>   includes icssg_stats.h, so every .c in the driver (classifier,
>   common, config, mii_cfg, queues, switchdev, ...) ends up with its own
>   static-const copy of both tables.
> 
>   Would a static_assert() work for what you're after? Something like:
> 

While adding more stats manually, The ARRAY_SIZE() approach was
explicitly requested by maintainer [1]:

This patch is a direct response to that feedback. static_assert() would
still require updating the numeric constant on every array change. The
goal here is to eliminate the need of manually incrementing stats count
whenever new stats are added

Your concern about multiple copies of table is noted and valid. Could
you advise on the preferred way to reconcile these two requirements? I
am happy to restructure if there is an approach that satisfies both.

[1]
https://lore.kernel.org/all/20260112181436.4s5ceywwembn674r@skbuf/#:~:text=Can%27t%20this%20be%20expressed%20as%20ARRAY_SIZE(icssg_all_pa_stats)%3F%20It%20is%20very%0Afragile%20to%20have%20to%20count%20and%20update%20this%20manually.


>     static const struct icssg_miig_stats icssg_all_miig_stats[] = {
>         ...
>     };
>     static_assert(ARRAY_SIZE(icssg_all_miig_stats) == ICSSG_NUM_MIIG_STATS);
> 
>   next to each array, keeping the numeric #defines as-is. Then 2/2 fails
>   to build the moment a new entry is added without bumping the count,
>   which is the case you're guarding against — without touching the
>   include graph.
> 
> What do you think ?
> 
> Cheers.

-- 
Thanks and Regards,
Danish


