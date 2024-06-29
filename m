Return-Path: <netdev+bounces-107874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD691CB5F
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 08:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C431F2253A
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06E282EA;
	Sat, 29 Jun 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="CWdbh195"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2176.outbound.protection.outlook.com [40.92.62.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE243C36;
	Sat, 29 Jun 2024 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719642200; cv=fail; b=FgHcRvTVxCUOXxWoDbAx7yV4rDvEAcj+BEWLmNTBSV1tcR6Uyq6o22MCwr1T3DWfyOS/0jBMCJbBiFWaBizxm4uqqWCGRd5jf3xfvKZ549cXvl6+wuSbIvHT+MrIU75LYk6rcr2DW1q9HJm+SaZlLniFTvqy7mP+Mcwe5V6lgyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719642200; c=relaxed/simple;
	bh=kJn+7gzy9ComQLF2+WpdP8yI8lkPqhHN4/AW9GVE6Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KSWevUj9reUdScH+ZCndn9iUb62mwKQnMHcubEkSppoHEvcxXINHFMwY5NdwXieogT2KAdTOBODusvWArDLUTppmk1yzqq7T5V1s1u+P7+w63KsXJNUagvqULAb/U7YBQAtCnFNdOzxYjIbdxjkFRpQguSpHkXI4sk5CBRkRmJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=CWdbh195; arc=fail smtp.client-ip=40.92.62.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELBnkLEEiI0ArNrQR3lyARAA4eXriJwFPshmlyNl+D08w77/P0dXBypgY9DAj0d9RUcWpYlaMmGRuUFrZxQPOb33uYCo0hC8TgeRk9cqqVcusp/oXag19PwQOfzbGg5x2qTJvY0+ERE5aYQunWj8Cgs8HApri1jMHEFlIEWuhJNMqDETvdsZI6wkIO2ZkzSCYXkkIKSu88XrNYZUETWb7kcX3hVmzeUf5eeEBWEEOX1DNX4LAhHjZ7vZjjbNwTSx86Tvg2YPwTaeckj7wnNDXMiCPTtZm8GYKuT0pkgufVIyKSQtI6pApVE9Smbwc4tHz6lj3h1IglNqnbx02CdTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjfStAl4X5APuJGdHfqLtnXkKQl7kdSwd8Ar5E4YipQ=;
 b=Ja1XYdGyRfYu/BRGLIX0P3uzugsAQlzdSlbr0DSTRG+ew1NQdo5EyLEaka4krWwolV9vmJvBejby9iLI3rfFtLJ4Zc4eiXSlxVC0CtoHrt939V5jo+/xQ2lAR8ctIIbJGOYjrD7ekHPfM3bc6euG7yE30s9mEK7/MyHfG73KdqFCfVUfr3YQJ+nJXf+VvOBBUHXlg/NT/r5BZhYMIpeyFAiiD9A8LFa/T1uA2XoiFlQEmWzPij+GwZfi7VWmMXoCGpSevJjwwYi4aIUVKHNIoquckHlPOkQvYmJJyUbnJE5MwE9+Hbxd9MfesegiveJhb7sod/1GxN3l+aB9ftVkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjfStAl4X5APuJGdHfqLtnXkKQl7kdSwd8Ar5E4YipQ=;
 b=CWdbh1952rsNFZYbLACQmX0ben+MaDiiqyh36CNt+phhAuV2cPM5pQ56UZQPisEPClm4OPmcm81BS29h/nqDapXgaUkIidsVH1S315bL7JMTsRjV7VtLgrzH271DLZGLa7vS5eIF3WVUEyY0vN9E7lqfymwGnVh9q3UWf6Gb1V1WGQ9G0WF32DuBGzcBlJ5dBk+O7vLl7/8gnogjqOE3YzkNszeaRw01DzVv7CoHmFWb4FVV01/+EasmN5Q0+eOd9z8iN6DJD8PexMYfcRp5ZMVIukC++EFI5dypiSJWgoqfQxSYIJU2iXZAvU54hpYnG75yxkP7w8YelJjGCLfhhQ==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY4P282MB1915.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:d1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Sat, 29 Jun 2024 06:23:12 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 06:23:12 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jinjian Song <songjinjian@hotmail.com>
Subject: [net-next v4 0/2] net: wwan: t7xx: Add t7xx debug port
Date: Sat, 29 Jun 2024 14:22:47 +0800
Message-ID:
 <SYBP282MB352896F07445518937AE7338BBD12@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jXBFwgFr8DlkzFpMWaf/BjmyND08zBIh]
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240629062249.8299-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY4P282MB1915:EE_
X-MS-Office365-Filtering-Correlation-Id: f3dc88db-fc86-4d4b-a373-08dc9803f387
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	t44y6AiB8xEFn6Ta76yGMUOBVk478lFCZn0MMsWNgVmYeFwq0qOuxst7EvOmfohaP6wG8T708H+uR4jOWnl3HQQCHouWmI7Nua9EYZXuJA4ExIvtUAhQOWgOQWdR7u77IrGCL3DGWhaFOZFBBiikHJZb4J14i1YuaHyRlMQKpFJkrMlEY9zErBV1vCqIBdmnCdJyfUtc10MsDOpKWl5kXiu1HiX0juMTE6YU+1+lRdS7FvWCCQogTHfiqWGafLVvIW7V+5NBU6YqLIYleN6bkgzGhIAG69M0RKpn8VuI4zFnaPuPf7rhHnVjWt+sK+iZV+3h/S+ojNsLTlwu0a9w899Z8jqxUkF7gY3/2FHn0W0KON5yKK5SP6112WoO7VHW1um0aaK36Ihie2ncFqgn9M5XyARtGQfHEjtUxF5LxPxwFyHTChSWl0W+ggfeO1MmnqTE33zIzF4sckBeR0+d4cvImJVnGKITqBk4ZngO6oFDivY55erP676PLXnfHt7W4IyLwWbXoER0iBC8vBYX61v5m/QiZCn2r/qVnrGpqRfh4i/SNaLiRtAn7kpPqIPgvr+Ri0wEEC+53yPhMwNoYhfkUtWTOlLC7lMrKVIdEGxz9tQ/Vw1oZY6McWbXGSsEm5MKj6I99e5p3Z+GTgv6bQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+YIawFSKahbhMtoU5n0f8FvTHupIMiDIigW2s4DToowf5pPrJjdSoy44y81W?=
 =?us-ascii?Q?K+QYzTncDvaloqBunoYEIYGJS5nUXxezov0CYEdSLUBo7lXibQeDWWKEODXx?=
 =?us-ascii?Q?ooMpO+pNiO4s9Y9F72WNqLo2J/8nLh1UsRD4R3pN5nQpJ1S+2ba2ThwT9nQy?=
 =?us-ascii?Q?dc9+Of4WGnzUMfCRHItaYPu4ec8K810lsqSdgbzXeTaE3ofhN/mwFkhU6pi1?=
 =?us-ascii?Q?YyIUfknV0Zwb+1PaIxBQKV7BXwpq+tXUI7SvQws1MjksUl06nWl4B+dlJ/SZ?=
 =?us-ascii?Q?p9wO9np9F3UgYC5wIT1pcn/pY6ED9D+cRfopEixpq6KtJQS+kkeFhjK19v6B?=
 =?us-ascii?Q?T3S5F80VefZtLyG0cwXYtr20drtQOPsrAoPCdmOy28TdpveApIsXN/i8B+jv?=
 =?us-ascii?Q?yXAIFvpo488Fi8wBZmaR/tbDC1WKfA0ott7LZaE5c4wbDy2lTIKhF2TPmnRO?=
 =?us-ascii?Q?Ak/W6plkPcp62XccveZyOaHPx26qO9aabfnQcnR163C4c+o31NxoYx01pBwP?=
 =?us-ascii?Q?RoXbYgNwCReZcl9Lsgvp77jU0XkhCxlVmUKQbE5ky3FQhnFJQ9L3K6DVBayF?=
 =?us-ascii?Q?8zp2Tn0Ml8ihFUwc7PmO4R9YyVIKQHvHUyV25sgIdGeDEmuZvWTPM+miTED6?=
 =?us-ascii?Q?5PoUg9jpQEgiBZHRsTieT5S5aj/6c+YVi3qlQVYRLTH7hFcToQ+VndoqZF9U?=
 =?us-ascii?Q?KkCurkmLWeyjWnBn1AMoSIlevTq5qNHFlE1C5HtBnaCve1iL9Q0EBdJ1FFND?=
 =?us-ascii?Q?gOITjx4UxQwh4QdTExon8lqNl3Dfkh4EJdMRAwComCGVVIZOkIBwn4QgXocN?=
 =?us-ascii?Q?DKhRT78ZyIL9BBZMr6twDiFmsbf+ylhrJqrDYpqKJYdroAK9PeS5YLWzH9tJ?=
 =?us-ascii?Q?34gAgMjMM9PQaVVQCQNRL+Gc1zLYSj0C6WjP0QIaspMJhj5aGKrZcyCyiOJt?=
 =?us-ascii?Q?N0XzoLgNosjDe5H+3disKYfF9uBNw1BlvYyjabCUrOG5Kfv8MdBEOeqGvPeR?=
 =?us-ascii?Q?uAGdGjnjBSbCqyvluSLENT61GQNoyZxwfOMTMbNkqqIU3zkAm9VwXOmBG2n/?=
 =?us-ascii?Q?proLQEwT9PU7KFemRYamxuDUdBBu5lbjfAyK3wTXjgOOwEYcKlkFnmtw2Ozg?=
 =?us-ascii?Q?6a0+Hyud6JQ3zL9FJRgY2JJjCX1qOoNLbHbFbyUXexaIUwi8I/uPd5ETgxZi?=
 =?us-ascii?Q?2NQzBLXhgK8d3pRRuRAvW54uNRI64mS8aoENNd+ti102PgtEBILndpidr6XN?=
 =?us-ascii?Q?d2+NcNL2CHHuJE8xJDIZ?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dc88db-fc86-4d4b-a373-08dc9803f387
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 06:23:12.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1915

Add support for t7xx WWAN device to debug by ADB (Android Debug Bridge)
port and MTK MIPCi (Modem Information Process Center) port.

Application can use ADB (Android Debg Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.

Application can use MIPC (Modem Information Process Center) port
to debug antenna tunner or noise profiling through this MTK modem
diagnostic interface.

Jinjian Song (2):
  wwan: core: Add WWAN ADB and MIPC port type
  net: wwan: t7xx: Add debug port

 .../networking/device_drivers/wwan/t7xx.rst   | 47 +++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.c              | 67 +++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_pci.h              |  7 ++
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 44 +++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 drivers/net/wwan/wwan_core.c                  |  8 +++
 include/linux/wwan.h                          |  4 ++
 9 files changed, 179 insertions(+), 10 deletions(-)

-- 
2.34.1


