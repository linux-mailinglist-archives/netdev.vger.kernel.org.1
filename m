Return-Path: <netdev+bounces-58603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B181778E
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A3B284B84
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB324FF98;
	Mon, 18 Dec 2023 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gxpme1rG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2B5A852
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmyzzvQGgwSvGvn3pVFkxQu4OJUg5syQXlKvBq6bP9iN5xflUUwBpuyb/V+RXvR7LYcIXmV8JK8AtefLReU9NOfnwCAqPv/yfwY2e20AFryM0dL9NMfXlpA+M6ZTM7tCmfQbm89uzDscX4fVjSlJo92pTjLfiKSAig7NPn57y6nByYN9SavmDMpOX14m5LhE8BwQok8wEEQvowu2UtcNkKQ+ToiRA+8WnaD8HZQFIpzh7x7Y3v028pDTa3vy3PqDqwBe+gDX2/3arzw91CDVSFCccRFhDgQ/5P6DArhOw5Am0za/Be2x7grXRYzfY2aTyUC0tlgl4LlzkmjAOcD3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Kwc3/8SYDtQVOv3ru71aD4CcYLEMJatGPzhXxJy9y8=;
 b=httPRjZzFyI6bBmQa3OIMMBUsuaxkI9PiAwnRNa0ZQHDQGSr0EDxTxZVtUYhFpMNZv4sfgqgyeiwiROWejdhQyPXkML1YTsz/LDlqqFffQ4CgI8WJKEdU5ud4W2nk98MtlXDFuWagNwPuZOug1cLjq0gScbXCKjVhGYkgdrNUoYdTVhjYYqXgJrkH8cR53vtm1Ao3YJB+L8rRFaWMZfKZRfHFR5mHfVqSy+yTYf/REkX5W8xSczqX7CV5vEgK3a/J0077k1u3f95K/PULbiQMO4GUYjzBCe0Hcv12h/GID6kWjMBfzPDWu6TqHLXyLarka25btmut6gmkFFYIVqUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Kwc3/8SYDtQVOv3ru71aD4CcYLEMJatGPzhXxJy9y8=;
 b=gxpme1rGzHX57qcW3Erp1jdgjUqzCNh0rEcUdc6WbkqITB7qlmbXPlLNb2uxw4U5T10DUD7v8sio7GMZdX4pm5YxDsnU5GZXOYocCxazNFN4LkSMng5WCYCKiSWUvfQTIGgIdQkM+WKueLinHeaaInu9mxBgfGLdfl08XIbYvpEkEqB9b3xQKvoO+H9b2Y3g8ldvevhFUeic8nIDA81U6znPtNKGWWJEpdVaSECS/o0asw6K8bQOmsLYD5OKgoqKQeJ8cEMtlH74mNYUx/MtXSy+BocNC2Un+WK0OpQeXGnZuAjdj9C5o3Y9S3gpFbuqVph1eOy32L8V7MFJnKC3GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:31:15 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:31:14 +0000
Date: Mon, 18 Dec 2023 18:31:10 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	nhorman@tuxdriver.com, matttbe@kernel.org, martineau@kernel.org,
	yotam.gi@gmail.com, jiri@resnulli.us, jacob.e.keller@intel.com,
	johannes@sipsolutions.net, fw@strlen.de
Subject: Re: [PATCH net-next] genetlink: Use internal flags for multicast
 groups
