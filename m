Return-Path: <netdev+bounces-56964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E0A81177E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796F01F20FF8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8A33065;
	Wed, 13 Dec 2023 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cKBjNrPw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8253257
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUXig+xOGCw4XyWZ/bzYQohaSPk5JMh5/v45sE7xt+KsAu1fqRs2XvSv2C4U02BWhrJf2O4zcmYyc79vyjZRv+eEgmVhg+CbdOO3qqf4FPMUnWKGAKSIVWpiAlwCh6igoZzBeYjj9QxJZPHzPBJCbgLYiNfWUL8xTFZVPnKeQ2VMo/gZ3HktU2LOJ3Dbh69lCaONGlubFftomXg1BnGQv6EkmwgrYu97Y4RF7XO1jJCflkhl83j/J+5UrbT943yTGPC3RdR6ZU3AHbz4jiR0SVENIdgEOkie+RyCInjxZ3RbRrUtze2c+0nAua6F5PV5YL9g9UyfjrddO6tqcLrflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpEJDBDkJgtWbxeCsF212H9JJjsaE6/fKIQutYv0szo=;
 b=hnE21omYyzbOXtOW0+FxbFY22Il8WYMs5+Cocr1wPgX2biL1qEFM7hudxFxm3UGQd8w5juv6V0ni+TGeF9hVGC/tD3JRmdBkpZFgZ/kTBk3Hb1fxNfWk4/ls7kbw6VsCgw3oByGLtvHpJwCk4dRZ7Mgrm2D9lwjjYYq91Fgd7G8vDmHMEiAJdVeCiK/dVhCfi5RIgeyV+58GkEyzhC2Wh03GPJ+8XROXXFU/8T5O6J94KF8dZt1rvZ2s+Lk8EB+2xCphgDniuxvsJJguV72TmbtABrez3ImEKanAHIuQOeolQuGPeZaTyuEGtcTjJ9NBShzQx68G7sf9egn+iwtbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpEJDBDkJgtWbxeCsF212H9JJjsaE6/fKIQutYv0szo=;
 b=cKBjNrPw8JrDgDrtZWPWS8S5zq9JMju8OwBzq7TrAji0+7HjsFWLoBPReVkoPVi/cs5Wd1a2zDfz/jWynnNsDScXfGnSFfZqk4sMzrBHCpF63lmQVu2desIeXnnDi/eI2TxvDkAlVPI/Zi9DLaW3w5RWGYiPeZ6CgQC7f6GNMI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 15:27:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:27:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 0/2] MDIO mux cleanup
