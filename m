Return-Path: <netdev+bounces-72776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72DB859918
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 20:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BC01C210BE
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40371B30;
	Sun, 18 Feb 2024 19:36:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D21383A3
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708284965; cv=none; b=VJLiQyxEW91KL3ln+OSLYHVhBEOzp7E207xEb9HxcvRie6VzHgWAhhqhdcX+WKB4PU0LNmzZr63RnGVUIuMBBwva5heWPWxclWje5PbFQCaLNq8sh8cB4Xo/mJm/97Kn4mi2c3+HfPkYFAHVvjpqTpbQHbeXZo7d1qfo2t6Sm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708284965; c=relaxed/simple;
	bh=3FX4rtGdKWDOzhksBPXgjGi3CFyV5x/Dl113EV0q9qM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AZztg8nFvRGKuwoQ/o1955c76DSycFjHn7Ym43tgYpvem15KTvNQ9hBDFXYcEPDT6oQ6bdhzkikm/etHUaWTEi4Ma9yij6NdV4BapTc/M4usYnE10JFlkE40k2d0g84s7EJNeKEKZTDrSnRldXH57Pu+qodYQlGPgq4GGeK7lk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36531d770d1so1580225ab.3
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 11:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708284963; x=1708889763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VjE8fPbReWrcIR9LUQJ053LQQACtWBbX685F4g+ltc=;
        b=JwUz44kMt0fJDoiL7D/rNDOwOAOO82DcAUabn5kfc1gsACWTzwT3qgyqHAgzKN9saP
         O2SYBEhillDblKVE8R6X3z9cd0dtU9Qe8chFpI+2BXALY1Z1lU01fHNrivMgZWQj3N9v
         lsyx+NphF6MhYqDqwdAJ8FyVZaCBCtyrbcd1qAzt2q25v7vrIANwXWy74rqu/VqPyZ3U
         M09m2qxrGBD3I9+jq3eYcb4n5oakm1cTmPJUzKbBRn9VzdW2G4OEKTFdtp4tcjPvj/sW
         X+c+1D0G23rYzEzu/UDC01Lf89g2/b3V4XVD0P7huHKKe/6uWTz0XL6lOciZYVtq5Z32
         mf0g==
X-Forwarded-Encrypted: i=1; AJvYcCWJi5uRJpU1aH9VtXHMIS6WJTw+FnATqjnTsjP/48D3S104ckpfUcoI5tL06pI38wjE8IP7679fPyqpLR/LaqZxKl+5tgnV
X-Gm-Message-State: AOJu0YyxkrcYdgv3xRE1gCCr2Hz8lrUk8rUqqN8cHSiLLLGjQbbhWGZF
	XFk6l3FDVSSyFsAxsEZwjLh9/T0GlZyhzPjco9Kio8UWyFe0+uYs7WAYm5n+d0+MOZhDh2Kwkwt
	F8dRDWKsUjXx4xYI8rfYiLI0+/r+qYZCnOSYQYTq4jEJCMvIb19+cs48=
X-Google-Smtp-Source: AGHT+IF4So7qhdMKtZscBnCFO7cz0QMU2cVZeGgVgDx6aEAicBGXOfuVRrpdnDybQ7dx23IBtYxxe/9lylfo0cVkGE6dXfexrIM5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:481c:b0:471:647b:47b3 with SMTP id
 cp28-20020a056638481c00b00471647b47b3mr97325jab.6.1708284963017; Sun, 18 Feb
 2024 11:36:03 -0800 (PST)
Date: Sun, 18 Feb 2024 11:36:03 -0800
In-Reply-To: <20240218190032.39987-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000655a600611ad164e@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in unix_stream_sendmsg
From: syzbot <syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com

Tested on:

commit:         25236c91 af_unix: Fix task hung while purging oob_skb ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=151b970c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c368c5806a3ee9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=ecab4d36f920c3574bf9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ecdffc180000

Note: testing is done by a robot and is best-effort only.

