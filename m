Return-Path: <netdev+bounces-47598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B897EA980
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1ADB209D9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 04:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883DB651;
	Tue, 14 Nov 2023 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=psu.edu header.i=@psu.edu header.b="pue5tElW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813BBA22
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:28:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D2DD42
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 20:28:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDt9usISTWsopAKonUTihFTcJ1rT2dPk17EcXZLLH4ejKdohMVf0REwZ0pGgYkAgX4cSRXGYGdBput1vG8FQaGycDgOFGswZJLs1kDbuJSYrV8gnznPMbb8cggQOWxwVwwpLyhORe1yH6aStD08CXNIDxMSdciiLelyjegqqlKbKrKe1jgjb59vavCYjyCDuQHkluEXo1B3akq0L0+w9XC0x5dpaxwY6OdzD30fqPy2ksg9apPMKFx32Gtbw+kchYVc2bzxFE0SbHnva928ycdpqkUnVbhbnYD8qwHmvixCvQNRWuH5ZROJHTNtY45r4nWYcp7kTS0IURSoMnWtw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hp72mkJTC9FErIJ7F8i5BhrkPSCGZ5N5CKA2lJqffQ=;
 b=U8U9E0Kg1cBixOXweNiQfTRWFGNABHwl0lOkmZpWDi6oYP/QuO9y8aY7ba6RjYrr0TBPvYEdIlE+Iidu+zJYg/3Nt9pgMeUlS3Y+UuaLsuqfYr0J/cOCcxccuz6o57DHzmVNvvY3/Q8+421fp2ZjStfl0rD3orADDCOpGTmg5tv7oZD0hFm2yBuyLLXxmEhJXvdTF+FxXuUbfgDWNxehaWIvo44/KZUd10WEoO9xqjQJIwAfkxSL5djH+7svldlv4itJxMni353l6DgDPkMvXvry/i7zNN1Lx/BiFtIO3ZXCTbf820um8ITAIUcpwOfRbgJ8+2R8M8LBgpkGF/wCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hp72mkJTC9FErIJ7F8i5BhrkPSCGZ5N5CKA2lJqffQ=;
 b=pue5tElW5hKoSHgYG7p/vYmZlDRSEPi+XTvRNoKkziV0O81S/in3eiYePRLhlESUeti+enw/1WwXkZgAeu7daVL5pIJt2sR4n3pDELQHApYHuSXpn4zvSSZBorPyiVRaYTk8QF3SMWetRduLuRhjlEpq7iiFxu5DXIh3IlLy5Qk=
