Return-Path: <netdev+bounces-174580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC89A5F619
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4048117EB29
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF2266B73;
	Thu, 13 Mar 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KxSEtcif"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C2DDDC
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873163; cv=fail; b=AbDBeBHZP29aIZ8ymE0/GmfKELZ9rJF98iQ/UAVRWePTIBT2DUEZrtxlodZzq2i6ARxVbqumwefTI4NhDAokxWpcKC6wQvINS7OW2o7OzFXnukeqc3oUSbQo3d4D2n3drCVOVb4zK35feNhzDbFxCBBoyZsHwOy6V2IpAVJVEdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873163; c=relaxed/simple;
	bh=qw2QdFEJ236oKVQJXSpSaZGvfaUALL2OePLx6K0JYHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QjqY3N4mnYCMHfQ/LnBLcOSWR7FH5gfnJcisdcR4pwNtBdcUm08EnvpOidlYLVwZlCOA4p/xzyjkeAm6ryuM870LMimU4wq3troulCJ1ndIIEF+mNcpOmbAAFNrQnfqOD3wP2whPxJpRFRFSk2TPAN+f/SanbnrPzMrb76J0gp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KxSEtcif; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGqEEZllKSeJXrQ0LU5rGuPkWsBXmwH0S8P5k+YLkgiTOxCInnw1YylMdnTcEKQKi1hA1uQfLwVHkziRyQYi2eiVUn6oZbz/HTpksT7KvjkQKfr7si4sgfhD7JcClyHpP5wXFfpUgPq1FBFZpdzfkyCRkcvZgPZ/YParmLDulaZB6Iwp2J2ob2BV73GjupuNqMt6iZZzReTGS3Rb1LS8Y2GMay2bS/Txbiscf1BPbbP2cucG/zrAxOAo3Kd2U7R+yY0mZM0iX1QdRHv5p1hSUCOK2CdES/J46+bSYYlN513tMTa5uhoAl1ckYJanYsnjT7TRZhm/qCrkyw40xXw9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJLTjr7iSBQEnttUf5x9E4XotrK4tCblU/ifwU0KQHk=;
 b=GnJX91icUtlQJAvMVAuVr7jzOTAdlpgT3hUQ5K+5ocB3qe7bpp9pO7EJnx8tPtSqEb3wMHKOQ1QmRKkm+Z8a5dhZueBTPrXihxXl6sDB26DVMstc9vvMeCg19ZC0cZ/FwQdvK5XLbctS0ki6lHOWmbJB+Eb2lP38OYO81ybBPFhYyfTcvb+L7rKngon2+jdYkjBYQ57+/3dq8+cxGlmoRedXNbkuEsJk/GOsDdgMryrw1ysmu7H0RsO726Au3svglQguLj+m5iWip78pBQUuPcg3WVxa8Z8sISrZ/zgltcTRYkuMs6PCrQ1zqGbeeVlpK4zTKMb+ohzxpDXBjJmZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJLTjr7iSBQEnttUf5x9E4XotrK4tCblU/ifwU0KQHk=;
 b=KxSEtcifR2F/2/dNnhOMc3mOO37Ju7NLQCLTwK2LsFE/vA9219vgDeDkGayfvN/DRv47uzCbInTapGO6KO89RbzcylC4iLOIy1ZwZIgGMTRs6OtKAl2WoEaCuRtVcbSeMI4MHzARGEyKnONKIbdCuODTwWVtjrOH7Xdj6H2URpoxNMM5Y7CHBn3LKd/O1gKGq0nQhbnhoquCEKRlsnyzZ2AxnTMTk4d8HP0cEvlfc6hXnYHhhNPJrvBsguH1CWaNg8BNfsu2JbCzJayWqW6k28OTO67PPlid+vg0CGwDKfBanBOICyqwo/jEW1U1iyXYyz5sRGJVH8aVhW2va9nBvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 13:39:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 13:39:17 +0000
Date: Thu, 13 Mar 2025 15:39:14 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3] igc: Change Tx mode for MQPRIO offloading
Message-ID: <20250313133914.oqkaihpsl62bmi7t@skbuf>
References: <20250307150231.pc3dl4aavb2vdp7i@skbuf>
 <5ebcf4b7-ed17-4cd6-ba1d-c35562a32899@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ebcf4b7-ed17-4cd6-ba1d-c35562a32899@linux.intel.com>
