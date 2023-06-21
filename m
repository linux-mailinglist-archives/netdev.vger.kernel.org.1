Return-Path: <netdev+bounces-12486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076B1737B47
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247DE1C20DBF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16435185D;
	Wed, 21 Jun 2023 06:31:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037972AB21
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:31:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27CB1A3
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTHdMazygkoQRPfaWDpp4U9SeeZ78szxFyylNmHbvoK+ah/fhJ9E8szDS9Aeotvp8XZoPWIqMTRBrIN/a5PiqBOVBT58feo2tO3vycBOpXtOQTFttTsifemI1vpki7/Bymg3NlreG8s/qpT0duYyf52EPepbo3hyBRXi5I34T2SpNDlFGNQsv+7pDsVqhthCO/WkO14bZMfsg4L1uIOzj5imBtn8uCD+kBek00dbHq4o/NJsO9E4hQRlOQ5QmKs8fzB3TEQEGj/he9j+F/DRH4ruVgyo059gUluqNDI9SgkKa2yoEgmaJPuYg555YftG1Fdb/tFLmoVVzNbMcKDaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqXQE9rPxp4D+U7wEPVfSBeVST7L2/8U5TotNp9NGAw=;
 b=TEDAwESW8RFYsqVZwcuVe9FRpHGZCKqfLIkKs4mHxZV/RtBEr28oV+VwBns0y+lAVngtLvJbsKWXDtGO8VG6lFfGf+Y83xCErZC7oSLSUFUohFmMfed1OlGK+ni083m4mkpFTPa6+5qxYJ2AruKzZtBPSZDJQYZdCOwpNy1ZkGBcEYk7gaEMZhINeqB+uUbMz/11j2t6AwvItWiLVTVzT/qPc7xN3K+CXqD+x4zXpRxYoqbyLBjIufYSYe8bnzgnYkQEjsIeJDn3RxovTzOGntuZhwIwWxoLL56emdgA3NwnZA5cQ03puAEHx5j5UIeiQTlF9iVSHC2OyKZE5HII5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqXQE9rPxp4D+U7wEPVfSBeVST7L2/8U5TotNp9NGAw=;
 b=FR03uaoiVx1r4yQdoqmVmeNz8Q5rUPNvRSOURfE4qisc3cLrB1zeB+tvy3+8248ep+uU7fYKT4DIEkEO3BrDnoFt6MKfRlXTTrfGFcK3REFNYnJB4faB2J9dV4IAtnRrWzgyasDeIGtsVIFCcBSO4dp0v3Xxmt10lOJelPWmh+IkuEmzgF9NjRfWtg9i7yP61GgGZbJDUphPeiC1c1PVXB8+FmS+1Q72bouI8lpT5hrgP6RCqb8MaXXmmGr6IFXCSlL4y43GZcC+z1iAFCl4hupZxQ3qA0FSmcfdjev8LyoalhLUKpHtGHNxcL0oZ0w7HkdVmpT9dj3VM/fvD4FWtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 06:31:50 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%5]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 06:31:50 +0000
Date: Wed, 21 Jun 2023 09:31:43 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	petrm@nvidia.com
Subject: Re: [RFC PATCH net-next 1/2] devlink: Hold a reference on parent
 device
Message-ID: <ZJKZT3LHBN3zEUd1@shredder>
References: <20230619125015.1541143-1-idosch@nvidia.com>
 <20230619125015.1541143-2-idosch@nvidia.com>
 <ZJFF3gh6LNCVXPzd@nanopsycho>
 <ZJFPs8AiP+X6zdjC@shredder>
 <20230620104351.6debe7f1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620104351.6debe7f1@kernel.org>
