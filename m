Return-Path: <netdev+bounces-213626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BBDB25ED6
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAD58830B5
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184D2E2DD8;
	Thu, 14 Aug 2025 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LuuMbnN/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29B21255E
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160156; cv=fail; b=fZUYx6GfMy9JKPZTK852HKmsS9FnqfVkcazia3J1pa2hh82XA1mleLr7nYomHsIJrhSsNHQJ5OwhU4OS+f3aexJUBsrHTlcdNWSYn21iWevIiFrnW1vmeQR+V7/4i7dnHZsXSXBBVmRpV8YR+AToccZyHOMz86/M3FXPSQqijMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160156; c=relaxed/simple;
	bh=jVXhS/zl72sQ7H4UIxTXbfXcqS0jVfztusxUXumvJYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dDxqhFUmPqUbrNOuLQfhsOkVDZTLOPpUQuq9eRiVQ5LU5x4kkYJx+HTs9eGUcYQ5taZdRPN/TJ/bzhpDEceZNg710GEQ8KR6pmwBQgJpw1eoI7Zk911xC3pJvb3zxg7HRX9uJab8nhHi6lyaCdwLJHWJUy3Z00Gzy7ttiWVxHJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LuuMbnN/; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlsG9dKJdIUHxiU76ZNEhPyvTfwuG3UPijKvt9ipGgZzjx8qkTo5HrRbUO3wMT8ddueM6QI4ej+F64vVp8fkc+kxowo9lGuDXCAgBFmdxxOFivjo8C/fO9hQm6akgA0INApVo/wg3fRl+tiBrOxX4Rw27dQ2qJS0T0a90Oh39pFNCGPARt1ynsm1tkBk+RU7xDBV26ME07fmG0DGRMJGpf4lMLbMrbLvD63ZbNLsoWWr52eXSkGckhXn3rC3sjzuTvZbQo0/r13UR8LwQMYtqHus7um+qVCI+VIsV3kn5ZYlmlT4jkCsRjJPQJ92EILqLzl0+5bbFsQIq5PHvnW59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx0h+d6xvoiq7p3f9gfgpx14xAWaJrrgbCbAuX2vyng=;
 b=Yk6xH0E7+Z7WhQ/DA3Ox37oGfHUe0W0rTrZ5jwZFS87OZJm05JCEceyyp7qRcl+339B6PCEnsDU/0m/GkdPN0JCATouxChguhkYvjTk+HvWSz2wsdpNqdPFd48JcgNpcQ4O2xLxZ00P5V3hiAVXKvhOPNlir64dMXtJH66GVCFZlTDcwdoh0ZIBllISshMJE7lY3EzPsQGnL2iLoZ9SfAZrGidGBaGW81bI1EIKfEzgwBExXVU0UShLBFe9QCr0fiHjh/XUWIG93DXUw2vJNU1uhysQUTlVeTpLj3Nre7ht1I/7b88oOFVid3oSjRb+H+uCm8MG3sCMOo/16vGmk4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx0h+d6xvoiq7p3f9gfgpx14xAWaJrrgbCbAuX2vyng=;
 b=LuuMbnN//Sylh04SKPxpbslcnMiyWKqsIpAxYS3cMNc9cnRECXpXaDpjGueO3ZxYgUqPtR5RGp/l/3YPyCtEKfwS11vHkbDUsK20IfS9u88xYc98whMCrNdtP98wYuf4J2O8bzDVxkEyRFtVH/+j4J9QCPupUmrd0JlSlCtHChzlPMFxTreRsgzO7sNMGDNYrQOMv2Tty/3LjgVFky0c01e8GKiMD/QJnn1Z/j09w92phQJD9bTVaDaIPEvhbpEWPbJ1UAI/j77q2ahpW6GC1ngKUL0bxa8NEvt+oKFfmrGq5xxpTz0/dKHbyPfKF8X3MOv6OoTE7D2S+4B8weN45Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 08:29:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 08:29:09 +0000
Date: Thu, 14 Aug 2025 11:28:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	razor@blackwall.org, petrm@nvidia.com, horms@kernel.org
Subject: Re: [PATCH net-next 1/2] bridge: Redirect to backup port when port
 is administratively down
