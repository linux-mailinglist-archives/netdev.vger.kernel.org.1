Return-Path: <netdev+bounces-176060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A267A68881
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534E819C1760
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381C25487E;
	Wed, 19 Mar 2025 09:40:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52465253B76
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377205; cv=none; b=YCoO1gH7QiZmFA83sml74Vu3FHM3Zc6MZK6GmVYAYPGEYqZ/6NFKnICboyQyYpovwxu+JY0y2A3wKnyA/eMszNynCk6rVT42877Ie9Zs/YmskwwBgkfgS8Ze9xHDWZNAmNXCUyCKpZkKGruWjHW0NnUz96ub9BmZLyLE5Mwcw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377205; c=relaxed/simple;
	bh=MUIdGfHqdt7bgez4R5hVp0jGJaNO3W5wLDchdmLq48M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWU5TrtRm+Yp+6mSME4Lq/DbzUT0zhO5n4QAC6xt09UPWkGz5mC/Jg3tMuG3SfvVMcc8sQI6evojInbQFtaBeIKTpNDjzCWaZccpCOKs23xvFYDqb40VcINRTWw9IVveHV1jZptOItzgNKPEjwUwme4tXye2yyz+hTVEn6NLnuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d458e61faaso5133045ab.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 02:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742377203; x=1742982003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjBe+XHI3ciJhsIHuXrQ+GA2Y7SNLmT3NwnpfP+m5c0=;
        b=SMirRI7Y8lrVyimQzt0SwsNjgxQ/yWrsUzSUAuQv3T45DfIdXeeLUzZVdedbsXED6Z
         CEM3JQjS2TWGWavy3uumN+pXXPOPtp8CAjYuBLHP4d19xrl+GwpATWYeNWORAlQWbkQR
         0a30I1gugwOkDo6Dgx3Y8QhhAjk/NACKh7tWNjEjJJjWOvWvXzt5uywQg3W8hFHCkDzq
         86rsqpCjpytJ5/KZ9PCsUQhkeKOGBX3U5fWyITGqJQAjCbqEDV/VJ6du3G9joYdEkhL4
         tYlSN6UO6H+yKEpKjW+ssuwdniPJ/6iu44J+kVJ79JmjFLROuSpmzjCeZ7l1BidoqmiH
         9XuA==
X-Forwarded-Encrypted: i=1; AJvYcCWmSc2jfY9hU23Ap9oj0Kc2RAHeXdEwkheKMCqhZnGH9f9+3r5U2Grgl6ptRXL43prIqJueimo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYPbozkylJXrlGdnab2s7rUM0aZTH5PHJy/hYYq+9C2XrPASM
	jemls7xTT0Vko8cWENd/Gvfre3TeJ00mF62y3CDBDjPQ4J0rHYjtpYpU5vtjwG/mosKNGVvZwJe
	Um0TlUJYDelW5CahkQB3T0N0+XK3M4X8MtG6HKWs44fCo+FHoasyui+g=
X-Google-Smtp-Source: AGHT+IGEbYzJWOz86GSJH3d+H/uesMTKCNrZ4yEyh/GDkdwj2Kg7c34kkrPiiVjmgyRe5xz43NyJttqmOUCx3cgB3iWPOfUr81YW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3388:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d586ec873cmr16492115ab.8.1742377203511; Wed, 19 Mar 2025
 02:40:03 -0700 (PDT)
Date: Wed, 19 Mar 2025 02:40:03 -0700
In-Reply-To: <67afa09f.050a0220.21dd3.0054.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67da90f3.050a0220.2ca2c6.0194.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] [kernfs?] UBSAN: shift-out-of-bounds in radix_tree_delete_item
From: syzbot <syzbot+b581c7106aa616bb522c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	gregkh@linuxfoundation.org, horms@kernel.org, kent.overstreet@linux.dev, 
	kuba@kernel.org, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mmpgouride@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 3a04334d6282d08fbdd6201e374db17d31927ba3
Author: Alan Huang <mmpgouride@gmail.com>
Date:   Fri Mar 7 16:58:27 2025 +0000

    bcachefs: Fix b->written overflow

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176e8e98580000
start commit:   09fbf3d50205 Merge tag 'tomoyo-pr-20250211' of git://git.c..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c516b1c112a81e77
dashboard link: https://syzkaller.appspot.com/bug?extid=b581c7106aa616bb522c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e449b0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Fix b->written overflow

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

