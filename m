Return-Path: <netdev+bounces-241335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E0C82C45
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C3334E4405
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D02F5465;
	Mon, 24 Nov 2025 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1gEzfnb"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98F2F363C
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025479; cv=fail; b=J139LvTMzY8LpgkwhkGd9b7XB5OEdsnjokygYJvrCP6kmlt9qMf/PchPkwC8hnlea/LTreOSu8KNJhK+Kr597DEYIOKlazUf1V2DwZRWziF4p0frdb8k2xFX6LYoB3FtVLmw1ds4xicr9oq/AKXXuitJ22/UzdjUhrJRNn8UZTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025479; c=relaxed/simple;
	bh=ftopPbsO1vfB9C/0CaUMXA/yIbd9SaMW9cPhHY5YBkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lyAOM7I8Wqrt5S/jC1kW5Ak94dlO0mld0HvyXl6UbaUpchbZbSU0mqk1hGfrXxAd2Xmfo0a0B18PSIw8FGvl8wHjitPNRlmEZzFSkPKHGuloEKHtP5s9Mqzzobb4Us56rB8DbBkbtX0IXJvR1mpqyGxlmgoh2y5pfubGaM6xqyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1gEzfnb; arc=fail smtp.client-ip=52.101.61.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gen9xhVvHjOiG73N6CSsrRD0tXDAPYfORL4L589Gmzl6OilCbZ5aHumRcjWGjcQVd9ozzURBEeuNLHB4/bPQAXlndrNdwQuKSiTzQDriwXj7qHPYnrV6mjvLVn9nCvwIIi4Nw0pZIUCS14cgk47ovol86mavQDFd5WttEmE8kvgfQuJMRsLcOf/9Ee4tWCdT9vzaY/RBay5FwpbMyuOrxEdyu11UsriSw+O46qSMaTWZimGlR2R/pMiioPcIe4tMJTDi2Xk28NSQMURykfI965rTbiNp34kcPIseACjyWoKJ1BbjExoO5MkRkQhZAW8TNEdwok4U1lefWTtSJPkpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhKvesw7hZiFsnClNapxFgo3glTXUiC7ZRy5PmO6MtQ=;
 b=Vry3K0xewTFErQ16GWkbp6jMkJvEsui+BEKOjrJtM93e04JqhKdZDu3yf7azvuH1CGwmbMs8g3ys6CCF2KcJeF1yPPHw6ZwVtzrESW5PWnToREv9c9DrWmgcx8CxbMeCcaPAm4YNltZnOeJYPGJzE6ernhe42tPIUpXhZGPlhGXG5DzNxYf02O1o+cgnWykOcmv7oroMZIiG8c6By8RGvH1CHW8ZwlaQFl3iYERXvo3PmYZnfnLqxQYyyixBbu+oyyj1rLf3aakPluELqXbhjH/smfvQ6vDXdTJPyls9UQEzqk3WvaSi2da5QYHy8YzDpXXWgduIZoFBzlZddRot3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhKvesw7hZiFsnClNapxFgo3glTXUiC7ZRy5PmO6MtQ=;
 b=N1gEzfnbW5ns0Zdd9ik1OztMOSkNaCSkkmfZAsc7PNn/16yToqPT3KbOdVOApd9iCsTtJcB+iNgFe+jmd52S0i4oEZ4mBKQQSQ/T1X4zJ+s2ldi45YD5MJ7wBdqHwfVsB9wWBj+0GBUdcwpbZvvoxO3C4/yFAEjcKZ/FvABs2EZFHyV2l+v3WyAzlqSzEQbagYFobhRRgwwJaVGp5HSjjs8U/ErF8umH6fPS0za8WWQAyDcZs108jDRUV6CdOXmf/iGjY5JP64vGa3+4LyrFyRREXfYecrR6K4HU5cWwg3Qm08zFLNC6tZAsrn2e8VF/PNaBHiv/KiroOyqNjOO6Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 23:04:34 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 23:04:34 +0000
