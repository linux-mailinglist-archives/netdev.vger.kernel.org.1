Return-Path: <netdev+bounces-272258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AhCIhWlxWlUAQUAu9opvQ
	(envelope-from <netdev+bounces-272258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:28:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F8E33BE2D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6886F303E600
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7134D910;
	Thu, 26 Mar 2026 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DWOg00Wc"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A948635D;
	Thu, 26 Mar 2026 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560530; cv=fail; b=kCRYf67LqAMylUIlkJMlK35Ud2c5S1rg8hZzUvP6muCijYfwKv01Lhv4fChGIfRt8dsgj0M9tuir3kDgofTl+Mt0lrwzoM5or76iGL13LskN/xUo8lKDGc5S/e7tDPJzhGAH3ZoKGmZnbImQ5r+DUFi2lemuAebHvyYRe6AkvCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560530; c=relaxed/simple;
	bh=yOit4jwLNRYEHwTG07g9Q9onZQjMA0Z5xwVlZbfRWak=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PafWUbJioSmLEQk9/3ZTzuv05KidcJocWOjYPgD0RRDpWaQYiMW43T9bqDKqG+lqZSCeJ0Db2wUCiF8s4RE0Gfl8u5ML4uAxJGlxoant4wgT+malX+m+CIsS/e2uaMx6vJnsfmck1bwP5ll/TaGYXKF8w02+E2rQWjypSicW9UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DWOg00Wc; arc=fail smtp.client-ip=52.101.57.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/Jv0uG1jNXaS7bR83qg/WtE8U5WSxU0TNY10Zh/s/tO/Lf4V38g8gDLKH2NDcOGNIH5C8zwFmqUBtcRoznASWMHmp7rXsI0py+JnaduEOULa00Wbk21pwn/fGqwYlJLS6xEw6K65A4vOU8NtzOrTa/XsMK1Dmeo5wOVJj6r84yxNXA/e9ZtPX52IrYOUEtx+YOz98fxm4kEoZ+cGLgWgAMfGEjC7bjGLVJBQ/8QlpD2xKP939CCogf6KwX7l6TgMi7cumEOrmGWjEBzhcz8zLpUf0DpJZXbGgBK9N9wh/S4xntG2nauYL7H9LX/f0R8JiPbt/dzOMwfgXLkclxBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vDXF4s58xmbHkyJ7dDQfrTZAYkmyNda0rS4n9LQ408=;
 b=SmfgWxdlRvlC+KQDJuajbEjYH1autKlltgSrepJ8ovzNxBxfXUQ3lhlJk0KMmHr/YJJfH0/2/6+5RLhalz7GscdPR/cN7huY49hOoL+Y3bgWrv/dxkP9o97LhViQaDH2fmNwvaxamgM9s5wXhex47iH+MhQuOueQ/YwtNBRIcJ5suGjo0f7UIOiyOzQpuPMTG1ghpHlQ071jgAOYQQkjNdF8DwUmSu1vkOTDkxXRMJ8j8S3O51dNu9yPaAwtjxAOzcFjAh2EwdbVgZg4MThwvDdurOvuU2WHk8yjAfw/3EiXMkZqxvpabYFxbWMwG1C9qGKJk77vbxdd1BqI8qttRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vDXF4s58xmbHkyJ7dDQfrTZAYkmyNda0rS4n9LQ408=;
 b=DWOg00Wcgi/KKMLxSbZVz0CJlgKGUfNnJ+CFeOuv6dUuv9XhUyUArk2JBY7UQzPGIQZMNtMvHm1rI0rRldaIVe/b+EGZYEuNamo4ZSRFOJsWxtZWhM3v+5P64EIIBUPb/gH1337x4PxcfI60Xhy8HpUvtQTWG86CSrIVyya5cNQ=
Received: from SJ0PR13CA0218.namprd13.prod.outlook.com (2603:10b6:a03:2c1::13)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 21:28:38 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::d6) by SJ0PR13CA0218.outlook.office365.com
 (2603:10b6:a03:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 21:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 21:28:36 +0000
Received: from [10.236.180.172] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 16:28:34 -0500
Message-ID: <5e901aad-51be-4be0-a9ba-a0bdb0e8a334@amd.com>
Date: Thu, 26 Mar 2026 16:28:34 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 08/11] cxl: Export function for unwinding cxl by
 accelerators
