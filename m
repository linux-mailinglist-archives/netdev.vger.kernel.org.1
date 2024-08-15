Return-Path: <netdev+bounces-118688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE70C952779
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA901F221D8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 01:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1EA18D645;
	Thu, 15 Aug 2024 01:21:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230E36D
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723684876; cv=none; b=As0J0DZZTXpTe+MYchsieAnY7WF9s6BIRIkfSXxQjf1NZmNMncOIJQFKJOB9U/zRiTTakJFWPZ3Ogd5/tY1ecC11ezVWp2IGXEgJuwqZyWa90x5Vc7G/MhJewwbvT836PZxTeJVb/TDbL3gjh50rsApN/djwCWahVm6krrdCSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723684876; c=relaxed/simple;
	bh=Hb3X4riTxNkNCGjBLuPrCPRcXoa2jIrWSholPAoh3Io=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dJlUEfAn9tKF8VVvw9EKzQUWvOw63BTct6/PwFhuUqAFZAn1Qt8Uz/1R8nO6RF2CX+QBoYKgOdUwF4HDB8xwqCSEPN9Ff9I0d1Y8ocEP5Fk5Rj0y4bjDSdP0lqvhn0YJhxE3ANy1I5sxPo4bWOd3Al3esc6V0I5GEnClAi/kNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3245b20eso3787575ab.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 18:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723684874; x=1724289674;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb3X4riTxNkNCGjBLuPrCPRcXoa2jIrWSholPAoh3Io=;
        b=qWX/GX81j5PGBGNGvsw6YDTXxh4C9qQuM55vrJwPgKqex1kbsGX71yPJ77Tk47MBVn
         wMOPfkwydOBg9dVibTMlLUGqJCuoQ6x1Uiaeqlgo6lujEq+oY8qREYRFLmPU7+XuPt2x
         +/xcMRA8RTa4FSERhax9O4iu5VksknOPB54xu/wgBn75q7EQMsYam874kSxlTxwcvHkJ
         Cq0wQMpWmaeTEZ6R4CJbMUFPq/VtCDdwqFVPC9hEORspLzBsfJJvCSfUEJDhvVKcLY5g
         frIYtLNzajPk8ZNxVqGoxKOhonufexrMDttVIXmNftjKQAExE9LOzr4P7sG/0UO4qt07
         hwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWpst8vE7cTWw66+ZO/oil581lK9u2vaoIoJQD9LB/Sjwcj4y+30ZylEsQ6PUvCZqWzNI1pSb35yz5ckiJXtXcLXAksx+d
X-Gm-Message-State: AOJu0YwfGc4Bp7AgvjkEL20dNCcME07MlDcsv2fNXG4pElWXf0TiUseE
	zGDR+WOXjAjWs9rNznFrvTfKVNfdqov55v2q4aina2FBwVIZ+rnfhY/o+q2udZgP7lqCq0FRkM0
	eN8bbX83EilesikJznvOjvTWYxm3s94yLRT5rk7XrU/wqwlXPquMOTrw=
X-Google-Smtp-Source: AGHT+IE1L+cIMMAFHcc0Wx8kcH60VX5XGrnjTgUDbjMF+9tGU9/HcW1WoLcbwHPNqV8SKgFyweHjql3dcF+ilk3XSi+FpZYWPhcz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:39b:c00:85aa with SMTP id
 e9e14a558f8ab-39d1bd3bb90mr881145ab.0.1723684873954; Wed, 14 Aug 2024
 18:21:13 -0700 (PDT)
Date: Wed, 14 Aug 2024 18:21:13 -0700
In-Reply-To: <000000000000ac237d06179e3237@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009df8df061faea836@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in htab_map_alloc (2)
From: syzbot <syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	houtao@huaweicloud.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=061f58eec3bde7ee8ffa

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

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

