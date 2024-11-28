Return-Path: <netdev+bounces-147722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD389DB706
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 12:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700E81632CD
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF919AD8B;
	Thu, 28 Nov 2024 11:58:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD01199385
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795084; cv=none; b=JRFtZw3as8rGsLVUE09/6I6swrBgi9Vh877EzZSoYgW+d5V9WXGkgYY6Yh+xsr7Kj5zoq9YxcIc8/LmF3IMn+wV5VHY3wavNk/aYQavu+vm//NDmxU3lIbhNMo+vEUNKBm8crXqS3bmpqAw3627h5U2hJpiO3DRXDXlLIcowXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795084; c=relaxed/simple;
	bh=OCJWJ+u4Yh9hvmQMZXkM8KRn/EgI9awMfpPqzOpmNeQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q1MvDOJMHAr6Hf9IZELsr6I/4qX/ua0C8pgdTHaxfEoYCZE8WCfKAmQFkCJH9e9+3yxz8SpWTBxzJLMXn88typ/YtcUPht+Mo0uZ/BvnxGDBAP4xsa+x2XARZBKRxMlrRyAwPLENY3JjMkuEwLyWHKJDdXYLz02vP27l7J36KXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78b04470cso7672115ab.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 03:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732795082; x=1733399882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4G4wt0qmrICABsL3fTmVUbz6tUyHRU/aFIpdT35VU4=;
        b=wwFO/kIfNotbaOIkl9o23K+PDBQ5uGMaLdjrOoJo2oLe+SavjcCT5rRn8jESPxEN7D
         rhnCnzWxhMdiD+LJZlabaEbAAT/2Kmv/wz7G4MNK3MBB4ZmqmkyCpwoZ6YWSwbjdWfqj
         80qF2/xSPipU702d1E6p+uXQKHwML6N1d0ZYbwiOr6UAI77sSg7lrN3363Lcz6ytQgxJ
         f48LwWwaSedFkQGB3Ic20sEQhcAXBRni/KvWbmsKLVhC0VpW0p/yOCNeLF99HGtu2Vwa
         KiVsyeNDKjCViYCEcTPYo5aXA3y3XhzIXGBB4Obv7DeKnkvR6mjUSfQPf9R3yrN37FnS
         Qbvw==
X-Forwarded-Encrypted: i=1; AJvYcCWYOv+0SVmG+j61M+xSM29DuIFjp8MPAOqpxgC4madffnxT5xamfBAtPegrRTXe2KixxunHHUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrH7TPAPzEhgU7XMmHk5k8GVUj6gZJ8IfNuQHFl3PY6E66rjH
	UNfQTpC0tWRjT8pLhhQnvEGpFBzbqkW0/mk5X90pXDtSEeQNr64Yx/4c+abksLCv36JkC0k9AJr
	uOPMkFZQUv76wClyjdt2AJBHhzi+fNE4nLuspJ/qHUJf+ywf0pdqZJuA=
X-Google-Smtp-Source: AGHT+IEVZ7aUJUgjShFgHR95vCPF7KZvaAgWHrtmMp9hLIBxTo6zaewL/H4pbgsZ6+AQhlvQFduZe6J/eDefsrYwF1fpY7cEo7si
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3a7:6dde:c78b with SMTP id
 e9e14a558f8ab-3a7c55446e3mr62921795ab.8.1732795081892; Thu, 28 Nov 2024
 03:58:01 -0800 (PST)
Date: Thu, 28 Nov 2024 03:58:01 -0800
In-Reply-To: <000000000000ac553b061e675573@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67485ac9.050a0220.253251.0082.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in plfxlc_mac_release
From: syzbot <syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, kuba@kernel.org, kvalo@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	srini.raju@purelifi.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 68d57a07bfe5bb29b80cd8b8fa24c9d1ea104124
Author: Srinivasan Raju <srini.raju@purelifi.com>
Date:   Thu Feb 24 18:20:07 2022 +0000

    wireless: add plfxlc driver for pureLiFi X, XL, XC devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15001f5f980000
start commit:   cfba9f07a1d6 Add linux-next specific files for 20241122
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17001f5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13001f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101a59c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bcc778580000

Reported-by: syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com
Fixes: 68d57a07bfe5 ("wireless: add plfxlc driver for pureLiFi X, XL, XC devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

