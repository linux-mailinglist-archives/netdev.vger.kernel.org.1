Return-Path: <netdev+bounces-286699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M6oF97wAWpfmgEAu9opvQ
	(envelope-from <netdev+bounces-286699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:08:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B814F510DEB
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA5330B4D58
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B202877C3;
	Mon, 11 May 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K00KYxN+"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0A6FC5;
	Mon, 11 May 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511644; cv=fail; b=jqgY6q0y1b+HaYxPbTX8RxWtZcGzlDNjnZGbfRxCninFn2WfpigMZSj8xs0X1mB3775R8G5lzczVI6XHrjyjD8z+cK6uJMvm5fQtC/C0ty69uZYP3DoIq+jIMXMBtY1UWYbybk5nQM80TaVP62a1SuIB3S9+K4mwe6QaHdBjEVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511644; c=relaxed/simple;
	bh=i86xPdiGWD9C/Np9F3vpD7lxYq5scuiPIXu/sXm4hWU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c+IUwZzkPlzJ7fqeoNidODmym2ndu5JqXhYmQXuWwsw3T0FeGIJCV2zfgm1xG+RQSsdYNahqmuejJ/F8hB/6pfocsdH9jhWiqgf13nsqiIT8h4Esc21SgMUbIl6NaOAOhdU9qH8rc7GV+GGTYbnKS2gfLs2ymmKVPkU01KJwx9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K00KYxN+; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs4oM6yb82f8B1ASUHphtOxzFdyZZ8cbpFSOAO0119QIpx/GOMPNWz40o1XOQh1MLo8yk5htHfxqb+6AgcBLA/jXwo7kI3L1TiGULYr3l3c7jumKcUXyakY9zXDG1JzDNrGH8HL2ivYi4PQ2KTTc+TEkmVJ2Zc+2RbRBmyvDHDfau10//l9bhwdXnWYLFPT3cHM527ag8g3Kbp3Vl5Eesql19pg9HQ7O0bMo0WmhoEgIO3gINUPQHTjdcaw43bzC53sCQ0hyX9KFW0sRYeSrMnG1eLH7PHkWkte3jGc6TlUnvpmZGpst/agj+t21YND2HL0eZqJJ8KM0oMzJvHD+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/c5L4C46J010lGntMZWtzAw7NZ4ziyj95gT3oellxk=;
 b=czq/Fk3IcVgOhXsoHZZW+Me0FUig4U9VkFFaYr2punVA31ekT1WjgbmtAG5hS10YPa60O3aQ7mwBKg2Vtp+fFSxbqHjYDklVk2ZG8DvU8NQhrN8M/AJAD/FJBvatjFAFtv//LnxYEMxBSWiDUY6EqLEroWKpxxhI/n2aewJnmFwB503QN95adRKhIHvAEHGVxbnq9Z7MBxTqjFXmrjVyuhEtZKOBWa3atbgQ5eRDViEELtTysP/3shmAWfiOEPkRSqMLFJY7IGPbt5sDUCnNsGJJ6qbuTshgQiqKkRXTrd5VD7syo9z+CTdHDVWPzXeakBoUJDQYNLhwdI6EvlowoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/c5L4C46J010lGntMZWtzAw7NZ4ziyj95gT3oellxk=;
 b=K00KYxN+AWH17XAiAPMSvOzrpvpog70iHGwCnuxWk5P7phvqYmCkd6IWC9E1A7z61j1wU26NnIET9N1+CHpsYfbsG60VFeXNwMj9oKJzGxAJB43zUI0zUAtCpcb3Cm7L30paUXF84t8/OlS6PnQQZJRPTvZqda8x0DfQXGpAYpavc5YQZ6FTu6e9puB2MiysN+jLHT7DDc7MrwR0GOuQx5yJ/eq+03mfa2n54OFucSBxp0Qk0q9cfzNir+6GCmIMI3MlOqqen3kVSv0V888LWZR6vkv4R38s3ec3jiyp0xjCHdi3AlkHaO8AHpmtXrislCU+KpfHJwYfiiZdw6Dl+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:00:35 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 15:00:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy-next 0/5] Lynx 28G SerDes: 25GbE support
