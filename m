Return-Path: <netdev+bounces-282483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I6gAwZr8mkMrAEAu9opvQ
	(envelope-from <netdev+bounces-282483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:33:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A430F49A2A5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F07305808B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7943939AC;
	Wed, 29 Apr 2026 20:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6429B781
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494759; cv=none; b=CpDsiukwllPoDV1SYzZGA5gMirokoVBZuMs/MUxVLkV1AGmK4j62NM/PyzqiAqqULZZBv5AtmNni+J4MwwQ642SArA3YrF+zFQGm/TGWIVhgtdV4pISQZ1/yNusx0mOXjbhHaB6rzkJBBRyTmox1pOkielL7vb37SN0U25crYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494759; c=relaxed/simple;
	bh=kyDam3w5LTuUUMJlNUNEC+4wSMr9edfUCp37kx3oR/8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jfvaD9NE9SzoYuioN33fRrQAvadI6w/qucZaYzYQkBXETlt6YLU20IUQZr4GqQ6sZEAVyn6t2/Uv7S6l4eMdMBNaijup/3YmMR5UfPzdXfskdAmWj7jZyApuO16UpET57UtAvgWX1+9kxH9Ic7mrsjDB9wEowQiRHz2nK3DycKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dbbb806e10so603289a34.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777494757; x=1778099557;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1mJTmE2rQEg/vhqk5b7ffjI2+vmg/PVDr1JbkSZPfE=;
        b=PuGylv1fJelmXjVvISJSX8/AnPrhpZOfDeURgEz3kRWvUgdloyQQ1Rhawh6b6038VO
         kyLAdS8hCm9QcfKg/+1o0CuI4s65Yj89sEJBtjFbiAuxAVJXNY8PVT4Hr7+Oc9uKcUe6
         AvGVBdIqCBYKVbfKjtobUiCUlk+Rf/0dFnr/IUoJm8q2i+4KsOYkwOIKjS/nN/SO7q2m
         O4Mq47kMjNrUqUDdY7mYnx3X9NZ/YhYOcz/7/L4xtr7WNGpPPFc7+CWGQJ1QaRoypjly
         hrxYUz7G/0nduS1VF6v/dURRM/t/OvXhMuPcS5fSEaE8MDOOlmKWIqx4wdLtmvoW1dI5
         43FA==
X-Forwarded-Encrypted: i=1; AFNElJ+CsAVuovc4IwdRyVGP71K/x6JpgI+bSrnlyxCSPnRZiwY/VFq3q0gt0yne4b7q/YvKgZ7mcNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ZuVuN4mKITq09CsL7KmbVrIXrfZW8XETEZMJdAZ/jll1nJnk
	sah0MMjkU5xI9ffBMgf2cz9BMVALntbHzjr4imqXBL6g5qk/Kvvvo7DSG9xwXzK7oDeCTUwWEUC
	5+7EvGvIWcj0mODBiPnzW+OQH15oO2/tl/dL8/zdAMlSggogD1N3Ktsba/2Y=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:edce:0:b0:694:a30f:a6d6 with SMTP id
 006d021491bc7-6967a521914mr103838eaf.25.1777494757384; Wed, 29 Apr 2026
 13:32:37 -0700 (PDT)
Date: Wed, 29 Apr 2026 13:32:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f26ae5.170a0220.3c4978.000a.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Apr 2026)
From: syzbot <syzbot+liste5400145e66cca787805@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A430F49A2A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	REDIRECTOR_URL(0.00)[goo.gl];
	NEURAL_HAM(-0.00)[-0.975];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282483-lists,netdev=lfdr.de,liste5400145e66cca787805];
	RCPT_COUNT_FIVE(0.00)[6]

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 196 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5008    Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<2> 333     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 127     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<4> 73      No    INFO: task hung in nfnetlink_rcv_msg (5)
                  https://syzkaller.appspot.com/bug?extid=c4b20b80ee6a7a2f5012
<5> 11      Yes   KMSAN: uninit-value in ip6table_mangle_hook (3)
                  https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

