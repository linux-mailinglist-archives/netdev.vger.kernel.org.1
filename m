Return-Path: <netdev+bounces-224957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65605B8BF39
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 06:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6ED7AD504
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 04:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91692264B2;
	Sat, 20 Sep 2025 04:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267ED1DD525
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758343028; cv=none; b=Cj7L3talTmGigm8tPdUeKTn7duz/SXTFWdriaSAwtZyfTiVo9munhzaDTO0wEeiqp1c8VzEYK/mXoqiEkzlpiugVCfzrWJ7g1aSHNzHysfg1bOvI401yiwvLfzqwrYJbtEPZL7j6npUry12I7qowD1nUjBYtQJmm7KFkJxE0t+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758343028; c=relaxed/simple;
	bh=eLZJJ4b5Hv13WnuF/je/2Gc/GJOLCP6cLSLyncvNLdA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H7BjjeyxdmsP7H2oJhnGh5ab0F/7/rO4DJaHemkwKfDBa/DV4a0J0Coa3Jb0wtd1lTZDSLOTCJhcsMcRaQ/MgvAvKt7j3g1fRkPDy/x1EjXNXyqy5br5K/nUgVXntpzqFr8iJoHe3ana0atmZK/kulFkqoHJhds3hbhfHXFun60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42404bb4284so37161715ab.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 21:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758343026; x=1758947826;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gja0G+YNMT4nfkxekGzUizab20nltKnqLeo3HZHwrLU=;
        b=DWa6nbL7TmNswXTiZrOwMOp3fEwDbUz5B14DylLheuI07up+2HUlZX0xxXCqkWb58i
         Pa/g5Ko6Lbk86m2ujaoX4CuZ51o41ZuUwKiVePeW0/YndQNIRAKXy3tqaqTC4MT4WJts
         jEIegU2P4ugaLgcskrbZrhw9rgkl1smewTzaTu9zCH84kkRfoSSOIO+BbRZjAqiLM7Zx
         C028fOQLaLHZ8bNxT+7igFEunWRdt3PNz/0M8PEPEinqRwsFGfb78pB8guyj0AAyrOrT
         leo4JzEqyyMW01FwX5SNe3BtTSZpegq3qxwX8DIQr8Zq9IWdUdm3TzoCBzzDdXNPvtb2
         SCZA==
X-Forwarded-Encrypted: i=1; AJvYcCW43f1Qr0NVGnUEwH/xmTqnnn6PKUbYpxIcBxoOjWgBbXXDPzVn5K1wUsMYExAMFKqz/ACmsYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwAB+0gfZ3fn0whJnDMeuHVhxIl1KsENVjCd9jY3MHZgAFnJ5
	24HbIsGh87rZKWyCiiq7hGMkekwqbbpkfoeOtKLRiYkLx/LxBI2tnSZI1sI1IYdOdsskCRopRc7
	cPr2N2E4+hZ/ib+36N0gpI0QEvl5n4NrAs+oUS8JZOk8A9e00gum1LAIJKCI=
X-Google-Smtp-Source: AGHT+IEboJPHmu/GmGIV1HX2yNQ77XkVwCngjKU9vicDDz+MZ7u0oRXuv26/XZA4q8RUdEr6/vmWleC4YNydH6JYZXyh1b78jOd3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:424:2d4:585e with SMTP id
 e9e14a558f8ab-424818f920bmr87191575ab.1.1758343026440; Fri, 19 Sep 2025
 21:37:06 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:37:06 -0700
In-Reply-To: <0ca2c567-b311-4f0b-bb29-2b860b75f85e@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce2f72.050a0220.13cd81.000f.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wangliang74@huawei.com, wenjia@linux.ibm.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/smc/smc.h
Hunk #1 FAILED at 285.
1 out of 1 hunk FAILED



Tested on:

commit:         cd89d487 Merge tag '6.17-rc6-smb3-client-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1381a0e2580000


