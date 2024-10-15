Return-Path: <netdev+bounces-135455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B82B99DFD1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327811F21F63
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29E41AB526;
	Tue, 15 Oct 2024 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHAiNfLH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE6189BA7
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978935; cv=none; b=DM5DXjhy6Y78JeolDr89G2k6THlXc9ljt3LD1f9vYF8ACRImxzO5HAVdCcLcwUAjuE0CIlJgGi3s5GfRuTlqSNo4joteE0kWPPm0dK7hfRLzP82FbrI48PTGVk/1/8nLjJYoyjKE1LqqlrzYolKpyhan+VsjrN0sPa7mYaF8tOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978935; c=relaxed/simple;
	bh=Rt2yDA3MJapKCnOGDzMIySE/rFBhoRtDc2b3TUcEBKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNgUyTOwjJ39N9clwDwrkx9SEiHLZDT4DKD9NP6Iw+Ogv5Ns6gjfuNmB0d711YIQq4cH654L0faAinQwUBs3T8X3V0Gt6A9JwBCJFj0JuCxJalJnJQJ2ot6pAYjqMuw3NTzQkYIMGh9feTVOYBnBYzpLG9xrxKiGdXesinNHmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHAiNfLH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c94861ee25so3101406a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728978932; x=1729583732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt5G6pI0V+Z/nds+HrT5HM2Cqui9jsInOvdseCn6N44=;
        b=iHAiNfLHI/W5mdNEWa7XTyqiw4A6gVldlAdgrkK/qrrR0ht/FPG3fh0rUGiF2IEM8V
         uZat7K5Bj6Us/Prh0lW6f+x2/Jmi8iE+EGL8TSWTkQXx8ai6NbGxKvMrPEDboDRWODif
         rZRfHYWOPlQ/wIo9yMsLYursT/eX8NMN5Flcym4IDMkIrI5mfxJLseOk3fLM7yckLweE
         5VSG9X5EOmPcg1dj8jATYLRDlGtZ/oNG96AAwoXFKANcbVg7fqSYljJUuYx/Fuaex9Nt
         WPV/aehnSxor3UrBUpzHt+Oyon+hFj/cbHB9vCn7eaXZVsBeeXcLbl19zUw/qCaKPQd2
         hkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978932; x=1729583732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rt5G6pI0V+Z/nds+HrT5HM2Cqui9jsInOvdseCn6N44=;
        b=BJyroX37lwI2BAt79QoEHjgRcYtUNF8xntB/lqUAmm9ujtxT+rN/rJGG+YGG3j+CLH
         iraHpDL41G8NfsbvSsh73IH7Ku7/y4fEOsao9WWA1ShUhSqKgzOZ7xiiTq32hjTaqAVy
         o3ZNm6JDP9SUbcKl9VLys6/ISS0ac26HLlkW3wspLlpLWWESEfdgyOI6AGbz86CUVcfi
         MG6gBD4TE7lD1q0slrGZCR0fVmkRKJ3ZtQuSp7a4C0+SRcQ/HbPL9oo2i4WX9eLXAkMB
         GZODtYCXpjQ3Gazj/rH30VEmr/ZKJqtIPHVCS6Tb5wyOUsyKLcrOBNnKFL8PsxwzLWNY
         pRGw==
X-Forwarded-Encrypted: i=1; AJvYcCXgPeybXnQIOB2GQaxGU2YyKt5jjYPVh8UlXKb/16DhsG7kZCVjakooEQnW/rt5dApwLHjU0sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPzuzitnvzefh8H0p65IvLxoNUiL1rgPE7atiOQEaoZgmksC5g
	cHsnMihzZc62oTLLs9O8aZKQrf65lTG06dvP29pGX5UVW56Ogy9oyjXKhzy557aGvKDNJPnk3kw
	l1DOL19H5i5dQov8TtUSyQ9V+zWrJiL5YUtv8
X-Google-Smtp-Source: AGHT+IEvfIyst6NaqX4hgxYkfJNYYQL4+bdLbi7b9MR6pZ4+OIs+H+4JSdBo+dZqUEzAoiOsrX/N1W3Jy/+9D+WbtGY=
X-Received: by 2002:a05:6402:354b:b0:5c9:48df:713c with SMTP id
 4fb4d7f45d1cf-5c95ac0992emr16933126a12.2.1728978931913; Tue, 15 Oct 2024
 00:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014223312.4254-1-kuniyu@amazon.com>
In-Reply-To: <20241014223312.4254-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 09:55:20 +0200
Message-ID: <CANn89i+uoYGpV69RQPNb1gPpeDZf_qv1+M5KcThACQf4rrJfYg@mail.gmail.com>
Subject: Re: [PATCH v3 net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:33=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
>
>   """
>   We are seeing a use-after-free from a bpf prog attached to
>   trace_tcp_retransmit_synack. The program passes the req->sk to the
>   bpf_sk_storage_get_tracing kernel helper which does check for null
>   before using it.
>   """
>
> The commit 83fccfc3940c ("inet: fix potential deadlock in
> reqsk_queue_unlink()") added timer_pending() in reqsk_queue_unlink() not
> to call del_timer_sync() from reqsk_timer_handler(), but it introduced a
> small race window.
>
> Before the timer is called, expire_timers() calls detach_timer(timer, tru=
e)
> to clear timer->entry.pprev and marks it as not pending.
>
> If reqsk_queue_unlink() checks timer_pending() just after expire_timers()
> calls detach_timer(), TCP will miss del_timer_sync(); the reqsk timer wil=
l
> continue running and send multiple SYN+ACKs until it expires.
>
> The reported UAF could happen if req->sk is close()d earlier than the tim=
er
> expiration, which is 63s by default.
>
>
> Fixes: 83fccfc3940c ("inet: fix potential deadlock in reqsk_queue_unlink(=
)")
> Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
> Closes: https://lore.kernel.org/netdev/eb6684d0-ffd9-4bdc-9196-33f690c258=
24@linux.dev/
> Link: https://lore.kernel.org/netdev/b55e2ca0-42f2-4b7c-b445-6ffd87ca74a0=
@linux.dev/ [1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

