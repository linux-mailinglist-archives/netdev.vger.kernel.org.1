Return-Path: <netdev+bounces-121131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3F295BE47
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 20:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2591C2234B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CC1CFEDC;
	Thu, 22 Aug 2024 18:35:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2941C63
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351714; cv=none; b=Vc0B3SSAnw5aNsaJ6D6zD4nyVJLvlZkeot10HRqZoxR2taJDgOYH3MWuCgv51KW+QMDIA6u2JD5JNuywlKaHVN2Jm+V9f+SasG1THnxiH2OPmdGxmd2TAY2fcKlO59S5FPNq0tEzUcxA/9zgIun2EkEqZgnB2uwmcDyLMn1wK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351714; c=relaxed/simple;
	bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uLsqsqtqZGScz1/t6QyuVtu6xsJbFTntvAzSxi2mpZboXJYvMiFHkJGfFBQGFn4N5nD79pzDu56GpqX+4Oiy6sAnOpYUR8FJbPvcccwlGjMVQmbyxDjOvhMBkqJj0sGDvGw4+O16hIeukcr08HjP18h+S+yiNDdyxAyJoKJzZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-821dabd4625so155434039f.0
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 11:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351712; x=1724956512;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
        b=SoPSe+NjNkjFqst2rmOEdO+046KWSfwJ+fEFEa9pdN+Qwhk5Lr30t+zClb5U/FIZN3
         msOH42LkmZFb2Le94n/IcGVi1QmHZR+Pc1HoPFqbk78wAqF61ume/YEClmtAu+yEQubs
         CB5KjDcv+BKWO2Tm2WpZFfKooiYIfO6O6LHwu6yPFBhxyGebiu7MToF8E5Kx8/SUSfoR
         oBTjyD1jR0z+dQfgB+k6zyAa77NOkP0GOcj+xXxhfyfdzqUN9rkFI2Am9aM+8wN3LlVY
         fmUvhzUYXPbiPbd6ETO4RoMR0ol3e1GXPR2nRBoSbuM7htVNkvbnk3bmpax98fEOgqn6
         w6jg==
X-Forwarded-Encrypted: i=1; AJvYcCUod5+vwQIL8ZP20dolDL4iRpkkTKTZL+uDrj2T5Uxy9ONQZQHTuODv38Kezi+1x/1aWlqZx4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3zk1iZDB1sbrOSKz/1q4uTLUYFPOzoKY8ludOcvB0ac5Clkaw
	fK8f7Cfm05HW9X/a7+IDOGmulOZhMFSjhlc+4AaKscIDgpFzwlSYQV5WaQxhwj5tuZmJ/JD1MDy
	i4Vj1uHHLmE3NfCIGUMZYQ8/Sp5dV1UABX4c879aTIPLXlSJnx8w3vEw=
X-Google-Smtp-Source: AGHT+IFfhm4qInQC3CXdMFXwuZtqryfRItmB36SvpNd0wCajLJ3q0lN3HzBbBjitkvyoakyPRpLfLoayP3f+oDOcYttr67W9D01i
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8720:b0:4c0:8165:c395 with SMTP id
 8926c6da1cb9f-4ce7f50abc3mr31071173.3.1724351711918; Thu, 22 Aug 2024
 11:35:11 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:35:11 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041ce16062049ebee@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

