Return-Path: <netdev+bounces-230766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB183BEEFA1
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 03:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B551897BD3
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 01:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A2915855E;
	Mon, 20 Oct 2025 01:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCE946A
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760922245; cv=none; b=NqCVSmLDeHC5EXXuQqDDQwmD6wR/kKyVR6GdRgbxHaYcGM5pHPVgJr71fhQvyPvuOw/6NDXOFdKghPA0KpgQ922eXULBMTSnzcFgeEx1hagctXEG3wMagmhAfPL3MgpslrDSFQZyXlIthVKgc26WHmDa3DmhxIOAuiiKeIT70yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760922245; c=relaxed/simple;
	bh=i2MqYNZvrySdVCtAa8ikFcDtHjYDN70I+XhamqnlKiE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RMss3veS8fHFe/WgWmTa1qEiKvmzIr9wExGRl8Wq3sSyQqklOEblo2+WNeIFAPCVsPgtgHE/PjjecxGDwIg8Bceof50H3+ScCpK605h44+T/7tb3Ug3gpYyMgQd8cB8llCZhQr5nPKxYOJmhhJhJyF7D6OX2oArCJH+JBFvmzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e809242d0so600655039f.0
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 18:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760922243; x=1761527043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mzU0wKQum/2LuRGf5VdXq+RiIPs0NooYzZsxD9Bfmg=;
        b=DfBnV8pxF7smpS4nbLIFkslHh1wjk/wrOZwyjrt22xOPbWl8ajZ0akqZP4hwMW9H0A
         2vwamsBnWhqacgjFu3E+bbRyu8uzBWPu7IJVdwP1mRC365gLAMsQ4nXdKZI13xOHFACE
         AfZj5xCeOLzLr4bYM3SU6q+kVOaymdhCGNmcs2m7hhTsU8KjyTgUqb77eil35sLCJI2+
         +NcfQAM6xh9morEYaL5UAYLvVJFOEBWmcBm7X0tD6IAVe6D80pjwUdyuEbpSxdvTFrPz
         6okos3AKvf+R3GTJP/NAa5hPb3jxSBB8Hna32I7iLJeTk3CLqm41hl/uqlhKKcWcBVca
         7RsA==
X-Forwarded-Encrypted: i=1; AJvYcCWGnmRxDM4RVX6JzQ0KYFnzJD8iPDBqJuSkBGSjfZZSjWHRm4KwKdwGtqfx3scgOBqd+dIe3ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXk3jFdUOMlxOXOwX0/xYvAE54gv7Dpw4BKjQLc8zmW01owlrW
	Q516RVfnKvf4PM+dKp14llvXnfi/yfb6JvLY+bjVIiRqTuuBQEhhoN752H4aSPAlrIbPPjXRkzE
	edWQF/MToCY2pZN0MTdKeJxEKGlNzTphPGIXf+Mr7+UbodPmqJHDPmpcKIXE=
X-Google-Smtp-Source: AGHT+IEpxfZ8HgO84tlGHy5kvRqAgr/Q9nap4TFMDV56voWSOdFhTyNn+AuW5+eI+/mJha+JX+2f1g7e7KqeefCzVxUORvleuVnW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1414:b0:887:638a:29b5 with SMTP id
 ca18e2360f4ac-93e763ccee7mr1733569939f.9.1760922243025; Sun, 19 Oct 2025
 18:04:03 -0700 (PDT)
Date: Sun, 19 Oct 2025 18:04:03 -0700
In-Reply-To: <68ec1f21.050a0220.ac43.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f58a83.a70a0220.205af.001f.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
From: syzbot <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b441cf3f8c4b8576639d20c8eb4aa32917602ecd
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Fri Jul 4 14:54:33 2025 +0000

    xfrm: delete x->tunnel as we delete x

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b49734580000
start commit:   0b4b77eff5f8 doc: fix seg6_flowlabel path
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b49734580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b49734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ab7fa743df0ec1
dashboard link: https://syzkaller.appspot.com/bug?extid=999eb23467f83f9bf9bf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc05e2580000

Reported-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com
Fixes: b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

