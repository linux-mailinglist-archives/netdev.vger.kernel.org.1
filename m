Return-Path: <netdev+bounces-68537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9284723C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21A5282A8A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6286E7F7D3;
	Fri,  2 Feb 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="T6MlAoHm"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2140.outbound.protection.outlook.com [40.92.62.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B414198A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885622; cv=fail; b=XPcZrCn0HYSQco3oFo62zg6qbQh3WsizhkqUdEVhuO6cr5VyvqoAuVGIxShQSGF93Z18vkhRsWyXBvweUPqAp/tBxZZMIPo35Jhh+38qIIiRIXK6B87u8/9wTT2RQ/5w6lAZLLAhu0gKjdkW1N5lrHkSmRWF/OnZjGm8XRzRYe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885622; c=relaxed/simple;
	bh=uKjTtuDIfIrMaCH3HeRrnWWuOCmRvK8C+lG5FootX+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=if0eBrvfteTAxzty/ltJCl6g/kAErA/REhDZxnY9AM3LRsFZqsnXum4qQaiuh5Co9VOuefLLM2/nQ1y8A4/Fnm2s0SZu7DuyO6t2tpfZC0sZ+JMV7e6/5OlkYPYKFVcP0ZtVgl4TDKR/59R+Kvqk+Zpu6BCnkVa/6AusylHIFZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=T6MlAoHm; arc=fail smtp.client-ip=40.92.62.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0ivE5iWoSQhTigouOHP8HEG8G7b7p8O85SqvTj+lRZO5vdSF8+MOsM718UVDggN69mltEeNtqkp0Rt47zWK6KDPHjGE0D2ogh5WaCb03p39yJY3UzN79biZrU0qFppsNo0HwiVQ2TTsT+OKrJwk6Orj8/gbH3zcbg3kCkWR9Dd86zQSUCS74FqKiHArTuj6ftpBvAVpC1Gl9r8fCUamIgc8XS5l8ZDABpQT3Y+2bxaQAeOD3GNFnLzSB5sZ6iNjeQD/5On2/5f1msbqX/0gyAUa8S29dZLyxQTUwbw3YDo8RWv1z6s9kupQ0MRHbUD6B2ifD+M+Ij+UUj93euhabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwDo8w5FRoVvf/S0qQNguBb0hhrKs4wcZvFIF5utdHQ=;
 b=O3jApGXcO/mlDnFYevqLGhg03/13oK8F7qB45/GjehS7r/XoqIiXxPWXC2Hso5XbqWLmf/dcTnpcfNIbVod+mKo9bFO3BFBnpv8f1zVMvU2LO7/H6T2BuqzQk4jPKLhFC4XJm3ZFfqBZn/POfC0dpDkDNCK8NSwUuNuzbgRXWeGqngCAV0MEu8JyoauDXMjJzJmbkckYhMSVllNnT+77mg1gb5TJpAVCBVarC6RUgB1wEmcdBZ01CUYQtGS3FyxOVUqU3LScxbh/qGiYpswfEpOXhXNRENOcnt/Yh0HqZus2lyDK4NQajyXkcIckmhIPpmOBIFIEvz9Ph1OAvoDQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwDo8w5FRoVvf/S0qQNguBb0hhrKs4wcZvFIF5utdHQ=;
 b=T6MlAoHm7bjiZVSw7gGASNuZ+mgW1VRgbsnv8jnS8pLoFlyXQ7WWikN+ElTSzk6WocQBjyWFA6fQF7M529FThUBbjdxejlgwjrBNBGsTz/fy7FmL5EVk8sLdeLMqVSuEYRCo5SHzsZ5187BBkcN2JpPAqNMMYX1Bi9oA8MdQ5CKcv7EPDYNcm9KeuAcrYSfdizybMsvNbLjgy/rvt3Wc9JVd6KBzHrsBO7vU9jw3SqZC1Sz75ZueyaS3ze7gCEOtQCxVdQL5J6WrVVimX5g+3eYdpUt3xKP2BZ5dqH176ffN5tsuGrGRkOI6div9TP+jc+NrFN6zusrObJtOPStqZA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3821.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:1bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:53:32 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 14:53:32 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
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
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	letitia.tsai@hp.com,
	pin-hao.huang@hp.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	angel.huang@fibocom.com,
	freddy.lin@fibocom.com,
	alan.zhang1@fibocom.com,
	zhangrc@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v8 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Fri,  2 Feb 2024 22:52:47 +0800
Message-ID:
 <MEYP282MB2697E01787526EED515382C1BB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202145249.5238-1-songjinjian@hotmail.com>
References: <20240202145249.5238-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8RtzYuG8V7isi+ROrYgwVYIbj2Q+vfdu]
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240202145249.5238-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3821:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ed4dd3-b069-4309-0e3e-08dc23feb98c
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6fTa61voF783eI3ZA+3oOgpha8araGTsw5CgQrxMTInpgGBaqdFe7k+ayRLbQAoGne456Wu/LfQu02VrRsKOW6jlpqBOmJOAKoHWFU9godOj72neXPLh1A7oiWr66EKZoKma08vG8DDIJb+KXoFT0Bk4TaFIfENLcHTJtL2gYrZZxZEWQvp8kcDrTOpjloKslcxtywSKFWmqI9OLQgB0rAxGFBt6sKSlkKYijIx6PkpZLl8WfyKOzn6RqUMpq9YyJFMbdXkg21G3NnkHi1uSraTL/gHyF2L6ETTo8e7dbuTrco2CCM6PRuf7BQjkPNDHj/qO6gDZ/8RyBeJvvRLNgl8GqDW1a0dImUP38PZLJi6yUjjt8xWfUqMSFk8O2j1oA/7Q57pnMU+MwG80zrwFg67K5csTsN9VCYHFbqnu5HbehRyJWJrfNh77mhMc7KKetfsjTrFjZB0HioPti9a4TvyQ+UrOuxmue3onQREgfbUZycMq3XhCtwZuZWWzRapxHIuJYfI2ZrUDmGo3JOFyJBcg+l3PsmFUJM01YoQPqnGTaOt0HDH8sNmxJ04kgW9oY8KkR9qmpfpfL0462WOkRpa+B8FDYqceNCpJ3Azl8747ZzjTHY5evoEAv+t6zwXI+13LL1iSLAyb1fhQZq4sG8JDvfz0y6GVn8IpWEBn3K6ZzESnCQ4WwcrKRI0DhA/Gey62EcfKTJxjItKF/5Yf1IOoUFJyVOQpHXU/9vvXMqXCeotPKKQONJEpFgOi6RB6KY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SAkCmzdJLEkEdGU+KDB33YZcsVNVozmDhIVn+R3/XaWbXDf5mAX9f9pjRdclHD6tgR56IZ+GQm6FshEpRpRfUEIpw0V7yWrmaGaXnVUiqSS92VnbH+6+++tqWMCqg7Ye+DpGqPIi4oLknYJbWMYOiC5Wo07mK1CpmIdJ5xGGd/XY88hy6/oeeNpksQglAexhTvdi4JxLBXj4sTQO+dW1yGJdp1fGp2MC1HoJPgUFSDCCLKDd+kZp+PWEJn299+uy+5P8bp7AmY3YlX9EAo1zEG/5nw55/gx70QPiXDnicC3Y6QT/xD1kbMySQCjwxPYjI3kbUyd4aWJMUz5yRfgPWMdFxZranLsU+ZqHqxZ7lEY/1otvIg19FfsndwNZ9PpOf5LCy2g9uhG4jClGCfCAW9qrR4ffSzh6Aef03Dlt/m2CknBUHTxUuNU7JEWg46oSjL0oVJYye4I08G8tYehyNlZHkLkOhjlzRdwjF0xkwWlMwcu+7WLAZynxAOeZMj6iY4tp2lF/57dJbgHqK7BHCZwHH74ps0mePMH4F70upl8/ycOkoBw4cKWBnkHA2mi5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tBWrWXaLro12VzzuMg56IzwrHra3KSS+gk1MLXkAesia/Ip9RB5fjyCE/tEW?=
 =?us-ascii?Q?n3LsByA+39uStinXALGpxHMHi55bL9RO83lEJTHpVEGJ4ZRI/o2GJfUA3icu?=
 =?us-ascii?Q?kxWSU3i7Pzvz01eRoZrHM4uARgAw34u/yIsfY1SOCO3l2doareZW8etHfHtz?=
 =?us-ascii?Q?nVpyX12YSkeORT2JE/MMmAkAc+JqeQqbtR/roe18regj90PTOm3fJ1IHqbrE?=
 =?us-ascii?Q?iNnavOLfZNn0MhXXQ3Fgi5DUtI+hjQJ2Exhrhlbr7kVm89AotcTMIFZvtWZo?=
 =?us-ascii?Q?iGl+Ll1rKLJCzRoYHCPVQL3v4dY2p5kHA2E9GkEeSUPLVANgqp6JN3FYtWfg?=
 =?us-ascii?Q?biwwUmcjJDQ+KpdjAOTKuJ0sZl2fU/zBOWdjT7vd7lINDfZ4VHpE1PybwHXN?=
 =?us-ascii?Q?npyW/u6hcucbSQNUhqKUI/Y3WhU5PjQAZKN3/ShPEy1oabOhYV+canMbw2x8?=
 =?us-ascii?Q?LSYK+XZ+O67Ga13kREZ1zsZYxth8TqiWAg738A4Rq3VViQYU33h82RPS2Tbt?=
 =?us-ascii?Q?sWENNtuGq1SzVnqkYUnRzEwwxuYgmyCMh/cSbEKmEirsm5diHK1qKk76MGPe?=
 =?us-ascii?Q?IvygMaPuywS/J468C37cZZtn9PWbyw7XEg4FeDS1doTV6vJMd9ii0D7Y2Ju4?=
 =?us-ascii?Q?bHUjvvhnUlazEfECgE4h/vDw9i2fe7oaYHbJ6i5HkoTP5g5olPCesz9vTAVV?=
 =?us-ascii?Q?+WgamBwosOtNpbOw1y8bOc06tsxbI/oEQEZOn/iRwrsoIECI8OvomKaKrRfK?=
 =?us-ascii?Q?ed45+csiPrPnEcPo3j/4LGyOWaO6kt5Fq+5FtI+BCyWIuPu5+V2yl5O2zXL6?=
 =?us-ascii?Q?GKnzL6mbKLfs/y73hyhMO5Wze1VI1JnV7BwTSvApLt+BjAD35FZHmLKGa3sI?=
 =?us-ascii?Q?G3+6UU9T/aGkyoHAEzNynhhkV+X2Sjb/4lcTmmJbUSqwDd/5nvuXIVblffwO?=
 =?us-ascii?Q?XmcJuD66VF+EJDR2jHAGjikDoOkaYxcSSOEq65RKMtlNQ+yssiDRW/r9b+nC?=
 =?us-ascii?Q?DTMM8ib3R9SvZoOvQ1stDAryObVIgfZFJ3Ib2y1iUDTvwbzHb7ZqbQpPK8WH?=
 =?us-ascii?Q?I7ngdQRWksQeSnqGpaRjRrhVuO3KcZSAbNAEl+aSbfGTt70iDELK8pwqC+H4?=
 =?us-ascii?Q?xzvHmYBuarmadP5I6IcovKLF8Hp6qFG41spdYCjxCQgdkZULDA7hd4mRAvEe?=
 =?us-ascii?Q?whOe+Rjq+HMdu4TmNqvCdTNZmHiu+lOigmBGMQJsWiPeApjpeB1WXuC9eDw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ed4dd3-b069-4309-0e3e-08dc23feb98c
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:53:32.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3821

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for userspace to get/set the device mode, device's state
machine changes between (unknown/ready/reset/fastboot).

