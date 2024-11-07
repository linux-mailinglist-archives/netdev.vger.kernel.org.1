Return-Path: <netdev+bounces-142892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097F69C0AC8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDDE281F03
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F2215F68;
	Thu,  7 Nov 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="g1rM0S+J"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E7215F4E
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995515; cv=fail; b=Kjyk2X3ohxM1/Kqp90brh8FA3s27Gy+1R7jPKPuqczksnFyEZ6HM+29taDS45X9kLYgbeHz/+FoUabcUleR994xBosCP+IpQFzL6fsUxHRcuuhf8maVWpzPm/OROcbk4jYEs5k380iWbu30BI8ru6r/sYqBbc399jQfmGPIssJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995515; c=relaxed/simple;
	bh=mqRB1gP4vMSHs4CmsJ+jivnUirb4GLP5EARCNqOpb4s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BDoPb+lwbiVqrTmPFy0PTYWSI0XRi6hehLsBfa7Ef9bspWikpgKWy0rBcN+9PiwS0Lz2+NSFTV1aleXi+sI6CPbwvIJDJMHVavNjWCERGdDZ0EiES3vOzcDAd7SGM3d8y+F3QtJnX0F0QMrtEY9B7bhhf/IJcMo2UcNbDfZcnMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=g1rM0S+J; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 80C40480063;
	Thu,  7 Nov 2024 16:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUoSX3ogCrlkjaJFOa/r/O2g1y/9gA4NtxzIj7mGHhbeORP3X4jbxgczPDjO76ZO/TMNP6t4RzsRJ323FPCY0X1QREIHPL0xggnI5cW3oUv2J/NSIQE8s3HmjpMSyjYVQ5/4svgzuMhxCWJRt1/PAYqiMUwDEkO702pIxmtkTzaZQoTUEBbPqsl2AWm2vt5YqILjbmC5OQv4wIbvDhaBxqZOVabCNbbklIgTqb46hxSKGG1l8EM6wRiDg5LYPidaBYyNguEJxf7N7M33M8UFNm5iK3OA2C2lSwKtrrReVUlCnkmnvC4T9308EQ6hYQNuvBYK4L/tct4tF7T/rHt9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCMPM4EnK0/NKN1WB2TM4S1A3Zv8Wam0sG4y9/9GVOo=;
 b=q+DeA0BdFPclsai5MtlDVkdCsvEj+mamlVBF8Qe492GM2FX8Qx9vUnozbeBHjuDpJov8KLdwn7Quy0MqTApp5sWsiVElNw7UO8uPDHJoR+xeQEhwbvljACaSHJe94RWmSlCMTzvKuq8gy+Sm5h6hXC9eu3k0aDLA00hsKactIMcsxJ67vSZt8Qo8oCM+aJfvBl3iv2M4LFEML1ClmMq11YI0l3vDynt7FG2vyUZJZjmPczHSD/BZqyKmnig20kKJbDnZAgSwdI2PRjmedLd2sMBgjL4KzVyxVGqtWuPKP/j+s5txyJjUL9KmgiAVb/5AOoYXkxs04s7NOrCS3RchQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCMPM4EnK0/NKN1WB2TM4S1A3Zv8Wam0sG4y9/9GVOo=;
 b=g1rM0S+J7uzottKWHoDoKi+jNcNaNkQvrrP2vYE51rDlarhf3yLTD/0TtU/i5ABOW+74Xwr+t8Ykk89iBKAGg0AsnDeb3pKMgawnSXfmzy7X7zgVwHg3xV+7+P2o1GjqSnWUjF9/t07ocLNY+1v0dkKBNobcV5tDotF1Dw7ddVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS2PR08MB9296.eurprd08.prod.outlook.com (2603:10a6:20b:598::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 16:05:03 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:05:03 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v9 0/6] Improve neigh_flush_dev performance
