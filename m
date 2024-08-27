Return-Path: <netdev+bounces-122190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F149604B5
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370572841D7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6549B1990C3;
	Tue, 27 Aug 2024 08:43:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8763197A92
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748204; cv=none; b=mv8Fnm6uij1N5c+nEyIHHpherACeOs2UmxuAEHYIcacJ8GIWGP33xUVeiQFWAZwm5Jrc7Wwq++z5Q+tZndGn5Rn+MSCuQon5tVMOHKD2D3vZB66YIFnQGI1/DhwYj0wkftco0vpm2QRqEVWYVVjfgfZQUQpSxlBxFtG30qBvaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748204; c=relaxed/simple;
	bh=XKuIm4B9e0oqIMtvY6r359aZpxxV6yrTqMrmrpy/nj4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t4DdRMnrXcFakUOAhY0NZUnYWVsSV0Xd6L77//eZPZKCdyWwvofsgKyA/eTppFlU4SD0bpULrk+c3FYq15v3WH+zeQcMCzhGJsuw0U505/j3sJpGaJ54K9oTXPuEM6rzSGPWfiLx+9sBd0sZb30kqtHABaf7XvXOqkBUufEflGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso580013239f.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748202; x=1725353002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yb0vv4+kO+PRSHRfUJfXMp+Rzluk27Didm4t5BwNtqA=;
        b=NKhWQYeaiEB8+pnTKILnUa0Tj6M+PUnzbGP3Kt10Lst9Fyj+S7hodPPskTRpLTZHUx
         kyIMksjJrdIRpVJSoL+UVqs7DW0d92MIl4S7sPFvd6p8X+ZW5ydJTe8Vf7wkI8rVU+V5
         dD3C5MEyVyLaA/pTQYr3BA7J/fMUHhsyJh3obu5+S6s4Np+ht1iMCv3V10Cyx6mM5Pbg
         UW5XTK3uySilz9AGQybmc2aD3jm7sTEA1P8m5zJxU4uOdGeoyOecrRmsgJLhhpRhkQ01
         8phoiI23WcuJR2PlpswdmKC22zevIfvl2cvUnDqyVK+ZjhyUce3OAAR/dikhtI2RmClR
         RP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWWFuhfBD/m7RIaZd8NiIpx46A8QKk2D6unxDLCz9cA+EXpFSg1dVG80PxlPNsORYRpwu/Omk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq6Sedt3O7TxJ12XbE6A9C0GSfu78DBuOtKdBpF0B1WaNYk+iU
	T8qztQG/xNN/bYXCRAFA7gQCxvBYr1n7R1vrDYFTtzKXwU62pJTgtV/N9tfSobPjDstxQRnvi1E
	cVn5ndLb92LygO5Sn9ULAyn+QDjqi+70pLyBdV4L3bjbny4FSH8rsQZs=
X-Google-Smtp-Source: AGHT+IEOJQEUfSz+/2Vw2uJF276C+xSABwvTeqD4hUIZvuf9L/TBg+bbnAz/RDhH+yPEWyagtY3qePa9tbqC4VQHWCA8Ad91Ud1o
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c564:0:b0:39a:ea89:22e8 with SMTP id
 e9e14a558f8ab-39e3c97fb30mr8107365ab.2.1724748201860; Tue, 27 Aug 2024
 01:43:21 -0700 (PDT)
Date: Tue, 27 Aug 2024 01:43:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e629df0620a63b2a@google.com>
Subject: [syzbot] Monthly rdma report (Aug 2024)
From: syzbot <syzbot+list6d1c113d5d8954339576@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 60 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 33      No    INFO: task hung in disable_device
                  https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
<2> 24      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 2       No    possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

