Return-Path: <netdev+bounces-115147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D49454F3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F1DB232A8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AC13E04C;
	Thu,  1 Aug 2024 23:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5F14D283
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722555545; cv=none; b=LSQvV5ENnSUGAa3DEYBkzV3cpjOUiJixebSaN0s16gVNZwrFNe2OeE1rKNU4geM+FAzwADrw27im4ntAgQr0Z6nCHd2NwEFRNt5/xosx/IIotvxxdz0fAqA57ROOlaAEduWWx4ZCwLa/F2LF5W4P0u2nkCDcGq8vl+qB6QiHbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722555545; c=relaxed/simple;
	bh=UmmXi35nfuScAHUEeIJwGppaSmZBoW8i5FyJvfJEzhE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EnVzE6VAb9vt/shJBCzHo2cvJgmgcbTxFqhA8CmW78SPwawcGZR+QyHkGI0QdPve5wApnGr+zaLiJMxlMs0xevvzYV6UpnY8fgxJCqEPndbE38J5zEjGN0D5b+2ezH1r0owsuT/JZYRTGWZXv7xcD4+OKQcSc94uEvD8RBLb3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa12a11b7so825459239f.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 16:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722555543; x=1723160343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODcuns1LudBlqI4V0K87ttGH2rAEsrJeBiRSk4hIkus=;
        b=fzu26M3CYCcjgf3GOi+OXYkZgsrihE/ZkuCQGhXtQqUdyLgSgxzRfQd+BTHfsKl4yi
         iU0Q3jUjKQdOAzyFJ4fHjNuMtuEcJY1S2dabRk5XChC7an61ca8HeBzeTDX/EiOKhXqy
         awyH1Ir3pmBINbu8qqT5gZE0LatKduHJf/xTW4GcKeuq9OGydgq+1CiqI6Vt6s69ScpD
         srQTfvLsbdStVxvb/QyuAf0aZ8sVzXvWxdAciacl8ybr5YB07UkcB82UuYSyFRmIRHOX
         GhwaJgZQfeuLBvfVS3iz8hCJtwPk8KfCnPBaVsgNFYOuB0KxAXqNz3RvboEYtliqHDpy
         naPg==
X-Forwarded-Encrypted: i=1; AJvYcCUiqLwxId+e6L6rhLs4xy47XQmtt2C4PrMzj8A5fBL+Ufxye6LIEfFnush4LH8Inkj/WYaHLFF87bWgsEYdKfL7LzORiEYJ
X-Gm-Message-State: AOJu0YyDOIgTc5mCdbmrIopFLmN+fSUM2wVO9hBVkEhZ3cK91nzKCrtX
	mrfoer2hE7oQrMP8YkIOGma2omfSdmqWmdJ8Eaye61mN61+C4jW2xhqkXuXEdvz8TGns6/GnzNr
	VrKlBCQ2KDt1ZtrYq8QWHoYLCPliTHFj7EWu/86BHlW+ILQ6vnGVXHTQ=
X-Google-Smtp-Source: AGHT+IG8TxilfBblIK7ewxLG6HE/mrHKCIseSqawEomYlhrUYVYyt4OhOTyyY0tgYhO72VI3qfqc9z4ejv5s988bgf3cBNUSPSDA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3788:b0:4c2:9573:49af with SMTP id
 8926c6da1cb9f-4c8d56f8d03mr60315173.6.1722555543269; Thu, 01 Aug 2024
 16:39:03 -0700 (PDT)
Date: Thu, 01 Aug 2024 16:39:03 -0700
In-Reply-To: <000000000000839d4d060a0fab97@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000434672061ea7b797@google.com>
Subject: Re: [v6.1] WARNING in ieee80211_check_rate_mask
From: syzbot <syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
	johannes.berg@intel.com, johannes@sipsolutions.net, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	patches@lists.linux.dev, sashal@kernel.org, skhan@linuxfoundation.org, 
	stable-commits@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller-lts-bugs@googlegroups.com, vincenzo.mezzela@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue could be fixed by backporting the following commit:

commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28
git tree: upstream
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Feb 24 09:52:19 2023 +0000

    wifi: mac80211: check basic rates validity

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d0b26d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59059e181681c079
dashboard link: https://syzkaller.appspot.com/bug?extid=07bee335584b04e7c2f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122bb7a5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dfa479180000


Please keep in mind that other backports might be required as well.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

