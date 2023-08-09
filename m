Return-Path: <netdev+bounces-25722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7A77545F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB5F2819F8
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6DF63A2;
	Wed,  9 Aug 2023 07:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5092B1B7EA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:46:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20706.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::706])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E8F172A
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtzpYKZmZBtoRZTOonLm295Ow/3upefkJDOXPZ/52yCUYFUoEvFuztWLAPVbu7Cek9pyqNmZ7pnOHw7ssxm3o5NGXGlHvp207t1bhIR1WycHbG6OG49Tbj7e2SeA/SY3IPuVbecbknEw6SoIgR57UxYJEgXElEVHt0vvUfVQnEnLas/8iWjbA0e72JUQwUuptRB6B8txZNijL3XgIP0zRS2h126aFzwy2ZHqyLDyrsgXR3siFuKMHmZQYvzr+5uXFXUoa/DTkrzb/bQ/J0Ac0//82zbTDnHP0JwUX6lEzmS1ufKxrkAyTKMJ3hyaQwbDN9wXiM7BZcZIdtP5xNY9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J56LAGtRYDl3W6NXbfnvgI7WMP+rhJCiWKgkqSfE+9E=;
 b=jlHQ2OJ5SUfXn4lIgjkJF8mEjkF6dv3mQ75RGFOf1EvbkVcmUQGCSRLer2PIbjR9PkMGVHau24SfZWw8779fsqLBeCw+BajNLtiZq4GNqdu56LPg5F2SosHXF8R0mj6qr4zQHVkYlvJiRT5l55iTWUXKNDQLBX3rhnCh7mb6pjkume4/HDgPzGaca3CqV6qiSAUVcLaYflgEYa1pUZelXtO4UK8XD/Ez8eDlA2JinXKNiVMt0lVtzEJ3nyAk2DX83P3WHfEYQFOiEHwzhcP/Ki1LHBh7i0XwwRn5MVK86QBbfznAitczRq5RR731ON20pulRGB3s1nPfdEZV14jwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J56LAGtRYDl3W6NXbfnvgI7WMP+rhJCiWKgkqSfE+9E=;
 b=HKHPgnpTTptpNrCDfV+ZLxrXEHRUWTT+HCbW024sN0CkVv2603iiojL7s0GffUXArpG6sOjASR2qple+0znJup7pr9hsMZ4kBVGzD3SIPUHUq4GVCS+25NReDt2Yy+fTDbEjV+8eTiux+xh4eW7PqrjaMjedki2f6kFTJK/JUNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BL0PR13MB4467.namprd13.prod.outlook.com (2603:10b6:208:1c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 07:46:22 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 07:46:22 +0000
Date: Wed, 9 Aug 2023 09:46:15 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v3 4/4] leds: trig-netdev: Disable offload on
 deactivation of trigger
Message-ID: <ZNNER20kn1SgZsh0@corigine.com>
References: <20230808210436.838995-1-andrew@lunn.ch>
 <20230808210436.838995-5-andrew@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808210436.838995-5-andrew@lunn.ch>
