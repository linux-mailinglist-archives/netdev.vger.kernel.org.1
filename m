Return-Path: <netdev+bounces-235833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E394C363D9
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 16:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA321188D8E7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81692328B7F;
	Wed,  5 Nov 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zLSVH+cp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B630FC00
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355390; cv=none; b=YT7KSJgSHVVbGZxCPfXrZooGOfYg+dhlzg+g4f8R639rGT5h18OfqXzhTuWplg5Mlj4kDQ9pYS+pr68RMepeo8n0XmPJ7V/jCLggOdzJHgpzVFI7xKtIqJ7RUG8ZWbWTN88v8NGCH/wkZbqDzg0U6BWS8wF4DBl5PlH+MVy94QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355390; c=relaxed/simple;
	bh=pkzDDAuu5FnbyLu1BGgHTr/rHEA+02rAzTZAHJGNYkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTOZZq2XFFhI3kPh7mT2f0lWb1SAGWa5YXp2gPD4tb+uZ+86D84E1vYjO9j68tXpAhZtJYRI14IP+4wh9EshKfZiNqky3v//zBUFqPbOANVj/DJb3dZ2cA9wgs2Jrxyp14gkYn8lbK9X0anzDPwcPZmpzDUriTOzhCMru4yTpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zLSVH+cp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29555415c5fso58656365ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1762355388; x=1762960188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npKJdQ/SFEjnsTgPu5T82klgRkrk6WAaS5E6NxS8cDA=;
        b=zLSVH+cpbs1qR5NQ2o43wKSdaOVaS1VtdhnlDEjIX8/9Ajn4HwN6wKHZ6uOD+ynKqZ
         rFTmElrFEmRgMW7OSLqFBHrgnI69SzNmrJhkAGhTk0oAvDWfl0qh+tUGsuwqzgyBkk1K
         ZcpqZR8ls6O0FkaofhQt0cj8b9sYOWUsgrneIQe/qf1DPZKkkkv0B3rg8U8WFEWifI1x
         hQtLuePdI1a8F1YLaQvRLqy9XsOywtP5mPyY8V4Ecyd6yH8NzgRqa3V+PAdNEr4nJu1Q
         2AEp8oyE79PeRWYxy5fkRCZTrIMGdso9ivrUurV5lg0tdWSZDNj8xia4WY0ZIc74/UVq
         Xusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355388; x=1762960188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npKJdQ/SFEjnsTgPu5T82klgRkrk6WAaS5E6NxS8cDA=;
        b=mCSRC3lx1iROt0xeNoxv67L7L5NroFtyInrBQd6yNocSWyETK0LyqQSl9rP9QQEAEG
         5Bo5l1fN2BNvGr+RkHXP+WNMujPnjnChNywM3WOiyOqW3O7mwWJfoQ8paj1er8+6rOQF
         CSHnMhVGfQ+7iir8imgLfMUAUERVDtFUhE6F2D1scOx+JiZTyhK0/6Deb7R5lNdgjKRz
         Rjow65ORgLjhgepdiQ4Z9zGD13OjX4cuQvX7SHirkLpW/VuLe4SfLSNDsdNpsEM/4FnB
         Un4k8mLdr82u4FXp3RG2fsOuWN0Jcuwe7TmcwtaN2sGZgvLF+4cnYVfoPlZrORYdhCwL
         dcXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3h1pm4vp6vjfYDneliV2bNpsakGWkoXWwr3gD7yORz5zgGlSP9RKVqTEfrZcZTtv8TQLFg2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LAUy4tDHvzeXJ1ifmJd3gEG43meEGTyQVqsBVcpzKTKlM3U9
	3u9wdMABMB43NMsl+sM6x4/USbSH8HxO+jB6Ppo2KBMNVtXFXclpsHQE55KQyTiIR4u+g6s4WuH
	NA08md5dfTMjQMI+UIIvfmTG2QMK5mDuIFzE5toY4
X-Gm-Gg: ASbGncs3+RV2lhe+X1TbCDsP+/gKX7QPY8gMVggu8DvXSGIxA8dwaIy0lyvbKfvbPX5
	U9ZPiz0RHlBoH8pBoWPaP+/6QzQx2pnQWvt5rtgnQZy3xRNTJwy8ltUQTkWsHr0D48FBm8UyDq7
	EgD/nPW8jTYUZCkvAy6c0lr+l7BdaEtbj44/c5ApjA5vmAbKg9+7xUd5oofep2W8YFEJHR83Nlw
	Xt1j0VOZIaA4L+O2veoHWIwum3nu/AXedFZrCJnQ+PBnjHKBbIy5UjJ6WLkBkesE2G3iv5CQHu1
	jR0KPn1rxvXjK9h7YQiqOWn6/GboLrpJIp0t
