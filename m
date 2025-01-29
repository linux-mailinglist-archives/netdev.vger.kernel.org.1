Return-Path: <netdev+bounces-161451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECA4A2180A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 08:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4F1188129D
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5CA192B8F;
	Wed, 29 Jan 2025 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="T1Bsfo5g"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022112.outbound.protection.outlook.com [52.101.66.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4B192B85
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135481; cv=fail; b=Wg+DrDDP/q9/3eYhNMkqjwfuT3flyeAWrrsc9PxlZ2xOQv/GBxLFCWRNjGhEhYQZQA951peYTvv9RzzOYVfUim0Bc2bqULxFoQFFHxZJP9cswtoePGSVnWTDgR5GNr9Whet85VEFoh9OR0RgC+MKJVHcLQAXMU0QWPlz5dvOdm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135481; c=relaxed/simple;
	bh=f/eOJFfXR4+cUvfuZn8bllqZLsCBHzOzW2sTXdgZ8/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YndYwGKLJeeAInelgVLBtR4Ih8XNk1mtIBs83/FGL/pDC4u1HGZF1LkI3ZZ5uNCacqDdHdYC49pdZExXchyl5hqTAkbkgThdkjGqAebZgC2nHqO1Ca2Fnwy15Ub8ZAYhB1SE0B7xnRxGm9zDMDn/AB/AvwYbkaIq4ejnNpfTXd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=T1Bsfo5g; arc=fail smtp.client-ip=52.101.66.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGhoDqnwQEI6VLN+DgsvtyvNrJKZhEEGItJ6zcg9O7FSaB69HlxVNi5Lkn3aa9pnQFqpZT1Hzn0sJCal+JDDpZf91X3py4jKOT+LcIXyFsn4CpmY4m+zHAbqCNfzoZhk7RHd1+TJvA/UtCvR/85WfFjJmLpHxlF9Co5aFJMuLZqZTPxGQsG1ANvnA0qXheWzv4IjhUIv/YNMwGQWInK5ptczg0+wnPZmuKH3zfMSXK/FX+zJpDappOQ4uSRCcp/zsojj9VwhmkzuKTvm35cD3Uf/MYDCtRRCgOxbuYwiLzRb6hNVFE3n8+0GFXnjekit/8InjOONj6yj+A/hekl52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osoQirmXLN/wlF1ehWKP68C692oKLfsyhlRpicdS8Vc=;
 b=oYQDedUhPzQEiaHXyzNeYA+GiHEOtYi/fCAX4CwfCm3K1SZokS/dtZ3rDl9Ltbvz1dIEqKrW0ujkkf/cbruFOzHd4AIocmb2wwGfbrAilX5j8lbIMz7+kTg/na+ly85Eb8KDvPoryFfyVa8kdDFCU5pwFeQdVpKime1Exh2KYpqHg2/4jTpWVBx6oUNSIyfAkL4XWYATBQVr0DEhPXcm5qy/WZMzHd24C0APrC4IXEXMjcFitY2++t5FD25/KiDwk9o3AlL29klmD56L6KSKm0nb5ADXNEmVsxvqhrGR+q9diu1uRc09kfXZI8NjC7+vJr+uI2VitCPTzghQ+qY2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osoQirmXLN/wlF1ehWKP68C692oKLfsyhlRpicdS8Vc=;
 b=T1Bsfo5g0E7RW0iljCOaUm1rMPz5tbph5cr7DUW1CQW3CpC7Rh/qTgdTBvbqwKsX9HVUGjdAI3iqvGQFuNG0yglJOc1+WzkFHRat1yh4FPAwlKv1t1QgknJ7/pQdw0Z+fDQWkRjqWKE1X8BD81uK2crooHf1r3+BtC0ItG2qpME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::14)
 by AS8PR10MB7255.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:618::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.13; Wed, 29 Jan
 2025 07:24:35 +0000
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95c1:ff1e:275d:26aa]) by AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95c1:ff1e:275d:26aa%4]) with mapi id 15.20.8398.013; Wed, 29 Jan 2025
 07:24:34 +0000
