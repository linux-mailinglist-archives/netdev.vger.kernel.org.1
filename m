Return-Path: <netdev+bounces-72798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA29859AE5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638CF1F215E8
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A92020F1;
	Mon, 19 Feb 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="sFIewm1f"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2148.outbound.protection.outlook.com [40.92.62.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F92103
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708311970; cv=fail; b=fcU3Vy4VDYngosIzcxqAr8BOfDqbecNtslAdJkmdpWiGicpOMTQxVpbdMYYshxvAL35v6tEbeM7t+FM5jblCRyExh1A9oIEYswlok1kukKNb0k+sSF8CFmM0aO2aJrYLjkrl/zyTbXNVfKllr/jaeZLhKOQh8Qmt9CanC8JMlSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708311970; c=relaxed/simple;
	bh=H3iZQKiOwC4wR8wsr8x3TeBm5ZGk+WTTvnMz1u9vLw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZvbh2IWJHfLPxoiGnqLrtdiOedt7iamtlYQl5X7CJArfXGQ4lMPwI2fsal4WDFaEnuEJqp+Kv1/riwCbkvpCo7EZbq+eT8BpCdDtx2ryTcUDSJeVHBQlW5/2QnJsnYWK1hXawcBgxPtckezbpyyCrlA/cQFvkSMODShh2SSlFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=sFIewm1f; arc=fail smtp.client-ip=40.92.62.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfRhWoRkVVetDHr5haQmXgO7M5Idn1Z66uhR6vucdR9dKus+pY1lJ2xy2fu2NP81S5+tNaJN7uIju02wnEvniS/qmylMptJzhFBE8j+EB/o+z8eB1Qyi+IjFOH2iA5gHLVEs+q628AbtqC+JOeyGXwaSW4U2yy9HoDboJ94qq2MoViF33e6QcZPWWkDbLtbS3sf7KzflGqZgo0+lsruaM61/SZdYYdbzlnaRN71fV+V47+glN70C+ZDrsGqynSWxsDYfhbzrZO5pooC9Bp5TPKfM/LtyJr009pJABjrxnRh6BOSkkdRsShr/t72dlgLaxDrbeyPc7jXVFrfLh1NTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZeU+o1mKmExzvZITCdjvzIFeUtL/ZnXMaCFzrF6rdw=;
 b=KIDk2GvuK5nxdpnqkndQxYXTGM8b1XNUmh6l+9+CgzJvrOX1BQQFmRuRS7AEccj2d+nrXm3YI8M83f9zqahIP3OfsK2RMNnvqgHTJMPXYB31+Guaa4NkB/j8rdtvO6UO0d3vtGu0++jWqDQ/JD6s8IJaz6QzJsK3r/E/Wl3QzJWNMJVdVRNBQq9IlYQnF2IAryRpPDNT8NIPSXZtM5srYvFobVIfAOHPUcyF6SyYhn9BxQfEUlvW1xuQjjebVvtQp8KOj4xx7CVyEs12aHwYJAsoXQw81PkVFU0OqvDUp19I2hwfxEPl9qQ6uSO74o0JIDMLOpqCbxy03f1/gRd6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZeU+o1mKmExzvZITCdjvzIFeUtL/ZnXMaCFzrF6rdw=;
 b=sFIewm1fEpS+q/KQl+BA2O/PicQoRdbZZTiHn5A8KYZ22PTY23i2/C6nXQ2BcWFC7hXKmuCblX1ECoAF66f/f0qCohss/C6olZDAmlinwBNwEBmR7mrkf+WnExi7UkOvsMeRza6Mqsstg8Z8Vv7/HPM7I/yt3kDnQgKkO4HoE12vjfF4EXyo2yqy3RJi6XEHZPQfKQuoHyU4W1nw9hTp5oOuGhcuEEJEVFGFvfaZbDsUYNlouPEB/TGzd0zIDyyxvgCLv7ShGdfqBTkyRDYTObMCWFF3j6pGZS8SGl1C5wAkCUk7dTMX7i8LbhQbelFZ9mdETxUTfzohvxDcFFehGg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SYBP282MB3607.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:17a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 03:05:56 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e36:8999:769a:3d9b]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e36:8999:769a:3d9b%6]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 03:05:56 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: loic.poulain@linaro.org,
	Jinjian Song <songjinjian@hotmail.com>
Cc: alan.zhang1@fibocom.com,
	angel.huang@fibocom.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	freddy.lin@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	letitia.tsai@hp.com,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	nmarupaka@google.com,
	pabeni@redhat.com,
	pin-hao.huang@hp.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	vsankar@lenovo.com,
	zhangrc@fibocom.com