X-ClientProxiedBy: AM4PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:205::39)
 To PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BL0PR13MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 9621e3f7-496f-4a1c-5045-08db98acb985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IM1e6WQqvCeCKB13Sn8gwhonmo2DCdkWsZhyUJ6uN2+4Xsw6FjIqeIoXHHAQ8V5rIB50JRxrdN40aowZ6rs0x5ZJ3Xe90HSwDIUY9ksl997UIZI8UF1MKYJKuUAdT4QrwpdJxvXB6hedhuQJ9cwVYo52WhEhh3OlsLM8NGajtRk+lNEWZ9fCTs+D44LgT8fJ8og7XolXpxhgzYKtvfLsNIB7ElyrIFq0WqwCIsgIvtQ3UEVgjFOAQs4v2IrbHIcxod+kA71bFCb03i0r2KZ9qnFtqG58dWDCbXKKHo0xKTfLv/UpbpcluUeG+62V8GksjHGeJ3sgo74I3axpCSHZZKEDqZ+7/V+6RYhvcTPvr1OKv2lfCqoQjVqJQDmuqjdqNCrg47jopKxW8aLr+a3atXUBrPgEdZ9v2VyKUyaLZvv0+sYWtvgYeefnrq5MtnYCjhrAVfds45X7I7iPaTNclDAviEticdN3LaOQlpFAzW0zuSx2b1Cm327MP3kYMZDJA1cN/8JkfTO+qQcUfIGwVhPOERcm1r0g6BJm7ltuThTj4tzuKxynjfVfjmYQgHI49Bk9ntoXskM5/+dfVqt8AuHHgVTGlALJ2BbbOgiPpFNY72M1bjsP/pC8orlDytNvlflJpg+1MhWXknhrRnIY6/T0ICzRCeKs22Sy4s+zSls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(366004)(376002)(396003)(136003)(346002)(1800799006)(186006)(451199021)(83380400001)(86362001)(6506007)(38100700002)(2616005)(4744005)(2906002)(6666004)(6512007)(6486002)(54906003)(36756003)(478600001)(66946007)(66476007)(66556008)(6916009)(4326008)(316002)(5660300002)(44832011)(12101799016)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m4s4ixPizM6LIrojFAJhegqP3RJFs6YNSYylmxy17z5cLvuEJxO/2AmA8rqJ?=
 =?us-ascii?Q?Ge/45YQlm2X93wy4YS/QBVsIzwWUK95Xyy9Al5vKO3m6bkgs8Xkw0hKhUbeL?=
 =?us-ascii?Q?mWHgokjyiBTpLO44+cXK/zTTa/nEWgHkry4HsEOnNYCncumk+mi+ERb5d/wn?=
 =?us-ascii?Q?YLUSNvj2cnqChdZXTqnbEAoZMlkzivCpsW2cYbGpdJYdu/yWdtMTT6D7orxI?=
 =?us-ascii?Q?mrnQ0Fg39u59aIk2cOmg5kK/2ReldHAHU0/lfg2Nt1LbjKBmUlzgL/m+bj0X?=
 =?us-ascii?Q?LBxXJC4m1xkm3CNvENLOEqFPAE/KtReklbsmc5NZPWv4zkJKrxJu2e4Fdl/d?=
 =?us-ascii?Q?e7TKlY7+KNneWK7vnIHOghZJn6p2GBdFItnhb0nFT9IWmMhzSDK1v8wPNhvp?=
 =?us-ascii?Q?lkSr+iQXtHX71vjC2ftnivecYgSGn87FCbrdvKYZdEO91HCEVXriIj8NBdW5?=
 =?us-ascii?Q?iHKlDiufxn/ZpqDa/GzOPdL//82KmK/CiWIKF4YU+OSUoIZO/rhpSkYJeC5u?=
 =?us-ascii?Q?vGojWJ8P+1rkK1hhFJXKohlDC5gyyIshLSso/oyg1OpdJHCCGmd7lg0xSZLb?=
 =?us-ascii?Q?op0tWbcRnLHt+JzqN2KNMMW51OL76jvKtdiMga9JQCNZ3y02rrNo2s/hmtnD?=
 =?us-ascii?Q?wSqX7HkLQ51JMlifYrvjESv7BqUHL2aGgU+VhCty9EyEdktaqMlLmlslcJ9X?=
 =?us-ascii?Q?0MYri4iXeZdgH7MX+RpmCLLpKAdRravfaxCUk6knybkOSDViGmkcFgciRwZQ?=
 =?us-ascii?Q?KUIHeuAMwgWeodxn3Uiz2/rjHIr6eOIZEWYadr/rcYUZke/Ouj1RnFNGAPip?=
 =?us-ascii?Q?3nfSNiG9I976ANmWdLTbgVKLLnct7jBY05WGmSuOn9Kl0l3Jt+IAt+HME2Q7?=
 =?us-ascii?Q?Wg02tsCyyAhaAMfxSoTzd4006cWKzW1Mpi65635buCf9YlTKfUf1Leov1tPw?=
 =?us-ascii?Q?Ne4wFG5VP5tnxCtcIfbXgeog8/QuSVK9wCstpwiQpkuuS/3WFkWmo+qhC8cz?=
 =?us-ascii?Q?W/5wjjghKTVXVs/b4zIj63b0tlQdQOPsJGAxfe0QL2/xvzAZm3gWvsQl8KuY?=
 =?us-ascii?Q?pTezju1OfOHEk/864tAhmXHbZDgCjTEgX/tVIGSoe8tpfgiDsXFX8PqOKCRK?=
 =?us-ascii?Q?lKvX7xSUPlAJg6gPzcp+KYdKIvKYf5+cM5XtgBUuo5XZVKMWcKum/LJCiG8P?=
 =?us-ascii?Q?0GoV28H880AV0IonG72BNRS7GJFzU/seiaQa36lhUFpigywrrY6ulfTU1E1h?=
 =?us-ascii?Q?jdFtW9XAUcBLp6nhsOrenwnKutImAAT9fRjrufC/r75XA4x5Q5Dye1Gd+YdP?=
 =?us-ascii?Q?ZY03bfepIOuwT3t+6jf5OOjN6LZurgraV6kkK5tZlYY2NySaQOxMdyZI1jJ3?=
 =?us-ascii?Q?H0lPG3SGf8xk70MgxoPhxLyYS8P3wZotLXNnHcUizJZguWe3dPL8iItmBnRo?=
 =?us-ascii?Q?JjYEP2a+2LrfAwyS3GHmHPnFQCuSuW9VJkhZNPg5FaBMWWoYRjSp3y7m0hzR?=
 =?us-ascii?Q?zZo5mZ17gJ9uW9oEEQcU+pdk6r0/PvA+oNuLKYydJh5Xa/vNAfD+BQFpqWsC?=
 =?us-ascii?Q?jw+Iyan/LLk+JKpZGMbDhbxJvW+xFn8H7Ykd/PaZPH2uIvv5EwRctSvNNN+t?=
 =?us-ascii?Q?NKX68Mv68M2aB+MJx4IQU/nuSykaWX4KP/4wyqJlRjP80t06SIg3Ocz/BN4s?=
 =?us-ascii?Q?+VT1Aw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9621e3f7-496f-4a1c-5045-08db98acb985
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:46:21.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcipRw44wzuVe7LJYFxcIhVQCgnBW+Y5Kr/NTf1tlDPOtUiqpWl5ffhlAfbGkVEo6T+s+kWJ3GvwQO2VMTMF9WfiGZokAfzccLtcd7OO+ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4467
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 11:04:36PM +0200, Andrew Lunn wrote:
> Ensure that the offloading of blinking is stopped when the trigger is
> deactivated. Calling led_set_brightness() is documented as stopping
> offload and setting the LED to a constant brightness.
> 
> Suggested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

