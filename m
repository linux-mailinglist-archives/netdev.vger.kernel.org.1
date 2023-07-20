Return-Path: <netdev+bounces-19602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2593C75B5B1
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14AC1C214FE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA42FA55;
	Thu, 20 Jul 2023 17:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7EA2FA50
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 17:35:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCA01BB;
	Thu, 20 Jul 2023 10:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC7nizFUzZvKUEL9XoPwfznTwWLeE9P3bGLQhU2V9uHq14bsGI/58laYN9Li/60zMSeoc7p93mBBifnQ4zY8qR5B149O4Iwi6mmUPL10bF9xrUQS/iYjMLRvJaw0NMkfGgDGFGMXZVq9OqRmpFXfWMe6ffShrLP1FTemRvYmVCiZqdlvxPFU3bQWHHcLqhiXvyNBNMapLpJSLF6pQKsJyctaWaSfhcZiA6NbBDXFg7XG03dgb+2fVto5mh6Lgg+WKJD/7GKwvUsdLJ+tkZXNuXx+QKBl7ofku7WTZKAM+ymiiLVz3Ox+1h8YwEDVn6HBqSxoZHotn57CTYQsxFwV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Y1R4fDEXMHj96aOtrdwmogTNdBcYYKQ/o8t5BGlly8=;
 b=jZ/qkcekElkyALxfOUqHir0WGJ1OpUnjQh7q3oFkVOrJotI+/OrcWJmTBphjscZ+0sXyvu75ItnxCTmoY7jFS2Eik7cUqsjH3dsFoykzXa4Bx2TCrUFGQUjSgai58fkIDdd1dfAHegIZfMo52ckLQX2hylnFdqWLs5YYPotzVV8o0cAR9RTQJAhDIjtg2nhcs2FvK5knAtIyPnOyaTf26J9102rcqw4sxZ1OkzOLc3MkonHSYvTr327xpcoO9teqKZh9J7XLgzAHILvvqBvx4sxFYsfomudbERQdErt891UK9t/9r2OUNggwJcWNo4dTxiPY4LLpTlcZFiKmfD5C2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y1R4fDEXMHj96aOtrdwmogTNdBcYYKQ/o8t5BGlly8=;
 b=AITvB/BV9M35kzQ/QseUKbFEtIOHbicRzEWVisVwvDPSNs7yg4nR9BZuwtKU0wlH3Nz2X/1OQn//KGXppAh0kP0yi2TDMZTM6Qv4mbMWE6mDXLESUzc7ZxHh4ahjGB8Fk+LOtCa+EC6opbIdJwVA0AotruXyjcqgHjz0dt+4uQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5729.namprd13.prod.outlook.com (2603:10b6:510:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 17:35:46 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 17:35:45 +0000
Date: Thu, 20 Jul 2023 18:35:38 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 3/3] mctp i3c: MCTP I3C driver
Message-ID: <ZLlwaoOMNymjXQ6I@corigine.com>
References: <20230717040638.1292536-1-matt@codeconstruct.com.au>
 <20230717040638.1292536-4-matt@codeconstruct.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717040638.1292536-4-matt@codeconstruct.com.au>