X-Google-Smtp-Source: AGHT+IES6bIx3iRmi6TnNQThdacyfXUn2MC8E/Eb3foVxURjYD3jCFL4B2OtVSRN6RcZ3uuhcllKhvneK9OOZ9vCQ9U=
X-Received: by 2002:a17:902:e943:b0:273:ab5f:a507 with SMTP id
 d9443c01a7336-2962ad3b1a3mr50683155ad.21.1762355388147; Wed, 05 Nov 2025
 07:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQoIygv-7h4m21SG@horms.kernel.org> <20251105100403.17786-1-vnranganath.20@gmail.com>
 <aQtKFtETfGBOPpCV@horms.kernel.org>
In-Reply-To: <aQtKFtETfGBOPpCV@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 5 Nov 2025 10:09:37 -0500
X-Gm-Features: AWmQ_blU6XcDEnFl20FbnBbH6b7zO2BsFs-Y_L7D1GiklwITbV2JeRK3k2GQLkI
Message-ID: <CAM0EoMnvjitf-+YFt-qsFHXOnZ4gW3mnXBzMT_-Z6M_XSvWbhQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
To: Simon Horman <horms@kernel.org>
Cc: Ranganath V N <vnranganath.20@gmail.com>, davem@davemloft.net, 
	david.hunter.linux@gmail.com, edumazet@google.com, jiri@resnulli.us, 
	khalid@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org, 
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:59=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Wed, Nov 05, 2025 at 03:33:58PM +0530, Ranganath V N wrote:
> > On 11/4/25 19:38, Simon Horman wrote:
> > > On Sat, Nov 01, 2025 at 06:04:46PM +0530, Ranganath V N wrote:
> > >> Fix a KMSAN kernel-infoleak detected  by the syzbot .
> > >>
> > >> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> > >>
> > >> In tcf_ife_dump(), the variable 'opt' was partially initialized usin=
g a
> > >> designatied initializer. While the padding bytes are reamined
> > >> uninitialized. nla_put() copies the entire structure into a
> > >> netlink message, these uninitialized bytes leaked to userspace.
> > >>
> > >> Initialize the structure with memset before assigning its fields
> > >> to ensure all members and padding are cleared prior to beign copied.
> > >
> > > Perhaps not important, but this seems to only describe patch 1/2.
> > >
> > >>
> > >> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > >
> > > Sorry for not looking more carefully at v1.
> > >
> > > The presence of this padding seems pretty subtle to me.
> > > And while I agree that your change fixes the problem described.
> > > I wonder if it would be better to make things more obvious
> > > by adding a 2-byte pad member to the structures involved.
> >
> > Thanks for the input.
> >
> > One question =E2=80=94 even though adding a 2-byte `pad` field silences=
 KMSAN,
> > would that approach be reliable across all architectures?
> > Since the actual amount and placement of padding can vary depending on
> > structure alignment and compiler behavior, I=E2=80=99m wondering if thi=
s would only
> > silence the report on certain builds rather than fixing the root cause.
> >
> > The current memset-based initialization explicitly clears all bytes in =
the
> > structure (including any compiler-inserted padding), which seems safer =
and
> > more consistent across architectures.
> >
> > Also, adding a new member =E2=80=94 even a padding field =E2=80=94 coul=
d potentially alter
> > the structure size or layout as seen from user space. That might
> > unintentionally affect existing user-space expectations.
> >
> > Do you think relying on a manual pad field is good enough?
>
> I think these are the right questions to ask.
>
> My thinking is that structures will be padded to a multiple
> of either 4 or 8 bytes, depending on the architecture.
>
> And my observation is that that the unpadded length of both of the struct=
ures
> in question are 22 bytes. And that on x86_64 they are padded to 24 bytes.
> Which is divisible by both 4 and 8. So I assume this will be consistent
> for all architectures. If so, I think this would address the questions yo=
u
> raised.
>
> I do, however, agree that your current memset-based approach is safer
> in the sense that it carries a lower risk of breaking things because
> it has fewer assumptions (that we have thought of so far).

+1
My view is lets fix the immediate leak issue with the memset, and a
subsequent patch can add the padding if necessary.

cheers,
jamal

