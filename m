Return-Path: <netdev+bounces-202455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D85AEE020
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BED07A1968
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3219B28B7FE;
	Mon, 30 Jun 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s6AWBu5T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782F28B7D0
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292499; cv=fail; b=HJl5DemROsLJ/z1CcIn4vb8J30mNNQKkb+lFFBdlK4ZXfKeUqtnTpnpoxI1TANQzJXw+4X74Yo78xuCWjEKA3WUVPqbDi+xbnTrILh4aT57fFodZIzp+mSUXzklSBYb5Pw5d4bjorWUnCKq9VMU0/3oY90PY5r8Fp9BN3HE9K9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292499; c=relaxed/simple;
	bh=94Ot5LB8iLADONaCb+f90SmDb83n/C4X2o41lZVCCbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HORnP6yLX/KVZtNF5vl8wVaBjqStG30W3EG7xhOyjA6Kcamzrx3UY5GjOwhuFCI3Nboo5+Bv0uj7ofFwJlgOQxJVbcA98MEeN+7h+7C1r8CHnkxgcP1AMzH6z48h3jwDtUWamUi0SgsUaQrI5ETkQjVaSfpREidy84eyr3oAbkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s6AWBu5T; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l12ngNlYoAhxzoTxNwiShcnvZr7EVVt9UOAn4IYT4fHl7Dl1HkrwxFV6ps2/RsThXhWRWN1QE3LMlcWWkFVmGearCtZlYcPYYxACxjNRPo574D6C3wjOXLN/69e4NBOwKF8LiPNxLlHP4sFg936jOPe9igktkOhjCxS4NUiff7zUqAadbaBjcqUU0uBsIut41Fb6W36ivSV8yGVRSMMxR4uyIEMrrJNZuKWXnVMG9IRISFdW+FR2mi6A1ZSF+BtorIuOz8dz3NMRSUQdHupQj4RqTcS1VIc0whBVIVwr/c8KlttiRDrNu0OS47TvLfX7IyZnhlFBuKTkhCfHBwaS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGIIvJUPBRWpOuq9pAXqdhUsEPpKamhZQ+KYIh+j9EU=;
 b=a3mDB3JI22Uu/blsVlZEjfPxXiB2F6gxRNEnX6S+xHaV6HxgIUjfZ6nab9SnJe6ne8S7OOQr2KiDuc6RGnU3gDTrnj71ilQnkwiACEinIGSK+lGCJCEb0JDv8Tm7n7Og/WyoHvg0PMAKR8BGlXZ9IvNRR8gHdaJ2TJ9Du+Pbw0pF4YYrO54IY1HqEK731hxewJjlNll8bbSRWIYQQmX9axnG+YmOxdmrkE65bOvYFz6nJd2XFWy/h6yGdjaelRc7emcBV84U+Zs7U68SWXz97cKhZU66h9r4yliZVTNL2YyEqlrAsZDmeuhEbp/Z6/50Ukb+dLN9XmVyXuxuB8CRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGIIvJUPBRWpOuq9pAXqdhUsEPpKamhZQ+KYIh+j9EU=;
 b=s6AWBu5TNyXS7Z8goQBvC8G5wpNcA402bpgJLVdJPGsTovMe6FtCK7zWNEQRjs1lDO/5dfkysGkqtnHmnx/1PeMgO9Dq0zDDvDko/gtS5G9USQHDzmEpmkHRNMB8MIELUinEtMBcy82ZvzaXa7h+I47QOU5YJ4vJHqd/873gKmb1X45k4iZlGjGp6iqtjJ1aC8nQS99KfW2ExitMLx2vaIpOAsoyb0mtm8pMRNg+RltnYt4IGSR611faWcW/cKPf35n5Yamo3ImhlrDj1ZIhd4E16Yz3ngOCa4b8SdQInva/U0f3/3oZxhkQV1SW6tUwuF4KJRZVxpiDZN9PCq8CWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:09 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:09 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	brauner@kernel.org