Received: from SA0PR02MB7276.namprd02.prod.outlook.com (2603:10b6:806:e6::17)
 by SJ2PR02MB9654.namprd02.prod.outlook.com (2603:10b6:a03:536::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:28:00 +0000
Received: from SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::10d7:16d2:aef2:307]) by SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::10d7:16d2:aef2:307%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 04:27:59 +0000
From: "Bai, Shuangpeng" <sjb7183@psu.edu>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: KASAN: slab-out-of-bounds in sock_sendmsg
Thread-Topic: KASAN: slab-out-of-bounds in sock_sendmsg
Thread-Index: AQHaFrLyjAlHTn+OH0KsVKWC+YG0yw==
Date: Tue, 14 Nov 2023 04:27:59 +0000
Message-ID: <AA94F9B0-9347-4059-AE85-7D4AE5422EE6@psu.edu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR02MB7276:EE_|SJ2PR02MB9654:EE_
x-ms-office365-filtering-correlation-id: 83cc9092-b918-4913-183f-08dbe4ca1570
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 no7YZ714A6CiJiMO6MZ//ZPNRWRK+AbJwgmZ1MRaGuEfyPAHhv/ZghoBjYtSk0PMRLv0QXhiUJgqv4H5YaYsfqYCJXapaJpvVoa4SiOsQlHc5JNzBCaqrr7t1RgpVZ2/33RFEYGDp3fSmvnXoFtFnNJNTZnZYKpPCGSC7ZH9RUaL4Sm3dBI5NUd+1YsUjj69gMP8m/saist+uQBRo5+WrWFmFpgu9wsU+T5HZZ/+69AJ0CCIn8bZiRCRyr+Lx2xj0D+gySOjKlPbrTQJNIce53d9FT39IC72wM+AhXKvjSw883tfOK9dHiJDBl6ybyheGbt5UqC2GdCyXrK6My9gc1w4cbXqESa6UKcjhFxk6TEQCiIz88SKGjLWMivuSnwJ57u1ilEp2DgVcQ5ZBLUYY4eWTrNAFi33fazqVS/PZgtY5Yxgexgtz9VMvAbdZekT+dyzHEhaCdpRrEXG+vt5NGTgEL8VhoGEDgfRXSwe4hdTIB5vEC1zk7v0AGM33NAWjXUKwpjYh6U+Z3Klq86tdfa/JShH5TcZwlUlxL22JHOxDoUA9TZH2u9bNnz6xPawG8cPSu8v2N3ShcRK7j0sswqlLSHu9AwGysOuqaYer+7gp6Vgld70SzL6I9JMGd7w2csj6D5mc5PgzJCmZCgHj4mpJj6LWZ+vTO/tqzdIGhY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR02MB7276.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(84970400001)(75432002)(122000001)(64756008)(66476007)(66556008)(76116006)(66946007)(91956017)(316002)(110136005)(66446008)(99936003)(38100700002)(38070700009)(33656002)(36756003)(86362001)(786003)(6512007)(83380400001)(71200400001)(2616005)(6506007)(30864003)(2906002)(478600001)(6486002)(5660300002)(41300700001)(4326008)(8676002)(8936002)(45980500001)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H33cQflDsHUz9Hx9E8nO0V3178s++Mhfxwch8hxev4nqAPSMtMJA1ICwWk44?=
 =?us-ascii?Q?rw+WLUsgWyMHWOZ1nxemyNqUT8V4/L8wO1apCqR2k5G+3zuOgX2rJ81j6yw5?=
 =?us-ascii?Q?dhNsDKFUKN8WJtiA0jXxNxY2+70lMeFKi9nFRvDPYj2Z5GIQRN0A0cZEdKA5?=
 =?us-ascii?Q?tdif9iqsMTpC3Hg32VpJSOkqnV7o24R/6i4XB8Iq2UQrNzjAYTYor+zyXCpX?=
 =?us-ascii?Q?THbOTOcRr8TuZbfiewmjFo5klbFDkphGMAnUbhKYPLSyV+HGzCO/6AIFcXpc?=
 =?us-ascii?Q?FD2gAjkBYCo36bHjzQXONEqJlgsl4vNPpbPPMcl6JAq9+jMG7++ag+dYMfu+?=
 =?us-ascii?Q?dyWa0H+lFjl+vKMZLUM5EbxyUAeVjXeQgT3LtJp/PI7kVcOhK6zqb9psn5m2?=
 =?us-ascii?Q?Tc9izs/SDmQ9LrI03lgOG8CI1FGtMK4fFk24Mjk+ecF8DVWx3iLSccGBFsMy?=
 =?us-ascii?Q?49Tx6g4v4IWOWZQBada00wTwR2G/H73xcoA3nxjNZewyBpg94sNgSk6SdcI0?=
 =?us-ascii?Q?UviMIZcNOVsTeJwQsArTxdlWbVcFQ/D+L13EFoNvW/9XUzONguhluPYdWqEk?=
 =?us-ascii?Q?dehC2jybO69AWoL5rtyiY4dJgyUGWpE+i7cOMZimdj6Entz4FYek/Bl6X9J7?=
 =?us-ascii?Q?zhJZVUIehCr9U4se7UlNqlh8ShkdMk5Cz139pYQqORZsY5kojN/EbciTk7u5?=
 =?us-ascii?Q?kKx1zdlYzKcIciEVn6B3gBjbAAMVusQmRNJMbkGsEwoffW8coBLdYoEvUKjc?=
 =?us-ascii?Q?ZZFcgFwrPA/xPJk2PvA98zXGX/KVKgBlTgfPVTOfvYCbnMSil3O/UnWZ5Eo/?=
 =?us-ascii?Q?FNTxHKwUtLKm+Ldmc7XVh5Ci85882XYnEhFafl1CU4pKDoIiS/2byWXRBpN1?=
 =?us-ascii?Q?RbTDwUdi8151COv4ByX1vk9JQGmQoTQ6DqzSmnEqWbX460x3GRRYDXFaYtyn?=
 =?us-ascii?Q?cJ7+jTd4FknC5z/2WraceBRCmpIL9JgRuqw/se9ILZ0EjJdOAtzLyt5yvySl?=
 =?us-ascii?Q?Ynf5wVggCBHgL5qdz0Z457BNk/WmdLBUEDKXETU41gjTe8JE/AI+xNnFEv4G?=
 =?us-ascii?Q?mHTDgJJeMXCHCHlxTY9MgNt+EOZPhWwU+2k4y3lDvTcDK9e/hynTwLmcWsWb?=
 =?us-ascii?Q?Ph4IgiHwKCtNCo/t1ByqPGI9zdnFnmupBk9Bpyzz69xS7DojUvlfUDExPQbn?=
 =?us-ascii?Q?ZAOLdbKbL22wK5iMtoVOadmJfh3JoI0g8v+Go6w/LCqP2842bpnHvgJ9e85U?=
 =?us-ascii?Q?3wZ37RMaVALcw6RZwyn0rU2LSsr2YRfjG3NMael2NAz1bnzFKM5F9JJE10UL?=
 =?us-ascii?Q?3go0QteWSJR0FFvmh99UrTWTEC1ULZpyUk7BpJY9ZZljZaQmAcGpGZxXD2Fb?=
 =?us-ascii?Q?5/xpWoDZfsgXlFf6kpcGCHyWzf0l36I+z06AmuoAQT8x+n/pb0UgX3YcjlXy?=
 =?us-ascii?Q?l6sBmZxluTyg4bEHU7tFA2U7PEZ9gvPQ4QtzgnHlrHTIT2UiEIrQ7Ns52wZU?=
 =?us-ascii?Q?d1aDJr5OG3HJ8yJ8Basg3IRmGa5AGC3nPo7tVy5v+rTVWxWv4dkh8Mwwqhhz?=
 =?us-ascii?Q?9LiRb+7I+vCknYu0tPXWiN3d21VIMvwAETBj3HTBPkxdu2uskY+nDsozRlYA?=
 =?us-ascii?Q?VJQ3Tyx6bU693xbFh0Q8ti7bta3uD0wfqkUQkPOzh87+?=
