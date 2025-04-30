Return-Path: <netdev+bounces-187157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A57AAA5524
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 21:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9701D188A2DB
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 19:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA9D2750E4;
	Wed, 30 Apr 2025 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="kSWX6ks6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF370264FA0
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043049; cv=fail; b=HCSnuM4NefS4t3ngbwEy5BgvLTBfihJjC76gUTMx1s/B/3mzAwl2HcoD9WnbgQZY8FoGGyYmFdO7YgRU0GMpOq5eoOeX6yXhj9RnGzOrtX6KqaM6Rhdv/V11JxSbixrrTHiEn7HWaPF9hJIKic53emmhQeWMdnmtHrBocZ39I+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043049; c=relaxed/simple;
	bh=8hyWshHtCdBjwIZRriEH8BmF8Mj043yTVICQPetSWUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o0adedr4LMqUxUWp1c1LViha3mGu5iTOszaVvHDa0jAfuA13+jiHq7iMV/BKklaqeHrWlVxxXizd9Wl8URP+iMtMbPAFWAgT3lCuu32Hzy8cMcgPKTA8yhVXGfFa4a4+BC1jMkZpNEm7orcugh3IY7I4sHpvMjKKQs2n6xKAcoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=kSWX6ks6; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1746043048; x=1777579048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8hyWshHtCdBjwIZRriEH8BmF8Mj043yTVICQPetSWUM=;
  b=kSWX6ks6ErK4SFYw/IB/IrJ/rH1MqSHTRBlVRI+U2VRq+Fvp9bhAw3jD
   K5h/R3XRZmePiCoKtWeyvSaEBm9e7KzSJKK3P5OeWRJxkDXQuTIt5AeTv
   6h2aUEk0aj9qjuC7Lbcvw5MLl4tZXy05z9zLl+UpSd0uxiBdYCIE2mcHM
   g=;
X-CSE-ConnectionGUID: AKqqBsNeQs6apafKAXLYYw==
X-CSE-MsgGUID: ymTuJ2E+Qmiepw6TKYlAUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AtE+cCGnybHeCuqRYvfQ14VwzJtzXOVT+1W76OGm?=
 =?us-ascii?q?1MH03QaWcR3y5yIdVotU7zg=3D=3D?=
X-Talos-MUID: 9a23:beh4ygtQWKIDOykfFM2nlTReKeUyzueXDUEAiYpYh+q1MQVNNGLI
Received: from mail-canadacentralazlp17011054.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.93.18.54])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:57:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQPP5IMq5FMCVVA8mmkoVCnZVleqkfL9gD+IjMTuTZRbhY2IU6i7cyhaL51auncdskyhxrvHnQx93Gdr20IUln7q/JTk7hVYKgJpriEqLjGOaW+ZK9Dshuq3JerIEgjjXQjnXd1Y+LK7utOKLCXr+vz500FcX21J2tQU9pVkMm0TF9SwUYgLJdHYoO6hzYAZdxUzDob2YIHXaxPWuuAs+8X4/xcm9uChOTFAZOEA6pX2rWZc+SWrrErTeEKrYUF627q/GxpE6JIokmBDndv8XCLXZfYJhWVhlqdoJ1O1S2RjHDjTneryObYGgRNHrOX2p1nIDCs+MFQbF4JYvmxY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mPa7FgvN1pKuupxVkHlZaviI73IJToXY1K28k+rgYo=;
 b=C3RfQqHAnfL6oPW94v0MsOvQ0mTZCBh4T7XHY2+JQnjZQMJqAXO5LAy1jqREUx3qAEw9yMP77oI7O2lIITN0hNbdr40T/JFNt83JcDzZjsEDEcTf9uANDyfpa7EYMOs76mcxcnb+AIZmrcmFFdCKlu6yTtoHKkKJZGKeeGwK5WNQv5Y6Bw5w2vQmk+dr51U5MZAy+58Ui38jvr7DDOl4T52yceViyHxnMUH5f1VSqACe14NF/odpXiqjpUQOhOy6mwj7NfYGametYmn08DusTz8TlkJDBnQcRyUWSp+mw2Ty/O6Sw9JCYwjAa6IlGTtSWBXeqauUDEuQAkmJnjgLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB6029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:59::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 19:57:23 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:57:23 +0000