X-ClientProxiedBy: VE1PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:803:104::23) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 627083f9-40ac-43a1-6a47-08db72213216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a6XGFdvvjaVqUl+3VbfyEWa/YVIA2Rgv4kOjjbjAGHBnNUwK1MNE332iWUlSInXsYLU5f+MpW/hiXuXucNgjv0rr69CpfyBgD2Az0Pb7iL0+Ysp9/oDBPKwYGZhqk43OepFmK3ivCtI0BHg2dlwM/+xWw3oEDPRPJ43sr2G25UXDb7W4Qko+MiDFGPqf8OASwtqi3rHtD+uULBLCi1l43VHv4qpihIwIyIsKYZg8nEers61M14+CvX4EoYRlvFUD9Zf5nrwScGm+GiD9KOaOAv0rOFwG8w8MKc90VKxIfuDdhAayIF5DVk0Oz90/W+ZiumvcWZuwDeFV4q5bXXST9a4jFK1AhqJPdUJSx5Be4T1+jEyNykk36AYMwx5E4oiwNc8laxrfPe19lCIIWWS8njlEaYAm+1mp+iy+Oh1WNlbkBihkFwN2LB2yPUCBoiWI+N/uD7iN9+wGSnRyC6rLjd+cYQ3W5qb8XR/yIxWBGQ3bGBsH73vrzM2lun9b4SKaiy+XWesJ3DxPXD1D0Jn+juT26nDnh4hSP7S2Sxdi3jAA2A/a8wFT/0SvRoyB9pCW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(8676002)(8936002)(478600001)(41300700001)(5660300002)(2906002)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(26005)(6506007)(186003)(33716001)(86362001)(6512007)(107886003)(83380400001)(6666004)(9686003)(38100700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yWgsTSBIcnpdg4Mq3v8npxxD8J1qFCpywyEt0PsyxERGVDJ1C+ErS/k+9OJ7?=
 =?us-ascii?Q?qc0qPApg008ufGJuEHa5BKK7qfY914hPsCXkw2Wly/K4zajJCgeETkQwX1xB?=
 =?us-ascii?Q?ghDC+K8fzvB4p5HkCXvIte/0aeSQNqNMj1KKyERtpN0x4XKZ39aUEpZBvYBw?=
 =?us-ascii?Q?nyEX6ZiRqe/8BK/3gi9ocUpwR/gQClzDjuO/Tq11XWbI/EU4bB8bG+dZLplo?=
 =?us-ascii?Q?FRbCBGhMaqXXURHWqqwY8PG0aLVny8YRqsBNa4JMGcImqMh45xUVAfhR6mvy?=
 =?us-ascii?Q?EKwdv4pX5gebVgUZSKTZ5LzFendmRPGJWQNRNgcajqwcoLidVHQ9/i4DqbSQ?=
 =?us-ascii?Q?KIYeDdy0tMjYqHyUNmV9sJ1Kdt6lWEuc6qFhjtZFLmFuYYLErNKzIOy9V2Gh?=
 =?us-ascii?Q?IGsIIJ57bdkxYOpAC/z3KUqNq8J06YjZOuNe+d6Vml0SLY+XuAOMXNwuvXOb?=
 =?us-ascii?Q?O1YM97TmdpWu9vMYbbbsdAX/SXdxA3vomoMV4+Ddf1J9Sh6qOteJmAvOuDEu?=
 =?us-ascii?Q?R8l58m0iMOJ1F3TAyrBTNU0lN/ZgVrCRjXVShBbdATtY7rWgJti//hZCZ3sG?=
 =?us-ascii?Q?SH4dpfFy3GfocOgYNZAM7N6vz1gHPdbj8lUdSH8sjkeuztXRnSzG8S4BZppH?=
 =?us-ascii?Q?4uPrQgb+bpLgAIuDK28n8OwmxsVPc6hYGhbHHAAR74qHWeV7+ChTn8Puc9VI?=
 =?us-ascii?Q?OPlkj426UoK1iy2x0Mv7+LnuO8zLKVqZVszVvHbkQGooRnAWdyrQ1gksWqK4?=
 =?us-ascii?Q?x4CTKABN0+gzLtdptYun4cODpiIaI9GG9NuMqqnBgDhg6QKkezE2EZr0B4Gy?=
 =?us-ascii?Q?bE4URpDC9pkFUCXMLjbr0HIv/q1vgq8BR1Oo5N2gJbwu1I7dTiLcZd6rfHL4?=
 =?us-ascii?Q?pqnW+UJVHDsCZzj6Qz+sTeTZY3k449vJQbzW94hdGWr7o7mx/+W53hOzCjM/?=
 =?us-ascii?Q?ftdEAAnODmQu9gZBwwlqMCncaZUy44f8TlqOHyhjRjziYx5O/yg2lsYiQpBF?=
 =?us-ascii?Q?khAP1rL8/RIfYHynS9qjKUtGElOHR4J2V7fZQXaeuL5ka495RdAgTYjmymTy?=
 =?us-ascii?Q?7ucHEvAK8xj/hwmxzpeUqX8e+xkzVSy/29L+z9+W2hDoE3zLNHviKPkHaxG4?=
 =?us-ascii?Q?H8t5bmPPW1LNErFSMZVSrFKhTr2dh9TVM9tGCBzaj6vRgIJotOwe7Vgkyf8d?=
 =?us-ascii?Q?VL42KljLNsZEVAW9tP2dlWpVpgWwM+b7lhzUCDwEWBYWzwXA6qfwNoArbzBj?=
 =?us-ascii?Q?1CYFLuWaicVrYTKvSIO/dpY41w7uYh+sjrLWyCP2lykNFLszHuPV+Px0X3A2?=
 =?us-ascii?Q?V3YL3hziBRzvh2FYADGyq8W5NFW0SG/OIZapoH/cHF10J46isN5MWd2pUbC9?=
 =?us-ascii?Q?zJFj3yc8Wij+N+YsQGCDwgoZ9p7QOcMFs6yC+e3Ou6MAap1RUXCV4lOLtnt8?=
 =?us-ascii?Q?J6oGw3eL38NVRsHEbz0hZopEJr2dYrAJdW7Nk6qqS/InTTkNtirYUI7TKLXU?=
 =?us-ascii?Q?4WretFVYUfjyLd6SqHQcFdFFP5lHB0VZ9h2TWvwA+vQN4ed3bLTRe++XTP2t?=
 =?us-ascii?Q?4Ij/aLBzRCvy37aCIsTwf429+1UzWBLyJWnTiRDz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627083f9-40ac-43a1-6a47-08db72213216
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 06:31:50.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cc17y7I6IuUDq4jnh0mGp1mSaC/fyunU6y7z4apPUM9ekKeRK7+tKWeYseNSmCbKBTRr1VlvlGAKnZkhs/ssUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 10:43:51AM -0700, Jakub Kicinski wrote:
> Do we need to hold the reference on the device until release?
> I think you can release it in devlink_free().
> The only valid fields for an unregistered devlink instance are:
>  - lock
>  - refcount
>  - index
> 
> And obviously unregistered devices can't be reloaded.

Thanks for taking a look.

Moving the release to devlink_free() [1] was the first thing I tried and
it indeed solves the problem I mentioned earlier, but creates a new one.
After devlink_free() returns the devlink instance can still be accessed
by user space in devlink_get_from_attrs_lock(). If I reload in a loop
while concurrently removing and adding the device [2], we can hit a UAF
when trying to acquire the device lock [3].

[1]
diff --git a/net/devlink/core.c b/net/devlink/core.c
index a4b6d548e50c..b60a8463d6e0 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -92,7 +92,6 @@ static void devlink_release(struct work_struct *work)
 
        mutex_destroy(&devlink->lock);
        lockdep_unregister_key(&devlink->lock_key);
-       put_device(devlink->dev);
        kfree(devlink);
 }
 
