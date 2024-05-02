Return-Path: <netdev+bounces-93090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AE88BA047
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 20:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DE12817D3
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436C17334D;
	Thu,  2 May 2024 18:28:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9D17167B
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674498; cv=none; b=Z12k+LWVhWyf/YFWKrovIWiE7fOdO06pGZ+A9DB9MAt8MrTFx4w2U/OtvdQwzq86BXgIL/lTjggM8ItHJzd30dEfcAMsq6LngnQv82rQi+cM/LABWu/JGMI6rd+kFRn7RP3tbaU6Fy2QLhgaBKBii7/oeEUTqo0rAQylF33Tn2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674498; c=relaxed/simple;
	bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BCH7xy9zpHEG+Na9hcAXHgk2hwpF2bMYaYVg8vVKNJqYNFbJ+lA/GGol6TSBifcBQWxipWgaHHU/mHSxEXdCUfJbvBZEC+R9r6hSQmgXaKlXcmqf1AYYHzQ8yFlxBDHhYZgUeB1B+UEnfx6Vxr2LPT2OyuqBZEQQaP4vwaV5gAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dee81b7e97so234231839f.3
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 11:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674496; x=1715279296;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
        b=Vd8I2QivoJcMED2kMTb1ebwlCNGrRwXZi6yr0ZzhdE924b6qS7FJh1FRqfkX8BvvJU
         JuCV3TgpUOsBuKt8S9lpzndaZFQUfSEpXYI+r3qQDwzLrQ8TDU3xIbycWPOD1GnKVc9U
         72rfzGmtYpSYzmeDzmfHc/4zhXiDB1WlpyH5BtilQJq4qxCzAuaAvQrA2H/pzXdVP87H
         YhN/AL6fED/OBKUiN6y+X9US0xmlVLaY7VtYGLLK6bSSmNMvXU/vXdKl6yE7JN30EU5q
         hEfPEV5Ogb7EDJbq3+a9jbNYDsYwCgaGrRZykUWm6ThR28d25UvexIvTtUaPwp8fnl3H
         CE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5J9Wjvr808EW7l+bF73hq1JMhqeNdMlLb6czdKiADH/5YBzq6dwBTaVzOVq0W9E8/eWdXkqlVJ9nC5twMXKeG6SC+3UlJ
X-Gm-Message-State: AOJu0YxC9yD0pLw6ii2AjzJPynGEsuO5mygRrjyUygLuwGE8OfaPA1k/
	zbSK8HRkPXKVzjEl5flLKNZ7pUF/I9BxVOZc1ZFI438nJjlDFB0JHB/GUIQ7UIlikU7dyU0GxNQ
	n0b099kmUvg+C1/WHX+dh6Zyt6JOpnoWCHpEABjXQpjDw1CkbFWK99KE=
X-Google-Smtp-Source: AGHT+IHfvdUjCK5ourMvNUp/Sz8U8WrMGbVCskwFzb4UA2DWIV0LaNKUHAeAIsAIRgbjYbC4dLWbSyCtWhY+2ftEEIG8pt9kXk+H
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4387:b0:487:591e:6df3 with SMTP id
 bo7-20020a056638438700b00487591e6df3mr5738jab.2.1714674496327; Thu, 02 May
 2024 11:28:16 -0700 (PDT)
Date: Thu, 02 May 2024 11:28:16 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042648f06177cc40e@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

