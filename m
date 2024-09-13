Return-Path: <netdev+bounces-128058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A46977BE7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F59D1C24578
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FAF1D79B8;
	Fri, 13 Sep 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/WM/87y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F91D7988
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218528; cv=none; b=La7Sn5+2UNXmv03KjQlsTO7BEs6ctlBSz2OY9IkUdJfeJrGVKjFYgtAnF3ys1a73h9fSwzyRbpIARO6sqF44BGYE+qFHNYSZrkf8RrHFHQjWk5V4UduomgwYSSzrMTB6iUmbaa+5X2gs6HxTogq7erTENc7frl5Fd+TutBz7Idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218528; c=relaxed/simple;
	bh=gUf1P6a051fpQa+Zsx4o/CGIDi47nKng+PxliLFNe8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzeUO24v2Bq40PyrtNrstwBCRn3zmg6YsSlXNmQhsUPKf91hY6bwkw3tiWVEGefnTB6KW95+WNbOMrbMnXEUp9Y2FEXEx1K0aDwsKa2NZomPp+PvF65TzyRw1Tk9Fr6XVBsx+HJaL98L2i6vxu/W5G2aaqZ6Ewg6BweoVamPW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/WM/87y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so247799666b.2
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726218525; x=1726823325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=if6lVwBQ3rYN29cQP9B8Wl2cgILO0Izj1asDZSpYXBY=;
        b=C/WM/87yoaDU/19p66AEaOh1TG4HZ79GogVWo3iZwG7abjhkQJVP8ZFN6JaC+7ViyH
         5wv/z6IYJuv8hCdbwrtGWkaUuHbsPjbu8ppOjV6T0cDD5vvxdZaEQdruKQTbPdcBDVhu
         UoIC08JXAmXgvd3w6Du9tl8+Q0UBQzUoqnhLSp/mqP96HwKrMPtX08lV8BKQMGRqvE3g
         A/C/h/6VWLVGR+gy3m8Gqo/WrxhDOIp9EiniFE0h9YduKfJM1oifgFhNfvTkMOcEfoci
         EncgFnTMD3iIm35Abl0vW8kk97bz3Cj0x6otmW+L23mgoJk2IlBpHKbZBbUt5h3+qxxy
         KwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218525; x=1726823325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=if6lVwBQ3rYN29cQP9B8Wl2cgILO0Izj1asDZSpYXBY=;
        b=Jxpeq7nNfU6QFD5Y9ffw7qeTSnGcxNabbupHLDSj5rvhCVghDO8wLcZkbIyd9Dfqq5
         zreaDGniPD4kmbHmKjwTqUXY4UcxZN/ZfO60l7aMAWzJp/pa6mFKm6ni4mYurb+RCXo+
         XGAhrN0g819Zjik/AUGdurol1DUaB1hzOhPdlcUsr1MAejjBuF+GNmzul6EAVi3NJjwb
         omXi9LIW9Fj63wN1yZSK5k4qwOKBDMu1Bq9HOiE7e3G1OzyZPD4cny7+P+A0IH3i5UKb
         3OUfPM1VHQBIKeQ0t9l1P3tq6J2aTKcddUFZ3Lv1gfrSa7m3uHY/buQwaWSvx0LbcPLM
         CtKA==
X-Forwarded-Encrypted: i=1; AJvYcCVoFDLrqW0NRtztLvP7cp/Dc4QLdLMzVhRXKWdHgusTzcsgqsCkUjFtaryXFHvVFYARGCdJZLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNZwLJAORVWCanDT4pluexOKnSuSThojagDdBhD8fBiwxR+8N
	6UQnd3p+si6zo/8cTKlax2fQyNhosSCEIHYIZ/eddu+9EpRJ6XmJUwdiZXPzTXBaSZzQtW/T7Rn
	MMYUeKfrc3ID7gBV4fkQ/9byDLWOv9KRcTmelG5yw6EQ+17wxXAhi
X-Google-Smtp-Source: AGHT+IEp8fqNCUqCMu3S2VVPPVgj29Eg5Ceh1YsoPj1klDAxZJW1PBj/acrZ8GrRoLISfm8K+ddcAGtOTLtR5KhCm/U=
X-Received: by 2002:a17:907:60d4:b0:a86:a56d:c4eb with SMTP id
 a640c23a62f3a-a902973187dmr559124966b.61.1726218524456; Fri, 13 Sep 2024
 02:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000005348f9061ab8df82@google.com> <00000000000011b0080621f73dd2@google.com>
In-Reply-To: <00000000000011b0080621f73dd2@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 11:08:31 +0200
Message-ID: <CANn89iL0eakKDx9WvrP5zmMJV6=N75PAuTtDx3M=VfUbpXs4xQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in neigh_timer_handler (8)
To: syzbot <syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, marcello.bauer@9elements.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stern@rowland.harvard.edu, 
	sylv@sylv.io, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:47=E2=80=AFAM syzbot
<syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 22f00812862564b314784167a89f27b444f82a46
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Fri Jun 14 01:30:43 2024 +0000
>
>     USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17eae0a998=
0000
> start commit:   dc772f8237f9 Merge tag 'mm-hotfixes-stable-2024-06-07-15-=
2..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D333ebe38d43c4=
2e2
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5127feb52165f8a=
b165b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17398dce980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D112fa5ac98000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log mes=
sages
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

#syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messa=
ges