Message-ID: <aJ2eSgyoj4JuxXrG@shredder>
References: <20250812080213.325298-1-idosch@nvidia.com>
 <20250812080213.325298-2-idosch@nvidia.com>
 <20250813172017.767ad396@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813172017.767ad396@kernel.org>
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ca3ffc-aaa5-40dd-c1a0-08dddb0ca3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMe67idxK3qDUQdV6+aQu/Fr1LG6eYalf+JeVaeN1N7r1Gxo0DZ1rrowMeZF?=
 =?us-ascii?Q?qkDAMN3rIJqkYNNVS2tn/kWxdHtFG98HJVr4n3A/nFzXHK++ovzIhbF/zvGF?=
 =?us-ascii?Q?4yPbzEOfxQEWxUAlLwGfRXQhS+yZ3Fp8TOInaacRPEN4Z0lGjSXVFXRASQKJ?=
 =?us-ascii?Q?s5i1aJLSSDUv0FFOh2WJS0sMqYRY0q0i+sAg7fkhZ4AMpFyHP7fZWtIES2Ae?=
 =?us-ascii?Q?u8f5/2uQkuR2CSNL18ad3QvA72o9MSob32wDgbvOueqPUbEjKEW8dVBrYXfr?=
 =?us-ascii?Q?vtMc5HIvUYsiSDI4MybVAtSNT94esBDpwajPVEZOpf+u5C4/ev+LrYDJSeBK?=
 =?us-ascii?Q?gjZ+hjP4K6t+f3PX9Wwur8uOK6oP+ElfoCLsqczuaSuG9uYFrOY14oMCXDLn?=
 =?us-ascii?Q?lme1WyicV7OgJxZ6lz2Q5gvwuN4gUv66LvOHi59UEQL4Oh3aFPMSbdO68sgY?=
 =?us-ascii?Q?8ver8U5TgK/K5OyfB8MLPOdEbLluXee0urSSsD+M7S9Hi6AhQWXlObiuZ0G7?=
 =?us-ascii?Q?+dImHNQiImkHd4xwqdj68Pf0aaa/7b9aodPa+EtjugZUw8mTWbpFK+wfdS9V?=
 =?us-ascii?Q?uxdXD71loEI2+gNWdf4mPhzMhkz08ToosFJxH2+gIupVXtsesDZ7Ffu9nrYn?=
 =?us-ascii?Q?ESUsqBJ7e2nLUrKTMhN8z05Zjan8zKYQjxQRhYQ42j7t0u9Jy8+6P/5GAt0I?=
 =?us-ascii?Q?XwxIAohA91IM8obbmB9n4jogl+phLwTxvj5XveR9+vqxToxA2mS9TqZm2DF+?=
 =?us-ascii?Q?pU+DU3Mvu2pjIUrG18OHeGrvd9C1MkF45Lg8cP74/z0CO7myOWjPM3cEKIXk?=
 =?us-ascii?Q?/+eDEU2WUZr6DWXkm0W78MDJOkdmNYBvbmnSWeiTgbXQvbL35qexlYq2loKe?=
 =?us-ascii?Q?sD9fJg3MDdG8Qdb1oyoo+YLJ2zK6OKUoR8mity+K5ClILBxu8PSyzncKCJiC?=
 =?us-ascii?Q?UMlKfXqxNLVwNBHhfT986B6WDFMTVH7ciwXlj8uC/wO7TaH6HKUGTe2eGgfv?=
 =?us-ascii?Q?6DCv6eh+PdcSG4qEKQoHQoiuMbHhtit04+ECm97gvsqkrJJoFnafXaItkgTK?=
 =?us-ascii?Q?SE7dOVn/k1J1Gydh432k11SMt/gDihic2SDEf2OE2YN4yWd0QA7R0ipwrlNi?=
 =?us-ascii?Q?9pAoPxN49VvIgA64bfPe1z5s+cbb2M1Ul4+IFrLPRKkRtVClybefAqUf928C?=
 =?us-ascii?Q?9NGUaGcvpBIJWOlc+yQ5pyRYruSxCuDtNXyb+DhjLKHdHOHy4PhHFbnq/V3x?=
 =?us-ascii?Q?iPJm2RKmgJIomjcAya2ZwQVigVcgjWSjGNT0BRVUAGRkjB/JP0vyqsgL+hnn?=
 =?us-ascii?Q?eMg0z0O4jMNvXQIjS1sHdHtJ1bgXGU3BHzhGnZwO41lTL86/cBdXiDYAiswO?=
 =?us-ascii?Q?tpTxt+W63MY4Pqh9EqYVMG0Ytmy8ecfYMVPkzfmfowQ4xpm3cOpPTKjYZDpQ?=
 =?us-ascii?Q?6bMvzFTkIeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fgPaGkqC0XnMTEVj84ArVnceFNHZjwITTujVR67A85oCB8+xgg4yXKoflSWa?=
 =?us-ascii?Q?McIZEe3en6pNgjsjoIq9LwJu9JYC9YNe7Vljrp30mxnBRCsfBi8wchim+fMl?=
 =?us-ascii?Q?d+EsvTCFuI2gcm14YrkAbrVK2qOkGvVXByed2iYR/539/P2fTu2z5uM1N+5u?=
 =?us-ascii?Q?pXxcURktcGrErtCA0nqHBaFpjwW6JKykI9GhTdP4zUpKVrTq/2w8hdVROm72?=
 =?us-ascii?Q?UVGvMr/aIFSaqogDO9YZekNzIr7ohgI+VJyVByDimsveMBx0zOIgRfPbvysk?=
 =?us-ascii?Q?9Ox2tayy+OzWPUfqCBAXqOLD3PUJcNFpbSzIvckGX24oJpQYj7zMhswTN4qh?=
 =?us-ascii?Q?ci4IIBxea5224MzdV1dircfddg2Zf/NF1+H87tE2u0+uPsfjtIJWNUeRN1WZ?=
 =?us-ascii?Q?QA2rmKNgYaQcht/CMpXXnTmFI7E3i5R2XTNzZKzAHK7ZBY/C/hTJ7/VX7rLm?=
 =?us-ascii?Q?TNndrZlbBcfW0VCLgzOUZyakgXUgP98GxTMhWVMFac0/jHTRDiX4sCKIcCYf?=
 =?us-ascii?Q?aWUzVNvwWPepIMnhS9vFubppDNuBO5RCreyQCIqTIVX1P89mw32D0X3nDLwh?=
 =?us-ascii?Q?UKYAM02QF7P4ycMjUp2pcxRExty84W0z0OCha0GYwVRmxp4OlUjEZawxqOt3?=
 =?us-ascii?Q?GCZ6xzv6sjjo8uy9Fk/sUQpS+Yoy/FIlrgoB5tZsl5vjf1F5DQZ6yiwJtDMM?=
 =?us-ascii?Q?nJtKJD79So20EQAfRqjNJ3P/U7LY5PG/0kgfSgzuXqgsEgiD6WMfh/Xo421K?=
 =?us-ascii?Q?NndQ/8jxCBRTdkNZl9fa/Ne9foUTD1HW5NtkItjT53nymmhwx34Cv9SVjHCM?=
 =?us-ascii?Q?MzburRrcuFzV31CD2JFqQOmncWg8cUsvAUHNJaqtWvPOlzOs+jkF9QXvT672?=
 =?us-ascii?Q?ZHdpMBMiNIJ5dCBMn+nwE4LnSQuNld2v4+tXUvl6gbquoOG7/8bD//O4zqdi?=
 =?us-ascii?Q?lcRDFZJeYWKtVmOMXLp+fw4GKCHnSRjwUdOwgfWOQWB/O//gtlQHNBP64elj?=
 =?us-ascii?Q?pHp5/OvlsVh3JnWAGPvMmlPvOBARMXmJkgh4kwXcRdf7hZ92xy9l4K6r4uvJ?=
 =?us-ascii?Q?9A09fUNKWNUAvuxMUYBSW7UiYSku3fhOfRBRV5EzabH23AZHXAFrToKBsZyi?=
 =?us-ascii?Q?BV0RrU6GzuOR9jcU+8LQnh+5ANHwLDhs81LppgcstKr5FNYVtnBJPktoiHx0?=
 =?us-ascii?Q?Oi8CXHXyPKCgacDYV1SKC+zBs3Nly21we0kpSe56ocV9bxkSHVpWraFjkeEX?=
 =?us-ascii?Q?FLnw19iZ+OYHFVQMp460z+mEX39xpCpuIDbUKGd55AI0Dyw/bHiXfYnuwDk7?=
 =?us-ascii?Q?WNhysHc/F7Zlbg4nvISqKG+rMTsSzzeunv+Wgyy3U5IsfXhIL8Sya6GRcfzb?=
 =?us-ascii?Q?6lhzAl+nWvvPsjdxVnUlsFCeBftb1U+o0R76ykd9iYbYaUnob//RGpH1l7V6?=
 =?us-ascii?Q?1OtwtoxHK+QBo9I/us1+DLrLpziuO1dPyMmvwRSVFPTPybgxraRAgPm1ytz7?=
 =?us-ascii?Q?gjJmASCxGN5psKqUZmtqcnRQ7DdrwB+S+McsgydkWWMXvLGYqOvdHy1oTps6?=
 =?us-ascii?Q?B8ahj/bu6QJlLHXL01acQ5nL52nxHp3VXswGX4ML?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ca3ffc-aaa5-40dd-c1a0-08dddb0ca3e1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 08:29:09.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxI+8TKVCls73xDcQ041j/wA1LZ80wlaF9RaHCT8FvE65ENtLP9VAIVvEhY0GCIaAsX2IbibOiQt7srCk80I5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506

