Return-Path: <netdev+bounces-46581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C517E5194
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 09:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F782813AC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC27D51E;
	Wed,  8 Nov 2023 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB93D51B
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 08:03:05 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545AE199
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 00:03:05 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b2e4f3defaso9032634b6e.2
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 00:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430584; x=1700035384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLxkoJ0J2bDcVFhjdD1ByIlE66SDaLG2rCYjwFdMcfw=;
        b=miK/p+Ysv9n7ItaaAL/TOUo43BgGTCHK9L0sD5apIlHrD5zuZxpIZzcByWiq2/9Sdp
         Vrfa7kv8nry3D05/9ChPHyeRH42W0vs4DoQqIjwS36ms/djiE1tSvDhz92Fz0PUgj0eP
         PL4ZeGWCjoVKRA+nk22/jBgJ/Dh+gwIIadlvqnFPHjO1E+wrQvM+U0FbI31zWdqHpncU
         p3plKmlJkcYRDEiE29ljvziNY7hf6KGIZ6jv7OgwxSTcwjz1J7/6bWf9drGC4Zob2fu7
         qVoJ5M2Z+S4gGLf208h6UPheyjSkpAbBiQVQ1K6vmwncA1eH8dMr2vO0gGOUOoA4zBD3
         CpOQ==
X-Gm-Message-State: AOJu0YwYE0xo20PFehkUl6SgwfvvxS/LjUSTmBfdoqwkV8A19HuEJedb
	wBkmPc7vt8m2qysKHrc+97SurNRaLcvqE44MknSyWC3ZQs+G
X-Google-Smtp-Source: AGHT+IFaX5LC4+c28UiyOy/nAi3zs6InloFZr1OolB/cB0NXkbGGJtuSl1zjrihF1453Xy0W+gcaNotbRS9cwtvEwE4TbRPga8XM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:201d:b0:3ae:61f:335e with SMTP id
 q29-20020a056808201d00b003ae061f335emr581414oiw.5.1699430584749; Wed, 08 Nov
 2023 00:03:04 -0800 (PST)
Date: Wed, 08 Nov 2023 00:03:04 -0800
In-Reply-To: <0000000000009e122006088a2b8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053135d06099f84a3@google.com>
Subject: Re: [syzbot] [dccp?] general protection fault in dccp_write_xmit (2)
From: syzbot <syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com>
To: bragathemanick0908@gmail.com, davem@davemloft.net, dccp@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 419ce133ab928ab5efd7b50b2ef36ddfd4eadbd2
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Wed Oct 11 07:20:55 2023 +0000

    tcp: allow again tcp_disconnect() when threads are waiting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142a647b680000
start commit:   ff269e2cd5ad Merge tag 'net-next-6.7-followup' of git://gi..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=162a647b680000
console output: https://syzkaller.appspot.com/x/log.txt?x=122a647b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53cdcbf124ea14aa
dashboard link: https://syzkaller.appspot.com/bug?extid=c71bc336c5061153b502
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142bff40e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1559f190e80000

Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

