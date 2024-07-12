Return-Path: <netdev+bounces-111006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6A92F40A
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0818282B68
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200179DE;
	Fri, 12 Jul 2024 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rtEBFyBQ"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020139.outbound.protection.outlook.com [52.101.61.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D408440C;
	Fri, 12 Jul 2024 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751798; cv=fail; b=W+TmWzrAB8rCXQMkFPUBqcfJJ4cpJq+bI1cn6HNC8C61oGyhTqHGUPRL3jt+XhETUlqY2c45+lB64NEWJF6Rv4zdl+iBJb26l+bsLHYx6N6SdB3QFSjJ+R9J+98FEmQLfuXK13I/IU826ESmZCt8Plsxg/nQ0fDdjvLbO620djM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751798; c=relaxed/simple;
	bh=6dfAy3yFmQVkYx9lHmFgatoJ2UXt8GAv7QIqcA9MDys=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nuEUP0Jw19gBnMEzjb9XkSAuqryI59T2nVqEFn822m4RONJ7XXjOzyqsy2GG53SnZw+oehcNgjar6QuEapIq64z7BXe1nkqQX55FVleKFLajkFrxFVfQe3qRhGWT2sg63FAD7vbuBPi67xodOFYt1ziV6MEqdqJIZIix+x4WU8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rtEBFyBQ; arc=fail smtp.client-ip=52.101.61.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5Cg5XFgyP4l43Fon4ka133sOKwtNdBal1asTzykF4kzosxTIUPwX61n2iKpyrC0G5/1TJOrRv49ezFc+4Su5v/Yn5K1aqaYDhUefRTFFixNjnOHXI8JKrfExq3KgRmsu2H6oMUQuhX+p+/Twe26q3fAzfBzfu4pUqSppJtysYCcwoNmRhY/gYRVXeO4SiGBBYjwmfCM47ONKLjFK7wBJha4crb/7IyzFN1esYn4nUKwYzNn7ygtir2hzDsZBhTdHrPSELlmAg/vx+uF/d68rRXJUCP40SmXvG5ZoU37nyTE1+gW2W4xadssqCJ1ITHF6Bii0ptrCs8kqC2fqkpG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgNsX6T3RFUhh0BqOwvx0D5btr5c05ykN4AEFvUGfUU=;
 b=OwqkR11kHBzWwze5qHOc5qY9UqneId83hCDWjJFKNoVkgz/fAg7DLV5ZEejboHCyxweulLHEO3rUBx9oSTFQn9300Rlj7sPe7ZrwgZWNMUHDuIN3gyQd6y0Em5LYLB138qQkc3bMG/H9ieZzj/aD8eyS5yEoej8zbdPsK5NYq2htaglUV0WPul6evmopItFigZJewxKUYfdrM7z5mLUI2MPb3hGshGn5zJYQk3XMDd3wK9HnlnC80AoLEN61ELIxPq8dj+cV2cZtvF8T3xiinP+swvALJ10bH8WogLMqntb4P4z/4ZM4Liy+KAHy5qMl6YnM95ZasSAwOFSHbmIhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgNsX6T3RFUhh0BqOwvx0D5btr5c05ykN4AEFvUGfUU=;
 b=rtEBFyBQ1B1gbfBTB//aYBAVH4xcvFwDCjiiLJ0OK7gVfK5RochnIbFPEg1QKjf4pJaVaaM1uhpYxF2o5OHmXl/hScMbl6KXroXWTNUF3GNMK1kBMIqpLkuYUkHehunoIM+QhXFOuLeePlLv5tnQEkL37rlx3nJO+AAOI9Je2lE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BN0PR01MB6990.prod.exchangelabs.com (2603:10b6:408:16d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.22; Fri, 12 Jul 2024 02:36:32 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 02:36:31 +0000
