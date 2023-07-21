Return-Path: <netdev+bounces-19837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E92D75C8A8
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4593B28226C
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F81E539;
	Fri, 21 Jul 2023 13:56:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC221ED22
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:56:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D135A3
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECyS0DLI7A1JDmolBXMGTNuNi5diaLHOmf/D8Ejp7LihIRt7J2rFWyy09B+/TafE8dpkc8FtnUiJi5OslgvglyP0kuQRX4kyDIZp1fAVG3nF3QbDRHiOZ0oxRK34g4SNvgC8tb3HtDJpC7t+2Xxj+tp5LWP0nAYUhutm6/lr/uvO95bxefTQ9UOG5JvYQ+iAiyC0r7wT7yuwO0gWEnyRcJiHwLkJVZx9ug1Bonhc8X3Yg/NG+dJS7ljk9qERb/CTR9NySCY4empRpdrIJlY7FB9iiTbkK+IV1PLF5y+MpQz5IyG1h1G/kLDPbSeMdiv5kuBuvzGpBF4QH2RWTN8VPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IIxmLdwc8HWkXwDBH6blQOmeWuz/a7ZkjjOgaAShHA=;
 b=fnlsEOTkZqhMEB8kqO3yLPXeaEWl95aeqb1UDvZJAfzwOhSTVWpypxee6kGsQX2c4A60Jy0yH5pf/HyTQAz33yUe5vjUGu8mjoIevVar4wbc2bR7ieFaA0EuGKAXhk3HFMW0CTenr1pG11jN1kK4T2oacUY4ETbI88GgG26eGjafidEZHU3qTZlFR13XAmBHjWmHSm7GnPET1IBllP8OPObLA52RWn8UYD5DKWnWB+v6fRokyjFIxxJciTmA+/gbwocsTgr5gAfTGnlWhzVdcyHlcPbA8oHSttN/pCSnkUre/k2sHsw9NXunqTXxdU7/0BbgohzJ9Z6ScAhEuSURYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IIxmLdwc8HWkXwDBH6blQOmeWuz/a7ZkjjOgaAShHA=;
 b=WbhmlucXSZiyIhsjKwn0OReH63l8v4NWSvSHUGOtJjxrL9j/EXLWoadmlNl+goHqazdNk129yFDm3GkMyPya2VT+ctqdAZYBL21WoTSani6feqoSZ69hUIcQoXt4linuw+b6Z3hLG6UTftBqO8WHB+q9LXrzFCNS91UEq3dEfYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5674.namprd13.prod.outlook.com (2603:10b6:a03:401::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 13:56:06 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 13:56:06 +0000
Date: Fri, 21 Jul 2023 14:55:59 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: Chris Snook <chris.snook@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] ethernet: atheros: fix return value check in
 atl1e_tso_csum()
