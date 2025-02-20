Return-Path: <netdev+bounces-168183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EE6A3DEE3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D130B3AA964
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356FD1B4243;
	Thu, 20 Feb 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hjMK10Yu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732611C4A24
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065935; cv=fail; b=B65grct0GjJZHZ48jOdflyoe2xmAFgYi+jykvLw5MElU9B7F+8fKikBCmddZxK8zLvkoWgEBPlJAX/CZ1AphgI4fzTErcp87zO2q3jaHAyBBbQQKsr5Jcoxos6jgECUvIMMPlp8uggd44crm9ci/4mvfxYAIqms9oEoLlZJWvYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065935; c=relaxed/simple;
	bh=LHJ6mFOzekjuAVpg0LN8JfVv9X9WJMUF5oA3UekQ1cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sStAtBkRWALGm/xFNJZjFW5ldRWH4rthIP/fXSRA+2JzQz5XC7NSjgfa9/1VLXjYlISkp51IG0VRdzlJnP+zZuBhiN8957xchzbrF+LXSIZJMP5+rIrD1qJj6t6PzGbVlEhKOXEpKBiay2wGwJThHS871W+l9KKeJMjEHCkUdbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hjMK10Yu; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvulT9RdljJZchScmdntNKKiwHkp8hXXdOcEy/axJ1EQD+xc7xlwAHkuK0VW0Nip69lFytHD8w4tidQW/HAml2UOx45n5bo7PcsfdAi2vPkv7oib6gyyzB4lTABeixiSlzqSTeV2bg1779xOh6JXH974ZKcg3XxGXrJ8Pc7308wFfYMtPWMvO+ym3B9A94Lmajvk5LLFk8PcY4xpBvt3jbzq3AZ/UT6tbfA5ApIYFOQ2A/OLaMMxftvPUrjwk9w3nd2xJJRNcKTXfDvu4rizhbPi9WoE9fcVL+hR0t346fplk+G3DnHbRsI+R1NaMX+wO8ugxx60KbDDNN8OKGxIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+C+ly+2aigiNMVnYd6h2NwvZ/fQ4MV8Tg3Dj6WwMY0=;
 b=Tq+2Zdje/X+xJxpLX8PHxnxfiSspnfCMQxWkuOQZgJwLBMeVV8WtPhg4JLIgvvqs1ZP5TRMvDUthUPij7a/wW2mdiH4paF+zcoDYw8oVrT9QuBNQMxozr6QRZMkjAD7ApfXwt857XxK0TlFgd7Ae+5/czG62Y1w42W4bNr1jdEp/WM8w6qcnnU8tr04ZlHzq+GtRC9atvx0eVBK3BU8ZVuF8L3FCJ5z7YMAdgwEZYTMIEsvS/j+Pk8cmJ1ATk+02wWus2UG6WsW94LMfrdoniWJSmD+Ef9dk6ykR4Ra9LWeXFSDPWEXqCIfBitMtqElqi2NfQOjZxY8SJqPFf1xXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+C+ly+2aigiNMVnYd6h2NwvZ/fQ4MV8Tg3Dj6WwMY0=;
 b=hjMK10YutrN0+MJd5VW3owdf9hUATA7Gs+p3yWVDb7ahwIhUe8Pv+ACvasM8C+s2OrW55Uo0AqlHIGiRRwbwBGWnYMjZfV3gsmyU153/0bQsOu7Jn+7YpEGQf97cTMW4KCKp/GyvJOiAydxZ5rnc7x5EHDADziTbZB5eH6fQcpaIgecqTRfJw+paMW/4W4DUF/w7IumpmnN8CXso2IfSkPxNIlSHlEMAYIAvHXOGx9LFAwFcPtcxvzKIUcefFPngwIsFTFDNYFLvc2eKAw2x0yKdw9SQzu5TtXIiLdHMG/4IQm8DpNor3koFXCqlB+lrVdoJjDQxMN/wzkcPAcCtKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 15:38:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 15:38:50 +0000
