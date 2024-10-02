Return-Path: <netdev+bounces-131111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5247298CC25
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 06:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2561F244A0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 04:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7712617741;
	Wed,  2 Oct 2024 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="E3tQFLFu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B61C2E;
	Wed,  2 Oct 2024 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727844019; cv=fail; b=CnIpwSKt0ssAXfLBTPax6SbFWlCOiEKtNZ3bJcfd4x3IIWohXmRc4OPh9LkYY4l57Ii8WRfPIz/f/0/eb2s2Mol9otezOl23lFhGx65fRaSA3vNHhC0q3S2/SLoPWCzVbZtgIUFlBKguqcFFB3/04HqLGcQfuimYRpveKS63VFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727844019; c=relaxed/simple;
	bh=nmC0L4Ni39y7qFCuFtTlgBzFMvvj43VCez3uzTC79zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gFYnf5YDKvv+mU4OeM95sZ+PBzMIFVhQa8qM62GHJA3ufehcFP2KEC39gjT6+AB1YIOs8gUmShS25cpuCNnKcWqyw85SCU/c8e0p3YEx+Wkys9YnzD1DM8H0xvwvyu96Dr0/zHKFSrKLWo478i8CaCxMWuEkMCMkIFTeQyjUTH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=E3tQFLFu; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M08PfxGsUZ2Ms9iGCfY8KXcL15kHhDOu3NPNq99I/9VBM/Tl4diF4oAPwY4vWkVDdIOMTKR+qSKqEgierTb5yJSKJIIVCIpMutESWIbG9tSuSbpfICoj/TtMXgFi2VlP4fdtbMxxKVEQfvj4WBv8GtwBrxUY8aA9a/QePtZFEvDyhd/SxIzDqt6IHx8MUvHMxFt2xeKRfKGpwUfOEj/ywU3TywP2XqGspPAOpP/AF4A/yhFZfauzOlfFG6Gz50zn7xnZOL7QgDcVU+H5xQpwmgATyhQcUL+ReP9qJ0tiKxw7USUNt54dVJn73Ojii0kDcOzgrz8H7dlhpTlE4Usabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obYiaakf6AdhISY5rnNwKZrkwp4QoIpfB3KuQdX7Yl8=;
 b=w75m0X/6rqJm+h/QGkFUogH+mnjnnQlHrQ2VFLEyZdScbhvgBITvG/mYuu2giu7JYeYE/wmSJxe8MEtI9QbKoZIWYdXC/P0Eh6Lime2qJTqGfnwSR5b3x06fB1v5QK8E0zYJ3npVqg771j46qHNA1Js3++BjKOAIpL20z0NX2s3Bo0LM74mMgLPTHrDNLtAZaiuiBo1K4vMQZ8ZeOFPqnFuUYFq2RdnUTBfjOVN6TP9SHgEdEganZAm+C1do7gxYcWjhQd4xDZGQy9WLV2wEhHPFhAbpVTWGLUHcm7fal+4037mEMICstg0tLYXUqS14nkr9gh2GiNZvDDP65xGyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=lunn.ch smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obYiaakf6AdhISY5rnNwKZrkwp4QoIpfB3KuQdX7Yl8=;
 b=E3tQFLFue5uVGKnTQHaP9uoANiYK6DtlYgqJ8yRdckMQTxp1hXM9l7eJiFXLyljeeMHYk5WjLnsOOqQd9ngampAUtt0ymmLn74r3XITwZdu21uXmA8Pv8CjTfoJlKpsYrZ6sLjgp3wPb06WHshGY25/ku2BEhK/DILHJNOG/q6FQtUxtRRzzrPWf1DJrpHo/g8iMTqV04tOUbA/qKbBYe324EFan+Hay9YsW8abT+uizWhXiwYCWRz28rmBdyIhjgJGC0gqOj8wL7II5OGdoMdd7aQpZGS2zHW73X2Eto6O6JUM5wdapfwjr2CU8C61Vo1dSK5luQSr5xCmtAuhc0Q==
