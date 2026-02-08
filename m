Return-Path: <netdev+bounces-257837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEO+KUy1iGm9uwQAu9opvQ
	(envelope-from <netdev+bounces-257837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:09:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 214A01095B9
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AB8530088B3
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AD34CFDD;
	Sun,  8 Feb 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jugkW5CW"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E849346E75;
	Sun,  8 Feb 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566520; cv=fail; b=k75BU7fYWJZc2He5KysnLT3I2Cz1HWckbrmFCkXaStLZB6BQJxqrt3V745Jip0BCK+JHlgOD7zDaW7FscooBCNV+TrF+rzsVzB96IChDimMVLfTPsbaRS2SP6LZzMuldo0xsjTZeKip4Nw1zLzoYa6aeRfmQmFJasqzU0wquc/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566520; c=relaxed/simple;
	bh=tQwZcXMyBiynY7uMoOnfuVyshQMPytTCVDSoRwoS1/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KqeVw/rPhyTrkfH4qtKveoXnzcuCXn4fYyFRUiwprTJa0bcrtNAKrlhHOyB8nEFR307seNi0pCD81Kum+ldYv63UV+9xqHpcVvwPXGH5EdA/eVbmyvpmzO2amZ6abqdPNFbMthXD8kis9sx5AYB17KEYf0dcIYT1cSqJThuwp5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jugkW5CW reason="signature verification failed"; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPPyKzbMyU/9n8fhW8CVGc1cqy+wFQPrS42oHO7lj9p5ZB/31I1jjhMYVN98F/ltwviDETmm2Kc7SoM7MS3rmOsf9/Dws2R8IJMzhbKAWmZeJIqjtacReRT8z6TeM1xGIxtkrErCvTTST+acRBJMWdcuk97Z5PpETm7gm8lfrjlpEifTfxXcAEMFyfEAu9laMvAspYyAfIApqDHqih4RQID/oQOChDlH7myFNPwh+ggfVNpr87PySm4xvbcxEgnkGccPLV9Qp8Y7SGQ8fkLzHtpJrOHwoNHUi+/HelEm1QgAu0jU7HHhdsH9Jj2YOvGp/gs+KhC8fo31kwQeJOkaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/L64+3Fu9+I/21qu2A7ynjjAgWpkRL1salgtiUBe20=;
 b=e5iGgR3uf7NOWf382Rpucqd3qcpx6xJyGZNxLeteBdRg2t7/RnsdDyI7AUuWPp6orOV8ePrQAeYv7ztzGWFPS3EQV9EYRdzeFgkw4RYFQU2lZzMXkbQwWAxW7RjGe7i3U/XBNqAios7XZZfKMcXSNPxoxaUT28Z63fbjuBQMTWJzSCOmtqpnnRrxRFk9je0JI37b385gAEYLqJ33d4nPTUyPPG+8DvlI5xOOXLgr166Fq2ZZQcaNysOEHJ5ytYcFr+koUQmSOiJrKM3c6s1uIVcrxVYLDuiQ2tZrQbvdZ/n3s9huk1QzzxeYABoH9A2337eagEe0uDOIdCsW2LdkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/L64+3Fu9+I/21qu2A7ynjjAgWpkRL1salgtiUBe20=;
 b=jugkW5CWbcat1HmhN9L0zs60QEx0BgTcIl2Ux+Ux1kDLG0kYXwhnZ1mDFGRBgPI3kAcUF8FXTfuVFAi9ol7xtvT6z+94QJ1rhQ9eJhvagYy4W5POq2TtfZvlogXO5EkbcYYrFj5aBJXcgwHhnrYppp8Ge9p71Yvy/+o1CYWWW+mdwlCkJxu0UyBrG5OUzJTfowidHr31nzK0e87nEh595hGyDv5ftktGw/J1Q7sec1rGVURUAJ8K0E4JkEXrvCsR4ED0hTPU/BCqzmWkMYiTvjeN1YLiKy2fTN1cSG2RaDWB7GIiAaMv47Ufhat6lyVeswzYW4wQ8EdioOH/DRsOxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:01:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:01:51 +0000
Date: Sun, 8 Feb 2026 18:01:43 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] net: bridge: mcast: avoid sleeping on
 bridge-down
