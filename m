Return-Path: <netdev+bounces-68270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910F88465B3
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8061DB233FD
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEAF8824;
	Fri,  2 Feb 2024 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gOEaFXRj"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2176.outbound.protection.outlook.com [40.92.63.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9F6AA6
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840210; cv=fail; b=OANImORrF+kq9CssYuk4B0iUf7DqxlC780s9lXiwgiU+6V0pmtaae5U1FOeXRUWvrPci5oR52imy5Y4CAbc1vVuqlBLZyH+d+5GXG+u8yC7z6ESFZwuiT0XlJDP6AmKO1JzG7bsOxAq/pohn1CIcaSc1JEeIfErv6sZnlSpMiqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840210; c=relaxed/simple;
	bh=noh7N2NBe2FzMz+1eZFTWUGRDl9KogHafuKqcCaEWmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Disposition:MIME-Version; b=XChTM0MJ+r3rBkibeQfuaLN4q8HRRizZ/EZvksqyr1eqBccbxUqzpPeY+V8/j2Z2Ldi3xtXRbXUSv/SC9BhTt886pPxKiBWxI8ZhgDRDXkC1LEg7YihGPamgwJ+M70rikxlaLh4SIEuO7Io71cCRItHzNHtnIhCIicM20aYB8To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gOEaFXRj; arc=fail smtp.client-ip=40.92.63.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpIQub0ZHY+1ZOOhE2YtVPbjTaH2V9plb/LroxC7GaPNzQ5Y90YJOO71Re2jp5tL9/oOx5r2ik7nmOiIbF5W7W63/M73WG4Seu/ViFzdigtZMIMEuUwABqtlyPx0DgmVBYyDH1dyUAiViKK3Ts8Bm3DLrr4BawqQb/JJVYWkT+MZGrNwjZG4zINk4IqoyZQTqM3DVN3RcQRQ1EEd71jMTZvOJsfuplnWx/ml1UuMgqm2LHw8ZHvSQivhLMgqE3Q2wrqMQlFYNwA6Icfgb4F5cz27P3qn9gD20hxJmCo3lqkpEF2YhCIWXlGo8KbLrAUHMFxNzcvp+r3pleC7iW7Ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdKdixHzb95KAKo9aebqCiEhDd9INywtU9WXWs6jk7o=;
 b=iu9nBPmtfZctZa+x0kiDXOv6j5JC5BLBcp4/j7JOiiDpe4BjDPedXX0T0Yq81N5/CIRGYpMbFpFnjGYLHPhHJLQKQI43olX7sE0dpGwEQ4O94HriW7IM8K4SP/daOZe1hDDeYIu2Q0eS+Qogz13dbBPNWavmow/XWesRPk0UTha1vtZZwqnfZh0h45NPW5tA5Dm3N31GYnzk/tXmzP25E97lnwTOfU1/DvqiwNCnzrAwt/WBoXlL8MKSSQd0x9G5HNIeOF+JKzhyV8ZJAVYUc/fWFF33U99N/Fv41B/yiGOMme9Pskl1jhb9rocuNoSwDjmv55dCpaXdCmDxT2I1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdKdixHzb95KAKo9aebqCiEhDd9INywtU9WXWs6jk7o=;
 b=gOEaFXRjIkUv3h7TuEXSM9FXWv1tYqigNPq7typvB5QUPB45q74NLqEpYL7L22PP14R4y80KoztWgGT5Lg9F6WvoZwE250cyRpgujzHpJAr9wBkkZHHZs7DM9DOW/9BJHTgWcp2X3pgye2lIgGRsAcUFThSZP7y/3iX8c9Hnasc0o9mG3k65KhV0HrD1yHsyho+TwmUHj5GOgCst+OLLr8H1cNIyiO+8v9oO3Rk5SsdsxCPl9gtmx6z5ZAuDd46teYDeaR56MmbVgX49U0Nfcxbp6ZtY08a2CR86F5Vd+lVh3vodt2HQo0Pk1v6AU0Un8xb2iIARokgayeHt5we1zA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB1681.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 02:16:40 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 02:16:40 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: jiri@resnulli.us
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
	netdev@vger.kernel.org,
	nmarupaka@google.com,
	pabeni@redhat.com,
	pin-hao.huang@hp.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com,
	vsankar@lenovo.com,
	zhangrc@fibocom.com
