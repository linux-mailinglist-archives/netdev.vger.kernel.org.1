Return-Path: <netdev+bounces-266534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG5nB/gosWkBrgIAu9opvQ
	(envelope-from <netdev+bounces-266534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:34:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343B25F66C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D11E30A3549
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A037C2010EE;
	Wed, 11 Mar 2026 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pexCnYug"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4222126C
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217502; cv=pass; b=bmMkxb47ZYYCk/FZczSNx/tUgqRQfEMgjv2UTHqXc4v41vZwId2co+GII+CUajpYNOiLNwBxzyWjF5nzVLwfk0p85XhqaNRuqp+U+6jNqQ+BXThFF/D/GwqtOZelLUsc9cVeN8Uu2GRuPk78TE4JQCtPFwG/JtTwUWhgL9/M+NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217502; c=relaxed/simple;
	bh=bh6U49eCiCBbIvwEknUz7QsV9A4ESrZsJ/9XWVh19mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNEumYcwlzL4VPBuQROmkPRQWY1dg9QrSdW5S+gyL4nb/TGeHFHAxoTsWz3gw5zsZbVL27K0ADUTVn/9JQJdDyxFP3GUSNHCAP1AZ6cz+wVUYaSZV5tt9SI1j16+n+J1m+jm2LOgJHZlVTiHp8oZ8rEOKG7XJRZJNb3u+G/9U2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pexCnYug; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5091d71aa11so8559621cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 01:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773217499; cv=none;
        d=google.com; s=arc-20240605;
        b=k1GutKHqCpUvVKcPdnl0z2MQmjtPp085WIydD7bI9bBS7VKKQ/yUgSHHBcIUhzT6Nb
         eYhGt8xwRWeJxptSu0+AfyJTndNsAyq6v9SguJlkk1lYH5U6QwTR9IzebwCuYr1SxI31
         xkUOhG0XYrX9gJYUgZaGc22x6OPg7u2mXewVyq+1BWHdBBCSkkObYpr2KbD4TIie93pJ
         3LjKBWvKBdUVll+ihBDKAVQbDMqW8OyjLpQKNGgqX5Rlx+vx3KjIrDLkLT5ErnrlF0aX
         mk7biGFUemScyaMmqYk2FhxFPv095++tSGJ2fDqu+WU7CSNsnCuu5snt7q7gFGvxDTOP
         ngoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bh6U49eCiCBbIvwEknUz7QsV9A4ESrZsJ/9XWVh19mc=;
        fh=RyFZCfKDFsLtmoI4wM6B7Purrtu3SlrqUF+t1/8sJ7c=;
        b=GhtC77K90omSRh94H223ZMRtxRTueExUqVDJrSHf/4lHgrWzNkTHcNjdddaKekaZ1K
         5PT5go8B27tfrxDSGDbRj1vzSt90bBfX2ePoH4XgvkaeRqQIJmfsOQG/20d7vqJQQSvP
         dAdKT7gh08FHeRHTqqSFQJKEYYNb+5xDUgNDno+3ha+qfPuYwQdiRM7Hzpmygx7Wso/E
         36FpCemvCUAzXStVkSj1BblTBeAnjpJKDwTUi6LA7eYbNYyyzFcoxzIeftnjTbSSUDvI
         a6hnM3jjClxj4cn5EPw2+F7qLxzeYZ9owKp5G37HIBAxzcLVkihnrpD+AVVmMHB/Ru7o
         HQFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773217499; x=1773822299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh6U49eCiCBbIvwEknUz7QsV9A4ESrZsJ/9XWVh19mc=;
        b=pexCnYugPMRnQt3MsAuJ5g+koHlN/GxcIaJ4EZs20CzSu2b5bAoN8F8/Rfd6Pd7YYc
         7NSkaaVRkIX/qvWhHQm60t7YTedMIhyeJtuUVJDiDb1MWcVLs0Gx8Z37u0gyAjloGs3j
         iAxrG7dSdWu+S1sHEu0k277zq9zDOTqD0FFMc2dipY4lGDUqV/zi2qO2h5uTVI2V1wRX
         Os0uSb+gKk2ATyWEiIYiVpoIe4luZ0qFgm/lewfgWG1MFrM6XGwwYegNEybZa0zaGNpP
         bkf3hjoxD956x6GMKks3P53X0cmSkwmivsjLJ4bxbqNcCHqE67KT9An0YHNH4Ajx70c5
         0SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773217499; x=1773822299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bh6U49eCiCBbIvwEknUz7QsV9A4ESrZsJ/9XWVh19mc=;
        b=t+3LI2vpL98CDUA73PPgfnKnHMMI8iVpLkph0j4mlFM38bd9noSHIiZ88Lf57RaOAs
         uqAr9P/xKa2YNtHD2ckwtGs6N0dk+1PAhJRu7P48sh5R7SDq+NQfAFcaZjtii0XZZNfh
         Q9FYNE+ekA0PgngxohtrbhhPjSt/T/KUHMjCZaWs/8lAKymSBUBQaovmHZTzisTe+hcn
         KrLtsmqxr1RQghYBVdStrS8gpKDiStMQXLoIdy46fMMbKf8Dy00MuWd5KCabYho7T9VG
         YTigoTgqY2blOuNSOQ+lE2XOzgxDwy/8/FrmV+Ryfl+0r5ygPHcW7uP5mJvvwEU1X9oP
         GqVA==
X-Gm-Message-State: AOJu0YzSwS0pb9JZpb5Xe0vR9i5lSo39bxL7ZpV5DW7OgXSV7UY2q6cj
	+eoPcS/BX3QsNHy6u1xvCafh8HelwcR358T6UkN5Wx3eKZJ5zLkzMYtLDFDtU5Fofm72UgFwTc+
	UX8m1gxMZH/YlSwx4iqCujNkRXX2KuZW3k2uql6B7
X-Gm-Gg: ATEYQzyKvPjsnOr1u4SDiMAmkcILK5OSDx0yFi6ZGvaFjGV6FmMJ9n0KxY8cfsigSCD
	jB4Z7FilEQXFA/A012V8VxadYfwyy1roLM8oih7nk6s4NPTqrXIjzqiiuIgxnC5CRfCT60n0jrb
	mn+tRvqXf7+MDHweQph/0XMZXn1KyfoTRzu3I3dF9WEvb8Y7Z2zl8bdjbTt+CrBPY75fPdjlrou
	uV83garC+HJsObPdYXzDpnbIIjmT8CORkevrfrGBZ2LaFe7Wlp3AVxoT97XYEvoVq+AnVBlnLvA
	SgKvtwsx
X-Received: by 2002:a05:622a:54:b0:509:f1e:41fb with SMTP id
 d75a77b69052e-50925fcd943mr73573621cf.6.1773217498516; Wed, 11 Mar 2026
 01:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311070611.76913-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260311070611.76913-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Mar 2026 09:24:47 +0100
X-Gm-Features: AaiRm52SdgCeU51Y-1e-Sk6l4P3zSL-DgLPLdP1cnJA8BQG1vPHxIiVp-Wp5uO4
Message-ID: <CANn89i+MTAhm+T3dR9T45wOBU3xjiyKfsKXHen3bBLu2T8JD9Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net/rose: fix NULL pointer dereference in
 rose_transmit_link on reconnect
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	Takamitsu Iwai <takamitz@amazon.co.jp>, Thomas Gleixner <tglx@kernel.org>, Pwnverse <stanksal@purdue.edu>, 
	Ingo Molnar <mingo@kernel.org>, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8343B25F66C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266534-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d00f90e0af54102fb271];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,syzkaller.appspot.com:url,mail.gmail.com:mid,appspotmail.com:email,shopee.com:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 8:06=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> syzkaller reported a bug [1], and the reproducer is available at [2].
