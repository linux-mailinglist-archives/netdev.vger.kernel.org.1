Return-Path: <netdev+bounces-77978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACEA873AE9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32120288E7A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D5E1353FE;
	Wed,  6 Mar 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pXn4VxHh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF4133402
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739561; cv=fail; b=WYLuhMWQyXIdzQe8pysqX8q4ZNCkZudHCzEzO6vGb64rdaW2DZb/UPvqcYtffF8kYewlc1r8D61meK/9PQf+b1WCHdN9nYnDjOsrsRZo2iBq2RaEfQsJiguhhSYTMndsFO2MjvA3eI1Kc4iAKVgbeHvQ8r3fbqhEzgne7Jd4eGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739561; c=relaxed/simple;
	bh=9FQHYjZ3Z1Qa0S2UFsZpHZw5ztCJNF0wpCx9AM1PIhw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=OGl/C9pwsi1c5o3SuxxESw/IPa4jsJp4pJC7Vvpb28CDgeIwr9WTiFBxjdX0EZvdDA2IDaT8S7Ze1egEM8ZVF2zlyURtmyEUCZJQO7weBQW9qk0+NXudNX1aZX0KObPT1wJJIySbrZXVWgmnznWBiiRt2CyIE27rmqI24HFAabQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pXn4VxHh; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+3dyUAhjdfBZiHjJzBunpLR4Hqk3Eip9WFQTuTT0fhGfHuD5OR8CaaBdqiobYq+DCPsUVYJViorLSAbi1BeCNtdVWtl8FMYZfI8UTW3zJOlyzgwBsi6IUepqHpLD1XtGLppNwvzo/NrlvWN1Dp9FJOXphfIGM51H3RnFrXQwhKyw/ateoZZJH+RYUoO2RqtNvXh1zOUK/+uFrOIfoPOmRlPijhn8PFfNFyRONS+zcYIA3Mv4fKpWY2L2IFPs9kQdmQevH/gk8RMDt+/0vVAL4vtqMnWWVsIWar07ta74G5byfUpK8YvSoA6Zwo7GBDxhslmGCbLne2iTTWB8+r9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tufnUD6247Zvjw3v7eBJGRHJua5o6EIAuclN7A0/1JA=;
 b=ltJ30GQU3ZgPHinaKwKVv3F3o6sRhcmCRXquBluF2NaGWAmXLZPmEjhiSHWTLa+yW+odcCjIWtfBO7QW1/ADKkT87FuQSq1riWnmR/sqxl5HUtSTYh3qh9EeDwcTYNiek5gYSLMkfTrMw+bX6PpCHcKiA0hfxEDrxdJFllfKd5aWEEh8/TJzZP7PaFgH75HRUHzbp3Po+WnP5yofjHWoWh2laJpUgdZGqzHZBxK7d3n90LToxwdDKkrewbKRZuhR9IZulgroGNCBCFgL6yRovk3QffP1rxM6SMU/18BgA1WmmGLsAoYRfoNLg+Jb4uc8dBeshfSYl7EQQlkikEtOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tufnUD6247Zvjw3v7eBJGRHJua5o6EIAuclN7A0/1JA=;
 b=pXn4VxHhJAOYSnzCbASSsm517a600cVxe08pEfSGUFyaOqI9L3HUXF6HPE3Um/IcI52WcNpLgOj4KyjogzC02K4vpIiYPVEWNe0DwF5rreQMQlwRwR75zRWk5Xbsm3J3aaTM9vDaITvrfBxJBeOYKPhFWFUpQLG64zZWjNL4CA35sjiApPrgqS5YmQUIm9gn+Grh3+4uaUWggja4uTxEwd8S3ehta62UnwVgHmcPJOeLd99vUuu9bNhYFmhjflzVDZ6C3Jc1VTNO27TYvNFoUfShIN0V7+0RedqU/rXStRwy3VYtUTZTngrQciPz4QTlHQLgJjL0VephJTQAvLnrQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.40; Wed, 6 Mar
 2024 15:39:15 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 15:39:14 +0000
References: <20240306151240.1464884-1-jiri@resnulli.us>
 <87il1zs7vl.fsf@nvidia.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 milena.olech@intel.com
Subject: Re: [patch net] dpll: fix dpll_xa_ref_*_del() for multiple
 registrations
