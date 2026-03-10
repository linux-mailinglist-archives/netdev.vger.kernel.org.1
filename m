Return-Path: <netdev+bounces-266252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJKOLMhQsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:11:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1707E255516
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB6CD303A92F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC53C65FE;
	Tue, 10 Mar 2026 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sXOShCOD"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7E23BCED;
	Tue, 10 Mar 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162614; cv=fail; b=rUzpZNvgfVpRZpLOI0fsc/ZdwTTT85Mx22/kj8+FoYyIcNhcSV0pdGdTUuQPRsdlI65BntLJuAubF/YWCOurlnVOtL/TnnjCNgbEkvECVJwNb1JHe7UVjXxhxpIz1Cdr7Jpkd2MlUGSkBGy7YQZXsTXVPythhX7agGcwuktIxfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162614; c=relaxed/simple;
	bh=ngt0yEIRauyscoB8fsQSkDURhR2mIun6WHg3scseUOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=McvcmwlbDdWkJEeta1VVthGpGotoe35mOYO/TdzQtj0Cy7v1XOR6XW0xaHhX7702MmS+PrXZvZ92V7KVVps7dnW/wRr97mEsP618MUI0WvwY6zhWuE3urAE8Nqjq48cx9G9vB1J86ID++rUl6E9EuBhUblWj8ZUKy4pk+bW1uIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sXOShCOD; arc=fail smtp.client-ip=52.101.57.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjBNQ/CVkVomg7ygyVvX9ithyr+UEp9cIzMdUdHN+j8dH6Ngzp5sHtkJUADubSOC+2CU7tkIhOZT5HuzdwJpVTrgpCovOncTp3LScGpxDVUqFlEXyzh2lMBz+Eavu4YhGH768u+F1Slz5eGZTyM+6/pTos00qmu5gFJbFKdRgo/MAoONAiGea+PzIspWUOaXm3vJt3H54iWBcmVf6hxdU5yknuOR8e85dGErrOn4C67um1gSU4PL2EIL7SJE/mSLR4sGB2Rs7J32f0+rUNXzetbfskzISk5U5AR8colZjivlf0bfNJC0ZBn3y0+c9X/zj7hhZNPSvKfisiJzZPJhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sc+OFQK5EUEmZJBvSVD0WSIrPqcgRLr1D3RKPuxVu0=;
 b=tTJlisjIkK6d5e9ROQAW+jQWw2v2wktOk6Z1bp8Nw342mrZ30Vm18UxnI2WMQxuGPwSBfgSt84ix1Kh4cJdjYTDjCtTUcT4Zy1SRLI6Mjyu+2TLp96hiO1xcBnjAYKWAL0s7W6rgwN5Yg9eLhhXNoo+4/ufzIu6PbzwIzHvqapH6m1C0UVUFCn7t4aXHcsv3L1YnI9vRmLBex8QlWvbtG9wLihW4ktBXlSFUhnJ4aI4cXYCJH6DXsxr/z6ycpSKLrC3rP7UpuYLqAow47s6SspviTYQ0Toygf5MpBC/s7rcsFI99Rd5OUXAz9WS2dshpPlaBhaeQYjg2FIfMOdiOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sc+OFQK5EUEmZJBvSVD0WSIrPqcgRLr1D3RKPuxVu0=;
 b=sXOShCOD9KTIWrd0ia3rmrKQ1VbQzmawW1l6BMlARQ58+xJ9QULny2qFJ3TsFJmRqJLnS08cwhaY/IpDVtY9qBn7ACamTpIjV7c0h+SS6Nk2ZUYTOoeYxDGWwurvVCKmbHXMocz3h7rtYOrxzYzdeDhrSrrRKcCA3SqhsyRdVTQ=
