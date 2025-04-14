Return-Path: <netdev+bounces-182023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF2A87605
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 05:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E731188522F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C75188733;
	Mon, 14 Apr 2025 03:07:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1962339A8
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600028; cv=none; b=B2EhLaDNENA48GXzSgsVnO4dUNu5TczMiZK5liPmXadiMVJ/1MZad1RHJt1kvJWLdcwDQzg1nJjcijf9VygLI5Xv3wCOgL78nrIQ4iouLq5AWZeYwk1kvq/jNFUwJqhOJxPnD9U5fZyvQMqQpSpapWRPQQaksKOqkS+aUBtYnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600028; c=relaxed/simple;
	bh=HREMeGF/s1vxz9xQppW1nMjEKJB+3m17uYCtJYdfzu4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QpynbE7f3mcMIilqUD9RRWRoVE4IMxiyuvWfN6doxvIP5/No6bQz8XVR+c0iiupCa24Pe7xLOz6gL3MJg9OIH88XYoMmCuJ3r96OLsEYaSCv9c8zQ4lXNElceKTi+PG1TdOhZV+pyZlyIIFByGCXEVWrsrwkW11Al0VmoZcy0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d5da4fd946so71465075ab.1
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 20:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744600026; x=1745204826;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54cVqukjapjwptJMc2lk98ZulqxlRdx+F8Y1epDzm8c=;
        b=go+uJohdtnq6qefM4BVCFAGOsrG7fieP2gAFrEhDEu6Olq427o5khOMO1WxVgQSBrP
         1PQhYtfra2/wEAmi5X0ziXCpWe1g5Eya2M51FoSSTlV1w91ENz7JjTaOhfaIiMgfXi5L
         RWISMEw2sVYHvnPcvdQ0DaneogCIKEQ2C1s/isFHlHcus+4G7VGLyR/qTyy/mKw4pk2Y
         85hxCwnPvBJ7Spxf6Y5G9h1xoA6DVFGim59jpRA4fRcWpCiysSHaTL0hyaqQrdLUW6Db
         LI2XvozUa5vtNelQoLbeHvnD2gnjqb3Dr20712rICufNWQPJko1joxot2WPjW8cs1eK7
         VLeg==
X-Forwarded-Encrypted: i=1; AJvYcCXWWw0nQOIAHwA8jB7FnGWaV/kvo5lMzAgRks93u2EJWuLZ7cbrT4sOhifcNVGUKPBfOdIXN68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNOrB/cfmNO5sgggDM6rJD/I0IgHQwXtmZ/bxQsVHnRlzkNkr
	wH1jETAW1nPJUlqMcmKVYNnf6BZHdej96+OI1LWMqP8qhWUAzTBsq/AKDlgiwMCgxZxnoZGUz2N
	n0VE2vdfXz00wUojuHh3yAH0rry09NetfI19VrqxESv83av6e0F77CgE=
X-Google-Smtp-Source: AGHT+IG6ptXUR1q+CNVldhfTl6PmBCG9MDPErXOqHVCulcsPtHLN8UAgqnQ90cRV+qYAQxEPYQTq98Cfzh9frDE2/dGfl9EuleZZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3092:b0:3d3:d074:b0d2 with SMTP id
 e9e14a558f8ab-3d7ec1ca153mr114566085ab.2.1744600026026; Sun, 13 Apr 2025
 20:07:06 -0700 (PDT)
Date: Sun, 13 Apr 2025 20:07:06 -0700
In-Reply-To: <20250414023048.44721-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fc7bda.050a0220.2970f9.03b2.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in rtnl_create_link
From: syzbot <syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com>
To: cratiu@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         8c941f14 Merge branch 'there-are-some-bugfix-for-hibmc..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15bab398580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eecd7902e39d7933
dashboard link: https://syzkaller.appspot.com/bug?extid=de1c7d68a10e3f123bdd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1661c0cc580000


