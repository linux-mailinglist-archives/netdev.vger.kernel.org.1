Return-Path: <netdev+bounces-92803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE7B8B8E96
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE31B20A4D
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90A14006;
	Wed,  1 May 2024 16:56:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5911CBD
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582566; cv=none; b=S2AMGAOp/1GYY6SulMsGh7gRtM++LME+ll7+VrLfiqQibswYHcAIkU6Bmbxs55Nfgt+7/H8yhz+tRLEgHhM4p24Q+5sJormDV2qRYjDI9xu02vdcfADb4D+b9oDOHeoQq692OGPpBBO2w88cjIkObT6Nj+WT2NihdGVWanqzI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582566; c=relaxed/simple;
	bh=1XZHi0YzBLS47mbettJ83dDPGL16uhOqOK1tJN4dlpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+y/EA18J6u89HXxiaux52nLbh+Qr3eqPdrG+AdXu4BemL0j8ASJWmuD/+wxJySMDngqbYRCrfVabRYkGUgQQuxM5C/4BiMnV70bv6JJo3wb9T/41ezUdMQ/FKuUWzLIQJ6uvudiRluleLAgLxshMOgc1Ras5W4Oywbr2qO8VOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7def44d6078so723739f.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 09:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582564; x=1715187364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zL5zLFLZ9/A+euis3e08Nm55+lvX3+T3wPrxtwGnFpQ=;
        b=K+dH2GtnHLs4xHm7fJTa2idhjqBLIzifGnXVkfcA+bNIU1lPx7tUZemapL2L7a7A7F
         S5xN9bWtMJ7wxO8r/8tjdTm8v/2UmSETTvEm9xk//Ga6jE3HCT+dDG2VLUAbYmlJgQuQ
         0u1VZGDany7JqcaUY4MFIERXkIykpy/Y8uBqLN9tJKGRWtP/KLFLH2vErBpFAvS7J/ia
         AqXN6n0KakzzO2EspKO+Gl/mH0nH08KVqYGfWBN3MiEKc5mk66zsJovRgC16bn+iQERC
         sYK6EIcaSszzHi7HbFmUdS4Np1krVl1FRocz7MnWxMABc/RGEVdjqNZMy00f7xp9PxMG
         KC4g==
X-Forwarded-Encrypted: i=1; AJvYcCV4oMso7fhJCZs66wr9+rG6YWZSSpc66wBY3iCs+wIsNFLb3ZGNAK3cMSWFQr+CZXUPP9OSLf5spiCD+q8O1IbbFxjHSInb
X-Gm-Message-State: AOJu0YwlXoboe5slEv87QQ+VEXmSdCJuWNgxAY8WHGI+wxkSnF0LnDUy
	eFlIzvZ15nYiunYbOh82X/BFLhO8O70k3/hnGnT+DlCSZZvtwGiqMT8VoHFHjSLVOzm+EfzzSzL
	Y/MXIpXSGV8jkw5ZlalTZNq/O8LdWvQitGc1JYopfZsYNXyoMVybSKo8=
X-Google-Smtp-Source: AGHT+IEBjXreViAye+0kXgWGM8QAOQnK+EHu2cHJMy66fdP74jLwDb6XfrE99WN2U9+ggleDVkBLcX+2gumyBDoVt+kvePoHzc8o
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8684:b0:487:5dce:65ab with SMTP id
 iv4-20020a056638868400b004875dce65abmr6872jab.0.1714582564003; Wed, 01 May
 2024 09:56:04 -0700 (PDT)
Date: Wed, 01 May 2024 09:56:03 -0700
In-Reply-To: <20240501121200-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa73d50617675ca3@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
From: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
To: jasowang@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.christie@oracle.com, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com

Tested on:

commit:         f138e94c KASAN: slab-use-after-free Read in vhost_task..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a152a7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

