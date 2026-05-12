Return-Path: <netdev+bounces-287010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MSdJ8zpAmpKygEAu9opvQ
	(envelope-from <netdev+bounces-287010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:50:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB0A51D090
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E54430436BD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CCB38910C;
	Tue, 12 May 2026 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cYm3+/Nl"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC0386C28;
	Tue, 12 May 2026 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575695; cv=fail; b=LhW23U4t5S/UGXiBnzUIlkeuZWvqhLJBumn3JH9cxbJyxCxuR+zb8U2Fp1zeMRSL4awk0K1SlXp0nSIASIRfZjxtVfEnVpZUlEsc/JNAVrLsPf3oG+fF7uEoVHSKTikzxA8NZk9ssUJlCS5zopv8QMQRm93ZMH/SglpUbywS0JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575695; c=relaxed/simple;
	bh=KzayNSdr3pdbIVDNjYD7WaaoLYIzNP6L/cS36iBAFQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c1jb+e+4w0SOdhjIKTTQ4xSUPHJ3CJJ4e4HDQFc7tobmgLd93tno66RZcKWNeWF5I8BiYk5lRjw0Wx61M+HrVqEFIFG/0DTurWy1b5PF8qKw1V+c3ztGYUDxbcig/PXnO0V89oDTLzmxvhsvh2Zna/mDSxQTmwb5ik7KGoQZ0jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cYm3+/Nl; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlOPPvOqw42D/LXW3N3a4Ncs6PFv1a5mDVX8DVmeC0HBpxUlkzRY0K4j2+iJmqxPa9XnN85InXWPNrcrN8nq6Joefat6MdchoQx/UBS2qS5vLAvgmYF8kg6G1u7qCRoj1dSeK+oD001m+Uh2UaqMfqoP2+ES91zAIDrzf/Pi7V6jzZNG79qXlGsYdPWDQvlv4mVQbiTWptHZTAlDkpXkeDnIIQ9B/V4epNUaAEERYJ3id3Ux1ElsWoJrzEQDhgrR3w/3wjP5cCm1F1LZRwTPoehKSIgJcBI+z57yVOm62PiOEsJ0qnfkimPaNkOahxeXANfpne5+eJRdfD/e7LOZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwGCEbjD2TslDGEkdqlVFXdjPj19Be1kUjzH3fwHtZ4=;
 b=HeGAA7WZQQOzRMlaynTuzDpOufX+/befUvxASnwlS5yuwQbOGAns1/MHjemvPxOiczGD4HVoTSNpF+l0fwH+1i0VBhpAwqdwSfc8BwvkkftwziJt8nHrpj17CYRrzSnp8FkNyqhqrlJgY4KLeabhjbtNp8UC7XGU+w3nATbCWuBK6zmGWob/FcjgP9+6UNINryMRvv6Mi6EwwgZR8Rr/HqCgpkeif5M7MPbom9yoxjvQ2yxBIbS8OMdsHNCuiPVULiw+nPBnxDPeOwf/kH3r7kJcfZYehVVs92V3jYL6/XqG9u1CXRe3H3HzTZljy0I+wQI5v/AehModD/kAM0FEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwGCEbjD2TslDGEkdqlVFXdjPj19Be1kUjzH3fwHtZ4=;
 b=cYm3+/Nl8a6ssUG1Jie6df7Klo53OPQT9BPZJVMy9UwzZ1ihoYTXCzvP001zeubwSx4N2zGIqZ+PestdQl1ujy7uob7QdvdqCn5dEhyuVWHeBaDjHAtWJvQvK/szstymbDN1W+hHavYfB1i1jZsuITTaW8gbTTzCIJR4sH3ZNUSBfN6FwgWU0vzN2kjwXoUACrReSev9LaATjc2trXx4Lk4CugcT8CHd5HT/2FYzXYWuEXSlsiwdcWY6tgS9hWgFttnNiiQcF2PGZxaGJzXaLg1gr6IKK1W5bgnzzaPz15HQ+FFKkQBUaNr1xek+10lTpDo31NLMAoKpDlAP56zY4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH8PR12MB9816.namprd12.prod.outlook.com (2603:10b6:610:262::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 08:48:04 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 08:48:04 +0000
Date: Tue, 12 May 2026 11:47:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: syzbot <syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com>,
	urezki@gmail.com
Cc: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org,
	syzkaller-bugs@googlegroups.com, fw@strlen.de
Subject: Re: [syzbot] [bridge?] kernel BUG in __get_vm_area_node
Message-ID: <20260512084754.GA181587@shredder>
References: <69ff8c7c.050a0220.1036b8.000b.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ff8c7c.050a0220.1036b8.000b.GAE@google.com>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH8PR12MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c52b60-7033-43ed-d41c-08deb0032e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	GPQjzsdzqsqQPnQYckDSyKe2lG+bCck0xcWLHwYGvaQVUz0nPlGtxd3x4FMagYx8bNc9VM8e2IV1cdOe/0IVnQL5nLB47oXqbateF38nTDGF4u2yHZTbA5HwEBl/6634DJVbRjsSBI7RTmrXjq9KBTpY65G3nnclPkAlqqtNwOuTTfzAciQJjMc0O3fIJ3Suh7CcMYrk33g+hSEkpmwkXtKSkfmpGOidcIkIwVn5Ps/NHvsOhLQwN1apoJUWsbJl2MsNBk/Lezs87elu1bnFh6bimxLb6MrC8PCukA9mdqE3SHbXAsm0Lx53T+vgu0spDmPPAO88RtUyv89/Xm7nTYRnSxdGvZrtpkHhOhhFTnUhHOaNNEEUOFRlxt7MijXiJ6+RPcCnwONqa+3oRjaOmgJasf1Wey6Ep4J9CqywDODGYVbdQliUYUhRqI5S3TpP+/gel2hs+Z+uagBeG2tflG9XXfOqtZKaFfoMNPkw30KYgoVFcrDJgfNyC94DeqZTr+7qTK21nYKd0tgycN5L3gdeSMau0HmuswStMZ5/pLamtGGKf/r46S1ubXIxCgp1ko5ut4cKJpjkICnZgyP+IyCgJM4Lb1up0/GA/wwXrM+WMocOC6ONfJjnQwCTP2Fd0EqDSD4qCxCEYz7dsmzF5589kX8yatRsr60X+4GJrjZrFs/Q2GX2QMv3Yaz52UwX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q5uKwF2YEJm65vAbu56BWsqnKX1n7R8UvPBZR1wpfaN02cG1pxZZdE+xQCl1?=
 =?us-ascii?Q?a4K7U9saZakVc0P5BAUZboWgtGFvVkQ6p5gv7h4gxSlO51PbxoD9ZqQFu7GB?=
 =?us-ascii?Q?x5TTalnZz/n+sAdPzHQnmPP8yqIXCCwEa7mk7HgX+SaPNmQXahYcuY7iAchO?=
 =?us-ascii?Q?bJe0Ne91Pc3bU11J9upUlQoDtERDHASOLNOqmW8DOHzzhF+Lvl0YS0x8QY4Z?=
 =?us-ascii?Q?an/1wLyNlmJ80srF/ldEJYL8UsLgDWYbN1/qnt3TNMqV55DS0v6RYZRgxIbd?=
 =?us-ascii?Q?VsxdnsnE+pTcdtVRgdwuWStpJfkV2ZsB7VWm2GzKYMXScbSQyXZ258RnDLoY?=
 =?us-ascii?Q?4mpZIDa6Mafekbz/plUAkzz4Pp/V+3wOpvgPZtNafB2yeI7M8BPIjrt6dSUp?=
 =?us-ascii?Q?Nd+BsQaTGrwT/95+xR9HZBzozDCjbziz235XPmNTyZMMdIWhBJhPzwsgMgV3?=
 =?us-ascii?Q?9qqFrehMoN73mzW6FfO2/khi6u01vCzUscrbSDOZYoi+kW11q0426AuxCdXk?=
 =?us-ascii?Q?FcjSVXbIaJcB3vavYqUm/A5HOnZZ0oABK0CE8LaOTF5xuX4wCXPtbLYGcbAB?=
 =?us-ascii?Q?YXOB9I2NabZKL+QwQbNqOidHcsXBlbmPDuoZcPDYmcyI5PXPy6PjF7r+IO1c?=
 =?us-ascii?Q?jowsLnaCq84dSHSkRnQE7y/udbv1UHM1ZBJoJUequeYopTrZQwi24vJplK9O?=
 =?us-ascii?Q?YfiELXhCSm4JTLXPUWhTMhYoL7j4sUBP0d5Cdb5tzm2EwtUVUgC23je7kVnB?=
 =?us-ascii?Q?PJ4wriygCu/pnnYoUAapI90nc3TyWdqxbkqi9dcosnOfB1gW4dguExVEOuNW?=
 =?us-ascii?Q?zS886ZeU+63+rTjYA6hr+i1gkTJoUuCoIbFLuzRGVkGoBX//QiOfirk3ePk0?=
 =?us-ascii?Q?PWYqyjOy8q/G0SC5H11XfRYOuTkpUJTxjF7ZFZOGiSM5wok0djwsawaQ/5u3?=
 =?us-ascii?Q?Bqmfd/e+OpBjJcdKzimlUaLb0CBPCgqTimMDD62jDv78jI3874WqpjO/o/vn?=
 =?us-ascii?Q?0piKUnbJC8yMytdFY2Yb22evQ6xn1LU/DSolFv3AEiZmuhhCbqMB2pUz2Nb6?=
 =?us-ascii?Q?hCeSivzfdGQtRnB1ygmbqNvakiDeveQ1tItfwrAK+OnpwrzW1arMKbJYmrtR?=
 =?us-ascii?Q?cIkW7DlTDcIEjJ1jQ23OW8cjw5zphDOWVVVrcyKOKnQPZkyWylqHG92xdeXq?=
 =?us-ascii?Q?JeMOzGZz8rdu/d8gWFIRfsGluGHnwbK0AnRxzJtedDQhWFpNRlDPMaBrF2eD?=
 =?us-ascii?Q?R+7trHZiJ0Of4zkQTi5Jew92NhpFeCgQsNrkL0rM64THg1LBXl6dvGfrBwgY?=
 =?us-ascii?Q?G77Hy7jVfO7Ag3N3VykTw89ktc65W04BLkd5hQeR/CkfvTADLV+JecnKsUfr?=
 =?us-ascii?Q?6OQQMghkiyR8PEII43Sr7jBBfElwJC+wMHBs62NOrsWiR4wXWsN4aPRvg7/Q?=
 =?us-ascii?Q?W16L+iQLJhucV2twrfG5EV51eJ6daWZ6kvyGdnYF6vs6clMFTaov/+K/tSOp?=
 =?us-ascii?Q?sXPn/QZQXTcx9ZHkrPsbwRMkNN/m434XFNmTO+AsWhlF8scmjiqvcKCd6DN4?=
 =?us-ascii?Q?xUFUjfW5SXWxoXn29toIa9s4QlOBgs26UW464UqSckI0lqwzjlqA2pwLArcO?=
 =?us-ascii?Q?gejnsPEkyVVD41RUTOge5P/85KR6ijdVcKNvKj+pGCgwAhYK/5wEjvWZGUqz?=
 =?us-ascii?Q?w2TKrYb9dlwsGb2w5cJrkSEOMXvanH9VD8MwC3bN3AjemMHbDuds0BmpqqJ2?=
 =?us-ascii?Q?veZ61EfhVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c52b60-7033-43ed-d41c-08deb0032e4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:48:04.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjajOLnLtZ0y1sxJv0eK4QA47iU3Tg3mbEk8VJXPj0YlGBCnLW59TXsxOPDy54ESL0FckPcz+R6nigETQQ2zdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816
X-Rspamd-Queue-Id: 0DB0A51D090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-287010-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url,googlegroups.com:email,goo.gl:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev,8b12fc6e0fb139765b58];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 12:35:24PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9207d47f966b Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e44d06580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
> dashboard link: https://syzkaller.appspot.com/bug?extid=8b12fc6e0fb139765b58
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9207d47f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6c5e883f31aa/vmlinux-9207d47f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/19f3e863ae5c/bzImage-9207d47f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at mm/vmalloc.c:3206!

It seems that this bug was fixed by commit 30c19366636f ("mm: fix BUG
splat with kvmalloc + GFP_ATOMIC"), but then commit c6307674ed82 ("mm:
kvmalloc: add non-blocking support for vmalloc") re-introduced it.

Uladzislau, can you please look into it?

Note that the bridge is calling rhashtable_lookup_insert_fast() with BH
disabled.

Thanks

> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 1 UID: 0 PID: 8030 Comm: syz.6.9336 Tainted: G             L      syzkaller #0 PREEMPT(full) 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:__get_vm_area_node+0x2d2/0x330 mm/vmalloc.c:3206
> Code: 03 80 3c 11 00 75 5c 48 89 43 08 e9 4b ff ff ff e8 43 a8 a4 ff 48 89 df e8 db 98 05 00 31 db e9 37 ff ff ff e8 2f a8 a4 ff 90 <0f> 0b e8 77 6b 11 00 e9 9e fe ff ff e8 6d 6b 11 00 e9 71 fe ff ff
> RSP: 0018:ffffc90006f76860 EFLAGS: 00010246
> RAX: 0000000000080000 RBX: 0000000000000200 RCX: ffffc90034405000
> RDX: 0000000000080000 RSI: ffffffff82633fb1 RDI: ffff8880244b4a00
> RBP: 000000000000000c R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000200 R11: 0000000000000000 R12: 0000000000000022
> R13: 0000000000008080 R14: 0000000000000001 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88809727d000(0063) knlGS:00000000f4f61b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000f73c4f50 CR3: 0000000055b77000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __vmalloc_node_range_noprof+0x228/0x1630 mm/vmalloc.c:4024
>  __kvmalloc_node_noprof+0x3de/0xa00 mm/slub.c:6860
>  bucket_table_alloc.isra.0+0x88/0x460 lib/rhashtable.c:186
>  rhashtable_insert_rehash lib/rhashtable.c:493 [inline]
>  rhashtable_try_insert lib/rhashtable.c:661 [inline]
>  rhashtable_insert_slow+0x16ab/0x1de0 lib/rhashtable.c:674
>  __rhashtable_insert_fast include/linux/rhashtable.h:788 [inline]
>  rhashtable_lookup_insert_fast include/linux/rhashtable.h:965 [inline]
>  fdb_create+0x13cf/0x1920 net/bridge/br_fdb.c:415
>  fdb_add_local net/bridge/br_fdb.c:450 [inline]
>  fdb_add_local+0x155/0x1c0 net/bridge/br_fdb.c:430
>  br_fdb_add_local+0x39/0x60 net/bridge/br_fdb.c:960
>  __vlan_add+0x17f3/0x2e10 net/bridge/br_vlan.c:340
>  br_vlan_add+0x2dc/0xa00 net/bridge/br_vlan.c:810
>  __vlan_add+0xf7c/0x2e10 net/bridge/br_vlan.c:297
>  nbp_vlan_add+0x258/0x3e0 net/bridge/br_vlan.c:1348
>  br_vlan_info+0x159/0x3d0 net/bridge/br_netlink.c:705
>  br_process_vlan_info+0x404/0x8f0 net/bridge/br_netlink.c:768
>  br_afspec+0x422/0x650 net/bridge/br_netlink.c:836
>  br_setlink+0x376/0x630 net/bridge/br_netlink.c:1135
>  rtnl_bridge_setlink+0x56d/0x740 net/core/rtnetlink.c:5571
>  rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:7004
>  netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>  netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
>  netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
>  sock_sendmsg_nosec net/socket.c:787 [inline]
>  __sock_sendmsg net/socket.c:802 [inline]
>  ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
>  ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
>  __sys_sendmsg+0x170/0x220 net/socket.c:2784
>  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>  __do_fast_syscall_32+0xe7/0x950 arch/x86/entry/syscall_32.c:307
>  do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf7f08fcc
> Code: d2 74 05 c1 e8 0c 89 02 8b 5d fc 31 c0 c9 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 2e 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 58 b8
> RSP: 002b:00000000f4f6150c EFLAGS: 00000292 ORIG_RAX: 0000000000000172
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 0000000080000040
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__get_vm_area_node+0x2d2/0x330 mm/vmalloc.c:3206
> Code: 03 80 3c 11 00 75 5c 48 89 43 08 e9 4b ff ff ff e8 43 a8 a4 ff 48 89 df e8 db 98 05 00 31 db e9 37 ff ff ff e8 2f a8 a4 ff 90 <0f> 0b e8 77 6b 11 00 e9 9e fe ff ff e8 6d 6b 11 00 e9 71 fe ff ff
> RSP: 0018:ffffc90006f76860 EFLAGS: 00010246
> RAX: 0000000000080000 RBX: 0000000000000200 RCX: ffffc90034405000
> RDX: 0000000000080000 RSI: ffffffff82633fb1 RDI: ffff8880244b4a00
> RBP: 000000000000000c R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000200 R11: 0000000000000000 R12: 0000000000000022
> R13: 0000000000008080 R14: 0000000000000001 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88809727d000(0063) knlGS:00000000f4f61b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000f73c4f50 CR3: 0000000055b77000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	d2 74 05 c1          	shlb   %cl,-0x3f(%rbp,%rax,1)
>    4:	e8 0c 89 02 8b       	call   0x8b028915
>    9:	5d                   	pop    %rbp
>    a:	fc                   	cld
>    b:	31 c0                	xor    %eax,%eax
>    d:	c9                   	leave
>    e:	c3                   	ret
>    f:	90                   	nop
>   10:	90                   	nop
>   11:	90                   	nop
>   12:	90                   	nop
>   13:	90                   	nop
>   14:	90                   	nop
>   15:	90                   	nop
>   16:	90                   	nop
>   17:	90                   	nop
>   18:	90                   	nop
>   19:	90                   	nop
>   1a:	90                   	nop
>   1b:	90                   	nop
>   1c:	90                   	nop
>   1d:	90                   	nop
>   1e:	0f 1f 00             	nopl   (%rax)
>   21:	51                   	push   %rcx
>   22:	52                   	push   %rdx
>   23:	55                   	push   %rbp
>   24:	89 e5                	mov    %esp,%ebp
>   26:	0f 34                	sysenter
>   28:	cd 80                	int    $0x80
> * 2a:	5d                   	pop    %rbp <-- trapping instruction
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	ret
>   2e:	90                   	nop
>   2f:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
>   36:	00
>   37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>   3e:	58                   	pop    %rax
>   3f:	b8                   	.byte 0xb8
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