X-ClientProxiedBy: VI1PR0102CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bae8f62-f328-4760-d9f6-08dd62347383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXVFZ3p6aTlPQ09ZeTV5dTh0VCtjZ3Q2YWdJRmttQml3UkFQNnJZbCtkNnRG?=
 =?utf-8?B?UUN0U210cERUaGlyOXhSZnF2cU83ZFlXMzQ5WEFEdWZpNHpkZnlSVjB0UU5I?=
 =?utf-8?B?K0p2bFpTZ1NmeU13RDlWeWNoNmlobUQrVGVKTmRPK0F6RmI2OEx1b3dzR1pr?=
 =?utf-8?B?SlBqaW5RclExUGxaaUJtRmg3Z2FZbWs4WThBV25jSXRNUkJMWFladStrMXpB?=
 =?utf-8?B?T2FZSFBTQkZMVFZZcEFlbnc5bUN5cXdwTi9jblVGS0hCc21UYnU5SUlrcEo0?=
 =?utf-8?B?YzB4M3lIK2R5OGxrZWVPVDhjeFpqLy9CUWVnMmxPVDMyeVpHY040dG9xdDky?=
 =?utf-8?B?dHJGWGRLQjBIaDIyUGpuSENQNlltKzJUdER0U3QyZldmOXRTWEM5MmJyUlBl?=
 =?utf-8?B?TzEwdmFBa0RzYkFxTXp0UVR0dFB1SlNsZHZNVWN2OFBWRHpON0ZDc1lMcm9m?=
 =?utf-8?B?cG13WmM0QXdVTVdzM3hlWTdjSUhnck1HU2tKanQzTkdkUTAzVWhLZFliVDZm?=
 =?utf-8?B?bit4MmpUT2kxbE1iWDVWSnl1Nk1EdEcxSk5ReklUR05HTW8xWUIvR1Qvclps?=
 =?utf-8?B?ZnlGY1k3a0d3c2pEVjUrMUdDaStTZkdtSXZnMms3VkNGR2JmS09wRVMwbTdw?=
 =?utf-8?B?ajFocVhKbkdHMTV6NTgrOTY4KzhtU3FqdVk0UCsrNDNHbnhRQllvdENFekhI?=
 =?utf-8?B?QUllSGtSNTdydWJOOGVEYWZBM2ZqWU16cVdKdDNURm9tdXVWQ0RIbnBNYnZx?=
 =?utf-8?B?cG1hYlBhSXVGaDJaR3haKzZCbFBRYVFkS0hKalRzNkVnUmhzNXVycmM3WHor?=
 =?utf-8?B?WEIxWG1mTFVjbE9GNk9WbDdNdmVpYmZnM1BEVi9WNGFBUkVDdmpIYXdnYXNK?=
 =?utf-8?B?M0ZRUUpTTmI4YTBUeW5TOWszR2pmbGIwVVVmVUY0TW9lUkRJVmpWN3JZSnRO?=
 =?utf-8?B?aTZWQW9ESUs3ZWpCczdkTDMrTTdJTlpGcUVMa1c5SjhnWXlkNWR2dTN5ZC9Y?=
 =?utf-8?B?SDc3ZTN1bzFjSDFuUjNaUGJhL3g3VWMxNitaaVVBMzlXUG5DcnM2T2NzTnhm?=
 =?utf-8?B?YjEwMnVVajBBRzhDaHMwMllVWHpoOEJOblZ2Tmpvd1NjMXdINEtUM3ZBUkRh?=
 =?utf-8?B?bVp4WWplM2szM1RDZ09sTTBQSTFsemFuSGpNL3E5a1RDNWFtSUFUeGNZUHJz?=
 =?utf-8?B?RURVUlE2RElYUFFMZFNYOU5ISkozeXFXSU9KTDd5OGsxMXZzWW5KaDJCWFcr?=
 =?utf-8?B?WVhxVk9VQ2IzdmtLUTY5cHo5Rk5tYzBzb1dMdldHM3lnVWIzVjdIYllKV0sw?=
 =?utf-8?B?dzhvVnlEeXR5M0ZOWGpYRm1mQUxhMTY0eXJHem56U2loUm9hOEkzMG9lK24w?=
 =?utf-8?B?YjIvOW5TbzMxakJDRjhqZzVybjFGQk10N25vQTA3MzJ4VEdoSWlDQ2RqeHVL?=
 =?utf-8?B?eVA2c05EemhDVlpRYmIxNlIybW45bGNSV3MwMGRBVldKdmh2NDAxKy9PNTBi?=
 =?utf-8?B?cFJQR2kzcEwvcjJ1N2I3SVA0WWprOUlHaEtKZTFpaXFXZWo2L1Y3clF1WmU0?=
 =?utf-8?B?aVNhWHc2ZUZPUTdmeXJ4dEtEdU5lZUVDdmkyOTB0d0NCazZZYUUwYXpsc0h5?=
 =?utf-8?B?L3NwZHNXRVpLV21lK0doS2RSVkwySjhybzB3YmFnU3VrTVpXTXBBY2w2L2xE?=
 =?utf-8?B?OFZGYWhpMnVUUkRTd2RCS3JLWnA3YTV6TlcvemF6NmJDbEROa3pITExZL3dv?=
 =?utf-8?B?R0s0Ny9RbTk0eU5yKzhUbnNhSW9Vcng2dUw4UkltV3BQeVJ6cW9TVmNSMkxs?=
 =?utf-8?B?ZlN2dENYNHpES1QrazI4eXc1cUszRlBFdUU4aG5TY2lOZ21YS1BwU1lpQzFZ?=
 =?utf-8?Q?UfagX5033MWTA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nzk5eHIvclFwR3JReWJiRS84T0FURFpkOXhjUldsWGFvWXpHZS9zS3ZzaDRS?=
 =?utf-8?B?VzgyeTZCT2lqcXRranJiV3gxelNUanFsa2x2eFE1bzg4a3l2L2RIeHNBamtG?=
 =?utf-8?B?ZEZJMHRrdkhpRW5waHV3UnBPL1FZdVhZOWpuUi9CMHZqaktJTG56Q1NVQ3FR?=
 =?utf-8?B?a1BGM1dLa1RhWnVyOVVxWHEvQnNiNHZqc2NTN0NvWVdVQ3V1M2cyV3pjUUZz?=
 =?utf-8?B?Q1pxOTI2UU1kbWxxWXBOOEN5V1NmN3V3S1ZzNUtLVnVuT2IzQWV3b0t6ek1l?=
 =?utf-8?B?RzF5VHN6KzdWUGxZRlVFaFdaa21WU3VlMEVyMVpJVkxESWhUeThnTDJJemha?=
 =?utf-8?B?KzZZWGhDeldBSzBtVVc0cUhDa2xkZVZzZHV3SS8zM2ZiVVVnOWl0aUtKUEtI?=
 =?utf-8?B?dzQ5RmtxSEhlN09VYnd6UkVrVlhBVHhZNlBwQU85NFlnMTJlQkI1aHFCYkk1?=
 =?utf-8?B?a3k5bFZGaEpaaWtkQTZNZS94VFVUWmlkY1lUNC9UKy90OXRKT21GcFJETTRX?=
 =?utf-8?B?aTd2QnlCbFE2VXV5UjhkS1pWQUdiZ3BKZkdSb21pb2QzUWFsbWMrNklDSCt1?=
 =?utf-8?B?d2pzMjhSMmR0Uk5KcFBHWWtnQ3NFVUJMNXFuOTlBUXkzZy8zbStPV3NmV1ha?=
 =?utf-8?B?dERHVWRTQ1Awa3pJYkZ1STRhWW00SlZXSVYvclRyR3VWWVVib3pleUF1WlBu?=
 =?utf-8?B?bFJhQ3BEZ0p1WkdidmxHR2ZkVk93bEExNGQ3Mk16TXNiakxkMTZ4d0YzODlS?=
 =?utf-8?B?MWpJcDZBYVVSTDNsenpCalBNeVVNTmV4QUhiSThDMlhyVTFITDg3RHhPbmIx?=
 =?utf-8?B?cWRYSk1OYyt3VnJGQk5udjY5Zzd6V0RFSVBneWxNVEVXRG94TVYwZUJCWE9x?=
 =?utf-8?B?ZSttWC9Hd2haMHpCelJOM1B6WURjOVBrUUpwL0dWLzREV3JhK0h2MTduZExO?=
 =?utf-8?B?WVFrZmh4SUNKN3lPdHdsVzAxVThyYVA2dVAwQU9HQmh3WG40cW10Z2hLVTM2?=
 =?utf-8?B?QXRxMWFpS24yM3Rwa3BWVFdSU2UyNGpraU9xbmc5dCtqN0xJQzgycmFCVVpy?=
 =?utf-8?B?WEQxbVFkSDBYdmhyNU44TXVOdk1hMHNKMEMrOUVLcWNNRlJPa3lsSWo2Tk1t?=
 =?utf-8?B?SzhDckVqZDN5N0hiODVHWDg0azM2cGZuNWVuVmQrWisrbU1rbndCL1VrMmdi?=
 =?utf-8?B?Vnh5STZDSkN2ckJ5MjlDbkF4QnFDR0ptUVQwRWgwMGIwOGZmVkxWb1NJaTA0?=
 =?utf-8?B?dHVpVnl1dERBLzBEZDlnY0pFY2NqS3dCRzROSmlOd1hhTk0yM2d5enRlQmZM?=
 =?utf-8?B?a21HVE95MVBxWUZDL005cW5UdVg5NXg1Rm9qZXM4L0V4VFVObi92cm9nVTli?=
 =?utf-8?B?SWlnQnFJT3dQNHYySHhwM1J5SHVXcjQ1eXdDYTJJZnJYRC9lZ2dYcWlCU0Rt?=
 =?utf-8?B?Zm5RUmsvVS82SUFRWVBTSU84VXhkcEI2Mm1Td0FvRFBtQ2kvdWxSSnpYdlla?=
 =?utf-8?B?S1RBMFRTeS81ZUdsZThKRWQ3Ump3V3hDTEZHcGtMUVhadXBCMm16MVV4Ulcx?=
 =?utf-8?B?WVpodkFXRW84b2pXUTk0dk9vZVpzNExzeGx3NlV2bmdHN2h3bTJYOU51RWQ5?=
 =?utf-8?B?Vm5QQjdwZmdIamYvODhLeTVEWmpUbjRTMjVHTWhXKzByb2pQMTB0a0VYUFVk?=
 =?utf-8?B?d3dJdXN5T01aY2NsUFRzL2NmWkxScE05Z0U4T2NhSE1IcGdrOUdUcU9pMy9Q?=
 =?utf-8?B?OGQ3UWhEaG5jaG0vNUhvQVhMZFUxb21qWTRiN0pFOEhjUmw5QTNmYzFOZ2kr?=
 =?utf-8?B?a1RYdUp5dFZKUi8vanlvOEt2VzVwWUVmNFRyTnNzSEtkK1pGTWdCV3h1VFZC?=
 =?utf-8?B?dmpSb0Vtd2gwUUN3V0pOZEtjYytjcFQ5VU8rbk1lMFQ2RE9ybGh6bkNKMFNY?=
 =?utf-8?B?bldrSkxkeC85V1JxK3lNeTJxTkhoanBsUWJOdUtpSW9XcUpnbndRU1RiYWs3?=
 =?utf-8?B?UmE5VEFyZWhGUm9JL1pRWis3TzdOT09Pdjc3YUtGdGVLQ1RFR3E3OC9xTnli?=
 =?utf-8?B?TTJ5Q3kxc2tQWjFaN3dBU1ZHR2ZYcFFpY1RBVi93MW1wR1NKeWQzSkE3cFB4?=
 =?utf-8?B?NE9tVFIvblNoL2hxQWN3Ui9vVzFoVklqdDU4UndTUDV1TVc5dURmc0VMU1pJ?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bae8f62-f328-4760-d9f6-08dd62347383
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:39:17.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDR4OX/o+ks9j/uJBxrkuBBN17OliooX3pF8Ur214YRqC2DVVbwY9exW3nqJ7ZXYD3jOrEjEDsIxWgYMKAHh1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

On Tue, Mar 11, 2025 at 04:03:57PM +0800, Abdul Rahim, Faizal wrote:
> On 7/3/2025 11:02 pm, Vladimir Oltean wrote:
> > How do you and Faizal plan to serialize your changes on these flags?
> > You delete IGC_FLAG_TSN_LEGACY_ENABLED and he adds
> > IGC_FLAG_TSN_PREEMPT_ENABLED.
> 
> From what I’ve experienced before, when there’s a conflict like this, the
> Intel maintainer handles it and gets both authors to review the resolution
> (this has happened to both of us before) before they proceed to submit the
> patch.
> 
> But if one patch gets merged first, the other person can just rebase and
> submit a new version ?

Yes, rebasing after the other's patch is merged works just fine. I was
asking if you had decided which one should go in first just to avoid any
ambiguity, but if the answer is 'any', that is also fine.

