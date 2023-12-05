Return-Path: <netdev+bounces-54153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BA58061CE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 23:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B7828212B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F76D1D1;
	Tue,  5 Dec 2023 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iQiwOJUt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8101A2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 14:38:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSJRwAYzgJfJNyhpgHPoa+dANQ7KEznsJSS754aWI+ZP38e39v/a9DC9EoAcUKtyZ/8LfpHB1CZUbJQcPi+J4B1BXa6jERIrCzju+LD+MIRV+lWtQxuBiColkmHOh4sj1qbsZ4BCyiDyn3/VlKWusc2bLa6lwD+ObSFRxFxHADawsD0tQSMQTOrSYWDuOwRGfIXsZlTVonh8U79RRYxX3YOZZ+OotTwa50FkOM579P9q1zJjvgZo2Fz+JJkH/4GzDJWnu7kdhd8M3J0NOQ3affxDcioD9fvqH6C83cNePmM0FiPly3XY0ecBtca/ygrIndNt2u9S4TWioB1duLBSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM7AOm/+ye2CHbIoNEeiBtkkfd/azhBFDS9UCbomqnc=;
 b=T1jJjZ/oSe5xjsVwwOVxBAEUdDRQBrr2ZBWHTE21CTAq+DA1HufNYM/aXBYTBBPKs9YhgC3pNr+XlxvtrSoWOFT5NA97sFlYl3qAufWcXO3qcFOhnNSiHjBNQanJYngjC9waJR+paCOCGca7dcc3q2n3wldYM/W52fBlWC4Mc6rYJU/J7tX+AJ4aWLkQZAEX70LtoKgjYWxs0P2qkKhxajZszBLbp0uC2MoJstddupv9mF2ii9W/GlPsda5fVExxQREkW2XjithVXX/Jzr7fiqtbX01WcnHNdXcJd++qTn1fyM1qodhi+0tcPYYz4Lq13VOXv6P0WGx/NmCRQNRi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fM7AOm/+ye2CHbIoNEeiBtkkfd/azhBFDS9UCbomqnc=;
 b=iQiwOJUtnGrrqIo8FJ1PKkQ+nmuQYLvbx88Xa/OlRbfnsDlJSUzqAkHicoHStrcxjJ4F0wstvc69tS0M2B4wDL5nvVLcbG0dcTuIm6LsDKRUwkOlcagqAjxPpQ0rzNSE+UEh98Bh/b7X40sPgTUwbG/XpJbqHiYWhM3+xY/6BEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBAPR04MB7416.eurprd04.prod.outlook.com (2603:10a6:10:1b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 22:38:55 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Tue, 5 Dec 2023
 22:38:55 +0000
Date: Wed, 6 Dec 2023 00:38:49 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/6] net: dsa: mv88e6xxx: Fix
 mv88e6352_serdes_get_stats error path
Message-ID: <20231205223849.wmapl37lerjr7pn3@skbuf>
References: <20231205175040.mbpepmbtxjkrb4dq@skbuf>
 <871qc09wuv.fsf@waldekranz.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qc09wuv.fsf@waldekranz.com>
