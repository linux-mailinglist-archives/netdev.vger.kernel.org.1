Return-Path: <netdev+bounces-164505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E2A2E041
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07A71885EE8
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE361E231A;
	Sun,  9 Feb 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FmZYKIhx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675DB1E0080;
	Sun,  9 Feb 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739129900; cv=fail; b=ZnnqzJgt0uF4LCaDtXPUlwuuU14Vq73lgubp0k0iQoHPMSiEfp7Q2hrkh5COCEvdPBYxZkz88flHBwkYh6LlA2090fZFkIJ/yD61fAgU3LRwucQG4UdQj9FZNbu+oBH0FgpNJ4wNsOV2cghsailHJzcL6fpR0RiQw+WHe0rBDnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739129900; c=relaxed/simple;
	bh=IOpvEf4R8rLkMc6By9eT4zXXFIMHXh/pA57cRRhWtxg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TEicpttOWjImAeS7ZTbdQej/SC36qbVwCK6ySvDKLMDD8SDPFxPycUJOVAbtdFkkk9cDTqo0TN2saflPpnelRQ487Jr2k9XoQx+2HqgfwaDJ2OIprtKe2RBvoIZeVjQgBCh/QM6ajhHxGWbHVw/jGue0Nln+oR7rnepD7NfcqcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FmZYKIhx; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNFvGoP5pmEU/Nm683u6x119jDBOpchkBrXuchcPmMnreLMmaL7boC4A0JaSaAICOFx/Uc3ayyuJIyM30htgdFBWJ43bpTjDXlZ/FT4cJUBu0E3QGKp5Ft8v8h1cALpTGkW52Ck2gEd1DN39ppBCtC+KY6rCO9zBLHLzie+Q7zWnFnC1fugGjqLeqZBVKjTAyYZSByqVsTMPn3DfTLeUQZGtP66cth2U+WCT+68DLiE8wNEga3fGGHYT4FAdVg/jJm4vNKN5w74mQTGwuPCS1zWduz5SzMvgrWEzPk1bu+xZHoK8QJuFvDlgQcGe9+W3lDby6LgGOzsv2kAbSWmdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy+/y3yYzxYgELArlw1VUuM8s+oFg07QxUIpqGCnLVg=;
 b=fWL2M8F9rpopRKfDnp4+mspCjeL7o2b1f8/ml+PgkFN6cJjROjXOyHQXdHzWWM4s2/g2QO+L3u97RUtpQKSehXq9CjKq0nRL2PdVWgpIzpxt9XbYuoSiWKzeyx1TlJij3NlFq7xGfelzu+Lp7EGPuuiC/h6rc/YjCdujOQ2pajR1C/ViO/OrK2EDSZxWQ786v1NVYZT2mI+YrhBS5sRg2luhc2EpnO+iBUcBXLYg5wkLpv0eYfbZ2KZRxj0rJXOku1dAhNIqS8VLzMg5FOzHY1Igbs9fxGS4K1BCVJB9H/M9jlrCv3UbzMLbXOrRprZpUWmoF8cxQhxDnGsyAoQskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy+/y3yYzxYgELArlw1VUuM8s+oFg07QxUIpqGCnLVg=;
 b=FmZYKIhxEI26aB+gArU/+fSf9GfnQAwI4igmuQcGUr5h9ORXKHF4xbIzQKijoBFmei1DLUNAyMeJWkX8U6iA2UL4dcooVeh05BNUDDDSchX4ee5gDveN4tWPtNMZPx9wbLdrFfsknuUpKdv2S5V+fCJKKKdZp3mPpqlTjAnGgumwHt395fgKikwcbf2oAesGgnh+UjtCwXjfc+IoaXKDGqyPdMqNNHQqt557J14xs27MWvZgPi34LbLO8rQoabHlO1ZHtlIKsd4bCIWAw5BuJjsikeULacCojkBTYh8h9vKkNts28M9fLqCzaLLeuW6BwiiT+maqby0ubjJmn8tdRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sun, 9 Feb
 2025 19:38:09 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8422.011; Sun, 9 Feb 2025
 19:38:07 +0000
Message-ID: <fe814549-3bd4-4ef6-8e7d-9d21626766e1@nvidia.com>
Date: Sun, 9 Feb 2025 21:37:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ovs-dev] [PATCH net-next] net: Add options as a flexible array
 to struct ip_tunnel_info
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: dev@openvswitch.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Kees Cook <kees@kernel.org>, David Ahern <dsahern@kernel.org>,
 Yotam Gigi <yotam.gi@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Cong Wang <xiyou.wangcong@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>
