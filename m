Return-Path: <netdev+bounces-48325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D58737EE0FE
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C44EB209D8
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C1E2F857;
	Thu, 16 Nov 2023 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W1VFTJw6"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA3B11D
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:02:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeCftpHHLfPgpAwxP36ZhD+OZkBVeOsnQRVDMLRf4CV6w91Dsn9qAel0MCK63pAAmC+uGLpiP3L6NJY/HBA7KO7Wv6FZ3LCivJN8+dHSdYGwR7+KvKidebesgdMkt66hDZ2B45UzLGcS258ueWM7AQwNmCuLHBeWQOAeRV5hENXy9XCu8gffwjxnUwRakhPLptYOy23Zo8nPLSgJo7YKa03Xm88c3tCvyxswysgX4BxTvhG/dgBH2Y0Lv+Cbd+S9JZ56ZtPNHeGOC2fza3XqPydbNgzC5Kcjza2KGUI5rhMlykbjqOT5nczFAZ2V6wPELRpnsNYjkMmXCfFRDkinCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHpekf8dMwnbl/UZLS3dA1S8v0wiclWMNP25lqJc4zQ=;
 b=BTqZc4nvXAO85/h8NsBMe5xDc/toe2NX1DerRAJxWrK5GiOn0TAkl/BZgnGWaSbGOequPSZUlAVBRCzV87bDplU6j3Gw4GvGcI72qyj81anWFLWxfDLyj2qzIwVPRa58BtJVcPST21opqG8+9xXeCNJnKMT1iMvuqPvZDkmORD8aruEqLwoDwN4ZTgiS6fl5/Tut6aBWbcKwqXlVPYawuHct7W2oqOb0js0Bun2aEmBeUR6ZEMKLfncFNA3LrJDRtoLWPdBB77TKwbh6wg6MswT8oymFHxzNrVLw0H/WtRtn7Kzwa5l1dX+nR5VwBMc0tVDtvU/Ik2m18P9sxT+6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHpekf8dMwnbl/UZLS3dA1S8v0wiclWMNP25lqJc4zQ=;
 b=W1VFTJw6Wxl+ljBsMeK12MKZpO9EoAHWHTUdRRhhrdoNpAXZe0lrNIVtwqWDR0gaZlgnqtsYEMzAZ/PvVfSirdtnVA055cm4FneNx/5yOk2qBSL4nUFRYzfXc02nyHNeEERxNzbWc7AsVwj1crnDw106zXhJM0BYoztDTaVYQPVKPYNmxVXo7siEDl2HnJrorf376uir1fV80PLWxhlkeddabpysWrwIF6epkwpQx+WHeSUoRBNGbzm12KpB0Wz5a9ZJ/xfO3HDv/EGjTNlE29oDA/JeRvyRLOtnNXv1W/IxaI3jltj5ehyoFtHSiMgbGywkuzHEiHF0wMRNrielNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 13:02:50 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%6]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 13:02:50 +0000