X-ClientProxiedBy: LO4P123CA0267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 2445c4db-b3b1-466c-ff94-08db8947bfc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7HFbvQ6xQgHuLM/1eUMCgIydItoQmSy0eRw8i6vZ0YHJJf4b2ENVw9QCUTENS59iIiJukeISMQV3LSQMSnLHaLILMVqo/gcdDcw+BiHvE5KLAeyXecN9PHbtzD6GludglyTiqp+0Ro4Ir/W69yzY+dzT/fiP6IxxVFQRcJTiwSjCcn6800gZtx1ABUwja0x/VXBlUPrJ1OqxVir+8UURt+aPAMWfNlJ8B9oLp6ZXZVgYaRtvAFdoknxjkprPPea/J+uWSyGiBg+Jrdng4Bo6KK/kmZFVhLFvguTWvHECtxy9639c5OkYWnoXXPHud/hfRk2EBmuB3+eS5HF01CJR43Yl94SfbpYHxgZwO7eGip1Isi0R7hAlXT3kErqccDESzpTnA3FiCxWfcwhe+P0VIHpbK0/6eOIMpBcN6Ur5OAAwARmGQvZThcwGboH+rfKHfJ8bVE4OxwuEATgC72X0imOPcBtHI6lWf+DmC/fgx4ipTOLwSveWq7JIGIWHjHLIbrUskl1PZIBA46wsq6iukhRPluJuSVWTY+swGzWODSkQjo40aqtIc4uFM2fEyEKqs5mz5Hbx209ze7Yhv1XXZ6azVOOfBAkmryZpl3XwmYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39830400003)(346002)(376002)(136003)(451199021)(44832011)(8936002)(7416002)(86362001)(8676002)(41300700001)(5660300002)(316002)(4326008)(2906002)(66476007)(4744005)(6916009)(38100700002)(54906003)(66556008)(478600001)(26005)(6666004)(6506007)(6486002)(66946007)(186003)(6512007)(55236004)(2616005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QT9VoA7cadKz7nGQ9oTyW++of1IzE8QpqhWUoPUPXu2OB/9CHEI1ZWyPG1Xz?=
 =?us-ascii?Q?F8K22XX83KAR+qdKsCxFKe45AOffjghN4+aHlBC9dPJVjtVBoabv493bemL+?=
 =?us-ascii?Q?2a1kthDFHq+Hl5lzWIFcMvJS8TePeZXAO3Ct+IZor75vq3AqywqL2cTIEjbs?=
 =?us-ascii?Q?vJf9W4ll0UzAy6Mycu2rDEgBWtFpyB/1WgCxycxgrnAr4E8k8viGrFqfbPEk?=
 =?us-ascii?Q?UI2ZxZP43TynMTLYr5EY2yrP9rgPjqyVTZgD5mHuRkgPLUtmJjTEE6uJXnof?=
 =?us-ascii?Q?xBwrkET7eikP1W3UurJ5E9VgC30VmV7O86GBsyJ7isVXqwsNsG13uffXbgnG?=
 =?us-ascii?Q?a3vB14YL9j3asN1Qmgodc2PyIEkg5e9kP6cWHoVV4zGOGa+s14YRte8+6YNv?=
 =?us-ascii?Q?Rz+6CSkCJVKsr3kFhM8CGSO5yhBpzAD62OCJF7qLKypbX6h3JdiMeqaEzpc4?=
 =?us-ascii?Q?6+tKp/Hybzv2+AbCzACadOpCeoYD6mK1+sa+Ysm9avTKejDtB8V5S6NIIRd0?=
 =?us-ascii?Q?pZcR+Ag3KzIXthUj+c2D4fTY/ZYguNZ8j088Qzjkjso4Xuf+UOx+p4xd6oJS?=
 =?us-ascii?Q?F8F6uliGRpDPOP2b9QWxDeQdIrtgEtMtHcA0bvimcwzgVQ69K6sj1q2ENmFM?=
 =?us-ascii?Q?zg2l55083qdNYOO7EIeQiBvVzDDYyFlQ23emOUB2vfBwNY1sY/gjcnk7Wojf?=
 =?us-ascii?Q?si7Niscfp88mmvDAxkw3woVpnCOkr6LGspmWDSzUcocWoZURKQgSg3MdCBkp?=
 =?us-ascii?Q?rOaUtul4e6lRKGiSW+LcQcIXFRQ9/PYLM5UGD/m6ekY5SQH7ytWTAtuKk+qa?=
 =?us-ascii?Q?c0gFPIqjeiJ5jolt2ccoBTNZYQnV1pTuhha/UYsMxWqMdfIQNKLuq5q66GRy?=
 =?us-ascii?Q?AL4aIz6X+aFqh1WBbZksmM8m9UsEg6CUjX/qXpfContgHnZGH35hSkdMMEU9?=
 =?us-ascii?Q?EuM/syoWK/oYuRty7Z9A9Yc0cRCywreubbEWoFamtwscwMDsqxU7vwRNU4nC?=
 =?us-ascii?Q?Z6ekpR2GiD9AeSJQIFCwLjXQ82VrrM9fJ/6fZ08rdRQPGh3+0WT4Ny4tCsu5?=
 =?us-ascii?Q?61QgJUyLVz4wcZBFM7Imj1KICSRbD1VWgPQbRfqHsHDtbHdtbWX28O5r8qOU?=
 =?us-ascii?Q?iSGbXbJrhMefnhMTpXSskhinWyzDLHpjVCWmF9id94wWNpTAhJ4eiZ3g4ap3?=
 =?us-ascii?Q?k3JXKbaq3YMeE/GtrYFP+oK+ze8Jm4D2bIJGTzJ82OdNOS+WaEyWo445kcdk?=
 =?us-ascii?Q?E3d1m87Z5RUbqWv0i6+HJls4Z2aP1dD7rb0Ohe0u63R+2tQlp7bHc8ELoDLW?=
 =?us-ascii?Q?Gi4bZfLc2xm2vvJ9dCjq0TD2nSn6l5uUFK1ME4Wnb8iIyVZRDH27fFv8o4Jm?=
 =?us-ascii?Q?Z9MvkcB7iprgUcZenJHCh/g0TfLLtYRBixjQW9+yu8h5h/mwC6PUH61GK7A9?=
 =?us-ascii?Q?cSPPYq7a7SQYLXPKzqN0utqmlzbK86fSnStSy8tTVaeu9BUuf6YGhLM5ZYu0?=
 =?us-ascii?Q?ToF4WGVBLFX7NOkQK3ZTJ12wE2797qqXEkie+Wx8mEGS7YGBWH1qznM2vaIq?=
 =?us-ascii?Q?/jKqXJjO1c3yH0M0se4BC2uTGHiYqAl8blz4L3AC0jpDFCPG9RlvqaptUOiX?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2445c4db-b3b1-466c-ff94-08db8947bfc3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 17:35:45.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qyit64yBpxw2edwtMRkbkSgfSWKkX1KpNYKTum96hqAF/3tRkc4I78LsFFUeUD4VKiTIv/87ENKdQADXgMEmsiEu5/u9Wt3zESJDgDcgChY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5729
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 12:06:38PM +0800, Matt Johnston wrote:

...

Hi Matt,

> +/* Returns the 48 bit Provisioned Id from an i3c_device_info.pid */
> +static void pid_to_addr(u64 pid, u8 addr[PID_SIZE])
> +{
> +	pid = cpu_to_be64(pid);

This assigns a be64 value to a u64 variable,
which is incorrect from a Sparse annotation perspective.

> +	memcpy(addr, ((u8 *)&pid) + 2, PID_SIZE);
> +}

...

