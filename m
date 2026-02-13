Return-Path: <netdev+bounces-258573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGB3EHXMjmkRFAEAu9opvQ
	(envelope-from <netdev+bounces-258573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:02:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF41335E6
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A85DF30A9E8F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A26B26E708;
	Fri, 13 Feb 2026 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gw7l1cVy"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13E249E5
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770966097; cv=fail; b=SUOA45LDF6XLcV55Asp91QsWPz+VWt6gCFLtcYFq4pYgGoYKk72o0jTNIHABtcYUvwN2xvRLOgIgHtCFhftNAXJT0qWTCxPz/sQlT9Y0wVIVYlswyeaDRzT5HBBp/HLtrMCuxuwabD2RIgnSpEur12gNfikm07lDGehfuwGlcfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770966097; c=relaxed/simple;
	bh=8QYiTejX17WHo2G0XLbSry7thuR6/sIqB0j2T+dBG8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=corBSgJnRhPVAxeQToadsokZo5GicbzjedNCmn/mf34zsj7bx89OOBZ/ffMSvdzW9IZsnIoFoZznre/4ACnui5ud4nzwcFrIRBACyItSp0u9HFv1VYT7YJxgOjh9dwa4sKytNEi0wvVlxNFPWQAFQj8yHDStACd0ScByqJ+hwAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gw7l1cVy; arc=fail smtp.client-ip=52.101.62.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut6Y8bb+wkIMQLvGyxft/Cocu1AET+nKmwxZBDSEIAkG2YnJOpbO1qK8vDixaMeFKLAthEQmCQs0BqMT8cPBAFCFxmULeYsFTbqA++U+DbtAifo7SydIOmIUFtRsj1k7hM6qAF//FI4/72mPnuT8An2ja+ClckxMsUCxjE+NkOe/p62VKgsQ6+oVF+NKwDG21sGLqwqekr6h8Fw19HfRRe2FQZ/QzGYzC0Wq/FkCQiU2yQwVkfHoeOkt9MS/kV30z//iGr7tAQnKz84KR3m9nN15RDzMV2QytSA/FEo2B1c1P/wJbQ0H/zij/+WDOMzrDiYN6IExs2ZtHvHM9BK1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltVN4jSMREXzJf1CqZra2zNZR4OYjTjwDGogJmGsfvA=;
 b=W+kLR2rHBF1fP8jz2Nmh35SSrIdKzhqbODGb0SeDh+LCc977BvShC9sZE9cYnJ47Xw6X62GYt6gkIIRJApYNFnv5Tn2gyCgM1yo/nlKBX8fh+W+WE0ARBDEFIgtIMOwSix6cUc21Wk0u94mKh9c8KrMAvYiohFCG3tbMmdT8a3KRvwilYvIEFAkbyuCv30d5RVYpDAn7gaCKfE5BcAJ+vK9jeqYrwtfFpkSv0bw88VcL9Rd072foGgjhrt8ggQtAINOjuAibl4mkK7eU5KzEa7c+Je2OyQcRElYE2VWo9g84Tg6BMlRs4EbyWIHGvUOLV5b0W4iFyL5JnKXtYNg7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltVN4jSMREXzJf1CqZra2zNZR4OYjTjwDGogJmGsfvA=;
 b=Gw7l1cVyHUhltJpiI/zAqfCLeK+476W2Ci1yPCpesnLs4pt/SvPrQwY/w+FRnTpGBKBw3Up/XU2Kr3mgQQcbYB/JpHT0j472Scl9UYH4CT+WWZ6gQwHY1E3q5HoGGxY2Y80SqXSt0OXWTfgxhIWh7shNiH3/PlzTof6Q0FksFEgfCFdIEmc1sSicjcxWt7NEK6CuQ+8qV6xHSoOpd6eoU6QRNqN5WmCQUqSVBV5aGzTDTz+sL6KFQPIxR9PYnAnU1BxYBQHaqNCKHznE+KICsPibQMzvrDhUFiwxY9/+sO0JjI+Np5HTY8qj/BGXubYNXdWWmGh2D6w+dDUwjnU6fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 07:01:32 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 07:01:32 +0000
From: Nikolay Aleksandrov <nikolay@nvidia.com>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@nvidia.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: [PATCH net v2 2/2] selftests: forwarding: bridge_mdb_max: add tests for mdb_n_entries warning
Date: Fri, 13 Feb 2026 09:00:31 +0200
Message-ID: <20260213070031.1400003-3-nikolay@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213070031.1400003-1-nikolay@nvidia.com>
References: <20260213070031.1400003-1-nikolay@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::12) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 21032b35-b901-479b-c8ad-08de6acdb827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AZ5b2F856cNcfGN3jdfuojiiKRJAAKmCk09hwXh2B+iYIDSp+0xY+9RC3wDI?=
 =?us-ascii?Q?53Ydnxn374Mhi9W+omo26lEoBskcGN5X7kuTjOxqZRRzerBLiN3aY4cUndRb?=
 =?us-ascii?Q?4Ysc6ZqRm4jWT0YX4GPLdHJ4nGEoW5yYGXsXTaEsKeZx2wEXnvmJ9ogkAqG2?=
 =?us-ascii?Q?bd98EfIAZjnpoBKpMVCeY/eGbWXGCvnnee3Ys4M9up7+RzhZQ4P7vMncfB+u?=
 =?us-ascii?Q?mqjIxLrpvqhAhYCT6oPGZ6G1NJAG0VHJKzDJ3DcQ4SZEU0zm9troFFl4dy/N?=
 =?us-ascii?Q?hkz38QIzLSclnK7xrvIJwwwW5GKha5AUHGzS1K6rLXOll6CuB0c6HPOCCdDY?=
 =?us-ascii?Q?aLhdY8kqjnqXJleK1KHmwZcXFnMvcl7XVMuKbTs1H32xR5gpcxs+jd1mGGHz?=
 =?us-ascii?Q?ssk4oQ4U9GscnIhi8Duy6b1ZbTDGqaeK9QtYpSwdhvW3gF2uac8jbG1eTsz5?=
 =?us-ascii?Q?QbR0x1+TpH/hiTRVIkyUry7xoPie816TjWHsWk3SCZpNC/LJv5nLFL6n5Ws3?=
 =?us-ascii?Q?0goFaxD59mBGiK7esXX5kkrGZVZVvk9uub9xVLouqvKZiSWy65h8OyPNfIsJ?=
 =?us-ascii?Q?YH38E95ZRBMYX4JOc4kue3NNb62EvcCu1QDvTpzPfHO4uYsAzFNqy0GniDkH?=
 =?us-ascii?Q?/DRWTgVe7fdxQXtbUbFG+nqMJltwZzDyrUu8ytnpRCrPniMZSl8Ck4WI9ynX?=
 =?us-ascii?Q?SAtRTPmZkgHQzU9Gy+o9czCCrYtM0V5L4a+sGdj2YWyTDqRAIuF1ikAmRKr/?=
 =?us-ascii?Q?5uwkziDi5BaSQW3wEUkRGGwLdN3Ye92rGA+FIPlSu5klpRged+BjWlLyBiVG?=
 =?us-ascii?Q?fhmp49A2NCJSvUbYvsi3AM5SVzs5aZ0+17Z6GLkaAdpMxudd6wubVwvaB14t?=
 =?us-ascii?Q?CvzUUHDuiEHX0+c4olnOP3+pRwSep0gWfJvSmTbnNznBs9gTbaox8hoRqxGc?=
 =?us-ascii?Q?Rv89LVJ6LC9v6ZH+TJf5NhT1w5NCopFhHpEdRdi1KqgYzFN5hPvpQunD8kBv?=
 =?us-ascii?Q?fs6+pHAoaeJUoTacevGdb/e/agJjuPl677v1rOjI6WlUGHHYw5C9BFBC4rvl?=
 =?us-ascii?Q?m8vv9ikubpwRFkRV2PYMJZTyyH9FhRYjAdqld/go3Ums5JHVrNdFZxL6sCn2?=
 =?us-ascii?Q?nLTbKetNJuoAq9AlRSUi+h3ferRkE+7R6I3N21S8wTSfME5Qhb+kZh6BjS8m?=
 =?us-ascii?Q?DIS4dksXmnZJ/IMoPyT/8Qppqp1A7rmoDvVGzyWSqAjTLKMBLtosnV6HUPwo?=
 =?us-ascii?Q?NJmv5qcm+yvRq3eCJL1ypt4t3l+Tjq/3NYdDF1Zp3OhGj+mcspC9ufP99gZ5?=
 =?us-ascii?Q?vGWVNGsOfLsxGZY2Hb707As8YLGc3xUUnFCr0PBt3ieiV6uxDPn7C2WQyK8W?=
 =?us-ascii?Q?kFXH+nbzk4o43kG46deGef7EPyBB7GGs5fmE7zsRl/FmNLNdqDjMQ34Wmaj2?=
 =?us-ascii?Q?FLxrV8GIK9todTDVGzpShj0A4K3KQSiMjbaU+eLt27KbKffJPytL1hmgfZvZ?=
 =?us-ascii?Q?zvJ2bkkI1ifrwaeeJjfxgpOF3VtRJV/gEOFDG6yYJZkFd1BijHz0K7RpXM2L?=
 =?us-ascii?Q?NLh2smNKu71Z94x0I5g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ejgpt5CpfrwTwBEE5yP2teIKZOp62KAdnlKzfuFT1vzpOKcYrN54G+o4MwDS?=
 =?us-ascii?Q?VNYQal27kLX/w3fQ17VlWaS4ftxEUP6iWQmmav8BWcujpKGR0Uzp1ZKtKrkG?=
 =?us-ascii?Q?7VawsNYFC5rgOxQtMvAZl3oJWiZiiloNGOotqzRzRSd/lnhz9aH3SwCRvLIU?=
 =?us-ascii?Q?GjDBhrxxzuK+3NDIVK3P7wI0nHJV+fJE8oBBHj6ri00sMqNMEAKgRm33pk7r?=
 =?us-ascii?Q?/ky6tz69J3Y7CmGzIxDEIZjXBgIvfCb/g94fOYm670+kCNSaMrv7tenQwRZV?=
 =?us-ascii?Q?46xw4HeVvehZPycedkIowwBbnsrAD4hhgOIx1kMNhDAl4xUwKT8HuKVfgqXq?=
 =?us-ascii?Q?lXf71yYmO011famDYzTKJYbJTkwXar411ZfBv3pmP5r/JHzXG4MIPcTZjgSA?=
 =?us-ascii?Q?me9LEB6Z3LX4tySmkRjmt3mmSa9Zz8oWsSjII599XCUAF9fgIPAuB4m+/Rwy?=
 =?us-ascii?Q?MwXhykDOuyQKhL+acQGXth9nV19/9YhD16KX9zjrFlFVyWblbO79hPaYloRt?=
 =?us-ascii?Q?tn8Nfua5rhqEh1xT8we46u7AfUQ4euZEtpeI/wGf6QiE2/1/BkXBvQ78fDEE?=
 =?us-ascii?Q?9TDMkLvIA09PgceZWQEN8zDhGu1BniE+PTCFlxVbI6yLPVx4GV8+n6/OoJ0n?=
 =?us-ascii?Q?y62vPulGstDcbQDV7jx4LYNwqI1hLQjPKhpcAhAoDFrxabRH5NMJ/IgJavK5?=
 =?us-ascii?Q?vEJpuhzv0SvkhX6urx5i8aS1HDWXAiii7yg01k0W7mkxETY8wDsp9pRbpCBP?=
 =?us-ascii?Q?S7VFdHmPG6AsC/FMp4A9Drrc563dlwkcariDH6txMRMEARzMzMnbW7OtFknb?=
 =?us-ascii?Q?BUgk+XlzJ83t6v/sF1kp6J8i2t5KmF2oKVYWW6mLjStpPa2hC9fayJDf0qgo?=
 =?us-ascii?Q?gkCTa8qmxdb5qVRUPNkqn0PkfZlFseNJwd/U7ik3d27HuqzT92z7dhm7b7iA?=
 =?us-ascii?Q?w+Tb0dvEMeYm35sZFGaGmzeVVa0R0NSjZBmBveSV1cKk5sFUgZTad3TTn1he?=
 =?us-ascii?Q?J6qkRMji2YzjbyrTnRwbrPDEz0uA9fAoD1/dwYSd3EMmSptnwA1lNSofYIBj?=
 =?us-ascii?Q?kR9TUgA4HXOpSFhVdVR0kFw+ovfW/MlqLUSF2XO4XTnO2VYBXxd/MQUMd/aE?=
 =?us-ascii?Q?ftgY995cWAt2C22ipLed4I28u8KvObrkpJBwispJBgIKt6Jgikf5gj58P+jJ?=
 =?us-ascii?Q?5r4FjDb37jNroHRP5FvfFpXNSOKpI6NEZJ5FAlkzQZaonfnuw+asS2p5lPel?=
 =?us-ascii?Q?u9+cutnbwGvHkKkb7SaBmsJEFUR5TnvojtljJ2EOO1Ty6tFL/IWfN/n55PAs?=
 =?us-ascii?Q?REQAY3uoM0+1UYsYV+sRnpqC3xRATQAxrxOQ/dJ2maCRAOeZksyGRORo7ZJ9?=
 =?us-ascii?Q?c/Ph4fo1+ZuCT+DIW4JiHPkqR3Zl73BznybmtjdhQluazQHHgyssG7JFWybh?=
 =?us-ascii?Q?6ZW1JurfAcbngJsg1bEXQ1+nYkgetKKkVLne0Aoztz3+byE+vCcHJwu0RCUu?=
 =?us-ascii?Q?ZEAYNHx2dVMGaXtATXumVKJSXm9CgfjF+dOBIajvgsjMGZ2PI+PmZDq7dFwX?=
 =?us-ascii?Q?b+yU1+TwoGvIqhOtqi1tMSWAK76PSesLYtj0uKe6/isyPjuvHIPzgAHuIcLr?=
 =?us-ascii?Q?rVOAd/vVVb0xEasIFfAu1PQbG8DR7aM+S5FhpYo2jGE6bWguzx6Ym6qzre2E?=
 =?us-ascii?Q?KDwsb3cX2HFE61Qr5xTpTk0/QHwY6QyxJDxfL6A4RzX/0q7/3kLjoscMp9Ey?=
 =?us-ascii?Q?MdTgexIp1w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21032b35-b901-479b-c8ad-08de6acdb827
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:01:32.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dZr74moKocWT27r0ir9omaVx1DRrzPOkJNyPrvK9DLDp/xbTH9d0S8RmfAiTfmiUcZVP1sv8lL6wfzXF5V+PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258573-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: ADFF41335E6
X-Rspamd-Action: no action

