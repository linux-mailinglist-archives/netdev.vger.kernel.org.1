Return-Path: <netdev+bounces-63929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92361830325
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 11:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B718C1C24D61
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C6314AAE;
	Wed, 17 Jan 2024 10:00:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F411BF5E
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485608; cv=none; b=F4D8nF66pl9A8R49xWgFJYp0s+tRVKzgR6jUplP8WnDZngTTqQaqSvclvfofiYz7AKhhuwLllx/aLM0PhLeZeS3SveMRmJkby8Y1rMWCnXARlfnMP3CcmGorkLrRDs/V1zyMMDcl83mU1AQTHBUogs+25QPahslJ2AYXK91yDNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485608; c=relaxed/simple;
	bh=V+2etrmWvlbG8txrOcr7VyaNx1VG1Hy4oQA7XD2JAhw=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=UiLmqt8WUwO9kEnB6RtIDDd9K3NETWsO1rzwzoiXX+JN3ECZn+15W40r8FPXdzxljFldvkl+A2omAPUh7b5r/7BPVBTbRlFDvOhZ9ocreWYwCL5+83U/lcmQPehNrgqEHG8SYgrjZq3AdpRsj3qUuHAiOd+z1AOzw79Bu3tf9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36037f2de0aso93382015ab.0
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 02:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705485606; x=1706090406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEWYXMygqwjqpXLX4r5FFUWm4Vr0B8II2TW/fN+KFgA=;
        b=t4tFJ5gxX6NUlwZrqcWddlwzRZLHX2dVmZqqUAAYQhnVXTJdaP5Lerd61uDbSH+z3y
         ruXWxXJFh5AQkXtETuVVyyJ+TaHwnf/lNKffYHvtP4rcCdB+4ubhotimO4E0WpZZsyBg
         A+AYWy2YfRCmoelW3+ARogM9VdagaYoeO2JcysWjnDhLwcYZULIBSHOrjsL4pnWfe6gx
         C1mazGziHAZB4/aI50y2e58OEOVmCREpTcjKCtZ9NizTL179jrNFaIw2aG5hZepaqleZ
         C9piKGDt4/+6sLejAnh0A5M/vKX4iO943UM6I+yEi2WtayxiAhAkdPLqvOzA0V+9J1o6
         IGjg==
X-Gm-Message-State: AOJu0YwdeEzBXe7kG4D0AKQ1x213AyHe5pa/lx6RREJdv1jwHV4PW7z0
	cawubC436XQ7t3waNmNzSu5NIDDGACiLcEtDSX4VDS0aiK7m
X-Google-Smtp-Source: AGHT+IFxzxlQiBQcX55AFmPxoteq4urJfMDjyvSOi68dybWh2/wMstcQoWDRkMhtdU1DXGkmkpRcVxbUE2YlVxE0/SEPmN1ghQFF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:35f:9ada:73a8 with SMTP id
 a13-20020a056e02180d00b0035f9ada73a8mr1265663ilv.2.1705485606163; Wed, 17 Jan
 2024 02:00:06 -0800 (PST)
Date: Wed, 17 Jan 2024 02:00:06 -0800
In-Reply-To: <5746181.DvuYhMxLoT@ripper>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9996f060f214f9f@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in corrupted
From: syzbot <syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, sven@narfation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com

Tested on:

commit:         a67d6793 batman-adv: mcast: fix memory leak on deletin..
git tree:       git://git.open-mesh.org/linux-merge.git
console output: https://syzkaller.appspot.com/x/log.txt?x=100a3dcde80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87c229fb8ad5e9a0
dashboard link: https://syzkaller.appspot.com/bug?extid=ebe64cc5950868e77358
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

