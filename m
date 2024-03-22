Return-Path: <netdev+bounces-81264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F946886C41
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C439DB249CD
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F8A40BE5;
	Fri, 22 Mar 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qirMS+gC"
X-Original-To: netdev@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2064.outbound.protection.outlook.com [40.92.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42AA947A
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111184; cv=fail; b=oy3jEC3UcR4IrJibagDO7Pc5OJ/KZFDSCc9SsZa1uBbmqyvDKhcNZZm5ZMWgGua051MhyrAT484bvyrEcwoU9W1fOOZwHlDeaqa3VHjK8lcsLwtwCkRslgnWYe2OzJinLw3069OdoR/B7vrylEuP5WAZgyXGUtDi2W00f+pwZp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111184; c=relaxed/simple;
	bh=jkMUh1Dy0/1NjRLgFK9JCIIunm52wrC3UzQlVAEOn/o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A3LzSMfuT810SPQw/+iQtgOW8YFguMTBH1mtJFPpVCn0BjJrV+PGXiSFIoyBBfb8PHN0Hw5/aF1JIsbft9fyZmqJmKkax9QUgY1C9RVwqqQyOPZAjvLCASEFQ0tYGMm3OXajHVsFmYHIhh/ZcjbOwDstJChir+Dzor0IZ0Cjv+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=qirMS+gC; arc=fail smtp.client-ip=40.92.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CahnuP4g+x/IsXam9pENmuvID90w6cePncv7tDZ8xA8ZM9wW4GFo/K8RN3RT3UOUSf7bUDoAByCZ702uhdkUKCHzA6KvuIH49i1qutGMfKDc47x/ilUtLxIiFZZyj2Yl5EvNEMph+mTSL+H/TxHIEYgrBin7pXa/e9nvtyiNQhRHNxfh8ckXzjTF98SlKr75lADH+95b1LkL+fO0cqB1I1fd/GIrfoEMee8QMVGxc/fvz3MdTIAvWEVJ0bNzaE+VcJGaHPK6Nr0DKED528iFfv2TtXxk8cDq1bs1pLnk/5BSVhq+DSwT9OjWRipHXMQENhz6gf2gz3L+4VHrcl6Hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/BAVpoSMpLahnHe00wgn/223rFc80cZlzj7nukVKI0=;
 b=Yrcj87tZD9qzUwXn+PuDHPsFtdOFsfYTpg2aQdlLL6+cObTr30oa1YPXqkNNroiTwqXDFB/5iP56YZdJ60Y9I9pjGu02zfG9gltUNwVRyg6PR21z4aCQ/0b7QmBOWEvvkg3jZEzK2PiZ5T6Sx9toy4ifitlQjioI1srIag9j4VyvWIBkmBxU53yDnGMjs3jjLl3m+7ll1EjLARvTFcf0JxF/CtHfDcSG4buttnYtKFdvkFYM672I9xbrbykolT509jClu+r0Xh3d4N8cuR0ThWuzuZsB/fplYObbfsNBXFUdZ9MG2JSHMqA2mZoNeRZtPe4AwMi/3Tb9gYXPnzyLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/BAVpoSMpLahnHe00wgn/223rFc80cZlzj7nukVKI0=;
 b=qirMS+gChpsJWlIn1Bf4FRhxVttzGZUBAe0P6EQ6e+9fhNuqFO+w0zc0xjiIRN1zl1S8iMmlPVdSgmCzO87vQJzLlEi/Bb23E9XxqJICJP84hlhTVHBFgqVGr7cdK2t94Y6V6GbbjO5/VGBGh251WyZRaDwRqq7nxFDwIritxrv1Oo41HRhO0U5bipJg/UZIPn0maSHeQrV9tJwckouk7cg6QcAWYOpawbHv9QqpGCyI/NqFpq+A9Foxcen5fjGSR+hJq6Z9opi+nDo7+oJLgd/yPz33DHLyApztiesbSIEyc1pKaXcCK4RCAObkAWU9FZCx/3oUec6+ODpjXIOlNw==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 MA0P287MB0832.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.35; Fri, 22 Mar 2024 12:39:35 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 12:39:35 +0000
From: Date Huang <tjjh89017@hotmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	tjjh89017@hotmail.com
Subject: [PATCH iproute2-next v2 0/2] bridge: vlan: add compressvlans manpage
Date: Fri, 22 Mar 2024 20:39:21 +0800
Message-ID:
 <MAZP287MB05039AA2ECF8022DD501D4BCE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0QMUb7vo1Jhrnd2dzmxJyFA80WrVwVlzWXGGIljBoIMCOr9mbeMUYpTXdx9Ncjol]
