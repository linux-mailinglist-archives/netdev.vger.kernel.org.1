Return-Path: <netdev+bounces-55422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2356480AD26
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0371F20FDA
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83BB4E1A2;
	Fri,  8 Dec 2023 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SutLwpWN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E61E98
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:36:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clwyjNpgT/g3zgbuO+uflJ7LEvZw2yQOtYL0k2wm9+2yNO8f+rK/AR+F/tO1KVp3KhPB24JdTb/Ma3lIh//ihIIoS4yLTwgyMlP5UX05JFcYMUbxKJbAFxyDiz7Pvax288d7ZfTpRNdNpqlJjgd528gGMHiOvEv5ECmMQ+MnBKijBETS7gKqLFgU6I8i/ZZrCFZjceRBjx/0vOMEdf/9y0o2Vxj3ET8gbRX/ZJ40d6oNEl4xiRCRTblfcK2j51so85iLfKLcVPrdBszPAKG6SDdEQOhTL4RLRY27Aj6+kXbpjC1W2alfzm/sBex3WdazYGCaxV5LPZUZXgNksIuTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeMfweb7WsKxQY2f0mBIMpsLkHTY2DWE7CSHSWe053s=;
 b=apz4QfqhbnSUMzrl8ekBqoe/3jev6c5E3fiMzfbAUbdQ05q59VYH8RVi6ubPBP2JuWMZl+UYzaqyDkV+iUrhA3SFSUzUP0gBkLvq8x+YsuJqnlvtRxn2TyUCJY4drqza7wU+FhLMVofmUcEyfcleDLRN55RjgxXHEOJN60Z3KEsvzxEg73bVRvfmxe5b9EJfcZdpeaBnuqlrO0HpXYuW3qCjILp9V8/f57E+pMMDWh1l1WxuNfhtdh7KysC/uJzwU9/xuBNdvGIv9IRwPtcUeTASrhF1wFf43fEO0YyKqkeAzwMIQU6KiTSyePYrWboBwpUyHGJoWi4I0Le1oIfZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeMfweb7WsKxQY2f0mBIMpsLkHTY2DWE7CSHSWe053s=;
 b=SutLwpWNKcJZJuNuY5q8FgtudU3VVZFGgHfx7ARwFqkdH3pTanfbQbz22y7MoJUtGF8mMKZ57hvrY2ARukQ1MOVrmwf2ilDbW9mTog9FPT6uMMaQpdJhK5zplX2nTU/YgAXdY7uA5gdqoMV0vfTb23bknpFBml4QL6ljO41iWmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 19:36:51 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 19:36:51 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Madhuri Sripada <madhuri.sripada@microchip.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net 0/4] Add some history to the DSA documentation
