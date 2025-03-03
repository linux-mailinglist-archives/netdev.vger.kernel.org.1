Return-Path: <netdev+bounces-171153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF6A4BB43
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBBB3B2A7E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8261F1518;
	Mon,  3 Mar 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DMq1WRfg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25D1F131C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995649; cv=fail; b=h3Tixpp9W6Sn0WxBprw01FZOnc64uILAbd2dZdr0Y86NR08jPfpvhYG0K0Z1mePhOXM520DJhsima4p8k2znHnyDxfZ9ttt696v5rXavS0ANuTSUajXqttRrRhR8+8/fNXi1GE00w7sF4AbNGo3eHwuCKtbYkZR3WzfZB7xbmMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995649; c=relaxed/simple;
	bh=aYiaCXcAxVmDLkvBDjY1vVAikAM+LUl73Q0xbOLhDXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RPJp3WmJnbNI/XK+4MRmc5wdZBACKobxFxKJQIPgkc72V97MfhT+nB6Eo+WTJlD23pk2HoXBXpe7FLuq9+myKWo9vmeX0UnIxbSIHUV/y0Brt8XuKk/Fk1a3whWeZ7aX/wbuEXhKPmriWVgnfjyIb6ZfavQ081VLPFtFllh2D5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DMq1WRfg; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1BilGb+doiOrZZbP7RVROpvFWwayCS6EyyE+1Vd4oj5GQmJG24852+JWIvRCjtkAqdd5BEJeO81AKI+Yctr0C7dDUFZLjJGs6b0ehsyIKyn71GfVfZZnR7Nqwy9dCiJfia1z4JwQsK0TMnOk7xARXGokxFX5olTRl0YpckHQ7lEery5TtlRqbOnrfks5OT7WOS/XuXMWOXNmm4KcXSIpP9s8/4pH0HnFnJT+cCzo/Zi0JVcsqWLlC1nCDGB1SIAshqiynlM2LFKpYyv873LgxqKBakqFTAxF3c+7nZ8hGlb5ebE0hg+qrjWwJoPZnUrsRDdtq8COCbX5oqoMfgj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU8txZXwY33LcqwAVLP6wPocAZjDgDd46k+kpvtQfyY=;
 b=sH3uxEdbIvoM19M5tCkOo6hJyZYaVC0XHifWc1CFLsI/PKhAlqnfzHaK8JlENsG+JCh718PXROVwv7D/XBjSFtEbkOt+ahTh229x4XXJWZrEW2zHApvukHWcfbqLnHLrigSD5cKOn1Mg+YD0g4aeZEYxb7D69T/A2H0L9jG3S5mfcPN3OG3sVpL3+yWYFrGZ6obWl/0fbuBKSJCzg/IbpDyH8OlOh8hJpdQ0LOv32ECdNAiORV0i38O7/71k6kIxlASy/85g3EwtVl2J2P7ngoiCIYpmUzvPuCKgVkkRI+42vBxrp2CK8rfN26nMgjUtX1kmOnX6c8MRDUekDAPGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU8txZXwY33LcqwAVLP6wPocAZjDgDd46k+kpvtQfyY=;
 b=DMq1WRfgOLELPfFaloQOXXQb+q7OMX2zedUFhhikIvZQzWRN4KptBrt7AAhvjmwGWnnr6KZmf5oT/lff9hCHqivksOCzYG5Bb/uDbcHxFV2AIzqYrP0Grrsu06XSfkRoCNCGtmXa+ZSnsdNKgKtkaqFwItdWhWrRR0jtQx1MO0nN/pf+e+bqKno3h4ay7x7NdWVWSf2+xE1Gn0YUTrNEECQ+M8FoIQpfPLi21qww7V/wMbCgiHzGMJr6K1MhyiqYMlv0K4Aw5uSunQwa8eMJuroaKzcX+Wph2LYZeW3gHNXZwpOIyHk8AifsUyTxYmbNDSY4QJjqjbzIuHxSX11KxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:54:04 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:54:04 +0000
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
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v27 10/20] net/mlx5e: Rename from tls to transport static params
Date: Mon,  3 Mar 2025 09:52:54 +0000
Message-Id: <20250303095304.1534-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::14) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 64eda2d9-2222-4b85-9234-08dd5a3954cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KbSXPpSQEaM4Df7DVHw3a2eF4Aba39T2Njcpp+yN7tGUHwSF1LSLdLLqJUUa?=
 =?us-ascii?Q?xesFu+HmR24mtwMyTOtHV6d0vCja6gbnkZyrpv4PCm7c1FDzcgUXK7ctsGlg?=
 =?us-ascii?Q?SRbZ9o16ZJRj2hxyNrmiheVJ9L30N8QYHNQDWJqhbfroqDsWXfiIxTXyCWXv?=
 =?us-ascii?Q?fd7xXun6MU8luYOzrcZtJ/iKrGL+xLnqzB6Nr3BWCSxOnsfFyUgRA+Hx6++j?=
 =?us-ascii?Q?jOHND5JMknHoU7cOPw7dxW7+pJqq2XB7/CknoEW/ZawjQL4RzpG4G8DvGVkt?=
 =?us-ascii?Q?YeYb0VsQtUDaexYOtcEJAPDdE80o1efvxjzPTGgbTvEvogIxsEpPCTSM3cSL?=
 =?us-ascii?Q?BHEjG+qZOC4IN3Kn3VT/16AevZ6A0bQIYioegCN+OtI2OdCXTGQixE5mUFV5?=
 =?us-ascii?Q?U55m/3ZwwRveomQ/3JFpbE65D0hrjhv6ZRSWROuPvYp+PMDHUDAXqGOsw5O6?=
 =?us-ascii?Q?+nkB4LxPpXbHO+IdzBOPi7PcL12Jb4NhTK/trHkSidd1RZ3fbAK6VYbtS5Ae?=
 =?us-ascii?Q?25R2xX9wtuza+fwUrbdEpbalwUC3a+b2ct74UspGA90XzXOvKj/mHmsbgYeP?=
 =?us-ascii?Q?dY3zS8HjsjMYotesD6t/lUz/APTpBhPzvLem+OtpBLolXh7WlTkbCe2M1wIa?=
 =?us-ascii?Q?7xpi00ovYUOXPOCiipcLTE+LnSsDQ4n49xyfnJANgOp3o+i5K5nFYsDP9Ls7?=
 =?us-ascii?Q?BuFmZNWSnizNrWOk1veRk/hfM60WQhMoXi4L8T+RZa5gBXx6O0wYFnZSBvrk?=
 =?us-ascii?Q?tzX0FNEXKEdQ2+Ch3s8C8MUJbadtrQqFp7YwK+dn1kzlzmWJe8JaOIajn6pL?=
 =?us-ascii?Q?QiMnhnQEFnhGQyiXz9W2SnAG0SzJYdDo8LXNNPEIEcrdOl4jCObOdKMYE2Jt?=
 =?us-ascii?Q?3ucYcGwThrFblYkxWOc1nwA8nOkGj+9HaoltbcnWjmsjk/HgGyRH/CF0YFCq?=
 =?us-ascii?Q?JLASbOA/cHgVbqxhHuZwHAg/TPeFKdUMKsSrKXYuHCU/mQVmezQD6UlLbYv5?=
 =?us-ascii?Q?rzwMbx6Gzm+VlAdzMyZ72r2PFzxN5d8Zb2xVJuWFqKorLxaUCgTCeVx66cGZ?=
 =?us-ascii?Q?cIKvESyxjUxXsYZKGdAJeiLUf0ux5S+tizpJ/41reOP+jFXuA9LkZZc+CNeK?=
 =?us-ascii?Q?GEGj/Dg+0upJeqkcMLBJegjoR1013eHdZX9mB/I8JJv/uzvGgyXVElU4nPZu?=
 =?us-ascii?Q?vfm+Hri9OdeJmtBfMVX28XjGXyC/hG7P6sUHZF+MWUvdIAawreoeQG9h2rHk?=
 =?us-ascii?Q?jaaHHy3yar5mYvUoq10GHqETnjQc2AED5P6bYZU+geRza3nvUYmOA/FJEZ1p?=
 =?us-ascii?Q?ZEXdZo/XpeoVF37+5/KPtExSxEUQYMSQVPxYeG8XjYVTWAlfBSVXY+HbhXJO?=
 =?us-ascii?Q?MLsv7hoUYdaR+v/q/lMe3yWI/jwo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EXiMCtdZNdAercaBQRDuXhLIVYlXi2aQooaTOYTMZsXiEqb5PrFQ/OVmbHmE?=
 =?us-ascii?Q?R+Vhlq8FwpKBIECzpMxg5HfwAshVQCs7uwAswyLgncSIm9NVEfFDSGk9iET/?=
 =?us-ascii?Q?2k7e/CJvowoicPNZOqFUS11Owy2lfv8SqTn+u+p5jCukcF/GqAylBfzvEdOK?=
 =?us-ascii?Q?pZ6CWGRZFmxhyC7H7qv/mRZqskix3OOqacDu7wjJrF6gJ5i3hwu3CVEIhKRA?=
 =?us-ascii?Q?k88Da2RS2Hk7537S9xvXIBMWRMVLgs2DJW5oPjdqsLXHXYeM7sLr/tXSJKVP?=
 =?us-ascii?Q?3Q97o8YZrqs3ADN009P6ktnuYlXRUUB1GwRmLXxEUBgs62Cx9/eC6RlcDTmf?=
 =?us-ascii?Q?Dc9k0XeHc/WcJb6ljIlWxK11JBSXV8ze7/nmVD/HXOxhRDvOVsO/qpQPNDSw?=
 =?us-ascii?Q?uu+gUF0r93Gv8suMbWtxBfF6+tCr2lEndAK1jQNznDw40e42fknO74JedtJk?=
 =?us-ascii?Q?Vr6XWGm54+ceT86mgpP1+EeumqoqAySvFiJqfMKyRcGgsPn4pzUhIwnxMwLv?=
 =?us-ascii?Q?fUkzyG5lfvV5wza700YTwbdzQxkRd/LG1Xan5OlXvMQqJIH858mOYrYqayCF?=
 =?us-ascii?Q?Zl1BBRhf4b8DlcA1pdA2UgUs8dnlz0Ze6DSDvmYsQKgLl/gFOa3GeH+zpnug?=
 =?us-ascii?Q?I9A/h1d4ae6vKojEcWLM1OivT603ndg6W7QM6dpxmjdJoNGCg73NcCOetcxl?=
 =?us-ascii?Q?o6khTCBhm130v86t0Fc7Gz1uTeDxAlpMUPj/HQFQPMcUc1F3WmmhAwSHCwCw?=
 =?us-ascii?Q?m7VssuKAyqIZGrOHTJu1OJK9gGz/PVInbB/JSYYn1KQem+nKIA8vLC2XCS4B?=
 =?us-ascii?Q?nlod1OqFpmf4E26IagFBXp1WzjLHc5GGIQ6amNXklCQ8ccYB6aZdp3V68GVg?=
 =?us-ascii?Q?UsJBFARQ9FNYgD94XSysiZD+q4vyQxJLEhvTMCGaJiYRXWLF25W72xY1aog6?=
 =?us-ascii?Q?ETzKrVaLSPoPGLr60M5+IgsaJLVZ7BKyC5g8y9t/tZT6RuRtyOmOdRaNWsow?=
 =?us-ascii?Q?rMb1Tm/XLsNMcZb2tYgnFgRYNQjfh0/c7AuXziRDi/AOAzfIM1PFktccBj9n?=
 =?us-ascii?Q?CIQlgvM3TqiFKecqirBFoY4pbkl5rdNPlxSR/gUTcmLkmlBcdpB0pfb5jlV4?=
 =?us-ascii?Q?vPbiIH602IYkIQ3WzkIVX9b2y2rY0gVUnyNxdj7xJTX8oSKonEhlk3Yck8lS?=
 =?us-ascii?Q?GqN174TLL+uiopKKzAAOG3oKsoTPZJUC/tduEgcuzpxxBFbqziYyOhRvW7ri?=
 =?us-ascii?Q?nNmckPA4TkLn19Jxm8s+76Z9cjIjWyDuYhY2TyeC8Mie1VxP7mlAuhAz9wCy?=
 =?us-ascii?Q?ulTJQfyPeCAl2+7kGxEMPFCJl7Fw+3gXuafKvqEPtkbut9PwEms2Tbp43kuY?=
 =?us-ascii?Q?HL87/hZ8K2jnk7upZij8tB0mXte+NjypyXw36fc22IDVOASY0EZ6f2F1lYqB?=
 =?us-ascii?Q?XJDcO2B54DLLL6AvpvHJFR0nYKbQuCCpPiGFZ5LjpHHIi1lb39l/WbjTucSm?=
 =?us-ascii?Q?5XKLL5ZUXmK52ph+Lc9RIrvzwRdclkJXJmVc7hFnebvfFaMVDoLnhBrYXNZX?=
 =?us-ascii?Q?ivyowAy04D+lLW8c18rPOmp41IgXQOEJxBOCkXUH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eda2d9-2222-4b85-9234-08dd5a3954cd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:54:04.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHjalB4QR7LVVnoR1itiFaDUQOF2nDldJhvibdtqi8WIlu3XBqvSENTj1O886wVQHGa9Wf4rzjQZO7HIMu+Jtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Or Gerlitz <ogerlitz@nvidia.com>

