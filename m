Return-Path: <netdev+bounces-269665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAAwE6VsvGkPygIAu9opvQ
	(envelope-from <netdev+bounces-269665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:37:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BD2D2BDB
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B5573047AE5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EDF3EF671;
	Thu, 19 Mar 2026 21:35:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E8221FBD
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956123; cv=none; b=l8Ah1N2CxOOUSce672gd0aK+kMqoAFj8kDlTACK89BLXekpn7Xo5so65xLzSVAjZ0Ht6AQjWqh1LxurvEnU5495Hh7m0Rja9cE7O1xIOQjBNv6pdQIt1LKhX1aeDlWHN+3pgu2pTkjR1irjmZAwMhhC3K0bp6TmjB3/6QRc72iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956123; c=relaxed/simple;
	bh=tWqVrtM0+4Vs70ubYKL4zkcuMvCEW1rftX5RnkS5hjA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WjtlZh2jy3ZrH1aYfTQHGxaiqTCEaDNEbRpY6hZldIHmcdsu3tQ2PWJFjuHYLHWBnbLODWDq2q6mpek1K97phti01Y7URWwTwq15fGqAxjTxHjX7w5ah6/+Tg79iJ1c05sW2RwALEomzXjcma27aQLyfhKW5Pmh1F25ob6K4vDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-41c02dec5c1so7885333fac.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773956121; x=1774560921;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kW5Cqd4AXaqbTURFAM4xTX11VPZxMsl0NOSLCzZeb8=;
        b=B+YQklS7k/Q617wVhgtQ9SpspagQ/OiwajtnvwhxlFDXauG50zka+GWZ+tssXNCWn6
         4+neoqdfVTewceH5woBTtzLQNMk/Dirtk5PsKIZkPHB3ql8fNnnw7Pf9kB/V+qg08hgg
         595cOWWVOQN6cKX1EW352mtFH86BRXESECFJ+DNLuDVaz5TXhdYpvoM5drZrd8IytkTY
         QsGPSp6PNEVUgu22n0sJYonP/A1MgtDaGtHz585lA9aKKA202YTltb1fIOoCdlYsJs8J
         A8S6bKrxIeGXcZ7a0pRFqhnH8xgzfIDnI7DCjMCA9M3rH9/s94peKB+Fc1bIALcF9yfj
         zQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUaZU/iAH8BXqnW9nhrUWJDgQ9jl6XzGic0VCy+LP2etGrMnm2wanua4SfdBYdALaXOXaz7ccA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8O+fKp6ZqN1JozK2slmnYRWzB3moRuu5MnM/24q3NCHeCfq6d
	tdrrq/SzeTYoxeFRXS9aO45Qq9V/UEx21F5zoM4T8+QPTHMGHHnIpbbL5GN/a+vpT60s2qTKNr8
	sw4up7DPUvIH3ylzoRiSYqJo2A7LlEP+mUNsOWeuUfs4Oh8MDsJIyl69e+Gw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2f12:b0:67c:25b9:d366 with SMTP id
 006d021491bc7-67c25b9db1emr31379eaf.42.1773956121616; Thu, 19 Mar 2026
 14:35:21 -0700 (PDT)
Date: Thu, 19 Mar 2026 14:35:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bc6c19.050a0220.3bf4de.0000.GAE@google.com>
Subject: [syzbot] Monthly wireguard report (Mar 2026)
From: syzbot <syzbot+listb2717bb6410baba389f7@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269665-lists,netdev=lfdr.de,listb2717bb6410baba389f7];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_SPAM(0.00)[0.031];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email]
X-Rspamd-Queue-Id: 9F8BD2D2BDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 20 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 787     No    INFO: task hung in netdev_run_todo (4)
                  https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<2> 391     Yes   INFO: task hung in wg_netns_pre_exit (5)
                  https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
<3> 1       No    KCSAN: data-race in wg_expired_retransmit_handshake / wg_packet_send_queued_handshake_initiation (4)
                  https://syzkaller.appspot.com/bug?extid=4ca9a7b9d61b76d0177c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

