Return-Path: <netdev+bounces-93972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508348BDC85
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062261F23874
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA9213B790;
	Tue,  7 May 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBZ1e2+k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC2A59;
	Tue,  7 May 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067560; cv=none; b=RrQstek3DihkbDdnAnCbpD4yg+7e6utySo3uEd8EETrBazuKgzt+t5dXB+k0wfd0flTAtM1gvTG7d348W51FPpTN5a223TdfI5XUI3MqLs7m/QQOtluyanNf5ubLUqbLHDvSsY1DMg+L8KHB4gvjYhZDRd9h+HlLt+Ahp+zJhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067560; c=relaxed/simple;
	bh=W3rMoftBCTnFGhHuj562gmyJ5nTr3AiKfDHakVAztus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGXLPFFzyLCU4YJ3sXSzjRHRfwKfQZVDsKWLTOQbNOLpXwxkatkjvvZnZYBW+QgEjDnc/JnfAHAIK7QqF67YN/5krsydhpXbydfkxaGOICFFPyjAzGEnU3Gd7FokmB4HhH6KxnfPiWEmjm7yYMUIRtEEN9TtF4NDguErvZGVb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBZ1e2+k; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51fea3031c3so3443851e87.0;
        Tue, 07 May 2024 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715067557; x=1715672357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxn9PE6PqeRe9A+FKlp89jxfX2ErRJUfIgz4NjuiDr4=;
        b=OBZ1e2+kL6yBeLZsUAG9VgXgsWl+tFLc45HeNTbLiXFGPdaqv3qsdyDu6M/Jeaie0T
         dklW4ugILOJFOClaCgMN/FZhIDVB7Yqlr121xoDTGRC48FJR7mtGzdNF6yxS6kfsmICp
         macP3ORSfgoIUTi+7gqfQpMazu0cpgEiKwF0jsq3UB7bhRnC0xaML4xJZByqPHBJRaS3
         XH8+Rckzd9gPzJxHjSwF40RA2++osEK2Qh3ryBSj4szZS/igAGN6zrnjW2vD/MGIRkiV
         R+9y/xY5aWc/3K/2ifj2GmWDcXKYAXkleHpOrtuBfDJTeQa8CiR8ei5VD47oN0habNLT
         6TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715067557; x=1715672357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxn9PE6PqeRe9A+FKlp89jxfX2ErRJUfIgz4NjuiDr4=;
        b=gaBqIl3NBwPLd/on7pV8c0e2YrUfmIuTDWRNALrFTEHZ4zUgsfZhdkQzfHiit6W8su
         On/i6EEk/jFtTa70bqb/Nc6UwJI37xtyqtmTRyde01aOxMkrlP+ykyWptyNrubAVaHqE
         ZbBKKWFO8aEVAo+UhR7M1IxF4TvgCfxZaZ53ohp+tgYuXAWqRvY2zkU0p1f2882p2UEj
         69ph6SCT8ZoYBtc4UEbWuzPrLOdQ5AXSiLsT6LyRRNeWD6g5xqO48sdRR6multVscVhI
         J8kE23+HlzyUyuRAnmyn8HrYlxrPlSYJwpib7bmFyNfhEW4cSsgEttq93vtW8Bjb0W/E
         1RFw==
X-Forwarded-Encrypted: i=1; AJvYcCWJdN3xmyLEbAbzqLgumMUDyXwIGzfdFWpvaBx7AsqAVePVxIoo4I8XdnFj+6PFWsjrSuRTMXbA4KVqUxwm2ATySBxmymKL
X-Gm-Message-State: AOJu0YyLFLTwkYWbU37mHdpZIkqDWBaPWy95/b2UZSs3HVLwYtLAutsl
	WCAMggjpBpFXB6s7QdOCINPdVXeyB/mJbkJYS2CH7OTy0AZ8mkqdEApf53oeFti42Fo0BSxXpQF
	X08PprN602OxFHk1MAGDoBXQ1KHNhK67ytTU=
X-Google-Smtp-Source: AGHT+IG6MwTWs/fqrivz7LO6egxrTEGvus1Z/0Ga9g4atGV0GQFGxW3aC0oo32jK10Gd4z5XCUAVOQbdLs4XrdVSUBg=
X-Received: by 2002:a05:6512:131e:b0:51a:f11c:81db with SMTP id
 x30-20020a056512131e00b0051af11c81dbmr12067377lfu.30.1715067556390; Tue, 07
 May 2024 00:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOoJZZnXioMsaHNHVj8e77Ch8UqKhNcR_UrzU9tJUKoSg@mail.gmail.com>
 <CANn89iLFvGd+=YCbzm==fA3Q0dj=FC-gTZy3kVJ0DTpZ5hZC8w@mail.gmail.com>
In-Reply-To: <CANn89iLFvGd+=YCbzm==fA3Q0dj=FC-gTZy3kVJ0DTpZ5hZC8w@mail.gmail.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 7 May 2024 15:39:04 +0800
Message-ID: <CAEkJfYP9PdD=4kbqWac0ny+X-D5YdZrtqW8VukFak0zRMo+=7Q@mail.gmail.com>
Subject: Re: [Linux kernel bug] general protection fault in nexthop_is_blackhole
To: Eric Dumazet <edumazet@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:31=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, May 7, 2024 at 9:00=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> =
wrote:
> >
> > Dear developers and maintainers,
> >
> > We encountered a general protection fault in function
> > nexthop_is_blackhole. It was tested against the latest upstream linux
> > (tag 6.9-rc7). C repro and kernel config are attached to this email.
> > Kernel crash log is listed below.
>
> This is another reiserfs bug, please let's not be mistaken.
>
> We have dozens of syzbot reports about reiserfs.
>
> Thank you.
>

Sorry for my mistake and thanks for pointing out. I only checked the
call stack without checking the repro.  I will ban the reiserfs in
future testing.

Best Regards,
Yue

