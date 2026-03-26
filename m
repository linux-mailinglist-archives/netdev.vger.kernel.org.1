Return-Path: <netdev+bounces-272072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPcuF3c4xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:45:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D7F33633D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABC6A31F979C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B1D3F8809;
	Thu, 26 Mar 2026 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ceE+xhMX"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD353F7A9E;
	Thu, 26 Mar 2026 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531754; cv=fail; b=FvfZnnjlElbuoKU3x7NTC482RqFacVy9OVHlGOLlFbYXTZ68U3PTOBUNOj42q4Rz7Mtd1DCxT+NGBn3+nzAYnR6pn576DIpyDDK5f8WF3jGbJfaT217VMY7ufOdBgiZNuozT8er+6zdJH3QyXDbQoSPFv1CPOCj0u6MWodmayoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531754; c=relaxed/simple;
	bh=2fynhWH0hYiJ31js8S7BEucxpAN1gP3XncftxlcUe10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJPJ3KAk5TJ0qrHKIq7GHRYddxUg3a2uHBf1DxisM84lvcqopiFmhkV6Gij9Z8eaEN3pLe5O+2xAnXGuyqSVMH7Yprd1niBC+9jJ8u3vBAF57/S36lvTxH89FFTHgDJCSzT+yf2gAYZOedrEwKpew+1jJOJwGD5h2RkLy9OFA3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ceE+xhMX; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs76cU7ArSnqftTY+Sld8cdbkpbQyhZFm2dw+KWEkiPMfsv11Tca6rrdwPOh7ftw1APAsowkUkLJBIOw8xlS//KAxsZEOubSGZ4uN7xGwJT4laTp6Pbob4ftOIjwgdx3o0RjtxiWqg2LpeBp3MIVjpHqaJ4UeQzNUHLSznehYA2CvGXHv6NJ8BJwocHztokA234JoIftAjPVctbBeCftyYhEz6sYKUBCNbQQkkBIee4jSbr4gIe4DTcsZCDJhPxVoWftA1DAEQnJF/5Rgs2rndTWL3phLrApk8jW0jBLk9YD5uxeENa+J4Zws6KA2AF6aSjjikLw26UYJzTI5/gcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+8rWwGMt2BhgY4A4WosBi2zNwvE9+uEfkz+kdI3q9Y=;
 b=ki+UvotzAK/rwwvCeXbDkCDgLquWFo2iIA+ySnZbSDSI1zFCvp/DPeioeMKwUdDPKYIzeMMpGFEBHsDDDE/pFQKv6i8jS2oituwoN5C6FLWL01J+3GyreAsEfbnViPW9G5LjitbSSlAqREVdAsVruRuQs+cVG9/VEJGhNGnUUMfITKA3OcV/qDdfcsauIL5jtAY2HVMmNEmkAn/sRgt3a8Z5HDwlqtheT1Jnn/gqasCkgUaswvtwIsaX0M2Cbn2fM9y5s2RCP2+vc2tehZ+jEZa239M+5CaR2vsEmQYnnfxglJUD1lcH4sM2bcQIMD75RXJJlXZtpNFw3w1szUEAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+8rWwGMt2BhgY4A4WosBi2zNwvE9+uEfkz+kdI3q9Y=;
 b=ceE+xhMXmciv59DfNpR2BH3sn9e/DLt7ZsmPJeMxejR9ZM79k3Hqo36AmcWPuoe/zm0UuQ4sOGpVjPj/NyCFZ6R+wpW+zE8bsWtStY60ij3GVuEAwVfogvvU7MFH0R8y/TYh0bACOYSIHQmgVaF8UdU8UBalakyVOfv7K3cPkRstxrGNO/Z9cq1DV0rP4b3u9AgcVz6vcLOTTeEXY520wnnAfHBLBgUb37HPtQLcVto7uxH5ud2LPWSMeajns3ypnAgbJdm8UJNuDzFWd/r53fWxWMPUMXRm16cHoY48HXwM4i8aRsOcl5WppHQ0daLc2F2LpKhDEMKhQK0NiYgYlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:29:06 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:29:06 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 10/10] selftests: drivers: hw: add test for the ethtool standard counters
