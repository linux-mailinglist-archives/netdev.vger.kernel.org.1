Return-Path: <netdev+bounces-198010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF4ADACE2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A318716A752
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B72D5C99;
	Mon, 16 Jun 2025 09:59:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A352D12EB
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067963; cv=none; b=CvdotH8MBFNQE0oe/5gN8/wwjjgXmOscIRTgBIBuK6wIX7r0oTlKursTFV3o4hEjn8uvSWiNcsa58tIApKQoFNDpYEPFTcX1kE4o9mMNp9oBt1HWikbTOcZsHH1WO1DGPIB9g3PVFvOoM4lKaFqCehvxV5/VoTyLK99pLlh2aaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067963; c=relaxed/simple;
	bh=doCLeYzsrj45Z2HBYvq5g3My9gFsOrT5a5JAuEQIrso=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AB9mmzu7JIKxcOInj5/kDf3N6cgUAKKFjD+QHBoiSr1+UpurNXoip0Hsg0nVHI3MTy0nbenM1JaNSHaK3C8fvD3QwE16w8kj2vOeSsIvZsp10tFXseRD0F4KVnCybgn1YG2GzKtbJSPpz3qxHDryay+TbKTL6zLAzamQSLgYcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3de0f73f9e0so11799965ab.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 02:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067961; x=1750672761;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uv1B4mAfQmuzPqdcif0Rr998oEN+e6p2IZSVJLfUKAY=;
        b=JRLlwiJS4QoTUKB0myG8HHSczQz+7AsbaiMAxwO2yxy1+0cCElD5LAm1SXKWsPKuaT
         VXXGxwLqqkGQQXEQwoncPyrPmMbEMlJPZqiu+dzfe3zfohPUd7+Tr1SuPcNBYB5NZ7vD
         TlvgBybt1Yj69fNR2mgjtpeihFwh4IAVh7jz+Z1ynOsLMx5bSivyd6wbeXzSGArfjC+H
         h/JjuXJNtzavz/3CJLXRxKru/LCAxs/J5cFoHYhwMLrgd8QlKokNJ28AlhgmQAvzO365
         Ix+D+M6Xnvx18b8/cvnRUqUlPg2RDrtNA3OMZ3hTOYIIUzGqwtm5Dp4tqzi/PJaY5fNo
         a5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXdHBFKSM3Qc4GFgOH6VcHblYMhqiPw15xP7dFSllDwZqg17h/CFUhp1P6zr0icmZyDW4v8N2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsLrdYmkpl6xKXRRJeNPX5Xaql+mRXJco/Lc3vp/Fb1RO5OO5
	YcJgHg0xEe4v6D/IL0WSAepK/yoS5ko+wdgZvqUZrJa0j0PmXWRehPPFnm/bbupFjXqgHbdFdYK
	Ed6GsYcqByY/M34ywwZnj4mPO9KovylifT5tTi4aLtPdmxXpFbySGDMmqZUc=
X-Google-Smtp-Source: AGHT+IGL3GRknel6W1gofzr2MZ/Z3dEyG16sNMTBLVsWsK9zMf4tfmz3K7ba/JBRVWpRHM++g7sMRmmM/qThPgdChW6+K6cUasAP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:3dc:8423:545c with SMTP id
 e9e14a558f8ab-3de07bc8ab4mr92413975ab.0.1750067961202; Mon, 16 Jun 2025
 02:59:21 -0700 (PDT)
Date: Mon, 16 Jun 2025 02:59:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684feaf9.050a0220.3aca5c.000c.GAE@google.com>
Subject: [syzbot] Monthly sctp report (Jun 2025)
From: syzbot <syzbot+list1d5558bc40e501f5b38a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello sctp maintainers/developers,

This is a 31-day syzbot report for the sctp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/sctp

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 70 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3976    Yes   KMSAN: uninit-value in sctp_inq_pop (2)
                  https://syzkaller.appspot.com/bug?extid=70a42f45e76bede082be
<2> 124     No    KMSAN: uninit-value in sctp_assoc_bh_rcv
                  https://syzkaller.appspot.com/bug?extid=773e51afe420baaf0e2b
<3> 3       Yes   INFO: rcu detected stall in inet6_rtm_newaddr (3)
                  https://syzkaller.appspot.com/bug?extid=3e17d9c9a137bb913b61

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

