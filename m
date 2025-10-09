Return-Path: <netdev+bounces-228450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C04EBCB31C
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 01:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ACC4275D9
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050042882DF;
	Thu,  9 Oct 2025 23:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48A2882CC
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052544; cv=none; b=lUSK8R04gSNLuXPXa5lmihDgN3kGCpPpc7+lJsixQWXmyGepgtFRvoIOxTFsl+iqiMqjrLsiyjPGe//NZPkae9W/ZlOCKKsP38YPUb59BY1Ab/nUNEJUY0LYOpnzYfPZhdoWRPSDya2ZwWg+S59QCOJxFZzJ9/pVlL+WracDZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052544; c=relaxed/simple;
	bh=MR3mDLO8psciWX7aEFIWGIcpwIll6YdhBIvr6LmW3fk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bkXzmWIJmNRWnhKBvS2ldknRYFMIdmWl+kLN5PmxF846g0SP7P3pxq13aomj6Dex0nnDmAQtCT0ylnMpKDp7sDf0y+RtEiTLbGiMI3dNpqFAPrhTQQ66+9m37QvOOVfheAHxmAvKbGG2soDWa0NinLmi/HwgbUPIM2w2ggLyUJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so658429739f.2
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 16:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760052542; x=1760657342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS+rszJgaizocP5WWuliZ9dJ4ZavwuTgx73YaLzfsos=;
        b=KrItF+I0DjuZejuxFgqXyVg6IEGIbhdX5ngVW6UAe8GLruluWu/w3sf/d2OvViOIbH
         auL0pwqWuxdob9/RQr4I6HbS7a4g89ftKAO7BQWMDADozjIIkzuWH0ddtHwHzvRbGek1
         7CzG5FOo4YcME/von3w1sugtYo0NxdNkakeSnvrT5V7XiB+2M8wvHwRR4YM6gKDI4knj
         lVdllLStPAcax6hNB1I7gsVwjF1zbdtmp9ANWNrWBWQKyzAyBA+nAJdqVsVbWYUWzr6f
         ax1yA+Wla+kT+XquXMxdkq4UWa6o0HbQqOqcTO5E7EecG8eOYpsbTdQckLzqliI8Wr/R
         l7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLyk3f3O6RBFLs4a3Mfg97Mmcau6NUlpR3uUZB7bQ2F1KNPqmiaXnkTQRJzRAcdqRQTGEonGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqStSk4ie1x4OXteDMk1z/lEbu9tX48tVdA0iwjgIjEPOfazMH
	vDkFd40e7QKvKrVvgR22GPiprcUD9IqW0+YEQFyiEWrz/DI7x1oyUHSrF/InA/XYE0+JpA3DVXx
	GUI5fD7MDBdAz622qiV6oAuWpboKU1jPuMhCd/n1GTBWSDCFz+Ars8ohhqtc=
X-Google-Smtp-Source: AGHT+IEQ+Vn2+E2g5j5qm1lu78xJUMAaWaxx4GoM0B+s9KwrDea9URSH2Lq8DiunLGRzb3uPqilmwyJygHxa4YEPRpLf0ZbtCDZY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6406:b0:93e:259b:9412 with SMTP id
 ca18e2360f4ac-93e259b9561mr246304039f.19.1760052542595; Thu, 09 Oct 2025
 16:29:02 -0700 (PDT)
Date: Thu, 09 Oct 2025 16:29:02 -0700
In-Reply-To: <20251009222836.1433789-1-listout@listout.xyz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8453e.050a0220.91a22.000f.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: sleeping function called from invalid
 context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	listout@listout.xyz, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com

Tested on:

commit:         5472d60c Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159b91e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b842a78bbee09b1
dashboard link: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f50dcd980000

Note: testing is done by a robot and is best-effort only.