Date: Thu, 26 Mar 2026 15:28:28 +0200
Message-Id: <20260326132828.805703-11-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc3245b-0682-4449-ae07-08de8b3ba736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZTX7nbqHe64QIxVNB+zqb8lPa7nDEDSbZKxKznLzH52CBFmOWoADi0ljAmZRNxwV7GDhBh4l9xAjLJB9Y54rmI+TAJPEdTry5XYVbp/T/k3508qoQ/aOY/jdnOfLf2bYw/hAfQQyxGk563HMCCk1E3gbHMmQoFhjEedwYegkdLduM7W2Kxw5utc+xqZY/SSABXsblxqYnUUxKi8bT99MJZ6zNM5BvWdliTJzd+11JS4xhWFYGEpfwI7GF9KjDGXvVeVcdOYKKCW9RibKNUWtvYi0BwwoxmbFbeYOMwD9HZB2bZ1cYFcIwvrZsoRSV2XlPa1RvSzJVRJ1mkJStBvvXuL6vDk3JBINIJ9ernwMzAQj0oEZXyf6UJDo5EM/Kj38ilsuRcroZEdDuugmbnnkSYzPQZZHdZQyuQtebYNtrfN7Ew0P6E3CLL6SCWwzeVIRcg24csDOmLSjFVZxIzDYJSS72q88EIDmqS61V/45/1D+mMPAeOhV4ST3Qacew87/rtUd287Cv209InzyeQHpy01WR6j8SDK82IKW9xamgRzZXVtUJ2mKfIyHICrDZe/gbCj3JqNgIpuriv4bY44U7JSXy9Ie285n2mij3lmzDXl4dKmyXHwKuz/+CJPSRbDeicTymNGXoIeV4pCJACGGm0iQHE1+AJnQMZdOOPX+eMezsiod2iB8vqU6wIvZapKXeM1by4Gaq3ohNnNheVpidsio4WGDg3o5eYz6PKtxwxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yXYsWyvVr5OyK2Jd3AlfgDJtzysxhnzzASW8swsJqdkYmmYqFclDyTm49bm/?=
 =?us-ascii?Q?OgV0oxvH6Q8J5mdlaZl66LCsuUG87zKVk9lUnmSazRdlYpDJB40IKR4Tvu8o?=
 =?us-ascii?Q?cGfS1stBOK+09whFYK/lynIzoFKM9UCK7D1XHClLXJHUNiZTbOZitjleVWtM?=
 =?us-ascii?Q?PahkbY7P/G4q/iSO6in4DJQyQyutzz1/lj53YzOfIut+zqMoH7pNGT6TEE6s?=
 =?us-ascii?Q?pOm7CGxSkbSF+N5otj8l2GMp8QrD1CLhyo4eTvORSOP11rnuNJ8kS8qVnpXP?=
 =?us-ascii?Q?gXBAx+y281pox2u5CFkavsDncAC9WZrvTivKmc6YpzuRcqLKr4PxHKhnLfUZ?=
 =?us-ascii?Q?OQV8424N2qfRStJglX8i8NJxCcIdFt9QshegaUf+kl4bEoaMBzoXgy/FoSS/?=
 =?us-ascii?Q?UwXhvfdC5zT+QFr4/tQtmGqbwD2f6doLkHD4jq+yhD7toLl5UQh3PnVH7EXN?=
 =?us-ascii?Q?nA4F13NvAnB3x/MESUHIQs3JSCBdYgceVjc+XdsDyOAeQIzI0ir/HOeZprba?=
 =?us-ascii?Q?J0qGTjTDShTpFRbEXQloyZImP0tUFP2xr/A4mxhjXKPsgmvwvNArL1ZiRm40?=
 =?us-ascii?Q?IOS8bXBKx1b6QfdzEl3qx/zYX86RBXhyBiJUAD0G4VAp+Gd5cpV9oKs7xLFt?=
 =?us-ascii?Q?cN8+p3GaK1C7BgtYhXY4+h+81WtLa8QGV1bsw46pKDKs2cOQn/gne3zM4TDr?=
 =?us-ascii?Q?Btd4zyyNQylSJ++0u04QIys3pHsI6o2HgQCfAYejrvcQqFi8nob8R20rHSf5?=
 =?us-ascii?Q?cjhNjpIaCjtb5X9ctLp9TpNb+x196IwOJy6BVt2e38e7kSLcPA0lANy42SFA?=
 =?us-ascii?Q?a7XP1KdP79OmMNi6buh4xzzI1V6YBI1/8Q6z0aOw7kuauD5VshgCq+lIhJ9C?=
 =?us-ascii?Q?OmViIWtnJPDkF7Wi96rW08Pxuhq7wrAnSDxdsV7KklbOp4vnEU/t1yCqbAFd?=
 =?us-ascii?Q?bVz3p5QQsYAeJExsrnXX+WOTFYbeFBqTjXJ97Ln8FK1x/RaJmAgKGzAL8jWs?=
 =?us-ascii?Q?FO5dEhRNirHEW14BoMz633urdfsXm5dhSIL9qTRqsYqgSG0jqKccXTBWx410?=
 =?us-ascii?Q?jCqJFbuRq7vcqVyPvWXQ3uEBm/YWbdgZ7ZHyuSOmCiIHlwPVBhKV7Itzm+7I?=
 =?us-ascii?Q?YF3iGdN+1rgme9M/s4W+QAVsM4BxPtJ0NKLR4ksT1KQ8mJJcZAFFP+UqHvhM?=
 =?us-ascii?Q?7EVfQgX6mhgA3fwf4RBkfSlU7KRRc3QdqgScWkxIyBc+3XQNSf9Fzd+D2xs3?=
 =?us-ascii?Q?pgmm3vQ7Sve9mBhfLEG0N/dubn/uarliujDxZnQjuZLJS0z0nN5+0+nxJRIm?=
 =?us-ascii?Q?5LE2BhBAKQxjswn9tzG6moRHMcb3Ewknq7tsO9Ls8nzBS4mNpAH/j97VmvDr?=
 =?us-ascii?Q?VFlRKnC6p8YnopLf5e2Co40xKWCRsOgONpSoqSxEVslamolzrsXTDQ0UIh6X?=
 =?us-ascii?Q?Rmo2cdyuPqgM6aZW2tEm4R/aDx13pw19zz/m3soMVvkFcdZv7TWMu8SxVNAw?=
 =?us-ascii?Q?ciBlgjQ1N7VzF0YLPifoBQCLEL+qJYGE09Q4bF20McwCJy8MK5AVX5Nh8J4/?=
 =?us-ascii?Q?YrSME5xEibxBGXKSfLGd1+PECSA3NkqtygB/fPtl2LS8MzupwuAN5sZRCeTe?=
 =?us-ascii?Q?Czrx5y60gUDdkkhMeurn9zmG7SKy0f5CKmOvkteqWQqUeHBFMQtKgGpNSUcK?=
 =?us-ascii?Q?m/5/DzDzt9zO3sdUu8QJq4BNYNnIQN0++sCTerAwZy9gbUsNPXNA/D1QGSNW?=
 =?us-ascii?Q?W3qqCkty9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc3245b-0682-4449-ae07-08de8b3ba736
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:29:05.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPtHhewQ1j65uquL86lvzt9d0Yt/HDGkir3clPUYW/Sd+Wh21AIw+a3R2X0V1O/jzcg3YwOzq9iGz+qxg8DqqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272072-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_std_stats.sh:url,nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ktap_helpers.sh:url]
X-Rspamd-Queue-Id: E3D7F33633D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new selftest - ethtool_std_stats.sh - which validates the
eth-ctrl, eth-mac and pause standard statistics exported by an
interface. Collision related eth-mac counters as well as the error ones
will be checked against zero since that is the most likely correct
scenario.

