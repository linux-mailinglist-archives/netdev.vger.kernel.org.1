Return-Path: <netdev+bounces-154126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A128F9FB738
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 23:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241B7163D82
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 22:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A541D61BB;
	Mon, 23 Dec 2024 22:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39A198E60
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734992945; cv=none; b=jPwlCwOnRQ0wLewIWjFv4EgqgcnFlnOHkcmcwnhOuorCH8KmRJsoWYB5/Aj75NSAWInC3c1B3Sj8NL0CnwegfZm3nQDuBteZSdVAjTgqlInbCugK8QkxK08aliOiVPBUwJnFcspEo7gmauxaKqqRZm9PAiDVT4hyryYO5ZNRpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734992945; c=relaxed/simple;
	bh=tbxROftgZUDZCPQS3dgHui9JtdKjojV/NV4pSLa7yLQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ePPyR2gI7YRBLFTpwvwrFm6KbjmXXn7T/6NHY44j8imlQ3J36XruSv/YWDpgUluxzz+Wo0MaYP6OdNjhMMACw+ZEjdWZkrkTpHInZx9imhPgXspzOD/FEJB3DWkF26BwYE62MxpThwtLi/OIYIkefq3+HOUiAyXAehJ4U07YpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7d60252cbso39668185ab.0
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 14:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734992943; x=1735597743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXFsWc3cBjQmAVXhERtP+fTViDwJmrmB4Hycvb0Vczo=;
        b=EGOTESbdNSyP3t/P6hZ9lTMh/wcIMYT3Nij+ttZLU3ERAij4NPHbrVN1+EMXuarmvK
         /QyKZLpZTOz6w+9gjKI4raANAZ+PZMVhpqfZwHm2IH+NunyIA1oprtI/n2hfgY/E29e8
         PZYX1I/qQdOs9rr06PoTHwB3g+ttv1x+FiwZHyN86e3kNvRTgIkw9cTieUkt7a5WpmFl
         eEQEL4xeKpPagTD/dCLui61ZZ+feRm5H9MjjVEpfcvDQfQvjGeStsozvO5Q8L5HVnSC2
         pNWQAmOVoa/zVf/Or9ai4IYKmazs1m9sv2Lot+08+6o7w/cXlmTOABRDs6iLxhXvNerR
         dEbA==
X-Forwarded-Encrypted: i=1; AJvYcCW9dca0SraqdLl7UtibXaicCcXJdIvxKYjW0dJk9sd3Scd/zTSJ2GEDe3s626+DNV1Xh9ZpdLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgDX5ICkDWKwaJ7SSkwrafwcsm6UJTffchlq+Zcm15RoeuZNJn
	p6pH02PUOgQBdM6VbbkQMaJQzg+Ftl2NoeMgaNkHlggt4H8Zi/RHdPKgfxq/iBwf9w90JgyXEqp
	paCp2PIbcVD9ksNGsePzBVpxU7L8Zt3ESL9licSRUovyY088Em9DbZUQ=
X-Google-Smtp-Source: AGHT+IFr3QOdlGNNLXo40GG/X1v8nXNMTvNIdi2jExJyW6chvs4r6L+prLfUOcCLhtwD2aer2+8CRLfr3PGFBsbAKNcKCXStVZub
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3202:b0:3a7:cce2:d349 with SMTP id
 e9e14a558f8ab-3c3018aaef4mr96055575ab.8.1734992942934; Mon, 23 Dec 2024
 14:29:02 -0800 (PST)
Date: Mon, 23 Dec 2024 14:29:02 -0800
In-Reply-To: <67251e01.050a0220.529b6.0162.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6769e42e.050a0220.226966.0047.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: davem@davemloft.net, hdanton@sina.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c8992cffbe7411c6da4c4416d5eecfc6b78e0fec
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Dec 1 18:55:05 2021 +0000

    Bluetooth: hci_event: Use of a function table to handle Command Complete

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d538c4580000
start commit:   30b981796b94 selftests: drv-net: test empty queue and NAPI..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d538c4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d538c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12050adf980000

Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