Get the device state mode:
 - 'cat /sys/bus/pci/devices/${bdf}/t7xx_mode'

Set the device state mode:
 - reset(cold reset): 'echo reset > /sys/bus/pci/devices/${bdf}/t7xx_mode'
 - fastboot: 'echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode'
Reload driver to get the new device state after setting operation.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v8:
 * change sysfs t7xx_mode to lowercase, modify spelling in UNKNOWN
 * change sysfs mode_names to t7xx_mode_names 
 * add t7xx_mode check in __t7xx_pci_pm_suspend() 
v7:
 * add sysfs description to commit info
 * update t7xx_dev->mode after reset by sysfs t7xx_mode
v6:
 * change code style in t7xx_mode_store()
v5:
 * add cold reset support via sysfs t7xx_mode
v4:
 * narrow down the set of accepted values in t7xx_mode_store()
 * change mode type atomic to u32 with READ_ONCE()/WRITE_ONCE()
 * delete 'T7XX_MODEM' prefix and using sysfs_emit in t7xx_mode_show()
 * add description of sysfs t7xx_mode in document t7xx.rst
v2:
 * optimizing using goto label in t7xx_pci_probe
---
 .../networking/device_drivers/wwan/t7xx.rst   |  28 +++++
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |   6 ++
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |   1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 101 +++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              |  14 ++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |   1 +
 6 files changed, 145 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index dd5b731957ca..8429b9927341 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -39,6 +39,34 @@ command and receive response:
 
 - open the AT control channel using a UART tool or a special user tool
 
