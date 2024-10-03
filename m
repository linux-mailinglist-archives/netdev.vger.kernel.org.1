Return-Path: <netdev+bounces-131645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058EB98F20E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796601F21B1D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A79B19CCFB;
	Thu,  3 Oct 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mBSQDtpI"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171619C54D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967766; cv=fail; b=G4XjdhgLAhdoU0d6nbO0du5Bf3kZmmodMWeShsUSceRvj8yUM0eV/Nn5MTdeHugRZiqJ8oNsN4Cb1Ij4z9h4+ESXgdHLj2oyYP5S+mP7AhOcaIiNz9l7ErHWcTslimtWg3D2erzmuXpCNiX2iTdlMW0Jwn3YoMTSJRKpvhRrX/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967766; c=relaxed/simple;
	bh=Bf4WiWFt5q2zie3eNUyLk/JQgV+aSHWQWXsLKKeQQBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=taA8dHcShICrbmqS01mDVcz/9GGJckJXe4MBQaqd0jpmij6pgTpEPz3UUMgi6oD/Owt8h56At7kIqxb7miGRClb+bnGl0/ykEVbPlRGMk3JROVXWSmNJq9o+1/8fQSAhjs69Q7rmmltKEZYv4z/4g0q0zIrVBul1wUQdAyvs6WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mBSQDtpI; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbIvEBZ+HYX+xL6E4vLZpkh8tV7j+8DUFPiIo1bedGXhpKGu8p66IJSi9sFUUR0Pbl11HFfJOBl1eHr33k1iU/WxcieZ5lOLRoRYdmMjB/qZwQaZxhF+khkqufvLtR0n4Ko9P6lyp7E2qQCQrLWVKY+MPHgni/j67qJohTFfzJ5nbcNuAthHq7QmF5DYTZ6sQQqpOe7jRzquA4vU6zOzlTcGEW8uXi7U3rqXA+S3sCP1Y6kd5eXYkscecf5DwSGU23JLZ4gmuKpi6qUiu38vnwfD2A/jm4Yz2az8XPWqJDpLcOS3YlLD2xATYWY+q4sEl5R0tCrBC5OsA3zrU0PF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWGaIsPEshk/7+WnJt2iH7XHxz18VEwmTrxC/deySe0=;
 b=XH3LRINNhMWyMhrXR2FHCsBiUBKnm2DtntfNrFNjxfrkUKzoziumJGyCf4DsJemghsT+HduuhLrIRzSMz+EkyJwFjEbbAetKjrwenuh8P0BY7e4pAtxBGatpqZwQKqnIFZkFKkwziZgzGz3RlufDBcQkZpWzzE0VwpM8gEyOCtu8IKOT9LoZEllNKwjFFSogrZfy3n7UY2SaeqMsFBtoOdLMLtHy6ZkMHmHAI+cJo8934MDMoLXF7DLS0vvUN75ib/pze8+bMLOJrVwvXnCeUOvhYsI+9dlmJ8BS25HndiHKxPfJn6o8gIDk8kulNA6MlEBblSd4xneaolpN2inApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWGaIsPEshk/7+WnJt2iH7XHxz18VEwmTrxC/deySe0=;
 b=mBSQDtpIeTM8wpCF6nBFX0E8y3so524nJaap+fbR6lKydI4Ft5lYfoQW6qc7BYVA4x8bginvTE1gt3U4QdfFdVPyUHXxUDiyyk2yR9Tjc3WSscb13nCHiddCIqTy5ahnN311gFBAVb7UxrlagK+kH4BNiWqDUhSWvEjG11yCy2rFy5GJ6LKEb3r/xBEMBJxKGTyef9chHX3MifMckmN3W+dnOzzvRjsvKMFTbCUWEDXksZKGnCHm+h4s0vLpV7Qrzts0pXzLCeIgLkwnTAKAgrCUmS38M2Ur1FkytTUNEEzZuO5FbI2WG0YtZcJj7xzX0CbgtAVUywZqVq5lHp0flA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB6831.eurprd04.prod.outlook.com (2603:10a6:803:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:02:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 15:02:39 +0000
Date: Thu, 3 Oct 2024 18:02:36 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 01/10] lib: packing: refuse operating on bit
 indices which exceed size of buffer