Received: from DUZP191CA0042.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::6) by
 AM0PR10MB3492.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.24; Wed, 2 Oct 2024 04:40:11 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::2e) by DUZP191CA0042.outlook.office365.com
 (2603:10a6:10:4f8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 04:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:40:10 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Oct
 2024 06:40:10 +0200
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Oct
 2024 06:40:09 +0200
Message-ID: <76d6af29-f401-4031-94d9-f0dd33d44cad@de.bosch.com>
Date: Wed, 2 Oct 2024 06:39:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: iopoll abstraction (was: Re: [PATCH net-next v1 2/2] net: phy:
 qt2025: wait until PHY becomes ready)
To: Andrew Lunn <andrew@lunn.ch>, Alice Ryhl <aliceryhl@google.com>
CC: FUJITA Tomonori <fujita.tomonori@gmail.com>, <netdev@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <hkallweit1@gmail.com>,
	<tmgross@umich.edu>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
	<a.hindborg@samsung.com>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-3-fujita.tomonori@gmail.com>
 <CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>
 <c8ba40d3-0a18-4fb4-9ca3-d6cee6872712@lunn.ch>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <c8ba40d3-0a18-4fb4-9ca3-d6cee6872712@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885B:EE_|AM0PR10MB3492:EE_
X-MS-Office365-Filtering-Correlation-Id: df46ab95-ab71-4912-34f6-08dce29c4c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWQvdjVuclJicFlpL1ZKcnd5ZCtYVTl5aVFnellaTVBMQ1l1Uzc2SDAzbWFR?=
 =?utf-8?B?LzZ2QjFwcGUwUDM0Z0k1RVJzU21IdHZQd1dWWmJ5SFlIenJwZmNsZHEvanR6?=
 =?utf-8?B?QjRKV2F6R25RUmpBUmNCbDNuL3llUW5IeC9DZk8wci94ZVVBa2FISWV2TFcv?=
 =?utf-8?B?dllKUVRsR3c0bXd1NEdFd2hxSUI3YjJwYnpBQ1JlVEU0QXYrWExPTXpMaWFH?=
 =?utf-8?B?N1A4QUJIVTBlSGlZcU5sREVIKzRvcjlEKzhrdEIwT0V0KzdXMzJBcy9tck1N?=
 =?utf-8?B?VVNUbS9KalAwUjdHejdIZkFhdEpucGpxbU5ldTVJSDNoQXhvRmlCYXllbXJQ?=
 =?utf-8?B?cFdyNlZTS0NTK3RVOWxueGQxcTJxQTNQTEtnQ1NqSjduMXVUb3B1aytvcmxO?=
 =?utf-8?B?cFdNY3dKRXo5RFVUOXFTRC9PWnAwRVJhTUl5YStqOGRVNi9xQStFZnZ3Mlpy?=
 =?utf-8?B?ajE5TktQRlF1dUxaZnY1Q1BTL1lvUnlva1dQZkNFc2dmbm9kSjFmM1l4Q1Qz?=
 =?utf-8?B?aC80SlVtSEJ4WWhJVUMrV095TytxaTFrdU02SlgxY25SK0ZUVXhEV0tDOVM1?=
 =?utf-8?B?aFZ4eURyRVN4NWYvcmVlMGlaTEE2eXpscHNJbzNURHUyeUVzSkZqbDFQU1dz?=
 =?utf-8?B?dW5Kd3dtYkV2aDlwTXYzYTFVR1o5dEZNdEJNZVZkZllOZXZHelJab3NISUpK?=
 =?utf-8?B?amFLUlBKNnNNRUZ3UXp0bUlGUm0zTkxhNTljVGJzUmVPc2lhTjBNS2NuSWQ1?=
 =?utf-8?B?c2hVbHgybE5VQjJtd3NoUklGTlVIblpKb2sxUlRDcnZhQVpyaXlka0hHYWdZ?=
 =?utf-8?B?cDFqVERBanpRUVdiZ3luRktwc2hxMFBnVkNRSWwzRU9OT0JmeHk5dW9KeGlB?=
 =?utf-8?B?dEhZRW9rT3VLMmh2TFhMWXVrVXNFMDVoQWM2a05OaFV2Um93Smczd1ZHUzB3?=
 =?utf-8?B?SWFuZFVYQTdJWDIvT3hXb2RMZjJjK0FFSEduVjVkdUJIeVVRRFYwQ3E3Y1pM?=
 =?utf-8?B?cENqK0EwQ1FkVUs3SktzRzdJT1FvQTJRNUluemcvN1ZRY0RUWFI3UUl2UVlQ?=
 =?utf-8?B?WG1GRXpCbnRuaEFqNUw3dG1USmErdkJuQTJzUVNQY1NhQ2lQd1BWbjVWMnBk?=
 =?utf-8?B?K0xrbTBPbmdFR0JyUEtpWTFpQTZ6ZHpuYnUwMXJqRTByTTRnTmVScUFJaGti?=
 =?utf-8?B?ajJTSjR0R0FaditPT2R0ZzNKeHVqV0o0cUgwbnJsZkx5ZFlXdTl2YWI5dTNR?=
 =?utf-8?B?dkI5N3JqekhJSmtkdXJWdEFvWHpmUG1YWkVSdDZjZ2R1a3FoNGFjS1RuZTdH?=
 =?utf-8?B?YVZFb0xLOGk3dVh6TTEzc3FXZXgweUkrVXJ4S2hjWmIxTTZlNVdIUDQ4RHNh?=
 =?utf-8?B?dm5NcFkvREZQTzk0clNOeWt3T2ZEQTFwcXUxM1FzYWJraTdwbmN0Nnp3Qkhx?=
 =?utf-8?B?Nm1YaXY4ZzJJM0o0SkZ4WCtWV2dPVXQ0aTB2a1hsMTMxdXB6dW5DUXdSeGV5?=
 =?utf-8?B?TW9IQVI2dmVCQXRmclFWT2grQ2NBVzltNFFqeDlNS09iZnBJQ2kweXcxSjk3?=
 =?utf-8?B?WWE4bC9kQjNVZTBSc1h4S1VTcGQwSFRmZHJHYWhidWJxRFVvaG5DUnZXaEc5?=
 =?utf-8?B?UW9kSHM0Vjc5dFpIZkN5Q24zdGFlSlR0V0NkSDJObVRjNTRBdFRWUFVTUjJD?=
 =?utf-8?B?UDk3Tk83QWpTMmtkZEFmb1VWZnM0cjJkYVgweGVsUWRhaWhLNUtrNDJtN3Fo?=
 =?utf-8?B?M1IyV2h3WFZzak1pTkIvNWhMRmFqYlZ0dHMrRGxiSDl2QnJzMzVQbm00SXdi?=
 =?utf-8?B?cVNLM2pNVHd2M0t1YWpweUNLL2R3RUNydWJSUkV4cDh1eThmdUVSK1ZQWUow?=
 =?utf-8?Q?jJNYoaWzmQrCS?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:40:10.4879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df46ab95-ab71-4912-34f6-08dce29c4c7d
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3492

On 01.10.2024 14:48, Andrew Lunn wrote:
> On Tue, Oct 01, 2024 at 01:36:41PM +0200, Alice Ryhl wrote:
>> On Tue, Oct 1, 2024 at 1:27 PM FUJITA Tomonori
>> <fujita.tomonori@gmail.com> wrote:
>>>
>>> Wait until a PHY becomes ready in the probe callback by using a sleep
>>> function.
>>>
>>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>> ---
>>>   drivers/net/phy/qt2025.rs | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
>>> index 28d8981f410b..3a8ef9f73642 100644
>>> --- a/drivers/net/phy/qt2025.rs
>>> +++ b/drivers/net/phy/qt2025.rs
>>> @@ -93,8 +93,15 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
>>>           // The micro-controller will start running from SRAM.
>>>           dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
>>>
>>> -        // TODO: sleep here until the hw becomes ready.
>>> -        Ok(())
>>> +        // sleep here until the hw becomes ready.
>>> +        for _ in 0..60 {
>>> +            kernel::delay::sleep(core::time::Duration::from_millis(50));
>>> +            let val = dev.read(C45::new(Mmd::PCS, 0xd7fd))?;
>>> +            if val != 0x00 && val != 0x10 {
>>> +                return Ok(());
>>> +            }
>>
>> Why not place the sleep after this check? That way, we don't need to
>> sleep if the check succeeds immediately.
> 
> Nice, you just made my point :-)
> 
> I generally point developers at iopoll.h, because developers nearly
> always get this sort of polling for something to happen wrong.
> 
> The kernel sleep functions guarantee the minimum sleep time. They say
> nothing about the maximum sleep time. You can ask it to sleep for 1ms,
> and in reality, due to something stealing the CPU and not being RT
> friendly, it actually sleeps for 10ms. This extra long sleep time
> blows straight past your timeout, if you have a time based timeout.
> What most developers do is after the sleep() returns they check to see
> if the timeout has been reached and then exit with -ETIMEDOUT. They
> don't check the state of the hardware, which given its had a long time
> to do its thing, probably is now in a good state. But the function
> returns -ETIMEDOUT.
> 
> There should always be a check of the hardware state after the sleep,
> in order to determine ETIMEDOUT vs 0.
> 
> As i said, most C developers get this wrong. So i don't really see why
> Rust developers also will not get this wrong. So i like to discourage
> this sort of code, and have Rust implementations of iopoll.h.


Do we talk about some simple Rust wrappers for the macros in iopoll.h? 
E.g. something like [1]?

Or are we talking about some more complex (safety) dependencies which 
need some more complex abstraction handling?

Best regards

Dirk

[1]

int rust_helper_readb_poll_timeout(const volatile void * addr,
                                   u64 val, u64 cond, u64 delay_us,
                                   u64 timeout_us)
{
        return readb_poll_timeout(addr, val, cond, delay_us, timeout_us);
}