Content-Type: multipart/signed;
	boundary="Apple-Mail=_3EA670FE-26ED-4E5C-8301-66C317FCF5A2";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR02MB7276.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cc9092-b918-4913-183f-08dbe4ca1570
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 04:27:59.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gk8EltuACaqLw4wO5BIbW2bNsg1e5Crb390BV+vB68gtOxboQeyiFKwP/mfnEs6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9654

--Apple-Mail=_3EA670FE-26ED-4E5C-8301-66C317FCF5A2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Kernel Maintainers,

Our tool found a new kernel bug KASAN: slab-out-of-bounds in =
sock_sendmsg. Please see the details below.


Kenrel commit: v6.1.62 (recent longterm)
Kernel config: attachment
C/Syz reproducer: attachment


[  112.531454][ T6474] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 112.532297][ T6474] BUG: KASAN: slab-out-of-bounds in sock_sendmsg =
(net/socket.c:747)=20
[  112.532942][ T6474] Read of size 74 at addr ffff88807dacba88 by task =
a.out/6474
[  112.533574][ T6474]
[  112.533783][ T6474] CPU: 0 PID: 6474 Comm: a.out Not tainted 6.1.62 =
#7
[  112.534356][ T6474] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.15.0-1 04/01/2014
[  112.535127][ T6474] Call Trace:
[  112.535431][ T6474]  <TASK>
[ 112.535699][ T6474] dump_stack_lvl (lib/dump_stack.c:107 =
(discriminator 1))=20
[ 112.536109][ T6474] print_report (mm/kasan/report.c:285 =
mm/kasan/report.c:395)=20
[ 112.536515][ T6474] ? __phys_addr (arch/x86/mm/physaddr.c:32 =
(discriminator 4))=20
[ 112.536927][ T6474] ? sock_sendmsg (net/socket.c:747)=20
[ 112.537342][ T6474] kasan_report (mm/kasan/report.c:162 =
mm/kasan/report.c:497)=20
[ 112.537751][ T6474] ? sock_sendmsg (net/socket.c:747)=20
[ 112.538165][ T6474] kasan_check_range (mm/kasan/generic.c:190)=20
[ 112.538615][ T6474] memcpy (mm/kasan/shadow.c:65)=20
[ 112.538977][ T6474] sock_sendmsg (net/socket.c:747)=20
[ 112.539383][ T6474] ? unwind_get_return_address =
(arch/x86/kernel/unwind_orc.c:323 arch/x86/kernel/unwind_orc.c:318)=20
[ 112.539883][ T6474] ? sock_write_iter (net/socket.c:740)=20
[ 112.540324][ T6474] ? _raw_spin_lock_irqsave =
(./arch/x86/include/asm/atomic.h:202 =
./include/linux/atomic/atomic-instrumented.h:543 =
./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:186 =
./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)=20
[ 112.540820][ T6474] ? __lock_text_start =
(kernel/locking/spinlock.c:161)=20
[ 112.541254][ T6474] ? iov_iter_kvec (lib/iov_iter.c:1001 =
(discriminator 3))=20
[ 112.541683][ T6474] ? kernel_sendmsg (net/socket.c:773)=20
[ 112.542105][ T6474] rxrpc_send_abort_packet (net/rxrpc/output.c:336)=20=

