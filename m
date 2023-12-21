Return-Path: <netdev+bounces-59612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7007781B819
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 14:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268972859F8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20801271F9;
	Thu, 21 Dec 2023 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EJRV99XG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475F1271FB
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlJ5rbRDpDoChxVFAlfxpBFyF2pr4CdhiGOc/8HN2G8giUMqQ1xv0R/kjUdupZvNKjO5Dq1dIJ+mF1GUxpVrhN3XRawptgGk1+6vtKdtTO0d6348JBLC2/GBQaZBAZ0eFNbDTQlH+EZM+saeqRInOCvEolBY7aWAWd+ivWO1rVBhQq6PqTr/fhBsuG04/RrT/OqtVr0li0gz+Oo3lSY2oozwYQWftFe5dLYErx08gWkgNsV99qMBiiGG4pt7SS+Tod0qXxuwJ/TjMgte489RxpytIiYE3JI9r9kE7yGe4V9/szD+ghvkKrDFoP4HFCdnN07j8RfxVItCwR1AHAw25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzxXEceV/Uhrw9JdczA8c8XdtGY5DsSByl/EV0i9qL0=;
 b=eEiSL2b4qA18qrN511UYG+eeUbn8QPo4JX3Du1MT94lLHaJk6qqPfZRdBTrrVD1xKMyT/z1htm4/DtHG0Wazj0cF+5maJVyz5u0TCNEZQpt82EsljDPX6Np1PQ6xALBhFtTTxxZ2e/C0eam7SntrptW2nL4ELoD8dufm28GwT9S8PC3Ops7kJBOv15ThpEvOEykyll5ldr2y+OMUQod8MuhhREhwQa8oxx8J6sIJzAu9aNb/fj5MgYcFkqAMRZSBPtL3A241vE1Dm+hCodsCh/Tp3JQ6tS4jbjyTJ0gzkRVqzIAE56nqbVOCvw06eWVtnzG3RlD403bCFGaC8l0JmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzxXEceV/Uhrw9JdczA8c8XdtGY5DsSByl/EV0i9qL0=;
 b=EJRV99XGCoHQ4h1fN3K0DJYHdQiagObaYZcl3CLDjm6lYB4OR5pjgQtjHt9XMvd1OSCu7utEYj+1XsAOvh1ZNcCVg1RqfRQo8D15Tjv3/mdfsAHctVxa847GV1xJciyxmdg0/136e1cohBbEqSKY2/DsuTH1SjnE+JPWiTvW8U4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 13:25:43 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 13:25:43 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Subject: [RFC PATCH for-faizal 3/4] selftests: net: tsn: allow isochron_do() to skip sync monitoring on sender too
