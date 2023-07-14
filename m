Return-Path: <netdev+bounces-17784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8266075309D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF87281CBF
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09769A32;
	Fri, 14 Jul 2023 04:38:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0761620
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:38:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A551D211F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHPs18v36MGmwnKjbTZLyTs43Re3UdK7wuKHtA+qFIOuYwPWm395boRjF84cERgDfE0rJO6HXd2JASzQaPyqRRrndBxMUUut9LVssn17vtgv4vZDhQGUNXU9WFl7ONUPgUJllM1BrSTTu2FGYeelbduSNr69NUTV5GArPSXzF7zMuTcQp5fRHniJzsVxVVYsNPy5cupZJkT9Z4oy72jNEUNGYRks7PrhQi/82MKhjIHOgRnsr1X8NQep5O8T1UrPnDllH9L71+beW1WcjSBK5eZycvBkhJ97l1nQMb3DF0FN0i1nzpRhvZi1l51rHAmrNFIg3vGAVrhKvMvwry9GUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFRvqWY6bR1dOTWuPAamn8pBf6YufHa0+zZhVh+/0PM=;
 b=OYK4jxi2veQIYb0iI7jniIOL2zjRJZ6+xWCr59d7Sm/au3Y1kbYY2qr5jRDumY2y8vxmEW329JezMa/XJnn5bNtDX8dTatAlfmR7kG1JAL4VliNqNcQi2rXXN0fb/n7MGXrqNHf6kigTyAEyiVkS+FSIXasURwrnDd/HqG4lcx1rh2DVB0kJlIg4JyjTC6+HoGLXEO4WNZTQ/MqSE1a0/sJ2yW1jKYWRqam8lZElXL7ME/9Ae7xJDMhKin7c1B2a7LWzlm2df28m6HlwWYgFqwaRlHWTtv/CaDNIa5pk37JpYtesB647Z/wkW3NiWIZFUAqbBUouGY+EVU62ZXl0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFRvqWY6bR1dOTWuPAamn8pBf6YufHa0+zZhVh+/0PM=;
 b=qtwUCht/EsFhpDkd2GX0sVMyKIFqptdHtdssA+YzpNERilELy+7HpZKSlKrckyaTf0zHF5oLAX4mG8VenffRNieBV3fKZR5xbus5LCkh4ooWPDjYBIEhxOmzpvwpm5nP6hFqzbpsY2yipjkAqa+2y6o9UtONcgLiJaOixULLzs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.29; Fri, 14 Jul 2023 04:38:18 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 04:38:18 +0000
Message-ID: <255e776a-a597-5d5b-9efe-4e0117c84eb2@amd.com>
Date: Thu, 13 Jul 2023 21:38:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 net-next 1/5] ionic: remove dead device fail path
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, idosch@idosch.org,
 brett.creeley@amd.com, drivers@pensando.io
References: <20230713192936.45152-1-shannon.nelson@amd.com>
 <20230713192936.45152-2-shannon.nelson@amd.com>
 <20230713195730.24afb3ee@kernel.org>
