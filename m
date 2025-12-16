Return-Path: <netdev+bounces-244880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34455CC0B94
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E34523027BD4
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 03:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9801E32D6;
	Tue, 16 Dec 2025 03:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F22701D9
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765855987; cv=none; b=IB3k/zQk8m18wvZfEigv9J+fJGsNeFw+9i2V0PvvUrC7LzLtP/6tyxAnAHXn2KN5+G/3ZkGXuvfV3FtC/FhYcAtS6oO7qHVypk+LnAc+niH8qzEa6o2Cxc73Lab51XYX22WJ17U96Pb1dDOSadNMzRhRT8o4y4TI6vvOsonMzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765855987; c=relaxed/simple;
	bh=q8GfxMu+gkL4UZqtErhl2nhXb69IchPEij0OfmV1h7s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EOdNS1WCcB+LiG8h2MzKccuJoIiLNTHxllGoNkwpzKGpmf6WLna9tbAkM8iByjLi/oFxyqfPX7kbLOfdj6chlh5ymEm/x9KbC9K+xTmwMZPJA757kh6vsGIUQFemCaZl3f1V/bS9hXHQwzrVWHanmOf1YYRmnbMGnYJ/dpq0440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c6c91ba9caso7348846a34.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 19:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765855983; x=1766460783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiZt2J4mwWA/bjQnkQCKEI8lAKBGG+H01b1dJMY8/gI=;
        b=CQdcTeResrrp/CsPO8C2hVHER5XikFiZ3wSiVrmDVtp52kVr1mywnJ/OWesiDjBB+p
         wfe/RTzVR8SxW7Ao0mNWb/HIhlmTY6a859yQ2S/pQAzuIVwhU2ASUopxkWg/X6c1JLJa
         b7lx+2iI6xUg0VlZC7oaycYRHdSgP1OBn2l7rrjIWYbow6N/kPEX0NZL9jEh0wHgQJcs
         0PBhNf2XNYA6nvubADEJs6BPJy0OxFktGPdbwCvonjZwiMU16jgSkaJ1nw2fkIZ2oAIt
         C7wE1SNzlB7YEx9RHq6Q0eh1OOdgMgy9O4dkXVMzgqgOcVbvJPQ90lnSXbIf+J7F+ULu
         WGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0SqO/TBJar4RWD5EjRd1iXwOR0wRIaxbh/ZGwCqgBKiZsbWgIyw0VgqsdUmSBRxJY75sJvjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/Vp2wSDbCf5pZnOYikHfLtBZlTwE+v7xcasvhBMbIs67atqn
	zIuEgE+sBZZDLeFOsD+0o6IBDbykXHMESEyBpTJg+S5rUKujdeRS1jkG7lSK8r7myzPmYZ0iK+o
	MEyBJEGGN/fcyor+eKG14GIyCMKjL+hsSwpUfdleJRLWeT44apSIqiPp508k=
X-Google-Smtp-Source: AGHT+IF5odtYrwu68ZW3BLPzGhuSIHUuwh4dXBk10cbMge33wddAQdVdsfk642X0qj0kDWvr6MY9DTom6LvHcL6dxaBry+fyKOBZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b95:b0:659:9a49:8efe with SMTP id
 006d021491bc7-65b4511f7e0mr5381976eaf.15.1765855983235; Mon, 15 Dec 2025
 19:33:03 -0800 (PST)
Date: Mon, 15 Dec 2025 19:33:03 -0800
In-Reply-To: <CAF3JpA4Yk03Zeju9Y4MMSS0ynAP+qrk1fXiu_CGV1G+ffC-NiQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6940d2ef.a70a0220.33cd7b.012f.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_ocb_rx_no_sta (2)
From: syzbot <syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com
Tested-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com

Tested on:

commit:         8f0b4cce Linux 6.19-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112b29b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72e765d013fc99c
dashboard link: https://syzkaller.appspot.com/bug?extid=b364457b2d1d4e4a3054
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108cad92580000

Note: testing is done by a robot and is best-effort only.