Date: Thu, 21 Dec 2023 15:25:20 +0200
Message-Id: <20231221132521.2314811-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
References: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 83597d61-5e6f-444a-acc3-08dc022854fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vojt/QW5D7LbVQF5KCFN2HM1LKH18vHCYNbaCNzCHhmoalSGgIpyo06w86uVOrtjh2HHPdDCbgeKzqcH0+gzzmtvCpg6lcY95sU0KhcGIV1JyXvtScs0vwJqBS6lPw4g3y0bP1R69o3aT7r32E+CTZCyTA2igiZ+TDJH5nKCpDocq0nkfS64S6BwAQm0gJW7wOO9+o1dY2qH376CMxTKWwvQ0NHfsZ2HlAaivXpIAdIuxi+k1d/x7+pmGmwjbtrm61afs3YmDz0QALbNXhQipCEuIo6gwp3SMtRM5ElTd8nzcOC/gl7XDGwYbLyh9oaqcF21E468HbKItAi0h69qMywm95ZFo+Ys3Yitxjh7rikGb/NY5LJ6naqYmU6EhSa3Ic2gVMCeCTbs0wM9m4mfbUhwpwNKl6EQ3S17GTemXt3HqkcoYmRWFpEm+gOkpWW8lZnkPrsI2rg5VjER6D0cttjO95iKZE/6lW2EsfXIaFqsXL7+WYK1y05mqJ48uoXx+o4viLpAzAydVboBhz8lwnQMbjpQW8CE9ShFB6ZrAH5wCprzXG51PADxDIuAwVUgbIXlMD3uxShVm8wH7xVm2ewU3m6xhrxXNEUdFm2PPpE+UHNNlyPDinGk33ECZ1CF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(6512007)(86362001)(6506007)(52116002)(1076003)(6666004)(26005)(478600001)(66556008)(6916009)(316002)(66946007)(44832011)(66476007)(83380400001)(6486002)(38100700002)(8936002)(8676002)(4326008)(38350700005)(5660300002)(2906002)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GmH0E4dEShHYIrv3Kyxy80EKhbaWoU+oM8FaSanS3hsGCmXos256DSzmexKG?=
 =?us-ascii?Q?wMzmurAMWMLJdvETkN38FmS3XK4RXHOn030ZUM5gfHaBPjbGC+rlgSwLoWel?=
 =?us-ascii?Q?ZUghKPYDnfA9DcD2S03XsUtjBnDYDS+NbTxm1EJFC3SaK0hztW8mZJWepQXR?=
 =?us-ascii?Q?EWHhj9giC62bg7d13Iq4ObQE1C+M6/pkZ9iWN3GTCMZaO5JtGeEvIfJyyIeV?=
 =?us-ascii?Q?a3v2gjhuToiYKBLnViV0g4b0ldw9d8I9laHEmowzjZl8OPHDokba8QDPJWkZ?=
 =?us-ascii?Q?no6My+EnEgv/+sOAJbGcQglmaLDf9dTzjMHwUwWW9SlbZOT4p3cGo5RjgcbO?=
 =?us-ascii?Q?Lkm2oMa2U2gYbVRCMpaDhrwHcsqK1/AuehhVTUCUprCCad9CYeKsB8dqcHYf?=
 =?us-ascii?Q?iSI926VoJ3jXQi5PAmNjaoU6ODp31tRBDnIDFFOsf+Z0mcpmjWQsM8kxL9lY?=
 =?us-ascii?Q?yXShwwNs+otLGjmuVyLMm5M7BCa5AZuB/95kfwgZpoBwl0SIME4xxN2r1ocq?=
 =?us-ascii?Q?2tGKuTUPr1Rl+CduYryRbdhdLDxKP4pypWA9vLu72aGKr8BA5bP0hWUndmy4?=
 =?us-ascii?Q?cwOR8W1nxG3KxP+APqkiBIvmnVH5rWMJOYXvEZ/QTNUxd6cw7aAJy/lJoqX3?=
 =?us-ascii?Q?xSbS6vqxRYl30L1S9gi70SeZFaCqlBXciWVBsviZpcjSdb0Ro6LrLFWuO9MY?=
 =?us-ascii?Q?jSDsxYeLEt7nO+GBx22CXsQWhwhZMNYO/0+0DS8KdzSSJHDbGoAhuQS5kNoI?=
 =?us-ascii?Q?xIyiOruuNkyUNx070AnplH4ygEkrBdNgAbeHEBiK+jNqA3mm5t/0T08y58dF?=
 =?us-ascii?Q?HepSxU1JY8ZIoNsWU9HsYle68Tp3bujfJtiLR/60B+eNMUoQ+O39H2zsPo0R?=
 =?us-ascii?Q?+v9vgPhE7A2x/FXzPCz10Qtr1v1mgROjGyH4K7YfAjYccRmctyYrjlMKZ7wl?=
 =?us-ascii?Q?KTh+VoXPdgbMPbs67OX9s8jdySYfChQXMoEMxatQp992fMp6q+kY7WxBa53e?=
 =?us-ascii?Q?Eqy6mGdavITVFkvqyFzmDowyP0TqYlr6lOGHEygsQrv5Tgo0y031bn0YDRZa?=
 =?us-ascii?Q?TD+deZ+OEkL0tAvc9FB2Zwgk4O1sqA4q1XkrtmzkjaP8h2YwjMyTfWzpwhCH?=
 =?us-ascii?Q?bWNDFWj1iclfz7uqqJ5mxpy5KNmiqKh2Ht2bUGLfHhjNXlCrMdiUMHqWmXBg?=
 =?us-ascii?Q?IE2CWkViXoWqEWpolaAclIGaFHn5/BkGl18qq+GRYHHKTWbt6FxYRXYsNs0f?=
 =?us-ascii?Q?DISO7BThPIny3hexVGk1OzOurQ3jYLf5ZtGjtnCkTZ9WVqJG0plYfBDNl3sC?=
 =?us-ascii?Q?bTRAQ8VVAXE6GxkYpQ600GJ/AOaax+vEeqliVLZg6mSLSiC1TUriDwak56q9?=
 =?us-ascii?Q?gP01c1DXeNOsoACgiL+j36m9H3QUODTnHmSPL8p584DD2RP4NlZwnvcClIKU?=
 =?us-ascii?Q?HfPjv3JnEwDC+9Rs3x+gkDb7I/TcAm6MbCjoq+C3lQxLv+psXGYn7gNlyFwW?=
 =?us-ascii?Q?zQW/xeOqaAfr8tizu8fdJzqxIkUFFUQvgwKp8qGObkRHOTlEu6GKWPtFKvtS?=
 =?us-ascii?Q?dmu9a9dVzQ4PKYQJ3aN03LoV6rEb51qvZYsVXnh/D7H4qS6cPesYd0w9g7it?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83597d61-5e6f-444a-acc3-08dc022854fd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:25:43.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2vP6hiBUrDhOfAp24tGG/C5R8cr633JSd71mv+nApONpwQ4VZ9VnjuEhTmtl5l6t2KKW34169p+BD9pd3vqNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058

For testing the tc-taprio software scheduling path, we don't need PTP
synchronization at all, but isochron_do() was written assuming that we
do.

Allow skipping the UNIX domain socket for the ptp4l instance on the
sender, and pass --omit-sync to isochron instead, so that it sends right
away and does not monitor the PTP quality.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tools/testing/selftests/net/forwarding/tsn_lib.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/tsn_lib.sh b/tools/testing/selftests/net/forwarding/tsn_lib.sh
index f081cebb1c65..189bf27bad76 100644
--- a/tools/testing/selftests/net/forwarding/tsn_lib.sh
+++ b/tools/testing/selftests/net/forwarding/tsn_lib.sh
@@ -204,6 +204,12 @@ isochron_do()
 		vid="--vid=${vid}"
 	fi
 
+	if [ -z "${sender_uds}" ]; then
+		sender_extra_args="${sender_extra_args} --omit-sync"
+	else
+		sender_extra_args="${sender_extra_args} --unix-domain-socket ${sender_uds}"
+	fi
+
 	if [ -z "${receiver_uds}" ]; then
 		sender_extra_args="${sender_extra_args} --omit-remote-sync"
 	fi
@@ -226,7 +232,6 @@ isochron_do()
 
 	isochron send \
 		--interface ${sender_if_name} \
-		--unix-domain-socket ${sender_uds} \
 		--priority ${priority} \
 		--base-time ${base_time} \
 		--cycle-time ${cycle_time} \
-- 
2.34.1