References: <20250209101853.15828-1-gal@nvidia.com>
 <2ef88acc-d4d7-4309-8c14-73ac107d1d07@ovn.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <2ef88acc-d4d7-4309-8c14-73ac107d1d07@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf61e9e-7453-466b-807e-08dd49414756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3IyY0JxNTdBYUFTM1lhNVJIUDZ6WnF0bSs2QnQ0dUlYTlZwSzFhNUw5emkz?=
 =?utf-8?B?MjRwMWIzSmtFSERnaW1ESGJPN0JrZU1SNnBvNWNxYVNldzV2eno3RlU4RnVT?=
 =?utf-8?B?N0hzZVFyMmdMeWxHSWhhejdKUXNWbFlXOVlsc29tZ282WmpkVzlzM0E5WUF4?=
 =?utf-8?B?UWJleS9CVEErRUZ6a0NXU25DVFhPTkFid0xuUEJKWi9uQy9LY1ZjQWhqaXV3?=
 =?utf-8?B?cFM1V2hXSDZyWGVqSkx2bFdQaVl1K3JXdGlBd3dLTXNkZFVFaWhmTUNOd2p1?=
 =?utf-8?B?V0VtaCtSOFB4OFp5Z0RjeUIxeUtiT2R2cFI2MjFYSWVOTkRUeGQwYmVMcG53?=
 =?utf-8?B?M2YwR1NKTGVneGpzbVdLZEhIZmY3MHliL0d0NmQ3Slk3V1JhTTQ2YVQvd2pa?=
 =?utf-8?B?UzBjdGp4Mzd3K3hFZzFIVVZ3ekt2dHJFMHZaNlJMY0JHdEpDT1dERkdBUWRY?=
 =?utf-8?B?a2I5dUNrMU1nY2pmNHVIWjVCakxWcDY1TjVVb1lpNzhpejVCWG40WlN0MlMy?=
 =?utf-8?B?ZnFjRkdyMU1HNVRockRnUHEzQXdDZU5xYWhoUG1WdG1xWGFWNlA4R0Zxb1Rp?=
 =?utf-8?B?RUtFcFp2MGRZcnRLdDFaODJheWZFOU1pbVBWTHllRGtPUHRtenNSR1ViR2Ro?=
 =?utf-8?B?dGlWVS9XR0ljZzMrNkFxeWhmbkkySElDenZ4eHZlK1hyL250cHhwQXJpOUQv?=
 =?utf-8?B?RUY3YWtRUTc5eS9ISlI0amtDRG1SRXFVSjE2TVRBQnB1aEhOVUJSdEYxclVM?=
 =?utf-8?B?OTd3Rm1nVGtmZFVHZnAzQTBaU3BHN1Yxb0xSNGY3NGtYTlJBRDNwQjNZYVN4?=
 =?utf-8?B?K3c0K2MveEh6MGZXaEFuTWZvUkorWlNnWW1uQXFnQ0pQRk9hQ2NkVHZpU0ha?=
 =?utf-8?B?K0pXSU1jUjFPb2E5cmdBQ2k0MjhldDZDUndqMXMzZ2I1RDVwWDVXWE93OGJC?=
 =?utf-8?B?Ukw5VGhvYW9uU3d1clRmZ1cvc1RPWFhRZ1gvU0lQUUpyanpodXdYbTZwODAy?=
 =?utf-8?B?UjhoQTQyMTREZTN4cmxQb0Vwa2FQRDJSS1Z6MDk4TGFNQ2xwbHd5UWpVV2JM?=
 =?utf-8?B?RVZhZ2YrQkQ2WkdpdmhJck1rNFhkSFV4NXAwVEgvWEVTZ1g4OGZTd1MwTUE2?=
 =?utf-8?B?bHdjUlkrdGJVT1htWExJQ1RqQXV0ZFFKU2NIV1hQdlZ2clZqd3VIYUVGVGJ2?=
 =?utf-8?B?ZVhtSEsrbThjMGF4WngyVThocmw2QXVQRnhKWDcxUlRzanYxUEQ5bFl6RHJa?=
 =?utf-8?B?SzJ3enl1MzBocWhSVDJ1WnY1WUVmc1dOdkJncDh1WFpZS2hXK0cyb1Fsa1BO?=
 =?utf-8?B?SGhURTdUVTBjK3pjV3ZKMWpWNzUrVEtTRWJpN1VSUXN2MldWamNGQk10MHhr?=
 =?utf-8?B?TEdaSDlYQjQvRW9seDdQWjhXVG9Sc0R2VG9zRWFpaEl2dmU5TEJvZzMxZEJK?=
 =?utf-8?B?U21ib01QcTdWN0ZoMXZySVFKam5PS1JSRmtQMERHWWJkWm5hVEpuUXJEQUdK?=
 =?utf-8?B?ZlFoQ1UxZWdVaGxVbElJa3VWTGoxSzFUQllxOUp0aUwreEdsRkNKZ3IyNDNV?=
 =?utf-8?B?cU1GVTM0N0hyY2d6Wmppa2NXR0dRSEkwMTNJTXVxZ1lWQ2ZoM3E5WnluNmFP?=
 =?utf-8?B?NE9FRkEwU0VLNkpOdXJzZnJuRXJRMWtMdk9Xa1kvaGd6NGp2ZDVZbnRNWkNN?=
 =?utf-8?B?N3hZOWpMWS9tQ2I1YmxwMVVHSXJkZmFqYzd0Z3UxVGpUVFE5NUxlZ2FxZFNG?=
 =?utf-8?B?eENrc1QzZGVDYWlKSDB3cVZYa0Z2QTVxZG53b1FtUW51Tm9PcDJnYlBwdnVl?=
 =?utf-8?B?UzlxOGx5dXFZbFJCbG51WkxabS9xTUdZYzBCamJmdHE4UGpBTjZTWEdYdVNY?=
 =?utf-8?Q?acF25oUDcFtE5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHlaVmVKWlVlOCtDYUVPTWY1bUwvOFZmSWp0MUd0aExTOUlQdHgvbVdZK1ZP?=
 =?utf-8?B?RHZNQW9WN1ZXN1E3YlZWcDR4d3FIbmpqU2x0YTdYSHdtQ2d4eXdNbEdDclBM?=
 =?utf-8?B?OGY5ZW9YdGR2d0JvRDZMT0NsWE1IcFF2bEN2N3Rmb0pLWHdjSXdsb3RtcW9s?=
 =?utf-8?B?cFoyendpbnN6WGlMVE9PQXNPRGd4bDgxUnpiS3FHdGh3aUVycjQrWXV4MTQz?=
 =?utf-8?B?VVRsaUtEOElQV3RtY0tWMXFxdW1YaUpDYisrK0RKZE5oV1IrR2ljZG9VTzl0?=
 =?utf-8?B?TG10dUh1UHh5RmJRVEltYnZGZDRrVWhwT1ZzUFV0ZFRGdjR6K0FwR3ZtMHVm?=
 =?utf-8?B?Rm5IZUwrZXU1a0Q2bGRiK3hyaS9WZXhRQXZYaFFzZ1kyazlLT1loMDhmM3Vm?=
 =?utf-8?B?SVdZdWkwMlhRQ21zeEppMnZURUY2MFdvK0MvT0VnMmptUC96dGE3dmJwNE95?=
 =?utf-8?B?V2RpRUtmZEhBdFZHdjJyNi8vU1FMQXhSeUxob3lYcE8vR2lkTTY2STdScWN0?=
 =?utf-8?B?RmFUOHRUMFZVTTlqdm1FMnVhOElTUnI4Sk1VVk1LR245SDRnTDFrVXYyYllz?=
 =?utf-8?B?ckpkSE5GYnh0L2JwVjZlcWNZL3BGMG9lOXVhck5abVpsa29ERXNUaFdybWNs?=
 =?utf-8?B?Qk1zNEdSbzMxcWhZS09HTTRUTW9Jc1FPeUdVZG5pVVUrSzdsRG10OFZISEJP?=
 =?utf-8?B?cnhNeVkwT0ZjTFJ0a2h4YkFLQ2FaUU05UktiRmMvUXp4Qy8za0xKSHliaVhi?=
 =?utf-8?B?cEMxM1ZsU3ppMTVoVkZhUitYR05VWlpqU0JkeklrSXZRWGxIcVpzR1drNjVY?=
 =?utf-8?B?Y3dXNmRSUkV4Rm11L055N3pnOC9nRVBrMEk2bm0za1hxVi8rMERzQXNOTXAx?=
 =?utf-8?B?cFNtakJxRnhIbGpZVFdzekRtWlYvc2VVNDY1eVF6Q3RJVURoTVA0T1gwRlV0?=
 =?utf-8?B?QWRxeVpNTGQ1NUtNUlNqVi9FQy8wWmh5UXd5Q2p3VkQvVzQ3clQxUmxVaVNL?=
 =?utf-8?B?V3NqeFZFcjRPd0NoVk44ekIwQ1lOaVVQTVhNeE5jeWdBOTM2WE1iMFQxd0dN?=
 =?utf-8?B?TTFwbi9ML1AxVTh1d3N1RWpzZFZmY3R0TCs5S1pNTThQQ2VjK0JqandDUEdv?=
 =?utf-8?B?U3BsVHRJL1BHOTJZMlJicEpJYUV5cWlWN05seCtLM1VqclZnK3lqQ2N2Y2lC?=
 =?utf-8?B?Z1ZpVkhGM0hpTFhPSlpvY1FuMWtDR3pkZXZlNWxvb2UyK1hGOFBleEVrYmxh?=
 =?utf-8?B?a0w0Z2JWenlZL3VzNnRmY0djNkJlbE04Nlc2QUxaRzRUUFJpc0xHMWw3Q3Nk?=
 =?utf-8?B?UlZ3T2NuYk14bnArZWUxVzNXOVIzWVBNV0FvNlhXaW9TY0ZTZDYwWGw2SGw0?=
 =?utf-8?B?WEhGaDdPR1c4bmhRYk9OSmJjWTA4VXJHN3VYblYwQldtZEkyZklqb2k4L0JU?=
 =?utf-8?B?aEt2QXN6OW1nNnRkcXJqTFA1T2NKbU5JOE85ZjFrNGEyNnhqK0IxTFBZdWk1?=
 =?utf-8?B?SVlRaXJIY2hhOUVxV2dtRDk2WXlFeTJESFQwbkZJUzFjVWdUaFpDQUhyRzgz?=
 =?utf-8?B?ckx0c3d3TnRucjVvQUpMa3ZaZnVkZFVEZVVBU0ZtZjR2QUtveCt5d0FDZlUy?=
 =?utf-8?B?akxhQ2RIYUdHdjl0UjdwQkQvOENhZnJNVGRiODJNQk5nbVlwWmpyczAySjlu?=
 =?utf-8?B?d2FhaGJZMzE4NjMzYy9lWU9BQ054TlJPVjZMR3VEWmJxSTZnREhyakNlMTlX?=
 =?utf-8?B?VXE4WmNFNGdBR2tyck10KzU4STBYd1RrSFRrTkkveFkxZERrN3hZS1k1ZjJl?=
 =?utf-8?B?c0hKUFNLL1NraDdZbXdQUzVGbmx4MkhDczh2V056bWNiVTMvZ3ZDMEhrREFC?=
 =?utf-8?B?bUI2OUZQNHVMMFN3ZlBmVndNazk2UG5Wc2duc1lIaUxNbzFmajltVHFSWXpz?=
 =?utf-8?B?UDRPRGpTT1BmdUhxbTZxNGpPQS9sQjJaTnhoa1Njejh6L1NzdnFsanp0Z0ln?=
 =?utf-8?B?SWRwVXhVNTlLSU8wcUhTV3BLZzN5KzNHUUhjOUliSUhkSnVVMzZucFA0VC9x?=
 =?utf-8?B?WEpMSEVkODFVbkhINTlCMk5nOSsyTU5TL200T0wvcCtPb2RBYUNIWlNaSDNx?=
 =?utf-8?Q?7Xhy07rmKF9Gjji+4/OBYR7px?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf61e9e-7453-466b-807e-08dd49414756
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 19:38:07.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDwt0v++ePA8XjiCpfz6QjyVzhJsxTm+GhYk9oGp+5kPe92I4VORAoxaEVhzFr9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298