From: admiyo@os.amperecomputing.com
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v5 0/3] MCTP over PCC
Date: Thu, 11 Jul 2024 22:36:23 -0400
Message-Id: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:930:d2::9) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BN0PR01MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c2b776-a834-4864-ab6b-08dca21b709c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7AuovNIzOwgMwS5HJFk/o3Oo1eBkMhxtPw61Jv2YVvlY3yH1dSCNF1gyc619?=
 =?us-ascii?Q?uVgzHxihIqyRgsn8NMi5FUwX3WKqgDYQkcKwZgFMEYYiyMgdfUgYsywUPZV0?=
 =?us-ascii?Q?KUHgzemdCP4k78wDI2SyERu/aSbOEm8WheW1UI6kJP0Ic+qcLx6frz5xYAif?=
 =?us-ascii?Q?iXy8PyGPgRfuM9tKdkJ3ZCQ0U4bdrT11Hh9zNCBOJKF/m8LM6B8rzgURCBry?=
 =?us-ascii?Q?LucC+TI+tArWxVtoumzYwDe7jFio8JD21+llEH+FobHRJECdH+1KUWa59Xr7?=
 =?us-ascii?Q?LXG0P7x7xnQOdddfT2HemVwb4rbyT3HbaufxDdlx2pAu0oEdihpP7T6AHlWE?=
 =?us-ascii?Q?YL70mhfaK4nLzZ3ZOiuXZrdu15zgEXyhnDM7WAFsZf5qqXhqOfvrz2I/6iRh?=
 =?us-ascii?Q?Dv/Vg6wvPEEwzjFH+txqhfBRdO4psbPLqNCjXAhjcwskZkmbR/G4FlsGR98z?=
 =?us-ascii?Q?M1kazVjvpqBEZ2iSkSV1NKq9w7+tmFvOfS8TemFGuqdwqtDQie/rw6Yq4A87?=
 =?us-ascii?Q?7W4+UBElzfbwcr9et6pLqQ0coxMKHbyfY/5P9DS0PjjeObV7VXHdK0F6l2FH?=
 =?us-ascii?Q?2vdBQsRObCq6D4F5CfTDfjmQBe/j4KkU99wX6ZS5/4T+B6z7+xdKokteQmd/?=
 =?us-ascii?Q?q1kA+AIgNjshX/KLyh/P3WroBwfEkXlNGGNqMbEN6TFIupCmqLGxNcfeFWhU?=
 =?us-ascii?Q?vWRiWidHmzQJgmA+gdq8xCmnB8srYPUFjkkOPWTqGh8L3Tra7v4ctJllz7bM?=
 =?us-ascii?Q?Nyk1QD2XQnuau51cHWPsgcOjOe54joYdw78WR/TqPSHFqu3E16EhxC0fThec?=
 =?us-ascii?Q?PD8yRoe5xa5GA2PHVEph0HieS2TD+bNrMoQNHKU1sOQSxG5RnDL5PpWmTAs3?=
 =?us-ascii?Q?jYDKWt7gXy39P/ylR4SSc7UxBCbUAz76ISNyKZ0yyTxE+0KMJmFyJ9eL+vZ/?=
 =?us-ascii?Q?Y75Rw3jCGTtHuyXF/LVEyRyoTpv6m6olQjW+vsbv58M1hxJAoQpOnEoCxown?=
 =?us-ascii?Q?k2MEDsl7s9Q3nFJRdQukVbvp3Meojukvbq/O3xHGeBAoeEXCtM3am4f2hkll?=
 =?us-ascii?Q?cGCG1yynHYMAFRu/IVemdFik/yDLytNYYAI14O+3kGulkvt287C9qccbvt6G?=
 =?us-ascii?Q?g1vPZ3kZr375A5+ZWTGZJ/2L3by5hRuqV5zX2hpfN6mxwkbYxaSTcLi5kGzt?=
 =?us-ascii?Q?C/440lFMDE2HS4MVnyVrQhhNPrkH0lJPvjs7LhaQ3oecPe9wbL93ZvakiBg8?=
 =?us-ascii?Q?5yq1KLV77iQfPuHQsHgUdqVjRVxkMJeJm4jMaLQ5RR+GuM4HY8/tvhji2nag?=
 =?us-ascii?Q?WjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3p4VqmqHPOnsUx3JL7vq7UXvmxDItxu4rz+CqYvNm/9xT4z2HM0Ixdfa1pca?=
 =?us-ascii?Q?iD4oaAhyN7Imb23zstqpyULp5BSBTotgoiqsYBNZ13opCxD0Ihc3Q8B0V+Ow?=
 =?us-ascii?Q?KR7q0kz9/SQIurZcN5azdwH8kvfTBQVkYoKMhAFnA4XIs1AI2gY5cFp+QeON?=
 =?us-ascii?Q?f/G5q2FqbdoQ3+GZP55qvQz2npD1atno+0zzSYY0TPhGkJEDll/CagDyxMge?=
 =?us-ascii?Q?g0axI8UfOSjDPXUm/bzWCOYj3P9+ZXfl0F2OwXIsb93MlnTtWnfmVEM5UscB?=
 =?us-ascii?Q?4HMPmmFGVnGni5MK3DG7WXSLI46ly/T2rD9vKR8MbXrlMDzx7+DLnxLDDsvw?=
 =?us-ascii?Q?kBtTB88lP4Nk2rXP7S0tDgMYUwFAU/vdQoGq/C3dgJUNBFsdwKG742QRPoBM?=
 =?us-ascii?Q?dfWVUMQHBHvy/YUHC1eytMjvOULcOD/HrH9xz0Vf+c/wIzAJcX5iM6VKYSVw?=
 =?us-ascii?Q?bwaC9ZV+HuoYNe92PDnt16DUFVdCmyTj9McX9oQ+gGc4T3EvJ/OJPLnjDik5?=
 =?us-ascii?Q?fYbrC+cHrrOX+PhKb9B3cDa3bpSuHGYzL+i/IIw4oybY+V26JMPHcJU5LJ8r?=
 =?us-ascii?Q?xYQJCZ44d4kxJY/aBceaYITC7CvoRVKG8tVLWRtNzXGngyojXazcNIDucE5l?=
 =?us-ascii?Q?h36VcLoEJORJGtX0o7JntBqCXNYoq6cN+QElxVbSnJtho/uI7m9RuBNT7u3m?=
 =?us-ascii?Q?uqqT/53WLD5kOTTPsVjD64b8cltsHxfJoC74fMAg9pneAGRcuQOBmOHD808G?=
 =?us-ascii?Q?UkxfsssfYd/1RqKC+etL9aRnOnWJI9AT0PKIenaP29SM5lb8yiFJ1q4/FFrh?=
 =?us-ascii?Q?9lQRnjEt5x05eIEdK3b/WDhuhoJh+a1T797zMCvirvIis6WLvyUr2b3CGnK2?=
 =?us-ascii?Q?oUgw2lF2P2HD/lcrzFx6Eac4vUoXv/XGzJwymISNUhrhK35VOyd+3JFAWclu?=
 =?us-ascii?Q?6nFycl5IOQ8/ZigVwymqxrASu7Fvq5ilJSqchkRKLnnFQ6Jr84jN+6S5/aD0?=
 =?us-ascii?Q?ZCnMlakTniyJFW3f9/Gt8HjghuZZ2ovoYLqeJLV0CjVXLvBGQHCcn4Zhk4HD?=
 =?us-ascii?Q?oCN2b0barQ1jGx77iQwZS0qI3JQxjLhgrVvtV+ptdkcJflD8ERGnklVLUjzm?=
 =?us-ascii?Q?f8ZQrMxXtMvW0uEWRjsG+aTtSAUHlNor9QC4ws11Y+8wnB7ybkHJQz3dC2u9?=
 =?us-ascii?Q?k62hEDXcTNvwpFEijPrORUn4uBTqxeDSmCsvz2onEB6h+u4TBZbnbk5JIH5z?=
 =?us-ascii?Q?dYGaKaABoIdEwpFGYm/Oxs71DfS2GuDbrLz6Oy2QI6CnQTLl5D8ZIy6qPUXZ?=
 =?us-ascii?Q?Ve+dRJK6Sdnqd4qwPrTHPipm4AtYHLNExy7ydwsfI30aCbSDNc+ADtt2vkh1?=
 =?us-ascii?Q?8f1HOMvDkYspB5cFAAtjaA00eVLUN+zlCERHqx/kAPLNg7VnGavfaudsyKJy?=
 =?us-ascii?Q?nx9DTS4pLskigMAIXXIBd6X+XWn44gsdEnUcc5gmF1V8Vt5lkK5lXfWfgsCT?=
 =?us-ascii?Q?mbApvDbraNekYvcPagHpF3wgz7hKPnjknvJWQrEC5CCmHFmm29MCKwVT/L94?=
 =?us-ascii?Q?3C2lGcim3KSpVcgWPKICX+/GveO7n00R/NoJMwYQ8C28mUAa8h+oZ6MYgdy4?=
 =?us-ascii?Q?M9vB9jB8tO/QW3osupJdTLmg4DrgHRYHWZtTxSNudgKWHKHAHbQvaHZVHHEB?=
 =?us-ascii?Q?T3i2ZtrRIL8O/6vwXWjXGIZ5DkU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c2b776-a834-4864-ab6b-08dca21b709c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 02:36:31.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pk9fwwdz38mv2W6rg/a8QdhQQgGPbo2C9CTqrEIWrs+lwogXjnrqup4vXWLjeLDoH2kMYZKXnsPiSQMCq+D414KngF+dR8jzs1MTt7EheKUoqGealsLdMKktuhJCq9OK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6990

