Return-Path: <netdev+bounces-84989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48002898DDF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791C81C22875
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629E1304A9;
	Thu,  4 Apr 2024 18:26:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0E1CA82
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255180; cv=none; b=E5GZegk+5u0HGtoAq4UtRrcVDziJhYRAxhTwAK8vKWlckIC7e2sCllmKu3yZIjTWqOtT81TYbeuyIEGeOWrlPSGF0lYPC7zXDBLnvRwjb4FQmsXaOiLheHUgB0wSou4UTxa1PBTkRqUwsDJPi2oB6r0L1F6ayTsJYMyUoHkz2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255180; c=relaxed/simple;
	bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kA9OKOf2WFpPIYokltksQChM6KfWs/WfEhBmN7eLAcv+wh/p3uXN0MUhJbFQLVWfP16qqbcGKU+UbRXWQCZLpUG0y70t34Md1g7g8tb8e3AkMOV9+OIiYvKd8O2teLyfN+azR9sA1vZltHJV7R23T4MnfKhZBvEVTLlsatJp4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265cb019so119006439f.3
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 11:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255178; x=1712859978;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
        b=YYlP+5LJeP653FOf2qO1iRRWnAi49uBWTbIZ7PgX70mFJIlEcaseVKFVoguSUcZX07
         HxOgN+chYcQCqPQaITmfyfv6gGjhSfMTT3zQ0cCgvHwMuQsg8X75mDMjIVPYPotowAf/
         ZEIZJ2OZyFXnrGkBdJsfNO0i4BPf9yN9w4/9IWXnyiWU4ZYR2qKliVON8xJIoeVqmfJz
         vZ1s9CdDoMpU/iA3eXQPqoFRz0o5lGbjCy1dWo4ZhgL4qhcSqc7vE1RtWpsKnb43UNGr
         0Eva/LvjDdJ7xaCxTzw0biYFoohDzjgO/z/t0FcEdzMnOhC2wbJsnImBOtiV6gOQF/2o
         Im8w==
X-Forwarded-Encrypted: i=1; AJvYcCXJoQIfFnd1jl+jWf55aCooY87sFL5+92nSR0ukZWwJ8tldT8SFgZhbFi7Mp44hNKSnQuRCUx/pNuC5Hq840vgtoN5phTts
X-Gm-Message-State: AOJu0YyowJPlIVfn2x48ihCoBMCsr78djGgvS+tEq7J+66ubBwvMmRFd
	mvAhEoVbeLScu+L6W/Ta0ttyLCD6z/zDkZ/3WRi3+eg/U1tcelBiKzSQ+mD0Yk5F+421iT4mFIF
	VvECD7mw0g57hLv0j1mht0IHbiBGNQASGZMtJ+caPqZ99WX/gmq41HW4=
X-Google-Smtp-Source: AGHT+IFpIWIHg6mhLlxKV0QUFxwSst0730/ptvTeVTNW/UryKELPdtjXE7jGOfXhNo5XLeYMDXSWFx9yJlRLe08U2sRzZ13cTnsP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b0f:b0:7cc:805d:38b2 with SMTP id
 p15-20020a0566022b0f00b007cc805d38b2mr22900iov.0.1712255178459; Thu, 04 Apr
 2024 11:26:18 -0700 (PDT)
Date: Thu, 04 Apr 2024 11:26:18 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad5b3b06154979cd@google.com>
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