The central part of this patch is the traffic_test() function which
gathers the 'before' counter values, sends a batch of traffic and then
interrogates again the same counters in order to determine if the delta
is on target. The function receives an array through which the caller
can request what counters to be interrogated and, for each of them, what
is their target delta value.

The output from this selftest looks as follows on a LX2160ARDB board:

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_std_stats.sh
 # TAP version 13
 # 1..26
 # ok 1 ethtool_std_stats.eth-ctrl-MACControlFramesTransmitted
 # ok 2 ethtool_std_stats.eth-ctrl-MACControlFramesReceived
 # ok 3 ethtool_std_stats.eth-mac-FrameCheckSequenceErrors
 # ok 4 ethtool_std_stats.eth-mac-AlignmentErrors
 # ok 5 ethtool_std_stats.eth-mac-FramesLostDueToIntMACXmitError
 # ok 6 ethtool_std_stats.eth-mac-CarrierSenseErrors # SKIP
 # ok 7 ethtool_std_stats.eth-mac-FramesLostDueToIntMACRcvError
 # ok 8 ethtool_std_stats.eth-mac-InRangeLengthErrors # SKIP
 # ok 9 ethtool_std_stats.eth-mac-OutOfRangeLengthField # SKIP
 # ok 10 ethtool_std_stats.eth-mac-FrameTooLongErrors # SKIP
 # ok 11 ethtool_std_stats.eth-mac-FramesAbortedDueToXSColls # SKIP
 # ok 12 ethtool_std_stats.eth-mac-SingleCollisionFrames # SKIP
 # ok 13 ethtool_std_stats.eth-mac-MultipleCollisionFrames # SKIP
 # ok 14 ethtool_std_stats.eth-mac-FramesWithDeferredXmissions # SKIP
 # ok 15 ethtool_std_stats.eth-mac-LateCollisions # SKIP
 # ok 16 ethtool_std_stats.eth-mac-FramesWithExcessiveDeferral # SKIP
 # ok 17 ethtool_std_stats.eth-mac-BroadcastFramesXmittedOK
 # ok 18 ethtool_std_stats.eth-mac-OctetsTransmittedOK
 # ok 19 ethtool_std_stats.eth-mac-BroadcastFramesReceivedOK
 # ok 20 ethtool_std_stats.eth-mac-OctetsReceivedOK
 # ok 21 ethtool_std_stats.eth-mac-FramesTransmittedOK
 # ok 22 ethtool_std_stats.eth-mac-MulticastFramesXmittedOK
 # ok 23 ethtool_std_stats.eth-mac-FramesReceivedOK
 # ok 24 ethtool_std_stats.eth-mac-MulticastFramesReceivedOK
 # ok 25 ethtool_std_stats.pause-tx_pause_frames
 # ok 26 ethtool_std_stats.pause-rx_pause_frames
 # # 10 skipped test(s) detected.  Consider enabling relevant config options to improve coverage.
 # # Totals: pass:16 fail:0 xfail:0 xpass:0 skip:10 error:0
 ok 1 selftests: drivers/net/hw: ethtool_std_stats.sh

