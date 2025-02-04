Return-Path: <netdev+bounces-162433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3662AA26E33
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49EF1886C99
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242F207A00;
	Tue,  4 Feb 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hQ1rqnsH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE576205E26;
	Tue,  4 Feb 2025 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661067; cv=fail; b=jFDTF7Q4oU/OPvrljtJ/xgsKt8aV8lCVUbWd5/TSolAuvKuJClUY26V/XCKMpcbEOqpUCvuyxZjmqnUvSayYjLpEoIUejRbDS6ujD7YFCMSx58q2qJsyfk7uJCzIQVjyP73DY/DjfQeVYUrjgDofpun8jy8vl4Foz88+nYHr9zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661067; c=relaxed/simple;
	bh=6MkKkRioUn5WRnWFyDOFDmP9efdnWY/Rxr5xTGUSia8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o0LHdW31stLXFNF+rK2dVgE7BvQrAXl4qDNVO7d7KUDoU+prTNNnKrw6mcZijWUyj8C5CjwvPD8KAyjio9/aKS1ZBAbXvVvl/EnoaeqWc69fdQhu6QEStH9vsWbYv2S3NjRj9OcjeojCmOsLftGc91aFyqSYyCF0Ht3GoUPDHTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hQ1rqnsH; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZA4XhVCd6v7h6321j9YrWuc4lwPCWGw5Gq5TKiu4vHtNHWyT20jAObA4PzSbXSisP6s5MTvGkOxgP5Uw5Oi5jz6EuKVMT/YZPlybyzCEL8b7TyRfVh89MyMyOI9BmMf9PNqDq99fIr4ZsJDwFWeJwFa5P0rGXPGNST5XhTiVhEmYJ0jHixn8ZY0WAmrNH7Cxsb61t9E8/Q9uQGJayk9JLrkYOhm8/UAN8Pem52qnTIQSJSuW5Q1Q8ziy6Sju8MLtEDzPhKrIiY4BZznIzjz92FTRAFZ17ecU0b68fc7JkpycuDAeDmbfEDmVO4uOWqwvHN4EW98JjTw01Ja5DrUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifQbiIm1cCHj1WbAwQKRihPbrgfFdXQmaGoUO6kfV6M=;
 b=F0faWhY2uEFIyPR4z/4fVXFDL4tWezG33SOkLzL3mWc4zr5yJIj3ZP9GMHMXxJQBmMxCNxzN8JJjuJ1JEtRNffFHNerB2eQ7LJrDzMR5CdiWpn//PV6RGlEKhsUdp+q/zTrVhIlkHlr780tZjLn/wplnBzR7T6aqT9sMYSmHopfjxEBBt+vGpOvnHsllzraZMM6OQk+9Nx+T4U6Sr6b9NXsfZl5nXIHUdTUaAO+hD3hOSxdld7kGw070mQp2iUmJu9Qheo0InJy/VRAGgX7MeMKlLtKWrcJ68R4umUZ7nUlXUH9DVgmBVIdSC+pGRRqybhpAPCRjF1XT/r8C3CVHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifQbiIm1cCHj1WbAwQKRihPbrgfFdXQmaGoUO6kfV6M=;
 b=hQ1rqnsH08J2qWyOSekIjyf1O6Pt6HBiaGthNodu0LhvZ4MOURa4UbGB+bY+nJrQoCcOr7TnxU4usr842ciIuGRZPen4H666zEm/XHXiuALpZnc8xx8RTG1de0eSbZntKoAhltomg+oooR+M/OoMg5aFd79MifxDglZR3WrOsD2HCPctWy6/uruZWlL6t2sVQ5WAOk4RC+jth0ZwLTrp9JrkCjrx8+SiDjXbxthhFw1ifTRZ3HT6iKhJKtbjAWW0EJMABKGzJkawaU7csgUGKsjxQK2CnF/1hsM7vLNXviK3Yfb/SzB9mPX8Nc1PgFf+peJHXn+utc3hy0W+tbNYBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Tue, 4 Feb
 2025 09:24:22 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8398.020; Tue, 4 Feb 2025
 09:24:23 +0000
