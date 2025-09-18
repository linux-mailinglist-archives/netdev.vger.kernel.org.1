Return-Path: <netdev+bounces-224245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD32B82E01
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 06:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5394A13E3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925821FF7BC;
	Thu, 18 Sep 2025 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsuCH26S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D665227
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169143; cv=none; b=ckl+uMuwRHCrqLTb/tGDpA4MaFitdARmlt/Npc5NLeur213KXnjbwWR4kUQ5GwmpHCw5+yWUaZUMUxXdS1gsNnWsHYSLw+XxcK4oPkETBtia0MekT35Pw/T2Ddp2yjek9fOMSOeTA79xBzAkbVyMDlu3De+zN5wSddgfUoYGT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169143; c=relaxed/simple;
	bh=/lCX0bBUBmwAw51lFxKXeVuTptCAA2xbbsVBlXQasWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbRKltTerOA7QmMNZsSJ5uVagsRE+E5dO3o29IAODxoTUXNpt6E9YFo6OIOaPHxmYp1JIRsSG6sdSn3XoMLFfH+rjAIRlq+Dib9M8JT1IHVdAxEmsYBXJB5Yi+35TDNkYTxcJ/Me7Z9Use6njS0+7I7pylH0hKTRj8OztNCKeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsuCH26S; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7f04816589bso54300485a.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 21:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758169141; x=1758773941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vPYYwcGu65PVmEIWTp5X9YAbvNKRA6qzAo5z5TS3Qc=;
        b=vsuCH26SY6rZWaxesztUbkyRvW+AKe3jhIRz4twcpiNcPaBpaT64PvfMc3+nS9m+Qq
         aWphwT22yqOM/Yq1K6Y2RvsmC0YziC1GkBVToAGdw47x3jg8bjch9dkypnnJqsq/kFDO
         glirokkHYi6Uth3SSJPAP88GfsRoA168O6R9u7dCLgiN2aseVMq2YWtYOMIEZL/Ze7D0
         KeIG58r0cBDeuHf6S2svd0IAU6HGQNaaAvrH5byWhp9+RmDy70aZaAfFrHY7ViKf2J8O
         qx2DixsqueJ48I6PqnKpX3oCZoMlhZIK/4JRaf9UDgjdszU9Er0pRfHdbAdoufNyc6ff
         0Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758169141; x=1758773941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vPYYwcGu65PVmEIWTp5X9YAbvNKRA6qzAo5z5TS3Qc=;
        b=FlFjTOu7qMXJxg2ZAzJpijfrB55H9JYgBnjehB9qa2AVROeT0tMNjHh5K4ACKrH8P4
         HBR1pYquuilfT61z911xxJHxpiNmI+2qam18t/paFEFhq6IUCqKzSoPCLXuQSh0NG/zj
         angzeaH3EUrH933NGKKFt9k9OeHphP3SD8N+7jWtaSoqTJF0k8zuyJjo4zAMB3HaSsfI
         U7Rs/2+32Dmr1VbIRjmeJageKd/JOq+Jqczm3W/ehoX4Mymc7uFU/5vQAJWrCfUhiLtj
         1ekWFlTsGHRNmqFR7PEijO3BcezAnIivN9NG0Un0FwQNkAy2JqLeN+cpEUQhZ6+urwTA
         n5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX6OOplVpX8PdYtPu1HLb8Wq8jN6Nmfef1MTRpymiLXGABa0sf1b0gXpC4otRctRBZopZ4aq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJW2aww16Inioahuc8CPFbeemjbKQuttgLXIMnFzTftmKu2jqe
	N+8//l1mqt5dYvO+qMPQwMo1ccz1sPYU5S3o5uuSHlZ6A6MKHrNVAIrFu3JCWDZeRsUcMONlXo6
	JKpesJ5b0aVcYVKViYj1lqZJJ9BautZpnMHfTmq9K
