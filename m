Return-Path: <netdev+bounces-48453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBC47EE61C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62731C20921
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96FE47784;
	Thu, 16 Nov 2023 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TdV5KPPN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10DFA5
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 09:45:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzXOdMFYTwVse/AHCDc81iPj0S791oKK3p9v+ShrYLXOSk3jPnhlz5yJpCBhnallagWWc9aApinLAJJe9tLmAZfGVKLgGflMgpJbp2hmMaz5r8p0OlO29ga9XGEOAXJa8tSOSM+NwO5JROi3NeRGJeZUMjbROE/Bb31xYW4a7co+1LzbdsvlpRSDtWfWSnbW32ppgGKkSK2BKoQOtiFoMlwBnQo9P0Y6vj72LvTHnlqqVpozmWFqE9p8y+43KreHOZvHgHtf0rp9Cw4I3UBhthBvUopNBNkHTHB6QTd06EHnVLmHW2bC0OLQYp7rkEsgTFxLgaUxFywh46gyy5VEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glLM556R7EuRaz7JjkwBdJdevD0uIS6nnKEgWojMNYo=;
 b=cxlh86jzK+ewA+Zp4orMkQ3KT1cVzD0o4HlMT52HmDzHP+XoZL7pr6XRMFbDjhYB3XIaYNiUuGC7Z834+p3LsHAoc55mboNre//gbRtQPXV4TYoQ+fD9SlAot29WcCAfWmYkZ7ux+XP96Zy5GkykznzObUP9sOXefymPvFPx1s7/av6YTIZmBN5hr2UyIEr5hZ92JVp1LwIHq/8BILqbbmDGNZArOMQBQb+aUejYI5RR7wRXm26paSuYEoY4j9VetXv6tcK2a4ZMf1hSTSfk4o4dMGsh2tukVYgGaNgujJqQ2Ef7TfRT9Pyll12QQxfC07N2W4pABd6hJv2X+rkP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glLM556R7EuRaz7JjkwBdJdevD0uIS6nnKEgWojMNYo=;
 b=TdV5KPPN1umthsnzvNCa19XHJ/5D+bqijvzqhZFywvYr0pOSTVZ6jsL31yidkWuISWHof5iluj3thKfkv4NYzgjqw2QtTtsU35swYwecjmaLdazcU9Nn+tBjPSc/BM82pbyHgNeYESl2v2xgZizY5D8eDfyRyPcBVfiyMJqg/nhvCYtPDavc0SBYe41z+cIMR8SBcZQfqlIlHqr+qCPhQ2/v/Do2UFMVh0gwqSacjZMQHmKvPQznfAWTNhcAOJLFqy/zQuEmE8yHuDau9AaNJnArCobrm2aJFmen/8Qud/TPcFGWClOD0gG9TsK3MwXhIzPExw5mpynyQtTMgnhMtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6478.eurprd04.prod.outlook.com (2603:10a6:803:12a::10)
 by DU0PR04MB9672.eurprd04.prod.outlook.com (2603:10a6:10:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 17:45:30 +0000
Received: from VE1PR04MB6478.eurprd04.prod.outlook.com
 ([fe80::775f:9e9:ef9a:6a09]) by VE1PR04MB6478.eurprd04.prod.outlook.com
 ([fe80::775f:9e9:ef9a:6a09%4]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 17:45:30 +0000
Message-ID: <b8e59ad0-c22b-4e44-94e0-cb46c4bbd5be@suse.com>
Date: Thu, 16 Nov 2023 18:45:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] usbnet: assign unique random MAC
Content-Language: en-US
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org
References: <20231116123033.26035-1-oneukum@suse.com>
 <87ttplg9cw.fsf@miraculix.mork.no>
 <774a8092-c677-4942-9a0a-9a42ea5ca1fd@suse.com>
 <87il61g7fz.fsf@miraculix.mork.no>
 <6eba35aa-c20e-434d-9d4d-71c1c06c7a1d@suse.com>
 <875y21g3cv.fsf@miraculix.mork.no>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <875y21g3cv.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To VE1PR04MB6478.eurprd04.prod.outlook.com
 (2603:10a6:803:12a::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6478:EE_|DU0PR04MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: 415f89b4-46b9-41d7-f568-08dbe6cbd347
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cT6E0si7jlNHFZbDFX/mCoQVrKx9R969jYJIX/hgtZpuCm3kPGeH2kVsNJv3f4pGIuEFZ0F3SVwxzlK82MP9esd6hwK+/0MeCJujuYJPhX/GNYWEMqByujAXjOg6nqFBVskSLUBCAD6FdykQ0kBl8f24PiNP3SRO6czBwXgaFFGQKFUe9Z1TypLjS55/vejgzrq83e47mdtNjeGybViOxMWglEi8ELTh1JtwNpPHSiAAH6iRWgxBCjGK4D3GGf21UuhqDUj5o9LCTH4rC0epnG0G/jNbJXyaDjkhFpWgfiGHsCMph5AovvmJ9HMDDI9eApMJ71vxGIW54vCNdKSSH1RECwWDNmj8oQ3rei0V1GZQyRJVCxTQAMd8Q3HQqwCWWMHokjty5wUOzAiMa4yZvAElmRsFgnUXG7sk/y2nAC3xAcAhMq1Ld4auVNyZgZrJPx8CmOd+wqF1ieU2QZheJpfEyk9bNWRM29t4BziYZQ58HhezbQUGB+a7M5SUd326u/j6LVlnhqrKd+1V0p17tJ2EJycbfOk5EqZg2EC7CaP/FDvBaeNgNCxSitEsf2olgIEosNpspkXIbk9+CLanzh39ZWDWqqT15X3H6zKCIedX//FbHkCF9AoDlgTxQeF0TGCbOn2BT0K2JSrHJcgbtA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6478.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38100700002)(6666004)(6506007)(53546011)(31686004)(83380400001)(2616005)(6512007)(86362001)(41300700001)(2906002)(5660300002)(4744005)(66946007)(8936002)(36756003)(31696002)(8676002)(110136005)(66556008)(66476007)(316002)(4326008)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFAyWVRvV1RUSm9RRnl2SGFKTFl6aUwxZEdZcTVhTXRSRnhFeXBpTnZsNlcw?=
 =?utf-8?B?dVpucVlwWDVOdml4NnNIUkpnOG9kRHd4aUhxcTRQbXp0MHhmbllnU09OTURY?=
 =?utf-8?B?a0g3SDJDbFlpODJuSEE3YW1ZRmR6Qnd3NDNpaFZmOFpIaUxSQzlrT3JIQmhO?=
 =?utf-8?B?M1NMMlArcW1kY1p0Q2VGbWFXTkpKZERVN2lvc1pUQXNkL2oxNGQ2Ri8yM1lh?=
 =?utf-8?B?TFFvL01uKzBtTzNrRmN4NWVucXN2VXRUZm5ycUQraWR5cHEvMWxPR2xMeG5s?=
 =?utf-8?B?RXFGelpxREc0MmtYUjZOZ0Fqek5QamxEY05QelBYbGQ0eGJ2VEo4L3hKbUpr?=
 =?utf-8?B?SzQ5SUFIaWxCUkpiZ2RrQ25PRVlVaXpxaFVNTXkxZlFiRjJlSHYzYm1JQVhj?=
 =?utf-8?B?MmlXS0lPRUhsbTNiREp3NTEzVG9nOVp1Zm5ualF3MkxZTHRFRFpFQzcxWlVv?=
 =?utf-8?B?eWkrUnp1TSs5VmJIN3ArL1dWcmp1N282NTVSY2tmR3pXRndwRGpOUWFqM05k?=
 =?utf-8?B?Q2VBUEJCamh6YnVpVDZ0RHQvbHVHbVVKWEtMNjBaOS82N3p5OUIyZVdxbDVL?=
 =?utf-8?B?Q2crRmtxZWVPSHRueHNYbk41eXFGL09lMjBJbFlsbldZRjhKdmtabUYrbnVm?=
 =?utf-8?B?Y2NoeHA5eWlTVS9Pa0J2TktEc25mTHNVd29xdSt2YnVPcE8ramY1YmlBeWhH?=
 =?utf-8?B?T2tWSms2TXR6Y0xPRndiR1RzZzl2d0pPTHk3QzFZSmVYbGtmK3VuMTNIUjVP?=
 =?utf-8?B?bFZVY0V2U0tnV1lITEIwQndQNEJ2U1djMSs5VURuNnZZRnlaRUx3SWgra2hB?=
 =?utf-8?B?REZRUEJLS2ZNTHBtRWNTQVNqWnhHZU41VHdURkg3WnFZQzBwejdIK0ozeG1T?=
 =?utf-8?B?eS9CcXBEcGRkWXlzbGJRSVdyWndhbEYyQ0x5bVJ6MXhPSnI4NWlYRjV1TFBU?=
 =?utf-8?B?M2VvaW5hUVNmcFVTdndPNDIxL25sL3NQZTdRcHJ1QTBHcUgySExYRkY5U0I5?=
 =?utf-8?B?Wjd6T1RwUndoOGNPTnUxVkJUam1kSVQxK1p1ak5jR0F3NjUrU0pFYlJCNzV1?=
 =?utf-8?B?cVllb3liM3NRUDVzcFJBakkvRS9rc2k1azlsdUZ1cExUaEg4MGRSVHhsa3FT?=
 =?utf-8?B?aU9MTVloSG5QU1BBSlZkN2ZiSFcvZDhUTzZ6eHNSMTQ3QjJqYWx1bnNKTUsz?=
 =?utf-8?B?QmRCcFZyd082ZFIrWjBEVDQyMkRrdjFkWDd2S2kranlRNDlVM3pIYURXU2tz?=
 =?utf-8?B?d3RseC92RXhqdVlhd0FHU0dtNGVRVlozQ2c1Z0F1T0dGYWkyQVo1UVU2QkN1?=
 =?utf-8?B?Z2dsdlJPakROaVNTOGlCekN3UWFPZGNaM1MvUVh2V3ZkMmt4WjNTakpBbENF?=
 =?utf-8?B?aS9QQ1VKRGFtOFFpYlVQNjk1S2JsR2JqdmZLM2lOSmV0Rkt0b2p2c3dUMHFk?=
 =?utf-8?B?dWdtdzdYRW5hVEhnZEpmOE5XRGtGRE5PVTVqT2hDTTZDZUFxNXY1UE5qOXpo?=
 =?utf-8?B?WmtybWhWSDQrU3JVMEduKzdWdTl4UHg2YVE4Q2t3VkExb0NqMG1sR085VG9T?=
 =?utf-8?B?WCs3eU5Iek9tS2RBUndDbG54QU1jZFZZbWowVDFRcmVWTVJKWXhMM2drMk1J?=
 =?utf-8?B?ZEhnMWlFQTl5cW9wcWJDMHRRTzI5bkNmRTdDY29aQUZ1M0pISUZ5WHdlSDBk?=
 =?utf-8?B?NkNuUURHSGExNUE3VzYyZHl3R01BTldPbWxjVzllR1E5cW5SQ3JyL3FaQ3N6?=
 =?utf-8?B?TVJIWklPUkFKb2hqZ0V3RUtEdjFSUG5hYTRKbFBwWUVYaWRCTlA0UzFFT3Vx?=
 =?utf-8?B?YldmWnVFV2M1WmlkdTVTeHo4c0pNZGt4Y0xXYU8vV3JHQ29KNUI1d3dYQXdR?=
 =?utf-8?B?VU02YmhKZmh0TnY4VllTYkw3czY4TTNDU3poa0FLTDMxakJZc01xcFB2NWdR?=
 =?utf-8?B?azN4N2xFMHhGR3NNR3RjTlJKb1NKYVl5WTRhNkdqN3FxNEsxNkswYmJxY1h4?=
 =?utf-8?B?US90QWFROHUwdU4zZVdDZE1OTWlWaTM1cnJZcWgxcHEzRCtFeXZGSEhoa3da?=
 =?utf-8?B?dzViMzFmWDVweEYrNmpEU2JTMWplcDVpR21XNmlOM2Nkd3FiU0FHZVlvdVJl?=
 =?utf-8?B?d2pueVg0Z29yM1psVFk4TG5UVmxPK0swZlc5dW9lTzJtNU43cHh0WjRCMm9B?=
 =?utf-8?Q?uF4tQ0Z/VylYNKALE+PTJ2E+jELgLJ4k18v2PY847uFf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415f89b4-46b9-41d7-f568-08dbe6cbd347
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6478.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:45:30.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuRGM6uXfyrn76Ol/5QybIzd2wFea7XoySTR3dz0gTYfflgsPXT4EO6Ug3t42Q7R6AZq5Si8F/vmQsN37AMcuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9672



On 16.11.23 15:49, Bjørn Mork wrote:
> Oliver Neukum <oneukum@suse.com> writes:
> 
>> You could argue that handing out the same MAC twice
>> violates standards.
> 
> You can't argue that to the Sparc crowd.  Which has to be considered
> when sending stuff to netdev :-)

Should I reword the commit message?

	Regards
		Oliver


