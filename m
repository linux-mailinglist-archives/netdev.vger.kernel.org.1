Return-Path: <netdev+bounces-175707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF38A6733E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B493AFC90
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CF020B1E6;
	Tue, 18 Mar 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gKlwgnKq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2FB207E12
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299057; cv=fail; b=PrAH2zFfFCV8vEr2iv+eMY4LyDzMkXhnLGmj+FaB2kpJspotwlE/RQjfBWm+llNPBWOEo5YMyf2LpQLtTN8XCjpRsIRDFPAug2yreKjgwGS7zbsbBIjvLx3g4A6dPmoGvQY3e61MxcyW0wF+ieIeiJeoHrRr3PLE/Ixh948jPUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299057; c=relaxed/simple;
	bh=+K8p6K8wOMK5USBcoKusru4RyEO+VLexMAL/AcobePE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bYB/xZWczZBQee8rAqsti4snx+s7JDxVaiNaE18DAB6klx4RswPgJa+zoBHNMU4nAGGZB1RlOfIlB7Hz40PSs/Wu5ffTFzzLyuzz0gsOc0RbCFHmad+acRRvQRD18Ozz5aP5Xx+4G3OlhkCAbZ2jgP2cya1I4FKeXe9h0vkVahw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gKlwgnKq; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmTQMNhU4x1wSfLljBkARWM+R2mBhVeD+PAHLvnCThO9vMEdtkMj0+Vtc9T0ZfoR6Anf7MxzkDqH3HUItkmpoIFMN0RLvWPzs7gsb+Mm3DWnJ7nfPXbQF4dj6XG0TTWpAADgfS3czKP0BxPYrwtz2AebVqXgAejeNAlpzfThOgjNa0SpY4RdI6iGkgbnps9bIs6MJMAvAsz/J3No8aXl4aCL6OMiKff80pXPMWKQZjsj/7OkQU+Q4FLqAzkue4skIqKij9v1u4Ov9FYO9J5k/8PtvYHQuodE9LuRLKbJoIPUFPKsMwkHAquFDZpNc9F+pO7xMB/yWEWiCfI2d/GRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug0bon0VlF1ZVMRClbxnVXNL8GMFJLGhOvnY+Jx3rvo=;
 b=BVfVBd07tivS2rN5kXw1wEluJaohRVpjlanv+QariSospEqyhs5t1onLFSOstvg7+NIhyDvVJIP8thIRWNcr9B3VuC8y4qJ1qgD4ZBEB5NFeD3e05ODy4sDwwLW0kh6Ta1snpcYJXaj3RHtUh6xe99vfDfkWzdB4oHk2PaOWV4s9u4M+4hkfDCUFuEusNDg8OxFuXYX5FMrcZU2a11sW4sjeyN4oQ9Glg0OGb5IZaXMqy5IfsQ283+s+pUcXpjBO86IZgmBlOl4L79DcrClFd1lsOzkLSqewOyxwcA50oYIJ9FBmJXx51EHNpK9rObEDECPL4vg8EyragcLcMStGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug0bon0VlF1ZVMRClbxnVXNL8GMFJLGhOvnY+Jx3rvo=;
 b=gKlwgnKqd7vxCj8IehSFeWaXubXD+k1QAZYx1vcZ1FOnkjeGNeTtJ/5eYQI/NQ1Hx2fOyLKXz1D0NYH2Z677CthtmFFaIajPVtYJm2EXBiNfIcsivRiZnpiYg0C9CO7LsACga62FE7PF8/IA6svY8CF2wVd/ojpIAj39dGiTHxBstBYt5qDq4CI8qtT2MP+EsTdOzO3h6MMm4JSUAujHOVVQ4NkgRFBJ/faFYeEtQaBytYLMAbgAd9SmuGPSpSTlNcuWiHqSnQ9Fq4GPGkadpUJ7TB/xUbHmYYzZELSHrc9emAA1kRbVp5bteumhxwBesHp3t2IS31Fdqsaq0ilnpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9713.eurprd04.prod.outlook.com (2603:10a6:20b:4f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:57:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:57:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 0/3] sja1105 driver fixes