Message-ID: <ZYBzzsZfUOkXGdpI@shredder>
References: <20231217075348.4040051-1-idosch@nvidia.com>
 <ZYAvBdhiAnR9dIi3@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYAvBdhiAnR9dIi3@smile.fi.intel.com>
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa92d64-5359-4ba1-265d-08dbffe6c0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0i+LNCqJUZhs3TB+Sry93pywX+fTLNXLdc8p1MSTuatOLZmOG9Z7qsIDXhcvVVcZyLmyMSzd8wKeRWh8eJ9J7sxhPY8PK07pzkb+hR4J73e33N6oEcG9DnvI4/O+sOHwXBiRUBZsJG1BQaESeoWFPqOOhLCrEe0GFZH5O+xXYT5AC+iplR3aK6FlpUxDguS4pQD2Osbr04+Okb8SfeUMVFO99MFRvo8wYxcEuEqDjsjIBDQJlhmAamckpn1+aET/55CkbaYcopxgp19jsQvjHWh+5gYRSXn23E7PJDhclcZ24evlw1uD9QtzX0wi47eT8Uu6XtKcHx5I0q2Qc+mwDe3DBw5gSE2YJ1KVUH6VTD+NOYvq/l45kJBVd+AZyxErcQplWEaaYBjXv/Zmoaw/wna3LjnfvoD3nZM7X7HIuoiTI+T039bD5gAYvKR7XiFWHC69UHDhJX2qsQ1H1X6J0W7P/uw2QAus5tRTFxhQcqTC7kJZ9xvVMnMw/SMrt6r5F3Qo6ugXx5Nm+pwVOD/PEcI0QG2E12fc1OpD17Yb9qXXcIehNepsmDdCKYDZuzqm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(4326008)(8676002)(38100700002)(5660300002)(2906002)(6512007)(9686003)(6666004)(66946007)(6916009)(83380400001)(316002)(66556008)(4744005)(66476007)(7416002)(41300700001)(478600001)(6486002)(6506007)(26005)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HVoZef0ANTgcJxtNogsMfqlSQvRRWLEmzUbwf2M7aMDEDczLVbPck2mRKUVT?=
 =?us-ascii?Q?IE6/yjJWc7JiTRKl4QY1NOI/yf4vL2w6EiN7fmrIlwjulzP3eKkNg0OpT54t?=
 =?us-ascii?Q?vM4x7/nj1IHLVUnl69APCjofctyg7qRmC5L0Jkyf24EkOg3X1WSTGqn+lsx+?=
 =?us-ascii?Q?seWAnDi8QIIWMtdcBw9odqTJUrss97P2IImIo5+wyQqSXaaTNuOrLhGk51Br?=
 =?us-ascii?Q?tzyPM5PkOSZQUmO26n08Ax+JuOoGAvmPZuVbtl1dx+PAbESNOo0xmWAW3cJ1?=
 =?us-ascii?Q?2zIqnIXM7jKJNNgXYPaWlDtzNmZxz4qBJEgVkvuD3MZLXOGCvqKwbACepxSG?=
 =?us-ascii?Q?/atlUOsuMwRF4Q5KTQfub9foiiYNSet3N9QXVZuKie/3bTCi8HrroR3uqrRr?=
 =?us-ascii?Q?jSBLVi/ZgndygRzUmEmU4kuVyC3UkJMqMCZ0+0ChG1xZUjs2uDWALExHU7+H?=
 =?us-ascii?Q?JJA5iIGwS+Ih6bO13dwjoIVY60RZeTK82DnXdZKD2JiFgOnv+S4oZ08R4Kr1?=
 =?us-ascii?Q?CyjK9YtTJlOUYBjRf0Z7dMra9EzELSRz0yCjeFIUKKblTbZAzHd9ivs35O1S?=
 =?us-ascii?Q?lZcerb2Du5OmoQjv2emsgL2g9BfTn66jxKHmnTRhgKvVbGGFAo+VnjOPjC7N?=
 =?us-ascii?Q?UiDcbcZOPnAwIKYl33NvpQHegShD9oRQtQZrwiFqmoc7hSqa58vnoQcYq9JZ?=
 =?us-ascii?Q?wwhhoXrYGuMr9FBY9wPPpGNtNpMn9PVvPJ6TqvVOPH0Jwj/dh00r6ieVDsr8?=
 =?us-ascii?Q?blV67DBpVHzDnw0xBp+JXL08MSfsyiZqgNojNTkVTevrjunUbT8DjUM8ccx3?=
 =?us-ascii?Q?s2R13rOSQiMZAzBAGdgmxsXnKEJ0dAXzWWd7pPITYKjdA1VtZv99NyeNHEDx?=
 =?us-ascii?Q?yhjX2bxBB5N/yN0nk1TC2E2KU+dBHe0TALW/pPv32qAbYj9D68BOaHccrKuu?=
 =?us-ascii?Q?ZHHwknFvAvWBiUc+ySjY9MpuRA48OWApBvEi9KinU+AUgoeM4KCp3LbDCDbI?=
 =?us-ascii?Q?5CB7EJrZzrA0RC+QRFkqHw8x0MWySu2XbmttNVTSZGt1GVxgeBUaSo3bdMpU?=
 =?us-ascii?Q?iF9AEfEhuH/HXBu21p2nL3P2LOqQfvIaYQ6VnSdWPphKfWCy+xGDsNJ5aanW?=
 =?us-ascii?Q?sUSVBkhCT2JbIqwQymgSZ70V+kBVhgHHjCNfwwCc8IlCGMs824Lx4QZ8fVrX?=
 =?us-ascii?Q?8GZTo8q2505dvUu7XOORsOSf3MENBHJDy5q+GITwR2QxLHHptPhtSZr7JVTi?=
 =?us-ascii?Q?Vx+R0W69Jk4SCMXs7Al6nyrzv7zV3KHkzIsys34wTVzohhI/BVMHXx4NCLyy?=
 =?us-ascii?Q?OpQ47EEc6rZqf9TaWOjrwTTzcx0AexFcuL/uzl12MgVzz1sV828OsQbOvFN9?=
 =?us-ascii?Q?NSiWKE6yFXv9npHRu8RDvAJmjVHKZTGFWuTd9Moo32UQmw8bKp/KKqjkrSax?=
 =?us-ascii?Q?p1Tvvp1OkzydtWkSDoqjsYY4ek8bw7r2yRvD8CmcB31UMCSff0wBVFVrHVEF?=
 =?us-ascii?Q?rR9vdk7WXckdm8pWf0O2uqokpzfVM3yzQbeRaa+SlHsR5wWreqj8bVraPT6w?=
 =?us-ascii?Q?oTVxW8vB+H+CNMOgGhNrYNIEgtNHPa1+MIr5nmIl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa92d64-5359-4ba1-265d-08dbffe6c0c8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:31:14.7102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zH6n3lcBgXhV/RjK6ksk0nOd90LeoVKTKD9mNk6m9waTLa3R+P8hx9ucCPH5A3sg3tU0fgjlzY9l7FgGNKjwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266

On Mon, Dec 18, 2023 at 01:37:41PM +0200, Andy Shevchenko wrote:
> No functional, but documentation changes...
> 
> So, I suggest to have these flags being described
> 
> /* ... */
> #define FLAG1
> 
> /* ... */
> #define FLAG2

OK, thanks. I will squash the following diff into v2:

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 5a402fd24817..bd6a6ffdec76 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -8,7 +8,9 @@
 
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 
+/* Binding to multicast group requires %CAP_NET_ADMIN */
 #define GENL_MCAST_CAP_NET_ADMIN       BIT(0)
+/* Binding to multicast group requires %CAP_SYS_ADMIN */
 #define GENL_MCAST_CAP_SYS_ADMIN       BIT(1)
 
 /**

