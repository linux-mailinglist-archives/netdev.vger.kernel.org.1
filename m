Return-Path: <netdev+bounces-232600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3747C06FA2
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE6F3A4878
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE1731D727;
	Fri, 24 Oct 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0KIq5/H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F283AC1C
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319585; cv=none; b=VDw52Q0HblC4VyCkbeDpLaGGSj5V6rYKY8a7zSdFALQhN8T/vlCOuKO4uqaOB8AwzccjpBDCSEGnx/GJo2FViJ9JAnntx6JWrJHAnooFiON0C8JWKLYKwbTyUVUOJtyEugNBRrrt8kQoA9NYct+O2J6wVrIoe1EOC7gqCS4Em8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319585; c=relaxed/simple;
	bh=h/b/7B8erCyrj3JILyJdzAZuB7zL6Tarc/A8a8l+KZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAvGfAW5dpBTutRKDVx1jV0oQqnT/tWrBMoRLRdqyCDwBnqpWjN5TWsunSijQhYP+1VrzxKT9P1+tJ3KxBi8VXFLe/QfqfuIjnFCd/zJBMKczXHupLMonfgTWqYEA8Ej7rhaa9Y1ofp59hbjoEBpcIU20pWe/pcfm2aH/gnKyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0KIq5/H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2897522a1dfso21742005ad.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761319583; x=1761924383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/b/7B8erCyrj3JILyJdzAZuB7zL6Tarc/A8a8l+KZU=;
        b=g0KIq5/HZZf3ko/3+l2iddwU0TggiQp08dyB7an8s/wTYN7KiVTRI9A2dpf/E1JMMk
         VTj4gGg6R7yT43GIQM7yI6ZDElG0esYFNVO/h7uS4GVFIR3lFrVyigu53FVnmuMeWOmE
         7mR6OsnlC4vumadBl0SUfluN2NZChXhRc73DQopaGbchDoPNEsfM8BQRabowY9qFO/zp
         v7sXQKMphHDhbUje1KldF96MmuOMniJdhflZJ5RTBxR7cbiwXe8nb+2KzynixOOUhYcA
         2ml2cFSGwlTY5LTPQb+36oOkS+53/7P80IoeoRIdMP3yqPjXeSb0u7mVyr+lUJ7wnN1x
         LLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319583; x=1761924383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/b/7B8erCyrj3JILyJdzAZuB7zL6Tarc/A8a8l+KZU=;
        b=H4ViXEEY97ljTNmyRw/hCYr0m3ztS0ae2TmtAV8R6sEL3hAD869SULUrcQq6FnUnts
         7y/ChFYB2/KuHwElt/kRIHNN1hqVOK7FZwUbfO+Did5LZf1Tv7Fd5Jqk8n6zJl3q2NIX
         WH23fjYGQqre3T6dVcPM7fDi8qwS8v9P/QfBrOr5aur3VnHFHU+7tnrubBOusyfp6d4v
         zX5ZrYN84gTVKZKroooEHd1Vu2FeRpZYTa0v7baJZHSB58NcJF+J4ohIaBEPjTm8jQa8
         dSyeprAgr5fgbbt5p7fEyuVkUCB1+y403RoVmHHfS5+m16hDziCDurcIz0KSDe9YGNJn
         vnsA==
X-Forwarded-Encrypted: i=1; AJvYcCUeosD0s4X3RC9w4DwKTeeZpuQ8JJIZlqT5F9q+pDkFtyz97Y9sGqqvFB0cSxJdtsErIEcNgWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz33T7Zd7w/fXXwcnV4s8b9mAx9HHUSrL3fX93hcB3fh1l0bM2h
	X4TqCJG8T6+4N9ZTCLZ9pFAOjCDYy91XleeKJor23cxygFjg/L56fKsk1yC6gvOqRXLh7/o2laX
	Fo1LO8RdESmYA/ITmJNSo1tFyNKDvF2Q=
X-Gm-Gg: ASbGnctzW5j+qpyZcOw98CgrkYc8WLOXDO9B7I5ITr9CCF3VqDfs7qoc1F3cmph0hmA
	Qzc2rkzDkzMKbwwnv7tkppApCWk3TGru/qfcxAFZ4/luajh0ABIL2g552D/DL8Onijl5j5HdUEN
	lQ4skXequu5nltcetqGrtk4GH7h8MnQGmUVghoGQkQFZSNnEsbhSup36mOyS5Xjf7WLkSDnkJwI
	c6j8zejOW4JeiEcqu8b7akH4A42os4QKrG4YfzFR3mGWMwbG6ICoGCRk5qBW9s=
X-Google-Smtp-Source: AGHT+IEOKdDxMb9HRkXEYTo6SU095pGaTWP1Is+4rDD/byL+J1nKnOMtorV+TskGEVX3KZgpNdKNwa4mrFcTz3mie8Q=
X-Received: by 2002:a17:902:f68c:b0:27b:defc:802d with SMTP id
 d9443c01a7336-2946e0ebeffmr84709465ad.28.1761319582838; Fri, 24 Oct 2025
 08:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-8-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-8-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 11:26:09 -0400
X-Gm-Features: AWmQ_bnzIhVV3MsPnWM2jSZ2tqW9zy4mQ0zFymu--KHSuU72fnUF-ZQu5fEvqAs
Message-ID: <CADvbK_cBbHfXyKe9=_+BH0VB-c73hRsNG0Jiitvh+48Y3_ydUA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 7/8] sctp: Use sctp_clone_sock() in sctp_do_peeloff().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> sctp_do_peeloff() calls sock_create() to allocate and initialise
> struct sock, inet_sock, and sctp_sock, but later sctp_copy_sock()
> and sctp_sock_migrate() overwrite most fields.
>
> What sctp_do_peeloff() does is more like accept().
>
> Let's use sock_create_lite() and sctp_clone_sock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

