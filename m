Return-Path: <netdev+bounces-285256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGbIDJNy/GkEQQAAu9opvQ
	(envelope-from <netdev+bounces-285256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:08:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E64E73B5
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD5F3096209
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A3C2F4A18;
	Thu,  7 May 2026 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h8vb+1l1"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EE30F535
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151624; cv=fail; b=diOIHjWKzrvuURmBV6x1fzwsSfBsUyJFAH5glh+jDBURrgy3U97X3qEYlAf0hAETRrjdBy+oxjIMkBCvObel5UJICsG9UqzyttMvTg3wGH92ZZBdfOQJXHs2rP23S5w5NgYdzu48g1k9XLxBQ1RItkCHeQtTOBKocyJicH08+no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151624; c=relaxed/simple;
	bh=vJjXRyGAVB2CZT9VMAZzA7erFfk7C0+4xR4zKGdDUPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cEwrFAaOJs14fQlQNnGNM8XguGQA6L3cFZTE4T/4FpAG6djofdn905kgh39OT5lkq2CNQAXIk+b5Lgj/EDzB9LNcBf4A/uz9rdxX7B1V0IOqJg90hHQfu08VuFUPxnLwf1KtFsv7t//m05/0g9hDsscEltqwDJ6LwyQ3RGFHKDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h8vb+1l1; arc=fail smtp.client-ip=40.93.196.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Da9cF6kKRSuLNeUlDixshFGPZ++dnWniyfyQmMYhS5SF56J74PtbSpnM0u6Xb1KKoT+492daBftqi5uUVbY6g+itxF4oZ9FswMAT6P6klT+J+H6B3XzbKxzfFQnv1woIyHpv2MQff2TNFmh+0Wg7Fz/pk5VSetygQjD+rdQ9qhBLyTNkzLQk3J8EisGs6SzqwPkHZuD3akdNlFH/Hr8kxlNq2psGmMNvnAvvNxkaHthqzzji5Ul1ScG4HOskbCAZAmQ7pDDfoHbqKWsaVoPhgTrZMf24ifJqLQIyinSPtzbnS83QCB+1R1bTasnM1L4T8Z402sdH2SQt4iA/RAlMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBI+t+NSbOiFqI5odmY6acHDilAI9ienwjLqY5SmGsA=;
 b=wfGFK9gHEJTvnmp6GFHtvjBFPl9/X+4Fgg6Ji4OStWBKHdSWWeS38K/i5qyLfbLq5cGAbpCSOgPWG83rAOj81C0e2k/kTEdqkDVQJYmDMT7tV+b9BK+inHuuXSx18N/8YjuMoA3nylJKXxSKTNS0ijIsPkFhKxpOer99Q5haVwgXf2o9FqP0pAtdPytI6F4/jL8+Qo5RbLJyrFwmHc21M8xCyKott4+4Ns3T2EsRbuJ/RwDt72hWZ4t3B7wxZZz7shEusb9YHvESKa+DmQjaWeXxhMc2MVVm2XkhPy0T9LChxhEkgp4cr7LrwmsSKoDAQ9ASY0IZOcExIPQrx93StA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBI+t+NSbOiFqI5odmY6acHDilAI9ienwjLqY5SmGsA=;
 b=h8vb+1l1tehhxT8E+Hbh6XsyRnH7jA4pTVeZ2/z7zmk006hfmVbh+/5W2ZVEwDyOCoxKwITWcky73Asb1uVPoTFLx1kfw3oyP1X243WSAhevfZ2k35EtI5K8fLMVvsQbalGLd7ICvH+0HgiGguhc1gZoQRtIGxhwAxUaIza0YEUzWiO/LC6umWoCRNlN7O7he+oRRxpF/j5jehdGxVEaeLc3MSVEQqcbPHwKj/p0u6edHm6Snqs/BAp/4qNodyfKYmCgB1XBE2zvR+MzygeR5qkTO9H5iNb+Ii3aJRavzOkyNEHU53wrZe1xU4E/j6eahradzidedOnxmQSc5RaAgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Thu, 7 May
 2026 11:00:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 11:00:16 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v3 2/4] net: Do not turn on carrier when protodown is on
