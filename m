Return-Path: <netdev+bounces-21930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4639C765516
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64E4281B12
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3800171C9;
	Thu, 27 Jul 2023 13:32:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C681640A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:32:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E62728
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkHSikF1ZDgDyOPD3HUzDdmpw0s3JiYEdwrA68u0T2embTyY6JXFgsmtUba4cWJLXY3xewgZafeKPCU+Bizofa+TwkKBeAR0zlVYb8ojMGE5IoJM/jrKx1fzErszoznB1M91zEhSb3S8dwbx9MpptBB1nzqS7N/lDFhYoABc0pRPO3k+MKwhXoF4Lbbs2xV9Xbe8JRSbJA0H7u9WDJlpK0lDmfFOQMxZLQUMTSks4FMVWjCMcMWQRH+kR0zbNR7/kedOiNIHsPsCnL9vEdgReOYdtSWQXS6LGoJso2ErjQ4PgkojzPqVbug/905dC+zDe6OkwOJ1hEciVnswQI2XPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhsi/sHKiprlb50sULVUhioiAI1E4oitkBHgJ1SCL8g=;
 b=Jk3e1xCGUwNJuCeM3+uLib1ZJhh3A9MRCg/3TlPngHZlNtya0668ZB2jpkNvgVCQXQL6+JTBqUb9ZElHWJ/Jd4WO79QKDZUnYSXyX0MZ7LjYx7irsJOyk9RIDOI7k0QpZF/uE7BiPDtV78Tai+aEj6amY4CIzg9RCu8YdvFupv6dYyJy1luOvT/BoXT56TLixMM3fvF0UKD4YY2RfEySVkNj3I9hXfcUud4nxEx23MHuLeRYH9I9aauHwzyWfPZNtgEiQk+SPtETQ/tAmvoFW3ryVzdhs3qQzBJR67DWLlg0AKB8ypJrXpsdy2sKZ9y/dY8cso44v1G9kDq14LyjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhsi/sHKiprlb50sULVUhioiAI1E4oitkBHgJ1SCL8g=;
 b=prw2dfuUwk+SqWe5okivSV3voxLuTjxpjpOmwecEJ2w5au5buRe44KjAnWq6NTOpIRtEIGibKi2fK/1HbLMmayFQM2sn2yBVgnRcxxdZngy7JdwUEwjakBXXfUEhRECO01ZuxhL3pTZvkDFevcI9iQdX6SNJTWAKnsOZ7cNTYyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB4951.namprd13.prod.outlook.com (2603:10b6:303:f2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 13:32:40 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 13:32:39 +0000
Date: Thu, 27 Jul 2023 15:32:32 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Chen Jiahao <chenjiahao16@huawei.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH -next] net: bcmasp: Clean up redundant dev_err_probe()
Message-ID: <ZMJx8JnLPBbsR1Up@corigine.com>
References: <20230727115551.2655840-1-chenjiahao16@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727115551.2655840-1-chenjiahao16@huawei.com>
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0a8046-fbf2-4529-89b5-08db8ea5f261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AonZMURN7eV8QEFsfsOimTCwYCRbgNhLe3Bblte9/lb3eX2Py62DIZcyc3EHAdql8U+sR4mmYO2HgHQtUEv4OocR/3vw4vYyhv5WVB/Mi+W9A7dFFBeor+0PFIzbORBO1Vd04Y/lO5QDH7TuBk3YmnKj2O0Z1QFfwmTMHWWAlHdLQDzOY6lXuOa3O0hC4tuDGoBnLKCkCb+3XIVLNNFO4zYmz+xrgE06w6NZZ8TCEXYB4M6Z/Fy31LE01d6GM5L2zHXPhsNjbl7oe5fpxvjeRwiDXzllj7NSoeaAGKW4gFcDRJL3J/HMj1etIF3jm+mCJu1vMyffzs7tTCdR4tCfdgQGwTeCbR4DV+4otWnOn1SDrm5GuvNM1PmILWYO0cFlye9+CPVAMLDqCD7I5p3Fip83okZx9tENo7j6MCq7oY7wSJJhe8WwQLMgy5ezQJw6DBCV+QYAsnGXH+nAQ2Zmzi0+MHC39Q69sGKT6j8OC4boyozXgh5hRuh+WqsKstq0Njcr7B2G96qCrBcyE8/X5RXxsOK+WVK3kFErpgSxDXhEBB0d+MAbxEEWjq2NNivcpULGZqovPTomz6BHHLuuha9ds2YIEgHWTKoolzEVqQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39840400004)(451199021)(6666004)(6486002)(478600001)(83380400001)(6512007)(6506007)(6916009)(66476007)(66946007)(4326008)(66556008)(186003)(2616005)(38100700002)(5660300002)(44832011)(8676002)(8936002)(2906002)(4744005)(316002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWa/na/NvrR8K7RlXUjB66aDaiFLfbXWC9bLmxlfVunPJ4g53ue2q8AZ9qOJ?=
 =?us-ascii?Q?tRz15doKTNf/u8UNTlkaKCZsn1f1ym2w+6eJkRKYSUx7gNlMIytzZPWyXJBi?=
 =?us-ascii?Q?revjYrndZeJ9VsY+EriVAXn8Ipk761m/KXeVZeRpj9m5nx4S82Hyk4fYrvsN?=
 =?us-ascii?Q?dJ2eYS9KID5nPO3uL9OWcbV/7tYol7n6lZ8kCb0wqKEYFV6Tvl0b78Nq2T6d?=
 =?us-ascii?Q?bLPopTpOOsGnEluHwqgcjgFHdT5SOXX5BwiU0eTonQ92z9TjS6C+oDE0d7H6?=
 =?us-ascii?Q?OQg1eXevXJwsYDg6/OjtHqxRySQCdPKW5h2n3nw+XeHwJM0uCmMWdvlmKitZ?=
 =?us-ascii?Q?e2RCwLDEqQ99ez9Ir+vv1wRvO88nLAnutnGBQXt5B40RNgiLyR0/jaoboHSY?=
 =?us-ascii?Q?UGLo24fiyP+Z1fXWBtDGatlCduLveRS1mmrLGIxAV+WHbklaDqdMdL/5cchu?=
 =?us-ascii?Q?7vavkR1BU+NRC0yuRrEs5OZ1xHQEBIF5sTgcAsWydvqr3uw5+LjiqV1jQfLM?=
 =?us-ascii?Q?1SPJoS0c/RKboN0+nTO80L05MgmlIurIZlALORQ/Bdr/sKh1wmJwZK9BgWVA?=
 =?us-ascii?Q?Zi9o9PxYxcAGHZxkWVZaf62a+OV3ghJ0zdFP82Gstn2zAGjoX1aDmCjwoKn9?=
 =?us-ascii?Q?TsvWIZR/xE81cvndIzGepek7Qcw746G6CMJwL0FUgl/Xhsd6hStMZU8UmEZx?=
 =?us-ascii?Q?yHWBGEYN+WGqdUfWqsdHBhk+I41IeGTWnMHb1aKt7TfoGSlj7N/nTAw4tx8o?=
 =?us-ascii?Q?t5wrqM6S3tL9gJWmw5PsFi+Jd058zIJoHRSt7UEYta/D6z/xtEc1wdJmr3v5?=
 =?us-ascii?Q?Oi9Ov6xSoKc8mntRI+U4avLRQAGkQz6CEhEqQ9mCas+v2eHAZMP1zpGqx3Z5?=
 =?us-ascii?Q?nax6fpeizo6/SQJ8duRYUB6Wxx+RcUcWEj3PPrGl04Sq3QdEP1F4LzcOpVb5?=
 =?us-ascii?Q?FTqdCz7lAYdDynldZO6takF9Dn8mRsi67ftr1GiaWOje01Z4TR1qHQNjoi5h?=
 =?us-ascii?Q?r0BmJJdn3QOyPBTaWfaL31ScBhmDwMKvJA3Rnv/0cSA6lhtWTPB4er1d9UNh?=
 =?us-ascii?Q?+qFzCQMkkmg/rVc8EBhGhuc13+rHDhsQO1mdx0zWDJdCg89TAnMiA7XYm3Od?=
 =?us-ascii?Q?eeEjqLA5+afFYaRjCIlhjptqTjQGJzdo3lgcmnUIzNHQLAnDAl7mMyELFdgJ?=
 =?us-ascii?Q?83EOpEoPTZGuIGJl8qsxAZGoHK16WIXu43SwIEhuhhkqL8HHdAIjmvpS7CZM?=
 =?us-ascii?Q?5QJ1c5U19c4hdDxyU8PFXoGiuO3T0gKA0fjxQkHG4ZjNxVuGhDlU+pauVTXw?=
 =?us-ascii?Q?alGpHafQBzEI1/fDCfKETKAgcMMj40l/NADso0zTGBqG44HKnsLqiytizRM5?=
 =?us-ascii?Q?tiJj0u8dLa6WoQjHGUb45BD9G9GdhH5ZnAwqehw4SWbv9I0dGUA2iaM5AvGC?=
 =?us-ascii?Q?AmT6cKPfuYGRipfAMaoriX+StXQyRPoimvuoiDMmb6mIOGJDZs/rQdrjz0d/?=
 =?us-ascii?Q?I88qq2XUbwV9Y/tzNoq2hkCSRdybMxik7PZLRLzeNc2N8jNtN4OHnCDdNR4t?=
 =?us-ascii?Q?rkIdSPlhKxcNsyoxgpgsdywEiot2qjnFEjiiu5TEx0VsrA+BCqhtrjCLhypq?=
 =?us-ascii?Q?RI4chx0C/b2G4IAmrj31sxltlZFc0f1TAnwA1Z33ZzfNVWaEGn+HqZTNj2Jk?=
 =?us-ascii?Q?WPn7jQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0a8046-fbf2-4529-89b5-08db8ea5f261
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 13:32:39.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+TEs8CtNssSQd/dJFirIcbPGl0eNEKNBoWATnZ3/MV2VdXMR6a5HtoURMG6SdIHk0I+enoc/YW9TmT1DMpTY3QFHzdoKC6XgcMdLYCc/yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4951
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 07:55:51PM +0800, Chen Jiahao wrote:
> Refering to platform_get_irq()'s definition, the return value has

nit: Refering -> Referring

> already been checked, error message also been printed via
> dev_err_probe() if ret < 0. Calling dev_err_probe() one more time
> outside platform_get_irq() is obviously redundant.
> 
> Removing dev_err_probe() outside platform_get_irq() to clean up
> above problem.
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


