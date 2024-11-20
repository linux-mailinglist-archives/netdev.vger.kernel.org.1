Return-Path: <netdev+bounces-146545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBCE9D4255
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 20:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886341F24907
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD6C1BDA8A;
	Wed, 20 Nov 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="O/07Z96v"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA11BA272;
	Wed, 20 Nov 2024 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129354; cv=fail; b=TcUpKPwFhamhpiMEb/MEdoyItTIT41d4Kvhu4Ed76t85Bgm4rTVccS7HpNI1H2s/qz5X7qRB7iSk7xPP9MJ7YVA7OlWgQ1fN3JbwYb+h2QiBFbkv3n0MHUVDnmI1/Xy/tdm8Cyw/e632ZtKzTqMcKl4Yw+nmsUyAaJoH04uUpbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129354; c=relaxed/simple;
	bh=f++X1TiDtEUpo+i/KpvXl2WyDsiYMF3oNg5X9AVgCh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWCQzKDeNzwgkRBP9j+f6iILFFSFsQTvsXybTlO0UClatEAChTKStsh6EVnN2SFX1GkjwueXWFDWBnc/EXB2PVXVLrJUaahz6nS3m4qLqsEG0Y6bze77CBsJ21n4h01svyFIwwUHcnjZiz5eHX/dXFDj0QE9SYlGvMcMbIewRh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=O/07Z96v; arc=fail smtp.client-ip=52.101.43.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysq6rL1N1eyaL8BTmd9QqMInClxobFqXYeoMI5Vujbt7e0iaEXlXw22Zb5SDp/NRRBo49qN0lryMp8IGLGje2hZszWr95cgrKq7zc/8zubP9MV+UhfXk4cKYiqMURdRyK0YUJ0vRwHCOHh9ruk7w+2a5u+oWZ3qH6x5rNRlCuGPh8C3OnJGVCG5WP1nv8RN67E4s8P8hfNfQR+WWZ5otWr2By0r58n+ym94uBUM+O3zKP6pBtn2q2jy946uKNGx2YomEPNMYhKVnx5LBSE6jQwNHjyb/xEQn2VRqYguN/AJjSyA9XvzqCao++v4qIUY4krnAQm8ijw6WshDzetvLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoaP9WNTf5wmvZyu6GcoQqFZKcIhdp6P/7rx/8jG8Ew=;
 b=PJB0rn6H6xafIinuCZUXxYitj90RnT9YYse2vXeXDxyIx8y9nR67UwLxflLVfZW1LssIj7VWzOd2kgnp6enaE0VVxb25e2CzB3xdtSGB9vnbtRwun6QVkau3tak0VHN7v3VSv/IHchThLWKpPQyeToacTO1uiucSLS+DEasxOiqUAxCcTeC/lJhpYoaxGo/YXY9EV7YqZOjgFzdTnT36Nykl5jQU/lWN+GMQljyFnedVozlRwgP7oqa/kSO3Nr7gzfKtUjMsFbnRLrP94wqro8i+665KedhoUXLB87+daLVq79+trnivbQ8ofRtMJ6llZy+FCh9cLPwQiBEjdbrmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoaP9WNTf5wmvZyu6GcoQqFZKcIhdp6P/7rx/8jG8Ew=;
 b=O/07Z96vCsNaxoiwfmtjKhNUPvOkTUFPycPyO331hwrYnjyF34rNIccW7HAANxKeaOm17Z5PERQt7hHDFeAuv0hViV5g25QakSDOxWtPQj84cdnJ/qjE5gE5OIx9p/drPnxBcXfbGjKVE/ajHGEthwydePNr9oF9X649WRNp+IE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BY3PR01MB6788.prod.exchangelabs.com (2603:10b6:a03:360::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.14; Wed, 20 Nov 2024 19:02:25 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8182.013; Wed, 20 Nov 2024
 19:02:25 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v8 2/2] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 20 Nov 2024 14:02:15 -0500
