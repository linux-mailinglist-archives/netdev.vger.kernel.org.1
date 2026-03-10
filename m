Return-Path: <netdev+bounces-265959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LHODuXjr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:27:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7742485D2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B2D430480C9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB3D43D51A;
	Tue, 10 Mar 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xfJRfuF+"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBF43DA42;
	Tue, 10 Mar 2026 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134664; cv=fail; b=Lk/8A0qHdNFc6433SevMQ+momU2h4kxhA2XkPORx1FdCVLeaHju2mo9S/FJKnBnkgIjoXoEaEnAfBRrhpiI+FuUkKdSobQtJcEa0qGws0dkurQbCwmwPVrhQuRfI5RXir8UoZR9UIFuUvlIx+5036WUHxs9st4jjGR9CayE57RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134664; c=relaxed/simple;
	bh=qoRR4DJzn2iJMGxDVA5bcA1XgoPJ/Mmsv4Gf4iZSj/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OydM+o+Eh62auRk1fsWMmJsr+nKknWpdqdJ7tIBJk+ldvnZ0grWHyvnMqewB+cUPMJCfumyPDj1woQUmb/wlSxZke0vt3IBvh9mCO/RhF2ErLX50Y4mROln+NOZT4xc0Fn/RawDT9cewv2KUUYJJGIRBIlZwbHsk+sSuwBy1h/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xfJRfuF+; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/3Myw38AKwS/nssj/HmeWsdG3uNp71q1xu/B2/Morngq3NBQ6DmT4RwBbPLwjDXuYWiwNJfmRQVTBq93ckyMU38b9IeJFdG2DqeoWjBmFvdOqy5ukL3zeTEksrNf3yKVfLQfMiPvA/SZ/II53SRuzLe8LZC05Z1rX08LKwlRgPFXRf83siloroRcmtZCNToIIpbtdCFpoQWbSjCvTPLRKosahYPhNOeiaJvwWJOcPhkcY3fb4QkK+/BfjaH0D1GtWptS/ZvVfd1YPxX1iF/Pb3pGiMW52MffL2W//jkjQX7p4b0aTOUX78LSvJ14MHy+/QHCtHryQgeXwARnPteVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ8W5dvFadf9Z9qK1m7f2dU8ylO5v075+Hwm/u21VZg=;
 b=a7jf+FX39XZKBjRJA64gGufJLcZ9Xd0wb0Q0Yimcvra5i+Ya9+EOiYjvzW9dXI7l+fSWgithkTyd0YAo+CgxA12TSuO+bfQa6vzIHss+jB11UJDMQfrJ1CWppa/v+UuOPXSr6pFbGCyH54wFuOmyqo1T5g94tc8PEYBwTb26vsJOzArzRH1nF6i25mZxOZcDY603+0imW9X+Jew/QUiBUkVG3iPe9TZFnVVNiyWLfyUxwfzlYkQytjDYkRjgCtsAVoIhItN+gkfbiX6MHGtQnJZoiqrARN0lccfuB1tvMaqnc6jJ5mOThQV3Eg5OD+Zfxdg9ZQ/gD3WhJwrvMsj0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ8W5dvFadf9Z9qK1m7f2dU8ylO5v075+Hwm/u21VZg=;
 b=xfJRfuF+tYNhpHEsnbF4pzzncQBJSGoSxZO30Y2xWUZ3LcaSJqHfASfiW5z72fO0zu3f9LHDuqIviYdfPqX/0hFp/ZGwN6PgO+E+Gj5goICXfrCau1esIJAaYuXmg356VoxVvRpJEVZmAC65CjQwH3yDtqLQht8L9JqqE+9vKR8=