[ 112.542583][ T6474] ? rxrpc_send_ack_packet (net/rxrpc/output.c:287)=20=

[ 112.543071][ T6474] ? kasan_save_stack (mm/kasan/common.c:46)=20
[ 112.543502][ T6474] ? do_exit (kernel/exit.c:866)=20
[ 112.543899][ T6474] ? do_group_exit (kernel/exit.c:1000)=20
[ 112.544326][ T6474] ? __rxrpc_set_call_completion.part.0 =
(net/rxrpc/recvmsg.c:80)=20
[ 112.544904][ T6474] ? __rxrpc_abort_call (net/rxrpc/recvmsg.c:127)=20
[ 112.545365][ T6474] ? __local_bh_enable_ip =
(./arch/x86/include/asm/preempt.h:103 kernel/softirq.c:403)=20
[ 112.545833][ T6474] rxrpc_release_calls_on_socket =
(net/rxrpc/call_object.c:611)=20
[ 112.546362][ T6474] ? __lock_text_start =
(kernel/locking/spinlock.c:161)=20
[ 112.546796][ T6474] rxrpc_release (net/rxrpc/af_rxrpc.c:887 =
net/rxrpc/af_rxrpc.c:917)=20
[ 112.547208][ T6474] __sock_release (net/socket.c:653)=20
[ 112.547632][ T6474] sock_close (net/socket.c:1389)=20
[ 112.548076][ T6474] __fput (fs/file_table.c:321)=20
[ 112.548439][ T6474] ? __sock_release (net/socket.c:1386)=20
[ 112.548871][ T6474] task_work_run (kernel/task_work.c:180 =
(discriminator 1))=20
[ 112.549286][ T6474] ? task_work_cancel (kernel/task_work.c:147)=20
[ 112.549720][ T6474] do_exit (kernel/exit.c:870)=20
[ 112.550098][ T6474] ? mm_update_next_owner (kernel/exit.c:806)=20
[ 112.550579][ T6474] ? _raw_spin_lock (kernel/locking/spinlock.c:169)=20=

[ 112.551010][ T6474] ? zap_other_threads (kernel/signal.c:1386)=20
[ 112.551474][ T6474] do_group_exit (kernel/exit.c:1000)=20
[ 112.551896][ T6474] __x64_sys_exit_group (kernel/exit.c:1028)=20
[ 112.552355][ T6474] do_syscall_64 (arch/x86/entry/common.c:50 =
arch/x86/entry/common.c:80)=20
[ 112.552755][ T6474] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:120)=20
[  112.553274][ T6474] RIP: 0033:0x7f4595393146
[ 112.553669][ T6474] Code: Unable to access opcode bytes at =
0x7f459539311c.

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  112.554264][ T6474] RSP: 002b:00007fff14cbd758 EFLAGS: 00000246 =
ORIG_RAX: 00000000000000e7
[  112.554977][ T6474] RAX: ffffffffffffffda RBX: 00007f45954988a0 RCX: =
00007f4595393146
[  112.555663][ T6474] RDX: 0000000000000000 RSI: 000000000000003c RDI: =
0000000000000000
[  112.556336][ T6474] RBP: 0000000000000000 R08: 00000000000000e7 R09: =
ffffffffffffff80
[  112.557015][ T6474] R10: 0000000000000002 R11: 0000000000000246 R12: =
00007f45954988a0
[  112.557679][ T6474] R13: 0000000000000001 R14: 00007f45954a12e8 R15: =
0000000000000000
[  112.558365][ T6474]  </TASK>
[  112.558642][ T6474]
[  112.558856][ T6474] Allocated by task 6474:
[ 112.559228][ T6474] kasan_save_stack (mm/kasan/common.c:46)=20
[ 112.559657][ T6474] kasan_set_track (mm/kasan/common.c:52)=20
[ 112.560063][ T6474] __kasan_kmalloc (mm/kasan/common.c:374 =
mm/kasan/common.c:333 mm/kasan/common.c:383)=20
[ 112.560477][ T6474] rxrpc_alloc_peer (net/rxrpc/peer_object.c:218)=20
[ 112.560897][ T6474] rxrpc_lookup_peer (net/rxrpc/peer_object.c:293 =
net/rxrpc/peer_object.c:352)=20
[ 112.561314][ T6474] rxrpc_connect_call (net/rxrpc/conn_client.c:366 =
net/rxrpc/conn_client.c:716)=20
[ 112.561742][ T6474] rxrpc_new_client_call =
(net/rxrpc/call_object.c:353)=20
[ 112.562200][ T6474] rxrpc_do_sendmsg (net/rxrpc/sendmsg.c:636 =
net/rxrpc/sendmsg.c:686)=20
[ 112.562628][ T6474] rxrpc_sendmsg (net/rxrpc/af_rxrpc.c:561)=20
[ 112.563034][ T6474] __sock_sendmsg (net/socket.c:719 net/socket.c:728)=20=

