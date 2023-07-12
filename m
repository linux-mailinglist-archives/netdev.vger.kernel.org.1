Return-Path: <netdev+bounces-17153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7405F750996
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E791C20F83
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01582AB49;
	Wed, 12 Jul 2023 13:28:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FCC2AB48
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:28:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F693C0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJTWQwuwV6zq+MrTzrlynQv9gxprzuJfMlAYETlV5xa/KqfoJVywTpSzBspJ8PPWJSsDcHmoguMlOcdoYhzSsT3td7r9w1S08/tZnNZ7Fkz7SB1IYo0piOBNfd/JDF+opfumTXoR5Sh7MRYEHW7inKPFoDuzAklI0JyYhqM0isAEY/0GKxrc/TJznYsUG3rRRUYF/ADBUEUXZs8WUNhaIxhcaAZmsl+rYCQIPAS4yC3Wa7HEoJLe6LjXhNu7RNNU3lrqrEeJJym1k6KXsUaL8r8iVIh8TJNvaTd+QouSlBKcR7DCTvx5W2rq2RXRpDAF6EXuJSyUUthDVNKC3dhEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU7o0O/YwytSA7peMl+eVuRt+JCwNJCTk7I9X5alf1Q=;
 b=YAOweP7pbkhoYdIC31ZjvZlABN+o1Z3FooHdYilPCRak5iB3hDeDTvpmQ/Ej68kzXn8Ndgm1WUa4uuCAGSJR64tEW7S+o9yPs6JvrDBcxs+A1ZLyL641cNGZw04bdkaPJwAap77qoMW4FoPbud9AhnPuDvxXD797ynMlnPz+MxdPXUsFUp/MX7PgYz/nvtrdTO63FFnyOo3bOftzwuL/ZN8r9R2C1UQGcfjHGqINRWMNoe7QNU0RnWuklVOWySPpyjoce1Rd/U5pxdJ6Cf+ny4cUjgFe2cgd0p2xtJ5LotChBIRhdxi7KbP/mkSAkk84VX+u5m6exZDtLl0ic8aBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU7o0O/YwytSA7peMl+eVuRt+JCwNJCTk7I9X5alf1Q=;
 b=bF+SPapceFbGIFV7aPfZ0fGA6/Bj7jzsUIwXX7sHzDtb6cEKGfcSfCvZQjNptgQ2rBV7OF4keLnmDloSDgrKJ2zmqKsTuxba7VyNdz9/muWYT3jE+E334KU8k/wEF+Ra/hVgjx9Jn3jaxcyHPBOKQXdS3mfIQbGiIEiFh83+PmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5403.namprd13.prod.outlook.com (2603:10b6:a03:3ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 13:28:48 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 13:28:48 +0000
Date: Wed, 12 Jul 2023 14:28:43 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3] net: txgbe: change LAN reset mode
Message-ID: <ZK6qi0NdzCVQFRIq@corigine.com>
References: <20230711062623.3058-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711062623.3058-1-jiawenwu@trustnetic.com>
X-ClientProxiedBy: LO4P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bbce69-329d-427c-f3aa-08db82dbec5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fMaHVF4NsNPMehsTBh0chSt334oxgnPWf5lx/v1oKlOwQETGjOPQRDpd5ZykFshggkd6LNMNDPhgc92Da71OcgSS2e5mQ82OQywQhc50KqmQXq0NGtdw6+o6wGGddiPCxOvfi9xo6d7mHuuH1pKr2h4yO5TUdtyoUILaqDxFB8GTRjI6AS1ezWgFEVL6CkBNLy1o9TkU+FpFqzP++LYUXlhH2y31CdlOOTN7kdSFXyZ64cnPo5cKtXa9SYvDnzZ7XuTfL0VWPLN9x5mURTnHyyYOFlAhxTNujeL11hZqGui6ldL72n00xhnaKnejqh32bx46dQJhA++g/lWuLi4dejmydGXf/+68na1XuaYU1zOWaXML3eTI9u+69+BCujYcGlWjm34Xxl8mXO+whb5mch2V/O4qbWMpRkMZrGwh7sQeh5o5hDcdMutmi7JL49cK3cVShTdRDypU9s9aL9FYYaml9aKMRUMALsjkj7m2sSsCeMxtX9/uYqnSH6jGdQjqq9wom2t0VEA7JAKv5SDTI409X2UbXCLtjaE293ZoONZCEbwZtw9gcl/So/23sSNOXMH/9ilWelFPyMK/aH+QR6LhNAB9wbPCAiWBh44mWr8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(366004)(136003)(376002)(346002)(451199021)(6666004)(6486002)(478600001)(8936002)(8676002)(5660300002)(4744005)(36756003)(2906002)(86362001)(44832011)(4326008)(6916009)(66476007)(66946007)(66556008)(38100700002)(316002)(41300700001)(26005)(186003)(6506007)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LA+Sy0TMJ2dA31gYHHEGI41DnuivKq5X+IypZiimEujlYgUIGoWrn8zMHHrE?=
 =?us-ascii?Q?QSEnUjbQgU/2xVhxkr+ULQGSN7G3V+fhdFXbQX1zQZxhJLOqwZUEsktx/nIV?=
 =?us-ascii?Q?NPC8maNGF4W/1BP+0Ey3JT0VgvKpC0G/sv4IHs+On5fqkNTnX+tDiy2J3gco?=
 =?us-ascii?Q?CG0V4veZ0vXUQOxHKQRELQ8W1aSzzjRneNZdFylBZYVLcn3Kz788pZGa0xW9?=
 =?us-ascii?Q?Yr1b6t0ZCUeJpGNrZswFdHs293vOO6kjUcG/7Oj9lj8hIdF9lDQdgmLcHtEH?=
 =?us-ascii?Q?2UhJqj9YIabJdGkAamYIVATku326wmRcnBplwdaVt/g9hJlK+hZay+vTS4yZ?=
 =?us-ascii?Q?3f9TNkGStcc7Nxh4tlneGH0f8SvlCphj8KScflC7D6x5t+vtko4dAa7mZtwA?=
 =?us-ascii?Q?pcmw1F9XVKEQKnmUxF937iLxH5CDzCnUEwDiEjrHiH2QFRY630lwZQai7Bl1?=
 =?us-ascii?Q?h94SVrajjDs49BknT1IIOsnkQPI3K11XWus0vlzUpVZpsTCfqAdOEGTMkFQV?=
 =?us-ascii?Q?dKHox2oqeewpvbzlmpu1CpVsYvm6tzszM8u/snS8YkyDkFGQF0SI4SmFlths?=
 =?us-ascii?Q?Y5Y90+sqNpkMuQ+QXsZYlyoQ8gCJlo120C8jOHfG4QCBYDmsVHFIJQ08oIWJ?=
 =?us-ascii?Q?pCKAjUAcdOXpJRGg1L0xowtTHLOtZl6EorD+DjBp0LrLaACEh949i1LhSoyB?=
 =?us-ascii?Q?Y0B6KNFCa0GMaLn2VX0mRXlxt1kJjcrkUjbS40rtQurxgYM0kP9qzl5yvSIK?=
 =?us-ascii?Q?xkpniUH4b0EwvXhxhMvXJOFZhYfjHBsliQ7eDR168ss57HzazCBnnlMCc+Fx?=
 =?us-ascii?Q?q6yjkpg/WsXiFzY9IyRrcBdSmkRBzCXJtDCSATB3ApNE7Yf74j6/tq0n5fWP?=
 =?us-ascii?Q?3J1Q7VkPE75Np+8ZnHk+UAkl8H6Gc7m+VqHEsf7qvK9Bb8Ux6oDUKtTT6/fz?=
 =?us-ascii?Q?EY8qEtbV/2KRGEVZhteODl308KjCbDGPKZxFyRCHAspnmjpt+RXWSSb7s4SO?=
 =?us-ascii?Q?OawuU6FCQOKVaKDNjc7+gRJZHo807qj1bzh91sgS0BNfox1g9M+bTQjmENcJ?=
 =?us-ascii?Q?d9bJ7/45CsINtguEvFIkjbAEUBHL7BUA4kTJ/JLwooZkhcbJ68t0ZfFFHtRo?=
 =?us-ascii?Q?LMU1XKqjstFRGpqIXA5jh93d+aMY58cnyIttYu4rxIpDoRMNiyXI3R6AMXby?=
 =?us-ascii?Q?gfJ67n/5fiaupldVlrt60XO02tN2YgLYNIxUh0tA3Qvp6bLsihi6vpyScUVd?=
 =?us-ascii?Q?77mbvNCFNgUNDF2tzTtHVMiPeqGukg4FQrun17Q2Temrzod0EkkIILcMMZ7p?=
 =?us-ascii?Q?268YxUSSTKn6RXMJHfN8VeAbc1YSFNzgUMoAdVHr3J2CuQ0A89JIZXGFAsCw?=
 =?us-ascii?Q?28vCd+tKsC4wK54c8ugSVRE0lsgUCYpWeC2EpseFLjlTqM2F7Hj1TYjlhtvI?=
 =?us-ascii?Q?lXwKssno1+LAH3v2daPIMj9eWAGWSfSO7MBB7balxqokoAB9qnUEq2rA3lqa?=
 =?us-ascii?Q?jwV9qUwsBZRecguGm+PYdqlz2M97pU5iKdF0jQsmzoBQWbxth7dh4BLHn0JT?=
 =?us-ascii?Q?cza7kfygVn2XrcvK19DXoA+byXFH9cb0NWHbNa1xmE2Zpb+vM69ClcKSf4FK?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bbce69-329d-427c-f3aa-08db82dbec5e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:28:47.9499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YtaqLvEdI4KxslbwOKa9j3ItliBfAFr3LBMtl/B5kzXLJyhxW79RMhSbVKI5GjLSgsLsBKf1wQCZF0NSDcI9izTYeUHmNI45NrOy1d3UUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5403
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 02:26:23PM +0800, Jiawen Wu wrote:
> The old way to do LAN reset is sending reset command to firmware. Once
> firmware performs reset, it reconfigures what it needs.
> 
> In the new firmware versions, veto bit is introduced for NCSI/LLDP to
> block PHY domain in LAN reset. At this point, writing register of LAN
> reset directly makes the same effect as the old way. And it does not
> reset MNG domain, so that veto bit does not change.
> 
> And this change is compatible with old firmware versions, since veto
> bit was never used.

Can I confirm that:

1. Old firmware works both with and without this patch;
2. New firmware works with this patch but not without it?

> Fixes: b08012568ebb ("net: txgbe: Reset hardware")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

This feels more like an enhancement, to support new firmware,
than a fix: old firmware works fine (wrt to this feature).

I suggest dropping drop the Fixes tag.

...

