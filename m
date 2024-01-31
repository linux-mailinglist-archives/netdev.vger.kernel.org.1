Return-Path: <netdev+bounces-67478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7769843A12
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F2D1C27BC0
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CFA6995C;
	Wed, 31 Jan 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="vYjiHUtW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2098.outbound.protection.outlook.com [40.107.212.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636860BAD
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691334; cv=fail; b=PA6+LNA3lfhaJ7iKFQcaw5z/o58IXflnk8Uz/8SlQmvxvwz6M7X1wY0NycKkveUa1HKDE/fRjp0P+XqQ7GsAoWTr20sBrwDoYuqOyOzHh116GmKNTohJ+lzfYM1FyGjoOH3rWIOEIPxTthk7wv8FbBwkyMtS5dCdFzuGytcikqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691334; c=relaxed/simple;
	bh=EqxJF5ftz4fQsVid6TGZUaU+LWNJHK3orqfgL/YkWAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YusVNn7mwB5iiUqhS/1AMIfGz5fGqQN/+LHEtH+2lCpOk4+T7jJW5ntAedlAnjkY/P4TiVrWtq538IbcOl32OLdaVyDm8OcxMOBm41IllxLTveps/3H0rkQvoKHx3tcAG/x/9DrE0yVQ6tMlntAowwOSyMD5q/3fL+F3npi1SAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=vYjiHUtW; arc=fail smtp.client-ip=40.107.212.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHkX7sF2EW4iFAlzR3MpYCmd/ibAhtYAlxyqp7eTa5f/7ZXiUXQUKtDD+uyRcO6OyZRom7ALrdYT719B8vzkPegJkZekCV5yRWtgAzBIunz6AT+77ddbGbWw6Xtc/ZU+2pZOgaxkEC+lhXbT5aefBMtmRTHeRCggxZggS42Lg6hbhaTnaHe1pEw6YvOtfBsrGn6OsT5mDJY+RjdgQEmEmLiIA5L+PwvsoRdIvW6zE21CCk+W9Xjv1PtvGWmnSnJmGSCkHedIFWw23GLsZ2AewarNvIVZzIRIjrI+KmSG9sm7j9nln2HnqqomppAm3sJjfDCz6MRtGQd18dPwKYet9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa84IrioA7f6Y6Pmz5pYxz6eSi5g0RF7OWU6owWBxP8=;
 b=ecZhmweF6GeuGlB9a6tWasu/WXV2FEKa73lZZJOyQFe649A7R5xp+58MwDsbmd4wmkFHs8eFw4t90fLBIfN4uC8+uuV4ufOUY96WYFe6Bmw/t48HRWRRqAMZT7ePGgPkHY6mQTsI6bJ6SbfgKzSPv3OV5Zusy6K1FoJJJ8zUyZZpYPiQEuJN0NAu4287An0k1Pn6p2Ce4tpMS4ttjzCPWqNEVly1aqiwur8PoWS2yb7b60t8ypbBwPmP2Lh5/LNpBrx9ijKwQkSlYLdIjsItvvipyfHICTpxEwhbJ/msnZHw1011o1W4iwgLmUi9MrhhbDVLiYXElg03cYaVrDddMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa84IrioA7f6Y6Pmz5pYxz6eSi5g0RF7OWU6owWBxP8=;
 b=vYjiHUtWB3e8jnVgvK/xbUBqEhe8G26DBE0jEUW5fNylL3quZoZykYssrvFUHMEBkBpYAiVCyPoBcp9hi+PiCP8ZI7nq6kJGVB7fWSt85PFXRv3/G+vSUEHpy1ugfPafVcbXlJB7g49RZpavMOTQfvlRL9IvU9RP4zD8KnXZ5BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by PH8PR13MB6248.namprd13.prod.outlook.com (2603:10b6:510:238::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 08:55:27 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 08:55:27 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 0/2] nfp: series of minor driver improvements
