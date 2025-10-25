Return-Path: <netdev+bounces-232764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D014C08B20
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 06:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D56A1B26D39
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 04:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4332882B7;
	Sat, 25 Oct 2025 04:55:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B46246BC7
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761368104; cv=none; b=KPI16YeVXRl/xkMpAxVWwm0Rn2eqPWUNITAu+XN0NCKHlcbKIVSxUxXAe2b+A5GhhID7NcFKojEH09QP1f/lXqWIOjkqnbpkvQC+eN3630IHf7Lv+eD0nzQ3BatVNYUa3TSlAIZuumSt1T/aWG/m3L5/RpcCiaBDq1GT11O/eFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761368104; c=relaxed/simple;
	bh=iktKT3WSsX5Eh5WpbJhRG4yNuP8WNCWNH5X4PESRAnc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aaWMUG9t4K8buSkA5xzZS/59g5Rw4uEP2oCbM/OYhtUhJhYqffKam/OMAgisfqd8zKnCrlyoD2eBEBaK7ZUKB/cKeoHlonFVAu6+wu83OF5UXHrlwnNyqwk2CiqkQDhRYyuJswe6jNy6uq2IFhLhZIQIs5FzTY4FP7CTb/Rf1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-930db3a16c9so252913039f.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 21:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761368102; x=1761972902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfohFdAczWF1WzY/GrEVTuUSveF/6y4Geu8fq13XWG0=;
        b=N7sc3hJwnjjTiNJ4xSNM89o6bavrL2NgLZW3OvNbweLUk2qvkhl8XWJhYnX9/nglg+
         WU7sJ4eMgJxxpz5P4uxQlwHTU6W/p0p6cXjTkiS2s+D1n3Pa76lPmi+Kbsc1d8NP0PXC
         9BcCWQG2DYs8Ey0QbLIC/FXXpIkUogOj0FRvS4kP17WXkLdymocXMfzYA8iYKHQzNm0z
         ZrF48Et/e8N2jsNGl8VKW261ljkgB+1F/1+O0ZUy9TnhFrBiEpQOytfdYwAIPaSuzp1v
         BkUpBSsR7TXLb5QbaajfA2PAeeD1pGQQlLeQYpI3jekz6IFadylVzaFHpxLpWy63glRN
         fEIw==
X-Forwarded-Encrypted: i=1; AJvYcCVxGXyNve1mfnCoTbn09vJzn6ucJmCXX2MDtg0ry/c/tcfUxSzPQW5PCKIXzEjrJudwROqTwwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZQKqu/sG82VYpX5mRi4WLcNCKFb+rU1Zs8HIr7alWn+8tHw9
	Rtlkq/GI+YnALdSrOJegPEwBrxa+FFTJj3KfNQOGzs0bt6untjzNsVJDlXbi1XUqYyGMkuNU3Gq
	43Jd+QtjJ+N4LncJsyqh4Iw80aZPWyfRWpuo/Qmu3jozZzLua3tZpdAOz/Oc=
X-Google-Smtp-Source: AGHT+IGmzN3hj7nTSLkXk9l23ogDW9Jk3lYuOUnF/SmoXNtxlLUT1tNfps/Ib9eNuMT9GWLVCiL6ZSXIMp0XiubP6Fz4W3ASkXvN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1414:b0:940:d395:fb53 with SMTP id
 ca18e2360f4ac-940d395fcbemr3180777839f.12.1761368102301; Fri, 24 Oct 2025
 21:55:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 21:55:02 -0700
In-Reply-To: <68ec1f21.050a0220.ac43.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc5826.050a0220.346f24.01f5.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm6_tunnel_net_exit (4)
From: syzbot <syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b441cf3f8c4b8576639d20c8eb4aa32917602ecd
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Fri Jul 4 14:54:33 2025 +0000

    xfrm: delete x->tunnel as we delete x

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160c5d2f980000
start commit:   cf1ea8854e4f Merge tag 'mmc-v6.18-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=150c5d2f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=110c5d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3df59a64502c71cab3d5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162c3de2580000

Reported-by: syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com
Fixes: b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

