Return-Path: <netdev+bounces-206901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF0B04B96
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DCC3A99BE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BC6279DA6;
	Mon, 14 Jul 2025 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="BFhbSTzN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2119.outbound.protection.outlook.com [40.107.243.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DCD23B616;
	Mon, 14 Jul 2025 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534134; cv=fail; b=CJbcl4Dsqf65lsRUFEkg7e+AiZyH4KS8CVok7IkPdKsR1PuhapMM8r4rhUFX9R41XeVXsGkC68P01edfNmBltpbdfqDXqo8RKIkPV4najVf33Zh1+XEsFhkym2q7WOWhlSQjaF6uwTCoIw8xZRJ8XPb92ch1/wkRFrH1g+ZII1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534134; c=relaxed/simple;
	bh=ussp9Fuusur+PPHKsBVJ2Dt02WB083zyRlV00ef2Ncw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YEgXpJpOfhjVJdSB6fVH+zl4aet4RrgxQvhckJ4TPHxl/HjnOj3U44ZVjlhbbVM5NJ42g9ror0ke54IbQ2Pf/GXXYKtwMh832iqU4cbke2T6v6y8QHM6woMvv3bFy3mcWPxvr0wT7MivsnW5DoVXZXvAchhOmLlx6KPKM0LMkh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=BFhbSTzN reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.243.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpEXhdgF1wlbrSAzxcY0TngoezqINcuMxHNloQEvHkM6bweDFKmRu/FS0ZldTlE++eOGaQ5EWzSIS0d6CfOqQqgy5JLzwZKYlldY3e0QBpt4eKZ90oLPf5N/v1NmJqLmdM30+EPe52rtut7I+YuZOgnBbISiF/ubJjDnRnABPkyxkJHyjgvYTdT4alxF39Wkx7tmvE8AOMtZO2qfFaa40S5jm3vqwyp3bKXTS77/vpW1IEt2yOAPy1c7Q8ZiyYjdYoEOdHbm9g+RRuS/d78rLFG30LfSA3QdZ9B0aHF9Tws9UW1z54AuxOezwAR7xe4pxl+T7FdNBBP3ndKa2gZ/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8xPV2ElXJghFQTI+dbJHulxmqAcLKCAwG0HVlY3Vrs=;
 b=uymgR5SVrKx+mqH8BfXDU7zQugpoUTgnyHH5QJwn47LgpLe+c60DrKsyBxH/z6OrPoU3eQMx/vDzcS9uDMtsnnYIJa7/HgxFkLxtDkHkQvHt0RHVzSSEUp0EWyzip+CSY5KvwncmyesCeq6O79KuUVSePlyZsLZ1FCP91BAIW3DxzNNKo/hV+vFJnnOcQJZ9WaYsPDGcaoehNlhQVdh611+lMTB2oR4ZpDSawFu/ZZPJBwmZEOVSua2Bo4WcGiJRzHJamLg3DFNaxOAZyVW5GBcxH7hbSV2h0bWV2HQZ/ehdQmszMUcO4qAOdYUh/rmrNA6aEi9lhJ9PI0yj+y++Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8xPV2ElXJghFQTI+dbJHulxmqAcLKCAwG0HVlY3Vrs=;
 b=BFhbSTzNCgPaZRdKEvypl96w3M+xYdPbuxd/LVE8a4F5LC1a1gVVGnYJmOkwSXp9Ps/mk29sWVD2bSlCUGI2RgeaGcOZ4W/joneq9/akAcbIL+OUg2bTDFyQpqipUfq8WT7VbMFt7dociHGjAstVMhZg8sDxYNu0wV9C4lmUwGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA0PR01MB6316.prod.exchangelabs.com (2603:10b6:806:e8::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Mon, 14 Jul 2025 23:02:08 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 23:02:08 +0000
Message-ID: <6f29a47b-13a3-4e41-808b-e29a41799ec1@amperemail.onmicrosoft.com>
Date: Mon, 14 Jul 2025 19:02:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 1/2] mailbox/pcc: support mailbox management
 of the shared buffer
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Robert Moore
 <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250710191209.737167-1-admiyo@os.amperecomputing.com>
 <20250710191209.737167-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250710191209.737167-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:d3::27) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA0PR01MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a593f0f-f0da-4d25-0634-08ddc32a7551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2FsNUVxSVN1QlJ2YnpXNVlhMnU2enhJcmJLM1lrSUhTaVZrOG9sSDhCM3dx?=
 =?utf-8?B?VnVobVR5R2g5VG9jUFVLc09TekNTdDZ5aFp3QTY3aWtPUzRHaVlGbnRHbU1S?=
 =?utf-8?B?eU0xS3puUGgrTVJMQXpYczdGQjVCa2ttbDBDL3RSOTRxd3B6TGZ2UitUcUsr?=
 =?utf-8?B?WjNHZnphYXJFZHM2UXI3SHBubldWSXVCSEhuK1RBRUVQQ0doNjdodUtYMG52?=
 =?utf-8?B?TGVGU25QaGxPdWJVWjBzTHJWNUozelg1RUxEN1ZtTm1sL1dJN2VRYWRta21a?=
 =?utf-8?B?OEQ1ZlRsUnM0bHNORTV2Um53MWZSeHlsTGZVNUhLY0JjVUpSdllxL3hsQ3RQ?=
 =?utf-8?B?bGJnN2R6aVYxb0J5cmdWQjU4YkZEd0UrOTZXWUtlb0tlOUNhVmV3OTUvMStY?=
 =?utf-8?B?SUVFaDVvSXIwZy9FOE8vSzZiSmdVeGpQMjIrMW51ak1HVzZXNk5QWngvRGlo?=
 =?utf-8?B?aFFqV0NaUzBIRlRtY3hSekxJVWY1L2RBamhIOWdsSnpLSm5pTEhGTnBRakZw?=
 =?utf-8?B?Qi9uUjZPTWprYmRVQWdpYXlQOXFzRXVVZmt6MWFQdVZYeDQrNkdvMXYxWmUz?=
 =?utf-8?B?ZFl3K3FZQUpuTzlLdnBBTGhDMjI4Q0JGZE1DbXo5SkRZbVh0VUx4ekRobnkr?=
 =?utf-8?B?MENrbnlnRUtvTVJ5WE0zN05sS0xmN09sVkJzZGM2alRvY0c4V2xtM0FmcVNv?=
 =?utf-8?B?VGZnY1ErREt1MkdNVUhqSDFHM2sxNjkyNDY1bjgzUXZlbmlLcUlXQTV2ZzNp?=
 =?utf-8?B?N0tDbFFjMHpEZFpDTVhEYncvSWFTWGpaQ21vSGZ3aXlFd25nOXkxTjlPci9O?=
 =?utf-8?B?Zmh2VFZRbTNCVmZzRWtEbm9FZ1QyRXJqZnA1TDJWdzlLVW9Ybk4zUlozeEF5?=
 =?utf-8?B?SndqbC9rclBGSTBBeUttVHZXYitRMTdDZzlDZ29LbFRmWmV5VGJFTzZxT3pI?=
 =?utf-8?B?UldoZXhjZUpud01Ua3k4VnJhSHNuZHBLVktCNlQybXJFQ2V5UXZJNC9WVWhJ?=
 =?utf-8?B?cC9NL2s3aHYwU1ZacFNOUGdhUjlselhETDk1cFVKcVhKWW9CTzJPOGRZelZw?=
 =?utf-8?B?aDlOVy9qcFdsUnVHeWpPQ1Y0czdEaytyaklMMXVnYnV3RC8rSitYY1RaZWFl?=
 =?utf-8?B?bmtUQkZ0bEtYZjc3OC9HSXZyRk8yam5GNXlvRER0cHc2TXZGR1BXOEZ0ZG5V?=
 =?utf-8?B?K1JYc1ZPa1k1RHlMLzlqY1VvcXI4MkZycHVyQmxtZXVqSXNCRFZKM0VFWGFn?=
 =?utf-8?B?WHU1Yzl4ZXBLeGdPV2sxR2kwUi9YaVluZGFrZlJnU3lKV25wVG9Ea2orT1Fo?=
 =?utf-8?B?YXo1enAzbFkzcFkybWlFaDlWbVMrWlFMbElSMDVaMGpQKzdvVzdUdGFwbllY?=
 =?utf-8?B?V09aS25iYmowR3V1ZUdscWp1aTBoRFh1UU9ERjFXWStYbU1vOHdEVnhZRlh0?=
 =?utf-8?B?TUgwc2hUNHNFa2svSUg0QlRtVjltTjFyZWJRd3AzUm40b3dsTFRybSt2WHFK?=
 =?utf-8?B?NGZ5R2dWTlhHbWFDcGxmaExNR0pTTm81cDhrRThBbnhwTitScSsxSzkwREdO?=
 =?utf-8?B?MW90b2ViaGpGcEQvdzNGeEFRa1FPemFjUVJxK252UFE4YmN4cXFBR0FTMTgv?=
 =?utf-8?B?VGFXZU5aOXZCMjRNNTR3MkJMSVQyb0Jmc3VuWHpPM051TjF2LzJtQ3BORElh?=
 =?utf-8?B?VDc4UFh5d3l4M0ZIL1ZaZ053cjcrcnNyU2pkYlBOOVNwUlhqdDN5VjRVeGhY?=
 =?utf-8?B?MHVQOThXNGtCTUtoRUU3MDNkY0JiT242c1hqUkp1ZDEvOWZNNU9tUlBvc2RR?=
 =?utf-8?B?eUFmYU9kV3dXNTh1alNzMGFvSU1XeXVTRTY3ZTg1YmxVbFBLTDFuV3k4ZGZx?=
 =?utf-8?B?Y2JsWmU4NXlhWTBzZnFpYW1CV3pTMDNCc1MrdWZMZmhlaGVPRmZ0Z2NZTjRR?=
 =?utf-8?Q?nAGIeBT4YHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0xKV002c3psbEE1Z2gzUnV5Yk40QkRVUTFxNjBnckoxVUZubEllaXE1M3Rl?=
 =?utf-8?B?Q2dGK1cxaDVJWTRmNVZ5dW9FemwwR2RjTmwwRGs5a0N5WUk3QWlDY0FGeDdh?=
 =?utf-8?B?THFxOGxxTjBOdVlFVllyWE5ON01EZEt4OGFNVUVaUGtWbTE1ejd6N2piVEdX?=
 =?utf-8?B?UlhhQWl3YXZnRXgwem5EMUVmak0zRFYzK0ltTHJUL05sOTQ0MGlVaWFVYVF2?=
 =?utf-8?B?ejNqbi9NYWpaWGlXQXNRc0t4RG95TG5pZGFmL05tWWo0RElDRE8zeS9palhV?=
 =?utf-8?B?MTdDWGlvRTVSSHBLWUpWVlBnQ3hJTEpwa1VWRmZzWUVHb2d5UGNpMjB5Rnpv?=
 =?utf-8?B?TzNuejFKYjZJb0loWTlUT1ZuODVad2FpMU03aHgraGo2YzJwNWd2d2VQVUN6?=
 =?utf-8?B?WEZpb2RiS0dCd0czK01zaTJxQmFSUURLakZ6b2NJTkpXZXFmNE0xcGdLQURU?=
 =?utf-8?B?NHJJeEtjUnlGZEllMGpJYVdkcHYvd2ZrQmdnUDNSc3YxLzlZazBla3I1djJT?=
 =?utf-8?B?a2FCc3MxMTlOQjVBMitDanJMMXo1R0U4dkMyZlVxYnpKa2JPQUFPMkFDS1FF?=
 =?utf-8?B?SVNGbUJwSE1XU09pRTRKVW5BUXBTZFZvRTkxdzBUbFBVY2xhdXF5S25UN2gr?=
 =?utf-8?B?dzJsMVIxcldtQm1aZmk3QXc3alRwSXJOY0tRMzdFc0xVK2dDTy9WMVM4MlIx?=
 =?utf-8?B?dTFBQWl5alNyUmVZbm5QY1Z3djg3TU5yV0xPUnhnMVNxTWd3aHJVRUU2blZr?=
 =?utf-8?B?UGhzOVNhR05YS2JYSGZSN3lnaWsxS0FTQzAzamFtak5RL2gvNHVBa1hDa2g3?=
 =?utf-8?B?dmVUZ1dBbkZnNFJSTUtPUDhlbEFQMTVCaWJaWGdhUmtJWVp0bzk0K20rakkw?=
 =?utf-8?B?d1VORW8zdUZYS1dDK3RYSE5CdWozSjg4Q0tRTWlEOWMxUzVFUUZPeUVYU3pX?=
 =?utf-8?B?QkhlVUNsNGg4ZkxUNFM2RGlvek8zdmRqREthMHkrMkZOM0RJNHk0N0hOc3N0?=
 =?utf-8?B?MmVOM3NnTHROd292SFJhNVVvL3pvMFNkdllBenp0YStKVnpqdGc4UCtjdDZO?=
 =?utf-8?B?VDgxRDl2RUllOUFJSFFvOE8zaGxwenZqNUNFRHp4YURhYnpkeWNZZDdHQnlL?=
 =?utf-8?B?a2pJVTlCSDVzOUFTRXlOcGJlaloxL1dNdVhDQlJaVGlydnR2Y1ZqMTEwTHcy?=
 =?utf-8?B?RTdyRHU4SjNYbkhBZng4cGVybk43eDBJdlVXUGNPdXdDTm5iWjk3WTVueVkw?=
 =?utf-8?B?dzV0dm5QZEU5MGtMemhzZ2VteHo2aFJYcU44L3RQMVZ4MFhweXMvalF3WDFk?=
 =?utf-8?B?UUxPUGNHL3RzNWxZWDlaV3Rob09zVmNxeDFPcHQwaDJkUGc4c1VrdmJlcDhW?=
 =?utf-8?B?b3o1MjB1OENGTDhFMHJqNUpDaWk4L0FQMHJPeEdVOTFOSjkwRXp2SDloM3Vl?=
 =?utf-8?B?M2JDaVdUYUc5anlZVFRxZzE0TC9sM3pnMHYvMHRCaGR6ZVJDbnpJS2NJQmgy?=
 =?utf-8?B?WWc5MFdFMW5jWUo4bHVjOFJIR21zM0hiamxiTnppMVZtd2hRL1J5MEVqSHFE?=
 =?utf-8?B?bXRKWDZWRU13ZmxVVUc1dFh6bVhDdjM2SmZWcmxwZ0hBUUVtY0JGbnJld0ox?=
 =?utf-8?B?U25TYlhLeU1EUjBCY1F4M3FNOXJHV1JEQ1QwWHlDQlcyS1VsYWx1ekQyLzdt?=
 =?utf-8?B?ZHVpN3JmRTNEMCs4ajlqTkVGZTZIVGtaTjJlbFRXalphVklncitWNENscjhT?=
 =?utf-8?B?a1JIRlBLVHVqSFZwWjMyQzVlSld5cExkWFJ6QlJRTmYwaDdkZzVQWm44UUF0?=
 =?utf-8?B?NStxZlpVK2xjZ3JqTzRGb0tITElFVXhZRnFVbkZoSzlabUVQMytEMmFycHha?=
 =?utf-8?B?eHZNWFA4clBEMjNkTllpSGovQXVuRlZTcHRYZ21yUkdDclZDS2hpSWdjRmJS?=
 =?utf-8?B?M0lVckFPcnlpVW1acGY2UXY4c2dRa0RFc09xRXNndjFHSWtqdm5mQ01OUk9D?=
 =?utf-8?B?WlNIVlFXanNWdzFhK3Ewcm9tUEprazFhRi8ybWZUK2l5bEFHSCtsOSs4YnZt?=
 =?utf-8?B?b3I3MUFUdlpHZ2luSXNvUnJSSmttdUluR1I3bzNONXByMXJJRTFPaC9rVGUr?=
 =?utf-8?B?M3BUcHdPcjl2V0Y4MDdQQjAvZXlrKzZLSTNYbDY3ZFRsMm9HbzRCbXAvczcv?=
 =?utf-8?B?ZXY4aGk5MkJ3ek5OZDNQc0g3Tk9Za3V2eHRMOVhhMkx2SXdRcncxYmNkeUZB?=
 =?utf-8?Q?7t4duQGDBF4s5IMDGBfCVFu4miay8QCX+uKSX+Ad+M=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a593f0f-f0da-4d25-0634-08ddc32a7551
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 23:02:08.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpGCORlq5CXkmdQ2pX5wejbS0CzHyhoCJO5dTSCJft+WXQZ6sqxIngd4aIBDQu1R6vw4hJI88jnSLPj3DSByubf8FSt41MgvamO/95TE6EDnwMd8AqGuSGz+GBOxinYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6316

Internal review discovered an error

On 7/10/25 15:12, admiyo@os.amperecomputing.com wrote:
> +	if (pchan->chan.rx_alloc)
> +		ret = pcc_write_to_buffer(chan, data);

This is the wrong check. The rx_alloc is expected to be used  for the 
type4, and the will be called from the type 3.

Going to add an explicit flag instead.


> +	pcc_hdr = pchan->chan.shmem;
> +	if (ioread32(&pcc_hdr->flags) & PCC_CMD_COMPLETION_NOTIFY)
> +		pchan->chan.irq_ack = true;

This flag can be removed and replaced  with a check of the value in the 
original buffer, which is held in chan->current_req.


Updated version of the patch series to follow.



