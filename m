Return-Path: <netdev+bounces-171697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26923A4E303
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F357AAF99
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4763127C16A;
	Tue,  4 Mar 2025 15:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF825C6FF
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101323; cv=none; b=RxH67pppsKwR1Pk7AslsHUPGfTKlrRARrspo7+wm3I0La1tg7ouEllVIq51EQ0pgELOwo2EB0+v4IJDa8z97UsZ8P9Nfj+fBRqRlZKfSejZtv8hjuLU+XlUTybgNfhgzijCuSXngWxvJ5CQN1amSJajKus1jgNI1P0WFc6CGMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101323; c=relaxed/simple;
	bh=mcLZWbvX4OASqJ6TP4DsOuccHhHsTxZE1ZtN7Iwta84=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EIoKiAYAqJs1HhuVSiGLEl+Bf/n7DJuQ6htp31LdMqutGm7YnAcbRXRSfS5pVXfAUq4zIkF3RUiSyddvt3CUxA9EGULsNvNpTtBarhrY496s8+tFOx6qs1IRZRlnLUwy5/F6Pdp4HnNHzBrS/51yzBIsRZS6/MQp21hBaEG0syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2b70f5723so119344245ab.1
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 07:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101320; x=1741706120;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCSESAKsiqQ+IFJbEFJWlyCbShr8mBIqRgAxgCfBLE8=;
        b=DFbIUFFx35LDrHO2t6zOGmdd6R5NOOJs9jiaYChiOjeldKhj+j6pypsWox+RBCtcwL
         iuBebHsDVpPDUACbxFln/ufrsrEtW55V/s3vnwTMKFrWSxdsYldnMACZUIMsMOTjifUq
         W1bUfeus1Ewka+5ishzsKbuWWn4cbEcuGBReWy3Cb8SKhQCW+SeNbsfTVIofjSK0PsKn
         R0Bb3xsEP4pHdMarRNoQO3JtgXTX8J3/BchnZNbTR4BVRyyS3uTVUfqgsJ/AaXNQKL95
         Xriz/ZGRlaLT/ySrNWVW0u7yuAmHRF0por7JEUtLzhkiEESK6Pru6SAK71kxI6TEMm9h
         aJvw==
X-Forwarded-Encrypted: i=1; AJvYcCVN2ijTPis9jo0mC1qJuCkj0zMqQrlrZDKrqvLzOED4XVcmz2/tokphDROCcWLxgIqgy0gnEnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmlEbi4rHT68iOaM9glxVKqH2FmR8tOWSjjArUzsAURKprALG
	NtGZuuznE2QdBROEU0NLV4oBEatxzUvIPgtEEDNWvX90h+HTDqewAPNvj9h10oO44P816lxB5DT
	Nlg7zleH6t8V7e4e7LY0Pn0wTLSTIcjrJZWTYH2Dy3o+32RCEmjmpXsE=
X-Google-Smtp-Source: AGHT+IFPSuVdOkDMWbPlHI6z489JojogoUgQt+6oFcvH+IjYcYZ03ZG8x9ZGyJ2qGUlEY8tpl46mn69MJBTzEUuNU9ZXyrhahC6B
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca06:0:b0:3d3:d8d2:2900 with SMTP id
 e9e14a558f8ab-3d3e6d78964mr168396415ab.0.1741101320684; Tue, 04 Mar 2025
 07:15:20 -0800 (PST)
Date: Tue, 04 Mar 2025 07:15:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c71908.050a0220.15b4b9.0010.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Mar 2025)
From: syzbot <syzbot+list1809e16a6bbc3c9e72b9@syzkaller.appspotmail.com>
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
<1> 340     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 275     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 45      Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 42      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

