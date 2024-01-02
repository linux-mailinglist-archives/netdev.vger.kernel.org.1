Return-Path: <netdev+bounces-60947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63523821F75
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92DA283979
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE114ABD;
	Tue,  2 Jan 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CIMPKnsQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3214F65
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd/A41kwZVuWj4YXcted7bWMlX5VETDntnnwgVDWxPZHX2k/zVPLkrn2H5kApHrng+K2u4K7/sdqHtCBQU1pFJjoMRbadqRLjK9KVQ9shPqcPq0RwS5NB6N4PGeOcm8tI0rYPQ0BpaZ+6GYI2HAns/ftlbTJt3sWKaaMnHM76Frl28gOFUaice6qN7IMN6N7aB6QDiTC/GGNcNZ9BjvlkW9lXEv6KbazCji/w2SNXJ7+eGXfGOvbXNOkCQP4F32JJqVUvMaab+bSjXIn3S+XfMZf75KOQVDuyLG8yJowfYumHaSe8HHaanYh1eDNI2QvbqmqcuQMhit9j2QGdTqzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmGk9Nn8lWaZRs/jIQPkwmWM6GLNRIYlTfrhAdomAo0=;
 b=f7Vu0IMCyaBfMbEfTXgmOz+z4lxvCtFoR6ghDqTI5kJOFV8CufQlts6bY6gTRkiyG+fRGdO0LC0JFb4x8/xmQEkCLZW8lUQyEKnd2SVo+QNXhXV0yx2oy5+BmKMpYJbgL9H0n4tVdHhxvvp2l3uZSMhfRWC1gxABGyJIR7SFdWi3EyjUgUY7uw0FdTop1egx9KVcjnSpYxFwaFT7G+FPmjS8bt9sbd2tXude5EVsziaNoxXxuSIapCk8DCjs5TMCueVKfVkyJSKHnRXHNdkENpMZ9n5903Z9PFOAfSbLFsN59sVaRySYD7FU5x4bDzqDreQzNxYGisBUmFZdW3Sqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmGk9Nn8lWaZRs/jIQPkwmWM6GLNRIYlTfrhAdomAo0=;
 b=CIMPKnsQYbzNLasJOJcYFuTe8Hod6NcdebQ6K5l4GZx/P0/E23jRbVz++XwahkSi4xDOvTgVZUJ1b29kLDRmwpXHqcpruNI6VYz6dquZfPZIq44yjK+G8v0nhw3wiFF2zisLH+qSC4Z/q2P1LYoCImAYJvbsPF/QFQWpEwMsMlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:26:58 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 16:26:52 +0000
Date: Tue, 2 Jan 2024 18:26:49 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next] net: phylink: avoid one unnecessary
 phylink_validate() call during phylink_create()
