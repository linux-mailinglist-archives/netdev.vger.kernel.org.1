Return-Path: <netdev+bounces-79806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCF87B93F
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 09:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04F31C2148A
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 08:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE78D5D732;
	Thu, 14 Mar 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqMHn5pN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6C2A1DB
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404854; cv=none; b=EcUx09x+OtyNFZQvc7egpqCjkMUUQS8Xf0NrGdnkAc068pQuLRhp3DBK14vKr59iSMSzoxInYX8AzRe79vSXFYP2doYZICl9lkRfcSiTa6b/NdqTr+J+RQx954VzxHImgvgGC8X5X+Wa4C4iQmJ5BGHWoZsbtagE7w49/q6fpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404854; c=relaxed/simple;
	bh=HWMY2utRF1QxItgWOGzSZbhuDVFD+L+nfm06fC1d714=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5usu+IVeu2WV4hmQzph46GCweWeYr0zKP6AH00ShmkCezUk/EpLlfK7Lx9OvdJmvr6B3T7Zs2jQP7/+GAAevkfiWT0uH5i+RNh/VTN5EB+i+WNrchSCA/QAnVFA/vy2zisPZ9EB6dIy5PXNucGjChtTBdhbOj+k5HT11aAF5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqMHn5pN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso5556a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710404851; x=1711009651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWMY2utRF1QxItgWOGzSZbhuDVFD+L+nfm06fC1d714=;
        b=iqMHn5pN0esRqf3ZmDVWzXSuwS+vKRMAUFzcifGN9tm7zw8394p34Ka1qYwAz1Fy8z
         snaqvfgHKP7wyWxqHDVmyPgWYYGFwAOgL9mUrI5O1mQCoTl4d33G1N3socMdmqxsMLbQ
         8TZt9d7sQJFFxqOZoFfnsdj+tmu9My8by7+s6+1dbJZp0fIOodVlu01id8MGTKCmJEdK
         c1p3fo2P5oilal1PmLGyDSrwsTwGycrDolwPZMiX1v63BtNWxbWpr+mF0gtqP6W/IzXy
         EgKfQ8nQ39ZAfemGalYXNHEg4e3Wn6XNqH9rJktrLkky0rEOR16OA7lYEODa1OODrBrM
         qPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710404851; x=1711009651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWMY2utRF1QxItgWOGzSZbhuDVFD+L+nfm06fC1d714=;
        b=LAhX//5VLwowHVEnvmDwoyYcbnMMIAHQiGBwQpUWQVU+9Nso4TjAVjHCYxLDZYUpZ1
         no3k1Q09jN/DWWYF2IdvZwiBd+rBxyndlPIqDbbvDeDQ7eTqmy1LZVjiL4wvzU2c8zkI
         2QmKA6a9bluudHnamKPIU46A+S+ttRxgNuHRBISFQbFysWsl2+r9cXIPKnjMkOF869Vi
         +0QfmgROTIYsQsqvB3V/obv0WuDUahcZz9dPDXOTDXPzhGOM+Oha7GxvNf25OmVIzB3X
         ky7CLWBPwgnbSmKypQjvIjMG/X8blj5v+RnOP7sYe+BJ/87IWr6njZ6xErM6W9S6soz7
         I42g==
X-Forwarded-Encrypted: i=1; AJvYcCUYpn1vXAiSskYSYZKvcVVtYv2NkP2lWEOV2NLZCWrkXLY7B1db0/kRrltIgKk9uaznho3t7mDS5ThaheryUz2a8fUHHlLU
X-Gm-Message-State: AOJu0Yy/m3ZcT62rNC1bxA2LrtrZxtoviW5vfWgRdJCj+nZpudI1NnTJ
	MX9zHhPFQp7pB0Bm6Lb+TkkZ3z74MPjTlocrJZYI/RZM8dKL6zHkP+zbxK2rz+TfdkaQc1KDSH4
	SvMrNKxcupgETXlpvQb3CYc8+S+bu/Zd8l4Fk
X-Google-Smtp-Source: AGHT+IGLN6u18H7uWzfIa0E7E9HF2UaLOrF2eZxIeAlQNK7ExX6YsQYqUbK3X4pLLHX/pzxrzOp2sSvtc7NdhEpYbeQ=
X-Received: by 2002:a05:6402:202b:b0:568:5e6c:a3c4 with SMTP id
 ay11-20020a056402202b00b005685e6ca3c4mr123492edb.0.1710404851002; Thu, 14 Mar
 2024 01:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308201623.65448-1-kuniyu@amazon.com>
In-Reply-To: <20240308201623.65448-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Mar 2024 09:27:17 +0100
Message-ID: <CANn89iLQ-g-y2UpSjezUSgsYRiy6Te-xOOZ6pnp8c8xecrUzSg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Fix refcnt handling in __inet_hash_connect().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> syzbot reported a warning in sk_nulls_del_node_init_rcu().
>
> The commit 66b60b0c8c4a ("dccp/tcp: Unhash sk from ehash for tb2 alloc
> failure after check_estalblished().") tried to fix an issue that an
> unconnected socket occupies an ehash entry when bhash2 allocation fails.
>
> In such a case, we need to revert changes done by check_established(),
> which does not hold refcnt when inserting socket into ehash.
>
> So, to revert the change, we need to __sk_nulls_add_node_rcu() instead
> of sk_nulls_add_node_rcu().
>
> Otherwise, sock_put() will cause refcnt underflow and leak the socket.
>
> [0
> Reported-by: syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D12c506c1aae251e70449
> Fixes: 66b60b0c8c4a ("dccp/tcp: Unhash sk from ehash for tb2 alloc failur=
e after check_estalblished().")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

