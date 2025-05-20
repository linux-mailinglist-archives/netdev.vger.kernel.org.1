Return-Path: <netdev+bounces-191997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D00ABE28E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 20:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756617B5BC3
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4DD28135F;
	Tue, 20 May 2025 18:18:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AA280311
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765086; cv=none; b=AvABcd80UD23+3olIKrGh94NaiAcZaKpg1w27N7MuE3X3LfpkTaPIJJbLLx/exiql+M0hJc4OI3zQyLopD6LWvYbsS2Wnkwoj0OK9PggBBlrD74ymol2ombZ03RY8yU1wDS7AyfIDAlOjvN9EYfQZXz9Mkez8yVg9TFgP4ESxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765086; c=relaxed/simple;
	bh=VwZEuoMNwZrEk53NaHcuMXlypeiTHQxbfLfDbcCg2is=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QF+DXkHdXZFOVffDj7ZhOtuOhLitaNTCFdzNpW0TdudR5DJsRalRENSxq9KSkpNFC2CkvW5z+quW712ixHVeZDiO4SjCKjxb16ErwR5hX/NzSldsN3LO9pzGOG9qAG2kEQT5AwJT1Fj4j+ClImHwylX5hn0VnRM2+aDYaNkG88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-861d6e340e2so514106339f.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 11:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747765084; x=1748369884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz3fMhLhUr4UywHSrROR0nSmPNcWcTC/GVXI5xlm1mk=;
        b=E0Yn7jSx2hvCCcuhOSRIGkX3dOa7R01kU2rQb+/+yZgHlvPM89leBbSuKwD6sdC0/K
         dDSX271VEdEs3ZM24Xy/mDWtiDhEg+jD3gyvvVdTmsMyrGm3WqIoPsZY75MRWZWzuFA4
         7RMMjQaS2XZsgnUTU8wQtvTHzY32BLfCQoppiMGEiX66g6JN1Mnx1IlFLvP1UXeTd5gJ
         0IgdFMt6P+HJVA2iDeMhy862W8K/P/vSqNJVcIo6m5O6vPJZmzNK4llrdJcgvybVRnHR
         +WLa2xQLcMhnAN170ZiSerUCKxUDLvmTKneTiuUKtK79eTPdXB5l0YqxOAFoyJdva2YK
         M5PA==
X-Forwarded-Encrypted: i=1; AJvYcCXDsZdZSxIVZJR4CuidiZBPpzBdDLt6v/KLDlpP+R/QQ2MNovCye0qtvIXo4JeQRPtPYUr3Gx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWv2KLuiqmSZ0gC92KHY/pSU9S6jto/TOnNway0VdBFcHdOwX
	QDyCiuki6jxGTeYJYY/s2f36c4zBjca6vN1Z3FbI+s+/0bs8qOrPoSHzmIAEK5g9dKuipH/25hq
	WqsdvDhi/eGRwvWXaRjqbALcL5YjpKI21dbPtL85xe0M0VnsnKXmdUpj2pGU=
X-Google-Smtp-Source: AGHT+IGA43rDwi+YTetDFxJCxhATL/2pM2yY6PsaSQzQ1maeiT3JzsgHswocrz31lttVRNWZFnxo1qtnjpL7ZazuuEQ2a0EPHWLo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:da43:0:b0:86a:2523:a9fc with SMTP id
 ca18e2360f4ac-86a2523ab62mr1508655739f.0.1747765083742; Tue, 20 May 2025
 11:18:03 -0700 (PDT)
Date: Tue, 20 May 2025 11:18:03 -0700
In-Reply-To: <aCy60X1I2XaRyo18@mini-arch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682cc75b.050a0220.ade60.09c1.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in team_change_rx_flags
From: syzbot <syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jiri@resnulli.us, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stfomichev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Tested-by: syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com

Tested on:

commit:         9e89db3d Merge tag 'linux-can-fixes-for-6.15-20250520'..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=158f32d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3f0e807ec5d1268
dashboard link: https://syzkaller.appspot.com/bug?extid=b191b5ccad8d7a986286
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116b32d4580000

Note: testing is done by a robot and is best-effort only.