Date: Tue, 18 Mar 2025 13:57:13 +0200
Message-Id: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: da7757bf-d2a7-4e13-8a3b-08dd66140e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fzbDU1nojouVsWmLzB+AWAhYl/cCyqRMcUiDF0YW38daRZKQeKLQSa9dS2Qv?=
 =?us-ascii?Q?iIqJYxix+cPUpQ2c1n2rZlt1GUQJ3SHZkSmzEMnTbsUv1mwHo6Ndu+YGv7Sc?=
 =?us-ascii?Q?z7P9eS3DCfq6wFvNdUDJukYQjGPe2uhjnH5XDAyNoDq72R+wyJ2thmDVd7CW?=
 =?us-ascii?Q?4IY80CnzB5M2rU3y/rFPT8oQvEP6eJEy0wxotEK4eJEVmyFwhbj0y8CZ6hLB?=
 =?us-ascii?Q?RMXHDb5yXYIBb+VfES3a3nMTMTKaKPv3+ThOchIw4nB+OpKLG43LYFwiRn8D?=
 =?us-ascii?Q?PrnpbNThdJykESSvkM5VJgOySSzFV1mNCGACjhuHB/RLWYJaclSalpGx6h+5?=
 =?us-ascii?Q?AS8ofr7Owb/qStIpTWYyX303IvjazoWuQ/512liBy32SbE0Le/6jNmrAOCBp?=
 =?us-ascii?Q?YW+F9pkrEjVBELJKQKqUy6Csgy9tUCvfR8AweBmFpZIStladcGsHszaA2yc8?=
 =?us-ascii?Q?UQhfMKsV/XdW4sBbZw8HuCF9BTPBdteXCFoBY/neKWwwwq/yW9pgXQiS2GsJ?=
 =?us-ascii?Q?bz3Z0mXRweJ9FygC28g0zDIF+HPBoSrKUnUfVhrH9RH79J5H5uorlJOIbQR2?=
 =?us-ascii?Q?kLB9N0tfCyW6Bm3RFDeIWs2hNkpk1QiP2IByXNxO7eUOwVr1ubKtTnJn3W/g?=
 =?us-ascii?Q?y7ygkDXxc+528MpdwmwELGOUZCJlwj0pUQzquyeANhjk5fKVuJdNbipSrQf/?=
 =?us-ascii?Q?wyyj056RNXXXbIpVw4iYbPBmnpcTngM7yF8OC/SMRNdRrU2ChRmN/lLT261B?=
 =?us-ascii?Q?LHQSKhpS5HJ64XUxHzKXVrJJc1+Wf0v0UPn1KvcDPadN6sxfarsqs8OOzDf4?=
 =?us-ascii?Q?YWIn4JqgcuhSGXzD0xNRA2FLsXT5Cc/ZJpdpvMlFNuTV09Vddjroqn0io6E8?=
 =?us-ascii?Q?0xR8uf/YdpKzDfE6+4o+rvTcEH9cWaqpA8Nqq6hJWKRM5rzWWRZ809faaLgy?=
 =?us-ascii?Q?W8RngChDsG/g5jmMsHA2qJXZKfL0XrbXKi+w1n4CqZ3N0ySSe+OUKv4u1N4/?=
 =?us-ascii?Q?KVPGpchrIBSSWBVQ3Q/vifcGoGepgk2CV1oOhq69KBfHEQW76jjJGG98ae69?=
 =?us-ascii?Q?vt44KWfmvfCOhv623Y7IpfDL9p3J46rZkyKkQazJvfT7wt8svWnGsgBkUWXB?=
 =?us-ascii?Q?rVoYS8+cdxlAmjmgmpErzh6Dcf0zcjke963xWx33wmYbZzx4kMalneZ727k4?=
 =?us-ascii?Q?E+hRIOCymhx80S/re1B6daAY0ilsIm1nvmesFgbPXL5IpmcLbBy0hyqYTUhh?=
 =?us-ascii?Q?AM4c1YE3M3LI3l/uJhXjSMI49qjB6yKfUlb7wPpKW0uqw5zAF1d5TqjQUrLL?=
 =?us-ascii?Q?bok7BEmhOTSTCqerK9hC3bkNiUAh5DkDikvqxPxC41quyvW8Zfte5kV0nnjO?=
 =?us-ascii?Q?et9kUr/Zi2DXXaIzxeC1WTrwXoVgJXR+rkkc/KdcBNhQ/OkVWHTev+42gAyt?=
 =?us-ascii?Q?Ind5ffD+0hjmfXHV6Dzj3l9AP+Bb53ZL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OsDz2ASjUA8tcizSXFn79Y+E3F6hRgLN3CzooQNUbxHEfTr2pMvql2yhZ28W?=
 =?us-ascii?Q?EjtgAvnwLjwMllXub/h5Gyv9dNoNEEdAB67xfJKE8hQyPPIErEoBMHQ3Xhj7?=
 =?us-ascii?Q?hCVRrxG1lmlI2TRxNNQqadh2PWjoZxvFG3Y9gauf18FSd4Az7Zo+m/Ltl5LQ?=
 =?us-ascii?Q?Vg031S76eK0CpbLUtcBksdU1BGkw85DJkO62IWX4J0g/Ca59OV/7cSYV6mim?=
 =?us-ascii?Q?FZM5Ddu+yzRTrKH7i09uAX7vZF9hWLpwXeFXk2t2m1b+kn2hjy96fVETL48Y?=
 =?us-ascii?Q?DzKo+TFPnPVbMWaJL/GIgufBWgOq9CY4fle54Ci2pEfH0WZj3c1G4wCswLTY?=
 =?us-ascii?Q?KC9xRjE67rHqJVy/llS3LbmiXGJNZX8mYtzcEpO0gUChBt2/ccRByzrSQ6jL?=
 =?us-ascii?Q?PtIAgn3BxzwusplyIHIp4SX4knArgPUZgJI58QB9pGF1LZNq/92MXyBdRDFf?=
 =?us-ascii?Q?N3taDc4NKG/363pIj8ebQFP5RgmK79Op//eIK8bQwXHUqDnbY7n3gVmp49tT?=
 =?us-ascii?Q?zEyOtVcQeSadbUeRs588konSU9xFfO1vi4ffcuA123tPpqmDcYAdPZ+sYzo8?=
 =?us-ascii?Q?kfrUXap1EsSb3Q11gM346GPL7gGXKwvJEpjSkbekYtlKLWnebm42m6jen8+E?=
 =?us-ascii?Q?mwR3eIJS4ofiBCcwJGwgI4wQCU+/z5tfupEHT5gsyHGFJasyfK86QPeaIsWi?=
 =?us-ascii?Q?rRU7/eaDrr5JC4Bev618+1tNcAnhVLJOoxdoNhoe/WpXVvHK6ZJ+ZF0Rvw7x?=
 =?us-ascii?Q?uBPPCFxbfXQvmkG7tB/1+or8Rp8sZmbuozzCJePvZ6gupvDiLLi6VeHGV8tM?=
 =?us-ascii?Q?E8e/KfUYK233UUSfIfMEA7UMbtTzC/Xrum3ImS1fPiQfvqUGI1bnXYp5VEoY?=
 =?us-ascii?Q?sIOkOW5e1Q+Hb3cx1E+IVnGn7qw0GgA7eCtJd/v07soJG0FW1yqY2oFLEEBG?=
 =?us-ascii?Q?SC4yLXJhwPIgM4DT+AzhHRtCYNUpBG9uJdxJwA0SZgmFMcLD9zmmyM70yHF9?=
 =?us-ascii?Q?+UPgr22Da1qTJwKK8lsUtZTrNJrY2+rADxxPN9Vdl2a2GzxHzERZN92aUTE2?=
 =?us-ascii?Q?HVUbmVbmPHf52U9GlH1GWZsh6RcCr1kf5C9t6GhZnIUfHRxmAUO9Y6vhuyV0?=
 =?us-ascii?Q?PAuTvqn2wRA1ww6nYqB656DdJvALw0RwRi8xib6HF02oAOZrDdk8BN5smovS?=
 =?us-ascii?Q?ISRjjpQA/KPJcoIRPIN6CAt/s+g5++AyUKkWQfsQ/wwjIfiPp3GWD9i+cnlv?=
 =?us-ascii?Q?2tIBB8Tq8jM0Cmzn8/s9jBGiTCWISZ4lnhyxs2VK1Gsi0TRDjZ4mv2ZEEmE/?=
 =?us-ascii?Q?WzE90cI3btF/4fjd23CATpqVcyUQpAlyzcLPp2vJnllTTSFI5SmeLOT8gZNL?=
 =?us-ascii?Q?3/r0ntIrbFMPEyny9kKGwkrolsKQcsVa+8/TT4eZqViw8DIOoZB4GHlq0Ad+?=
 =?us-ascii?Q?0S+ukGipaGGwRRLqs4RdrP3QoNhjYw/327j2Psl8vx6wu0XeQK8gnjjdP57K?=
 =?us-ascii?Q?TGw+8hhaI0aWyFIUkzkdHfnUaNH3/OTbaCKh6JgxQIP5981ezuQApeTw/K1v?=
 =?us-ascii?Q?5agvTrkt1zBvxwx/HdBIjtdVtt3XZ0Qk77/kWDen?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7757bf-d2a7-4e13-8a3b-08dd66140e2a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 11:57:28.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWpOGtcHmiTmweW0zvRwXbycDzAlScton+kR22Isssk7mnbqWgOliBDKfio8UwT390mG37cYsCwdXeWCdSYjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9713

Hello,

This is a collection of 3 fixes for the sja1105 DSA driver:
- 1/3: "ethtool -S" shows a bogus counter with no name, and doesn't show
  a valid counter because of it (either "n_not_reach" or "n_rx_bcast").
- 2/3: RX timestamping filters other than L2 PTP event messages don't work,
  but are not rejected, either.
- 3/3: there is a KASAN out-of-bounds warning in sja1105_table_delete_entry()

Vladimir Oltean (3):
  net: dsa: sja1105: fix displaced ethtool statistics counters
  net: dsa: sja1105: reject other RX filters than
    HWTSTAMP_FILTER_PTP_V2_L2_EVENT
  net: dsa: sja1105: fix kasan out-of-bounds warning in
    sja1105_table_delete_entry()

 drivers/net/dsa/sja1105/sja1105_ethtool.c     |  9 ++++++++-
 drivers/net/dsa/sja1105/sja1105_ptp.c         | 20 ++++++++++++++-----
 .../net/dsa/sja1105/sja1105_static_config.c   |  6 ++++--
 3 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.34.1


