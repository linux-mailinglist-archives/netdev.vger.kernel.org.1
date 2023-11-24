Return-Path: <netdev+bounces-50680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB97F69E2
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA516B20D74
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97666375;
	Fri, 24 Nov 2023 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334BDC1
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:38:09 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cf974e87f9so10818065ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700786288; x=1701391088;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPLTnc8KvHWqsxcIPXp2s7Iad5LW8gL2my2v8cVDRX4=;
        b=a+OH2tvuf+4tziyLgkJcIaPZyENdr+R4dkCgh5rQQUjRLUQMBa02VqYEw/amccrGHT
         kJ+6O5sdEjSbz4D/XFsjWfIf+LScOWKUsDWY5M7uxhJFNVBaDNEHC/uwxv7G3NWoeLrr
         c7CF++iBv971DFuxi84xqwf2q/VfTRCD5ekGuEGJuZ+Adr2ctkExFoJNj5xqlTtbwSkv
         YseXltuRdnH89QYncHKqgog7FKCi2fMuj09+Ew4nhQ8vlt3BEAKhZTWV4JiM3F+yLh24
         mfodUGcLtO9rX0/FlOswm5V6jKJbiKvnkn44Dq2/CKk6mJSn2RnTiih1tmJ4egv9xSww
         a1+A==
X-Gm-Message-State: AOJu0YycHB9tmX5s7reEp7Oqp9avMmjOHhD+X+iF0pOhfe9eB+k87jQR
	njYi9g6lWJ9OZ2GVlz6uMeJkkT+9QaBc057ZsmpuupSs5f0X
X-Google-Smtp-Source: AGHT+IG/i1S1qxSA6e88vsKZWkSX6vhKxjX8h9mxmSMPbbTM6FrVEA9zYJvddT/18F2HyONTerLjCeEBKu6vOEGP/7EgeqRxciue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:b948:b0:1cc:cc77:94ed with SMTP id
 h8-20020a170902b94800b001cccc7794edmr247078pls.10.1700786288803; Thu, 23 Nov
 2023 16:38:08 -0800 (PST)
Date: Thu, 23 Nov 2023 16:38:08 -0800
In-Reply-To: <000000000000f2771905a46374fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000954422060adb2aa3@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in sch_direct_xmit (2)
From: syzbot <syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com>
To: administracion@diocesisdeleon.org, ap420073@gmail.com, davem@davemloft.net, 
	edumazet@google.com, hdanton@sina.com, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1a33e10e4a95cb109ff1145098175df3113313ef
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun May 3 05:22:19 2020 +0000

    net: partially revert dynamic lockdep key changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17cd55af680000
start commit:   feb9c5e19e91 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=142d55af680000
console output: https://syzkaller.appspot.com/x/log.txt?x=102d55af680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78013caa620443d6
dashboard link: https://syzkaller.appspot.com/bug?extid=e18ac85757292b7baf96
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14430eb9f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13738f71f00000

Reported-by: syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com
Fixes: 1a33e10e4a95 ("net: partially revert dynamic lockdep key changes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