Message-ID: <20260208160143.GC154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-4-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-4-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7ddc83-46cc-418e-122d-08de672b5f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?j5rTc0JXYD7AtxUVQxUZlgos5KmeB920rrgrEZXXIcCDVe+8FOQaTQVeSc?=
 =?iso-8859-1?Q?A+z4F/21vQWX6K795s2J9/xcPMSHCTnENobZWkseOanqBL1t9w4dsIccWr?=
 =?iso-8859-1?Q?nUOOXX90+FYJTn8lL+cgTZQsI8VJVaUM2w6dj0SDERxmmXh8m+yPJR47By?=
 =?iso-8859-1?Q?mZG55QxQzGK1rOZgu2YvZwGvJ5Xply5Mu5x1ZNq1/R66Zuq22rQyQgBDSx?=
 =?iso-8859-1?Q?tf2HtUAS4F2FYk1JK9cf9OFN/iM/ohIH0olKjc0CjsKbwfihrfxpJfIs/W?=
 =?iso-8859-1?Q?yplBGKJgI9G1z31PKrwrRDwe1/sfTxM7NnY9F51zFS2M3+Q81omtrwQw9S?=
 =?iso-8859-1?Q?ZWxsIiasUB4OUf/XMdc8uvNf0dvVPFVk/GxUTcmltRRH7hAxVMeq3NnxDu?=
 =?iso-8859-1?Q?EqOi8cHD4fRCL9LnHYVgFu7NkYlJbc81ndLLULUav78QJTGUOD7f9cSSJi?=
 =?iso-8859-1?Q?fXEabGtxHyYVTBBYHgNz5kZYqTHTNzL2aJ2+AD9GqGXBEratq0A2OBWgef?=
 =?iso-8859-1?Q?fpxKC+qaSmrL8A7LDwOtBmCJiP55dbSTQOyQ1pZZzK6gZ/bJWd6ncP4bhL?=
 =?iso-8859-1?Q?+ORIm9ZTpHykbzwzaBRMPdplelMEWfvoIiqnGbAJm05Xxvl/DAOJfGuhJL?=
 =?iso-8859-1?Q?TOlW0R1HFclu7xIazfsxPfIh0/h3dE5l4FzF3hFZ0L+3OAWvAIc3RVaHHC?=
 =?iso-8859-1?Q?llYB+vlLLW0FEoOT7RLFljpVnHhnrkt+cYggCnpmH6mbu46MfBfR4xT1nJ?=
 =?iso-8859-1?Q?MBtEPHn/PcnQA4ruyFrCQc+9e2HTMIEimulXe/BQQw5s7SLf68sHZsyQ03?=
 =?iso-8859-1?Q?KcicmX254AcEqnyhl+SopZOqzTRBiC+BVTrqd/VNlp6ynRZW9zfQNNTwFq?=
 =?iso-8859-1?Q?KPWmYcI01LEb92c1PAegB9DDFzduQtht03GDlmKzk6iUGuIftyiBNXt6Ln?=
 =?iso-8859-1?Q?C2gjP8b3Oc7o8TPgLY5rhERCRdZoZtmBF34pnqoQD+oAS3CLPoJZyKiR5X?=
 =?iso-8859-1?Q?qivrK/J38Xl0xBNJsKytBixxlamB/OLkpXr/1eQx7P7Kfq7uSjTE4YH3wX?=
 =?iso-8859-1?Q?9MfXYqCNTmXHuv4R0mnz67XUVAUB7oSRjj0wLfc0A+9zV0F9qS23JDl9DI?=
 =?iso-8859-1?Q?TyCcmyl+3g3df9wzxv2UgrDZr+sJAgyACQu7Z431m4LXVlHqIlCY77LMuP?=
 =?iso-8859-1?Q?9gADY5sDVg5fC9/zoj5NPTZA9R9AucM2eXPEINE7UzYmOHw5EiV6GWEUz/?=
 =?iso-8859-1?Q?zHqlV33aWYuE5AzfluOIkI/f0vYOyedmVi/LVh2eGuNgJLIACwESE1xqVi?=
 =?iso-8859-1?Q?HKyj2l+iE2g9ZxEi2JZsc0WQOaDDH7hXL+1k7nqjE+5oP7jgWuSQIx/+Qw?=
 =?iso-8859-1?Q?u3VW0Cqy7ZOkFnFP+XX29ns94isEW7IpERJ3NsCyAT75EnIsbZ9KwYyZ+G?=
 =?iso-8859-1?Q?A1EORzOVH3hpqx4HpTm8CUlWzvdyhzSsLtzRAjk9PDq0ddl477IHcVzGXJ?=
 =?iso-8859-1?Q?Am7aSizZFlnyYm5TID/qQIZ0ckVCvM4Ch27DcMwa7CvXkkkeFd4zUnjlnA?=
 =?iso-8859-1?Q?iA13QAcHOFzkFr1DHpGlb4MiUp2YRrGMifLEs+ib8Qvv3KuzLaYajGT3ry?=
 =?iso-8859-1?Q?hioB7BiKXdRp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?AjmN/InvbrmrabREDhNAx6HsZHrUb7EPDgIt1T/BKFvkx0k1lc6v4AWJlh?=
 =?iso-8859-1?Q?/KnHxXxS6BCuXBBDLkh8UV0cB5TZvMf7amutjxcdMgsVsTBU47T5ja717/?=
 =?iso-8859-1?Q?E1zFknYL1fjMfP+MierSaUl5ARn1sZsuEAZoLOf8W3hakif8a/5IxRDlmj?=
 =?iso-8859-1?Q?7z/mNtldzLOou7cXgYkL/ShKqBT8a4DZKx1jFiE0Ee0OqCjphgxmCZI1aV?=
 =?iso-8859-1?Q?TB/FqevzOpJy9Q4oqe5FTkwRJlocyQ+MbrMYF0v7gGgHF6ZKqRWIOu8/4v?=
 =?iso-8859-1?Q?wNu/+KMlvsbxEtS1PjgptMoRKMkW5ckQKCtKs4Dmmaq0hX1aBecbkeE4Np?=
 =?iso-8859-1?Q?4i8LfsayHs0uk4rCLofy8oGKQKyDApEgn9ORylfncOqaH8doPN7O814mIb?=
 =?iso-8859-1?Q?EvTX68kWHBiGjokViw/78L5buxiQuKZb0dPDHb1dkvMKy6nq969Ga7rF/+?=
 =?iso-8859-1?Q?aNxfz+iNJy8HMSYBeqhDyBQvf91xcSII1rQ6drTY3oitlN8itPjKayU4lU?=
 =?iso-8859-1?Q?lMi1loahMBxzKGXzjOUjx/yuvpegqdtUitfMkOtK/gxhXCbiDSPuHwUoyN?=
 =?iso-8859-1?Q?bWgBu1urv46PemI5BSLVtQ2UzMkzj8JidaQE4R+4OYGgH7kZF/Adu1ETM0?=
 =?iso-8859-1?Q?t8klypPhde69OkTu8GEUYXyCyRlNlKI2whm96uSC5IkmdkIvgxRXVCsUmB?=
 =?iso-8859-1?Q?DjCxkdgRdWbwp1aLxYTpO5VM4Lf9Ej7OvFeSRua185XNXy+JRFQqtncTfz?=
 =?iso-8859-1?Q?ZmkIAsmOEM9MGlgM5n1o84jsnfEEx5eTkKhxI4H3ztY+KWNSBa6OuGpI04?=
 =?iso-8859-1?Q?7MQd9JapGcSbTnLcPOPYxYSs417MkfTT2vLe+u3Jw+5Ws67rmsdNvFtE1j?=
 =?iso-8859-1?Q?1yVIxDW5UwAWFPwPfbV6XX5Ju8Ghr6Pg7sabpIed9Tqg272As/R7xLKThB?=
 =?iso-8859-1?Q?sVBXH5KNjJsWEDr+7NNfV/PHPIAwyLC1a3g/+hR4Yep4r4Cfo61aoP3URv?=
 =?iso-8859-1?Q?RMQh6c3Vb2RFT9Dw+zRqnvMBbHz8Zd38mTsMbYY9+AsTCbR6tq2loOWTu5?=
 =?iso-8859-1?Q?FBCymWsE6JIWXvMFM58WncRm301MgoBpNlQNNKroMZz/9yWXul+jrnJIgM?=
 =?iso-8859-1?Q?3UvgzDw89JQQtGdHeL71o5uEER8WUKSxqzZOhXAphVEcSDYe2UkHcfoHKM?=
 =?iso-8859-1?Q?Updl5mW2hT+qtZZWVQ0teNUjiQ5COMRtvJdaWYoh4MA+VSHpd3bJVV3HCE?=
 =?iso-8859-1?Q?EPvZfZh1ua0V7567NW/cB94BYO742dltJ0GN/gPv+h6gjL7DE9C2e5JFWD?=
 =?iso-8859-1?Q?dAfoOxaAib/lkQsVURZwvjJCxwo+0UQR5MZE8BxGiv9onJGCLn0jWuTVFW?=
 =?iso-8859-1?Q?llIdIx+8lbU+UPLM/vFcUQwShgETH/hWrJ31orS2l4lF9VWXX7DSwSTXlU?=
 =?iso-8859-1?Q?ZGIbIFbAeR9C+PaRpzESIe6Jnk9w1ylG+/bipbmH+CFSx2ZoLc3WHQ/XNW?=
 =?iso-8859-1?Q?14w8a2FXL0xQRJaSIqfA4OkMBX/XZtUogBYlOOEzS1TfYtBfmFmhrCaTLS?=
 =?iso-8859-1?Q?5Kr1WdFRuJ4peH1Z/vJw5rETmKAhWCkuKoxwbwcbVchDynGlHeD+UXB660?=
 =?iso-8859-1?Q?CIv8XMHSDTMWY0xwH6EXRT59Oe3IhDMha7ySCk1EH/isCskNnxRr4Ajfok?=
 =?iso-8859-1?Q?aUYTuzEWrEKJVZ9nFI2X1/XLjeat1BWnPA/kCBKbwOk4umpbZf9+Qf/4ge?=
 =?iso-8859-1?Q?ZnnCWYS1inI3g39ZsvPWwBPD8nn+CbLv3/yeZZkMvTr2Lk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7ddc83-46cc-418e-122d-08de672b5f74
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:01:51.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxemsMPUglkvrGkojQ1HiAMothFXIShX8Bwi9QRhLaMCktHILAdM5Yj5yOu5ocsvrXMm39MHdDjwZI7jruLI0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257837-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.969];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 214A01095B9
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:09AM +0100, Linus Lüssing wrote:
> We later want to use the multicast lock when setting the bridge
> interface up or down, to be able to atomically both check all conditions
> to toggle the multicast active state and to subsequently toggle it.
> While most variables we check / contexts we check from are serialized
> (toggled variables through netlink/sysfs) the timer_pending() check is
> not and might run in parallel.
> 
> However so far we are not allowed to spinlock __br_multicast_stop() as
> its call to timer_delete_sync() might sleep. Therefore replacing the
> sleeping variant with the non-sleeping one. It is sufficient to only
> wait for any timer callback to finish when we are freeing the multicast
> context.
> 
> Using the timer_shutdown() instead of the timer_delete() variant also
> allows us to detect that we are stopping from within the according timer
> callbacks, to retain the promise of the previous timer_delete_sync()
> calls that no multicast state is changed after these
> timer_{delete,shutdown}*() calls. And more importantly that we are not
> inadvertently rearming timers.

