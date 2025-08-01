Return-Path: <netdev+bounces-211293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF2EB17AA9
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 02:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7B2586CA8
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EFB22301;
	Fri,  1 Aug 2025 00:54:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169E360
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754009645; cv=none; b=t0Fq0gP9k9dxesMpRt4nXF/3o6K208oZWvC2eBclfvewZRIU9/OtwiLXZD3J9oXRGM2jEyIiR9aEKhQPPIHx31UYKUOd6rXE6NLniLkKQerW5kGh48bU6tluuAkCBLQun4tnmqtxidwY0A5SC00A1WjmMHTGSzI0mBf2UC+wBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754009645; c=relaxed/simple;
	bh=SWWSAxzg0urfm7YQfgJMgzkC5z/Raw2jx2xKLULcbqQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DyRtEYyAz94jptplIFC+71c0nOD+GDP+vZZ5gkgW1D3+awMSfPKuQ+nD/CO6W6f5HMyDwL4wlNjjr4dhrBs+v50LfUsW7qCiWkvW13izenfOGktyGXCC4Y8ziszH/Rw5obLWhyNFxxi84xt4DsKtJelVnQieYc5ue2veTkQs3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e3fcdbeb23so28714575ab.3
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 17:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754009643; x=1754614443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+4lsoY/uOE9b0JrS65NlzuPeknd2zacB9YwHmUemzA=;
        b=UOI3lhrlTEa25YpB9ggynzrK0+WZPXGvmHJBw9QaAZtUeiICqvu8JY1inCdjKo3S03
         viB7xecPBadCBg8HIQkCE8anBj8eY+hVU/oQmSEm5LBbvlkV/TQHxzHS6F9076oNNw1i
         GP/Ycg7FQ1nt5lNKkIoBtA0YpTPTtH2QHodmYPH/5ETdqbZgfgeNJbInhSzbemKkuejr
         DNFb5Fpo3InF48IYA111eQkVUssu2qO92yuaw/aaobVO2QJwEdhahAMW4SzdMljPyTze
         pNPcFmdV2cVfgrQ3JJpCwyVmW3E7YWGGQvi2Qi4YGnnjCQ0rw8HAapXwIdN70uLWZ+XI
         z2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgNczGWYT4+MOF9A8RAoyx/Lf7/xPtSODXV+dfZinvRD5aWamuTaeWDwO7YgmZ1XDB9lm5D7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxERCJ66lrck9Nvsb8DDSz9rlflVl//ppxlhv0Rw24cEbXST3
	BOA3DXRhji3mJDU1fR2+2DQGs85+DF4bqeTH6W78U+O/b52VN4RldM2kvse9Dvz9O/OmJJM9E/M
	mjor9z0kprFphwa0Rf8U7gaP6y6SrZTL1WmUWqPvCLqVLyN0U173zECIK63c=
X-Google-Smtp-Source: AGHT+IFaVZdBQYjo1zKx0gGcfXAh4/MccliMcbrduNQGUM94KUkUcjqih+MSl8N2B6gZ6Cc8Vq+QioJtZnXDJZ39XZcejI1qbHLb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2610:b0:3e3:f9fa:2c8c with SMTP id
 e9e14a558f8ab-3e3f9fa2e8amr168893905ab.12.1754009642873; Thu, 31 Jul 2025
 17:54:02 -0700 (PDT)
Date: Thu, 31 Jul 2025 17:54:02 -0700
In-Reply-To: <6888736f.a00a0220.b12ec.00ca.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688c102a.a00a0220.26d0e1.0056.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
From: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	hdanton@sina.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sd@queasysnail.net, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2a198bbec6913ae1c90ec963750003c6213668c7
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Fri Jul 4 14:54:34 2025 +0000

    Revert "xfrm: destroy xfrm_state synchronously on net exit path"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1714d2a2580000
start commit:   038d61fd6422 Linux 6.16
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1494d2a2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1094d2a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4066f1c76cfbc4fe
dashboard link: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ca1782580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140194a2580000

Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
Fixes: 2a198bbec691 ("Revert "xfrm: destroy xfrm_state synchronously on net exit path"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

