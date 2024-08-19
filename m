Return-Path: <netdev+bounces-119824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728D9571F3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544961C21084
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC0218B476;
	Mon, 19 Aug 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oo3JYXkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A118B46B
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087748; cv=none; b=Q3kT4g5TahmM7eX2ONAXdt+2gktL4AjShDk/Dnb1/HT2tdF8w7tTJK+09zAOHRvNShhrwNUX882YG4Z0Bd8fXyo6icKtiZImImX8/eACL9YpRe9If7BEUG8cDlt8A+9LcFfwQWtGSdJ5bGXMU5sB0m20bZyk0+GWKAy/OQ9mI7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087748; c=relaxed/simple;
	bh=a9rr8Zzfaj6zR+sz7AUJcd59Kyz9qMEm5GJnXatsP/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUSe4fQZjbaCrlraUXlbs9HNHmPBq+lclkXlagf4CSebYvhGKtWQS0/o6hg2pRkDzfVEKdVWugyIHo+Hm5HcHgxsldwWt3mo2xtGgywMvoQ4C1DS4Qh6fxol8T1Eko4QfUeXvQe071ZWaT1ARLEokWa2WSCRjNDkqiTzn6EVKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oo3JYXkh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-530e2235688so4941632e87.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724087745; x=1724692545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGFAUwiyqzEsxE26Pwxg3nLYP/NXPqeq8pN8cKZ3Iww=;
        b=Oo3JYXkhMjvLaf0YkaAcIXACGXCuhtJFVQaFlDgvOX+mytrqPZlwm+f7XLpU+LOv4c
         7wyw4EuAZ2vF0gTC3Vjoq7PkXe/0Yef/eQZOcC+ykJhM33uk3nqZSKhXW/okLAVTqNIb
         BZiPm7aLbc7F8q1mCwvuxzKrBoqTa9shu+eViJdF7MQl5+p9sS0nAOgrx8Nuo/4uXAiv
         LTxv3htF5VjYT7KVTd2+IBRtCd44S/13rwsQs8mLNfUAOypob57+Ptfrn8dDo/RGLRA0
         YrTyAiOJOFm8KXkj4Sf7DoLUKTJaNq3UEUIUchH+YaocWETGMG19MyKLnb7HHd+wJq3Y
         2RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087745; x=1724692545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGFAUwiyqzEsxE26Pwxg3nLYP/NXPqeq8pN8cKZ3Iww=;
        b=GwWnPDggJyK7fU2ZMoxcuo7GwXd1l2F5h079vWGG/ezyELjqccAm9ceeqm/oKEfaC6
         sUxTSBpnBUqsoOqyvoiyGupkq/oL9wmXWnbmJPKfHjWhNSS1uUzgttI1iPT+JuTCiYyc
         9RueYGkgdWO9bXeUBb0Nnng2SAMXXq4SMAAG1v7Smb/nuzAYRfVZGBe090WKy9njsQBP
         yXknkmmiY90oaWk/Rda4eriUaDWEyydtiYF9mE7GXgAFAiPCgf737ZVTROX519LTHQAw
         6poUHklwyNBiAegYWI5AOYi6CLwphytQYvtt/uOkRtEmK1rUarDjtRFo1aIATop/aWxE
         QO8g==
X-Forwarded-Encrypted: i=1; AJvYcCXNqOZgjbyryBE71wv1L1tUrM1IOYvtUpaIW0TVqU85Zl71+hNg5EOl2hDdCFzoMr0+5ZrVSy2Q+stv9+2g/ZniSUBLMcv1
X-Gm-Message-State: AOJu0YzrO3mt70rFGpYkFrBsyyw0ECWJzlLhmGqZWzDpCi6UXg99yOz0
	G6d4TN9qUQW+42VB/WKdP9B21mUWDLbSZOOJJVs6/1gwObKkouHn6yBO25L4mF+XMo6Ww2KykGh
	2VCrCsa5OVKO61frYWrEae6Vvsn0bmcmRpR58
X-Google-Smtp-Source: AGHT+IG3RMSvTLr5DD7i3LgrwUZMDv9J+nc9wOhmqtPdDc6nEMnVt8MCjLw3hxdwcpq9I4ecKLq2S5tT7JLavdchNC0=
X-Received: by 2002:a05:6512:3dab:b0:52c:c5c4:43d4 with SMTP id
 2adb3069b0e04-5331c6f0065mr7523990e87.53.1724087744655; Mon, 19 Aug 2024
 10:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004fd05a06200be9c1@google.com>
In-Reply-To: <0000000000004fd05a06200be9c1@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 19:15:31 +0200
Message-ID: <CANn89iJF2TtaF3XBxGXtRQ_ek3RKSL5HWzVrb6r0PvZYVZwUUg@mail.gmail.com>
Subject: Re: [syzbot] [net?] Internal error in sprintf (3)
To: syzbot <syzbot+3c22895086835167a3ce@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:36=E2=80=AFPM syzbot
<syzbot+3c22895086835167a3ce@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    47ac09b91bef Linux 6.11-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10f4843998000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2b3e97716aa87=
b7b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3c2289508683516=
7a3ce
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm
>
> Unfortunately, I don't have any reproducer for this issue yet.

Stack overflow... we might simply reduce XMIT_RECURSION_LIMIT from 8 to 4 ?

