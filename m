Return-Path: <netdev+bounces-134937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A7699B991
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2065A281C03
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB90143871;
	Sun, 13 Oct 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4sT9Qia"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E471E871;
	Sun, 13 Oct 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728825579; cv=fail; b=j7JyAGUcw4sekiWWih2A2hpEl45/0lOasZiPmubHofC4IZI5zUgxuKlaooelZwDEjjK0lL+7iYlJ37lVTxuT6jbq+3wjjhRh2ked3qqnRZbk1l34l+i0rjuBuM2m1WIeBZGGNt7fjl4tNGfURfxs9AGmwxucmiLew+s9tN9JYSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728825579; c=relaxed/simple;
	bh=s5iKoWyKVRUl6HTll/VwuxdGwUIsaYlwNaFPuqIDr1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jamaRlLKuv7Xke81mycf9944MpaTRUxmlMUq1yupm0m4AUc1aZnzWPgj3rpD1bN0fvsKta4p2CfMtgKn1DsBYNQPyRg+soIeSoH2iutRG5dyfE+F+8EOOWFQU/yHBS3S7MUlQPktBcsggbQDv75uQg5RNHnzNtFCc7N183L2Hv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4sT9Qia; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLbJJLhofDY8+LY8GrPIo0igj/eHjI7z9nCT9j5MOVvHS1caTnWJ6OuZGTI9dia7X3RS9aCIyCjU4sI8g/cyHg7hm06Lly9xYgKhRxj2sfRdCIHDaGWls41Uvt1Bd+pwscvTyHAMeFqubKo2WA/2+fTlR7JoGkoYhHK6Cdmp2fuvOAB+IbVeyU2LMe1oLNJF4NTD6iU2FFuG1hybU3UJo/ipJ+kI7q5kTmworozqorCFt+9Krih8qYSHtWSv7yV0+i6iegYgD3dI8MmjnShMrV3Ovyd+cJh5Eqidwj8xmtyU4xvj+AQuX0l+LY7mQ2cHCAWwy9StF31LaLsplTeprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poYIaUl6gYXZNUlqshu/GSzDmnyph1IOoKUkFaQByr0=;
 b=hHcusfn0ITlGWPMo2ikFUi2PKPeMvHc9MOOzvj0RS1c99he3CKH/J7y4KPBkOgreStHeGu3OONg7obNJNnVNrXAOzaIwNaKVY55rMtRIDzIY2X9JqJkMrmZMv9rLZZlk6U7J7Ri3XeW5VC9ecrH/mEMH3RBOORHBnzoeLY6X5GZn7hh4GwkqqHgTrVWNWxsl8QscJc9pDrdYKgUt3WgdOrXTssKJiHN5+rwjngzJ8CBqhAS1A1dMDu0kNQwydBQhB4x+Tm0d2UP1B/ZEEyWCfmyj93gp8vJ8Tx4gRGdSJpRWneWxUnMroZ1avQcpBJR7GNsSJSSHKZ+usuxctZ10dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poYIaUl6gYXZNUlqshu/GSzDmnyph1IOoKUkFaQByr0=;
 b=O4sT9QiaV7Sho7AGpLMrH72qmknyUQ5pks4j73Ykn+nz0ZvjNdoEmiFb7Fy4ymBmcmwIz26K8fIAWUL+M++eTuQiJwdiRgz9Uv2TPL4k5brY85+LAH1pOnXZyAlZvzb4r8wytMalSpN2sskNe1rG8s28N+F/3e27BwOrvKF3q7z6BbiXjnUgSHpDNWO2EsKnAvOkGAM4jGKG34XsGJ50EXHAsCxe1K40g+GIZKWV4WRYWsttMHK3AeBR86rP1kfLuNS62srbAf0CGgdu5WVSlwr3REmKHUYjJB7bWDwDf+CLDJ6p5JAjh7NLszuOver5GirH7vnKkwHWKIQy1mSOvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 13:19:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 13:19:28 +0000
Date: Sun, 13 Oct 2024 16:19:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 11/12] net: vxlan: use kfree_skb_reason() in
 vxlan_encap_bypass()
