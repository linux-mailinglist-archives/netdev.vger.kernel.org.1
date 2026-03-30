Return-Path: <netdev+bounces-273045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALblNlDeyWnM3AUAu9opvQ
	(envelope-from <netdev+bounces-273045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:22:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F908354C03
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA9D63019B86
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 02:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57657391856;
	Mon, 30 Mar 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e1NZoWtB"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FFF391E51;
	Mon, 30 Mar 2026 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837276; cv=fail; b=EwwDUcI343Rbjl15HsWpBjACCv434WFsuow4wIMgOhTHs5yPV1xPs+t6Lr1CyOvt4rJRF+DiZJzEdzecs8iJRMoxtAbcNVGpXx6nPAceln0S3nhtw1BeShyde05F0CLMIvGIdIXRHlR8HxIi+zc4Auqrje52L6USE7RRd2uPErE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837276; c=relaxed/simple;
	bh=F6pPaU0pHFkjHKkHIqBn2YUnBYqSOgsKdfd+SShI3yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meP8Y2SIIuuiWANabppqjiVTScm4/uDzErPpnPrt9CYPojLmHCIAOM/q1+60uGHyRmnp9Kj6BVTg4vFyqJOEDyBtMpaDOMbCQ1rVS+DKtpB5Oe5faYVrSNhg/rR82hZC+1TnJ8YTv94YEdJpFnXstFTZc90Vgo8usJKeCDk7iV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e1NZoWtB; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHN06+w3aRPl6NX0kGsOwH9PM4O6EFT1pNfnh8attM/Ui6BupPG28iN6Xlqfch1yJeUTOw/eO9tisQKXCkFGJN1utjj/ylLxl8PxzW7l9vHX1on4kxRBM7rp/oajDuRCnnICWfVLi5nUg+dKCDpT9ZK1OO4iA0Bs3tHDZ6Sv7LTH5XTV2g+JWkhIyWBb0YcglN+4Kp8EwTJ+ddogjU7QAgI4/7ck3zCEfZbsG7fuqpBizVmIoxtlmkTg0HV6zVmFuermrlArpXLbDgXGTtNfkYpapq3k5bw7fY9mjZ3l7CoiuPlOINWGKratCu+Qh2PBoXUK6RtOWlUcqXQVzr/wKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYtY8I8O/4EkS37y2GSGl/LGyImh999RZqLafmap+7k=;
 b=NnIWiIaCJUamENaQ83egTGa0avk4kyqohK7yKdvM7xRxPRaPH3o51Wwm48P6bkXq8ITDfHhLJmR0iP9F+En74DpjJh/6m2O2SGApoJYgsyXJYOO83tTC7ow/y6D128OlBU6P62bQIUqwg9vKWimu08zqiybZWnEmX5M9RMmZX1mOFGbxIfI10l65BmNVNCknuanngwnLpgn0/W573QvQh7kMA0Ev0qHidIYWkLv+gMT7RePAIuaC0vY3GW2d4SuFBio3/egjq9w1T9jwrO0zOTD3WMQO2j9xqf9VolXZQSynuEzqrV8EvsieK6nz0p4azGrEdbKsBhrOCgP25ukNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYtY8I8O/4EkS37y2GSGl/LGyImh999RZqLafmap+7k=;
 b=e1NZoWtBLuntkg25lsLUNwDwEptIH8UsH1ljCqGfy38HF30fkUVWoAWQ9+0aAXN6RKbXkVDxjXDaBqr+Cv0pWJVQiqHDUmsg7zHM9Ge3oG1otrGY1uanL2REQ16rp0Ges01f4JVJo7IdhhKSuHMWWQ/lKw3J0w6G/+zukWYBjJXJr2+6VcyvKLItPinz5R/R/q7Dapg/Bzu7adxxZtMK7G9OWpPZTkkAl+OFonTFEOd7/lM1m/22bsvSqZR4zZBU9FjqT310/U8rluQoIBq9mRLHbanKRUZnK02TUygjgKMsXSulUh0GUhiV+j3/JU0c5QQHvB1VsUIQtQjSm+9Kfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 02:21:11 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 02:21:11 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net-next v3 1/3] net: bridge: add stp_mode attribute for STP mode selection
