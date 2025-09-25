Return-Path: <netdev+bounces-226450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E515BA0866
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA771890DDD
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700312FFFBE;
	Thu, 25 Sep 2025 16:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34442E2DDE
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816086; cv=none; b=d9OpmAJVjsbFQRzCw23TiYx+oWGA6R5fCz9/gA+4L6/ismuNhgDES2HOstLAGi3+6A6O16CMHlMj5z/5IgI3Qu84JacTy0Shx/5+KVIVIe54W7S9WQD9hLkPKpBgfKQEgTneQIavoFLVZXGiu+UOU6SEM/eY2Q7TJwdVm7QKvUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816086; c=relaxed/simple;
	bh=vDNDhXb51t11ecjweGcxO6tZH7hRi/SsZUkwnb+CTOo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C2r4idiBS5xAdOGBB6qVz+cc2xT/jnvq50b06u+yGrtp2wkg7V1EDUEyihy6njJ0Vhra5CXcO1FSzoPxXKI7QzUFwi3//V9Wity9fXZHyHgvQY6Wl9WVbNfw4aN4hjtnbFNWuS+qWVb6T9zLwTCAw1zp+I4srgZt5MKICSiePOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-424c8578d40so13568025ab.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816084; x=1759420884;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wC9eoNmxGFzwBPKZvnASVvExWPvQq7FONJl+BGjmkSM=;
        b=fRyp7Lg0D6Hffmym2dMESnyI9v7YzDMfQSe/jXEf6Qk841VhEJf9gDzKYaw/3FVT5T
         34nSAP94vKwbw1xK3qOVej342tQ9DPOhhOdegE5d2iMVebFRMZ/+wm6qs3d+SrsEs3ew
         +kAucu865b3viYHIY3qq8EzB/NbNG/aIC2Y2uLBUeBdXnJ9B/Jnks5yUTPjTzSqf6SuT
         DTB1u0zEFQUoc5AmsRRAXgldA0Nf9NyhgNoZnqoRhmYHi3YdlQxc61T/De+5FF9+0lrx
         oZM9bnplkdWISu1aSOQO0el8p9dRNFlX9g0I4bbP/pQVxOk7qiipcQWeFFm1p1JWtbSi
         LTzg==
X-Forwarded-Encrypted: i=1; AJvYcCX5zJNJ4bO7WBmvD30uHa6XGNHImhLEX10Unuxp25zYoM5TsIA8FdlL99XGqfNrLqb6rVbhb0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLbhGEtZRKZYxV19lUCofIFSreGBdzE5F/4omd+RRIImxgxip
	/adtvkUKDDYPd3Y71gRpizhMcGxhcJPmCVgn8ZlP5mvaBB90DRup+83NlBNA/EGYwvXWn49BRav
	y6zP2WPJh1Gp8Y7QzePCaAArk5Ak5NS8a9joZYbMm6IzXYI7XUc07F9FVRd0=
X-Google-Smtp-Source: AGHT+IFqidjahOsPHralLRd7agu4VD0AO4qJ7WVMC7UNgEJhzK16ZgAQFMxVKpXj9sskRWloeV0Mr+kSq5E0JX/l2uo03MoXq8KU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c91:b0:424:8b66:fbdc with SMTP id
 e9e14a558f8ab-425956509d3mr46700845ab.28.1758816083860; Thu, 25 Sep 2025
 09:01:23 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:01:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d56753.050a0220.3a612a.000d.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Sep 2025)
From: syzbot <syzbot+list7a42d00aaa51d0121b8c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 1 new issues were detected and 0 were fixed.
In total, 56 issues are still open and 168 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  15578   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10293   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  6859    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  1291    No    WARNING in drv_unassign_vif_chanctx (3)
                   https://syzkaller.appspot.com/bug?extid=6506f7abde798179ecc4
<5>  1221    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  842     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<7>  734     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<8>  595     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<9>  564     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 477     No    WARNING in ieee80211_request_ibss_scan
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