Date: Mon, 11 May 2026 18:00:18 +0300
Message-Id: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::6) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: a5433286-2b24-4bae-b512-08deaf6e0e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|3023799003|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FkOpT92tw+vAz5f+TNCwooyGT77L9qowS0nanLlyHRRO9LBB3z56GE8W6o+x2Y107hwcItkEMAL9JDTjgtvwVAEs0tLu6IvXNuM6LGSLme15oh6uIUs7OnLeHufZJp/Uh5lRweEcNIVKOF4+l1baw9nT4HLkoTe922ix68rN2734pPW6+UzNxPS7yyYrbJdksjjzyjuEI32hUsN18vX3rDqyUxe2N1wDAVMqMPsL6yf5g5zqovY71G1KmcT1I6RcIqt6isMWU2bFKnAwAPQXWFzjE8awHj5uCBr4+CNzk7ts9FS6RG8MlX/RraeND6ZqpW7UWuM+RO19GZVIYvuE1W/4E9WJsX+uf4g2XuJQS2l9zUdmT/1hyPUmWkRMmkrSGKCwQ1O4r7DgwHCnlrsznbiAm9OPNxhfcuDbsgyluLSMhuFoKRJL14FkasvDdYNh74O/8ftyfSDhSi2vaWh6BwsgcCuPpeGNU6p/yambY+dGbw8LBtJFfrAFMiuY1XAqGdgtBk1nz9aY/Bhk7rNdkyxHGIJielYykVLuGUF2qfPOqdD5iVMBfQaFBvN57Qyimdk7zguk2DJ/xSFbsmyxEgjV+M4J0Qbq4jsbZTysTWfZlTGx7+FVWRpFVl4X62ncjWdOlla9XbmzTBIrqs5vtDEJWUZZ/6morGRG7avmS1wrT9B04Tzctj60B16V8VW27W1WjR9sCC4Pdl48wKrvZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(3023799003)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hQQ48PhKg9e3hRt8P3fYYzhh+6oqqW4f9s+2VIkSJ4wpRlVwsbAjSMYMy/d?=
 =?us-ascii?Q?pIzLtGkByHubQtNU1NnZCDvJR+2Nzp+4m/GvZ2XnTjqHEt2QITIHCRL1XwTA?=
 =?us-ascii?Q?n+fnZzkZRY+AV0REql7PwagrPSoX47V0DuQ+1aUvtni8FaqUn5LUerjbW58p?=
 =?us-ascii?Q?iJY7UJHEhvL1hpZSZzmbJWAPggv8ho4BEvdJgDkRkKQO+JnPoEJP9uGL+WwW?=
 =?us-ascii?Q?NgbbPfs5oBRLG1DT7nYwsAWoNHVlIdz7+b/63AlGUecEFLM/uQvtpnU94vIt?=
 =?us-ascii?Q?SDdCZ6AXs79NIhK9O5VWg5Wo+g+Klq1/TOsbEMoFynAESFj6xD5oXa/KzYKU?=
 =?us-ascii?Q?pAtroTic+VV0aYMta92MAt4oHsEJiAniNuniGVvD8zSNWTUwwAJ9MaHxEg5B?=
 =?us-ascii?Q?KsQFFLU5uL2yMeDELiWoK4PlYO3HqHHz+nk1M0Y4k89HdfD1FTOpOYkjc0KY?=
 =?us-ascii?Q?vNjcuk5jEWGY+0uVPSTiWEUFakyf1xplxtGK0GtjjxDwqrqvSW8TmKAEJKut?=
 =?us-ascii?Q?cFdaJyZtlH0VIUocD+Lr9y4BpCnYFMFoYVNUECl/+E35xC8D/fxN9Fg+w8z0?=
 =?us-ascii?Q?NTtYBe5QWFVor3fhzsOCCo6l2hYMTHZQTK+T8qgqm2OrtFNOONaKroXKa9uS?=
 =?us-ascii?Q?hsfX+F2SyWmBJrF4isfLrLNavWVfuw1Kog3I4oipy0SilbkUDdV2vvE9sSAh?=
 =?us-ascii?Q?yqO9YHrbabhJ02jVl3mOxrgy9+LTDzlxYokHWeZySjExi9FgcLSVohtvYZCf?=
 =?us-ascii?Q?q7kb8h8CudCBEe4DVraIhFB+FY/Knj9fVzemDyRN77T66VfrPlp7taJeSdEN?=
 =?us-ascii?Q?OXJljRmQEiGJ+NdPt04/ESAhcXQpUqiVznluUPtxj28h6nuJ340q+Pfj1sm5?=
 =?us-ascii?Q?avqtKfSKxc+sf+LCCGLVAX1ApR/Fs4e88d6Qx9aw/YwhUmUMMccmnFbZCJRg?=
 =?us-ascii?Q?ZI8p5HK45ECRHHy5XRmLBfHiWWdzz3ihxUwHVf5jFmFH0rLn0IGmAjKZMJHB?=
 =?us-ascii?Q?90OwaZWu1vwq/RUaGeyJvE9VOISAjni4ywwg7zlfFU9uR4YfkQ/MTN82UyIO?=
 =?us-ascii?Q?ZdgfBFTzZf+RHPEaiEseOx3Bwzpu8KhVaB0g/eohgEc0hmDbRcuSusflbl2c?=
 =?us-ascii?Q?PVpJCiSwU3QStuw89ksRWy7vulIpIBr2v8bgqsjC07pR7Ywzi25pYitHlVwv?=
 =?us-ascii?Q?9uMYVvzGRj6QCrEtplDR1lS7JfAZPp9we0DCmypcuIWlhDKilZ/SqyxunsKr?=
 =?us-ascii?Q?UoB5kXRm1idXeaciA6QZ/mp3FW68JfbJO3mUQGaL7ZLtn1yIGnmfqqpxdIqI?=
 =?us-ascii?Q?UnYNKRpANLRZcvdhdLeFOtrbHf5+LRSMpfPbgejNKSuhhpUO/Uu3/Q9QmtDR?=
 =?us-ascii?Q?f0Ewj7kv36TcTMcL1yPyREOe1tCDbyy7JJwiq55FAW+BkHrVrdSb0r/WNQLr?=
 =?us-ascii?Q?C4Y9Y1QfI5EX3VUVijzW+M2eXY1h3U9KN+N4ar7vuPUKZ3xYO8Ey+xQWKVgC?=
 =?us-ascii?Q?FOwZ79vdY/SnBodFkwA1iLiOV0Dn372CCxOEYq06t83tZDwgWM/N73g9Pfm3?=
 =?us-ascii?Q?6nNaM8A1PKw6lZh1FF+XkfhKMa2fpMO8o/LTO15GwCN5OCbcKhblgjE7W6xX?=
 =?us-ascii?Q?/+EcmdQoJZY/Evmx9YAt/uFmhTj4ZWG7tsX5jO2U1cKuSPHC4hLNrkRHSzSw?=
 =?us-ascii?Q?gaa9o8NSIsNxG2nrIcFNlyWbfbf67e8/71kLpog4RSBnRB+rIvDRKcOffcBQ?=
 =?us-ascii?Q?WNfQz0UvXQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5433286-2b24-4bae-b512-08deaf6e0e0f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:00:35.1581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqQf/iUg86iLUKhoji6BewiAkUedRfUSK0AqgIWc4Jp5hLUPupHpNsklc9ATzX/eQcsreNcFly5ztoqidv5nMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976
