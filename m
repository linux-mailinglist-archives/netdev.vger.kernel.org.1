Return-Path: <netdev+bounces-189801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03288AB3CFA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F48B3B78C9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743A2475CF;
	Mon, 12 May 2025 16:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FA2472B2
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066086; cv=none; b=ePrnkjCo5OPPQragGrjtD508q7F+7wiojBxkFq+tdNmC7EZcBDjkSDo09WZzS++83zo8L86wXgkiSbupi/uEAJ/uxlO8yCvzCRdJfN1uatYM9339NYRz50UGhrHce1OEqdmIkglSjdxlf/A/sh1FiJuQ72Al0WUznPTO+PIJLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066086; c=relaxed/simple;
	bh=xf2gk/7HejFkj/yUD8Rcn/c3OEV9aXKrIeQoQwgUpxI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qLpeQsjmmDFh40V6qeBh5V6Bg+oahTqXKiIZ/I98H7qiHLzuj2CzSD4cjbXTa1jk8mJhY28LMlJEajw3Fs0qwOxczVGmgnjyxRVhC0RI4SUHJg/YqPwZ3iRxTLDKTlPTry7FWKm5z6RW2M0SbyC27UJG/7AdCodrnx3r11/YgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d81b9bb1b3so35633475ab.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066084; x=1747670884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gt5URQSkZsJi8HYjVkWgqYk5S7TJ2AVMXcD4Cuf60ao=;
        b=QgtWpD089vdLVxSsHV8MiOiTJ6TPMDFyHvkXfuPJ7VJJ+CrueRxhSOgQUMkC1ccCOl
         SBh37srfE/S+CMQgnuRF7/PC+cmkoaQCv6XTdxOgAfYVYlyXnsZ3rUpw0mWPiYyZ+MB1
         DHo6ykrsflkqe2/GoJ8U2v6NNI1iBO8//55U74CXQ7SdnMSK15YR5vAWKiQ+H11QwPmd
         K66CdTSP9unkotNHUr6NKHonDiixRvfW8UBs529n/B434fDcHD08FD+bW1hRvMfOOmaI
         RLLMhVgekWxhO4rIqzFc4PmYea/eqdZcdfJpUdolehDoYtpu68vKwURrWvHxHgV3bnM7
         O2CA==
X-Forwarded-Encrypted: i=1; AJvYcCVaByyQa+cP1x7jLABUjUYp7vjR9Ba+l0qsvai3UGyfJO+ndz/zDzeRUrR2JPxjsB6zFYp/FGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+w9z5u9tmvq+kTeFvPRU9kPGe7YJP89tYsNVwKtmvZILO9/ov
	sWRRwOcSQ8OXrxIUzyOn1vXV0ZyTGN1nYppsSOeticQEBtHs0F0spOVSSEmqU8UynVdVUfR31gD
	h8gD4S39tPCYeQKwLEKdgX0AyGh1jL4ehTK//erqdZoLTjjQihHNVTXk=
X-Google-Smtp-Source: AGHT+IGcj7hDDUl63wjXEO3+XruwNefnp47j4mhldFaZGFjrTH4hft3gln2ARkheFl41Vx6lpdU5XxwDw+Z9Lo0NO1Q33wHkRMQH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:3da:7161:23ec with SMTP id
 e9e14a558f8ab-3da7e1e1a63mr160273105ab.3.1747066084202; Mon, 12 May 2025
 09:08:04 -0700 (PDT)
Date: Mon, 12 May 2025 09:08:04 -0700
In-Reply-To: <66f18d50.050a0220.c23dd.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68221ce4.050a0220.f2294.0070.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in gtp_encap_enable_socket
From: syzbot <syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, danielyang32@g.ucla.edu, 
	danielyangkang@gmail.com, davem@davemloft.net, edumazet@google.com, 
	guwen@linux.alibaba.com, hdanton@sina.com, jaka@linux.ibm.com, 
	kuba@kernel.org, kuniyu@amazon.com, laforge@gnumonks.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lkp@intel.com, 
	llvm@lists.linux.dev, netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	osmocom-net-gprs-bounces@lists.osmocom.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 752e2217d789be2c6a6ac66554b981cd71cd9f31
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Apr 7 17:03:17 2025 +0000

    smc: Fix lockdep false-positive for IPPROTO_SMC.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140462f4580000
start commit:   9410645520e9 Merge tag 'net-next-6.12' of git://git.kernel..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c006d80708398d
dashboard link: https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16215ca9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110c6c27980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: smc: Fix lockdep false-positive for IPPROTO_SMC.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