The static params structure is used in TLS but also in other
transports we're offloading like nvmeotcp:

- Rename the relevant structures/fields
- Create common file for appropriate transports
- Apply changes in the TLS code

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/en_accel/common_utils.h         | 32 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/ktls.c        |  2 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  6 ++--
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  8 ++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 36 ++++++++-----------
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  | 17 ++-------
 include/linux/mlx5/device.h                   |  8 ++---
 include/linux/mlx5/mlx5_ifc.h                 |  8 +++--
 8 files changed, 67 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
new file mode 100644
index 000000000000..efdf48125848
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_COMMON_UTILS_H__
+#define __MLX5E_COMMON_UTILS_H__
+
+#include "en.h"
+
+struct mlx5e_set_transport_static_params_wqe {
+	struct mlx5_wqe_ctrl_seg ctrl;
+	struct mlx5_wqe_umr_ctrl_seg uctrl;
+	struct mlx5_mkey_seg mkc;
+	struct mlx5_wqe_transport_static_params_seg params;
+};
+
+/* macros for transport_static_params handling */
+#define MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS \
+	(DIV_ROUND_UP(sizeof(struct mlx5e_set_transport_static_params_wqe), MLX5_SEND_WQE_BB))
+
+#define MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
+	((struct mlx5e_set_transport_static_params_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_transport_static_params_wqe)))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ \
+	(sizeof(struct mlx5e_set_transport_static_params_wqe))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT \
+	(DIV_ROUND_UP(MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ, MLX5_SEND_WQE_DS))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE \
+	(MLX5_ST_SZ_BYTES(transport_static_params) / MLX5_SEND_WQE_DS)
+
+#endif /* __MLX5E_COMMON_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index e3e57c849436..ab7468bddf42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -100,7 +100,7 @@ bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 		return false;
 
 	/* Check the possibility to post the required ICOSQ WQEs. */
