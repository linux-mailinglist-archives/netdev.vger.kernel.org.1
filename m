Return-Path: <netdev+bounces-88958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3188A914E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 04:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DEA1C2039B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D35464A;
	Thu, 18 Apr 2024 02:51:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3E50A7E
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408667; cv=none; b=YhyfWMzroTZWjC7yOA89hgkBmWRL8NXGyRbwqWvFg9Mpw72Hiky7UuVpkLmigOAfsAeg1rI5LwrWRAJoRQ+T5Tsyd3P8+8zbuJ0PPcrxA2aVsDeqocgh2yUHcGIjwd1QkTxlHF3hNie83j8l3qWYy7+wf6gJwHDVi7rHggkuyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408667; c=relaxed/simple;
	bh=kemaksdsrlIR1S57gG0m03aOcevlas0sdvRbHQ9Py28=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dakCghZ1S2FV/F1qy/eaeN8uDas+TQQIhsoUMaL3YKn1FavgYBJTdtOWBjuKCecdcyvy3YoH1lh/7hMg/0pMmDLuY1JiWnOWxt+kinX+z7FXEs88+lPFwYGCZMaIssRbAJxSrKwrrge7Om3fakxxoikKGn5Sd5VwQgP4Sg34hH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so62576139f.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 19:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713408664; x=1714013464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ikh/8IxQiRxUmOZmfpOtSXJ4MJQsJVrq/VyspE2r/6Y=;
        b=BCZNzcJwhXIEi6KR8GlJihrHfaqgeft8+uHsGezFdHxOOrbXkVTilVQy0o3bDUUEu9
         g9fFpXUAEZaMXZi0ucd3Ezl/h6br024BJ0v1vSSk0Jr5zLV0auDjmRZRIiPorDO8PamD
         8fZH+YlM7Zfb+ffY7G4E/h5nrju5+uOeeJfg4TTLgKJiV5UA2/wXiQdbo7rd8n82pwU5
         of52DlIQ5UgY+yFfWZzdHLEP1K8PLmgO4PjklS4yPwbHhR8lRZFCG2Hk3hJCW5ZgngGg
         rkbBwF/ZFRoWAeuNiNoS6X1dNZA4NcWF/yR5xqDsI1XKoiAqvGJuF6zCXyPhdOisrDxu
         BGlA==
X-Forwarded-Encrypted: i=1; AJvYcCWf/4NUHoVm2annvDZcgN2u5wU2Y7L8EkLqLINm6uKxFxj8czycnHHIeQ/b47hp1O8I4gqUMEcQTcgaXFPjZfxM66bXQ8f2
X-Gm-Message-State: AOJu0YxK7Z4STIS3ZmD+zxHhiWTNx2nYKFS2Ml7eGGOD51h7GC1Fbpwe
	jhUzdYrpCq5PKDBGqmoIZ7dD+pdlcPTG8qTEGNNQ7//rkcNklFm3TwJHhq8KRv+Y/g20uX6eKev
	ie5+vfLz+0SwCkVJAj6e6DCOFaHMxZHutB+PUjhXse0v0MDr0x0KyiwA=
X-Google-Smtp-Source: AGHT+IEH7hcoKAZspDMi2dP3VJIZw+p013dekRsehXW/X7ylh3IrZDuqB98iGe7Y8ncILxLfuz6GLvx/hTAlufONhdsfcuPNRCmR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378e:b0:482:f06b:70d5 with SMTP id
 w14-20020a056638378e00b00482f06b70d5mr77102jal.5.1713408664122; Wed, 17 Apr
 2024 19:51:04 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:51:04 -0700
In-Reply-To: <871q73vlvj.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7cac10616560a93@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eadavis@qq.com, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	toke@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com

Tested on:

commit:         443574b0 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15d5b33b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bfa653180000

Note: testing is done by a robot and is best-effort only.