[ 112.563442][ T6474] ____sys_sendmsg (net/socket.c:2499)=20
[ 112.563877][ T6474] ___sys_sendmsg (net/socket.c:2555)=20
[ 112.564304][ T6474] __sys_sendmsg (net/socket.c:2584)=20
[ 112.564718][ T6474] do_syscall_64 (arch/x86/entry/common.c:50 =
arch/x86/entry/common.c:80)=20
[ 112.565125][ T6474] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:120)=20
[  112.565646][ T6474]
[  112.565860][ T6474] The buggy address belongs to the object at =
ffff88807dacba00
[  112.565860][ T6474]  which belongs to the cache kmalloc-256 of size =
256
[  112.567034][ T6474] The buggy address is located 136 bytes inside of
[  112.567034][ T6474]  256-byte region [ffff88807dacba00, =
ffff88807dacbb00)
[  112.568174][ T6474]
[  112.568381][ T6474] The buggy address belongs to the physical page:
[  112.568919][ T6474] page:ffffea0001f6b280 refcount:1 mapcount:0 =
mapping:0000000000000000 index:0x0 pfn:0x7daca
[  112.569777][ T6474] head:ffffea0001f6b280 order:1 compound_mapcount:0 =
compound_pincount:0
[  112.570472][ T6474] flags: =
0xfff00000010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
[  112.571160][ T6474] raw: 00fff00000010200 dead000000000100 =
dead000000000122 ffff88800fc41b40
[  112.571863][ T6474] raw: 0000000000000000 0000000080100010 =
00000001ffffffff 0000000000000000
[  112.572588][ T6474] page dumped because: kasan: bad access detected
[  112.573105][ T6474] page_owner tracks the page as allocated
[  112.573584][ T6474] page last allocated via order 1, migratetype =
Unmovable, gfp_mask =
0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEM1
[ 112.575352][ T6474] post_alloc_hook (./include/linux/page_owner.h:31 =
mm/page_alloc.c:2513)=20
[ 112.575797][ T6474] get_page_from_freelist (mm/page_alloc.c:2531 =
mm/page_alloc.c:4279)=20
[ 112.576286][ T6474] __alloc_pages (mm/page_alloc.c:5546)=20
[ 112.576710][ T6474] alloc_pages (mm/mempolicy.c:2282)=20
[ 112.577103][ T6474] allocate_slab (mm/slub.c:1798 mm/slub.c:1939)=20
[ 112.577503][ T6474] ___slab_alloc (mm/slub.c:3181)=20
[ 112.577906][ T6474] __slab_alloc.constprop.0 (mm/slub.c:3279)=20
[ 112.578369][ T6474] __kmem_cache_alloc_node (mm/slub.c:3364 =
mm/slub.c:3437)=20
[ 112.578840][ T6474] kmalloc_trace (mm/slab_common.c:1048)=20
[ 112.579228][ T6474] inode_doinit_use_xattr =
(security/selinux/hooks.c:1317)=20
[ 112.580483][ T6474] inode_doinit_with_dentry =
(security/selinux/hooks.c:1509)=20
[ 112.580964][ T6474] selinux_d_instantiate =
(security/selinux/hooks.c:6357)=20
[ 112.581412][ T6474] security_d_instantiate (security/security.c:2078 =
(discriminator 11))=20
[ 112.581861][ T6474] d_splice_alias (./include/linux/spinlock.h:350 =
fs/dcache.c:3147)=20
[ 112.582267][ T6474] kernfs_iop_lookup (fs/kernfs/dir.c:1181)=20
[ 112.582701][ T6474] __lookup_slow (./include/linux/dcache.h:359 =
./include/linux/dcache.h:364 fs/namei.c:1687)=20
[  112.583115][ T6474] page last free stack trace:
[ 112.583528][ T6474] free_pcp_prepare (./include/linux/page_owner.h:24 =
mm/page_alloc.c:1440 mm/page_alloc.c:1490)=20
[ 112.583967][ T6474] free_unref_page (mm/page_alloc.c:3358 =
mm/page_alloc.c:3453)=20
[ 112.584385][ T6474] free_contig_range (mm/page_alloc.c:9501)=20
[ 112.584823][ T6474] destroy_args (mm/debug_vm_pgtable.c:1031)=20
[ 112.585225][ T6474] debug_vm_pgtable (mm/debug_vm_pgtable.c:1355)=20
[ 112.585658][ T6474] do_one_initcall (init/main.c:1292)=20
[ 112.586059][ T6474] kernel_init_freeable (init/main.c:1364 =
init/main.c:1381 init/main.c:1400 init/main.c:1620)=20
[ 112.586507][ T6474] kernel_init (init/main.c:1510)=20
[ 112.586891][ T6474] ret_from_fork (arch/x86/entry/entry_64.S:312)=20
[  112.587283][ T6474]
[  112.587491][ T6474] Memory state around the buggy address:
[  112.587971][ T6474]  ffff88807dacb980: fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc
[  112.588653][ T6474]  ffff88807dacba00: 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00
[  112.589346][ T6474] >ffff88807dacba80: 00 00 00 00 00 00 00 00 00 00 =
fc fc fc fc fc fc
[  112.590031][ T6474]                                                  =
^
[  112.590603][ T6474]  ffff88807dacbb00: fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc
[  112.591289][ T6474]  ffff88807dacbb80: fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc
[  112.591954][ T6474] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  112.595224][ T6474] Kernel panic - not syncing: KASAN: panic_on_warn =
set ...
[  112.595872][ T6474] CPU: 1 PID: 6474 Comm: a.out Not tainted 6.1.62 =
#7
[  112.596457][ T6474] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.15.0-1 04/01/2014
[  112.597243][ T6474] Call Trace:
[  112.597529][ T6474]  <TASK>
[ 112.597779][ T6474] dump_stack_lvl (lib/dump_stack.c:107 =
(discriminator 1))=20
[ 112.598169][ T6474] panic (kernel/panic.c:357)=20
[ 112.598511][ T6474] ? panic_print_sys_info.part.0 (kernel/panic.c:276)=20=

