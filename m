Return-Path: <netdev+bounces-261342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE3tCiZEoGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:01:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A0E1A6040
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CFC33034E0C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55CE2DB7AA;
	Thu, 26 Feb 2026 12:59:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D002DAFB9
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110761; cv=none; b=DtdTyGXux2vL9F5XRQBwBDGvgKcMgxuwFqWcM1rnTmWtE3OEyd09Pb2niBFQMKVFrQo89k4ISWltvxqAIIwVbpW0MgI5NLHCVhGF6t4qwv+lNA4HLB0TzdV5Kh7MVsANsmqBlNbE3LVnUAyqnM6C1r4lFtQmKD+xw012utKpjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110761; c=relaxed/simple;
	bh=six8rnEJiQPYWzcQX1THF1cLIU6oDaq+bzhspJ/Nb5o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gdxISyCwbtc65ujidfGZHC/QtDCRwIjdlKRGKcM4Q9EpNonClWUKC2NDRwVRajPOD6VaFrs4dum4OfAnTn1Gh+gttTtcW1kIm/rUaG8/OvCz8LQoM4kaWPTC3KAN4hJ68iT+xTtH6bFkebsJDwrQOX2sj9f5P3s5/Ut8uJl24tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d1950b48f3so3554507a34.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110759; x=1772715559;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDdEeTN4Szojn/rjG8dW2fuRWLH4QpxpS/wKHni5q4o=;
        b=v/459tRdOL0ffTrbLvN6ODgpFcGZM+i5JZOBDNLl+CQuWfbl8MjWjr3xzYe1m23DeA
         s9t+QRTRfpDP/78UtZoXlUgovedpSlg1h6pZVezXDeP2C3vR596OEL8io/biKIHYpIgI
         GQxCUvDhUBdxMvM6rPHbbJ1mJFg3jdsPWXDtgiy3yo90AFsy+YHR060OWIK5zxwN7ndK
         dSQNBEConl5Yyf9DgHbOE2MfdYwmOQAVvFaD1t7m5p/7s8VOuxF9wABQxLYeA2FLoMx5
         82ekYMfnhpX6scn7DsC97ELS6lJDIRTn+J4igIXiZzYUYdd61SFVHK7nmEST8hTQS4IM
         bI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3hwQzrYdyQzIuaweg+dbh0JffwWKQ2bgX4XHNYfvp8jjMXOh854bVX9iRwu72oxyyHNXex0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnxRtsi71ht6/mqfSZcSh24tsx4xqHcjJ+Fwe0peOqW4IesQmg
	1YQ02oOtxUfAk8AbZG48IJNuhC/ErqaCJ8febdnJJyVl0HwAM/Ffw/UkbkGCeNMO/wiEqkq3gXX
	NZM0GRmO+COspXcO7WpZ/ahRJrTpPUsuTuvhVovRT/Dd4V8CiYO4vSRS5pX8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1391:b0:679:e9c1:a91b with SMTP id
 006d021491bc7-679f3d0378fmr1014279eaf.22.1772110759502; Thu, 26 Feb 2026
 04:59:19 -0800 (PST)
Date: Thu, 26 Feb 2026 04:59:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a043a7.050a0220.2fcbed.0009.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Feb 2026)
From: syzbot <syzbot+list29614c14e531b35da2e2@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261342-lists,netdev=lfdr.de,list29614c14e531b35da2e2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,bootlin.com,datenfreihafen.org,googlegroups.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,goo.gl:url]
X-Rspamd-Queue-Id: 26A0E1A6040
X-Rspamd-Action: no action

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 398     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 347     Yes   WARNING in lowpan_xmit (2)
                  https://syzkaller.appspot.com/bug?extid=5b74e0e96f12e3728ec8
<3> 43      Yes   KMSAN: kernel-infoleak in move_addr_to_user (7)
                  https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