Date: Tue, 4 Feb 2025 11:24:11 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: linux@treblig.org
Cc: petrm@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum_router: Remove unused functions
Message-ID: <Z6Hcu4RgM53fS0rr@shredder>
References: <20250203190141.204951-1-linux@treblig.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203190141.204951-1-linux@treblig.org>
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: b755a513-8363-40d0-8a0c-08dd44fdb617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oC6aR3QzcEDIuAG434/cIojE0neTYMb7cr1AIKgEZ8/MQq+Mgf8TLsNXEMAk?=
 =?us-ascii?Q?MqguFUW+/ucngGwX6OOelD2MABfkLgNKkHhGWWfujIP+tAN3zgRjxAYdonGb?=
 =?us-ascii?Q?qhM33FYU5HogfDFKKmiGi8uT1K9gm4voxhdnd65U7MVe0Wgrd5daKuh0+VZF?=
 =?us-ascii?Q?3B02YzUnrwvQZewcUVqlx0WfUGGdsRs4+Ka/tYvV3KLOchGB+HTtSO9GfvjM?=
 =?us-ascii?Q?qlxX1FqFsI2S5u0KLKtY6EFQ7qwQ0qvt7pI7U50zQKi638LgTTOM9e9d5Qlo?=
 =?us-ascii?Q?L4sySeJkVjIWiBOjeYHV1HABEupn1WxOWQIS2ifddLVo9ft2nsBSPUDwDc+j?=
 =?us-ascii?Q?tco0s6He9Xv1xSSSNU5F+zT+pR9UBUjchfbWNegN/fUJVfarpwF6SlPsUHdS?=
 =?us-ascii?Q?w7JQoRWcFAblmMA9AFBMXZrBh234ez7aotrTWDP20+kzwJ/BnW/yaCDlzywc?=
 =?us-ascii?Q?2ryrIMiTjHoC9fRZa1pSNXRFbqh6B9z+fd6gIe1FgCauq95Q6pn6qSE1F6HI?=
 =?us-ascii?Q?TfX0v8xzGahPPylh968vIq3EUC/HqEDoZ4bof0uG6RDnlD+5lY+P9muUdlsV?=
 =?us-ascii?Q?t8ntLHYV84a7wJdAZpClFqWGAO8z6p8Y6mI1Mnbn1DBymdSKv1pjKz10PI8A?=
 =?us-ascii?Q?JgSrKjl7Kmid1iY+y3MFIZi2FAPg5+VJK+luv9aENzsmkkU/kl3js/MG2Vdo?=
 =?us-ascii?Q?gqsDfkTQ/5NKJ7XBcPyDtCQ6lhZ/YDGFlfRS/wz6QTggSONnOavDLGWSDA2l?=
 =?us-ascii?Q?4AaPExprnh14Rh3tkalHePITTzAaLwwkIgNBEp7xlBi51OPUCJrU1Ii3mfqJ?=
 =?us-ascii?Q?2ZP8+0+V6mC7WJ+tHURcWSzxGOaA9Hy3e2hM7anuY2w95EUQs4E+cMFA/wtN?=
 =?us-ascii?Q?MlCvreKyprpD7wABUo+0yJBm74kjn3rDA0HNZFIzItrlzMUWfUR/7F6gTm0h?=
 =?us-ascii?Q?AwUzraPMqnL8e57JDP/oBOIu7WunguLyVdQz0Cj5sP8ou5dSbcVYtmrUXV8G?=
 =?us-ascii?Q?+fE5XXUpR99urgpDVhVQzhOpN8BOxeLS1Hen9YoEnv/NkDvwGk4/46m4f7Y+?=
 =?us-ascii?Q?UjXWJnh514UTJfe611tBJMtZs03lH2t4Pvdnn+lwMyZVrzfj9tUkBW+MqxVm?=
 =?us-ascii?Q?2ILHto4xIYU7vKe5TXCzrfs6+GZbC9SzUKrTdQkO5ukPtIarrjq1uXYNEunL?=
 =?us-ascii?Q?WtvPDa4pBxLQxabhIvD0IGvz07AhIeR0BOMTwHfT4yNg0l6WQypoSIbZZFOw?=
 =?us-ascii?Q?ayVEe9RCgiYs52qruQ2dTi8JNbAvDZ4uCuPZYPLQMOnK7tFMxNSga0VNfccR?=
 =?us-ascii?Q?rxMz8v6AJXVqEzmCpt2jk8ss4k6KSORsVw1TiHxq8M8xiuUh+DUoD1/1ehna?=
 =?us-ascii?Q?NVWbOXOMUadXwQ47iUh7TbhQvVZE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q4ymuDhcgdAuwdR6ucst4VJNU6r2AELjtuQZd99GHa4bGQ9q2IyOEMaZjlh2?=
 =?us-ascii?Q?hDtNoj3NAYW/Z6MRVgmSr5JKsPK8EIxFit4X4PIr4iEogQuqignpboiuxdtE?=
 =?us-ascii?Q?3bDwprffkdsnBB0ewMRMwLXtvPy2v0N+qHZCEKN2kH0Y++Su4NxKwGFWQTkI?=
 =?us-ascii?Q?KQbCbs8qJBSt8U+I78B8+pc+gfcijWGz/ob4y6Jar5WT4tlcoAJK9dy0t/6S?=
 =?us-ascii?Q?xOiMtKgmpEAP/ChKy+RVAXcpjniZoIP1GvmAvYfpr2ijoip+uh29hlIs/DiG?=
 =?us-ascii?Q?Bfi5YKl8+IxruIylgKPHk9+ksQO8gcFk6QB7h04iZJJ6kQtWvf1g5sqgWwVP?=
 =?us-ascii?Q?II5ymCdToyeVDgn9qVwrdUxWAIlrAsS4IccF8T+bivOFcSW06UnX26QmdRRQ?=
 =?us-ascii?Q?cfaiDCV7ArVXiRml4eNhKt7Dt1Tw7AVV130DDfD4eV0zpP1Z0gZROJz5Ui0Z?=
 =?us-ascii?Q?ebf3UrhhA/6xG2yzObiE92Q4GSWMtaKDDbsGmTr+r6JvCdPrGDENZP3iinn8?=
 =?us-ascii?Q?+SsCHwpsAOqrkg5rIOkvUXuA13yQk5T4056YHX0346HJsJKN67ZUw4n/K7+V?=
 =?us-ascii?Q?egCnd9iq6mvU1HUCsJbpI7Ay5xSrHzblqCTVxl5Lxv2IKg9bI5YfFwCvm3XC?=
 =?us-ascii?Q?rwA4SWc39UvL3REQknTF9TuAiZOAbVA5yi4nd+idEZRvFBroznBedp0hypuH?=
 =?us-ascii?Q?Iz1C4Y8WR/b3xtRMXh8H28/CB7W9a14Pg6h6jXYxkbmc0KkIHrwwgT2ldnHl?=
 =?us-ascii?Q?7EKDuu4933jYD9vugxud/f2wIP8bXMDryL1w8gueM6DlIHa9jyRzld2ozdKA?=
 =?us-ascii?Q?sjd/hX5QhYsWz77z7a5A2VCh60TJACUV2KuutO5MlEyzPaQGIE58ppv8FRz3?=
 =?us-ascii?Q?t6pRu3RaWcSBhMweMiFdqphnlcxSOKqnKFKVF7I74TT28I0LYOQPjii02/T4?=
 =?us-ascii?Q?TSxIbXlkSbIcCjOkouyvU9CU8ZMXLgXyu5UMoIed122rv4fZpBGbZkO+skSo?=
 =?us-ascii?Q?sm85WO7pZHKYd2YHzbURzOLI0r5wMNxGGx/IDre3doCRW3+eF5nv1hfGup4m?=
 =?us-ascii?Q?CgT9lWb7ARLyFZXxtKq/ySSvamrcKrWiYZItcEKdC2CxjS3e/lFRmGq1IaGH?=
 =?us-ascii?Q?/89HoJxDZW+BZjCTPyq5eX7BEH43/JogInYzDrMJiGKtCLvGRJLffOFgKie2?=
 =?us-ascii?Q?BzD+yQ/eIBWkQfohSAUMhcUUqu8y0mFzmWbiIn0Ks+Cz9QXlNXWzsCwVKn6U?=
 =?us-ascii?Q?ako1x7qrCgwJAwgAg0L+/UPaDhBuOxzrH58E2Up9zABf0Z1RWCRvDHrfEFtU?=
 =?us-ascii?Q?ODgNewybNcE950ILFiZ1MPe9jYbxXHENoEJoa5K07I9OoZhASM/DYmjTcoX2?=
 =?us-ascii?Q?ybvW2q28mcl0iOx1tIINsXKvrSEcs77m1jaaJR9R9drgqqUAISUT2evEi+bS?=
 =?us-ascii?Q?lSObA8+mIX0sR1AmjSBldYIHWHnFwzakio207/hepUlZfJwpbWA6awr3YeYQ?=
 =?us-ascii?Q?B38lamdGMavkQLzx6GaKzr5Njbvd+v2eU9QCqh92VFfXTYZivCNzjXJM3HJz?=
 =?us-ascii?Q?vEFTVT/kybGb2aJP7UU9MBY2KqQT7YZZHAqKE6RR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b755a513-8363-40d0-8a0c-08dd44fdb617
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 09:24:23.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0uoigQrpzX5ktnBUcgcMZQGcU/ehjlAPLf8ucs9GL4MhWGSM00bRq9la/1bBXJqQnPiPNiJjzwpTs7/wxk7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612

On Mon, Feb 03, 2025 at 07:01:41PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> mlxsw_sp_ipip_lb_ul_vr_id() has been unused since 2020's
> commit acde33bf7319 ("mlxsw: spectrum_router: Reduce
> mlxsw_sp_ipip_fib_entry_op_gre4()")
> 
> mlxsw_sp_rif_exists() has been unused since 2023's
> commit 49c3a615d382 ("mlxsw: spectrum_router: Replay MACVLANs when RIF is
> made")
> 
> mlxsw_sp_rif_vid() has been unused since 2023's
> commit a5b52692e693 ("mlxsw: spectrum_switchdev: Manage RIFs on PVID
> change")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks

