Return-Path: <netdev+bounces-78461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E8875399
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C281C22144
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E112F380;
	Thu,  7 Mar 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CkGn03H2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1B12F37F
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826293; cv=fail; b=Abx37aCHSgWWgDylWNIzzS9fqoi/YiEfED3XQABLesTPPnaJZHxxVHpTL8YHh+8JS2/rga2RggSeCwIIo5CWqxHt3zHA/7f9saF9rBlL01niPI//3H0dOpBX1vsUJp6LcqpEDBhuGkH7dDjGi2z0NlvGZ5OhbEoLOUj7yqVP4i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826293; c=relaxed/simple;
	bh=C6z2RPUQYbu13MAMMz0ZPhF+biK7VBgujnw9Z36aWCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=cuOsXCFksvBdMwTdt/P6d2v6wfGoQxNkx86Mah0gInoWmpanMpfb/USh6MOE4hJ31VxyAKgLziBQ3jCn2I0myAo2zhqUSf4iqSgC2oXNMCZfoxdX/GUpLWmPEJkU9IBC25R+Ox59QAlauil20TyTb5P+OexeGNTmC8UaZHZCwiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CkGn03H2; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxKBC81xxe+Q33jlipbnf2xicmOKY3fKq0pDxmuczXngkj/wgogjcdlsN3jttftZn3Rizn2vtTgug9m/oTQqcooRLh2ofsQ7+0/2/ySHBqbtD3dFvIAk4P61eb6NEhfYJZz5Jlo7M2u9rC7QGBv199BgT3/8zhiRN3ZNOmaQ583QS2Wd/wPFx7DOg0G5ENTWtqZvcWxjC527mg19Fg+0TSGsEdtqVgLx0VboprSZ0Q/tbkWnablSBsVCpSYce+Y7QzRIBsER8trzXj1B81Sz3H81whkioOmPNnJHwycthq6JqhCgFqrhemAMHqtqpTqwXKyfsSPALKB2I0ffMoSDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6z2RPUQYbu13MAMMz0ZPhF+biK7VBgujnw9Z36aWCc=;
 b=bNv+ZwFzbjxvxKaKqDIP0OXztIXIXGjbuWwxBg17cI01I5osZK0Xbad1nVxc9rrAxWpOpXxsJwzobJVBi3klCw8ixuAtsntggK5hwWDKR1oqj4Mrm13ZjgvYnR8r4pfzWYxWaVWG5p0S3hilArw88kD4Vm5ZzmmWoTWxTqm89/+t6l6wHfLl5lEIehgH2hZFx9YYpqpouhvAnChLXPRDYWfbD3/H8D86lX9+Mnh9MHjLMPl+FgA5qtcc5s8BAaLKn+Lxr1A7QU5845eCSJgkqO06U/ZQcXp/MkxO7euDUVxI09JzfSufs3HP8KU++v8jVTIRjp4eloreOs6rBMJUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6z2RPUQYbu13MAMMz0ZPhF+biK7VBgujnw9Z36aWCc=;
 b=CkGn03H2j42br4g7i/FhlbMSvZyX7kVXi0MQ20fkwTqsh1m6lJt38y0KH+3sS1DgYQImzKHKRN4o+xtAc1iTa9Cf/nL15ZEy0nhuIYMeSgEJ3ZtyzrTnQjTsT2jshRqXcdTsQ1Ivq3qdI8eCZq2PUZAtgWC1ijXe+4ybWGImXIE5Rc56tvLq1YQw+Tw/zoYvOwSla2xqMt4MX6kPHzGihsSo2u6DQGeIZFO2aak9OtDriryRPPaY+mF9d+hukAuEVGtBjunqQWFZlb8UZkxv2s1GR4OJr77i22jVvOPzXqmuIrBKz0XbN0yVtH8mstZtAQ69L3IUq48xcxo8SiDPzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:44:48 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 15:44:48 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v23 07/20] nvme-tcp: RX DDGST offload
In-Reply-To: <91318572-af38-464c-9c7a-4f6d1f642eee@grimberg.me>
References: <20240228125733.299384-1-aaptel@nvidia.com>
 <20240228125733.299384-8-aaptel@nvidia.com>
 <91318572-af38-464c-9c7a-4f6d1f642eee@grimberg.me>