Date: Wed, 06 Mar 2024 07:38:07 -0800
In-reply-to: <87il1zs7vl.fsf@nvidia.com>
Message-ID: <87a5nbs732.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::49) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: e43d216e-0200-4603-dbe6-08dc3df3939f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MYjZzzIQssmzKVKHu640Bh3BPO1WtsWbqFnfnSNxwc1tVZQJDSD8SqRBf95EXmU1jtICnUe6GdwsF3PS8eVt2ZwYR3hy+IWsKmNb6XVZBTQR2w/dZcDB9sP1OLpOj+OSuffHWhAXiIDcDtE5DgWmURKWnr4xXbeI86vK4yUwvd4XFaxHF8/w1l4AxeupduWBfjb6L0EScKqsTBRsioOapqPxBAeJDqa3VoDh7ku0X+K1YBXogsbuYKSqoWUqkYR+t+K+tCK+ggfx7oypwEOqaLTMTNPJuoXpuSu8I6Bw6KP6RbRoYAWitURsc2GVZHGwNxAG9b37W/yiyCXv1Zk914FqaiGi1qtYsipmuAqK9kLmJhnK1jedw4D63xW6WINlRuk3WLSCr7+BL42Fdj7mE932gQDBsyydkXKcTiE8NdSWyVwOGcp+7OAMEwqNQTunSZUzrP6SpX/dye8Aq4K+D4B2zPQINfrmrckwXlu9cQ9s3p/1g7+rWGcdjTClv2quw+K9G3ftXa3RzGt2gbi9ksqqciDwXK2hMobxHVwlwMx0Uc+/xloyIXBWxGVgcDJxYoT/BJfTe0SPT7ThGPepQT6w9SG4NRIpWYTk03zKzozdL1AeJztcE+o3itc7gKViWnDMFeZfgFuPRrA3WfXrmACES3Lpvq/QVQhgn6wJ7F0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aTH280Op+OcGit11z0QobIZQH+zmCqgGUvfFI5klWDZLtdknHklEmtUFPeCr?=
 =?us-ascii?Q?RmsRyQE6aHx4huKsowXXkOUXqOSBdKT30c2b/PMUndvdtOXtOj4yil90tac/?=
 =?us-ascii?Q?zBEs5vCPLtaUTTjeHSnCsR1/dxiXSGJpK5dqrXXZBieBBaHuq0gIzTK8ihU7?=
 =?us-ascii?Q?/Yp2vp9vrPKZJSTQCAogksZYUdusAc1+4r9BN4AQkS3XNUjqSohRWWJGRnp0?=
 =?us-ascii?Q?8f+41etfAOt10PX6TrEeLfMPB3SEHb3VEy8/duLwVES6U6R9uUP7zacCGLas?=
 =?us-ascii?Q?eA5pjQdv0WfWVMVCzONCZIh7D68ADtucxSbHEQ1wbb600jT6YLfs6tFhtg2M?=
 =?us-ascii?Q?CmTU+FlTC2++AO1mJA1tfz/nUZ2qDQovuQsdIbnPFN3gIee7E1WNDwCRqHbI?=
 =?us-ascii?Q?W2gnK8mv0Hsx3yDNfeoPEqQXV8gdqGhmEZyln35T5eiCzGm1YY/HSZT3SEsZ?=
 =?us-ascii?Q?AwB66tDVsdhmKhj2SUU85BQhOloWngmqCysoqAuorq22m+aknVEuJRRzi7ie?=
 =?us-ascii?Q?HUNiSAZWa7rzgmhon6e8Zis7cXI6qaU4bSRZ69/aoMOIkNyAYr9nci5KjJre?=
 =?us-ascii?Q?YIbvLmE+9mGzqb0X7EA2dBp65Hg9vGu9AqE/6qOXiOcU9rroxY72m9xhO1iy?=
 =?us-ascii?Q?DRJ/x+2LbsIgeIOeavRisw4+o7XzRNHLuFQG4gWnFVBv1PWCw+t6b9yzluTz?=
 =?us-ascii?Q?P37b8Pa2UEkkeDyz52PFQZRgAb6RtbgJgxxAnhPfFrPKc0keuXr5e5KdNbNv?=
 =?us-ascii?Q?iE1zb53brrp0Bk0dQdq0UcQ6TWtix3zqwUd0IrmVZu/+oVM2DHOtcuF1vlxk?=
 =?us-ascii?Q?BPqgBVdxlilLbVN7xMEdUVscazRC1m0UDJUWGtAojgv8k5o/Jo5OhsK7T6Cb?=
 =?us-ascii?Q?0MFqgqc8gzlCyqqND1+EVf0UZXstgNtbjldq5sNBNPeP25JPTErOiYkrHyK7?=
 =?us-ascii?Q?4tzXSsqp5WK4oyjbmiWuRQ596u3IwzxGOtaogPTvZnLpjVz77+0zcS6ANohl?=
 =?us-ascii?Q?gI7/Nzm35UlWUPnaa27ZFh3NerrSdbngMrUurQEuZY5WEToj3vTUrCrAUKru?=
 =?us-ascii?Q?LYBBKz34wUcyhEzVc+nXZHdvbwo4J/p5jWkzhW9iWVE7UBluq4Fj3vPG99UH?=
 =?us-ascii?Q?YcS8y+olDrqD+FlQofmJoRF25myxZMsyV1e1mAOVyD9iCqMP4SJiVjfvke7H?=
 =?us-ascii?Q?DTAcBKTb7RTkEGuod2HAndIHPeVEdwNYenKQF8A4Ki7qSDTrStU35oAUaTYp?=
 =?us-ascii?Q?Sy6tTEsDzTignSB8X9afRKElBvZKHHyTg+Ha+TkEYxMzXTzSsq62v+XOiTj/?=
 =?us-ascii?Q?Tep1W/Y6nzMKQwKcM1SHuY+hOezO5NGLZMMGSey88aa34U+9HWQzNJOEmMJe?=
 =?us-ascii?Q?gilb2z+wdBZQcGEkfb9EJfEMU5eOs3LDPgOcKi95t00c+uafHUdtERUzZUUq?=
 =?us-ascii?Q?pAAEtQcuTX7w+5i2PzM5LAEZMH2CTLEpWY+O7O8vjDPQeRn8ICNiBINGi9Zc?=
 =?us-ascii?Q?4+f5n2yNPyezQb1cYEqcUNsdVo4CAbPuHbE9WGKrl8BzT3hTOw3nby22Fkhz?=
 =?us-ascii?Q?COtDqh9i7rrqS4lmuzQNKo3J/yIabUfZfMd9rfKbQeerNkGcG3/pHypCWCnU?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43d216e-0200-4603-dbe6-08dc3df3939f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 15:39:14.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rcu1JvuHE4cH9OY8p/I7/JHYiHQzv8YKmE9FCqAYKy/nEtm6aupRP9QOrjcatgCcsdXoA8Kd1cP+nkwPingmeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910