To: Alejandro Lucero Palau <alucerop@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, Gregory Price <gourry@gourry.net>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-9-alejandro.lucero-palau@amd.com>
 <20260324165056.000037b0@huawei.com>
 <0d21a506-e158-4b80-8264-064ff891dde1@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <0d21a506-e158-4b80-8264-064ff891dde1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d692ff-2576-4984-ad33-08de8b7ea3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	17CwY5VPl87DvItmhtsOX4fk7UH34wLaICGgNj+sANwC2xsRwo1NBJ7qCZC60qbUCAsDF+ayH7STXLtomGBfxMSXVc9VOHw2Kg2tcondbRWtQmTxe3ahq6LgRVHiUdKyVvKhF+9/tWT4UxjvECHL3Jplz90UQBgN0Dpzq7gE76TvIhg+f2ncwlwZxC3IEHQ4Is23/WX/UlXS7Wkj6+B4Pt1xHpDHPbMB1XH05aidNO6mwIhqrxld22UN49+3CHHZpwO+JR86l3X7Uw4x+5KPKsD4zSnGYFkWf/EvQaJVcI78OBenxLrRO6RtDRQqd0oFZny+pGZzgoJDX56/DrtNOz/5cXo9W0FvEbOg0rnhcVEUMcnSwdkjq7MHoJfP/cBAimG8B/JDf4zXVQ8tUviVjWf8TPdfcyuTPp+XdXHlyHOnlfkXckT0zne7UfE1x9iV9B8ulbPXcLN7QWUvUSr1O2jp+nNhiFMSCu+UL8dSmwUrmZ2IdqJNWxJ949TBWRzX4bPuHDnCFFAOWOkqUOpvFnUtNE4w2aglnu9YYvPa3o8oEeQMlhKfzBUIjs2eadW3rCt0KeL1Zy5Rs/wu67fa13HYzC3xXSIRdjAflew7/zThuqrfj9z4AjkH0HPj0VSqTwfIshpqsnRuyT+yRnKljmbUcSJ9fn3iU9J2AiryuxXm398mUmXaLXEJVatwC/Mk1mEp7CYnD8BGIR7ooSdCPEixW7jCm61caR4wvGrg+eHgW5+yh06RYZkU0YMwlAdwIhbRJcf3rS5EmqklBkwuug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	879kGdw6Q5C3cDFlAelzFJHLj6BaB6dS+T9ChX/lYU+1rkDlYuE2GGhpzDy8CcQZXxpXoemX8fbj9aIyoNnGipOOQhb/u/hep8lqMuXst/E9XYn7zvVH2S1tLvjd4WDyB3xcDo9P+z7ojrb783xGNabJxRxY9vc5NXdS3QgrJmnEvOIee6CIKDj+C610/nUWPAu8/oAzdDdQMd8DwC3jQ2GOjzg4NcjzBxVQy2pBcevnHKTDYkzixI8Wdx6+ErPtZFN485gNvnKTjflQPqJWTyx1AALxHWbm5PWXA/71v40BO1tXPdL5fXggx/kCWxtWNEOnBb6RmC80F/2MusuU9q9peNOebm7txXVEEkdU+aKofvFKfqfZeCD05ulrvbW/y/U7X6YR/i82x0JzPVl/iUdhP853w2/SiAYVNGZgSbmkNT+0x97v+EqvmfLQIG2m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:28:36.0319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d692ff-2576-4984-ad33-08de8b7ea3b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272258-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 25F8E33BE2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/2026 4:36 PM, Alejandro Lucero Palau wrote:
> 
> On 3/24/26 16:50, Jonathan Cameron wrote:
>> On Mon, 23 Mar 2026 11:31:14 +0000
>> alejandro.lucero-palau@amd.com wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Add cxl_unregister_region() to the accelerator driver API
>>> for a clean exit.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> For this I'm seeing an outstanding question from Gregory on v23.
> 
> 
> Yes, I did not forget about it but I forgot to comment back.
> 
> 
> The kreview is obviously wrong but I think it points out to the missing invocation I need to add. I did not suffer those problems Gregory mentions, but I think that is due to how I configure my testing kernel. So, yes, I need to remove the release action from inside this function to avoid invoking ... this same function. That is another thing that puzzled me when I saw that review, and it implies I need to have different functions for accelerator driver specific invocation and for normal release action call. Or maybe just an extra param only removing the devm release action if invoked by accelerators. I think I will go with this last one. Any suggestion?
> 

May be a dumb question, but what happens if you don't export this function and just rely on the devm action registered during creation in the core?
An extra parameter seems icky to me, but the alternative would be to push registering the release action to the endpoint driver (cxl_pci, sfc, etc.) which
is pretty rough as well.

I may just be missing something here, I haven't thought about this too much. I was going to look at the rest of the set tomorrow, I'll see if I can think
of something then.

Thanks,
Ben
> 
> Thank you

