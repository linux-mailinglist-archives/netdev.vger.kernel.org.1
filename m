Return-Path: <netdev+bounces-125366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA096CECE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4FFB256FC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 05:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A7188A31;
	Thu,  5 Sep 2024 05:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737479E1
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515825; cv=none; b=JlxiH51MTGR5rFuQhay+16AXjQFNgqhZT3wOV1ry85ziLyBe6EsajKl8Que0zrr7k4F4iX6iaK4Y1c9+MYn9l1RR9OfhDM/EZ3vv2DBNlOgJPwUxhCRkmqb68euMSzdXzEnNhs306VIwg49MvpMA6eTqIfOwAYuk93Zma8cNQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515825; c=relaxed/simple;
	bh=pyUAhBX92buKhrzsf2G0r/M8qmQA7L+1+Ncg4M7/daw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lOVZTTGjEibW2TKK2HlRheWBDK67HxkMUpZbUWzLtNTOICLwyVd7159ZBMMxaBxhq3X3SxsF8OiUzqFC3F9o2kXe3z7ion22lz5rRa1lJUV0nRM4sduXQXChGvVhiJZpvKlhrSRq9BTBKZWns77n6JLAsXUuzlxXigVRwlWzHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a043f8e2abso5632175ab.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 22:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725515823; x=1726120623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCD5nD1M1msY2xhN3qs13wTf/0aKlhatVMivpIcFI+Y=;
        b=gKiCfeOBXsWpR47DjKp6ef5G+Qjq6V6Vsqzjep07EEGXGd9kAHm90YT3Gok3MCg9v/
         t8U2+aGEo7e1qZaPLxXIWIU9g0aDfoc9A1F7sQod4FZrfP3EVISkk5ftWrFJ+AR6f5/W
         ioSenC246TWz93wIvb9ZmjV0KEABrvK9dHLqoGi6BbGO5+QNItZuUGMm3JM6q1LKvOCE
         ZWksSOsFsDnEG6pTtHenCOFh/54Z9lRhGC5aMeY/Sm9xU4a2Kd3VcKIMUm9I+27kvCpF
         VWwoH4jc4D613P6G0gWxg13Xu8miuUd83IABUkm5xJfjl2vcDCrY3wezIJUxVlG8BIFe
         i4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5bNt62DU46aIvUOkNHYNuPGnWjdfz3wI4DO+sA7MA9sUPR38qVoiTUCy910bOXrotEwRDXus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXD20mGlcnw4zzVhi0xJa3kAwyc7ydW24enIK+WN+M0+JbIFM
	WW7aKw3RGOU3JCSJYr14KR3MDXGERLajuS/vMOCqpIcM+iIXShZTYvn0s64sW3owcPdV3NnAxYt
	6yzIevYNONOYN0dj9251l/fkYqinBryyiDKM1rebwDIKo3BeDIT0Xjq8=
X-Google-Smtp-Source: AGHT+IGCvnHCK805ji6QbaIknsKC6dw63UMmm8pwocMTN3hobf2dzJHRedIyr1YdG/fO3ZASs9c3+UVO+bPSwV8gReCSrtOQsB7Z
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2193:b0:39f:5c02:48cd with SMTP id
 e9e14a558f8ab-39f5c02bbfcmr8859215ab.6.1725515823664; Wed, 04 Sep 2024
 22:57:03 -0700 (PDT)
Date: Wed, 04 Sep 2024 22:57:03 -0700
In-Reply-To: <20240905052532.533159-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b96245062158f5aa@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com
Tested-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com

Tested on:

commit:         43b77244 Merge tag 'wireless-next-2024-09-04' of git:/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=137509eb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=8811381d455e3e9ec788
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1196cfdb980000

Note: testing is done by a robot and is best-effort only.