X-Gm-Gg: ASbGncsiVCh1qgETh3pSU66U+GgN0cSyy1jw0WZ3sUXGL9vg02/W6vgpha/43FpaG99
	hYdR871pVAeXREjMy9HtvVJ/TcEFf4bc1yNF/JKdIMmXfApHgZcC/DP9AHxzRgZ6l/p4uhJPonZ
	Af28HCOoAqUQEsf743IlxBz//d0FLwzTbCuPCSEqwG5CLv+saPXjdnVMR6R2M29U+LugUdrSO6h
	FxStMIfB6e4O7+eG1XyheSAGiuufWAF
X-Google-Smtp-Source: AGHT+IGxhja2qucPtVQ2eWTV8w04RGBojg03X/+zcqUIX2YEfDvWGuA/WxLuctHiQc5GT7HurG+I7iIeu/6qK/YTXiE=
X-Received: by 2002:a05:620a:4410:b0:809:8ef7:8546 with SMTP id
 af79cd13be357-83116915c98mr529291685a.75.1758169140357; Wed, 17 Sep 2025
 21:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-9-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-9-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 21:18:49 -0700
X-Gm-Features: AS18NWAgq-CFsPfE3ezUelQw0Sr90MBY8ENxXaQs5DvQ-cAsOWNuaVMEYSZoFFM
Message-ID: <CANn89i+GxfOvKg2TVGGsnibK0SGT_sdcbMB0K-hje=yQac3fhA@mail.gmail.com>
Subject: Re: [PATCH net-next v13 08/19] net: psp: add socket security
 association code
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:10=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Add the ability to install PSP Rx and Tx crypto keys on TCP
> connections. Netlink ops are provided for both operations.
> Rx side combines allocating a new Rx key and installing it
> on the socket. Theoretically these are separate actions,
> but in practice they will always be used one after the
> other. We can add distinct "alloc" and "install" ops later.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>

> +
> +static inline struct psp_assoc *psp_sk_get_assoc_rcu(struct sock *sk)

nit : const struct sock *sk;

> +{
> +       struct inet_timewait_sock *tw;
> +       struct psp_assoc *pas;
> +       int state;
> +
> +       state =3D 1 << READ_ONCE(sk->sk_state);

nit: Not sure why you need flags, you could later compare with TCP_NEW_SYN_=
RECV
and


> +       if (!sk_is_inet(sk) || state & TCPF_NEW_SYN_RECV)
> +               return NULL;
> +
> +       tw =3D inet_twsk(sk);

It seems strange to use inet_twsk() helper without knowing it is a tw socke=
t.
(fine today, but strange)

pas =3D state =3D=3D TCP_TIME_WAIT ? rcu_dereference(inet_twsk(sk)->psp_ass=
oc) :


> +       pas =3D state & TCPF_TIME_WAIT ? rcu_dereference(tw->psp_assoc) :
> +                                      rcu_dereference(sk->psp_assoc);
> +       return pas;
>  }
>

...

> +
> +struct psp_dev *psp_dev_get_for_sock(struct sock *sk)
> +{
> +       struct dst_entry *dst;
> +       struct psp_dev *psd;
> +
> +       dst =3D sk_dst_get(sk);
> +       if (!dst)
> +               return NULL;
> +
> +       rcu_read_lock();
> +       psd =3D rcu_dereference(dst->dev->psp_dev);
> +       if (psd && !psp_dev_tryget(psd))
> +               psd =3D NULL;
> +       rcu_read_unlock();
> +
> +       dst_release(dst);
> +
> +       return psd;
> +}

I would rather not use sk_dst_get() and risk UAF later on dst->dev->psp_dev=
;

I would instead use dst_dev_rcu() and __sk_dst_get().

{
   struct psp_dev *psd =3D NULL;
   struct dst_entry *dst;

   rcu_read_lock();
   dst  =3D __sk_dst_get(sk);
   if (!dst)
       goto unlock;
   psd =3D rcu_dereference(dst_dev_rcu(dst)->psp_dev);
   if (psd && !psp_dev_tryget(psd))
           psd =3D NULL;
unlock:
   rcu_read_unlock();
   return psd;
}

This can be done later, I can provide a patch myself after this series
is merged.

Reviewed-by: Eric Dumazet <edumazet@google.com>