+Sysfs
+=====
+The driver provides sysfs interfaces to userspace.
+
+t7xx_mode
+---------
+The sysfs interface provides userspace with access to the device mode, this interface
+supports read and write operations.
+
+Device mode:
+
+- ``unknown`` represents that device in unknown status
+- ``ready`` represents that device in ready status
+- ``reset`` represents that device in reset status
+- ``fastboot_switching`` represents that device in fastboot switching status
+- ``fastboot_download`` represents that device in fastboot download status
+- ``fastboot_dump`` represents that device in fastboot dump status
+
+Read from userspace to get the current device mode.
+
+::
+  $ cat /sys/bus/pci/devices/${bdf}/t7xx_mode
+
+Write from userspace to set the device mode.
+
+::
+  $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
+
 Management application development
 ==================================
 The driver and userspace interfaces are described below. The MBIM protocol is
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 24e7d491468e..ca262d2961ed 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -177,6 +177,11 @@ int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev)
 	return t7xx_acpi_reset(t7xx_dev, "_RST");
 }
 
+int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev)
+{
+	return t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+}
+
 static void t7xx_reset_device_via_pmic(struct t7xx_pci_dev *t7xx_dev)
 {
 	u32 val;
@@ -192,6 +197,7 @@ static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
 {
 	struct t7xx_pci_dev *t7xx_dev = data;
 
+	t7xx_mode_update(t7xx_dev, T7XX_RESET);
 	msleep(RGU_RESET_DELAY_MS);
 	t7xx_reset_device_via_pmic(t7xx_dev);
 	return IRQ_HANDLED;
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.h b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
index abe633cf7adc..b39e945a92e0 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.h
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
@@ -85,6 +85,7 @@ int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_md_exit(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_clear_rgu_irq(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev);
+int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_pci_mhccif_isr(struct t7xx_pci_dev *t7xx_dev);
 
 #endif	/* __T7XX_MODEM_OPS_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 91256e005b84..f99eb21cb8cc 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -52,6 +52,81 @@
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
+static const char * const t7xx_mode_names[] = {
+	[T7XX_UNKNOWN] = "unknown",
+	[T7XX_READY] = "ready",
+	[T7XX_RESET] = "reset",
+	[T7XX_FASTBOOT_SWITCHING] = "fastboot_switching",
+	[T7XX_FASTBOOT_DOWNLOAD] = "fastboot_download",
+	[T7XX_FASTBOOT_DUMP] = "fastboot_dump",
+};
+
+static_assert(ARRAY_SIZE(t7xx_mode_names) == T7XX_MODE_LAST);
+
+static ssize_t t7xx_mode_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+	int index = 0;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	index = sysfs_match_string(t7xx_mode_names, buf);
+	if (index == T7XX_FASTBOOT_SWITCHING) {
+		WRITE_ONCE(t7xx_dev->mode, T7XX_FASTBOOT_SWITCHING);
+	} else if (index == T7XX_RESET) {
+		WRITE_ONCE(t7xx_dev->mode, T7XX_RESET);
+		t7xx_acpi_pldr_func(t7xx_dev);
+	}
+
+	return count;
+};
+
+static ssize_t t7xx_mode_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	enum t7xx_mode mode = T7XX_UNKNOWN;
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	mode = READ_ONCE(t7xx_dev->mode);
+	if (mode < T7XX_MODE_LAST)
+		return sysfs_emit(buf, "%s\n", t7xx_mode_names[mode]);
+
+	return sysfs_emit(buf, "%s\n", t7xx_mode_names[T7XX_UNKNOWN]);
+}
+
+static DEVICE_ATTR_RW(t7xx_mode);
+
+static struct attribute *t7xx_mode_attr[] = {
+	&dev_attr_t7xx_mode.attr,
+	NULL
+};
+
+static const struct attribute_group t7xx_mode_attribute_group = {
+	.attrs = t7xx_mode_attr,
+};
+
+void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode)
+{
+	if (!t7xx_dev)
+		return;
+
+	WRITE_ONCE(t7xx_dev->mode, mode);
+	sysfs_notify(&t7xx_dev->pdev->dev.kobj, NULL, "t7xx_mode");
+}
+
 enum t7xx_pm_state {
 	MTK_PM_EXCEPTION,
 	MTK_PM_INIT,		/* Device initialized, but handshake not completed */
@@ -279,7 +354,8 @@ static int __t7xx_pci_pm_suspend(struct pci_dev *pdev)
 	int ret;
 
 	t7xx_dev = pci_get_drvdata(pdev);
-	if (atomic_read(&t7xx_dev->md_pm_state) <= MTK_PM_INIT) {
+	if (atomic_read(&t7xx_dev->md_pm_state) <= MTK_PM_INIT ||
+	    READ_ONCE(t7xx_dev->mode) != T7XX_READY) {
 		dev_err(&pdev->dev, "[PM] Exiting suspend, modem in invalid state\n");
 		return -EFAULT;
 	}
@@ -729,16 +805,28 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
+	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
+				 &t7xx_mode_attribute_group);
+	if (ret)
+		goto err_md_exit;
+
 	ret = t7xx_interrupt_init(t7xx_dev);
-	if (ret) {
-		t7xx_md_exit(t7xx_dev);
-		return ret;
-	}
+	if (ret)
+		goto err_remove_group;
+
 
 	t7xx_pcie_mac_set_int(t7xx_dev, MHCCIF_INT);
 	t7xx_pcie_mac_interrupts_en(t7xx_dev);
 
 	return 0;
+
+err_remove_group:
+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+			   &t7xx_mode_attribute_group);
+
+err_md_exit:
+	t7xx_md_exit(t7xx_dev);
+	return ret;
 }
 
 static void t7xx_pci_remove(struct pci_dev *pdev)
