Return-Path: <netdev+bounces-195567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6913AD138E
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 19:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA4F169393
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E405E19F464;
	Sun,  8 Jun 2025 17:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839015DBB3
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749404006; cv=none; b=JAG6cqe3Njl8oqx9uaF/IWR0XeGAvpDl4U2cDxuh0BfABbFRv9MfevaJqDUAfVuuLsgsIYKP/C8+RHzI1XZQD9EsBssO5TS2YPg7C1P74hp/ekAcAvFi5LMetFXmDZhqpaAZPUaffvTv0dPhveJvACOAvttsG9EtVQ4V/sGNaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749404006; c=relaxed/simple;
	bh=5bAIMo5449Y2Zsk7C/nk7K3d2lZ2pHmlhbszdjHS2Fk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k+btcOKzWJjXdqiDIsHuRl2tJPIAh3vohpFXx6RvHhZMYffkBonWsIFi1rxjdsmwBtPk7HLqkg15acYIep43qQ2XzJssUmCpy68OC7HXTZe1ausLE1zBYKQmp7KTyXn9NOFAOD9Y7LZBPZgZ3wQOAjHteQBKWWRRUaO3V1LwOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3da6fe2a552so77685925ab.1
        for <netdev@vger.kernel.org>; Sun, 08 Jun 2025 10:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749404004; x=1750008804;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jIBUgKfo1s7YvNdeDIUYV5LKf2tqtfkNThcYR4lhL4=;
        b=r9funtv5xEDrO5E9DW1wnldeahqbmJLBQFZ8qSWOJZLhzWCCa6vdExXO6BuyrNxO2+
         ePUFvthfTRJX0FImHTXR9rUrFvJaSJ8rLFHajZbuP51L+RGrKSzYwoLqxohr1hNViDv5
         RM2sNnGjApwRdObnrFnidtXXGhRIGZhIDT/IDVgw/afBRJKF0Ad47QCWElvQX1PoDzts
         ygsMYciZY3RciepV1kpyyuius82XAXiQ9rB62l3Mb4TbkejRN+ViLalQAzUc5czpkDRB
         60BDOHoA7CpGl9WyVgO+HlXgs+2pTnEZeW5B60APg2l7DqA5mdCIb0DPCrvdCnx72fIu
         cIJw==
X-Forwarded-Encrypted: i=1; AJvYcCXi9+WsX/bj8khclJdkntR0LyP1tLcMff1g18P/9HzizyKrWk0daQXhvhO8YG2U3WSOFGaK8K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxATYI93jXrZWtgU7J0sbFV/AMAlrSbeWtKpGHBHK0mRCazY8oE
	ffpSdESMih3gRVMg9UtiZetPpcwV05rKZ2cETBdrEiJZmfhGoHiSZCOBDGEooA4av/MsMxx4M7O
	D1V/hmhXLU9PZnYr9FVYjHsIUpOFiahMQ4cK/zIvQqF04VuNYHLHXZIxHVIE=
X-Google-Smtp-Source: AGHT+IFoy4TaPwn8E6wr/Kz7niH6YlVpH16ANSJ65jY+XgtoMNn2+9E+sZaiizIt9EUQD0OYvF9pEU7imDP+5bSfO1TCja2+GWz7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2701:b0:3dc:87c7:a5b9 with SMTP id
 e9e14a558f8ab-3ddce426531mr109203445ab.10.1749404004600; Sun, 08 Jun 2025
 10:33:24 -0700 (PDT)
Date: Sun, 08 Jun 2025 10:33:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6845c964.050a0220.daf97.0af3.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Jun 2025)
From: syzbot <syzbot+listac4fa3bbb63e8b6699d9@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 430     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 308     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 50      Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

