Return-Path: <netdev+bounces-186823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BABBAA1AE3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80F216CA73
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7132522A8;
	Tue, 29 Apr 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwJgNlKu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACBB25484D;
	Tue, 29 Apr 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952309; cv=fail; b=uQYCJNBVtKL4hfhofVjqtyoHYvu9ECweFw1LYi6IxgkhtzHxaXbm+kk/AO4zuDOKEOutmayLQavf+V8TmYOoeRVkMiaiKeNVZMp4T5swye1IUOuB211SRkcG4Xm4kwVMk7CAOFuAUhm5TZ9Q3qz20Dr0WuVn5K5TRD2Djjch5FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952309; c=relaxed/simple;
	bh=ySt+LzgtIN/EMqzYURvQz7NvvLKdqjtnQiGRJB9ZTSk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m7bpCZaWro34XCjWvn/QSicv8CTJKgM4y2Q2cMlhhwBX1KshLxPJN2zs0tnIQpFNcfdZ7foMGNZ4r5frztzuSDbvSQfxxOF1LQlT8cqFnfWTRU+ss3c9n2EYV12G2xj3L803KCwflgGdXzsbC0KW52Q8iWHZKFnWnoiR1kerTGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwJgNlKu; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745952308; x=1777488308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ySt+LzgtIN/EMqzYURvQz7NvvLKdqjtnQiGRJB9ZTSk=;
  b=bwJgNlKuQ+7gNWVYz90IgD3bpuGXno+9D3xhX5h2ZBoMSxaHEKEPjhnq
   iK6BylZdoa+RN3vRsnkgbilxYkVFnJiVQKnv878hjFo5VFuxp9DSeIjAx
   bBqZcAHtJOopnumZrNSYtwrJ+Di5F8srvAOBC1cYsj2nDXwp2Bl+O9cKb
   rW9ntVIGMhgRS27X/T2je7uWVFeXUIJWIAdSFfUkr4Cj8llMUV8l316ob
   fkTEnpGp+C5TS0xQ+Fv1ZYkKbO6uBG5Tim9tZyDejNB4rLy/QQd5FrnsC
   aELu8BbKcS0NDJphZ5U/ol33IeSKIfkgmlBDmTzejrj11JpfGQiSIZEst
   Q==;
X-CSE-ConnectionGUID: 0cLopgPCTy2PQ0+ciW/udQ==
X-CSE-MsgGUID: GTl+513oQCG7Vgz639Vxpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47475428"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="47475428"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 11:45:07 -0700
X-CSE-ConnectionGUID: HmJjTW0KRZWGY0eecymbKQ==
X-CSE-MsgGUID: 6KDOXUX8TTC0V4xNowa6ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="137924048"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 11:45:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 11:45:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 11:45:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 11:45:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM3IfX3C17gbCbX4I5AAfQ0G9VhwvplCJqgrPvkQzHobFbZPqKlwm2//l2IGuuvUvMF8iZyROes4guE1qI3vuwPDqkiiBIhR76SuU13ys5QNvjHUzhTt4ecegMTCByijqFcFV6nbeoOhh1YoEKyf9vPEb8tLdQoNiT7up15g6zYfQ2b27oObc9ZYHyjt84aRftrEsMoo0FOJGHDbCx5hZRsS+d9xWM6ndWc3rXgEFBQwZXL1ZJ0pUIKZWc5XYQbZ4SNsDQGqU/Zqhdw5FScq4rjMKXz7EHGX36Jk5V+tZuIupOrTO71zOxt8KR3J5YDGHAOtdmQQh+bUQR2CHIm2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtiJNvsln31Np+Eu0O9fhB6BPhSRQxQs+u9cyeFY8H4=;
 b=aBDeFNrQcPx2FLFJxTcDOZORKsWyelk73vGTk3EVgg82BLef6thJ3H1QEHy7LnHlq2m/7GU+9FW7HAA75VJzTRetrJ1yQBSIvo9TAT8EgJoWqKSldpjKN9VaQGk+WjAUBHAf5/Db7c+HuJx8SFZ7RX5a2vQxo0ckhHNipioN9sotJ4h5ki3ZB1WAMtMe94SWedqmr68XdRn3ul2ySVthRUUkGNBiAoWoeWYcMp0Woakv8Rrdndab3D1rQ/NrbKakeoK23qElmbtwVyO8AxbPKaUvrfNNP3kY++TXPOS4CDQLcQniM3KBIJGiDznbQCGTpJN12Xhs6knrx5MT56s7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 18:44:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 18:44:57 +0000
