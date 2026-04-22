Return-Path: <netdev+bounces-280432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN+eGDTW6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:07:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF64470FF
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BB3E3007202
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759363ECBDA;
	Wed, 22 Apr 2026 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWS1Ip/x"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F322652D;
	Wed, 22 Apr 2026 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866856; cv=fail; b=m++R5hCD8XkSuVKMePv4BvW6JWelYY2NS59eeygQhvx/6w6698KXJuQAGigZAHp6mO684WoHIUgEuBniYc4oUWyMX29p20JCfpH0psH+JIGueYLJKfWGR1IfzOHgva4blFRqmNRK1mFn2lQMvH5nhyo9dtIg5nGyUc+Xsd118iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866856; c=relaxed/simple;
	bh=mh86S50RQDtjo4b5+LedW063NWaNapokvcTK0Kj4sZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OzHfLy7HgS97yPAzyvULMhVZ72hGi/SiYkC5vGmA65hSHuc+TnhJqa+mej2vtQhbex7wI3gSarN3SF3IrdrDtEAXWQ0tj9uZa7ehzAbzYxhj1r657TZUeEMX+r/DvJrCJiA0ExCkktghjHrZ7ZfLH2aUp4zT6TbuGiTLqUaDeCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWS1Ip/x; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsSK01EyN8HBSjzgs5CnUrcuDMNCEfyh4luw/WksgKDK009fmDXy7AmKawVp0VIlRdlFBve9R8BJrBcf+zMD2HfEblHdB0RminvVJOZzw6c2heRBeMtDgKlcYKb61ZxAisH9T6wmwJXC66MylV6YYG/E+Ob96mA4NF1Nzqr90wMSOUbbkQLki6esXWPbQNyUx6ysR6OvBeYIRAJ7KPmfew3FYJ86Njp9zULjIbwtF3UtxKhhH2/lpwCULPdUIpqy+MHqvefEnEVVmHEa/0yphhhdU84d+aW2LYlEDwLBy3zUGKzbMm/GdC5rVRK8lBeQQTuUJkoSCeUeWeIT3KGDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKl6PNr/EtsVRUKZqjh4FjqZVOGL/X+I07kqX4+YgYg=;
 b=hsOvdl26Ll93LhWMMeWbCoTVQj5mqSeagcilEsuSKpDE72wC72uHdlHNXrJ2EFgaoCinaMo1SNeGK8NXqkh9ZvumGJVFknDmSvFw63DjhU2YUa832MyKgcRlRil2cWykDwfD9CUySu1OXSH6h2b89zIcR6fOd0SMW+mgG6PugUOilJwCMpUkhCA9k41DwBH/cwS8zuFzfnAce7921v++jfsdNuuHR+03sa5Bx1lw/ueDZy4g/A4BqMJ9bVa4h3X/mg4Y2cO4tRYvysGMmxrJw1HcM2HZePRdBG221NkZtqMNRsAAonR6zHD38lgeYtWCaXMfbl7N9FAHllimTA3Y6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKl6PNr/EtsVRUKZqjh4FjqZVOGL/X+I07kqX4+YgYg=;
 b=GWS1Ip/xYOQ3TGve7Qyupw0HxsPqWZJB+xVzl/VJKdvo09twlxR2QE4h0PL3vJ4BS9LcOKoZdzEES9yX3+KjB3ZyHU503wqUV5OJIM4TYTwccdkrtirI6E9166dhRite0zWkfZDSeHYspDjR3szwTi7bKi2evC3irpdKW5D350cz3dVjpA0/SrJvfsBr9PyLZTBzPBE11LZ4zCd38kxZN4r7dmZZiSgYUZrAUAlwDVaQsy0cyu4p7rDk9raCqT0iy7kJ/RJnIj4yxK04iZ21AgVPJFrtSp0fBBCG8n6YCiK5AEXO9Qb9PBXhEf8NwtJsE14dztxBxRrBhw4y4clKfw==
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 14:07:30 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::91) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 14:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 14:07:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 07:07:11 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 22 Apr 2026 07:07:06 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH ipsec 0/3] xfrm: Don't clobber inner headers when already set
Date: Wed, 22 Apr 2026 17:06:45 +0300
Message-ID: <20260422140648.3877129-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9d802c-fa0e-4ecd-eb25-08dea0787e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zc+m1eCanOyW+rWZKSEFoGxqsiEXkaYBxUaNZp0Sjw58dhLBRn2V4aYPyXZ97gdoOUQI4CyedGB0y5dv6Ese7xjYezyT1kHfIVWG3EEFnP7G8J4H2+uOH5+ju8XYDOTRZQWft4vB4hAICh7zrz+ZXO3J4xJd3cbC/vEwwl4C4XtXQ2Situt1AcurDpR1xaSbj8soMrZRWKG7e45pt6pk/FFeiRfeXj4dlD101C+xGzJnfHyryYy6n9m7MlZ2HMC5LtxiHv33o94IK8wUVZPUDR6PUiUUsJQoRt3C4+AJFtXFMzK53Hyo4jmFstBynKuPBKUsTy4gcjUoeyHqkIVanujIIcws6dHg8rLszCcxNkC5MwbTKd70zpjKB5LOoPcUyzGwYxAovXJQfAJbiLtxBmVfBMuhXcjdig/HnY6mMz6ZcoD7pHYC7Xn5TTiuk3ijHW93Jjr9oGEQBVKktAbnvLs52Dy0J6iylxjUS5OAxMNgnIBSgj7m1Bmf4EziXy8W4v+ZDDztYgnKfFAvOBNQ5vTdBLUniXfwpFUBUTrF7zF57J22cGLk70PyXJ2w8/qcJjPnnJQS2aNidbczvgpx1ZVQsuGvJl+8zyV0+1ioXxv4F6AKz/kVESt27pkByOkQxHwbWrOuZVL/sk9ykeXkPRb2oFnOGLMeSgRMT08uKjbCf/Frq9KgUId4xou8+g6X4rEiXQxff0+eb1MfT1xDhnHFJ1zxyK7R+5KWSmP1ISsFnRX0VodyXM/XXBm5gRFM8gac3IH32zqTAl4p9AvzoQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nzDjaIvE7hcfmtz7jNTQg8KHyjm3UpnVag4R1J8o6i0RFwdA+AVYA5GpXU8y6HR9DEm2G2AsB5M3nmQ/ItlWYui6TBgCU5iS0VaaQEdxifaYibJoTa8pOgh7FZOTd+WOnz8R0xv2JLTXvIgyZKx2ppDdh2W9M+Lzmim5zhHnfmxR+ofXSBupq+UiV9VSQTVyPPwfRs+67fU8cYJfQlNklWUAnf6IdGGWeAlvbFu9el38Ibxh/D2Zx62PDKDrcUe5HK/Sk35MncOLUanYVNBBIYsmd4ZOIYWP8FGNBFsKH1GXSRroQxK8FZ0YGDW3e/0hwumuQ23WogCV0fwxDawF1ITOa76BiA4viBOkqXpo/D7mrCznPZKd+EJbjKRUVCzPNyfNwxc6XPIPn7+PcUbv35REMGABr3IM9mkl7vYDEXAGXkG4krvHY2mBhKuTapmH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:07:30.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9d802c-fa0e-4ecd-eb25-08dea0787e07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-280432-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5AEF64470FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit [1] exposed an existing issue in xfrm which broke tunneling
protocols over IPsec (e.g. VXLAN over IPsec).

This series fixes that and adds a test which exercises VXLAN over IPsec.
For details please see the individual patches.

[1] commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")

Cosmin Ratiu (3):
  tools/selftests: Use a sensible timeout value for iperf3 client
  tools/selftests: Add a VXLAN+IPsec traffic test
  xfrm: Don't clobber inner headers when already set

 net/xfrm/xfrm_output.c                        |  20 +-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   5 +
 .../selftests/drivers/net/hw/ipsec_vxlan.py   | 204 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/load.py      |   5 +-
 5 files changed, 228 insertions(+), 7 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py

-- 
2.53.0


