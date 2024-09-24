Return-Path: <netdev+bounces-129531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8120984566
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79622285933
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058ED1A7242;
	Tue, 24 Sep 2024 12:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F10A1A707A
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179268; cv=none; b=Ze4QQ19mPVt15vKpoojZm7sHCwC+buqR9tjS+lRABh7qq4v9Z9IfS7tTeammgFx+LqW6dtnGDMlPTRjhYKK60DbUs/WgHd9jEEG5ibM+brA6ItGp/1C3fGEBdXC17WeXhth9ztPZ/MHKj89QIvRMi4lo9AGa4SKI7Z8uxxdOQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179268; c=relaxed/simple;
	bh=cObrgCUSvHW+ygJ1FqkY0+Tz/uCqpy6uPK5t+gWO+j8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vw8s2D2G4bbQFxA0ZJxk0sZz/lMELqOErgA+G+9nlGhuYrgCA8U/wDIZ+z36dcho1lKcq5q4LnroKW2q69O8FtQ/w20U2EhxQuPmMuBZtSKq1TwUgKNHsBvOdaePR/ED3w/VxuSeyzAUJwlr0U4CbXb7FWjtnbskjRfh1rb8u+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a8b992d3so1973405ab.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 05:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179266; x=1727784066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6XSwTL3/zFm9C67RW1I8K+Y0nZgbXlIR8uoPmui7Ow=;
        b=Dli241giMRHVP+SkHVpKm9bpq0jZMylemOkRAPKs+syWSXI/JMiA0RbOrNGUaNn42H
         wRQMzBcDh0U6n35Wn8dORfGcrdZwRF3YV7PN6O/h2L32fvkkMQImOYCk+TpEcVELNQ4w
         78vFMSvll/l1ve4ttewVTpBkbTSxjx37ey6AvaPNVqzIuWsxXG4HGyDqgxhAQcvZuzrg
         NqqQBJP/hVmEqJ4EOu9GUYYEOhW5SXLNRnryg6V8kYuncrGuLMTeZi3E4H5igMfmNRB+
         7tw0/GaDjrpG/10cPd6szdTdabmYRJAu2EYeCAku0szE/2yj1IY4zMPvtXxDPXF52OgK
         830A==
X-Forwarded-Encrypted: i=1; AJvYcCV97Q7TVmXGRwMjMnncLOo6435VG9rLqhUSQ87fPL3VtGrXSQWVEs19A0a2t+zC4s7SYAxPK74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBl6NQ5ncToeS+/GcFXtXPelUlvhw+FrlT1mo2LfDa1/yO4l4
	T4RqTEAlAjEEbZkPOYNFaY1f5CLR4/H30Vri532A7oCygjiE3bY001p3Y7olfkUrAHrQ2/P82wB
	Fh0AzuG0aRjeoZoX4y249rrWSYYd22HQMqdoBvHv0bDAnxjiZ1xuEQaE=
X-Google-Smtp-Source: AGHT+IHrOmvjiLzvF7jwvN3hI5LzS+Kv/KB41hVRF7f6fcdWg2aKQjwpw0ahz2JHQBSNt2sFKNFZvypTChxKfYan2ZHULmNIvNPZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:3a0:ca91:2b4e with SMTP id
 e9e14a558f8ab-3a1a2fd73ffmr19734095ab.3.1727179264991; Tue, 24 Sep 2024
 05:01:04 -0700 (PDT)
Date: Tue, 24 Sep 2024 05:01:04 -0700
In-Reply-To: <00000000000020c8d0061e647124@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f2aa00.050a0220.c23dd.0029.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in addrconf_dad_work (5)
From: syzbot <syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kerneljasonxing@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103252a9980000
start commit:   af9c191ac2a0 Merge tag 'trace-ring-buffer-v6.12' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143252a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74ffdb3b3fad1a43
dashboard link: https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162e9c27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1123c107980000

Reported-by: syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

