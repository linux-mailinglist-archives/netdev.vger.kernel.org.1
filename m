Return-Path: <netdev+bounces-155860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB7A0411F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9573A1C0C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6751DF749;
	Tue,  7 Jan 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0FA4v0e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110758C1E
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257645; cv=none; b=gS0L3w434xqhjGpNkzke7V20uXWjL40a2NJPkMHZ6X8/C5Y7n/wuvg3NUJHQDOZKz98JvWIt2gRA9sFlQkALKI7sdSUBCWHkWnkQ/bkHfMsKY+5+uqqLi2VksKBq8v0JAos+lCmc/1/aPXyo2wtCH3a7lnP9KvxmVOdWWc1nXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257645; c=relaxed/simple;
	bh=Lhj1wajr7Vj5aagV1WP7iPHVgWxd26ip62mD8wDrVqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z16XPvRCIrKWbY1LPvz47DiWDZiud33eZVz7GCimHsF818SrqSsP0U0vgr5+qNTTbvl4371lwyGPvhlhQSX2/Z+klyyA/RdeQtpA8mxdSs5y9D+H6YR0g/g0s/WbNgxXn/j81VB7nL1+ubkMkAPD/zoJfhIjZ7mWtn/tzA5teE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0FA4v0e; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso30851641a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 05:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736257640; x=1736862440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lhj1wajr7Vj5aagV1WP7iPHVgWxd26ip62mD8wDrVqU=;
        b=D0FA4v0eAHDfZzsY7Hhk/D7dlZ4poV+wiUreIS9Ei8vZkl23mZKGo4a4B4kKfqPEeh
         CjknR8A8UwW4qgpAyhf9Fck39M4RSHgaOKBZo1f9J82FDrxZAKQ7Gc2kjHZzo8X3YiOv
         SlfU4aq7E6wNyONlJEyNYGOC3dAYwfq3FSW/RZzhXNMdVFUAw5e9kjmIE3+XcmphWWs2
         9QraYqXOCl87/ux+IcPIDJ2B8Clpk2LqBysxoBBt2yq+dDFUsjU22utDrD8g/JYGSwRC
         4G32zNA0bqhEVaz/m72GlEs4YN0Q8cNl9CFsu2nT+BmyBdKnFCrHP++cH63XS/wpb92i
         I67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736257640; x=1736862440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lhj1wajr7Vj5aagV1WP7iPHVgWxd26ip62mD8wDrVqU=;
        b=KoGyc7ioZzbQMuSdILupikVL5bMIHbNO1kav17crOmfhO5SIp0o7nL24DmdfdtvOuL
         KqCZLuTJrY4TJbfPjfkp8jDqD1aWmX0ePkE8Jm0Ct3CWuFH1QMsxPe7ggFvmconaPYu5
         LEMI+5RjbGvCeydKEayEpePhfO8oPDrLavQKkWBwh8lWa7Gdt7Bhk9oJugDDzRDaeSY2
         y2/h41RVe8MeQyMD34ZfgRYwaiaax417/a9913Gz7Yh5NmwHceUXQfremaEifQBLGkpg
         MtydSuvjGhoGC7JOBl1xStYwwbetsYUX3ywPHsK02rxVuvxaLWN4i8e2kT472Q992OH9
         NAzQ==
X-Gm-Message-State: AOJu0YxTy3ROypfap7XS837cBbfK2kYMuUoEKsQtS8rtfjqQIhJlI8Hd
	MimU/IkMbMIMKBGk3ACBWlGs+1JY2HACJW+9cwPF11uj1lwPeDYxzhDDn7dJiWXFgAWNUlF7XPM
	+whNIYx9zslqXqvzV0pVGdO8wVxoK2WE5JWI+
X-Gm-Gg: ASbGncsBhXtsvlQdxxGcwtJHsENWZIsqy/JiQy1HLRQd2q5gj6gQGqDOE17VGIKgN6v
	yyslpzTDnN0vCw4DrlWCiJVJFpWx6XhsL5rwZ6w==
X-Google-Smtp-Source: AGHT+IHTBgBpMcbfjH3UpogqEv/xlVGQ7wCOryu8awQkdLbmSRGp6j3hlDt5soV00Z3KOMJ/sBRF1VS9GTK/9NLrG60=
X-Received: by 2002:a05:6402:524b:b0:5d0:bf27:ef8a with SMTP id
 4fb4d7f45d1cf-5d81de48bd1mr53690466a12.26.1736257640278; Tue, 07 Jan 2025
 05:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f459d1fc44f205e13f6d8bdca2c8bfb9902ffac9.1736244569.git.daniel@iogearbox.net>
In-Reply-To: <f459d1fc44f205e13f6d8bdca2c8bfb9902ffac9.1736244569.git.daniel@iogearbox.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Jan 2025 14:47:09 +0100
Message-ID: <CANn89iL-=M2sP4B6Wk5dMqCsE9aoNAfzsMxDbp2N-fxDy6bAcQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Annotate data-race around sk->sk_mark in tcp_v4_send_reset
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 11:14=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> This is a follow-up to 3c5b4d69c358 ("net: annotate data-races around
> sk->sk_mark"). sk->sk_mark can be read and written without holding
> the socket lock. IPv6 equivalent is already covered with READ_ONCE()
> annotation in tcp_v6_send_response().
>
> Fixes: 3c5b4d69c358 ("net: annotate data-races around sk->sk_mark")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Eric Dumazet <edumazet@google.com>

