Return-Path: <netdev+bounces-130611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007398AE6E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F0428101D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79531684AE;
	Mon, 30 Sep 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ecvp97xC"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59621373;
	Mon, 30 Sep 2024 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728359; cv=fail; b=DKh6AoxsSXoNJTFZIu040eMjOk63N1IkwKOF9lqTw+yxnI6lhYacBhPOnoRqjUqB0lPKHzJh1guPyyX2t/B2Wky2IF8cCQBrKo3sHt1S395hVzg/bC3KrcoQprntKvGPoyCovdRXtIRAVqSlXGFBG/wDibB/vbX2VUCdafxAXXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728359; c=relaxed/simple;
	bh=pEnTJWyFouROvCuevEfi8zPVr+vcZcjQSidIUyLBt9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JpeAEjROku3N9IEaJiCId13dX+yxHB4N+/cgtc4GPocH1ug4m/MozCoail1RBu/Gz5vj29dgfq/hTzRuAbG4aYqCv2Vpo56swHBP+sGQvGzgDwFFLVwh+SXFyBl0Sk4dd74qvSswR4DCWrWtlg5UPxts7Wozqinma4cCMC9UXEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ecvp97xC; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYZGisvKmFDmBxhZ9czXxajiMAd7Z9H6qb6ftcar5I5BMVs9pXQ/B4Wk2OPPbHqQfkqyxsDtGqQpaDeV8r2lUbwZE2eyfDg4B2n89DgTtA1CR+feZ7fK3XLNFvJylloMS6ChdgQtuXRaDf+vkVrwDXnCFxCscYLVq98psCWelcQhUD4jtn/WVyj7Gu9YNF2FEIXpe2ZmO3FiRW3DViRKA+9/hpDBw5r/pS5k9arLscqyYvtmQ7BWIqBOMe42PBrzDwsePLY4sZBAIIhnvQVlF3I7rYlZYQjqFS2bMJPUOXPejwPfMgIKj8Uipqlz6YnraqxE4N8UVdKvTDuyP5G9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFJm53+6fRYXb7tAOT6eFHQ/B+XmeNLlvem8yKDoFzg=;
 b=fyF+HEldkdL6Cpn/G189qSPJBbkSYTsG2etLvGi+YlXGmHBxBlkmiRIMNBDd3vFgte6XkMMnfx12hlZkXIfOu4+6x/rZ+ze+FZAAT1U+0Bs1tT0rtbcNlSseQ5okQ9CQc9dHZQ6wkk3bIxw1KMGhMi/Wv5yyTGDy3lVDaf9/H+9ivlyb+F4HKP1ZA5BtGEK5BvaSe2II9jlsExt+e6L2+l1TyP7E6ii01kAk6zb0UfKBABXwf3xI4g85UDxv8NFfuKlShC7rxgjescsLQg5L94SJ9+/Vfmm1yhSBiHAFswH2o0q7EwFlk8TiCTL6w/3jRMC7lfbdgc5nQNxOyv5gXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFJm53+6fRYXb7tAOT6eFHQ/B+XmeNLlvem8yKDoFzg=;
 b=Ecvp97xClTf6sGoBpKpUyQ9KYWq06TL7vr7Xcor+OU7hXOH/fbw7GYbmXdurqFeVW+LTjptD34m7V7ecWKY88siavQfaL1zk0kM1JOADFNEr7/bjJy7FJ7FFgHY3rBUxsMM6geF5jL/2TXE95YAkCJvrBapdImBaNzBH3VLAPhkw2IPDzhwj8g6ONB+8PeGfDcXEUxeu7omSxRn5UVDvjxW1/1M5nqdMTK06ZfkIKafw0VWHi6qFkkCBJyIIppqPHpIgpXQaPKklPZo7VP/ODSVGzm6yzUN0aspTwvPZnjeKdmuXvCF+rxzcprJBeAl+uZdYuIOeBy8vPyvgdzv5Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 20:32:27 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Mon, 30 Sep 2024
 20:32:27 +0000
Date: Mon, 30 Sep 2024 23:32:24 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: Simon Horman <horms@kernel.org>, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Message-ID: <20240930203224.v7h6d353umttbqu5@skbuf>
References: <20240926160513.7252-1-kdipendra88@gmail.com>
 <20240927110236.GK4029621@kernel.org>
 <20240927112958.46unqo3adnxin2in@skbuf>
 <20240927120037.ji2wlqeagwohlb5d@skbuf>
 <CAEKBCKP2pGoy=CWpzn+NGq8r4biu=XVnszXQ=7Ruuan8rfxM1Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEKBCKP2pGoy=CWpzn+NGq8r4biu=XVnszXQ=7Ruuan8rfxM1Q@mail.gmail.com>