Message-ID: <20241120190216.425715-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120190216.425715-1-admiyo@os.amperecomputing.com>
References: <20241120190216.425715-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0022.prod.exchangelabs.com
 (2603:10b6:207:18::35) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BY3PR01MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbcdcd2-dce7-478c-1658-08dd0995df19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cLyLfRNiU49izYO21bpPEohOGVaJn5LlNlV3+ZENCMbbmoL9ztOlSp14m8DE?=
 =?us-ascii?Q?jqLnHbMVqRCgJ4mnl3Zs24+Kq4y7AtsMMkmy1G6tDevbxv4K/oLmnV8gCgbV?=
 =?us-ascii?Q?PetQGCBIUmuD3yA6xEcVQib3G5rM9QpUX6bLOzDGezBRWvItwHXKkqru/DZ1?=
 =?us-ascii?Q?2ATndoHFlec9bG0yVpQgFJyFuOdC9cRfFTRA0b72p6wCInsqiThS9iOQT8rz?=
 =?us-ascii?Q?pOHiCkOWhYJfn/QoykOQNa2G4PNNimvZYA6vnNO9OV32uQ3NyWUOSI/aRX+M?=
 =?us-ascii?Q?TQ6Et+qqDb0wVYtXhAdaIaovnWCWtulmox4MBnZ67hpIekzFgGQ5hvomfMKW?=
 =?us-ascii?Q?Q6P9CR1BJIW7gISNIg/up/3lkOhH3hOwAm12HVE0SM6pzXdCw/LWqjr2TSW7?=
 =?us-ascii?Q?1Ctn74QYFkqB3HERLcZLud1L+0cCSQZiYxdxqY/tUN+Lo+x1k7eFpjYzL3fh?=
 =?us-ascii?Q?+Oxmne5atBbaZxa1JvKvz/3ZGUjH7pPziIGkz/NlpRHWRP12aR0qtC4mVWyz?=
 =?us-ascii?Q?uhfUGtGMaQc8CXQlfnQI+CsfGSZZR8qj8/lgQaTKkUxWFXv+7xIxX8IhIG+3?=
 =?us-ascii?Q?a8Vbvivqp2LKYo0GUV6gp5kgbuup4V3nLfjTjG8eRE1YcEYOaZbFEliNnBHI?=
 =?us-ascii?Q?W7/Mjp8Pj39sZTpex5TmCzbGC7LuAGNtJc2W8pVcNF+8CADxeWDRcgAORgIe?=
 =?us-ascii?Q?+uatRUI8OhBSZzaDSaRFqLbLYk6hgGQsb9c/pcK+x/gR9cko0gBo30+eNwi6?=
 =?us-ascii?Q?ik+YKGyq/DPyT/urVTCUjSa+mveNjhYEVDDFuJoCvPZ9y7LTBLxbNyJgPV9E?=
 =?us-ascii?Q?aVtF53KM+W0V1ZXF+TgaM70UnwM3L8zz+re3Z74h1LPAnRQWN+5Y6epqGHl4?=
 =?us-ascii?Q?ptKU2ne4fpd7Y+MudVNAWQhtCwPV6zKLCoPoGkZC1Cu0CesJzVlZbDuplnHG?=
 =?us-ascii?Q?j5yP6PnpmPasjt0v2mK9dpCRhNJj42JpQnubA+Lo5F31wnWO+OzcS6Z0Ub7K?=
 =?us-ascii?Q?AyNeRnP9ALXNo1CjRt0gbnJn1H3zQeyE0kePcGKTTSQs3hv6yEOy+Myyv1EB?=
 =?us-ascii?Q?S2NtY6DfltT894Xt7Wqvd37KUVh622SVXc/NbCxkYSfRM08ikn+RCDzh4AAT?=
 =?us-ascii?Q?spy4zMP52ug5iPFeyqnSoNTshvYKdTxEMyNnPGkdEz3w5LYzfGV6SoIQ+Qqh?=
 =?us-ascii?Q?rtz+q4yVItbq2JOHeSAJvQS51MkMtS7zOrFm/8xHf7u1ShyYDv0xAhkUQME9?=
 =?us-ascii?Q?Vw4zeRmnlMJNnTyTWHgZCi25BLM+jtLP1B6JYhMeIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tWgs2xKD+gQ8zOE6+8U2nfUl1g+fUujtVunN4wk4mpLH/1IAfuKwhUPctSxL?=
 =?us-ascii?Q?WdyFY2ViP99ZA8Y07Bc1nlxr/miII5ChyF3XpF+zJbBtQBQizU0mZ2GMHwSs?=
 =?us-ascii?Q?C14NzoGo2Z6wSTqx0wIRtULBNpdWBsaZWkH/Pvf7odPt+Ud8zJg1o8ulqCHP?=
 =?us-ascii?Q?f9wxrCm/gfdqdI/IY+wqUqXc8FhJyxFLFwwIqtAjeE0m0l8R3bWHk47QYC7V?=
 =?us-ascii?Q?nDji9GRiybhW1Z38IA3OmO5fBmk/Z8XByJFJBLvJHRyUA4opKqFeu/8j92GV?=
 =?us-ascii?Q?eaknFzV9JPup++AdQQEearBFdsgf6yCsnUeQjKU48lbuBxS9Fls/b2FUd746?=
 =?us-ascii?Q?/Orx95DXsuwOPgORp2hBfKkeG3LSZRNSMCYkKdIGE78FdAaEV2aAl3+jDO9u?=
 =?us-ascii?Q?gSLUV6wjbaHBPXJ4lSRQu0FFkp4gHBiJjkX3g5aDe0ggdYzrfNB70hmQ7Jbs?=
 =?us-ascii?Q?R6QlNJXY4qvAUGwWftk3lm3q+9M/YvD+v42OaTsLbco/unwBKEA2J/I6kaAU?=
 =?us-ascii?Q?XUH2rLyt6gLUm85FfckIkqWwz1kXQNPklkVN5trRSjlR7w5RQL4aKZLLQbgN?=
 =?us-ascii?Q?kH4LWMjy0RYlx+fLyJFOoivnuILwrLKYonVvUJ3Z53xxzzdIkXk5p/2XICAX?=
 =?us-ascii?Q?095B0jOXyWr2WJYL5CEEI0CQF4HxkQz9hEHNiAOHAdVcHt/W9ohcQUpJ/vqv?=
 =?us-ascii?Q?h/mBliJYwStdDoNSReH7mPfrcJXLgeXeSIi/j6k+FuMVVTMoMGLpu5MfUi01?=
 =?us-ascii?Q?ziir8UndUEJWzlgD7pBhKf0rfo3ksmnKKA136jDC144c5Xh70GUvfIM4Ereq?=
 =?us-ascii?Q?P4grJ1d8yM4mV5/U259mO1MfLVELFYp9r1PMMZ4lSceJOpPEqkZt5qcCE2NJ?=
 =?us-ascii?Q?6EOOhjo1GwPPofx/ogvycySleSuJF7KLiWtxKF9hpTPVra+JrAbxQ3XV/3Bq?=
 =?us-ascii?Q?mWnEyj++AKvMUKhkKmYct48VLHkuzB4/lqb84ZA07NIdEr8Rc+Wd2wDNbx0L?=
 =?us-ascii?Q?A/0/tQfi3p8RLH6D/O5Dl9B3Xa56TRBtJ5oEBxdahlu8KAPXdeGn87uxfdFN?=
 =?us-ascii?Q?JKfgct3bki98q1m2QA5namsjLpioVaoRB/OaTTjPO406n7LEKMmpl1bubuVH?=
 =?us-ascii?Q?oydWSCwURtQBtQk0mHBW9P+FLW4m88l/V8V71pMbsoeHotDfb/+PYYbJacGh?=
 =?us-ascii?Q?zKiIJr+f76BLJX5fYW9QdIbF1JHRuc4sc9Z9RvMyr83fbN0K98htowt1icyb?=
 =?us-ascii?Q?tQwWoBWUs4LaQjIqbGh+EwEGAF4BHoC6w1IhZc+7qc0GypBa9JFPV5eWayRD?=
 =?us-ascii?Q?e/MU3dcJO5tshh4UyabH3baNsT5EZVpHKigxvo8Z7bS7n/TChL+LBkS+WmMT?=
 =?us-ascii?Q?kMnRsMoX9UjVNJ6C6aAX7tvcAZK6uae00O31bEUXMYD7BK2RZHWNyEZPO1gd?=
 =?us-ascii?Q?pIy1L1FAXcu2h5qknAcNaWBfq6RELP2fT+Nuw5vsQKTY2Uw/dageIzPwWXWy?=
 =?us-ascii?Q?t5/XcJNgoM8Bi/0zhiIQHKekLkZuE0aN6Z85vITVL5wpAEfl5HcdFVfG6E5K?=
 =?us-ascii?Q?eS8ZkBi5EhGZYit1s8ufb3BjU/cUThnIDNhcDzUcs/TvaAv/5Sp/1A3uPIRs?=
 =?us-ascii?Q?4CpcdUrOTP+C1DVkOx7+Kfv99igzmMY/pumXob58jvUMgNSi+EXUK8fkmdEy?=
 =?us-ascii?Q?L85lIkRP9VRWcGDZUnqas7VS0eo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbcdcd2-dce7-478c-1658-08dd0995df19
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:02:25.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTFG0AJWBlfg5r5IWmjhCrmO1+oAgvwZu0K2s49Y6yZr1mxvLpqPtFyR90AI+gyYouxUd675D/gSN0fjC+toYQsRI/7Rv2YAViPi/5uIDdBxmCESfifvhU3m6o/p54Zq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6788

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 321 ++++++++++++++++++++++++++++++++++++
 3 files changed, 335 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index 15860d6ac39f..073eb2a21841 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index e1cb99ced54a..492a9e47638f 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..c1c28d3c24cc
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#define MCTP_PAYLOAD_LENGTH     256
+#define MCTP_CMD_LENGTH         4
+#define MCTP_PCC_VERSION        0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_HEADER_LENGTH      12
+#define MCTP_MIN_MTU            68
+#define PCC_MAGIC               0x50434300
+#define PCC_HEADER_FLAG_REQ_INT 0x1
+#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_hdr {
+	__be32 signature;
+	__be32 flags;
+	__be32 length;
+	char mctp_signature[MCTP_SIGNATURE_LENGTH];
+};
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to PCC outbox buffer and registers
+	 * Note that what PCC calls registers are memory locations, not CPU
+	 * Registers.  They include the fields used to synchronize access
+	 * between the OS and remote endpoints.
+	 *
+	 * Only the Outbox needs a spinlock, to prevent multiple
+	 * sent packets triggering multiple attempts to over write
+	 * the outbox.  The Inbox buffer is controlled by the remote
+	 * service and a spinlock would have no effect.
+	 */
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_dev->inbox.chan->shmem,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
+
+	if (data_len > mctp_pcc_dev->mdev.dev->mtu) {
+		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
+	if (!skb) {
+		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
+		return;
+	}
+	mctp_pcc_dev->mdev.dev->stats.rx_packets++;
+	mctp_pcc_dev->mdev.dev->stats.rx_bytes += data_len;
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_dev->inbox.chan->shmem, data_len);
+
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct mctp_pcc_hdr  *mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+
+	ndev->stats.tx_bytes += skb->len;
+	ndev->stats.tx_packets++;
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
+	buffer = mpnd->outbox.chan->shmem;
+	mctp_pcc_header->signature = PCC_MAGIC | mpnd->outbox.index;
+	mctp_pcc_header->flags = PCC_HEADER_FLAGS;
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	memcpy_toio(buffer, skb->data, skb->len);
+	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
+						    NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static void
+mctp_pcc_net_stats(struct net_device *net_dev,
+		   struct rtnl_link_stats64 *stats)
+{
+	stats->rx_errors = 0;
+	stats->rx_packets = net_dev->stats.rx_packets;
+	stats->tx_packets = net_dev->stats.tx_packets;
+	stats->rx_dropped = net_dev->stats.rx_dropped;
+	stats->tx_bytes = net_dev->stats.tx_bytes;
+	stats->rx_bytes = net_dev->stats.rx_bytes;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+	.ndo_get_stats64 = mctp_pcc_net_stats,
+};
+
+static void  mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct  mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	switch (ares->type) {
+	case PCC_DWORD_TYPE:
+		break;
+	default:
+		return AE_OK;
+	}
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static void mctp_cleanup_channel(void *data)
+{
+	struct pcc_mbox_chan *chan = data;
+
+	pcc_mbox_free_channel(chan);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	int ret;
+
+	box->index = index;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+	ret = pcc_mbox_ioremap(box->chan->mchan);
+	if (ret)
+		return -EINVAL;
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0, 0, 0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	//inbox initialization
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	rc =  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+	if (rc)
+		goto cleanup_netdev;
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto cleanup_netdev;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	//outbox initialization
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto cleanup_netdev;
+
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+	mctp_pcc_ndev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = register_netdev(ndev);
+	return rc;
+cleanup_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001"},
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


