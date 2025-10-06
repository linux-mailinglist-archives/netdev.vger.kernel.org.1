Return-Path: <netdev+bounces-227978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7871ABBE7AF
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 17:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328083A9935
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD22D7390;
	Mon,  6 Oct 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="JZW4Xu0q"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020102.outbound.protection.outlook.com [40.93.198.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FB288537;
	Mon,  6 Oct 2025 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764277; cv=fail; b=R02tTaUDif8t9n+aflXoO/1wPP28q0/OHjZxYzuFx0dBO+m+tHrMWNIVFAYGl+cvDJcW1HYtIIDvGDbOK7FnSVPaPXa3+NbmflsMnB+L84Gl6evnONWk2bD2S40paOz6jXluGF6TQxFUF2Qspdd7GtUiQ1hBg9DwdG5mzTKraB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764277; c=relaxed/simple;
	bh=jbqOKFbzZO+h6Fu8hv+/fGAuq6041PWOtzGextcfO5E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H6BuPsKiJddCje7k9xqowjd4kQfhpFzJcw0RLGS5SjbVpdDOoJRxFEfopgFFdv9o0vJTbY8mN6zRtTqSqBB1O9e51kx5CBFE7AfnKIRSi40xbmsGcpkLN8xclXnuCrwhUK5z7w/204Oz1qzwzfaA3fKo/AF3bxvD2UlYdl6wUdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=JZW4Xu0q reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.198.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsJ8cS0B9dDvXZBtDHKwdwhl4HmssTL+lPnMftPSMZL87ndQ01RmCILNx0r0jGqCLJnNdosIuDMmoahRl8P1sUMWlP452M4Z0afXr3x4gdN389zg/gEJhWE5D+qR1e4MMcYcMFM945XArFE7NOeuTWjxMHuDwjbd15ioQIodNemSkqPsoC8PDtCwc4CH3QMYlHRJ3THIc+pO9OXxOWlp5Bt6VN+IdA2TnuXyzW4jpP6xlb1RX7sYO9RAMN9SmW7P+L9xerZ78wDVtB9yJX0qkNFnvxmaRMw6Q5VgVYpddfNfeX6RGuUYJhiUUVBfz00sMM8IayVGuJAVyzM9U6UD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEMPbHCxEgDtlrzp2KrJ/W+TW8IDicBPnvgObyJBH5Y=;
 b=sWHnH3/Qp/mUx1JUZxnaI+c7HmE7BixGco96yX265ZqvzZmgnkR2fQBwa6Vwr7/bqCCQXfcnlJBxdRBjOKJBPCtLmKH90l3YjDRt1cPkgCeJF1cbDLWnK9bmkRyI12KlgZlq9bGTHLMZvsPBwqXQWtNwVvCESsbTo2jFl/mWd+mAkSP+PVW5JevWs+ZbKPmfgyxw5xu9bUlBwR6TCmmOJCRqcAg499hYUrrNjcx6/94QpV5EIvHL0Him0EbsRBc4/3DXm/dWvT8ZkP6ZcrRS36eOxeU66K3Cic6ETEy6S+niE7a4+QYcPuPNJP7KaD2nwxgEvPHsM0UxtgjD7mgIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEMPbHCxEgDtlrzp2KrJ/W+TW8IDicBPnvgObyJBH5Y=;
 b=JZW4Xu0qOxAHSigp2Ru8idI8/+umeNcgcLQzrTYkeRhGRXH67ONsaZPxKBeXZ0ae7uFSRao3aWrA/zp1CTHX7xvlVMqu8YHGtwJtSoZXVLWAK5s+GKo/5ZfZc/9K31wrGudiPOltKvnFyy67lbLok1SS1JnYSpKK5/P5ItKDij4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ2PR01MB7981.prod.exchangelabs.com (2603:10b6:a03:4c3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Mon, 6 Oct 2025 15:24:26 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 15:24:25 +0000
Message-ID: <fe645202-9e00-4968-9aea-8680271a2067@amperemail.onmicrosoft.com>
Date: Mon, 6 Oct 2025 11:24:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v29 1/3] mailbox: add callback function for rx
 buffer allocation
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-2-admiyo@os.amperecomputing.com>
 <5dacc0c7-0399-4363-ba9c-944a95afab20@amperemail.onmicrosoft.com>
 <CABb+yY3T6LdPoGysNAyNr_EgCAcq2Vxz3V1ReDgF_fGYcqRrbw@mail.gmail.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <CABb+yY3T6LdPoGysNAyNr_EgCAcq2Vxz3V1ReDgF_fGYcqRrbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:208:234::30) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ2PR01MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc4cb2e-1477-4d7c-4470-08de04ec6f28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3VkWi83OVN2N0dzbDUvZ2xnVVZVVHQwQStiQnptSWcvWUtIYlVkdVZrQU14?=
 =?utf-8?B?THkrTkxBZjNPYktxa1dkYUxHcG1QZWhZU2hObXBzdlJwOWFNZGJiNlhaQkEr?=
 =?utf-8?B?djlNeGVVNTByY2RoTko0QkRMWVBaTHJzMUVMRTZNbnVjNDRtZ3pPUk5PczI4?=
 =?utf-8?B?RndNakxvWFMrWUoxN05UTHYyZm1IZ0RVcVBKQkZVWTFpSmJMTy9CaUpJdUw5?=
 =?utf-8?B?aWFmK05FeW51OUd1bHA0R1UyRnZRSWVNUnVFMzZ4bnBCZGl1VkF2ZmtRb3A5?=
 =?utf-8?B?WS80aWs0M1pCV05ETnM4VlNxTElQekpjb0diYkZFblJoWFlzSjJ5MWJYR1lG?=
 =?utf-8?B?UHhKVE84c2VRR0VIK1N3bHJkNTNIamlXWmEvZE1mQ1o0dythYVRMNkZ1QTdT?=
 =?utf-8?B?MmthVU5leWpMaG9hdjBLdUwza0ZHallmY3B3YzNFTm5vT2NWRDh2NXl6TVB3?=
 =?utf-8?B?eEczSmIrWm1aanJ4Ly9FN28yT1RSZkhqOS9Ua0t3OFpub2JTSC9oSU5sTkJN?=
 =?utf-8?B?Smh3c2Z4dFZPS0tBeGNWTWlKeWFvWEdYVWZ1bnpPVVlLbW5WK3B6NUlwZENh?=
 =?utf-8?B?NzhyZFYrU1FqNGxEakhMbGRMKzJRV1U5RDF6d05WZkJaQ05Fcm9ocG9mT2FJ?=
 =?utf-8?B?OURoMGlYK2U3V2dSTTFJQzl4SFlpZUJJVFo1RkFqZTNpMHNVcDJ4OE55OTFH?=
 =?utf-8?B?UTdqdUFlV3lldlJLRUswVDV5WlB2VkR5ZUJCb2N4OFJuRmhvYjRBZVo2Zm5G?=
 =?utf-8?B?N29mMTBzQTNiNHdYNWxLUGxDNjIvNGMraFYvTlU1UWdGNnhKUnRMMXpYdmlo?=
 =?utf-8?B?S0ZpOUNKNThIOElmaEJXRXdiN3hVZDFqbzFXb3FQMldDc1p1Qy9wSTlTc3ZY?=
 =?utf-8?B?cDhLaU5pTEdkVlFDd0c3RFpoNGFRNUVXeVM0NGw3OHBkQTgySzRTN2VMMG1y?=
 =?utf-8?B?QkRnMmt6aklCQTlMcDY2WXRzLzI4SkwrM1VIdE5aWFFTbXozUU9GKzRBdmlV?=
 =?utf-8?B?ZFFGOHlad2pzQm1TbDN3SUhtZ2c0ZFN4QUdqUXNqYVYyY2s4VHdEQUZRVlVS?=
 =?utf-8?B?cm9OVzduUGp5U2FqWTMwR3ppQ3gyN2xBUnk1T1JITDRMUktvdUpFWjQ3TDBu?=
 =?utf-8?B?SGZoTXRMZUtZcUxJVjVoTytrZy9YYytLb0tJQ0lZT3JwS29aVDhpeEJpY2NP?=
 =?utf-8?B?TGdXQXpUYUtoMnkyZkh4bmF1SXBWbzB5R0N5aXNKNGM1ZVArOXVkaVZ3SnNx?=
 =?utf-8?B?Rm9zSXB6UWF0Q1phZGRQdmJIOWkyTDFEV0VFS254NUpEWHNiV0haSm96ZDV3?=
 =?utf-8?B?QTQ1TmVablZoUXF0OTlyd3pWZ1Vaa3UwT25HM1l0bDN4OWpiVk1XS0tkb3N2?=
 =?utf-8?B?dUErMzhWMWtYQkFObG9TTnJJRmVmcWIwdWo5a3Fyd0tuU3pvc2pEbHVSQXVj?=
 =?utf-8?B?RTlzQUhIbkNFNjhwWUtSZmwrVnFOWkNsMEo2V2pGbXIzNno5azJNeGtKN2t2?=
 =?utf-8?B?NStrKzl2bmQvR3d2THQ3SGFTR3V3Rlk1U0tCSVMxby9DakcydFFmdk9ZVlFP?=
 =?utf-8?B?amhHUm9NU3pzdzZjT1F4eVBnU1JtNWRWakJFTTVKUElTNTJsWnV0bmR3dGQz?=
 =?utf-8?B?OHczWFdWZ0U0T21XWE5STWcwTFB0YTdSV3pWRDIyNUFJeUJubWVUUXM2aDBk?=
 =?utf-8?B?WTBHa050WHJyRm1JTC8rN3h3RTlmb2Q2ejd6ei9BMlVnTXB6K2NscGUxUW5r?=
 =?utf-8?B?aGg0Rm5hbEZ2K0lscGs5OGZXUVVqblhHT3VKbFptMlZNRVErSHJMdW9mRDJH?=
 =?utf-8?B?eVJqdm16amEzdDVJZmlubVBvN09sUkg5cU51Z1VYVEwvb0hjY01COWErY0RS?=
 =?utf-8?B?ZlQrdFRKRXFiL2NxNnpGQXVEWXR1Y2w1VXlZZjF2UFM5M1QvbXJmSFJ6eUNW?=
 =?utf-8?Q?gyZHo+vd4VY0EoHDhtdkZt6hmCl9s6it?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXQ1RzQrbTdRd1dXSWdmRjBnTVQycXRXQ3dydzRvUlpreGNQbzdGZkg1L2xX?=
 =?utf-8?B?UFVkRmtrV2JWY0pDTHAxN2xIWXFUZHpvb1F0QVduWDhFNkJST21aRmFpOXJl?=
 =?utf-8?B?aWg1ZlZ5eVo4OUVvTXJ0Z05RSWtWaGxvSHgvYTgwSGxielZnakFLeGQ2bnpF?=
 =?utf-8?B?dUxpMENYMkRTOUFSVWpxVjdSa0tGQXdFQXZJZEhkMHE2VjBIUFhzVDFIY0dE?=
 =?utf-8?B?MlNVTUQxVUxHWHU3MmNNb3NlYlNTU0RmcFREZERxMlBla2xHbGdzV2hmVGNj?=
 =?utf-8?B?dTRIVmFQKzNTUE43ajJya1pBYzNlYmIwVDA1d2JLc3pGOXhKQ0ErdDV2amJz?=
 =?utf-8?B?RzUydGxhSFVrVmR5KzhWUDRMSVh0bS8wUE10MmJ5SldTTGZRbU5MS2NMb05y?=
 =?utf-8?B?cFlyU1BTWDRLWjVEZmZpdkxZd2ZFcmdKVWp5YXM3bjM4U293eWdERkkvNW9H?=
 =?utf-8?B?b2JDL2hFMDR0R0RXY0x0UlIzYkhWT3ZxN3FqQjl0WHAzR3Z0ai9PV2RCUkp2?=
 =?utf-8?B?czlySGlQaGllUGVzZ3pod0ZFSlhIMkJuaFdQNE5oTWcxSEtHT0ZVMUhOam91?=
 =?utf-8?B?UWVZUlkwRmVvVkFVYWlYS0UzWTRKSWw5eWxQbnZyUmhQOEE2RjkwU0l4N0Qr?=
 =?utf-8?B?dmZ2L2xueDFNSmE3dldlKys3eFRxS1lsT3lodkVUUDRNVlJxR0FnMG5JU1Jy?=
 =?utf-8?B?Ykd6TUtrRU5zanVJUXQrVzRMd2lzL2YrajFtQ2hDdFlYbzlMaS9kMFM0SDhV?=
 =?utf-8?B?eWFlc29IeWRHakVqZzhzMWE5Um5xYitqL0xYZzdEYXVSdUs4M2xmRVNyUng0?=
 =?utf-8?B?UGxHcGNJZlUvSnorY041QmFSbml3Um1xQlVzNWt5eEduNlBRb2IxVHpibEtP?=
 =?utf-8?B?MVVwVWEzMjVEZDVIWTc3Z29Tc2dwQnRwZUJabzdEV1lpS1dIREh2NTVTTi9y?=
 =?utf-8?B?V04wUHhXVmQ3OUI3L2dxeDV0cnBKSTJVcmRnVGR2NWZGU3BlNUFaajVuT2xy?=
 =?utf-8?B?aERoSjFMWit6SnVRMWxYYndvSmc4SDhhdVptVlNUelE1d3Ayamltd0twT0xv?=
 =?utf-8?B?YkhjT3lodnhva0VVU3RKZ0tMZWZZT3FkTUFPN21aRmpsYzAxZWJpVVF2N3Ni?=
 =?utf-8?B?OEhWZFdnT1FwWW92MjJQVDFGclFKU1lEMURXdUh3TXdKTXpza0kxdmhwWVFj?=
 =?utf-8?B?U3grVFZzWXlzWHlEUm1uYXVFL2dqK1RaelB2STBadFBGdmZqWnNQazlSSVBP?=
 =?utf-8?B?MUY0VjFQczI2K0VsVlpMclc1L1FraTZFN29BSmZ4SnhBV29VdDIzblpaWnoy?=
 =?utf-8?B?VzZmSWVFaWppS1lBZnY5ODlvUFE0NzlIUjJDZlgxVnVidUUwcWRPNC9GOXhX?=
 =?utf-8?B?TFNzVUd4RkYzSjB0RW1CVmJwVHFuVGx4OXA4LytZU3I2MmdSejJJdlVuUEJF?=
 =?utf-8?B?cHQ5MzFUdnNEKy9YQ0JmK2QxdEJTVE82dE1makxTVmF6a2djVXMyOXRHNzB2?=
 =?utf-8?B?a3JsYktSdWM5VW5OT3FzNEwwdjhwTkdNZ3VpQjRBS25WYzRZQzlpQUF3N2pG?=
 =?utf-8?B?dCtjcmp5SXRPK0Y5OWpUUDNjN09Zd0pHMHphRjdSb1BVNm52cDFTdnNVQk9n?=
 =?utf-8?B?U24vanVKNWk5bENkZ3h2YXB0NmdtSnEwdVgrWWYyd0o1dDNic3hCaFd0SGI0?=
 =?utf-8?B?T1RlTFB4TzBpV1R4bnNMSEpKc1VvZERwUm5GSkh0dFM5cFR4L1hqalhvMTNm?=
 =?utf-8?B?ZHVKb04vNWIwS0gwdTZzWThkb1VKQlM0L3dBSVZKTEIvTnR6UDZ5M3UxWGhP?=
 =?utf-8?B?Y1g5aXpqZGlhNFMwYUM2OCt5VkpwVGQ2aU5pUk1rQU9qaXAxM2ZYbG0vS1J5?=
 =?utf-8?B?am55ZFFnaFdYaUVNWWIvN3FDZEx2QmRhMlJ1dkFnRlNoMCtIWXRzWXY0a2pF?=
 =?utf-8?B?NSs1RXlqK3NZeitLSkRDWnhRN0NNTjhMelJmaTNBVmZ3U3NVaWZuT1BTdk9S?=
 =?utf-8?B?NlV0dkdLWDgyMnFGN1JQdkNpeElhSU1CeUIwbEcrMC8wcTNESHVqT1ovUXov?=
 =?utf-8?B?SkRyVXpaOEdtY1c4QjJUTFl4WE5qNTk1QjlaTG5UWHl0dHdnZThhb1pDTC80?=
 =?utf-8?B?cUkxWkJXcHpjRkYrcktlNExiYUd5YTNjOUpEamhFSWF4QVdVbHpuMXBFcWVO?=
 =?utf-8?B?akVGOWNjRHBhMy9KT0Y1U1BQa0FZcU5IL3NLR0h2czR2enp0TEJ0SXF4Z1hC?=
 =?utf-8?Q?Xc4Q2JHz32Ood+4VgQoPx1PrvaB1gZSwvj8+3ZQ9U0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc4cb2e-1477-4d7c-4470-08de04ec6f28
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:24:25.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4TEfktacNM7IBfHRYPJ/nIY3j+js1FUnBthth3seJgcP9ckdKrIqKb6jAmPJJ1s8GaUTV+WIPIkkiZm7zLd1BzTxaRnP2Y8ABt4PZWaTQXLZXEF485GlkkAzPz3DTWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB7981