Message-ID: <16f665a8-6b4b-4722-93d7-69f792798be4@nvidia.com>
Date: Mon, 24 Nov 2025 17:04:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 10/12] virtio_net: Add support for IPv6
 ethtool steering
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-11-danielj@nvidia.com>
 <20251124165246-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124165246-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b1b327-19af-4616-c288-08de2badd530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ulp2OHBmbGVoNG41dEptZXV1eEowOCtjVkQzZkhSTlFXTTEycDA3K3QzTkMw?=
 =?utf-8?B?V05ENXBHWXE3MHh5aExGQUh5a2dRRnpleWVwaHpHSlFDMWxzMWtsNFBxOUp5?=
 =?utf-8?B?WUU3Qkg2eFBUYUE5RmxJaWV4TjJoOCthOHpiQW1pbnhrbmJvWGtVZElwWnpn?=
 =?utf-8?B?TnJqU1ZZMlBLS0tvTEwvSGZOSkNqTU5PRTJ2R0gvaVlvU29SMzlibmlzSVdU?=
 =?utf-8?B?enBSZVBIdlBsbG9Nb2MreUx2bkdIT2c1Nk5wenF6elVQMGdPZCtlZXhkQnN2?=
 =?utf-8?B?SERjMWt3dVh3TVdVWmc2b3d6WXc5MDdvUGMzWGF4RzZOOTM2Y2JiajkvYWNQ?=
 =?utf-8?B?dVRZaHI0UnhQMWxnVjVqK2RSQy9GSThrVHorOW03OGFyMjFEbk5lQUhYNHVu?=
 =?utf-8?B?T2huZWU0NDNhR2ZlNnlVNFd2ejduZkZhWFlQZHc3dWVVVnZPM1RWdndVaVh0?=
 =?utf-8?B?SFRjUDhzYXRjOUMyMDV1WGt6b0lZZ0pudUZ1WU5oZUY0SjlmcTQ2bjB5NnY0?=
 =?utf-8?B?eW5MMFgwTmtGV1VYMldKM2VNWmtrZXFNWDVpcVplNi90UjBiNW8rVG5zWDlz?=
 =?utf-8?B?c0t1WWxkY1NidHM2V1VHLzRBckZlcW4xSXU5dWQzTzJ3YmJZVlVidUsySEVw?=
 =?utf-8?B?b0RNK3JFRG5QWXphODhzRERzVy9PUUtCVDV3dWx6aXVxb3NNWUpEcnVJcEg2?=
 =?utf-8?B?aSt5aWczbGdKYkZFK0Z3Z3ZSN0NPemllVHRESzdOR0lQczhycFo3UjFrMGF4?=
 =?utf-8?B?cjhwdEEzQjFvQ2Q3Skg0TmtHbHpFa1hnOXdUeDJkMkRZTVNZc29RSytIQUc5?=
 =?utf-8?B?YnZwcXZVdmU2Zys3QzhDSHJBdzh2VHR3eW5GY3RVNTNTTk1YNFpxV1JoUUJ0?=
 =?utf-8?B?OU1Xb3hiTUJBYnl1cmkvU1R4U1BadWVIVHE5OUxRREZIME1UdnJCMTFya1dR?=
 =?utf-8?B?b3lHMWV4SkNSeGYwSEJOdThENHgzbGh5Wk1rWXoyMnZOWGFTZ0RlT3Zydlky?=
 =?utf-8?B?RGwzeXo2VXFIWFRuRkpKUnlINHowVDIzczhVTVlLenNJY3AzYy9EL3RFTUdm?=
 =?utf-8?B?TytsNWtOMVphVHphN2JyYmdjMGZMcFVTNWpLRnQwQ3Y1UEtzUmhVTnJTUmlG?=
 =?utf-8?B?Q1FjYmxTcUZaek5YUXFMRzI4bDVibUY4ZVY0S1I1ZjhCZnZYdm1sODRpQ0lE?=
 =?utf-8?B?RGhielJxZXBsZXp1cFdTTndYMXZDdTdXSVg4Z3pDVytyM3V4TkZJM0I2RC8z?=
 =?utf-8?B?OTNLZVpaM2E2VnRYdmd0b0QvVkQvYS9WSWJBaUk2NUlRV2xiWmVsQWNLMFBD?=
 =?utf-8?B?WlpaUlpwaktsa1Z5ejI0V1VlQXBGdURBV2x1eW5PY1dsN0FzVXUzM1NyUVNh?=
 =?utf-8?B?bkVSYS9wWWFNejVVaHJBV0haVlhNV2cvQXZVTzJ1VUFqMHpST1h3MkJhUkV3?=
 =?utf-8?B?VzFsYStWNitGTWNZbGtSY3NnNVpzS3BzMjBwOHBBbWZhSE1CSlJXVFFRQk1x?=
 =?utf-8?B?NHoydVFIVE1MQ2l6cFFFN0pMU0ZGN3ZUcVo2bWVqSUxhUVQrMUdlcTgvWWZR?=
 =?utf-8?B?ZUNTb0c3d0RoenhUOHQ2eVRvdFRiM2NWeUh3UkRnSVpMelJreGdBTU1maFFi?=
 =?utf-8?B?U2crNW1CaE9ZUm1RWVRMcnFGbDYrcjFJeVJqTXFFdW0rcEpMNXVQdjdRSDhj?=
 =?utf-8?B?TVl2YWR5RDV0WFFoaUd2aG5JcndXbUZqOE9kbUpuSGZVTUpaVnNrOFREUDQ0?=
 =?utf-8?B?Tit4NC9wSzF5N2tuUzREM3FEdDZRbE5aU3pFSTNGR1BMeTh1RWM3VFBaM0Zz?=
 =?utf-8?B?OHltaHVLSmhHUzV3SmFCanhOWlFCd0tHWm5ZK2Izc0lZWFFLelM4bXZEek40?=
 =?utf-8?B?c05vdUZvUlRQbmZLaC96T2NMejExZUcwbzFvNk95K3gyZUw5Sk9DcWVxK1Va?=
 =?utf-8?Q?KXPO0XzFGINkR79iQSr0EJ2Xs1bj2VNB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZIQkRHTDJxa2NqWGQ2VllxSVhWSXZxZ01GWExZcjhIMzhhQ1BsTnM0SmlD?=
 =?utf-8?B?bGs0WE5leHEzWXdjd0lYZGVXRzFaNk5nVzlCUGhlajlORjFPWFRYKzNrL3pO?=
 =?utf-8?B?anV5NmhCaXZBQlNFRzBKdXNMRmVlZThSbXIvR1llcXhaYWp1d3hqVGx4L0or?=
 =?utf-8?B?TEYxaG93WTVEV3RFV3VpVUdvWm9KUHM0TVd2L0V1cUxOWHZTTGJ2czMxOTBS?=
 =?utf-8?B?dVlTcnBkbk9ud0tRcXhkMk1sTTB3eXRhL1VDWDlySGErc01WZVZ1Qld1dFAw?=
 =?utf-8?B?S2JGNEl2aVRLOXZhOVFzTjF1WHJNdWEzNDBMUXNkQ1dFUThMUWI5MFlBREZs?=
 =?utf-8?B?elhNeDZmQzBMVkxPakt3NDZLdVpKYzRrUkI0ZnFER0Q4ditON3NMUzFoNVQr?=
 =?utf-8?B?NXV3d1FlQVJNdkFtMTJRTlk2WHYybUhUUHBDNm5nVENqUHpGRmJjZ2lpZE1p?=
 =?utf-8?B?bWtpMVVlOXB5NExrUUw5VEpidHRaK29BU21lV29xcVZ6QWJkT0MzR21BdVBD?=
 =?utf-8?B?NXp2UmFBYUVRK2dsVFNoVzI1Q3RmdzJ1dTNVOHhEbkY4bHEvb0FhZEY1STg4?=
 =?utf-8?B?aXhJM0o2YkNRMStGc2hmc0RrRlFRSzlLWkJCajY3N2xoMkJFNmhiWUJqc0Y4?=
 =?utf-8?B?WVM1WStNdmR2WEh2cTExRDA0S1l2RGhGQkJDc0FTYXhlOEFybVpYKzlOQjRW?=
 =?utf-8?B?Lzh2bHN0ZmlGQjlab0FkMGQwb1c3YkVVVTJySzNuSmdzdkdrcXYrV3ViV0h0?=
 =?utf-8?B?RGVsRDVTeDU0S25zUWRyTGx0N3g1OFM4emRHYzJ5clB3SXdKK29ZSzFZT3Z4?=
 =?utf-8?B?aTF0WDBGTk1RSXVTa2tReFRBcG1CTHlORW1RRUcrT1V4R1krVVp2RiswWks2?=
 =?utf-8?B?Q3ZONDBQVlAycDBVUCszM3JsRElHd0R3ZmxIcnRkOG1JWmJGUVpuS2x0cGJH?=
 =?utf-8?B?Tm8reUI0TWtBNmRjaGI5NTc1RVNwa05xZ0VseERxWmxCUGZ6djVQaS8zY1I4?=
 =?utf-8?B?MVVCTE1vaEJ0bVJYeEh4ZEgwMlorOW1ibmgvWjRxcisvVlIrdVdsUGVzMnZK?=
 =?utf-8?B?bHJ6TTlpWGxVRWVzOUg0L29EcTZsRFdORXNOandkZHFTMmdSZHV6YlkyYnJL?=
 =?utf-8?B?OGVuUWFmclFLeUJJYWVPOEpwN1Z2QVJrQzVrSVJKU0dkL01QcG1pdXVEOWJY?=
 =?utf-8?B?ZXFNYXBoQlEwYUUxcXBxS29IeFZhZWtpQjh1N0xNZ1kxTzBxajBQQW15VjNq?=
 =?utf-8?B?TEIwSk5lczBNZzZJUno0SHdrZ1pCRHA0ZjF2RUdPd1g3YzU5NzE5bXRkdk13?=
 =?utf-8?B?MzBTRy9YQWlrQ2J3eW1JWml2OHFxYjZDTTdackVxV3R5M3g0N09Yb0VRNzgy?=
 =?utf-8?B?TVp6TFN1bjJ1ZmxKeVIzNEp0RWUyQmZUMnczRjgvSzl0TDZGU2NteDBTR2Jn?=
 =?utf-8?B?QXlOWkErd0F6RUREaXZrb25XQ2orblRoOVpKeVdqZWViMVNRK0l0a25lRHNT?=
 =?utf-8?B?a3FHMkxhMVJzS2I0cFpEeDU0U2ZLa3NYN1ZSQi9Hb3ZkMkw4aVF6TFVzNVZT?=
 =?utf-8?B?bEJnVS83V3AxejZTNk1lU0dBYk9uZFpidWEwWVZiRFBLdThQV3ZDT0dVY2JE?=
 =?utf-8?B?aG9wNk4wNUFxRkNxUWQ1WnFIQTdWVmp5M3JmNlo4bk5acktGTndDeEtwR1Qz?=
 =?utf-8?B?VGd2T0g5dW9LSHh2bVE2TTZVZVJzbzJZWVBtSDVTTGVMeE5TR01qaDBIMFpr?=
 =?utf-8?B?ZUc2ajJMUVlPOEJqWkZYOVJXNHliZmh4VlVJMDJIclY3YlZqaXdOY0F2ckhF?=
 =?utf-8?B?YUthQVV4eHpKM2NyNjFETlpyNFA1QkRRTUpsSEcvRkdIM25uZzFzMmtraXhW?=
 =?utf-8?B?cC9BM1lSa1pQZy95TEI1R3NyNFMzR25aK2hocDdkK2JWVU1teDJGTW1ZQWtK?=
 =?utf-8?B?djFxV0F1L2R5K1VxSm8vVzFKVXh2cnZoRVVWcVhaSnBUdnJRKytBSUVDM0cr?=
 =?utf-8?B?eURQZEQzZjZvWXdkVStQUzZoWFdodW1QVWF6R1IzMjEyVHpXNkUvTXd5VEtz?=
 =?utf-8?B?ZERYOFY1R1BBQWFPRThJbXU5M0tjNHIvTDJUN2Mzc2FTYjZNMTJtNnNZd1Vr?=
 =?utf-8?Q?iwIJwii+U2WPuEQC+vEAjcH8t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b1b327-19af-4616-c288-08de2badd530
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 23:04:34.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5A58WlvzZl038S0nYsD2azko041BAmEw1X+19tntuVxrvyS5ARrQLWYafs70yPdVhZmCz8WlEqg4HtktroEHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566

