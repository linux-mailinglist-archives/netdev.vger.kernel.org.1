Return-Path: <netdev+bounces-236848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD0C40ABC
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B8724F1E3B
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807D2328B65;
	Fri,  7 Nov 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTVAOP0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FAD32C954
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530611; cv=none; b=HzNsNyfvVi96Ni94YrocLRk7mCtHXox3Rzy83qL6A7x4tGutr23wZIbRs+TVs3x5jNeVkNedPMrywmT24SklMeXg+8m2LGIsiDKJFZNB0A44VA5Exd//6tcoVaQL2y8lSvtjUgU/ma8NJZxHXg1weJ+oaM+iuPYzWOMazS8vqR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530611; c=relaxed/simple;
	bh=rMuibsfjwQTkZxmIQzy8sIFXgg7FCnLwNlI1IDc3+0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkFEDUA4IJ3288ZUhnanOhYjXE/9ACxPCVA7T5H12cJks+wsknw1pv4bcRM/piCpWTwqFO/od8S/j/kkZWcDuYIZJYWpsA+C1nLjDOAVaZqXUQXL2Y94k69gMDkLaXEjerr/uF5GdTgt8mIuEKhAA2JcUHG0kfyPKM2MBOj6JI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTVAOP0I; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-92aee734585so32617639f.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762530609; x=1763135409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMuibsfjwQTkZxmIQzy8sIFXgg7FCnLwNlI1IDc3+0M=;
        b=aTVAOP0IZu1g/NzeINRMge3lhBW2BaKDuE8TFTFrnZlEZFSnFUy5R4O2kKcpU8RlDc
         ObjgIggp2fbe/zyUvKdiQuDonUsSyQ0n/9xSUC/zGrc3XU9CYLgnvxKNyjwTCwvAqYlR
         V1PX5Hc0j61qKTyU8Y4ok8hyI95zvAvgoPuBKxH8V3XMvTgBKqRy47CaUSB9Xuj88+K7
         e1jnnRsTLUx5xQO2LkShqrSMHcAbxAMqmq4DE+iBENCn5H2LC+Euu6EAFzUCOoNpijjn
         bMX5F7RI6KBDcyrOOpwL0NpfJhicC6hjXLj1dwvC/m0gBlzqjfoc/F+vJwV8aRaa1uW3
         OAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530609; x=1763135409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rMuibsfjwQTkZxmIQzy8sIFXgg7FCnLwNlI1IDc3+0M=;
        b=FBdwWFjbsJS7nZstzN/izMYmihz2GcMtO3zcLoGsHssVNM41NkiJJub5o74a8fj6oF
         iCH8QTY6CcrennqAWt/kk0s3jwXrRA6Sjc733MTyKa7jEU75J/c4m4SfRyvZgb8KGj9M
         LyXdIMErCrin3buBWNt4FQmyc9MmmjaKjqKwJLAVaJ9CLSDUjjFt/YBuONruAK+nkOCL
         KD1O0xkyVHE7fIFcUlVULoUJ2qyODc3C5B4qpkGmbRNvqcwyivXeLLy7FpfaWflwa3GR
         2jMqrraVFJiWzQhSxiQh4wG/5zfirClW0tpgN2FxQYZQed9FBhvfuDkSCgY/ARgFlUCR
         gzpA==
X-Forwarded-Encrypted: i=1; AJvYcCWf4h+iMREI5qr24goI1xb5rPEMinsWBbOinqLfpxlgWsrRozXKJrL1KCjIt4brX4D9CFRZVJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPF/Ral/Q+PPPZ4+PWoqtjM36ueFLiEUE+Afzk00M+hQOTDX6J
	8PZ5UNQDKkocqtAm0fIAEUFtQcP41tHC078OsOF+8UZjWe+0bYvVtYhDQwL3eydjVZfyTPmpVjZ
	3qARJwF+V25Ml5ALESLNl0z+stF6mtwjftO23qY4=
X-Gm-Gg: ASbGnctX2YHvwP2YyxuUIbsP8BR8r1jOcOUbc+YPLVs42q+4ZnM3NIyWHFQ7CXdGwSD
	gjd1qqoE3zwc81tQz9EMUqj5lYH3wA0lVykpw+Z4AnhydLVzf8SWOaJ9lVmvFnJXnyVzePcTOeA
	RFlqbdg91duMOaI4jQaRznq8ct/tu2Ry7EcCoi+WXkB3MKfhNklWdKUqXDKgIVxw/WE5LnbQapB
	CIJN2SdClYMBvIkv5M/WXTXKfkVA0JPe5T7Z05S84aGoc5cjlulYMxRaZdfSblUiU/SDY3exlA=
X-Google-Smtp-Source: AGHT+IEI4mqtLjtT50kKot5I71++nWm81AjX7kDf3Fm5ROHG41tPu9V9bm9okZPGUMFrI0Z7WTqTyW2s4aMttUt4JA0=
X-Received: by 2002:a05:6e02:1707:b0:433:2df8:5dcb with SMTP id
 e9e14a558f8ab-4335f4932demr54075995ab.17.1762530609089; Fri, 07 Nov 2025
 07:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-4-edumazet@google.com>
 <CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com> <CANn89i+fN=Qda_J52dEZGtXbD-hwtVdTQmQGhNW_m_Ys-JFJSA@mail.gmail.com>
In-Reply-To: <CANn89i+fN=Qda_J52dEZGtXbD-hwtVdTQmQGhNW_m_Ys-JFJSA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Nov 2025 23:49:32 +0800
X-Gm-Features: AWmQ_bnvMgViNRJ7TWP9jVwXCjQ0GWxGO8aB7bLlYy3A5X8vtUkyYQZ396Ih1ZQ
Message-ID: <CAL+tcoBGSvdoHUO6JD2ggxx3zUY=Mgms+wKSp3GkLN-pLO3=RA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 11:47=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > skb_defer_max value is very conservative, and can be increased
> > > to avoid too many calls to kick_defer_list_purge().
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > I was thinking if we ought to enlarge NAPI_SKB_CACHE_SIZE() to 128 as
> > well since the freeing skb happens in the softirq context, which I
> > came up with when I was doing the optimization for af_xdp. That is
> > also used to defer freeing skb to obtain some improvement in
> > performance. I'd like to know your opinion on this, thanks in advance!
>
> Makes sense. I even had a patch like this in my queue ;)

Great to hear that. Look forward to seeing it soon :)

Thanks,
Jason

