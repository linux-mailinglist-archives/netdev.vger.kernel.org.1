Return-Path: <netdev+bounces-88758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1C8A86A3
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6888C1C21787
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284713F44A;
	Wed, 17 Apr 2024 14:49:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0B142E6D
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365345; cv=none; b=fP28Od9UU1aYa0bKs3c+fIMxfpjkTbSUJn4CBCAuuYpX+o/WdYkm4pFXHQHILFLwrL8XTVzswkyuj/ISaGG10j3OsB98DcQZKha4zoRBTvcOldKtlwLCxVcADLXfCknEBxDPxCjPv4bplcYBAQhkOAAlUNe4GRilxTdnxJW4hLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365345; c=relaxed/simple;
	bh=arYAiaCB5bQDcWyY6Fg5A6dpdQ7egLODjHN2gDiOR4c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qZgD39BIxfAOliEOka8grWIiEqo/ArUZAYGE3PTN3vtVtazYs5KhODEsJ0F3UW+a4NRyqzgE1AsBizC6WFIf7KOM1PsO3zE4QqUojxhav3bzKhDoEHgAaYGMKpcpW2R6bpLjeveLgew9UOOOs5WQpDI1gnR7HKl6JKuPqr8/ByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so63074839f.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 07:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365344; x=1713970144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iLXNunqSNr8QRXcPEHq58jPUvBUNMYnjkVj+0AeDws=;
        b=heGJaB1B/vxorAjqXrRPbANM1DeaFw4zSgaGGSocGy6msq/BkXuv4ceyTEfF+3dZzF
         OAmygYfKx353uMfUPaf30fC8KxS2Hmb3wbAuve0oc7akQeJr3KYvapvuEWTT1Y49FAfF
         cZJDmyD8ujpD8YLeaUpyBmsJrtY4kDiKv8H/K01rzGHlQV7DqxNfInwn57ZrDQJDIusr
         +UsUoAJwYUE8xUtJ22bXLbile60TEN9VCpX2dhWn3ajIRIfbiIt07zSOfzFi+oxjoPJ6
         afVJ7chwRgP0rPpM9KePev8C/v49o5d8USftk/x75KuSVh0qh3sbCLGCikE8pDXhqqhL
         N3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVlZuePk6joO6rQ5FnkTwjVrR2VijeTym9A3sH7/WU+8a7MujTQ3sZWJ9rxCdqSSNjsDdcHnTk3WRWpI4qXceLJBppROSq
X-Gm-Message-State: AOJu0YykEc/bxJwcs8pGyM4Y7+LKzoqrElVCFm6eBFTkul2Aee1taijx
	2hlCbS3Nop1Y+/5P1AiBK88Zon6dbKzMK2P7R+m0XbfsSGxe86J13Ei/BBlXP0IOv/S7FuOcXij
	8PR830l3cnu8GE8BztfwT9W9xE6wPAvri1jqJvjw7L6XaFNsJKTkcBdA=
X-Google-Smtp-Source: AGHT+IG5KPWeJ6k7l1iEickd9TA7War8sUCpO4E/yTKozoCtWTn4mh1KzRpVsk6ZYxw9Y0eF2w0SQnmEkVvYFKet3EqQL+vJRrjo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8529:b0:482:c2c6:65b with SMTP id
 is41-20020a056638852900b00482c2c6065bmr1093800jab.1.1713365343174; Wed, 17
 Apr 2024 07:49:03 -0700 (PDT)
Date: Wed, 17 Apr 2024 07:49:03 -0700
In-Reply-To: <87il0huixn.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a693f106164bf4c7@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=125ea0e3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156227cd180000

Note: testing is done by a robot and is best-effort only.

