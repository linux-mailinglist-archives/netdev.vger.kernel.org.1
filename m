Return-Path: <netdev+bounces-108620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0F3924BEC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 00:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD49B210BA
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9B155A55;
	Tue,  2 Jul 2024 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SbBXp7XU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2117.outbound.protection.outlook.com [40.107.102.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17DC1DA301;
	Tue,  2 Jul 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961138; cv=fail; b=JN/YUtG1o1mD009mu9SxBsl8j9vFM4xk0Zdt4mivTASaeJ1Lg7Jrf9pGH6HRpY0WvwQ703Xdt26BOfI1gyDrGckanCohQiC5foRXx4vwhyqB3grTneJHyysP4dXBXhJRnJ01eJmdDZRBxzHND/gyrqOS5O8U1CrI+RlIVSAzuJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961138; c=relaxed/simple;
	bh=JE3wGZAvC3OBJBSo+rbTl8HgqQY7xNBpQnnaheKZSNM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SCJ5A8CREwXGdzdleEpDTj3GbqtFI3ypPR7LLWRN4PiAfa1lfXDCR7Kx9teitL/WsYPNFg+JuxyFfUveypcZoKq3uG2MOemkckwVd7ovlOdzPfLDhWk1KgSaDgXjKusCIuFG5pZ6Y3DpixCTPTB6AO4pRbJqEYsTtmXZ06w+l/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SbBXp7XU; arc=fail smtp.client-ip=40.107.102.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZE9FdiHCwZgEfACwKGGYa9sxhND1Xv5VqEGydx0mhlu37CDhOUSfvnj43KUaWs2HQnv8u60H/cJRvDbBJYCf3xW79smSeUpvd3j/u+87aOrYkXI2icgT1wqPXRVIxe4VJSBEAcvMV1hSYrLN81UWUNQ/L1FWpX5Y8JF3f0XQB8N/UbHgQAs4rOEqirQzfjgbj/9/qlqfp48O9/0QJjyWBM2RQee5WXzgGgr3UF9tJG4O+HYceLR0vVcDEfl2DEmOve4WsjMPwwekyHg6ZbRqssT4v68TqL8YMJQh+fNJh7UVm4OxwkZmXkC0lQTlI2ZjFCn0cjJYNEcb2PCUe/QgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6AyNDdEWX7vFzVXOit2MGEYQx76FjbpcAjVdlUfVv0=;
 b=fQTclKT4935I5/L/Ho+tcAVp2lMxE//L+t/BLMxb3Y410SJwVrIbfMcRkkqL19CAOlBQqF3GTf6UqNGwLuxn3zJgIBn94Fy3HtwkkGXo2zbTag4p8egi46fayMFydsesE3bIzwvEsxVFt5hJ/O/Yh6CoUT4d9TTPeq8YhfJHhtYwuHKpXZOt+ZF8bMRv8YYNoXlb+mwVxJT0fcULZuyZ9KJ5ISdPZRgeIcI5J8w8wGwU/kUi0rfWqXf4wO4ytPCcZCMoqFRQzQylrcqLJqiw5fVHlOU7ShxkNK2ovS9HV5V4DZDTn1jtGGpuyE0W5ojjzjV2gREQBp0b+hgK9OREXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6AyNDdEWX7vFzVXOit2MGEYQx76FjbpcAjVdlUfVv0=;
 b=SbBXp7XUexopAsXfen4tl0oU4Nght/H6RKQxsN+mm6O6183gRHcr3qrSCpqwXLUt8vmmSMBwZJFhpW8po2fq1ABVUa5gOhqI5/hL3Xr1qa3pBetbjsH6yoRWWoYryt+NsDOmYrTuxPNh17YZEXvw8JcIiAKByi9VeS+ht+hExjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Tue, 2 Jul 2024 22:58:53 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 22:58:53 +0000
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
Subject: [PATCH v4 0/3] MCTP over PCC
Date: Tue,  2 Jul 2024 18:58:42 -0400
Message-Id: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::38) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: dc15ac5e-1f21-4c8d-5ef9-08dc9aea8bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?es7TEIFp9XGo6naC9YgcM/+80yaErNrdEMpONFYEd4obBHG4VaQ7W7C0hrt6?=
 =?us-ascii?Q?5XVCrVy99FJld1mpPuTfYwB2MQ46H1cR19E1/MyOttyeT4D/RiHae7lDccLJ?=
 =?us-ascii?Q?mr4/CyJcDdgCnbwG3IhkR46UdEizOwtDFaERa6lWJrPU1a2nLLCvIFVBk2AO?=
 =?us-ascii?Q?9HRqa+FauKvdHBCjvCZyaTRTEEXJux/AKQaoRY4Sb0fIXYpuDjl4VZAH3C8q?=
 =?us-ascii?Q?9icQPiXxSErNgcnkUnve3kkE/Fs+WS21LI5UkOsIdO1oWXrNrtkQ5kTVQCrT?=
 =?us-ascii?Q?F9ydpK1FA9EtPUIytQzhUwbnBH5Y2FW9MIpa76W/ig3JOWOvNqtHvdAiZWjG?=
 =?us-ascii?Q?zq+ljr5r62Seahs6V7qc4q0QTIjWbVtAJqonr2JWzWe7ptWFTQSozsSbbyOM?=
 =?us-ascii?Q?xZ5Sw/Qp6kBmWfP7R/wbveqqIo4PxdhnX/mVr4S+YuLp1Kmglwf6Rt4LuaVb?=
 =?us-ascii?Q?M5ZrDNnePbzzafGroQO+LnTrN4KGR1N3bwugBt3GLrat2Qm0C3G+IHWqi20H?=
 =?us-ascii?Q?QOm9/nCODBuWsEU2508nmmA7FYwstPNOSoVm6l8jpEBwL+jpcgdKDfwsljJX?=
 =?us-ascii?Q?HPXD2zmttcdfhPh5kWktfbbJkCBpyCThxDQxSpE6X1aeBm3oUYCh4oX4uyas?=
 =?us-ascii?Q?TGB/ANpvLUMmimzhfUOIXccacBc5DkPvKV566yoJpdWTmN2NZQG6PwWSkmnr?=
 =?us-ascii?Q?FoL3srMRcgWXEMdtL9Q4uRCRQtTu69C2CBPGz9cxa47/RyWPoW3DX2vF2hp2?=
 =?us-ascii?Q?/mKMH+3o1ii/V/3ncWCG7KPM2TYNCSvvGfw1h4KMndUHu0pwx0Ih78I+4cKz?=
 =?us-ascii?Q?XrBjbxeGR3pgnzaLiTE5qpcUflRRIprpjVjbhVGQxLebZi0fSSS3v7YIYwOb?=
 =?us-ascii?Q?HLYZcwAu/TttGhC+tiTyPnYZ/M+oa1tUaQ1PR7w1dWZ7iZrHyDijy9RXMXAp?=
 =?us-ascii?Q?k8lRCHFVdg6EtF+Ab40AYwe36qpHy/EpR4GOi9hw3aqPgni8RAslR850sjI+?=
 =?us-ascii?Q?E8ZLnv5+qokjSBQ0yeWt9rADSViFL8+ISTup1lALeC18e2A5/3bX3HICJgGJ?=
 =?us-ascii?Q?1IPqOA9Utn8kV4U5tigPmojXTvINSif9u8Q+nwLS5Lvlte1zR2uHNc/enk8Y?=
 =?us-ascii?Q?oRwaNw2+Rr4Tc/Q6MZHR9bveyR9R6/DIMPMKZ8elwczKIUpkxeTUyYT3SccL?=
 =?us-ascii?Q?E9hdvTu1XYo91zGluLXO7C0hUMoL3iDgtwRrsy/c+Qn+LaGC+aNwh5mUHXuj?=
 =?us-ascii?Q?sYVhK24cBdfAwBGa0Kuw5Iv3raV+WuN4c9AjF0dowudx1rujfWa8C6rovtNe?=
 =?us-ascii?Q?/D8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZygXTdaMV9CuCnNWjmE2ZkXBRml3Ixa3MFXYc9maqMpzIQwFqrv0SewmpoF1?=
 =?us-ascii?Q?SiYM0jz6nxOWoeKch58I/mCnAsIbVz5EiV9+3sLdSnHpaY0UEW71ZUWJhBF4?=
 =?us-ascii?Q?t3RE/+bII3016IpmXH/OBgwZn79G/dN2DVIJZoO7P6w4ukrsiCLdqO9SvQ72?=
 =?us-ascii?Q?IJgtC78nVYe2ir8zLkVM2jJ7rSWgODyriSMlp6OeuiDaIrjO79n9wk5I0MCO?=
 =?us-ascii?Q?GPVCdZ6ROU5QHaMxE1/4fyT9aJWWtvGLyF74Jd+GhhRo9SHDZcXxxKAv5AvQ?=
 =?us-ascii?Q?ZP66qUl0XXQNw+7cVc7Zz4ewX/GuqgTuv7pNQ3xbVZqK9zhY0nxTvW3J+/Nz?=
 =?us-ascii?Q?0ly0YDDxHTK91x70b3mTzwd6MV+NMpZv7bZ1CVzoiHE49mICB6ctcNsQL/Yo?=
 =?us-ascii?Q?uE9Q5qyF3j57zo8oc7eAOud5aAW/BywbXplDbAilTTalB0NRg8bbLagDPdPt?=
 =?us-ascii?Q?q6yxS7fQsqMbckMSGfAdGOl7B3ePETmCccsX3DAgcUYBmeM9BqH2RHdxsI6F?=
 =?us-ascii?Q?6ilFbc6JOiPBAiXbyOAnpk+ez5f8ygKw1ZkfGE0jSiRvfpody+1UOCeGqdmw?=
 =?us-ascii?Q?yE4PUPxz1HtVtMJ+ZHhrtNWBd5h2CR3TkludTnWdiCTFmYKyjUFPlgenmqYP?=
 =?us-ascii?Q?aCSpsj0QYAbN+7FDgR+H7EZjz8Lcoz3j5AZ44mCKujo2MMlcI143QAQYLoWr?=
 =?us-ascii?Q?m2RRp0MXWPNVijShEh6vfBN3ewqonAWNS725Ch5wYkLr2insdbiJi3/d2SXp?=
 =?us-ascii?Q?+3IZYFoICwzWRAb+2MsOi3aGkmqruc2Cv0ILegqwuAX/lvn8cMEZmcw+yQ0B?=
 =?us-ascii?Q?KC/nuHSQynyVm5gu1Q30lMNVRl7OiMxulRUUZZrLh6JM0HiNepRYCAfXmayC?=
 =?us-ascii?Q?MJlgBRsuzZxRTIVuDLdW5P5BFlXVRI6YQNzuXnTnXtWkOWUULY0ybSihmy31?=
 =?us-ascii?Q?dqAisIMDLeVbvTaCBburag5Mn12ZaeXvYhKqLY7YjvmMa0aOWBh2+B2fWhi4?=
 =?us-ascii?Q?DqZp0p9aYAhh07WL51C93U7SaDRC8ffziJDT1fpO+HBL+9e/1yjHywwm8DfQ?=
 =?us-ascii?Q?uuK1CcUb07JzIhG2dn7seFeMgmFkuIWX7VQSk/6kPtX9HLSYBOBkOe/hUZ9U?=
 =?us-ascii?Q?MbwotzdzSDUKBJIY5DVAM6U+ypbOOAShzFciPFpdbPU7ngUU/Ni2UDsc095F?=
 =?us-ascii?Q?bDSkfOiIf6l2lLxPK31LxCMfnzSZQc88p7QXVSA0vdG/mH3G4qAEPa6y20HZ?=
 =?us-ascii?Q?DcDOWodw2DZJOz2PkeZof0e36kO00GcHOJVbzfWF7A7NWNhWwbax8PfCiBTB?=
 =?us-ascii?Q?jKdJFieYyTS36yZwT3COw/jSqqOzh1EEweFPporeKqodxM4L6zfsdyJB6Zlk?=
 =?us-ascii?Q?ngbm5mQMAZOkW9J4aRJBZo6hAewRxOEPeV8ZZbh777dc/XsffszrDaJxcO22?=
 =?us-ascii?Q?s7WGiN2elcrR4JTRwcbtTcGjvX+06vM0/JtM9V9TUp08zwohN++Ux7bM58j3?=
 =?us-ascii?Q?Z3m38Dc7jpQAecStAiLt826JBtgc6x+dOVV/YAGJZXhu3KP+hBxcweDg5KIq?=
 =?us-ascii?Q?VgxR5tOhSXwHLFNTQUQQLuek7bM6xae7xgtp4QJzuO5ATAAC/GZkWYQTkTqB?=
 =?us-ascii?Q?EuUuqb9yIenlXT1xih/K96pcuk3sgvnPWAh5dw843Dd5aL/yxjhBvy8/lSHz?=
 =?us-ascii?Q?YGfJtCkEVt/Ml9aXrwgDfu/VWdw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc15ac5e-1f21-4c8d-5ef9-08dc9aea8bad
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:58:53.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nT/zTabykhPtmT5X6cWa02fxkD55mpqh9iwrLclZ8SjpttIPbnMnfTshtGC0Gv6GqmzPVi3q4HQVNzkiyeQtvFL+aKTRWc+8OPU9EuzCIAOUF9nQWNjTSWtHKy1X7YID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6509

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

 drivers/acpi/acpica/rsaddr.c |   2 +-
 drivers/mailbox/pcc.c        |  31 +++-
 drivers/net/mctp/Kconfig     |  13 ++
 drivers/net/mctp/Makefile    |   1 +
 drivers/net/mctp/mctp-pcc.c  | 322 +++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h           |   8 +
 6 files changed, 368 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.34.1