Date: Wed, 13 Dec 2023 17:27:10 +0200
Message-Id: <20231213152712.320842-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU0PR04MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 7717d892-7795-494e-604b-08dbfbf004e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+HM1S7F0AY4ZAT4L9qR5RLEttEpQnMvgIVxx73zr95iuURZo14PP50NKqKXl7gGQxAColBniQkbd99D+m+aSPRHpGo+/ThiIztWYpwHFCah8eX1oF2lVLtH6rKP6rTGv39HDAN9PKp+JJZ5WRlxRGdhdUaepNb4CeAWy5SVdSDHjxX+WRLZRYJJHFjJb0/ddAXZiVNuoYRRSFKJ5pvaKAm/ht/iSekA11SLT7EOZEKaUPGvLzXL+FwlOKcifSbV2AicliWBJOCGRzoLTW+A9iyo71In5JdjDmPYbzsgsO8uwuMeIa49UmU+szLZx24WTsqwVI8tHyBnO3AxsATKwEJWyjRB7jhAW6dxp9fDgT80Jc/csjg9Jgd+2efiGM+kGNMfLnUykELdprw3ykwQsDgmYpSswJCilPkYlRTBt2wk0/eMVa1OMtyXAtLnvAZ95/YcmP/niS30jTDhOIndq+c/GWO8T39/7uIO09DDQkJmOtEQ/bMQ0CHyPT/YzPgCo5APrJNg682de4u4m3NZgbh59XU8JAw+VdV2mhBzU6vPX3kzbQEW0Ioj9y8CXTpRdOjWmq0Uh+xKNmCkT+RWMxuIOGBbLll9mc+q7Y0NEIGAJ5ESi7YjW+4S6nVEdjpTR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4744005)(5660300002)(2906002)(44832011)(8936002)(4326008)(8676002)(38350700005)(36756003)(41300700001)(86362001)(1076003)(26005)(2616005)(38100700002)(83380400001)(316002)(66946007)(66476007)(66556008)(6916009)(54906003)(6506007)(52116002)(6512007)(478600001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b1Y9zmAHlr+6VxIaxFRw3TFx+x7yNbw5k9SVW7VcWxRMCizdu8XCwyDEsVZd?=
 =?us-ascii?Q?TzenA826Tst5nwYOp5SThLJUFXJ19tDXocsUcRCPUPVijWZyCEm1nbJgRna+?=
 =?us-ascii?Q?KSjPblCs6W4HfaaUoImtZpqNr2e2gz1V1JNDKOvFdsGx1yZ6coX/5i5FAhh8?=
 =?us-ascii?Q?XSH+/CrhG+g/DVXCnKCvB4ON6rh9nhEhnbJPV9HWHRe3jxSQhmTSPI7qVo58?=
 =?us-ascii?Q?gbesi+0WxnVL7n0hYwz6SWRXVFcBRiDitMDpzicva3ZVKOAqbC6AOTFbw5ZC?=
 =?us-ascii?Q?xAzkmHVO84YcU2VkyibpkJAJLAYTtdroUNnxAV2aYEFcnho2QoOpvbRGQcmI?=
 =?us-ascii?Q?6mALiAf8o1wdnd3zlMEdYbotqf2CvnbVdTTNMWCV8jnrut+ZeGdEiAsYcF17?=
 =?us-ascii?Q?KgOIms5mSSAzw53t/j5WQ3JdF+VMJY01F3zCvvd4/WU75yT0eXElZS+DfuMP?=
 =?us-ascii?Q?LVJmRNTkP7LbM3/J+qG37DgEZqGyLkFatIohtQpTK/SsJKwIBuakNHweESuQ?=
 =?us-ascii?Q?oO61BLcJpx3P4x3KKRnnOhH/K+wcFo+T+t4mMp7VHCaWtadty2VvuwsAb9Be?=
 =?us-ascii?Q?oNBv1omEEs2MO82xNEygBlo29yxImKc/Oa2J6SAufsrAKVWJLVoArmXoVoyn?=
 =?us-ascii?Q?zbkF0UIy+5fqaU02IFb7OI+KqFzTrnWpEuNJZBOk3bFvzhnhofv+ml88/K1N?=
 =?us-ascii?Q?+4aZjnKPMgc7gr+z7kymNCjB6VWEkPs9fnRrtDBbK9/bmWGxZh0Wq5CagBpC?=
 =?us-ascii?Q?HgDFKk+GpWp9u/z9S1xi8Hed5LcR03y4+4hIZUWcLD6MLCeQ1AS+rqLBuWeI?=
 =?us-ascii?Q?WwTKwjMnigJF06le07JJ6GJRPBhacPNeaxpQa1GXzYDcg6YINao2Jhu6JBq+?=
 =?us-ascii?Q?BH5kYR0U0Wp6PmeXSmACLbtsPBvmQRkpu4y2Uu3HobI+nTU4JT1dzfjzAUTW?=
 =?us-ascii?Q?AAM/0GcZJr+KPtEtBOQ3UWhkHBOJoY05kzPYJ4TN+WM/7xp1m2neUtsOY1qV?=
 =?us-ascii?Q?qLPQTK9KxnsNdUuXPmu2AhnOEHXgsqxTMjuGox/9BMxuYQTY0WbbQ+u1Fde+?=
 =?us-ascii?Q?QSRbmf55nOtUbhHrLYjw6VSrnTzIH+BFoxKKH16AyyaWvQs1u06Vhs6wr0E+?=
 =?us-ascii?Q?N10Edlc8WfDK/ccV3ripVLHfN5WvdxumkHf/9Fg7CKW7aLRMzFECEmgh2mVT?=
 =?us-ascii?Q?9hbM2xjZnnMkzxbJZyOu1VXZE28KpG98058g3JizvOld1mpfKvBfX4cU/uqy?=
 =?us-ascii?Q?zLmZFVWQT/COpZop2IUKCyIYduIQhY6ASOjuGHM4B96T5DntGy98OUcjG8Us?=
 =?us-ascii?Q?Ax8ERbx1ChrX6XiGnTqIIPhraLSPEMVMBTv2qteQKpb9c9V0zgsy8VAEz/15?=
 =?us-ascii?Q?UifBYJxAQNblXe+4ZlMKY1dwUTCtz4rHhUDl3Oxe2S5J3BASjqyl2NKscFSK?=
 =?us-ascii?Q?wRMS9hoNvGoYQqH7DZa7dYQ7jp56IyY6bHMnBLkTizfJqYmNnN3YWa6pON6D?=
 =?us-ascii?Q?qgWYZ9EcaSEEvbkY8HmRY3PYYzT6hWyBOt4iaQh24nzCV9JVsShPe5CRt3XF?=
 =?us-ascii?Q?Ked0bHGgxapaKn544O4syIbZLYr0lD0EFcvx1AfChrGpsqJFYy19Jf9ksYsM?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7717d892-7795-494e-604b-08dbfbf004e5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:27:29.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWhpx2TGsa80bA4EeL7uIf7g/5pzPkUBaGZVtyvPkEfFiSoB1p8KwcjT9XSFPNh7mB7kCF+150KwrBOyny12tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273

This small patch set resolves some technical debt in the MDIO mux driver
which was discovered during the investigation for commit 1f9f2143f24e
("net: mdio-mux: fix C45 access returning -EIO after API change").

The patches have been sitting for 2 months in the NXP SDK kernel and
haven't caused issues.

Vladimir Oltean (2):
  net: mdio-mux: show errors on probe failure
  net: mdio-mux: be compatible with parent buses which only support C45

 drivers/net/mdio/mdio-mux.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.34.1