Message-ID: <ffe2bfff-ffc5-4ae0-b95b-6915e5274bd7@intel.com>
Date: Tue, 29 Apr 2025 11:44:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Fix promiscous and multicast mode on iavf after reset
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: <intel-wired-lan@lists.osuosl.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>
References: <aAkflkxbvC8MB8PG@csclub.uwaterloo.ca>
 <8236bef5-d1e3-42ab-ba1f-b1d89f305d0a@intel.com>
 <aAu2zoNIuRk-nwWt@csclub.uwaterloo.ca>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <aAu2zoNIuRk-nwWt@csclub.uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef8468a-9798-4927-c44c-08dd874df092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajFXa00xN1Y5cDV4TXF6V3FQMmlZUFEzdzZvdWpsVHlCZVdOK1AvV0JwdkhB?=
 =?utf-8?B?dncyQzZ2SzkraWpENVdlVnB6bmdkRWtOdUVuQ05xK0JSdFhLUTR6QituME5U?=
 =?utf-8?B?T2xoQXExUTVrOUp4eDdXQW1mR2Ivem9YUEdhN2FjbE9iejRnNkNsdis5S002?=
 =?utf-8?B?OEtKa2ZVZFd0NHlDcWxhVDY1S2Uzdit6eUhLTjZVcW1IZE9zUENtSFJCZ3Q5?=
 =?utf-8?B?enpJK0pvcVNzL3JYc2U1dFgxUjFCSGh2NmNIUUtaWlViL21nVnY5VEY4a09m?=
 =?utf-8?B?U1NKcE9hTFBzb3k4dllQVndlRk02YmpDdHRENjRZVHZ2WEZMbWVmZzZna0wv?=
 =?utf-8?B?S05mR0tHcXpIS21Hd2w0dGoxK2xaTGFsUWEweTdYN01scWxnZGN5c2ZhczU0?=
 =?utf-8?B?VVFYZWQzeEtjQ3E1UlVDWFpYVVNoMk1CSktBOUsxQzJiZVVOcDB0eG9WTENz?=
 =?utf-8?B?MmczcnpWc3FRMVgwQjYvSHR1c3FCazlqN3Z2bGF1b0ZlS3gvNGRNMmlPbDMx?=
 =?utf-8?B?NW5mRFo4K3FUOGppMDIzVkIrRWdWc1lHbHpLYWtkT2JCM2ZsOW8zcnVnV1Zz?=
 =?utf-8?B?QytwQ25jeTZjK0t4RCtUUEo4YmliUHlRN1ZZNk9qUnl5bXFDK1FWSGI1SnJk?=
 =?utf-8?B?dlNFeVdBcGFYYUUrdFYwTWtiYWZTK01lQWQrSjJwUVpCMVB5VUgrN2dpWVZa?=
 =?utf-8?B?elhYS2loREtHWjE4UWxzSk5pKy9PUFlnQkppSXpOYmZJaktQMmRFdkxVb3VD?=
 =?utf-8?B?OHBJajlKMEpUK0RoYVQ4V0sxMTN1bnptcVpYSWwybmVHNElLWmI1Smg3TS84?=
 =?utf-8?B?bEk5SmpHUThFUmVDY011cVJwblVrMStwaGcwTlJHTTNPcFl0YTJ5bTYrbTRZ?=
 =?utf-8?B?YzV4OFdlUDIvbi82SVp1MjVsSlI4blg3ZllqNzQ1VWVHOVdHSHdhVHlFSlls?=
 =?utf-8?B?cXVHUDB2eTZDK241MVcyaUhsZGhtb0t5WE1hSXg2bms4Q2JzUERKUEJaa1B0?=
 =?utf-8?B?SERreHNnbDFxeHFoR05JTVRMUUVCb1BBS1h5WmlwUGt3ZzFGYzl1aDl6MSsy?=
 =?utf-8?B?SGt1bEIwTnNaWFU0OEVkK1VzY2VVenovV0pIOVRjTVN4L0hIaUtPeVdHbTY5?=
 =?utf-8?B?UVZnTmVEd2N3SUFLNVJUR2xlSU1XR1labG83SzJMaXk5VW1scEZ4S1czaHEv?=
 =?utf-8?B?WDJuMFlzWXNEYmZxRFduUHVnYmVDMnRyaStSbGErYldYU2J0eUJDbzNDdkJV?=
 =?utf-8?B?em5BdFF2V0c2OTUxcmlmbE5ZbVFFK0wxay9wRGFBNVlBRVUweUp6SllIbUgw?=
 =?utf-8?B?bHUrb2phYzlvaEN3SHpFUU1qOGRSUmw1TDBXZzVnVEdsQUVlUnk4dS8zczFm?=
 =?utf-8?B?TFBwZjYwMTJHNS9ESUNxNjM4NDBVQlp0MWJOWXBxTVVBRmU4dzVuZlpyR0U1?=
 =?utf-8?B?cWtFZHdMblp5TlRqSkNLanNneGtPR0E2aFo5MExocEc1OG5GT1lIWVp3YkQ5?=
 =?utf-8?B?M3ViY0ZDMElFNkUwVnVTM3kvM1BMN1VRbzRValdKbEd3aUI3STBBT0hMNFBx?=
 =?utf-8?B?UFA3YUkzZjRXMkZPQ0tvbk8yaFhvZE9oaWMwekFST0E5Y2pSVzdHY2FYYmdX?=
 =?utf-8?B?K0ttaHJvTlMxNXRVWjBtcGtKNGx6TUNRejVHYUpNMC9YTDhUSDNJaHZZS2Rr?=
 =?utf-8?B?cHZRSnpGaHlIY1NrZG11WWhPL1J5SHU5anhaejBvZEI3aFVRU2xwb0ZJOEpm?=
 =?utf-8?B?NVV5Ujh5ZzAxcUVkYkJ2d1phaDNqeWQxNlZmRGtoK25pNUgzWjR0eVpJMUp3?=
 =?utf-8?B?K0NNQkUrbTNsSUxUVXlQWmpyMlRTT2QvSHh0MmJzWXBhWVBXTU14RWhSNktZ?=
 =?utf-8?B?ZXJ0NUdhTS90dVRoRk9NTnFyQjF6MTI0ZkQ4bUpYRzhMQ1prOUk2cG9ZMmZY?=
 =?utf-8?Q?g3cCGfXe0p8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUM5ejNCb1lRZ3pEbTM0SDdEdzEvYlhZTU9HTHZ3NGFEUXI5S00xWCtwRUNU?=
 =?utf-8?B?ajZ0bW43OFp5MnJDR1JwUjdOWXZSSHl5YjJuUWw5MXFYODBldmhVYm8zWTNC?=
 =?utf-8?B?MkpndEYwVFc1NkJ5V3ZkOWlXYTNKNlYycWxNK0U0ZVU5MngwNzNZdDc2Yzhi?=
 =?utf-8?B?TEF1MCt2L1VvTUMvS3VNS01TS1ZKUC9GVlhBRmljZGNBalVSSnJnVSttQml0?=
 =?utf-8?B?NDMyalMvcmpjcTI2T3poQkxsUXkvOFZSeFZ6NHMwbXlFMGo4ZVNJUVVSYUI2?=
 =?utf-8?B?ZEVYZm15d24wT1hnMUpNbndrbVNnZDdKaXl5SHZNWnFLZHQ1Y2xxVFZMZ0FT?=
 =?utf-8?B?VHkyQ052VE9RdlQzZ2tiVWMvdEMyUmdJOUR1ejF5S000a1BIRlFzNEdEMmVQ?=
 =?utf-8?B?V0lHQ2V3WktUd3ZCdjVNVlFQVzA3SnB2NnJkb21ySGJqWWRSWXQ4Qm9aUVlH?=
 =?utf-8?B?TC9VV1VOR0hmZVRVam1BUk95ZUVySjNoMHpMMjczQnBwaU5kUFRVVGdFTVNy?=
 =?utf-8?B?VDRkK3dhSG9xaXFxQ1ZicmUxSGc0a0VCV3NnYSt4c1BHeGMya1UyYmFmVktV?=
 =?utf-8?B?cDZDUmF2RnpJZzI3eDI1OVFtbTBISmpGMmZCSkVOS3Y0bFRLbHFLMFIrN3Ra?=
 =?utf-8?B?YjJ0UzgrWkhYWkdSUVU2b2xNVmhYSktEYWU0cHF6MzI5Sk9ic0tMZ3V1Ui93?=
 =?utf-8?B?QUFHNjdneEhpbHh4R3Y4dWVid1VrbVpLdW9jZ05FUGN3VStLbURDTEN6ZldK?=
 =?utf-8?B?TUFkN1U3cFQyTitCMUdtMXRwSmVIWUYwWmlMV0J1V0crd000ckZhS21WaUtj?=
 =?utf-8?B?cG1zbVJOaGJIZ0FxU1k2RTZsT1hQaDE1STE5VXJLdEZwZEJkUWsxRGtHWUxz?=
 =?utf-8?B?a1JYWG5xY3V2STVuelZQSFUrZ09Sa0xrZ3VmMkJMeCtVU3lUa3pRYU9wVkx0?=
 =?utf-8?B?bThvN0pUeHFBKysxREJNRGk5MTZTTDlUNFA3VlRwS2M3TU9OcnBZYkt4K2R3?=
 =?utf-8?B?SUttSWdCc2JpQVRHZ1NwOGlYQmZnbllMTlhvdWhhMkRvREVjRktwUFFjTHlv?=
 =?utf-8?B?QUNyS0NHSkwxdUJwTlZKV2dkY2tzT1BNQVpZa2hjNzIwekZ1dExFakJOa25G?=
 =?utf-8?B?NmI2cnVUNDdqS2NpNElMYmF2WXg1YWFiUWMzUGFSdFN6NkM0a3F3QWp4dHBJ?=
 =?utf-8?B?eHpwM3dhOExoaDFMNjlBM1d2RVVyeU55T0FQUVVyOUhHT0c5WENDR2FQN3h0?=
 =?utf-8?B?akN2aEdHY01KRVBETUtPUFoyR1hpNFJVL1ZEWDRaRTdKS0NBU25CRXRjWmtW?=
 =?utf-8?B?QmZTUW92bXFMK3pRdzhDb3hEa2NOb2laOVNQRC83ZkpUUXlLODZSRFo4Vjgz?=
 =?utf-8?B?YkszTmpKMmI4Sk1hQVoybnl5WVRLakppVFFOd21zVWd1VTFucmNVRkJueVRm?=
 =?utf-8?B?ZEhmQ3BNK3NqaVpoMWQ2YWVQSHRRS0d4T3NZVytVRzgyUHZvVUVCcFcvbCtM?=
 =?utf-8?B?dFkvYjVaRXlOU0lXT1h3aGNyRSs0UGFGYWw3L3BkR0paQk5ROHgvbEFDV1Fh?=
 =?utf-8?B?VzJZYTlYQlczcGRBQ3k2THh3OGlyN2hOK3NNQkE5NmFsMEl5Q3JTMnZBaXNs?=
 =?utf-8?B?L0dzWDJjbC9VTG1yV0ZxUnV3cUplUVp6NHRQYW5nYXFSZjBoM3BJS1hOdE94?=
 =?utf-8?B?RHpCcGRZQVZmd0hSdDQ0R1Nsb0RCRCtkcjdlR0p6UkcrbU5JeWNBV0YwaVNh?=
 =?utf-8?B?ODg3bnpLMTZiSVMwd0owWUlxUmh3VmFndi9pM0pTbUFhR2NIRi8yMXlkVm5T?=
 =?utf-8?B?NFBQMzRERzg1YnY1QWNKL2M2T3lMYW1RSWpxbERmNjFKa3FwREdxWkhKVjZZ?=
 =?utf-8?B?RkFGaHpJclg3UWtFS3lNcGw5RWYybTRtWFdqWE9VbzViRllGQlJMbitOOE1k?=
 =?utf-8?B?UlBmVjNKNHdyNTVhWjF2d0NCTVhMU05yS0lHdDJMdnVoOTF3dXpmRmZpUnVV?=
 =?utf-8?B?d3ZCM3RTcEd5dFFxKzUwb0xQUXBHVE9TNlZJREZVQmlObHUxaGFhMlBFdzNw?=
 =?utf-8?B?MERVSFVyWHJxdklNWFlDTVdvK1R0Vi95Q2xMbDlOdFUzV1VBSWFJNXA4dnRF?=
 =?utf-8?B?ZnVYWTFRaXB3U3JiZHhSUUFsS2o0MVM0RzJwK0NmbW9pSHh2c3Exa3J4RWRy?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef8468a-9798-4927-c44c-08dd874df092
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 18:44:57.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VegrnqBAscD9r+bDt9l1bRr1q4yIzC+Rc46pOcXh8eO07ACdwq7kJEpIX8BfgK9d3Wrg84kG+AoHVuDMngK5LN989CjCkyVb5QbUbkwT/Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-OriginatorOrg: intel.com



