Return-Path: <netdev+bounces-259594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGpTCzaFl2mwzgIAu9opvQ
	(envelope-from <netdev+bounces-259594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:48:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E9D162F1A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D49ED304AAC0
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB52D9EC2;
	Thu, 19 Feb 2026 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET68yUaT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056B329E77
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537668; cv=none; b=r6QlsQWwJGlm15ulnPhErYO6wTDiszVd7m13ZwW+btR2quYavLsZ2HiCw/b8SlSKku8fBs2I32jxny5zLAG5jNMcbdBJUdlS5BwTo2g87EF1eoK1/6dMkum7N+EVFAjk3fcThLHPgPOz6SPVGog3GBDWNzGlER9dKge25C4JZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537668; c=relaxed/simple;
	bh=hI/HB47KJY0BxEspPFN6Pc/qn4qAqWa84rV9wMoXVK4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JOlXnj9GDu4+Nxd4+WXtx9tovmBI/aImYJMffjn6eXRT96ti5hlBSDbZj+fBUG23Qp8LbrpAmZ69EjJxB3ArjTDoJGoMKTUJa5I4DFga5D7bLU+1IY46y5qKzVSHEQ1Aoltn717A/7id1eY0jCJ8OS/cFTD8h3wIie3Je2d3lSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET68yUaT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8947404b367so16813466d6.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 13:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771537662; x=1772142462; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqS+BeGnJuxOwDv6sYFOeLw7hL+AMH9ZPpuLvHVhUkQ=;
        b=ET68yUaTdmbGqcWjDLkaSsacos6wSAStBU9r9AhEu4hN3B8hDyh+7k3YBf43I3i5g6
         xd0dmAdO9Akr2egskwQ3O+3QeWXZMqKZgPK0DZntm9pi6G/KGdqB0HvmDc85wJuZTJ8J
         aumsyCHcQ2B/DhjWuUHunQ8ATPcuPBum0hdNIKDex9vmJUzW853o4WjFzM3t3EgD/Lx1
         5yUjH+zfdnc4iwJMUsWIoQ1yp82qGnaPHjERmWoHERuSqZGN8Ccro2nFd+5//JsbmoPz
         vzFIPP8gvgAW/3OML3mgmYnMJqNsgE+27DL0rBzmA8xAA3b6sSuD5Pv3/JDC7Q2Wp3D+
         g9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771537662; x=1772142462;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqS+BeGnJuxOwDv6sYFOeLw7hL+AMH9ZPpuLvHVhUkQ=;
        b=TtVt9A1WJgYTnIOfhsY+4T9hhD/23VolyJmal4ySK1R7XeeEfS6Ge/xQgl5KMQ4uR/
         KCEnzJVVrNduoc4phEvmfUw6dAkiuLlT3eX6URBdX7bqCxF1ZYxEpSeyzuW8FxU11sct
         yqbzmalCTpMYtjdqXFfeNp5jcmRw+NCveE6koNZH/fRpc2sAJ9GbXDbh9cHHDffLztU+
         QqMCQ+fvovo/AVJMTFx9MYLkeRoHc8rQuIEXYrWr4pA0vthXjT+OLYt/Gey21MpJZ0Fo
         e/3jvuYZz45m3jZaVJeeKHR6WWpwlIpQlmlyPhNRgympIYEwATzLZvokaGvK4TudHH3v
         qQFw==
X-Gm-Message-State: AOJu0YyV+iVt80Ibuw9KwsKNyq+HLGacivDum9F0OA9JYNrqDI3mKaiW
	hJywf1/rVGlyYVLuaI3ybGHKzbhEYehbzk9sfi6fzybrKnFvqE2igG5iUqpFywxZ
X-Gm-Gg: AZuq6aKeKRmkIJIoVW//L6YQuepJcDFvYTS46dxETN4qOvOVELPIYBMak67BtaGI7it
	6xiMpykhUtrs3HABhkHMGEXfyeEOWo5bnkrMeMgM8nBcTeY+ojgIkcYVvHWql0iVUJPgzgsqNq9
	6ewWKuTn149HEEeA4UYZQTEZroGVjY0/5fHhzfeVJQKKXaIauX5CoDeB3hjRw/fCMMvoSjKpvdN
	r4dM8oDRQBqBVqNOgMjt2Pe5IbCM0juwMPQJHLuKROcQ8Jv+egMSvGWmHiySXEQQ3Xia+COIQ1N
	IA4wQtGviEZkg+a/OUzeSbkMFjMBJMIYITsNpyBc9GYHEhpZ7JU9l2XknYBhKOAWxPXPpVOtlfv
	EeJdmYFTcPnRE3W0qnpaVz6DzrksuCmT6jtZRibQbz5At6bD+h3ty2ii9Wm16vOUCTAFRlvVlB2
	Qd3BKHlUw4ygWzYJ3CGlylNhVLcg1hFOeczTUfDD8QDWkuo0tETAT7whHq2Jxa5Sfd
X-Received: by 2002:a05:6214:b6a:b0:895:bcc0:2e1a with SMTP id 6a1803df08f44-8996204f3e1mr63110106d6.37.1771537662503;
        Thu, 19 Feb 2026 13:47:42 -0800 (PST)
Received: from smtpclient.apple ([104.39.198.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdd1541sm228186556d6.49.2026.02.19.13.47.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:47:42 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH net v2 1/1] serial: caif: fix remaining ser->tty UAF in TX
 path
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <3c9706a3-92c6-414e-ad60-4bc29c5d621d@linux.dev>
Date: Thu, 19 Feb 2026 16:47:31 -0500
Cc: pabeni@redhat.com,
 andrew+netdev@lunn.ch,
 hdanton@sina.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F93E12BB-356B-40DF-9143-0D7B6096228C@gmail.com>
References: <20260215025141.1106576-1-shuangpeng.kernel@gmail.com>
 <20260215025141.1106576-2-shuangpeng.kernel@gmail.com>
 <3c9706a3-92c6-414e-ad60-4bc29c5d621d@linux.dev>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,sina.com,davemloft.net,google.com,kernel.org,vger.kernel.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-259594-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 81E9D162F1A
X-Rspamd-Action: no action

Hi all,

Thanks for the previous feedback and suggestions.

We explored several mitigations to address the remaining UAF in the
caif_serial TX path, including:
1. Taking a tty reference in handle_tx() using a new
   tty_kref_get_unless_zero() helper.
2. Setting and checking ser->state to avoid internal races.

However, our reproducer still triggers a UAF.
Link: =
https://gist.github.com/shuangpengbai/c898debad6bdf170a84be7e6b3d8707f

After further debugging, the KASAN report consistently points to
the memory access in pty_write_room():

    tty_buffer_space_avail(tty->link->port);

Two different tty objects are dereferenced here: 'tty' and 'tty->link'.
In debugging, we found the invalid access is specifically on =
'tty->link',
rather than 'tty' itself, based on comparing the runtime addresses.
Therefore, our previous analysis for the race could be inaccurate.

We will continue investigating the root cause and we are happy to=20
provide any additional information for you to debug this bug.

Below is the report showing the fault location:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in pty_write_room =
(drivers/tty/pty.c:131)
Read of size 8 at addr ffff888116df7018 by task a.out/8414

Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:122)
 print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:597)
 pty_write_room (drivers/tty/pty.c:131)
 handle_tx (drivers/net/caif/caif_serial.c:213)
 dev_hard_start_xmit (./include/linux/netdevice.h:5275=20
    ./include/linux/netdevice.h:5284 net/core/dev.c:3871 =
net/core/dev.c:3887)
 __dev_queue_xmit (net/core/dev.c:?)
 transmit (net/caif/caif_dev.c:237)
 cfserl_transmit (net/caif/cfserl.c:185)
 cffrml_transmit (net/caif/cffrml.c:?)
 cfmuxl_transmit (net/caif/cfmuxl.c:240)
 caif_connect_client (net/caif/cfcnfg.c:355)
 caif_connect (net/caif/caif_socket.c:828)
 __sys_connect (net/socket.c:2089 net/socket.c:2108)
 __x64_sys_connect (net/socket.c:2114 net/socket.c:2111)
 do_syscall_64 (arch/x86/entry/syscall_64.c:?)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 </TASK>

