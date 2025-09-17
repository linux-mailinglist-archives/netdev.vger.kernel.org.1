Return-Path: <netdev+bounces-223832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B3FB7E813
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4CC1C00B63
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B02DBF52;
	Wed, 17 Sep 2025 02:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0824429DB6A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075186; cv=none; b=i/cgb/taFCDyKCj1JoCd1fYgogDQ17TqjmtLwrlg9agYAtZoJzqtSxKSOVtOd1YmEAvzEAOAAP7b/mVAOKeeDsVtXAP+spUDD/2YTHLx3f7RBXdsElPorX9ekvs41kgPRuwNH3Tcssv7NjHOjifQC4TVCnd1FEnFVcu4n6WQCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075186; c=relaxed/simple;
	bh=6g5R/CWMwYhd5/WdCqBRyVlAAiYoh903mjsN79+AlgQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A0g5b51Zl1Y6pwbshnvdbDR2hD5PsrisKTHEV7Qo2jHznQrt9K4QYC6R78l/5uBAEt0ejJO/oUmfQe004rcgh0K6onFk57dqWDz+2bMPS03zvszJciVcq5e4HBnErOpKO/SQ5t6f2dRKCBjzq3ZMrJitGFCdvl418VyFLYp6wlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4155725a305so82834725ab.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 19:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758075184; x=1758679984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx9KHdVtHZIgjGBqLS7wvJNBVbVLbHgFsIJKE5SzA2A=;
        b=IL9iq8k2xm2T+nF9IXkRAHE7MH8/WVY7hgJlVrWrXK01/E9XZiWbVgkePdhKZgVPZx
         D8qQ39nV+qaDD/sFAkQttOFBmqBnCnJYPxBEXlEhi5tv/sy0e9lH7If4+BmtMisgCWj0
         +KzyjsTomVayzTgJcdy0ThcaiEpwzbk+3QfcpAJxcLcCuk1tctLWuFj9r5X5LnhZ6KWu
         jdWXaUa3lZrmiClH7f2dyoTB4WUo/NWQlTciny8hlYhft/382a4epNEMZtyBVJixH84Z
         0KtEsdm1rm+YMoa66+H3n+F39mrXevSVf4LXa2HLn1WRansuPRXicXfaYs0fpd6+vJXA
         R7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXIZSvBE/YUvw7dVGnKOhEKoNSXNu5XYfoho5ejyeZOYvPyARdzWCS8PfrcLXD8nF225iCpl84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3yARWyCwmcsWCG1ARgrrWd7rvA0tNlC+2sRqz9hn6TPfEUjvw
	EtI4Qm0C35NVJdpxRs/ma5FeTFm1LjKjfZR15ykk6O8l1kOVqqAy1Z4KA2QJ7z8/KJAYbiRczNX
	6271gH4UlQgvyg6ONIYeMKaz8ZdFHqAwGUsh36eCniS0s4v2ZLo3Ux7yCxpI=
X-Google-Smtp-Source: AGHT+IF+Xp7F2zdQBLS6SfovYyoE419pQjxvECuoP3lsjzjgdtWD70iDaZp39lRnVWoebUhj7MfmUrcBlwtX+cSlj+PwarwdY8fL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-4241a56dbedmr6050635ab.27.1758075184290; Tue, 16 Sep 2025
 19:13:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:13:04 -0700
In-Reply-To: <15d03ed6-4913-4498-a1d4-9f4f2e43d7f5@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca1930.050a0220.2ff435.0498.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in napi_gro_frags (2)
From: syzbot <syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	lorenzo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, toke@redhat.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/tun.c
Hunk #1 FAILED at 1875.
1 out of 1 hunk FAILED



Tested on:

commit:         5e87fdc3 Merge tag 'batadv-next-pullrequest-20250916' ..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6c33a7db07dbea2
dashboard link: https://syzkaller.appspot.com/bug?extid=64e24275ad95a915a313
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17600c7c580000