X-ClientProxiedBy: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c75fec2-7e65-4602-6eb3-08dce18effae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ywqBDI7V84IiBvog0OEZNBtBV5MBJy0xkaUUzL3Rqt47wGE5O6mG5gL5geq/?=
 =?us-ascii?Q?K0Un13xHzYJIIUNAxK7x7ppPekff5iulKFLk/nZCY/1yvOdjw+z6Hc3H2+IA?=
 =?us-ascii?Q?oC6nP0odPRdNZLVDfsgIZarusRJtubCXx7FWNAf23VGkXXsb8zEZh7nIfKVN?=
 =?us-ascii?Q?K+DcW/buZfsxTvkB/uKXktolBbBt6wo2snUAjfnlzTMrqvIp5eI4+CVsBBN/?=
 =?us-ascii?Q?QKX3WuaXxM8U67Aa8sqUAzy9SUJOmKxEN13L1P0hJDc3S4tXCgS62SkF3fTz?=
 =?us-ascii?Q?XrXAWmRGV0MTGa6CwJoQKTZHP1xcUWD2KEgfkksLsCS8EgYwLGIWyw1Ad8RN?=
 =?us-ascii?Q?570KRr8mQVohxwwe80iQ2vjJeskmScg+njxY/3i0kZ5+UMdaWckmNqP+bYaf?=
 =?us-ascii?Q?9HzUgX15KDUMTl9ypNVSpGzZtdpbzZM5W0Qy1NkKIl3NbB3OWOYhW9nLzVnp?=
 =?us-ascii?Q?E4Jqea/6eyH83gRqNbmWr4mwpoJO/wg9SD5LKrAhtqORWPRwR53fRUFP5l/z?=
 =?us-ascii?Q?FZtABqI8vgGDGKimy8BcBnZsa4xoLriKuJGYkgz3555yKCD+u7vM1AaEHEJb?=
 =?us-ascii?Q?xREQ7zCPRKlmp0kffBjtwh3G7xhDoKUVnjGYh0wKWELhILhIJZGEpiR2KexC?=
 =?us-ascii?Q?kAxtPQUHgG9U06mopVv2RIWPwf8jArnsTg71jPSYLewVwj6X0KS1Y6qWcUrS?=
 =?us-ascii?Q?6kETmDusV7aK4Xv9rv6EamW359Qa2bToA5xrhMunQ34XnTpu272UKS0IJwq2?=
 =?us-ascii?Q?/3irvkDxc1PRvKSLue9Uopa0vGH1Y47K9gZT4+nIL1Mgkw5HGNQuCLAYM+C+?=
 =?us-ascii?Q?+yhCRpScY3O78YhL2kM+AJN1m8UQREyDeqyMgAkzsxbH/nOUP6L8UgJ/Y0aM?=
 =?us-ascii?Q?hE8vKfIP3zYcAW+YvrOloiD/Irl1pih9bhyTW4W8moFoZv5WDFr93XrHcyPO?=
 =?us-ascii?Q?SkCDtHRxX4TwDBFp7nhq0TD9s+8Y3OXk0DehB06eZ5VpLyQmIlXomU4WtTiN?=
 =?us-ascii?Q?DAMqYBoH7vGFvIi68ei+QdeMP99jNL3YylyqNOKA1VrTxih3ki+QoIgI3LEh?=
 =?us-ascii?Q?roJXC0CNuy4tKieEOzYgGVYqehPJbl5b+umR/DV0Ub+By4qqeWp+N103Iy+K?=
 =?us-ascii?Q?W16ssK0ufUi5Ml+hQf0cF9lcRE3xyXCSTIcl8dlJGbadbvIB4lwXXTKl/Ffr?=
 =?us-ascii?Q?sIxyIDM+h7Zo979RK31QD1wwldKuDYi4gd219FqMiJue+y5vPaA0Q4X2Yg2y?=
 =?us-ascii?Q?vhnwG1tdzct3k92u/K0+SUPUeEYQZBSd+KGrc/csdNo1KMqsRVY64ydLtMgn?=
 =?us-ascii?Q?8W3kDb37pJlODjk/QGWc3iwqxNaAeikCEIOjghF0ytIwNNVT+9Y2S33geqZ5?=
 =?us-ascii?Q?FycX6pA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bUlBamxervwZhzmQTK8lUpv3Bl8SaFKxSwZnZ+y+BEsjusAgQax0yroLtwCG?=
 =?us-ascii?Q?tpujPyIzcS0edoHTOpf3hEe5JjrMbRNF025G9qGh1zRkzOnoWu7b22eChonT?=
 =?us-ascii?Q?0TjwOH63sPBeVDnOC7Gt7v6PJ2E2nP5NVEOUf429Z1h8NiwfVLHecDlYZ3gW?=
 =?us-ascii?Q?mTmxfQDAOU0RGpgX5Bi7cnifaZQdEQN+tuh/ZpTsHqKgcIfgQEoy0kC2TavX?=
 =?us-ascii?Q?ju82BJqPQFoJIk8VtJQOHdxWc83gqHcPpCh8sKjbJVw36DwSYSpUnDZox0cT?=
 =?us-ascii?Q?BuvZ1iS/e/8NG+MA7aQcx9RLz2a0xdYtf/kp6ckHpkWKDxFUWtyR35quHqDI?=
 =?us-ascii?Q?MAqcRwA3mwUwTjM6K3xOAByi9R43RgWGAVDA8QVKDRkrw268pBytoEp0TAJv?=
 =?us-ascii?Q?XTmXX3OYkohzxTrQDqMEX+Enj2HdKc6DJEAjDI5GFQOrVW2iGf0LOXYz3Kq6?=
 =?us-ascii?Q?rTRiuhPKZ+WCQwCAlCaiy4PyjAsQ4HsuTt4FIWKo0Ty9JBJeH/KLxYyQlKbN?=
 =?us-ascii?Q?kjxFqaYSXygKsqt2fq81f6YzCzVH8aFVwnfZGqtUv1V0tUOG/UOXayatLouk?=
 =?us-ascii?Q?zyQ2nBT7YrYbpL52NrciHS7hP+ho+ahdY8LX9dbL4cJUKGn84UtpJr2xJncf?=
 =?us-ascii?Q?oL1vIvSqSeNw2Tb7ODqF5KX1p7BscWerJGMgxOb8GkcK0DfoMZBc7xmOUtZP?=
 =?us-ascii?Q?L+EneEU0Dc9PHgMl5jkFNWWx0J2FPGRJgUljqa1rQsasrb3RYJlevqRN9MhQ?=
 =?us-ascii?Q?o1m6fupmmRs/MkhY+xgkPREjxMt2M31H1wASMF257UmF0vvKpUOcz5/eQBsR?=
 =?us-ascii?Q?Xeegh0++pkxtvcEUG1PkEYUunDfIEiEpQ9ArJQ32PDqxrHPv4VBNR3qsFXIj?=
 =?us-ascii?Q?dfLpEOajgrZebIMsJ9YQ1KraI8sm/gFap8SPBn1/FO0hWYoKpoJKyNG/LYuf?=
 =?us-ascii?Q?2ZNNQf1eRkY/tNVDLV6LaUl/hPklwMsVrdHlBTwRpMBXAaJEdQnKCN4pTFnI?=
 =?us-ascii?Q?y66Giy617Obo9+uD3uvKj242EpLsthd+/3p12lXIknPh11ipivY77lDykFzS?=
 =?us-ascii?Q?owTx50OF6wZF4ZE45yvu1PYYYPoxsc/eDed8vQkhf0G2/6W9owBgDENvWeFG?=
 =?us-ascii?Q?/x5r6agnIsojE93YlPY5KtsCr75vd9NSgB7k2m2/DWAk0MYFXJT9yI/gHhEy?=
 =?us-ascii?Q?jSvVCiUJvpqe7868hnWmqFq3kVrl9Zi8PlRpR2EpkB+zORJbPnB7SyQpPWn5?=
 =?us-ascii?Q?l74LqBp+3MD2tA1gMZlFYi1q9RIlN6WYJVUPY8Q9ewXXROLe27dFgoQUWXTL?=
 =?us-ascii?Q?f+owkS/cNSvAsnR18tckO36D/hoMq/io/schZ51g80p6ofwIrQxk/skHRHXD?=
 =?us-ascii?Q?+gqgleaYNGFrqppLnKbqmkb1U1Uehy82spCBC09viHQ5kYTeVvBzX+eF6fFJ?=
 =?us-ascii?Q?8Cxk/m0+W3pLYvdq+yYRZeKElRVVh8jusbdWBN8Lxb374vTt0OVr9cZGPNhg?=
 =?us-ascii?Q?+5iGpkCEkcvRzqgRSkU4Buju4yNDhD8sbKq0ChIYLrgWSUIOh69N3OlW0pQe?=
 =?us-ascii?Q?bXqkG3RAdC3xDG/nUnZp9H2Y6w65gOTdLRgjNPfI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c75fec2-7e65-4602-6eb3-08dce18effae
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 20:32:27.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rngUnN6N79eVvdDf/2ZmNgYdprlC4w3OR/WkPDJ6TQpbd2/zdBdXVXucj+tfwWS6BbeXlUNwEdRxnRJqIHiEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