@@ -264,6 +263,8 @@ void devlink_free(struct devlink *devlink)
 
        xa_erase(&devlinks, devlink->index);
 
+       put_device(devlink->dev);
+
        devlink_put(devlink);
 }
 EXPORT_SYMBOL_GPL(devlink_free);

[2]
while true; do devlink dev reload netdevsim/netdevsim10 &> /dev/null; done &
while true; do echo "10 0" > /sys/bus/netdevsim/new_device; echo 10 > /sys/bus/netdevsim/del_device; done

[3]
[   96.081096] ==================================================================
[   96.082158] BUG: KASAN: slab-use-after-free in __mutex_lock+0x18a7/0x1ac0
[   96.083107] Read of size 8 at addr ffff888109caa8d8 by task devlink/429

[   96.084266] CPU: 0 PID: 429 Comm: devlink Not tainted 6.4.0-rc6-custom-gb01b0912311c-dirty #303
[   96.085443] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
[   96.086632] Call Trace:
[   96.086990]  <TASK>
[   96.087314]  dump_stack_lvl+0x91/0xf0
[   96.087852]  print_report+0xcf/0x660
[   96.088384]  ? __virt_addr_valid+0x86/0x360
[   96.088980]  ? __mutex_lock+0x18a7/0x1ac0
[   96.089558]  ? __mutex_lock+0x18a7/0x1ac0
[   96.090132]  kasan_report+0xd6/0x110
[   96.090667]  ? __mutex_lock+0x18a7/0x1ac0
[   96.091245]  __mutex_lock+0x18a7/0x1ac0
[   96.091898]  ? devlink_get_from_attrs_lock+0x2bc/0x460
[   96.092645]  ? mutex_lock_io_nested+0x18b0/0x18b0
[   96.093323]  ? reacquire_held_locks+0x4e0/0x4e0
[   96.093972]  ? devlink_try_get+0x158/0x1e0
[   96.094586]  ? devlink_get_from_attrs_lock+0x460/0x460
[   96.095325]  ? devlink_get_from_attrs_lock+0x2bc/0x460
[   96.096053]  devlink_get_from_attrs_lock+0x2bc/0x460
[   96.096767]  ? devlink_nl_post_doit+0xf0/0xf0
[   96.097409]  ? __nla_parse+0x40/0x50
[   96.097943]  ? devlink_get_from_attrs_lock+0x460/0x460
[   96.098671]  devlink_nl_pre_doit+0xb3/0x480
[   96.099255]  genl_family_rcv_msg_doit.isra.0+0x1b8/0x2e0
[   96.099966]  ? genl_start+0x670/0x670
[   96.100487]  ? ns_capable+0xda/0x110
[   96.100991]  genl_rcv_msg+0x558/0x7f0
[   96.101516]  ? genl_family_rcv_msg_doit.isra.0+0x2e0/0x2e0
[   96.102260]  ? devlink_get_from_attrs_lock+0x460/0x460
[   96.102925]  ? devlink_reload+0x540/0x540
[   96.103429]  ? devlink_pernet_pre_exit+0x340/0x340
[   96.104017]  netlink_rcv_skb+0x170/0x440
[   96.104508]  ? genl_family_rcv_msg_doit.isra.0+0x2e0/0x2e0
[   96.105166]  ? netlink_ack+0x1380/0x1380
[   96.105662]  ? lock_contended+0xc70/0xc70
[   96.106172]  ? rwsem_down_read_slowpath+0xda0/0xda0
[   96.106767]  ? netlink_deliver_tap+0x1b6/0xd90
[   96.107317]  ? is_vmalloc_addr+0x8b/0xb0
[   96.107804]  genl_rcv+0x2d/0x40
[   96.108213]  netlink_unicast+0x53f/0x810
[   96.108698]  ? netlink_attachskb+0x870/0x870
[   96.109230]  ? lock_release+0x3ac/0xbb0
[   96.109714]  netlink_sendmsg+0x95c/0xe80
[   96.110206]  ? netlink_unicast+0x810/0x810
[   96.110711]  ? __might_fault+0x15b/0x190
[   96.111194]  ? _copy_from_user+0x9f/0xd0
[   96.111691]  __sys_sendto+0x2aa/0x420
[   96.112148]  ? __ia32_sys_getpeername+0xb0/0xb0
[   96.112706]  ? reacquire_held_locks+0x4e0/0x4e0
[   96.113275]  ? rcu_is_watching+0x12/0xb0
[   96.113769]  ? blkcg_exit_disk+0x50/0x50
[   96.114260]  __x64_sys_sendto+0xe5/0x1c0
[   96.114742]  ? lockdep_hardirqs_on+0x7d/0x100
[   96.115285]  ? syscall_enter_from_user_mode+0x20/0x50
[   96.115899]  do_syscall_64+0x38/0x80
[   96.116352]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   96.116964] RIP: 0033:0x7fa073f72fa7
[   96.117417] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d 5d d6 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 71 c3 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44
[   96.119548] RSP: 002b:00007ffca2723938 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[   96.120449] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa073f72fa7
[   96.121287] RDX: 0000000000000034 RSI: 000055883950a460 RDI: 0000000000000003
[   96.122120] RBP: 0000558837836e60 R08: 00007fa074050200 R09: 000000000000000c
[   96.122951] R10: 0000000000000000 R11: 0000000000000202 R12: 000055883950a2a0
[   96.123789] R13: 000055883950a460 R14: 000055883784eeab R15: 000055883950a2a0
[   96.124638]  </TASK>

