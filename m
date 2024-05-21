Return-Path: <netdev+bounces-97402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486BE8CB4F6
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 22:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AB6B210E7
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 20:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4882149C66;
	Tue, 21 May 2024 20:55:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD301494D8
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324907; cv=none; b=k7pOrqtddEm4A6rgSH6uixltABbRoUVtMX4bf2WTguueAceo4Mduwz3UYg6g9KIHaJgXmcOh92o1WNGqv/DC9N2KZoGj2D1Z8j0Tntqyieh0VIiXiTnn4fckiKa6oHzaZq7zH8KFD6I7ZWnvJBR0Ot1i/mYmK1Mzo5oVc9GZbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324907; c=relaxed/simple;
	bh=R3fCvTgotTxLXsi65QkeFqLB7siU1DAP4itw793zAbc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GW6aGodPCVvNLKMPvRE3N563Gu/Vm5J35ripVldID903+PTKEUB9Vtn37/PQbUngiVJpOMRgCSOfkiIZ187gBGDNEMeUNIPSNSnC7IFHcA+bToBNpPm45IurJkH7NaTib9ywhHUE7OCwdJdzEr77sLwiTQXKR47sxmdD7ZEZICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36d98ad0c7eso689305ab.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 13:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324905; x=1716929705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEiS+NAbk5RMjDOg7D+8NkoQTQW7Txc26tuIznMSR5s=;
        b=JLDiYRdj85YqYV3oNZ02EEGx60muCS1ZSDjCBPIV3qAuLlYcsTQz4PI9KSdpO0cVBS
         5uShd+pyeFYAH2XsAG4TwZdTmss8sqV5gW2Lwt88BB0nwF7oTT14grOvm3Mu/KN6UCYQ
         hDR0bZ+8YsjTvKBr6ox/yJKckHyLjbVw3OXTu7tMmrHX4ao6ZxRQk/Pij7Kdx/JjBAAC
         HjgOz9vU3libujW9X5I4+i4M+36bfwCjpAR5Y4UXJB3AUl3jOMK7YhTmLUfbaFxHdIk7
         T0VXu1/rdZgZ6NWvj4VzQkDiyPAqY6NBZQ4ldT9TvZaso1aAeF8IzMsyCxTQlqpoiE43
         kLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwgDIvbR6B5pe2ri+Fs6bbO5EDfh/jyk4M5JQhaXp05wZ9yGNrajQ5s23xnBOiDfcnCp4AMW6oSJhERYjL1vGRkUoStUs6
X-Gm-Message-State: AOJu0YwvL+icUoLWSETuLHSrs0flBKW7Xck+dm5MLF7Qv105rkqrFHxJ
	+NjNrsoClJPblBLyRDxAQeTAK651k4LqPGjTO2mpMoKjayDc99YF7nZBLJx6ahUe7l6jhFUEdbU
	h+7msV2bsZRGvRlMjw0ZWb5wNcRJN1DXAoDUrJ9/ZjhkwNzQMl0OgHGc=
X-Google-Smtp-Source: AGHT+IF7myKplMlP2iRDvN1xabnHS0FA63h1KOBMghTZeFYqaElRBXr7o65M7k9nw8WSfPfwjJ6wDj86smTt4N+eBmVJhPMRD2fe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:36b:f8:e87e with SMTP id
 e9e14a558f8ab-371f6e0e1d4mr205215ab.1.1716324905771; Tue, 21 May 2024
 13:55:05 -0700 (PDT)
Date: Tue, 21 May 2024 13:55:05 -0700
In-Reply-To: <87jzjnxaqf.fsf@cloudflare.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053f7c10618fd0878@google.com>
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com

Tested on:

commit:         8d00547e MAINTAINERS: Add myself as reviewer of ARM64 ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=133dc97c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11caabe0980000

Note: testing is done by a robot and is best-effort only.

