Return-Path: <netdev+bounces-103184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF63906B11
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DCD1C20F2C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E7B1422B5;
	Thu, 13 Jun 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="QCTmaycy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2105.outbound.protection.outlook.com [40.107.236.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468913791B
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278536; cv=fail; b=g6fhmyVkW0njCloJui3j2HK2ZQMT0Mkf0L0Jzscxlqobqkn/rm0EuSsMtNQj/6IBttf5IIGl+pz+7RdDt9TfysH2gjhP02T34XoaR75RwYfDnGYsoRHznqVACWS2Hn9sWPQyUOnQr8mYEcNFhSNiqcA+pCddA1KZiw2aLVYMs9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278536; c=relaxed/simple;
	bh=ak1iEY52P0VXqxlZ6Aawm2f5gIPI9QuybnWmbLOJsyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSJobIdIW/2jZVElyze/S+HRWTXk6egclxUXDdoIaZG8l2oYTPrz5xnTCbNTbUau2yVWH1qgjdfWANeOLItkSVdPy+2ZUVvwFEVG2V1BAr/0Kk8wyS8Pjw7YJBh78fvv3Alne7PLghKREvTsK7b6NJ9tvuzfW8LsbqWu3xgnP6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=QCTmaycy; arc=fail smtp.client-ip=40.107.236.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8ljnhipVE1lQM9FsxJzAQqZLXu0EBM5k+OAtq8WySCe1g4HNlzqnOV1EJfi7aDQ1Jtcw+Xc+Q2KTuKxBUSiRghFuXVsawj7tV4d3ozrTi1stn3XZDh7WvyrM0sYpNm5YJSyhtZ8lYARfOGmxnwm2svXs9Rm7Xob53Pt2fLGdOxVo2n/mAlUi6AJRD6vYOHXTI2z/6UxO98kk4zvZ/FBv+tEs+yvO0SqYnOY3xbcZRPERcFOQJJ/LVxVavLWDsRfPTITmlhyRzvW4SuVgBq8HQTdjUzoI1RlecJiOAQnUl6VY5EkmHmITwf0TAC3PGCbUP0yiaHjaWXkI/DpvGrEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUZHHXm/9Sx3Y0nlYB09F931N0ZIQhVenrEpdt6daaI=;
 b=WpWAdIvwF1k+05zSK/Qm302MrbJfLyvmWwYUk5wc7264nH7KgDnNZ5DQrO8/H0vw8uzhl5qHmh0CQFR5fheyLvWE9iwmixBcGXo/Gf8n5lgx8/+YXXXlaGVDC0ziZ+4LU+N0hU5IE1IqrjnqgGWYl2QL6XJ09aIzgkG5QTlvjwERN8pjLvR6ilhp+SBBnw0ghZN7O+gRHgUpczxT3noBumFBeb4XgIEbr5ebmSQsuCJz9MGtmyHFEXfKTrv3K+IS+rermGlVSm4eFR9Moqhi3zLe1awNCDiCwV1Y4RTEyEuXlFGoSc6HLnyg4bMCtqC+pH1ABnXZAS0pmX4U0iWBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUZHHXm/9Sx3Y0nlYB09F931N0ZIQhVenrEpdt6daaI=;
 b=QCTmaycyRQsLPRKaPCA5rtn2En1hAu1ucn7hCb0Om8mt0ML2YqvlfxZhsSvZ1nns+PE+vdF/kN5zBgIJumwM+n3UmYRuEHnRzeYB7WTaQhbWFnUGD7tP/UYIN9B3EPTcMostl3JtiabwtcXYWNrim6IUySqmqy6bySUORpey/rM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from PH7PR14MB5619.namprd14.prod.outlook.com (2603:10b6:510:1f4::21)
 by IA0PR14MB6283.namprd14.prod.outlook.com (2603:10b6:208:437::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 11:35:31 +0000
Received: from PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a]) by PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a%4]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 11:35:30 +0000
From: Eric Kinzie <ekinzie@labn.net>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric H Kinzie <ekinzie@labn.net>,
	netdev@vger.kernel.org
