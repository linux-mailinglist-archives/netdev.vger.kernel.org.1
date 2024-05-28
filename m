Return-Path: <netdev+bounces-98674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181128D2088
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498D51C23383
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A9170859;
	Tue, 28 May 2024 15:36:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928D16F27B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910566; cv=none; b=t5WadtjcPSAn7Ash4rCIbNCyJCqmH/rY9KLCuvnO1ZYCGYvHHKv+EWxVf02Qy7jxiF0As/kW36CN0i/peMu1jZMKrwIZWyrzPX5f/DTBWXHkaj097dfsauDSxMFHl1oDKhRtCzWdxE3wqY8qLvOd4L3GFsHVm/ke6PDC37mB4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910566; c=relaxed/simple;
	bh=8rnuhAuoOY4+BX2AUDdTnyJdZyLTSdhV44tJJs1mM/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OUX3pCCXXH186Frh1HtHC9C829PaNHo9IKJiGD6lDShyX43oFE6M/5aLTiZZw60O/5r16lRcI1oea8dI+AVj2qbRg+YAmzJgMBp0aSzDJDdT0OOfaEprYgQ2kNWHieYexysf/hIRZm7AmNhe5t9WgDDl144EkZCZlbS83QUcn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3738719ba5cso9196305ab.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716910564; x=1717515364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQHTyKrHplm0juBKxb5WUEglNyabr48Hpql64BnOGhE=;
        b=I/khZZPzGwy6U2tLqqVfilvD4rFF+mYESXOYOuAF/Kyq+1c9VxF2qx1Njt8q/bFGD/
         PoaTlsobR6sys7W+PTGzlXql4K8Jkl4+hhuGh4sXcXEC/qy4BIxDHgPUrYZ0i03AO/Qc
         RCOI08zDHdc3WldFQs442e8aubxHqzmtXCfPitGeVZS84yjV9FnCg9Gn7aqMpd6Eo8U0
         cbLnMmXSeSYgjH/DQpaDJXeL38Xsu2cdZuS14kp22NcHatcN25hDsQHBeB5HjZOpr2Xa
         TwnYdcimJjLvh8qW/xscDo00gx7Aemb4nuPUWv4LR2wBDW0O/MIXXcsjE984BoZ0URMB
         LQLg==
X-Forwarded-Encrypted: i=1; AJvYcCW/q2/kUk+Hld5frO6aDCjskjlz1ztbrqNSBK3FoqJFPNj50mZlFq51OvT+bZ4njlDcIJRlYDcnGVJELRMpNheeDULYwBEL
X-Gm-Message-State: AOJu0YzjyQOBUzvZ2jOrcoKvltzdJRzT4kyLNfGhNnBxrMD6JQs3+m2D
	tcBpxy/n8JHxB1s61SJUMUwHOKms7sjkYzzTs9ieWBbQvdwLMZOAW0POf32OrhynfFPB2VyzkCF
	jbrjY4b+juwazBCJ3bDJ1+udJngQDTtkySWWASk4Twm35XizFMYoUTM0=
X-Google-Smtp-Source: AGHT+IGjSjQ2TzVZnr0zsTuk4c+Am6/3KFUFuPq2Q/w3Cy2bX4yQZmLuDmLpTnGzLwEYqbldtBfvmIHX0TtyA5SCm+3QXwrz+ryb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:371:30f1:96be with SMTP id
 e9e14a558f8ab-3737b1cd625mr7322685ab.0.1716910564041; Tue, 28 May 2024
 08:36:04 -0700 (PDT)
Date: Tue, 28 May 2024 08:36:04 -0700
In-Reply-To: <ZlXJOfSLb-2iuJeI@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047f9230619856425@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
From: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	osalvador@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/hugetlb.c:5772:51: error: expected ';' at end of declaration
mm/hugetlb.c:5782:4: error: expected expression


Tested on:

commit:         a2868b0f mm/hugetlb: Do not call vma_add_reservation u..
git tree:       https://github.com/leberus/linux.git hugetlb-vma_resv-enomem
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

