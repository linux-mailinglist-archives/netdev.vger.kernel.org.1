Return-Path: <netdev+bounces-52459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1077FECD5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E302B20C2E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1077A3B7A0;
	Thu, 30 Nov 2023 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HqKfUATs"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE2E10C6
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH+ZE4N/aGfyss6e/SUf2U2t09zaXdWBc8QEngq6SbdTjdlLuYkXH5p3oojZRFLslwfVSJPktgrTFuhnA4rEm+mIG4ifsVQ9RE3yYDYxQTNWtvg8p0ARR2Cu9Qt+A7F+QV9x7XvqwqN5ThyKCzHS6aLxO7qq/gSP69qjn9BDUz9yIleRAUPiiuLkAbl4vqxjvCH+D1gwE+mOvEjtpH6OkEJncyXwFiq+SmpY2f8ih4FpYyOeOZDTmbkr6mZStpsdVo1lO69mDt6qiaKSQ3zxJgr6MwIUqjdyz791dm4V8eo2/l4ee+6qQJqgJdStYYQJQtplhu+FeNn0pUR7n0As+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLiRNf7vQY9A2aUYtEsZb8IVnhd8BSUa3FwQwnWNxmQ=;
 b=bJixTFQ5TfF3RaIDjgs/Z1xhOAMwrKeQKGajTvTatSyblddg7raUIzwq7aFMXLF25lFWahRBVYsqCXd+kNkEXGLDPUFxowTAzbVsHyEmP2AUHLTi/EY3cKd0QNhQJqhUEVEqjLZQQTUi19wPKMKCEJHjveNYG39Ha5kb8nPct4BvPLYxQgecgWWodavxO+lHkhkqMHDgWxMEBz5wjmIP7vkXrjYqXjqedi77UIi/mLtLJbTf12jPbOLOeWYi52BV8g2+E54xleXf6J3ucYjRmZM97FEtNYHdabMqSLXGMcigkrvhmjrnh4LPfpCmBtrjLV0LRHtJxIekhpgSxXCJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLiRNf7vQY9A2aUYtEsZb8IVnhd8BSUa3FwQwnWNxmQ=;
 b=HqKfUATsGdPpRmWZazAWFaZQnPfWgds38oo8/if0FvLqHuvlV+Cc0tN6oTqlW3OIvsBYqzkbfG8UGM5uXaBu4yXyELJ61aQjuj2q5asGCwre9uSUMWiQvhYBf4pmaCZA2lk1sLEt+EMI2ND+akPtq12M4tYS6UGlR3LjI7jNfmok+LFAbvx003rYCoi8rYWQeN8alevzPf+jMGI122Q53bSCipSo+KrzDMDSldwDT0sYley9RqQZJrfvipqnWhaf/R1t2CU0Qe68NkVnWL1xiEp+oWizjQaIaArP9Fo+d+4VBqNcwjC7gJ0qHuWQTPFa8/1KMNDI05eulSglBu2QeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by PA4PR04MB7614.eurprd04.prod.outlook.com (2603:10a6:102:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Thu, 30 Nov
 2023 10:25:34 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 10:25:34 +0000
Message-ID: <086b4baa-ae9c-4d8f-af3d-2cb9f9d9bf09@suse.com>
Date: Thu, 30 Nov 2023 11:25:32 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Gregory Greenman <gregory.greenman@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Oliver Neukum <oneukum@suse.com>
Subject: debugfs problems in iwlwifi in latest kernels
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|PA4PR04MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0ef4f3-160c-4ce0-6e0f-08dbf18eafee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A7UCdqQdVceEpfsiD5Wmsw7keK+PT+kn64+WKlfcI0twdOasV4dMxt6ReuhrLSshgnQl4UGy/8x+WcPxgOxgrx8T0o8Kz1gXdLEA+Z0BfSp9bjT7V7VbUxOmh72/Mzl0va+S2Q5Zet5MHAaqcTv68qpgRU/F++j1HnSFjnv/NXYJzcPn4VQRy6WZcqyKq3EtWfCEyPAZdX3baI30HWgLlMXybv36dpHNRgZ9c0ELzIgepWnOeGVMutyI7Ex/uaejUpaQnSfDUkyX5sADZJEOigefXRSo81YiwtIXMkf5+txI93t+5xaSyixCPcwbjOjr77Njro+XrCaqmBtIBr+OiDXh0Uxv2k+CwEbgls3WdymzQ26hegVgFKQb3yc51oEjgVfoci6EqpGhNBuI6qLgS4fzRiIL48Doxbc3QprDuvUFLEq0bgqOtIBZaxhoIKboaXkfPghv/6qqN6hEOTuxvcCSKPB3JLGmx2PcEpPza+VuaXMUSIHAtxgfBnaS4P7/M1MsNHXNzVNBqEwP+UFvTCydJCxdButDGvkH5bo6xCGLL0pn8ru1ktbZVtOFVUPKdGYnDMTEaYWNDH9Rv7qtq34sLO7+Zd5XToazytUhBU1WpQKKLAcK/pOWhhqteYF1Ap03s7g9PfrNgi5d+ijqNEfe/pxpln77IB0t1vqRwLUyNLMV+gFnN/D/qZy6YFNNK8JKtYKS5YI7KFWWXpm5NW+JHa5fl55V9coaHCN8Zy0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(38100700002)(31696002)(8936002)(31686004)(86362001)(4326008)(8676002)(316002)(6916009)(66556008)(66476007)(66946007)(41300700001)(6486002)(2906002)(478600001)(36756003)(202311291699003)(6512007)(6506007)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTVuT1B4RzBiTHA2ZjNsbXQ3alphUkZBRjNCdTFDM3NvQlRBRUlod3drU1RV?=
 =?utf-8?B?Y3V3OXVWdFhyNlg1MTFtLzRnMEZkYmpLcWZnNDJHM2F1VkZFSDJMdlo2TlFK?=
 =?utf-8?B?SUFRZHJOUmMreHJqZzZqVXVPWThYMGdBU2QwL2VvN3B4ZDlDRFpGa3dkclU0?=
 =?utf-8?B?M21xU05xWVRaa3kwMCszM0I0VGdRMmhXWWFhWWRQVmdoQkpkWjE0WVRuWmw2?=
 =?utf-8?B?NlN3Q1RGWnl6bVFMaVdCL3lwdnMzUkQydWRleTNGYUl4djY4bndqWlJxQWp2?=
 =?utf-8?B?Y3oyVGZqQm9IM2ZCQXV4VnRoWjJUZnNMVDZzcUFYY051bjBLVFVXVmMzcjk1?=
 =?utf-8?B?ZHRnYUdvdDM1dC9GbnlreXdRZXhCQ2poYWlhNDViN3VsMkJ0cHVBU3pVd3pN?=
 =?utf-8?B?eTRMUW9RdkpqZkR2SzRISjZPOHhIRGF2L0hBN2xTVnExNXBjWXlSdTExVk94?=
 =?utf-8?B?MkhoMmVHNW4xZ244RVB1cG1kU2dqbmppK1ovNGxoUHVCajBueEIwdk9SVXVD?=
 =?utf-8?B?ZDRrL0VnUUNrSTNqeHFLR0lja2xLNVRuZUl6RVVSOFBvSDNrZ0c2dmFHVUpU?=
 =?utf-8?B?VEhTMHBUdzVNdnlJMTdWWFVaMm95NUhDdEIyU0JhdnBoOGh3L3hzZTFBcE5v?=
 =?utf-8?B?V0dUZkhBWWpOWUtURklRYnpvN0pGL2FuUENCV0ZMT1RVeUZML1d5OG4zNkFN?=
 =?utf-8?B?Y0pPY1VPVEFFZkMvZFpycjA4VGIrUUZ3cUVLQ1RveWRkamZvYlhmWlNwQ3VH?=
 =?utf-8?B?S0piSjNUWHFRYkNUREQxNnRYWjBPRXBtWmV3cVN5UXVOMmZ6VWdCN0NJQ0d6?=
 =?utf-8?B?c0FSc0x0YitxUzhadHRKZU5ycnd0dUhacWVvRHhRd3JOUlFleU5jR0JPKzNv?=
 =?utf-8?B?YnM0aUxlR0pOQWxTSnFQejVCK2VDSHF5bGo5RlU5S2NkQ0YwVUUxVFF6MFpD?=
 =?utf-8?B?c1dnN2NUd2tmMEp3LzNlV2tmejQyU2RlN2xoWTVYbUt1T2FxdjQraUNoMWpJ?=
 =?utf-8?B?VlkwQUE0bS9jMytZWi9XeEN0eWZUTHNXZ2x6Qm1rekdRbmRSTk14eUJuRldk?=
 =?utf-8?B?VUNZVVEzNUh5eDBtWHBzMHhLcDFSOC9IdXo3RUZQM2FkUkc2K1VDd09GbEhL?=
 =?utf-8?B?RTZsamdHaU1wZUk1cEcvMjNnTFpPMWtqaU9ZZHB5QTZXZExvVGZ4WldJUXV3?=
 =?utf-8?B?OFdBOEtiUVhrYTd4VFNLRUdXOTV3VUdOOHBCRy9rNzd5UlZ3WDlhN05yWnJm?=
 =?utf-8?B?YjdlcTAzVjJreHNlMkFzWit2VkFBd3FNOTIxUzFRa1cxa0dVcnB0bGI2amNL?=
 =?utf-8?B?OVV6c0VBTTRta2lxOXlrc2tKZ25VenFjNzZRYUJkWkUvNkxPQnFRQU84K0xX?=
 =?utf-8?B?NVhyVWR1WTFqcXN3b3dYVit1ZlI0RHVDZS80NGdVazI3QWhNcEoraGhrWUU0?=
 =?utf-8?B?ZFEzRnNaOW1UYzJXWkJRWVdURitlajN0bStJOFpheDlEM3pvbVlJdG9vZFBv?=
 =?utf-8?B?Y0V5OW1xL1ZBWVZiUmRINWpIU0lnb2JuNmV4UDEzUGVjN3NMSnZiYmZpWm5V?=
 =?utf-8?B?TENQYXNDQmpGU1p0TEZxcDRtSmF3d25WdXhkUVBqTVh5N25ja1A4TjlIQllG?=
 =?utf-8?B?WkVJTXB4T3BjM0E3WC9odHRWVmZWdjhEWWZiUnU3QUsreWxKbWVzOURtOUpU?=
 =?utf-8?B?eXRuN2JSbmFHcFVlNDNWQWZJZ1ZCYlNia05xK1VlMlUvZldjNXVKcVFoQWwz?=
 =?utf-8?B?K25DRjFpaExYcFRNWjY1Vkh3aW1Bb3EwS2dLZTlLS3R6UlRGTkRnQmZhQjc0?=
 =?utf-8?B?Yzh5ZnBWRTQ1OTFMaXl6MG04c1h2a0xRYzh2TUNjaUVQbVhzeDRoUXNHQjhh?=
 =?utf-8?B?VVBEamxFalZZc3lQZXc1T0V3VFZFMTh3QVMwUDEvN3Uwc3RWOThVYUdNVnB3?=
 =?utf-8?B?SUNDZ2xyYmlrVzhsOTlnbkM3N0ZHdnhrNUMwTVVqMjFtNHhwSWswTnBnNWlS?=
 =?utf-8?B?ZEtHZ2s0aFgvTUpJZjl3OVAzUFpXcVcyMmhKUmpaeWhOdkdNdnVnOUoxS09m?=
 =?utf-8?B?Z0doYUhpMXNETkdzblh1VmljTUVMcjVNOGFBRnR2N3czbG5DYU1RWmpVYzky?=
 =?utf-8?B?NGhhVVRrRDJjMnFSNmNzc2lwSWpSeUdVMTBrRWFwYWd0U29mMlJyVSt5SHc1?=
 =?utf-8?Q?mW0IkQp/qWbAYZa6+IEc8tBYisBpanzGy0xhaVaCV7O5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0ef4f3-160c-4ce0-6e0f-08dbf18eafee
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:25:34.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HtL3/InYatgKQFDlsUq/dcJzazWZEH+f/ZhpHngC7WGsapfi78z4LGvDKqz6unh3Wz6aiof/0rocv/HYJNHIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7614

Hi,

I am getting these reports with the latest kernels
(head at 3b47bc037bd44f142ac09848e8d3ecccc726be99)

[    8.744119] Intel(R) Wireless WiFi driver for Linux
[    8.746363] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[    8.758343] iwlwifi 0000:01:00.0: Detected crf-id 0x2816, cnv-id 0x1000200 wfpm id 0x80000000
[    8.759641] iwlwifi 0000:01:00.0: PCI dev 2526/0014, rev=0x321, rfid=0x105110

[    8.854357] iwlwifi 0000:01:00.0: WRT: Overriding region id 0
[    8.856851] iwlwifi 0000:01:00.0: WRT: Overriding region id 1
[    8.859258] iwlwifi 0000:01:00.0: WRT: Overriding region id 2
[    8.859265] iwlwifi 0000:01:00.0: WRT: Overriding region id 3
[    8.859269] iwlwifi 0000:01:00.0: WRT: Overriding region id 4
[    8.859273] iwlwifi 0000:01:00.0: WRT: Overriding region id 6
[    8.859276] iwlwifi 0000:01:00.0: WRT: Overriding region id 8
[    8.859279] iwlwifi 0000:01:00.0: WRT: Overriding region id 9
[    8.859282] iwlwifi 0000:01:00.0: WRT: Overriding region id 10
[    8.859285] iwlwifi 0000:01:00.0: WRT: Overriding region id 11
[    8.859288] iwlwifi 0000:01:00.0: WRT: Overriding region id 15
[    8.859292] iwlwifi 0000:01:00.0: WRT: Overriding region id 16
[    8.859295] iwlwifi 0000:01:00.0: WRT: Overriding region id 18
[    8.859298] iwlwifi 0000:01:00.0: WRT: Overriding region id 19
[    8.859301] iwlwifi 0000:01:00.0: WRT: Overriding region id 20
[    8.859304] iwlwifi 0000:01:00.0: WRT: Overriding region id 21
[    8.859308] iwlwifi 0000:01:00.0: WRT: Overriding region id 28
[    8.860155] iwlwifi 0000:01:00.0: loaded firmware version 46.ff18e32a.0 9260-th-b0-jf-b0-46.ucode op_mode iwlmvm

[    9.130468] iwlwifi 0000:01:00.0: Detected Intel(R) Wireless-AC 9260 160MHz, REV=0x321
[    9.131531] thermal thermal_zone0: failed to read out thermal zone (-61)
[    9.188374] iwlwifi 0000:01:00.0: base HW address: 38:68:93:82:ee:b6, OTP minor version: 0x4

[   12.122360] iwlwifi 0000:01:00.0: Registered PHC clock: iwlwifi-PTP, with index: 0
[   12.369551] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[   12.371131] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[   12.622862] r8152 3-1.1:1.0 eth3: carrier on
[   12.865883] NET: Registered PF_PACKET protocol family
[   23.422934] device-mapper: uevent: version 1.0.3
[   23.423136] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[  424.025821] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[  424.025854] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[  719.828959] BTRFS info (device nvme0n1p2): qgroup scan paused
[  836.020932] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[  836.020965] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 1010.127770] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
[ 1248.043519] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 1248.043551] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 1423.400973] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 1423.401003] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 1423.436864] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 1423.436880] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 1426.544779] warning: `kded5' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[ 1426.690498] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 1426.690640] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0

[ 1446.809198] wlan0: 80 MHz not supported, disabling VHT
[ 1446.815785] wlan0: authenticate with cc:ce:1e:f4:37:95 (local address=38:68:93:82:ee:b6)
[ 1446.816863] wlan0: send auth to cc:ce:1e:f4:37:95 (try 1/3)
[ 1446.958933] wlan0: send auth to cc:ce:1e:f4:37:95 (try 2/3)
[ 1447.066528] wlan0: send auth to cc:ce:1e:f4:37:95 (try 3/3)
[ 1447.168961] wlan0: authentication with cc:ce:1e:f4:37:95 timed out
[ 1447.368481] wlan0: 80 MHz not supported, disabling VHT
[ 1447.373729] wlan0: authenticate with e0:28:6d:fd:37:95 (local address=38:68:93:82:ee:b6)
[ 1447.374741] wlan0: send auth to e0:28:6d:fd:37:95 (try 1/3)
[ 1447.416245] wlan0: authenticated
[ 1447.418936] wlan0: associate with e0:28:6d:fd:37:95 (try 1/3)
[ 1447.424934] wlan0: RX AssocResp from e0:28:6d:fd:37:95 (capab=0x1431 status=0 aid=2)
[ 1447.430187] wlan0: associated
[ 1447.482515] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by e0:28:6d:fd:37:95
[ 1458.346586] wlan0: deauthenticating from e0:28:6d:fd:37:95 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 1459.320382] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 1459.320434] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 1870.031487] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 1870.031547] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0

[ 2283.028582] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 2283.028623] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 2697.046828] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 2697.046902] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 3109.031148] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 3109.031171] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 3521.035194] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 3521.035227] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 3934.038809] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 3934.038837] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 4346.040215] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 4346.040319] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 4760.046923] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 4760.046946] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0
[ 5173.051589] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 5173.051664] iwlwifi 0000:01:00.0: Failed to create debugfs directory under netdev:wlan0

The device is functional in spite of the warnings. Debugfs shows:

localhost:/home/oneukum # ll /sys/kernel/debug/iwlwifi/0000\:01\:00.0/iwlmvm/
insgesamt 0
-r-------- 1 root root 0 30. Nov 09:22 bt_cmd
--w------- 1 root root 0 30. Nov 09:22 bt_force_ant
-r-------- 1 root root 0 30. Nov 09:22 bt_notif
--w------- 1 root root 0 30. Nov 09:22 bt_tx_prio
-r-------- 1 root root 0 30. Nov 09:22 ctdp_budget
-r-------- 1 root root 0 30. Nov 09:22 d3_test
-rw------- 1 root root 0 30. Nov 09:22 d3_wake_sysassert
--w------- 1 root root 0 30. Nov 09:22 dbg_time_point
-rw------- 1 root root 0 30. Nov 09:22 disable_power_off
-rw------- 1 root root 0 30. Nov 09:22 drop_bcn_ap_mode
-r-------- 1 root root 0 30. Nov 09:22 drv_rx_stats
--w------- 1 root root 0 30. Nov 09:22 enabled_severities
-rw------- 1 root root 0 30. Nov 09:22 enable_scan_iteration_notif
--w------- 1 root root 0 30. Nov 09:22 force_ctkill
--w------- 1 root root 0 30. Nov 09:22 fw_dbg_collect
-rw------- 1 root root 0 30. Nov 09:22 fw_dbg_conf
-r-------- 1 root root 0 30. Nov 09:22 fw_dbg_domain
--w------- 1 root root 0 30. Nov 09:22 fw_info
--w------- 1 root root 0 30. Nov 09:22 fw_nmi
--w------- 1 root root 0 30. Nov 09:22 fw_restart
-r-------- 1 root root 0 30. Nov 09:22 fw_rx_stats
-r-------- 1 root root 0 30. Nov 09:22 fw_system_stats
-r-------- 1 root root 0 30. Nov 09:22 fw_ver
-rw------- 1 root root 0 30. Nov 09:22 he_sniffer_params
--w------- 1 root root 0 30. Nov 09:22 indirection_tbl
--w------- 1 root root 0 30. Nov 09:22 inject_beacon_ie
--w------- 1 root root 0 30. Nov 09:22 inject_beacon_ie_restore
--w------- 1 root root 0 30. Nov 09:22 inject_packet
-r-------- 1 root root 0 30. Nov 09:22 last_netdetect_scans
-rw------- 1 root root 0 30. Nov 09:22 mem
lrwxrwxrwx 1 root root 0 30. Nov 09:22 netdev:p2p-dev-wlan0 -> ../../../ieee80211/phy0/netdev:p2p-dev-wlan0/iwlmvm
lrwxrwxrwx 1 root root 0 30. Nov 11:22 netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm
-r-------- 1 root root 0 30. Nov 09:22 nic_temp
-r-------- 1 root root 0 30. Nov 09:22 nvm_calib
-r-------- 1 root root 0 30. Nov 09:22 nvm_hw
-r-------- 1 root root 0 30. Nov 09:22 nvm_phy_sku
-r-------- 1 root root 0 30. Nov 09:22 nvm_prod
-r-------- 1 root root 0 30. Nov 09:22 nvm_reg
-r-------- 1 root root 0 30. Nov 09:22 nvm_sw
-rw------- 1 root root 0 30. Nov 09:22 prph_reg
-r-------- 1 root root 0 30. Nov 09:22 ps_disabled
-rw------- 1 root root 0 30. Nov 09:22 rfi_freq_table
-r-------- 1 root root 0 30. Nov 09:22 sar_geo_profile
-rw------- 1 root root 0 30. Nov 09:22 scan_ant_rxchain
--w------- 1 root root 0 30. Nov 09:22 send_echo_cmd
--w------- 1 root root 0 30. Nov 09:22 send_hcmd
-rw------- 1 root root 0 30. Nov 09:22 set_nic_temperature
-rw------- 1 root root 0 30. Nov 09:22 sram
--w------- 1 root root 0 30. Nov 09:22 sta_drain
--w------- 1 root root 0 30. Nov 09:22 start_ctdp
-r-------- 1 root root 0 30. Nov 09:22 stations
--w------- 1 root root 0 30. Nov 09:22 stop_ctdp
-r-------- 1 root root 0 30. Nov 09:22 tas_get_status
--w------- 1 root root 0 30. Nov 09:22 timestamp_marker
--w------- 1 root root 0 30. Nov 09:22 tx_flush
-r-------- 1 root root 0 30. Nov 09:22 uapsd_noagg_bssids
-r-------- 1 root root 0 30. Nov 09:22 wifi_6e_enable

	Regards
		Oliver