Message-ID: <ZwvI1Qugc6W99_2Q@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-12-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-12-dongml2@chinatelecom.cn>
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f960a0-69b2-47d4-5f73-08dceb89aac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qddxIAEjWASqUlAXRokabBqHsKOL2R8OUy9j3ax9q6r9SXhAB/yRKn+kYsuT?=
 =?us-ascii?Q?DHEUNlWM6+mxmQVpT9Xqr4dvHt0scceiPeDvVhXrqO54kHnrrsda3Z+Qa9v2?=
 =?us-ascii?Q?F5eVU4+DE6ZMu41/O5iYMxquSgQ9cXVr8XqDezyMaRXjv7Rv8DqkMnV0iXvm?=
 =?us-ascii?Q?nDGUIXeBF+AUcTLYjRiWChM+ibco5YIYDlO7nexXwuKzBrYF78iwvycPV4+w?=
 =?us-ascii?Q?MJOA3VC77/y3rwYnvDoL2OD+nPZtzpHN8B2DwOpDnqwqZ9x9yybUIiL6JEuU?=
 =?us-ascii?Q?siSqQd4jrqqdMCoPWWePVv0wrl2R3PdR+fYoRAFg1a36V6uRaKCdykLbnW8H?=
 =?us-ascii?Q?t5NxFHckjnV8ERd5Iap7U1fT5676IEGEW6BlwMIvhPl7YERU1Kn8Zd1PnRyO?=
 =?us-ascii?Q?gOSjuEzbfE0njszhVwtvtY4mfsHjwLgDP0XHYnZY10I97z4/g+nxGM4N37PO?=
 =?us-ascii?Q?+She+geb7/PxsbVByWuUM73fTAEoa+3h0cqSqEWhoDAcZ+vBrKwE7BYHSJPa?=
 =?us-ascii?Q?B64X5R7vXpS4XR8AQGN4EccUEnr+yPfQtksKq8VrPmwNAyPF8yBrEqls937J?=
 =?us-ascii?Q?2ZsDB+57+HqNZqf8AHxU+TD9BavmOWurAUUyl7rRpL75yjWf0P4lEkr5UR/+?=
 =?us-ascii?Q?rYImgpky8NHWFVR7smFLjsGkP43YenJQqIakMtgXHO9gVDEwQX/OTRxj0oDK?=
 =?us-ascii?Q?X/Tj2VjWR0z/jFNs9Hw3f2aOjcqhD7cpcfW0Kj1Rtx/IJuLtmilhP2BKOPuY?=
 =?us-ascii?Q?hsim5/5PHyHCMG5ZscUO1u9LEAz2PTH0u+6iTgHMq+2IFSgTbmZaADtJLViA?=
 =?us-ascii?Q?5CEgUVLUNpLKxw9fbz0xSUTcy0AAimPXASxNdp5swp2HyWyD4FkusoqE91z4?=
 =?us-ascii?Q?mJKjlKb9KiMLBFOX3TchvjksTy0pq36P+FgiPw2exNWfjImev0Cm7MQSyXC6?=
 =?us-ascii?Q?GQk5PNCjSYOSZ/r0BjOwk68TuMKZ9Sw8oTMOwVDp7vI0e8UMr1fTuaIDPrbE?=
 =?us-ascii?Q?yy8qG8TydvYbcbVRGJ9V9rZyH0ZjZ9OuReFkixNO97jKDg0/KW1vScvgGHLa?=
 =?us-ascii?Q?8oD9EqiDJPMlATE4Xhj/HM1ul+GDlS5dAUepdFQrYr2tY6hGjK2QOPnkWuL2?=
 =?us-ascii?Q?ZhRN00Eu1+0uyKY4RszbZ7MgWmnorokYxs6wT8VaiHXzSJQnfuUT9LGLtnM8?=
 =?us-ascii?Q?NzUEMk+94qqFdLAdzZ6sCXJVCeUqiBI0X/CSecL74jbZbcwvqm9/5EWsCQJd?=
 =?us-ascii?Q?Hvs2geoX2GKU9MME6A4msBOOGdijUkTANmvOsKcZQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C6GUKNBV9Qi8Fb2a+gMiELjvaq9Ad9vRGrEF/muWnOuAphG12rEAIzXfEpqC?=
 =?us-ascii?Q?/aNdp4bwYA9ZGfYxk+2RbAekQVKV5qIMClQgS8G8JNQ6OYeIe5GmCZ077my5?=
 =?us-ascii?Q?yA2fO29Rmje4+NEPZs+ZMsIW0lLsBadPCG4fuK4r9SbNTBd7QEA898ex5K7A?=
 =?us-ascii?Q?FrvcFyiCQIENLFCRwXphGbwK+A7HpEG/Aae9G3y5FAg7vii+qhtSfTfW+myU?=
 =?us-ascii?Q?gM1kvrp5d/vaKMLQzu/W8rMAMj/u8NPKoclOa46XYZkDv6PDk0yoGw1Rk/n0?=
 =?us-ascii?Q?M0ek98TWLtN7HGxh+B1PUbAyiANhez21BVpxmxv8J2l9gIWhCinfQdKhEfly?=
 =?us-ascii?Q?OJqQlKmz5yuknvo06V7/TqDM3cXcA4YLGoI4TujaD8quJnd43Q3Up/YwK+Ji?=
 =?us-ascii?Q?ZXmfrBzsHP9s/3qfPn/gFF1ede+vcCbfzrs7GD+NUg7+oWyzqdpYL75YtxXf?=
 =?us-ascii?Q?a3Z4hAW7y/uOVdLTLBoa6jy29wAqG+p3afvR8A2uj9yS5FrDk2U9jU28JkGJ?=
 =?us-ascii?Q?9ifQy/ioSwOoXpB7wJQk4S030RvhBVQd9oHkNS2qdaPQ/dSUpLW7HNNk1rXo?=
 =?us-ascii?Q?wRoBTphnJQoApdx4eEiGwvJSe5LK9dUpq2rfGQZDbR7B9lKQB9Ji10bmHNhz?=
 =?us-ascii?Q?xQfoII+nTh2u0yqJLHN79Zlemh09H/7oq8+mKXDaFrDfTu0WgJRyr2dTJrOH?=
 =?us-ascii?Q?WmnsUGTTAPS/ev2gIMKAKWR+IJuiXMXIDCyDwIGic8xyvdJIDJVE1K/OhRn9?=
 =?us-ascii?Q?lRj8fK2bN3XOjtJf0vp7+MCMQhv9/hBIC2Bo7Gpy3njGyZYd1Bj/ra4N53OS?=
 =?us-ascii?Q?PPtrhBXlVcvBZuMP4Q7eQ/yscDlz4KvPei/vg0ffSVDYZ/C1JfBWu3Iootpg?=
 =?us-ascii?Q?qMCaSZr9YL6r5wt8lXbdsDOugfjh0bC8AWVo8R400/T54uJWEIWJlkqX19b0?=
 =?us-ascii?Q?8MXbtuJTnlcYWTIPFpNxvekcE2ODJ9FjIbCWW5Pm4zCl3mZg2yu5b8SP3Nkn?=
 =?us-ascii?Q?XcDdfYdltJlMg61DvogJBGeV1Mh0cvOnSgV2lpgFhN1hwQSdN2i1qt0PwQo7?=
 =?us-ascii?Q?YX7AD+SLUEZqNcujCNr1HY7Wrvccf1j4kdSdQ00DiRkhkVUDsj3g75EHWZyl?=
 =?us-ascii?Q?SAn2wXN0Jk1N3rMIIklYjOwH7Wi++NhtYlXpT1Izo3MKZECiOVdyNiCbhfyh?=
 =?us-ascii?Q?NjHDbf5P+oru/xqGyR3DkAn5Ftukubq5fGzgco5JD/+WZzbNuhZyLbEoDwgu?=
 =?us-ascii?Q?uD57kaWGm9RCUcIl7WF7MA1kAAiSOMKFhJKTTKXREkaXfP5E4TDwxGiP34zx?=
 =?us-ascii?Q?mBLSFMtuFlVU+4LWo/qvZHKgriq/M3pR6riMZ6viTadbyCkferLUv5/sY0cx?=
 =?us-ascii?Q?5ehI1ilQS7uuCNAJW34kWFV3bgRBan3U03DFgjoGz3v/AEP8MlvwuyWrHoWq?=
 =?us-ascii?Q?6FhDYu81DO+lSeEsffFytsubaMRt+q9zko60MAqmjhZWBAVGlV0o3YvfNTN1?=
 =?us-ascii?Q?OWLRjFWvzhaprxN+iI8sB9GHnBEZy3s3vylZ9zuS4GAvLFOWrqnm+TPy+VkJ?=
 =?us-ascii?Q?lMsmkmsgG7QEAb6hb644vreKemFB+YbScnfEb4rQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f960a0-69b2-47d4-5f73-08dceb89aac9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 13:19:28.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEkx9JB4yfe/Jn6B2Nxb1/H4Gqfu4HFYkKYSCj/9Kv9jRGz12GAXSiJbAvJs4XgBWFuSyOx3YrmHvVTtIT2OaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

On Wed, Oct 09, 2024 at 10:28:29AM +0800, Menglong Dong wrote:
> Replace kfree_skb with kfree_skb_reason in vxlan_encap_bypass, and no new
> skb drop reason is added in this commit.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

