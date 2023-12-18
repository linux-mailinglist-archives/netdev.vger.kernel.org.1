Return-Path: <netdev+bounces-58711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE967817E26
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EC11F2183C
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B95768E8;
	Mon, 18 Dec 2023 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXVNBybm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C261768F1
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702942115; x=1734478115;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2roXlhyHioWd0n2NjrbF+rRwmHnSTt90Nbm7vDFnDVk=;
  b=UXVNBybm/jZj7q8bOL/oo1rtB0ZOn/xEEDMr9a65UFmCfkHYfmE/0Ax0
   vb1Av//u3iIHx4deEsFhN6D3vi0GDxQU8wB4/0ODxtJlvU3GizmT12PZR
   ZQuaBFRHNPDb7CbJXo6C3RabXtaLlXau9Opn0RUA+VTJ2X7r5QbLJV0LT
   KsaCKoDt/eqMIbGSfa3FRhdbV4E6I3BZ0Np8ET7sMpyt8xZOBtxwReOFu
   CbNzFV6b8QERF6kG2VfTDcKfu9Z1bIdkO8KrhJfYNcxYFcXWHajCLA3N/
   iehr2vyF56hMagCi61Aa0yMKn3YZvQTOmFGoWqXqQEkFhrgPnqknVLIOD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="17136657"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="17136657"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 15:28:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107134429"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="1107134429"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 15:28:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 15:28:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 15:28:34 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 15:28:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqpYTOPLnSkjtzIFHZrjebVN+TPW9s7z059LEYXFzq2mlGeEVRft1GVVcO2LAaQOJJ7xiiDUtlrvIm9vIJ0Udcznhg5S5aYeeN4O5DqznLALbOSxb3YJsLRT8NdCjEDt2sv0QWbKE55+C9yP9AQgtw6ZifFhm1SxOtitPBQGGogx9IHwcEs9iQnw/2CLmhIS5DBAqNRHe7ze4mJrj7U2nNW/AzlDKxh3An9KQO5msbOcOlpmNmdMKIl9bMpiJ/ABy6uwztyTVlO+cQu3p5kLbLKw/khi/iMBl+LaSB3s6kxdFBP+0XVxwgmNyYoaAyMvKtluKW/+6enPl9tTD0JHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOyHU6ty672sbNMMrv+rR92nGD4UdrwFPgIBcSApfGY=;
 b=hTjGmvXKa6xP7bSXNcnFXcImD46GxoVXwTTTlek6+kpOK6ciVUwlr5ZARvFBPdtsrQmDeOC8CGlUQANDAqLbDSaLUS810iUVFfV+z/3qyL3Htg1ekv7aJTZSN7d1DhSvsbVAL1jeIEVfoaJNdJsdj20LLqLBVDA7e3aXn/SU0xYU1ltvN/AaIGjxmCjTHsEN3PMqlsF/XVtQJLtQ+hqNpeD9opl9gPgUwawdMXsU3HyynhUgrUvrsay/CWjbB56ofcUwXB8TCQ2l+Ev6LneQKLsHNHUAvyi5KhPFAu6VuOOLi3N2i5IDFfeAfbwygh5T/8Oy98iDvGp0A7QTAMX7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7287.namprd11.prod.outlook.com (2603:10b6:8:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 23:28:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 23:28:28 +0000
Message-ID: <ee4682aa-9161-4a46-b174-14c993a31eae@intel.com>
Date: Mon, 18 Dec 2023 15:28:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v5 1/2] ixgbe: Refactor overtemp event handling
Content-Language: en-US
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
References: <20231218103926.346294-1-jedrzej.jagielski@intel.com>
 <20231218103926.346294-2-jedrzej.jagielski@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218103926.346294-2-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe127d3-3954-44f9-fae9-08dc00210a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxgZP/HfiMjaduZ3IYd/EyMehpvwX6eLZhasKKzm42zj6oMSDb10B58n/k4RO9X9YnKz1iuItoaGI7mLMHITdbOpzpD4YhHhK15aOKkNBskkFo2Ij9+IQOGbh+po4lO/zJo7rpk40YNyFkJcEnw0sQ8USbM79pZvwMM3jAdr3D7gZtU9lGMCJqQAaGK5JJ07UJIZ6Eg8ar6Ip+GFspsIcC1Mz+vroACrRmTRhooEa8sW/gwXKaq8Y4g6zRVsqdkoYZv4/rrkiFA+ZpIIzihSWRu1ECMNt3+7SAT2evQNvgLMOcFISEr06bwJdfBH/LBpF+G/X6CtluzrY5od6rhk0b1fiCJF72Bnv61DhRp5ltZfg6MwIBv6YeC/qRoEqbglFJ8yzXFERXLPnHmTfmMA7SGjUgmzEx5qNcOSIXsdOnl8gDt5sMRJytrMPhta+S/mTRBFb0eYmUTI6wEkF/2kYUsBRwqLZvyLJ1F4p194g/qIY+OMvKRj9Z69/IxWeixpUnhTzwyqXWioLGUFSO8ELHe7gDtJ/t2Hd8TOjWcHo+FewT9ejmByC+CZp98DZVrYQYHkgm8zLhKRjxWAqkgVgP6pf4KZa9+usi1I80fCP/C0zEnbnwWRGwCoTwynJb+X+BPDJ6jFRfZigOi2QcUgGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6512007)(107886003)(2616005)(53546011)(26005)(6506007)(38100700002)(82960400001)(31696002)(86362001)(36756003)(8936002)(8676002)(4326008)(478600001)(4744005)(2906002)(5660300002)(41300700001)(966005)(6486002)(66946007)(66556008)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0MyMy9hdDhZTWczUWZOdWx1a3grb2luZEpuZW41UUJIWUVmaHpnVEVhMlRP?=
 =?utf-8?B?bEFGWE4wYVlTdEhaRndFdDJmRm0yMmxFYmNWbDZWQVBNZ0dNYlVUMnNtd0JW?=
 =?utf-8?B?Yis4azc4OXlVQld5dktYVDlQSVQvaithTUdSMkZ2OGpwRWFyUm51eElpd3dq?=
 =?utf-8?B?dStzS2lhMUROdHNVclN3M0RDWHBqREhEdG9KUENMZWp1RTlaaTR3RjUwMk80?=
 =?utf-8?B?QWkxMWNXdnBTWHZlYkhHaFZ1c1ByZzczQ2pFa3c5aTZ5OW1EVzFVWkd6azFE?=
 =?utf-8?B?MlhyR2pDZnozeWY4OVpkK0hvaThxODIxVGs0ek85TTNxL1hHMVhYcjRpbWJK?=
 =?utf-8?B?M2xRY213eERNK3N5RGZMVlA2UXcxS0dtbmdHRlg0WGRMZ0lXdTNuL0t1L0xT?=
 =?utf-8?B?RlBkTXJZVlV4em4rWW5maHZqVVRtK09GNEdWVlFZdVArQmdnc3BpZ25nNE5S?=
 =?utf-8?B?cTNSODhtbnlJM2pmcFJRQkJTYnBXZFduTVBzME4yMVBneTY3RnlKR2ZWOU5G?=
 =?utf-8?B?bHFRQmNqTVNra3RkeW10eFlwZ3RkVXVsRnA3RkZoNEpldjl4b3NvVlZHd0Rs?=
 =?utf-8?B?M2NTc0puVC9SQkpESkRQVkpWRWkvSEYrUUpBaHJ1bVZ3anNIdHk2UnR6WXJs?=
 =?utf-8?B?K1hOcVVPcnNRSTZQVlB5ZXAxc0JTTExRdjQ5ZThTalBTNTR4dzQwUFZOMHBi?=
 =?utf-8?B?TFo3d2pBNXdPRyt0dHNiWUY3V2lGNU14enU5YmZDZGJYWWZ1MEFubjByd2U4?=
 =?utf-8?B?dXFLNzVHUURUWjlJbldMdG11NCtVNldKSG05RUV5T3ZHdUp1YnZZbGNmVWRp?=
 =?utf-8?B?cTJxYmhoV0VFMWtyalJ0eW1jWlVaNTB4MFR0OTBrc0l2N3ZZK0I1NUN1R1JV?=
 =?utf-8?B?Z1JWM2tLMmkvWTY5cTJhMWhYVUt2WDlDTjhuS0hJNldqSFlxcE1rSE9BTkdp?=
 =?utf-8?B?aHZJaElpS3k1OTBtSmtMNlh2OURnWnYwZVZnYTdVb3N4TlFob1N0YUl2Wkkv?=
 =?utf-8?B?blhIbzdsaG9kL0VvY1RHVWFPVlRtMU9VU05wWFcvR0FBemtjUzBFTjBFbzRu?=
 =?utf-8?B?MmpyWjlXa1NXN0JjbWUzNG0vVGFJcmZqYURlWThROVRqY09nNmJLT2wyK1BI?=
 =?utf-8?B?QzllQ2hVdlBHWVM0Ris5RlFmZDE5MmV4TjZiSUxFTGk4Q1BqakYzZlk0V3dh?=
 =?utf-8?B?OWZiRVROa3lSV3VZYkV6K1BhR09uSnFVSFg1czFsa3hBalNuUWdUVmp5R3li?=
 =?utf-8?B?Qi9TRzBkMjJMUkRQQlFxWk1DaFRoYWdMS3JCYzlaZXJsNXJiRDVzWjZjci85?=
 =?utf-8?B?UlVPbndyTzVkeXJVRkZWWnNJTStkTFRRNERORlhiZHNwTVpFOWQxWUJnd2tL?=
 =?utf-8?B?bTk5M2FmczZyTk5lbzJLL0FBdGVScmRicHhIK2tGWGN6eDJhMWdMZmZrODFY?=
 =?utf-8?B?YVlpbkYzT0NaS1B0UzRNY3dOZmZ3Lzh4ZmlwS1lvTUQ1NjZaL1A2aDNwVzE3?=
 =?utf-8?B?OExPWUd1NHF0UnJkUlRNSUJuUDJsSldJQ3lXZjRsV05wazBGdHNYS1I1V3d5?=
 =?utf-8?B?SCszK0Zad2ZobjZKN2FYaXJURDdvTGROa1Jra2JVZzAzSFFlVjlVbG96MXJ4?=
 =?utf-8?B?aHQ2ZmhBSEIySXExOW0zQTgydStMU3VIMXJGWEt1Yy8rK1NzenBUZXhneHJF?=
 =?utf-8?B?OG1ieDJUcFJMOEVQM21Ld1R2OHRLVjEyYmlUZlNTT1p0MGRaWmdsZDRuZ3R5?=
 =?utf-8?B?K2xGYnRQS0xGcFY4RU13emRMcHdaZUJyWUEzQUwvbm1EQlBkYnh6QWp6dFBB?=
 =?utf-8?B?U3M4TmV3RjhDNXYrSmhUU2ZrUlJLWVpmMElGOE9nWEdQUEVzTVJoVmhJaXhU?=
 =?utf-8?B?RFJzcEZEOXBndktFRUFXSVB2RkhiWGY4VE1jQ21HTkVXMWNwSWthRWJaU252?=
 =?utf-8?B?N1JXaTZiaU1MNk1LdVVwbEM3ODV0UUNuUTI5andTeng4WXNpVnRsOFN2YVNT?=
 =?utf-8?B?WHVJSmlhTDFIL2dFMjg5SFJMclBpNHBNVHFadEE2Ui8yTGlIYjFZbzlUdDhz?=
 =?utf-8?B?U1JPQnlDVHA1aHRKNUV4UUdZcE4reDE2SDZZaVNBWjFFY2lydlV1MXVMTjlu?=
 =?utf-8?B?eERFVFNVWHF2YWExTmtFaG1kZ3hZRUZKOHl4bE96RmR6V1RsSVZQbTRpUzBv?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe127d3-3954-44f9-fae9-08dc00210a09
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 23:28:28.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byDjrmXCAyt1QJYsg1MLVfEJ/L09aOJiTn7aVj5pCh6vmgpCcoenADzZBCOQ7n5UOkSSxgRrAt7TXy0kBKPsTPjXZdYy7FP5zKZbGaFk2WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7287
X-OriginatorOrg: intel.com



On 12/18/2023 2:39 AM, Jedrzej Jagielski wrote:
> Currently ixgbe driver is notified of overheating events
> via internal IXGBE_ERR_OVERTEMP error code.
> 
> Change the approach for handle_lasi() to use freshly introduced
> is_overtemp function parameter which set when such event occurs.
> Change check_overtemp() to bool and return true if overtemp
> event occurs.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: change aproach to use additional function parameter to notify when overheat
> v4: change check_overtemp to bool
> v5: adress Simon's comments
> 
> https://lore.kernel.org/netdev/20231217093800.GX6288@kernel.org/


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