Date: Fri,  8 Dec 2023 21:35:14 +0200
Message-Id: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: c7387752-e519-427a-0533-08dbf8250698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KOUoHFlm0L1Ni2A8K0gRCZeyDKZXSI9Bjic/y952mNaY53cWh4UNIZdstfj79Jg9eaEBqz5DC8/ny9a3dvJvN0GOlYUCw76/uQIuw5iuubOVnaZ8Rj3OHNpFNNS9mZZFjfhwyyOP1ARm1Z1flw558E1jGv83hxJ8P6DKTcIlPIZedZnFxF9DgYTH/Ns1EnnBUB+o8DSwdBJIxfINDiMaSSPNiHJctbstdqEababFYsvibEqfCEJVzo+n0JEORPsp9O5YQ6aANMqJBvJw3hGn2ypMGAnjcg+BnPTUiJOldNBkNXQjlY5SOXpbY9+5a/PMHHdBF9XwjRYpjtgy0J9wgAaoJKwrhs6ESHG8C0Mbw+KFDvQfmxY/eYicZdbcVy6BS0xijkI9bKDSpabriyoaM25nfsK5aZmUJN6HMJAGjCTAFNflQ7g+3JiIsjH/1MqNV4d99pGhgq7dd9DYnRSh0NsGzoh72hrjsk7DC2K5ND8FRL4L5stGo4bjaMhvisWl+cdbipGw4yKkYbeyHvu4aLn3dYLEp4SjdQwRIIiVQ08fRKFg03dLlrhISYTzoFl8ZDVMG2F5dOXSRr8b9P+yAXL+W0SLWVEzOqTtBcsVYUjzwkyoJHadjzrdEYQ0F4Y2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(8676002)(6916009)(66476007)(66556008)(66946007)(54906003)(86362001)(36756003)(38100700002)(83380400001)(1076003)(8936002)(2616005)(26005)(52116002)(6512007)(6506007)(4744005)(7416002)(2906002)(66574015)(316002)(478600001)(6486002)(6666004)(5660300002)(41300700001)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU4rOThOVGNUN3IxbFpMR3BPbXlvSFRZaE9DSk8vUHA4RlBrbXdjM1dxUGJM?=
 =?utf-8?B?QmMxcjdCbjVkNzd3dkhBTkM1TytXeW1BekNkTy93UVkxSmVjMGgzQ1V1YjJZ?=
 =?utf-8?B?Y0RyNWdsZWxhOU1QZkcxQ1Jwbk1LNW9MODdsbmNzOGxmS0ZWa2FPQm5yOW5I?=
 =?utf-8?B?T3FGNUpLUDBEQWFqL1FtODBrUmJORU9STGtla1Z6N0x5VlYyMTFDU1NnTVF2?=
 =?utf-8?B?WHFQZm8zakdNQStUTU5sT1IxelViTWt0ZlZEMmY2Snlpdi9lQjFOZTFEb2FE?=
 =?utf-8?B?SGxUWlUzbDFIZGY5dzM1V29zZktYd2FEZVhJOXlKYmF5OUdET1JMTEs5YnNK?=
 =?utf-8?B?QU9pOEVWdmpqMHVNWi9RaVFWVmVLekpmU2YremFFQjdXTjdtZjRmWjFOVnNU?=
 =?utf-8?B?VVpFTUhtRXFuWm54SWo5bU83WG5nOHVFQlA4REVxd0RsRjFzcDV1Y3NVeGZT?=
 =?utf-8?B?S1hGZnhDZDVBUm5oNEtyMHlnTWxOei96SmcrMUIwY3JTQnJDUCtBSFlxckhr?=
 =?utf-8?B?MkErbVZ3NkkxTktwRVVIWjlpUXRnZkJNZ3BMbWlSQitqNDBmOVdXdnV6ekRk?=
 =?utf-8?B?aUl4U3VZQ01RVTFCVXhNT1hpcVBTTzFVVmMwUWIwUjBudlBIRUxtclB3dVdD?=
 =?utf-8?B?UmYzVEZQNGlIakNXZEdVWVJRNEl0dko3SVNlRnhwMmpreXVMeTJXbTJHMmEv?=
 =?utf-8?B?a3I5ZWNnWnZza1IrRkxRSXJ5YjIvUkdoelFLVndRdWhNNTRMTDNzbjU0bVhs?=
 =?utf-8?B?ZlRXZkttaERaYzJSYVBUQzE0cnhoYm0vZkQyUkVoM3NycUx5aHRmSjhmZ0JV?=
 =?utf-8?B?SVZVbHh5bjBwcHFzQ2lpZFljekhLTVlUSWljT1h0bEhxdW9GSWxCakhkeFVE?=
 =?utf-8?B?Q2kxeVJSbVJCdUpiNFpla1hldWJKazFEbXFkeG5WV29WREttZnRhQzNWVHpl?=
 =?utf-8?B?dVNvL1lURU9DUHRKdDFJc2k4Sjc0ZU4wSU0xWkNZYkgxdlRYa3l1MlFnK3Q3?=
 =?utf-8?B?ZUtjWmp3OWxyVHVBeGQwb3IvQmVuSWZjUSt5MklDZEZRQ04reHpZeWh2dGZG?=
 =?utf-8?B?NTlYakYyZjRWRVZDMnFpNzVMblhoTFlMZ2QyTm93a3R4NUhQakF3QmdOcWxY?=
 =?utf-8?B?cFFmVFFmWDFjamd3Q0dUcXdpT2JrWG1mM2dQSUhUZWt2K1J5N1VsaU1xY3JP?=
 =?utf-8?B?ZmF2S1RmNUhkcWxtRUh0NGs0Zmo1SnI3d2NqUWo0S3YyeFU3SXVYRUUvSzhP?=
 =?utf-8?B?UW1aSi90bHBaYnRNN0o0emxIbG53b0ZnVzl6SWxkdS92MlJzcTVlTWRuUllZ?=
 =?utf-8?B?eWxsS0dKUUJBMkc0WHl3UDU1QWRPRFMvS1hMYk9WWndaUlkrM05PSlVCQ2hl?=
 =?utf-8?B?VkhkYzZtUTJwM1pJSnBNQVJTTU56NitGTlY3QlBxeHl5UEl4blgwTitycDQz?=
 =?utf-8?B?SmE2WDRsL0cySTdxVThGa0lURXFmSXo0UlFwNGFOZC91c25MdDl4THcwZUlx?=
 =?utf-8?B?eXA1SitvUzFQQU9sZW41L3RCK2pZaGF1VjA1WG5rMUNyNFlpdk5weUNCMms1?=
 =?utf-8?B?Nk9ybVBmTTczS0hXWEVpcExXcXcycVJmdFgyamVUNTExaGhwbW9OTVF3cXBV?=
 =?utf-8?B?TnF2TFNMM2pKVGNoM2pLNWZuc1dKQXRjTDBiVFJ2K0M1VW45aTdMbVNxMVR5?=
 =?utf-8?B?bXJmSDd2QTVEbk0rMVBRRU9VQ1FtRWw3WVhBOXhhZWZYajhaNDVzWm1uWVMv?=
 =?utf-8?B?WTZVL3dHWWpXRExlcDRnc0NDdWpBV1plTm4wTVpadzdvUjJJdml2ZjFVUUo5?=
 =?utf-8?B?UGcrU0x0NE0vcWhHL2pqNnpHWFp0VmswQ3NzM0Q5MWJnbS9YcjlyVXhRZW0x?=
 =?utf-8?B?UVlKM3laVUN6ZTBOeEd4MTdVM3hHSmt5Vm9IM01tcSt0ZFVTbjJ6Z0Q3MDYy?=
 =?utf-8?B?ZlJQZlVTdFpzeWlxMXJyUURjTFl3N3lYSm5rZ0pXRHRJV3NrblFEV0JYTTZs?=
 =?utf-8?B?Unc5bDA2NFVyajBWOVZWUDZOaVZBMzVtZlErdVNEOExCSi90dFhPaTE3MFhm?=
 =?utf-8?B?TDFGTVRaWjhPNjVDb0E3OFEyNHN4NWs2SGN5aHV4L3J0TUdvS0JiRjEyK0pH?=
 =?utf-8?B?RTdldlN6bnZlNWswUTc2YXB6YmFxcHpkS3Z6bW82eklhRFIwMW1xZFMzZmVJ?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7387752-e519-427a-0533-08dbf8250698
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 19:36:51.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cL521YTD3XJ3uXGuCRieVWvelNcyBm4a218qL10JQpvIiDCV6VkyBrv3kN27jBAW9j3y1nEBOvJskthQWsvjIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213

I'm not a historian by any means, but I think the only way of explaining
where DSA is today is by looking at where it's coming from.

Some mailing list discussions with Sean Nyekjaer / Madhuri Sripada /
Luiz Luca / Alvin Šipraga / Andrew Lunn over the past weeks made me
realize that we don't all have the same perspective on things. Some more
documentation could potentially help.

Vladimir Oltean (4):
  docs: net: dsa: document the tagger-owned storage mechanism
  docs: net: dsa: update platform_data documentation
  docs: net: dsa: update user MDIO bus documentation
  docs: net: dsa: replace TODO section with info about history and devel
    ideas

 Documentation/networking/dsa/dsa.rst | 302 ++++++++++++++++++++++++---
 1 file changed, 274 insertions(+), 28 deletions(-)

-- 
2.34.1