Please note that not all MACs are counting the software injected pause
frames as real Tx pause. For example, on a LS1028ARDB the selftest
output will reflect the fact that neither the ENETC MAC, nor the Felix
switch MAC are able to detect Tx pause frames injected by software.

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
 (...)
 # # software sent pause frames not detected
 # ok 25 ethtool_std_stats.pause-tx_pause_frames # XFAIL
 # ok 26 ethtool_std_stats.pause-rx_pause_frames

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- move to a the KTAP format output by using ktap_helpers.sh
- update commit message to reflect the current output
- use DRIVER_TEST_CONFORMANT
Changes in v3:
- none
Changes in v2:
- Use the new run_on helper
- No longer checking that each counter has a 1% tolerance against the
  target. The only upper limit is UINT32_MAX.
- Check that both the error counters and the collision related ones are
  zero since this is the most probable scenario (we don't expect errors
  with the traffic that we are sending).
- Removed any checks performed on the remot interface counters since
  that is being used only as a traffic generator.

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/ethtool_std_stats.sh       | 206 ++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 3c97dac9baaa..442dba3d6a03 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,6 +26,7 @@ TEST_PROGS = \
 	ethtool_extended_state.sh \
 	ethtool_mm.sh \
 	ethtool_rmon.sh \
+	ethtool_std_stats.sh \
 	gro_hw.py \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
