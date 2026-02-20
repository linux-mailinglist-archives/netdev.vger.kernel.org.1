Return-Path: <netdev+bounces-259655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODf6BA4OmGlF/gIAu9opvQ
	(envelope-from <netdev+bounces-259655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:32:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0BC1654E8
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E056301FD4B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D5331A78;
	Fri, 20 Feb 2026 07:32:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438D32B98A
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771572745; cv=none; b=kBJ3enTHg9pECnk+lyJne3EyHcZfL9JWrGuB0RBxsbblI/08oLvKIzk0qfUGMaK7JvZtQjdlpqxOU+9vC+p1kho5E5khB6VSUnrQm8xXsWyEMAIbVtcfOVMs0N3TCsec0uXHpjbSPvenQjk5+jeWjkzoL+XwUyrPtv4v2mxYRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771572745; c=relaxed/simple;
	bh=12Px9gc47YmXX9jUolLJQw4rp3ppH8oY2E82F9mWc4k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aDYJ9nPdExrQrQpKSJRvdvVAXUI9oAo5Rp8qC1+mRE5IBOHnpGUiijtUGsS+lk/sHHrdk8DFsG3jpn+ve3SY1FgZUznuZHWoMXyaUsMuWbboo8WMDw3gMnguVSLLUwxRnjKNlwlsGPwB8jn8V6VwZl8fs9BFtSJSuxItg33PaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-66b47c7a795so14901268eaf.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 23:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771572743; x=1772177543;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWS5jKRBN8Jkaw6lYBMZ7WrSHvKNHSRiqBchKUn6Ip8=;
        b=Efyrp4Wk4u/wtevl0ELw0MzcfhXAttqPUVxEJqI4uhAv2xDLdZUHTGCmydfYC5hmHX
         +fwmNsHiDHmv8oS56mONh8NVIhMvAn3zts34xYmkrcdkEeEz9mFeYj2R+JjJQ5jsU6pw
         l03rBfR76JBzNPo+6bJndWiOYEGugGHQNd8iI+vGFpQic5pu/jvDFaeJdB8EzoS3zzQ2
         wkmVH1qse7bfIGJTsmS9rzowLQwqpxekRZ7bjZUHbygUXTl0eor2i+EbdVTFZI/CUmTd
         f7gJOtXmugYqa47FOiwOJmKU4eFlgoi+0BX408yDEL8iFeyKU7SnoyCN+xcLQyQ2TchB
         rpYA==
X-Forwarded-Encrypted: i=1; AJvYcCWCLxvZAEPlj3NM5itBdoCkFssRBnROqG1bFHiQ63V1HIBqT7ff6omCqEIHcH0ansNH9Xz7JfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7aGbfHXMWBtpFaw5KyCeki4ILE3KA2RQaVnxm6XTB3XFriFQ5
	ccsa5bzFbtNPWpByCw0iulL1d9XouMHxGr6Vd3S8RKEM4lXiXjI981o2/galoJ2nMeyh2qLOJw3
	AC8Yl2dIlmwn9xxekGaE3vqiSEGY4qNq9GlwyWi+RmunZlREMYiqUr3bXZnE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ac5:b0:662:ffc5:cec9 with SMTP id
 006d021491bc7-679bd304bd0mr479737eaf.40.1771572743061; Thu, 19 Feb 2026
 23:32:23 -0800 (PST)
Date: Thu, 19 Feb 2026 23:32:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69980e07.050a0220.21cd75.01b8.GAE@google.com>
Subject: [syzbot] Monthly tipc report (Feb 2026)
From: syzbot <syzbot+list03bbbf1a526b820eedf1@syzkaller.appspotmail.com>
To: jmaloy@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
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
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259655-lists,netdev=lfdr.de,list03bbbf1a526b820eedf1];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E0BC1654E8
X-Rspamd-Action: no action

Hello tipc maintainers/developers,

This is a 31-day syzbot report for the tipc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/tipc

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 87 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 793     Yes   INFO: rcu detected stall in corrupted (4)
                  https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<2> 116     Yes   BUG: soft lockup in do_sock_setsockopt
                  https://syzkaller.appspot.com/bug?extid=10a41dc44eef71aa9450
<3> 103     No    INFO: rcu detected stall in sys_sendmmsg (7)
                  https://syzkaller.appspot.com/bug?extid=53e660acb94e444b9d63
<4> 47      Yes   INFO: rcu detected stall in sock_close (5)
                  https://syzkaller.appspot.com/bug?extid=9a29e1dba699b6f46a03
<5> 32      Yes   KMSAN: uninit-value in tipc_rcv (2)
                  https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