Freed by task 4526:
 kasan_save_track (mm/kasan/common.c:58 mm/kasan/common.c:78)
 kasan_save_free_info (mm/kasan/generic.c:587)
 __kasan_slab_free (mm/kasan/common.c:287)
 kfree (mm/slub.c:6082 mm/slub.c:6399)
 process_scheduled_works (kernel/workqueue.c:3280 =
kernel/workqueue.c:3358)
 worker_thread (./include/linux/list.h:381 kernel/workqueue.c:3440)
 kthread (kernel/kthread.c:468)
 ret_from_fork (arch/x86/kernel/process.c:164)



> On Feb 18, 2026, at 09:25, Vadim Fedorenko <vadim.fedorenko@linux.dev> =
wrote:
>=20
> On 15/02/2026 02:51, Shuangpeng Bai wrote:
>> A reproducer exposes a KASAN use-after-free in caif_serial's TX path
>> (e.g., via tty_write_room() / tty->ops->write()) on top of commit
>> <308e7e4d0a84> ("serial: caif: fix use-after-free in caif_serial
>> ldisc_close()").
>> That commit moved tty_kref_put() to ser_release(). There is still a =
race
>> because the TX path may fetch ser->tty and use it while ser_release()
>> drops the last tty reference:
>>     CPU 0 (ser_release worker)         CPU 1 (xmit)
>>     -------------------------        ------------
>>                                       caif_xmit()
>>                                       handle_tx()
>>                                         tty =3D ser->tty
>>     ser_release()
>>       tty =3D ser->tty
>>       dev_close(ser->dev)
>>       unregister_netdevice(ser->dev)
>>       debugfs_deinit(ser)
>>       tty_kref_put(tty)        // may drop the last ref
>>                      <-- race window -->
>>                                         tty->ops->write(tty, ...)  // =
UAF
>> Fix it by serializing accesses to ser->tty with a dedicated lock. The =
TX
>> path grabs a tty kref under the lock and drops it after the TX =
attempt,
>> while ser_release() clears ser->tty under the same lock before =
putting the
>> old tty reference. This prevents the TX path from observing a freed =
tty
>> object via ser->tty.
>> With this change applied, the reproducer no longer triggers the UAF =
in my
>> test.
>> One concern is that handle_tx() can be a hot path. This fix adds a =
short
>> lock-held section plus an extra tty kref get/put per TX run. Feedback =
on
>> the performance impact, or suggestions for a lower-overhead approach, =
are
>> welcome.
>=20
> I'm not quite sure we actually need spinlock here. It looks like just =
adding simple helper tty_kref_get_unless_zero() and using it in =
handle_xt() will solve the problem?
>=20
>=20


