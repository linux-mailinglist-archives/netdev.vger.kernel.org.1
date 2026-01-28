Return-Path: <netdev+bounces-254489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKWOGqSQemn77wEAu9opvQ
	(envelope-from <netdev+bounces-254489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1597A9B37
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB385307C334
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1D2346768;
	Wed, 28 Jan 2026 22:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C2343D64
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639979; cv=none; b=SWZsWMOtoVD9lD8oKU4PF5B5wAtmGC694au3oL6ubzp8oKAlVGkJ5XFZWhzvZow60vzld9hx9QD6RdLSki+7hnfwEWhsyORAPz/2z6TkZ0NEEmvPx1L/LN8Sdq2tr6CLLc1tqLZ8/xg7woTF0dSfSvG+nSIACMp/wwRgxzaBnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639979; c=relaxed/simple;
	bh=L7LMowbbFe74UE736M0mXofgeYBJ75YSZFR7RyVsQPk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CTEtQhyyUxxevjTYCfXbT8ZA/BkpjqpMb2mzezLMIH3BV8SX/jo7k6Vj1BPKoXak3FpuXJUj7pY/uVbUh5RDK1WheJ/pLH98KeNNxO2cwOmWqDkJzrPNo3E9cpMUay2tkl99eyl2nUDxTwAPH/JJc7kvipZPuc9JACBnFAUZRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-65f30d38617so1066345eaf.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639977; x=1770244777;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHLvlDBwy9U71exMZeCWgguqy+MJQInJDJn0tuli10E=;
        b=PVcZhaucsq0Av68ePQVsS3zZlacd1izhUU/QdGXs76QxuasCbRJzapS4qezJ3Uefwp
         uWraJy9hhXPnTlH4AkKDxht16PYXgdc18NnIyHl1dg02ppQX7dI21k2tuz2iovb5dYjt
         ymq2sn9WdIvlhNV0TyScSxi8qdKMa1ZHq9cs04erBo26E6yroyKCYIq1a5x8uwRjeFfR
         RuyotLOoEACZSz21qBkUBVXbgJeMMg8TfK+Q8AQ+c/W4RJNU7oYdQ7ow7qhrqUqYfM4M
         /sajS8asBiKQtLNfWzjUBPKRdcUbRiz9d88PtOwoFPPJlJv8MnVIeO/JJ/1nz+3IGzLG
         nMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDoNKi0IOStCjrCUWclLkohb3F+OzG7PF7LOOxx1FD2yOT6UJ0oU8Xx4VQlDO022ng47KwjX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhz/IY4SIA1Jv9qcq4RmkBVCgWTvxfmPJLU4hCuJsUHMUSrOPr
	jEGTk7qE4c/FflhH9C2iQJVQlTOXmNOlKvkj7TeUFpgY7qOKO5kodUKXhKbrUw60IH58RA2rxl2
	pPhAbwfK8D24ziFHe3sFx6BCGv08pSlBwjLvQcQBVk/5DP6bg7juF39MCi/c=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4888:b0:65f:70b5:1a89 with SMTP id
 006d021491bc7-662f20b3034mr3350391eaf.49.1769639976817; Wed, 28 Jan 2026
 14:39:36 -0800 (PST)
Date: Wed, 28 Jan 2026 14:39:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697a9028.a70a0220.9914.000e.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jan 2026)
From: syzbot <syzbot+list6aea27ca2eabd5fa9140@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
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
	TAGGED_RCPT(0.00)[netdev];
	REDIRECTOR_URL(0.00)[goo.gl];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254489-lists,netdev=lfdr.de,list6aea27ca2eabd5fa9140];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: C1597A9B37
X-Rspamd-Action: no action

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 56 issues are still open and 171 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  25396   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10510   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  7244    No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<4>  6921    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  2111    Yes   WARNING in __alloc_workqueue
                   https://syzkaller.appspot.com/bug?extid=392a2c3f461094707435
<6>  1226    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  1026    Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<8>  842     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<9>  750     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 648     No    WARNING in ieee80211_tx_h_rate_ctrl
                   https://syzkaller.appspot.com/bug?extid=0d516b33238bd97ee864

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