Message-ID: <774a8092-c677-4942-9a0a-9a42ea5ca1fd@suse.com>
Date: Thu, 16 Nov 2023 14:02:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] usbnet: assign unique random MAC
Content-Language: en-US
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org
References: <20231116123033.26035-1-oneukum@suse.com>
 <87ttplg9cw.fsf@miraculix.mork.no>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <87ttplg9cw.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 2990dda2-f0f5-4872-81f3-08dbe6a4566a
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T2bHg3cBhA1ecx5r89imwTHXdiUU8YcTK1zAEkAYpt2E/GJzH4LlQBCK6CkiIKR9AtOJJkffu0WRJbrRWNYWKndFDNJs62CHbnoseEjdXE09HRMQMnNz6gcaafYkBhRLpsBAmtQtjd7qg3xl+roBeKCXcluaVMCtTVpsugyWo0QGcJRJyjZFUZCheBb5uP8unG9NKB2LkU3dSBqH6EBAvYRdSLs6h3idLvuU1H70lsq5zA37uU+pNo/w/5v89SYvRjz+NuvQ079VZO9SmSZiSbDGDHw6/5fO5DLpfNkdATnstTF+GH0/XfCjxBEZdKCD2LocCZ+de9AgX2fDsS8lh4oMd/F+2zpVBHzhnF8E127PXMqAVWmew31mnFXeaon607SIgMhU7+YcHpE6PBeGvxOKrl17OnyWfm1bh2Ad8rZeMcVg+WORt9p+fLto9ufQSuWBSNQewAXToHvOPIkRO66d+lF0sHYW5YcuJLYXYWMx/Kzlu+E7Bem17nfBJcEJOjtY4IfdY31qOiyxRHTphhD7iJy307m9pQ8E3G+w17gQka4Lta/YdCS9vgUTsLlKdw0qWNx0k90ekfynwm7kyfS2NYfQg9PvMiSBoA6ZIzARI1Cjiqrm+mMlHVg5niRHJ0Xs/L3a+AEqWHtmP4o4Ww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2616005)(66574015)(110136005)(83380400001)(6666004)(6506007)(478600001)(53546011)(6486002)(6512007)(31696002)(86362001)(5660300002)(31686004)(41300700001)(4744005)(38100700002)(2906002)(316002)(36756003)(66946007)(8936002)(4326008)(66476007)(66556008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3UyU3VaeWRhdk9tcUZZVk1BL2RZNHNheFdKSGxpVkt3eGxsekVmNXF1YVl0?=
 =?utf-8?B?bXhEOGw5cWJDdGJSS0lDdklESWtSMmtWaTk0dzhjRGtuSHdYejk4TjFNeUZ0?=
 =?utf-8?B?QW03V3FQbnl4dVVSWEZSMlA2OGVJc21tU1NnUnhjNFhLWUx2Wi9tRndmUFVI?=
 =?utf-8?B?bmpYZXNaODFiYzhXa3gxcWExRlZISDE0ZTg3ZS9nSVpuQnoxTDhlU2xJb0tv?=
 =?utf-8?B?WDJ0Smc3SHlGT04zVyszNkEyd1ZXWUxTcHpYcHlxVVhJVmpSblpmL0U0cEta?=
 =?utf-8?B?M1IvMUlnNDJ2OFl0d3NSWHRzaklic3cyQ01Xc2lGZFFaR2Y4d3l0SDBLdmNV?=
 =?utf-8?B?cFE3LzBwMStGa2c5NVMxL3dsT0tGeFIyODQ5alRmSkd4OFFSdmRCWDRkWkdN?=
 =?utf-8?B?bTFicElqZnQ1NlFmdTA1RnBIQ05lSWJzUGR2T1VyOXFqWjBiUlVBWGY5OWRs?=
 =?utf-8?B?Y0ptdjNlYjViNGZxaUpoNGFGMFI4UWRrYmh0YUZpOXMwMHNMY2FCM2lSUUcw?=
 =?utf-8?B?Zkdyc2FTd0hqKzQyMDh6VVR2VlBMUytIdDdMM2xJbWFQcWVOZTBGbkJBdWpr?=
 =?utf-8?B?NG1Zb2hOTG1ZeTFycDlwcW8yUWpEZ2U0VTNoSC9wd3pzam1CRlZKb1hMTkw0?=
 =?utf-8?B?Q0Vjb3FZUEQrSUxxZngrVlVFNmkzK1lFVEpmcU8rOEVRQ3pJdit5aDVlWXlX?=
 =?utf-8?B?ejlYZmUvREdlblRpSEJPWGQzVGMrc1JxeVpGckh3dFFvY0tDcURpZlRGRFUv?=
 =?utf-8?B?a0ZIQzlkU1dYemNJL1NwQTU1K0YzWW0xa2RFd2hYODc5cHhMd1lMd3FqbnNE?=
 =?utf-8?B?bEhydjZnSWw2VkFqZ2Rzcm9GT29kSFBRY2V3aEFGRG1VNHYzbVhkRjZIc3Rt?=
 =?utf-8?B?cmxxL2hpZmViQUhzRVRFZmxQZ2oyWnNTTTlyWklQYnZDYmYyZlFaTXZQRTdU?=
 =?utf-8?B?a2piZHA0cVh0V1RzUGRscjZ4elhsUVdYNUJ4cWxvOEZIakZheHRKRVUza1h4?=
 =?utf-8?B?SC82cHhtVmExc3pzaWxrTzRFd2tza3VsMVBvV2VERkNyTUdIbE92QXQ4Q1da?=
 =?utf-8?B?aWRZeDEwTHJPeHpxRW5HVXlTaEZLZjhMUFdKZUtlVWcyT1VqTjkrcllrdlh5?=
 =?utf-8?B?bXc2WVQ2V3JxMXVKMzg3eU1LeGVEWmhMZTA1UVlSRTNkTnVaYlZ0TnRlY3Va?=
 =?utf-8?B?MXZQVHp0OVAxZm41VDA3Qlk2N04zK2lhTHQrN2gzT096Z0lmelVYU09lY2xh?=
 =?utf-8?B?MUJWZTdCb0JkdDBLM1hzSmIrN2hjK085ZGJMWTNXSktISTZaNDdIZ3dtUkRZ?=
 =?utf-8?B?ekQvb1VPajlNaHIxUllSL1pqN0lEaTFkQ2g1WlNNS1Y0bGJzaTArTlllL08w?=
 =?utf-8?B?SWFaWi9oVzNCQnYxRzNQQkhKUjdZWGhKWVJrSG9GN1pCQllNM0p1azJUT01m?=
 =?utf-8?B?TWxzSlRkSk5udE1YYXc5dFJPY1p4ODRub2ZjYW1UamZtb0hQOHVZVFZlVjV4?=
 =?utf-8?B?Y3NXamd0SE5CbEtETytweTFlejB5eDhrTGRWclM2L05OL0NMWnNGbmRjVTVa?=
 =?utf-8?B?cFF6L2JBZGJjYlFpR0dOcFBQc2RqUXZHQ1dUWTV0VkkwbkxjQWtwV1NNQUk5?=
 =?utf-8?B?U3pGdGZ4RldEMHFrdjY2Vlk3TjNsWVJKaUJ4Q0MzakxIM0tVcWUyRHVhTXFi?=
 =?utf-8?B?VXVGNmx3UVVvZk41aXlDVTNBQnpzZDZ4WkF0Zy9NeGt6aTErOXBZWFNrZ1dW?=
 =?utf-8?B?RDZrMll1ZnREZXJ1STVqUEVsWmdhQ3BHWGMydGd6Q051ZE5Qa1pLRFowN1N0?=
 =?utf-8?B?ZWJLTmlqWW91UjFEaU0rWm10azF2b2hQb2owT3FHa3hzWGwvY3YwSUVPVWtR?=
 =?utf-8?B?TFNCVGJPRWhUSkhmY3cyUXpwUUQyTnRJeU03RkNrYXVoUWgvbXRNSDFZTzlR?=
 =?utf-8?B?NCtWYTZMV29nN3RTdjlKVkNZa211czBpazZscUxKYytSeU1jR1BONWI5UGQ3?=
 =?utf-8?B?alhQNU5SeU9hRGtlS3JvTGt3ei9wRnY4VXpzQUp6ZS9tWVZtdE4yQWFVWFdi?=
 =?utf-8?B?STR3VjdaQzh4U1kzQlR1Qkt3eVhja1hlRDdNcnFnRHkxdmRJRnNyYmdWU0Vj?=
 =?utf-8?B?WjZBa1NIN2dWbXF2Sloydm5vZmpTTzE0ZlJQUXN1d0g2QWRFT0djNit2ZkRO?=
 =?utf-8?Q?UdHBbFUZBVOZCi1zAe3mcXlIdYtI52a57XNvgsOtmVid?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2990dda2-f0f5-4872-81f3-08dbe6a4566a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:02:50.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNJ/cBlAvvIhITJYQeysr/nbd1QFpwmA5W4mGrgALHdib6edtZbs24hfSTkkl1hddd7fhaWGMsn/e8Sbh52phA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885

On 16.11.23 13:39, Bjørn Mork wrote:
> Oliver Neukum <oneukum@suse.com> writes:
> 
>> A module parameter to go back to the old behavior
>> is included.
> 
> Is this really required?  If we add it now then we can never get rid of
> it.  Why not try without, and add this back if/when somebody complains
> about the new behaviour?
> 
> I believe there's a fair chance no one will notice or complain.  And we
> have much cleaner code and one module param less.

Isn't it a bit evil to change behavior?
Do you think I should make a different version for stable
with the logic for retaining the old behavior inverted?

	Regards
		Oliver