[ 112.598997][ T6474] ? preempt_schedule_thunk =
(arch/x86/entry/thunk_64.S:34)=20
[ 112.599482][ T6474] ? preempt_schedule_common =
(./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 =
./include/asm-generic/bitops/instrumented-non-atomic.h:142 =
./include/linux/thread_info.h:118 ./include/linux/sched.h:2231 =
kernel/sched/core.c:6731)=20
[ 112.599957][ T6474] check_panic_on_warn.cold (kernel/panic.c:239)=20
[ 112.600425][ T6474] end_report.part.0 (mm/kasan/report.c:169)=20
[ 112.600850][ T6474] ? sock_sendmsg (net/socket.c:747)=20
[ 112.601264][ T6474] kasan_report.cold (./include/linux/cpumask.h:110 =
mm/kasan/report.c:497)=20
[ 112.601678][ T6474] ? sock_sendmsg (net/socket.c:747)=20
[ 112.602100][ T6474] kasan_check_range (mm/kasan/generic.c:190)=20
[ 112.602539][ T6474] memcpy (mm/kasan/shadow.c:65)=20
[ 112.602889][ T6474] sock_sendmsg (net/socket.c:747)=20
[ 112.603286][ T6474] ? unwind_get_return_address =
(arch/x86/kernel/unwind_orc.c:323 arch/x86/kernel/unwind_orc.c:318)=20
[ 112.603778][ T6474] ? sock_write_iter (net/socket.c:740)=20
[ 112.604214][ T6474] ? _raw_spin_lock_irqsave =
(./arch/x86/include/asm/atomic.h:202 =
./include/linux/atomic/atomic-instrumented.h:543 =
./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:186 =
./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)=20
[ 112.604659][ T6474] ? __lock_text_start =
(kernel/locking/spinlock.c:161)=20
[ 112.605089][ T6474] ? iov_iter_kvec (lib/iov_iter.c:1001 =
(discriminator 3))=20
[ 112.605507][ T6474] ? kernel_sendmsg (net/socket.c:773)=20
[ 112.605934][ T6474] rxrpc_send_abort_packet (net/rxrpc/output.c:336)=20=

