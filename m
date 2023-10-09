Return-Path: <netdev+bounces-39153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A157BE3C2
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C861C20979
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8FF347A3;
	Mon,  9 Oct 2023 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fho1LTZk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6E1A278
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:59:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54796E3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aot1e5DZ/PtDVnv/pjYd2OUg4JW4CH3CNql88PmwIt88E7F+tGEfai54ug1JjiIaWLMzVHlD4YFYofeAK7SYIkvyXMCV8SLA3UagKy9/WDUig/tZVEthNTISUjx8wc0sFt96wuD2DOxKMZ5ImFJCmx9lV5OzcbSCnQ4JhkVJ/Z9wIM0zUvk/so3JNyiiBTzzSg35DMps9Xt/z57yvgIoN41tXTZiztD4uc8Wd0rCbfjPetvDcaKv3WcUGkAHPjHTo/VQ4AVzfiUYNHUz/BpuKUiRF0cu/sBpNuIPi0CLw3TReuE6pTIXcOehxRvZQrCzGBtcE8JvfJzjTC3rXgx2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCTU1B0UZkXuOsBqT0QcPLi+9rDbZpWwttzACVFCWcI=;
 b=UKsb7aAdfr557hRyDsiXJAOS6jy7VluK+oT5e43M/J7hKtU6KrSGnuWda76nlwqA8bf5nDoPjbdd6VdTmUtZRQEqhj6XqOaptMQA7MsMgfgMYN0UvD+vw4Iavw+eurdLGqHi3W83sG7W2QYSOBZO4+7MNy8/Y3hTHixZHrmX569v+CDSTBtItPrLXrh6CY+X9Rjc6kBGc+bV1Kamkt78rKq5ZEXJaizKwwKvnuBmi3pJ+IlNw+21uCKvO1FIDmR5z6C8o994vpzAHLoMl/OO1qc886/gJy784w6rxRQqyuahMNCno3NYyQ62ZyhyI/yCA+ufNKLmOec8AcgHbv+aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCTU1B0UZkXuOsBqT0QcPLi+9rDbZpWwttzACVFCWcI=;
 b=fho1LTZkMBRUq8MxX0oqMGOAMZ5BpedzhHFvHN/S01idrGjgo56PQa9wxdUARpNGelYfSpi/MpEyrVydXoW7sCnOUoxMcFX+V7xL/6uAiBmfGLlzgbk58VURoZPJDlF/Nzknornke01NeYzOr70XuHFYcYqo2+uuROsFzw9NWm+ctGxwLh2rdrdU9QMw/m8Aj7pPOcxUkviPrZWCA6ozv56dZ0trQ2RhLSf1/ZF8RIeok2t++3ZKR7+dMORCcYW+19nNKK7aEL1KKEGh9UidWfXfgf7+9aqLBd2y2H7SdDe1LgPAZLq59yKtQdmwtKEJ/O7q3jzxZg+oMjIlM//vog==
