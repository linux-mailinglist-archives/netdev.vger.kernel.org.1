Return-Path: <netdev+bounces-214361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE325B291D4
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 08:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6344445B1
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBA01EFF8B;
	Sun, 17 Aug 2025 06:18:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64491DE89A
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755411487; cv=none; b=ksmSy9u/CctcOAM5APqQYw3mX8xuE+lwdoWz1b2/gBEXPtqEASuqd62cqFOKTBD0b5E94Q+fIyqfMeta3QGuK8NMK+5uKlpkFRct6diiTZl+pl5C7Eff8xiKduTTHS3IYcWfJGRZb9r+RhNRL/a5/kusNxy/HXgXiyFmynJKevc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755411487; c=relaxed/simple;
	bh=x6SRgnib0G7M2g+ot+TWQJ8h3Z9ID7PuY1Ye6vQiO7A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lCcdbWbVICL1Y54sVfcK/40iIkCh9gXfldKFYH4OC6vfQVeDe+DC6yLAZJJ24698pK/bgsEauJnN/MD6o8mxZoEpQ3Fcpos0mR1aptIw8PW/wyDyGbaopdSjoTTktCk71NOaL6aRqShFynMQyCCsaIe5vyoYtDavOGGbFMQSkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432e5aa43so373755039f.3
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 23:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755411485; x=1756016285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdO8zLjvXGnLAKqt2Wo9ucoKrtcFQMjL+W6shvTRwsE=;
        b=Zgw7v8JjrzuYdga45z4aJYnTJ7NwJtKyqYs8HqqWbsBGJQ94EG0z7zY8OgWCj9UyTr
         6fAmesYO0EeQwS+3hWZAuXmfAHFE6sofkTqgNvFKhu5GZZjrtGBpshRM8ZSf3tvBCXYJ
         e12iXs21YEvUShY7w5iLuqT97vTzE4PrxZar9tjbvHtkL52BFTl6jImIXMD7F3AWIsVp
         4bAzUN2fir2wIHjOqTSlJ4PdU4tkqthT+KDvDhZuag97n0jmb2h1xzhsdGfH5c2uhpiI
         iu6rJmMgRvR7xsnylzFuB8QdOyth8b7ZNfp50tS8tDbDYKEnAISc6OI8vWZ0NZd5Puwj
         MCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Oy0JWnupY3/AQLanT1jabJi9Jos5ETL+PBQN7RLlGclm776ODBvJO+weQ+vOAEnev9I86NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB01QBMDEhdfqlo7KnSCSCLL4iR3JoukURfeX7F6LVMzUv/BTa
	oyNbpm9m95rUwbc6Pu3vRji8He4gpjTpgG0DPEotQVlx40Xpm+OegcwpFKYCZuDSaZmmZ/nJZEA
	X627d+YhQv8MllHxu+zosBYOr9T34an+ZOMRXUSe9vKsSGJ0pfwxWoTe9+eE=
X-Google-Smtp-Source: AGHT+IHZFzSwDxf2TRTZM6Le8S0sSkvLrk9hGAeEtwb8V3MPhnIYewVlR7ckO5uIS7XAC1CPsuDIjUd08C4UFZSkM+VjvxP9yYWX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:3e5:7e02:a06d with SMTP id
 e9e14a558f8ab-3e57e84b6c4mr127240065ab.4.1755411484903; Sat, 16 Aug 2025
 23:18:04 -0700 (PDT)
Date: Sat, 16 Aug 2025 23:18:04 -0700
In-Reply-To: <689ff66d.050a0220.e29e5.0036.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a1741c.050a0220.e29e5.005d.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in debug_object_active_state
From: syzbot <syzbot+56728135217003dc6f7d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, davem@davemloft.net, 
	johan.hedberg@gmail.com, kuba@kernel.org, linma@zju.edu.cn, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e305509e678b3a4af2b3cfd410f409f7cdaabb52
Author: Lin Ma <linma@zju.edu.cn>
Date:   Sun May 30 13:37:43 2021 +0000

    Bluetooth: use correct lock to prevent UAF of hdev object

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c6e234580000
start commit:   ee94b00c1a64 Merge tag 'block-6.17-20250815' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12c6e234580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c6e234580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=56728135217003dc6f7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118d2234580000

Reported-by: syzbot+56728135217003dc6f7d@syzkaller.appspotmail.com
Fixes: e305509e678b ("Bluetooth: use correct lock to prevent UAF of hdev object")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