Hi Ilya, thanks for the review.

On 09/02/2025 18:21, Ilya Maximets wrote:
> On 2/9/25 11:18, Gal Pressman via dev wrote:
>> Remove the hidden assumption that options are allocated at the end of
>> the struct, and teach the compiler about them using a flexible array.
>>
>> With this, we can revert the unsafe_memcpy() call we have in
>> tun_dst_unclone() [1], and resolve the false field-spanning write
>> warning caused by the memcpy() in ip_tunnel_info_opts_set().
>>
>> Note that this patch changes the layout of struct ip_tunnel_info since
>> there is padding at the end of the struct.
>> Before this, options would be written at 'info + 1' which is after the
>> padding.
>> After this patch, options are written right after 'mode' field (into the
>> padding).
> 
> This doesn't sound like a safe thing to do.  'info + 1' ensures that the
> options are aligned the same way as the struct ip_tunnel_info itself.

What is special about the alignment of struct ip_tunnel_info? What are
you assuming it to be, and how is it related to whatever alignment the
options need?

> In many places in the code, the options are cast into a specific tunnel
> options type that may require sufficient alignment.  And the alignment can
> no longer be guaranteed once the options are put directly after the 'mode'.

What guaranteed it was aligned before? A hidden assumption that a u64 is
hidden somewhere in ip_tunnel_info?

> May cause crashes on some architectures as well as performance impact on
> others.
> 
> Should the alignment attribute be also added to the field?

Align to what?
To the first field of every potential options type? To eight bytes?

