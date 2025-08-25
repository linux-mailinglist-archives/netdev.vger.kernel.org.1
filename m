Return-Path: <netdev+bounces-216411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08962B3378D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7629169782
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6011C2877E3;
	Mon, 25 Aug 2025 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JnGhFNu+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03D189F43;
	Mon, 25 Aug 2025 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106091; cv=fail; b=ILjUrbZ59Gou8UJdpQpl2zpeKPIh+8csef1tgfYubjhN2ZnHKO/MB0f293EOddzaFEflWy1Vkbdw9i2BK03htKfdPYiBgVcZM/ZSzblpejuMhVpV/9NlalXjiYnLmflZUsZeKaT3h/8Lx64zVthdIBe1POSNjvvwG6DVFNw1weE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106091; c=relaxed/simple;
	bh=/XMaadry2iiOPEh+Da5rNR48+Ul5EAquJubXtuSGJoA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rPbMaJwcYIy67lu/vnJg1SsrKfmy+NNijl+jv5UTfURfURXRz4D+FaViQcD4oU7Bf82FpcH6HkrKlVWhyCA7IElMA+EoAcN0pt9yCHvAO1KifPssvn3NSiAsLwT+aRz6Ey4lwue3MGOom7mWdKjc9JnetHzRfOxGwRFfn4BZJow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JnGhFNu+; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojK6QclbbuNxJtrmUXlpy2RPA3T4mrYM/BJDjJrU+1eqFULc3vH9MLQtgsEDffRCsVOUhF2+jqhIur2cvjEVvSxYuorg6dR28htGhxLUYtW4HeJoJoIK+Js8OSjeFZTPpzWCJ/s3p0F6/2eS/83H7bFCl8qH4rFx6ZRUdJu76cj7eTMgsFwQAJ9JIQElFNBUoRZGyV8ms1sEyl6G1K03r00RxenVtw5Z7l+9K1UyWuhxn0hrMF3ujj4grvQO1xeycweuqrKkY72WfElkEnGcNDJFN2UoXTaaVnd/greDUZaEy9MU1RZnLUUb/tXhFMM7Ce5avdf+DVM4kWu475s6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkzZPO0TJs4NIWGQM56JBU68eTH/14ua1MZxmKAfXRQ=;
 b=acDEvzdbaxZ1R/ZuD4FRVjM/y+N3oRr9/lRnD4jLtCQdSRzEB653gYrVTM2ukNJqPyeqBM2tv1Zoro+Du+aFHyNMTg0b3sq4rSQnciPe02bYausZxyUMtqyne6O+bOqCsZDQ4tQI8kSg+PmStXw4tEHQino1DXg7VIujG6U7J3Zpz5fYUMHJBsuOtfh7WBbrLaNPBMFZ0+mqgh2zFdtPYrEFTu5xDHcEN82nvRBtLuMgbI157yDVJeDPOLZCUsF6mZmql8o4lBcjpKfvsN42fc15Kc8HVBNKAvQkOZmIaRyXtraW+R2t++fGFGQi7xt4gXCjCF5lD+A636+o7UO13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkzZPO0TJs4NIWGQM56JBU68eTH/14ua1MZxmKAfXRQ=;
 b=JnGhFNu+7PO+BygiHalZOjanmfTaCzOWHBXwoB0MqlpmjmiysLMXpo46xcS0Y83yCPhpg3zVvQxs+c5HOHtHFAYsqofcJxeERSA/UVHIiziviLKnozawUz5ioDCOGlb8LaC2POgfvYe/ejxpI8toR+kWd9daMV9oFXIFaNODz+koN9iyDjVOyszNeAJjPLpl7Qy0WFLYlWLOhArz9UWgddAXPEwo2X+tnQPbJz/sK9/OCdF5/iodelTVBhs64OU0k3FZLg5wqsGT1j96JH0m3zUER6tcTSTTsqKbr2X52MGa2YgGk28/qzVuRgVVBi4B5FVcOH/Yx0XZd5DlFWUosg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Mon, 25 Aug
 2025 07:14:46 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 07:14:45 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathew Gerlach <matthew.gerlach@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH] MAINTAINERS: Update maintainer information for Altera Triple Speed Ethernet Driver