X-ClientProxiedBy: AS4P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBAPR04MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: e9af01c4-a183-4394-6295-08dbf5e2f589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yItbdQcfexLricFDLjyBFSPFBiWrdSaNAfZ6qYSdlDd0um3//MVe2WldSKNRyg3bwhvW014Bf8uSn366IsjnnBD1DubXMwq+nDnCAE1bkBRYDGaA9ouYb6zcbpLucR1UnrhztBMwFKi0yluSd229RDCeuPbCkW+fdALoubRPDP0bM28rO0w9AboNhZjN3ZG3FBAxXDfnb4oGQvnCoKjmghnNd1pE1iu7YlzIgErfxjYYbg+SdjLkWJqjVApdG8vtiaLij1fP2SelPqNaDoConS2hjqOl9/wMHDiMld/zTJbMgzHjv/1xpHYny5Ehuhr13+9/rqLc1rqHeid8OYayNj88qcqUIALkXastgeRN4D9SXwdKylGOFvEZS7xuuwJtAjyC9f0I/gqvRsj2PZ9E7EGPy2n2lG1f7f1FKO9vY/CnLBlg+mGqlmmdz49JEUyCitOG7OgBn2slATBp+7Iz7w0zyh84a0CV+09g+2tZd9C8m4YgdpKTHaiflmMS4QQIDHdwm9ivDLL1NdBW7fO5qYlHJMSmnNODAbBqvr7zp/dPQOaRKQgmu4GFTCKY1PHT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(44832011)(2906002)(5660300002)(41300700001)(33716001)(86362001)(38100700002)(478600001)(8936002)(1076003)(8676002)(6916009)(66476007)(66556008)(83380400001)(66946007)(6486002)(316002)(6512007)(9686003)(26005)(4326008)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsqMacVCyvTgQqTOYFgO4Bo7KrcMlWSKLtdlsnTuvqllD5w118LzAb9Zmhyt?=
 =?us-ascii?Q?xf2FM2zwjU65gU+MXrnPdSJKUlSxW/z07qfmU9ggVHQo4xffHQ5QmwSb9jz9?=
 =?us-ascii?Q?RlziT/dHsByrHBEathtRPLHeVgtIso0gag5qZFqKcdtF54t+n11bWbCSqQnD?=
 =?us-ascii?Q?bsazpSDmPk9DNcg/0K9uMg5V3MVZtVMC1SG3SnG3lNZHOovQYHW3NXDBmiOo?=
 =?us-ascii?Q?+MqbGpnzUF8tvcLHrXAkiyvmIL9LoFMrUEqOVEcutd8h4fCA/qF7zQD+BcOP?=
 =?us-ascii?Q?eRwwOzrdzFpKzLoLFfw+oFI0+8pcG1XkT5WfdjcC36O5p1gdlCiycH1xJNZm?=
 =?us-ascii?Q?lXPJOUc7oSKnImpiE1xrY+xDqCsWsmrOo3yggH3Nhd5KD2KFULZ1Cvz8Zwdh?=
 =?us-ascii?Q?OE2nbeUC0lTYAhQqJpG/1RE5w+5PRtS9BQL2cY7QS/iJd64wo8D9kr83GZsb?=
 =?us-ascii?Q?g27bJ7AI9NGF0gbV4kzcTboN0tE5kFuojr70THX5v4om4GAj8/0Aky2w0rK8?=
 =?us-ascii?Q?ejl3Aqs9k1k3qN/oBiu7DEFWuYzdGyp00JGxCAS7ubJTIO2J8FvEV8+7LoPM?=
 =?us-ascii?Q?Bqx9+IyJHngg1nSDE4QstAlp7FroIwU4KVrI/szSdoRfhLddXzOuWJgmdKuT?=
 =?us-ascii?Q?PL/bBWWKlB679d6T9GkZvHml1TdfRNebWt5eQKjIf0hnFJOpcBhH9ayHLk1e?=
 =?us-ascii?Q?fUCwuc2mN1lOoBN/0Xvt6fPaRXawkc49GjAZ+aqvHaA1/l1TY9b97BJ8xRQg?=
 =?us-ascii?Q?d+zh9Ot5h3wyuuRV/4gc0dgrFImNqBbKvMPdE7m+Mu6etytH0ZxueM4bm6gc?=
 =?us-ascii?Q?Ah/lXh0X6Ru/zIs9T/mlBs3QrJXzGV+3IWv071m93wbFUgrDVHoN2caSHpxy?=
 =?us-ascii?Q?dGrk/1CL/2CoPT7yX2cB7IWlx3j38FzW/M0tAusJiDpr3eV/+jaR9VFRERxF?=
 =?us-ascii?Q?4TA5qsmB6lMb9It7PZpXPhQHsaFyWO00XuYRwBBq4iONULhJCB6RHba8jYHe?=
 =?us-ascii?Q?TGtjd6SJTcNq3mI/P6aBtcwPqJMURApG/mgJoLkwNO7DKbhN3kiUnrZaJsSm?=
 =?us-ascii?Q?EtEZbBUDetwiuEHrw/NHZB3MW707ogsttHbM/R13TJGQZMg3NHY/TJs7G7LF?=
 =?us-ascii?Q?Ie7qPLmYVQap2MFnP3K/YmtWW00ym01oHFoHMdakrAbu4r2BPZ/8lVLf6al9?=
 =?us-ascii?Q?WqytCoNx4WuO80lrTHXQv3vwwf7z4j9qsnzkTOXooEOQ2D7xzk8xkG4Vs3YE?=
 =?us-ascii?Q?KGl1llc9VqiBsEMy/NozHLz5tEa+1Nb4qeFxjI6PkN44dOkxpkvr0neGQXSL?=
 =?us-ascii?Q?Ong3KOvlguSmxjuieWj6aWoTFfXPs0JzPMpuoBXPtgDZDKcRhoA3GwCWjvcI?=
 =?us-ascii?Q?9oKNZ2UQ9R/3PXtj45Uc615X8aP83LY62mtLrdIslZwMRSyccHvdaiKFZ8Ou?=
 =?us-ascii?Q?lHSuq1Nt3vjZU9lfoWjfphRYx493DGN9JvR9mrZjVWa6e+QQxE0+bPUKUbVU?=
 =?us-ascii?Q?BbRmBmY6Hd0x5Tf+Q6J+4YC5WeuhgbHw89tXtWxx8seDwLv8FU+4j6IZbCa2?=
 =?us-ascii?Q?FmgnDfSyuEPgyuVB1q14o14oIs4FEda/QhZd4xrUhX89wByc9LXR5x+d40xN?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9af01c4-a183-4394-6295-08dbf5e2f589
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 22:38:53.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tla7pNvP1hXQucm7uNT4mMReIvqKjJQKj5xur0f+CMdXfG0I0bnj7uUgcUfMBiHOCpribljWolrOXlEulC69Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7416

On Tue, Dec 05, 2023 at 10:13:12PM +0100, Tobias Waldekranz wrote:
> > Ok, you're saying we don't care enough about handling the catastrophic
> > event where an MDIO access error takes place in mv88e6xxx_g2_scratch_read()
> > to submit this to "stable".
> 
> It just felt like one of those theoretical bugs that, if you were to hit
> it, you most likely have way bigger issues than not getting at your
> SERDES counters; and since, as you say...
> 
> > I guess the impact in such a case is that the error (interpreted as negative
> > count) makes us go back by -EIO (5) entries or whatever into the "data"
> > array provided to user space, overwriting some previous stats and making
> > everything after the failed counter minus the error code be reported in
> > the wrong place relative to its string. I don't think that the error
> > codes are high enough to overcome the ~60 port stats and cause memory
> > accesses behind the "data" array.
> 
> ...the potential for data corruption seems low. But I could send a v3
> and split this into one change that only fixes the return value (which
> could go into -net), and another one that changes the type. Do you think
> it's worth it?

Reading Documentation/process/stable-kernel-rules.rst, I think that
consistent error checking for register access on a non-hotpluggable bus
is the type of bug fix that is exceedingly unlikely to have any measurable
impact on end users, so it might not even qualify for "net".

To me, this is good enough. Let's spend our time doing meaningful things,
while also keeping the material for "net.git" meaningful.