Can you clarify what you mean by "allows us to detect that we are
stopping from within the according timer callbacks"?

> 
> This new check also makes the netif_running() check redundant/obsolete
> in these contexts.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_device.c    |   4 ++
>  net/bridge/br_multicast.c | 108 ++++++++++++++++++++++++++------------
>  net/bridge/br_private.h   |   5 ++
>  net/bridge/br_vlan.c      |   5 ++
>  4 files changed, 87 insertions(+), 35 deletions(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index a818fdc22da9..d9d1227d5708 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -168,7 +168,9 @@ static int br_dev_open(struct net_device *dev)
>  	netdev_update_features(dev);
>  	netif_start_queue(dev);
>  	br_stp_enable_bridge(br);
> +	spin_lock_bh(&br->multicast_lock);
>  	br_multicast_open(br);

Maybe move the spin_lock_bh() / spin_unlock_bh() to br_multicast_open()
and have it call br_multicast_open_locked() that will also be invoked
from br_multicast_toggle()?

> +	spin_unlock_bh(&br->multicast_lock);
>  
>  	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
>  		br_multicast_join_snoopers(br);
> @@ -191,7 +193,9 @@ static int br_dev_stop(struct net_device *dev)
>  	struct net_bridge *br = netdev_priv(dev);
>  
>  	br_stp_disable_bridge(br);
> +	spin_lock_bh(&br->multicast_lock);
>  	br_multicast_stop(br);

And like br_multicast_open(), move the locking into br_multicast_stop()?

> +	spin_unlock_bh(&br->multicast_lock);
>  
>  	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
>  		br_multicast_leave_snoopers(br);
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index dccae08b4f4c..f5a368dd20a3 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1665,6 +1665,14 @@ static void br_multicast_router_expired(struct net_bridge_mcast_port *pmctx,
>  	spin_unlock(&br->multicast_lock);
>  }
>  
> +static bool br_multicast_stopping(struct net_bridge *br,

Nit: br_multicast_is_stopping() ?

> +				  struct timer_list *timer)
> +{
> +	lockdep_assert_held_once(&br->multicast_lock);
> +
> +	return !timer->function;
> +}

