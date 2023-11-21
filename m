Return-Path: <netdev+bounces-49600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB52F7F2B08
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B34281F3A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490622D603;
	Tue, 21 Nov 2023 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC4CC1
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:55:04 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5be09b7d01fso5902421a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564104; x=1701168904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MucVPlPO96ILTl/BV8ROPTsisZcP2/vhsy4x7IWNNfc=;
        b=xGtfPHZO6pc1vMxg+TbmHgSEszJWrTSfpe2ZDzLiCx6BMEnqvZHOJiKZ2DqvzqpXSm
         OcMSvpT2oaRyS+dM8TalK7/JS7oauvv9arUuCrwTOuPiTJi70MHUq8wk7oG5RDs44+AZ
         jMLCtm+iKdHEiwdEsO1eWiDXcaQhtHsTKjeGFn+3Vx2e1wswJnuT38TscnBSltuw+UIE
         zuIBc+v88v+DdGTNRWjLeqjglDiUWyOOd9CSWz6k7HMnbbLiTWKINJBSkIzM4/MStU7t
         dcoRvcHTld6I4MXbY1HUi2HAO2109o79wS8GvkA1R/+UEGbt3o+xd13erUQ7P9Bjk9Hc
         +IYg==
X-Gm-Message-State: AOJu0YzYeuC5Ua/sknrLZaWw0s8fRa+wiW0jxQAz8Q5tTFm2NeY3dHJE
	ZejSG/cOETem9TdBgQr00ssETUMx7vmnuxPkoWGuEPW9ugVZ
X-Google-Smtp-Source: AGHT+IG8ioXPYyO1oJsiFIQ7AFgEZu9Y+SvUceib759BZiDwK4pCkyKZ9Fnjg0bhNBDSdS8gRMqei0g4IcW2h6EnHa/2dyw3Kq/b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:9304:b0:1cc:20dd:8811 with SMTP id
 bc4-20020a170902930400b001cc20dd8811mr2954783plb.5.1700564104429; Tue, 21 Nov
 2023 02:55:04 -0800 (PST)
Date: Tue, 21 Nov 2023 02:55:04 -0800
In-Reply-To: <000000000000959f6b05ed853d12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ccaa8060aa76f91@google.com>
Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_rfkill_set_block
From: syzbot <syzbot+3e3c2f8ca188e30b1427@syzkaller.appspotmail.com>
To: brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com, 
	davem@davemloft.net, edumazet@google.com, faenkhauser@gmail.com, 
	hdanton@sina.com, johannes.berg@intel.com, johannes@sipsolutions.net, 
	krzysztof.kozlowski@linaro.org, kuba@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-nfc@lists.01.org, linux-wireless@vger.kernel.org, 
	luiz.von.dentz@intel.com, madvenka@linux.microsoft.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, scott@os.amperecomputing.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 2c3dfba4cf84ac4f306cc6653b37b6dd6859ae9d
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Sep 14 13:45:17 2023 +0000

    rfkill: sync before userspace visibility/changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d68677680000
start commit:   ae8373a5add4 Merge tag 'x86_urgent_for_6.4-rc4' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=927d4df6d674370e
dashboard link: https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1099e2c5280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113f66b1280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: rfkill: sync before userspace visibility/changes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

