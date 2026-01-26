Return-Path: <netdev+bounces-253348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGcuEv0Td2mHbwEAu9opvQ
	(envelope-from <netdev+bounces-253348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:13:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC58F84B48
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70C45300EA9E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5E29293D;
	Mon, 26 Jan 2026 07:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91F28C2A1
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411548; cv=none; b=aV91Ka5NrSgCNV7lfyj9dGGwgGm2TWDEruVZ+U9WEBORU2Ju88vQ+VqMJYadFzJAFcED5pjwxrOS4GtJi0PwyM6CTOZQC4MUmt4gOS2fRQvVIhT13CRpHbH1cqfbTL+KvcVtNiguJJL3K8vHxgFLY/OTl+b2RPPL6b1akUEcKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411548; c=relaxed/simple;
	bh=b3PwR7PZHDFl7bFHeYlMJtw+smhcSG6Fx0pXGqGjQOA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ibnApJu//4cVvXINihyT2EeqrNwgCldPp7RTbXrGxVbmcU8CjJ0gzUFVLJt5ElC/d5EdGrxJ6V4vqgMIFs0h/ACR0RbRAbUR2s0Yo+Op58itcnbjNkd0gPbnqpwDVfHLbqFPTAkAg23pSGDP7ZZMh9Iq+isPpIAZC5CjPXR1VDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-662c9283404so11076777eaf.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 23:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769411546; x=1770016346;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6dMLiRQAKLWaXNSJ9qzlzVwL/ShJ+BkMJnyUWmKp5Y=;
        b=oX7OZmwBV0Qi4gDpdnnVddqLuAMadKVlR5flT0rxQUKZ+uaVP0/vkY3Etxb+kDKAAb
         Zs5+aTq83B1d8Zif7G9rt5MTkMzo3tSRnTwVK08WGubT6TUjohpgehYcuUvuHs1qK2Fv
         jNeS9tpjOF24x1HSHM8KostMSet1pp5oGXAMSezzdXNcR/UkwPFhwrD9KCjumwkzu6lv
         13lXcXtuX9sPS21Mbd3A57qigXNY5yKS1ZtskvU2HkrbFLOPjpllnQnuax4hXbekKSI/
         O+7OJ4bvPoyK6kjR0GkFSRIvyt6pUXudFwKiXjv2Mrp5KJxtFpXvu/LKSJF3jq32DiOM
         29TA==
X-Forwarded-Encrypted: i=1; AJvYcCX0KNf+4cQg0czsX6GJXJhfGQMNKK/PwK1fBawLsbPvbrT8Tfh3/xvwK5LK+lHIPR1cXEt5F0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTc6m/0E2WsXjzRnGw5H6AC1mEPXfft/hkXR+UdgzLi5vmntd
	OTukh3eBD0hM/KGirJuayZJo6WIAlBl72WYuJTe6cArHAW5YJTDZ+E3QTJtLk+P3OfW9NSMgvS5
	8bK3LRPa1LW/h+E4+JVz4w2/JomZW7Pv7udPeBOg0XYv/70YWUaE5IcZrFyM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:985:b0:65f:cda0:e00d with SMTP id
 006d021491bc7-662e0a2ad14mr1722709eaf.17.1769411545834; Sun, 25 Jan 2026
 23:12:25 -0800 (PST)
Date: Sun, 25 Jan 2026 23:12:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697713d9.050a0220.226181.0018.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Jan 2026)
From: syzbot <syzbot+list7f6cf3fce3443642c016@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253348-lists,netdev=lfdr.de,list7f6cf3fce3443642c016];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,bootlin.com,datenfreihafen.org,googlegroups.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,syzkaller.appspot.com:url,goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC58F84B48
X-Rspamd-Action: no action

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 374     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 346     Yes   WARNING in lowpan_xmit (2)
                  https://syzkaller.appspot.com/bug?extid=5b74e0e96f12e3728ec8
<3> 43      Yes   KMSAN: kernel-infoleak in move_addr_to_user (7)
                  https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
<4> 19      Yes   WARNING in cfg802154_switch_netns (3)
                  https://syzkaller.appspot.com/bug?extid=bd5829ba3619f08e2341

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