Date: Thu,  7 Nov 2024 16:04:37 +0000
Message-Id: <20241107160444.2913124-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS2PR08MB9296:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f8c22e-f09d-4c30-5f96-08dcff45f03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DumdJdhpvdn9u31M3vd9LpOE9NXTXDoO8dS20ec/5jX4Zt7sD8KoDIbC6xZq?=
 =?us-ascii?Q?D02tz/oz+Ih6COUMOuzIp9hC5TorwKFhebs1w5JPHO9eLruWrylInJ/kt5Hm?=
 =?us-ascii?Q?JaPZzQyNBd4VWfxBuEViqOyPLr7S/Qq4hK+SJfC6kkOwVqqeDVmJZRLnNoTs?=
 =?us-ascii?Q?k5mbI8ibB2DDszHqbSmD/Yf+fIQKrtV8xkY3FajumQowHpoftzEt5NJRB5wh?=
 =?us-ascii?Q?usUhRR1zYdkN569LFHxjAH996nZtxqmfHm2j3MAN+pUJrVxuYv/7J3Fu9/MV?=
 =?us-ascii?Q?WyeHdD+CinAlOPHjRgbppfUho3ZdNaUzkRU8A0+zGdkbQYGySAhpebU+TEx0?=
 =?us-ascii?Q?CNeQECVZ1xXVZU36mb/Lp2TFH2t0ghT6ROwJ3jqb9RKiYXz0PuA+EWGvI7go?=
 =?us-ascii?Q?Rkpv9KUu2eCdl6GHvt/pT8Io4XDtYrVI+WClJPqkxVtMK1prS9u4SzEMGHGc?=
 =?us-ascii?Q?uOj0vq+w4Hs4/UKHpjDIhReFoNrGOE2lL+oA1n/hQ7RMIppTHBNxShA8BkOO?=
 =?us-ascii?Q?LqLamK+FfJMLMhLke6i7NTteiIG4NQXj52BUS7ZSqVX2o26u/qXhafymE9Ue?=
 =?us-ascii?Q?G2nNkjVXHQ1e5iESFuo/lKcCqslurk34ow/EPeE2WvFjuc9Q0FIA8rbIfpPj?=
 =?us-ascii?Q?NxqAJ8neyGU1JychzbtYeWaZ/CRDt2sZaQXSj+jBmI4oUgeKajJedFQMTnLw?=
 =?us-ascii?Q?DWNy7YOBnG9BKlgj5Fo15EyoGJtuc60FJqHZNEeztfs76z2rZ2Le9UYbM2+G?=
 =?us-ascii?Q?BEKS6GVIfqv1LkFSgXMLGQectlTvlzTMF7IJxG31H4k6j2DTaM2swNurnj5m?=
 =?us-ascii?Q?EA04TtsrSO1Sl40MwahjjgIEshEdOabbjcyk+VA2PTLFmqBKYSKhHWRCXf0w?=
 =?us-ascii?Q?RZ6+Ghg09q8p04nfWCHWQA+0do+0LKhcvBXtNIuXZVQRaXC4aT/iR8QMJHG1?=
 =?us-ascii?Q?HiWFDuFJwJfcS9j4yXutscBfVbnl0a+lPaCU6aCZm/SgJWhjQZ2kXD0C1eGD?=
 =?us-ascii?Q?+ZnJaV8cJsSXnPy+3IGwN9E7VQUX6HnN39JwnDEjrM97/9YqUwzp0KshJKLP?=
 =?us-ascii?Q?E+qZA7jrUDrYqY1y6afKhFUycRheswyGehhISf1GQ4hlh6PScOjpNU9AItcG?=
 =?us-ascii?Q?hEOIoIKa0yDu6rRrDUI3Y4DOj1sOuchY0SPObgZQKsemb4sP14t5Waf14LvL?=
 =?us-ascii?Q?enKPUhEeRg6y0gi7Lsyuxfk4TsXD5itad3HIFQVx07m+36dECR4FhHdoPs0Z?=
 =?us-ascii?Q?QxClItDUQyIv5lK8ObZKVpAB67yeo8gIL5qLAGfVbPjxtZPWfq+YjoguQB5Y?=
 =?us-ascii?Q?zebw3rAFtyJ2t2yxYExstegHsFw7Ip3vfd+yYmAJthvH6XdC++gEKfstvXJe?=
 =?us-ascii?Q?h1MYdp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owBoDPRYWyhXetbjb+P9kbxYGgBerGHzirNC+GmZqXknDdDAu1j/mnZ6xyuE?=
 =?us-ascii?Q?NhewkvKTa4qDlg8cJibI0DHwLk4dq9phS0Qh5fTXTDfBWeBzrfHe4iId4L9b?=
 =?us-ascii?Q?G8K1vEUjrycstQlrIYcE48jtzM6vLjqJcsvCMxW6gbaSh3mnnYxBBR1T4527?=
 =?us-ascii?Q?XKZWk9Lp7Dtc6KG5epVd5cN3XjYJEt4vFE2S1J69yZupmsxgyM/1D/PlrJAd?=
 =?us-ascii?Q?sfnHN6QaCtOPH3wlNLYVyfHovi6v8pssAEdwaTNZZDDh3ynpD1sVMFjkZLLU?=
 =?us-ascii?Q?dl00cE6V4Tvnk70Enejn8LHYd3sFQ2UFHXi1l76iDvwVTEm3+G/g+mB1Rhlo?=
 =?us-ascii?Q?f/OcqWqohnFIySYd83gOj2f20Ur5mc911RkztIB+w2HnuirzN+Sw5WYKlgRp?=
 =?us-ascii?Q?Dkd3FLXnEMwdOir7KzRIvNOvxxnn+k2cvLhA9//ueSDtJ0UbTdPgcvW+xsYZ?=
 =?us-ascii?Q?+RNsxsglfv0tcDTNpzcGQhqoZ6HC6IGe29vtq0EkCxfk+cnF32FWYHGmHLAh?=
 =?us-ascii?Q?B3xOYAgsQ9XL7yclpjNF9wtK0RzDmpwFn0TvrIzTFw/zqfOaDIQDDIu8prOI?=
 =?us-ascii?Q?YmSI+sTHmk6pKI7yM8B2lfSL4UMqlY+oVCz6o3KsBmOjI2S6XgRrmND/903K?=
 =?us-ascii?Q?M61kdq8HItXRQZ3f9Fix0ROJ21whLlmTM+MabFFkm6YjW9ZIpVUKuN+H1Uu+?=
 =?us-ascii?Q?YD44jia+EJBaQSDR9E2hYeBMmAvJoOP2IfmeykcXUSacznx5yEBCatvm6Dqr?=
 =?us-ascii?Q?KWXrbiEQzUbSpd3D6pIUOCZQt8AbEuIvkuFR0R8d3mczpHqYdnxxSkwhDIyv?=
 =?us-ascii?Q?+vtB7V3dJBUo7YcvWxm7JcOIDWBRn5CL68c9xLpLCj4y6c4/YslFdoQM0VrZ?=
 =?us-ascii?Q?BlcxzQSy+u/0Bbut3yK2k4s+7cJwcPkrEQMD2BpdM2ms6NghOGFzZySn5x+J?=
 =?us-ascii?Q?da32+06jdqDRFWkXykOETaljKNOLt/KXzmRxr+SpwZwPc8d0trj/yuTDOZBw?=
 =?us-ascii?Q?NAM8dOkhfcIBwlEsUgK+ovjvMgppp9YOOnZonrEQLz3Hcdy6kNmHXRzVD9lx?=
 =?us-ascii?Q?8qJ0Vs32T6RWdQXa0EIJYpFlMRrAmL5t9iDl0Hf+/IFL91QOoptsBUMJ0VJk?=
 =?us-ascii?Q?E3G/6AOYIq0nMxFNU9Vlmb8WqrRimpFlC/hLW/mKeJ4An1LKcXiyT2WYNcDf?=
 =?us-ascii?Q?tqUCl96MheGzFEA/p0BxppWqLaKXJCpZ8YLzuiI12y6F/hGGBmJITEw79ZTu?=
 =?us-ascii?Q?OitOiPZhz3dGpj4exvPEYHJei3ELMV5PI36wR/R28lJtf5xJkfar/ubfAaJv?=
 =?us-ascii?Q?SiEwQSdXUmKVgfSUoGM4apQ/YCryJabvq1pTSp+6oO/BsplJvF2TQ9K6kYvl?=
 =?us-ascii?Q?Ky4hF/UOiZKo6mvPvojy6dmX3NkPcFI03yIzDgjglbIyPylCLRAcBc60GxTM?=
 =?us-ascii?Q?c/Ff2UsHl/ykCZu+YF6KvUl3KahcOd2TRO+Nz6xY5cAdWLiQ5yu9uf0MPE3a?=
 =?us-ascii?Q?NVjD7dBTIpQEbu135Yjfk3UVyZD8ZLwPPDY7O9yKKAWger0bgnkB/LDjvt0V?=
 =?us-ascii?Q?NRJHq+vrSU51T9KKTJ56ofPsrfHWUtHZebui0zVh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNuov5nT7zP7jIO7qXM91X5qCEY+C+nk427nEwGFx6dPIPDh+z5hUK6SLxOPcI+FQRLv45T6GgYEkM05RSogzHsSW/Y+REv/7q3fQPZLXjc2WcgHyHQDF5sPG2H/LByLG7bY5rMCplInxLskVoxgs2ZMr3QcWSYzrdQreop5fAKgLEYrEE6clFzDcor50cdl+hDr3QDAOjnBkAllyzJpfz1UVwRtmkSuVaw7y2lR38dp+UvM/e0jw4AEX+X+ULzblFYfgV47uazbFjMEreV+JbO9O1FEEZ9bWjg/5YDe0gakl0QZiz5NhTiWodylSEQnV2KSzcZZnqGanOYhM4/rr8X+e5cdnzsjbNgDVt10XRPJ5Z7mARXwD92yxhK0xDbjY7FPHwmjmPbl9TrNmYEg5ej5AMNk2N3/H/ABCueVco9HndLeoBUATLHamAfl5s2jdcDE8g8HKtotfBYJVfXdHYkEApNwiu5GKVOApMkLqNSatVWa4iDvKbwRUJe7MmseUaxZD37Fz6S7YGmq11gSm+jJE2rz5ubald6N212uSJsn/dw8KnK0XW7qXYQZpzYMNdn6mrmN3Vjxi2k8faUMUbw3r4Nh0tqthfmh8oRTWTJ8gr3pGi9YVgedVIeMBLK3
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f8c22e-f09d-4c30-5f96-08dcff45f03e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:05:02.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnbE4e5YtjCw8FkiOd1IUjABLjLbrTF5UpG6WW5c+L6S5DfNi9ZoDAgGtcTprbnAriKwcKE+niIFdEfHQgZXnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9296
X-MDID: 1730995506-1Jz_tj5oqi6Y
X-MDID-O:
 eu1;ams;1730995506;1Jz_tj5oqi6Y;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

