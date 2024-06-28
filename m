Return-Path: <netdev+bounces-107643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F4E91BCB5
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41B81C2254F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F48154BEA;
	Fri, 28 Jun 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXbsh65f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA4481D7;
	Fri, 28 Jun 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571066; cv=fail; b=ULK3nAB1XaOX+mvjjRtNXK9vRmPIl3tZbqS/8Qd5YzwzKKems3EAGgODP5/BXZ+YlmZqPqtiUAdBdG7qJLWGF0BB4luekSlFX1dEtS8BNwvtBUnB7NuxcbM2hFGmqV8UZ1tjqvrapq4bD9BoWlZQiXs2o9kIqk0aYP7o4qAD+Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571066; c=relaxed/simple;
	bh=4Eo3nUEEOHnSm8Dtjo51nYrq2Tq8HJ4ydFm8xeumuHw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0SsI1TnQVdTP4kmNkthUEJ7hMykr+keZQ6zYGKlRvPZtFsU56GsiT5QkFzIv/CRfqvRewjzt+7m1xteZkVOtY2/zKt767vEcZ0VbKEbxIslLKsQlHapp4iNiLLe2srckcuoW2ntlZtOjfS1HzjmHA1z93Pe42nlSVGbSA5JqS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXbsh65f; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719571065; x=1751107065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Eo3nUEEOHnSm8Dtjo51nYrq2Tq8HJ4ydFm8xeumuHw=;
  b=HXbsh65fgKHqRqBLXTmo7anvhOepryMrTj7gpjJUMztR7+xPK4CYIcQM
   TuR9QDWAcECiUrVffDlRAdwjdmrBG6DvbwtwB4qunTYKKiRDGqkdExOxC
   dTh2JqSjqH3dgi4KiqM321fRiyaJBcqXHR3fJ6pX0Jn6JOVcJzRtXBToY
   AL8Zk4DhTcEBeiXgrDK4k4JYT8RbKhM+NZucN9ra503xJxRYVFvAHHtp8
   4ZopiaMBg35V93mxYcBkKIc6XCKKCO79Yq8UE83GzVvrsrv67o98GArc/
   V8u/YMGFRy/Ux97Vt3WnmISz3ZEpmGL0QJXdrz8c1wBOlX/W5ikg+DTBo
   A==;
X-CSE-ConnectionGUID: m+sHqTEpT7uYj0lTcQ+fgg==
X-CSE-MsgGUID: 9HRLWck8R/CV5Cg34t6cGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16880592"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16880592"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 03:37:44 -0700
X-CSE-ConnectionGUID: ZiwkB9SIQHuj+fN+0L2TqQ==
X-CSE-MsgGUID: N75P53dNQ+KBwJe73U82MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="49305012"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 03:37:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 03:37:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 03:37:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 03:37:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 03:37:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLPwfUVwUuaMmSlBrUuGufiiu7YDWCKxFCUTjlwR0RKWwxqlr1VSaqD9CwSfTt9ywnN7WN3RZzHbjIvxGApTshNNtMOvPA4HI7WpR+f9wMf9BR0tWtjTykYNwfoOMpqH/2GNvcYGQ3Qy+ubPct94hb5k1GlFxZOBLO/Mc9Lbco+LW/ndsM0BkmXXHJOKeDB9EGUIBF5lKz6TwWJvpbzn1Ls4FlCupBZHfZrWmrakD7qZPtehq99RoQie3aBcI/9Y/ylvdvouJvb+MfyRCBqtSY6dZMSEr53TBqS0mNUdOSZzr7KNcSeHQGjpiKF5u7K8VOlNDW3o0KM39Qd/3NBAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuGgGo32wAROFAKz3eUqdVpYHJtGlI41ZTbpbwxcEeA=;
 b=RyJnPfX1o2S47NyUysL+FDYLa3sk+sHdTddKmnscbJw+9mbEuWqaJY83j4Ww0oppww0/NFVQ83SsmeQwW+l4UNdugPRXLLQKfSuwgxti22wvYljEM9GAMqPNL0h4IAEDifPZj4k2XBghSyCP1rginZjvCjI6ki54UsF9KksecKUdqjdmt7l8S1pVairSkDl1nABWk+lmNaDRxwGoegs+dgTNA9PXsBGEMYe7IopicR+euM9nrh4RHa/kzkHzSAVT0tI10rGGSgxGeXHYf38JlsOMHnS5nSA6DdyxmgZ1DnrP9SEWWBDzhphMAZ2MZD1t8bXfb1NlwsjNgPRakfYF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.37; Fri, 28 Jun
 2024 10:37:40 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 10:37:40 +0000
