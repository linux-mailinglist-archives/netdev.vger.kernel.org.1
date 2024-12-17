Return-Path: <netdev+bounces-152678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38C9F5615
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D7E188F534
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198B1F8918;
	Tue, 17 Dec 2024 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Xe7nZChT"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021115.outbound.protection.outlook.com [52.101.62.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E131F6671;
	Tue, 17 Dec 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459939; cv=fail; b=fxgO0Jxk7NCHfNT1+O+v4jb6LvpnyIOeHmK42yDTtLou1Pzw1SkQjf3nY9Pf1IjRTuApGTbo15beWPO8QV2t5vhntT46kvJ4OA9MfmW9Q/V8lUhH/0Jxc75Lb8LOr6v4KSw7tv8E8pcZ+qE5OsUBFXLiz6B3paVqLwcXu0W+yd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459939; c=relaxed/simple;
	bh=PWLfOxIxct5BDNK17gJreqg22Y4R1akT1zRWl5e9/50=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b7MWGpAf2gRpWRdcy9nl52NT5HcQen4vqcWPRXuz2TCpRfbXEdKRAVCpxx30NHybjb4r/VUOkXdyuMYmIaCc9Pmo/PbQNIWH+a4jYJzfsOnoSq+qLtzX4+DeWXsxWkxiePvMfBCsV6H7oR5+4tVIqCqNbv7FWBG4hDFYXL7rnzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Xe7nZChT; arc=fail smtp.client-ip=52.101.62.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNOwirWQKnBlYRsw1IysAAiHw36faAe2bt2Zl2vdrU7PeEjgWCgthE01k81F1f0jU1sFrfo/Oh5OGLWhJFVNOh3UNcUcrAmOHsAABtkUPq5JsTxxCRu2N3J5ZiRIv49fDKOhMp7klCsNJCdJAV9+bTcOipKvMKxeXv2dg9nZQAlqs+7ly3h5z5RDnC1m8srmMVXUGUNJdU5xLzeuNGY0+DphBaKw+T8UKTzrYdRKuvH19nGKWOkhEKoGmbWWFMhcgrbftPiTXPhzJaMc9BpQlJzdvzCBDlynIOpmofJB4YRZabJs+PkgE9kpJ0tEZpVCUl4iBZSP2/xq6oLRHRINkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRYgj2xOHsBwWUcClff8HVhtB/F7o8zs2BUXPlrm758=;
 b=vd7ULblmvs+kAyGMbyCn294tBMJuI9Fo/kQPdk1vgXPC/PfRaw8jwuBAbu3B7OUmyWjjUTchARCAR7DAV1lgH/B+ziQhp33VAFWgJ8E02sirZB2DB7Te8VG9FCGiebv226t10Mi77hyUeeNAVTqOLhEioncI8htRPNIM/L+nrnaLt1/kY4MQRIZxjJLM3NJ9fsjENuEBTi490eLZC0HlRRlF6pJXWCVDQdsx1sopyX442TKu/RPl+e+N+rF6hq8vvCrhl3bJ8Vx6rnGseqUgARozboeYcXMYrcVg69myooGViMzJ7bOjM7GHDwWYchO1M0bCwMtwKAjg1r11gyi09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRYgj2xOHsBwWUcClff8HVhtB/F7o8zs2BUXPlrm758=;
 b=Xe7nZChT3kLoEq4edGKcWYrP+rW5bsjFFq7mvUzA9R/soVHKGUoEsOdJim9npRUUZ3SdoXKwGSAB4cjAPlm3kvMd4ZrT++f7vBdIPHfoKDnFmILoLHrnFn0h8pmBAuI1p4P80t650tftK/XodV/G/lcEgDz76byGzH7nwfC+rnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CH5PR01MB8911.prod.exchangelabs.com (2603:10b6:610:20d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.12; Tue, 17 Dec 2024 18:25:33 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 18:25:33 +0000
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
Subject: [PATCH v9 0/1] MCTP Over PCC Transport
Date: Tue, 17 Dec 2024 13:25:27 -0500
Message-ID: <20241217182528.108062-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CH5PR01MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff4b94a-17b5-4864-aa18-08dd1ec831b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CDAZSOSZsS+F+HkZe8HKLDzi4adBNObVT4M5dwsUzGQaSXd970QFdMRRnLDK?=
 =?us-ascii?Q?3wWA+2+duffLDE9ZNRgF3Y+CXb9x2ijoxvW8/z+sh/1CoctwbZcR+mYD7Ooo?=
 =?us-ascii?Q?eLqfh3/WmOIddbBuCywRtvnktUf9RjcX2N+MtKsrj7bvZjUXhzR/DamqwqoN?=
 =?us-ascii?Q?ceM6beDHwZn373A+RNl/NjYXTfL82x7ZWk7l0MrWLZ8X/hNz6gbsFDAkYGVU?=
 =?us-ascii?Q?7HGtC74e+zUPlL7DyrokU4reUYoxhvYGlUUCm4wNg8jfgyPGtgi0Nxkge4ip?=
 =?us-ascii?Q?DS891JZbNdDEi7Ad+mmSIS34yL+fhd3tqaEn9vPdRPmRexeujceEJfsZMlE4?=
 =?us-ascii?Q?9AikICu3jl68AvdWg6sGNw39l1hDX5UItx5AH5WgtlKmBmCCMaMalCIg6lhj?=
 =?us-ascii?Q?sC2RpsIpx3zL9RBd8ljb/Gk9vN3qJneWXi1zeiJG4m472nFktzjDFuy8evYz?=
 =?us-ascii?Q?CYIeUuWLwcqMhnytrfLXIzEtPGMBE0jeAgzQ06ciws08iVNjhoqFQ/YTQSk3?=
 =?us-ascii?Q?i4KwclcrtznNmR8jE45a0/ddw5RkdbpQpLuz9MJ4OqCUs+EYK5HZ1Pi7V+mU?=
 =?us-ascii?Q?TZ7Y99QJ9kvsWy46wPe7EhbzrSfhSgBlk4nBzi9fOesTNKFJInZNd0g2B6lO?=
 =?us-ascii?Q?Xim5IFzc5NTdB5XKqB8mcEQdDxkjl4mjx0IKFdgIlnekeBVCZF5LHtNC3RAH?=
 =?us-ascii?Q?uSYGwa3rhoFin09szyXkJHDIhonOwF62PzVqGHN3UUn5FYmXNhqz/7hJBqlJ?=
 =?us-ascii?Q?hm+gjx5K5SOTjN/3R4jqD2qfkxRKaupj9NpH40SzgSdLXAUUrEca5cXfr5r9?=
 =?us-ascii?Q?NM32owPwJIMrkCIoYBvBBSDXM8hXl7p8S3ykoQLoimx4Y+48SjezEmqGGbqu?=
 =?us-ascii?Q?eoahZcf3jGB3E7Z1caMv60fY3V0VhT/lACI0I6WNjuJOBSRGeZu2SMtM3/fd?=
 =?us-ascii?Q?EakT7VqTVXqyVN96anX1nt7TZT1IOtAAKjiBNQmKVLkYOzaioG9ByOxH8QoA?=
 =?us-ascii?Q?GpPCVbyPKny5vEBvndU3+UZIOrt4bBTwPHrq7MVx8AM5dH1JEIq7tQB0kBdZ?=
 =?us-ascii?Q?mfU6iVLA9xY+U+B4tyIqaMkYWz6iQG0/xyYQeodqSzbgjmP9+fS0KOHuiSPe?=
 =?us-ascii?Q?B30Tfidl5UKcUr39lHQKy85Al05TgRRC4RI82ZXqrvu1xCYLzR20GbH/m4aI?=
 =?us-ascii?Q?jDbEVtKvDOQFqkdGH8TYzpGNdw8seihtJyhEJmgIc5liCRiUut9Kq0r2jVwT?=
 =?us-ascii?Q?uD8k1K6mQWVWnjVQ6611Nki3EKROdjxGS6V+dMnhh1n8wDVeVGBh+ZY7sVTe?=
 =?us-ascii?Q?fzW6IKk2+k1gy+U1EliAk/4j5TCz/+R4NNsPJEZwTrWfgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KPH5SzyI1lokBNPlOzBS3a4wf4H3APWxyU1YUXgTpw/I8NtFLfzQuLJ9k5tB?=
 =?us-ascii?Q?x7d1CWyBXgGEfSFGTOoHJ+ycO+rXNHqNbHsAXkxRD6xvO7F20Z/AfFqvUc+y?=
 =?us-ascii?Q?9ySXVQGZPv6NnRv/DM4OQHFpzPg1YI4tTP6IF8yQ/i4Zpw+SPzdc0e4WTZeD?=
 =?us-ascii?Q?URCPBFUi3K0zsdrStJBhlVfcqgG9FEboXmLs1hhjar79OK32A37pmUU1/5QV?=
 =?us-ascii?Q?o764s2F1WsnJpbVUcpOI837wf7lTweI+AUCDOj0c8nVUP58oaupgHsK1AX3U?=
 =?us-ascii?Q?gbQ7/Ht5XxQLyaTJtAcF7y87Gs7RY5WbqeHqO3EckDDwXWJL60yeNde3yhro?=
 =?us-ascii?Q?TG9mI4Z3sjXANdRxzLruDiotDTi98+XWcpzFaVjUf4+7LK+aley+lIiXCcIk?=
 =?us-ascii?Q?VlD7xiRhYxnWIC6BzWXdY8894QimQeiZCeO/hvMkkoUaMFow/QsGbOYv2u79?=
 =?us-ascii?Q?EQUhZeRWrYQaFAw6MegN5lvG7tgiRlTL2XIL/DiDN87xejRmZLce/lmfTEdx?=
 =?us-ascii?Q?j2bEpWR8R33UrImgSERYtiYPE7lfOA4IwkMML0GjHkEkuUb/YdtcdFaVxcT2?=
 =?us-ascii?Q?Z1zLfdsZw51hQRWXY/1Dlm3zQ/6oP72Rw3EabnMuKyo5vbb9oztYhVSxxM+g?=
 =?us-ascii?Q?QSaKnZz7PYm4dyfiw0ZeITbxYByIE9phkVjG5QA4tQXcGUKPfKLO7aPfgvQ7?=
 =?us-ascii?Q?GFDjBGFBoGrb3lWFa7S63HmU628QBSQ+krGyyt+4EiKLz4tWU0B0iKIoRS2F?=
 =?us-ascii?Q?Aphq9DhIDxSFSeFLTKk8HNjIIBockdvQX2xoGPM0EnA1AiqLrM2HZ+FuYs+2?=
 =?us-ascii?Q?EwL+X0tCSlngkKWnNiMfhGcpF9+Q65E9+LKMh21z4ZHqbPPfCxqiYHMBL/w6?=
 =?us-ascii?Q?TrDQKuCwQCMKZDWR9MHAaj31tjD9S0ouRKXSBBtSaV33Z9NUVng1Sv/32rq+?=
 =?us-ascii?Q?iK1u2SjG+vJp9NJ7JN8ZTD9RpwlslqnkCs7Fb6btEjw5iwF4vAHRuJBFN9S7?=
 =?us-ascii?Q?PnEAYkLowQrkz8IBzRhy+8cw1vu8HpJMfOugbkqKaygc/wyqpT5VBVGbQ7wI?=
 =?us-ascii?Q?gmwU1RcxXMi+MmhptwxNckbzBKGKOE8Dv1iM0Zl1ZLeOlBiFLIdnihjk/2az?=
 =?us-ascii?Q?uOlhfFh7s1m63r8g+ongYgp/LYkCzMH6uDNOfDY4XcgbP7uvzsXQf/HZ1Mq4?=
 =?us-ascii?Q?ZoIboIno5/WlPxqtzG9mq3ecmgJhPNSv1R4esI5sqdu7ySXtoSEWKJ9OaeLg?=
 =?us-ascii?Q?e9Jj+TeFVfVT07Ef653mt8QyAbnWZQJXUqEZynfJTIJ7RD4zBMnXUztaJPbH?=
 =?us-ascii?Q?VKJBKu09b5b4aklm9pAMrR4RyuA63IZKRbHt4tFketWg6bw/4Ge4JSDVxHN0?=
 =?us-ascii?Q?bdxGWUJt6I2jg7OXY8tcLqlKchamhCAnYyXbBztPKjKic9fH50x/lPxtuDx3?=
 =?us-ascii?Q?VgRyjWf0BHmSGPmGkvI13AgNYssOk/pvfyM0xEIbj6UwVJq55w+qUEIzODXH?=
 =?us-ascii?Q?FLCyerlCrIGxhN1CECm/ThlfYXawCEwj/mYRoDHohPs9WqneOqodRYUsPQDg?=
 =?us-ascii?Q?5/aepnB7iOspq3HfMJENhZ7GZ8k/oaC3V56RKJJFecij2HoaUfB2r7gSRKJE?=
 =?us-ascii?Q?4VJf511YZLRgsTMP7JRX2b4Fcy8EEfK65J6CU/bQZt+xEGPwpaKoBRddNq3L?=
 =?us-ascii?Q?9HKdNSAYSMZgXoONF+xPcwObxYI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff4b94a-17b5-4864-aa18-08dd1ec831b6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 18:25:33.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a47zwACPIGGJzMyCBy6WrhVvILCsfnZIHiEjJ2SL/72aLhApmNdAkkMIT0AbB9DyX92NfIimFUUfGHnly7bTHDPYQwx7qSUi2Z1dyVQz13+BETS7Qb5yXiLtzEMlOMys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8911

From: Adam Young <admiyo@os.amperecomputing.com>

This series adds support for the Management Control Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

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

MCTP is a general purpose  protocol so  it would  be impossible to enumerate
all the use cases, but some of the ones that are most topical are attestation
and RAS support.  There are a handful of protocols built on top of MCTP, to
include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, device
authentication, measurement collection, and device secure session establishment.

PLDM is more likely to be used  for hardware support: temperature, voltage, or
fan sensor control.

At least two companies have devices that can make use of the mechanism. One is
Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part of the
ACPI spec: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has  the ability
to ignore an MCTP link that they do not want to enable.  This link would be visible
to the end user, but would not be usable.

If MCTP support is disabled in the Kernel, this driver would also be disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations that the
Spec calls registers.  This mechanism exists regardless of the existence of the
driver. Thus, if the user has the ability to map these  physical location to
virtual locations, they have the ability to drive the hardware.  Thus, there
is a security aspect to this mechanism that extends beyond the responsibilities
of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device will never
be enabled.  Thus it is only an issue on hard that does support PCC.  In that case,
it is up to the remote controller to sanitize communication; MCTP will be exposed
as a socket interface, and userland can send any crafted packet it wants.  It would
thus also be incumbent on the hardware manufacturer to allow the end user to disable
MCTP over PCC communication if they did not want to expose it.

Previous Version:
https://lore.kernel.org/all/20241029165414.58746-1-admiyo@os.amperecomputing.com/

Changes in V9:
- Prerequisite patch for PCC mailbox has been merged
- Stats collection now use helper functions
- many double spaces reduced to single

Changes in V8:
- change 0 to NULL for pointer check of shmem
- add semi for static version of pcc_mbox_ioremap
- convert pcc_mbox_ioremap function to static inline when client code is not being built
- remove shmem comment from struct pcc_chan_info descriptor
- copy rx_dropped in mctp_pcc_net_stats
- removed trailing newline on error message
- removed double space in dev_dbg string
- use big endian for header members
- Fix use full spec ID in description
- Fix typo in file description
- Form the complete outbound message in the sk_buff

Changes in V7:
- Removed the Hardware address as specification is not published.
- Map the shared buffer in the mailbox and share the mapped region with the driver
- Use the sk_buff memory to prepare the message before copying to shared region

Changes in V6:
- Removed patch for ACPICA code that has merged
- Includes the hardware address in the network device
- Converted all device resources to devm resources
- Removed mctp_pcc_driver_remove function
- uses acpi_driver_module for initialization
- created helper structure for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unnecessary null initialization from acpi_device_id

Changes in V5
- Removed Owner field from ACPI module declaration
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

Adam Young (1):
  mctp pcc: Implement MCTP over PCC Transport

 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 320 ++++++++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