Date: Mon, 25 Aug 2025 15:13:21 +0800
Message-Id: <20250825071321.30131-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|CY1PR03MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: a23e6e25-93f2-4d07-1d13-08dde3a711dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Q4wqiwpJD7SNC+/VP87Y/OqSGx/CVTZs9eeGzrpbw+N+wL3sdR5iS5a6LYa?=
 =?us-ascii?Q?iVkUomEnX6yXR3L0/ospH4fBhhYn0P17W5IqZqOsxEeGv8gMZ/zGQw+c0aiu?=
 =?us-ascii?Q?LXJYkzrkkX5uVgF5AwJgxbQxiUh1fhIE5b1MDysZA+bkRZ+uHxU42ijNuL9z?=
 =?us-ascii?Q?SBzDywXWLkWFFwhyHSUY8qMzjNvku/3UgLNyEAu/9ts4T05672Wt6Rw9CRG0?=
 =?us-ascii?Q?2ZymogWW0Js08ib+13JLPTfC6IW+WP9EZ6oGCOv66YxqfmdtUM/C9ms6C4tR?=
 =?us-ascii?Q?HXijyYM179imj2Eof4CK+2GTDg8mQCFWObQd+eDDqUYe0fOJsmaKmyducUuL?=
 =?us-ascii?Q?c6F9WmBB3OtyLvxAiq/iWgQt2JShWG/YQGs35H7I9NW0rxPf+gkGYRW5MbUG?=
 =?us-ascii?Q?fogqW3bIBC6YZ3e8oQYoqZJjtT0URMmU8KtMm2yXce7RDhi3JX0yaK4p+LX4?=
 =?us-ascii?Q?BUwWNci33pa6acA+s+ZF3xjFgVXKvk/kOVv880JxhlIjn+oxYuGwFO+dVqD4?=
 =?us-ascii?Q?ArKBJdCwLMwELtwzOBoQoI39Bi3J2l0s9HEL7ik+4Bt0hstP8zpLUev9DYxB?=
 =?us-ascii?Q?/2QOvkrBXsJ5LZzPVTcz4VPnrAdTyOJuZRGNba8ecnjVj2b0kw1khP4gK1kz?=
 =?us-ascii?Q?wlj3mvH0K5sxt1lJ+jTaEtp5Y5D+IVWlCnQsVNaxOEzwVWhCIQ0Qw9BwgTJ8?=
 =?us-ascii?Q?dahiDqd+6sfZAtayYRWIpbCuDUO+kwyTNSHhDZZ2e41bh4K7TC3BhXqPLI8F?=
 =?us-ascii?Q?03M+p8FRMv5aB5A2LlBCRQe1Shbhk+JUG7dBXLOqv2BD9tPuQIo3Rie4xDVH?=
 =?us-ascii?Q?fchtwShpfAm79laO22wUfZQ3pkO0awrnFK1fZrh4j4YI2hqMbmbIqIz63FIe?=
 =?us-ascii?Q?a6rSBtaUktHOZLBYCuUz3ijil3oO2u3P2Igv2AVmkMxiWpq4zhwqhKcpOAs9?=
 =?us-ascii?Q?76oOzc02q4nfe0WiswrQLUH1we/Hsa7ZImmyiwNIazCmjyw8DAA97Z6ufxE5?=
 =?us-ascii?Q?qVui4EnSaJ6GiWxs9ApgDQA418xOGnzc//ucKe2aAsqLdwCeAlA+8TDOaoVl?=
 =?us-ascii?Q?d2wvuLnh0yMd2A/EifAmXDNwzW2dWo9uocXGoDo0CXTjmRqHk1C4rycRt9Bg?=
 =?us-ascii?Q?Arwi3/Oq76tWiE9q1hPTT637v7TmAGKFouJafEayA9zL9eYHLVfvghZLCG/f?=
 =?us-ascii?Q?kGUGkMB1S8WQB6WufHBP2EEVk7CC8ea3kK9IiPjW5GbHP5iPEMGS82Py2g3C?=
 =?us-ascii?Q?ncfD7oa8LShXZFlu+yDFxEwiLxbt7Jh1Vfzrpe3NcRlisSaoekWOBuisdeoE?=
 =?us-ascii?Q?FBKh6NubI4RWRI+lxaE3N50QXr+vo0g1/21UMkaHAn9/kzSmt3a+LY4QC9Yl?=
 =?us-ascii?Q?guv8KEGdaoNcZhGkBSCXVcwaWgkrk7p7R6pp0miuxFF5AQ6nPJS5iwhIME9h?=
 =?us-ascii?Q?7Vu5j2BXTQg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR03MB7187.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DwBsOPZQNVwZxqPBLcZFQ0IAO73btdaNAXGGLBExydR/M+JyKc2GsTkKm5Z7?=
 =?us-ascii?Q?Yuj+wg0mybo1kfwMMxUwZ4g3QlhMQ+y2oMoVabxlQPNRcnLQrtJTRqcTFjHZ?=
 =?us-ascii?Q?Sf+yvvWhI1c92+UZ987IlFEQftuSTGc+rnzmhAMVVPs6B0GVeYe8wHgiQjpz?=
 =?us-ascii?Q?ScouyW7ZK8KMxSMAgAsf4IqGFDXCfkhJBEY+VJvwgyMo6ehmUMJKwPtjwzWV?=
 =?us-ascii?Q?foWloTYrF8UFX+BllbIYmrT+w/jdCrUKHJaogIuUirS9Ny08GIQUfKOFo9WT?=
 =?us-ascii?Q?XMGoVn5VA2Nc0W/98L+nBcuBVxkR7w6wfJ7+LC2qbEBJfLo/GVB23txPw+TB?=
 =?us-ascii?Q?Cp9ZXUZLk6qfN39J1D+l79hEqk7+MJjSj5DXUGQQNkidWsFGUqW5Y4WqNLmK?=
 =?us-ascii?Q?MPDjXfdnsdfq2369txs5fNwXrRJTyGz7OuyF/ysC5PhRsv9DsyRtmV73bFVB?=
 =?us-ascii?Q?879Ap/rwRdoHaLTEVRevZbJJqVs/yQT5je0dX8BU5B+43c2+O2leM94jjC3Z?=
 =?us-ascii?Q?etSX07C5FLG2cnU3gMXQg+LGEKzXzKDa2hGPTfKNXwmQoTdTDW4pq6pdrCAz?=
 =?us-ascii?Q?8cHD5XGqD1TRTzKv87zwF5YlgSAxURvDVVJrwUnOzSPt2cfMcK/2JgmcP7Sm?=
 =?us-ascii?Q?oS/D4o8nZI8y2Xv5bKU70JKkBd9ICvPH56V1+f/6CIap/SFhJXSUfAyUyauv?=
 =?us-ascii?Q?3FtOe/TvKJUKHNClTIr3lpuDkQRckeeBV8G+2UFh4NhFnoRcOI6CwvE3J3Pr?=
 =?us-ascii?Q?h8kOVYCg6q4pcmSkBHuMF47COmStPSEDjX5wW22HX+8NvEgG5fXklVPHKalo?=
 =?us-ascii?Q?daEsN6VQe4gUQwbrj8rXYYuKRjwAvOMSKCtxWwTXIkBINVmYqy26vSeVBEVo?=
 =?us-ascii?Q?DI6qtjnDqursumk5lLlgsvw4WUfxZkCsQOFY+Q4UCA98mZfkHSndfVzwg/O3?=
 =?us-ascii?Q?WGSoQrlcIwyPRrnHWCzSp/SdRFrFzUYT8iQXy/B+q0Cwzps5oWIhEVNvkkeQ?=
 =?us-ascii?Q?s2FDVjDULMj83trvJSWIkXNqzffy7B38719xfhnlWKrElDdcV8TseWUpXBZk?=
 =?us-ascii?Q?OPqKFrroojvTEUsg+60O/ceFMSlot3ocjS98g9pCTzl6EhMLlDAWaqVuiM0R?=
 =?us-ascii?Q?0HajWUUaJMqEC6LlIFY0Py8Rkc5QqFYHUcbrINpRh+5j0MZjTgBplSm79axs?=
 =?us-ascii?Q?G3Zfec0mqiskhIr0UI7E50htzfFaN51ZrKZwP3DH8oysMr2tmr6Xs7cBTcK4?=
 =?us-ascii?Q?/yJ6uVUBUiFuRYWRs77/95Aspix7z0tTCRYrJsRfTpR7JkERX6n77sSIqJ87?=
 =?us-ascii?Q?rRb+7Pf5Tr3lBy9+NiXf832HmAbCrik/osqXHi4X4nRoC1/vK2WAD1VDJD07?=
 =?us-ascii?Q?p26IRJArWBQJWvHgFc/dXdNTc6G4K1v5GJ5WLqPHNdM5ijqwBglnRHPHt++6?=
 =?us-ascii?Q?jJ72UkgM7SgUr1RV/KmDL7QLknuNqeCxqKgZLYfdEVIwY6p6Z7cLqlUkbCpT?=
 =?us-ascii?Q?yn3cIWEcbrayT2uIQz5HqwErKfiWIHLtq15WXYM8Hhnt+LUa0+4aiL5QLUSu?=
 =?us-ascii?Q?ZGFHHpF6047NOruIlVtgFM8FJDXShhLUSw//uX0ZgRRnrdjNj6m8OKIdvAa6?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23e6e25-93f2-4d07-1d13-08dde3a711dd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:14:45.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfCkJ2rsl9XMhFhVO8twOiUPLICpRCs/IGbMkeYnsNB5kUtlrVAfASvNRzANWkmsidKsSxpphg62Mj63ULt3gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8121

The previous maintainer, Joyce Ooi, is no longer with the company,
and her email is no longer reachable. As a result, the maintainer
information for the Altera Triple Speed Ethernet Driver has been updated.

Changes:
- Replaced Joyce Ooi's email with Boon Khai Ng's email address.
- Kept the component's status as "Maintained".

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..47094f4f23fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -937,7 +937,7 @@ S:	Maintained
 F:	drivers/gpio/gpio-altera.c
 
 ALTERA TRIPLE SPEED ETHERNET DRIVER
-M:	Joyce Ooi <joyce.ooi@intel.com>
+M:	Boon Khai Ng <boon.khai.ng@altera.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/altera/
-- 
2.25.1