On 11/24/25 3:59 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:21PM -0600, Daniel Jurgens wrote:
>> Implement support for IPV6_USER_FLOW type rules.
>>

>>  	return false;
>> @@ -5958,11 +5989,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>>  	}
>>  }
>>  
>> +static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
>> +		      const struct ethtool_rx_flow_spec *fs)
>> +{
> 
> I note logic wise it is different from ipv4, it is looking at the fs.

I'm not following you here. They both get the l3_mask and l3_val from
the flow spec.

> 
>> +	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
>> +	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
>> +
>> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
>> +		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
>> +		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
>> +	}
>> +
>> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
>> +		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
>> +		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
>> +	}
> 
> Is this enough?
> For example, what if user tries to set up a filter by l4_proto ?
> 

That's in the next patch.

> 
>> +}
>> +
>>  static bool has_ipv4(u32 flow_type)
>>  {
>>  	return flow_type == IP_USER_FLOW;
>>  }
>>  
>> +static bool has_ipv6(u32 flow_type)
>> +{
>> +	return flow_type == IPV6_USER_FLOW;
>> +}
>> +
dr);
>>  
>> -	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
>> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
>> -	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
>> -	    fs->m_u.usr_ip4_spec.ip_ver ||
>> -	    fs->m_u.usr_ip4_spec.proto)
>> -		return -EINVAL;
>> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
>> +		    fs->m_u.usr_ip6_spec.l4_4_bytes)
>> +			return -EINVAL;
>>  
>> -	parse_ip4(v4_m, v4_k, fs);
>> +		parse_ip6(v6_m, v6_k, fs);
> 
> 
> why does ipv6 not check unsupported fields unlike ipv4?