new file mode 100755
index 000000000000..c085d2a4c989
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
@@ -0,0 +1,206 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#shellcheck disable=SC2034 # SC does not see the global variables
+#shellcheck disable=SC2317,SC2329 # unused functions
+
+ALL_TESTS="
+	test_eth_ctrl_stats
+	test_eth_mac_stats
+	test_pause_stats
+"
+: "${DRIVER_TEST_CONFORMANT:=yes}"
+STABLE_MAC_ADDRS=yes
+NUM_NETIFS=2
+lib_dir=$(dirname "$0")
+# shellcheck source=./../../../net/forwarding/lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
+# shellcheck source=./../../../kselftest/ktap_helpers.sh
+source "$lib_dir"/../../../kselftest/ktap_helpers.sh
+
+UINT32_MAX=$((2**32 - 1))
+SUBTESTS=0
+TEST_NAME=$(basename "$0" .sh)
+
+traffic_test()
+{
+	local iface=$1; shift
+	local neigh=$1; shift
+	local num_tx=$1; shift
+	local pkt_format="$1"; shift
+	local -a counters=("$@")
+	local int grp cnt target exact_check
+	local before after delta
+	local num_rx=$((num_tx * 2))
+	local xfail_message
+	local src="aggregate"
+	local i
+
+	for i in "${!counters[@]}"; do
+		read -r int grp cnt target exact_check xfail_message \
+			<<< "${counters[$i]}"
+
+		before[i]=$(ethtool_std_stats_get "$int" "$grp" "$cnt" "$src")
+	done
+
+	# shellcheck disable=SC2086 # needs split options
+	run_on "$iface" "$MZ" "$iface" -q -c "$num_tx" $pkt_format
+
+	# shellcheck disable=SC2086 # needs split options
+	run_on "$neigh" "$MZ" "$neigh" -q -c "$num_rx" $pkt_format
+
+	for i in "${!counters[@]}"; do
+		read -r int grp cnt target exact_check xfail_message \
+			<<< "${counters[$i]}"
+
+		after[i]=$(ethtool_std_stats_get "$int" "$grp" "$cnt" "$src")
+		if [[ "${after[$i]}" == "null" ]]; then
+			ktap_test_skip "$TEST_NAME.$grp-$cnt"
+			continue;
+		fi
+
+		delta=$((after[i] - before[i]))
+
+		if [ "$exact_check" -ne 0 ]; then
+			[ "$delta" -eq "$target" ]
+		else
+			[ "$delta" -ge "$target" ] && \
+			[ "$delta" -le "$UINT32_MAX" ]
+		fi
+		err="$?"
+
+		if [[ $err != 0  ]] && [[ -n $xfail_message ]]; then
+			ktap_print_msg "$xfail_message"
+			ktap_test_xfail "$TEST_NAME.$grp-$cnt"
+			continue;
+		fi
+
+		if [[ $err != 0 ]]; then
+			ktap_print_msg "$grp-$cnt is not valid on $int (expected $target, got $delta)"
+			ktap_test_fail "$TEST_NAME.$grp-$cnt"
+		else
+			ktap_test_pass "$TEST_NAME.$grp-$cnt"
+		fi
+	done
+}
+
+test_eth_ctrl_stats()
+{
+	local pkt_format="-a own -b bcast 88:08 -p 64"
+	local num_pkts=1000
+	local -a counters
+
+	counters=("$h1 eth-ctrl MACControlFramesTransmitted $num_pkts 0")
+	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-ctrl MACControlFramesReceived $num_pkts 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+}
+SUBTESTS=$((SUBTESTS + 2))
+
+test_eth_mac_stats()
+{
+	local pkt_size=100
+	local pkt_size_fcs=$((pkt_size + 4))
+	local bcast_pkt_format="-a own -b bcast -p $pkt_size"
+	local mcast_pkt_format="-a own -b 01:00:5E:00:00:01 -p $pkt_size"
+	local num_pkts=2000
+	local octets=$((pkt_size_fcs * num_pkts))
+	local -a counters error_cnt collision_cnt
+
+	# Error counters should be exactly zero
+	counters=("$h1 eth-mac FrameCheckSequenceErrors 0 1"
+		  "$h1 eth-mac AlignmentErrors 0 1"
+		  "$h1 eth-mac FramesLostDueToIntMACXmitError 0 1"
+		  "$h1 eth-mac CarrierSenseErrors 0 1"
+		  "$h1 eth-mac FramesLostDueToIntMACRcvError 0 1"
+		  "$h1 eth-mac InRangeLengthErrors 0 1"
+		  "$h1 eth-mac OutOfRangeLengthField 0 1"
+		  "$h1 eth-mac FrameTooLongErrors 0 1"
+		  "$h1 eth-mac FramesAbortedDueToXSColls 0 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	# Collision related counters should also be zero
+	counters=("$h1 eth-mac SingleCollisionFrames 0 1"
+		  "$h1 eth-mac MultipleCollisionFrames 0 1"
+		  "$h1 eth-mac FramesWithDeferredXmissions 0 1"
+		  "$h1 eth-mac LateCollisions 0 1"
+		  "$h1 eth-mac FramesWithExcessiveDeferral 0 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac BroadcastFramesXmittedOK $num_pkts 0"
+		  "$h1 eth-mac OctetsTransmittedOK $octets 0")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac BroadcastFramesReceivedOK $num_pkts 0"
+		  "$h1 eth-mac OctetsReceivedOK $octets 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac FramesTransmittedOK $num_pkts 0"
+		  "$h1 eth-mac MulticastFramesXmittedOK $num_pkts 0")
+	traffic_test "$h1" "$h2" "$num_pkts" "$mcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac FramesReceivedOK $num_pkts 0"
+		  "$h1 eth-mac MulticastFramesReceivedOK $num_pkts 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$mcast_pkt_format" \
+		"${counters[@]}"
+}
+SUBTESTS=$((SUBTESTS + 22))
+
+test_pause_stats()
+{
+	local pkt_format="-a own -b 01:80:c2:00:00:01 88:08:00:01:00:01"
+	local xfail_message="software sent pause frames not detected"
+	local num_pkts=2000
+	local -a counters
+	local int
+	local i
+
+	# Check that there is pause frame support
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		int="${NETIFS[p$i]}"
+		if ! run_on "$int" ethtool -I --json -a "$int" > /dev/null 2>&1; then
+			ktap_test_skip "$TEST_NAME.tx_pause_frames"
+			ktap_test_skip "$TEST_NAME.rx_pause_frames"
+			return
+		fi
+	done
+
+	counters=("$h1 pause tx_pause_frames $num_pkts 0 $xfail_message")
+	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 pause rx_pause_frames $num_pkts 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+}
+SUBTESTS=$((SUBTESTS + 2))
+
+setup_prepare()
+{
+	local iface
+
+	h1=${NETIFS[p1]}
+	h2=${NETIFS[p2]}
+
+	h2_mac=$(mac_get "$h2")
+}
+
+ktap_print_header
+ktap_set_plan $SUBTESTS
+
+check_ethtool_counter_group_support
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+ktap_finished
-- 
2.25.1


