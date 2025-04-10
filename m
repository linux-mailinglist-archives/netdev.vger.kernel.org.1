Return-Path: <netdev+bounces-181275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5CEA843C3
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E933A5F3B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39FC284B51;
	Thu, 10 Apr 2025 12:53:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD702836A5
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289585; cv=none; b=AoObaTsbEVFyzDh0k/w2sL9+9ZR98m8qevwbN2GxR+xp1yBxl298d0SqUlhXFEYOCoIyGrk015YK68nE2wW6fZfng+b8jqBMzW2JdrF7xzUUGwhjuew7PzKvQVqVfqDgzASD2dHLpyodxZonoBztAB46DlqrkT11SWuVzA/eci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289585; c=relaxed/simple;
	bh=vDEmMGrUTM8yYCrPqwhQCEL4t02ezZbeVW8VUbU3L6A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PSKanLkZM3KWUt5e8ifw6r4yyxsSdEaA4yuIalT9gVZCx14sWHVzLPBzLz/cR0ijmPyUrLeaM12QYATG/vHXx8MQTnysWnLkpX3FXylfmyNZ3LoMVPBkqkYpHhBHrYeM/flGin8aHTwvkg4jRsM4fPxDjXnPeYer/8WiUZ68SHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d43d3338d7so17073355ab.0
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 05:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744289583; x=1744894383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwjKGeyplOihDN5WsNx76P9DgKNh/A9aQGFHVxRsKGg=;
        b=r3aIL+YIcMPMm8AFuIgmAjQ9q9ONaotDAuEloGogSbThLdWPHkLuhxhfzG1AjVKdGm
         BOYiJhEpdM4wF7XBzmA5KEoFh4BUBsp6dG86z4NSh3oV5xLVXm6vBg2WYhACTDpCz5Od
         UQS/fFoPafoJqaQjeNaZAUpQyyCV3vIqujbd9NBKE4uf2oZ5MFCKUoelloY8DgUhchhV
         Qq0l4hqK5u0vpqkF/yLHRJtqMGyyVoUx3XE2Wvm4So02gUwGyjFv/OP5G4EvVWs2Nazf
         4q295wP7QDeitWqYiHHutkrKQdS2V1LIX+BCu7C467HzW0cEwrwvJrxazl8Z3h732RPH
         cAeg==
X-Forwarded-Encrypted: i=1; AJvYcCUVuP4f4QyfyLdfeg/+uBA/WedafjAUtp/eeMWEQd+2hoQqAKWfSd8aBer2yVOePDgrkhPtO0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAuJqpDsKqegNTlfQhb4D3Ekbt6Jns3UmPsbCgy8+axboT4Z5l
	lCeFUwe5vzJ+1ICpGIAF+2ljEyX+ZO5etAFBGLSXZtGJqYOE9xbKp7iRDMcJ/3EbEZ3460lXqVR
	khE2JPJ+UBJk9s1/iVge+e0mGTo3PBd1jq8NTABma4UP7xgXStnp6qdM=
X-Google-Smtp-Source: AGHT+IGKKvMad2D5Pe7llo9yGvnZqkSWQ75yF6Q9NeHzwi5dN9/T+3XSEVg7DE3sdhjQgF2SnCDod5Ae6v+BONjR4ZkMlLmcJfpQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2588:b0:3d4:2306:a875 with SMTP id
 e9e14a558f8ab-3d7e46f8e1dmr32898695ab.8.1744289583571; Thu, 10 Apr 2025
 05:53:03 -0700 (PDT)
Date: Thu, 10 Apr 2025 05:53:03 -0700
In-Reply-To: <20250410123831.1164580-1-memxor@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f7bf2f.050a0220.355867.0001.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
From: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         e403941b bpf: Convert ringbuf.c to rqspinlock
git tree:       https://github.com/kkdwivedi/linux.git res-lock-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f46c04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea2b297a0891c87e
dashboard link: https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

