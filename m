Return-Path: <netdev+bounces-90080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6318ACB0F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4772815C5
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4071474A2;
	Mon, 22 Apr 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZHpOiqK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CDD145B26
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782373; cv=none; b=PqyemktxwaGmZdHoY9xmDdI3uV5QACd5Kro8iDjF7/HqYyU1a0Uqj3UkIPCBGMVlD4nidxArWGht2/12pIYFsyUZGYcFL/w/T08y76QXBPbKTFsbBOUuCVRrUlWBOr2h1jtD9qnWAsFbmxAplk3uootbtbwRTzWeZPOla5OQnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782373; c=relaxed/simple;
	bh=tOWoHHOJ9GweieT+1W3+aKaJIzXisho9bFMCiEs3ky8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPuekU5kvt4ijfU1cwUyOkMnpXHWZPYhW/MPel7CyovYF6pxaQNz+FU9dafewN3LKMg/PWnnum8I+EAP290E6jkPuUTOccnmOMoJK+hHUyzZgN2D4zV2/uNBCNhzVpGUeNZK5FIVdRJC4bCUZ76/AWmYU4zlklYArf+NtDUjJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZHpOiqK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so12916a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 03:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713782370; x=1714387170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOWoHHOJ9GweieT+1W3+aKaJIzXisho9bFMCiEs3ky8=;
        b=eZHpOiqK+23RNB49SP4tcxfCYtw/MCj1qz63DNHMdwotk1jJKHD+s53iEU6A9KVnAT
         4qTaOhxKebWf8ie2JE+EDp7dDwzPRa0rc5rfbiAAVwon2tGeO9W2ABUIaosbj2uoUUbS
         hD3M+qzEbb9lqJb14bENu1/GRGFeyp3isYQeaDnU4v9LWfjGLTuse5NiG5gIp/m2jKlM
         yCukYHwkt5285VjRTRGuC8ZRerKQpD0f+9yNl03Sryy9GVMKUcYBP+rZoziC+1mOHTCc
         T74UIxBU22WTQs9BtIXy8Y0kw/kvEdbXuNxjIKYDeS+sA7c1yapOtnV3Pb3umJzBhPLE
         3aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782370; x=1714387170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOWoHHOJ9GweieT+1W3+aKaJIzXisho9bFMCiEs3ky8=;
        b=Pkc25IqMqkaTHzDGpSNoSXSjI/29l9luZtBK2w4CaRbUJfT6dIIutI74hLvSZbYMUb
         2yM70+EtKTWIRVsPDfWdltTzkMoTyCHsFg8YFcG+kQjkkLagd85duCKfMtHKXarV8vhr
         pHmOOeHcRidsmp9kjTwaJ1k757tczNb6Hv8NNuIA48nkPN3OFt5iGFAUXCe60Nkc8zw9
         M1X61SBWl2L6KzsmuuoaTxs7ZQsB3K0mrHmu92YSNyzYfwZRuom0cQ+efUHCZJBqSobu
         uQgTab7MjP5/QiJ1zrKv0u7YDh/cCsYA/t3lAiP/b24yd/yZRavpzV/i9pL7BX0tyaFf
         Ln2g==
X-Forwarded-Encrypted: i=1; AJvYcCX3kATJke9MrDC4+OwzS4gZpxnOF6HgHBEgmxpQkIfFL5WGI/ug8s5BPA2Vn0g+cGZznExz31JnRD/i3IePQKMOoYUOwkS3
X-Gm-Message-State: AOJu0Yy+a6fh+MgoxUKbK+Pw8MRiGzBVtWuQZ34qutrilWE6UtRjiciS
	vCpy9VDVfI09VvtXh2ru4EFTGH8EoPzTIxipo+TcFG8ZTU7fzHgNiMj4bC1rFAaN6K40Gu+eZsj
	nZmwW5mXXvcPF8ehir6NDTLOsfImBR/j+l6KltM1YWBVHBMMAtg==
X-Google-Smtp-Source: AGHT+IGFh5zc5/B8LX/nsbIcqrzHXykEGcKBYEjt8nbC3oeKsXNkx+kPBmIoH9FAVTCMXeP11R8ao8nFKfIv+SjNbeE=
X-Received: by 2002:a05:6402:4315:b0:571:b2c2:5c3e with SMTP id
 m21-20020a056402431500b00571b2c25c3emr238159edc.1.1713782369841; Mon, 22 Apr
 2024 03:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZiYu9NJ/ClR8uSkH@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <ZiYu9NJ/ClR8uSkH@v4bel-B760M-AORUS-ELITE-AX>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Apr 2024 12:39:16 +0200
Message-ID: <CANn89iKpN_dnFsfxbhZsz_jcJ7OmP=5+AhmgkicCKC066qGxDQ@mail.gmail.com>
Subject: Re: [PATCH] tcp: Fix Use-After-Free in tcp_ao_connect_init
To: Hyunwoo Kim <v4bel@theori.io>
Cc: 0x7f454c46@gmail.com, imv4bel@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:33=E2=80=AFAM Hyunwoo Kim <v4bel@theori.io> wrot=
e:
>
> Since call_rcu, which is called in the hlist_for_each_entry_rcu traversal
> of tcp_ao_connect_init, is not part of the RCU read critical section, it
> is possible that the RCU grace period will pass during the traversal and
> the key will be free.
>
> To prevent this, it should be changed to hlist_for_each_entry_safe.
>
> Fixes: 7c2ffaf21bd6 ("net/tcp: Calculate TCP-AO traffic keys")
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

