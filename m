Return-Path: <netdev+bounces-142537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647229BF920
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E166FB22A29
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155B20C486;
	Wed,  6 Nov 2024 22:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071A209F20
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931548; cv=none; b=BAikBtkoqQZw8MPxQgXrRTx+27MOgRzSPBGEXcMt6A0KnM36O+9njkD30c/k52EzirgwsUyREYfXN4jvUQQ8PPT51KAPV+TZbSY74lOJc/sbzAe0kb+gGkNMXg8QmGV07ndZS/ZKJcN6TJ83RlIiGBcB6+/jH5IGOczmyG4w0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931548; c=relaxed/simple;
	bh=+gR57EeKwbw0Kwz6JIBh8JtZeP2pTiNAeaE8mY7cdLw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sxi3LOP9/ncqA+DVNf6MzdcDmN3V2M5Don7dQkFVrUnCkYvlVDf39I/zFWZnagTYZlYbafdJ8yQI2z8KUcDOZD8rtgrNUA8VZJToV9MSln0xRXJYYVOfex15atGCzErkgELK+/3lU+MyEEJ5CBvhzzOTnaMgaKEfJvLHK+Rp8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso4875275ab.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 14:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931546; x=1731536346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko45KvLVsjg/SK8Ct5743fIEU/Eg1iBnoARTt6ua45s=;
        b=D9dg9kij3M9ZSTo46QiGEBHIayMquTxGCfB+wpnlim55Kpx0O1QA/ekUJ9jsIe/lZR
         sMNwoz+YJyj/5uGMDxymNiSI8nfsjlAGAtloOI4Cca5sIDna+gEJXNOSMBlkhkHlUvXh
         QmmitgFl1JNSaipf+PsJw02pfx/DiVWeQfGOWzAOc8okr34TQQji26NW2FSYKPceRFPV
         46hbgmW5swhy3yWmqyJKFqbeqDzJrx3kpPBYIaeemfOTSaSc1MFhk/OiMck361FXxtb8
         xyBdmvVy8Cx4W2rgLQu8y70C5u3jdTLI83zWGb+t3g0WFu5cfglmgd0JeQeGILZj02n4
         zKhg==
X-Forwarded-Encrypted: i=1; AJvYcCX4MNPYGf2Scf8S5CBRBqgZzU3R2L0jRfp5pg265k8Z7HfAeHKWWPf0C/NQi/D4ZIVnJyqq8K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbklZ27kKwzDGIbgizwbnq8KbZ3pP+LhrtjsuM1D1oX/n6MbH6
	HNWHWRtby600By+bi9bGgSqwCi/8xqTQoxFOx/ZjgQ2L2De7Z68X24aRzGuCkilWe31XnIDSjUq
	ASRjl1RBF03+dXIhXa7HB3uCCQzVA+PYjUkvuNz9t2dB2YUhtpnR0rZM=
X-Google-Smtp-Source: AGHT+IGPQH134goapcSY9eT7NLw6Ji7rELvx0NPPbitKv/F44WvkYOx798kePlkHETZ9gxFEXBaI83nx6N4GYR6QJDZ+E7jq1KF7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:3a6:ad61:8006 with SMTP id
 e9e14a558f8ab-3a6b034b0edmr214369125ab.15.1730931545807; Wed, 06 Nov 2024
 14:19:05 -0800 (PST)
Date: Wed, 06 Nov 2024 14:19:05 -0800
In-Reply-To: <CANn89iJptb2gackja+KocyPYwf855EgZM34GSO3km4Z8tcwq1w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672beb59.050a0220.350062.027d.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (4)
From: syzbot <syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/uapi/linux/tc_act/tc_connmark.h
patch: **** malformed patch at line 11: diff --git a/include/uapi/linux/tc_act/tc_ife.h




Tested on:

commit:         f43b1569 Merge tag 'keys-next-6.12-rc7' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fdf74cce377223b
dashboard link: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14119f40580000