Date: Thu, 20 Feb 2025 17:38:41 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, maheshb@google.com,
	lucien.xin@gmail.com, fmei@sfs.com
Subject: Re: [PATCH net] net: loopback: Avoid sending IP packets without an
 Ethernet header
Message-ID: <Z7dMgRwCaJi3aG5b@shredder>
References: <20250220072559.782296-1-idosch@nvidia.com>
 <CANn89iKnRBQipCOLtFq-rVPOoaZ7M6tYVo+Fm1aYgCZnyqW=eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKnRBQipCOLtFq-rVPOoaZ7M6tYVo+Fm1aYgCZnyqW=eg@mail.gmail.com>
X-ClientProxiedBy: MR1P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: ad23534d-ca44-4530-bb41-08dd51c4ac7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFZJR1U4WnhYbm5VR2c4TTZQUVpreTBIYWRYZ3gxZjVVenI0UlVtKzUvV0Yx?=
 =?utf-8?B?T2xCUVplellacEJJQWpnQkhEZmFScTVYNkxZTUU1Znhyd3ZVRXREWXB2Mm5O?=
 =?utf-8?B?c0p0VnRNZXV5MVZJT0J2Y1hKRnV4ZEt5K2c1N2RyenNvV0hySEJERzJDZ0l5?=
 =?utf-8?B?Z1hodGtiNmFpOWk1WjJSdFpGb3V3WnpSK3pwWFUxMXFmLzRteVMvYzlIYlJo?=
 =?utf-8?B?NG5lVzFwSHhzZlNsak1WRytiaXhHbFk5TENGelJVeGtDRzU1WmdwS3JSWGk4?=
 =?utf-8?B?bXhjUXBHN1VmZVY2dHB6eWZYcGRwTDl3aGs3eDBKTUhBcUVhMTArYmRoNEtr?=
 =?utf-8?B?aHJ5YlJGNHYwSWgrRzdwOHpyZ3AxR0w2TEdSL3d2S0c0eHkydC8waUl5b1dj?=
 =?utf-8?B?OXVNdjV5Q0JUazErNW92RUlmNU9rWkwwVm5aYlNFVnhwQkN1bnNFdlZXYjhY?=
 =?utf-8?B?aG9uNmEvS3AvSStuRGVweG1GbVlOSjQ4eXBrbTZHS1kyMkEyTURzRWJLL3dH?=
 =?utf-8?B?K3BpNzA0eU40aHcxV2tkWFF4dUpZMWcrc3RYNmhTcHZNbnd0M21PcGVnelBy?=
 =?utf-8?B?RDFRcU5ubk1qbEdqZTZnRHVXTlBGUjVUMUEzMVRlMXJFanIrNWt0WFNPYlUw?=
 =?utf-8?B?Mi9yV0t0cEJCS2xsNWdXcmxOeE12dTVkUjRnTVpHc080OTh6aEhaUW9udDQy?=
 =?utf-8?B?MXE4Y3hLNVlYcEN4VU82a0hWNDBRRmMvN2JhY2s5bUpRUnNiY2FPQ1FPNEty?=
 =?utf-8?B?VmtQa3p6dkI1OS9GQk1YaGlZUzYwR1Jxek13TGg2Z2VqVGZRT0o4eTVaazBy?=
 =?utf-8?B?UVh6d0lwTE5vSVNpUmV5UW56ODNldERJOG1rVjQxOGFPV0hzV3hKeE1IOU5P?=
 =?utf-8?B?a0p4RGV0SWYvcWQzV0x6UG45bnRmaDdxZGREeTJYWUdRN3JXcjQrdVpiR2Nx?=
 =?utf-8?B?NFJHU29KVWc2RHIrNVNyekxmbkhVRllkSWlUQk1JZXYyZjJmNSs1SlA5dWdG?=
 =?utf-8?B?S2dROTlIOXhaS3lNRlFFT0pkbEFCandNWWw3bjFlS0dGb2NESTFhN05yYmI3?=
 =?utf-8?B?d29BV3FvS1hXVmJ5WUZpZmJhVE1XQ3lHZmRBU2lFZWlBSEVFNEFlczU2L00x?=
 =?utf-8?B?OVhqMEE0aTFsNkhwWXoydStka1BMb2J1Ui92d0FoeHp6K0NMaGNUOE95UnBJ?=
 =?utf-8?B?Tm01QUpjbDVTVTZ2cWl0R2xjRHpYWThubkZuZHRXaUREZW53ZUZwSG5vd2JT?=
 =?utf-8?B?b3BCSnExNnYwOFhtYVpSSmhIa1lvREIwdU91QXcxVVYrcmFUU24xQXdpTXBu?=
 =?utf-8?B?bGo2aGRueVlBMzdEMHM3UFV5anJ1U2YzRGQ1Z210WG0rbGR0UjNTNzRDL041?=
 =?utf-8?B?bEU4RS9GcHp1Y3ZLRWxKYXF0am1BZlRWcDlIRXhwNzJXaW9IOFYwMVV4M1JS?=
 =?utf-8?B?WVc2a2JzNXV4VU1CL0dPUDBzUnpad2RVWitZVnU0YjVrQkd5ajdWNjYvTlUx?=
 =?utf-8?B?RUpqRGN0dkFRUnZrSHZDc2MzWG93Z1ZWYjErL290RFYwRk5rM1NXTDBYVlBX?=
 =?utf-8?B?cjhvdU5SdjVJRDRpMDY4RE9TdzFIYjBBSzFnZUwrMkY0VnRoMHN6UElpWlh5?=
 =?utf-8?B?VFVGM2xXZGZmMHBTNVBadEp5RVREaXYyRGJFZ3E5c0licG5yZGcwSlRUQUZC?=
 =?utf-8?B?Rithd3ZZcU5rQ3JCeUtsbkVTQUNUV25uSXlMTGNJUUxmTnlEWDl6Y0VOS3R6?=
 =?utf-8?B?WCt6UjF4bDBualFPdy9nS1J1Y2JBN29wVzIwUHRrSWFNYTVJZ2I5cnNOVUtK?=
 =?utf-8?B?V0pzZXIvM2NURk01ODN5MDBlbDJIZ0h1NFErT3ZOK3RKcGFEVTNEcXdHRzdq?=
 =?utf-8?Q?IEqBHiq09gaxQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2FRWXBEa3pYZ1BFQjNoQ1pKbnJqR2pUUGZkK2NlWWJQMEY0MVRvSXpwRGRL?=
 =?utf-8?B?RnBsNXd6NUk0eUFhWEJQelljaHFweGdQbVNIZHp0ZGkwSy9pQVdiVmx0MElB?=
 =?utf-8?B?Y2RWWlpNOWNleGdkVnRYUFIrTjhMcEpWdjlKcWx6TDZBMmFUQ1J1S0pPemhu?=
 =?utf-8?B?M2VDWlRMNHBDQkEreXBUTjhTOFBCUDZHR1NKYXpEZUpXWC9CMk9DUnh4d1Nk?=
 =?utf-8?B?YVA1eDQ1ZGdyVm5YYnk0UXRvTnI0Z3JSV1Z5WVUzZnhEd2xuT2FiWWd5eVVP?=
 =?utf-8?B?eWw1dVpsLzFHN2pkZkovS0xMN2k5WFI0MnRQdG5mRGZ4QURVYi92N3NvWTZ3?=
 =?utf-8?B?RVdhL2dIQkdoa1R0RXg1YitBdklobVB6QTg5ZVliZ1cvc3dQZWM2emdPUHdE?=
 =?utf-8?B?V2VvdXlPVUtqN2xMR00yM0xKc2MrMVN1MStlQzYycW5DRFNWTkF6VVZlS2wr?=
 =?utf-8?B?SmZEUk1wMU5YekwyZVpwUDFMT1I2NXJnM1RiYWZ6d2xIL3dvcWxPZEZ3SVVk?=
 =?utf-8?B?eTBvdEhFMU00eFhHbEJ0eGtGTEJ1WXRKaGdFWmhFdVdybFNxV25NZ3NkWnNM?=
 =?utf-8?B?TnhLalk4YS9IRitDWDlDUk9wN1N2SnR3b3MzQnlCNzRBRGRwbnFSUTNxYmpp?=
 =?utf-8?B?aGlrTVhJZTZFL3QrZUdXWFgyYm1hUEJTWE1TQ0NNc200WnQrcFFzUFdNVmNj?=
 =?utf-8?B?eUF1RTdYc25nTHExUXJJZml5eGcxU0tyb3NGR0lWRUtvQWU2dVFrUURQbXFT?=
 =?utf-8?B?SHFaNzhNblZNQllNcEg5LzdHQ1k0aTlycEp1akJZUFluRnBhYUxCY2g1TFhh?=
 =?utf-8?B?UStRYTFiTmV5UEgwa2dCc3ZPVnF5aUJnS2hVOGtJRnI0N2IrcmxBZDFxRUk2?=
 =?utf-8?B?d0Q4WmYxTzhuZjlleGpET0VsNDI0U0ZsR3VoZFZDNXZ5WFZ2Nm8vZWNRS2FX?=
 =?utf-8?B?Y2s3SXEzR1REaFdaWFR0M3QwSE9EOFNlKzN5WlZXazdIbGVBSXJJR0JRZWFE?=
 =?utf-8?B?VGR1RjQ0dUhvZE5DK0hNYmJzTWdDdEJRS0ErSW1mdzc5cnZwODEzMGowc2hO?=
 =?utf-8?B?Y3pMSFFkM09OZUlsQmFjMXZDbWxvSUF4eHM4aFAzNjU1bkRrZmo0bUxvMXNz?=
 =?utf-8?B?NS9BVDZmZnhQVStYakdBWTdCUXNnclZ6MmFncnlHeXE5S0ExREZwa0x6TEla?=
 =?utf-8?B?dVlKV2prNGEzM1pwbHhTa0RoVkRGckpTSGZNblFqTjJBTXhnNXVmdmpkRXZ1?=
 =?utf-8?B?MDhzSVFvRzBFYTFPZVo1YVZlTm4waEZDeE1MSjQzOVNLT1Z3dVE0VWM3aUNQ?=
 =?utf-8?B?a2lCbUpoeTMvOUNKNGtnZ0JjVWJHSU1jU3A0TFZIUjNka0V5dlhZS1AxaDU5?=
 =?utf-8?B?NVNOWDVXTUgxVHpBUGo5UytUV3FkeHkvbnRQakVSL2YrVjFaNHluTllzTFhL?=
 =?utf-8?B?UWc1VUVkYkt2cXIrOEY3QWgzdm80MkJlaUlDdU5qYmlOQnRFZDZSMlk1OVUr?=
 =?utf-8?B?bDhaYkJxVmlhY0M5eVk2MDVqSUVPcnlsSVRXQ1Z4WVpndVUzaVJSU2tqUkhG?=
 =?utf-8?B?YmdGMERzVG80N3NUVmgrMC9tWFg0TU91YjBYazZtUHJzVVVZMVhJRkhNRStV?=
 =?utf-8?B?bUtPaWVSQkE4emhOU3crUWtweDdRMWwwYUxodVpEbjl2UThqUlFnV0FwdzFh?=
 =?utf-8?B?VTZjVHk2QkorQWFUdUdRQXZpNWdQWmUwK0xFcUJXMk55WThMd0pORTd3VEp5?=
 =?utf-8?B?c2IxcEdxQXhrcHIxWnJBQnIvYVNoWm1hTnMra3FVNDhlYU1vZmxJdWVMU2NC?=
 =?utf-8?B?RjhBN1dYbjZWeXBDeWdXN1lCTUtYS0RLc1l0emFYL0k0dmlLTG82NTB1enBQ?=
 =?utf-8?B?ek92VkY2elY0VjA4Y3F5V2tPTkhxZWtJKzRHRFJoV0VxYk1YeEdJVzRIYTlO?=
 =?utf-8?B?eTZSSWlIUmNob1RNdldlcWordGt6UHpJZDBqYytEY0ZPSjN6VEtMUVZIcm5n?=
 =?utf-8?B?MC9EZ0Z0MDQ3TVp3bnRoNzJKVE5LcFZneE1zUE5tYitJanRxb1ZvUG1rN3dX?=
 =?utf-8?B?N3g0blk2R2x3YmZpSlk2SVVQRGhyWjE1clA2U3lQUUF5K2lpd05JSHNZdzV4?=
 =?utf-8?Q?bw59KAqN7ivYTMzWBUIjtkNYJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad23534d-ca44-4530-bb41-08dd51c4ac7b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:38:50.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSRvrQYzNlah0UZLv0uFTM6Yd5URsqRe/FJ3vOHYQnb50r4lTm20HrlSzqn3Z9/kjYpzB7BLxiQMYgPv/nyMlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