On 10/5/25 19:34, Jassi Brar wrote:
> On Sun, Oct 5, 2025 at 12:13 AM Adam Young
> <admiyo@amperemail.onmicrosoft.com> wrote:
>> Jassi, this one needs your attention specifically.
>>
>> Do you have an issue with adding this callback?  I think it will add an
>> important ability to the receive path for the mailbox API: letting the
>> client driver specify how to allocate the memory that the message is
>> coming in.  For general purpose mechanisms like PCC, this is essential:
>> the mailbox cannot know all of the different formats that the drivers
>> are going to require.  For example, the same system might have MPAM
>> (Memory Protection) and MCTP (Network Protocol) driven by the same PCC
>> Mailbox.
>>
> Looking at the existing code, I am not even sure if rx_alloc() is needed at all.
>
> Let me explain...
> 1) write_response, via rx_alloc, is basically asking the client to
> allocate a buffer of length parsed from the pcc header in shmem.
Yes, that is exactly what it is doing.  Write response encapsulates the 
PCC specific logic for extracting the message length from the shared 
buffer.  Anything using an extended memory (type 3 or 4) PCC channel is 
going to have to do this logic.
> 2) write_response is called from isr and even before the
> mbox_chan_received_data() call.
Yes. Specifically, it is marshalling the data from the shared buffer 
into kernel space.  This is logic that every single PCC driver needs to 
do.  It should be put in  common code.
>
> Why can't you get rid of write_response() and simply call
>      mbox_chan_received_data(chan, pchan->chan.shmem)
> for the client to allocate and memcpy_fromio itself?