Date: Thu,  7 May 2026 13:59:04 +0300
Message-ID: <20260507105906.891817-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507105906.891817-1-idosch@nvidia.com>
References: <20260507105906.891817-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 7922ebd8-2b17-41ce-40a8-08deac27d227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W9UOryWOx4eEz39cb4Q+C8T/zQA2vASDM9b1lCBsGmMJCvda5WoUGQAxoM8wukEcrapwya8HioMrjZ4aFhcFPj22jooCWwbbcgFKF47Pm57BhYXzCiyLIG5vG0QLfbISzgEUkIuLnabv4ieaYcIW/fg+PKsO6jqufRFKsta/cDFa2jrx49zo2hmlXHayeRqHPvjy1GMEKwRRmeQfN8EZEcSDWZOs9Eb1niNyM95XmMICkd1JM7PyCpw0docteJPbA6AaGNk/2pxISH3V8k3sQoxLX1vveWcmkGByA052CHhAc1RJHA/pnYJuHA5hHJ+AAFawTXDvDigwJZ5V4tA0KXJTyze5bQC7eimslhD4C7r5TOpUMmyP43iCiXbcB+2DYMpskJARtw4oHlcxi1KzxlY5lSFv+BaC7n42Zbw8IVXbHj4WaAFPyY7mgU6svYV2GTSANNAMyiuqKtmgFIO2gtJnY/c9r8XEurCvq1UlYJP//a7+ee9kr7RM5AvLfm934tNdLmPqcwac1Jv7nqjd7lAIilpbxBqPdGHTVCMHhmXgsxdDQVB5Tdaeb/xPyP2IQ3qbNEdH4ZBq9pePBV1SJ25zCbJv4NCkszj5Eb2vMoxnJOGaU6x73R0Y9oEdh3Zy5VSCFpbk/neXh8hbajtmYgjNun4s85i4H2EW7o7/JalkbAGtgaEiS54Ax3CekFtL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(3023799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?POOAxC85onNmF+hc3EfVPRV32PuyCnZ/GsIxYNh9lfdrvvzn6Wr0i6m7Yogv?=
 =?us-ascii?Q?I88unNRdBoXinnEkEo9nfmjlpF5tEzdmppQBoJSAmjh9pEuxj8CnGXsdJGqX?=
 =?us-ascii?Q?GrzJae0zE6JHb33gZO6JJ/q9D544HRYU1eBYuW/uE+Od+YXqSVlVZGnpanKO?=
 =?us-ascii?Q?nCj88vE5qCu3qjtPD7f5QrUC44/fy8YVcRJyN7QMpixmRbU1dFphDRlQRtvg?=
 =?us-ascii?Q?6aqb7ZxmpO3fjIfu6btmDOFImpMJNSbU0JEEkQK5d9TukKbp4futz5rEBbnH?=
 =?us-ascii?Q?0Of3vdlp9qwVFcdP4l8FS3gBwB37j//dXNQCxWgtxESKiPi9KhPSFKb/HdXV?=
 =?us-ascii?Q?5dHEBuNXTlYUbBbK4A2MCTZHxzWXHihqdI7zAO1Uh9YkajDulfHYeJXd3gCK?=
 =?us-ascii?Q?/YKsbH4k7EsQnaPUIyegft/etmjUSF0kllGDKIlgFMYb3NlNzzU7cJU1X2Fy?=
 =?us-ascii?Q?acygEi86N7k5miu7jb9vFhtshRowmBd7jJYuZ3EeTbFwUhr2yOxAVSrVVIbM?=
 =?us-ascii?Q?p6wJtWCFz4zbMfm0rsKHL4vzdw3zgiRgc5yoiCMB1KTb7p7YF27pjZu+zOZH?=
 =?us-ascii?Q?xP4nbfwEcXnnOJaLh211V1LTksge7Xs53z6Yw5DvMadxAR7tuUhpQI+vEt98?=
 =?us-ascii?Q?vtCOe8dj0o/YLnGe6h6TjU2hA2LnMhe1b6ia5Wiw2Ln8SOGHV7qiCUox7zDr?=
 =?us-ascii?Q?i7+Qeyzcd06MT4oXeBb6nhcypkvgRZFc5fALFITeLoNWeJ9yVs6N/54ldNJe?=
 =?us-ascii?Q?pKVvRUsM3zo2P4HH8c/F0TYf3rTEd7XxQKt5J5UZ/OrjPRAu+oZBwW0xQLFR?=
 =?us-ascii?Q?ZzGITxlTxcXhGYo1VtVsyT4+wO5eFUufbLoHiZZ3rvV7UPBHWwwKLeurBB2v?=
 =?us-ascii?Q?Hc/SI/avm9Hjl9E9PElAWk2Q+1URT5eP4nRBnMTLtmwe/zi3aBOGv6KixHRc?=
 =?us-ascii?Q?V+9alkCA9PJIHBCGdTINbcVv6qLkqQCdjdo5xF1X23xbX7C6ZVcKxVp9NPn9?=
 =?us-ascii?Q?g70TVXUc99tykzlgZ+cRZRmzoagkByi2qRYLhhbkce/z9w/GzWvhxtzm7OoK?=
 =?us-ascii?Q?gcjWRjVaoFjKclsMy5vjvSuWFbMdI1UQBIDWjN7HWP/su4TjdtfJeaVdHRfp?=
 =?us-ascii?Q?aDhzjB3pBSKKEt8b+7TdU9M5ziMjCpEV0CANOs7IcUQUwfT6jMy3q3wfa9my?=
 =?us-ascii?Q?fnZ5Wf8rHkougAQxKVyg/F5FBjlPgObItJQ8J93QV4JcsOhoGLzNndc5bxa2?=
 =?us-ascii?Q?omSooo/VRf+Mpi7m10M1JVCqE04Kfkr35pIgobgoEp5Y5RKQs1x335PywPOr?=
 =?us-ascii?Q?zduXFJfvHw4U0T9UceJtXadVEz8O86L9yXhl9PUm0ohqVHKbTwraYa8hh9Hf?=
 =?us-ascii?Q?jEneC8avwg3wOTxFWcbtVySBaR1LCQY5ZHV/bobxD4KSFRrnLYKOmz/8LJWa?=
 =?us-ascii?Q?/wLj63okDTjaEsuA6v21EV8S9i2FqU7RpxfyLEP9wz/OCBYI5O6HcgUwv7SS?=
 =?us-ascii?Q?VnZnpVPeiRAfPd5bAJ6jYPm57ItDEDQ1Vu0YBh15OgViIHnrP2qHfTS5ckRn?=
 =?us-ascii?Q?UPSpSWzo6glrHGx6jcMAEgVeDzjuOKJU7u7ZOPSQWjUROri2i9u5Dvgsu0cY?=
 =?us-ascii?Q?S/c90glj9H0jHXkOFdvwwEAn+kpgr5OCOIK9nJo6pT1KDuuv3vzehgb/OCUm?=
 =?us-ascii?Q?CpQJsdfaTp6FZ4hUjGzBsCfLWJLFNxHXdWLcsZB6oaojni17?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7922ebd8-2b17-41ce-40a8-08deac27d227
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:00:16.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 800tSUdN/GWEMhKWM0eH+W/BJ5FvMS31OEE56p1wRlNcPpUKt+udL3jaPrIMFLJMA4lRYUPRVnKjacHvQbWdzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
X-Rspamd-Queue-Id: 813E64E73B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285256-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dummy1:email,Nvidia.com:dkim]
X-Rspamd-Action: no action

