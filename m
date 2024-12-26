Return-Path: <netdev+bounces-154294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F959FCB0A
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 14:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D1D16242B
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C131D47CB;
	Thu, 26 Dec 2024 13:05:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E31D151F
	for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735218304; cv=none; b=hqZPwjVqzG59ron4nKLprhaDspIm0nVoxQpDTVaENcV/6Ff8m8FqtZtuWyO3MB6/gesaxXWKS5VfMCRexbdkVOovhO7JR9uRoIv1eCy88utg5LPr5WP9p1++EvOiKqIKd787DDvJ0iuae6sgXr/68x0zIjkAZ4daryOAY2X7h1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735218304; c=relaxed/simple;
	bh=ojuoVsWI7D2MehUHk81iFoc6zeavGNHJ2AvCOakoohw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rUYT0B4/dkKHx2AgcecukEaQ9cZ4txMw+5qxuys7F2qM2njoqSPNvqPf6JXKe9izwX1x3Wg8CVj/aFvlh2GvlvAKQ47St0qMur0jdRlj/i77r7XZqRKiCU1AVCWgHQLh3Bf+qrYjWc2XVzpgAeOWf9IYl8ClMP5x2FLIz/D1//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso132504805ab.3
        for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 05:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735218302; x=1735823102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfZAw6nkkopPycDGHxqbXAsiMVaMBshiMpUf9RRGGKA=;
        b=d7ggq8QTq4Yv+W7Y8Aq4H0LWoqInSSn96B5sZaWAJEhaODnD74LvKMrX4b5BhPZZjI
         atq6yIqdgO6r7RJW77e43iAezIADjctF393UatWV2rocBJUMvNpvyIBSvUfedcJSb6g9
         2c/p/XZ7iMBaI6mptRhLWHGpjq+ZODLjDQCSJY0Oi7L8mZkHfiwrpZZl4DdKiEKmP0C5
         hIiuh6zE1ooijfdYZkZLeCPa7OhxcX1n1/gzH2nbEQe9ypP5z2lEHCN6/soV3Y+cQUbC
         COsvcpu3LbiZ9bxL5eKaTBTZyVRkurDaM1RXarD31hZjYSt/SZV29bwCz7VSo2mocM94
         75+w==
X-Forwarded-Encrypted: i=1; AJvYcCW8zTl6+mwh95d9aIRQgmYHtMGuNzVOYKG5WzFx0n2D8W33xM06cfsWH+iZIAErfti3/wu4/IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6TduTjUlT8ujBZkd8S6y9/ojYzb6Z0aHWKZWmz6OsOJgDVsn4
	8i1C2WRgIL2wH9iYVc4JWFjf1t3QKxndSnWtOEoD4JKvFsgq3HO4lI8qwD2426SgP39VAucMRCp
	N1lbqWUvQp+DN6d+YG3UFMlQwIJLgphY6se1CJaDJH6q2Z/gNRcUQ3U4=
X-Google-Smtp-Source: AGHT+IFsClCwKKxNjh2qy8IFlSdR86iJ6l6Rnz/rbCrEuCBbR90dTtUbE0c3fjildTbFNKcL6denTgyepBX/r2SPgRUFPEzxJQUJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1889:b0:3a7:5cda:2769 with SMTP id
 e9e14a558f8ab-3c2d2f3b65emr177346025ab.12.1735218302197; Thu, 26 Dec 2024
 05:05:02 -0800 (PST)
Date: Thu, 26 Dec 2024 05:05:02 -0800
In-Reply-To: <672efa7e.050a0220.138bd5.0039.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676d547e.050a0220.226966.0084.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_cmd_sync_clear (3)
From: syzbot <syzbot+217e3f1283cafe80586e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, iulia.tanasescu@nxp.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a0bfde167b506423111ddb8cd71930497a40fc54
Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Date:   Tue May 30 14:21:59 2023 +0000

    Bluetooth: ISO: Add support for connecting multiple BISes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11845adf980000
start commit:   0a9b9d17f3a7 Merge tag 'pm-6.12-rc8' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13845adf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15845adf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=327b6119dd928cbc
dashboard link: https://syzkaller.appspot.com/bug?extid=217e3f1283cafe80586e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1094e1a7980000

Reported-by: syzbot+217e3f1283cafe80586e@syzkaller.appspotmail.com
Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