Message-ID: <fb3a774c-0fe5-44f8-bf28-d69b5ceda18c@intel.com>
Date: Fri, 28 Jun 2024 12:37:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31)
 to bitfields
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
 <20240625114432.1398320-2-aleksander.lobakin@intel.com>
 <20240626075117.6a250653@kernel.org>
 <e0b66a74-b32b-4e77-a7f7-8fd9c28cb88b@intel.com>
 <20240627125541.3de68e1f@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240627125541.3de68e1f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0019.eurprd05.prod.outlook.com
 (2603:10a6:803:1::32) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4d61f5-7003-4c41-ad7a-08dc975e55e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjdYUFRZa0s2R1BMQjRwaksvNkVwdHJBZUdaOVNSeXF3Z3N0R296cjhtTk1M?=
 =?utf-8?B?OGtrc0ZoL0lkd2pTa1B3YjlrTXM4MU1JZUE0VnM2cU5LWEs3RFZnK20zQldB?=
 =?utf-8?B?bEYxbFoxcm1zSDREdnhvazFxYTBDYVlCc0FpV1NkN1psaDB0TytZSjY4S2ZW?=
 =?utf-8?B?K0ZMOWRPODRYdzI3YTRmcnpXdnFsM2FBMmhtRGdDbHZlaTlyNlM2dk9qRGgx?=
 =?utf-8?B?NVRKc2FTaU1Hb2VPNUFDanhvWmcwK3RSM2RhYzJRVnkvdDhNQks3N1E1M1dG?=
 =?utf-8?B?TGZVVCtvYTBwS3lPSWdRMG8rWHp1SGRhanVLdk5DMUN2Yi9STEk3TnkvZ0Nj?=
 =?utf-8?B?SlZvQm8xZzBiUURpRFAzU1BDeUxQVTY3MHBaNUZxWDdQRml4SFo0MWxQSnRJ?=
 =?utf-8?B?cG0zNzcwbVYzWWtLNGc0cU13YmxOcXVMME9IM3llR2VXMzRCVzdsVjRxMEZF?=
 =?utf-8?B?Q3RqM3hFVE9pdG1qcHJzdHlRbHA2bEQzSExuY21KNHcxTElaMTVCM1NFejly?=
 =?utf-8?B?eEl4YVpmUHBRSElmL0xHOXUxTlVMcnRTallUMktDTlVZUlRTTGVUOEZxSmt6?=
 =?utf-8?B?M3I4WjFMWm96V0crVGNNOTBOWkFHcDRRNTdwNXc2bHY3cjhjWWlLMjFUalB5?=
 =?utf-8?B?ckhLbjRPcGRVSjNZdXF5TDJHT1FiK3hUTzNUcm50TUplU2pJZ1g5ZHVhMUto?=
 =?utf-8?B?dnM4d2s3K1daZWwzMlNuTFAxVFRkMFBQckUzZ0FvTEUwcUhpK1NHUlRkZkxx?=
 =?utf-8?B?MkhMa0JhUUg1aUVMU1NvSVdFRTlqVDU1Z0UyQ3dJdS9OQlhCQ1l0YlJZWnZM?=
 =?utf-8?B?MDc3S0syVUdkZklSaDNielFKTmtGbGlpUlJZbHVGKzdRZWRQY004ckxOdmFk?=
 =?utf-8?B?Y3lXUk5OajUrT3gwa3RjMklOZEhOWVBTWkFPRXlQRzhlYmdUMHpRU2lYVzM0?=
 =?utf-8?B?SVdnUnhkcURhMmVhM1pXQTgvUnlTVFQ1aEx2WEdSMUlheHdmVXdUR1d5K0JC?=
 =?utf-8?B?QjNHUE5Dc2VZTTBVYjB0UmVwMTYxTkg0clF0bit2NTlvZS93MzdOSGNmeEcz?=
 =?utf-8?B?SUhRYXV4OWxCOHpkUElRMWN3Rlg0LytyUmRkVHlHeUhWUGJKc1JRcXZNdmJr?=
 =?utf-8?B?WTFLMkFwV1lDbHJzWHFNdlVraStMa3ZrakJPalMxQ1F6L1pxYnpFclhRVDlm?=
 =?utf-8?B?QlJNWjdyZTFseG9xZHBJN1F6eENhWGdCYklvNnJIVGljQy92Q1JOWW9peElH?=
 =?utf-8?B?UkVaUzN5TVZzNzhLNFRyUm1KRTRndENYbmVxT1Q1MmNCeTA2cmFNYWV1S0Qx?=
 =?utf-8?B?ekdXeXlqTnFBZkF0WUJvVzEyNHZWVVJLWktnSDNiQmF2YXRCYXVSSFFzYWtQ?=
 =?utf-8?B?aGxMbHFXS0xEUGhqcXVDYmQyK1RzTTU4SUExbi9RalVKN1VPaTQ0dS93NDZl?=
 =?utf-8?B?TUkvbUtmdWZPMWJrRXBKbnBaRWsxYldRTDhIMGlDUklwU0tIbk9qZFdZM0xT?=
 =?utf-8?B?Wlp2SmdMam5XYmlJY3hDNE1Ed2RFTEpZNzVsYytZeWU5eXRsVlVJRkNBYTV6?=
 =?utf-8?B?dld6bklIWjQ2UmlMOHZsTncwUUphL0NSU3RadFdhRy9WbHo4Nkp0NlJHRVJC?=
 =?utf-8?B?bjMzRFllS210WGJOWmxKWksxZEFXTmpua2RJMHp0Tm50emNhVitlVjlxMjhR?=
 =?utf-8?B?eDdrNmVFZC9MUDQ3L0hnZVFocG9uZXdibU5sR3VMYk04b284QkRLSG5wRFh3?=
 =?utf-8?B?dFMyQnJsWTgwbVlRUGxGdERBWkFVSlBhcFM1eCtSRmJzVDFUK0ZtcnRjeUtD?=
 =?utf-8?B?clB4NlVCQ3RTR1JKZEozUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnpUdGtKbWpPNGl6dlZvK0RDWHVFVGsvam9mQTVhZEdVVnByQy94dlhhbmJD?=
 =?utf-8?B?OUlTT0tMNEtXSEVMamZqbHhCTk96LzhTQWhzQjVERk5hNHZKZ3JFWVQ1ZlF2?=
 =?utf-8?B?ZFlpbkNlSXBjN0FRRHlOZ0NOeTM4c0pnbkFNUEF1SmhyeUR2emVxbjNmQkY0?=
 =?utf-8?B?aXJvejBKbno1alM4UTcvZVdlbG55NkZnYVdVUGNFczdiSzRuV0lVVEpTeVpF?=
 =?utf-8?B?akxMVFk4THRCenJyYXlJd0NSV2lMOFN5UlpaV3RGRkMrR0pwU2FCTUYrdVpJ?=
 =?utf-8?B?ajZNWXUwa3Vwd0gvRjR3Tmp4LzRJT1BCRzJheWdrMGdUYTZCOGFqdFhQQjhN?=
 =?utf-8?B?VDNkc1o3MFh3eXZZMG1xeC92VlZJUll1emNLRUVIbndkSVdWODUvelVia0gx?=
 =?utf-8?B?OVFSQndReTREUTZyY3JrU244WUwxdElXWFkwZWsvWDZxOVcvRUlCbndMQ0tt?=
 =?utf-8?B?QnJIdXhFeDdpcDR4WnNoMUt2cGJncDRvNEY1eEdRWkZJRG4rOGJDMytKT0tw?=
 =?utf-8?B?MmkxdTBCNlllSzNubVVLWWtYdGZNdlZ6UkkzNzRBSmNSalpCaUN5UGs3VENn?=
 =?utf-8?B?UGJoSHdyM2Q1ZHRweW51RGtTR25QU0d4Ry9QV0ZKeWs5L2VJQ3dHY0wydXZQ?=
 =?utf-8?B?eCtnL1hVYmlJRStLSlVvS1hDeVFibFJCT0Z0aWkyZDhJVWJPYVVFN1k3bzlS?=
 =?utf-8?B?VzcxdCtwbEFFbFREdmIrOWsrTytQVkc1cjgxbk0zcHdsbU5kUmxTYzJ3WWlW?=
 =?utf-8?B?ZnliZlNGWTdyTHZJWm8zYUdsYXlueXVyczJ5N3NPSHZtcVNJU1dHU2pKWEk4?=
 =?utf-8?B?czJ6OGtBTzNTSzZrVGo1VjF2UGJVanJrbDlycVhaTFBFRGcyTVBuQzVSNE5P?=
 =?utf-8?B?UldLemFlTkh5UmtIUXVnU3RhaDZOS1JwaEhDYWNac0t1UU5QYysyaklqZDh1?=
 =?utf-8?B?L1BJVnFTOXZ3ZnRadmN0Z3lWUFhHT2pkVEZBK1orcW5TNFg0cWUvY1pSWlRh?=
 =?utf-8?B?SmN2WEFxR3MvWHd6TzlOdWdRQUphYmVCcS9pb1dCUVVKaEhsM1k2ZWZ3Q2xl?=
 =?utf-8?B?em5sRGZvUks5VWUwTG9FYlRUUzM0K0Fndm9zdTN6ZFVRaXgvNUljUWxJU3k4?=
 =?utf-8?B?N2cxNVlNVWdCTFF0eU80NjU0eDRFSUpuZTV2MTU4U0VQb29kQXhJcEJHRkdO?=
 =?utf-8?B?RU9ua0ZCL2hmb0l2UUw1aE04QkpBOVU0TlZDUVN0bk5xc3ArR1FUWGpwS3No?=
 =?utf-8?B?NjBqWTNYY2tVc3lMKzNpZXMwT25pTUoxUmJCMC9EenU4SEk5ck9xQVBRQVBq?=
 =?utf-8?B?ZE9zTVNCQm04YVJaU3ZzT3MrUzdFQzJRdms2NDFOMkN5TXNFN3RwNXZaYnNE?=
 =?utf-8?B?NUIwZ0FvTUUraTdtSXR3OU5RbVNHdy9aQVhBMjVPYXRCZXVndUZ5YXhzQlNC?=
 =?utf-8?B?SW9TSU5YUXViMkFvcGhDY21MUnRxWnZlV2xUVk5oWngvQUVzSVJhcWltQmpv?=
 =?utf-8?B?UUNXeHIxMUdueWxJYUtKQVVJOUFSa20rRjdRb3FxTksxTHNudnZVa3hKQXNO?=
 =?utf-8?B?TTFlY1NjdWdJcWE3VEVYVzBNRGxoY1ByRzhhQTUrRHNZRUZTRnN5dU5ES1ln?=
 =?utf-8?B?NnovOGdVKzlFL1JDZmpXL21KWUc4akt0VmZZTzEySE1RcUZHckcrZlJOOVEy?=
 =?utf-8?B?NU16NHFvVlVzQkVSbEgzd1U1azJiajAwNFZMYXVMWEtJVnFrVmIzTUkyd0ov?=
 =?utf-8?B?UXlNaEZLUHZvOW8rYlNMVmFMZ29TM2hibnhIL0xHNHhwQWo2UjlmNVUvMnY4?=
 =?utf-8?B?QkpNN3c2VTIxYldLM0hUbnhpYjFJV1lLT3FCekp2UzRsV1JuckJZaXllNmth?=
 =?utf-8?B?ZWl0eWc0TmRnQ1Rpamx4MldDREtTclIxMWlESmFpS3czczBhN1dlblpJVUtv?=
 =?utf-8?B?dGNCS2RCNUdZWFo0TVFEbVRyL3E2cDN5M2RnVDlESmUwMmsrZk5tT2VhMkhw?=
 =?utf-8?B?Uy9xMXBIN3VaMkMyZUVNRldWdFFqNU1PcVZCOGxNei9rcDhxSDJVdy9VTzZO?=
 =?utf-8?B?QmF2dFNTVDR6NGtNVnErZXRWSDFVSUJHdncwdE45cHNqT0hQQnZoSTJ0TU5G?=
 =?utf-8?B?Vjh2cDd0U3hVcnpwalozWDYwT09RZWN3cGR5a0RkQTdDaTVja25ZTXVWZWhE?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4d61f5-7003-4c41-ad7a-08dc975e55e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 10:37:40.5490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yW/Sw0gDiT/A/xa5OlWkcG1tgofzbEYQCRqjEXkNCm1AHkQ9RTBr3QmOybMqciUcszIW481SiWvMlUlMzNhgkjhfW2aZmq3hnz+tPuK7nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 27 Jun 2024 12:55:41 -0700

> On Thu, 27 Jun 2024 11:50:40 +0200 Alexander Lobakin wrote:
>>> I don't think we should group them indiscriminately. Better to add the
>>> asserts flag by flag. Neither of the flags you're breaking out in this
>>> patch are used on the fast path.
>>>
>>> Or is the problem that CACHELINE_ASSERT_GROUP_MEMBER doesn't work on
>>> bitfields?  
>>
>> It generates sizeof(bitfield) which the compilers don't like and don't
>> want to compile ._.
> 
> Mm. Okay, I have no better ideas then.
> 
> Do consider moving the cold flags next to wol_enabled, tho?

Hmm, sounds good!

Thanks,
Olek


 


