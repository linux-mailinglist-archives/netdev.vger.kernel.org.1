Return-Path: <netdev+bounces-29436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B587833CD
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77FB280F6E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0911734;
	Mon, 21 Aug 2023 20:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52364C9E
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:42:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E5C185
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692650557; x=1724186557;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l7G8NS+xaAxUNR0NSsKU/TouMweJCVhWd6zVe6zEmpU=;
  b=VNh0s13X4c5MvnkaJGWKSay/I2EcAYEkfvVTmVUVVUM/KJ+G5q7tgWfH
   Ngy3Iy/Ujn/4U0plc7md32ufI+Thoa7PRZJLy7KuV1E5V415vbgAlUmgL
   yIj3bzo9UrBJmN1DqXibWnHXhpawFoBtmSnGy0zUbLx8VT4nxzCPNTUGq
   81Ux5b0JcoQKUBGcI4hPEeeLtauD6l7URpVxyEqs7ZQVy5ao9t3Av+8cQ
   eA63MFkNGBqJt3450q4fijwAUgcYKUSWW1g8/CIJm1XKXv8cWVxTiVAbG
   qg4gnDywLvFfpnEE7fGc6u84Ca7X/KLp/k3uEc+HmizGMEMom3T7HM4pN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371127114"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="371127114"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 13:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850317180"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="850317180"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2023 13:42:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 13:42:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 13:42:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 13:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xsvqr/h4Ci6TetifykO6Kp7qDuuWAcUt/INWqGmNJdly1N8UOA5XZBCw5PuHAO/twHAhpcMKbRNPux3RYsa8q2J2brzm+yuitKPsTNuUU0eN8hw42m/oUksX25RWL73HAtxzc7EqInBpCsgDFC161NPKVfttZnhQYUinXqZ4krFgp3LDWiX0GjNeeei4rriHr59ZpKtssfG5fmmzhd3sWaB4cyC2qZ4+eYtdymELjFI0WV+FBRFzxiw78CEHYZVtqzQNxoUfw69xIc4iHqVdqm37EjsN8kA1WSUdXhmUp8hWGK7Sq/SZY4RydWOb1gtizVgZBIg46QxUiakCLtE4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MXC/MZ09tY2Yyl8SGAg87oSi97QHCiTkRMQMbVjffU=;
 b=kohnGv1HSy/EW4JwD9Mkzoht+0uyUuyYgO/JNDMxQYMLoe+yUvaYfiDm1bUY93C93VvSAOr18hiB9LEOyixEv8bZzmwXjYkj5BtUuUaOiuLCXJMtzvx2+ywgFtvHYsKVGLB1mwMIT3FiAwEZblg1vFFF6/ybMHE5QGbWnArpBshOraCWnHzD3qfJB/7hkJx7EXRA1P+xozcyfYiP8iH5XMKRauNRajpCiRuTiRWAhCgVUhmQhaQs2Fv1X01SvnXP/j5inFORa0QDUJtjcfmoMnhrCgA+AOtQvMm31clREArbFPLYzclfjlBH8RqCD2HC5FoZiUFLRQ1POxztmM3/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 21 Aug
 2023 20:42:29 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:42:28 +0000