Message-ID: <ZLqOb2giDzKrrP9J@corigine.com>
References: <20230720144219.39285-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720144219.39285-1-ruc_gongyuanjun@163.com>
X-ClientProxiedBy: CWLP123CA0259.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:1d5::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d495682-fea0-4577-d86b-08db89f23a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ar2N7Pyqr5m3sQqU9CmfTMXA6bh3qcGl4CuHFIH7QbTvcE/pFr+7MNrjxLhvw0uI/xcGlqRxYOzRkzuQFN3C13xMeNBaIMYVnMsbv4Wt8ELsnCjIBSMDEzvWw8RNXJhikJsmr0ORtFAwqyNIJ7XdMjy5w+CeJZWOVnARh5telXy0bxLpmWCDXwxg8YPKwuo1yCVMDDmpvw1mzcr65wDPODHsDDpLJEZsYyklcvHJJ0X0SIJZo8x1ZuxNxR4UdMDP1Ju8khjpnKSWlb3I8dg6RvgzAFup2eaFYfzp1u6Tgjy6FF62AT6aYZZcAsIx83Dt7o4jp+rF1MJXzZQ0TXRNL6dmZe6yUtN8h2CWDH+gVpuafeUtvbaR5NhexfSGCZyKCpsBJlAnxuMTsc7g/I+0dn0ZI2KL98n+Brh9ufU+gLjVk8dHaxhHFDbbvSZfWpDukEIL9Saq/1lKT1xYquoaFHlzev3Bk4EDnjbbSL13lQmHIjBhoqnC0SaIPJYDUJDYnDaksM7riAzmlzjWfV9+O/sQSksZkx7H0Vo6FBPtAxXBkyUYyS7SP0k0GVOtWSGvtCmjqpgoN7U1nzLQmWG6ZFvnABF/oFcQg7jSDlc50Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(346002)(136003)(396003)(451199021)(66476007)(36756003)(86362001)(6486002)(6666004)(54906003)(66946007)(478600001)(66556008)(6916009)(4326008)(26005)(6506007)(55236004)(6512007)(8936002)(4744005)(2906002)(41300700001)(8676002)(44832011)(5660300002)(316002)(38100700002)(2616005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f9U4sQ7W5nhnxrMCP/EPDrkmJCLP5Y/qS7y4amuhp7eM/tF827+5Ksd3xey/?=
 =?us-ascii?Q?30i7zP6LDYI+QIxJkLlTzf/rn0x9grz2oy2w3150vJEg8sZcyIk118WY6pCh?=
 =?us-ascii?Q?fZaYZg0tn+GKtJu15r0vtKXkG22coOXMtumb6Sw/fGyITexK+KAo7BzMW+k5?=
 =?us-ascii?Q?NO9D72fuoGlCl83euqHKGBw+36Ueeq6tC47ehuRsSVJbqzkCWHiigfQESjsm?=
 =?us-ascii?Q?RiriD8fCPysHo5oVptY7iYiXqsCD4ejze1ay74/xq0Gs6tta0C5y5UdQtItX?=
 =?us-ascii?Q?Qz1+QWYCNQuDZ4qz6GyaDJ9oE0VHi33c+kWp8wZfvYISbc0Fa75p9IzyodrQ?=
 =?us-ascii?Q?XKJDGfWabzwDC/kHANcpuxGskq0NTudCbIwQ8+bBwqSAechr2gaYy/SLenN3?=
 =?us-ascii?Q?o8XgL5dBxK78r2PTHTB9fOJxxI6g3ABPNjDqaL4Lu66GdFSb5dC+9nrz8OLF?=
 =?us-ascii?Q?aHS3v+FqgLj9KwtkXeynQHPePg+Wq+yF4GfED/j+jL8V/IcFFdUsDZHCx2mb?=
 =?us-ascii?Q?wFfWLNC4PYRWHYMm/w6MRT6QtwSHjAOfhrgKX/AH2xGjxH8CZ3/Nm49TYQZ9?=
 =?us-ascii?Q?OnFDtiZ1Z9aFiUEtmg3bHfI8n98EHbfmQmkiigAFwT9N/agyDoEln3g4kBrl?=
 =?us-ascii?Q?QuW+VZdVVe0JTjExjBwOf+m1Ab5LcY9V5pd7LV5K9Lb3HQIYf5w29APiK8i9?=
 =?us-ascii?Q?jZOrxeeczBIzNV/JY8wRFtkFBlEqK0KX4Jg+w+qig5MtsO2ARH9p7OKSDU7F?=
 =?us-ascii?Q?2wXXd+eFm6dLYIAIU/Bmen2ns2CZ3Ce7D+ANPbgtVTrAm1DjWHnWAQfWYVF1?=
 =?us-ascii?Q?a6i1NvaJcJUjPqadJA4uUSPKtDWXHRBV+sLwf1jaYNHSh25eQf9pGvinHfSH?=
 =?us-ascii?Q?i5scFwClakWMyz5uiXJl43YF7XGWiMSY5NC+ZG5NID4mq3M+/0Av4HoffnP/?=
 =?us-ascii?Q?EvOEnE0SFCIuCTGkG1EzMkTtGrh4I34dIPwX/hi3bWe25D+rjHjgIVPHlkT+?=
 =?us-ascii?Q?Pvbbix1CSPawCVlOkSW5C6uYHdbxqkSk1v2/iZltJ2xRxY+SLvxpDKEnH7/Z?=
 =?us-ascii?Q?U1cbeDJDF7Q2f2NUXkAyVEFEijn7pZD0V71j4pqiPvk+7N8ZU/9S2qCfBIqo?=
 =?us-ascii?Q?v5NmCZLxq+g4qVkscMSEgTNfmOMCtmEWq6PE87W/D79V+CiDcZZnWP+EWtD3?=
 =?us-ascii?Q?C1dVU5NU5CPhs1P3dWaBWnDImzoPsi0joBFonotBkGNCDi5CsW0uLVVmzHrY?=
 =?us-ascii?Q?d6vUfi4ql4ohRNIpyU4bGnh0JNiuuf4934EXwAbuERBpPa4Dp+fNsFB1vnHr?=
 =?us-ascii?Q?affNYjwf4SIalFRuQQIpG6h/OWB8+N5U8ZVoU97hv03b5oIZ6tFV2kFlJZ34?=
 =?us-ascii?Q?pAhkn6uxqYSZfarqYebtzCHWOhN8FCG76mO2sOE2DPzIJqLYyv3HccnXcNpD?=
 =?us-ascii?Q?pDebXQGaF32uvmcF3xzw9ieSO+9nXG+AJGTjM6e2fSGv4XRYsvBPehhHBqrM?=
 =?us-ascii?Q?amXu8Ez92qZcY13eddjo+CpSIGoo8pCwyqv+X97iastHqXe8fikT5fIhINEG?=
 =?us-ascii?Q?7yBegvKuKZ166QewQkT77RnLG/PAsZqX5b9w4LeasDXyRHwJqhs5QJ8iT7Ef?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d495682-fea0-4577-d86b-08db89f23a6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:56:05.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0t7CAb0mz1l45zRjFZylCkxEyfAtFehMHuYBRhwkJXmRX7A8jTS9HTFaG0+O/8gn4g+APhDNxjyB/eV9bLlpLAEG7IWY8m337o1GdkyhKJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5674
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:42:19PM +0800, Yuanjun Gong wrote:
> in atl1e_tso_csum, it should check the return value of pskb_trim(),
> and return an error code if an unexpected value is returned
> by pskb_trim().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


