Return-Path: <netdev+bounces-49201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB097F114C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8331F23B62
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40812B8F;
	Mon, 20 Nov 2023 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MA8s/lJt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E190;
	Mon, 20 Nov 2023 03:07:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWp6+0b6MbmZWLPCRyvEa28Wps74GHZOXXX4EIV/VbaH4Hq7nzWt+IwHWQCufSoyJTMTDmOURcHY957jOpZ3mVuZSHx03BwfpIw15z9TVqjXm8T8wz7RVjRwkQObPyJ74rNvNTPCjegf7faUylH0rqqGbHjLezYPJok5O1URLIzUHCemIHU7p3gZ5ur+UEbuD0sSy6h3ppyqtqxOt4F9DgxmB33CDVm8Ko6qYnTd6wpRYFat6tOfxb+VCh9gCknqvz2BzNBquwkgYECF5Dbfx1ZAbby3SHnBSkEalexgXkWZxFJqhTbiIIZR5MySgSkhTw7WB/B/NfGE029oZVf10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieaN50L7bowXIruXjJJAY+3pqKmnsge4cq4EkAUWsmQ=;
 b=SIaV4aqEOHSBLBCdNjLj8/bkWOLBC70wW8iLQyPxMCKgvNlW3UwLOl8Fd8tPxVHgFMjumyMUmjko1PBVG7trIK81KzW0ib01xHGk6VyVZ6q+kmVrGEtj77pqOOhYdziOWDSHTsSIw+5Vf66GtimYDxLZb8MvVXKiJUu30WB9ZW+VemLUx+zLUjW6ZhDlkuoKIKSe84m6L93GZMtcAS4A5kheJTQC7YQrou7J0ph1495qjAydd/8hifWuVHWaiZAliaNoD03QitZ7VZuF78JA3u9X0mSa8AqjYli7l/I3bY0qJ0XbmUcUv0MztPxChmYwQRF8mwuGxV1TCFiRR7URJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieaN50L7bowXIruXjJJAY+3pqKmnsge4cq4EkAUWsmQ=;
 b=MA8s/lJtDgECmbtvgmEE9hB3p26kEuAlP7sUZI6FTzqWuI6RZVQFfvGyIGwlMF1t0yjxwEqz3aEdRcgR38K+JgGtwwaBnKSWjqpLxRug41sQk1v8j/8VKr3VtVLHy1VJ3VdGqjRPXqbjAPeiXqhPhDQE28fGxxnULH/BBgtP4Bt61BqwWII0GESToUC/sra4gW1WCB4sDw+/FjsUd7iXGr8LPF5DqPbamrM5urMKIA4y3SU07kGyB6P0TdMeNBmOAdcQLYcwXtF9K2jWr3x/Q95QwF8y3Yjw36VpEBFsxan7fyIsnWUy3cdyJnHXx7M9SI70EFGS6DitHM9sfFnv7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 11:06:57 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 11:06:57 +0000
Message-ID: <a384af65-7fc0-4af8-9c86-b838994437c4@suse.com>
Date: Mon, 20 Nov 2023 12:06:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: question on random MAC in usbnet
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, =?UTF-8?B?J0Jqw7hybiBNb3JrJw==?=
 <bjorn@mork.no>, Oliver Neukum <oneukum@suse.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