-	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS))
+	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS))
 		return false;
 	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS))
 		return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 65ccb33edafb..3c501466634c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -136,16 +136,16 @@ static struct mlx5_wqe_ctrl_seg *
 post_static_params(struct mlx5e_icosq *sq,
 		   struct mlx5e_ktls_offload_context_rx *priv_rx)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	struct mlx5e_icosq_wqe_info wi;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, num_wqebbs)))
 		return ERR_PTR(-ENOSPC);
 
 	pi = mlx5e_icosq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_rx->crypto_info,
 				       mlx5e_tir_get_tirn(&priv_rx->tir),
 				       mlx5_crypto_dek_get_id(priv_rx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index 3db31cc10719..5e00e1a98eed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -33,7 +33,7 @@ u16 mlx5e_ktls_get_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 
 	num_dumps = mlx5e_ktls_dumps_num_wqes(params, MAX_SKB_FRAGS, TLS_MAX_PAYLOAD_SIZE);
 
-	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS);
+	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS);
 	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS);
 	stop_room += num_dumps * mlx5e_stop_room_for_wqe(mdev, MLX5E_KTLS_DUMP_WQEBBS);
 	stop_room += 1; /* fence nop */
@@ -550,12 +550,12 @@ post_static_params(struct mlx5e_txqsq *sq,
 		   struct mlx5e_ktls_offload_context_tx *priv_tx,
 		   bool fence)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_txqsq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_tx->crypto_info,
 				       priv_tx->tisn,
 				       mlx5_crypto_dek_get_id(priv_tx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
index 570a912dd6fa..8abea6fe6cd9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
@@ -8,10 +8,6 @@ enum {
 	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
 };
 
-enum {
-	MLX5E_ENCRYPTION_STANDARD_TLS = 0x1,
-};
-
 #define EXTRACT_INFO_FIELDS do { \
 	salt    = info->salt;    \
 	rec_seq = info->rec_seq; \
@@ -20,7 +16,7 @@ enum {
 } while (0)
 
 static void
-fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
+fill_static_params(struct mlx5_wqe_transport_static_params_seg *params,
 		   union mlx5e_crypto_info *crypto_info,
 		   u32 key_id, u32 resync_tcp_sn)
 {
@@ -53,25 +49,25 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		return;
 	}
 
-	gcm_iv      = MLX5_ADDR_OF(tls_static_params, ctx, gcm_iv);
-	initial_rn  = MLX5_ADDR_OF(tls_static_params, ctx, initial_record_number);
+	gcm_iv      = MLX5_ADDR_OF(transport_static_params, ctx, gcm_iv);
+	initial_rn  = MLX5_ADDR_OF(transport_static_params, ctx, initial_record_number);
 
 	memcpy(gcm_iv,      salt,    salt_sz);
 	memcpy(initial_rn,  rec_seq, rec_seq_sz);
 
 	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
 
-	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
-	MLX5_SET(tls_static_params, ctx, const_1, 1);
-	MLX5_SET(tls_static_params, ctx, const_2, 2);
-	MLX5_SET(tls_static_params, ctx, encryption_standard,
-		 MLX5E_ENCRYPTION_STANDARD_TLS);
-	MLX5_SET(tls_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
-	MLX5_SET(tls_static_params, ctx, dek_index, key_id);
+	MLX5_SET(transport_static_params, ctx, tls_version, tls_version);
+	MLX5_SET(transport_static_params, ctx, const_1, 1);
+	MLX5_SET(transport_static_params, ctx, const_2, 2);
+	MLX5_SET(transport_static_params, ctx, acc_type,
+		 MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS);
+	MLX5_SET(transport_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
+	MLX5_SET(transport_static_params, ctx, dek_index, key_id);
 }
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
@@ -80,19 +76,17 @@ mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg     *cseg  = &wqe->ctrl;
 	u8 opmod = direction == TLS_OFFLOAD_CTX_DIR_TX ?
-		MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS :
-		MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS;
-
-#define STATIC_PARAMS_DS_CNT DIV_ROUND_UP(sizeof(*wqe), MLX5_SEND_WQE_DS)
+		MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
 
 	cseg->opmod_idx_opcode = cpu_to_be32((pc << 8) | MLX5_OPCODE_UMR | (opmod << 24));
 	cseg->qpn_ds           = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
-					     STATIC_PARAMS_DS_CNT);
+					     MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT);
 	cseg->fm_ce_se         = fence ? MLX5_FENCE_MODE_INITIATOR_SMALL : 0;
 	cseg->tis_tir_num      = cpu_to_be32(tis_tir_num << 8);
 
 	ucseg->flags = MLX5_UMR_INLINE;