On 4/25/2025 9:22 AM, Lennart Sorensen wrote:
> On Thu, Apr 24, 2025 at 02:59:38PM -0700, Jacob Keller wrote:
>>
>>
>> On 4/23/2025 10:12 AM, Lennart Sorensen wrote:
>>> I discovered that anything that causes a reset in iavf makes breaks
>>> promiscous mode and multicast.  This is because the host side ice
>>> driver clears the VF from filters when it is reset.  iavf then correctly
>>> calls iavf_configure, but since the current_netdev_promisc_flags already
>>> match the netdev promisc settings, nothing is done, so the promisc and
>>> multicast settings are not sent to the ice host driver after the reset.
>>> As a result the iavf side shows promisc enabled but it isn't working.
>>> Disabling and re-enabling promisc on the iavf side fixes it of course.
>>> Simple test case to show this is to enable promisc, check that packets
>>> are being seen, then change the mtu size (which does a reset) and check
>>> packets received again, and promisc is no longer active.  Disabling
>>> promisc and enabling it again restores receiving the packets.
>>>
>>> The following seems to work for me, but I am not sure it is the correct
>>> place to clear the saved flags.
>>>
>>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
>>> index 6d7ba4d67a19..4018a08d63c1 100644
>>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>>> @@ -3233,6 +3233,14 @@ static void iavf_reset_task(struct work_struct *work)
>>>  		iavf_shutdown_adminq(hw);
>>>  		iavf_init_adminq(hw);
>>>  		iavf_request_reset(adapter);
>>> +
>>> +		/* Clear remembered promisc and multicast flags since
>>> +		 * reset clears them on the host so they will get force
>>> +		 * applied again through iavf_configure() down below.
>>> +		 */
>>> +		spin_lock_bh(&adapter->current_netdev_promisc_flags_lock);
>>> +		adapter->current_netdev_promisc_flags &= ~(IFF_PROMISC | IFF_ALLMULTI);
>>> +		spin_unlock_bh(&adapter->current_netdev_promisc_flags_lock);
>>>  	}
>>>  	adapter->flags |= IAVF_FLAG_RESET_PENDING;
>>>  
>>>
>>
>> We probably need to do something similar in the flow where we get an
>> unexpected reset (such as if PF resets us by changing trusted flag or
>> other state).
>>
>> I don't think there's a better solution. Arguably the PF shouldn't be
>> losing data, but I think its a bit late to go that route at this point..
>> Its pretty baked into the virtchnl API :(
> 
> Yeah I can see arguments that calling reset should put everything in a
> known state so the VF driver can configure things as it wants, but since
> reset is also used when tx hang happens or mtu changes and various other
> things, it is definitely inconvinient.  Changing behaviour with an API
> version change seems ugly too and you would still have to support the
> old API anyhow.  I suppose having a reset fully to defaults and a soft
> reset to change settings but keep other values could have been nice,
> but a bit late now.  Some VF drivers may even be depending on the reset
> putting everything to defaults.
> 

Yes. That's the trouble with the current approach. The VF interface has
to work well when the VF driver is running different operating systems
or versions, and if we change the behavior with a new opcode or similar
that would be difficult.

The reset logic is likely a haphazard mess of different "solutions" to
various issues we've had. It grew more or less organically out of i40evf
code from years ago.

> If someone that knows the driver better can make a complete fix that
> would be great.  So far this small change appears to be working but I
> could certainly have missed some cases.  It took quite a bit of debugging
> to discover why promiscous mode on the VF side was so unreliable and
> unpredicable.  Due to the somewhat asynchrounous message handling,
> sometimes the reset would not happen until after the promisc setting
> had been applied, and then it was silently lost, while other times it
> would do the reset quicker and then the promisc setting would work.
> Very confusing to debug.
> 

Agreed. Obviously, our own testing never caught this. :(

We might be able to get away with improving the PF to stop losing as
much data, but I worry that could lead to a similar sort of race
condition as this but in reverse, where VF thinks that it was cleared. I
guess the VF would send a new config and that would either be a no-op or
just restore config.

That makes me think this fix to the VF is required regardless of what or
how we modify the PF.