Date: Sun, 29 Mar 2026 19:21:05 -0700
Message-ID: <20260330022107.670566-2-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330022107.670566-1-aroulin@nvidia.com>
References: <20260330022107.670566-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:a03:60::16) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 231c99cc-0b03-447c-2eed-08de8e03025a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZRRKMXoUWVdAd3p4C09dymRDtW8eJLDrKi+dIcstifSwdMPMBDvkub/EjRSqtWYfZhB4KGlYZjFmOSlOdoV0XhxtFoP7X1abKuuvhIkL3tNPJD1IdOEd1jHe6r+exO1aXEsqLExwn2yzyOIN4b84b1kVj7ROfS8QpRJPJad7mWJh/XXSEchRFwTkCX/s3gYJF+4uoiVuMkN9bnBNULfBluhFfBA1Qrfrj8ePnl01d47or4a/6abt5CLGpJ7sElMvuMQ2SNfqy/nkLsSecfew4pCMIsQmNki09zadM+tiCcwHTpG4RSAfNYJow4tf4GcNVJRb/TepbECf4fVYeVT701ryNWRuOmRqNNhoQuKn3d6vPZGY94lCAW8FbHNaHbRIlo6dcSz1PHO8b1TdCqbxFeuqXxESyBYURHlah3ZAjinRA/6B6HdDsYoNupMyvI7FCxZlPuXuPIdj/kCIH12XNsmNTeKxkZ3CRYRD+rEEMAPCTqB/SIKDMIImgpDavQzaqdMvaN564QDJahKYsHmRn77HPdXhpHW6SSCWLRTr5vMn0EuE/0AhGk/qPmSShwFUBpwmdAt4cvwyItQ9q1ud0u+UyZc8K8y3dk8CFxRSwavAaA1mEwgVSS+i7ecTmlSTnOBtiaXEcXhPwY+8Es8FNUO9VMy2YJEI0ifWkfqMxEzaNM+rMBT49PyAcaqfjcLgq7X7kbU0icJIc/4hG3mzoobENepmDga23uJTxRQBKII=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18092099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EV1SyohJp7gWOtVaoeprbrPYXajFVhr1Xr/AEfvJ7IakFsgxxwDT9oRXpFj4?=
 =?us-ascii?Q?ulEAb8s5oVUdN7sfUwcTi0BKzMuz4R/rOdObn6UaFc1fBGJEO1Dx4xWA7Svj?=
 =?us-ascii?Q?KNVmnWvPLSc2zM/GC5si7a/tAe1QA8ys8h6scpKI54LiMj6D+GDFfXb9huLy?=
 =?us-ascii?Q?lPBeUt1QRP0jXJ9Y94shk7DEvAzW7fbGnFzK7uwLYRq9PQ3d6BMS+OZMlqXi?=
 =?us-ascii?Q?ia10mTF26A+5n+X8GlhfefUp3LTiEn2XRmpuaq4I6d70bC3BniBeu4mkvUAK?=
 =?us-ascii?Q?FYUS22iwCsyWXWqo2o704gY5hjUA3NtX6zstEvCzXoVp9YIJJ4asytiBoQMX?=
 =?us-ascii?Q?+UgdjN5Y/iWbxTFZp5XtdjJO+15B8H77pdart0AQxqiyYcmPMYh+OIs0XI0J?=
 =?us-ascii?Q?VDZ6puruQ/+DwVTfJcfxcOg+Elpr6sWMcvTJO8lQ1i8yRzs52FxAo1huaJ2A?=
 =?us-ascii?Q?ZLOhZgT1MlPmPjk3VtEo9E3+iIW4Xh1411Z8v49XejgIfe16Hs7ulvF1cfZW?=
 =?us-ascii?Q?Uo9UQAkJo1pd4ZvIdts7eUI1H0wMg0MgWi9TGsb84TbjBoqjDtiXvaDCcFlK?=
 =?us-ascii?Q?ZTPKumDj+zjxfn+LIdyTOI9c9P40MepqBpxOFCojIatEYUuLpe8c1yoUI9A5?=
 =?us-ascii?Q?FBKD2YVvcYGH6TfOJu/UiaP+v+ue5t2kuAGFDjhBMM+Fit+3bxLvPAaUkzOq?=
 =?us-ascii?Q?VWgPD0NOEsCBsdiOnjx5fdjnl5n6qOQAFClckVc4GmGES1gwQcCIPuMe0bIn?=
 =?us-ascii?Q?DsRIqcwdy8lYt0ak7eEEiQVjDM9vk2GqDezCuyr4Eei+/Q2atIYOG4ETbPOB?=
 =?us-ascii?Q?yqOHgySb/N9+LpnIKPBikQBxe1AJJ5j+ms4Kuy7WKYsLUEk05h/4QDReg1kU?=
 =?us-ascii?Q?gq/HI7lkCkE/brP8Ug6zd4PKAAAMbZsKfHuaOi55uXgqgUAsO56+hVaQs3Tm?=
 =?us-ascii?Q?1ucidd+HFuQDZOvrWUGPmt0ETe0UtsI1CVmQ3/xVc62MhCoHa8nhMjxNihtR?=
 =?us-ascii?Q?NtK90Q4Qg6B2PWvM/SZHwSxkio47AbKEM/H2Aj+f3r0JMN5CnBXr3Azl1xz6?=
 =?us-ascii?Q?HeOen6QZRZPnrFS6wSfF9WdgvMl8DfGOr7LxjKDRuB/DEKV2odu/5a/sYG2h?=
 =?us-ascii?Q?kx0Ly4XMHDyyrfRwEO65TcgLLs2plooj6d3d3301JgFzRaD36oQ+y+WijMJK?=
 =?us-ascii?Q?kFYUJ1mCmSL0irvyAmaR5hNT+xI+kAAsYemBBDqI5TMMmg30oWI3dRbZLZnI?=
 =?us-ascii?Q?c5EvByl7kNA5t454xF9RpS69TPZq8f6NV6sRF1YhVbFAxJXqCI/7qNW3+Z9Q?=
 =?us-ascii?Q?1IPbWDSj7XR9RxESLM72PsCVITXJoLXFZXGvqXUlAfRm41rsADGsZiPaMmM4?=
 =?us-ascii?Q?LE3212iM0v+fCK+ZjHeuremCyN4PuHXSurLipE5ZNsQJsv7MtnXxHflI42JM?=
 =?us-ascii?Q?rSrUL7+ONTTCUJ9Kv2NMNOK8/m+xRYKHd5wgkW45FUvjr8h9j34Tal45iwR5?=
 =?us-ascii?Q?FqrqI3Y02Tptfrag8ygSEutX+D8afhVjkmCAe2K21EPL4goKlfinBYKG5MVV?=
 =?us-ascii?Q?XbqmAyAdE5+RjgMF+UPoFbxenMGai3GrDczGYMrabFCDmrWML6mBPG8Eji/t?=
 =?us-ascii?Q?au2iTQ2QntWOH+Uyh96911mCnXlPlsQX3XmF7ptEp18z/F/5MML+2yd5hyS5?=
 =?us-ascii?Q?emndwMS3Td6JUie4TeD60xefkHM3o6zQ6T1ftP0Ey4StQXzqrnDXjgpIJIJn?=
 =?us-ascii?Q?D4ZiLtc0bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231c99cc-0b03-447c-2eed-08de8e03025a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:21:10.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH4az0gCpDTsjnKeCz6P1nrI0ez6uqYF25gb0VR8u70wh7KxONdAYraqBKM1gBDE0DFZKcdIJPoKhjdgsiAXmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273045-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 3F908354C03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bridge-stp usermode helper is currently restricted to the initial
