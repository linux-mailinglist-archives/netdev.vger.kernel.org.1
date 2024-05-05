Return-Path: <netdev+bounces-93463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81D78BBFE7
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A2BEB20FD5
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D295CAC;
	Sun,  5 May 2024 09:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8A6FBF
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900084; cv=none; b=XPTYGTBKdPGssVOGtYoZh5G+7ppelu9ePNZAT6rsieIXBPsaFurG8pgPyJFnqxFp7OWFOWRl8+T2K5N7OjhZauYjzV1hZBEbOtf/2NMWekhbjizbTsOeZZfKpuiMV5niDGRuXiyuv4dl0YmCZ4awDfMH3JzExwSvvataEaV08oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900084; c=relaxed/simple;
	bh=+kvNGsIf6cUqhl9egqdjJ1o07E9o3CD77g95IKWENsA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aolLKg4zJSwb5JRmZFpIX6OzEqkJbfDOYldmyhjc+8+R6ObA0DFeV3mtjeVWwiwtJMVxL1SVmGFxwCuMgEkrQvbCa/MMm0HwpnE+rt2c5kp9NFW0cciSlGrMJuJECo3/fyDslzgtBAG8U9Lr4KYDavfLX+0tWXgqurhl/7f0ymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c74ef7261so14124275ab.3
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 02:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714900082; x=1715504882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rR9uYo4pUV9Ptwo8tFdHdWFFeBKlQtLIoXS25vEOSGs=;
        b=OaZkRUjDZAj59FGugTcRWWBt6VBivdihpLJsIjMGIcsQkrMiELbMHuQ9UBKv22tOPw
         Fup1hvO+G6QwgyChGlZKtl/hbr2Ry+Jt57UlGBF5Aglr8Grz377y5CKPnv9d69gIfkrF
         rmiG1pHrJRUn3ykypIOAe8Q4cL71rvszL5NsBXhibz14SHqq6gi+7dpG0GOO/kNmKmbd
         KMdtmghFLF5OSD0GN7hLWSNW230KoUH4SfS7j3d0rCnRt36lfhA6PaZh9eKf+fOFqKS8
         XQOq+IkFjMejUTCtCqX72xitCF6zy81kpfGyf1zHf73IMMfV6QSYPhB/sEGNlVHQ5iTG
         ujcw==
X-Forwarded-Encrypted: i=1; AJvYcCXNqGYy2dzNzUW9C5owLLcaFXGGcLpjcqCNLafrRwORG9HqZXYGw7pxf1sToqjiGRTiUmHbO9dQSyuc05f/kF1LfVODqj9Z
X-Gm-Message-State: AOJu0YxGHTfcOEZN0IhJ4rbg8nL5yLek0vdpUF63wB9casxKiVgED02k
	YQ+/wPNaFdlMKD/hwJNt5V1em9MPNJ8/UGacqtVKfB8MTdg6sriCM4SrjjlLMPOdP1i0cgwQeBt
	RxC6D2FN922KehVxSxQLDHgNAH/Q3RUGVUd5DEASUchnd3TLmy4mKgnA=
X-Google-Smtp-Source: AGHT+IFWDqLnTzsRcrBxqd5SqG2JiVps/sd0xHJP5/WtobEL4if6t3mOAZ+eSHsaUwj1B9Z/mqsH4Khq2dJl5U+pVISPV2pV1l3P
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:36c:4cc9:5923 with SMTP id
 s14-20020a056e02216e00b0036c4cc95923mr405376ilv.2.1714900082343; Sun, 05 May
 2024 02:08:02 -0700 (PDT)
Date: Sun, 05 May 2024 02:08:02 -0700
In-Reply-To: <000000000000c430800614b93936@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bcdf30617b14ab6@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in hsr_dev_xmit (2)
From: syzbot <syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 06afd2c31d338fa762548580c1bf088703dd1e03
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Tue Nov 29 16:48:12 2022 +0000

    hsr: Synchronize sending frames to have always incremented outgoing seq nr.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133c15f8980000
start commit:   5829614a7b3b Merge branch 'net-sysctl-sentinel'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10bc15f8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=173c15f8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c70a227bc928e1b
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144d20e4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1532ab38980000

Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