Recently we were able to trigger a warning in the mdb_n_entries counting
code. Add tests that exercise different ways which used to trigger that
warning.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
v2: fix 2 typos

 .../net/forwarding/bridge_mdb_max.sh          | 90 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
index 3da9d93ab36f..cf7a2d43a81a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
@@ -28,6 +28,7 @@ ALL_TESTS="
 	test_8021d
 	test_8021q
 	test_8021qvs
+	test_mdb_count_warning
 "
 
 NUM_NETIFS=4
@@ -83,8 +84,6 @@ switch_create_8021q()
 {
 	local br_flags=$1; shift
 
-	log_info "802.1q $br_flags${br_flags:+ }tests"
-
 	ip link add name br0 type bridge vlan_filtering 1 vlan_default_pvid 0 \
 		mcast_snooping 1 $br_flags \
 		mcast_igmp_version 3 mcast_mld_version 2
@@ -106,6 +105,7 @@ switch_create_8021q()
 
 switch_create_8021qvs()
 {
+	log_info "802.1q mcast_vlan_snooping 1 tests"
 	switch_create_8021q "mcast_vlan_snooping 1"
 	bridge vlan global set dev br0 vid 10 mcast_igmp_version 3
 	bridge vlan global set dev br0 vid 10 mcast_mld_version 2
@@ -1272,6 +1272,76 @@ test_8021qvs_toggle_vlan_snooping()
 	test_toggle_vlan_snooping_permanent
 }
 
+mdb_count_check_warn()
+{
+	local msg=$1; shift
+
+	dmesg | grep -q "WARNING:.*br_multicast_port_ngroups_dec.*"
+	check_fail $? "$msg"
+}
+
+test_mdb_count_mcast_vlan_snooping_flush()
+{
+	RET=0
+
+	# check if we already have a warning
+	mdb_count_check_warn "Check MDB entries count warning before test"
+
+	bridge mdb add dev br0 port "$swp1" grp 239.0.0.1 permanent vid 10
+	ip link set dev br0 down
+	ip link set dev br0 type bridge mcast_vlan_snooping 1
+	bridge mdb flush dev br0
+
+	mdb_count_check_warn "Check MDB entries count warning after test"
+
+	ip link set dev br0 type bridge mcast_vlan_snooping 0
+	ip link set dev br0 up
+
+	log_test "MDB count warning: mcast_vlan_snooping and MDB flush"
+}
+
+test_mdb_count_mcast_snooping_flush()
+{
+	RET=0
+
+	# check if we already have a warning
+	mdb_count_check_warn "Check MDB entries count warning before test"
+
+	bridge mdb add dev br0 port "$swp1" grp 239.0.0.1 permanent vid 10
+	ip link set dev br0 type bridge mcast_snooping 0
+	ip link set dev br0 type bridge mcast_vlan_snooping 1
+	bridge mdb flush dev br0
+
+	mdb_count_check_warn "Check MDB entries count warning after test"
+
+	ip link set dev br0 type bridge mcast_vlan_snooping 0
+	ip link set dev br0 type bridge mcast_snooping 1
+
+	log_test "MDB count warning: mcast_snooping and MDB flush"
+}
+
+test_mdb_count_vlan_state_flush()
+{
+	RET=0
+
+	# check if we already have a warning
+	mdb_count_check_warn "Check MDB entries count warning before test"
+
+	bridge mdb add dev br0 port "$swp1" grp 239.0.0.1 permanent vid 10
+	ip link set dev br0 down
+	bridge vlan set vid 10 dev "$swp1" state blocking
+	ip link set dev br0 type bridge mcast_vlan_snooping 1
+	ip link set dev br0 up
+	bridge mdb flush dev br0
+
+	mdb_count_check_warn "Check MDB entries count warning after test"
+
+	bridge vlan set vid 10 dev "$swp1" state forwarding
+	ip link set dev br0 type bridge mcast_vlan_snooping 0
+
+	log_test "MDB count warning: disabled vlan state and MDB flush"
+}
+
 # test groups
 
 test_8021d()
@@ -1297,6 +1367,7 @@ test_8021q()
 {
 	# Tests for vlan_filtering 1 mcast_vlan_snooping 0.
 
+	log_info "802.1q tests"
 	switch_create_8021q
 	setup_wait
 
@@ -1334,6 +1405,21 @@ test_8021qvs()
 	switch_destroy
 }
 
+test_mdb_count_warning()
+{
+	# Tests for mdb_n_entries warning
+
+	log_info "MDB count warning tests"
+	switch_create_8021q
+	setup_wait
+
+	test_mdb_count_mcast_vlan_snooping_flush
+	test_mdb_count_mcast_snooping_flush
+	test_mdb_count_vlan_state_flush
+
+	switch_destroy
+}
+
 if ! bridge link help 2>&1 | grep -q "mcast_max_groups"; then
 	echo "SKIP: iproute2 too old, missing bridge \"mcast_max_groups\" support"
 	exit $ksft_skip
-- 
2.47.3