Date: Wed, 31 Jan 2024 10:54:24 +0200
Message-Id: <20240131085426.45374-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::26)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|PH8PR13MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: e71e13a6-7614-460d-bc35-08dc223a5ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BZa8E5nhcD1TNbvUTLNpYwFJxDlylV8bkQ1W66pwegqWxAWUCwSGszHlFCA1MCaSCHAnJ9b1XmoEhKsK2Ve9CMDsMmIfgakEZIK5v6Vx1Ms4TxN9/wkR5SiieOhWPy+XXTLwANP2KRv6RjBmDo6vmZ8L9BHVAolS+75BKASuHG0a/1YkIWR1ndobRCCK1gS9c4Z0adwIMKRmC7fE3NHHjkTue+uVas7dsnYGMclnbDq6KskxCDsEgpQbqIKrF/mMo/m/5OEQYiNwM2G7/nu//qxXBejC/tH9T3WvWoUCdYJprp9Lbq47QqYJlHBUTsbPfrYH7wT3fGYUqlXvlTbvCrEtiH0PB6xRTJlTxoKWbIDmaGlH2lsa9QOw/+NDb7j+3ijRtv8OJ26EvW6I3VgNsBpCOAz0ikMI8LG+OwaZz30r1EgAjaA/Sayo5c8fAG1o2Qq7dsDupyD4mukXyesUdjWVg9N6wl2DbdMGqByfrc1asn/iukrnJKtmdMOgRpDkOAnzvxWLR0q14ohkyYCQyL8Us4RpPlhfJLORFgtV0OVk2LTPscHJmVJ56e7UF0fVSTTd2LmAmMpJssHYOjfN9XdaMD03g7Psds2uSdIab/ojAazQaZhsvPdxLSWaWUY/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(107886003)(38100700002)(6512007)(44832011)(6506007)(52116002)(6666004)(1076003)(83380400001)(26005)(6486002)(36756003)(478600001)(66556008)(316002)(66476007)(8676002)(8936002)(38350700005)(4326008)(66946007)(110136005)(41300700001)(2906002)(4744005)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64sK0y5CYHXlv9BbIyoLhPeNNPRP9AgGN8UnYB0TXElSscSejBisnND+uYkv?=
 =?us-ascii?Q?wLc5E70a+R2Ful8S8FwY8f54wmVAyHljNkccW9+6qq9gGjbVXHmXPycyIeW8?=
 =?us-ascii?Q?nyu6l7IquIl85IBwwejtrc4p9aFlhInAJi2JsxB/gm+y9X03MgkoOpE5A1Ve?=
 =?us-ascii?Q?X8LVs6BSjqwTS92gC9GjRgAcmKLMUciddfSiNaUIPVoNWfGNjCmtymXJJgt7?=
 =?us-ascii?Q?gV3jloJsEcuwT2zoR14o3yMu4nSewJJwluz+xElSf/7XH6VB/vhr+jaJZgx+?=
 =?us-ascii?Q?tQxjRhfBgtrUfsMO3ysvezbqF6Twwr6R7V8P/GyNyO/Yk8MDdw8o6qIYq65I?=
 =?us-ascii?Q?99950FjC8ez7HxfCGgfCvftp5qi97mpHK3AoOJWBdYIK7IkT0PaDe6+hEUkG?=
 =?us-ascii?Q?OICULjSz1ISpFARJagKP1YHb0lrljRLfw6BuNa8HueTQrDxH/JrJU8j6jCEo?=
 =?us-ascii?Q?vgXGReyc/wMsH634+mzB3fuIBMtiTZOHhnI5GXvQg5be52I2N8X+DFojmOe7?=
 =?us-ascii?Q?IcUu6fMiLMvIw/nqS7PpnjBXdaPijSrXpJMywzugEVZvcqAezBVtXP0r8KP9?=
 =?us-ascii?Q?e4pnh0UVTjnVv67AUhjV0EavQnuPiGvoRuR73J6IxFnXtC2hMqokDdMq7/Gp?=
 =?us-ascii?Q?hYPXTm2UUCw4wqkq7V5sUFq9a9+X2INMD5itb1Bqoqm/WkRYfJHTshW7MEP1?=
 =?us-ascii?Q?C7A3PDxBN4yuiHcmw8VDHODz2lqz6y3pRecirHJpQn7T2GKCjC8n0hR+llNi?=
 =?us-ascii?Q?UUdhZ+iTbXjeQgzsjfRePJAR7o22ESq6BVWy/BNJ3FynDruYXezuCZ7qFng/?=
 =?us-ascii?Q?SKz0+gQrJRQ2QqDTb7dw9BY36P9IB2Aazq5V5t9Rqm+VTEbI0UMUDXbWt/wQ?=
 =?us-ascii?Q?0EoJu93LjwGW08asIDyGiYkeN9ySw2gNAH58DDCIijeTVjQUrcoiNCkWl77p?=
 =?us-ascii?Q?h/Udq0a7ikrjKMpqPPM50DcWDxGdZeYDUqWipcpNZY5o74DOtVGKLtygqQio?=
 =?us-ascii?Q?ru2gdvZV2FHrDR+xM+S78/OZpAvKPIFAazH05+iLAJl3GQeWEV4pPp5iV2KL?=
 =?us-ascii?Q?nxGIe63OUPBNQGM//cq+tgsV0/gxk34f1mHbD988tNuqVvO7bGa/1YiqTmU5?=
 =?us-ascii?Q?fJaOSeJm3nLDdFQmYWqPTatLbSQqBc+tG3Ul2rpKGMI1QtXgznTZcy+kX/jP?=
 =?us-ascii?Q?4AS9xfv4lwSf20mHv0OrvNWVEhefqJguJTvdW7zKer8ZJ2K74FNcXpLzXLaO?=
 =?us-ascii?Q?4h3eGz6Lj194PY5BNiQAm3wATC3lefYkt4JC/ULZm4Nvb+hAhoaYDkWy95Ac?=
 =?us-ascii?Q?Q7XsPVPPFo9jjT9Efq65hWed4nlPfdbUIY33acjyoD+LaEgE2iIhvQM0z23k?=
 =?us-ascii?Q?UmN72EM/obB6oiVYs5atTJowUOeVPGl8B2yg3zewD3gcEcwDPip/ZMIt+QDP?=
 =?us-ascii?Q?sXOyqNsq5gHyD8ZAKXJUb6JGaJVvyTtKudQPCY6jkMu+Xei7bGCYoahXYRUl?=
 =?us-ascii?Q?2asgOtVqocPoHPbCNTCRI8IuWvLu1tGoDTaI0T2rZV5PiZFh+Yy6ZOMXWbtr?=
 =?us-ascii?Q?4z3N7Ge+F5sLHZUoWsdIBQv2GnJXQ9JGqFuP8mViMG7kAFnC6JWiS6Pe5ksg?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71e13a6-7614-460d-bc35-08dc223a5ea4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:55:27.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbyUIJXHTiniqrLGP+8EEBrlUQmBYpatnw32hfAIILo/R/jgWB9BOCTCp9uYOYA8EW4cD7rSoG3IdyoVxj6PsCWIatWDZs3xWUE3m/wxu1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR13MB6248

This short series bundles two unrelated but small updates to the nfp
driver.

Patch1: Adds a new devlink info field to expose an upcoming hardware
        information field.
Patch2: Customize the dim profiles for coalescing on the nfp.

Fei Qin (2):
  nfp: update devlink device info output
  nfp: customize the dim profiles

 .../net/ethernet/netronome/nfp/nfp_devlink.c  |  1 +
 .../ethernet/netronome/nfp/nfp_net_common.c   | 27 ++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.34.1


