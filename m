Return-Path: <netdev+bounces-44092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98017D6168
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899B9B210C9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB98836;
	Wed, 25 Oct 2023 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1AD1FD1
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 06:02:33 +0000 (UTC)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611C8A3
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 23:02:32 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e103f22f74so6540621fac.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 23:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698213751; x=1698818551;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wii8E7zHSEDik3+/ZAl9Uy7hVmIz0evyew93pf3levg=;
        b=T6dsoDMKeQdCNmjlmBoKTOlp0QH5XOYtvjeR3cWLOH+ZfR+oEjZZRCmZdyG2t7q2O8
         N16YkM/zt6JkTTb6vlFDx1i1X0jvz9wIRd4abmXDioCsPdHkI41Ky1uP2O8V4EvZBm3Y
         Yd/vVBJyybfQkhmpfbFZrUQoFC9wLp8c1E7Q70pM5t1QO7HfUOKW21F0fi75awGsRGzy
         KPjYrQoPxwWTjEifS4CcOtCkwor+GO8303w5E7phXmfosZMDvVv7mu54asrtYZMTKqYy
         zqEPRnHN7M+dKRM2Idg5qQVsNiIpgICvlBDKh75PvOx6k/JN7O20k79JB4V2Jk1ywZ4R
         uaDw==
X-Gm-Message-State: AOJu0YzYrM2J0oVGoIgkcnDNkZnWp+7OiAQ2g3gxVuuqiS/C14jJMK7h
	PK/aQ4mTKZCfc5w7HfGL8EcLgVobF5YYkQqjWGN45WBLDCPi
X-Google-Smtp-Source: AGHT+IHssJml8McZlRux6ZXt3VOeHacpOyLeRKgWH6j9CJmj9sveOQS0uWJF+F3U2CxWMMjmBub9b2Hx+0PMCfEE4WJkoUN7Sz2i
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:472c:b0:1e5:7978:9ce4 with SMTP id
 b44-20020a056870472c00b001e579789ce4mr6743294oaq.11.1698213751574; Tue, 24
 Oct 2023 23:02:31 -0700 (PDT)
Date: Tue, 24 Oct 2023 23:02:31 -0700
In-Reply-To: <000000000000e8364c05ceefa4cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a55890608843368@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_session_activate
From: syzbot <syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@rempel-privat.de, mkl@pengutronix.de, 
	netdev@vger.kernel.org, pabeni@redhat.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 259bdba27e32368b4404f69d613b1c1014c07cbf
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Date:   Wed Mar 9 12:04:16 2022 +0000

    vxcan: enable local echo for sent CAN frames

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a2e55d680000
start commit:   84186fcb834e Merge tag 'urgent/nolibc.2023.10.16a' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a2e55d680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a2e55d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1f30869bb78ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=f32cbede7fd867ce0d56
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c6300d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e6935d680000

Reported-by: syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com
Fixes: 259bdba27e32 ("vxcan: enable local echo for sent CAN frames")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

