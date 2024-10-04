Return-Path: <netdev+bounces-131866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8598898FC4A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 04:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351771F22282
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE21BF24;
	Fri,  4 Oct 2024 02:26:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985988F70
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728008765; cv=none; b=RQNsDo20uwezY4MAeLGfASJx2UqsSyj1afpIxL2TCNBo+ykHi2EWauwXsTTIMdVgtixRjTaieq2NWFO7los99uTEatbJFdTrvN5Dn3cREPL5A5Mna5DdwDiXAgkySbKx17GgMaLaQduNuMWFOCEYU7/IA8Vjqsa7Zluv1rYULIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728008765; c=relaxed/simple;
	bh=4HWecSz4M7EUkOXXBP9/ZooJcAR5jb16syVtiRjEbuE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uVbGjv79WbghMhU6ISoom8hagjVTIDh/blJYIkd55+cvbjPUu6eHCNeXFvrAqBvPPJ2z2A8xwRUy357DnHwDe4i9xi/Xw+pb9Wf60MzXu9Rf1gcm6q6fD/Ph6vAWlzMU1Thx6odUCjPQmdLLOht+wz95S6Xrn3zK8yq9FjAR4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1925177fdso18401955ab.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 19:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728008763; x=1728613563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0TKGVjZnvG+gbyWukrboF5mMhpG4D08XO678TzzDo8=;
        b=qbo/VXXQOy2ES3SH4wbK6JEXg2X3na91bA2VvYQ4h+i3CAePjbP/qjDbNttS1eVMjm
         uZUCMl/uEb1+l3eoectgBmc54Ug8RL6xyEH6vjTNJxUoJqKG/xg8L6IKRhOB9AwErkXY
         ydOjN2eBelNJ2TnQfMWN4QH/x/YyClDLSWvH+Be/m/1OdNbHjBX30WRzx+/MkiV2mk7r
         XlumuOs1oO5k6+O0MSFqpNkUJ0C5k85IHqgYtcxLT/niMcAwtWCjMnjYHXVteqVvEDVk
         MI10f+m4jaafnCqF52L7MU9CgMromy9Nl4G4l4fhIhCNiH2oEwrWxmCLfYlnBdrzJzSh
         5hLw==
X-Forwarded-Encrypted: i=1; AJvYcCXt7QRY/Qjlgvtb9DkiGTYhIOTxQZMz44iHStBbrw+fUnHmWrIOaNkvHGfJej4GAChqRVkSR08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwasHo+XnNZ+MMKomZ5DfDw0AsyFGpR3Gui3CoL5KqPXdANpfug
	O6EfHXoBvZNksjjYqxPCOoV+neungP5Y1TZ1FPWw8xEIfVA4f9E+2Xbqh6ESxcTHn1drb8Sqbdv
	rHCfOWjkjz+Zo/wNdQhZPdBekRWEpHVzFZLVuKeY3Fv8+JmLntXFHVsU=
X-Google-Smtp-Source: AGHT+IEDAq1L/9hrIQmAijk45oUjCKIMrvI/y9UrO5WjjEY5d2oTq1wpaIDF3b9kOodsAS2tymqxR4Uv1qQWjX4YOA7zaZ9iXeNT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca07:0:b0:3a3:6b20:5e33 with SMTP id
 e9e14a558f8ab-3a375a9b3a2mr8900805ab.12.1728008762724; Thu, 03 Oct 2024
 19:26:02 -0700 (PDT)
Date: Thu, 03 Oct 2024 19:26:02 -0700
In-Reply-To: <00000000000094740b0620b32b4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ff523a.050a0220.49194.0413.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in phy_start_cable_test_tdr
From: syzbot <syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com>
To: andrew@lunn.ch, christophe.leroy@csgroup.eu, davem@davemloft.net, 
	djahchankoike@gmail.com, eadavis@qq.com, edumazet@google.com, 
	florian.fainelli@broadcom.com, hkallweit1@gmail.com, kuba@kernel.org, 
	larysa.zaremba@intel.com, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, 
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ad78337cb20c1a52781a7b329b1a747d91be3491
Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date:   Tue Aug 27 09:23:13 2024 +0000

    net: ethtool: cable-test: Release RTNL when the PHY isn't found

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bee307980000
start commit:   f9db28bb09f4 Merge branch 'net-redundant-judgments'
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=5cf270e2069645b6bd2c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10542a33980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178c6225980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: ethtool: cable-test: Release RTNL when the PHY isn't found

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