[ 112.606423][ T6474] ? rxrpc_send_ack_packet (net/rxrpc/output.c:287)=20=

[ 112.606908][ T6474] ? kasan_save_stack (mm/kasan/common.c:46)=20
[ 112.607324][ T6474] ? do_exit (kernel/exit.c:866)=20
[ 112.607715][ T6474] ? do_group_exit (kernel/exit.c:1000)=20
[ 112.608135][ T6474] ? __rxrpc_set_call_completion.part.0 =
(net/rxrpc/recvmsg.c:80)=20
[ 112.608702][ T6474] ? __rxrpc_abort_call (net/rxrpc/recvmsg.c:127)=20
[ 112.609160][ T6474] ? __local_bh_enable_ip =
(./arch/x86/include/asm/preempt.h:103 kernel/softirq.c:403)=20
[ 112.609636][ T6474] rxrpc_release_calls_on_socket =
(net/rxrpc/call_object.c:611)=20
[ 112.610157][ T6474] ? __lock_text_start =
(kernel/locking/spinlock.c:161)=20
[ 112.610590][ T6474] rxrpc_release (net/rxrpc/af_rxrpc.c:887 =
net/rxrpc/af_rxrpc.c:917)=20
[ 112.610985][ T6474] __sock_release (net/socket.c:653)=20
[ 112.611384][ T6474] sock_close (net/socket.c:1389)=20
[ 112.611745][ T6474] __fput (fs/file_table.c:321)=20
[ 112.612091][ T6474] ? __sock_release (net/socket.c:1386)=20
[ 112.612528][ T6474] task_work_run (kernel/task_work.c:180 =
(discriminator 1))=20
[ 112.612948][ T6474] ? task_work_cancel (kernel/task_work.c:147)=20
[ 112.613386][ T6474] do_exit (kernel/exit.c:870)=20
[ 112.613761][ T6474] ? mm_update_next_owner (kernel/exit.c:806)=20
[ 112.614229][ T6474] ? _raw_spin_lock (kernel/locking/spinlock.c:169)=20=

[ 112.614661][ T6474] ? zap_other_threads (kernel/signal.c:1386)=20
[ 112.615120][ T6474] do_group_exit (kernel/exit.c:1000)=20
[ 112.615535][ T6474] __x64_sys_exit_group (kernel/exit.c:1028)=20
[ 112.616003][ T6474] do_syscall_64 (arch/x86/entry/common.c:50 =
arch/x86/entry/common.c:80)=20
[ 112.616408][ T6474] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:120)=20
[  112.616936][ T6474] RIP: 0033:0x7f4595393146
[ 112.617334][ T6474] Code: Unable to access opcode bytes at =
0x7f459539311c.

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  112.617905][ T6474] RSP: 002b:00007fff14cbd758 EFLAGS: 00000246 =
ORIG_RAX: 00000000000000e7
[  112.618619][ T6474] RAX: ffffffffffffffda RBX: 00007f45954988a0 RCX: =
00007f4595393146
[  112.619315][ T6474] RDX: 0000000000000000 RSI: 000000000000003c RDI: =
0000000000000000
[  112.619980][ T6474] RBP: 0000000000000000 R08: 00000000000000e7 R09: =
ffffffffffffff80
[  112.620655][ T6474] R10: 0000000000000002 R11: 0000000000000246 R12: =
00007f45954988a0
[  112.621295][ T6474] R13: 0000000000000001 R14: 00007f45954a12e8 R15: =
0000000000000000
[  112.621951][ T6474]  </TASK>
[  112.622323][ T6474] Kernel Offset: disabled
[  112.622694][ T6474] Rebooting in 86400 seconds..