Message-ID: <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
Date: Wed, 29 Jan 2025 08:24:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9477 HSR Offloading
To: Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Lukasz Majewski <lukma@denx.de>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4f2::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB5671:EE_|AS8PR10MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6034e0-5e51-495e-53c1-08dd4035fb21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTF4VUFNK21rd2lxRTBadjh3dHIwQVF6aW8zMGFRM0MyT3dlaHNYWURYTkti?=
 =?utf-8?B?TnlLZDh3VVNrUEdQRmpnZE81OWdwcHpQdkJqcTVwZUxLRFRlbnNPb1Mra1dm?=
 =?utf-8?B?eER1akpjUitlK1RhYTlSUlhVRnJHdWRReFJNdFRPdXIxZmN4Uyt4eVRYVU83?=
 =?utf-8?B?dDlqZHN2b0VKVUZRNkJibm5SeFV5ZXhXZGsvQ1didXAxZUoxZzZINnVkU0gv?=
 =?utf-8?B?d1lWWjNnK2xQYklST2hlWDh4T1VuaEszTTdoSkNvVDBKT09IOWoxL1NFM0hT?=
 =?utf-8?B?ejFDZFVCRXB1Y1ErdW5JSm9PaTFWdHpvNXBqWUlyUWhnY29DTFNWazZINUpk?=
 =?utf-8?B?RVR0NUNObGRmU2FtdFdpMGVjeE9NOHJjTktRMzJxM2FFY1FCeVA4YWRHVzRo?=
 =?utf-8?B?dXBPNTNZdXJzWW9iMERGWkM5NG53VW5WN0dqaktKU1g0SVBlVzhNcUhGRHhK?=
 =?utf-8?B?TG1wcldxZWZHWGlYUjd6dGYwQnRXdVFXbys3eUNCVGQ4UVNxUm9DVjBtUDEy?=
 =?utf-8?B?bk03NlA4QzhZckNWbjFOVjczUFE3RXpVQVNHTzlSRHlZODVtdEg5UE5veGhi?=
 =?utf-8?B?NlB0blRUdDUvSmtqbHBaY2dlUlRTVzkveHJBTmJaMXdhWVpmWlpqeUplQVVn?=
 =?utf-8?B?aWRyV2JQODZPQVdha25LRzcwNEFnOUlieHlPRUNXSE9BbEJMWU4yVWxIdm5W?=
 =?utf-8?B?QUtsR3dvRDFrdlluN0lXS2I4bHRzREtwejZEZTFIWHlaUFJqSDhybXRBbW9H?=
 =?utf-8?B?SXY1SjU4U0dmVDF4cVpzSHIwNkRNbkd2Unl1RVJMRDJrTE44SnlabVVUQU11?=
 =?utf-8?B?QkdqV2F5TkhwdFRwUzJYd3VJOEg1cUViRmVSUkxQSEowTmxWYWNhdzZCbnJY?=
 =?utf-8?B?eGNvM2RaZDJQQTA5cGxBL0kyR2Q1NkNQK09SWWNpWDZMVmVKQi9mTmdMZ01E?=
 =?utf-8?B?R2NLZ1lhYlV0cUs0Q2JMYnJMVHdyNWtuTG52WU5wb1ZHTStzcUkxNEg3YlJP?=
 =?utf-8?B?YmlJREl2Z2RwSkpXWUFnSUs2T1MrbFhzNm5OY0pBeUs3YUVINzA0N3NJNmRj?=
 =?utf-8?B?YjJMOHFFNFk0QzNYdjUvc2pvK3dzdWR0Wm5pN01VYmgwaGVkeStLdUM2NE40?=
 =?utf-8?B?eHN1cXRCZmVTdnZMeHhYY0pvY0E5eUk3RDBXQnZCbnNZZ0FWWWdSUkhaTjJO?=
 =?utf-8?B?K1dsVHExNDN0QVdPWkkzc29qSTF5RlVOMDhuSE9PbXNOSEtGdFZ1M2xMZzNE?=
 =?utf-8?B?b2NObTdoMmwxZHFhNHFObDBxSFl2WFNBcTQ1WkVRVXdYLzNrRkRXRzhCTVhz?=
 =?utf-8?B?d1RqT0RvWjBQdjNFeXlFN2szQ3loUmhmZ2RkdnlNUXB5Z2RVRlFzOUJMcEpr?=
 =?utf-8?B?UHllRDdJa214VGxXRU9ibVpwZXV2RjVJUDJEYXVWekJxUnZlWkgzU1pxcHBz?=
 =?utf-8?B?dzdXSVFleTV6cGJ1TndLZ3JlR0E0TVVxSE05UTNGMnZGb1dpR3JOK1IwZEdY?=
 =?utf-8?B?TGhUS01PSWhmeE04SVZ2dXFBajg3bHU2Qllnc054MkJ3MXRLMWFFYkwzblFq?=
 =?utf-8?B?OVV4bmlRVmtEOWxrRnVMZVZYOHphb2hRa3o2OUt5Q1RXZ1U2V2JmYk5ERzE1?=
 =?utf-8?B?dWk0ekRWcUhEWklrU3ByRTVsd0lYRGxMaHZaUVo3clMySHNZMjFlSzlkdm5N?=
 =?utf-8?B?WFlJeG96clNrdG80WDVzS1ZTUGhaMkIzNlZIOHRPbEZLdjcyUEtxQTZQcWg0?=
 =?utf-8?B?WTNFbkJDRHk4WWRkRmREVGN4SlgwY2xHY0xqMnBrYWZwamNQN21pSnFNM0t1?=
 =?utf-8?B?eDhtL1JaY0JuaHJLdGZBRlQxVjF1RTlNeEM3RVdhR2RnazRqaFhXNXo0V2Q5?=
 =?utf-8?Q?t6pU/NAkLvKei?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2xRRmRleFhyUFQzeW5jMForUFBISzE4Znl0ZlprUE9yaUxpajc0MytPaWhB?=
 =?utf-8?B?eVY5Q0hOUERuZnA5eUlGNndZS0I0M280c2xRZGdKTXBVR2NFUHBTdzJpZ1Nl?=
 =?utf-8?B?Rjd6VkM3ZXl1Y3VJT2tFK3NPSjFnMytyZHBYRkFGVm85dWU1d1llbWFTOVpJ?=
 =?utf-8?B?RkpmT09uL1Nic0tZRnRnUW5mR2J5OUpoZSt3MFAwOXl5NldLVGQyTDlkNFB0?=
 =?utf-8?B?ai9NU3Ntd0dGRlhEZjRWbzhKNWorSjlSejJYcWxkREZ4YzlVLzdxbXBPalhN?=
 =?utf-8?B?c2h4OGFTSjkxbXZZeWR2Y2p6NzhoQVNtYzZJOXJEbzdTMjAvUllvYnRwUFAz?=
 =?utf-8?B?VnI2YWUxZ1huNHFvU1BnVUFIZkxKZE1iaGgvZ09DNlovb1RYenVreHgrb2dk?=
 =?utf-8?B?Wll0L0FEQU56M1p3cko3dmZnY3d6WHErMnVYS0xISkdoeDgzbk5CaXpGbS9y?=
 =?utf-8?B?alQ3Ym1ld3dNUHhDRk5BdVBJSmdwS2xVTVhrMWhBcUpHNktqUk1HbEJMdndU?=
 =?utf-8?B?cjN6UDhGcWNqVWZzZGdydU45YisyOTNIdmp2M3h0dnJuS0R0cnFFTzdJd3dN?=
 =?utf-8?B?OFJMc0pDSlpGTzFaMkVDR0xRayt3OXg0QXRJdVZYUEF4SVJIVUQzZUFKR1Ji?=
 =?utf-8?B?YjcraWcyNTdDb0tmRXJTSzFSVFRkdTNNTGVPMWlaZkNJNHZLcXJKaGpjZUdI?=
 =?utf-8?B?ZjhoQ3ZBWmRSNXkyZmV0OTM2eWF1dFdiR0tZSEdHNWRNalhBdFFtcVg3VFp5?=
 =?utf-8?B?UWN6NDdScmc5SFFDWG1VY1k4VUJ5R3d6ZFpwa0hMSFZhRnhXMWJSZUhhKy84?=
 =?utf-8?B?VUx0YVV6VDQ5YjBoQVBKam4wRStJaEZTVGZOUUZVaDh6NnBNWnJqL1piZEQ0?=
 =?utf-8?B?aXJyMEd1SlVxS2lRQ0drZE5MYVUrYlpSSVpmWUdwS3BWeXd5OUticWdpVTJj?=
 =?utf-8?B?bHk1bTdJQ2ZhTSs5MDA1UzlGTmg5cktrTkU5d0NzNk5TQlZvZTBCM3FIbG1D?=
 =?utf-8?B?V2RTODVKeXJFTVA0L296MWFlNDl4NmNacDdXWW4zQWhIeTBlcW15bDNZYjNl?=
 =?utf-8?B?OXh2aE9QdG1XTmpmYjQvN1pWa2NSOGtza0RaNjY2cGs0Z3VrRTNkNktSY2d2?=
 =?utf-8?B?eDZqaDJpM0JPNHcxd25QZXNEOWE0NXJrKzM4SHdvZ0IydnFmZjJnT1AwMU5Q?=
 =?utf-8?B?WndjN1dLeFFqcFJNV2R3cFJYalEzb1JNcXlqcjMrcjZhdGFEV1JjK25mQWF3?=
 =?utf-8?B?M1RXNGVyRVBWbzIzOEtGdCtCNnhDUUxFQUtocFIxTWxHa040SkxRbGwxSG81?=
 =?utf-8?B?KzNhVnFDcDRwYkdOVWtmdVhwYmcxTzEwampCNTRPZVByL0s5ZXA2SU8yU1gr?=
 =?utf-8?B?REJkcjQvNTQ2L2l3NFU2MVp2SlNDY2FtR05GUFd2d2UrZkg5NTlQWEtiQWJ6?=
 =?utf-8?B?ckFaSzNUbGswRkhHYUpFZnVtV1Vzb1d5WnY3N3A5NmxqekVBcmx0NVgzMHBx?=
 =?utf-8?B?dy9FWnNPTDlBL0huQ0ZHU002M1lJL2ZJSXByajFIQWMzUnRvcmNmWlhyVUEz?=
 =?utf-8?B?bXUzd01KV1RrZlN6VUIwNnhkcHVxbHhsbU5aOE1jckxUWmtQc0M3S0JGVUNN?=
 =?utf-8?B?ZU1sTkYvWkRTSVU5QWpPRG84TXVoY1FWTFlWa3JEQjUwS3Ura3FHM1B6NEE4?=
 =?utf-8?B?OUhMaitPK3Z4cTlZYjFsOGh2bzl4NlVwV3JzK3F0bFZKT1NmeERIM09xeFFW?=
 =?utf-8?B?aFY4QU5WRDAwQjcrZXhmdURPQ2ZPckdPTlppQkwzYzRKTExVMXYxQlJxZzNX?=
 =?utf-8?B?SWZqT01VWFI4K0dmODVvaFdRNW9pQjE3b0krVC9Uam9ZSUJzSkN1REx6cnZ2?=
 =?utf-8?B?Y2o0cWhRU01wZGMzaGFrSTZUTjY1VTRwZU9jZHFaWERTUmFrbFpQSU9YM3Zz?=
 =?utf-8?B?S2RBRXFQVm8yNkNGei9JZE5kTG1TTmtvMU4rVnBsb0NUVVp5SG5ERDJUTDUx?=
 =?utf-8?B?bUpjdFVoalFtWFNIb2FvTFFCU0xWR2U5RmwvYUpzd2wxdDlGVFFMcFpSdmI4?=
 =?utf-8?B?bGhjN3lTSHpodEh4cDZ2bjNORllGYm4rdG85Z1dwekhnS2hacU1haFlYTzZk?=
 =?utf-8?B?UnEzWGRJU0w3Szd5RXo4bnYrVmJHS1duL2VsSE0zeUcyeG9EcUIzcG5VdWRv?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6034e0-5e51-495e-53c1-08dd4035fb21
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 07:24:34.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js10NVSXiOYy3FymJbg6ks13lgmAJlZXYESSd6HwxJ11M/vnPqXZWcSb8pk4pHAIIA9EUoUZlyBjrMvQad89bL+cKxrk8KvBbyuLFo9PmFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7255