The protodown functionality allows user space to turn off the carrier of
a net device:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>

Different applications can set different protodown reasons, which
prevents an application from turning on the carrier of a net device as
long as others want it down:

 # ip link set dev macvlan1 protodown_reason 1 on
 # ip link set dev macvlan1 protodown_reason 2 on
 # ip link set dev macvlan1 protodown off
 Error: Cannot clear protodown, active reasons.
 # ip link set dev macvlan1 protodown_reason 2 off
 # ip link set dev macvlan1 protodown off
 Error: Cannot clear protodown, active reasons.
 # ip link set dev macvlan1 protodown_reason 1 off
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Unfortunately, this mechanism is not very useful when the carrier of a
net device can be toggled by toggling the carrier of its lower device:

 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev dummy1 carrier off
 # ip link set dev dummy1 carrier on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Obviously, this is not the intended behavior and it is unlikely to be
relied on by anyone. In fact, it is a problem for applications like FRR
that use protodown with macvlan on top of a bridge as part of Virtual
Router Redundancy Protocol (VRRP).

Solve this by preventing a net device configured with protodown on from
gaining carrier by making netif_carrier_on() a NOP when protodown is
turned on.

Output with the patch:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev dummy1 carrier off
 # ip link set dev dummy1 carrier on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/sched/sch_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index a93321db8fd7..05c250c483f0 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -609,6 +609,9 @@ static void netdev_watchdog_down(struct net_device *dev)
  */
 void netif_carrier_on(struct net_device *dev)
 {
+	if (READ_ONCE(dev->proto_down))
+		return;
+
 	if (test_and_clear_bit(__LINK_STATE_NOCARRIER, &dev->state)) {
 		if (dev->reg_state == NETREG_UNINITIALIZED)
 			return;
-- 
2.54.0