Moving write_response into the client and out of the mailbox means that 
it has to be implemented properly on every driver, leading to 
cut-and-paste errors.

So, yes, I can do that, but then every single driver that needs to use 
the pcc mailbox has to do the exact same code.  This is the first Type 
3/4 PCC driver to use extended memory, and thus it needs to implement 
new logic.  That logic is to make sure  we have proper serialized access 
to the shared buffer.  It is this kind of access that the mailbox API is 
well designed to provide:  if both sides follow the protocol, it will 
only deliver a single message at a time.  If we move the logic out of 
the mailbox, we end up duplicating the serialization code in the client 
driver.  I could make a helper function for it, but we are getting to 
the point, then, where the mailbox API is not very useful.   If we are 
going to have an abstraction like this (and I think we should) then we 
should use it.

We have more drivers like this coming.  There is code that is going to 
be non-PCC, but really PCC like that will need an MCTP driver.  That 
driver will also need to allocate an sk_buff for receiving the  
data.  There is also MPAM code that will use the PCC driver and a type3  
(extended memory) channel.  The mailbox API, in order to be more 
generally useful, should allow for swapping the memory allocation scheme 
between different clients of the same mailbox.  Then the mailbox layer 
is responsible for handling the mailboxes, and the clients are 
domain-specific code.


> Ideally, the client should have the buffer pre-allocated and only have
> to copy the data into it, but even if not it will still not be worse
> than what you currently have.
>
> -jassi

