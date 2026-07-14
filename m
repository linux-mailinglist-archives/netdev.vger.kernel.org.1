Return-Path: <netdev+bounces-307512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YvL5GIZUVmr03QAAu9opvQ
	(envelope-from <netdev+bounces-307512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:23:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ED6756648
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:23:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=OBtsXgt+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307512-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307512-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82A763098695
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E14A33E3;
	Tue, 14 Jul 2026 15:16:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023087.outbound.protection.outlook.com [52.101.72.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3544A13B4;
	Tue, 14 Jul 2026 15:16:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042218; cv=fail; b=EInLuhFymrpjbBUGloc/y7qewxDy4cdkurZA8KxuvgXQWI9NqWdYPGuTGwql3aeCdI7p/ppV9pSNTmkcw5z5E5b8jIN0rO/3fAA8XDNIbzYVljTOkY7TvVy1utHyQwnlQKgYZlinWDTtocLrISMLXF2i3s7oJdlaranHAxwSJpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042218; c=relaxed/simple;
	bh=ydU+oXAsuhWrk45lruJ9qpp+PozOdICdjCQBRWWyQR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbYeW4E3RbZWgkHEFTxWEOHFNmYbaXN2/xiGIiCrCZR1v2iw4CoyXAX/BKNH5IejDlLyXC2DDCjqBOvvOqZOX12npE0YG/bbPeYXd7RmtAIjty3RKtmGwEsBpAAPx4Dn9Nja4b2tpEfBOdPY9iKpsi5jhLyq1WUluHMOMJnlfVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=OBtsXgt+; arc=fail smtp.client-ip=52.101.72.87
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EilbPzhjz3HRn4H4DWAlfMxrt7e1R+kI/5uP4mkR+LV1/A/QLDcMc2om/hMQ6J7VEZh7bTTNh+0XoihQHglI9l1B6IjFqb7wdWXXzAYXWCtTX/DTGEpi7KCSpC9MX9zcpcycrjCHJ75DIB+7lp5M90itSbIO0i8JNEL9PD9KolYeXzTPkisDKyiOnEn3jShefxe1wmcYFpVrfFqqloIX7PrOvSSeu5FqD66WZNCdTuuf7FQPDn+Jers/z1gBGysfAzSsKvfzjCyeN0w8rz4aVjeZSKQgkgYDEz+sGJ+OX6NrL6ZGRBWeouudyoGi/LsXCAL81nTytBaNEadIyh6W6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rMmVOc6DiwI0NQL5M8bhoO50mPRicAqqqRFmQXakjI=;
 b=Tjg+gBV/+lkSZT3BhtxgMLMmDGLWV6Ashe0P3QtZC1/8752bgJPUbIclTGKelb6U8tXJIk6up8wnruhin0zoP7mno9iT2eJMPonL5Z3idHykqi8JigwPZiIkddVAKFPa6q3EF+UGGOMwliPAFBTcjjo3tl4ivOFk01IHxNx0mv8DavjKs+RWHJk4ZjUUdn9LUhHOe+i0XVAz9AaVAe7LpH2SK6Lf4J26YZZBGX6jDx8q01Mv9+x+7JpgiuFJuqc4nL3IjiK5Jgq7iWYV0wZ88tEIRW1xnJf2RXJoFTStjf73de1Wdg5qGYxwg8My6+hqlkWFsXS4ngghU7dpQLNxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rMmVOc6DiwI0NQL5M8bhoO50mPRicAqqqRFmQXakjI=;
 b=OBtsXgt+WGIshvaRFwRO9q5Sf1meiQgoJY1R8//oO9JqAh5xx472B5g9Wezy8BevNk4GnBTrDWjiokjhMZCi9IkaKfzUEtknuqmM1zopupvyiEo0A8liUAxV0EcaxjF+lBzduTgf15AtSWz4rBVOYwu1Y4BGZu/eE/98THvhEIEu/y8QHMLwHQ1b4BQr8b5J/2nHP1nLUYhWhPz+f8XCm2w2KfU4xGze81J1SmP1TlzkMGHEruAU8lXCvLQAgYOyKhmJ0XXnkAi1GQdsNukBjSEKLJ5Nii9v8icOswnI6Uezmsgk7OKEdFujacoisQd4ndr80H0dialduZb5CGpBEg==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB7692.eurprd08.prod.outlook.com
 (2603:10a6:10:3a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:16:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 15:16:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH v4 2/5] vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
Date: Tue, 14 Jul 2026 18:16:35 +0300
Message-ID: <20260714151638.143019-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0107.eurprd09.prod.outlook.com
 (2603:10a6:803:78::30) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 12af8642-da4d-4313-1171-08dee1baed53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|52116014|7416014|1800799024|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qL5JKNy+osUPsD7e5yD8XkKQb4LNwMCvFdWE1mhD+vJObku/npcfBfTu9BIdfd8YuZIrsEfPToUvNyb5ggp7aWH4vTvWHARziR9+eKaZZPkNHbdjE1yioJP0YY1B4DTuEV/px3SvSt71+Y9RW4rWG7A0jRKDZIcrMibZkOVsLLUUjI0JGlE66tJTiZ5Jje8AhmFeSDMdGZbYjdHCk6LmQKBjDNeKF0L4y7/I7eRYiqxebmXDnuhjgQWL10tY92x/euBeFcgevWIWb22MoOD+Ly1INsJ5rRNfy4Tq0retMugyUyB4x+sf01i89A4j6rCkf/ds9dLJIjqYCYmPbBcr8v6237JldXEmqvijGvP1zNumIi9fBO/FMGnejAl62xlWy2cFfU3TwZJZeaIZo286ryIb+JP/e7wtDlxoIACp1CV3yz/iElceUPE5mDdGWuviV6ku4jxWy+G1lMOOb/sv8KU4xKQc/dVIjyYxGV827/1JSrd9Y0cDLaxBb4AQesYS19TDBTltTsRsBr+c9bbkNjuVT7qTgcOI+0H641gg1A7ULaa7pmzw3pZ0pF2qlmcnXLzAv2hn+7hpMl+VZIa4B5uluiLOtz/Zp6zbf4Cc+PCWHBB2AEhVP17MRb0huaumrEErIb4kyLSyQrxjoTPS224TqYIdgo/Sb/F0U/qbfgOJjNBc6jsD8/VxlnWeNKYR65paDdkAxgfJZP+TmdlYfI/Gv72esbuCR3g1upDtVpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(52116014)(7416014)(1800799024)(56012099006)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZPTpS/PfRuJdwkFoIwrZWo0DaC1XqoW+H8kOK7Qla5M2rR2Jaez8d6oM0nzV?=
 =?us-ascii?Q?RGfTcZfjbc1vY0+KRvzxc+jeh4zls0Qxr/K+6VBGgLRKaK3rwhmUwngXdJ9p?=
 =?us-ascii?Q?oU1RkPkZuNs5HgrbpB21L+PR6hK7RelBOnRo2lLIMe42MB0TTjjP3OQZveIK?=
 =?us-ascii?Q?QAa2NmMU/40vFx0B33HuYo6Usnbao2ywBHjjyVbNPnPWNZ6uQN1FISRPKbzz?=
 =?us-ascii?Q?hnoq5705iB7vpjEE22cg4t9KbtbKkKoM0moDeWCNCIunffkS4d/xAxVVx6W/?=
 =?us-ascii?Q?JuX/iAqpuikRU04bcR3uMf+iAKgChUaijISQBcjX9oBQv9+zsLb/Twv5/pTx?=
 =?us-ascii?Q?8MBur0e6mAIHIHqxcUJxLK8qFQ9yV1jdV1xkIN2X5w3L3jl2oRcPLecbgj0j?=
 =?us-ascii?Q?Yb4r4BTjf8wBM/xw5vd0aPqPFLVOMNeNqet4WGTwTZ6HvXhRmVATZAGJMwAo?=
 =?us-ascii?Q?8ZOXcyWDG6hZUDgKG9WeKBNLhl7Ca5C3lyOI8VSEzEdDuo1C4zkjdsmuhjPl?=
 =?us-ascii?Q?aNsDmtAAiy9lHJMLyLz3PNL38b1UzdN9gkqKAVII3BCVdAQIOBW5XwdJXMLc?=
 =?us-ascii?Q?hviIsvuCYIW9hTimVPSF2OcfPdPNi2DXIHOeCJ/9mAgoS8PYnkcZWwY7JsRS?=
 =?us-ascii?Q?SJdHHIa5zhp9kXFLBSBcuTXfJpDTXUIAXH8F8NuIMfOM6CUmT8Ww4oRu7lk2?=
 =?us-ascii?Q?dBds45c21mVOn+a8cEkf3V6ryaRBnwWh24Az6u40fPUcPYsRFGpD0+tyGR91?=
 =?us-ascii?Q?DAIfYotn2Ots8xpPRKlNhobmpZlfyF/qYOjgtj/hhPml7EgSrjdM/KLoliUL?=
 =?us-ascii?Q?/kREXySa9sKMQGXUFrgf59NqoTj6BojTrIYAg8Ce7inBA2SKvhIhtYKo312B?=
 =?us-ascii?Q?3Z+XfmpXiqLM8z4kMTN9IGf73bzwOGj3PVfA57L7e2paz9k8F5Z1+0a+nUzp?=
 =?us-ascii?Q?CDdmHoduSkWSDi6TfLs/pzzmCICvsr946CL9i2EmUiMvYib9R5XbbpYKLuGN?=
 =?us-ascii?Q?oY6uC0Jle09Uv7juSzYoR9ENbiT5l5+kffhVefkWR/K9303ldJa7XR1eNBTs?=
 =?us-ascii?Q?mVi5OEsRrOrSwm4gFH/4YYYE3pzS9Wi/V6FARkrusOB6AWwBVo5uHz1hEuus?=
 =?us-ascii?Q?1r36fEdfnNL99nhuvc+Yyi3rI1FjmpbQ6yUcw0xla/kZ43d0I/TAgpR9DTjO?=
 =?us-ascii?Q?kq2F0+VdgQ6XxXjBwcK2yzBkKMoM/aQt2bMRxrdh1dxUNFo1DPoI5SUzxO1d?=
 =?us-ascii?Q?cl1kJbcDuqT9YYvxYNIPQQdWwj9UNBSPDVlBa+0yvWF1oXIpbpgKxB1o3zkB?=
 =?us-ascii?Q?Czk9CGoS07vTsqdSka6d+HMwtoBSfP9qhRA8PwWHHTTf8NhJbJhvGo2XZqhO?=
 =?us-ascii?Q?S/OFo4/VCvgdd18oAOlIXrnclVhWq8aGAIInss2mygRfLoMo3agj0aJ7N/AV?=
 =?us-ascii?Q?Uj6He4nHLWNj+Y+Z9snlLmeEkC3ITdOU01MtMvlaDa+CLF+/C6GZ7G4Qegrh?=
 =?us-ascii?Q?Dt5NKrwEFFQh/JoHy9yq8pSWmV+BzpIUtthu3YBiPkMFq48lXO+WqczuKUBG?=
 =?us-ascii?Q?V4LTuW69eeWfxGAOuVBg5HCPHdOA9FPQDaZBVTemXeocy8sUy4y+knRlckLL?=
 =?us-ascii?Q?lgyTGiMwYu8g+LlMSPmpbjFs9CXKfPdxk2wg0xkOOYx4R5QlxUXCvaoA28sH?=
 =?us-ascii?Q?G2II8ml10skrIMevGpTphctsb/s7utEZ73RYnHUSDl3zdboMwqXmkuj/RKq/?=
 =?us-ascii?Q?FA2DTnn6WRNndK6SW3twqR2s7G3rA+w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12af8642-da4d-4313-1171-08dee1baed53
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:16:49.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcjvKsteVS7qLzQ0g87saxFt45zLNO7mfbKw/ykepkhX+wrno/QMU682PQygPwu9idgrDqtA5HgWy5VoWJaUjcN3AVctGyidBYCoJwRcfyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7692
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307512-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:from_mime,virtuozzo.com:mid,virtuozzo.com:email,virtuozzo.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,openvz.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06ED6756648

Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
immediately when guest isn't ready") added a fast-fail in
vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
until the destination calls SET_RUNNING(1).  The fast-fail condition checks
whether device's backends are dropped, and if they're, the guest is
considered to be not ready.

However, there might be other reasons for backends to be nulled.  In
particular, when QEMU is performing CPR (checkpoint-restore) migration,
device ownership is being RESET and SET again, which leads to backends
drop and reattach.  If we end up connecting during this window, an
AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

Add an 'ever_started' flag which is set once in vhost_vsock_start() and is
never cleared.  The behaviour changes to:

  * When device was never started -> flag is unset -> no listener can
    exist yet -> fast-fail;
  * Once the device starts -> flag is set -> we don't fast-fail ->
    we queue and preserve during any later stop / CPR pause.

The VHOST_RESET_OWNER ioctl is implemented in a following patch, and
without RESET_OWNER the problem we fix here isn't manifesting - thus
this patch is a preparation to support RESET_OWNER.

Important caveat: after the first start, a connect during any stopped
window is queued instead of fast-failed.  That was the behaviour before
the patch bb26ed5f3a8b, and we're restoring it now.  However we still
keep the behaviour originally intended by that commit (i.e. fast-fail if
there's no real listener yet) while fixing the CPR path.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 drivers/vhost/vsock.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b12221ce6faf..27169a09e87e 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -61,6 +61,7 @@ struct vhost_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool ever_started; /* set on first SET_RUNNING(1); never cleared */
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -302,17 +303,12 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 		return -ENODEV;
 	}
 
-	/* Fast-fail if the guest hasn't enabled the RX vq yet. Queuing the packet
-	 * and making the caller wait is pointless: even if the guest manages to init
-	 * within the timeout, it'll immediately reply with RST, because there's no
-	 * listener on the port yet.
-	 *
-	 * vhost_vq_get_backend() without vq->mutex is acceptable here: locking
-	 * the mutex would be too expensive in this hot path, and we already have
-	 * all the outcomes covered: if the backend becomes NULL right after the check,
-	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
+	/* Fast-fail until the guest first enables the device (SET_RUNNING(1)).
+	 * Before that there is no listener, so queuing is pointless.
+	 * 'ever_started' is never cleared, so once we're up we keep queuing
+	 * across later stop / CPR-pause windows.
 	 */
-	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
+	if (unlikely(!READ_ONCE(vsock->ever_started))) {
 		rcu_read_unlock();
 		kfree_skb(skb);
 		return -EHOSTUNREACH;
@@ -640,6 +636,11 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 		mutex_unlock(&vq->mutex);
 	}
 
+	/* Set 'ever_started' flag on the first start; never cleared, so send_pkt
+	 * keeps queuing (instead of fast-failing) on later stop / CPR pauses.
+	 */
+	WRITE_ONCE(vsock->ever_started, true);
+
 	/* Some packets may have been queued before the device was started,
 	 * let's kick the send worker to send them.
 	 */
@@ -728,6 +729,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
+	vsock->ever_started = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
-- 
2.47.1


