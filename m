Return-Path: <netdev+bounces-116985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7594C46D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527022888BE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC5149E0E;
	Thu,  8 Aug 2024 18:34:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B11474A5
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142061; cv=none; b=K6vkBL0BafN2QaXi9bO2tlCESTdB3xjU3cKHU4BnbD1wkr9btVeP7+DHAwqkkyFCGnu+86AE6TRP1Y57oOzyywUdJK+/f65+qt1tpESrk8O42pAM0CJOEHi0MOZg5GOXbpmQys3HxHJA1erKGHok1tSrI3VVdvTZ7IWKFcppJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142061; c=relaxed/simple;
	bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qH6WycJ8nfcZt8sMsAwqC4sbNyicVQWY/dgl4xPRnj3QDwZFit6davYTOcnO5G2L1wgaTVxakkztAv8OJ2rxYUpD/fdB2/3oTrYIOsJp7DZvBhpgtS8FQBi+GYmhMgsb2+P9YW8xoIl3BvcrbNWGmUibIgXxFCbrc5zKgkJ9sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a16e61586so16798985ab.3
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 11:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723142059; x=1723746859;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
        b=THzyLGJzRqC4m27Off3ZKd2ZMee/ih3fM33gDsoehO50KFKp+5qxay2wOWOgKDrJ6H
         fgAdTkla2fLnCFdS53z30ihT15F6kRRvfGUysWrNNDt57bU5cWQzQR+Hui6scmyz9wm4
         eoRd8xP68lQZPFtfzbDaIXjaPD8+PRIpSdgT5OBduP5VvLcoVkNU0fFJIcnNWAIwDyZw
         g/ruEB7EmfYIu9yUc7TtWfz0N4VNLNEd2NORqbM7EauFYVwYZgR1m5Wxckr1eT5dUUEs
         /by8naS2ywtdfREFoJNCoTcm3eCDXTi95D6iQbBVhotO53g67VjNiRLYYi+tRLrAe2Bf
         I18A==
X-Forwarded-Encrypted: i=1; AJvYcCWU3lyTsbJjfBaWTEzc9xOh+bV1pAYWf72/wGlHBfS9jsDXNQkrwnUXnuUSukkTDfOcPD0XS/c9VygdBjoPT0RFDtrqLMOa
X-Gm-Message-State: AOJu0Ywqe/QEk4GC85AQYdxlTH8+5o1eA3qe1IANVhEFuaLY8klDqOgA
	5eMPm4d9BFGF+JFIdT+ph9fe2Ow9IA8Xt7Ik/lkArJmI/Ea5EKGOpp+aXTMz+lumyuAIAHrO1kb
	xeFRDQ6K1vp4z4yaN3WApCmnM+BPKmQ8iHjAHtqw89P016J4wCWriaPE=
X-Google-Smtp-Source: AGHT+IHAVcthn4u2TYL9hCDajzn1SGYRWIlZ1iJ8RrmUyqA0kroAAagIT+VSUzy0UBJbPct5kqvmXxmuGAPeuYaVCIDisNoZSAJR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2161:b0:381:24e:7a85 with SMTP id
 e9e14a558f8ab-39b5ec6e4f5mr2414175ab.1.1723142058830; Thu, 08 Aug 2024
 11:34:18 -0700 (PDT)
Date: Thu, 08 Aug 2024 11:34:18 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000508163061f304654@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

