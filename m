Return-Path: <netdev+bounces-307510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d/TKCTRVVmo33gAAu9opvQ
	(envelope-from <netdev+bounces-307510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:26:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E6756699
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=q0szfJ06;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307510-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307510-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B12430755BB
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990D4963AB;
	Tue, 14 Jul 2026 15:16:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023087.outbound.protection.outlook.com [52.101.72.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9FE48C40F;
	Tue, 14 Jul 2026 15:16:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042214; cv=fail; b=lA9LLHDO7Dvwl/AzsMBkIyldi8baWHzMcPj5XkCDwLRyCvzxIQHNt9ISLyO8S6kPhjR+5xFmrQ61xCXenUmP0H4QpuUqaMsHQoRUcWVnvXLaRz+b+l8iiVPin72co4toi8kgN+2n+h5coHmLmE4aN1/E4h2TMrTgCgQtIOKYsoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042214; c=relaxed/simple;
	bh=b8uRF0emTAt3PAVYx1tGx3e2GCRccnC3zSioko3y430=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CBpZIxFtd2W2EboGq6ifwpjqsR06A8vOMvHUD1H70fOR/sB7GtJOeiOwDJ01J9VuCFzCoh4JolDW8dAPp3ePOdmwaEM8dkVA9KCUaDt1J+2mJXf3C4L3ZmuruS0TMjZZrcAHuUMTVWo68EnQty2x5LT86ci9Ji1sssqoZcJEsBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=q0szfJ06; arc=fail smtp.client-ip=52.101.72.87
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxKeD1IHp8WuLjGlYOFer+fCioIAs9L7PrIM/YF2GMko9o/09Pvqz92GKh+TTrySXaAXK7UkUeebL1AeHWURAha2JM+rVyklAusGdCN+VpuwXmONeuY+jMTb8UFnm00yD6cM01OFAeeHeb97efGEcVhtDrHm5ivJiSkQ4gEEgt6brCio6arNHoNHa/NrVosswQ8bW5WkklE+hlX+k5XcltQW59Vm/4LdtU15B1bvB2VlzAf9y6XDK+U7QqyPyvYYyQkmshHQT7wmrMeELbPHrnzPOIGwFTUa34LSQIfSsMMRorad5WeuildI6cKV2EXRGRLui7YW3++2uTbuA8u0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BtX2Cbqi8Qd1lSZ3KPP4MasZ595d9hlHqGnEa+IRCk=;
 b=kU+kztqfZGgFTTakYooIQLLIaCXh4kAYAVzlm5fCKBQWcP8TAGOGyJ88pN9oGJyieqmUPKkJ2QRzNI6Zvd4MbpFWv8wR4NZ+tzRTTglD/8umBu1PZo4Ex9KlC815h+TWNU8kbIokfC71nOorYFPm8IaIZgat9cuH7m5H8LKK+nB2ho+mycfCI31yjPUcyc8aEJY3F01Qd6Ftp7ZR+uPea8z4bvkCLRiczi+8ajuUzoyVvDWdlcnxUNxKGOpkin8AR0j9ynW9+WUlEAi88B/yNVFsumZ/oiSsnKGzrNdR1LpB6MWf9U6zycyH+o7jQ6qDV8kqkIBjEa4DYD58vogVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BtX2Cbqi8Qd1lSZ3KPP4MasZ595d9hlHqGnEa+IRCk=;
 b=q0szfJ06DM7yRFO9fg1utGP51vkIxIzOpSZ3K3mzS/w0gDGRuyHweIZBOWUSiMmS6eKCp+rZCs3/dqr36Y/pmRm97MZJqYr2A2Q/k8Bj5eb0oUnXQUWAmMDgUDTbOQFuHobgpcvdRco0thJEmJO/DaTpDmprUvPXVKKmoGEBnKGvX1uPBunVDk7IEPsBiyD60iZoac9ui4Hg2UIOuswzGncTtyvfo7TgdoOvz0PgKljzpj2SWAey0jOw6g2vpzFGfnoj9FvHU4HsDU5NPPZV4T2wpUPRFvcWmznZrvxVUGlK3Mj3gHbX6s+v/urRs18JxTL2gazbgtEQE7yiD1XvGA==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB7692.eurprd08.prod.outlook.com
 (2603:10a6:10:3a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:16:48 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 15:16:48 +0000
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
Subject: [PATCH v4 0/5] vhost/vsock: add support for VHOST_RESET_OWNER and CPR migration
Date: Tue, 14 Jul 2026 18:16:33 +0300
Message-ID: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-Office365-Filtering-Correlation-Id: 5697c46b-da1d-4a29-db77-08dee1baec61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|52116014|7416014|1800799024|56012099006|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	h4LyYHRKX0RsEifC/hdbM7Sokali7d0hI6dtW/5534jhzw9wPqplkSAqvZrvK5SxkC/sX0LkpzfaN0SWZaTjyWITVdbf2OvyKT5BFTOTHD17mZpngFU8eOcz4sHGMRGYvYXiOfK7EZuh5iQJLNV9CtM+lXtZoW2mCDZ3kI+HhJywfBe1y4vqqDxRqO4xQ/+G3plfxkyAPMtkK3GRFtl2oVrTj2krzVZxwdzfuQh/3RT9PVVUW1uCqncmgTF1+HMPbdCxkfFlsFpNUEgSN3qoT79O8g1tIh5EJq64hn7WPhA1JvFeycTamdE/4GRKWiR/MDJ2KsBmGOfWtQFOz9HHz95dSUSZ0rFHQ4CzBpv7KlZ9wl1tl5QunyTCmhcMBFQaMTIaMErxWI6CMifYUixqKIFeCmx8JREVxSve1TJKXGh/ezZdAsIqZ81lwiHtwnOen6itQn92nrTbPjCuIG1Z8MgejM72vzrkBZLTas8yQx0LDpzmIO7BfVy7e7UjUUkRT1hpXajoUqfMaec7jFXsQKUlhvdSrlKXV61M1WnST3lq1r0VAJESPDAlOvQSYJhmsQiyjfsHMHUqi1CVK74zDKEsRbU6PzR97gIDVEp2GxLuBMKyAUalD4G593N2BdPOEi0Nixd9mhBS+aDe5q4hzYz28MLMWEqwx4ns580aAU0T5H9fqvqW/pl1U/oL4zytk11aGAltCYRF0TS4YzcKMFM9uxTXlhxFFgDE6B5BDus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(52116014)(7416014)(1800799024)(56012099006)(38350700014)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kp0o4WxEMqi5hFDkn+tTSdYtXby2TlvUduHOB9DYslOQKOWBokWU7a3NyzrN?=
 =?us-ascii?Q?b5YyOsbwPh3Hu8uEkZBiVaLnrEsfj3xd78n4qHp39t+DkxHl8Yv/fVY81OM4?=
 =?us-ascii?Q?hjVglUbIei6P0N3UCXVB3P80zJF8zz5j5uxKxfxpTMH6hP8xoo9gisUDOtJO?=
 =?us-ascii?Q?8tGXaWBOdbP8RTRWbyxJXlS7omEmc9zawq5yuuifRQ2KnS+azOj0z0Kn5jNf?=
 =?us-ascii?Q?uupt63p5dLcHeXNqEJJ1I9JKsu4S2F6A26v3haltiUus1AfgXVvSQ64m8Eg2?=
 =?us-ascii?Q?4OWvVdQteapOK75+0ZUT+QYuj1OFLxERyJtZL4UKubEMdp+guynaOHWLvKSK?=
 =?us-ascii?Q?/M0XcVqwT/MEPn5NMgNOETOFsu740fTvwgX3exiKmrMQHu1x4fCb6fMSH4rc?=
 =?us-ascii?Q?LzeCVP7KdVSjXV53XoDI6S3MPv9AF4xnZE/3k/DKk3z7VWXwtAhWalSyvROS?=
 =?us-ascii?Q?lIYqNA7f4wKsMfL9qDMbPBwYTOPRLGRQsEIotdH8ffHhxpwsM8OthFewg0XB?=
 =?us-ascii?Q?d/L8dzCvD2sc0S2JX7Yvs/CPWcYNcaVokq32Yenf6Gk8DBD+TP2ZC5DUDr4g?=
 =?us-ascii?Q?P/dsv14zj1EEJncy/wnQn30OkUvIcj43w2Xzg+aW9vGVLVdozMvIRl5QAg//?=
 =?us-ascii?Q?o1a3kVhPhVBTvZ39bcurXvSRHFFwT8ImF+njagZAuPlbRV94q564NEWnV+8+?=
 =?us-ascii?Q?ARwqoiTIHtksc/yvXVGpn4DQQava2XJnm5azDpq/mZoDph2DZtTgp1Dj3TN8?=
 =?us-ascii?Q?Ny0YipbUnTxuGtWj4/S+BoOdAOqpcua5RvxmW2Bz5KNBLspcRJwFjPA1Q9hz?=
 =?us-ascii?Q?9cd6FXSGfLPGYb0aN1bIqs8CuUadshKhAUfyDDwS6dRgw6gd3MwoL9L0I1Ml?=
 =?us-ascii?Q?zE4vencKOm5Srr6QlE1UoPngmPIl5eTZEwZI61zsChEAM76T0T5nlKWJY5Qq?=
 =?us-ascii?Q?iyH46Pi14y3k3+ZbVeFjosdLDLLQ8tkBOvKoMV5d26rWSMqnROD0aumYzl5z?=
 =?us-ascii?Q?9WtI5MZoaIhlp/G4BtcOInmMwDYRCw+GT4J0afqdrSZQMUij/7AxxnWoJj2c?=
 =?us-ascii?Q?bfljtRP6bmlJOXpoTYpKZGo25eV87mKAM7M02Jlez0p+u9wAoyX4j+T6ryXY?=
 =?us-ascii?Q?Pa57YvwpJpLS3C2GoWSxv6TTipQWdTsZ+po9aQXX3552Ql/D6/xuY9irWMp9?=
 =?us-ascii?Q?53PlF30+cHntHvvTRydmERB/KVLX7aaJ7YlcbjG8uX3R1CYhqLVi0YVOCMiK?=
 =?us-ascii?Q?ZRIU2GVuLxWqZnquuOxbZdUG8zfk+MyWmO6clA4iqQR49od8OdUNm7n9LMv4?=
 =?us-ascii?Q?XaZVoBXoslVPwZrwusBEN5r58zcx9A3wS2UcfmkXk4+iTrNZgLIfVU0YsHKo?=
 =?us-ascii?Q?5FeslU2MoLZvSHG+wdwpZ4g2+AU+VIXVcQTTprxV1XCQ7iTbjtei34fsu0de?=
 =?us-ascii?Q?wlJOJ2okNR/MAr0Nxx+GkSyxNlPRMevRLIMYFDoduVl+sIanLtiKIK2DvME0?=
 =?us-ascii?Q?phR6tRyC8aABm/WtceSDTgJnF/oPN0CXlVVflVbRkAMCurYyW57Ra6nRMz1N?=
 =?us-ascii?Q?PxJU9Kd0Bmj1vIkBns0bW+svRHWqe1u9LijYoupYs+5hy1o6UwG/TNtisqW9?=
 =?us-ascii?Q?ikzzIA+hAmiki4Gj+Jj+wLGnBA9QY94bR7l+mprY94Rj/FoXuwV+TQRLx24H?=
 =?us-ascii?Q?HItNH5kcG9CN8+dP1fa5r4Zb4RCFKTSuPLRG8k1y6rWL8hsGS3i0YQRygjPf?=
 =?us-ascii?Q?5HC5a4VyJEeqS46LIT4x/n/XnZ+DOBU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5697c46b-da1d-4a29-db77-08dee1baec61
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:16:48.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqxCSKWg9FSdqZJnD0LB3hLI0N6EX66fMT+CdWxbVfkr6YXdA+UtgLKZQdBj1KS9zlX7Y9+GMBKTOHhR1hD05haOfAZJE25sUz/Gu57z684=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7692
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,virtuozzo.com:from_mime,virtuozzo.com:dkim,virtuozzo.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB9E6756699

The main change since v3: as suggested by Stefano, the worker teardown
race is now fixed where it actually lives, i.e. in vhost_workers_free(),
instead of being guarded from the vsock side.  The new patch 4 makes the
teardown wait out the RCU readers which might still be queueing work on
a worker, and then run whatever they queued, before the workers are
freed.

With the teardown itself made safe, queueing work on a stopped device
is harmless again: the work handlers check the backend under vq->mutex
and simply return.  So the backend guards in send_pkt()/cancel_pkt()
and the synchronize_rcu() in reset_owner() from v3 are no longer needed
and are gone.

v3 -> v4:

  * Patch 2:
    - rename 'started' -> 'ever_started';
    - reword commit message;
  * Patch 3: reword commit message and code comment;
  * Patch 4 (NEW) ("vhost: synchronize with RCU readers when freeing workers"):
    - fix the vq->worker UAF and the stuck VHOST_WORK_QUEUED bit
      generically in vhost_workers_free();
  * Patch 4 -> 5 ("vhost/vsock: add VHOST_RESET_OWNER ioctl"):
    - drop the backend guards in send_pkt()/cancel_pkt() and the
      synchronize_rcu() in reset_owner() - covered by patch 4 now;
    - make vhost_vsock_reset_owner() return long;
    - reword commit message.

v3: https://lore.kernel.org/virtualization/20260625155416.480669-1-andrey.drobyshev@virtuozzo.com

Andrey Drobyshev (3):
  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
  vhost/vsock: re-scan TX virtqueue on device start
  vhost: synchronize with RCU readers when freeing workers

Pavel Tikhomirov (2):
  vhost/vsock: split out vhost_vsock_drop_backends helper
  vhost/vsock: add VHOST_RESET_OWNER ioctl

 drivers/vhost/vhost.c | 15 ++++++++++
 drivers/vhost/vsock.c | 80 +++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 76 insertions(+), 19 deletions(-)

-- 
2.47.1


