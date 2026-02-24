Return-Path: <netdev+bounces-260669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFi0JRMwnmk/UAQAu9opvQ
	(envelope-from <netdev+bounces-260669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:11:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D618E162
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66CD430292FB
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C0344DA5;
	Tue, 24 Feb 2026 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pV+AcE2Q"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023105.outbound.protection.outlook.com [40.107.201.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BBA29A9C9;
	Tue, 24 Feb 2026 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974672; cv=fail; b=j2eWfh9rPliRf2NM+bLmXCetL1cJsNL+r7D2yUHjnhp2XLRlct+G4tOvVbZFg/eXyN9EmPi4+h2ai5E2IWND5zGVowYliH9HXDTqAjBgDFGuMgPy+aBo4izlEZzxVp7LBilDG+nMcAhyYqoAJjg1u4KVIxqaomEzCj9X16ZZq/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974672; c=relaxed/simple;
	bh=XzGtt3I4lrQZsMqUbDAJvDJPYkjpZdftwX+xnbsOjI4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SxT+U+Fgzl9QXy/v6a8PD6+UQP4XoRRPAAehyIVIkQ3p4rlIv45dM16cqSrp+rurU3vYUcwMnNWbyKy9sXYAmcKwwy5Wojb42pi62ONFTRuIi2P0DtIMZAorX/9SCouNYVL2+C/hZvhMhjnGa/2VEs5torYoabIO93QoKtokLzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pV+AcE2Q; arc=fail smtp.client-ip=40.107.201.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zgndt95c30e8PfgsUCM6rf0t8CT5Ex+WbHnaii4qNvvDVs7lt7d5GcjnFMmoFj5s/fLcfL4QK9pFlL1CnsV1ZUxs1HoU0ePAuWdWpoAnzyetHMOXKJpsMR4HELR71PVJzXn4oSvXrmnBGhXZKT+9MmDG0yWDF9PYXebT7zP/Cmz98Z1DGMyoy0qEnZxLx2Ved5TB0A0orEeiyTHnxMcFZAirrfcvWw59aHoXgARwhVPtGbKDw6uvSL36+b+Z2dGxPcnzxd69pV4KeClsVpnZenjhgAv832z30Gqo1bhZbOHiosE1AfX/Pd7LaV0ESd2AqPulzAOYtSs6cbNRCzowhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOskl2iEHXv2/JHJesBWixCf5kZU6HPWvFTkV8bTC5k=;
 b=q0JQp2KYY/zFVDAytw7QJfavLsJ7o3OeQIsY0zBbLJ3P7eZ7mIKEsG/Uc0NOjANQ8BWr8OHGJ0jHCmDPqzpfGH/cb0lnqizZlQr25x8sXXEtrt7JmWK9yKFZk2Kmkn+tgJWEjRZiV0pRlmEfMGQrrdRMsmblmFB4RC17VDId3AXEVgv0und9SMHXT03fLm9FrLJAILZpmB1fYghfC3ktn/MkVhngnAc/gRSOW4z+tPTVzany2EOpvcB9sEKBO3hWz1T2srT4GgvY66359Wd+BfR9xQW8Ru+B6gYTRwdgoj86ERw8JQC+Op9WqLoDgXggj8gzg9oz4DXyFaAcMrOb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOskl2iEHXv2/JHJesBWixCf5kZU6HPWvFTkV8bTC5k=;
 b=pV+AcE2QE2Rr8nXBOQOoWJPqWHBKwvWx2CFq3PoBv5MklVaHqK/hdaEJDeUOX60/pVwxCxgvBIMugq1pociBjgj6LcP0imlPVSOOXPgPhSInUpadeXUg3k386s8bCsoqrBpiIYO8HdGLxazBYavkSMXrdzKWdO8GO5zDckh4yrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CYYPR01MB8567.prod.exchangelabs.com (2603:10b6:930:c2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 23:11:03 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 23:11:03 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [net-next v31 0/2] MCTP Over PCC Transport
Date: Tue, 24 Feb 2026 18:10:50 -0500
Message-ID: <20260224231055.393329-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0082.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::9)
 To BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CYYPR01MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b7d182-9659-4de2-d19e-08de73f9fb09
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|52116014|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n8vMv6MIoie0atuf9U5p0ojFCjK/S2NngCzfDqamfrIl7RZnuHPdANjVv74i?=
 =?us-ascii?Q?fQ3G+61JpuO4b5Imt/K+PSXYGzac97LWIUI0Jevi3hBZnZlMGJ54/IqnIUNH?=
 =?us-ascii?Q?o3iMoscsFk2ZaKrEDjdx5Dtddqkf+xoDH9C+64+kynZiZvYISGx71j7w+slQ?=
 =?us-ascii?Q?wlO/AzBPQv1L8aLkFz8B9itmrqfepNCCOXskGc1+PzJFpbAClB5vyOrKq1rC?=
 =?us-ascii?Q?o9QRGGtphr+9n+N2BPxRTflwx2vark95dx/cMw+K0XhuFJAoh8ay3e0jQkre?=
 =?us-ascii?Q?4Z5+poWy7Go+dHES4yhRVzfqlaoglahsDzfVgFXuF2fkCQ/OIQZnLz6rYv4m?=
 =?us-ascii?Q?vu+fs3zmYP+zCzcGmQBYp7GM3+g2nGCXsujSS05t+Ch7UY4q1vcw9weHmfbI?=
 =?us-ascii?Q?AQIsXsQJLpU5dm7iuHNjPH1fwLvsAl+mg5fay0B5ZdqdDWGa4ksTPNWKwioM?=
 =?us-ascii?Q?eMbx8yPpdZk4/GfQVnvz0OZWxBLjx8WpMBcQQoKFHyZ0vywsOhkTTzZcRh52?=
 =?us-ascii?Q?JRuChcJQGQhDi4HbIVZP6uoz3+Gjw+OrMA19P9ORpVfRqSdzjWWWMl9Zd6Rs?=
 =?us-ascii?Q?xn16A/hmw5SMF2ib5POO96rJL6l+pHRWG6dAmDJGxLfkJpVlfJ2fNNaTbuZw?=
 =?us-ascii?Q?pb7pWcTZPDCCNqArHkQpKop3+ysEtuxY5lxjrxaqzTDb5drj71wj2eXnfjd2?=
 =?us-ascii?Q?spMVfF7MDV8LoJerDGnA2HTGOHDIy5UWbod61Y2CabYG+6ZtPMlPreuzlJ7m?=
 =?us-ascii?Q?4kwZ+ZKjGZpPDT2Z1Y/ACJZK3LnoGKtOxn7bucDDW0kpx9cMdUBP1FMdaBZM?=
 =?us-ascii?Q?TUYaREFjE/9cZ/xzPn1JewnwwUbMs2Bkzf3le/igc+CFxEvC4p7HmZ6CfAUd?=
 =?us-ascii?Q?F7pjGH/uGcYBi4tI02lqO/qDsdYA2/3JOFLHHTH8M3elEQSteYfYjd7kUitD?=
 =?us-ascii?Q?Iae0ZJLCj1eSrm8kWLVelSQI4HPiFWUwSNE07jj93IouvwPODAvj5uFb6slX?=
 =?us-ascii?Q?/lTrWAa4wMJhyCZ1GL7Hq79oeV/aelSTO/0hzHRhzdoSl548dluTlszAixS4?=
 =?us-ascii?Q?oPoCWGyZ1KEr2+k5tCI/4Jpw4hBnWkRY70zp9ArjBxrMJe56jSULTm1EPNlT?=
 =?us-ascii?Q?UocIZu697b1XPJH5WPDItFuL+SCdvD45IsJfwN89p0X5P8DQ/pu5CsRjII2K?=
 =?us-ascii?Q?IFNFq4UEN6rfpCBi7a79UFqinoX1eHsQoBGZwUdpsmKIATqjFdY3TZg3Q3ZU?=
 =?us-ascii?Q?0WZvB8egH1ovxXbsocGvzQBiDRC0N4eiedYHHVoYBWEq+K5+2LX4MBfBec8X?=
 =?us-ascii?Q?GIRcsbeFgg2TwszRhzVnHmZRdwyhX5roHbnlsMOWrtDjD0px/OKLyXAC3Xp+?=
 =?us-ascii?Q?bgFcSSwQD58Adb0LU+IhzsXIU8XyvTxST2J6HRioNPL0Qp8ivjO6V1ohUVTp?=
 =?us-ascii?Q?yzG+qM9WtdU3kFXOV2IGjUnObbwfnwJ8x2Ldj6zx/xsy6hqjE6mOcy1l/hLs?=
 =?us-ascii?Q?zsBbncGE0b5ogzF8FaWxPBUvdAKZbEROiYhMx6bE+IIxueSLx1/tH7jc/fHv?=
 =?us-ascii?Q?+/kxBo2oUsZZzznPjRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(52116014)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zbeOATAXhX6++jP8Bvjr1F6XokWMmMA8nJmofTwWcGwKrtjE1GnguQJiLmbY?=
 =?us-ascii?Q?bFp8kxQqj/+tz2PB97md+OdhaB1tcgAvc3zVRooQn01+tP83C+ERFgVqQrqC?=
 =?us-ascii?Q?JV3CGcz/CF06VCewQeOaum5qIO3UPoqssruMJCPVUdV2Aq/Epgy9azcGt/LK?=
 =?us-ascii?Q?6KIx8zpEvy25tg/moaMLxyw6wCEX88+YwUOdYOq6m2VMBlKp8XdKUSVNR3Yv?=
 =?us-ascii?Q?INibLKKjcCHF69RvpBc4It+s7PR1BHv0PRny/PdOP5gLI5kI9MV20TbMlVg9?=
 =?us-ascii?Q?rBczMeszXK559abSbc9zbN/KP/KKexHhhqENBccLkadZa0o3UaDYl+ygKX2T?=
 =?us-ascii?Q?4Caz17wEQJsDxSPW0GiB5B2Jjnt5kNsE2WxHiS/s7mynl7pRuBClNrweeGSK?=
 =?us-ascii?Q?1UYysi+rc1BBB4S6NG/pRg6Wk9jY4uhCHSkRxFxZVm6El1v890Mt5RtGCHsh?=
 =?us-ascii?Q?Yuq8lP6HJVbICJTK28MQjFWzLJKmXtRY81SSTks7WgcNFUKXA7ACLA/EieJz?=
 =?us-ascii?Q?X42XhpT9PYhLe786OTM77NJECZQtZRRpFSGhVDnlVnJZSwN0ClF0w3NUMN3o?=
 =?us-ascii?Q?vJ/Z7roTSFH6+ny7IxxnSJnqPdwcqd7XI4XlBvT8+6tpnth4V2wnOQp3JuYm?=
 =?us-ascii?Q?0Z0pwALH6gRteAUSC1t34DvCrxHelMfeAJP/FMMN/1O6zAiyntahGZ0TyG+9?=
 =?us-ascii?Q?m4E8L8g/3gXqpKTbDQXAH9wx3O9IlsXCu6dDCQGL1l3cIrXzOOjRjFtyfTw3?=
 =?us-ascii?Q?3qNBM/HRO4SNSSEgMoA4cu7w0k5JpKOqJ0Qod2QfIXA5JFxV1YdKhXawOkqV?=
 =?us-ascii?Q?/mAZTutqBOC/dCbAJjhN6BGE5QQcPwSOn1QgewRNTuigSSwnJ95x06nKOyDs?=
 =?us-ascii?Q?O0dz2U+nSGb/Vk1OgLTdbyHEbiCK9KgvnjBA5ejanTt7jS52fqBLQPNvqIgi?=
 =?us-ascii?Q?GJ/gr4gNnf/jFj/TwLY4FuxAba1j7QfR5QMZRxfDkBVBE1kzQqKdrxektFVk?=
 =?us-ascii?Q?11ydOQ2o1VJVAvOD1fSkv+4GzktIbG8/h6RCAmCELO6N6Tw4hh9A9OJ9Xcxq?=
 =?us-ascii?Q?BcgwWqaC6GzK6wYQqU7frqagyeS8sbNuIeOi5K1FJBs3qSXPyJaPyQ9gB1QH?=
 =?us-ascii?Q?PL5HbaARH/H4L8CfcUWbtKL7IgDvBQ2DOCcDRcBR386G7j7Xm71f2+y3ifLL?=
 =?us-ascii?Q?Iz1rQdMr2/12RdFgmtxZ/pUTkD7zyvFzhgUpI7IEGMkgS7ydphgrwuVaPFN4?=
 =?us-ascii?Q?JX5p7VSGkj1SJK3x5SviIF5oHNbHHiZfL2d4VNCEKWks1y+YAE5/r36nT/XL?=
 =?us-ascii?Q?ETv+tT90PIGHcVl8GXTqY26fgi3WA/kKwEPzYShjjU7/4w+jLlg3PoY/2/od?=
 =?us-ascii?Q?VoRPEnZa6cqxDmY+2EwzHgKycMh9q+pn5wosED//x4LfDLS+RwnWjAI8OcXc?=
 =?us-ascii?Q?+bM3Ild9YL8ZknnBEP2brtkqPxOsh2idDlrsLWDQ6tmcbwJY4HUe5k7Bm8eg?=
 =?us-ascii?Q?jUTo3ssU3YkGvV/T+IneuLlCmjAmVJPOuzud4g5pQokuaopcg5K4A/PtFmp+?=
 =?us-ascii?Q?Wk1Re4PvvoxwdM/hJmldQYtMNixcJKIvi0C6VhxUw0kZqoP3Ym/kZRHRgHQr?=
 =?us-ascii?Q?/CcJckWXGQD09A0mxJbgmpNoAsfPzjPKjU0iA0D63KsAIhZAsKC9gpmsVNy2?=
 =?us-ascii?Q?216TRgt8aNULmgsfBeCcr9zA7qDb40l+QZbnz8R71m3FfJ6GEkd5oCH5eooK?=
 =?us-ascii?Q?Ba8eN9vD4yRYGB++V/d+a6521rSTEegk9h2LtnYiMvwuMnS3k41GYKj5j6kQ?=
X-MS-Exchange-AntiSpam-MessageData-1:
	j2BqGpjsDFkzgyPHkAABo6EGgBktu/tBqlmUkvov6eic7TnQhgsAbkVd
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b7d182-9659-4de2-d19e-08de73f9fb09
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 23:11:03.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lbRB6+WPFGlpmsNPYD9RDp7LbZKj/iDNJbBd8oikbf7BKp6gpAzamV8ayuAvqxcalXMQansJGhC8g4sP0zQ0/Gj0r6WuO+Vp84c7uS2/8jfQYjeQaz28f4gfz6IjmK5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8567
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260669-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uefi.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C1D618E162
X-Rspamd-Action: no action

This series adds support for the
Management Component Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP defines a communication model intended to facilitate communication
between Management controllers and other management controllers, and
between Management controllers and management devices.

PCC is a mechanism for communication between components within the
Platform. It is a composed of shared memory regions, interrupt registers,
and status registers.

The MCTP over PCC driver makes use of two PCC channels. For sending
messages, it uses a Type 3 channel, and for receiving messages it uses
the paired Type 4 channel.  The device and corresponding channels are
specified via ACPI.

MCTP is a general purpose  protocol so it would  be impossible to
enumerate all the use cases, but some of the ones that are most topical
are attestation and RAS support.  There are a handful of protocols built
on top of MCTP, to include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, device
authentication, measurement collection, and device secure session
establishment.

PLDM is more likely to be used for hardware support: temperature, voltage,
or fan sensor control.

At least two companies have devices that can make use of the mechanism.
One is Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part of
the ACPI spec:
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has the
ability to ignore an MCTP link that they do not want to enable. This link
would be visible to the end user, but would not be usable.

If MCTP support is disabled in the Kernel, this driver would also be disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. Thus, if the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hard that does support
PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would thus also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

A Previous version of this patch series had a pre-requisite patch that
allows the PCC Mailbox to managed the PCC shared buffer.  That patch has
been reverted. Instead, the functionality was moved to helper functions
which are explicitly called by the MCTP driver.

Testing of the patch without hardware support can be done using a patched Qemu
and helper program.  The Qemu code can be pulled from
https://github.com/AmpereComputing/qemu-ampere-staging/tree/pcc
And the support code from
https://github.com/AmpereComputing/pccd

A running virtual machine with a Kernel with the applied patch can then be tested
using the mctp-client command line utility found here:
https://github.com/CodeConstruct/mctp/blob/main/src/mctp-client.c

To test run the following script:

EID=50
LINKID=2

modprobe -q mctp-pcc

PREFIX=mctppcc

LINK_STATUS=`mctp link | awk '/mctppcc/ {print $11}'`

if [ $LINK_STATUS = "down" ]
then
        mctp route add 50 via $PREFIX$LINKID
        mctp address add 15 dev $PREFIX$LINKID
        mctp link set $PREFIX$LINKID up
fi

test_mctp(){
	REQ_TYPE=$2
	REQ_DATA=$3
	TEST_NAME=$1
	EXPECTED_RESPONSE=$4

        # unccoment to debug
	echo mctp-client eid $EID type spdm data $REQ_DATA
	RESPONSE=$( mctp-client eid $EID type spdm data $REQ_DATA | tail -1 )

	if [ "$RESPONSE" = "$EXPECTED_RESPONSE" ]
	then
		echo -n ok
	else
		echo not ok
		echo EXPECT=:$EXPECTED_RESPONSE:
		echo ACTUAL=:$RESPONSE:
	fi
	echo  " - " $TEST_NAME
}

test_mctp "SPDM GET Version" "05" "0x10 0x84 0x00 0x00" "10 04 00 00 00 01 00 12"
test_mctp "SPDM GET CAPABILITES" "05" "0x12 0xe1 0x00 0x00 0x00 0x00 0x00 0x00 0xc6 0xf7 0x02 0x08 0x00 0x12 0x00 0x00 0x00 0x12 0x00 0x00"  "12 61 00 00 00 16 00 00 16 00 0E 00 C8 00 00 00 00 12 00 00"

Previous Version:
https://lore.kernel.org/lkml/20251016210225.612639-1-admiyo@os.amperecomputing.com/

Changed in V31:
- Use predefined Header structure for pcc Extended buffers
- Rebased on top of changes for PCC to handle ACK interrupt and tx_complete
- Fixed formatting in mctp_pcc
- use netdev specific log function
- removed condition around dev_consume_skb_any(skb);
- initialized ndev->hard_header_len with sizeof PCC header
- removed spurious mctp_pcc_ndev = netdev_priv(ndev);
- Rebased on 6.19

Changed in V30:
- rebased on revert of mailbox/pcc.c code
- Explicit patch for dealing with PCC Type 3 ACK Interrupts
- PCC buffer management moved to helper functions
- PCC helper functions are explicitly called from Network Driver
- Removal of sk_buff queues
-

Changed in V29:
- Added a callback function for the mailbox API to allocate the rx_buffer
- The PCC mailbox to uses the Mailbox API callback instead of the PCC specific one
- The MCTP-PCC driver uses the Mailbox API callback instead of the PCC specific one
- Code review fixes for language in comments
- Removed PCC specific callback

Changes in V28:
- ndo open and ndo start create and free channels
- Max MTU is set in create
- Reverse XMass tree rules complied with
- Driver no longer has any auto-cleanup on registration functions
- Tested with KASAN

Changes in V27:
- Stop and restart packet Queues to deal with a full ring buffer
- drop the 'i' from the middle of the link name
- restore the allocation and freeing of the channel to the driver add/remove functions
  leaving only the queue draining in the ndo stop function

Changes in V26:
-  Remove the addition net-device spinlock and use the spinlock already present in skb lists
-  Use temporary variables to check for success finding the skb in the lists
-  Remove comment that is no longer relevant

Changes in V25:
- Use spin lock to control access to queues of sk_buffs
- removed unused constants
- added ndo_open and ndo_stop functions.  These two functions do
  channel creation and cleanup, to remove packets from the mailbox.
  They do queue cleanup as well.
- No longer cleans up the channel from the device.

Changes in V24:
- Removed endianess for PCC header values
- Kept Column width to under 80 chars
- Typo in commit message
- Prereqisite patch for PCC buffer management was merged late in 6.17.
  See "mailbox/pcc: support mailbox management of the shared buffer"

Changes in V23:
- Trigger for direct management of shared buffer based on flag in pcc channel
- Only initialize rx_alloc for inbox, not outbox.
- Read value for requested IRQ flag out of channel's current_req
- unqueue an sk_buff that failed to send
- Move error handling for skb resize error inline instead of goto

Changes in V22:
- Direct management of the shared buffer in the mailbox layer.
- Proper checking of command complete flag prior to writing to the buffer.

Changes in V21:
- Use existing constants PCC_SIGNATURE and PCC_CMD_COMPLETION_NOTIFY
- Check return code on call to send_data and drop packet if failed
- use sizeof(*mctp_pcc_header) etc,  instead of structs for resizing buffers
- simplify check for ares->type != PCC_DWORD_TYPE
- simply return result devm_add_action_or_reset
- reduce initializer for  mctp_pcc_lookup_context context = {};
- move initialization of mbox dev into mctp_pcc_initialize_mailbox
- minor spacing changes

Changes in V20:
- corrected typo in RFC version
- removed spurious space
- tx spin lock only controls access to shared memory buffer
- tx spin lock not eheld on error condition
- tx returns OK if skb can't be expanded

Changes in V19:
- Rebased on changes to PCC mailbox handling
- checks for cloned SKB prior to transmission
- converted doulbe slash comments to C comments

Changes in V18:
- Added Acked-By
- Fix minor spacing issue

Changes in V17:
- No new changes. Rebased on net-next post 6.13 release.

Changes in V16:
- do not duplicate cleanup after devm_add_action_or_reset calls

Changes in V15:
- corrected indentation formatting error
- Corrected TABS issue in MAINTAINER entry

Changes in V14:
- Do not attempt to unregister a netdev that is never registered
- Added MAINTAINER entry

Changes in V13:
- Explicitly Convert PCC header from little endian to machine native

Changes in V12:
- Explicitly use little endian conversion for PCC header signature
- Builds clean with make C=1

Changes in V11:
- Explicitly use little endian types for PCC header

Changes in V11:
- Switch Big Endian data types to machine local for PCC header
- use mctp specific function for registering netdev

Changes in V10:
- sync with net-next branch
- use dstats helper functions
- remove duplicate drop stat
- remove more double spaces

Changes in V9:
- Prerequisite patch for PCC mailbox has been merged
- Stats collection now use helper functions
- many double spaces reduced to single

Changes in V8:
- change 0 to NULL for pointer check of shmem
- add semi for static version of pcc_mbox_ioremap
- convert pcc_mbox_ioremap function to static inline when client code is not being built
- remove shmem comment from struct pcc_chan_info descriptor
- copy rx_dropped in mctp_pcc_net_stats
- removed trailing newline on error message
- removed double space in dev_dbg string
- use big endian for header members
- Fix use full spec ID in description
- Fix typo in file description
- Form the complete outbound message in the sk_buff

Changes in V7:
- Removed the Hardware address as specification is not published.
- Map the shared buffer in the mailbox and share the mapped region with the driver
- Use the sk_buff memory to prepare the message before copying to shared region

Changes in V6:
- Removed patch for ACPICA code that has merged
- Includes the hardware address in the network device
- Converted all device resources to devm resources
- Removed mctp_pcc_driver_remove function
- uses acpi_driver_module for initialization
- created helper structure for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unnecessary null initialization from acpi_device_id

Changes in V5
- Removed Owner field from ACPI module declaration
- removed unused next field from struct mctp_pcc_ndev
- Corrected logic reading  RX ACK flag.
- Added comment for struct pcc_chan_info field shmem_base_addr
- check against current mtu instead of max mtu for packet length\
- removed unnecessary lookups of pnd->mdev.dev

Changes in V4
- Read flags out of shared buffer to trigger ACK for Type 4 RX
- Remove list of netdevs and cleanup from devices only
- tag PCCT protocol headers as little endian
- Remove unused constants

Changes in V3
- removed unused header
- removed spurious space
- removed spurious semis after functiomns
- removed null assignment for init
- remove redundant set of device on skb
- tabify constant declarations
- added  rtnl_link_stats64 function
- set MTU to minimum to start
- clean up logic on driver removal
- remove cast on void * assignment
- call cleanup function directly
- check received length before allocating skb
- introduce symbolic constatn for ACK FLAG MASK
- symbolic constant for PCC header flag.
- Add namespace ID to PCC magic
- replaced readls with copy from io of PCC header
- replaced custom modules init and cleanup with ACPI version

Changes in V2

- All Variable Declarations are in reverse Xmass Tree Format
- All Checkpatch Warnings Are Fixed
- Removed Dead code
- Added packet tx/rx stats
- Removed network physical address.  This is still in
  disucssion in the spec, and will be added once there
  is consensus. The protocol can be used with out it.
  This also lead to the removal of the Big Endian
  conversions.
- Avoided using non volatile pointers in copy to and from io space
- Reorderd the patches to put the ACK check for the PCC Mailbox
  as a pre-requisite.  The corresponding change for the MCTP
  driver has been inlined in the main patch.
- Replaced magic numbers with constants, fixed typos, and other
  minor changes from code review.

Adam Young (2):
  mailbox: pcc: functions for reading and writing PCC extended data
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                 |   5 +
 drivers/mailbox/pcc.c       |  86 ++++++++++
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 323 ++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h          |  22 +++
 6 files changed, 450 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


