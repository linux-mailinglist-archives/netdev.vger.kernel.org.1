Return-Path: <netdev+bounces-56403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E880EBBC
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAFC1F2155B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462C35EE6B;
	Tue, 12 Dec 2023 12:26:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6924F4
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:26:03 -0800 (PST)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-59127c4e538so1092467eaf.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383963; x=1702988763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IB8C7XyMYQp9js6I3u3+HREkfx35O/WPhq62642Tn6U=;
        b=DyI1SpR9Im3a4+9JSc0wwHOy8eEoiXRPlu2aYWZnT/LoUXYzeCGed5eBv+DcBJmqxr
         1u1xV0fVL0FCO6To8L3V2U/WTpBxrTfLARr+2+SHSgqJXFD+5QmTXlPlB3O4RwIdzoXC
         1JE7z+8jG0tN8H8/qZeJUkPcNK0N3CmOKuzmVPtEETqoJ6V6/vv3iVBfCL4NA1ctAwzu
         R8PbrVYhTTFUEXm2Tlo8WhMf+8CWDxuYA1Ehhl3G31doKxGJVrWrF4X+JV56GmsVwvTm
         Vwv45vGKo0wTzAI7g3SuaYATavNxLa9uir6JWOb1sD7yPb15lPUSfjIgDCp2eDaG10R8
         TOtw==
X-Gm-Message-State: AOJu0YztuRfVpmxcsPWwHMa5gWdwCOTimaZB/FzVsnny4eV6u1JH4dy8
	NJwGVT2A4dNNnh+rhvWbPar7KtPM0w+FAEwodJQm1N1ZpHtV
X-Google-Smtp-Source: AGHT+IGFW5g3e6mA+LgWx2H/a9Cj4ZanQsFcd4iCXcghjcM04EBeoSn1GE5TRIxUvox8ZXjQik4AEtVZhFon/5TqCSJsXq9c+Xd+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:3149:0:b0:58e:2832:83d5 with SMTP id
 v9-20020a4a3149000000b0058e283283d5mr2236155oog.1.1702383962863; Tue, 12 Dec
 2023 04:26:02 -0800 (PST)
Date: Tue, 12 Dec 2023 04:26:02 -0800
In-Reply-To: <000000000000e7765006072e9591@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060c000060c4f2747@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in task_fork_fair
From: syzbot <syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, 
	daniel@iogearbox.net, elic@nvidia.com, haoluo@google.com, jasowang@redhat.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, parav@nvidia.com, rostedt@goodmis.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c0b21ee80000
start commit:   2ebe81c81435 net, xdp: Allow metadata > 32
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c0b21ee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c0b21ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148b2632e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aae88ee80000

Reported-by: syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

