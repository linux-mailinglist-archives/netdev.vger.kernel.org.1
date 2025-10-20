Return-Path: <netdev+bounces-230890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C804BF1260
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A63004F41B6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B983128C5;
	Mon, 20 Oct 2025 12:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39430F529
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963173; cv=none; b=GXrwW0qiDajmPjkGWw62J4sbJjVqLKjd8AHmjkoAumLmvK0MJKN/AXPP3sPhlk+OoTHqN/Mmq0WQZQJQut7gJ2gHS5+8LjcRU9ujvyQUurbqzarDkMNqUEJPu3RR6GCcjaWZusrGf+uWY/DC62apwE9J8FtrYkxpKWX/m7y99xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963173; c=relaxed/simple;
	bh=phGJj3RgceRPqvLEhmuHYt6Xs/IlhcLpo7DLHPfSHTU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iERWERXLtuvbb7aQpG1LhjAAJtr8aCG0GC8hVa+C2UMgfyajsUny/MJyKJjLL35pCCfEYc+eHbWDGpeaFkV2037ZbBPIBvfa7oGSF8ztiHiFC1ikWCwYNdNm/Ry5ASTv3dc4W8I86JvFeWSdiF0wTNqB4F/cCikmZ2rxjtJfipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d789ee5aso16893535ab.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 05:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963163; x=1761567963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RPwyJ6zNa+Ilffcb2jxcjrBpiDHQo/NJyrIQpPWyVc=;
        b=jtbgH8ERJ/Ftp9RW+SikJfUWFLZYmXrvbjZqEr4cz/QgQsx7kgP1xyecqxt6nEubpk
         ON7FV4XduLSUKrIB826sISIyyLLVSG61niCiETvVaeh907sFW/hrcOX7pL7NxgqcUOig
         cwo4ezYlu2dkb1Hp+flAZq5jnHsjyvrBh0LvIHcIpSKVT/Hc55WC/JYm8EDu+0u4/391
         DNnVvvs1FNDevi7y6mXk/YUhBRLFQVO3dypoKxk4CLNRMH35Y1ZMOZsv32nimFA10NkP
         HMs8uYJUxDbwQp7sToO7SgSAsjE2u22b+8zhLXpPKEd6IohRptNLa/7+9c9O6Z6mu3c5
         s6TA==
X-Forwarded-Encrypted: i=1; AJvYcCWPHv3e8ajLuEDLepu8BrtabtdCozGcilklSICSiJZrlfzAErfDmV2cIlpWaxSmut9kiQNV9jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGnR9yqVIk6vOkjN0pcS20M2U37yLipRqCmCZAA4akSFziVjw
	/iL9hXY9AL1JYozBSgFqWPvf76RpunxqzrXPG/B0K03BKGAOYEAKMsOifVJ5zwpP6driKcc/7bz
	CKM0LoXbGJ6EG2RHNWUaftocGIelHKuRyz5R8hKSbS0Rce4e+QPyhGCc0eRY=
X-Google-Smtp-Source: AGHT+IFhXiAIcAqfy99ebruXdCEa/SBzSACo6L2+82Ibn7dHTxDMg6NCkkB444vB6/ZJc5vtm3ClNG5w24iLSEnx/iS4Vl5BUBSb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:430:adcd:37df with SMTP id
 e9e14a558f8ab-430c52b5b37mr199573665ab.18.1760963163149; Mon, 20 Oct 2025
 05:26:03 -0700 (PDT)
Date: Mon, 20 Oct 2025 05:26:03 -0700
In-Reply-To: <20251020112553.2345296-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f62a5b.050a0220.91a22.0447.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
From: syzbot <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com
Tested-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com

Tested on:

commit:         ffff5c8f net: phy: realtek: fix rtl8221b-vm-cg name
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11573c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=999eb23467f83f9bf9bf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15159734580000

Note: testing is done by a robot and is best-effort only.