Subject: Re: [net-next v9 1/4] wwan: core: Add WWAN fastboot port type
Date: Mon, 19 Feb 2024 11:05:28 +0800
Message-ID:
 <MEYP282MB2697DA315999097C79CDD9EFBB512@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAMZdPi9-OCucMxPBTqBc4xTe_LgOiNd13tVVzeVBg8aim_M+ng@mail.gmail.com>
References: <CAMZdPi9-OCucMxPBTqBc4xTe_LgOiNd13tVVzeVBg8aim_M+ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TMN: [NGgdVm39oVYXQ4IJr6WEs/6jgCVH5LZh]
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240219030528.15603-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SYBP282MB3607:EE_
X-MS-Office365-Filtering-Correlation-Id: c664c54f-2a38-42af-b6f7-08dc30f7b05a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z9Sl2ew5GCRBXo/g2qE1jq364C5CxHymEynVWNxcevUo/L09xAvLxAYdIRbY/aqG/3xy3IRSCWRoELvbpP6RZc+vEH/Aq98YmPtsjTHM9HOmbrh9TIPxxzVqc3u4ppk2kpARxw647zxLlO2o+IXWqtu0d58H0MxIoqKiebUTvCkXI2C3eEcYHSg3bxtR5HzDQQA8aXUuNU69t3vumGyqsE8E2q8o8ofJoSqazpymmJVlTRuXciKQ9aR1MyNRRSDHyvRb7CVeM93ZdWa2zcJAlIOajM/8Mvi4KaPRqNYF19mM41gln7otF7k9/m0yKRCYPzYYooL4lHQgTSyQwuGx1oGQTIQHy104Xal2u1PCcx4nLTuxhp/eF/74oDpYBrZb2D7DSuyxBasXanjvY1UENiduQGV3FcHgIzCctAdrL+gJWGRTpxPwvgtI4W/LSYoNOqARIzkrOMtYVV018qX+9jQMwJldoci89eAb28r2Rj06mmozqvFT/LgqS/lbsFDohae2BRaMXpaSpiIrhGAnTIXuDWITm9hpS0KHXyxroga2Hc6YoPeNBboMsc7omJ1gRYejy2f+J3nsqgKK5Vsq8Cpf4SAWy6/N4f5QonE1AYs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlNuek1ETjVBNlhpVHUrYjBhbkI0ZnV5bkZZOG1zSjA0RHJiOXBNVTdpZHBH?=
 =?utf-8?B?OVV5Y0YrSlhSWDF6aXJUR2gwMmdQTTFHak9EWkFUakl3WjUvZFAzWmFzZlR2?=
 =?utf-8?B?VTd3TlBKdm0wSTZWdndjdEd0M0lmUVRmUjFocURWc21TYlZoS2RWdVBIUG55?=
 =?utf-8?B?bzJWS0l3aGxKczhnSlBUMVgvdXVzNWRxdm56b0ExR2htdGlGa25HRDRpdjRD?=
 =?utf-8?B?cEEvc1h5SXdkMXQzemkwQW5Zbk10cHExaGR5Skw0WnJnLzNNR2NLTDQxZGxY?=
 =?utf-8?B?WmJUNXVqalJaRnRmN2hvS1hURDVXdXcxTXVKaVV0SFFFSGJ2dmtwNEw2bTZL?=
 =?utf-8?B?eEpYeFhia1h3ckd0YUZ2RExNUDZUKzNwUGhpeGlpazRzd0VnRmljckRzeDd6?=
 =?utf-8?B?WkJWRWlDdG85YVlEcDlJWnVWVnNHbDBDQk1WQ1R0QUZKdGt4U0NMSk8wTEpV?=
 =?utf-8?B?RTNsNjFlcTMydk1KUWhRcHJCTXdhZlBxUFA0V0N5TEs2QXBtUmtpUUk4Ri9X?=
 =?utf-8?B?bmFYMFRyczErclh0clBpdXcwc1crSW5yV0VrQ2JRVWowMmhJSHNETW9YNWE4?=
 =?utf-8?B?KzhWMmJwTlROY0FMcEV2YUozV1JxaUkvaU84V09INWRrYXV0VlZLUjlCSUlP?=
 =?utf-8?B?TXpBcmtVeEY1QVRqUnl5ZW9GRXpnOTJLdDB0RmhWZTQzMjlUU0dHMWR1bFA2?=
 =?utf-8?B?T2doNitZRE9qYnM5TXhnQ1dBQ1Vpc1NyZmo3alo2RW5SQVJFUllGd1dDaUlk?=
 =?utf-8?B?M1NiUlVZSE1GUGkvS2FWSFBXMTROMVhEWHVSTVhvMUJndDJPbTdicWMrRi9x?=
 =?utf-8?B?ekNISzVDZk44TUJtdjFkWjBrbWQ5RUlWbUFLTFNqUDIzT05Ccmh5UjlseDFD?=
 =?utf-8?B?d1VDV3NmR2EzN0lNS2JBckJEOE9SbjRPdW42YVRHMEs0Q2lBKzA4bDJ4L0la?=
 =?utf-8?B?OHJsbnAzTVR5ZG9Ra1pBUWlGcldGbWtHTkxwZHJwTEpZNlZ5aHpCUmdmcTJ1?=
 =?utf-8?B?RDBmWEtaK1IxbWcrcUp6WEdYM3hGZ2VHVlo3bnplVGI5ZnYxVlJMZWNsb2x6?=
 =?utf-8?B?M1BaLy9haVVNbXlYK2Y1a0RaUUE5c0d5WEl5ZnNpVitGSTFDZzdUT2RSWnQ2?=
 =?utf-8?B?aFZ4eEc5TnNOT2lnMTJpbVhiZzB4c3g1eWVhRllFTGI2ODM2aGNwbFdYSXUx?=
 =?utf-8?B?V3hmZmpRN1ZQNVVjbU9lM0tKUFN3M0RNSllzZTRIVDBpVVJJT1JFcktJSGpM?=
 =?utf-8?B?Z2lXVFJpMmsxbWE0OC9aZHY4Tkd0TnhIa1NYVUtLZ0NoTXUrK1R0YXIvUHpq?=
 =?utf-8?B?c29jYW03WHZ4Rlc5UmkyekRWUmJDb2lUeHVBajgyV2pEcHlJc2NjbUpFQWZ1?=
 =?utf-8?B?MHFHTXEvTVJNN1lreDFUK3l6M2YwLy9iaUV3eFRFNDVjeURRUHNpT3RqK2Z0?=
 =?utf-8?B?ZmlVU25qbnhTZ2hzeFZMNDBUeXR6Z2s1YVl3VXhMWVlRTnNXU2FCeUJJVzFh?=
 =?utf-8?B?cForM1RCbVptdnJnUGJIcnhTN2NnQ01uNGJnZ3ZzcVFrVjFzNThFbFRsTHJu?=
 =?utf-8?B?ZUtuQWxFN0wzalUwQzU3Y2tuNkp2Z2EvQlVyZ0VDTC9lL3o1WDNTSmFpd1pB?=
 =?utf-8?B?b1ZOQ3Y3QW9hZ00rNHBtajhiSVdvTDhuSWVmZUNPWGNjbVFEbDFJdGlXQ3pQ?=
 =?utf-8?Q?D9R5Pak5Qw+mf4Vn6fKc?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c664c54f-2a38-42af-b6f7-08dc30f7b05a
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 03:05:56.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB3607

