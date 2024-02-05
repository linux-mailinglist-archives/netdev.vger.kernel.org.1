Return-Path: <netdev+bounces-69067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557358497AC
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5911F21087
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299916436;
	Mon,  5 Feb 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="o8uaNyVE"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2170.outbound.protection.outlook.com [40.92.62.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224817543
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128584; cv=fail; b=vAdaodxjwT52ZFumnOIN1oRLUx/kuuNNF9QMBe1Jv4asnpQao8wQJRiXQMp96ZKHyYiDR0MffuUu2QE1RK6NRS5EJY+NIS0yFEJmsYDi6MC7qASfBx4crlAWlnh4ODgNMctg4UxJoXcrzm7ySj1lQYxQhmzcgsPYJzolFl4Tor4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128584; c=relaxed/simple;
	bh=Xj45aHC17xqfSHuN5YFJ35tXrNtdmCxL+ezpRvYgrLM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fJixu7fzL0IDc2DIoYmQEhGWjxiKnEdcq5lQLggnPn8q5/QzVzAwFQO3Fqi05HMaFre6uu3RB+PqlF0cTlQ2LNkFBvc/PgtMWN3nJatkRqOSJMDEUT4hup+T0E9byoRmTcmUAh2GIlDa6w8wG32theJqX6iwiTK61swHcK7bYOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=o8uaNyVE; arc=fail smtp.client-ip=40.92.62.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrmZcseIsdqHI2ELxYxNobH4//4Z4jeT5G5zwbcA2zVKsxAkbPrdWb+7avEl7uJfwX2o0jv6WWzBoTXZpyeghE16k6jh0HhxUpq7CxdHkmvPIfCiXGJN5HJ7Bp7uc6I8T9OpWFTDZwvutHd8xod0Sm5lprek3r02dMn2sqBYB8oSb+BF22FEncM5zyZ5ZlgwMsrBF27WOdw2irT83Vs17+xEBc/GUx1g+kfIFlI3Xlw0UeAbtiveA4ts6VdhJNHO4ABeZSm+IqN/9jr+Ny8KjxfW7XN3XcrWPrciWO6t0u7JZds7ioiARv6gY7lj1rRkbbU0Wd7zv/oEsenkzJLwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDQ52S/Q/vbtGXE3ZrX72QHGus2YSttmes/Oypg2IkI=;
 b=jjSeqFdQ8AdhuUV18wTU/cbwZLDA2PG3EQozsYDPYIkdZ6bRIRtTKPR6BxYo+MP/u1UnD5kJPP9JWLqbQrjez3OlMTWF0mX2dCrWtzjHfv5xRtzli40b5sc4qKrT33MzxQenTIG0CIO3+DGoOV74inZ+rQAW2jtlK0A/YPBLPPXGXDPiRBRk/oRuI0E8YUiBmZRRU13F7nOEGciJPkFAt8OPpxSviX1Tj5CSWW48GWXLJ2GHmdZD3YjugcI1+QWnGZZnIMPv0MeQvWS+Flu1K5SM8RAu77wZ12nAtqtViceq0gcpEPdH//lnWp5VXSfaC/p8rAEufJv1MURsDV/l4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDQ52S/Q/vbtGXE3ZrX72QHGus2YSttmes/Oypg2IkI=;
 b=o8uaNyVE21m+fzX9Uz+acCiJkiUiTL9O3P8CkRzzi+o2UaxF39kYQB7veC31UckLkjyclL6ydR9LSia308b+/6zJnN2Bd1Z8qLj537SZ1slCB2o8hFMSMry79962MZc04FEtBKyusshkxcsBfwe4yrOFdfpPeVLVYf0UHxx5jgQ/sOa0/XxJzfLJRtkcrvtcXaw6yJHbPBqXGfryd/XXNN0UnDYqcP0grHscuJlhiO5m4oOIMjHk7G0XQXzdd3GG0CPJrQ/5pGkGlIsrH1/9Yf2hqpaTY5OQbNm5hzb2zUZyQ3rjrL48yNJWXHmA+jP/yJv5CnV+VlTKTs5ZDBT4Fw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB0886.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 10:22:54 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 10:22:54 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: alan.zhang1@fibocom.com,
	angel.huang@fibocom.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	freddy.lin@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	letitia.tsai@hp.com,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	nmarupaka@google.com,
	pabeni@redhat.com,
	pin-hao.huang@hp.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	vsankar@lenovo.com,
	zhangrc@fibocom.com
Subject: [net-next v9 0/4] net: wwan: t7xx: Add fastboot interface
Date: Mon,  5 Feb 2024 18:22:26 +0800
Message-ID:
 <MEYP282MB26974AACDBA0A16649D6F094BB472@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [mrZ0IlZqf5ZUTIUpCSPlbp/j5t48tI2H]
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240205102230.89081-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB0886:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3b8db4-b3a2-46ce-e425-08dc26346a3b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i40KwUFOvG6+l10oMzbIO9fuz4fGogXNgxT6g5nF4mT7Xsj4OJVLbtj7bjw2as20KbAQYIcnWoNrg2+z3pTNFqUGBSTvO0muovKkk0chVH3otWDRD0pGZga07KWX7iZQg3uWaeYKDyPUwH+x91wKN3npkYU6tNyoKSvnPa8R3HWp3MjUjaQ2a8hpdB3T2xVgdScOG8I3vNKIGpLkdH+rh1twQvql+N+2DniYTDmaOxiaiHAFXa6/jc1p8/VUkXU5/cr/K+9P8qe0AFasO2823vFSkUElqo+A8U3IkfHnltmZpvYKNsb7Q+gl/iAEIJnXamNvuGbAO2YaswTZ1plMCqNJ1C+u3ptPkJQSZ4EW9DQD2Tewg6RFS3ijONBHT/OmSg8jyKSF8wQMML3LTf+/Ly7AjkOoq7chh6kQ/Biwn5tVu79jsBxRz1ITRpnPfDqNKCCv6CP2ASnxQsCbuX+DCugN4LqFT4uz1ZgoE81amiZsiOml4XRYCVWF018ofu3IrMsQ9QqX0yZ+T9eYQcx8eGYVku87o23kFVkpPViJdNms1posR7LafgOx7ellHE4v
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/zdlWVL6G4WfgHxosvHuhh9CDXCbmXQNfCuHZfNB7+UeIeRswUYj8uQqUML?=
 =?us-ascii?Q?yEKYOHgrjCXCXM+wyb1TDbn5u8xCUReqbhnd+QBg1Has8jTsljHqLUSzRfWd?=
 =?us-ascii?Q?Q12Vvwvlm6DbVLGMjAlPmrN7hRF0uh7hF7hU0Yy3FW7uSj0XFlUnW0jkyuIy?=
 =?us-ascii?Q?Crd7x1PPxibUG294mtFXkBl4NbzQQr1PvALI8v6PNPUob0RgAYwL52ZeYsH6?=
 =?us-ascii?Q?rcg6pz9w5mgoiHkyc2UZqyXu2RJe7iSX9l4R9TbwIdqmJN4p5f2/fTSmKPXy?=
 =?us-ascii?Q?mgF9XNibou6xkTwNAWdyiAlgcJUEQW0gUr8Bi4ZISIetf0rnNEwkxnM3SXkH?=
 =?us-ascii?Q?5GD4vfd2oGlx4Wd+nYEVg+pFTpdEoQvVekprcSjXUJsykweQSVaYJagTH8/J?=
 =?us-ascii?Q?jRH/xVpPc+JjHmZWEb0LsFce9WFnAnz0BG1lvL/7bhN1DIJKY83NmbRBctox?=
 =?us-ascii?Q?D7MrQGFG00c6Xa0oWczdT6aehiaba2bW9/jx2eDUAzODiHhMymVbQVk/s52f?=
 =?us-ascii?Q?0LQJ+amCUQ0ikRor/1j66JaADpULefQmRXKQG5JZZbsu2ONG7tirKtb5ThVb?=
 =?us-ascii?Q?dxhu/c3VOJmZlZe602uah/P+lxU6G+EEK5zHMQFUoKUP38K7QOWYXUNsljTM?=
 =?us-ascii?Q?m36+RVogJJFXN6R2NuOk2PsQy28Ve3agfUuTIQf3lw9ADZBQwLBCt7tIOkT/?=
 =?us-ascii?Q?NohQMZjzLeqB6hsUNxVqfFPGp8NHRr5dSB9B1WCxv/LQLknWISWNCLLoIF06?=
 =?us-ascii?Q?CmvCKaO3agRt5/T01Kjy6MWToIc9iE39FnW0EtWQFh685ci2tnlpP/GTig5J?=
 =?us-ascii?Q?8NpbUlhiA5bwskjnXAjBgWd2JUltE2Bq1zskrovBHzrRlllK7cO+WaxzEGuV?=
 =?us-ascii?Q?YcrJaLAQjyMlvGMatUIkwmKZXTFnana5esqbCtItslf5PaJ2JZ99txWcd9D4?=
 =?us-ascii?Q?+6hb5POXTnmz/ONmwy6+3nOniwEWVu9+eelqAhgfJlIRGfsulAwJ7AWSgzZN?=
 =?us-ascii?Q?Z77YZ7jwsUvv7R6mJ9mXOhtYv/94VPp5yAIy+YM2zNIYJLaOiORuiZ1lZaAS?=
 =?us-ascii?Q?3myiiucRksv2rJiVRcBlsouBLMeGcnf1bNkRsRHWFd3lkqahEsjD+Z7pflwc?=
 =?us-ascii?Q?wQ3EL3v11rlDVIMyQgHtke4w8jTKH0qw2EW08LZqN/P1PwVuZgoXsS/5f61Y?=
 =?us-ascii?Q?s9qOWJ5sR1f0NRqQres4xsCwmdy4p2YtL4XA4LNpZvaSPwRB4FhPqen+wdI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3b8db4-b3a2-46ce-e425-08dc26346a3b
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:22:54.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0886

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for t7xx WWAN device firmware flashing & coredump collection
using fastboot interface.

Using fastboot protocol command through /dev/wwan0fastboot0 WWAN port to
support firmware flashing and coredump collection, userspace get device
mode from /sys/bus/pci/devices/${bdf}/t7xx_mode.

Jinjian Song (4):
  wwan: core: Add WWAN fastboot port type
  net: wwan: t7xx: Add sysfs attribute for device state machine
  net: wwan: t7xx: Infrastructure for early port configuration
  net: wwan: t7xx: Add fastboot WWAN port

 .../networking/device_drivers/wwan/t7xx.rst   |  46 ++++++
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c        |  47 +++++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h        |  18 ++-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  14 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |   1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 103 +++++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              |  14 +-
 drivers/net/wwan/t7xx/t7xx_port.h             |   4 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 108 ++++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  10 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        | 115 +++++++++++----
 drivers/net/wwan/t7xx/t7xx_reg.h              |  24 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    | 132 +++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_state_monitor.h    |   1 +
 drivers/net/wwan/wwan_core.c                  |   4 +
 include/linux/wwan.h                          |   2 +
 16 files changed, 553 insertions(+), 90 deletions(-)

-- 
2.34.1