Message-ID: <a8a7ed7f-af44-4f15-9e30-651a2b9b86ba@uwaterloo.ca>
Date: Wed, 30 Apr 2025 15:57:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 jdamato@fastly.com, netdev@vger.kernel.org
References: <20250424200222.2602990-1-skhawaja@google.com>
 <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
 <db35fe8a-05c3-4227-9b2b-eeca8b7cb75a@uwaterloo.ca>
 <CAAywjhRM8wd67DwUttU76+6KrKUki-w9hgkbVskhVG+nJ4JNig@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhRM8wd67DwUttU76+6KrKUki-w9hgkbVskhVG+nJ4JNig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::21) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a48edb-4020-47c6-b2b6-08dd88213902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFpjUkpHUU0yTzU1WWxBR0JqY2o2NlJHNmVGcU9ocUZRaWJheU9PT3B6VDRS?=
 =?utf-8?B?NURnb2lUZ1habGR2cjloNjNpdHE4S3pldytNQVNFd1RwYXF1NEM1YkJGUlFH?=
 =?utf-8?B?SlZSZlVraFppOU82cjFNbi9UNDJDTEx4OHR1djlFSmNYOXo0OWZvR08zTUor?=
 =?utf-8?B?K0dCYmd4eG9oL0wxMzVFS2c1RkZqK0RBU1ZsZVZFSDdzY0pEbEVjZU0xbXI1?=
 =?utf-8?B?NjUydE1BK3Fnenc4MktIcGVjSFV1V09nMWhyUGFYR0UzeldtckNVTC9JV3Vp?=
 =?utf-8?B?WHRvSTlVSVg4ZDdlM3poMTczaTN6WVdiRUJ4dXdZaFZ0MW1xcnVGV3ZFMHVO?=
 =?utf-8?B?NGErV0laV292MTMvTGhJa2JIMVBNZFg2SHNXSk1NOVBHR3FhZlFzSU9jMVBM?=
 =?utf-8?B?Y014akdWcjVUM2k5bHFwSXdoVXhPL0pHLzNBeGVWV0JuT1B3SlRYRDk4blZB?=
 =?utf-8?B?Tmx1VnVHS1JERzJqb29iWTFRTS9vQ21xQWl6cHNKbkNLdFVTb2ZETzBlRHpz?=
 =?utf-8?B?aVJqYnhyanowc3Y2Q3BYZnB0UG00b1o3b0JSKy9jNjFJMjYxREo5NWttSVV0?=
 =?utf-8?B?T1dFS2dFTitzS05JUVRMeldyNU93WlY5c3UvQ2VtVi9vdTkrUjFXYzNKcDBi?=
 =?utf-8?B?WXBMd3lWQTNRYTFPZnVTRWV2YWxIQzNSWTFCZE5DT0kzd1VGWFdoS2YvZndU?=
 =?utf-8?B?NG9lOE1jcEZoZ09sVXF3dDNxVW9PMkhvdzVCWEQybWZmbDB3OXhSdkRqYnVI?=
 =?utf-8?B?RktkOUN5dFBuSnBuYWhZQjlPNlF3YXhWdFRkVHR6L2h1L05TMUo3bVp0ME1P?=
 =?utf-8?B?ZWZsZllEeFR5R250T29iWWVGVW93UTFuYXZiWWtMcmtuY3Y1VEFXRzMwZXM2?=
 =?utf-8?B?cGwvdk9SMDV5OVJCYzgwODBIbS9oZGlGRXVCTnVxU0xnUVRnejczUldlWFZl?=
 =?utf-8?B?cnpFbG5UVzVVQjJKV3Y1UkJNc2NwOWJQRTFKeGlnSUNIUW1NOXZJYjJkZGN2?=
 =?utf-8?B?STI0Mngvay9nV0QrS01TdmUvSnJoRStld0hzODVOOW0zWlo0RXZONmFMUm1Y?=
 =?utf-8?B?TG5Rc2RHN3FFZXNRV25oeWJLeENnaDJ3QUN4Zkpkd01FdUU5Z1hCaGtwVXpr?=
 =?utf-8?B?a3lQTjhPWW45bWRWUjV0bSt5QnorV3docmwxRUZsTmdqUWFQVTB5NlMwNzJN?=
 =?utf-8?B?YWd1Q21Db25LL1k2VEwyQU80bzVNajh6dUprRnFKeTkwOGhiSXIrQ3RPRDZL?=
 =?utf-8?B?Y2J4OTF6aytUc0FVdVlBNjJ1Sm5Ydm8zU0tOeEtTaExCcE51MXNnUWFFM0F6?=
 =?utf-8?B?QWp2RENyWEZXVHE3cFhmbGg5cEVid0ZlV3p4bTVKMW1GVCtDTTdjTkFoQmlF?=
 =?utf-8?B?aFcwenlwN1QzN1ZFeVQzWVlQV3piQjZFNFFrRkZocUxZNThRZkQzTlBBSnIz?=
 =?utf-8?B?dWRyTGIzN3lXSDhXVjNYcWFKY3V5dmpkZk1WREZFQjJ2cUR5UHgvR2lFdDZo?=
 =?utf-8?B?c2RLVTIyTHcyZnM0MXU1djVCSWN1UXY1NWJ2ZFFtTTBsMnBUVXlwajZLbWI4?=
 =?utf-8?B?UTgrNnJCRG5wcXo1K3YwRjRINld1a3NHaGlYRmVhdG50TjcxVnpPbnJkcEZR?=
 =?utf-8?B?UmpiTkZiMnRZMHJQVmNiM2c5OUlPcUxlUDlzbHN1dGQvMmFrcjdtVzMyc0l0?=
 =?utf-8?B?eVhBUkVCUktqU1FieXhpNjlMbUxqcXVaU1JZSU9YOGsveXk0cFZWK281T2JQ?=
 =?utf-8?B?VldYb09lMFVaWTRPNEUyNXRWeVFLUDJ5VGhvcVowTFliVzdvaEs0U2dlRzdm?=
 =?utf-8?B?Y0xlYVg4d1lKRlNxUm5oczhIcG10Zlp6M3VBUENsWW9hZVZJV1ZTYjAyRWNL?=
 =?utf-8?B?QWVhd1YyWERyVVE2WlhIWTFIaGs0YWNHWVJWZldxSTN0cDJoNXJUcXhPUXVa?=
 =?utf-8?Q?PcK4yfs+ZhA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTZzaG9iS25oNVRnLzVMdFpEcXVZSkxDd0lCUEVjd0dNNlBNTG52QS9Oc0dn?=
 =?utf-8?B?Z1VpRmt1LzROSE5IRHptQlJTZjY5OS9qOFQ4Sk9wa1M3YnFZNjE3REI2Szgz?=
 =?utf-8?B?MUtndEhEZ2lMSmFnbjd4eVJaV0g2Q3JzZEZ5dUE0Y2VNVVB3UitEK3BQQjZs?=
 =?utf-8?B?VVRYWFl5QnRpekU4OTI5L2xTZzZERDltdmcvQ0Fzb2Z5YzJEbDZYY3F5SVhR?=
 =?utf-8?B?K3V3dDVJRFBVTjNrSmlMZThKWW41Y0xnUEZWWFZiTmh0dkJOQ04zN2dnUWkv?=
 =?utf-8?B?Qzd3bmNmaXpaK29mMHJQTmRISm9WVDJUMmJPQnp0bXUwZzJuSFE2Q2FiVkRo?=
 =?utf-8?B?ZmcxeGxOMWVRVkpjakJhVmpqZGN1V2dGbTlYM3kzY3l3MFZiTVBBR1lPMklE?=
 =?utf-8?B?TlB4dXVTN01JNHZYMlhSVGlxb0I1R0hVZkFqRzZrZGpjcEoxbVhYaDlrdjhh?=
 =?utf-8?B?dmZIRllkNjBUVC81cE9lcXlWRUNGdVhNRVNwQjhLTEQ0Tk5jYklFZU01QjRj?=
 =?utf-8?B?WjFhaFI3akRra3ZwbGZhNDZseWk4dklBV3ltWjVnQjkzc0FZL2doM0VjVGZY?=
 =?utf-8?B?c3dHMXI0dVpnRiszQUtDZHkydVVBT3ZqcHBDc1BmTmNFVlBkWEhLT3k4R25w?=
 =?utf-8?B?Y2lucGJjZFU1TDgydGdVVFhlQ2p3K1U0SUVaN1dUYmJFY3ZaRmNlSUVmT0Vu?=
 =?utf-8?B?ZndkRUJSUmlqcDNmbTg0ZHpRZWZ4ZXZrMzEyeWdFQWpEa0dVQ1JvZURCQXNn?=
 =?utf-8?B?MytPL1lZVm03VC9WaHhaTm1tL254TVhhcXFqVWYxY1BQK2tQWG1JT0swTDVl?=
 =?utf-8?B?N2t4dEpPTkwxV3pEUnp2WTFWT0hRb2NURjhhYjk2VHZ3am4wbytnV1NBTmdu?=
 =?utf-8?B?Ti9FbXJ5S0pKRUF6cmJsN0hxbERPd1EwOVVmK0ZZUXR6UTZCMjh4Z280aUw5?=
 =?utf-8?B?RDRWOFlJNzB6TndTeVo0dklVTkNpQnl3cjhJNUlvSHVpOXZLMk1vcmJZdVdQ?=
 =?utf-8?B?ZndPVGx4b2JuOXpRaGdxQ0NtNVVWcGdNc2FSYlNpMm8ycFV3Vnk4ZGx2WEJQ?=
 =?utf-8?B?MGY1UUJrbHFrTEg0RzFESU4zK3R3YmFESHhwMmhGZU5paW02eWhMK3o4eG5X?=
 =?utf-8?B?VVhRbGtwWlgxU2J3Sy9aTU9OUTM4eWIxTmZ2SjZKUlV5T05WN1B2elJ6MS9S?=
 =?utf-8?B?eU1MdkZ1cXdCQVhWK05RTzM5L3I3d2l3MGVkNHJWQTR2RXhiaUcxMTh3VGpQ?=
 =?utf-8?B?eU8zTS9KMTQ4bkc0TndEVTdKSXUvQzVvblRjaHNYN1B2UXBkOTJHNDJWMHRG?=
 =?utf-8?B?YXZ5TE92R1owZS9WbTZUK244QjBjM3VWM2wwekZBNFJmcm1NbGFxQ2FHalRV?=
 =?utf-8?B?ZlE2c0pkZmlWbmJDL2RKZ1lLa1RRMmNwQ3dMYytrZUY1QWw5ZzJ0NVNNYjFZ?=
 =?utf-8?B?VGFIWGVrY1ZkRk93TFVXWnMxVGVFNXdsUFVZVnVIaE05WG9jTjY3Q2NCdHNB?=
 =?utf-8?B?ZHR4ZGh2c3JwQk9CdE1RQlBPRE0rbURoMUdWbHQ4SW5iNWJOMlJyUGRmTUI2?=
 =?utf-8?B?UTNkVFMrWlY2V3c2QmxoQmJkOStLK3RWRHNvRGl5RGlXeDlQMG1QMS9HZktL?=
 =?utf-8?B?U1hJM0t0TVBNYTJyZU05YUNWbHBXZVJ6YzNRRFhNTGRtdHRRVHdZRGdBKzdQ?=
 =?utf-8?B?VUV4dHZyV2QyTU1ORi92NXVpSUxteEJuWGJlWC9KOVF2QkFiRTlTKzFXVktC?=
 =?utf-8?B?Wjl6WUsvYkZqOVEwcHhFM3FjWTZaRUJPSzlGVWVEdkFHb3ViUURQdGsyYXFr?=
 =?utf-8?B?Y3A4Z2R1VEIzQUsrYzB4eVZVRmZiYVRiOCttaFdiWjB1VlJPTVBZVzlobjlh?=
 =?utf-8?B?SkN2QlJTTlpvclNzQnZFa2l1SytJd1dkWkRCOVl1emNRQWVPQTE3T2k2Q0JM?=
 =?utf-8?B?eUpUdmRsYkgrR2RiYnIrOUFtQ0hPcnluWG5uK215WXVaYlpjbHIyN24xZDBy?=
 =?utf-8?B?aFIzbHBKWU1oUXVmRTVEQUxWNmMwcjhTK3U0a3JPOWZzMWlVQW9UYkJ4RVd3?=
 =?utf-8?B?VHlaS0xINTMwRkZVZ0RWL1l0Ylg2YnBERytobENRcUJmUU9yVzJ6Mm5Dc3hp?=
 =?utf-8?Q?4sVyhk3KZwzx9cPxxhudGidRv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3HTuWMjrKCtsMwsWm8P1gYk0T0NzzBMbMk0Z/XrLQK5KwtR3/UHv5KVrFRU3CjZLQruXdYwfuQe38VUiG0JUU9j0x1xweYxJ1b5pmLUeaOggSYrSmhRrzWTa1b9Z8A//SzYxV2xSZ7bLfOGS1eohKb+pYowc3bi1HpBSEW/NOaX/kNrYUsnpKWtvTOguHTAd1+RChsBI6RdfMOlG4H9ZhG4LVTB0cBhN+TqjTcUtidbwUqW8VmqEIoF9TFDp2AINJNc50iUKZmgs6XSNDiK5T5n4zH2ne29lekBKVLh5LtDittWZGYW+tVHn/3OvwgIQBHYpeN49HnnI59z9wB2a54RQftiwlbhnvTGmek3bCSpcdcKCmvvkm0nwXJhapruQpe87ZOI9ZwJjckPJjOkrJRDUn8mPPh/st3Lty2sKpMKPqLz1/QA5XAfdS1fQKmLE4hGwpzFE81E/yUC1+4i1rjw1vNUKdxgeUPv9hEBvtQuCAm2UuhztR/XHZ1gW3BSLV2x5wcSP4k7bDALaiJlezTslvOIDZXPKT4BXPsA6jFV0cwUggYOBmhUVhEv2Vn0yY+W5AHL6UQSediXf6o45/fTibTxUyIUAN1On7LLdFbwOC966yw6KwOEB1MBPsNhg
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a48edb-4020-47c6-b2b6-08dd88213902
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:57:23.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEdXGcMx1WjBQau/abO+PmWD1S24k64Bu8aodIJVrQBSS2nRc1AQw4wjzkWjH/ZnN/AwmoYTDa3gnyy5kT9ZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6029