network namespace, preventing userspace STP daemons (e.g. mstpd) from
operating on bridges in other network namespaces. Since commit
ff62198553e4 ("bridge: Only call /sbin/bridge-stp for the initial
network namespace"), bridges in non-init namespaces silently fall
back to kernel STP with no way to use userspace STP.

Add a new bridge attribute IFLA_BR_STP_MODE that allows explicit
per-bridge control over STP mode selection:

  BR_STP_MODE_AUTO (default) - Existing behavior: invoke the
    /sbin/bridge-stp helper in init_net only; fall back to kernel STP
    if it fails or in non-init namespaces.

  BR_STP_MODE_USER - Directly enable userspace STP (BR_USER_STP)
    without invoking the helper. Works in any network namespace.
    Userspace is responsible for ensuring an STP daemon manages the
    bridge.

  BR_STP_MODE_KERNEL - Directly enable kernel STP (BR_KERNEL_STP)
    without invoking the helper.

The mode can only be changed while STP is disabled, or set to the
same value (-EBUSY otherwise). IFLA_BR_STP_MODE is processed before
IFLA_BR_STP_STATE in br_changelink(), so both can be set atomically
in a single netlink message.

This eliminates the need for call_usermodehelper() in user/kernel
modes, addressing the security concerns discussed in the thread at
https://lore.kernel.org/netdev/565B7F7D.80208@nod.at/ and providing
a cleaner alternative to extending the helper into namespaces.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---

Notes:
    v2:
      * Add rt-link.yaml netlink spec update.
      * Allow idempotent stp_mode set while STP is active.
      * Move stp_mode next to root_port to fill a struct hole.
      * Rephrase BR_STP_MODE_USER doc.
    v3:
      * Name enum br_stp_mode for YNL codegen.
      * Add enum-name to rt-link.yaml spec.

 Documentation/netlink/specs/rt-link.yaml | 12 ++++++++
 include/uapi/linux/if_link.h             | 39 ++++++++++++++++++++++++
 net/bridge/br_device.c                   |  1 +
 net/bridge/br_netlink.c                  | 18 ++++++++++-
 net/bridge/br_private.h                  |  1 +
 net/bridge/br_stp_if.c                   | 17 ++++++-----
 6 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index df4b56beb8187..495836a569e8f 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -833,6 +833,14 @@ definitions:
     entries:
       - p2p
       - mp
+  -
+    name: br-stp-mode
+    type: enum
+    enum-name: br-stp-mode
+    entries:
+      - auto
+      - user
+      - kernel
 
 attribute-sets:
   -
@@ -1543,6 +1551,10 @@ attribute-sets:
       -
         name: fdb-max-learned
         type: u32
+      -
+        name: stp-mode
+        type: u32
+        enum: br-stp-mode
   -
     name: linkinfo-brport-attrs
     name-prefix: ifla-brport-
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 83a96c56b8cad..f159be39a6e78 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -744,6 +744,11 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_FDB_MAX_LEARNED
  *   Set the number of max dynamically learned FDB entries for the current
  *   bridge.
+ *
+ * @IFLA_BR_STP_MODE
+ *   Set the STP mode for the bridge, which controls how the bridge
+ *   selects between userspace and kernel STP. The valid values are
+ *   documented below in the ``BR_STP_MODE_*`` constants.
  */
 enum {
 	IFLA_BR_UNSPEC,
@@ -796,11 +801,45 @@ enum {
 	IFLA_BR_MCAST_QUERIER_STATE,
 	IFLA_BR_FDB_N_LEARNED,
 	IFLA_BR_FDB_MAX_LEARNED,
+	IFLA_BR_STP_MODE,
 	__IFLA_BR_MAX,
 };
 
 #define IFLA_BR_MAX	(__IFLA_BR_MAX - 1)
 
+/**
+ * DOC: Bridge STP mode values
+ *
+ * @BR_STP_MODE_AUTO
+ *   Default. The kernel invokes the ``/sbin/bridge-stp`` helper to hand
+ *   the bridge to a userspace STP daemon (e.g. mstpd). Only attempted in
+ *   the initial network namespace; in other namespaces this falls back to
+ *   kernel STP.
+ *
+ * @BR_STP_MODE_USER
+ *   Directly enable userspace STP (``BR_USER_STP``) without invoking the
+ *   ``/sbin/bridge-stp`` helper. Works in any network namespace.
+ *   Userspace is responsible for ensuring an STP daemon manages the
+ *   bridge.
+ *
+ * @BR_STP_MODE_KERNEL
+ *   Directly enable kernel STP (``BR_KERNEL_STP``) without invoking the
+ *   helper.
+ *
+ * The mode controls how the bridge selects between userspace and kernel
+ * STP when STP is enabled via ``IFLA_BR_STP_STATE``. It can only be
+ * changed while STP is disabled (``IFLA_BR_STP_STATE`` == 0), returns
+ * ``-EBUSY`` otherwise. The default value is ``BR_STP_MODE_AUTO``.
+ */
+enum br_stp_mode {
+	BR_STP_MODE_AUTO,
+	BR_STP_MODE_USER,
+	BR_STP_MODE_KERNEL,
+	__BR_STP_MODE_MAX
+};
+
+#define BR_STP_MODE_MAX (__BR_STP_MODE_MAX - 1)
+
 struct ifla_bridge_id {
 	__u8	prio[2];
 	__u8	addr[6]; /* ETH_ALEN */
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index f7502e62dd357..a35ceae0a6f2c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -518,6 +518,7 @@ void br_dev_setup(struct net_device *dev)
 	ether_addr_copy(br->group_addr, eth_stp_addr);
 
 	br->stp_enabled = BR_NO_STP;
+	br->stp_mode = BR_STP_MODE_AUTO;
 	br->group_fwd_mask = BR_GROUPFWD_DEFAULT;
 	br->group_fwd_mask_required = BR_GROUPFWD_DEFAULT;
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 0264730938f4b..f5b462a040b92 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1270,6 +1270,9 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
 	[IFLA_BR_FDB_N_LEARNED] = { .type = NLA_REJECT },
 	[IFLA_BR_FDB_MAX_LEARNED] = { .type = NLA_U32 },
+	[IFLA_BR_STP_MODE] = NLA_POLICY_RANGE(NLA_U32,
+					      BR_STP_MODE_AUTO,
+					      BR_STP_MODE_MAX),
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -1306,6 +1309,17 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BR_STP_MODE]) {
+		u32 mode = nla_get_u32(data[IFLA_BR_STP_MODE]);
+
+		if (br->stp_enabled != BR_NO_STP && mode != br->stp_mode) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Can't change STP mode while STP is enabled");
+			return -EBUSY;
+		}
+		br->stp_mode = mode;
+	}
+
 	if (data[IFLA_BR_STP_STATE]) {
 		u32 stp_enabled = nla_get_u32(data[IFLA_BR_STP_STATE]);
 
@@ -1634,6 +1648,7 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_NF_CALL_ARPTABLES */
 #endif
 	       nla_total_size(sizeof(struct br_boolopt_multi)) + /* IFLA_BR_MULTI_BOOLOPT */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_STP_MODE */
 	       0;
 }
 
