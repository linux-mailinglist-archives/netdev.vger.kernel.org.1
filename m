Return-Path: <netdev+bounces-214830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84471B2B6AC
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E72B4E289C
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54099280CFC;
	Tue, 19 Aug 2025 02:06:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BD21FF3E
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569166; cv=none; b=PvCgXdNXPLKxz5gGAm8qzKct5qcSDzN/eaUj/og8UkwEpv92s2NVhL65jtz754IxTE7C1k4uKUDrSnV+PuYoAkduinMRs3J+Z3GFGAa/wk2pY3oOGCaVNYDl0G6emPK7UHq1MTRtZgw9UKScsUi2Y1FS5b3B5d+7u3XfsK7839s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569166; c=relaxed/simple;
	bh=lh8jOzNpHCI/nH1BvzANTbsWlc6+7mgRM2GYOA97cSA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d7uuSkwtDHTH8WHS9reXxeT9XHO3g5gNnPAT2Et5qj+5KwIdKpGx2ch93nObHXfs8BkdLuTDpEZIxhP4hK+07P1Ms5JSS29TUHhB9mSSaJAajK0q7VUtNCVVn6fWfslut/QfByFmJC77rNgxzY3sHiVXe2fo7HW1p74sUv9ufCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432e5aa43so566216439f.3
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 19:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755569164; x=1756173964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hySzSrwJgHRDd/NJGNmhoyuoY2oYZl87dUt+SZaU3Vw=;
        b=U9SgaKeSAiMJeQC6Cj81ldt6rcvMWKl0A0hH3mO+kBxUwuGKLa+URDLxTMWY5qDPnk
         6qb5jrk6vtVz5wRgQBv3Tw/ERy2BycDBDHOJ7E3V2GkPkcOVySMl/QNeb/tDaJhn9474
         yfddn6imq/zeE/6Py3cFKWL3tVEoMco0u8pAPY8SBjHBL4nGRLYVgZdpgva6xHJ/3iZW
         ZeK4mfQLaeM3jbs7hhxaT8JfL8+ZFMSh6qNDFJKjjDG0PnIVpe3bDQW+OOdmZJGxtOo8
         sh3aqmlHo/MPVUSTSb3yvZuK1fQxCE88r7KJgP1wzqnPF5SPHlYRv5/+sVbWH2uJcFX0
         qkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBEUYA9di+NYwjWCLbkFDHpwsBGX7AUurvlgI4tCJ2RmlLXVkpuP8mhWhxJz9PcU2cm/bnj8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOlRqzGVbszWhETCBlWMm0vyUY/IEUvGlrhu5qQ+9uyPBmztK
	mS7oSrDuHHxDptdNM5WEHFHQ47nJ+zc2SMviTma+tndSL+WBpFUvbq5SBM4aTPyY79J0h//0wgN
	uaAiidr5aXIMV/cDuWr2aXkPd3lCgRDXcX9sc+1ltMoJ1hQ7ZMIhqIS+NRKE=
X-Google-Smtp-Source: AGHT+IFPWh8hcC83DbPI8nICzmLysNTfx2q+c/0s8wrbCup6BnbcNXZPJvKrIZJUb8a8Xcrui31+7W5+TV2ecOdqs7Cjr/Yx04cl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc3:b0:884:476b:352b with SMTP id
 ca18e2360f4ac-88467f641a9mr183004739f.9.1755569163936; Mon, 18 Aug 2025
 19:06:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:06:03 -0700
In-Reply-To: <20250818222718.5061-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a3dc0b.050a0220.e29e5.00b8.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
From: syzbot <syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com
Tested-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com

Tested on:

commit:         cda250b0 change_mnt_propagation(): calculate propagati..
git tree:       vfs-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=13eb7ba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e92a122a0cf6f2a
dashboard link: https://syzkaller.appspot.com/bug?extid=1ec0f904ba50d06110b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