On 2025-04-30 12:58, Samiullah Khawaja wrote:
> On Wed, Apr 30, 2025 at 8:23 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-04-28 09:50, Martin Karsten wrote:
>>> On 2025-04-24 16:02, Samiullah Khawaja wrote:
>>
>> [snip]
>>
>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI
>>>> threaded |
>>>> |---|---|---|---|---|
>>>> | 12 Kpkt/s + 0us delay | | | | |
>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>>> | 32 Kpkt/s + 30us delay | | | | |
>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>>> | 125 Kpkt/s + 6us delay | | | | |
>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>>> | 12 Kpkt/s + 78us delay | | | | |
>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>>> | 25 Kpkt/s + 38us delay | | | | |
>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>>>
>>>>    ## Observations
>>>>
>>>> - Here without application processing all the approaches give the same
>>>>     latency within 1usecs range and NAPI threaded gives minimum latency.
>>>> - With application processing the latency increases by 3-4usecs when
>>>>     doing inline polling.
>>>> - Using a dedicated core to drive napi polling keeps the latency same
>>>>     even with application processing. This is observed both in userspace
>>>>     and threaded napi (in kernel).
>>>> - Using napi threaded polling in kernel gives lower latency by
>>>>     1-1.5usecs as compared to userspace driven polling in separate core.
>>>> - With application processing userspace will get the packet from recv
>>>>     ring and spend some time doing application processing and then do napi
>>>>     polling. While application processing is happening a dedicated core
>>>>     doing napi polling can pull the packet of the NAPI RX queue and
>>>>     populate the AF_XDP recv ring. This means that when the application
>>>>     thread is done with application processing it has new packets ready to
>>>>     recv and process in recv ring.
>>>> - Napi threaded busy polling in the kernel with a dedicated core gives
>>>>     the consistent P5-P99 latency.
>>> I've experimented with this some more. I can confirm latency savings of
>>> about 1 usec arising from busy-looping a NAPI thread on a dedicated core
>>> when compared to in-thread busy-polling. A few more comments:
> Thanks for the experiments and reproducing this. I really appreciate it.
>>>
>>> 1) I note that the experiment results above show that 'interrupts' is
>>> almost as fast as 'NAPI threaded' in the base case. I cannot confirm
>>> these results, because I currently only have (very) old hardware
>>> available for testing. However, these results worry me in terms of
>>> necessity of the threaded busy-polling mechanism - also see Item 4) below.
>>
>> I want to add one more thought, just to spell this out explicitly:
>> Assuming the latency benefits result from better cache utilization of
>> two shorter processing loops (NAPI and application) using a dedicated
>> core each, it would make sense to see softirq processing on the NAPI
>> core being almost as fast. While there might be small penalty for the
>> initial hardware interrupt, the following softirq processing does not
> The interrupt experiment in the last row demonstrates the penalty you
> mentioned. While this effect might be acceptable for some use cases,
> it could be problematic in scenarios sensitive to jitter (P99
> latency).