>On Mon, 5 Feb 2024 at 11:23, Jinjian Song <songjinjian@hotmail.com> wrote:
>>
>> From: Jinjian Song <jinjian.song@fibocom.com>
>>
>> Add a new WWAN port that connects to the device fastboot protocol
>> interface.
>>
>> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>
>AFAIR, I already gave my tag for this change, please carry the tag
>along versions.
>
>Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

Hi Loic,
Thanks for your guidance.
Sorry for that, is it possible to carry the tag now, I found this patch state
has changed to accepted.

>
>> ---
>> v2-v9:
>>  * no change
>> ---
>>  drivers/net/wwan/wwan_core.c | 4 ++++
>>  include/linux/wwan.h         | 2 ++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
>> index 72e01e550a16..2ed20b20e7fc 100644
>> --- a/drivers/net/wwan/wwan_core.c
>> +++ b/drivers/net/wwan/wwan_core.c
>> @@ -328,6 +328,10 @@ static const struct {
>>                 .name = "XMMRPC",
>>                 .devsuf = "xmmrpc",
>>         },
>> +       [WWAN_PORT_FASTBOOT] = {
>> +               .name = "FASTBOOT",
>> +               .devsuf = "fastboot",
>> +       },
>>  };
>>
>>  static ssize_t type_show(struct device *dev, struct device_attribute *attr,
>> diff --git a/include/linux/wwan.h b/include/linux/wwan.h
>> index 01fa15506286..170fdee6339c 100644
>> --- a/include/linux/wwan.h
>> +++ b/include/linux/wwan.h
>> @@ -16,6 +16,7 @@
>>   * @WWAN_PORT_QCDM: Qcom Modem diagnostic interface
>>   * @WWAN_PORT_FIREHOSE: XML based command protocol
>>   * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
>> + * @WWAN_PORT_FASTBOOT: Fastboot protocol control
>>   *
>>   * @WWAN_PORT_MAX: Highest supported port types
>>   * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
>> @@ -28,6 +29,7 @@ enum wwan_port_type {
>>         WWAN_PORT_QCDM,
>>         WWAN_PORT_FIREHOSE,
>>         WWAN_PORT_XMMRPC,
>> +       WWAN_PORT_FASTBOOT,
>>
>>         /* Add new port types above this line */
>>
>> --

Best Regards,
Jinjian

