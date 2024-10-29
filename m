Return-Path: <netdev+bounces-140005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81E9B4FDB
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD34283331
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C901DC74E;
	Tue, 29 Oct 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fRfSPC6j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCF1D95BE;
	Tue, 29 Oct 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220874; cv=fail; b=F4SJNmstBtOdrDz06qmVFr1ulFQbjzmf0FyQ8jejQIu1ZwYGiM0WcsC/dNM8+vIcttnh8MBnME6lpb+iOMU55jtCWk3Os5OPcBCUP1GeB6sm7gxW0tMfcd92XfVaDqhssMamI9scXIQsjuFSVyP2Q79ypqQuIhCEjD4GC5FDHF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220874; c=relaxed/simple;
	bh=Y9N4/9qqyLRXS9U5b7XP16LPgpOSfH/+4XBYzFFf8j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dv7EOG0lp1STPMVLyupbhJsTmJXkvE7jo6zMRxm+mpNNUu5m/KvGdhki/gjKiLu3AY5rO6OGCo2+fBceuh829ZAzWE+M7DqF25UxVh7my19iaibszEuet1f1633r8UszOKQNvghMp4dufV4k9rl6rI8k2dP4T5119WrDmbpCyzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fRfSPC6j; arc=fail smtp.client-ip=40.107.93.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY9PPk5eMRqEAMkMuHAD+ufS3gW6ZJZGdnVZJPp2z8INc3gh80v8zho2ruf48M6HKI3VC5mjZpHKdSk7VhQoWXO1tluA3w0vKlsj32ueVEQTW2VR6Fcn9iXQhqUbkK/ctS4JIyumuK7tzjt9g+uW29uDJE8Tir+w0cH/VGE7o54h7ONCuojijrVY98gthwbq60X6KPhmp/NeG0k08I1csOCyD2OcAqZn7UcC+Z/026uQP4lvJvx/mWr0i/GhhdTfkzONufK1nXbdcynzY7Yn+vW+8tsNu3NnrO8hZsyRfpJxbMsDf5nXzJvG6ASdOGUNkKQqqey3A8wkjsVPhM8izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwOIlIsou09us1IUQ8OyuwDCoh8swhSvx4i/Eu0bhrg=;
 b=GNjkRyvSJxGAm454krr1ZWWbz3VjL5O+FBllDrXsvlV+fNUtMVxWQzXcnFpvSqX5RSwo1bAE94BcRAYNzbGNePbp4v5Lo68lSqtlV9ORXDe7VxHoE5oRDZGGxMN0HE9UKFP/RHRCZsUEqEWEErkW6sYDYjGyHol5RLHBCxTLp1VGmGy2oao2JQ6trJPy9L+2AjcGQGr0G4lOriHIaxy+wSnuvqmNMcGvLbBCqoDhISqYSFuo0q9TYamXp+K3ZKSuFjT/OPpWNiAdesX6YlWgRwkCdGUDQN1JMC9y3JDmzuRcCbKe7ULpYaUy6LiEkVrQp1nBpUCnFCOex+BpA2J5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwOIlIsou09us1IUQ8OyuwDCoh8swhSvx4i/Eu0bhrg=;
 b=fRfSPC6jiGabJh4en+7aVj8VVWyE4ziWVRtVz80gOvxgowZItjakexxJerE/+fDA3tGuSCG7UQD8CKL/paNBcdNh98maPVyIkCKb8GUQzytjaHAcNuObBjCpXDiYWs+c1c9ZTiEhU9avvz0ye8VFNoO9a+YqPgQS+mBtf1GZiPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8372.prod.exchangelabs.com (2603:10b6:a03:542::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.15; Tue, 29 Oct 2024 16:54:27 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 16:54:27 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 29 Oct 2024 12:54:14 -0400
Message-Id: <20241029165414.58746-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E01.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1c) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 643aceac-7f17-46ce-544d-08dcf83a598c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DkHoA7u6Fxfi7wMKVRPe/zP8RzbDGD7MPvSQOsD3r999+by4PxXZmJDSGOfA?=
 =?us-ascii?Q?y25ebZ401Id22Bjr7QYkE2K+Go/T4pev6GXbWVtpvw5JYS2uAy6ZM9d/4dJX?=
 =?us-ascii?Q?Y7RgX8ogenCoVgGNVEIE/BbCPHK7ZsHeQMp0TGtM8aQ4TaJFLUad19Gqe1RJ?=
 =?us-ascii?Q?TxE0Zaf4Jaiubausi/hZkMmO5GbKp23+eu/LpP6wvI8c9x6pkH5SCMvGS3XP?=
 =?us-ascii?Q?CKZ9Zu038Vo++HBGtJTN0S6lpxy888nzGGvJHZYvA+j8mzZE2+R4R3SHwc0+?=
 =?us-ascii?Q?zOf9GfX+A3dz/Z6KcuPHk+7wCCWftiIJwZCUZBzRoaOhbYfmOx4A8zGH0LOv?=
 =?us-ascii?Q?8RMRtg7rLZK2Nza6NOUOPA/F5iBUccJPapqXPNzL4RFTyp39nV86rzwfeUs3?=
 =?us-ascii?Q?eDCSZ1zMc39ezKwqLJPMLx+z6MFwStKQDEGr7pN6RPZtSB7AEtXccFaAALZ/?=
 =?us-ascii?Q?0UN22MEvr/nEj2rIYen1olQJw6Sze6soVSMrZg+xFZNsLdRNSlfH8G+llP4M?=
 =?us-ascii?Q?XyNwNVWT/qkiLggHrYlZBsiRoZ0cNKSK0fnkboblNIswpLOjaml93xT5Ddvy?=
 =?us-ascii?Q?IQwCloNIP8FZ3iFW9VQuJMtuPvglzM4X0PopCjFRROcafxqkt1+H3MXFkrIv?=
 =?us-ascii?Q?L7y2sU53QWb3aZFlDfXqG/P7tGqQLdDpqh1p1epOoSXRt5ARf2NmXBuz7fMO?=
 =?us-ascii?Q?SKj62j4q9dLyEObhgnFhaYYZuN0YvlWcfl2WPgZOrEETQ9qr2z0OamMLpb6l?=
 =?us-ascii?Q?xIC7xB+PuLP85/myrf3hBzb6RpVueFcuqIcGOcemTm7FXwJaZJ1jv+d0XNfv?=
 =?us-ascii?Q?sRfbIjqjwTGJK+LK/qws4xCO6EoH+iAuuW5kNMLOdfGIWvEoS7bpZ6bPzYmv?=
 =?us-ascii?Q?QQw/qOpLstFUQnZ9eSO8yeQ289oAmBsI8vAlTGseUAnrANDWXLQc9GlhvgIH?=
 =?us-ascii?Q?YSm88/C1yWIMsUCUMBvk2+Ck5Y1/51rjRYgW5unO0sGsOJemcnHMslOWePHf?=
 =?us-ascii?Q?oFzbk9NfE2C9LqLyqhWGjIwrADYgPwDZEQF4oc488oTKnulenrgYgKRuKUdj?=
 =?us-ascii?Q?lzEPo44VfrbzRjiFrRpMvI2/luGMD5UbXivU3zU7eB83ggf2RhJD76BJiuHg?=
 =?us-ascii?Q?Pmp7TinHS72mliODcUWGFRkL8yhcFIMoeAxDETj4q38JP/dD1nfgV9bfFrm7?=
 =?us-ascii?Q?kAyQxILObZVvD6U2mn3a+M3zPDAXL4lKNQsCDqHYU8ZsWym8BA+WEFOXuWfu?=
 =?us-ascii?Q?mKF7Zf3rTIP4Cq8UaWTN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kF0oYPx+2UAPcy3EfESUvmE+pCaSU/S5Ea9uRk97FCoCUzHJfH4PY/Mbj2QH?=
 =?us-ascii?Q?4gKY6zEDZUFNWX0qTb+rG7dealIUmENBMSXMJWVQHjtPq+hREFKLWZQjrUNP?=
 =?us-ascii?Q?xyV5cO1fIz7ySFSbk+AdUWBGp8saDEAec4bFcIT0fhBp0j3KITQPijJ4nXba?=
 =?us-ascii?Q?LterQhSrF8XbTCi+QHg2bvZ3yn0ByUqPnOf2pv084qkdW9/WoFyohxJQNo50?=
 =?us-ascii?Q?dB2ormbC5nXsc30r1VOcpPfxaKvk1WcsjXYTVwx5v5nfUK9jmOvbkx7+dU3i?=
 =?us-ascii?Q?TiUlT+0pvyNtkQLN3iRk0Z/gL0ysFLs5l9OBnIDju+BDeLfwAjETZiQIf2k9?=
 =?us-ascii?Q?XvJIGZ7+KtP1n3CROw6vSuxSMq6VgCQiSC0+Pj2S7Wwd21RQF9wXhtFjivs9?=
 =?us-ascii?Q?l/GrekTWv7sx2juE7PXazJ5SjOkReoyegY4yGAXT2TvSQn1uWS79Sxq98l9C?=
 =?us-ascii?Q?dvAaNQ4E8yt52oog+IcsUEzvGl+7o3XUzOvSfEY59C/coABSJiHZjFFNOatI?=
 =?us-ascii?Q?7HLwVO2OWJ6BWX7cPNQX5KGK4WIUc3OpbDC0AYMLgeD9iZUMjN9Wq4lDL+UQ?=
 =?us-ascii?Q?b1m7TjbmU9ulYYE+fsSGnly8sfKObszdlGUUIWBCyTs9dSn52szToTJ4fNPn?=
 =?us-ascii?Q?GOGFHeTE84fCe3JJbcTu7sSAzC1rNMrbx+Q0fMjh8Ku/BvhEGjHPLSwfreUB?=
 =?us-ascii?Q?Iyjaxr978huyXLUbQkMNWV4Nkjmlaz71AWe9OrFttDCoi3cx1nmEQEQmHDfX?=
 =?us-ascii?Q?qihfUTVe4jIzCCFIDhe/aZhQbDhuGCnMAglIgGCvKiBZdpWat7NRruigL2IM?=
 =?us-ascii?Q?8TUJUxdlPf5mgCAAY+IkSWv6Lz3WbpHK0On4L/q4YY+miPxtdgj691+tRAaC?=
 =?us-ascii?Q?I5rjwleRojD1rwQ521XrTrS2wPdqdXmKN1clHQ/YFoRtXA1fOJ4PDZh+iaxt?=
 =?us-ascii?Q?gB2eY4BtBSCF0x+PhLh5XvowJCYhqeQgji+IsrgIEmjsapdq7dnM61JqMryt?=
 =?us-ascii?Q?L177A7GW1JeUlcNxhzCCN5FNhOoWkk6Mkktp5RU3w7JMlEH+B/m71GmsNYCL?=
 =?us-ascii?Q?0FK3I+db9WrhBmvoJPVL0rXajDXo0dhyWXrvtMFGabG3cK85+5vvCNooqwtR?=
 =?us-ascii?Q?GqFrgqbqTMfRxWCxfpxEXMyMxBW0Tcj7hl0M8IoBeeufBsTNOlsgcsOiWPIm?=
 =?us-ascii?Q?/YFmxZr0EiDr3ooBf7CeqC5316tLGb2Q44bzH86t6jbwa27/l6is5p/dn7oC?=
 =?us-ascii?Q?1m+3iahgswqpOwrMQ4WgdrtXkXczS5yLiTOkl1DziGe3wNvPQUaK8+viA4+3?=
 =?us-ascii?Q?UUA/ttFE4HVCa/ldhXjcLRpbXzyotY3UtYzGz2HwQB+LqYX+eV70QhS3fzjp?=
 =?us-ascii?Q?/eEQWUJQ2oKoFJW/k/B59mqO5ksFww6Ns+RoKY3XT/Bw1eS2aU+937fuLKcG?=
 =?us-ascii?Q?ojCYt6MUlheJD5IIjSCVgzpdWpzDYizP3p0jDe7S70bM+KjdAlToEjADXRHg?=
 =?us-ascii?Q?wbXSYun79AcApqe+rMVeJhURGaf0ALzaLrOVyMFUJyUKrEWMjtLlYKr/CVIu?=
 =?us-ascii?Q?vTU8CcEk8Q1aaM9vjrbn4zsKIkZ8xb1+WBETeBpZJRpDbSVWfdjCeGvGGDgS?=
 =?us-ascii?Q?wcqJs7s1B9np81UsEgUK5GLZM1VPez+ytBK7VNj0dhb83iEUHRw2YtL0M0kJ?=
 =?us-ascii?Q?nMrky53/FPPidFyFCMPX1wQLLDc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643aceac-7f17-46ce-544d-08dcf83a598c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:54:27.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gOgjrxgp4wHg8iakET0Web9vcXggQi6a01arJBFr5l6Mp58nnM7YkqdwORirIi4q2J3wBD9DJYhxUaCpQGovIvR/yr1INE5vpE7p1bEEuKzNdO3p64mAC1hV02l5Buf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8372

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
 drivers/net/mctp/mctp-pcc.c | 332 ++++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index 15860d6ac39f..7e55db0fb7a0 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	select ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  commuinucation channels are selected from the corresponding
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
index 000000000000..b21fdca69538
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+/* Implelmentation of MCTP over PCC DMTF Specification 256
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
+	u32 signature;
+	u32 flags;
+	u32 length;
+	char mctp_signature[MCTP_SIGNATURE_LENGTH];
+};
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+	void __iomem *addr;
+};
+
+struct mctp_pcc_hw_addr {
+	__be32 parent_id;
+	__be16 inbox_id;
+	__be16 outbox_id;
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
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_dev->inbox.addr,
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
+	memcpy_fromio(skb_buf, mctp_pcc_dev->inbox.addr, data_len);
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
+	struct mctp_pcc_hdr mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+
+	ndev->stats.tx_bytes += skb->len;
+	ndev->stats.tx_packets++;
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	buffer = mpnd->outbox.addr;
+	mctp_pcc_header.signature = PCC_MAGIC | mpnd->outbox.index;
+	mctp_pcc_header.flags = PCC_HEADER_FLAGS;
+	memcpy(mctp_pcc_header.mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header.length = skb->len + MCTP_SIGNATURE_LENGTH;
+	memcpy_toio(buffer, &mctp_pcc_header, sizeof(struct mctp_pcc_hdr));
+	memcpy_toio(buffer + sizeof(struct mctp_pcc_hdr), skb->data, skb->len);
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
+	stats->rx_dropped = 0;
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
+	pr_info("index = %u", index);
+	box->index = index;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	box->addr = devm_ioremap(dev, box->chan->shmem_base_addr,
+				 box->chan->shmem_size);
+	if (!box->addr)
+		return -EINVAL;
+	return devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0, 0, 0};
+	struct mctp_pcc_hw_addr mctp_pcc_hw_addr;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS");
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
+	mctp_pcc_hw_addr.parent_id = cpu_to_be32(0);
+	mctp_pcc_hw_addr.inbox_id = cpu_to_be16(context.inbox_index);
+	mctp_pcc_hw_addr.outbox_id = cpu_to_be16(context.outbox_index);
+	ndev->addr_len = sizeof(mctp_pcc_hw_addr);
+	dev_addr_set(ndev, (const u8 *)&mctp_pcc_hw_addr);
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
2.34.1