Message-ID: <20240102162649.lhekve4ufo6yhp6q@skbuf>
References: <20231214170659.868759-1-vladimir.oltean@nxp.com>
 <ZXs467Epke85f0Im@shell.armlinux.org.uk>
 <ZZQckTKmEjSbgCDo@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZQckTKmEjSbgCDo@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1P194CA0027.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::16) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fadf829-c9bb-4535-9f0d-08dc0bafa0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IrjW75ORlvluxI8mUYU70waJkqKNRphPgJe5UTH1g8R3YsMC/V24bmTMIf4gqUw3a2Z7PZtXswAz6FpbNK+vxadCb1UwdCMx/Eu7TLrgvEsdx0eaZgUNMazU481P0MEMnIfPuD3pt4Njkg7DHoxTmSDzE/pzd15/UfQkSl1w6L3gJArn1hSLvzTwleUgobl+X5iuUrKb6cin6t0QuAPaE9axsqVNPwUEH0DKHweWN9QazUsXX6iRyjsn2Nnhwp/e8zW7npbUygEC/0BccE59QJb2nx10oMTRw0RnDKmyHz6Nn0PtjXLPeVPaEhpNbs2hVXwjARRstevA+s9kEiW6vmGr6KKKxy56AI5ixj5UfH45RdL7tZ0/+bFJt0qU8XH9W+6FPM1HifDMgj/pKmV0Xq2R4lV07CrQVt3217BQRO8RH9vB9pqKMP+fghGey2G11rBV+gxxt7mbwW7fQi2xssjUkz/RiiQ4kt/G0ogUEITesLIxVJfzUhJsVsvSHnsOdLycI6TSvOJErahTsfDeHeFRSXrh59i+CJEyCsTnRVksGM7Cpop9lzGglgJBx3QSunTB4q8smtD/oNWSIioFJhPi4r708ODTvbB/XCHvxx8+0Yz8kmfIxoAdexR5aoGV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(366004)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(1076003)(41300700001)(6666004)(26005)(38100700002)(33716001)(83380400001)(8936002)(54906003)(5660300002)(8676002)(316002)(4326008)(2906002)(44832011)(478600001)(6916009)(66556008)(6506007)(6512007)(66946007)(6486002)(66476007)(9686003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5F2MdhfjH1h4GMUwYSHb6XK9YpY1H3L30SXaFNYuP8foEpGay/zAdg+42GEp?=
 =?us-ascii?Q?jHpp+/MH04f1u7DtovxBgbhs2TEbzfgYTeMxev1O+OPFUiqh+zTddbjMLVBN?=
 =?us-ascii?Q?lPO6PTzeIS2MPiZJBCImWHFdeV/Xb2zeRIxS1QL3tdU9HtrG6VNnZup5L01L?=
 =?us-ascii?Q?vfabZW8z5jE0tW3IhENLGvJgWjVOLk/Gdsza+51tm/aIPBkuMSuMwo9J8Nas?=
 =?us-ascii?Q?UW4BR3MFHapY8lyDDlTa4QP9mCWike0/MLh6nIuCdqL+BYhUKTNoTJ4UcmwE?=
 =?us-ascii?Q?V0XGJ1GNX0Df8fBlo/AS4wjht6NQ0TKghyORfB+zjjPQnIrvb1kuLBc1AP2h?=
 =?us-ascii?Q?0WAtTJdZ8wFUCrNj+P2Qz4ViyGxTPBYr5oq1KSTr6hCGDt11l7lE6r6pHTdp?=
 =?us-ascii?Q?ed28Uh5dQIV1JQQBjPSUwbmPPOC6QuOEiXSEoQue0T4vXT8OPRpDPxDwj1js?=
 =?us-ascii?Q?Z/xeL554mzZxE5e5vXuzWahgDbmgoNv02aANpQncCFU0cBJraHN0d/IP1QUG?=
 =?us-ascii?Q?HxH53OG5RzlJwcJarW2r6q3j5tFrBuFl1BwDy477s6NRFIKPe/hBglrDzaH4?=
 =?us-ascii?Q?v62Sg0bPGax1TOhuat4CGFRiwv8fcf5V1X33sz/FBAAP0cH9XcbdTQUJtm5c?=
 =?us-ascii?Q?3FGrUpCukekzBUu7PoGGUnHEAMJNTQTdjkZ+v+v+KT0MPLeHfCDG7QUHfF7v?=
 =?us-ascii?Q?3fKnNIpeJail1ZQLAwNudws4i64InCxC+qgVj4ol1/2fLF+y8pYp5javcRoU?=
 =?us-ascii?Q?JGG9v7wf0qcWgaOYxzovl9vFHYmqEAIagsdUSSjMULbhwlXnqDqjw1Fkvf74?=
 =?us-ascii?Q?p0xkNbWNK9fuJdLKMqX6mMAZ10fT5RfsZEkhaGTir7zO1VCr37C38DmfdcxZ?=
 =?us-ascii?Q?m/sfCJutz5l0PEatio1p2SyiBYZTl1Qvmu3BMXMxXlSZbn4wEupnsG1CGorQ?=
 =?us-ascii?Q?MszS0dGcl0ERBGkaZgNREYexyXUTbu1E/bdZWedEE/iPfvw52bd1WZimQZ4V?=
 =?us-ascii?Q?Ktr2a6McJH5A5trtNdbxdPY0n67f43BdJyekop82wA9y5ps+ETblYK4S5bEe?=
 =?us-ascii?Q?+qLZVKt6oBMVx+yOH/VT5aihAt2U93suzGVwqP2odFiyV9minFIWPKokS28H?=
 =?us-ascii?Q?t6zwVQav5KXoUB4AT3TPEe6jUqqdU8GrJ4BEPf95RIjvE/9bxwv/V+y/Khpd?=
 =?us-ascii?Q?9sVlMvAZyV74NkHZHLnQdRIv3PHQzj4ecc7H1FbTrmCKLht27gtCfvemBbhO?=
 =?us-ascii?Q?epKJ5O8U9EDjghzvqbAll891dxk6qD4dJtnAAI4IeDRS781ZzPocx2NleSh1?=
 =?us-ascii?Q?Xb3uZMuKTurt0dmCGzZEmBMsMAc3+86e2ocwdUS+H0QZnTzOuSX46Gh+ZkZu?=
 =?us-ascii?Q?6/tWAImryU5bVR8ZGHb8c5wXuQ8tPk32FPVp87j2p2iYSGY1NqqqVpEWc8sN?=
 =?us-ascii?Q?0Ip4OFhbuAh4KX57uRvzb5XTSdcFdMDmu/msWwFHMqJz4e3dumntJ3eAvQSO?=
 =?us-ascii?Q?3jpqZ25rEYKF6DRaPDjYbXLr7dNMRDYmfYiAGoY57A+MkNqZQXAiJmVr7hm/?=
 =?us-ascii?Q?heMUBKzh6io0fSRuER8g3U744vIAhvQLw7BfJITsONahx4dAiY1hbV245jU8?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fadf829-c9bb-4535-9f0d-08dc0bafa0a7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:26:52.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z4cB3b7AYEirz4riQ4OpgTCv80cIoW1RdDxAT98yKRgUUEqKKM/3l54bWScQps5GMGnUZRvM58O0JtowRk4LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

Hello Russell,

On Tue, Jan 02, 2024 at 02:24:17PM +0000, Russell King (Oracle) wrote:
> So... getting back to this as I have platforms I can test with in front
> of me now... On October 5th, you asked by email what the purpose of
> this was. I replied same day, stating the purpose of it, citing mvneta.
> I did state in that email about reporting "absolutely nothing" to
> userspace, but in fact it's the opposite - without this validate()
> call, we report absolutely everything.
> 
> With it removed, booting my Armada 388 Clearfog platform with the
> ethernet interface not having been brought up, and then running ethtool
> on it, this is what I get:
> 
> Does that look like sensible output for a network interface that can
> only do up to 2.5G speeds to you?

I wish you a happy and healthy new year.

No, it does not look like sensible output to me.

But I have a very simple question. Did you test "with phylink_validate()
removed", or with my patch applied as-is? Because there is a very big
difference between these 2 things. My patch does not intend to change
the behavior, and I have tested it on a mvneta-based system that it does
not. It should not produce the behavior you present above.

Before patch:

[root@mox:~] # ethtool end0
Settings for end0:
        Supported ports: [ TP    AUI     MII     FIBRE   BNC     Backplane ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                1000baseKX/Full
                                1000baseX/Full
                                100baseT1/Full
                                1000baseT1/Full
                                100baseFX/Half 100baseFX/Full
                                10baseT1L/Full
                                10baseT1S/Full
                                10baseT1S/Half 10baseT1S_P2MP/Half
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Half
        Auto-negotiation: off
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Supports Wake-on: d
        Wake-on: d
        Link detected: no
[root@mox:~] # ip link set end0 up
[  105.603188] mvneta d0030000.ethernet end0: PHY [d0032004.mdio-mii:01] driver [Marvell 88E1510] (irq=POLL)
[  105.615130] mvneta d0030000.ethernet end0: configuring for phy/rgmii-id link mode
[root@mox:~] # [  108.706615] mvneta d0030000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx

[root@mox:~] # ethtool end0
Settings for end0:
        Supported ports: [ TP    MII     FIBRE ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Full
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Auto-negotiation: on
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: pg
        Wake-on: d
        Link detected: yes


After patch:

[root@mox:~] # ethtool end0
Settings for end0:
        Supported ports: [ TP    AUI     MII     FIBRE   BNC     Backplane ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                1000baseKX/Full
                                1000baseX/Full
                                100baseT1/Full
                                1000baseT1/Full
                                100baseFX/Half 100baseFX/Full
                                10baseT1L/Full
                                10baseT1S/Full
                                10baseT1S/Half 10baseT1S_P2MP/Half
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Half
        Auto-negotiation: off
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Supports Wake-on: d
        Wake-on: d
        Link detected: no
[root@mox:~] # ip link set end0 up
[   35.890744] mvneta d0030000.ethernet end0: PHY [d0032004.mdio-mii:01] driver [Marvell 88E1510] (irq=POLL)
[   35.900834] mvneta d0030000.ethernet end0: configuring for phy/rgmii-id link mode
[root@mox:~] # [   40.002662] mvneta d0030000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx

[root@mox:~] # ethtool end0
Settings for end0:
        Supported ports: [ TP    MII     FIBRE ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Full
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Auto-negotiation: on
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: pg
        Wake-on: d
        Link detected: yes

Putting the "before" and "after" logs through the "meld" program, I see
the result is identical.

