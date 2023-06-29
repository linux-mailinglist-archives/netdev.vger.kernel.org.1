Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB50742D96
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjF2TWg (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Thu, 29 Jun 2023 15:22:36 -0400
Received: from mail-co1nam11on2103.outbound.protection.outlook.com ([40.107.220.103]:51969
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231712AbjF2TWP (ORCPT <rfc822;netdev@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1XI1sfeg7abdSypVyjK4bxopkCTMwVUlTh7JOiwcsSXI4Gi1XZJ4rTIwyD1mTOdwZUm+cH2GSobRaTVUxn/MgX6vr18mvQ7XASGgC2K88zm7Sk3x3g8qGKgfdCbLJl2+QaWPmJXfoDhYoiTNiK9/vLK18YV0cUf7iaVKyc4L4nH7A4jEYhGF0xsAqRXNJsQAb4amHxVO40WTDoOyzjS2lRin9gK8+xWPu31s3P6uBkFZV5WXKoD50jYE9oEAlwXIkRKLb3MLDziY7R5i9miNd9xRG5z0fPxuNa8BibyrcXePNUzAzHFUGmGIRFdzAGGpc5isIHow1AaXznNSX6spA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+4UHBJAoE7kuvnEIP9Z0BgeZtzKdHA94RPBZy7UUgY=;
 b=ch6n24PRnKDCIEliR8HMjkWkkyknBdF0bCA3Rip8mXE5U0dVBy0/l9j4wBG13C5cz52tzWBCFEmw/Dv0v0hPL4tJRjuwitM3CS3n4VpAgY1BeImjOwHfRwjdMzSmaI2et03Gp7dSkHCi3/eC3frXnKfykULKVqm3yYn9lYSNVppDEdRLODmtQIW0GzsnJi80NSZ+PBxl0YDBQE4wBbgafYdgEMs5DQNFV1rJGXfeQ9S4icAFlzcNohuVpu8PRvMcQ3SGg5tt69FHTrjoJuSNmKHs24Tngu12TG/HuBYroC05uT4Jx5OkKlwlVLd3w1nrKPQlfg+4p6GRC+Ymyqd+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+4UHBJAoE7kuvnEIP9Z0BgeZtzKdHA94RPBZy7UUgY=;
 b=YkPp6hvkoNqhNuJmJKGCN/WQ0yDEcJVnp+E8i8RLWWmlHkHIXd07gDcpo0RXBGeCO7J/5B3q0ZBbS1P2p6/WFX7q8nEExDUBksxY4MvYnkESwcCbq84uTQPF8iPd6k/nvImA9ZtzHf/REdUmDkpfENf9NnNsMxG1tgXXAT/ETgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BN0PR13MB5197.namprd13.prod.outlook.com (2603:10b6:408:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 19:22:12 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 19:22:12 +0000
Date:   Thu, 29 Jun 2023 21:22:06 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net] tcp: annotate data races in __tcp_oow_rate_limited()
Message-ID: <ZJ3Z3jBp98dbFG3k@corigine.com>
References: <20230629164150.2068747-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629164150.2068747-1-edumazet@google.com>
X-ClientProxiedBy: AS4P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BN0PR13MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: f806b0cb-b8ad-4ef0-d17c-08db78d62413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5leUU7xSZidnPDIP9yvCjgkL0sERW+6hSRk+lJZsOmk0V7yzJeEO7EJv0aGMvAg3tzleFr5yLiMuqO1zZKRWjiYCHy7py1YeCm3vwtb5P2Ua4KL7l0I0iIUKj4RxLgjh3pPkc14jvzI02k6U8KfmUZP29g+lw5SUjK2/SjlMuGB0HagYuBY5Mv/Av+qe3KvjiC6dGM3zh6eOLgdDChrWYlLnl5bg40ZLSgMmqMndOh2GKmFsdW//XPEYvxU4N04pViR1NOwgAx+H17TFwpp+nsG6xzh1lqLywbCRQ/1BRnr/I7UKNHnpyKRnAgGtzgSilvjyaqbIoCEDhenfmn8N5S1x2mU7NUkMWP5dNpD9jGomy8OEWLWXt+yB9MuCiSveTkNvS4dz8Wf4F3HElX3t0JQayUWMuHRNL+x23dohpEXpvrMRGRfatVMKzS00pPE32KEzHkYUbjlpgJ7bXCLOkv7kwkxGP6q3gqQZNkZRlFsg5fXoXZDlV+WE0AWAMzuHKDFwl9fOG/78x5fPyMoCUzRG6wwYYaVjpHUyXvqZ28bW1y8zjPoTcqYFZDZm4UYdvT01sDp0AZUC8d90oQBqAPDLEyAqgj9X/aQwyLVz5i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39840400004)(451199021)(6486002)(6666004)(44832011)(8676002)(8936002)(478600001)(5660300002)(86362001)(41300700001)(316002)(4326008)(6916009)(54906003)(66946007)(66556008)(66476007)(2906002)(4744005)(186003)(26005)(6512007)(6506007)(2616005)(38100700002)(83380400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q79T2nNPb8euGn2j99iU7P8WhR7X5DWktKv940H2cXw10blEQr9RMNmoR1QP?=
 =?us-ascii?Q?ipJj0yVsVfprD+P9jABtBZzp32xo0Z40qYVXyqcA7Di+CpFoHg5fg0tSHTCd?=
 =?us-ascii?Q?qg3R1rZnSGnJp4u/XG1pZK572IfhvqK95sEqd8Utj2kOuG8rIXN4C3CWr4OR?=
 =?us-ascii?Q?Z/woXkg15kRI8UKqq3DjdgkUxWqiYNB7MBDGix/2Tr8mgbhfIz/DpbXlzEgz?=
 =?us-ascii?Q?gxp1xg/i2n6KXF1Udbh6bFupGjOxn7OIHuXzz1YOldu1d6X55GobzDXPx2Vk?=
 =?us-ascii?Q?jX7C10VByW1SCQNIHnxRelYm3TLVSI+ZANZwTF/oqXn9zGFk5rGCVnhj+r2h?=
 =?us-ascii?Q?fKBeqUNSgBdfu2OcqjqX3ZDHFzlewgOLSIXYmaOzgXKD1PdEopU1AQd9Nfk8?=
 =?us-ascii?Q?i3zGF5PNSmYuUNVhZGxIv2znnGypgJVQsBAjhpOQU2xAsERuMlzg07Z91uad?=
 =?us-ascii?Q?ysM14uoIcObWLQtyxNJac0StMcE99PJMH+LEDgBFyKohjKfeZpqSrJfWGAmH?=
 =?us-ascii?Q?Ej5O/LhB5TB61xjb9+OFIqTcaeEa/FmjiNuLmP1TAIXWjfCVI0gzuaNifVFb?=
 =?us-ascii?Q?Zqi9VqmT3yDatb41uVoytFUYDZqJJ6z5W4DUGhLGu/ymtl2L2gntvBBC8/TO?=
 =?us-ascii?Q?oI1gsxhEzUTTbqqQ+p1TbELj8pbBbDHi6NjqcRCsDkUR5T/TXKa/iIXLmsSQ?=
 =?us-ascii?Q?d/6y2jPfyiZf8J0y7z4u9KD5U6fA8neWPmQGWkMLURwCg+sznSStHrnC9nko?=
 =?us-ascii?Q?3RDMoLnlJ84IeK/FX3i7ASvsvuYDAz9fAauX82+y34KvEvDFTx8JFZ6U8QJB?=
 =?us-ascii?Q?r1cKNL9odjnsV2obS7s0mNJ3aoyNvwUOViR2GV2H5u51MKUa4qcL1J77J8QH?=
 =?us-ascii?Q?61UAPXXUhwN9lpyW43YZIrj2LmvYiZoK4I/FBk+A5JFuK7E9zo5PBY812mSX?=
 =?us-ascii?Q?LOH0i6r1nFa1y54MalLrlTzdXWiNY3fDVosQWGm8PEYBzHH+7fHfnmZdjOpl?=
 =?us-ascii?Q?aL+ut+dpfzIaA9oezRZuwgIX3NH2DKmzCBMuxaj3V70fvMrRDj+HVOoLU5hj?=
 =?us-ascii?Q?XwuCd5uxQB9OmWG4qkeNWR2w5jUFlOzoAiTz1PWgjRsRVIXwKPz1aE1mOLBw?=
 =?us-ascii?Q?oRgRN9vKIIZO2QCc9QV6dcWyrj7XHA6nOeeaQlkMUvcamcB1MNXf1BLiAGGX?=
 =?us-ascii?Q?0dlBGFDdGaX4NZTmMowJmImWbneNRWLiIfaUVNfvSCOpJ/HwquOjpBUiyG4A?=
 =?us-ascii?Q?VJVSgZ/GHRS50MT89DIusOFHSM2prrpSza909xDanBq/serxG7Muq5lagWq5?=
 =?us-ascii?Q?KA0zVoGphFT6vRJMx6KgwDLj58ivWsKBoyPMws8PmUqQAOEf2AhcmQBvS7LI?=
 =?us-ascii?Q?Wc5PguC0k0Az+sG0Vy+8HeWks4AF9D8Y4Fqef0hj+zKuzfOXhIVsp5bpQ2qV?=
 =?us-ascii?Q?A/EwUGhVcEtDF9Y624DQ46jvyASzRg5LgqkItSQ5cBctK0dtwS+MmloSCU1b?=
 =?us-ascii?Q?k0s+NyKY42WEkVsLfy6dSIqJ4MWGE2ukVUwg1NmC5ESDRkAs/Lx9iSnBqrUV?=
 =?us-ascii?Q?0XhjUQhcpm4t8hodj54euLWNQJUFsRxxHx462raAdCE7s9cHQXrO43vwQMh2?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f806b0cb-b8ad-4ef0-d17c-08db78d62413
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:22:12.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjNEYUrl8PZrf8zEix4Cfx8SevgzNE9voUdiP2ojBOSCDylxOsPBJDLIQcVRLep9qDK5le1cC9Zrz4ypdFidajwyM4Wypr5Jh5kAbX+UKz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5197
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Thu, Jun 29, 2023 at 04:41:50PM +0000, Eric Dumazet wrote:
> request sockets are lockless, __tcp_oow_rate_limited() could be called
> on the same object from different cpus. This is harmless.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations to avoid a KCSAN report.
> 
> Fixes: 4ce7e93cb3fe ("tcp: rate limit ACK sent by SYN_RECV request sockets")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

