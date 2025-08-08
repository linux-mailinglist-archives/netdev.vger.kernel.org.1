Return-Path: <netdev+bounces-212301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4566B1F06F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 23:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF2A7AE6B7
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08B289833;
	Fri,  8 Aug 2025 21:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20BA24DD1B
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754689987; cv=none; b=UXPY91hRi18IO1cPwdJYQiW4RzVR7PIa+Vf/3LyNA8tsYVatABl/Bc4jdujuWO4W8XND9ycN5vF/+iJlxeoOHsoJ8ZldkFGvw8mKqaC69Krbb68UAH6ZHPmSesR9TSZ4HmkxC//RMEMzhWAhO3+zNIBLU9hmSTiKtgX2LfxMmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754689987; c=relaxed/simple;
	bh=ZzjdYrxYEcxo99s9h1GnuOAWn45kMBSUB24pYO67++U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BTkciU5Ztw6NwXMvCj5P+KhqI6Vcur7SIbHvwFiHBzNfWzSDm2Y225BWRe8B5l96511jsOk2McqN8X2VFRXR1hngJKDts84lxmxWwILYWSIL6K+AP7ju2YRYHD2wCkR6VbgAAHE7ZLJkgEv60bluQyWRjH5/5TUVEvH1qOme4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88178b5ce20so448440639f.3
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 14:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754689985; x=1755294785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBCMcg0k4PNCUZ4EcEMcgDzn+4NHxC7yQYWs8JkG+bc=;
        b=Ci5TqzBYOIE6qB9lEa+ZcLSOL5oz/Ep/2h4g3ftA3FPC6JxdJ68UelHB5BeG9G3GiU
         tA6ndsVmi2EAL50CTJY7j6xXFxYPI26R6okFkhxiLO5rsAOLQ0aqMe5yJxwdlJ1ZgbKF
         rSPpxuQkppVPfQVZgzuo+Sf3BD0q0q1VuHkCVZGfDYxcnDQ9tqIB5ehmzM3IRXtcjN+U
         AXwSWG80N6tE6ZWSZS66cUnJSrfkqr4ktdzah5kdhJxAVbCPRjQ41/ZEXi3gdCctkNXL
         QZHFlJ4+RRVFYTfgjYqA0/3f+4s99PYNmn7ZD28i2tNryrpOSMBfngDJfs5ixexiig+P
         v/4g==
X-Forwarded-Encrypted: i=1; AJvYcCU2MqRx8K1rylIlZSMLzVq9VlvtNBMpI7OVX2H019pGZO1Hf+G1i092dYrvna8dwgrbaAzQquU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFv4xELjGwhvNgSwUoGf9wJAv/Cu8znr//jiV/gEL7RCtsxgyy
	l896G7zIc15saGh8TJjvhpaDshd0Ba6H4/pDOISdRBoGjcbusTGF+XFO2eTgbgd7PbUrYqxi3Qm
	oev5DhROXS5MvnD+ccsjVPIPo/WXs3bTyKR/kQLt2ZCowPMgJRrUJWtWrQ8U=
X-Google-Smtp-Source: AGHT+IEF1na4CL596K5tr9vAfldDM2eKsOY8NzKJNyOz392+5p4iZ2zo9TIo+Y+YiykN5IC1WA2v5EXCr9l6aXuaz9h/U5aUXy/9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1591:b0:881:8e2c:9995 with SMTP id
 ca18e2360f4ac-883f12552ccmr907971639f.11.1754689984923; Fri, 08 Aug 2025
 14:53:04 -0700 (PDT)
Date: Fri, 08 Aug 2025 14:53:04 -0700
In-Reply-To: <6871b125.a00a0220.26a83e.0066.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689671c0.050a0220.7f033.008b.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in rt_set_nexthop
From: syzbot <syzbot+97bf275720e06ad75f63@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, dsahern@kernel.org, 
	edumazet@google.com, hdanton@sina.com, horms@kernel.org, jaltman@auristor.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e4d2878369d590bf8455e3678a644e503172eafa
Author: David Howells <dhowells@redhat.com>
Date:   Thu Jul 17 07:43:41 2025 +0000

    rxrpc: Fix irq-disabled in local_bh_enable()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a4c1a2580000
start commit:   d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6cfc97245100778
dashboard link: https://syzkaller.appspot.com/bug?extid=97bf275720e06ad75f63
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1532c28c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148f9582580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: rxrpc: Fix irq-disabled in local_bh_enable()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