On Wed, 06 Mar, 2024 07:18:35 -0800 Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> On Wed, 06 Mar, 2024 16:12:40 +0100 Jiri Pirko <jiri@resnulli.us> wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Currently, if there are multiple registrations of the same pin on the
>> same dpll device, following warnings are observed:
>> WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:143 dpll_xa_ref_pin_del.isra.0+0x21e/0x230
>> WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:223 __dpll_pin_unregister+0x2b3/0x2c0
>>
>> The problem is, that in both dpll_xa_ref_dpll_del() and
>> dpll_xa_ref_pin_del() registration is only removed from list in case the
>> reference count drops to zero. That is wrong, the registration has to
>> be removed always.
>
> What about the case where you have two functions/netdevs that refer to
> the same DPLL device/pin and you only remove a single function? You have
> another function/netdev left that now refers to the unregistered DPLL
> device/pin.
>
Actually, I see that being registered or not does not impact the use of
existing DPLL device/pin references in other functions. I agree with
this change.
>>
>> To fix this, remove the registration from the list and free
>> it unconditionally, instead of doing it only when the ref reference
>> counter reaches zero.
>>
>> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  drivers/dpll/dpll_core.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>> index 7f686d179fc9..c751a87c7a8e 100644
>> --- a/drivers/dpll/dpll_core.c
>> +++ b/drivers/dpll/dpll_core.c
>> @@ -129,9 +129,9 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
>>  		reg = dpll_pin_registration_find(ref, ops, priv);
>>  		if (WARN_ON(!reg))
>>  			return -EINVAL;
>> +		list_del(&reg->list);
>> +		kfree(reg);
>>  		if (refcount_dec_and_test(&ref->refcount)) {
>> -			list_del(&reg->list);
>> -			kfree(reg);
>>  			xa_erase(xa_pins, i);
>>  			WARN_ON(!list_empty(&ref->registration_list));
>>  			kfree(ref);
>> @@ -209,9 +209,9 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
>>  		reg = dpll_pin_registration_find(ref, ops, priv);
>>  		if (WARN_ON(!reg))
>>  			return;
>> +		list_del(&reg->list);
>> +		kfree(reg);
>>  		if (refcount_dec_and_test(&ref->refcount)) {
>> -			list_del(&reg->list);
>> -			kfree(reg);
>>  			xa_erase(xa_dplls, i);
>>  			WARN_ON(!list_empty(&ref->registration_list));
>>  			kfree(ref);

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

