Return-Path: <netdev+bounces-193203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC84AC2EB6
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623F84A694A
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58991A08DB;
	Sat, 24 May 2025 10:04:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7C199FAB
	for <netdev@vger.kernel.org>; Sat, 24 May 2025 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748081076; cv=none; b=cVeyFB2IIRmFhUeP2YmF0FmpBQtV/KXfH+5C0CSniAs1zxZEErLRBOzwfdSb0M9edjqs11ZSKupSWJt4aRep5wL4UbQpqJnX+2fGMAhMtvnrznk7LYuufGscLoBYnWYtnj1iqRX4A7RCD8h6/kirjhXAmYPqari3XWB3sieEHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748081076; c=relaxed/simple;
	bh=e5FAItjOUVgu208JXZ6Q6IRZJFER/+U3nwpQKrSjQls=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T5D22EdKgUxt3dLggTiQ73N484e6zyHyF98pa9MfCbNQL4WUNfDmHR2qaRvN8upoRKfPsiYI5HLQ3XqtXhn5ee/EnscqdDrmMUbHsS6OPpPCHcrwiF3xkDCF/ozImbNJyk3HxeFCrehOMzGqdFe8TisQ7v+nKnPt2VgVhX37PyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e6b977ef2so104783139f.2
        for <netdev@vger.kernel.org>; Sat, 24 May 2025 03:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748081074; x=1748685874;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/oazIG9eIkKX1kLYtUBakGdZ2zpECZekm+C1pvoXJs=;
        b=B+0RMAaY79YdEKtgbeojYP/PkReWYYFZoBmxJr/wFqo4BYg8MNkwPgbj6gYnfEo+Fm
         rbXj54+oybgzAE+VnP3v5e5wJjUrd+HKFEM0e521V0KGjZWQM+YEknYKaABzeV8TrNX1
         51uicEZp2JQuiHpk0ekd9s2QmLPLAqyO3VFk6ALacq7JTZ3fo4aJH43HO6FU1bvHR8Q6
         jSkMKfCal5EJ9tiP9LJzw8BPdAi1ZgsrW6rXUjaKwVwCgtI9Hr5muQ/TC1TklymlHdKr
         tK2Jd15aPbyc0X4l9qpcrMXhXO8gz8MXpcYBCnip6qjjx6zMMRklra0v2sOmzhAoQX+k
         KuTA==
X-Forwarded-Encrypted: i=1; AJvYcCXZoSo99IbmuR5FGSu9H51y8mtVg4QIznKseguF9seutyDjk53ZPIh7VAWJSRtzHRLGIAoPzbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp6B9rUuZ9a74V1CgdqT0dgR+TNnyQ9SAqBbENy9n0WFEA/wBA
	Ed5sI4mXnY6axq1KR0Sr2QDCNUth5fhUggdjeUNHtViY2GSVAp1xPMzlSMUp9MB9DgYj44uy6+S
	FP2CE+v/aYl00CMe5FTgoXZbvG97TchWCYni5e44J5ac/bT2jBRqfBdtbZL0=
X-Google-Smtp-Source: AGHT+IHOMdPgdyMGDK6iaWwUFwI9jfCGRXgY/C/cohoWm3k23D8JclT3N2bpn6wT+HcDRh7YFR1xqy4KhpuGz/LeBypl8a9wzlnr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:389a:b0:85d:b7a3:b84d with SMTP id
 ca18e2360f4ac-86cbb8bee3emr210592539f.13.1748081074230; Sat, 24 May 2025
 03:04:34 -0700 (PDT)
Date: Sat, 24 May 2025 03:04:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683199b2.a70a0220.29d4a0.07f5.GAE@google.com>
Subject: [syzbot] Monthly wireless report (May 2025)
From: syzbot <syzbot+list1fcea8bbcf300c57bf70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 1 were fixed.
In total, 55 issues are still open and 158 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  127535  Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  10768   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<3>  8142    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<4>  6632    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1208    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  1129    Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<7>  567     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<8>  511     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<9>  500     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<10> 427     No    WARNING in ieee80211_request_ibss_scan
                   https://syzkaller.appspot.com/bug?extid=1634c5399e29d8b66789

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

