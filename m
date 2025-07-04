Return-Path: <netdev+bounces-203957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE4AF8514
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 03:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E413B2C34
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 01:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A5272612;
	Fri,  4 Jul 2025 01:12:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352D1EEE6
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751591529; cv=none; b=Cow1AdxhK0yaJf8gmFtzq0TA7aLx0Z4yh4D7aPK05yP4g6U4hGQyWukwjtMMSupNcmMiUnxG4gLKeWwXGq/ePWJ79mU9iAiCzXI2Ezi+M3X76Q17CfUpq2gMNUbKUDzDvIthB7DgCyZ+uz9tV7BqXLa6FIoJPqmVgQ1Hbz9js4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751591529; c=relaxed/simple;
	bh=v4ljxXh9jmLHKzoGwMvcVw2+anv/viIoaS532cR4bqI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nSMkB0TSgNxbflutDE3oaO6IyiMGggh7ubc5SH2ynir1PWjLtCaLWGa8DsdrfWIyUZ9E2lz1I5hyZTToLdHMwwy0Z91ZyPs6dsl8iE4FcLS6MqpsTVUg5k/ccBeqBDRz2hmsY+h4YqKlWdsmA6NuYR7rN71O1Ppw+A62SzilBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df33d97436so13703835ab.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 18:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751591525; x=1752196325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkuOwkFiGaiAuFJlUywvo+QnqLqF8JrCZ3yBHoZeImQ=;
        b=A8YzKaE8PPz0AHAwDLE+EJHOLVuKCAsA/xZf57KDtsvAjBxN2kV/xIJonKBbQt2G9M
         03EFnDUBrP9GZLlvGP7BEqMBjeo/PDvccTDaa3TIoMPPnPHeq5mAd91J8jlJIXbovf+H
         XcRCef8WLDAFkcN3VUpJc2WlHNtosJRu0LjqD5rLLTGw9QIe8wn9QkWTaYBlUujDDhGd
         SFvRmClM6IMpOwzzeM1ZIJkm58+GxCCkZexM2fcyKOyoXX8UlHY9Y175ja+JAKCYmgj8
         7c4cwyuofG2voJygu2GrZrN9wwmSZUA2aM/n8tW1K3rA+5GEQe7LYL6CahnMWKPPsKlU
         gc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7ww14zDKehZitwDraH5f8wTVmMZsowe4W976qYuYwRVgLrUMFRVIAV6t1ktwULtPuCZbF7Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwfSrkeT8MvR0wPPVwpZ6yDZswXAnjdS/OUCDAdy1J49GOPTx
	fLWjahNNv2DjzX8YwRQIoiLD6ULmj6ob08LAsEe3Ywgy2KnzGYb6Zym/0sDwD/tHltp+VeFTvXy
	ZmHE8OfRW5pOkClTfBaICGU7V3kfLFiQE0bD9N1pxzTt0lxn4ETg1VpdnkGg=
X-Google-Smtp-Source: AGHT+IHwNUtJNYBWi9dh6hlhmUWt01g4j478p8KSAzt2iVqzGD7y+FBKavq1knyjjnEO5w2MgU6suKIGkQtwvL2xzu7Ovu7k6N+J
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c52b:0:b0:3e1:3491:e873 with SMTP id
 e9e14a558f8ab-3e13491e9d2mr8427755ab.10.1751591525652; Thu, 03 Jul 2025
 18:12:05 -0700 (PDT)
Date: Thu, 03 Jul 2025 18:12:05 -0700
In-Reply-To: <f14f4c0f-dc5d-454e-b5ef-1143b5a8f512@mojatatu.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68672a65.a00a0220.c7b3.000c.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in htb_qlen_notify
From: syzbot <syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com
Tested-by: syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com

Tested on:

commit:         223e2288 vsock/vmci: Clear the vmci transport packet p..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16685ebc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36b0e72cad5298f8
dashboard link: https://syzkaller.appspot.com/bug?extid=d8b58d7b0ad89a678a16
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141d8c8c580000

Note: testing is done by a robot and is best-effort only.

