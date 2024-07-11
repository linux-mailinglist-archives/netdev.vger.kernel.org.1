Return-Path: <netdev+bounces-110924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122D592EEE8
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441321C20F90
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700DE16DC3A;
	Thu, 11 Jul 2024 18:32:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974D16D33F
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722733; cv=none; b=UtvBHUqp7IDzvTnXkg8yKF4dKfr7AMdQ7rtsU21nXPRaLF9KZUhppmYWXJ/+/neZAJ9Lqfok+unoXjFZ10k4uvzlXLYblI39auoomBUtjUGGkOue5CIs/IPIaBoW2NUR10LmVecR2aYmwbYzme/p3qiXm7/UW59Ql0uw/nY9VTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722733; c=relaxed/simple;
	bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lE2jjp1zz86+c+aETCp2TrfdvGO7wLVptGl0vModNBymFelVFvWyPN5iQmuAtUSShIMZ7WNkIdwbZGNSbuLLOuhcYf5lfnjXFMY0EnZkndvKTscwR+Yoassau/G+vH3MjTPHIj86kFuSR80comZs6YsRgOXM9/zmAYw9iAfHCSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so131334339f.3
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 11:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720722731; x=1721327531;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
        b=gJsYKRm27UG9Ayqzz9Xaap4drnQc0Tn+QJZuH337TL7MnSkZS28IeTaRseZJq56luK
         o7F4hqnt/OAFiixaU2yKvt3m4BoBxN+0vN6VzWeQz+fyazq2nfLwChE2dLwBmjCZHWsO
         mc6zpZKYPT4RHqNJcDmGpx2WE9OYRDtik1Xd2RiwQ0dUARncu0CWTiAuFBo3N2PYccr3
         0uS1xUAl/cKf64pIwvBSiCgvGzfCKmOLflBMm0yIp5ylG4d1hGenYOuGCUWOLzZDzC4B
         o0LLEi+AWNCaszATclH+/wr1RGk20tOANTQK/w3LWbbkKx9gA9c7RpnwADfXC2AT3sU8
         4Ymw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+fJpQ4quK9tzXKvpyMmOs/3n7sn33VsAmFUWaHkYU0vtJ6DbmzSG3tm8DVV5d4+CmpUFtRVzV3DW75AKhDTNx+Et6tzX
X-Gm-Message-State: AOJu0Yxrmq1LjC0pDGZi11Ysd+wrH/h2kMk3U9RiBAF9HdnfYLJ1u4Sx
	5i9dVoUSgVz+nnUJHEmZ1Q1EkU34zV9Hwty8GaSouwaF/nduw2cw9LzECyN5du1Bc0L1RbEjENo
	iIe/xWPK6tkFO3nplyxunfWWI5qmcQbwNiefR3V6TnoKinEu+TxLVKhU=
X-Google-Smtp-Source: AGHT+IGFmDTloPL8TIpr3S3s15gCH/qkddRtmRkHA06URHCkMzkIPe7PlInjnupmBbg1pMQJ2GtpZJHITN9hqdJMUpntbQZ9QItX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c09:b0:7f6:2d58:8d5a with SMTP id
 ca18e2360f4ac-8000621696bmr61547139f.3.1720722731229; Thu, 11 Jul 2024
 11:32:11 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:32:11 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026fb2a061cfcfb67@google.com>
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