On Wed, Aug 13, 2025 at 05:20:17PM -0700, Jakub Kicinski wrote:
> On Tue, 12 Aug 2025 11:02:12 +0300 Ido Schimmel wrote:
> >  	/* redirect to backup link if the destination port is down */
> > -	if (rcu_access_pointer(to->backup_port) && !netif_carrier_ok(to->dev)) {
> > +	if (rcu_access_pointer(to->backup_port) &&
> > +	    (!netif_carrier_ok(to->dev) || !netif_running(to->dev))) {
> 
> Not really blocking this patch, but I always wondered why we allow
> devices with carrier on in admin down state. Is his just something we
> have because updating 200 drivers which don't manage carrier today
> would be a PITA? Or there's a stronger reason to allow this?
> Hopefully I'm not misreading the patch..

Probably the first reason.

The primary bridge port and its backup are usually bonds (the feature is
called "LAG Redirect" in hardware) and the bond driver does not turn off
its carrier upon admin down:

$ ip link show dev bond1
83: bond1: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 9c:05:91:9b:5e:f1 brd ff:ff:ff:ff:ff:ff
$ cat /sys/class/net/bond1/carrier_changes 
2
# ip link set dev bond1 down
$ cat /sys/class/net/bond1/carrier_changes 
2

Same thing happens with the dummy device that is used in the selftest. 

