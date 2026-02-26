Return-Path: <netdev+bounces-261340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK8MDIFEoGkZhwQAu9opvQ
	(envelope-from <netdev+bounces-261340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:02:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602BF1A6083
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 778DF30E6454
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8992DCF45;
	Thu, 26 Feb 2026 12:58:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2ED242D76
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110717; cv=none; b=MoIGwCkthgvQS/LlOkwJF8j/YHGr1s1zBiRfuAFhiI8Lw2/J+jhzIiZUvtEZ1d8GsnnlgEz8gEncxi7OWAF0pL8DIxXojSgQQcVkIFtrN/tQAMXV6+Z3fm+Rq1Ox/HMvXv8diR4YX2KQe+qhpOhcarApA2MfuUCj69vOIW9/fNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110717; c=relaxed/simple;
	bh=jgTMHcWDHylG0I0dXdBiZGDrftWEX9QlvkG1P7mnCho=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ecl8GOhOSt46nZsVxj+O2uwv0hfUU6w5kn0LX5M5cetl4wA3VmBnb4F8LBOuNTLLbnPxduFJKZ0PIV29jIX5oSyp0+am4WI78XBy3Xr0XKHo6LJVq3JE2ioFebLNWsP7dQL7JpK7CV+1V52fHcNU1TSxji/trNTHcW4YcJ2QRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67995e1ecacso18395567eaf.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110715; x=1772715515;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8k5Nu+4WdoFwZvOfUmhYahsobY/Ezi5a3CfLGRDfYM=;
        b=VA8iv524G9CRkQ8IoVs60EbipRU/MjKsVZBwPpM6UyodnPvDSrt8Gs3IrVnBqZcre4
         ObM2rE8PlsLPeqZCCgQTlonYUFe7tUnPD/emJGBEAZ0lVVCHY7SiDeK92Nnsbng4Iasa
         r+q5i2AuDfPHDkzph01LIQo72UWiTfcy+XknR203VrPAXKE7BVyQKCvgieN4T50RWC1j
         8Dj6XnfRtSf/gcyE2lK3y9YlUFoACwmPTqEX4csFDmplUXSt6nmWgxyf4QGhqKlVh7O5
         wvh2LpngkxN751m/UzTMMs/JLe3EAAeLjGg1gfnnDdx0UOgiLMB3bFLIbg9rr8zFV7AI
         xA+g==
X-Forwarded-Encrypted: i=1; AJvYcCX4Zg6FgfmgYJrmwbdUDvEOriu+2XD5//Rkn8GbYQObN3tZYmyy74DR+qTroVgF7SLvXdcfbsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhrItWNkW8A8educMqls4Cwks9DD4KLQA8czWbqvgtCK/O6eF
	+Sd+UnLdHzaDq+UJSOHVD5mOr330RswZyohZa8htVYXRjxQ4KEsaKIwMPjCWcQ7/KTKgMLljmpc
	n6yhIR8xsYBxVR+9ySg7iotvBbGtnawtj3hChxRWn0EWwdUJa6VNvbk3CRcA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:999:b0:679:f08b:5382 with SMTP id
 006d021491bc7-679f08b5ebemr2171559eaf.11.1772110715212; Thu, 26 Feb 2026
 04:58:35 -0800 (PST)
Date: Thu, 26 Feb 2026 04:58:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a0437b.a00a0220.21906d.00e6.GAE@google.com>
Subject: [syzbot] Monthly hams report (Feb 2026)
From: syzbot <syzbot+liste72a2905ed88c1b0dc99@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-261340-lists,netdev=lfdr.de,liste72a2905ed88c1b0dc99];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email]
X-Rspamd-Queue-Id: 602BF1A6083
X-Rspamd-Action: no action

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 2 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 46 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13802   Yes   possible deadlock in nr_rt_device_down (3)
                   https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2>  6378    Yes   possible deadlock in nr_rt_ioctl (2)
                   https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<3>  2258    Yes   WARNING: ODEBUG bug in handle_softirqs
                   https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
<4>  1878    Yes   general protection fault in rose_transmit_link (4)
                   https://syzkaller.appspot.com/bug?extid=d00f90e0af54102fb271
<5>  1005    Yes   possible deadlock in nr_remove_neigh (2)
                   https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<6>  162     Yes   possible deadlock in nr_del_node (2)
                   https://syzkaller.appspot.com/bug?extid=6eb7834837cf6a8db75b
<7>  24      Yes   WARNING: refcount bug in ax25_setsockopt
                   https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015
<8>  23      Yes   KASAN: slab-use-after-free Read in nr_rt_ioctl
                   https://syzkaller.appspot.com/bug?extid=df52f4216bf7b4d768e7
<9>  10      Yes   KASAN: slab-use-after-free Read in ax25_find_cb
                   https://syzkaller.appspot.com/bug?extid=caa052a0958a9146870d
<10> 6       No    KASAN: slab-use-after-free Read in rose_t0timer_expiry
                   https://syzkaller.appspot.com/bug?extid=44cccec2c6a4501f6a45

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