Subject: [PATCH v29 05/20] nvme-tcp: Add DDP offload control path
Date: Mon, 30 Jun 2025 14:07:22 +0000
Message-Id: <20250630140737.28662-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e0a4be-934c-45ff-f918-08ddb7df8aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XIsr1o9Uid0tvRLouzt9CUvXvYcK96uhQzKrhBH1Ub2LP9CPZdMEBr520jee?=
 =?us-ascii?Q?QwPAW7RAq5Bp39AxynndpJqTwa7o2fz6F8I4Uc28abNOXpoaHgULMHwvntxa?=
 =?us-ascii?Q?V9VknFnXDb2hJEdeuFiX6pWkMJ1VcqEzTUH30cq/qEGewxCe+gmDZkOXYW/+?=
 =?us-ascii?Q?OAqeTWTaXEF8eqchN92ox5+0K8PQ4vbt9qqsRaSOJDBrwBbk86IHg6ncmAQe?=
 =?us-ascii?Q?+fEuvDj9uOWBLWrct9XGlPjwzN07usbU2feqfCW+KSujtluA5bY48OFbpnPW?=
 =?us-ascii?Q?z6SBqoWAcqoYwV0G6KZwskTh7t4cEQAHTyLM8cZA7hq8CaWCzVM4xF+uZkD5?=
 =?us-ascii?Q?0O4Tv3eUPW4aM1wu+4T/2rpmWjnUcuZius2f1leyYJFg/nkA3ejhVD9hNNN0?=
 =?us-ascii?Q?5iSQLJgBa2b+5bl+D+BRpPz3YAcnmzV5ef8AY9PpTDdcBpAv6cFoVZXm5Vm9?=
 =?us-ascii?Q?yp9a5xcA1fI/ua5d+IHUUzSD+m/aKb64Q8coV08hVpeIBtahWhWiMj+5zPG8?=
 =?us-ascii?Q?d58otg5KIzZ3xwHdKbyv6Kkx2NZ1CTInJYyaKl/W3b3xKLEMQbsDvNzPPQfQ?=
 =?us-ascii?Q?hGwklV6HHXYrs0pKk1pMJNmaAJ+YbUWZ12UFsxhW/QSq3UgH8CUSqPB5qIny?=
 =?us-ascii?Q?p5WBMOV1vJz4l84t3O2qjWsJH5POZlps1Si3puQoFe5WabvM6gXaxRZLWYtK?=
 =?us-ascii?Q?cIrd4HDUBcmUWh3meS8hbn0/A4WKn+jU+Ju3vJpS9tvu00iZY7ACRedaCpxC?=
 =?us-ascii?Q?HsOfMVdzg66wHUgdtS9zFCEbX5VjLV9vj07ICgVq8XEiN83xaiWpzrqVMhIT?=
 =?us-ascii?Q?6Tg+VJZ2FpxcWGOXow37w9SPu0loB+pKkIGgr2167SmE/+lStZRIk7cMpeHJ?=
 =?us-ascii?Q?mQslIQ07B1bK37S09SVZR/AvH3wgV2NH3L3stzMqpeMyqq+B2DFA4wATyFbU?=
 =?us-ascii?Q?HmmfPkmc3Tza+SDvxTXjoCIuSW424th9wJJwZEHbd5bAncI0A4bd4xNqrQxW?=
 =?us-ascii?Q?/iVoIRosG6oUv8e3P4ArC1RlOrnFEBeG82c+Rgg0JEmuTSanuQXvomA9eXEy?=
 =?us-ascii?Q?BTwuxrHIjpY8GCExwKddNCviZtY2b8Z/asTFvNJcVQSJgM2hYofp+d4K8sYJ?=
 =?us-ascii?Q?UocQWmi+UZe0AshlUm4fte5myEyBszSvNfhQPXpQnzbv+U2Oaw5Ry+wwKB5P?=
 =?us-ascii?Q?G6343SOqT/uP8/n2Obl4DZASFS6s92yqPc/SjUsNQE9AV9EutFz4hQb/x9qf?=
 =?us-ascii?Q?aoG8Yl0wHI3uxCIyG1d3cpcsoGUKyAadw9m8GVptyMD6btu+XrVeUqrY/OqX?=
 =?us-ascii?Q?lBXyebB7pzRDtpqJzLCPylgke6/5+yTgxC9RK6u+oHxmD5UXtrxDMNXhQZpq?=
 =?us-ascii?Q?FxZYhCc0S5A6PwH/2S6BnC4D13PnuybhcEgbIYcZV94bZ7Yjxby+qlDtYHhI?=
 =?us-ascii?Q?fhnzwMHFDFE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31tX+idZqhZbztAJULsRXrpsrQA2Biqwi72e29Y2+ZCm64Jv3Q/cpSGf655V?=
 =?us-ascii?Q?Lssu2k/po1knS+B7upBAMda9m5yxyFeI1xOMKzvdQEz233Q2SIy+j/FJsvya?=
 =?us-ascii?Q?mwvYjqXGOBoxsrWs5pkz4+wzy1WgpXJpX+7aXngnbb4vaz3EMTjq01ECBvlc?=
 =?us-ascii?Q?FXpi4IVoBUGvcxgDAmQ3Ncbb3261Ks4bGEPh4AB97Cs0MygXMY2MrDn5aIWG?=
 =?us-ascii?Q?bkA2Ni+BZYRx3tXH/PQB8ogIccLgTLRt/DThDLaEX8PE7NN0U9GhVih6g+3z?=
 =?us-ascii?Q?f5+hGsnK8CoAoeh20QX3g0D8PE6b9g6BsMPGvSiFcK+fN3fXius2UimkhJA8?=
 =?us-ascii?Q?7bVnRzpMhUKEkiyPq24jMrhNuhWJP/jq2G1p0gLn0ZOxddD0O3Jiy6FmW4hL?=
 =?us-ascii?Q?sBWBjr6Dd9SJMN37LxN8Hvnn6XUT7DBQBGp8u7jvqhrYGI4A+KYfWiVQiduB?=
 =?us-ascii?Q?bVdqRyOAThNuoL6hH/suyNAujwykbhjlD97yc+Ub/MTXwDiULCtzRQrHOL/6?=
 =?us-ascii?Q?zbCiNrFJg+wVlcdsaFHrNJaANCdR/7jPZJxB3L78G9O1zwVgnqFZo3aR9r/l?=
 =?us-ascii?Q?FTM2YiJCKFAkQ9Z38Fdq3/IGOKEv/0y7gndix0ffczmYrgnfokBkDSavv1VB?=
 =?us-ascii?Q?GeHtfnKGV6OUIpO1XhaGd0qu8dosJt4ateraL+OqwaVWuGU7j5oPNHJulQ/Q?=
 =?us-ascii?Q?RjV+TC2OxCOULo/DCiPqc8JNWvm7QyAj2AyZ7CT+gJDc3TyqepoeYXI3zr+n?=
 =?us-ascii?Q?4q9vljaKOXGogFS2uuvs+FgT02MSwggH9KNR0GKLeBqe2MJrrqX1Phm1F8gu?=
 =?us-ascii?Q?HkhwYbt8GtJlGTKKVpq+EmmaqQ57x7oAxdvCTggXP9u8rx7gIBVqHhY/qdV1?=
 =?us-ascii?Q?UeRm3dpNFHJ7di6TJoelm0wTB8FyCGmYGxDV3kSKeNtSwM6r4c1GKSlJgOvB?=
 =?us-ascii?Q?95GAdPfkTy+GMg8sbtM8aY2KMpVdqM3+wytk/DeKZVlCSbnzwixPlVu9dS6V?=
 =?us-ascii?Q?UdqHOBAZtjabuvEUe8ufvm/HD/ZYvz2Pzm9PHFQLnfMT5kzhMQH9Rflzi4Js?=
 =?us-ascii?Q?eJ+946082xnK2i7a39QGX+ThJa5fzN4lNANhVN9/A4udw0nAywUWxbxqhqgh?=
 =?us-ascii?Q?8iutks8HUNxth17RUfNs4b1TCNUChKBMHfiu5vSobKBoSETgomL05gUBwQCj?=
 =?us-ascii?Q?UW40Kxq0IjJXY5wm+l2Yhozdt8MCgKJP9UPEx3jwjx3yQ+1FDDa0CCqUKuvh?=
 =?us-ascii?Q?ecNVA9/MTrotZGxEPERwEVc2fOmpO0c8dXrGDFqwYIdY6GSrDEc+q2FZTK0x?=
 =?us-ascii?Q?+Q3+HQASvCnwUIsXOXhbKldxw8YspNcAJQrLmdmekNmtUGJAOGA/CbmYPaQI?=
 =?us-ascii?Q?WvhHjITv7g0o8GaxLyE05CzIc1byz7w+VAuOIYFIwo2oV/RnCwLySpEs0hG8?=
 =?us-ascii?Q?xw+x5oc7znwH8PaCMk6OellqfU8XK/rr/iiw/l6fhym+f9fG/h9jBJCLUsOt?=
 =?us-ascii?Q?h95QVbaHAliGtwj1jGFE8HAhZrVn85u/krO9wCzOnABx/KhIc1pfk0K4p03f?=
 =?us-ascii?Q?HlIcf/ipGk30QQYllIfzULfxy53/OgifafAs8Cl3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e0a4be-934c-45ff-f918-08ddb7df8aed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:09.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGHDpfAw1+hRGjJUCU8DVMzi1r18OCbG1of4ehyOPKXcUWz+8vZJ27vGBeSZ8u7LbnLaud6qwfEPGzQ648dXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (resync), which will update the HW, and resume offload
