Return-Path: <netdev+bounces-192418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90781ABFD00
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227F04A6364
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C62F23183D;
	Wed, 21 May 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lL8cBb0X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7D381BA;
	Wed, 21 May 2025 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853284; cv=fail; b=ectR0KozOF5JlzLrBkB0DoDLs2B3lLCAcQlFXa5RTH76yrXAIOJYg647pVRjaXlJ59h1M70PKDDLx6W8yYiOIZS55zBD9441F4BdR8YZxgSjyW3OD22Apg0aJTWHZaSPb7laoNmDy4nYk746x1Pakigiij+FSlsXq83lp2iaq/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853284; c=relaxed/simple;
	bh=/4TOUQRNTbFeRSFN3/U3TADAZgOLJ/2nfsTi7tg5J7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uFXhKwCFgze4IckufpWxBRFcut/i4hO7rmWYNxaQKKZPDuAqhJ17UiblYsPP003I5vAd9mwx+ONMn3WsZtYh2+HwpzT2D7PEh6P+eFpPpt5fO639Z5pWR2gRfq2bV9c7zDws9I/Io26Dl6ConqPHImDqsRNjabEGvcZN2iU4zfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lL8cBb0X; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747853280; x=1779389280;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/4TOUQRNTbFeRSFN3/U3TADAZgOLJ/2nfsTi7tg5J7c=;
  b=lL8cBb0XvzQp1aCnSe4GCLMZc3902b6t7oF1jHYhwp7pF/h2TXozXIPn
   2PZd/YDXF0tx4pmPTzXZYQqTkk57Jj6TP55GJKyJXOzAIhgfJnzWCjHdt
   kc5epFu4H8G2QJkOl9L6NZ/uaxFYnw4bCxXa+9ilsH/ifp2PPZjK3WEhy
   Q6pzloCErbW7FmIpwtxT8IciAQrrXuf0CK31Djvr6Cd/BeZpbxA1p9BYz
   GVrWS5pTlbDZvYcOQyaY9rW0FM6KLi7ToLZhNeFiRi+jDp8krNQs/3lfv
   JuWcizNwBRDLJMPfR8BG8e3Qelml3VExvqBMShsSAR3QHelQnb3hbffPh
   g==;
X-CSE-ConnectionGUID: Hw9dTQAnRBqVxw6vnMdrFA==
X-CSE-MsgGUID: oHL61dUDRiykNBApjFvaZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60488225"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="60488225"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:47:57 -0700
X-CSE-ConnectionGUID: 1bb6smIETGGstc9sSbvGIg==
X-CSE-MsgGUID: XBOGAVtiT8KnjRPMr6NOeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140057123"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:47:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 11:47:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 11:47:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 11:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLEeNbmpyLV2p5QI8lVL7l040mU10EiQtZDujYk3tmhpYiBA9RX+gI7gnrPRpLot8sGr1G+G6ufhuUmIx6eecBCBAtXs02a+s+p4G/Ekt/HOCgDMxH2VSv7/XDAGDv9TqsBfnI1VjKZb4gFbUCXlcH4HLNbAvHJaxNPwSwIL2VUVFbG21CWggdB+7kkJt4cIOTo04mlaPF0Ef2oTmVVMBjuEJHtOEZHT/U2KbdBjkP9Fhij1HAh62VSFBd8ijJSfbbABLtKsJOV2YpEpahsC8112iPvf0L+VdgPUXmLmSKy77X4nDTY2bWoIF1KtnjQ/Bir5mYOUIn6tILSBVCnIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tslOha9mNQ9b/ttvuW/xOktO15zzmYQuGsMMc3FxTl4=;
 b=kbGnjgz6ESwrAZXS0GSy7FSMMHFgNQEcGhnyQvOrk/z90mgUKuR0j0NPRG8wKnfe/dbmbUYFhfHy99jE1a5e/RlS6KM5Y8C4wLOAQciHMu/3ueCjXNUzCZofsbB3QD9RXo4mWdSwFAAFuFfD8z4vdN9aCkqwNaG/KtOaI4rT1n6K2nhr6TZKBY7N4TAUFkk7M09i1/3kJaoaZ1MTIxof1KxINnbjWAH5IsrdmxSss6lCv9yEr14ylYtNaCYb2CJQHcC2r+3hb6AFV1M14BEvyS8TMHtxqOGVuz6ZdaTekEby0aWIGcz8dJqK8xGJl18d8FAZHCG4Ny3FQ9JV1nC3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 18:47:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:47:39 +0000
