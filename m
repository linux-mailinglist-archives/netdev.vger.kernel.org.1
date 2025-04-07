Return-Path: <netdev+bounces-179527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208CFA7D745
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F273F16B999
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE0B225797;
	Mon,  7 Apr 2025 08:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3D155A59
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013585; cv=none; b=Coz2pbavBltygUOZxXNOokRprh7To01u6JfSCJVhWFaAKp9czzcI2CoUU1u03dmPeR2CQ3Q33Blq5Z2HAH9z2sP9i3sY40BsdZmNHDmVYW8i4lmCe6kimGZUOh7e0AAeTzQYLCSL6KkAghjwCYjcBXSwdDMqY6LkVxT+0jBUYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013585; c=relaxed/simple;
	bh=q0gccAoDn/97jLK80bGmGnGBpb61IglwFSzH77KNYTQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WiJ2piAVrGNuqd1HPjYXtNRU/n/ODTLCz+c7K96AogoEXNmhrvJTktYjYZx88z/JYOAAR97nab1Tk5Unjj5ulQ5GsxGExZZqX2sR99FBYL1KdMulrrnov1iNxYmxHykueb/IDxwjaTrZy1FrT/BO6lNVAKnxo+EKswXvkD6BWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85d9a52717aso591056739f.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 01:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744013583; x=1744618383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChzbHSI+62rwdyKegLaasRCQDyxCws+/K6BLPNTrOAU=;
        b=ExncEJ0k2BPJICZtYjxPd0REhx66S44NDrrc8wx9CWd9Rk1kboOowJjxcklmhp1tB+
         Ld8cQIf95KctjRHxjjLkEoJ5klW+ePNmPMpgZOwHTVXQhnDBmb6dnjVifhOpnHlvHZqr
         6DPgcJdfJDHQ5CSGJbbZehfX8Z6+rvNFk3AcMKyhtCZ7ePAHToo09zPoSlM5eh7uzroT
         OJiWyyh7IS9y4iyHOq8xqlpvj/QvnDv6y7XnbkXJJHyn101/E4dlXMQ6XTqMemhKhwK9
         P/BfvQo1uOKgLGCh9t0IsyNPyJ7MsUdzJOtyW3/tdaOlAdScngbTULnzschQ4yoVcpEg
         IWgA==
X-Forwarded-Encrypted: i=1; AJvYcCUzgwC8IcmdQuZ/Y2QBoiDQuZQP069IYFvAf/sJXBki71MHRN5Ps14cpx3ooSu1Jz8GfeQEYBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XkzLV7tLUv6Ek2i3JatuaIPitVsjaBaGx1sfbq9AO1q240ZS
	0p9SR92tiYwFACDni/atAKKBR5p7v4thYc/eGJyWx3mpzOOlUoyIWrp2CaTuClUcJaLRmkIABwH
	XPJP9Rho9MZNV5BQx9H5js8Zc+2inSs8LbOqUQCcuUA7J9A7r/GUUj3M=
X-Google-Smtp-Source: AGHT+IHUGP7Xfr2iz2CIUvQ3ZQXT5qHk/M6C30TwlTFdSNUg2q++UOUJ1xNkhfknaV+YPus3Bqy0cUX2W5DsqhJIaD+h71kXJnXE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:3d5:894b:dfc7 with SMTP id
 e9e14a558f8ab-3d6e5876fe2mr99720945ab.16.1744013583420; Mon, 07 Apr 2025
 01:13:03 -0700 (PDT)
Date: Mon, 07 Apr 2025 01:13:03 -0700
In-Reply-To: <20250407063703.20757-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3890f.050a0220.0a13.0286.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
From: syzbot <syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@amazon.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         61f96e68 Merge tag 'net-6.15-rc1' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=111c523f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=45016fe295243a7882d3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f3bd98580000


