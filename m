Return-Path: <netdev+bounces-97385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD18CB31C
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EDF1C21737
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0631482ED;
	Tue, 21 May 2024 17:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0922EF5
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314105; cv=none; b=nqGW53RXKL83AJtEmZwum9eN37nonXrWte3evC6gWtQYxWb24EmIPBTM5+Q8wBJm9kEcLykGYKV1ElnYcOb5whsIzjisC88XO4p5FOGmF1Mh2JlcRTUud/23xm7V1Bc6Xvu9zoSjM13MlsMyqEtguxnH8TJDRqFs0PgPZ2qEKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314105; c=relaxed/simple;
	bh=zoIdtgb34NADuLjc3tV+N7aGplUZrQnoZrFXqAvUrMw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YE4pJYQ0cRDQ6/zpeRvXoFKkSAtqb3q61Lxkcg1k1bWZDV9t1LBxzIFNGlzHGunVF45W3VXQLU1xqWKui71ek4hDjN3XCMgtyJ/qmHPT2FrJmM9qt531q3BHmQ/qPOtGGmbQJ5xVwHf0XUeexWGC+B71vTMP2RtLxJ+uksC0O1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1db7e5386so1255148139f.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314103; x=1716918903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWWQLx0u45d0F/7cndUkioBv+DcKIil18vzCB0kWDY0=;
        b=g3Z43qsGTzQip4FQR9OvANthnGRPDNL4o/Viq4R4M5JGPPp2ir4vUUA6sfGpUDNTYF
         4LqTbSCHoQmUzuor3+w7KCuGNlnraB6t/5pXZn4QwNOOqo+Ot3cS1kY7/4RkRXcXgNgZ
         arvOfYHEYNFMY/iJnpUjY/3CjfqsyB0jxL9saRF70ZJ2Y2hthIzDVhe+ZQcmnfzAfWiQ
         1YWKCRx/ZKZUmt/xnQd0lnO3XxXtPDKNNwQy5g1qGpnlqEdAB90Uj7aUX7Gej6n0T07m
         CiSSkgBg+tKDzzR63hxyZ2xVKscreIbArY4VjANRr2AylzACt0LdG8r7BmzF3KyUVhdP
         x1uw==
X-Forwarded-Encrypted: i=1; AJvYcCXvZX4mFqqOqXvNrUmFu+Jk0mMyOIC/bgMFx8bxTdOaVh4sXzwl7AyAvmSwKAtmxwz65RlyX1YHyLPuEs7PzWiYys9Y+98o
X-Gm-Message-State: AOJu0Ywbb7ln6dQJRWmFlRL/xCBzDFbLzjK2jq0UlIMgqgakeFUhn5ZI
	RRQRF/9hBScFcFBC9g2IVRFzPq7/+LFt+yPC1b7aex/3ZPv7Mfp7YWE2EqKTs0x9Ec41VSHQW0o
	Sxm+Q23HBaShhx181Dy8cFVk8YHG5+3Rww3bZQls1ClZtkNl6ZIOsHWU=
X-Google-Smtp-Source: AGHT+IG8Ql4z9HzJhkI0jOEQuDwYKu1tx4wtIVtXYjZPGYlAVV52rq2rg+5tujQGh1Dx5VbozJX4mR6bvWCsHCXQtZv6kZaztANH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:5e26:ffb5 with SMTP id
 8926c6da1cb9f-48958694bafmr2302849173.2.1716314102929; Tue, 21 May 2024
 10:55:02 -0700 (PDT)
Date: Tue, 21 May 2024 10:55:02 -0700
In-Reply-To: <87o78zxgvq.fsf@cloudflare.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dab5b0618fa8405@google.com>
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/main: failed to run ["git" "fetch" "--force" "9bf55af7188d6db60300eb8cc78d9b6572cad83d" "main"]: exit status 128
fatal: couldn't find remote ref main



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1136a5cc980000