Hi Andrew,

On 28.01.25 6:51 PM, Andrew Lunn wrote:
> On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf wrote:
>> Hi,
>>
>> I'm trying out HSR support on KSZ9477 with v6.12. My setup looks like this:
>>
>> +-------------+         +-------------+
>> |             |         |             |
>> |   Node A    |         |   Node D    |
>> |             |         |             |
>> |             |         |             |
>> | LAN1   LAN2 |         | LAN1   LAN2 |
>> +--+-------+--+         +--+------+---+
>>    |       |               |      |
>>    |       +---------------+      |
>>    |                              |
>>    |       +---------------+      |
>>    |       |               |      |
>> +--+-------+--+         +--+------+---+
>> | LAN1   LAN2 |         | LAN1   LAN2 |
>> |             |         |             |
>> |             |         |             |
>> |   Node B    |         |   Node C    |
>> |             |         |             |
>> +-------------+         +-------------+
>>
>> On each device the LAN1 and LAN2 are added as HSR slaves. Then I try to
>> do ping tests between each of the HSR interfaces.
>>
>> The result is that I can reach the neighboring nodes just fine, but I
>> can't reach the remote node that needs packages to be forwarded through
>> the other nodes. For example I can't ping from node A to C.
>>
>> I've tried to disable HW offloading in the driver and then everything
>> starts working.
>>
>> Is this a problem with HW offloading in the KSZ driver, or am I missing
>> something essential?
> 
> How are IP addresses configured? I assume you have a bridge, LAN1 and
> LAN2 are members of the bridge, and the IP address is on the bridge
> interface?

I have a HSR interface on each node that covers LAN1 and LAN2 as slaves
and the IP addresses are on those HSR interfaces. For node A:

ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45
version 1
ip addr add 172.20.1.1/24 dev hsr

The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24 and
172.20.1.4/24 respectively.

Then on node A, I'm doing:

ping 172.20.1.2 # neighboring node B works
ping 172.20.1.4 # neighboring node D works
ping 172.20.1.3 # remote node C works only if I disable offloading

Thanks
Frieder