-	ucseg->bsf_octowords = cpu_to_be16(MLX5_ST_SZ_BYTES(tls_static_params) / 16);
+	ucseg->bsf_octowords = cpu_to_be16(MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE);
 
 	fill_static_params(&wqe->params, crypto_info, key_id, resync_tcp_sn);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
index 3d79cd379890..5e2d186778aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
@@ -6,6 +6,7 @@
 
 #include <net/tls.h>
 #include "en.h"
+#include "en_accel/common_utils.h"
 
 enum {
 	MLX5E_TLS_PROGRESS_PARAMS_AUTH_STATE_NO_OFFLOAD     = 0,
@@ -33,13 +34,6 @@ union mlx5e_crypto_info {
 	struct tls12_crypto_info_aes_gcm_256 crypto_info_256;
 };
 
-struct mlx5e_set_tls_static_params_wqe {
-	struct mlx5_wqe_ctrl_seg ctrl;
-	struct mlx5_wqe_umr_ctrl_seg uctrl;
-	struct mlx5_mkey_seg mkc;
-	struct mlx5_wqe_tls_static_params_seg params;
-};
-
 struct mlx5e_set_tls_progress_params_wqe {
 	struct mlx5_wqe_ctrl_seg ctrl;
 	struct mlx5_wqe_tls_progress_params_seg params;
@@ -50,19 +44,12 @@ struct mlx5e_get_tls_progress_params_wqe {
 	struct mlx5_seg_get_psv  psv;
 };
 
-#define MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS \
-	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_static_params_wqe), MLX5_SEND_WQE_BB))
-
 #define MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
 #define MLX5E_KTLS_GET_PROGRESS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_get_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