X-Rspamd-Queue-Id: B814F510DEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286699-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

This is the remainder of "Lynx 28G improvements part 2", previously
submitted here:
https://lore.kernel.org/linux-phy/176850672122.1082429.444623229961712368.robh@kernel.org/

but split up into smaller portions (merged separately):
- https://lore.kernel.org/linux-phy/20260226182853.1103616-1-vladimir.oltean@nxp.com/
- https://lore.kernel.org/linux-phy/20260321011451.1557091-1-vladimir.oltean@nxp.com/

What remains is the highlight feature (patch 5/5): support for dynamic
protocol changes to/from 25GBase-R, required by SFP28 modules. These are
used with the NXP LX2160A and the (Ethernet) dpaa2-mac consumer.

Patches 1-4 handle the following situation: with current device trees,
the driver will think 25GBase-R will work on a lane, but it may work or
may not. This is because not all lanes support this protocol. So we
modify the SerDes compatible strings to identify them, and we use a
driver-internal database to figure out on which lanes does each SerDes
instance support this protocol.

On current device trees, 25GbE is not supported.

Detailed change log in patches. Summary:
- reworded commit messages
- change match condition from dt-bindings change 2/5
- patch 3/5 is new (reject probing on devices with no OF node)

Ioana Ciornei (1):
  phy: lynx-28g: add support for 25GBASER

Vladimir Oltean (4):
  dt-bindings: phy: lynx-28g: add compatible strings per SerDes and
    instantiation
  dt-bindings: phy: lynx-28g: add constraint on LX2162A lane indices
  phy: lynx-28g: require an OF node to probe
  phy: lynx-28g: probe on per-SoC and per-instance compatible strings

 .../devicetree/bindings/phy/fsl,lynx-28g.yaml |  48 +++-
 drivers/phy/freescale/phy-fsl-lynx-28g.c      | 221 +++++++++++++++++-
 2 files changed, 254 insertions(+), 15 deletions(-)

-- 
2.34.1