From: Adam Young <admiyo@os.amperecomputing.com>

This series adds support for the Management Control Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

MCTP defines a communication model intended to
facilitate communication between Management controllers
and other management controllers, and between Management
controllers and management devices

PCC is a mechanism for communication between components within
the  Platform.  It is a composed of shared memory regions,
interrupt registers, and status registers.

The MCTP over PCC driver makes use of two PCC channels. For
sending messages, it uses a Type 3 channel, and for receiving
messages it uses the paired Type 4 channel.  The device
and corresponding channels are specified via ACPI.

The first patch in the series implements a mechanism to allow the driver
to indicate whether an ACK should be sent back to the caller
after processing the interrupt.  This is an optional feature in
the PCC code, but has been made explicitly required in another driver.
The implementation here maintains the backwards compatibility of that
driver.

The second patch in the series is the required change from ACPICA
code that will be imported into the Linux kernel when synchronized
with the ACPICA repository. It ahs already merged there and will
be merged in as is.  It is included here so that the patch series
can run and be tested prior to that merge.

Previous Version:
https://lore.kernel.org/20240619200552.119080-1-admiyo@os.amperecomputing.com/

Changes in V5
- Removed Owener field from ACPI module declaration
- removed unused next field from struct mctp_pcc_ndev
- Corrected logic reading  RX ACK flag.
- Added comment for struct pcc_chan_info field shmem_base_addr
- check against current mtu instead of max mtu for packet length\
- removed unnecessary lookups of pnd->mdev.dev