Date: Wed, 21 May 2025 11:47:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 07/22] cxl: Support dpa initialization without a
 mailbox
Message-ID: <682e1fc963402_1626e1001c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-8-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: a06c1a2b-d452-4744-c4cf-08dd9897f64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ky12lWZeg9fmtFIxYLEd9z85hSo4nspYp1mGbotZJXNoL3B98sjuR7IaKW0P?=
 =?us-ascii?Q?kutyN3mdzNdSAIemdebIoHfCI3FQFoMx1j8eSxBLrGSYd4Rj/sjGG1MNrb2S?=
 =?us-ascii?Q?n1c1zHwdjjoIZj9qmS/Q6ynZzfFu8f74xDy0BsDBE4ppRGd4LQMP6aztcQh3?=
 =?us-ascii?Q?t7cSonEK8UQ72NdwoydcmA8bhC7BAm9XxS1uPQPHQOynusRaSbPtxBTDenU7?=
 =?us-ascii?Q?UEHVw6dUDSNCKT6C6gO28bJdTxVyqZdQxGaN7XNbQmDVP1zNYVKALyuVhUsO?=
 =?us-ascii?Q?0XdeCG2W9aNwHwlJgLXhi0LgFe9YKnBdCqhcfTKPB3Er4bSOxoP5BHO6z55x?=
 =?us-ascii?Q?pU3m3QjW8XAwdp8xb7d8JixHp8lr6y2EmSjl/C1vTTw+Uf/BJGMjprzdTm71?=
 =?us-ascii?Q?S2xQdtBOc95fnI2NiaBhSN/3PdqxA9CVWZO1xkSrQiSS6zeJa7fk5rAJUr/I?=
 =?us-ascii?Q?qYdMKY8tiRytSmh2sABRr8bqRWaEg9lAcFXGxx6A40E1lxqg8Y9q7CwrxxBo?=
 =?us-ascii?Q?i8c60MFtJjgKjc4e3drgBsU12DczBIFXrarq+eFuGl6LNb25JHmT0m7g7FgH?=
 =?us-ascii?Q?I2bNqd6wmpaiHOI8tByPy2eUWHu0yg8XTZ/ZH5PFozkJ36UcIMwemT6L/Bv0?=
 =?us-ascii?Q?Ppi9o1VQSHsz1ZpzPV+fmn0ELnle3beDKyGlSRnbIItI/HZFCTUFNAtJzEOJ?=
 =?us-ascii?Q?qIzCGbB8FKXF1QdxgW+sdnyPisGtVizpLnbJ5oAynwWhLChklcVIaDztNelF?=
 =?us-ascii?Q?T4W4XSOPRH08uWA+s0qd5h2lEclMETNlMDjeZ2YLDWZjFiel7RtsoQ9pkus1?=
 =?us-ascii?Q?miyojw6ftPsGW9rub1yBFK/cN0RkCp3EifMdNVHUKfk0nfruuPjsErd31K1z?=
 =?us-ascii?Q?wMoO/x4hfX3YotltdPwUFixMBpxJG1238amJBvbZi1JPbqmKIlwX7Ppcu3Mj?=
 =?us-ascii?Q?NhzblUDZckfmy5tP6nQm1YvSngv5UmIimnmaVYklNwa1+NONAFeOJgtbQUQD?=
 =?us-ascii?Q?bzwfaKU3SKgmELDUGtmNk3HyvxSKDflNLvBH1fDEE3d6VkxSz7YVrmP1ndUP?=
 =?us-ascii?Q?GfxJUy7SPpamuK1DBRdrNTvk/KwUct5K1VlIhNY4Oxz6tzQLXwlKGNyX+yJx?=
 =?us-ascii?Q?fSX6xpgAm3uuz5DL0kvjHCF9eW2Ebl8LhJjbDq+XFino1bVSey6/cYor57Tk?=
 =?us-ascii?Q?eHQ9Q3yNAaD+GyGyca8RRvzRK9Yw/aCmgfBDLisAm1sDTohqpePvFfE2HTVp?=
 =?us-ascii?Q?/HEOPopFxgO19OPtfRaeZKJ6xaYbnt88cM/N0EgzhaExmLBBF5JXtWIHtkfG?=
 =?us-ascii?Q?ubs/J3bKj2cq9rdz5o6OX9DKrKa8BlOOTkFPaIoq7oIB8SC8RRF1kil8QTLl?=
 =?us-ascii?Q?rfqrQsirbwv2jWaYy7S4efLH+Yo1sPSPJ1l6Il4gQLjDvF6gjxs/FZbqREPl?=
 =?us-ascii?Q?flVXpD4GMb87StzdlQxR7YgQHG4CifBS8JCtuNYhat03lL6VWqqtFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DhIFzkjdTwcc8h6EWX+TjgppbO40e9qYDVF41sNsYkbAE2LZV3ZGC+oL26nO?=
 =?us-ascii?Q?H6BSnVJWMqMAupsjtPvi/x7tLlXjLSA7/hZe/R4AhqbJFAhI9pRFIfW1A64R?=
 =?us-ascii?Q?QY0kIKoI3JvC95kya0X21wF/SnJ/apn+ko5Y3wVIvicn8SVWjVbzfsnPiRZu?=
 =?us-ascii?Q?SfAZy8/YYdPdY9IwT8ymN3NZzeYgVbqLx3DHRWIJtUFFdIG2AulBognq/gpH?=
 =?us-ascii?Q?ntnYEu3XB1pNDXfcJEsckazNiS12oi+/wd1l33hkQigA7Qsi07qUMPYSMBhw?=
 =?us-ascii?Q?xMKb2hUlIsLLeUCOBnhztbLKppsqVT09Qg4PuJzai7eGAtcS8m3G7+gs418d?=
 =?us-ascii?Q?ETM5afXi0+h2D29WUKb6TbmiKDXsM3tpYijwl/qO1jkOWYJh4iHueePKOUgp?=
 =?us-ascii?Q?zyxF6/L6AsNV10Kjp2Sds9YKjRXKMT5EhkNjNUkYzIob21cZpZPWQGKPuxgg?=
 =?us-ascii?Q?8irAkNOvYRp2atEvzhMmCxBjk/YCGmZ9H7WovZg66AzOPjqTLNu614Ju6xKK?=
 =?us-ascii?Q?FC2gyJYboUCPS/ogddNmQI/FlCKLHSwadSp7Ex++K4bTMdRR59dBrQ3+tmiw?=
 =?us-ascii?Q?a52UqAam51ENovm3hYBUaczln6BDybMNxUtG3PVtGWW4p6+EFq5uk+eXrt4+?=
 =?us-ascii?Q?5tr84kxIu1w5oAi2CEKqgvyc2nNBVLbig7A3o4vnHtnPgbn0GFwacC8wZyTe?=
 =?us-ascii?Q?XCyjZclo4i0W03PyJK+FBdYturfmtQQ0wu5+sZHSVjZSAP7Kuks5KXy1TL1U?=
 =?us-ascii?Q?0OcVzu+1WnaT03P1TVicJ87JpyFqHdU+Q6liaaB4UhbeFUbe4YnHVbwz7D9Q?=
 =?us-ascii?Q?8xQZiK/Sak8+oyYUmwFX9bXHLtbcXxnpg7eSm+Kcede+vYZZlVG+hb/NRzTR?=
 =?us-ascii?Q?/AaDlKJaPU6yHKpKfcVd6dr2cEQmUEDcxyJSPS8zD/FD7RlBlzVHEWGD7OAE?=
 =?us-ascii?Q?lZ4lueBcN8U0QuECM2yPaTOEMbVgG72NcxqHHuCyOTNye2e2WkqtoG78a3Lo?=
 =?us-ascii?Q?tQ3RsrTcwkcZy8G2jKwvbf1haakmPr9GJXwfQlc0z5Rt/SmUCQEES04B5M67?=
 =?us-ascii?Q?JLkNL4sSIgJslPzpXz5MPzn001g+AdiB9GVNHkrmBitpBwUFgWBYsod1Ss9N?=
 =?us-ascii?Q?rTky8/U9pT9rhN2ytPouNsaVvinyZt6dI+444miBHyTMlYT/5dpmFdYDya/E?=
 =?us-ascii?Q?hXb5FeGJfZELX5ZE5UCM0wWAk6ie0G+uyQZ/gcb7sVgFRA53Ksve1aAWxHtd?=
 =?us-ascii?Q?OWkGR3OdSxaUfhyCOb0ZzQ1DisrQFStp1COL1UR6s8oeKqBrQt51sTARW8I5?=
 =?us-ascii?Q?T95kdppExi8wxBzzAvydLtWWtCj2QxF4U9hDzThWlqk+6jtXgVyI9rMxvUsh?=
 =?us-ascii?Q?7sbOGKRRRsjbR2YXgX7NEotArUjZerwqfBsy1l26HR1Z4Ki/1uxGGDg9YByr?=
 =?us-ascii?Q?bH9pBGBm9ITE7Mqt8GKMpga5zOwmdAmfU1crJD+vuM+x4PKgiGnTlkVx1zJ1?=
 =?us-ascii?Q?/Jfiio5cIgNITPvOSuRgfi8KD5zU3ZUFuGSgboQ/UO2lD/a0/MM4LF2fjcEH?=
 =?us-ascii?Q?aMqke3BAZHUVrzmeEM8Awe6j/V7Sj9kDLq95sxWFDj/vvpReY16XENfyFkys?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a06c1a2b-d452-4744-c4cf-08dd9897f64b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:47:39.7347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PafN2CjiSbLmLLyLgznoiYTpvHA/n4xo3WQfxzsmmUMCCqrwDt0vxUg7uATjr3dew7fRMIhBjwfsaO6Icj8UpJchjgssW2nMDVM0is5i5A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DMA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile and/or non-volatile hardware partitions.
