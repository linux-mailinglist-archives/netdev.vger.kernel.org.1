Return-Path: <netdev+bounces-302249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JvamCx66PmozKwkAu9opvQ
	(envelope-from <netdev+bounces-302249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:42:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1A6CF71B
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:42:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dK6ao2Su;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302249-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302249-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B68309BFE4
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E23FE35D;
	Fri, 26 Jun 2026 17:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A0401A02
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:41:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495707; cv=none; b=PuI2G7p9WsqxUwlhyVK7MuoTbUZqei5hp+PyaS5cBC+ODvstvruA+yAPEOamKorhaksmkn39NZ9l5XV16UuvLUp+O8mI4HmE9yoLyBMoUaKy6zYinWLKXMagsjOTIWDWnjSOT9jE/jYckqh/8804ObiTSjgjGtOhfl/Fme3Jq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495707; c=relaxed/simple;
	bh=y783qvk1TjnNBeI8iZy2q5wNS26CgOBAitwbMeK6aQo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uIWEhunvzJr3FzYhuaXbmLqK2/hL9meNnJHDVAe9fNJR0zbo+BaTK+hTpxVCO7eEIpkVrEnDCU4QZeMBxrJkDhzgw1CxZY5vOOPee60D829a6Yg4lWuepAmnu//iSuEiz2kk7j9g1fg+r+f6Cp6Q2nhzbqaApHQjkl4+00m2GFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK6ao2Su; arc=none smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8e423029db6so14472656d6.3
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782495705; x=1783100505; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhLy5HGhlmHKNgyKg0Eoc8/OEklRulKzznkysm+tQX8=;
        b=dK6ao2Su27ufaZVvcF6ZHMlBPzTKxyBPNiKD0RBtkjQrGZAiFFafcyGZD97UnxYe4k
         cS2O4/kzFKwSibAY8ndRd23WOTm33pNlIMACLIf2aPvbPMYl/Z27RHuVyG/Wu0q1prD9
         Wt2nr9HRas8osJnrPdLdTooub68X3G84bk9Q25VHtOEIA4VoDxAg8I2T936ReS57U8/v
         Gj8yIbzAzw//Ox//zVXRdlmPgcwmft0n9Nr4LEQDXRaUsS5nEzCge8xCMwnk3swy293s
         LN8GpJ7rLgR3dMYF1uJoP60OPE+IGRwb5q/mzLgKjlkOFKHWMBbFwsyJLRHT/VsOMd97
         lMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495705; x=1783100505;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhLy5HGhlmHKNgyKg0Eoc8/OEklRulKzznkysm+tQX8=;
        b=NyNZ5qmFYQ+xvLIQidqkKPg67xCfo/X0P9fU5noi4N9Jo6Tfb1EM3VYUiYfzgh4FAo
         Wf4UTW3q6BD0MvnHG9m4jbMSh5c7h0blSEcHupJdT1KkAN4qcOzB1Ks4FXlb1pxlO1hW
         RObYIvRsibbFwOsfNFzUTVP0QdbiFU2+Y9cDsM0L9NrcPk3q92vkCDwL3EkpV7K66V5K
         rODgbmJ9xey+icGwcwwNfJF+hoo3f97dmXmGDKhM8Fb3sLFZ17UbFH9h96W1MB48xRRP
         yUF90G2nTSaCCEH9ScIeFTDokJshMBBlOe48zeqVWHQkrpPNvMM9cQylh3bJsU5RH4eo
         +Y2w==
X-Gm-Message-State: AOJu0Yw9A32xnWx04ykmzeMgRAVv8OVYsS3lufPhbeX8hq6UszEztah+
	rbZlRgp87IspPXuY7FQHLRZ3Jn46RwdPUQmEPtrhiWej7VQ8o5Z7E77Y
X-Gm-Gg: AfdE7ckD6+awS5dtGTI6FKLCT19bJSQaJy84vMyy6r2SqhwhUBY2uIyXu7tZs20TGwf
	BZIdADnFiWw5Uddr1jpixX8EHrZ+OvPl4gr7ksu70FsuUfYfSwDkZThSR80mV7TtCoZck5r3+s8
	pzT14BZQqWGB/7vdMKHuGcm2+051eab3OvICEJG7eOn6zsx4Yok04TDmTobIMf1h9XmMZ8V60Uo
	2t34Wfhx83Q8rEXkXtencZCm90j2bvDQydjRGUnMz9/Tgn5Q/YJ4FkAitSzY17JUaF1joxmfBo4
	KXSqiaddaYjbPYnFicefDNRKcQzBeMmiNiW9G1CjsV2hNIpfnjPPHGa0D2YmWkSNJCVB+HP3Wu7
	ot2IRYjJo8LBZW1I0p1RL7sV7OTxv1sXKaQw4B7+/QC9biryrVFGglwQIVGBEI9tFgPA0CFd4Gd
	rdAg8U1G/qOTWDfumfawtl9QO7EbVIVgvma2OIeGpvVjc=
X-Received: by 2002:a05:6214:2aac:b0:8db:aaf1:c446 with SMTP id 6a1803df08f44-8e6d6581059mr134067166d6.38.1782495704750;
        Fri, 26 Jun 2026 10:41:44 -0700 (PDT)
Received: from smtpclient.apple ([104.39.15.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82d59cfcsm236600846d6.48.2026.06.26.10.41.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jun 2026 10:41:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] netdevsim: KASAN slab-use-after-free in ref_tracker_free
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <CAHfVqdXqZkrp5Dm0a8BJU0Tbc_T09A=e02PenwxrZFDMQrEmyQ@mail.gmail.com>
Date: Fri, 26 Jun 2026 13:41:13 -0400
Cc: netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2037CBE9-D72E-4E81-9B18-62AF3735306D@gmail.com>
References: <178144969601.60470.14764529841344817811@gmail.com>
 <CAHfVqdXqZkrp5Dm0a8BJU0Tbc_T09A=e02PenwxrZFDMQrEmyQ@mail.gmail.com>
To: saeed bishara <saeed.bishara.os@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302249-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:saeed.bishara.os@gmail.com,m:andrew@lunn.ch,m:saeedbisharaos@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81F1A6CF71B



> On Jun 16, 2026, at 05:34, saeed bishara <saeed.bishara.os@gmail.com> =
wrote:
>=20
> I tried gemini, here its analysis and a fix suggestion:
>=20
> This is a brilliant, subtle bug. Let's break this down with a rigorous
> audit of the Linux network device refcounting architecture to see
> exactly why this Use-After-Free is occurring.
> The root cause is a classic "Reverse-Teardown Fallacy" colliding with
> the kernel's dual-refcount lifecycle for network devices (pcpu_refcnt
> vs. kobject refcount).
>=20
> The Dual-Lifecycle Trap
> In modern kernel networking, a struct net_device is kept alive by two
> distinct mechanisms that must be carefully orchestrated:
> dev->pcpu_refcnt (Operational Lifecycle): Managed by dev_hold() and
> dev_put(). This tracks active operational references. The
> unregister_netdevice sequence blocks in netdev_run_todo() waiting for
> this to hit zero before it invokes free_netdev().
> dev->dev.kobj (Memory Lifecycle): The underlying memory structure
> manager. free_netdev() drops a reference to this. When the kobject
> refcount hits 0, device_release() is synchronously triggered, and the
> kmalloc-cg-8k slab is actually freed.
>=20
> The Exact Race Sequence
> Look at the teardown order in the error path of sysfs_rtnl_lock():
>=20
> unbreak:
>    sysfs_unbreak_active_protection(kn);  // LINE 121
>    dev_put(ndev);                        // LINE 122
>=20
> Normally, developers write error paths in the exact reverse order of
> initialization. However, in this specific case, adhering to that
> convention is fatal.
> The Setup: sysfs_rtnl_lock starts by calling dev_hold(ndev),
> incrementing the pcpu_refcnt. It then calls
> sysfs_break_active_protection(), which explicitly calls kobject_get(),
> elevating the kobj memory refcount.
> The Unregister Race: In parallel, another CPU initiates device
> teardown (e.g., echo 1 > del_device on netdevsim). The sysfs entries
> are deleted, and device_del() drops its primary kobj reference. The
> teardown thread hits netdev_run_todo() and blocks, waiting for
> sysfs_rtnl_lock to release its dev_hold.
> The Lock Fails: sysfs_rtnl_lock fails to get the rtnl lock and jumps =
to unbreak.
> The Fatal Drop (Line 121): sysfs_unbreak_active_protection(kn)
> executes. It calls kobject_put(). Because the unregistration path
> already dropped the standard kobject references, this is the absolute
> last kobject reference. device_release() is synchronously invoked, and
> the net_device memory is instantly freed to the slab.
> The KASAN Trigger (Line 122): dev_put(ndev) executes. Under the hood,
> it attempts to call netdev_tracker_free(&ndev->ref_tracker, ...). It
> reads from the ndev structure that was just destroyed microseconds
> earlier. KASAN screams.
>=20
> To fix this, the teardown convention must be deliberately violated to
> respect the underlying memory dependencies.
>=20

Thanks for the analysis and patch suggestion.

I tested the patch together with the local delay/debug patch that was
used to trigger the original report.  I rebuilt the kernel, booted a
fresh VM, and reran the same netdevsim reproducer.

With the patched kernel, the original KASAN UAF was not reproduced in
this run:

  BUG: KASAN: slab-use-after-free in ref_tracker_free

However, the same rx-0 create_dir failure path was still reached, and
the run still produced a ref tracker warning:

  kobject_add_internal create_dir failed for rx-0 ...
  WARNING: lib/ref_tracker.c:295 at ref_tracker_free
  sysfs_rtnl_lock
  phys_port_name_show


> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index a1b2c3d4e5f6..7f8e9d0c1b2a 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -118,8 +118,8 @@ static int sysfs_rtnl_lock(struct kobject *kobj,
> struct attribute *attr,
>  return 0;
>=20
> unbreak:
> - sysfs_unbreak_active_protection(kn);
>  dev_put(ndev);
> + sysfs_unbreak_active_protection(kn);
>  return ret;
> }
>=20
>=20
> On Mon, Jun 15, 2026 at 4:18=E2=80=AFAM Shuangpeng Bai
> <shuangpeng.kernel@gmail.com> wrote:
>>=20
>> Hi netdev maintainers,
>>=20
>> I hit the following KASAN report while testing an upstream kernel.
>>=20
>> The issue was reproduced with netdevsim. I have not confirmed whether =
this is
>> specific to netdevsim or whether other net devices can trigger a =
similar issue.
>>=20
>> The KASAN report shows a slab-use-after-free in ref_tracker_free(), =
reached from
>> sysfs_rtnl_lock() while reading phys_port_name.
>>=20
>> I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 =
(May 25 2026)
>>=20
>> To help trigger the bug more reliably, we applied a minimal =
diagnostic patch
>> that only adds delays and print statements.
>>=20
>> The reproducer and .config files are here.
>> =
https://gist.github.com/shuangpengbai/b49765d646ec4610917015371aa1c3ca
>>=20
>> I'm happy to test debug patches or provide additional information.
>>=20
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>>=20
>> [ 3145.449971][T17497] BUG: KASAN: slab-use-after-free in =
ref_tracker_free (lib/ref_tracker.c:295)
>> [ 3145.452089][T17497] Read of size 1 at addr ffff888107678598 by =
task cat/17497
>> [ 3145.454439][T17497]
>> [ 3145.454977][T17497] Tainted: [W]=3DWARN
>> [ 3145.454980][T17497] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX =
+ PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [ 3145.454985][T17497] Call Trace:
>> [ 3145.454991][T17497]  <TASK>
>> [ 3145.454994][T17497]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
>> [ 3145.455002][T17497]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
>> [ 3145.455028][T17497]  kasan_report (mm/kasan/report.c:595)
>> [ 3145.455046][T17497]  ref_tracker_free (lib/ref_tracker.c:295)
>> [ 3145.455083][T17497]  sysfs_rtnl_lock =
(include/linux/netdevice.h:4491 include/linux/netdevice.h:4508 =
include/linux/netdevice.h:4534 net/core/net-sysfs.c:122)
>> [ 3145.455091][T17497]  phys_port_name_show =
(net/core/net-sysfs.c:665)
>> [ 3145.455118][T17497]  dev_attr_show (drivers/base/core.c:2421)
>> [ 3145.455128][T17497]  sysfs_kf_seq_show (fs/sysfs/file.c:65)
>> [ 3145.455135][T17497]  seq_read_iter (fs/seq_file.c:231)
>> [ 3145.455144][T17497]  vfs_read (fs/read_write.c:493 =
fs/read_write.c:574)
>> [ 3145.455169][T17497]  ksys_read (fs/read_write.c:717)
>> [ 3145.455181][T17497]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 =
arch/x86/entry/syscall_64.c:94)
>> [ 3145.455188][T17497]  entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:121)
>> [ 3145.455193][T17497] RIP: 0033:0x7fcf098c43ce
>> [ 3145.455200][T17497] Code: c0 e9 b6 fe ff ff 50 48 8d 3d 6e 08 0b =
00 e8 69 01 02 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 =
c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 =
48 83 ec 28
>> [ 3145.455204][T17497] RSP: 002b:00007ffd05e76b98 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000000
>> [ 3145.455211][T17497] RAX: ffffffffffffffda RBX: 0000000000020000 =
RCX: 00007fcf098c43ce
>> [ 3145.455214][T17497] RDX: 0000000000020000 RSI: 00007fcf095e4000 =
RDI: 0000000000000003
>> [ 3145.455217][T17497] RBP: 00007fcf095e4000 R08: 00007fcf095e3010 =
R09: 0000000000000000
>> [ 3145.455219][T17497] R10: fffffffffffffbc5 R11: 0000000000000246 =
R12: 0000000000000000
>> [ 3145.455222][T17497] R13: 0000000000000003 R14: 0000000000020000 =
R15: 0000000000020000
>> [ 3145.455227][T17497]  </TASK>
>> [ 3145.455229][T17497]
>> [ 3145.479014][T17497] Freed by task 17497 on cpu 0 at 3145.447575s:
>> [ 3145.479559][T17497]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
>> [ 3145.479963][T17497]  kasan_save_free_info (mm/kasan/generic.c:584)
>> [ 3145.480411][T17497]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
>> [ 3145.480813][T17497]  kfree (include/linux/kasan.h:235 =
mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
>> [ 3145.481148][T17497]  device_release (drivers/base/core.c:2542)
>> [ 3145.481567][T17497]  kobject_put (lib/kobject.c:689 =
lib/kobject.c:720 include/linux/kref.h:65 lib/kobject.c:737)
>> [ 3145.481951][T17497]  sysfs_rtnl_lock (net/core/net-sysfs.c:121)
>> [ 3145.482351][T17497]  phys_port_name_show =
(net/core/net-sysfs.c:665)
>> [ 3145.482782][T17497]  dev_attr_show (drivers/base/core.c:2421)
>> [ 3145.483154][T17497]  sysfs_kf_seq_show (fs/sysfs/file.c:65)
>> [ 3145.483586][T17497]  seq_read_iter (fs/seq_file.c:231)
>> [ 3145.483975][T17497]  vfs_read (fs/read_write.c:493 =
fs/read_write.c:574)
>> [ 3145.484334][T17497]  ksys_read (fs/read_write.c:717)
>> [ 3145.484701][T17497]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 =
arch/x86/entry/syscall_64.c:94)
>> [ 3145.485092][T17497]  entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:121)
>> [ 3145.485592][T17497]
>> [ 3145.485794][T17497] The buggy address belongs to the object at =
ffff888107678000
>> [ 3145.485794][T17497]  which belongs to the cache kmalloc-cg-8k of =
size 8192
>> [ 3145.486991][T17497] The buggy address is located 1432 bytes inside =
of
>> [ 3145.486991][T17497]  freed 8192-byte region [ffff888107678000, =
ffff88810767a000)
>> [ 3145.488159][T17497]
>> [ 3145.488367][T17497] The buggy address belongs to the physical =
page:
>>=20
>>=20
>> Best,
>> Shuangpeng
>>=20