Message-ID: <8f7ca327-b5e4-7d33-0f6e-dbc14411a98d@intel.com>
Date: Mon, 21 Aug 2023 13:42:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v5 10/15] idpf: add splitq start_xmit
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Joshua Hay <joshua.a.hay@intel.com>,
	<emil.s.tantilov@intel.com>, <jesse.brandeburg@intel.com>,
	<sridhar.samudrala@intel.com>, <shiraz.saleem@intel.com>,
	<sindhu.devale@intel.com>, <willemb@google.com>, <decot@google.com>,
	<andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, Alan Brady <alan.brady@intel.com>, "Madhu
 Chittim" <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
 <20230816004305.216136-11-anthony.l.nguyen@intel.com>
 <20230818113740.1ed88d8a@kernel.org>
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <20230818113740.1ed88d8a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D05.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:e) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|DS7PR11MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bbbecb-da17-4219-4294-08dba2872288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wn9+j2M+smwdGRMyGQg+HovXvfESLpy6Iih0UylT0oLwAxcLhLJhfd06hyAvbbtQnefj+fNVHMgfnRXYKUsKQKlVeA6SeTwxgEO8IhSDvpRJSislAPxz8JDgmolui7K7jniCtlszSafbk+OS4iZC3TJsxcRHR5lwzr4kSG093qMTGGSFOln9D/DgtJtY1wlf5T+EIU8C0n8L46Crk9AEQr3xqcYKRCMmjvqF6sCsh3HVpIqiaAzryFj2LlsHuvsu8QvHtE44TTMz/D959HInIqPXW1CzltIh13DuOPxph/VXhYZWOvyBinnBxIqgglFKuA64Zd+fEB0AkmzP/vuKdTbbxPLju0UW5YlFZzMoJUXDlFb9Wsu0jkVqS7clhL2S6DJSNPGqSosETpDYrsxCercmzRVYoJ5mB5JDwzIC4C4r1/8GSRU4d9T6NpG2VUidYtmj5hDKosSKmS49xbzBloLpPgnESg3qaIIQorT1RmXOJeSQaPuoDdZoW1clArOc6TQ30S1DcfS+95CGrYnn1lLMfuAzlIrC684sOLGQp+QOLv/JfVg9D4YZtmg8i8wctZSlsOaZmA0+AXrLwD9GXgGms1tHD/5DCkbnKVOk8awtvTVyWAbCnyCtC9R3A3b9atKD1dTSFkG66aCuSFwQvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(54906003)(110136005)(66946007)(66476007)(6636002)(316002)(31686004)(41300700001)(5660300002)(66556008)(38100700002)(4326008)(8676002)(8936002)(82960400001)(26005)(4744005)(2906002)(31696002)(7416002)(478600001)(86362001)(6512007)(53546011)(6506007)(6666004)(6486002)(2616005)(36756003)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3cvZ2JoU1FIc21MNmJPeXdXS09qeWRzN3FGV3BhOFp2cEswSVcxdUg2Tnlv?=
 =?utf-8?B?SE13ajVwY0RXenRKNHZLeEZWZXNleWtFZUJyWjdJK1VJR2JLaWEzNHlrcEV0?=
 =?utf-8?B?Q2w5bjlUd0R4bS9BVHBJMERyeFJuOUNPUk81UlJYZkk4RWtCZ2p2M0piblNQ?=
 =?utf-8?B?UlpnN2lCaGRoUFdDSitwVUpHKzd4OTZ3S0hNdnJsYkN6czJPVHZXaXowSU5o?=
 =?utf-8?B?Ym1kVTh0VWF6MVR1Y2g0Rzhhc3ZXYWhiT2ROS09ieUhtRksxUUN2VWxGekNE?=
 =?utf-8?B?Z2dyWXhBd3h5NUJmOUJZZEROdDNzN3JrSnhBZWlyczMvS043MmsvYWJoSVhO?=
 =?utf-8?B?eUFJUVI0bGgrdFBpSjlTTGVwRTlBc3pNSE9kZHVxT1VXcU9mTm9XTFcwMElO?=
 =?utf-8?B?bktkSWlUQ3BpNFlxbjJIU0Z4RkZFcHRTUVVHTi92Mk4vclV5ZGlTbjBtTlN5?=
 =?utf-8?B?L0w1UXRPei9rTEhWUmRzNlZlOUZ5TmU2NUVPUUU1ZUVuam4wT1VvRENyTk1t?=
 =?utf-8?B?SERoSVRjSTU0dmlqZHNLMjN5d25sVzd4cXdVbkFoaXlybUgrblJlMDBIRkht?=
 =?utf-8?B?RFdzZkZlVGpKcDJmakdmY2dZZTJ0cFRIcjZHa2s5UzVYMmFGQlNudi9zd3Jx?=
 =?utf-8?B?eTFPWmswd0F6L2RqcGhQSUNWV1hIMlU0QzN3RXR6NHBJakdjbTJsVWd5Y0tL?=
 =?utf-8?B?QkJoM0I5K1ZEVTFsWjN3Nm5IUDZLRTJHdS9neENDZzZabmxUN2VXOUI1R3hI?=
 =?utf-8?B?VHl6UkxROXBWYXM0eDBKcFp2cmlwM1hhRms1TlBQWjJEK210MEJqK3RFTnBl?=
 =?utf-8?B?TDZka1lkNFJzdW4rcjFxNU1KS201VDRadUlwTzZaZGZlVGV0dUVhemhldGtn?=
 =?utf-8?B?dm9TZW5RYldQMkRqNDBlTU5kNUtFQU5HR2JFUHdvNFM1SnR2aEpiREUxdTZR?=
 =?utf-8?B?eVQ5TVFCcnhSWmIyZjBOZXE3MnhEdmU5RXkyWmdaRE5HU3o4bzJIUzNTT05Y?=
 =?utf-8?B?cFVseGQ3TGREQyt5UDJKSmlSbnBwLzRTZ3RibE9mNzBlYjBBMy9ES2VENm5m?=
 =?utf-8?B?VjljZ3ZYMy9NaHVCOHJ5WG9hMTd4aTc0Y055VnFFTFMweC9UNUI2OGxnNHVs?=
 =?utf-8?B?ZHljdDA4cWd5R1BTcWxCb1d2SXJHd0p2VVJXMjduemVaOXZqWVhOdkg4cUkw?=
 =?utf-8?B?dlFIdG5QTC8wWWEzclN4RVBPcVFyZ1Vjdm9uc1lTWnQva2Nwc3lYWnhwbmZ3?=
 =?utf-8?B?Z3RmVVAvOUhJckRZT1lvKzFqbFN2ZUdFS2kxMGVsVFBWaEZlV1hpdHQ2UW1a?=
 =?utf-8?B?eElIRGpZTnZ0SGZsRmtMbjhEbjNuWFpFVi8xSlRheDVPSTJZa1NYNVU1TXk5?=
 =?utf-8?B?NnRBYndXYlBWcnFRUjFONkk3ZnBBcjdSMG50UVlDbEJDQUdWZE9SbFhiUFlq?=
 =?utf-8?B?M3NmWGMrN2JBUjhEU3AybGFabXYxczErQ0RUVC9JUEtVMWJXa0IrNEtwcWgx?=
 =?utf-8?B?OVBFdUxoTVhrM0RQbjhaRTRsZTJNTHRaMnFiUUlpeTRxeTlabDQ3NjdkWjJo?=
 =?utf-8?B?Q20xY2xoMGNMZVZZWG1MdkpLK1NYNDR1bGlyM2hjZzhvRnIwRFBzNktyVjAv?=
 =?utf-8?B?ZzZSc0FxY3dkZWZBaTZSNTBTcDZrbjRIVW5tTkFkY1JNaUczZGN1bnF0TkZT?=
 =?utf-8?B?NFJqMFI0UzBmUVh4VXM4YXp3TGtvT0J6VUdwYkw3WlBKZWx4N1YzVG9ycDdD?=
 =?utf-8?B?Qm10SUIzWEVoaXJPR1prRldHS3V0TXI5V2Y5WmlPb0lOVmZLWGJuQUowQUVr?=
 =?utf-8?B?eVVCOHJWUnFObHVVd0pzeVRYSDZ1dDhJNERSMHYzUnpwYmhMOS82akVRTXZu?=
 =?utf-8?B?WjVObkZKWG1pUElmcnl5allrbzNvNkNRazh5Zmg4T3ZwL3EwQjRlQTAwbDlZ?=
 =?utf-8?B?c2czZ1lUYVR6blNNL2svNkxFVEVyS3ZJcU43OHF6bE1Kd3oyVUxlY2VVcXhj?=
 =?utf-8?B?VnZZa2hpQ3RKQTVYcmUxeW9zZWJHL0Z1cnVWKzVOZ2dCbEQ2SmRzSmVWV2hs?=
 =?utf-8?B?MCtmOFRkNHdUa2V0R0FXbVFmS2JaekhpYWNhME1ZS2pFRTJoUGthSHp5d0NB?=
 =?utf-8?B?RmlYUzJ2QVdrL0xrMXNCZ094Tm5HZlJJOE83VWZjZ3FuNVZTN01YM2xBSHd1?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bbbecb-da17-4219-4294-08dba2872288
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:42:28.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufe99Qm8dlh/KI0p/DlBuAd31VGNaBh6LUEC+Lgo3wc+VpfrsHgl1ZU6hFse4d2KxXrBPh7EulxgqyVsq9MZ+Un3Yun9N773pwf9c7fA6w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/2023 11:37 AM, Jakub Kicinski wrote:
> On Tue, 15 Aug 2023 17:43:00 -0700 Tony Nguyen wrote:
>> +	netif_stop_subqueue(tx_q->vport->netdev, tx_q->idx);
>> +
>> +	/* Memory barrier before checking head and tail */
>> +	smp_mb();
>> +
>> +	/* Check again in a case another CPU has just made room available. */
>> +	if (likely(IDPF_DESC_UNUSED(tx_q) < size))
>> +		return -EBUSY;
>> +
>> +	/* A reprieve! - use start_subqueue because it doesn't call schedule */
>> +	netif_start_subqueue(tx_q->vport->netdev, tx_q->idx);
> 
> Please use the helpers from include/net/netdev_queues.h.
> 

Thanks for the feedback. Will make use of the helpers.

Regards,
Pavan