Best,
Shuangpeng



--Apple-Mail=_3EA670FE-26ED-4E5C-8301-66C317FCF5A2
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCAzQw
ggMwMIICGKADAgECAgomgLs6nu4+PhOmMA0GCSqGSIb3DQEBCwUAMEYxFzAVBgNVBAMTDlNodWFu
Z3BlbmcgQmFpMR4wHAYJKoZIhvcNAQkBFg9zamI3MTgzQHBzdS5lZHUxCzAJBgNVBAYTAlVTMB4X
DTIzMDMwODIxNTIwM1oXDTI4MDMwODIxNTIwM1owRjEXMBUGA1UEAxMOU2h1YW5ncGVuZyBCYWkx
HjAcBgkqhkiG9w0BCQEWD3NqYjcxODNAcHN1LmVkdTELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDU0+VQPl4Ed5XjmLYXorvm7VgJa+6QQ06b4XEL6rqBeDIGCKXc
HSzBmziCw1Mw00jpaP7X3qNn23GIEbHM/phmMCxUJR2eAcmsjq7i2kZAhKh5qs/oucYRPww96TpA
9xTcyqH0W4eguzqhW/oyrJKRlgEPcUud9drZyI9/X86ewU+MUy+2sKuiE3BkIJJJCiOv7VhIZyCd
gzkHX0zZSBaSPlCj6D9bGTUcjne0dI9SwMi4qXjtX+CwIezAp+xg/8q7TLJkBSebv28qvAjs0x4b
VRwJ0Wyfejsg/SmY68rMfAdqpmys42Sj1bnDgJ1CBiDMj2PtO7/JUrHM+iHaePKfAgMBAAGjIDAe
MA8GCSqGSIb3LwEBCgQCBQAwCwYDVR0PBAQDAgeAMA0GCSqGSIb3DQEBCwUAA4IBAQBbuvW97VLc
MXCpCAx0U/5yw8d4pBjxSmT5ozOedU+5U0NR6Wl2NkdZDvGEDNhuuIih8TwKTx0ZcRfWMt0edj/H
TBKkd0CpcsZWwefxSLkHeVLyF5NAWOhkazgKmXZtGyZ460z3x0QU6m4rrLluNwYNNBS0igT+32Qb
Io9zm1MiKMppDnx3FvYZByb2/1juAO0/vvF5Ttpi0Gf684U/xvlGKd/enAfwag0QrT6vcRXmb1ou
xY874h2toKzq1PDyMGtbvU1ERg4JECfLQ/9uzlpBTNiHpV66d6n4uQMT7hbsbuRbciKRWkKEyfM+
eOc9ANrNYRGIqBzRupXVf5zIj/WbMYIB6jCCAeYCAQEwVDBGMRcwFQYDVQQDEw5TaHVhbmdwZW5n
IEJhaTEeMBwGCSqGSIb3DQEJARYPc2piNzE4M0Bwc3UuZWR1MQswCQYDVQQGEwJVUwIKJoC7Op7u
Pj4TpjANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTExNDA0Mjc1N1owLwYJKoZIhvcNAQkEMSIEIHbEv9JA4VydlJCS0ur+XHuWIBc7
83YgqxvEhIy8l21iMA0GCSqGSIb3DQEBCwUABIIBADwkQUI2suEhJMYNhS/q9C63rSWs+h3Kmpue
H+TLRUurYQmbZw5elD/0MgZH4JBf3gZkPzcfhPbl5KbLc+L4piSlsSej+Az4XoSmcN9jGfUY8ppr
LJVtwCfOzFpSrz6j6hxUZgjo6/NLaKA2QIL0Zb2uMAADKfH97st381VPvCL0cf/aeuaUuR9SU9xY
XnrbDd6nA5F1ivpmE2MqquOTF/3HC3EoNY54o69rLeHVL6qsnc0GGx3acAXtc+2SOxzuht8Q/7iq
mTay42DsRT5zxP12QsIY4Psf0kLzaLRsdmhlXeZQojAl3eHzN1EQKvD81tlDe4qfvOCrysbIf7hp
5nQAAAAAAAA=

--Apple-Mail=_3EA670FE-26ED-4E5C-8301-66C317FCF5A2--