From: Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <20230713195730.24afb3ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: c507a8c8-5ada-46ec-44a1-08db842424e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aUiNKkt4i36BSm2/J+XU1MsIT+HSUSCX2H3IaaJMhGut3FVVgkbT8U2nG1M+wfVzwzo8P7MHD/TR6YqkV4gUC0g3gV52Xo3AXed7CS7xVjmebopQ1IPR/KzySM2hTjlbZPi+By7EYby0YcAzHlbKKs8f7lp1hYe1b1/G3RISd+RED50f2nZ19VbF7n3uHzqSJswkssvpDezl3Zsac3jTlY/SwZtMa1G29GWroPa2f5kJuxFwXox0tnYAvPQbqKDofQrCEOFAfun7wJ3vr9nuQmgpa1zrmSvIlimyUUuKJmku0JLwwXcxqMM/GV4hNS4uGiX5XYD6oCtCUgVqQtN5qRx4/6++mExUWzaGgxL3n1mv6Ao7P8IPCmeNcBZi93o7lG665XUywc8eD4ntBs4lJth4r0rFS9+90s2/6yNMiUJUpRdG2Cpf6OjKkIhkYob+gj1AI4C06aB6WvRHa2zpPUKZiUDckAicIc6SaPd4XXx4TKsnxpZ+CCzYHz+QksTSlkCOroCTQLDVQp0Zq5jJFNg83LjWdk6bfROc6Jps6Hx3VQ/S07FVKL8GIct1f9NgCG0r41wuwmsmMoeZaF72Kez3c0VSxBIPpSGtqOuTyCj6CsvgFkELBJKbDkGlerhC8mHzIDluBvYx71bAQzLBSQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(31686004)(6666004)(478600001)(4326008)(44832011)(38100700002)(2616005)(31696002)(86362001)(83380400001)(36756003)(4744005)(186003)(8936002)(6486002)(26005)(41300700001)(2906002)(6506007)(5660300002)(6512007)(66476007)(8676002)(6916009)(53546011)(66946007)(316002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1BMcy9HTC9CSVhmNHcyUEh6cW9KOGp2by81RktMNUFmQ3Z0eStuZU5KbUdj?=
 =?utf-8?B?ZjR5Tnlvc29oOHNjN1oyTm44ekxZSEpBL0FaRzJsYWc2akV1QzhzU2VQTmd2?=
 =?utf-8?B?cUM2VmNTeE56VjQ0akR2Y0lsN1ZaajFkdGVQakFXZkRKM1A0K1BNRm9pVkxL?=
 =?utf-8?B?WEJwZndHMGE4eGdzcHE4R1grRHpYWTZBK0RweWR5Z2o0OXRBL0c2bGNUWHdJ?=
 =?utf-8?B?OHdMNmxxamZsdC8vRlA4NU1SVHY0QjF4TGNKbEMvR3BmS3N1U3FjUXZwaHUr?=
 =?utf-8?B?aThLUHdEV0RuRm1DYmMvNVFxVXBqN0U4N3pCNTNneHhUT0sxSkxZUnh4U1hF?=
 =?utf-8?B?dDNQcVZHYzkrUkVjTXg0SDRxbWdPek5TUlpuUUVNUFFFV3QzZ3FvMTdzc01l?=
 =?utf-8?B?eXhlcUluU0F2R0JSbDliaHJvOFBFakpvVERVWnZubjZBdWF1NUMrM3cxWmFS?=
 =?utf-8?B?ZXJLNHdPS3RpOFZKZVY0dkFNQVNycnJzNEFkT04xRDV4dEE4SmZ6bnMzZmJy?=
 =?utf-8?B?UnZOSnQvTURadDFGQ1FuZmxpRUxISzZacmMrakdtZDhYQyt0TTl5aWc1aDJL?=
 =?utf-8?B?MjFLSUtjMGxRdklENGlsT0hyL0RDWlFTMU1McTlsVGhjcThXc0JGMGxPbVZQ?=
 =?utf-8?B?N2xvVE16QStTcU0xN29Lcy81QUh6Q281alhTN2dmYm1xMzR0TFMvQlpPRUpJ?=
 =?utf-8?B?TE1GSWhYMERpOFZJMmFhY3hMb0haRE5TU0ZrS0crODZwYk9UcSt6UkR0UXdW?=
 =?utf-8?B?eEFmYWhycEk0TVBYOGZ0S1Y3L295cXkvMUZtSFllTlB6OUpid082ZHBtNjd6?=
 =?utf-8?B?RXBWUmQzZkhIM01aSVJQR1NlVzIyNHU2MTlHT09DalM5SnhKVkJYWVowdGc2?=
 =?utf-8?B?QlhNWURqSC9ZemdoY2hUQXNxVEt5dlpxa0ZKVVhSQzU2dGU1N01KVktUMXFr?=
 =?utf-8?B?c2txK0xwcHE2N1BnVll0UGpjNVNZUGd0WmQ2YTUrdWk4UTlOS3hJcXpid0VJ?=
 =?utf-8?B?dXlWcU5rMXpOWXRNbWFSU2x0TFE1RmpGN01ER0JPbXU4Vzlsc0Y3WE9oanVl?=
 =?utf-8?B?MGJmeGlmN1lkUGNSRmxPSFJ6UmFvQTJRNVdIUnZnVDFZK241MENyeXQyT3BI?=
 =?utf-8?B?TlpKa1NvOXJLVVI3c3c5dUMzN2xGK016cDBiaUltajlxcWdFOFFreUpJSWUr?=
 =?utf-8?B?M2hTZTdUZkpROW91ZVcyd2I2L3FxNDIvRHM2ckZtZHRjVmgzMGx1M1JyU0ht?=
 =?utf-8?B?cy8vSWpGdkYzZzdKSWlYNXljWjVGcXcyOWhDS0krdHdqSHpqazFmeVloOFdq?=
 =?utf-8?B?dmlCVlIrNUVCeXRqNTQzbm5Ea25xM25uZ29uKzl1WjE1SW1LdjFNMzQ2RzVN?=
 =?utf-8?B?Y3hpRWNtUThvbVRpaUhLQjJGR0RvQlZ5RFl2Z0FZWE1XWmVLdGJ2Sm02NUVV?=
 =?utf-8?B?bTdyc0dyeEREMjZ6S3N1dHNmekxvczBRSnFabVNNclcva09ndm5NUURVVjFv?=
 =?utf-8?B?MC9DS0o3MFFFWm9USDJyenpkd25ySEN6THpZQ1pZWnVjVXBHU2YrZWJjQVh4?=
 =?utf-8?B?eVpLV0xGWU9hZHFKQ0JyOGsvenRuNU5TNWlSaWVIRWlCeXZwaXR3eEVPejVk?=
 =?utf-8?B?UWZDaXh6RmtrWDhZcW12THYxNDlVYWJrZ0ZLSklVZnJqVnFybXZvVW01TnVi?=
 =?utf-8?B?bnlZNGR1TWgvVEgxeVpsejZtMmVHSDVlMWhiMWh3RkZwMlVoQmxEK1FGbGNI?=
 =?utf-8?B?OGZZQ1YvOURrb2ZSbndFMGF1SHVId0pvRFlGazRvVHljcFVvNlBBV1NaYS95?=
 =?utf-8?B?WGlDY0diUHR1SE1GcndQRFJYODJhMmJZUkdqK2hXVzdnVW1PazRlNzJ1Rkw5?=
 =?utf-8?B?c1N3NndnTTJmbUFrRDFNZmdseHpCbUovd2kwVHE0c3JsMkRKRkszcVRFQW1W?=
 =?utf-8?B?WHJ5bnZMWlJhd2dkWmJJZWQxOTYzQkcxYVRUS3lvejY3RUZnQW56MjRleVBn?=
 =?utf-8?B?YzU3VE5kS3JUSGg4MDNWTzdwZWVDVldIWWZ5MklQWmhraURibEJqUDNjVTRN?=
 =?utf-8?B?WDcxaXRCWmwvb0tuMkhWaUJ3d2hsWUxJN3JNUks0RUZnN3ZmRk5UaFY3dXpy?=
 =?utf-8?Q?aQrCg71FT93maoQWMUhmLcQdw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c507a8c8-5ada-46ec-44a1-08db842424e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 04:38:17.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ns/t0maH0Gc4XzJzONN+1nA9qa0+XmkuFut9Q4R2SUWMsdXVNCp8YJP2AYRndiCtO4NyFaoarw4M2R8qnR7flg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/13/23 7:57 PM, Jakub Kicinski wrote:
> On Thu, 13 Jul 2023 12:29:32 -0700 Shannon Nelson wrote:
>> Note: This patch is cherry-picked from commit 3a7af34fb6e
>>        because the following patchset is dependent on this
>>        change.  This patch can be dropped from this series
>>        once net-next is updated
> 
> Doesn't work, I tested applying the series after merging the trees -
> git am doesn't skip this cleanly so our scripts get confused and
> end up making a real mess of the branches. Let's stick to the
> documented process. You'll have to repost without this patch.
> --
> pw-bot: cr

Okay, thanks for trying.  I'll have a chance to update things and repost 
after the weekend.

Cheers,
sln