Just to be clear andexplicit: The difference is 200 nsecs for P99 (13200 
vs 13000), i.e, 100 nsecs per core burned on either side. As I mentioned 
before, I don't think the 100%-load experiments (those with nonzero 
delay setting) are representative of any real-world scenario.

Thanks,
Martin

>> differ much from what a NAPI spin-loop does? The experiments seem to
>> corroborate this, because latency results for 'interrupts' and 'NAPI
>> threaded' are extremely close.
>>
>> In this case, it would be essential that interrupt handling happens on a
>> dedicated empty core, so it can react to hardware interrupts right away
>> and its local cache isn't dirtied by other code than softirq processing.
>> While this also means dedicating a entire core to NAPI processing, at
>> least the core wouldn't have to spin all the time, hopefully reducing
>> power consumption and heat generation.
>>
>> Thanks,
>> Martin
>>> 2) The experiments reported here are symmetric in that they use the same
>>> polling variant at both the client and the server. When mixing things up
>>> by combining different polling variants, it becomes clear that the
>>> latency savings are split between both ends. The total savings of 1 usec
>>> are thus a combination of 0.5 usec are either end. So the ultimate
>>> trade-off is 0.5 usec latency gain for burning 1 core.
>>>
>>> 3) I believe the savings arise from running two tight loops (separate
>>> NAPI and application) instead of one longer loop. The shorter loops
>>> likely result in better cache utilization on their respective dedicated
>>> cores (and L1 caches). However I am not sure right how to explicitly
>>> confirm this.
>>>
>>> 4) I still believe that the additional experiments with setting both
>>> delay and period are meaningless. They create corner cases where rate *
>>> delay is about 1. Nobody would run a latency-critical system at 100%
>>> load. I also note that the experiment program xsk_rr fails when trying
>>> to increase the load beyond saturation (client fails with 'xsk_rr:
>>> oustanding array full').
>>>
>>> 5) I worry that a mechanism like this might be misinterpreted as some
>>> kind of magic wand for improving performance and might end up being used
>>> in practice and cause substantial overhead without much gain. If
>>> accepted, I would hope that this will be documented very clearly and
>>> have appropriate warnings attached. Given that the patch cover letter is
>>> often used as a basis for documentation, I believe this should be
>>> spelled out in the cover letter.
>>>
>>> With the above in mind, someone else will need to judge whether (at
>>> most) 0.5 usec for burning a core is a worthy enough trade-off to
>>> justify inclusion of this mechanism. Maybe someone else can take a
>>> closer look at the 'interrupts' variant on modern hardware.
>>>
>>> Thanks,
>>> Martin
>>