The UAPI for user_ip6 doesn't make the same assertions:

/**

 * struct ethtool_usrip6_spec - general flow specification for IPv6

 * @ip6src: Source host

 * @ip6dst: Destination host

 * @l4_4_bytes: First 4 bytes of transport (layer 4) header

 * @tclass: Traffic Class

 * @l4_proto: Transport protocol number (nexthdr after any Extension
Headers)                                          ]
 */

/**
 * struct ethtool_usrip4_spec - general flow specification for IPv4
 * @ip4src: Source host
 * @ip4dst: Destination host
 * @l4_4_bytes: First 4 bytes of transport (layer 4) header
 * @tos: Type-of-service
 * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
 * @proto: Transport protocol number; mask must be 0
 */

A check of l4_proto is probably reasonable though, since this is adding
filter by IP only, so l4_proto should be unset.


> 
>> +	} else {
>> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
>> +		selector->length = sizeof(struct iphdr);
>> +
>> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
>> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
>> +		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
>> +		    fs->m_u.usr_ip4_spec.ip_ver ||
>> +		    fs->m_u.usr_ip4_spec.proto)
>> +			return -EINVAL;
>> +
>> +		parse_ip4(v4_m, v4_k, fs);
>> +	}
>>  
>>  	return 0;
>>  }
>> -- 
>> 2.50.1
> 