> 
> Export cxl_dpa_setup as well for initializing those added DPA partitions
> with the proper resources.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 26 ++++++++++++++++++++------
>  drivers/cxl/cxlmem.h    | 13 -------------
>  include/cxl/cxl.h       | 14 ++++++++++++++
>  3 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ab994d459f46..b14cfc6e3dba 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1284,6 +1284,22 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>  	info->nr_partitions++;
>  }
>  
> +/**
> + * cxl_mem_dpa_init: initialize dpa by a driver without a mailbox.
> + *
> + * @info: pointer to cxl_dpa_info
> + * @volatile_bytes: device volatile memory size
> + * @persistent_bytes: device persistent memory size
> + */
> +void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
> +		      u64 persistent_bytes)

I struggle to imagine a Type-2 device with PMEM, or needing anything
more complicated than a single volatile range. No need to pre-enable
something that may never exist.

Lets just have a cxl_set_capacity() for the simple / common case:

int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
{
	struct cxl_dpa_info range_info = { 0 };

	add_part(info, 0, capacity, CXL_PARTMODE_RAM);
	return cxl_dpa_setup(cxlds, &range_info);
}

...then there is no need to move 'struct cxl_dpa_info' to a public
header, or require type-2 drivers to pass in a pointless PMEM capacity.

If more complicated devices show up later the code can always be made
more sophisticated at that point.