Subject: Re: [net-next v7 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Fri,  2 Feb 2024 10:16:12 +0800
Message-ID:
 <MEYP282MB2697CBD4E366DBE80DA59216BB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB26974374FE2D87ED62E14549BB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20240201151340.4963-1-songjinjian@hotmail.com> <MEYP282MB26974374FE2D87ED62E14549BB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TMN: [Wza2VLEMtO/8BkrRUbcqF8tmfAF189ep]
X-ClientProxiedBy: TYAPR01CA0217.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::13) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <ZbvCorTYXK1o_sdV@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB1681:EE_
X-MS-Office365-Filtering-Correlation-Id: 9207b302-b714-4ab4-d357-08dc2394fcf9
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6freGFPHZ3GjNuqOE2HYSoa8HqAct7ghuk8yB1ZRVlCHoumYPS9E3xwFZayx30ZDeXt/g9iGwNb6/0+lwyELBoO4cc1ArifTwjh1bTkitIzVfOtovOOrbIi2QaQYHOUUIKcGXM0Nq1Nr+Ya3hpSpw+nuQUMA5SJEiCzV3nOlEN6x2C6EPuq8IcrrY8ZyXLAaqlzbrTSDBUTIPCYFDrS9xhLD/D/sQ6SxB2vzrdXquM9is9QWKulwWqWMNNJXC7BbrLbeZMFyDIaVx65F8s+1Owso7E1EocO1jCoh8Dgm/hDADnCWZW8YmiexWfcRhTByNxpHACXnxmeOgUaQ7Z4rRFVphYOBeMOP+PDLQ/0hppYdjhrgpqlpOFjC5+2GI82jxVBwHkI/OhQNMwVcw6R+7BzTDGSHi5X6C82cd1WwuOSDrPAo/v5vP2DUTEsXDipTi56d2P/I4hIV894HZvwvatsjvsPz0EaF9iCvRBo+e2deH/UakQgzEn3TnQNUq8sGZv2PJzebaqSGcpL774XABuY7iyAvkLd+22cmzYYzr3/M37xDgqCyy2MJ7U3F2EZbaMcNnNGCNHXr1TlQ612mR25+OgCztn/MOUjAhRlac4My8rQcSj0b0sKMo5Lb5I8Fg2WLjzXWNZlHGi0SjM21Zp0m2WS4/4IKjZKoP9euXyBUq1RbwrCyPP3L36WL5lDQZIo4oDoVI7gmTfRCYoZOfiS7kCIGWCagnwRGP3C9kw8adFhek/Ds0iPvqeHhmEQrQc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QiwLIMa69BnRZvFhPp5EU5CHEdPXSXCnxG1Qb8l6hrQgREDh/3PYLus6BcsUZgDgjzji/4DT2po5DjJuw2ekjgtW9NT9LEKq9rHjb4HYaJbfnoBM9FWRcb64o2u+P6D0JS93aVeu62NrSvRi81mQHChPgVG7wCm3Bvaa8iD5+pG56J+uNswNL9cATXizYBV8o1+qqupEPk4lRT6vBQcYYCsTpH0kvDUsSIFA0o6xWrW5urAR5EIplqGyw+pOlFYTOOZTa2uZcG5NHSiqdBTtsgEFtVoA+KVPvE7FGKmLV+w+wSvW/y/b3mz96FsKfpc49iIK7JS2pDrpl5E6avveLZkhlChjImydxu5lfDV9zlu1jfRZeKUTxMkbmK77LoOSKpdE0RvE0Q0OG9nqaq5l1hh1xWy7/3jBnAQq2moPXVwJ5TEYGii7bEzpSEbCMQW3rtQYzcJsrU6JCjiyqDJkSja72FNRhyTdefK2PLNKGe1l8GodQF1MpzMkVsefKPTzXZ9DQ2HuzMMobL6dpwSXB28IOr15VeWBoUk9FcHbUOTBjRPZbW1z5uKJ/PrkYSIca/Z1m8XfCtLdLePw52v3qa3uR46o+2fyM0XLOxl9rCagSdVldPx6DDBQuBpzAUXe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ChCeQYJs9Jz/vyAN7wUaMzYqiSypGBRiCP1OPBtYdT0nttHdpvgNgCMtXBCm?=
 =?us-ascii?Q?bHdQnreQyn2iDqSG5BkvXR/f8lNGv28mEkf1muTHvnufXUaMcQGmgSdu8zGt?=
 =?us-ascii?Q?GjwOyq+9s/v8PTlWGzO50SVNv48KCFybe9WZaEvVvZcLtAHhYnLXcQmjFBvu?=
 =?us-ascii?Q?JmEg7UsvWT/gXOZKUOV4uSIJ6bPnh654J3nGkbm1zXTNlGL7jSg/zucWQPii?=
 =?us-ascii?Q?XWxn6qTSS5qf4sKDgW7Rzq3+Vq3BHTAjEDyt62fK2+aw9u+AJAaselbbuB6s?=
 =?us-ascii?Q?Tm4sG6Gg40O0pM5iA1QFTk4WRAx4wWQnqqNJ1fAEsyM5I/8R++iHAujR1bmT?=
 =?us-ascii?Q?+/B+oDKWvCmTmJaAcdXrWoz2njndG5mWYdftsDsAnOip5CG9JMnnRLSZPbxl?=
 =?us-ascii?Q?VJU+LvU7cJvsoZKFA9ynONd8Tg6G+hvHy4lMaKhjmx+i/LMtiEBBwanKLUo2?=
 =?us-ascii?Q?49nX49teCJlahQq3s8NPFpWKwPw9vRAojg6BhEGv5WE2NRWtpAdnNdP0W9XN?=
 =?us-ascii?Q?tmlgFeu8x0vYdTAGXwegJo8tO/C+k0PU3ht66Cru7OfYBBiqnMjYQRHTCVM5?=
 =?us-ascii?Q?7aLq1H/KgZpVgO5e3WTLiBmsjbeEDPa6+748FftmG8gKhN4Vj/zGCQ8S+yEw?=
 =?us-ascii?Q?z/2F+dhy0/GwqQUXK7ZybU1Nf+t584LrxuDoUwPXx3Iy1MY2SfvDdkXk8+lE?=
 =?us-ascii?Q?58TC5ACyBtD1dpZkxaddW06F8iLar8hak5bTuXQaAmyFv8PHK7ZMbggH8Hna?=
 =?us-ascii?Q?TPN3Ho0gT8EnVm8U1p6cf1Ue6PeE8ipagWW5Q5Izd1JhsA4Os/kTUijhVVda?=
 =?us-ascii?Q?66J8IL+fUCAXVlmvwDEhzLQVOWvugT2HIo8e0qknTzhJSnZwiLYUnhm6NaYB?=
 =?us-ascii?Q?XZgzqYU+2LJ2bwK9JoowOoGD4pnbwFoKq0MKeJqZn9Sb8GI2By2TnDKuICXj?=
 =?us-ascii?Q?vg41undYRG7AI5Br8lHYQJloo8YnFipcICMj/iMIwDfTraHSz+Zdb0bLZchQ?=
 =?us-ascii?Q?Xfx+okS7NqBjE9Iibulnc1dn6j6l3518fU3Yq+A140sPN30UMq7jMJv9bPbu?=
 =?us-ascii?Q?YO3+MDl1gri9eETfenhMaW8ufq2AY8S47ZFV+AqjIJc2HjCF8eH/Tl1m0h2H?=
 =?us-ascii?Q?BTWeuTmTaeU3yqHk0sfSkBQBWemip5axp3GGEUuPILaakcwNJyceoMEh6CfJ?=
 =?us-ascii?Q?R3QcUbmiMYB4P/O+mPrHuqDuGynlaJR7BSwRZ9hiiGhNMAFWvsu+RrDQyTw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9207b302-b714-4ab4-d357-08dc2394fcf9
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 02:16:39.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1681