>
> ROSE sockets use four sk->sk_state values: TCP_CLOSE, TCP_LISTEN,
> TCP_SYN_SENT, and TCP_ESTABLISHED. rose_connect() already rejects
> calls for TCP_ESTABLISHED (-EISCONN) and TCP_CLOSE with SS_CONNECTING
> (-ECONNREFUSED), but lacks a check for TCP_SYN_SENT.
>
> When rose_connect() is called a second time while the first connection
> attempt is still in progress (TCP_SYN_SENT), it overwrites
> rose->neighbour via rose_get_neigh(). If that returns NULL, the socket
> is left with rose->state =3D=3D ROSE_STATE_1 but rose->neighbour =3D=3D N=
ULL.
> When the socket is subsequently closed, rose_release() sees
> ROSE_STATE_1 and calls rose_write_internal() ->
> rose_transmit_link(skb, NULL), causing a NULL pointer dereference.
>
> Per connect(2), a second connect() while a connection is already in
> progress should return -EALREADY. Add this missing check for
> TCP_SYN_SENT to complete the state validation in rose_connect().
>
> [1] https://syzkaller.appspot.com/bug?extid=3Dd00f90e0af54102fb271
> [2] https://gist.github.com/mrpre/9e6779e0d13e2c66779b1653fef80516
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69694d6f.050a0220.58bed.0027.GAE@goog=
le.com/T/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