Date: Thu, 07 Mar 2024 17:44:44 +0200
Message-ID: <253jzmeujv7.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: f5881bb1-b0d7-4caa-46ed-08dc3ebd84f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q71Koq7K1gndVyeZQrq5QtLo4NGL1Qj2a44OkY34Cz7NfE3kqqrczwS06dAWgs/4VxJv9CiKxOAXWayfm5jU7UuwyUU6YvI595VrF0DT+uZihhIj5qT4QhR++t0xaPGOW1aOxeHO1tmNsweliGRd0UQ68KfvwQh1BT2K6TzlXMyWILYONsVxQgLDfuKeXFyq3wGqHjXc8Wbc6/xCWOT4HnhNbH/RX04eZbWZ6z7DAUz1D9mETuTy0foDANaLd9BtrevHLNzv6mHjGZGKUn6aG7CgpCXy2FhvIpqF9ApkBY7ZxgA3yUzRyxTA9jPHe5tDtkwo3xPcZBooO7ftLkYhwWkHC2AfLZHus2MDYB2XlfvXB/DP2DQthZ+egl2373Jkj/T6piiutVrg+TOh1myZpQO8jD45IdQXWo9ieeXX3jmADLv6D5S69TFBPQTvO0oN85XAYi2a8qh6D+fCpP9AaGQJcK5i1Ad9q13tOLEzpo4CRonzO9C3+JBha4SQNKcM4SO+NzCsToDDJPoxWRN604/+XLP9ooZpVwBy+FIKSZN5n1xzFw7wnojkdqIjYtsYCnVg8TTLVpZYk1IZL+mB3VnxskiPdp2rcMyE3yzLayBJV8BZ5yDH3ILyHv8xmJN0Ja9hE1gXxj9sbDoRu5bZcU2AhiI/kNB3wkrg4JtJ19k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LpHnOyN85MUOYiwtMtSC31kZcK1gyVJxoNgJUfvrq4s67tbaxfc71BSzloB7?=
 =?us-ascii?Q?lGIU5h/5C3X8ekazcNTP41DugY6YiuG6lRpU7DA5tVCEkT1aoZY6DzDpHBYd?=
 =?us-ascii?Q?6kkvw5of28m7QIW9NAYuKi2q2i54UtnjOVFlLypzDd48LNldLTLcKG2vdatD?=
 =?us-ascii?Q?HD1igh2qss73M6VT7zuEweH+8ciMtSnkrugOYZLLsxBZtGyxWcRTl6g0YSuh?=
 =?us-ascii?Q?EzTu09VVpAuyHoKocTx+1hEXsVAUfjuPrJ7Eb3XD202PHuH8QlpedRBgOyej?=
 =?us-ascii?Q?vwvmYaXdBWbMp0pHp4rTLKH1/x6l+r+z2sLhkWTcDdKE0vNaEXWtUsoirsGd?=
 =?us-ascii?Q?PjD24mZegEK6aUNJCVf2vjlVn9YwIqO9420fZgZo+1d0jjXYr+4x3+IywCGH?=
 =?us-ascii?Q?YBaXqHhmld/wwoQk9D9OMaSl5HFI9rhBOCcIq8eo/DnCAf3H/vIttwn765iA?=
 =?us-ascii?Q?dHiYmUG0LPWXFP0dyciT9Wzpyq6kvrN8c6cm/DA3Wk3ORbsv0NtYffS6Ycbe?=
 =?us-ascii?Q?f+0C5pAGUJbrhV/WFf1hJcs/rj2CgWinW7mpkLLdioy57pNrTgqaYnTqK/lM?=
 =?us-ascii?Q?+p4yTkxPW/u0EEbKxWjks7JbKPqyW7zAlSFdI9v4UrJmMekKDUaTbxPwJblN?=
 =?us-ascii?Q?+QI8FXu/o9y3nFFfyfuevCJaRDmzM8Rb5CV5Uwm6JYkYm7PeVuCOvVBKMgMY?=
 =?us-ascii?Q?/bJiujtpdz46mUeLs8w9EybA/G7Jpl5KZ2RWaSyFcB4e59QQIRnRNUdDIh5E?=
 =?us-ascii?Q?QpzDU42qK2G4SW3cug/WlkCC17WPDdLgz0EmlspyYQR7Byf0Z1niLGB+7GN4?=
 =?us-ascii?Q?8K8lSfemnLxyseqPk/9OqHdtR0d9H2N3lDgPFK4dq4hxqx/G5EsGGjaZab6D?=
 =?us-ascii?Q?udA2h+rY3iRyfpG+kf/VC1FaO/zXAR6OunndXzFYwizRTpabfhW+p8PIm0vv?=
 =?us-ascii?Q?xpMvxRLdfPYN2CUBygkUydyYyAazxT5D1eE8Qp8MGdEO+2YiMeCv743Jig56?=
 =?us-ascii?Q?s99cdQZiyLYYXc8yVN9y00fhSdjdiqr/jWPFKCWdZJcgk2K++efgcg7xUYWr?=
 =?us-ascii?Q?VRIyWuPERZSdBhkNSSGQjh5IEcvEg3eEFH7+KkLmSRY4aeuPefXtKJzqZZi6?=
 =?us-ascii?Q?/sr0DPb0CcnSJFLq+Vmmad3u0ZHHMVTMChpPHVPWgbd3SpZ2dW4gVvJ8eROD?=
 =?us-ascii?Q?im5SBT9ndIXXIjIkkiPLo7K/yqaLMXXQzT67N8opc9o/CAc5UYm4giOIIP3u?=
 =?us-ascii?Q?NxhuJGdK8mBFD0WSKIpvou+TnLQxC9Hy682VupMCAgnzbBnk3DhpiekLVU5W?=
 =?us-ascii?Q?uSQEVF7tzmtzrMDjYiKHHP/CGVc2h9wLnxpzmXY2u3FnIP0XtSAgnv1m3L2+?=
 =?us-ascii?Q?uM2eOFoD67z6u4Z0rBYFBL91Ogq8EBiUgpLNj1GhQ+4RAKfrKv3t+/4IO4YS?=
 =?us-ascii?Q?SIbLvYkRCqCKInSpO7QwD/sD3nZVCzZK9nVubPFfb/82jyzyJu9ZHG3xTMdS?=
 =?us-ascii?Q?uznD01iNvnXBq5/OGqClp54aFBAFUy+3HBZGdfSPfOuYd+OFyKrAu+7OIl7Y?=
 =?us-ascii?Q?Ux3gHr0TpBOG4O0abHALdoE1KEwfqegydnn27MOL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5881bb1-b0d7-4caa-46ed-08dc3ebd84f5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:44:48.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDCV+sPbB2kxiLkRZtqLsfudqYeFkirCoH2qImz+Vq//R6X6tuXfdSPLEDSDuihZawgDoS6KPGyTXy9obADuSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

Sagi Grimberg <sagi@grimberg.me> writes:
> Nit: you can rename the label to ddgst_valid: or ddgst_ok:

Ok, we will do the rename.

> Other than that,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks!

