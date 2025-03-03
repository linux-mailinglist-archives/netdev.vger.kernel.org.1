Return-Path: <netdev+bounces-171775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C72A4E9EF
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF013BFD65
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA56E29DB61;
	Tue,  4 Mar 2025 17:17:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431BB29B23E
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108631; cv=pass; b=pLSwWBHtFR85txM1OUd1nHl0eRulLVgFhkpT/yoqxQuCGrwrTMW4PcWjY2v4lp9tZWAbeSeily1to5EJgO02TPOzjA+Sum7RAwS1EMc3LOx6Zsq9W95/+/pLOBGZVBKOEj76AShB9lxog741uqqCTB5ayJdVehcBzH9xo8q9uf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108631; c=relaxed/simple;
	bh=5w6pA4eYiBnHNqpcmteMeSrZV2g2L1eyHkQ8+j6h8f4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UDp4uTrhlsBDNusGvcFbRetNYhi3fVuYQVvhrbGE22/MY/R4pxO8mhpNX6cE7aLS0l6zcnCatxVNw5flGRKsg1SFnB9z4EGjPcZ+Jw9l91dA6tQ5d/jrk5HpFQ9lETFt8xBT5F9qr5ZhS6sb4D7ag2RxoLV3b946Zm+ScEL33y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=209.85.166.70; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 80B8C40CECB3
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 20:17:08 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dJK38HwzFwNk
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:25:37 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id CA9F842720; Tue,  4 Mar 2025 17:25:34 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541399-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1093442D20
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:40:52 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 572873063EFF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:40:51 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A73C7A70ED
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6D1F3BBB;
	Mon,  3 Mar 2025 10:39:32 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E81D7E4C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998370; cv=none; b=a6qD4pcx1QuLVf5xmEIcTQ0vJCi0H/qWzEtSR3pebye7BFrEzckCQMUjH89OyFy8YhJ7RnugMM4pMah0lNg3x1UU5Lob6F+DLemT+5ukdmz75hTsdsIo64sEoooFFs/VV3IjRL03ag4I3/IqyRXWaRdnjhD63vODS1Z61PmW0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998370; c=relaxed/simple;
	bh=5w6pA4eYiBnHNqpcmteMeSrZV2g2L1eyHkQ8+j6h8f4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dXP1ydEMyrD4mRoOe42tj/q/j4rUMpwRCxgVH7ePN9EnwWx5/IdyRhoKl3LgtOyF6vReBg3ekiHKQid7d3U87Fw0gZdhwQQbKPmM/MEWqUDP7SiTmkJKg3MVeq010fFqwy6cFF2TNX3548UMq6PZIa3vM16T6fSGE9JqzdpfrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85ae33109f8so34328839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998368; x=1741603168;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94B1AldC1Ra+VOi32bZczZH6eYO+XQiGIIy01bId2WI=;
        b=V7wOBcRUBkjivfmCcg5LPCuO/xHGIMPKvMjypOrkrtEn/mC9OgKyqWYAu+FjIfmkQ5
         wF+bUENS2eT8kVqO1jWoxDFwpOThAdewzgklTBh2n6kmQhAhebaUfp/DnS6uymAeBfd0
         0msHx6D58mqd5EJPVxyKVCQCpaYrjE7OUwAtPLjSiCmoWG8fFUG00+vyoEDHurjC6IdY
         AlBNCMFTJqZsuWt8RoH5HZT+jK0zXBsMqpXgW1K7Ha4+ewdWLI4ruN1ODYEDC6QARMvn
         ma7kTrW6scWyC1Hb+fvZi7uRuDqRLcArxweO6qLwMihLFOYe+oqOGT4HDWwiY+tyd/4L
         LzXg==
X-Forwarded-Encrypted: i=1; AJvYcCWxxWqKPCDuULxJk4KOnXoeOclmuacyDvf9e6lVloIgwH2lamW9Kcz2oP+PbJabwPnDDZTzUI34wH+cXPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwe6C9XMNPU33L0eay22k1x+0rXBJUHvl4wYTQmr3i1hzljIOo
	5i3KQ+Y0QDiberm7/iFcmn9nDHmGd807zP/1gVHXyx47LlTH+7zQxoqHCtztXhcazFA0QLy3Ba/
	orx3dKhGluSeFi9fLISZo5pe+6fPZYp3amuPhxDqq9USsniGSx10oQ1M=
X-Google-Smtp-Source: AGHT+IHXGGfJycEVF1C0NA+tWbF57mYYWAfRa3uH7yonYPLILGd0Xs6oQjnQHhZiPUqQSby7mDcwV8F7CrVZ/77JAIhHK7ysIbjU
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3111:b0:3d3:ff5c:287 with SMTP id
 e9e14a558f8ab-3d3ff5c06f9mr41959675ab.14.1740998368052; Mon, 03 Mar 2025
 02:39:28 -0800 (PST)
Date: Mon, 03 Mar 2025 02:39:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c586e0.050a0220.1dee4d.0124.GAE@google.com>
Subject: [syzbot] Monthly batman report (Mar 2025)
From: syzbot <syzbot+list0f38ff37debbbda9dc0b@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, 
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, 
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dJK38HwzFwNk
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713333.43951@PXJMsLMyGC9uaW8JczWNIA
X-ITU-MailScanner-SpamCheck: not spam

Hello batman maintainers/developers,

This is a 31-day syzbot report for the batman subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/batman

During the period, 2 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 555     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
<2> 136     No    INFO: rcu detected stall in sys_recvmmsg (3)
                  https://syzkaller.appspot.com/bug?extid=b079dc0aa6e992859e7c
<3> 14      Yes   INFO: rcu detected stall in rescuer_thread
                  https://syzkaller.appspot.com/bug?extid=76e180c757e9d589a79d
<4> 1       Yes   INFO: rcu detected stall in batadv_bla_periodic_work (2)
                  https://syzkaller.appspot.com/bug?extid=fc38cf2d6e727d8415c7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