Received: from SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::12)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 14:59:36 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::92) by SA1P222CA0176.outlook.office365.com
 (2603:10b6:806:3c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 14:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 14:59:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 07:59:23 -0700
Received: from fedora.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 07:59:19 -0700
References: <20230930143542.101000-1-jhs@mojatatu.com>
 <20230930143542.101000-14-jhs@mojatatu.com> <87edi5ysun.fsf@nvidia.com>
 <CAM0EoM=2ObA1yrasNWRFoSzB+JZ0su2TKrXH-D0k+Pth=aOUxg@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: <netdev@vger.kernel.org>, <deb.chatterjee@intel.com>,
	<anjali.singhai@intel.com>, <namrata.limaye@intel.com>, <tom@sipanda.io>,
	<mleitner@redhat.com>, <Mahesh.Shirshyad@amd.com>,
	<tomasz.osinski@intel.com>, <jiri@resnulli.us>, <xiyou.wangcong@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kernel@mojatatu.com>,
	<khalidm@nvidia.com>, <toke@redhat.com>, <mattyk@nvidia.com>
Subject: Re: [PATCH RFC v6 net-next 13/17] p4tc: add table entry create,
 update, get, delete, flush and dump
Date: Mon, 9 Oct 2023 17:27:00 +0300
In-Reply-To: <CAM0EoM=2ObA1yrasNWRFoSzB+JZ0su2TKrXH-D0k+Pth=aOUxg@mail.gmail.com>
Message-ID: <8734yjzvsq.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: e9beeabc-6092-4731-e240-08dbc8d85a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S3dUYfiFeMEfD6Q9XWa5j51G9CynebimJAd38YMd1IaAtNNQ5fz0BFgCodXNsQz7NGAqPtyHrQalGnOnMkVcujbtzfGk/ELbnH0TnvicCZ0QxGG9QlDaS+mirmZu6lwuiCl94VjxRCSqishbONzMltUByI/QcQDDrIcOqdc7dA10F+wkO0Dd2dSZ3H/2HSo1lB5igiLUe8xEQGe5w7rLK3BBGDM8B2FO3wGwHaRBbJd1s1CFN5aRHkKeuTgW3uUoOJitH5WRZR4QW8dotjOFBrmJtHKCEl/vpiXogPdKM2leQ7FZ/BVpk7/fRyyW8KbjbFspSgbh1DwSGvOTjHdDI8eBMHpmQtyx72CelfFh1nH5WJu4krrzrr3qpSXaDBBdu6eMS9gdR7U8m7ruZ6Kv6rrnvSOWaR2WL97hUETrM9BhNeb2N1srCTyLHecp+pdfzflLkc8yr0Mj6fzwwrou1WxfABmxex/AqOkjSihOYoXwK01ks22kAyEtrYYBO+QjopEcoiDp73OMyddy/eyqEYveN9Tgr3o87VY2KmA6Sbb8lppTi5hU2jyoPw0Et61aTgmql4vQB8yEwlI4wP2BWq4ZhhlTddlnH01scescHKhqU7B6vSgChRKh77tI5zbhibYp1eIST1rTnC+flj0sekyxX3rXL5vxUHY3if/CYWfBJTwOAaLXTKvzy8nxhZ4pMGNLGky7v3njJukye3caVyNeB+emjsUrGTx/ZtSRnYv9diVaJE7EEMpkPxugfmIKdCRuFy9FCJUwo9WbGOfxaA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(83380400001)(107886003)(6666004)(478600001)(356005)(7696005)(82740400003)(2616005)(26005)(7636003)(16526019)(41300700001)(70586007)(47076005)(336012)(53546011)(426003)(316002)(6916009)(54906003)(8676002)(36860700001)(70206006)(8936002)(5660300002)(86362001)(15650500001)(4326008)(40480700001)(66899024)(36756003)(7416002)(40460700003)(2906002)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:59:35.5457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9beeabc-6092-4731-e240-08dbc8d85a51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Mon 09 Oct 2023 at 10:02, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Hi Vlad,
>
> On Sun, Oct 8, 2023 at 12:36=E2=80=AFPM Vlad Buslov <vladbu@nvidia.com> w=
rote:
>>
>> On Sat 30 Sep 2023 at 10:35, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> [..trimmed...]
>
>> > +/* Invoked from both control and data path  */
>> > +static int __p4tc_table_entry_update(struct p4tc_pipeline *pipeline,
>> > +                                  struct p4tc_table *table,
>> > +                                  struct p4tc_table_entry *entry,
>> > +                                  struct p4tc_table_entry_mask *mask,
>> > +                                  u16 whodunnit, bool from_control)
>> > +__must_hold(RCU)
>> > +{
>> > +     struct p4tc_table_entry_mask *mask_found =3D NULL;
>> > +     struct p4tc_table_entry_work *entry_work;
>> > +     struct p4tc_table_entry_value *value_old;
>> > +     struct p4tc_table_entry_value *value;
>> > +     struct p4tc_table_entry *entry_old;
>> > +     struct p4tc_table_entry_tm *tm_old;
>> > +     struct p4tc_table_entry_tm *tm;
>> > +     int ret;
>> > +
>> > +     value =3D p4tc_table_entry_value(entry);
>> > +     /* We set it to zero on create an update to avoid having entry
>> > +      * deletion in parallel before we report to user space.
>> > +      */
>> > +     refcount_set(&value->entries_ref, 0);
>>
>> TBH I already commented on one of the previous versions of this series
>> that it is very hard to understand and review tons of different atomic
>> reference counters, especially when they are modified with functions
>> like refcount_dec_not_one() or unconditional set like in this place.
>>
>> I chose specifically this function because __must_hold(RCU) makes it
>> look like it can be accessed concurrently from datapath, which is not
>> obvious on multiple previous usages of reference counters in the series.
>
> True, tables can be manipulated from control plane/user space,
> datapath as well as timers (mostly for delete).
> Would using wrappers around these incr/decr help? i mean meaningful
> inlines that will provide clarity as to what an incr/decr is?

Considering existing wrappers I don't believe adding more would help.
Looking at wrappers for entries_ref:

static inline int p4tc_tbl_entry_get(struct p4tc_table_entry_value *value)
{
	return refcount_inc_not_zero(&value->entries_ref);
}

static inline bool p4tc_tbl_entry_put(struct p4tc_table_entry_value *value)
{
	return refcount_dec_if_one(&value->entries_ref);
}

static inline bool p4tc_tbl_entry_put_ref(struct p4tc_table_entry_value *va=
lue)
{
	return refcount_dec_not_one(&value->entries_ref);
}

it isn't obvious to me why 'put' is dec_if_one and put_ref is dec_not
one.

>
>> So what happens here if entries_ref was 0 to begin with? Or is possible
>> for this function to be executed concurrently by multiple tasks, in
>> which case all of them set entries_ref to 0, but first one that finishes
>> resets the counter back to 1 at which point I assume it can be deleted
>> in parallel by control path while some concurrent
>> __p4tc_table_entry_update() are still running (at least that is what the
>> comment here indicates)?
>
> It's rtnl-lockless, so you can imagine what would happen there ;->
> Multiple concurent user space, kernel, timers all contending for this.
> Exactly what you said: its zero in this case because some entity could
> delete it in parallel.
> See comment further down which says "In case of parallel update, the
> thread that arrives here first will..."

See below.

> Consider it a poor man's lock. Does that help? Perhaps we could have
> more discussion at the monthly tc meetup..
> We have been testing this code a lot for concurrency and wrote some
> user space tooling to catch such issues.

I'm not arguing that it is somehow broken or not well-tested, just
saying I read this and previous versions several times and still have no
idea what is going on here.

>
>>
>> > +
>> > +     if (table->tbl_type !=3D P4TC_TABLE_TYPE_EXACT) {
>> > +             mask_found =3D p4tc_table_entry_mask_add(table, entry, m=
ask);
>> > +             if (IS_ERR(mask_found)) {
>> > +                     ret =3D PTR_ERR(mask_found);
>> > +                     goto out;
>> > +             }
>> > +     }
>> > +

Mark A, see next comment.

>> > +     p4tc_table_entry_build_key(table, &entry->key, mask_found);
>> > +
>> > +     entry_old =3D p4tc_entry_lookup(table, &entry->key, value->prio);
>> > +     if (!entry_old) {
>> > +             ret =3D -ENOENT;
>> > +             goto rm_masks_idr;
>> > +     }
>> > +
>> > +     /* In case of parallel update, the thread that arrives here firs=
t will
>> > +      * get the right to update.
>> > +      *
>> > +      * In case of a parallel get/update, whoever is second will fail=
 appropriately
>> > +      */
>> > +     value_old =3D p4tc_table_entry_value(entry_old);
>> > +     if (!p4tc_tbl_entry_put(value_old)) {
>> > +             ret =3D -EAGAIN;

I get that this prevents you from updating the old entry in parallel,
but I was asking what would happen if concurrent update already finished
by this time, set value->entries_ref to 1 and concurrent delete
deallocated the new entry? Isn't use after free possible when calling
p4tc_table_entry_build_key() and p4tc_entry_lookup() if all those events
happen before mark A? (for example, if task spent a lot of time
allocating new mask in p4tc_table_entry_mask_add())

>> > +             goto rm_masks_idr;
>> > +     }
>> > +
>> > +     if (from_control) {
>> > +             if (!p4tc_ctrl_update_ok(value_old->permissions)) {
>> > +                     ret =3D -EPERM;
>> > +                     goto set_entries_refcount;
>> > +             }
>> > +     } else {
>> > +             if (!p4tc_data_update_ok(value_old->permissions)) {
>> > +                     ret =3D -EPERM;
>> > +                     goto set_entries_refcount;
>> > +             }
>> > +     }
>> > +
>> > +     tm =3D kzalloc(sizeof(*tm), GFP_ATOMIC);
>> > +     if (unlikely(!tm)) {
>> > +             ret =3D -ENOMEM;
>> > +             goto set_entries_refcount;
>> > +     }
>> > +
>> > +     tm_old =3D rcu_dereference_protected(value_old->tm, 1);
>> > +     *tm =3D *tm_old;
>> > +
>> > +     tm->lastused =3D jiffies;
>> > +     tm->who_updated =3D whodunnit;
>> > +
>> > +     if (value->permissions =3D=3D P4TC_PERMISSIONS_UNINIT)
>> > +             value->permissions =3D value_old->permissions;
>> > +
>> > +     rcu_assign_pointer(value->tm, tm);
>> > +
>> > +     entry_work =3D kzalloc(sizeof(*(entry_work)), GFP_ATOMIC);
>> > +     if (unlikely(!entry_work)) {
>> > +             ret =3D -ENOMEM;
>> > +             goto free_tm;
>> > +     }
>> > +
>> > +     entry_work->pipeline =3D pipeline;
>> > +     entry_work->table =3D table;
>> > +     entry_work->entry =3D entry;
>> > +     value->entry_work =3D entry_work;
>> > +     if (!value->is_dyn)
>> > +             value->is_dyn =3D value_old->is_dyn;
>> > +
>> > +     if (value->is_dyn) {
>> > +             /* Only use old entry value if user didn't specify new o=
ne */
>> > +             value->aging_ms =3D value->aging_ms ?: value_old->aging_=
ms;
>> > +
>> > +             hrtimer_init(&value->entry_timer, CLOCK_MONOTONIC,
>> > +                          HRTIMER_MODE_REL);
>> > +             value->entry_timer.function =3D &entry_timer_handle;
>> > +
>> > +             hrtimer_start(&value->entry_timer, ms_to_ktime(value->ag=
ing_ms),
>> > +                           HRTIMER_MODE_REL);
>> > +     }
>> > +
>> > +     INIT_WORK(&entry_work->work, p4tc_table_entry_del_work);
>> > +
>> > +     if (rhltable_insert(&table->tbl_entries, &entry->ht_node,
>> > +                         entry_hlt_params) < 0) {
>> > +             ret =3D -EEXIST;
>> > +             goto free_entry_work;
>> > +     }
>> > +
>> > +     p4tc_table_entry_destroy_noida(table, entry_old);
>> > +
>> > +     if (!from_control)
>> > +             p4tc_tbl_entry_emit_event(entry_work, RTM_P4TC_UPDATE,
>> > +                                       GFP_ATOMIC);
>> > +
>> > +     return 0;
>> > +
>> > +free_entry_work:
>> > +     kfree(entry_work);
>> > +
>> > +free_tm:
>> > +     kfree(tm);
>> > +
>> > +set_entries_refcount:
>> > +     refcount_set(&value_old->entries_ref, 1);
>> > +
>> > +rm_masks_idr:
>> > +     if (table->tbl_type !=3D P4TC_TABLE_TYPE_EXACT)
>> > +             p4tc_table_entry_mask_del(table, entry);
>> > +
>> > +out:
>> > +     return ret;
>> > +}
>> > +
>
> [..trimmed..]
>
>  cheers,
> jamal