References: <53b66aee-c4ad-4aec-b59f-94649323bcd6@suse.com>
 <87zfzeexy8.fsf@miraculix.mork.no>
 <64dfec9e75a744cf8e7f50807140ba9a@AcuMS.aculab.com>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <64dfec9e75a744cf8e7f50807140ba9a@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::13) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|DU2PR04MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d1113e-2a76-4658-00ce-08dbe9b8cfcc
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gkB4EwtrzCAzKUEee/9D/NKbK8L1jlmIFjXoaLA8H7gYx6iTVD4Ylyuz/BPcnBZ0fGDtDMsIQ8P+XFNhcQ42ymU1wyFHJY3/O4GvuWas2mvOuKFaFvgLlj8gjPNtMEOfP/wiMYeSJzhuHwxzaeoqRM4N3PAiMHXZbsnNQsA5AnnI+HHKbJvxnsbK5rXpb9DWhntKeJ2ARFzy9AisycnpcekPWwQW6yswr+sLuaLJMqZk9DXuf3BAAHJjCuHwJ+GrueNO+9qNr1/6DEt1kl5b02OPT5LW6X7g/cpNHU3Gr0touC4PAhFJpli0upYn6Bxj2RQBP4/KA2IzdujFy6FcH0wz3J90JYdG0NQIp1+WH2E0pFZ7YEq5hNtOy7b7XPoe6D/JTeJKmBB7fqD0bWf810OX7gJhO6ixMOJswve+UW6iSIhDai+GJef7SwjVZhImqxY0yYxEmuNXEAzcDDnxXl/CRh/beKJom3s0K7/H/rtw6fcahPPQKutgszfvZFhIfPveHQqQVafBaekydO/xI6gEqilLYv2D5f4XVuAuZGghZvxGI89RlLYdlHg2wpKcHhhsBtMbi+4Vl+e2k1EM81VboPUR/9yryxxoy2WOL/jqQwz3NqbMUVpkKziwk665V1uzcs/UQ00j5K6T+dwfPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39850400004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(53546011)(6506007)(6512007)(8936002)(8676002)(38100700002)(4326008)(66946007)(316002)(54906003)(110136005)(66556008)(66476007)(6486002)(478600001)(2616005)(31686004)(31696002)(86362001)(4744005)(41300700001)(5660300002)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGd0eTR0allUcDlyT21MS1p4ZVJSZ3luUUtHNzVuaFdLQlNueTVYNXZhMXZT?=
 =?utf-8?B?T0NQcmN6ai9TdVlobEJzbU9MSHQrOVE3S0tWUEpxWVQwOGlNamRQNUUya0to?=
 =?utf-8?B?YWhLL2JYWnhEUHNkSjQ0L0VndGZyYWVBU3hkMndjYlU5WitsT0tRNGdHWmlS?=
 =?utf-8?B?Q3h1bXROUU9tT0EyL2JkWFg2a0VOREFtMmEvWm5TYUZRM2J1ZmZuS1lJMDB6?=
 =?utf-8?B?SWRFOFJDNDFxbnFmSktTQlBDMkF6aUVYNUxYcFpMU1pGN2Z1cHM4OFc2dmFu?=
 =?utf-8?B?cXlxMDlpWkx1QVpNb0FZZW5tOUplSFFObHNVSVFpeXhZUjJ3TXdFU2RtVWJB?=
 =?utf-8?B?OGVLTjZHZzRYOEhZZ2ZDNmc0UlJHOExML3ppV3dwc095Uk5zVVU1Rm9QNk1Q?=
 =?utf-8?B?anFnQXZSSHBaUWlHVjZVcDNsYlFPWWxqTTVhZE15ZHVoNFdmUGZ2emVVYnZM?=
 =?utf-8?B?WHZpTENNOGFlTjZLNVQ4ZWVYSGpuMmpLeHB5NkN6cUtXQjBUUWxLSjNTQXlm?=
 =?utf-8?B?SXFTZnhtdmczYXhGNE84bVlUSFhLdEVOaENBWkk3aXRqV3owRDJ4Qy9SVFQx?=
 =?utf-8?B?TkJjbk80bzdqU1Y1bDIrYjFQY2pORnE2S296dTJGa0ZtZTF1YVAwU210NWxs?=
 =?utf-8?B?b0tUa1RLVmtEcWRZeUhiMmNOM0pha1NNTlhzR09nSkhURjZVMncwZXJGZ25O?=
 =?utf-8?B?STYwVE5Bb3hhYmE5Q0xBbWFMcStrcU5vVGliVkpZQkIwcW13bjh0azQ4d1c0?=
 =?utf-8?B?UHJjWG9oM0EzSEJGcEpaTFVZd1hqeERtakxTai9WZ3NBWU9EMHg2SFhlSFVk?=
 =?utf-8?B?ODZiNC9Wbm9xcE9zeW5EVllPMXVOVHFDZDAwdVdCbVVYUXgzQ3diUnJ2WWR5?=
 =?utf-8?B?STg5aGFKWStXOG5OTkJlcHBuTWo0YWZsVStKOWE3dTBPTkhSUUpoazdHVG5L?=
 =?utf-8?B?QUJick9WQ3FUSVRuUmo3YW52SUZPRDJqSk9iNXdjeUV1MEZrQjFjdmlUYnk0?=
 =?utf-8?B?MldUb0pISWpXN2dBcDJoWFZOTFdSOXEzQkZGUnRZOW15V2xkQi94SnRQTmNG?=
 =?utf-8?B?ZmgvUTRLSkV6MHVjSXJJVnFUZ2FCNWJRK3hyOExyWXpZemFsNUtDWWVBMXo5?=
 =?utf-8?B?UkVzOVlYTFk1ZTgxV05BdFlZQ1pvSmthbG5HNWx6V1lmVjg0Qy9oNHBIR0U1?=
 =?utf-8?B?N2MzNWkyd2FacnVEM3VwMVZUYmYzZFVobytTd3ZvK1BiVTdRSmM1aEVvWU5T?=
 =?utf-8?B?ZTJpTnZXWnhMN1VqQVdJemFSRjQzTEMvbndXR0pOekRmYTNaMmNLcUNnNkJV?=
 =?utf-8?B?eGhXL1F0VWFHTU9QOGVacHFGOUM2bGZaTG1UeC9CbFNYN0oxUmJJL3l4Wjdv?=
 =?utf-8?B?cm84VDBFdHVmV2RrVUNHeUpTWjNlN3ZOb29sZ001UUw0b2gyL1VoNU9DdlBJ?=
 =?utf-8?B?dnJaYUd1SDBQaTdVZG5BcGdGd25tZmRtWTFreFZCNENyWHR3U05OZ1hHS213?=
 =?utf-8?B?anlPb0haSC85eUJ5SUY3bERDYlpvcGpYQkJ2R2hOWk9BM0RMWG1YVzFzeHg4?=
 =?utf-8?B?bUpWZGR0NHhNUDI0UUt5dUlkTndabXU4MElieHFmV3RoMnhMZ2t3UGtKMUxj?=
 =?utf-8?B?MW1sOTJiQU5rNDU5elJiNHBBY1VGdHdxa25UcU1uSFFkSWFDSVptUHFvWjYw?=
 =?utf-8?B?S1ZFUHFJd1pVOHZJOGdnemtoY01nU3RNVHY0Z0VvK1lrdG1SY1J0Y0laZXdm?=
 =?utf-8?B?S1VFN09XRVM4dVBsdlZtdHJZWXJNa1BDSlpxZjFCVWxucXZHL1lzdTM1ZG41?=
 =?utf-8?B?czNObUJtZUdkRWE4RnR5aU1JMHNIeXcyMjVqV1NVQUhqbmppdVNxSnZPK05a?=
 =?utf-8?B?TVpvdXdwd1RJTlQwQXkwUXhSYmtTcm1POVhVZC9JU2x4MFEyK2tkR290alNO?=
 =?utf-8?B?SGxNbG1nTFVjbHNVbkU2V1crVVJZQU1FZGRqbDgvc0xKb2xveXkzdjNad05z?=
 =?utf-8?B?d21hMmpoRFNtOTROM0xqM1Z2UFJWV2ZPOFZaR2VLZ2lRZFY2OHdTRlVnUVJ6?=
 =?utf-8?B?UTJkRXJtSVpVYzBHYk9BaDYyTE1zM01vamZ3TWdmZWxGTlRGOXZSa2RSVGpJ?=
 =?utf-8?B?WDJ2WjJEMGsrRkR1OTdtejhPMnp4eFVJc1FWRXBKSjRCUy9mVEJ4eTlaMHBx?=
 =?utf-8?Q?Ou0V/oqFXcE15kLuu8eoWj/83u9nq6pWNJxp0NGzL+o4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d1113e-2a76-4658-00ce-08dbe9b8cfcc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 11:06:57.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71krc2k2axbjvPdB/5g0T3QUj+FaeDg/OXXFTqZCl1ChqaZ4r88I2aJ9k0x1o8/Ql1hCuSDh2nZ8ubh76qtmfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917

On 19.11.23 12:09, David Laight wrote:

> It might cause grief when a USB device 'bounces' [1].
> At the moment it will pick up the same 'random' MAC address.
> But afterwards it will change.
> 
> So you might want to save the MAC on device removal and
> re-use it on the next insert.

That means that the MAC a device would get depends on the
sequence of plugs and unplugs. That seems ... interesting.

	Regards
		Oliver