@@ -1686,7 +1701,8 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
 	    nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED,
 			atomic_read(&br->fdb_n_learned)) ||
-	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned))
+	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned) ||
+	    nla_put_u32(skb, IFLA_BR_STP_MODE, br->stp_mode))
 		return -EMSGSIZE;
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6dbca845e625d..03e9f20181175 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -523,6 +523,7 @@ struct net_bridge {
 	unsigned char			topology_change;
 	unsigned char			topology_change_detected;
 	u16				root_port;
+	u32				stp_mode;
 	unsigned long			max_age;
 	unsigned long			hello_time;
 	unsigned long			forward_delay;
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index cc4b27ff1b088..fa2271c5d84fe 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -149,7 +149,9 @@ static void br_stp_start(struct net_bridge *br)
 {
 	int err = -ENOENT;
 
-	if (net_eq(dev_net(br->dev), &init_net))
+	/* AUTO mode: try bridge-stp helper in init_net only */
+	if (br->stp_mode == BR_STP_MODE_AUTO &&
+	    net_eq(dev_net(br->dev), &init_net))
 		err = br_stp_call_user(br, "start");
 
 	if (err && err != -ENOENT)
@@ -162,7 +164,7 @@ static void br_stp_start(struct net_bridge *br)
 	else if (br->bridge_forward_delay > BR_MAX_FORWARD_DELAY)
 		__br_set_forward_delay(br, BR_MAX_FORWARD_DELAY);
 
-	if (!err) {
+	if (br->stp_mode == BR_STP_MODE_USER || !err) {
 		br->stp_enabled = BR_USER_STP;
 		br_debug(br, "userspace STP started\n");
 	} else {
@@ -180,12 +182,13 @@ static void br_stp_start(struct net_bridge *br)
 
 static void br_stp_stop(struct net_bridge *br)
 {
-	int err;
-
 	if (br->stp_enabled == BR_USER_STP) {
-		err = br_stp_call_user(br, "stop");
-		if (err)
-			br_err(br, "failed to stop userspace STP (%d)\n", err);
+		if (br->stp_mode == BR_STP_MODE_AUTO) {
+			int err = br_stp_call_user(br, "stop");
+
+			if (err)
+				br_err(br, "failed to stop userspace STP (%d)\n", err);
+		}
 
 		/* To start timers on any ports left in blocking */
 		spin_lock_bh(&br->lock);
-- 
2.43.0


