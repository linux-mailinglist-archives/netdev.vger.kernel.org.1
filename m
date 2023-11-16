Return-Path: <netdev+bounces-48335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC67EE189
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411971C202E7
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CBB30D0F;
	Thu, 16 Nov 2023 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MDQz/+ao"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06189A
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:29:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPX4MyeiZQs46+lNyX0yc8TuTzbHz4favZ1iaSQz8lHK3hmQMtRYl5G+lbYwR4CQk1jbSwiM+XT5Nyi/zqzRD7V4Wytp7HedmhKpVU7A+aCgUiXWH/J5uBfn9gRjNVbYtsbKRdkqSfTmR1xQIPNWadembMHbRX9H0MRFTugwcb/NoChzER8X8nWqP9oXqJgfxmhd3ZvLb14GV8v0w/ucz5lCim5yRdW1sl8meYNVEhTmqOx6Bj0jV2PewZnlGvW57xRAF3xIvzun11JAdtHL+BY8VsL+0vBdulQ3lnxjUoFPMax6hLtyQ2wi1B22isOGiZ26UgoyQBqnf0TdAoF04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIt81YYq0EqUZIICZ/W6xHAubDdXFg5tfwm7/+Nu3og=;
 b=l3YMP+jKKG2zG7o9//wgzWmj+uFMgQkSawsL9qvDrFmNGTYb1CKvoLQnfuJTidVEYEeWO92+6X5ynRFE0BL5Z+nPCvFSMHFPnMDB0mJU7ZIJL2uAE+KDXme7r4mJWZrDSAGIpIiFEIl9xs08x+mTHRhBFrxNnx1Rr6NWinzNLv9TYIq0OboefFZieiZv1wG2ban2NyVojmhHxYYO/hWbn6oZ4HMLI2g/AN/ySzPZrQVPdZ16JtfznuMsm0XvDGxIplDumwhhfrojXseZf+Iq0mzLPmfvJAsbVNvUaAtIb5V9RW7Mwt15yl5MjzlSuRovmvkRwT89LE820m1D+UOROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIt81YYq0EqUZIICZ/W6xHAubDdXFg5tfwm7/+Nu3og=;
 b=MDQz/+aoeCRIEuUNQQl9WBv59dH2s6F8TQXOcalui/FFV0xnpzINGRsThKW644/zFGWLarU8uaMogjkAzq93Vk2RscwWr5RXpXxJvFo+iPRUapqRrPPS66LAyT3BDk6ecESQEFkdb1sDI6fgyCCwuczYgT2aL6X7/7Qull1lf7KfqnPlWvrh4eIw2xYoVdp8QavL4nCt7wva6k2I4RklrTCIQAbrrpI8H+oDAAmaOR2AqaRvTOR+Uq9VgLy7nFtA7MNTZQn7UX4gWu8ORWx+WCizW7M6ekAiUYtwGxvbYk7y3F+XGmU0or3w+nPQ4DMkXXVwYdMddtFKNWO7uCYbWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by PA4PR04MB7935.eurprd04.prod.outlook.com (2603:10a6:102:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.9; Thu, 16 Nov
 2023 13:29:45 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%6]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 13:29:44 +0000
