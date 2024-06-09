Return-Path: <netdev+bounces-102059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223E99014E5
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D911C20D18
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F61C698;
	Sun,  9 Jun 2024 08:10:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0018EB0
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717920605; cv=none; b=CKXdzuV98XiW5p9aUBzoNICHgcF5UlyLTb3om4PWDU+JaTzdlcV0SCmffJLhWgD7jMkHyqN9/HHDmfQRrLc5xh6tshyp1Bum46gujholtC+LIqyqYZwUui/6zEF4waeMprzHBH7b456JkQ0+3PsmeFszO4YpvubZ3Hzvu2MxlJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717920605; c=relaxed/simple;
	bh=GS9aZJ+LvBwTLtq/qNJhQCSTx+jEOzzxkyfkjOGKc3M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MvzKUhdq+CGJwBCNvugKHobjftmV36lbWDssWjSnWlNvWMblSW8f54og0gJv4pt8oYSI4kdwh1uDG0rKQFQLgRDVESEbv43b0O23QkKNAOB9ZvHQSqW3zq3itcwT3GlHf6C0jMhV2+9GbAfkF3zt4ZTLXACgnnuvdlnn4LpImAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb7cf84c6cso48940339f.0
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 01:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717920603; x=1718525403;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNJralV27Phiz3+/bwDTU9IpTrdPF0Y6Sddk9Gzyfpg=;
        b=xJkcfpDeMby9pi+S93nyVV46lhPbCFZ5mwbwQ2g2cmC5WoSP+rDnGvFLeRjkaxCsHH
         cj+WXSVCmXtJo7J18ySD2ZlB5H6VFlX9X8+Wm56J5a1gTGygfISyE/Veh4K5ErkfrbPd
         2WRb+nyDRVU9g+QfZC072t0myNruKmwNOrtr9HLbd5wBEvR8L8voVDY4hWr1rQsI9E4/
         XvSRKW/Hw4Emtvp1Su9SId3As4d4fjblTllsVpzAY59Wr9MuHY51VGbzwWVIHgyd50WW
         g0bqw1dektasygTuiGetr9RtXnfwyVrP0ff6GxLLfQG/Hmsv3WyIzbLZSnjC5Xr5SPZV
         Xn6A==
X-Forwarded-Encrypted: i=1; AJvYcCXyGb30xmKq2/Ob0cNrMRsOsvqW9MjYnsw4/ZTIk5E+imxs3tlvXcJ96bcrgiIJA0zEd0DWVJhTKjgfvc6W+Py84SrwOBxA
X-Gm-Message-State: AOJu0Ywz+8SS++hKz8YtZi9hC5rZ5w676c3icVOWtIfzqJHo5XFtxkOE
	1vp/xwTkl04a4CQysgTbQzkgsPCN+ZOqh4XqbtF6lqFCL9lqNEZpkI+oKirFJmDmMerb0I6g14a
	xncjuXOmpJnmtD/8id4nkdL6sq8jxfBEhpptp1iX5uKYJmd/k1BodhQU=
X-Google-Smtp-Source: AGHT+IEy9eOLWJpA4i/hRidAbGKrxF/9TU6K0IRIrcf+HYaBTgTEqoKqcY/Zmj140g39ubNQ0I2CaTEli8UDwsRi4WZw+p8n0Arx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9806:b0:4b9:13c9:b0fa with SMTP id
 8926c6da1cb9f-4b913c9b5b5mr7429173.2.1717920603137; Sun, 09 Jun 2024 01:10:03
 -0700 (PDT)
Date: Sun, 09 Jun 2024 01:10:03 -0700
In-Reply-To: <0000000000002a48dd05c506e7cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d7aac061a708fa3@google.com>
Subject: Re: [syzbot] [usb?] [wireless?] divide error in ath9k_htc_swba
From: syzbot <syzbot+90d241d7661ca2493f0b@syzkaller.appspotmail.com>
To: ath9k-devel@qca.qualcomm.com, davem@davemloft.net, kuba@kernel.org, 
	kvalo@codeaurora.org, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paskripkin@gmail.com, 
	quic_kvalo@quicinc.com, syzkaller-bugs@googlegroups.com, toke@redhat.com, 
	toke@toke.dk, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot suspects this issue was fixed by commit:

commit 24355fcb0d4cbcb6ddda262596558e8cfba70f11
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Date:   Fri Jan 26 14:02:17 2024 +0000

    wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is compl=
ete

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D155ade029800=
00
start commit:   e8b767f5e040 Merge tag 'for-linus-5.18-rc1' of git://git.k.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da28aee0add07943=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D90d241d7661ca2493=
f0b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D130fa98770000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12f2d26b700000

If the result looks correct, please mark the issue as fixed by replying wit=
h:

#syz fix: wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is=
 complete

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