Message-ID: <20241003150236.w4dpvqwfqnyfudhg@skbuf>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-1-8373e551eae3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-1-8373e551eae3@intel.com>
X-ClientProxiedBy: VI1PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:803:14::27) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: dc131fff-23ad-4381-3ee5-08dce3bc6c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UoIrWsp1aL2VyzSQtZos/BvRZ4fsWXOAiv/fzl5rEpBo/2aPirX0qWy4E80t?=
 =?us-ascii?Q?b1FQoTcieSyiF2t7PCSE6g4UzRv8LH0DFJ0XITnCLSmvcuChpX0zjad6/2EL?=
 =?us-ascii?Q?V3otCpCd2ZMh+8c3mLD7mohUJHNIILoMNtm0ApB2395B7jrDr9590UlQTGvs?=
 =?us-ascii?Q?ljbCs33G29t99kaZDDMg4lNdOtH57bXYofNwkuPi/P1WL0W1wHd6NgKcJZX8?=
 =?us-ascii?Q?xqz8X/sltxeHDz9YVUNAwsz9f/QlKun7rLwh1bnf0/tWbQuq2o4wWWL2Bm+E?=
 =?us-ascii?Q?JnX1ixB9nvuojdWJBgEUk1vscFpMe6wnMmR0ct3vHNhFnCFn2+9FrhfCuPnK?=
 =?us-ascii?Q?g2XAkmhyTE6ifDCkyaZjkl0Bh4fT91/HNlM75O4Wu1lTisneFlukmUy7AsxW?=
 =?us-ascii?Q?H/tvsqhBzDR6yACp+IKFpzfoADRy/e2bS+ZU0Qt6rI/SzEQi4IiXpGlR0FtG?=
 =?us-ascii?Q?I9PwLmXWJy2bwjqRrjtxCTTkH8JgMQaufH3/WdPVavQwPPNxe7Ue/vVbYer6?=
 =?us-ascii?Q?QqmpQljAy8Stg1k25VTSmsn/oXNkXpPDf45SxMnjn9AFrWWi6+QMS7ADkcYE?=
 =?us-ascii?Q?0jcm9SvklrOQu8+YOLOf84f9x85j7mxoSstUuEkfr4GVhRbkwp00chp8/4yV?=
 =?us-ascii?Q?WroJOI/rfGWViBw4Qn1I6naWK+o1vKONkjD4Eiq/kfLrwcj3TtCMd6M3zAz5?=
 =?us-ascii?Q?4GrFJd5G7LbQsxu6fLkIRKaFO16XlUPqaFKPw67ImQtTe9zcdxUa3xN/zwUF?=
 =?us-ascii?Q?WlJVmUDxCkDo/CAFFQXHLd33Iola6LQaMqcLNOQTLTx9cVS69zsyGvmqX+6P?=
 =?us-ascii?Q?haMWMH55an8LOsOwmJQ+h9z4xXiy1aow1yLpYImxQIupnOEAbwUGyn1mdzl2?=
 =?us-ascii?Q?ZO8IOOi5QxRaJGc3cZz99Fs2lPlJqGYCXwYv1Qa+8y5MhGTrpWpj2uSl1ryd?=
 =?us-ascii?Q?NZdi0wmNoZkVj9RioUMgER0+PZC4OqAzUKPfK8IAAtESLjah8k34duAHFH9p?=
 =?us-ascii?Q?0drZkCVBaV1hJdkx9L8ZIbine/FC28xbSxbq2hJSWmYTvCHsYJ/oEre/LdLl?=
 =?us-ascii?Q?AoMxUOC0syDwUgMFXp8fWwSvC3HWxx1D+UtBjzkXWE99HPufMxMtP2iiY95o?=
 =?us-ascii?Q?aEzgSapVULfAW1FDb/BLfxBlJ01h7fwdTMNihLXxVVhOxcmc/mm40FMEuVBD?=
 =?us-ascii?Q?iQesFOJpZTeWcPfEZ2ePOp3CACB4ex/Nl9VwQpQ4gZlEA+WC5bdWZyVJfspg?=
 =?us-ascii?Q?Y4FKuDcCU4usmrb/Zv/1m2Hs+PjugLHc03MmMRQfKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7+I8WsQP3WbVel8zxONJ72vbMbNWIwAVPHCLyVkgyZJuhc9bfo0zu74+vIe?=
 =?us-ascii?Q?Eulpc8kDJGBUWejl+39A6Ou4rOQQ5dVUi002ANKh/g4vdgK84w2SdaTAUbgC?=
 =?us-ascii?Q?zBx5GIIKhC6oJZkzPycxbMC+FTLnhrQ4Qr/3U0StJ+MPxdBK+MkI0sI1d3Na?=
 =?us-ascii?Q?JSeKsnqBbvG5Rn60Q3QPen8fEnUONHCO6z/0/0iEyqc9V89p6yidgA2iYKlo?=
 =?us-ascii?Q?bqPew1Jgm5gDM1kASO3vmTiCkAo101jQ8wL3TBeMQ+2Mnxo2Q4pElVV6zwPJ?=
 =?us-ascii?Q?n4KsLLnrc1eO1uClCuk6Smcic9/eubH2gMKSqCR4x4pCNHZ4WFYNdKM4yD2P?=
 =?us-ascii?Q?imKhx7+x0uv0cby6I/qzx4Uw5mmgZDzcYIG0f07cwPU1xYfKATDjtvE6Na3W?=
 =?us-ascii?Q?B5tK9Crsjnn4ywKz32tTLTlgDvIXnNYcuNOY/GaHai0p3VoKggh8XiGfm6ca?=
 =?us-ascii?Q?d4V/Ke31CzUHRsddWBzW2UdhIEQ/6DhV9oXzF1Mw0b9BXOeY+r2uAyVJwqb9?=
 =?us-ascii?Q?llH666HPOQr5pYS8O1yyX+0wjldyRigrk1UXXDfzJ7/g8XO3M5Y7HctKZ7p7?=
 =?us-ascii?Q?Rnj7i2xK/5vAuLxXGoL6mEXWtyNIMrAdsFtHzH64B48CQSgRtmThNgMej2AP?=
 =?us-ascii?Q?/c8nWjxo1nBDWKjw4oCFZ2Y8z2Mj9btiYPJysdNQ4a3UEC72AmCi8SRMF5QS?=
 =?us-ascii?Q?4gRFR+tpb6u3Z+cFOaYfA6Yz5RgSItSIz63L4qQDnj9381aqLJ1tYoEDsNlp?=
 =?us-ascii?Q?LnL0AX9Pf6qKJFaCbxzqSoIBojPBNfIjoCrrs2727NVGl1zc9MoRCHkgwrpd?=
 =?us-ascii?Q?uE7F8Oe/TVeWhLWdjLtuW0u6w/OXrugc7vqdcnS+ORm+dqM4eyQ6hSrDh3y2?=
 =?us-ascii?Q?mv+QmWGWewu/ppdn5owahycD1vy+8VdBF7I65LfZQB0szDSJugs1k1AYldtZ?=
 =?us-ascii?Q?Vjwlvk0xlP/fJvB6Z7gyPfizk0KhWvCCs5NjZhRoHorrkzhozC3m6XVpgixP?=
 =?us-ascii?Q?pXQ5FPicyy4g1m5ST6tKBruRGELc/OgyNog7Pc4IWkN2SzIdwOeBfigPt82g?=
 =?us-ascii?Q?ik7aEQt9xgJFRzd1ULy9PiErhTtR+A5PcTKaF1rgaaYYTz1IPXUexIqDGqyu?=
 =?us-ascii?Q?CIyl2Bz3tTJIaivZhrot/U1WyRxo3rJDJJVMpERNtyUA3MgJsaXH05oyrSd4?=
 =?us-ascii?Q?yVE/3TAL/J16efqdjXlIaeA61myfkIes3MED0nU2VdWoT6egUlSUV3y14au7?=
 =?us-ascii?Q?Ls2oK0YK/VHR376L3dt4BMdQJBHoPOOFQBtmlbbAHMiRQprsZ9ZfYuAHHl8e?=
 =?us-ascii?Q?75FbAV9vO3lmQquzRJoQ4/CglHa6UHPBrePUSLSv+LDlii6JaijV5wFDOxvd?=
 =?us-ascii?Q?NBBrau8wULjL/dnAouo7LEpm4/ZF2ILAGSQJE+85+pktADYcRBmFTa7fCCUo?=
 =?us-ascii?Q?aYQ1NZvz/znNHZootcQpiYXxdrKHjTe2ViS1WDdW+kUs5xFHzQtOH1JXf+C1?=
 =?us-ascii?Q?np8rS26bko6/C7M0xZ0VoDCZxo9mCmBUi1LKSx3Yd9kkaAvfTg3JIAL2If+3?=
 =?us-ascii?Q?kHS9viT0ObZgrdE9tKHmB/HyPZEg/15YIP9gfTgnFcHU6P6hd/samQ1Q1uBj?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc131fff-23ad-4381-3ee5-08dce3bc6c71
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:02:39.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODdcNS1DBMleV0Y2fpI+Puy59tYEJU6NBdNN3zA/t5yzXtaV10pEtdVawHnniRHDNxvDQ11+FKk+0o9ktLefpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6831

On Wed, Oct 02, 2024 at 02:51:50PM -0700, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> While reworking the implementation, it became apparent that this check
> does not exist.
> 
> There is no functional issue yet, because at call sites, "startbit" and
> "endbit" are always hardcoded to correct values, and never come from the
> user.
> 
> Even with the upcoming support of arbitrary buffer lengths, the
> "startbit >= 8 * pbuflen" check will remain correct. This is because
> we intend to always interpret the packed buffer in a way that avoids
> discontinuities in the available bit indices.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

