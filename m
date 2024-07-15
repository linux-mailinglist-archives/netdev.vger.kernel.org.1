Return-Path: <netdev+bounces-111470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE693137C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176AAB2346D
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C5C18C165;
	Mon, 15 Jul 2024 11:52:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D918A94C
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044346; cv=none; b=h2chdXr7nc9AKssUdQdlCWgAbQea47jQgfX9a6GwBOHfaskmaGL/Oc7ImwB+4gz8S/IDheTpOjMNbLEgzIJNMq4JWL/rK7ALE4I220dsE/f4m44t4Em70QCzArWjKg04erHVNhpnNtQjHP/ijk57ddDVmewn5vmgId5taI+cxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044346; c=relaxed/simple;
	bh=t4pDWDgmRHlWKFeqXPZa/lEDpSFjluOZxYF9jV+3PgY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PMGpnE0sjPfYmVszqWx5aariUmIBb77N7cIT423Mw/6PSXFkHJWEDgyTfF/TJNsFVsBZPrd9JS+4kNGwHOzFOM81pn8bsC2b5hp2eK5wAQ0H3jAn1cj5MgUxHX9Fi/51VkOU4nc/EUXrTt5I/8r55V/e58sK4OAkr0sRhQumsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f12ee1959cso509649839f.1
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 04:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721044344; x=1721649144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lllYPE4GPyNqsW1MAxUY+CN0ZVo9aIg8GROzQIAinyo=;
        b=fQfQDpcot2+dLvry/uu57ZIjW0MNo9mw2nYMXKievqGUhkYS8mU/Bqz2jYP7O+EPpU
         g3INFlIBgHWgQIAFQqPKGNOH+IHf4+44HNvfyL6GTLFMZHgp6OI3x+Lw5KmPuZSI1EV1
         3BVcnZbVspVP1nJ+pvj8BSf6Rh94bHuDsKG6KKesTI0wCMnZMKLnqZOnSY7xCXk0k/zM
         h3QMPbTGQzTn+tQcIghEZozfjQb3X3C/J+O4vhWyUE7+OALNoaa3PFQ+zo9VjF5hbfFE
         08mZ1/akdQIKHd8VadlEqp8+b3Kb+FGbH64Ew74BRnp1QPuWpFv1B9/PPvPDFpFhUBMh
         UcrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyy+r78QPai+t+YGmLWCfuyORjGnsrQIk6c1aOc49v89ack+qRZVnXNV29xCoLKkLqw3f3maQJhcmQlihhGnxFD26Z6wmG
X-Gm-Message-State: AOJu0YxJle0lbsSGgXroh6Tjua7cjyNH1iSKfkqoaEdWXzbuLJj1Az9T
	SdjwN5bp4g/qMqmy0uzivoFlkHYfR+OPVTyelx2TBG0+4bWh8ltXTJHS3ONWVgIYdW0HKuHH2EZ
	MJ5cyi/b/5dZN3/HtM/+jr+rgdDwrjUWWZiOdnxikiQNOkTKifacAXw8=
X-Google-Smtp-Source: AGHT+IEEnMX0NPtpIhNWzE9s+ZJMHHn7EnH/1HgY+OJdlyiUh10GvxgRFUmJbKaSturjGICO8+RHPXegNh9XF7g7naGO35FhIhV1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c09:b0:7f6:2d58:8d5a with SMTP id
 ca18e2360f4ac-8000621696bmr128825539f.3.1721044344703; Mon, 15 Jul 2024
 04:52:24 -0700 (PDT)
Date: Mon, 15 Jul 2024 04:52:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf1914061d47dc7a@google.com>
Subject: [syzbot] Monthly dccp report (Jul 2024)
From: syzbot <syzbot+listd096a34372f703f89669@syzkaller.appspotmail.com>
To: dccp@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dccp maintainers/developers,

This is a 31-day syzbot report for the dccp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dccp

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 105     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
                  https://syzkaller.appspot.com/bug?extid=554ccde221001ab5479a
<2> 57      Yes   BUG: "hc->tx_t_ipi == NUM" holds (exception!) at net/dccp/ccids/ccid3.c:LINE/ccid3_update_send_interval()
                  https://syzkaller.appspot.com/bug?extid=94641ba6c1d768b1e35e
<3> 17      Yes   BUG: stored value of X_recv is zero at net/dccp/ccids/ccid3.c:LINE/ccid3_first_li() (3)
                  https://syzkaller.appspot.com/bug?extid=2ad8ef335371014d4dc7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