On Thu, Feb 20, 2025 at 11:40:07AM +0100, Eric Dumazet wrote:
> On Thu, Feb 20, 2025 at 8:26 AM Ido Schimmel <idosch@nvidia.com> wrote:
> > diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
> > index c8840c3b9a1b..f1d68153987e 100644
> > --- a/drivers/net/loopback.c
> > +++ b/drivers/net/loopback.c
> > @@ -244,8 +244,22 @@ static netdev_tx_t blackhole_netdev_xmit(struct sk_buff *skb,
> >         return NETDEV_TX_OK;
> >  }
> >
> > +static int blackhole_neigh_output(struct neighbour *n, struct sk_buff *skb)
> > +{
> > +       kfree_skb(skb);
> 
> If there is any risk of this being hit often, I would probably use the
> recent SKB_DROP_REASON_BLACKHOLE

Not very often. About 10 times while running the reproducer I shared
here:
https://lore.kernel.org/netdev/Z7D9cR22BDPN7WSJ@shredder/

In line with the original report:
https://github.com/siderolabs/talos/issues/9837#issuecomment-2642116378

> (feel free to resubmit
> https://lore.kernel.org/netdev/20250212164323.2183023-1-edumazet@google.com/T/#mbb8d4b0779cb8f0654a382772c943af5389606ea
> ?)

Can we do it in net-next?

A few questions / suggestions regarding the patch:

1. Can we use it for IPv4 as well? I tested the following:

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 753704f75b2c..2aeab70c1cb5 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -966,6 +966,7 @@ static int ip_error(struct sk_buff *skb)
 
 	switch (rt->dst.error) {
 	case EINVAL:
+		SKB_DR_SET(reason, BLACKHOLE);
 	default:
 		goto out;
 	case EHOSTUNREACH:

2. Given that this reason is going to be triggered both for
user-installed blackhole routes and dst entries being destroyed how
about adjusting the comment? Otherwise I think it will be confusing for
users who didn't install a blackhole route. Something like:

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index f1d68153987e..cb269b3251d4 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -239,14 +239,13 @@ struct pernet_operations __net_initdata loopback_net_ops = {
 static netdev_tx_t blackhole_netdev_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
-	kfree_skb(skb);
-	net_warn_ratelimited("%s(): Dropping skb.\n", __func__);
+	kfree_skb_reason(skb, SKB_DROP_REASON_BLACKHOLE);
 	return NETDEV_TX_OK;
 }
 
 static int blackhole_neigh_output(struct neighbour *n, struct sk_buff *skb)
 {
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_BLACKHOLE);
 	return 0;
 }
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index de42577f16dd..0ef6869dbd1b 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -556,7 +556,8 @@ enum skb_drop_reason {
 	 */
 	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
 	/**
-	 * @SKB_DROP_REASON_BLACKHOLE: blackhole route.
+	 * @SKB_DROP_REASON_BLACKHOLE: blackhole route or dst entry being
+	 * destroyed.
 	 */
 	SKB_DROP_REASON_BLACKHOLE,
 	/**

> Otherwise, this looks good to me, thanks !
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

