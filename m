Return-Path: <netdev+bounces-49985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2108A7F4330
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4492F1C209C9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284AA4B5A7;
	Wed, 22 Nov 2023 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e9tsWRV/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0F1727;
	Wed, 22 Nov 2023 02:04:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn3IDjBH+yLJF0jsJV/lQPFmi+6k0Q/Okv7s39am1P3o48E9Lgz+xGgSIuaM+XtZaY/g53pM6s6xTprNLIDwZA9Pxxqc+QOCqnrik5ILdPaE1DbjC4z94pR8JuglxxeSTniokEZ3nn7AwVRHQvzCnQRNOQNoyRoBKh1iUvOIzLOg05J8z7sDei///+0LSuxJmvY620h0WPw8X9Xr7UIjjJRFDlM+ZW/WOfZyl6dcolEWRsQ+EQ28qKnCAg+7+biRmLxR6wDcHU3DIyIpuNF3UtQMGJ2bvM9U8T1cHYZ4nBeqX/HrJof/YYcNzQdv2ywfZzpzuKwy3BhpNYCfNsQaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azbMCHCMonJtbVmUle23kBXZkAFUn88QKjtL7P68+Es=;
 b=F0HNa6wCTjtdbQhI3JhgAfwbASLdMTPHDiE1sv/+0/vgGwCUnZiAQozDWXCJmUVuyZP2neBC+FaofsMLD31xH/MoM+EHlsBiYLAO5vHrKiVeilxnaCZSIqV7DhBpif9UvKm+Veww5wxACu5/OFacA2nh0/Y0uGUbruDJqRJUX3LOnviXyC3DOgOMKyCoAQAh4vr928cC0qHwSYkT29altMsZFH90R+l3RmaxP9jB3+4GPadWT9knebrKi9CAq+7pLxV2hXUECzqM+LbYAolMwHeKFVsljAdC+FHR8IUY8vGQaAUry0P4o5LE1B5CJFxojKzn7Aqxo767zUB/u+Tcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azbMCHCMonJtbVmUle23kBXZkAFUn88QKjtL7P68+Es=;
 b=e9tsWRV/sHTdwEKPleblGgk5iWf5qD5DEcSo4uwrikCa6QLCNKgDjtyXJqOYrrGOQlZO/OY9+ZuMX2nw5n4b5Zt3Ba1x3vH85xtI7gs+iZLHytESvq9guogMsrTwuSbguMMKDQM2k6TLv6OjPfjWgM+IE51MnWFIvWVSmPiCRgFTAPnCiScHVs1x5m/FZEUyBEdVniXGsogsDvP8l4/PfAfXhzz6f5KEBArV2WSt0juZ+Yohs+ixVUjyurzyyCU/wezKMva8wk3fFZXyFb63uVoxvq0/WF65DEZUuK1/+yQk9FPDICaptrw7ul58qj4s4v7PzjIX3WQKB/w+b9A3cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 10:04:34 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 10:04:34 +0000
Message-ID: <367cedf8-881b-4b88-8da0-a46a556effda@suse.com>
Date: Wed, 22 Nov 2023 11:04:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] USB: gl620a: check for rx buffer overflow
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Oliver Neukum <oneukum@suse.com>,
 dmitry.bezrukov@aquantia.com, marcinguy@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
