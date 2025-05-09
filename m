Return-Path: <netdev+bounces-189198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECABAB1256
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A171B3A429C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235AB22CBFA;
	Fri,  9 May 2025 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PHUZZrIn"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9151223DE4;
	Fri,  9 May 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746790714; cv=fail; b=Y/rxt0N/wUvZqMRKKuPVSNMy1TXrcEpOu5+PD8a8Zzb/IpX/FTvFsHDn1DV2sb0cheoU+Tv4wMt0YXwk6hftRYdAMoHfRBcfKPf9u8qjON3twxvKWY7OPqEub+Gmzo0lBq2SOrBQCMuir0fMXG5KKlS1VjB7J+6AzhEZlwHZ6Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746790714; c=relaxed/simple;
	bh=y5RStU/6AxfG9AXgcWC9cbjq72C6v7SgdKHXzqRdCeM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LyWj5T6CxfjD5nih/Tgao2MxKWehW4AjxKSvMTwhx0QEIv1LGvmMFM1oay8eA9pIOuP4dGXgHQrfjashuyqJydxNqnmveuT6CL7v29P5CoEgIyID/jDUA01F89lB5kCGqEipZ1o0S57FDVbV6eJGMxUhC4FQTMplrj4fotUgjz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PHUZZrIn; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5QVfUdzUdsVZg7kyPeTqokJyBJPUvWH1sSA4KzzqR3TkYJYfRwdcKRmLu7MqW4AztRiPV4el6TEKRoWAtX82o9D6TtK9JDPgPApbPio79bUiv6GsSe0L+XScBiehCRRnA4qnnhsX5gP/VG3XIRJgEO70TAkTMab+fPBj93Id8Uv8BMucdHWj8lLSkE7htdjygrpx1Sr0379WsZVapdzaTeK0nMbYzUlOhOUEixZsUFwF8MaQlnkw8AEZu7tyXi8h4yrjMu6sWTsq+eXxa5oBwuycEbeiPkg4WBZgyeASsetw+TNbCm7iNHeKccNIc8wpJ78v6gbC0XnC9fQ7fS67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h16QuoRQT1zQVBYWxJfuNQ7rBq63G3z9C9nAuuvVFDA=;
 b=qaLTaX1cKvogj3xMOv5K1k7bQH5AHib9NUYNnfcWq+ah2kbv5ndg9yGdD9BCAV97hBPXZB6c3xCBNsAmboWJRTd/AejI9rTaoN4ohY9YAnJ7ArTzUi4Gu/vMCzYQCVE2ZGssK9gyh0TOZnml+P155/9aidq05et7CZvx8OtGh25doel1eTiVWqeZQtwNQ7bPr0RJIU+wJJGNi07+I7+1iYk0hts3zHjWZUtMMNjm+8KfHpX1/jGdujBF9N+pl/+j+oqg80BqI6yP/Psp8yG4nYz+SolARrlOV+dfA+C5fOWZW+hsys1u8Wa4LUktL8Q+rrMalmqB74FGkPiBxF/3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h16QuoRQT1zQVBYWxJfuNQ7rBq63G3z9C9nAuuvVFDA=;
 b=PHUZZrInlRKjR+dfkCVt/OGit64aRRuRY/DICJyE2H3uzyIJzOsRct9QSQDulG9K0EyuybEeRLm+n9PIZ0rL2H+E5nZ5SboMsXPfw94i5ZQooF6QP/R1eG05Qqa9YAhsdInMks1C04wlOdVs0m2CkHJl7VryyszbSSPOZJZL7euNmkKh760/kV34cMJstvaKILw11kIoStx145xeEa+AVfg42xzyOildSUchBechqYc8LInJQQ/8DKXov3Bvfe770eK7vde6Q9LP4nyXAK5pv7svUB5u5lunh3WnPIFsd1DfxUzhj65voWayacpgHtx7hfKJZhmTWU+xyzFFq6pXhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAWPR04MB9807.eurprd04.prod.outlook.com (2603:10a6:102:384::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 11:38:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 11:38:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING
Date: Fri,  9 May 2025 14:38:16 +0300
Message-ID: <20250509113816.2221992-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0104.eurprd09.prod.outlook.com
 (2603:10a6:803:78::27) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAWPR04MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: f740dcad-a15a-4ae6-e5c3-08dd8eee049a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWXPMu0SYbQzt//LnKVSgSBM3dF3ECU3Rol72SCfH2YHgQQWMPEYd5PbwkTe?=
 =?us-ascii?Q?pQLrKdd/nsY9dCFeVoP2Ckd+dCXHD0Or6C7SWgFMCQH8fu9zDrcD+RdgruoH?=
 =?us-ascii?Q?1yiLVoYbCQEWoUHxHdNfqIjqkNLRKm/FiZLHTEQo4yLKDvp4ifldjUT5R7WO?=
 =?us-ascii?Q?zqM0i0PmXQtQTPDHI13ZghcmIh3HITaQ13oIbdPB6M7+voH22M66qK3rlUZW?=
 =?us-ascii?Q?mfLSBJPCOk2xjDgTSSOtHkw8SVC7DxFLpWx9+ntFoNmj7Ah3fgXfMEU7G5hD?=
 =?us-ascii?Q?8aXDNh0vYE6T9OuVNwn5LfSqgDvm2jGV0IjDMvQfkisVVOLPQod1k2wRTZ52?=
 =?us-ascii?Q?hHndilAwBQnddiKFTezEqpZZbb58u4sSNZ//+VOP5heHLHc05gz1H5uj/LWK?=
 =?us-ascii?Q?l3QDLdK8EcdvwDQpy0Cds4kZ3ewY26a+CG3D6pyyEFZXHL2XDewzXERK9n2d?=
 =?us-ascii?Q?IJjxhlcZ2glz9UxaOGd6E0ZHIpOZEKsR85AstOkUuM8phsl7kJji6D8yACmQ?=
 =?us-ascii?Q?FMPfSyP9h1wYGHduTybqQZBzGBJrBAzobYfno4vfQSouJCGsBUt5T4/LlAec?=
 =?us-ascii?Q?vfNflncGK4BdpR19903M4vplkOzq2ICNt+WV0FJqmUzWCqKkBsXm8sHAFl60?=
 =?us-ascii?Q?MVlksTco03zE5mTAsB15J3uv5BwZZk0wwAEN2H+xH0SkRVhgpAE9GYgMp9d6?=
 =?us-ascii?Q?59Tbk0B4Ad2UG7KNT9h4CUZXjkceWQevhdklnuGBhWFbt9VUuHSZ+iA5U/nz?=
 =?us-ascii?Q?LMsED6qE9bcUormge8MvV5ltuI4s3vuAjeTz0whdrj3+ofxNkayqtcSlpgK6?=
 =?us-ascii?Q?0daQimfmDVQmTxbesIpRWXKtmQ2wh45TudjSvCabXw+d+S/Z6vbw2V/ctC0j?=
 =?us-ascii?Q?t5V92dmxtP40e470hLlCNDyFCKklQMJP93VV0kBCG4aG+9YoF++fz7Ra2ZM5?=
 =?us-ascii?Q?0e4nCSA/CsWMwrnwleT4jiQPlgZ8CKGwW+Mn5rH8cHuUsJHwPEANM0U9LdSr?=
 =?us-ascii?Q?pcbZitAgSAWS9ZtjeteDSGWg9YDDrE0oQgL2YkL4ZDMmL3GE7rORP5vKW1Am?=
 =?us-ascii?Q?fviI3MloBUnPyfl/DUYp8POpd1aC1XF2FZaanvfmN+4HhqUsnr5foxHRmxfF?=
 =?us-ascii?Q?yXpBTYMGpXVQSyZFol517DD9ganuBvw4dKnedEwqgG0uyLhaXIOtmS3zE2ER?=
 =?us-ascii?Q?qq7HoGvim1l9cT6LaEZnZhhifDbF/gq0noxuUmG69tPPS5+e+XPUDWzvcMyF?=
 =?us-ascii?Q?IqxfusbgxkfU5JwZ5RXDvPBZzOY783PjcsZ3KnCc//0Th0PXvDjikQ+9VqdS?=
 =?us-ascii?Q?90e6k5rZyGPRN1nUZBlfgGnu1wnBpw5EvzQO94GThR4DSyRl9ck8SXdHK16d?=
 =?us-ascii?Q?d5bNGqBDxsnZHd3hYgK+HG/FGLc09y5hZiudZfN5p5Pbb1InSQR7oaHycCub?=
 =?us-ascii?Q?qP6bofHNoEMpNrTpiw8rblI3JVTMov0KoFlSxhKORBDj3/flM6IUuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YdmXmHcT4aAe1Lz4Fj/lthpzZFxs+bSTjvc7+NnswQREUZqZKx6LBqL+wnbk?=
 =?us-ascii?Q?hH4c20FTCABXjFcm4nFi2RystRTmE+flyRw7Xb8Tk7lisb4ADSLNO1hl86gY?=
 =?us-ascii?Q?E6LKUgUiUiwDEw1mgqKeR/IJJyI/TS8TlgkDygWzlpDy7Wb+q6XKHTfo96Mn?=
 =?us-ascii?Q?q9js8hkb66eEFn98kOwHgIpy+hnSM3qOylEh6kFtiNX2v9luQxwmcknvtr8u?=
 =?us-ascii?Q?saTiOVSN8Fc3xbN1SdScTut14Bro7BrbAJQ7c75ZeQTtuZ/L8Akp8Rnna8js?=
 =?us-ascii?Q?52XiMBNkRFKOf60XdIdaME3kW1kZovzdvipRMtwE6rtES8GzVC0geG2NeUg0?=
 =?us-ascii?Q?YUz0U0qlQH1ay2fZAnhiqwCZDGFN5kE+BrCdFZ6e6Hns8SfFJdtTEjAD1dG4?=
 =?us-ascii?Q?fjQuD2ykOsfmyeiWKvbcc0eMx8Zr7nQspxtZSUd7+wD+zDn2VlhOJRLjeHTF?=
 =?us-ascii?Q?T8OjJWwEDO8qw/7YPGdqRwSzi/jWJtEp2ggaWEjGZP5gOzOCyhlvmzruzg8G?=
 =?us-ascii?Q?sOKkfomTMOOh+Rnjm4g2HsShBu+mWJij+9uvKMauZQgDziFui8nf7wRpv4bE?=
 =?us-ascii?Q?ODmfNcf+YJRLuNBJA3DwyGtGWdPJpGQSZMJVNj1M/bDIOIQxzBYk4Z7ya76j?=
 =?us-ascii?Q?mI6Pb8NA19QDFyFOS4iJC1gFGZ8fBGNbhvkabYfp6NLt8+iZ0DQrpbLEwgt5?=
 =?us-ascii?Q?ZmoeUTtLYU6/QHKIESubZMfrZ27OA6fGJisDrn/7bdDbAHxRTNmjOuExOXm6?=
 =?us-ascii?Q?6HD/E/X3QQRzbLSyXZuAMN/LPC/sBLZFNxq4CBcHV54j6imE/299xiv0/fDD?=
 =?us-ascii?Q?l9XNf+SW5LKGfhx4ox2VHeERX3cfXqPsaqm6n50Nu81FobElwD53350ZXlH5?=
 =?us-ascii?Q?UTuBkEAAG4GCIplnR/MBzuiZiiCmtdsjEcr1nLM3CFh88SGnsS9wvmJEb1HX?=
 =?us-ascii?Q?eEAfrtdkTytJqS7OBbQkiFjG/q6uGRsV+zORuDuwGWE5TBaNGZf/PK7H77YP?=
 =?us-ascii?Q?Vil2LrwUtTM1Rs5qWV2osUT2cF/Rvw+pgqIz5mi63JVVDEAiNvFWYHMCNtRZ?=
 =?us-ascii?Q?U3f95bd0dVCM/Jp9ax8ZXTWGMaEwxe71i2HIaiRAFaueZScTCI/TzH0CUSVw?=
 =?us-ascii?Q?FNQYOQ0MroXbWKAi3grAcC6EXGdHvMzjZNFJJ73UDGp0tCWzV5r3GHwY8Rjq?=
 =?us-ascii?Q?qns7TV82CDQ7txTvoHwrhtaLDcewXyBJP7OISbTkto2fVexJqbUIOX1i2SYA?=
 =?us-ascii?Q?LNAtRSQyZ+EEhRQc6CKeYDXxw9xyVKPcYDiwL7ixqyn0f4XeFFoMKuxQFD0i?=
 =?us-ascii?Q?XxuEOvxGrfrP6xi78VAVyz2Vr+pKZcYg/CFqvB7155XGUfkGWBaed+ndt7B9?=
 =?us-ascii?Q?fkOeiasGRqsyHZb7nT2YrRgIflWZIqrFCyUoC5OICuDKTAuXoPHf1Hc7RI4l?=
 =?us-ascii?Q?fW+HluEEvEdS62GaQu5lv+w4WNy0esCGJz1imW5zdtanqECUUHzoB2nixjqz?=
 =?us-ascii?Q?b1xyUkYq7G60F7/s5qkPQrItgLu657XeD7BdEkRVwFDYUcmknZZLx96Z6LPD?=
 =?us-ascii?Q?5ULZOeIjuy5v2rIRRQ9KkqclERk69iklipldIXDpV7Z75t6dmN3shJPx3KtO?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f740dcad-a15a-4ae6-e5c3-08dd8eee049a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:38:28.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1h62T0Fx/RLALm9NkJnXPRnDPIC6nlV/kCv5xwFaZFYIx3qJ/BP9wZK6h2q86s3gk8u9eaNO+yBt/vjw+A0+KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9807

It has been reported that when under a bridge with stp_state=1, the logs
get spammed with this message:

[  251.734607] fsl_dpaa2_eth dpni.5 eth0: Couldn't decode source port

Further debugging shows the following info associated with packets:
source_port=-1, switch_id=-1, vid=-1, vbid=1

In other words, they are data plane packets which are supposed to be
decoded by dsa_tag_8021q_find_port_by_vbid(), but the latter (correctly)
refuses to do so, because no switch port is currently in
BR_STATE_LEARNING or BR_STATE_FORWARDING - so the packet is effectively
unexpected.

The error goes away after the port progresses to BR_STATE_LEARNING in 15
seconds (the default forward_time of the bridge), because then,
dsa_tag_8021q_find_port_by_vbid() can correctly associate the data plane
packets with a plausible bridge port in a plausible STP state.

Re-reading IEEE 802.1D-1990, I see the following:

"4.4.2 Learning: (...) The Forwarding Process shall discard received
frames."

IEEE 802.1D-2004 further clarifies:

"DISABLED, BLOCKING, LISTENING, and BROKEN all correspond to the
DISCARDING port state. While those dot1dStpPortStates serve to
distinguish reasons for discarding frames, the operation of the
Forwarding and Learning processes is the same for all of them. (...)
LISTENING represents a port that the spanning tree algorithm has
selected to be part of the active topology (computing a Root Port or
Designated Port role) but is temporarily discarding frames to guard
against loops or incorrect learning."

Well, this is not what the driver does - instead it sets
mac[port].ingress = true.

To get rid of the log spam, prevent unexpected data plane packets to
be received by software by discarding them on ingress in the LISTENING
state.

In terms of blame attribution: the prints only date back to commit
d7f9787a763f ("net: dsa: tag_8021q: add support for imprecise RX based
on the VBID"). However, the settings would permit a LISTENING port to
forward to a FORWARDING port, and the standard suggests that's not OK.

Fixes: 640f763f98c2 ("net: dsa: sja1105: Add support for Spanning Tree Protocol")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index f8454f3b6f9c..f674c400f05b 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2081,6 +2081,7 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 	switch (state) {
 	case BR_STATE_DISABLED:
 	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
 		/* From UM10944 description of DRPDTAG (why put this there?):
 		 * "Management traffic flows to the port regardless of the state
 		 * of the INGRESS flag". So BPDUs are still be allowed to pass.
@@ -2090,11 +2091,6 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 		mac[port].egress    = false;
 		mac[port].dyn_learn = false;
 		break;
-	case BR_STATE_LISTENING:
-		mac[port].ingress   = true;
-		mac[port].egress    = false;
-		mac[port].dyn_learn = false;
-		break;
 	case BR_STATE_LEARNING:
 		mac[port].ingress   = true;
 		mac[port].egress    = false;
-- 
2.43.0


