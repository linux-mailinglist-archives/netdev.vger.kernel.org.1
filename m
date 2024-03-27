Return-Path: <netdev+bounces-82666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00688F025
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 21:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB941F2CA8D
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FC7152168;
	Wed, 27 Mar 2024 20:32:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACB152E1C
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571525; cv=none; b=EY50jYyQE/CGgaVYduSeYKXRhWU51+HxeyZe+Q2GFTfh5rcOPP3ZFglcV/2fXGYnVxZpxBxOQne3OpGtlL37/vOodsNjXa2ulwsR95jq8Ha3vidaNZmZbtKrft8Bjn73z3quFv+TH97P1RZHihtbEy89W1vjOTp8FGgOrhJUjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571525; c=relaxed/simple;
	bh=nRwlE/hA+5kIdWWS/56V+tZqn6E78CxeZd1m1w7AwQ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NUY4uuF0lEdO8fVCjiGETWHWrZHZOYCxNFenEISyGoH2qdbl/zoqbO5CjCy6wNhgbW5DHm0J3NFRMrCMtc4x60+u+RzK3tvvG+HsFzu6q9lrCQfrlrJxatIiG7EJka+J3OXvWFZRkTQvAboqJ3MAfgZnC8L4dmAUlYD6DExhmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c88a694b46so20704639f.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711571523; x=1712176323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrIQKBS2v/d7YU14An08GRjqL5ZRUdHZeXnpNFfQdUk=;
        b=FIDcLKz5uQ0K+4XX18ICQGkecDzl3aZExMKH3j/LdvAFawLgfGBsSw2jPgNThPkXj3
         k1wxSRlmUBMvFePoMni+Rg7emxk5hPYS0kIz/OvAvdZtVunegOFORy/6FUzA1aSoocd2
         pYoHIFsRZPqaSlvlxRTlHUTaG5AJz0ZvK3EOguBw7xiG/dHxuC8B1zKQsYlAm8t9j0VP
         NRJok2R9gQSVz6QBlJrPiDBxIn0u/OzIEzefLC2EsNdBdSA61s4Om1/y7MPfcSeNEDh4
         zo7Dimn6wbIbZa6wilhWlAcAXSfZGU+cEg8SmUcO/P30iDGtef4DqbyYwQJdm9tqs9Bx
         yQUw==
X-Forwarded-Encrypted: i=1; AJvYcCW10MhfOs27espGCdZrFlCAwWGmjLvc1t/KyqnjwEvQu0RNgvKv257a08JcFhlzh6VOLGAYihmD6aP5aOWUwX8rMP+T8IGE
X-Gm-Message-State: AOJu0YyL7tWoSvFQ73K6AeovapCy/GMrBaKDCqRaDZ3iGhSBLjMZ4Jvd
	oUkD/napkIRz645ZsDdDSO26QwEgVbVQnEL/aQfOj0rRYt4+RvEGaQxYuM6+9lu6YWd6LWCK5bB
	pwJeOV0TLiAkdbRaT3TfLJYgVULMGoWtH1kQct1wDkx01O8gzLrpWotQ=
X-Google-Smtp-Source: AGHT+IEv1GS0F1bIQIoueTKC7US/um1YmwFLw785Q/O0DHu40YUikpwnw4dFaz1J6Vc+zuxa3ZZur/MOvmSybjnXmQSPHjqMWXYb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d81:b0:7c8:c7ec:2b71 with SMTP id
 k1-20020a0566022d8100b007c8c7ec2b71mr4702iow.3.1711571523139; Wed, 27 Mar
 2024 13:32:03 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:32:03 -0700
In-Reply-To: <87le63bfuf.fsf@cloudflare.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a50cbd0614aa4ceb@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
From: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d4066896495db380182e@syzkaller.appspotmail.com

Tested on:

commit:         4dd65107 bpf: update BPF LSM designated reviewer list
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=116d23e6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5826764df8e788a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d4066896495db380182e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1593c145180000

Note: testing is done by a robot and is best-effort only.

