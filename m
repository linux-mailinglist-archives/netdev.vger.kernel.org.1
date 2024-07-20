Return-Path: <netdev+bounces-112305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429299382E8
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994222813AC
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D11487F1;
	Sat, 20 Jul 2024 21:26:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF41145A1A
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721510765; cv=none; b=Wp22ZOZyJFlVgn334xt8uJrAmwYaTK69MsuLd1Sf494gkrfHpJo5iQIKmQc95UB7h0jkNmR3TyvEESIVy/lqOaX7Ror/7T8Ippr+gox3c7X6rnzZ6RJH2cyglnBnFjPN/3UpTX4K23a1MAwJMmXd5tU3aUVaEDX9kP/O+o33lcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721510765; c=relaxed/simple;
	bh=Jh7GbSSzpoLhE0yBdL+yraTkGtSkAMKNhPfifJWuvcc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hVs1cNb1Amxo9QokeSW4RI+Sn/SjAg8RQZ+OtmaQEb4wxlZebhocH+gcNLz3U1HC6ePXb5S/OVRLEglKY2ByRr8b5LRGIhIK+IgdNus6FCVfKyv1s1C/5XX+rzNFxuUCl6SGTD04RDH7uH30cN8W44K6lCr7rGDg5Y3OLHFoM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8152f0c4837so452409039f.0
        for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 14:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721510763; x=1722115563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rV3Jud4u6ISVkUf57AM/OWGABipbBpR33pvi9L9imf0=;
        b=qydwljt1qTp+NEUUARUjZ5IQk35CQTp7OFu9HhAbacMQjbdecD7InMWBMKkvIHtTxB
         gDmw4vtjwJoBCK+a2pM2FxRkaJzSZCdgEeZClDs+1v3iHpI41zQgHdYJoPkEmwgtFSeb
         /crEAvafnOmN2lJwYwEh6DsWA7P4OX7ftWuG20wD2v7NbE2Ldo396iC0iP2uYubsnLnz
         zpNsR1yCGyLQGgEHE5f1zhE/MPfCoR87zthv/L2WVthLG2W7JqdQT0gNspgb5OnN5TJB
         vMx8O8hJIF82hBaxyNZ8+6p+VNeVCDtDvNT8SjCp7daYhNDsp1rPMGovhNn3Nt0tgIXZ
         XBAA==
X-Forwarded-Encrypted: i=1; AJvYcCUPaKKy0RuWrMNdAKrTvZ2oLphwA+3X12VQwELz/IFfOWOHzZ2Zl4bqXSdXV6nzRVdmqOBJDq3irpdH2D6oewFFHfggxBAn
X-Gm-Message-State: AOJu0Yyg882jbcLFKZGIjUgojwlimvNnIorVFbVplOAOVJQ3ID9odyJc
	AdWz1ujVhmIY7BFNkQ3n8FgMayr6Xs+LX6oDeCd9ywD8JUDWJ5ctzqfCx/N2DG/hdMd9AqkMiv/
	aOTrRVM6YQLV4x7LHl1kb8AE13dN0gvzK8V7jUasOM5pwWXUkLZ1w4+M=
X-Google-Smtp-Source: AGHT+IEQTiMIoVKahfKrJ2z1F12FLyLT6dj7lbMUMrda66T2tEwe1m8+YfPSpErFcBqj+DnHlbRP2XsslOt9r3MXMqKSQntflL1k
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:d509:0:b0:808:469:7077 with SMTP id
 ca18e2360f4ac-81aa7638413mr4755039f.3.1721510763376; Sat, 20 Jul 2024
 14:26:03 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:26:03 -0700
In-Reply-To: <000000000000eb54bf061cfd666a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008750c8061db47514@google.com>
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in synchronize_net
From: syzbot <syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com>
To: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, j.vosburgh@gmail.com, jhs@mojatatu.com, jiri@nvidia.com, 
	jiri@resnulli.us, johannes.berg@intel.com, jv@jvosburgh.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit facd15dfd69122042502d99ab8c9f888b48ee994
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Dec 4 20:47:07 2023 +0000

    net: core: synchronize link-watch when carrier is queried

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116d4a1d980000
start commit:   523b23f0bee3 Add linux-next specific files for 20240710
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136d4a1d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=156d4a1d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=9b277e2c2076e2661f61
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148611e1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ec9585980000

Reported-by: syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com
Fixes: facd15dfd691 ("net: core: synchronize link-watch when carrier is queried")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

