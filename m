Return-Path: <netdev+bounces-125414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C096D0AD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FC6B21384
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DBE191F81;
	Thu,  5 Sep 2024 07:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B78F66
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522363; cv=none; b=D8jEr08WEFN+bP9hMB+AFxwZDpyQoLN6iK0F4//wgM3UDguxL58XFBmJTlDvd1+tkc58K2REwxTGUM/EfsLOtgSxGC8YA39FbF7jw/KBf46rX/hD3XUDf6C2hV4rDLu2lACtkx/KvmoQpzm4zjARIh8LGqLg49XVStoT504pJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522363; c=relaxed/simple;
	bh=SyxsvJtcJVqaiQHgUJLuRt7j3v/axmlctYI2RnXBQtM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LV3GOaxJa3hBlwqPp30IUO1IgZvQ7W/xrxMW5bRg+vfGc+yLGhLXsukV/Mul5vpflYBVFn7QUqxwKaDQakLfYjtkTsWrcMr5X+mkf8lPijMEynksRpMR8ztgZNCpQgM9umo2tqFv3slA0MRx73q40Of3dBTbe/7SuC72bNIYEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a319f6520so82367139f.3
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 00:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725522361; x=1726127161;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0F7zeBTWaDC3bvDb+oeW8Ic3uat3Aamdf19hls7iZw=;
        b=le3fGdpO9ySX2rgKV/ePhZLRHpbwzpdHBQt3IZDSltXFqmFgGCBe/gGkqEY1kRPP5m
         LpIAR8vyp3Qr7h2O++ukzRToXhfYlpElfcAUSuJuYUqNneLTdo6B+/YkLZiTWsakgxut
         22wHTfZ4/Jm2Nd6xsXn6AwjJXDRzIdSs5NfM7ZrrQzaMPOdwOFctpHuGe78M2fhShV0v
         veg2DwQIp2xFXqF50DJn7jimVkVt24rLGCw8BnVZlBQ/1LgFddxtDp4zsmwcHOa+WGJ+
         UGT56/WC3bSEh6Wlk9iUlOKwSdUmn3nsG4XsQLO69A8ENYXtg2hlLHIshFXp9h306D9I
         ssLg==
X-Forwarded-Encrypted: i=1; AJvYcCVjHSvtyIyXQh6tpHaCQbiK1WdiFNEfGlEwMWiGITKPgQgwpxwBfYc2T6LXqzTWPu6iX6IDjcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9i7hS3cEjFx1NVhnQrroY/yd+xmnVObCScZfNDl5nBlrLpSF
	C2nER4FoaADQvXQ62ihQTLe166FUSQafBmU4L6DYOC6tEFDkqrvcl0BP8GUos2xORKFh56dCiIi
	2rclk2eltl+CoWCTedltDa6wZ4A0QBwbKpPvmGLP65zMQKFDpA/WS418=
X-Google-Smtp-Source: AGHT+IFO1js3UnJdsjfFeMrqPiMcPXUxGOhgj6RWXAEOhvugYQxMc8QlA7TiXBcCt6c52xeAwAEA4qdEkGnc3o/tMwhQxJsyEH/3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c7:b0:4c0:9a3e:c259 with SMTP id
 8926c6da1cb9f-4d017eecf15mr966608173.5.1725522361247; Thu, 05 Sep 2024
 00:46:01 -0700 (PDT)
Date: Thu, 05 Sep 2024 00:46:01 -0700
In-Reply-To: <20240905065955.17065-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064fbcb06215a7bbc@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com
Tested-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com

Tested on:

commit:         43b77244 Merge tag 'wireless-next-2024-09-04' of git:/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1582bfdb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=8811381d455e3e9ec788
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d22d63980000

Note: testing is done by a robot and is best-effort only.