References: <20231122095306.15175-1-oneukum@suse.com>
 <2c1a8d3e-fac1-d728-1c8d-509cd21f7b4d@omp.ru>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2c1a8d3e-fac1-d728-1c8d-509cd21f7b4d@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|DU2PR04MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bcb2fd-a21c-4beb-7e76-08dbeb426d59
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W10XA5IfinA9fcg9xhn6s/eqDZCPqCtHDX2ZpDiGPRrVOkvyIT8pzv/KbDb0UImcmuc0xdVOI4M43QyFbGjm6DlbJx4WNFGB+cH+DCOxFjtQezUGjNXYsy/GBownANIfNxPcWvVNGU0fr4tmjjhqSUYhLpMqpXgFZLGBK7i+0TFCsmXLNMG+bSdCXLncM/OE80ZbfZ+wAdR1bvFXlol1HRrGmxpK32pR3HBgh/od+Tl2hsmuziwaoMnVvp4iiJOjIav63ggs+G3uJyv9TIQ/ptLqz7SgKYMyZXD7U0s4yJudwamgv85Lm5jcktR0LVU1htR+ooiukz2SQ681LKioZmpNAbGjqhesBfFg4qte/us6AvHOlavpnXKN1l7CzJxd1ieyGoT/gzgvUEmQfTHj1/sI9ZTToYpcTflad8HVKkzRlPoRRhAC6qMW+jWGOu2YMIeg4thF9hbAPh6hvEVmqz2qo/e2VEV1awRL5l4c+yigItzWbvDRgS9rFzKgBlwNVdN6ywT7uoTQLp3U1Pfsi7XjSqg+erzv/eA0Wm6ZzNGlOL+Wep6ZXf4ZTXkd5zwOS3TQoAnpV356OFnnEi1zPVimXEu17VPpGW/2C1kifaE5cPAaeCMS0JnbHI9yq35GDQNoWsmZGk9l1gLW3oYsx6PrCX8Ut2DtwF/Go9FzYvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(53546011)(478600001)(2616005)(6512007)(6486002)(6666004)(66476007)(2906002)(110136005)(41300700001)(8936002)(8676002)(316002)(66556008)(66946007)(38100700002)(921008)(558084003)(31696002)(36756003)(86362001)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHoyb2tIMXBqb3JmcjYzeE1HTVJsQWxsenlEK3JQQlI5MVNYdjcwSEdxeU9n?=
 =?utf-8?B?OHI0TXpqMURHVUhWWlJZckZvOFJkU05zcHlxZjJwaFBxMXFGRlJyMURnRW10?=
 =?utf-8?B?RXNpRmlGYnFxNjNEMHQxWC9saFQ1cGlDU3d4SjhHd1ViaXczRUZ0K0NTQjh6?=
 =?utf-8?B?Z21hdTFraVNLU1doTkFSN040V0VLSDNFVkR4RFE4Z2srRlFDUFhEdlFIdnBR?=
 =?utf-8?B?R05Kc1RoZ0VXWVR4R2JldGRqOHZxMzIzUUtxVzNGazJ2MFkvdlNHNSs0Mkwz?=
 =?utf-8?B?YThZNWR0eWV3Tjk4d08rVXljMWtLR01JNzJjSWhPaEtuQnp0UTJINzg0SVpx?=
 =?utf-8?B?VzJGTzNGcHdGS1F0azB6TEJhQmhySzlmRi9WZnd3eVBBTHlmTWRIRjIyaEVn?=
 =?utf-8?B?OWtpU3EvSUNrU2hxSkNFQ002Sks2UEVFM0JNTW9qNmlSNDlidjhKaTh0S0ZF?=
 =?utf-8?B?NjFEWjFXMFdNLzJlcW1rMkJSbTlLTWpkL24zUVBCZnNrQjZMaWFlV2UxTnJ6?=
 =?utf-8?B?UnpEaVBuTGEzUWZSeS9NM3dsaytkcHpHaVFRaXdEMzBHR2I1RlpIckJ6dHVF?=
 =?utf-8?B?aWtnYndTU2QvZkQyQ214UE5naXlXTWtUQW1lbUZpM2U2MHExYWxIOEwzUng4?=
 =?utf-8?B?YitQc2xOdU9FazlJbDduS29qVU5Ma3A5UkhvTHNxOFNGTUk2UzIwWWhmRTEr?=
 =?utf-8?B?QTl2MlZLY1crK0JtUGVnTTFYQmQzS1NFZWlwUXZ0NEwreHViN2lJbjVNSnE5?=
 =?utf-8?B?L3p5QVhvMmEzbTl0MWtSM1ZVbWVKd0FsQTQzWC9OR2U3aEc0NEcrRXJ5OVkr?=
 =?utf-8?B?dis3cnBBMXZnVUlsaHk0U0hiNERnWDdWQUluRjZ3OTZreXBNTVRmRDFjalAw?=
 =?utf-8?B?aXhxT3FGUzhhRk9OSEtUUkRQMENBcGNiTnkxTk9qY1BteHFJUkRHOEFzR2Vo?=
 =?utf-8?B?Slh2M3BoRTU5dDVINWwyeGplNCtUSHdBRkpSMyt0MmpybWJ4RDZxNnE5eWor?=
 =?utf-8?B?aFVxMlhLa0pWUXcwMmt2cldnWXJFb1ZZd3E4SXhpMXdNNU53ejhVMkJ6cEFp?=
 =?utf-8?B?amxBY3BKU0VSZDNKMlBzazNlUWF6NXA0QW5lRGtNMEZCZWI2VFp0RCthdk8z?=
 =?utf-8?B?QVdCNkhtSjA0cnlnSjhURFpkS3BtTTV2YmZBc3Uxb09ScVg5cENDSzJJcDAw?=
 =?utf-8?B?WUJYVmJpQnlRTjZmbWJHKzlleWExRFBJTHhIUVZqelBYcEhraWREaE03MkRB?=
 =?utf-8?B?Y2pDM3loMFZRNVVkRUxtb2dubWx5cGRsRlVZVU1NUEtYUXh2TUVjNVVjc0dq?=
 =?utf-8?B?cVQ0TUVaT1BOc0tHQ1RKdTRTNE9IVVJ4NUd6UW9vR0pwSGQ5MWRBSVU3UUxx?=
 =?utf-8?B?YVFaS1ZiRXppQzFib2FWRjBYYkY2OE56eHYwUE1zZGwwWGRzS3V4S2RJTW1p?=
 =?utf-8?B?QmhKcit2TmZ4QTVuemJadGlCU29MVWNuUi82WWpKUmpOVTJET3pUQ2xaVWRQ?=
 =?utf-8?B?ZVNDR05GNVFCMHZOQ3RRdEU5cWJ5TkxlMUJaUEFIdkpCa0Z3cUl2OHpVeE1n?=
 =?utf-8?B?d0ZRSVU3RFo1YnhDOXBBeHV0MUUrc1J1bnJkUjVDYlRwMFhENFFtc210TlBQ?=
 =?utf-8?B?T3JzR0hSTTc4VHBIN1NBbHZpUVB4OXVCS0ROVm8vc3I2UkdWV0tsNGtDNDJ5?=
 =?utf-8?B?azdjYTlhY2YyWDJaVWVBVkFLM1RROWI2ZDdTb0V1cXR4ejBYVldCeDIzRnZv?=
 =?utf-8?B?aFNCdVZaNlY5Wkg5MjFrT1R5a2RLeHo4UjJhUld6Wm50VDYxb0lJV1NMTm5S?=
 =?utf-8?B?N08zZURpU1NILythNWhtZ3VGWFhuZU9CbHNLdjVFeVFHdlM0dkNWZ0xGcWNT?=
 =?utf-8?B?ZW1vZnNQSDM3RUtjQ25WRjRvaGdrQU9jQ0lhMTdXTndSZy80YjJnTHdSdHFD?=
 =?utf-8?B?WUVQcDBtbUZWdW5RTU8wMkVVWCtxZ1JQQXRsMmI1N3A4dnJzRjVPR09FTlYr?=
 =?utf-8?B?MytHZ01Mb0ZSNm9GZUM5OFJrUzBqMGpJRkhiY0IvdzFpQjBOTlFUVTRWbGEy?=
 =?utf-8?B?aEJEWG5WUzlQdTJOT09PMEt5WUd5azQ3YkdrWll5WURoaEJHQWYvT2pSZ3U0?=
 =?utf-8?B?RmNIWjIwS21mbHlmR1NKc2NmZDdPL3lLWDdHc1RmZnZFdGhsR2dSVXpFYmpO?=
 =?utf-8?Q?lPaG+DMkbUbYxZVioqdvXMDIjlIVCxHVtgOfHB+CBmbY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bcb2fd-a21c-4beb-7e76-08dbeb426d59
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:04:33.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wlgz1R3bIShElFcGt3QG6/1dlei+2ZUqZyIfB+RNY+tjhJEWQFNW/lXjW+NnIQdxnRpjy0GKJGiLxyUjx8mI2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083



On 22.11.23 10:55, Sergey Shtylyov wrote:
> On 11/22/23 12:52 PM, Oliver Neukum wrote:
> 
>> The driver checks for a single package overflowing
> 
>     Maybe packet?

No, that would be read as network packet, which
is precisely what this not not and should not
be mistaken for.

	Regards
		Oliver