@@ -747,6 +835,9 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	int i;
 
 	t7xx_dev = pci_get_drvdata(pdev);
+
+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+			   &t7xx_mode_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index f08f1ab74469..49a11586d8d8 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -43,6 +43,16 @@ struct t7xx_addr_base {
 
 typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
 
+enum t7xx_mode {
+	T7XX_UNKNOWN,
+	T7XX_READY,
+	T7XX_RESET,
+	T7XX_FASTBOOT_SWITCHING,
+	T7XX_FASTBOOT_DOWNLOAD,
+	T7XX_FASTBOOT_DUMP,
+	T7XX_MODE_LAST, /* must always be last */
+};
+
 /* struct t7xx_pci_dev - MTK device context structure
  * @intr_handler: array of handler function for request_threaded_irq
  * @intr_thread: array of thread_fn for request_threaded_irq
@@ -59,6 +69,7 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
  * @md_pm_lock: protects PCIe sleep lock
  * @sleep_disable_count: PCIe L1.2 lock counter
  * @sleep_lock_acquire: indicates that sleep has been disabled
+ * @mode: indicates the device mode
  */
 struct t7xx_pci_dev {
 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
@@ -82,6 +93,7 @@ struct t7xx_pci_dev {
 #ifdef CONFIG_WWAN_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	u32			mode;
 };
 
 enum t7xx_pm_id {
@@ -120,5 +132,5 @@ int t7xx_pci_pm_entity_register(struct t7xx_pci_dev *t7xx_dev, struct md_pm_enti
 int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity);
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_pci_pm_exp_detected(struct t7xx_pci_dev *t7xx_dev);
-
+void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode);
 #endif /* __T7XX_PCI_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 0bc97430211b..c5d46f45fa62 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -272,6 +272,7 @@ static void fsm_routine_ready(struct t7xx_fsm_ctl *ctl)
 
 	ctl->curr_state = FSM_STATE_READY;
 	t7xx_fsm_broadcast_ready_state(ctl);
+	t7xx_mode_update(md->t7xx_dev, T7XX_READY);
 	t7xx_md_event_notify(md, FSM_READY);
 }
 
-- 
2.34.1


