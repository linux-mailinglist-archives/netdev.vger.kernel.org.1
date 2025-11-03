Return-Path: <netdev+bounces-235266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82124C2E65E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA173A6516
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C712FDC4B;
	Mon,  3 Nov 2025 23:28:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033752F692D
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212485; cv=none; b=eYxbo90+IE6ruhO7pSAyyRt8Vt61ps/nOo71/zUVostu//qnNyo4pxn3F+Db/Zt/JXVGZEOf4YQiksaSak1dsRkCuqpzqWstAapMdOwDToc2SWudi4tLItg+TlQGTuK/XXxaQGM2S5L/lD2iuzzQIn9+6q5nh3BcSgDgMMFen9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212485; c=relaxed/simple;
	bh=e+hUtLgnUk9Xelyamxzo8aAh92PTX/nGJkqBbHiuw1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e+xftdqUA+If0U1S50zi54WB7zoDW8o3ZLSO+1DXfF3UojNER7K18tg6h5whxBJQDDPf1J0ra058eugNN2va+KA05gHE/X3shOdoXBcWwre6kECpiJbROaD3K7RP3Guqih+cWJfoqOv3QY8fU32NdFDWDuGWUXY8cLu2w357gbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-948409cc397so187714839f.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762212483; x=1762817283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAZCNdGP6oa4/13Oj7L2uGoPdWBFOF+p2dxE9OH7Xts=;
        b=HBMkVhePEE9pxGnx0KwZE7vE3y+1MwnXwAP/N6Ss/Hd7xKLblGd893skEY/4N1AHq0
         pGLWs3IV11RbhhXKwMHmDSwXw97DMGm64Zrsfz2cp6z2SQvcBLBA+0H9D1KPIM6lXPrR
         751g318eCUPz53wsRxrl4zAg6ismLWzfpwtYjxM+s6WEByrWQfDa47Naa9p/Gzcr7+dy
         DEAyAlmmEbejbTtfxsJzA0hL+tjbuFNj9uZtyaKPTG9L/5eV1LEwqbJh4/WukjB9eJEF
         y2rznj0puuR/x+ni98YqYxq6oUNFsFef0Ajxdhc8tW3uX8R8a5X22tuhWKXSMqgP4qxO
         VGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU470Us4rTs0ESnFSLQw5tJ37V0dRhgRJMDa8k/U8XAfqKaBRuY3ulYsYCiXeGMAhEtCJ2NygM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGATlOdm+mzwoaxg8jMbU5sULvqaaO8ylOlgjm6WxqW0Y4qiNP
	GBWS43u/X/13iY8vj911mYPP/gKnIXhz+obIQGA2vugLED6s1OgyX0YDZSoBEyzsbLSf+n0eZrm
	ZAFSldyUPInmPwQ+3LvSOKUoH97hM6ebxgY3rdhD9873vLbSsCFnhKxHWSGM=
X-Google-Smtp-Source: AGHT+IGdfjUbagDO/4+FziCnHEUyeuf6B9If+BZc4kuwQIqb9ahoHL7XKeHxACMKk70wvvZhdDmGpPBqt1bgpW8kLip3yqMw4Sgc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:ed15:0:b0:945:9e9c:721 with SMTP id
 ca18e2360f4ac-9485929af5emr165838339f.3.1762212483202; Mon, 03 Nov 2025
 15:28:03 -0800 (PST)
Date: Mon, 03 Nov 2025 15:28:03 -0800
In-Reply-To: <00000000000062a2960621a49519@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69093a83.050a0220.98a6.0096.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_rx_list (3)
From: syzbot <syzbot+b4aa2b672b18f1d4dc5f@syzkaller.appspotmail.com>
To: acsjakub@amazon.de, davem@davemloft.net, edumazet@google.com, 
	ffmancera@riseup.net, horms@kernel.org, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	liuhangbin@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit d67ca09ca39f9605459959004b28c56899e3bca3
Author: Hangbin Liu <liuhangbin@gmail.com>
Date:   Tue Sep 2 06:55:58 2025 +0000

    hsr: use netdev_master_upper_dev_link() when linking lower ports

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153bebcd980000
start commit:   b66e19dcf684 Merge branch 'mctp-add-mctp-over-usb-hardware..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc73f5c6f9d29d57
dashboard link: https://syzkaller.appspot.com/bug?extid=b4aa2b672b18f1d4dc5f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104ccdb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164d7498580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hsr: use netdev_master_upper_dev_link() when linking lower ports

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

