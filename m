Return-Path: <netdev+bounces-96435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90EC8C5C7A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7994B1F21542
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD697E77B;
	Tue, 14 May 2024 20:49:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871E1E501
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719776; cv=none; b=o1kWP4FhJ3OcRqiHfl/Pw4CUNvKD9KVnglEu5X8dWV+5bFKFM0bBILNP7vnhA6+7VDbXWV7LUQ6pRbzg/lZr2nNdBHBiC5r+MJ4XjGqGlQdXtXGyofL61YN0JtZWTNcUT31eX2OBy101TFB2iPdvqj05T9UuJ0dbsMOcw7QzFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719776; c=relaxed/simple;
	bh=IB69RAvqCOdOjg7nFJ4PG6OHmguovls0NLwI8SN34WY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VuvDc2hSUcBM6jYKFg+Oj6UETxF/oZ2ZYaXXQg8LF7J83Y6dNs5A/CRivwZaH1up562V/RGbLhxvyd+awgNperLRi3E6KU3CyAunyjTGEkq7zcVJ8zHLjJgYhIh7vMHKjOR5O5GzHO1YG/qtLhMlZWZfvGDDi9DjFS6x+3VdZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1eb98f144so227589139f.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 13:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715719774; x=1716324574;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVqW8S3ABFDk/zNJBkMLpZFKRsCOqY4qSaDAmMCsU4E=;
        b=Pd1/E1kOXk0h5ElfoDEmByoFGNYNyd/8Zi5GAk8I+8yxGKvuE9D0n9cmGSPeheoarT
         5ZZJMlNBy1ub+hlSR95golc2gcILJ8t63SN1Dy5ICzGoY7Fd4tNkVrEy3sD/+TCdwVLW
         9Ti5KoCYaR1Twf7Te22yW717N6o5c6P7yEHxJOM0Ufj1mLj1X3dE+CkOcH8YGvQ6v0hg
         FXpVaO31k1W0HrlYzPov+rkW5xviarXf8ilDPMMR2h+7FUZStOZngzDTbOveRbLPAawh
         7ubqtCNFWRS0z3xwhTy1iG9u5d7JFPEeLdpNisSIru15r7mo6RbI0EXzr88mmcp4Y3po
         AB5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVbr/6CK1G0hZILlHW8q59zXj6eBMqrYIp2/PmqbNHTdwNvM/IxB0aKVQ5waxmJLk0yQfs8R1C+jOKAvyLbHWKFORvpKvN
X-Gm-Message-State: AOJu0YyUD3XUqwgGPHGpXG+09sM78q5HNXnKWSsz9jnZrq5c5Ow6dpfS
	MWjFcf1z2t7Chi5cH8OyxrteoTaa4Wy2Er8Y5O6ubz9XOvKpBqbfyFfDbioKkq1gyL3FEpYRiI+
	kEUldWlAitRaD73I9tHvhfiClTYa64/fHzIlyEejDT4iFEI9WbBE8Vvk=
X-Google-Smtp-Source: AGHT+IHADF36HovZ4nEix/LNsmP7MIKXZTsQIoDpi9OF/S8o9O2BkcW3OdPN5ChDi98azQ4YeENsmszraj19HOLTwdeh6PAXoVX0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ad01:0:b0:36a:63dc:2009 with SMTP id
 e9e14a558f8ab-36cc1436c0fmr3440275ab.1.1715719774152; Tue, 14 May 2024
 13:49:34 -0700 (PDT)
Date: Tue, 14 May 2024 13:49:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac3c84061870238f@google.com>
Subject: [syzbot] Monthly dccp report (May 2024)
From: syzbot <syzbot+list962db2fd5c4970f5379c@syzkaller.appspotmail.com>
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
<1> 102     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
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

