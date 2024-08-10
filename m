Return-Path: <netdev+bounces-117407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3427194DCA7
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 14:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1D11F21EE6
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7721515852C;
	Sat, 10 Aug 2024 12:07:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B46156F54
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723291625; cv=none; b=ZRviOzsxLtWWS+PxNovvrnMBsjdkCZOgpXpeI1DxFqI4ugfG2uT+27CRnobzqZtiaKNb0bjetjYppqRV6vuoau8XuFvEEDocSyGQOvvi+d/YKUOEq/UhqZk4enZhliUnit1NxidFlY95VBlQIuif+Ck710Y+P0ae92CGC9k62YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723291625; c=relaxed/simple;
	bh=JMi4VqlR6VLRsS45yK6xehSfzEWKZlPxzkPo4WsyD6E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=daCJXJ1SFmBSLLhGCjl88p+b8s02VqW9KCw6qN8061pfxH7pIx9dXCO1wOCum9uhFqgJfFiPgCt4qVvV5qklh0CcN+qTrOvcOJarYHid0pCrls4n/gOxCaKrVbD79KyLwY3pzmfYpW737n1t++1p9z7vRsqWisuCMPvPzQRYAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b2938b171so35518955ab.0
        for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723291623; x=1723896423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brS7xkekpvIr1jOYZCd0Wlyr5RS+/5cL13gt+qEWR4I=;
        b=ix91y61m3nWhFsF0CBQsI3GSZZYBnNP9Tn/tDfyAvsFOq9zYiLMdk0hNt35/ltfat+
         nrozzn7olUnqSzOb8RQmxTOg289ERNaJ86czbtfw96GEnPBC/s/NCr2Q/eq3XWJY4wKD
         pnkhNYSGRf8YEyZSQyORwIi8VeEWoepgUirAmQIFEIHo64a/N4UzNZ4gbyqUXgczkDEb
         M/uQ01tM+SlT548m+EkLTM8vaeHslw76VfcuKYIY+ZkuP+Vae1+RGdOLAEBOYTX3UeeC
         STYL0GooQTcLpAw0aJ8y8/PLUi5qE4H0YftLBZE3+6pu8XPMC1aCmyDp+n8v75HeiOpf
         AlYA==
X-Forwarded-Encrypted: i=1; AJvYcCXxOfoWaWdqzY6/OJGHg6sOTJ7vHwN155nZuYWdF+rvfLbsj2igc9QSKDseVjxem6BbV0K5mRZk3WPtx5w0XG8FXc5jFDMy
X-Gm-Message-State: AOJu0YzxY7XM24ILnNYXB+POMVXQMPtfx6bd9zneaExHzkHywquf83Z4
	TQEIMS1HK2PnB4NE6pKhtPMqeJhi+GiXQGW5JdM6EVMSCN2qpMW1dqi5XBOwghRIWYBMohcMo/+
	w++8lglXEbLG2x1s3L8fq9W7VhFsozh1Xy7pddlRPirobYxPLvMjTMJg=
X-Google-Smtp-Source: AGHT+IFy+VeqXqzz/19A1XE5ksRo66lpGRBRIcR5gsemJWKDHHV8VcCm7/3BuhZRoKjTALyu3JVCmRt4uDYiNtIkUWqL8gt9FFWm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-39b8134a48amr3691455ab.6.1723291623131; Sat, 10 Aug 2024
 05:07:03 -0700 (PDT)
Date: Sat, 10 Aug 2024 05:07:03 -0700
In-Reply-To: <0000000000005f5a6d061f43aabe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a9b85061f5319be@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: bobby.eshleman@bytedance.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux-foundation.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 634f1a7110b439c65fd8a809171c1d2d28bcea6f
Author: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Mon Mar 27 19:11:51 2023 +0000

    vsock: support sockmap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d3c97d980000
start commit:   eb3ab13d997a net: ti: icssg_prueth: populate netdev of_node
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1033c97d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d3c97d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=bdb4bd87b5e22058e2a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a1b97d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e7b2f3980000

Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
Fixes: 634f1a7110b4 ("vsock: support sockmap")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