[   96.125120] Allocated by task 209:
[   96.125543]  kasan_save_stack+0x33/0x50
[   96.125567]  kasan_set_track+0x25/0x30
[   96.125587]  __kasan_kmalloc+0x87/0x90
[   96.125606]  new_device_store+0x22d/0x6a0
[   96.125625]  bus_attr_store+0x7b/0xa0
[   96.125641]  sysfs_kf_write+0x11c/0x170
[   96.125659]  kernfs_fop_write_iter+0x3f7/0x600
[   96.125676]  vfs_write+0x680/0xe90
[   96.125691]  ksys_write+0x143/0x270
[   96.125707]  do_syscall_64+0x38/0x80
[   96.125722]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[   96.125947] Freed by task 209:
[   96.126332]  kasan_save_stack+0x33/0x50
[   96.126355]  kasan_set_track+0x25/0x30
[   96.126374]  kasan_save_free_info+0x2e/0x40
[   96.126389]  __kasan_slab_free+0x10a/0x180
[   96.126409]  __kmem_cache_free+0x8a/0x1a0
[   96.126429]  device_release+0xa6/0x240
[   96.126449]  kobject_put+0x1f7/0x5b0
[   96.126465]  device_unregister+0x34/0xc0
[   96.126478]  del_device_store+0x308/0x430
[   96.126496]  bus_attr_store+0x7b/0xa0
[   96.126511]  sysfs_kf_write+0x11c/0x170
[   96.126528]  kernfs_fop_write_iter+0x3f7/0x600
[   96.126545]  vfs_write+0x680/0xe90
[   96.126560]  ksys_write+0x143/0x270
[   96.126575]  do_syscall_64+0x38/0x80
[   96.126590]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[   96.126815] The buggy address belongs to the object at ffff888109caa800
                which belongs to the cache kmalloc-1k of size 1024
[   96.128252] The buggy address is located 216 bytes inside of
                freed 1024-byte region [ffff888109caa800, ffff888109caac00)

[   96.129875] The buggy address belongs to the physical page:
[   96.130540] page:00000000c7912b23 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x109ca8
[   96.130562] head:00000000c7912b23 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   96.130575] flags: 0x200000000010200(slab|head|node=0|zone=2)
[   96.130591] page_type: 0xffffffff()
[   96.130607] raw: 0200000000010200 ffff888100041dc0 dead000000000100 dead000000000122
[   96.130622] raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
[   96.130632] page dumped because: kasan: bad access detected

[   96.130844] Memory state around the buggy address:
[   96.131424]  ffff888109caa780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   96.132266]  ffff888109caa800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   96.133101] >ffff888109caa880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   96.133944]                                                     ^
[   96.134666]  ffff888109caa900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   96.135510]  ffff888109caa980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   96.136351] ==================================================================