Received: from BL1PR13CA0321.namprd13.prod.outlook.com (2603:10b6:208:2c1::26)
 by BN0PR10MB5077.namprd10.prod.outlook.com (2603:10b6:408:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 17:10:11 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::1d) by BL1PR13CA0321.outlook.office365.com
 (2603:10b6:208:2c1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 17:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 17:10:09 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 12:10:06 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 12:10:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 12:10:05 -0500
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62AHA1f73471650;
	Tue, 10 Mar 2026 12:10:01 -0500
Message-ID: <b6457298-12c2-4f13-9704-c0b46a34137b@ti.com>
Date: Tue, 10 Mar 2026 22:40:00 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix rx_filter
 value for PTP support
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Michael Walle <mwalle@kernel.org>, Nishanth Menon
	<nm@ti.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vignesh Raghavendra
	<vigneshr@ti.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, "MD
 Danish Anwar" <danishanwar@ti.com>, Vishnu Singh <v-singh1@ti.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260303075819.3246032-1-c-vankar@ti.com>
 <20260304190156.319df897@kernel.org>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20260304190156.319df897@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|BN0PR10MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e0a6d2-e0c3-45cc-ee52-08de7ec7e288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KZrUKFYu6CpRk59C4rDWDe69CEwN4UoxIyEYt4ypTb40uhytShEWMn33E/GWCWPv4q5cK6f+b5wSe/4tLHZGleY1B0MkA3IOSJWdIF8RkxPGyuBKAlndXfwYmIBz7iOJ7jF5ImDzIrZu8OsSjnwbvM38lfwy0f6mp2ulR9PCXa/4Rp8VJrnnc/CpJD3VE+WPlnLm6TpnDE+aKA+wdxtInlfRRLkhutW/MvyNt3q1RBLnMbwlAwy72tavfkbi7yuJqtMu1Qx9H3kt1e4Q8MQjSUTWVlF7cvspJP1mZFvRApr/Di3uQJOsQWNs27JZEWxq2kEPPpshj7bFnwMQ0SCwk2cihNXkJ0kRu31BoaUxs2V4HywZ84owi6vDIARI3JDuyiIyy0KggDmZQqmGuf5YA0VvNZ+Rtih5ciOc+83NeoU+cUELwukVr/3LmU/d1JOyD1euuIUkUKSvLdBkzh+k7pYEz8/D2TUk2MRKS7Yd4PmJsTRuuruP8+RtNkkTRrAHnxsPR1I6CpUc5ZBiJq+FhWMDkrqECzYufVC58E1aHZhxacGF7Nnya9BAVAMdRkR0BgEJyZ/SLdr3/bWg7B0r9xQlwm6NlUaoTbrPQo8YY+tYVtM8yBaO8MrPahgVsn7+gKjxWun6DY7vCfv/bfcx/pPGCQuM32uDrkygqLVs2OARjjUcLlXaEX3bdMyfUYxeAXmd/7iXP6CVsuXJLNdP+hJtD+2zXdot1wDyiWTKZFIzkcuYWbHBdFoZ6rPstoi21cnmae4PQU/fzQ0pruNaBA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1CHQyfXGBZ2r+Ym9sHY2IbZBYEzpDh/iTTUn3RFdBmWe5h85QJ8p4uJUYa/ahd7g4oLFwZGIsrAVpbzkx8nfkToW7qYTO81AA6asNobURNQrVM2FCX29uibUXNuhxp3IIetPE4t1gSzK8IsgdY2sZCHPfzrXe9seTvMNhJxfLt8RUJoHUIxTj1h01IZn4wlScZP6dqpUV1QZyKsn28KwzR4mW3uEvS1e5o9tWuxb25lrcJgISRmcsLjdbK4Ps5CwUrttnpsgNVMZMtWTm3MYRjtGNgLFcJfFMvMYkNByLO8ToS34of2UM6wJjec/Byx3i/Ugu+uijAaG22yqsQxdY5e05PcEdnOin3DiYr8ckM1k/ExwhLS9Q6Ch51N5eUlnvjXasFYuf3G+y090WnVhlgnd0uC4Enood0tsFJeNuGWMpuQE16O+X16R5Px5vXmL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 17:10:09.6599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e0a6d2-e0c3-45cc-ee52-08de7ec7e288
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5077
X-Rspamd-Queue-Id: 1707E255516
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-266252-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:dkim,ti.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[c-vankar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Hello Jakub,

On 05/03/26 08:31, Jakub Kicinski wrote:
> On Tue, 3 Mar 2026 13:28:19 +0530 Chintan Vankar wrote:
>> @@ -1888,8 +1894,8 @@ static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
>>   	cfg->flags = 0;
>>   	cfg->tx_type = port->tx_ts_enabled ?
>>   		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
>> -	cfg->rx_filter = port->rx_ts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT |
>> -			HWTSTAMP_FILTER_PTP_V1_L4_EVENT : HWTSTAMP_FILTER_NONE;
>> +	cfg->rx_filter = port->rx_ts_enabled ?
>> +			 port->rx_ts_filter : HWTSTAMP_FILTER_NONE;
> 
> HWTSTAMP_FILTER_NONE == 0
> a lot of code depends on that
> so you can just assign port->rx_ts_filter
> 
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
>> index 917c37e4e89b..595123c155db 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
>> @@ -53,6 +53,7 @@ struct am65_cpsw_port {
>>   	struct am65_cpsw_slave_data	slave;
>>   	bool				tx_ts_enabled;
>>   	bool				rx_ts_enabled;
>> +	int				rx_ts_filter;
> 
> given none == 0 you can just turn rx_ts_enabled from a bool into
> an enum hwtstamp_rx_filters and maybe rename it?
> no need to have two members in the struct for rx

Thanks for suggesting this, I have posted a version 2 with updated
changes at:
https://lore.kernel.org/r/20260310160940.109822-1-c-vankar@ti.com/

Regards,
Chintan.