>Thu, Feb 01, 2024 at 04:13:38PM CET, songjinjian@hotmail.com wrote:
>>From: Jinjian Song <jinjian.song@fibocom.com>
>>
>>Add support for userspace to get/set the device mode, device's state machine
>>changes between (UNKNOWN/READY/RESET/FASTBOOT_DL_MODE/FASTBOOT_DUMP_MODE).
>>
>>diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
>>index dd5b731957ca..d13624a52d8b 100644
>>--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
>>+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
>>@@ -39,6 +39,34 @@ command and receive response:
>> 
>>+supports read and write operations.
>>+
>>+Device mode:
>>+
>>+- ``UNKNOW`` represents that device in unknown status
>
>should be "unknown", missing "n".
>
>Btw, why are you using capitals for the mode names?

Thanks, let me change it to lowercase and modify the word. 
Previously considering it represents a state machine and with udev to report the state.

>>+- ``READY`` represents that device in ready status
>>+- ``RESET`` represents that device in reset status
>>+- ``FASTBOOT_DL_SWITCHING`` represents that device in fastboot switching status
>>+- ``FASTBOOT_DL_MODE`` represents that device in fastboot download status
>>+- ``FASTBOOT_DL_DUMP_MODE`` represents that device in fastboot dump status
>>+
>>+Read from userspace to get the current device mode.
>>+
>>+::
>>+  $ cat /sys/bus/pci/devices/${bdf}/t7xx_mode
>>+
>>+Write from userspace to set the device mode.
>>+
>>+::
>>+  $ echo FASTBOOT_DL_SWITCHING > /sys/bus/pci/devices/${bdf}/t7xx_mode
>>+
>>+static const char * const mode_names[] = {
>
>t7xx_mode_names

Let me rename it.

Best Regards,
Jinjian