X-ClientProxiedBy: TYCPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:405:2::18) To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <20240322123923.16346-1-tjjh89017@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|MA0P287MB0832:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbea739-9ac7-4f07-7876-08dc4a6d2154
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ixzgVv3sGSKTKbbMDYpKQzCL7huSlwYoLjJXBzoTo034dn2ot4I7J8cTsZtZR5p4fvMu71D0tKLsgnsGoq2AR+xDiES0yTWmqlInYWyeyPBT0K5XxJFuRsVwyCBUVRdU6K69EMLAmJhtIwUNsDThuQ7KhTRkX/luoM24kliEeHOot5lYH9tuZt5SqtcRjgfTpYWieYWS/pqhkH0GP2+CixncIPN9K8m12ZTEaJgt9rKPqcA6syeDLn5ZzwBXff18JqzkGlp3iRPwMtwpmd/gQva3IM82Fk3NZNMDaMfTfcOEL59jazXFMm+jGHSP5cLRk5143lrxHaeQ2Fcr8ppj7DRWohVp5dmH3W2oAoQGxaqnzu++M+vdX0BX19raNEbr8dwzydlf8+ceuqJkcfAL5yUFdSn9MsQ/qrUCdN7SEJxfD4HNZaqmoHXC2QQpaVWaanjA2xtPz5atEEgpX9qCbelinNA5YyOtnZSnG351HQK2FtjOnm/S1iVG3yIbkRhA+lY9D/KBkV145is9Ntpx2bDyqQsrDnB1q5w4bKsSDG/IRZ/nNIgx14fzcGbdRDCdfkhL1Fmilhkup3Gl96mVVvVsgIp9m4iIAkCKHr/beZnEBgSIZzhA/aOSokRmBcn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lwf4ybHbdSfjMHlar6RN/TyYeL3mA1jCPqgkUvaRyZ6+nP5/mpmQ++MMJdq2?=
 =?us-ascii?Q?bgTkqcU/GXrF5vKuIq1bblDTErIAVDNMwFf2C5LUJTURkKg6WikIrXj0RF9E?=
 =?us-ascii?Q?JbUGHxNQ0OvN0UrK5M6HcuG3R6rESK+cz6F+erWbUkDmBgyte5Z4yb/z19KZ?=
 =?us-ascii?Q?+yJJQDcg44BDx+dIpE3sJioSTiaTTK5v1uOT6Khzgrb7gnT/3W9oKpXinTql?=
 =?us-ascii?Q?6+hCe85a4+DJeibtNZa67egGW6+InOLQTywtB3t+SMa5K2tpms8UIHs4Pgbk?=
 =?us-ascii?Q?40IpKulaxWeby81c2R6ApmK6yivOMOTzTfpeTMzh899kjekSdS8aDPtwd5Da?=
 =?us-ascii?Q?4ZVx5DnVoOXiiWo2PN7mlEBFf72lLqQKT40w8mSUexcL2cgKxA183OCBhabi?=
 =?us-ascii?Q?E33ACNuVO3fi+y6zqBULRb/WOtDY3Wbmz0pqTda1ktCYwOTE+6aHD6Rde9QG?=
 =?us-ascii?Q?+iVaqT3r1nigUPIn4e+AGSvwNwAhovCxKV+ndUPajUj50IqOOAvw6pc3WL+F?=
 =?us-ascii?Q?U7psMjs0/Qj8VSf3s3dFh/rmW+m3aHiuYTv9oDX1oU8ANe+vAXIjLlAp1Bbx?=
 =?us-ascii?Q?O4FGyoMxB2cESkUVlrThZr+P78DQe3yd0MRQrj57V1sAQWUlrl4soX/8fGXg?=
 =?us-ascii?Q?zHuR5D+iG9uOySV7eZY5MFvZ1iVyzGHNBohZ6zCCJ+64+46HPa7PVjS/V6U2?=
 =?us-ascii?Q?STTv0yxo8lTb/F8qsrP16MOmPhY+aKd+5ZT6wGp0lJ4ce8FpIxXXZNxn6ui3?=
 =?us-ascii?Q?uqkAXDL+9bZ/GZY0tXlbnmDA53um6XN5NvTzZTz5AoRCHnLj7GIX8t9N+F+4?=
 =?us-ascii?Q?sWV34zmKd6j+Xy0a/gTsQzcIucZ3AOpmcGgWviBszI9UhiYUnzWwNkP5suV1?=
 =?us-ascii?Q?QtExBYtMTZEVB2+KhVmklhecRqkZGDv921TjptALfFwb4NfqkPMRXTJ2MbZM?=
 =?us-ascii?Q?mrFSwgQiO+I7llrU8S1WanHV6tzco7Mxke9tJoXLWvUG4MNPhoJxkvZsq/k0?=
 =?us-ascii?Q?tesS9wF7dU2lW+dn6AA7Cs4T/PqJX4Do4kkUp1S2DvL7FOLiB6kXoHPFcNjS?=
 =?us-ascii?Q?X88HywUJp4K7VHgY9MYxrDMlSXo3kU+Bv1nyW7IXQSxzhN0zqWpycgXfJw7T?=
 =?us-ascii?Q?eRxXIh+CZ0JGnpQteyboKQonUarZDDwyuVkLdFNP7svW0X3IFcXPd/LJtFAr?=
 =?us-ascii?Q?gbPZ1HhvaSeWS4uZ5eTq/W76hRl9a6MsaPnNqVLPxbWsJjnpgqglf7H0NHEc?=
 =?us-ascii?Q?wAtRJBbPkOZm+pqaPbMETZpWUzZTdGJplOLkrqijehpLXr7SegJ/B+ssGpnT?=
 =?us-ascii?Q?u1E=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbea739-9ac7-4f07-7876-08dc4a6d2154
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 12:39:35.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0832

Hi maintainers

I followed Nikolay and Jiri's comment and updated the patch to v2.
Please check it.

Date Huang (2):
  bridge: vlan: fix compressvlans usage
  bridge: vlan: add compressvlans manpage

 bridge/bridge.c   | 2 +-
 man/man8/bridge.8 | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1


