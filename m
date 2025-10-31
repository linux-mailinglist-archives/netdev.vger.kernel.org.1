Return-Path: <netdev+bounces-234578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C67C239BA
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7239C34D0C3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455C2ECD36;
	Fri, 31 Oct 2025 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxqUeRtN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9F2868B0
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896956; cv=none; b=ZG5ED5yQIeBbzXgewUmmiDFS0IJ4sm5wRA+fYUIcpIREUd8L1bO947C2C4nE33rnx/U2fQy/mZbidTxtXgjFiSNrPg9JtVDsEAzR1gEnSB43rBWTrZSSR0Azmk/iqvODQDufXTbZVL0ggLzzGVXwaQzcaES3ioxB38pTBxc1ZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896956; c=relaxed/simple;
	bh=mj/okHz5PHZV0wR4OqbZRN7R8+J74cRQmf1t7fmO9CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9m6lx04S3JQZeL2tbTrFEAEYN18xnNdnHMcopmnUD2ycuwqH4f1fO+qQLzFfctLsBI+sFBc6yzRZmJZAXxZNQL5kOSya/M9qeMzwesZ5+uXZq8JSGCfsXxw0Ef/iE9SKP7mhm3ZDJzAb82jlD+yWne0OGPLYWoowA58NrBkIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxqUeRtN; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7814273415cso19059417b3.1
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761896954; x=1762501754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj/okHz5PHZV0wR4OqbZRN7R8+J74cRQmf1t7fmO9CM=;
        b=SxqUeRtNx+BaFjKkAlBbX7Mz9rBWZvOHFHBBx7DvJ5kbVTi/gEolF71Y0iXVrEy8wq
         gfim5iF35rbhHKYutLaDI8vk26onDVBH2uUPdH80t55bHluITtWBV5PBuLppl7Tztvw6
         8OH5GnMoTFAnMF0cI4GQoHXMWJf96mgeHxbLOxAG9QKDeE4j6sh9O5W0a3hPcEhUlbxL
         oIi3F3Od+j3vwyg/EEvlD+EzM9wbu7myXB9DMTsN5FnyVaGQ4LbR9wHXRfJfte6Dw0Ai
         aDzIn5lKow3KOKHsnZKOHdN5bmQi8HVNYNU1HlWxA4PYe3l9a/LfhsnH1xr8N2ytovnB
         Sq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761896954; x=1762501754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj/okHz5PHZV0wR4OqbZRN7R8+J74cRQmf1t7fmO9CM=;
        b=e5c9e9HGum3Ov4Ou8Gpl10upP39z4raecrmaq5w6EpMBFHKnkuz9PAG9oTFHFDnNTD
         YRM/y78CPFdWwC/Gj0vjBdhHXpcj/nlCb+ayropVFzrw6J1BULkQQvwfT1RznaM8RyJ/
         JNtEEnPA/H4HfVFhziHKvlwAcRVXIwTf/cd8Gs78TQSoyTLkZH09xLhHBBGjXN3zjY51
         7qUiLEkdFUj3Z0ZjRWFhilSFEMQNnaexvbI231gJ2D5N3Q9xiESdjR18mwP+RXqJRzEy
         VrE/CZzdmTF+hdiBUNDru4/N7q2okUsNUM++wGx0Cnbln17toGiOlS31rxynA1Jria4D
         14Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUHz1kC3M/ey/vI1hB6MDmIDQFhAY9x8I6lWp/nE/NP409J86IDWADUpdGiqi/bAEIVZ+J9ZZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgc+1yEC2RdXLPFpTgCEHxw3heaIAyt4SNdLboFXNhU046oJMW
	rJLuWP2lgmpIF5NlVm9HUvDG2PHyXyDzv5M5cv4+lgr9XxUulLdpF7LR+Eyw5+dZteZ9bfdAImO
	eDC2saLXn3+HOgS3iDW0hkEVn4nWyBJQ=
X-Gm-Gg: ASbGncsJcDx3hjEXldKoNzUY+T+S6pvKkAuTICe0fgVuk2NGgzN2f+3ZQa2GNV6EBn8
	uf9UdrDui5p9VoHZsjb4B2F750tSCDrbV3KvyiTZpiKqg9HIYGZ1VszAC3abKSjPP3i2OL9Oxcj
	NMtaaMjQ7iv18risScjPB6SCDCmUfKV59nmE0SUgABB1gT0r+0XtMZmC78BbdncSEw52ao7CKni
	5+O4Mcq3cgX7xnopZrXwf0dTFfU2sBUi+NFSBms6amqVBUxVJF+w/dWkXINh764ABxJ/PIhmnG3
	QJlsLIscaLtcH1uIUXwvXQ==
X-Google-Smtp-Source: AGHT+IEccNo+Ud/dOtRufb2gzRJKeSMooBpV7Zz3ch+oKF7jaIplRlzywy5u4xYHf4jy/vs0gsE5Pv+qfW9zHowBm0A=
X-Received: by 2002:a05:690c:3603:b0:739:7377:fdc4 with SMTP id
 00721157ae682-786484dd91dmr22017567b3.35.1761896954009; Fri, 31 Oct 2025
 00:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030064736.24061-1-dqfext@gmail.com> <CAKYAXd9nkQFgXPpKpOY+O_B5HRLeyiZKO5a4X5MdfjYoO_O+Aw@mail.gmail.com>
 <CALW65jZQzTMv1HMB3R9cSACebVagtUsMM9iiL8zkTGmethfcPg@mail.gmail.com> <2025103116-grinning-component-3aea@gregkh>
In-Reply-To: <2025103116-grinning-component-3aea@gregkh>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 31 Oct 2025 15:49:02 +0800
X-Gm-Features: AWmQ_bnGnl7eYzzqxU3isuAIhu5FYgWbwGA7Uh3VYsm5FYbX-qLmiqhxk1Hb_ds
Message-ID: <CALW65jZgu2=BfSEvi5A8vG_vBKrg=XLs68UoE3F3GBOOpeJtpg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: server: avoid busy polling in accept loop
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 3:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 31, 2025 at 03:32:06PM +0800, Qingfang Deng wrote:
> > Hi Namjae,
> >
> > On Thu, Oct 30, 2025 at 4:11=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.=
org> wrote:
> > > > Fixes: 0626e6641f6b ("cifsd: add server handler for central process=
ing and tranport layers")
> > > > Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> > > Applied it to #ksmbd-for-next-next.
> > > Thanks!
> >
> > I just found that this depends on another commit which is not in
> > kernel versions earlier than v6.1:
> > a7c01fa93aeb ("signal: break out of wait loops on kthread_stop()")
> >
> > With the current Fixes tag, this commit will be backported to v5.15
> > automatically. But without said commit, kthread_stop() cannot wake up
> > a blocking kernel_accept().
> > Should I change the Fixes tag, or inform linux-stable not to backport
> > this patch to v5.15?
>
> Email stable@vger.kernel.org when it lands in Linus's tree to not
> backport it that far.

Noted. Thanks!