when all is successful.

Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
for queue of size N) where the linux nvme driver uses part of the 16
bit CCID for generation counter. To address that, we use the existing
quirk in the nvme layer when the HW driver advertises if the device is
not supports the full 16 bit CCID range.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via ulp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Socket operations need a netdev reference. This reference is
dropped on NETDEV_GOING_DOWN events to allow the device to go down in
a follow-up patch.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 268 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 257 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d924008c3949..3ef48731ec84 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -20,6 +20,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -55,6 +59,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ddp_offload;
+module_param(ddp_offload, bool, 0644);
+MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -129,6 +143,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_OFF_DDP	= 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -156,6 +171,18 @@ struct nvme_tcp_queue {
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
 
+#ifdef CONFIG_ULP_DDP
+	/*
+	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
+	 * an additional flag in the lower 32 bits) that the HW send to
+	 * the SW, for the SW to verify.
+	 * - The 32 high bits store the seq number
+	 * - The 32 low bits are used as a flag to know if a request
+	 *   is pending (ULP_DDP_RESYNC_PENDING).
+	 */
+	atomic64_t		resync_tcp_seq;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -197,6 +224,14 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*ddp_netdev;
+	netdevice_tracker	netdev_tracker;
+	netdevice_tracker	netdev_ddp_tracker;
+	u32			ddp_threshold;
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -335,6 +370,178 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	struct net_device *netdev;
+	int ret;
+
+	if (!ddp_offload)
+		return NULL;
+
+	rtnl_lock();
+	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
+	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk, &ctrl->netdev_tracker, GFP_KERNEL);
+	rtnl_unlock();
+	if (!netdev) {
+		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
+		return NULL;
+	}
+
+	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
+		goto err;
+
+	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
+	if (ret)
+		goto err;
+
+	if (nvme_tcp_tls_configured(&ctrl->ctrl) && !ctrl->ddp_limits.tls)
+		goto err;
+
+	return netdev;
+err:
+	netdev_put(netdev, &ctrl->netdev_tracker);
+	return NULL;
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	int ret;
+
+	config.affinity_hint = queue->io_cpu == WORK_CPU_UNBOUND ?
+		queue->sock->sk->sk_incoming_cpu : queue->io_cpu;
+	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
+	config.nvmeotcp.cpda = 0;
+	config.nvmeotcp.dgst =
+		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.nvmeotcp.dgst |=
+		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
+
+	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
+			     &queue->ctrl->netdev_ddp_tracker,
+			     GFP_KERNEL,
+			     queue->sock->sk,
+			     &config,
+			     &nvme_tcp_ddp_ulp_ops);
+	if (ret)
+		return ret;
+
+	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	ulp_ddp_sk_del(queue->ctrl->ddp_netdev,
+		       &queue->ctrl->netdev_ddp_tracker,
+		       queue->sock->sk);
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
+	ctrl->ctrl.max_hw_sectors =
+		ctrl->ddp_limits.max_ddp_sgl_len << (NVME_CTRL_PAGE_SHIFT - SECTOR_SHIFT);
+	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
+
+	/* offloading HW doesn't support full ccid range, apply the quirk */
+	ctrl->ctrl.quirks |=
+		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
+}
+
+/* In presence of packet drops or network packet reordering, the device may lose
+ * synchronization between the TCP stream and the L5P framing, and require a
+ * resync with the kernel's TCP stack.
+ *
+ * - NIC HW identifies a PDU header at some TCP sequence number,
+ *   and asks NVMe-TCP to confirm it.
+ * - When NVMe-TCP observes the requested TCP sequence, it will compare
+ *   it with the PDU header TCP sequence, and report the result to the
+ *   NIC driver
+ */
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_tcp_seq);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
+		return;
+
+	/*
+	 * Obtain and check requested sequence number: is this PDU header
+	 * before the request?
+	 */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	/*
+	 * The atomic operation guarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_tcp_seq, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
+			     atomic64_read(&queue->resync_tcp_seq))
+		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	/*
+	 * "seq" (TCP seq number) is what the HW assumes is the
+	 * beginning of a PDU.  The nvme-tcp layer needs to store the
+	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
+	 * indicate that a request is pending.
+	 */
+	atomic64_set(&queue->resync_tcp_seq, (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	return NULL;
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{}
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -835,6 +1042,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1918,6 +2128,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
@@ -1963,6 +2175,19 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	nvme_tcp_wait_queue(nctrl, qid);
 }
 
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+
+	nvme_tcp_stop_queue(nctrl, 0);
+
+	/*
+	 * We are called twice by nvme_tcp_teardown_admin_queue()
+	 * Set ddp_netdev to NULL to avoid putting it twice
+	 */
+	netdev_put(ctrl->ddp_netdev, &ctrl->netdev_tracker);
+	ctrl->ddp_netdev = NULL;
+}
 
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
@@ -1993,17 +2218,35 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	if (idx) {
 		nvme_tcp_set_queue_io_cpu(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	} else
+		if (ret)
+			goto err;
+
+		if (ctrl->ddp_netdev) {
+			ret = nvme_tcp_offload_socket(queue);
+			if (ret) {
+				dev_info(nctrl->device,
+					 "failed to setup offload on queue %d ret=%d\n",
+					 idx, ret);
+			}
+		}
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		if (ret)
+			goto err;
+
+		ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
+		if (ctrl->ddp_netdev)
+			nvme_tcp_ddp_apply_limits(ctrl);
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+
+	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	return 0;
+err:
+	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	dev_err(nctrl->device,
+		"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
 }
 
@@ -2261,7 +2504,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -2276,7 +2519,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove) {
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2621,7 +2864,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (nvme_tcp_admin_queue(req->queue))
+		nvme_tcp_stop_admin_queue(ctrl);
+	else
+		nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.34.1