Subject: [RFC net-next RESEND 0/2] MPLS point-to-multipoint
Date: Thu, 13 Jun 2024 07:35:20 -0400
Message-ID: <20240613113529.238-1-ekinzie@labn.net>
X-Mailer: git-send-email 2.45.1.313.g3a57aa566a
In-Reply-To: <20240529231847.16719-1-ekinzie@labn.net>
References: <20240529231847.16719-1-ekinzie@labn.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:208:239::18) To PH7PR14MB5619.namprd14.prod.outlook.com
 (2603:10b6:510:1f4::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR14MB5619:EE_|IA0PR14MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c203546-e3ab-40bc-67ba-08dc8b9cee21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtLPcnPpC+y9GxzqzunFfyBu8VUVGhvMqe+1KTv1x6JVqYnEvXgm2KxksnER?=
 =?us-ascii?Q?w0wl1PUIfUI2GAKmtubYoUzdGnbcPLWdOs4WPcInBujXKKTciEMvQcfi0cgx?=
 =?us-ascii?Q?5kdGtamkPqM47waGrRMjv8c5SN8L8c1HKUzta11laYelV+B2ohHCjCsUX9xu?=
 =?us-ascii?Q?WuB4yLJtVCnY3oo/yIVj6oHoznYsaXzkwbrEXChVrxXse0ZR8zF5w+6WbaYr?=
 =?us-ascii?Q?cgELiic/+BvJT3+vEgl0z5/xTF9P5zcaYd/ruP3DRVtJEmfPrHwesVLKXJEd?=
 =?us-ascii?Q?PRhlR5D8zPwfkrgXVoO6s+jiC/3bIif8XlzKh0XYCVNavfo7wKDYrAoQ13w3?=
 =?us-ascii?Q?SwXtsl5wL6hsbVy4MBVpatKj00dC33ibTbesiS7jWY+J581YCTnhTIYkgAoi?=
 =?us-ascii?Q?b8vZ+emSP1YVCZu2axk6wETSrQjaRbdgKGwAATYl3gnZub4Ek1A8MaOCpTrx?=
 =?us-ascii?Q?j3d3o1wdt4KE/RleGzJrzcJ3tCvMgXAE3YweCd1h2qINs4i50Sqxd3AyyZpy?=
 =?us-ascii?Q?0ijTaiYFW5b0Ieh/dwFBdMNPFBdfRxlkIJmsDyhaKVYk3dRTDIAbH0rrmBmU?=
 =?us-ascii?Q?3LTP5xEyt3MITuXi4vEoilXj94aEZ3eowluo+/iAWj0E2jRfD/xPbxoptaL1?=
 =?us-ascii?Q?VVsDmPIIkL8SOdjPZzBIQdhX+dpqFucTTui1oTJXSTYv7RfTtdpmz5VnPma6?=
 =?us-ascii?Q?V7IV5LXma9L42TvOIXB1QY/AW2HQAy+9EWKFwb5lqJ6BZB4W1OcV/OG8AiSo?=
 =?us-ascii?Q?tJeuTvnV/8rtThoDmuOGFOxOREKtBFY9/WjibfTdyW7+uispTeY3Qwrn9yJi?=
 =?us-ascii?Q?C0xGFcYsyRY4M9pnbyOnjtmwPiQM2g74uUtSyUAv3htGrsbgiRij56ZiO94M?=
 =?us-ascii?Q?Inm+iaK2RGi+KMVbs0jth2wR1dUkZB3Plcd9Wz+Hu3wSuWZ6wrnoRjvYouq3?=
 =?us-ascii?Q?tjTqS8S3VBWmdsghwLZnxxbt/CdeX0CvLyfBlrkMq1oTsE73YNk5ugFhN6Yu?=
 =?us-ascii?Q?VO37CEFpm26Kr/ElLUGQZrWfOzmIzOmHQRMUO2N4+Kj61S7abbQ8s34H1v3T?=
 =?us-ascii?Q?L2gWFbmtFBJQLB/tktUuz8kN368oMCWe3BZLTXS6sdYLV8jAqqPzY8OjZqOA?=
 =?us-ascii?Q?+QInLUJQaVUvmxXPTDv+AUj32Lh7XZVgTQbZqkODzLSWJB/N7Sh/kC2a0AFL?=
 =?us-ascii?Q?d9I6+doRu5daGC6+VaXR40osAkTdrDxrSsc2WtZ0iUkXHRTbxrG7sg9K4XON?=
 =?us-ascii?Q?oyPEt4garKZ2VgGZpZnMq8srNpUgk15AWTpawyAY2UOtiCFEopHQ93cR0SeW?=
 =?us-ascii?Q?tT1O1ikL/3kSsIamVaDs9vy/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5619.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8FHzUAP1YFQjxt6+va5xay0oH0AzvJ1hJhhyGfNB4w6pZyCrUh97zZpT955i?=
 =?us-ascii?Q?yQ1S9c70HIdS9QxYLdJDcYbJKHyFvi1XZBs5iG8zIhZwvwVi7DCMU/KX1c/w?=
 =?us-ascii?Q?ntxYzkXw/pL7Sd5lD/KAWn+4JhM5dXsBSZwPxgKNc8Gp51QSwnY5Typz9zaE?=
 =?us-ascii?Q?3H8SkUPnD7KhNIgFUP1Bn7VlePguo5Jcu6kcBGuhvHxKFed4ykUtQ3w00I7f?=
 =?us-ascii?Q?yDnL/jcS8Kqr0eUl16+gCGONtLyhQTrkH/t4wcwsd9FpTeLMdD1vfUGj7LX1?=
 =?us-ascii?Q?b3HygUPlH8rFFokbA8KlZ2KaiNuQ9/NTCiiBM8a26TzpKcj4JYsVgVCoPSj/?=
 =?us-ascii?Q?zjiRlW8ruNPv+0oujvm6MF8VS0Io3WPVH1n0b+sSgdU6sztX2BX7s/OYt3eY?=
 =?us-ascii?Q?nd9yRW3QVaCe/T9AHPOm1s7n+wQP0hff/SxyB3hQzFClSI7GGwtKhlGjO+Yf?=
 =?us-ascii?Q?Uzz/Dh3Pp1XVmt+vLxw6zlXYcW8HuTXQMjsqa4BHJW1tYLFa1l64KMFunvx9?=
 =?us-ascii?Q?J7nB20XRdaME90UaJ4Bb9kGdiHl19FQRd583KBbBONZEbaNLhX+i2OC19op3?=
 =?us-ascii?Q?EJZi3jFAjF8jD3DhkYU0x4jpmQ0ox1+Z22VEJo6XR+8SDpPTRAJwx9oVKYzy?=
 =?us-ascii?Q?aPkwFSCk99r8pheuzE1DnUWBFnzybjzXpyRaCIhcT/9ut6U59Ho848iaKeQq?=
 =?us-ascii?Q?d1vVndMY952hkxP5yWHbIZ/m/jJNeQf17a4xYMFDwiO1DYjrzyvsEIMVIAow?=
 =?us-ascii?Q?AfEB5StBtp5RnxcjWN2HFOYHBX65csmIdb+CKdMJ9sH1J5dQgIX4mxhk2GGR?=
 =?us-ascii?Q?F4pNeIAUgvCNphg3qExv/flJsQwoA8dh/QlMCDuIAUjyK7GRTJqjPqcHtvyy?=
 =?us-ascii?Q?FbCS2vCNcTzNMV+oTsk8SvOjsbNIb0MvZ3a2lIvunR+XQ1Kgyvv5X4Zo1Nh3?=
 =?us-ascii?Q?mmi43IU4a4X7sp42mMEMkzLtBC+tViVLhU62QVNx0aR6ATDVAobPiZ5XJrvU?=
 =?us-ascii?Q?jiy0okDRivppYjaSOpJXE2uGIdT/v+RzrIFl0VmrzHACpqC97pfXToRCBuKg?=
 =?us-ascii?Q?k2V8tsMI8r/PLpNV8OnCgUF0hs+0wgXo527CMmzXTuQmBbn9cisLJBsjixHs?=
 =?us-ascii?Q?c7q5k6iK0+Ti9eynXz+67y1dLwNpLm0RuZj+Sxgo1VQ3FFcX3m75ARB2BkKi?=
 =?us-ascii?Q?l05i57zJF4emBRqYsMAfHkUQY5pnLfz2z86i2ef5xPaDnzhpAowLS1XfVZzi?=
 =?us-ascii?Q?kjFDtAAUFTC1BLKii9Dx0LfpwAVkcJyxiSLEyRBSL92LZ0cNw/2NM3xtsbXD?=
 =?us-ascii?Q?2tRXZDkQW/UTdktfchJ+3dGC6SArkr3ID9+Geiv9hCDjk0RcoEy72mZPXZdt?=
 =?us-ascii?Q?UpGs/Fn7qCyL+0+46QPQUXBPTkJVx6SbVsUcV1gV62oJpTwIBE7sa1ZNAyZk?=
 =?us-ascii?Q?zMl4oWfO2jOHeTvSxwk4RbOhePAV3EnNXJWBZglRr57Xg4Yqt2vYh5CTHqWo?=
 =?us-ascii?Q?I0EgDE1GSJGrrZ3grBu8oLrMRgpig9/2QA10xHVIHi4gxFiLNMzDFfMaOZlL?=
 =?us-ascii?Q?FNbUUgUz5EuQ0uHBPtCefjNbx7H4a9X7a7XyTmhf?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c203546-e3ab-40bc-67ba-08dc8b9cee21
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5619.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:35:30.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOyMobVLTCH88Go87yC6uMcs1MW7I1qZWh7KYQ9FwXvRnH9QACIv7LRv5Rx/7AYkoWoHmHwjPL/Jcddc86+dHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR14MB6283

From: Eric H Kinzie <ekinzie@labn.net>

This series introduces point-to-multipoint MPLS LSPs and fixes a bug
related to sending ARPs for MPLS-tagged packets.

ARP/ND: I fixed this problem where it was observed (arp_solicit()),
but I'm not sure if this is a good long-term solution.  Other options I
considered were (1) adjust ip[v6]_hdr() to make sure the outer header
is actually IP and (2) add a field to struct sk_buff to track layer
2.5 headers.  The first option might add overhead in places where it has
more impact than addressing the problem in ARP.  The second option, of
course, makes struct sk_buff bigger and more complicated, which doesn't
seem great, either.

P2MP: This splits up the mpls_forward() function to handle P2MP LSPs if
the route's multicast flag is set.  It uses the same array of next-hops in
struct mpls_route that a multipath configuration uses.  It is convenient
and I can't think of a use case for p2mp+multipath, but I'm curious if
there are reasons not to overload the next-hop array this way.


Eric H Kinzie (2):
  net: do not interpret MPLS shim as start of IP header
  net: mpls: support point-to-multipoint LSPs

 net/ipv4/arp.c      |  15 ++-
 net/ipv6/ndisc.c    |  13 ++-
 net/mpls/af_mpls.c  | 218 ++++++++++++++++++++++++++++++--------------
 net/mpls/internal.h |   6 +-
 4 files changed, 176 insertions(+), 76 deletions(-)

-- 
2.43.2