This patchsets improves the performance of neigh_flush_dev.

Currently, the only way to implement it requires traversing
all neighbours known to the kernel, across all network-namespaces.

This means that some flows are slowed down as a function of neigh-scale,
even if the specific link they're handling has little to no neighbours.

In order to solve this, this patchset adds a netdev->neighbours list,
as well as making the original linked-list doubly-, so that it is
possible to unlink neighbours without traversing the hash-bucket to
obtain the previous neighbour.

The original use-case we encountered was mass-deletion of links (12K
VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
slowdowns would also appear when the links are set down.

Changes in v9:
 - Use RCU iteration in ___neigh_lookup_noref and neigh_dump_table

I kept the reviewed-by tags, as instructed, but note that there are
minor changes in commits 2/6 and 4/6 (just adding the `_rcu`).

Gilad Naaman (6):
  neighbour: Add hlist_node to struct neighbour
  neighbour: Define neigh_for_each_in_bucket
  neighbour: Convert seq_file functions to use hlist
  neighbour: Convert iteration to use hlist+macro
  neighbour: Remove bare neighbour::next pointer
  neighbour: Create netdev->neighbour association

 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   7 +
 include/net/neighbour.h                       |  26 +-
 include/net/neighbour_tables.h                |  12 +
 net/core/neighbour.c                          | 325 ++++++++----------
 net/ipv4/arp.c                                |   2 +-
 6 files changed, 170 insertions(+), 203 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

-- 
2.34.1


