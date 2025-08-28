Return-Path: <netdev+bounces-217624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0080B39513
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CB57AEF48
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1433E1BE23F;
	Thu, 28 Aug 2025 07:25:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221321CC61
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365908; cv=none; b=LS92yLzdJhCl08sWm0XL9NuNzpXxy8dGLbi5OX7Fpyya4i1HGI+bJ2ZzvHfqZMOuW0szzh6OUv/YKResn5eQX5X01ipIn4KhcuUdi1R19fsIOZ5uf0NMx+jVGbxxOWbBA5+ecT1u0ZrO1CkE//NUJ3zi9fPAPFcY42HjMrqJKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365908; c=relaxed/simple;
	bh=npf0QIT/KRuA7Bi+QMNHPQSmHldMwRfE3wBwNzZOmjo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eNxOk1qAVVWhuCHE2kgr3JtDEHvuNNqpYw44EJcDaDmS+hPk8alXg9YIpFev+OAxlpeF+WC6VQHPVSb8RsDKgveNfff66YSweJOf24vsvB45CM0oiZSh6AHupoPjCK2yWSqHcTOjZRz4k2aQ1r5F8BmTyXUXUTplbB1An1Cn694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ec58544f79so17278145ab.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756365905; x=1756970705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqGmcDuCUYT5pUJBrH/WD7wjsTBZKETzC4/f3FJZq/U=;
        b=D+gfCX8id13JoHxOyETkkkGdnI3YJpm9br1hhIw+W7+Z+MsnnTT4sfauEBbmTE/yrQ
         Uh+n862bzA+Gd4amaGD6zf0UF4pWrHdJ5qgOd3MnAyx4DeXh97Ny+OWhtd3fNLOgLB8x
         VaxT2cqkYI/FEd6PABbJA7OWL1jRc9NhtpTa/2Ocd3rB3Uu5QkSdn6f+wc2NgF+sFVSr
         YD9mlQwhm9R014vFPqUrBwncpt3t5OEg2AIepJIf4RzEjtwogLtCXrYvjN4gYMnKB+DZ
         rKGqep+U8WKSRCt+bp6OhDHqCTBy6OrxS6OPNMFUB5CzFjLkXZKW46X+mjeurYnaKvc2
         7iFg==
X-Forwarded-Encrypted: i=1; AJvYcCUyaDIKsV0/ZoCeTnVg24gnIjNxRZaFGz0/Dpuv/LHsD9qKJYSmmKQp3mp1SJzVP+92UoIG8Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPhgXGLq4QYv+hko2Sp69V4OQoC6vno8W8kMYqzrNFg+d9DJ5
	CdcIEBidryOSsqnsDNoHJS5RQ0sqUmUqmgaiHUb6Fiqi+MGLfV/bLoTxElU3NDcNZPkL/ppaRQf
	yJBdThwj5E/Dfk/tDy5OEitVFLx8fr4KEIUwWYOlzCFQmKB4RLlu4hErt/uM=
X-Google-Smtp-Source: AGHT+IFD+k6Kf9CmErzSy5h2PCHLn9sY9JNYNfLpfK56pJEZrEczVu+wml87IC3IPx1DwZ/4AhE0mnIjg+xv5xMUikNKB3iogipw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3087:b0:3e9:8a9f:ba7a with SMTP id
 e9e14a558f8ab-3e98a9fbb99mr266834845ab.21.1756365905733; Thu, 28 Aug 2025
 00:25:05 -0700 (PDT)
Date: Thu, 28 Aug 2025 00:25:05 -0700
In-Reply-To: <68887370.a00a0220.b12ec.00cb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b00451.a00a0220.1337b0.0003.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, edumazet@google.com, hdanton@sina.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	saakashkumar@marvell.com, sd@queasysnail.net, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 94f39804d891cffe4ce17737d295f3b195bc7299
Author: Aakash Kumar S <saakashkumar@marvell.com>
Date:   Mon Jun 30 12:38:56 2025 +0000

    xfrm: Duplicate SPI Handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d07c42580000
start commit:   b1c92cdf5af3 Merge branch 'net-wangxun-complete-ethtool-co..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14307c42580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10307c42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14221862580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159fba34580000

Reported-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Fixes: 94f39804d891 ("xfrm: Duplicate SPI Handling")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