Received: from PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::7)
 by CH0PR10MB5084.namprd10.prod.outlook.com (2603:10b6:610:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:24:17 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::91) by PH8P221CA0058.outlook.office365.com
 (2603:10b6:510:349::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Tue,
 10 Mar 2026 09:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 09:24:16 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:23:48 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:23:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 04:23:47 -0500
Received: from [172.24.231.152] (dhcp-172-24-231-152.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62A9NheQ2803394;
	Tue, 10 Mar 2026 04:23:43 -0500
Message-ID: <7c9eceef-8e4d-4d04-a68c-4ca8f9c89795@ti.com>
Date: Tue, 10 Mar 2026 14:53:42 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Add HSR multicast FDB
 port membership management
To: Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Meghana Malladi
	<m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, "Roger
 Quadros" <rogerq@kernel.org>
References: <20260305125251.1828326-1-danishanwar@ti.com>
 <20260309141145.GI461701@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20260309141145.GI461701@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CH0PR10MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e24d25-5ac0-4dce-e215-08de7e86cce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	seqrAtJouGG0fzvRzsaOH1lxm12t5gH3iW0r8OrrFDfOf+7XHffvl/O3RnAYTD3F0z+Az+Sksgtghi6k71+ymvgA69yNu13vKyZgwU3eSCcuTFzUk1yEb486Pl0scL2jtBYoyskSfkRtuqw/2deV9+1jUOTSi7+1J+SnAYStsV7hl/0lFtZIHTldHd7bEsJb27WGN03vqgnppa/TPY6YduRt456hEV6S8wKvpwJrNWdIw9bNBlcDHVvbWmQyxEQFIOZ3lumeKGLecwKMd77mZyEWx25G7I50rGgSfeAZjpaRVkPqj4bCerdBgnmI+zO7Ok17P/1nFOHbhHB9DNISlbBaCYsDQDx6qU5T2unfGClKqbkr0A+HHP0BrYdsuOlmiRKmE5N4NPmDCz1t90CSiF6oTZ3iL+iOsNNJmLxlPSTxd+X9DhVI/gM88J7x7/cLTQKF3Z5575CzA+JJ3YlA7gW81gN0wtLnbVgNFp+f0SJcXTc/9o84Zime9wMGrMCqlyzVsiEmBEvvrzo9iXzOqEkkakg2BbejkWXsZ7rgRH0wRRqh1CI//3comNN28+HQqij604J5yyj233K9KkOMP+ZaYxrA8KRfH8xb1y9rWAP9d3OvXrxhnEl+VaUBAf6vzyNoakDWPMZ0KmhA6n68B3Brhx0qKpo2r11CQtGGz0ffifaM5jfwwbN0MWNKZgiEIL9ycWh1EWa+4/5ZIFfeRo8/qo/yQx07SUIktY6rrCF+UuKEi3E7sVwwB4wZikt45+MmPI81iziJAKNz4CeVmQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	buyP0yubo/IGP5WIoZ6HzoLrGO++I+ZiWZZC0V2RKKDFEWX5AFsZ5H2+wYs17kDNXFXEFUD/bXKI9WK8aLHYlBS1F/ipY25EArcJWum2KJR/qClCWyvKF+msaiadzsYPgdAIFKpIcuL/SaOpwp6xH7GDpsl5XKphsjBlYZozjone0X+Yqq/SeHo2BCcIy6vbreQUZEwKleMw1RTJW+odVFCXQxaL6SyW8Drv23LsZmVTnBHhUdzyxlZetRkCcUs+iavJyXl3jkr8wf2ES+e59E2Po26cPIpW0uyVtwLtTxaelEhDH2Z+4D5v2aB1KAUANo4K2tlhFuFgTUECo1Mwkx4rvZW5IOpi7LFNFTXh6+gzMRvTmn4nUDJkH+imRC9+twf8AOACzi79y1g5V3TWIgQQ1kMSpc98G7sUgFby2scBGuqISw2x+zbg1Vs0ITkU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:24:16.0571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e24d25-5ac0-4dce-e215-08de7e86cce3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5084
X-Rspamd-Queue-Id: CD7742485D2
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-265959-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Hi Simon,

On 09/03/26 7:41 pm, Simon Horman wrote:
> On Thu, Mar 05, 2026 at 06:22:51PM +0530, MD Danish Anwar wrote:
>> In HSR offload mode, multicast addresses can be added via HSR master
>> (hsr0) or directly to slave ports (eth1/eth2). The FDB must track port
>> membership: P0 (0x1) for HSR master, P1 (0x2) for slave port 1, and P2
>> (0x4) for slave port 2. When the same address is added from multiple
>> paths, memberships must accumulate.
>>
>> Implement a hybrid approach using __dev_mc_sync() callbacks to track
>> basic add/delete operations, checking netdev_hw_addr->synced to
>> distinguish HSR-synced addresses from direct additions. Post-process
>> to handle overlapping memberships by checking refcount:
>> - refcount=2 with synced=1: HSR only (P0)
>> - refcount>=3 with synced=1: HSR + direct (P0|P1/P2)
>> - synced=0 with P0 set: HSR removed, clean up orphaned P0
>>
>> On add operations, accumulate new membership with existing ports. On
>> delete operations, remove only the specific port and clean up orphaned
>> P0 bits if needed.
>>
>> Add error handling for icssg_fdb_lookup() which can return negative
>> error codes (e.g., -ETIMEDOUT). On lookup failure in add/delete path,
>> default to no existing membership. In the post-processing path, skip
>> the address update to avoid corrupting FDB entries with garbage values.
>>
>> VLAN Interface Handling:
>> Add support for multicast addresses added to VLAN interfaces on the HSR
>> master (e.g., hsr0.7). These addresses require P0 (HSR master) bit to be
>> set along with the port bits, since VLAN-tagged packets use separate FDB
>> entries per VLAN ID. Without P0, the HSR master would not receive
>> multicast packets on VLAN interfaces.
>>
>> Track whether the add/del operation came from a VLAN interface path and
>> set P0 when in HSR offload mode with VLAN interfaces. Update orphaned P0
>> cleanup logic to preserve P0 for VLAN interfaces.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> Hi,
> 
> This patch is doing quite a lot.
> I understand that there is a relationship between those things.
> But I am wondering if you considered breaking the patch up.
> Or is there too much interdependency going on?
> 

I had thought of breaking this patch but there is too much
inter-dependency. It makes more sense to have all these changes in a
single patch

>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 233 +++++++++++++++++--
>>  1 file changed, 217 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> 
> ...
> 
>> @@ -1077,8 +1191,95 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
>>  	}
>>  
>>  	if (emac->prueth->is_hsr_offload_mode) {
> 
> In a similar vein, this condition is now doing a lot:
> about 90 lines more than it used to.
> 
> I'm wondering if you considered placing the new logic in a separate function?
> 

This logic can definitely go in a separate function. I will make this
change and send a v2 shortly.

Let me know if you have any other comment.

-- 
Thanks and Regards,
Danish