Changes in V4
- Read flags out of shared buffer to trigger ACK for Type 4 RX
- Remove list of netdevs and cleanup from devices only
- tag PCCT protocol headers as little endian
- Remove unused constants

Changes in V3
- removed unused header
- removed spurious space
- removed spurious semis after functiomns
- removed null assignment for init
- remove redundant set of device on skb
- tabify constant declarations
- added  rtnl_link_stats64 function
- set MTU to minimum to start
- clean up logic on driver removal
- remove cast on void * assignment
- call cleanup function directly
- check received length before allocating skb
- introduce symbolic constatn for ACK FLAG MASK
- symbolic constant for PCC header flag.
- Add namespace ID to PCC magic
- replaced readls with copy from io of PCC header
- replaced custom modules init and cleanup with ACPI version

Changes in V2

- All Variable Declarations are in reverse Xmass Tree Format
- All Checkpatch Warnings Are Fixed
- Removed Dead code
- Added packet tx/rx stats
- Removed network physical address.  This is still in
  disucssion in the spec, and will be added once there
  is consensus. The protocol can be used with out it.
  This also lead to the removal of the Big Endian
  conversions.
- Avoided using non volatile pointers in copy to and from io space
- Reorderd the patches to put the ACK check for the PCC Mailbox
  as a pre-requisite.  The corresponding change for the MCTP
  driver has been inlined in the main patch.
- Replaced magic numbers with constants, fixed typos, and other
  minor changes from code review.

Code Review Change not made

- Did not change the module init unload function to use the
  ACPI equivalent as they do not remove all devices prior
  to unload, leading to dangling references and seg faults.

Adam Young (3):
  mctp pcc: Check before sending MCTP PCC response ACK
  mctp pcc: Allow PCC Data Type in MCTP resource.
  mctp pcc: Implement MCTP over PCC Transport

 drivers/acpi/acpica/rsaddr.c |   5 +-
 drivers/mailbox/pcc.c        |  32 +++-
 drivers/net/mctp/Kconfig     |  13 ++
 drivers/net/mctp/Makefile    |   1 +
 drivers/net/mctp/mctp-pcc.c  | 325 +++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h           |   8 +
 6 files changed, 374 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.34.1