-#define MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
-	((struct mlx5e_set_tls_static_params_wqe *)\
-	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_static_params_wqe)))
-
 #define MLX5E_TLS_FETCH_SET_PROGRESS_PARAMS_WQE(sq, pi) \
 	((struct mlx5e_set_tls_progress_params_wqe *)\
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_progress_params_wqe)))
@@ -76,7 +63,7 @@ struct mlx5e_get_tls_progress_params_wqe {
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_dump_wqe)))
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index fd37f4e54d76..ee329b80e426 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -457,8 +457,8 @@ enum {
 };
 
 enum {
-	MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS = 0x1,
-	MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS = 0x2,
+	MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS = 0x1,
+	MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS = 0x2,
 };
 
 enum {
@@ -466,8 +466,8 @@ enum {
 	MLX5_OPC_MOD_TLS_TIR_PROGRESS_PARAMS = 0x2,
 };
 
-struct mlx5_wqe_tls_static_params_seg {
-	u8     ctx[MLX5_ST_SZ_BYTES(tls_static_params)];
+struct mlx5_wqe_transport_static_params_seg {
+	u8     ctx[MLX5_ST_SZ_BYTES(transport_static_params)];
 };
 
 struct mlx5_wqe_tls_progress_params_seg {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index cc2875e843f7..c0ac8eec338f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12882,12 +12882,16 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
 };
 
-struct mlx5_ifc_tls_static_params_bits {
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+};
+
+struct mlx5_ifc_transport_static_params_bits {
 	u8         const_2[0x2];
 	u8         tls_version[0x4];
 	u8         const_1[0x2];
 	u8         reserved_at_8[0x14];
-	u8         encryption_standard[0x4];
+	u8         acc_type[0x4];
 
 	u8         reserved_at_20[0x20];
 
-- 
2.34.1


