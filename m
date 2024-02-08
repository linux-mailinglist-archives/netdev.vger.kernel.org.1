Return-Path: <netdev+bounces-70346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52A84E73C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 19:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEA41F255D8
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA380C05;
	Thu,  8 Feb 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="G9juobfc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F67C6EF
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415354; cv=none; b=Dll2fxoMoQ/SaOHujWc3ttYYoi+CQ8QFajl47jjZApb4SKzo3dcYuI2Tp1p/FD9/1EmtGZwrx8MyRnabOgbJetUN5KXpKFwi8UAo6U6fwn+2Q0Onc/XdzjE+mI4MP+lBJ6T3wUjhAutiUiCU8G9Q+t9rHjjGI2T7hoLIvkxiyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415354; c=relaxed/simple;
	bh=riou3+Fq36IJAtX+3pXoc7OprK6nvHOm6r4jOcoY4yc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RRs+HKeGelNoBcwQW+gT4uxu6TShvdo3Ypb6+NulCm4BBPylDEfiIJ2kB6MRzT3I5gkmtHaUqYAFnjaU9BifHnBLsK+fc2DhXDYziL8yeXYOCIPJ24IZXWt4ukqyZYf+y2zzmUuz/wMVe9zF8oWqTZnVLNa/6nhRMetBeiNQoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=G9juobfc; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5bbbe57b9so22981241.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1707415350; x=1708020150; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ct2+KwEphGhNOP8xmJwtzKkz6nxOVbiA85F9BV9whg=;
        b=G9juobfczZ87uv/ZcAqt9vSUgzjayK50vf7p0WgLoDJuEDUd6NXIHo7FJaj4EINQK4
         8HCBGZh46jm7j/9cUdJk1lRNFaWmoFIKPcnYOBSF5ZP8SLEo79Q5mNolSAkrwrXj/Oeu
         /Fb8jD31N4ftZy2IX0GKim14JzQKHdahgjGuf9TnsdynzUNKLhoK1jC+yzIqLZzrEKWv
         GYqIhzEm+6z97pXGo+IU6L/O0UEnoNYJRKwALprV1YfidU6O81+/0ZVoQGAe2XMm5jFV
         gz3ru0KqiFbQzSxySVMKE1REwvxXgK40xIllJY7PFPLyNNx+snTqulebhlFTUlZ68xEn
         ZhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707415350; x=1708020150;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ct2+KwEphGhNOP8xmJwtzKkz6nxOVbiA85F9BV9whg=;
        b=TBGaSCPz6pCVEJk1pij7gZFQfbUmH0wbJXMNUyx+/lyxOMAtLOh1dW0+qV10DP4HCD
         IWpicvrO4jDVNW44FHVq2Q2wQL1KzZhs+xdvLlQqH08SAdc+buiBPeJWDAT/Nly8vGfp
         hBJ/33GNNFY+ZxyEvOonqJQywjqa4NT+jcxQhPo/WifdZPUP0Y1a+kcgDWMItzLPYDxQ
         5yoOy3fN0TC5ddJtmJBEHjAIq7CM59b7gkxEQL2c2NvN+oTEbyizQSjhqzgWLF2zBSAg
         95Q3neX+/Y1IVVdvnPrVwZDiBQ3obr5CKaH/Ry75gf9iHVVD73RiSqRedfQ83NeDkWCV
         um2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8hiCuKfm21NzuICHnxEb1sOOqDqvl1EpmRyndgQy5xqa52AZzFXf/EUXKrGLB5H9pamsL5hS8McOyORnMaB9q/l15cQ8A
X-Gm-Message-State: AOJu0YzJkjuLSyDeMMau+kpbjDN6ckEoPN+cdhx2xeN83lzomxkEXHzG
	BCQm6EWyOzrr8SECB16A0TgMZ2Fw7vZcPQA123+WzDmroR4YfL/CCrKeg/pBaJUGaL2lLkpXoCk
	EQvlF8TuBP8BMkuofU+gMPpjFRap7mwdRlNHl
X-Google-Smtp-Source: AGHT+IGLrfIKEoBtrQsQ2izjfBNqiPKwpLuC/GJQ0e71z3VrVIgBnUc0PoA6C7dPbaTHUcTqKg5PGBdFPoUxx/8XDxQ=
X-Received: by 2002:a1f:c387:0:b0:4c0:2d32:612f with SMTP id
 t129-20020a1fc387000000b004c02d32612fmr318022vkf.15.1707415349870; Thu, 08
 Feb 2024 10:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 8 Feb 2024 10:02:18 -0800
Message-ID: <CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com>
Subject: SOF_TIMESTAMPING_OPT_ID is unreliable when sendmsg fails
To: Vadim Fedorenko <vadfed@meta.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99ve been using OPT_ID-style timestamping for years, but for some
reason this issue only bit me last week: if sendmsg() fails on a UDP
or ping socket, sk_tskey is poorly.  It may or may not get incremented
by the failed sendmsg().

I can think of at least three ways to improve this:

1. Make it so that the sequence number is genuinely only incremented
on success. This may be tedious to implement and may be nearly
impossible if there are multiple concurrent sendmsg() calls on the
same socket.

2. Allow the user program to specify an explicit ID.  cmsg values are
variable length, so for datagram sockets, extending the
SO_TIMESTAMPING cmsg with 64 bits of sequence number to be used for
the TX timestamp on that particular packet might be a nice solution.

3. Add a getsockopt to read sk_tskey, which user code could use to
determine the next sequence number after a failed sendmsg() call.

Thanks,
Andy

