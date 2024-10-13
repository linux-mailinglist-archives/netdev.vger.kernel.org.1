Return-Path: <netdev+bounces-134927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5799B956
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 14:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E381C20AD4
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53B613DBBE;
	Sun, 13 Oct 2024 12:09:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276213AD0F
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728821344; cv=none; b=Fk44laPpPjFe8kI7B1MX474x1SpYAi9dWKAkWpSEeKEyxF4yOZfH7BDlswwzVzbHdFySPePM1j1sRp6/81DSf41/gPt2G/6jUz+zqP3Y8ueXOa6IArYUDKtwAJf50K7NxcaaFZ/tXFsYEbOJMhiOzxhCXPKgFO+1TT8WcYL0i3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728821344; c=relaxed/simple;
	bh=1//wjsvC56hpGTmDuUZ2T4oScL4MK6KvU3Wv/21Pn9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bNnneS5TIPo8Dgy72NWNty6vpsuW+iEAl0Y1Xnza1glEwW1lNB3Olz6MAtMYpw1AfCsHBjsogk42HVNFjwBf4/p5Af0u2NSXbFT7rYyHnZ1J6R1UU8uZ5znL2ZHDBxqxIopFqThnAon0ei+1gLkXqcMs4Xy4YtzAycdPDfgcdZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so18592685ab.0
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 05:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728821342; x=1729426142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gH0baQP6BUi4dgqAeAGb6JNew30La5RpjGfm2LRlP8s=;
        b=E+cX1XMQCo6wfw4gQ4uIqvpYsuR/hXILeQH6R8txEgw45R/BmWW0DUWc9FEaHYEvLp
         sTqcCPCTiR4nx7j0oSgAtTsStwONHjXDp2KVMifv5Ykxv3DZNAp72qa7eedE8xlccwCl
         rxqHWgCKGwzxxDTKA1V8aOor3Q54J6aJVWpoO3f3ewfvNwQm3i4A6+ravE+6K0CeUW/R
         b/VnjUQ9jUflD28iD098fHpgj4F9R2TKKREoV2O10JhYBTsgEB5/kGGbNAwp2orNGYPJ
         5VXPQ7XXIhTRZlfCuD6J0aY6KN9YPo/Uf1i3l6rDS38M9NG294Km5Jg+T78tYdxl4n8y
         AWgg==
X-Forwarded-Encrypted: i=1; AJvYcCWR0XCDV+pqjJnrSvpeg9QPLIUA4jijiFFpHha5rDN5lNZPq6yAnVvbb04I0uq6IwITTi1+Ikc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZU/YotI1vSYae0K241HBhLjAs4p5JTELMlZPkSc3ZaD3qSSq
	JXgawxiVJYuaPn7vXgFgzJj5MGfScl3Pv5lIHJbu3hFMVcN8dLowyGlEeQoU56+v9w9Yfe1P5GZ
	V8WYhAZA+CQA67DL1uWcqm/T4ADTc0cw1vRaRCgLZmook8GLSLL5PvFo=
X-Google-Smtp-Source: AGHT+IF/PQtax4BS4UuOZQYDSpFuOwh/Ub4zyOY+zZbI0lfBW9YcyDGFYqECkoz/W0ode9TC7Z9zGRA0iZ3Vf1KoBOKAGXdSVFMo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a3b5f78525mr68063645ab.3.1728821342534; Sun, 13 Oct 2024
 05:09:02 -0700 (PDT)
Date: Sun, 13 Oct 2024 05:09:02 -0700
In-Reply-To: <0000000000004b09b90621e1e9e9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670bb85e.050a0220.3e960.003d.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_path_from_node
From: syzbot <syzbot+0772686ab2731ef3b722@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, takayas@chromium.org, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b6273b55d88539c6a7127a697c61d3f89c5831fe
Author: Takaya Saeki <takayas@chromium.org>
Date:   Tue Aug 13 10:03:12 2024 +0000

    filemap: add trace events for get_pages, map_pages, and fault

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f59087980000
start commit:   8a3f14bb1e94 libbpf: Workaround (another) -Wmaybe-uninitia..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb19570bf3f0c14f
dashboard link: https://syzkaller.appspot.com/bug?extid=0772686ab2731ef3b722
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10aa1ffb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b1abc7980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: filemap: add trace events for get_pages, map_pages, and fault

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