Message-ID: <6eba35aa-c20e-434d-9d4d-71c1c06c7a1d@suse.com>
Date: Thu, 16 Nov 2023 14:29:43 +0100
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
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <87il61g7fz.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::20) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|PA4PR04MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3cb588-7290-40da-7e46-08dbe6a818a6
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dwUI584a6vhfF9zg3/IONrrhIoAC+sTo9WSbxnhcFw6i6zdDax8F6qAfXwZvcot4822gZbsGxtMiAmvT1b0IrTq5E0D5zklyibTowipJ3vXrpbpHr8dewGP4umpzOK56/O0mwG9K01rY1PM4lqYvNhQlo5zCHL2Hbj4AHi+sXNRob8iYKUhrxVa7hRQQPEuxOpcfIXXnHw4GPCY2p6kGG5xnPJRDf9MbTIkqhkKHcKY6xrIPuMSGmogymjBo8N3yoW9wy5hljXJ0DnikrTf4gw+HFgHNZO9rkd9wQxSsHDUao9Tea57vJsIs2c4ngpgxysSMr7P5WFLexdOn5cFP5xopCgo1VP6Ocki+d5mHFA3H0x87w7Fd0ItYADa6DeZmBiBg/wENzF3F3y8RS9peT73r87Hcgtj3uFmtvA0j7VzhBx8C3HX0aJQp79XpBz5hd0zBO1PtIViSjtwWVO+l+i+NqBecMS1FRLRRzw7Gkph74rz02X53sGWYS1DyL78DKRioEJGF2g5g23MDCiIBZ0T1beJRPCUkWymAdvCGmzk4faMiPkbdS+xL0lXHCRS0Z0F/TzCFJuwF0X41l4Md/vbsGFL6s7TrybPFB7Q2LSeb0DzEF0Sf+6J0tPNvTreSqnntlcJWLmliCBncmxsd2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(53546011)(2616005)(6512007)(5660300002)(4326008)(8676002)(8936002)(41300700001)(478600001)(4744005)(2906002)(6486002)(316002)(36756003)(110136005)(66476007)(66556008)(66946007)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWswTlIrcXRvQkFPMnMzYUVveEZEQ3dRcUJQRzdjU0pxdW52ZU5IS29jVmNh?=
 =?utf-8?B?MTVnZ0xKeHNEL3N2dzAzZ2NZR1FjaFJRNXhiN0E4dkV3SzBXN21jUXF2bUNC?=
 =?utf-8?B?ZENVUGNwdHhvbEx6TkFPbWxlTXZER1BUcm1iN1Rqb2FIeXB2RDJKZTVVeERz?=
 =?utf-8?B?c01MK21NbzA3VUVzakdOK051SnIzWFlMdFNTOXpFbU5zbURPRUJVRGYzbGNt?=
 =?utf-8?B?c2FOMjhQM1pqZHNyOTdMdTFXMWFnZlpoY3hrZ3gxNVZJN1JCQ3NDUGRuc0NY?=
 =?utf-8?B?SmlCR2FlRVpGQkd6TGhabmhLa2FNTXJVc0RlRnhzSGdrUGJTNURYdDU1d2h0?=
 =?utf-8?B?UVY1dW1wWFlmQ290SnVOeS9id1duQmd2RDYvd1Fuc21jQklkL2NVMWxQKzdr?=
 =?utf-8?B?SWVBMU9JRFNIMDhLKytKWmcyTjJ2TUQ1ODRzNTI1M0M3aS9xeEMyakRFSjlQ?=
 =?utf-8?B?RmNaVkx5WmtDRHZnVXh6ZXRLNU90ODErTGVJSi9FOFdrbHY5MUdQaTQwTXg5?=
 =?utf-8?B?SW5EQk1hT0xOSVVncC9aWVVOMzhRRGZtNFJ1a21uN1JFRkJtUHBjQTlsRjd4?=
 =?utf-8?B?cjlIV2gyWHZ1NmF1SER1czd3SHR3UlQ1K09QWDZpSVh6d29kK0J4a3ZnT1FO?=
 =?utf-8?B?WmxkRnZCVTBBcVRCMTB0b0piZWRRMFltcDlXempEME5hKzhIRHVzbFAzWEM0?=
 =?utf-8?B?a2JpMVIvZzkyaTVzR25ZYm54RWJ3ZmJzUjhudGhoK3NXUUJEamViZmFpLzZw?=
 =?utf-8?B?bk1lK0o1ejJyWkxtUGJacmVNZ3lOTDRZSkhadmV3VGVQTmoxUjNtRUVHZ3Vr?=
 =?utf-8?B?RlFFMXR6d1pCTmQrVHpZeHBFemlOUkExalpSZkROUFBFZ2Z5d2Q3Sk5iR0ZK?=
 =?utf-8?B?M0VuM2tpR3NiRGkvRG5jYTlCeWs5YmEvUUNpTlpaOXlKOTFXQWtwTTIyT2F0?=
 =?utf-8?B?alJPYzlYOXJDem1JSHZyaWh6eHNML29aNURGL2dlN0pUMHFhdHdJWVd6dkov?=
 =?utf-8?B?UHRHS3J4MzJ3NkZyNm83L1BGTU9Od1RiNE1PZjhMWTVwaG55YXFlb0hRcW1N?=
 =?utf-8?B?c0JQRy9xMWFDbG5tOWRFSUtxdnRzaG1sL0FldENXYXFKNjY5ZCt4Zm5JdUl4?=
 =?utf-8?B?c0NEVWlQaXVaeEQxdlFIazBHdmJWdys1aVZvM1BtQlArR0RWQlIrUkpGT2xa?=
 =?utf-8?B?OFZsUTBSQkUwZlVDMXBwUnZXSCtEYTVTUkxudExJYnJtb0pZamo1R2JtOW9k?=
 =?utf-8?B?emdEZFBVMUhJYjBDbFh4OTFJUlB0U294NkZKUFRyUU9HaGtHR3pRLytrQkkx?=
 =?utf-8?B?dUFwQzlkVFo4Sk1LVGVKUEIzWWNTczRycis5OE9NWGZHSjZKNkpPRUlMK2N2?=
 =?utf-8?B?dWtaMWkxREJoZmJJZk5yRVhSNGV0V0s1M1pjemZab0lMVUFtZHpsWDZGU2d3?=
 =?utf-8?B?dGZUMU5YZlo0dFZJNjBHTzZOaVdKM1VrRHk4Mlo4VlllM2JwMnJxT3FqWktW?=
 =?utf-8?B?bEprNElTWHQwcEVFRjRRT1hzM0Q1VDNOS3BkZXREa1NEa2NyVzIrSmRsL0dT?=
 =?utf-8?B?VENjTDN4cFVjZ2NOa1hveWZ2Sm02OExPdEdpdTB1cW4ydk9sTi9ZeTc2dVdT?=
 =?utf-8?B?dWJITTR0ZHcwRnJHdi9nYXJZQUUrNmdLSUFrWFdsdGJVRHBSbFpCSGw0Wm8w?=
 =?utf-8?B?aFYvRDFjN01kM1FiUncydGJ6OWd4UForMVNWMmlpTkFJNGFxYWYwc2lZOVJ3?=
 =?utf-8?B?QlVUNzlzTXNCOGNBNm1YQWhmVllwUFZMZHZOUnppTG9ZTTl3cTdQSFZFMXp2?=
 =?utf-8?B?NlJPK0dHelRLa1pSN0dWUEFZSmRvbTVTNTU1WVpsK0owaXgvSDJWdWdyNlhB?=
 =?utf-8?B?WUxhelpHSGx5TUltaEpzelQ2RUE5Qm9xRFVLQVErY0NOL0JteUFUdGpDM3gx?=
 =?utf-8?B?Y1BhTjVGN0t5NTBxaW12NzVYTmZja2poTzZYMWR2cWR1RnMxZ0Uyckdwbk5p?=
 =?utf-8?B?ZjdlYmhpYXQ0ZnRoWUYrWERJZDludE1iRWExTWQyL2E2M3NNRjRWbWFCd29X?=
 =?utf-8?B?MVdjbmNFUWNTOFI1VGkydEk2WHdHZmZlRmFHSGNmZzZiS2RPVTNZYXpYKzUw?=
 =?utf-8?B?VTRjaTVaZGtaZWZwdFhSQjhzMlhNQ0Zqc2hDS0NlOTd3ZHplSDVmbStWVlZQ?=
 =?utf-8?Q?3GepmXL+kjJ7iRmpu6b0jM8OKaPeDKsPN8YN7ncifkD0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3cb588-7290-40da-7e46-08dbe6a818a6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:29:44.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iscM8G+RhHtwgR8OTkJdWZlGexZDex97GBNnXvgzevfrrcbbju95AIy9QYj2NPqJuhcU2oSwSviKGpv19+4uoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7935

On 16.11.23 14:21, Bjørn Mork wrote:
> Oliver Neukum <oneukum@suse.com> writes:
> 
>> On 16.11.23 13:39, Bjørn Mork wrote:
>>> Oliver Neukum <oneukum@suse.com> writes:

>> Isn't it a bit evil to change behavior?
> 
> Only if someone actually depend on the old behaviour.  And I think
> there's a fair chance no one does.

Very well. I'll take it out.

>> Do you think I should make a different version for stable
>> with the logic for retaining the old behavior inverted?
> 
> I assumed this was unsuitable for stable backports.  Is there any reason
> to backport it?

You could argue that handing out the same MAC twice
violates standards.

	Regards
		Oliver