On Mon, Sep 30, 2024 at 11:52:45PM +0545, Dipendra Khadka wrote:
> > And why is the author of the blamed patch even CCed only at v5?!
> 
> Sorry to know this, I ran the script and there I did not find your name.
> 
> ./scripts/get_maintainer.pl drivers/net/ethernet/broadcom/bcmsysport.c
> Florian Fainelli <florian.fainelli@broadcom.com> (supporter:BROADCOM SYSTEMPORT ETHERNET DRIVER)
> Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com> (reviewer:BROADCOM SYSTEMPORT ETHERNET DRIVER)
> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
> Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
> Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
> Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
> netdev@vger.kernel.org (open list:BROADCOM SYSTEMPORT ETHERNET DRIVER)
> linux-kernel@vger.kernel.org (open list)

It's in the question you ask. Am I a maintainer of bcmsysport? No, and
I haven't made significant contributions on it either. But if you run
get_maintainer.pl on the _patch_ file that you will run through git
send-email, my name will be listed (the "--fixes" option defaults to 1).

The netdev CI also runs get_maintainers.pl on the actual patch, and that
triggers one of its red flags: "1 blamed authors not CCed: vladimir.oltean@nxp.com"
https://patchwork.kernel.org/project/netdevbpf/patch/20240926160513.7252-1-kdipendra88@gmail.com/

