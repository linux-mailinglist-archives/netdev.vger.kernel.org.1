Return-Path: <netdev+bounces-71632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0930854496
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 10:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBAC28D2A3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D171679F4;
	Wed, 14 Feb 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3j/X7ZKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA579C1
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901550; cv=none; b=Lip0TxVpaKBvPmcn5QJiZmAsY0lc4PDPXr0pcjHb3OaJAx6SEYP7611ufhQFNYbXQqzZcs3BxIL+RJ4YvrcxfU1WA2dC8uSCFTn2+gE80Lm350Z9RNMP36j1FBupOQ3yFYadsvHVoQiUo1P/hwPh2YtdaHmN+MQRM/VbwBknKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901550; c=relaxed/simple;
	bh=V8+hzT9g/ZZGyQJPNYr3WqVQ4Enuw+TbC/Mr58IKYYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUbFkHGFc9nSrSHpTQZ3jSNzZGS7+clV7h9jSwQhVYAXcTwCURgMliEZwMI864jgzZ+QvU0AMsghl7WrylFtVVAkPDArnvBycIxicFc1LZI40n+YhfdTJ5agE97YLscwISHHhiPLcyXkYtrTZPPfGbqSiHLRAc2V5ZCdfhZkfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3j/X7ZKE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso22467a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 01:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707901547; x=1708506347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOiJmkmBjV5saUy+4hIsvcPRiSnc062KmKvQNmzhkYE=;
        b=3j/X7ZKEtuEViGDhFA2SBd5Mw5snO4TlBfXRjnb7PyaScaH8xdst4iD3HncrB09YH+
         VbULaXRSxZVlXqNCpFYsRFQj7zuusERK3F34SmvYP7B0io9oUisjeCp52j9BYujatxTb
         sNW8w/LO6a8Be0eHV3Sh19Tdmho8EcC4sMAdT0OjEcbpBG+bXEkygjd8Ni9siWkEl1yZ
         iOGLioor6x8uaabEulwRB3Vo52+88NxKQLng5DrNpx7M/UaBaEc8cAubC5wfoBPxdUZM
         V4Oy/wO2HBLaUl4IXZLlBtXUIs6Mg7VjirFTpkec6fYC9N0Lfaci6Y856MsR4HYot+v0
         5Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707901547; x=1708506347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOiJmkmBjV5saUy+4hIsvcPRiSnc062KmKvQNmzhkYE=;
        b=uSXe6GgitP4Eu34w5EEoabZwFuiIziXFuPZ7Q0YNjhcf1spCILP/IWvCY5rewqJA4P
         qiqJTRtWjw1aBKTss59c4U27wshLhIZeV/HzxzFYyuihUkydx8r4bmeANhczNvvP1K07
         PcVTOAKQWZitn+a+tVy1iQKlI+9/6naLzFDuG1w648KQA06epGoVfzAjqLhwgs4SYHBg
         IrSdFwhLQoAZfm0nOoP2HqiMM5U46uMjHjJy3Ts3Bai8EUwm+RfyzTzwipzD/DJfRHvd
         HkROSBPLPLUVuWF2WShFUj2iNV0swzbDMB2FD2vVAClCDJRUhORsedKF4rxBZLZLEKNO
         Z3JA==
X-Forwarded-Encrypted: i=1; AJvYcCX3n4m//0926HocvRBiUIXyzp+kff/9uk1KwlAoML/ZkVTePh6ofIduNbkL+3Sxf8of3J09zIxVXw2Eq0fH6tUGLCXZ6tOm
X-Gm-Message-State: AOJu0Yx0h2ePROMo6qx8+ltpKIOWqdWvS9U+ZFOvkC67OUnDBcFvT8ga
	ndD49NivStY59hxkLRzC8xP3dW+f6OGKCUlDIAwVa5j88yJ8gMxiqI0luezhDr7oqjt1bMBfuIi
	BvqWBHrDQcNFOvoyI9WXGGDrbYbzLoO3mQGIY
X-Google-Smtp-Source: AGHT+IHEoIgTWg12h3aga/E68VWidz2sD+uNSQKdBAOqhuoUu26CuqJrhdPPI3HQJAhSAeaPOcCZ6ABFU8QA5OtMsE8=
X-Received: by 2002:a05:6402:128c:b0:562:a438:47ff with SMTP id
 w12-20020a056402128c00b00562a43847ffmr92683edv.6.1707901547046; Wed, 14 Feb
 2024 01:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213214218.81786-1-kuniyu@amazon.com>
In-Reply-To: <20240213214218.81786-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Feb 2024 10:05:33 +0100
Message-ID: <CANn89iJ29sLgpz1sEMJ9K=PtJy7RY4HOyg2+ykuCJ2ico_629g@mail.gmail.com>
Subject: Re: [PATCH v2 net] dccp/tcp: Unhash sk from ehash for tb2 alloc
 failure after check_estalblished().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:42=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> syzkaller reported a warning [0] in inet_csk_destroy_sock() with no
> repro.
>
>   WARN_ON(inet_sk(sk)->inet_num && !inet_csk(sk)->icsk_bind_hash);
>
> However, the syzkaller's log hinted that connect() failed just before
> the warning due to FAULT_INJECTION.  [1]
>
> When connect() is called for an unbound socket, we search for an
> available ephemeral port.  If a bhash bucket exists for the port, we
> call __inet_check_established() or __inet6_check_established() to check
> if the bucket is reusable.
>
> If reusable, we add the socket into ehash and set inet_sk(sk)->inet_num.
>
> Later, we look up the corresponding bhash2 bucket and try to allocate
> it if it does not exist.
>
> Although it rarely occurs in real use, if the allocation fails, we must
> revert the changes by check_established().  Otherwise, an unconnected
> socket could illegally occupy an ehash entry.
>
> Note that we do not put tw back into ehash because sk might have
> already responded to a packet for tw and it would be better to free
> tw earlier under such memory presure.
>
> [0]:
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address"=
)
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v2:
>   * Unhash twsk from bhash/bhash2
>
> v1: https://lore.kernel.org/netdev/20240209025409.27235-1-kuniyu@amazon.c=
om/
> ---
>  net/ipv4/inet_hashtables.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 93e9193df544..b22c71f93297 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1130,10 +1130,31 @@ int __inet_hash_connect(struct inet_timewait_deat=
h_row *death_row,
>         return 0;
>
>  error:
> +       if (sk_hashed(sk)) {
> +               spinlock_t *lock =3D inet_ehash_lockp(hinfo, sk->sk_hash)=
;
> +
> +               sock_prot_inuse_add(net, sk->sk_prot, -1);
> +
> +               spin_lock(lock);
> +               sk_nulls_del_node_init_rcu(sk);
> +               spin_unlock(lock);
> +
> +               sk->sk_hash =3D 0;
> +               inet_sk(sk)->inet_sport =3D 0;
> +               inet_sk(sk)->inet_num =3D 0;
> +
> +               if (tw)
> +                       inet_twsk_bind_unhash(tw, hinfo);
> +       }
> +
>         spin_unlock(&head2->lock);
>         if (tb_created)
>                 inet_bind_bucket_destroy(hinfo->bind_bucket_cachep, tb);
>         spin_unlock_bh(&head->lock);
> +
> +       if (tw)
> +               inet_twsk_deschedule_put(tw);

Please make sure to call this while BH is still disabled.


    spin_unlock(&head->lock);
    if (tw)
        inet_twsk_deschedule_put(tw);
   local_bh_enable();

Thanks.

> +
>         return -ENOMEM;
>  }
>
> --
> 2.30.2
>

