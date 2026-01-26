Return-Path: <netdev+bounces-253347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BDqNOETd2mHbwEAu9opvQ
	(envelope-from <netdev+bounces-253347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:12:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA8684B05
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6894230063B3
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333C28CF6F;
	Mon, 26 Jan 2026 07:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4828A3FA
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411547; cv=none; b=eNL4IIp7pBWsLcikA+otbMbUGM6jHr8/BBNPP7gFevCOCHgly1j8baIhPYicg8f6sb9be+cZqIj6C4NV40ym3DLtNNwU9sEKgtBWCY5U8cxWHJHSR+PVk/3ZY5bWAZmDLTXGkL7hbJleg7ppod5XdUzQWvY1qMhTvUO6iwpUYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411547; c=relaxed/simple;
	bh=PjsVMfjbLC5Wb0ZXf8CFrN8ulOiy7e1Dsx2e/V/Mlxg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o73XSK5N0DJ5c/8XhpK7vBPaQA0AJxfjMhb3k3e0uGst6xzk046EZGcVeHmAZ6Nx0TLshowYeOBeVysbMMtqO5CQYajmcKwHg/w0rmtzI4zi+ITb4EljpKI6qIaWCIvwXFNa0OXQPYDORnpAXG9dHYfqCIgzysyePHmedqEFmaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66109baed42so7517970eaf.3
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 23:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769411545; x=1770016345;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I62FiAaoX1ZRn8SEMhGaCp3g9ETXeKHjTK2Ke6OkaLc=;
        b=YGEXZVsSMK7awM5+PpvdlQ0w4BKBmbIEeTMWEITmP9zeq5w4BChCNnpj8OMqjpv9bn
         k1/TtLh8lkpjuS/x34UiLDThpo6n+UTMELRfGZUVbuTW5Q7n6PrK5bQwTlesnONBu2M8
         vmtJYx9WN6//fGdmukL+3Ct/UmTM9rnYSS+DGomEITIuXrG+P+NPc8rXrkcj/8EnvXY3
         Y64jacROSn5mrF17bfAL0YKbeCnM3FPtmDS9n87SMuy7L5AGo5b7egE6ow8zk9q60FH7
         diCR6+/+HHQNTlyMwnLVp0NVgBmlrLdVPCAgv4ieUIb3U1OuArAyWRFjx1E5laJtBkLG
         RAeA==
X-Forwarded-Encrypted: i=1; AJvYcCUzYecz2gq/nYTx0KYKBpY99X3yn3C/PL7Lzqph1CTDXuAUMqHzbd57DT2dFoCE5/cCfvZm9nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwndQFDmX3jzTxlK39hfyw4o1W9ASzwW1NyRVsMoPzJj4ahDEyQ
	B/59LcKe5lYAboWxLOjlRa5AVAxS4iI/wsABoCfnRFdHYNga5PqpGQ5HKZA+iMbYucZ+7nqfbdL
	z+ia+JaXQX+BBC+O8n8vf67N5XS3eWWWeqS08ZWmrROL+ely1MvHY84Nd9H0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2224:b0:65f:64eb:8ff5 with SMTP id
 006d021491bc7-662e04baf7fmr1575491eaf.81.1769411545223; Sun, 25 Jan 2026
 23:12:25 -0800 (PST)
Date: Sun, 25 Jan 2026 23:12:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697713d9.050a0220.226181.0015.GAE@google.com>
Subject: [syzbot] Monthly hams report (Jan 2026)
From: syzbot <syzbot+list35a4df8741cb3bcd553c@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-253347-lists,netdev=lfdr.de,list35a4df8741cb3bcd553c];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AA8684B05
X-Rspamd-Action: no action

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 1 were fixed.
In total, 16 issues are still open and 46 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  12422   Yes   possible deadlock in nr_rt_device_down (3)
                   https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2>  5206    Yes   possible deadlock in nr_rt_ioctl (2)
                   https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<3>  1784    Yes   general protection fault in rose_transmit_link (4)
                   https://syzkaller.appspot.com/bug?extid=d00f90e0af54102fb271
<4>  1634    Yes   WARNING: ODEBUG bug in handle_softirqs
                   https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
<5>  985     Yes   possible deadlock in nr_remove_neigh (2)
                   https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<6>  513     No    WARNING: ODEBUG bug in __run_timers (3)
                   https://syzkaller.appspot.com/bug?extid=7287222a6d88bdb559a7
<7>  128     Yes   possible deadlock in nr_del_node (2)
                   https://syzkaller.appspot.com/bug?extid=6eb7834837cf6a8db75b
<8>  24      No    KASAN: slab-use-after-free Write in rose_send_frame
                   https://syzkaller.appspot.com/bug?extid=9cc08d5dcb1fc8feee76
<9>  21      Yes   WARNING: refcount bug in ax25_setsockopt
                   https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015
<10> 7       Yes   KASAN: slab-use-after-free Read in ax25_find_cb
                   https://syzkaller.appspot.com/bug?extid=caa052a0958a9146870d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

