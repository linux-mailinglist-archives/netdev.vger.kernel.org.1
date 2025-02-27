Return-Path: <netdev+bounces-170150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87CA477EA
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9239C18878D3
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B89222573;
	Thu, 27 Feb 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzGU+NXR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40C222595
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645319; cv=none; b=SB1zuQsI3zq4idpUDQm17tx8SY5ABx4kSwVhlySutNpRiwWNkkWaLUzYiBSJUO7/x8l+5lOoqERiKZu5UW38RX/lFfiMhZj5iXgrLAPDkJx3/JvFhmdMRwGcA2b04ENRNT/6YcWcWfZyVAJpKho8Ku/TFQ1rP0FghzYAMUN5O8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645319; c=relaxed/simple;
	bh=xPMrcZXlyzkOROzTylH2sE2WQhKnhPRp81sgczS0BDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vqhb1HY3gymT2N1alV8lgxdSQO7Mt/iMnKNOaQ0902RJRp1XGbbgRQgOMwP/fdmR3sYjTfBqLN9YqfXAvgRfI9EDp1GCjbuKVBrdpkAcETDdk5sAhNxpqXpYnfCtvN9kECdAynGaJRiSslokxQagX4Y17sum+iejkHDf8g5De5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzGU+NXR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471f9d11176so7453931cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 00:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740645317; x=1741250117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbUNq4GyX64nqzEmvp+umfuZHI26ffw9v99H9Suo7JE=;
        b=HzGU+NXRvHEegbXS0+SMUpFYF+3KoeWCz2qMFDBPnmHFMNRm+hhRLHoeXdcxqXa8lE
         xQvE/sTAjt40g8NXGkK5j08LkTnB9e7FROCcEO1kl7nguY3MCGaSdRW9420Bf/W9skYm
         cJi6u4THLBigEv1O5NogZQ6+/iwhF3irdrRhhFGZ2T5jIMMOfVLvzrZXUIGsB/ue4GOm
         JJI29VQkIkiTX9kJCMUsw0do1IjEW5sFl+V7eMpVEzUTcABoSAXhRSySk4SYuWjve7x3
         VfmAlbKzfIWhDykk5xZO1QhSmXvjelQNK3gMIADwA7WNAEni2UCUPs63NbJrPEu+mcQF
         f7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645317; x=1741250117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbUNq4GyX64nqzEmvp+umfuZHI26ffw9v99H9Suo7JE=;
        b=AM+OJbnRNH003rReN53Zwj7lkUOlESQhh/UwDT21KcP2nlH21D0sXsshDFkStNWdpM
         royPW7yi0Ftp4F36dFtS7kbKgs5OYMpYvTooXYCl4pQE5RIjH5qTbyzh6ybhoMTiFJb7
         HywoGD+VUaOUKC/8QHSks14k4FrNkruruzK4MU11Rqq0KqZMF7CuafnYHwLL/+UtHXn2
         MTKjMb2MKrkazb6FSJ73L9R4LqKSRu/+I7zDFW4M8DgcJdEzdmO94Hi8VsipdE1z4QI2
         SRJIPCg8OLV7O3Bz3V60Yo9FXD57om7kqY14GmGmMK/m7fADuxWjqdUwVK1bBhvJW3Sb
         D4mg==
X-Forwarded-Encrypted: i=1; AJvYcCVXw1xuq4xkqVmf/NhcX9TKN+PR/mHS638tLu5RcY0fD4eDAEH4+l3wb6aWWCERrhomvqqF1xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxrjwdCh5o0HvP+Krf1n5Ika+WSCJywIt/w2SEOT+QRRvuUc7A
	lxqF3N7xMHJYUe8pcdhVDgdKd7O8Uz/GxKs3J3QiCb1lEJ0aoAkuTgkEVf0lvdSg6XRO90f4thi
	PC23m5HacnWdtMx6lWOzP8WDuxDgz00bYATEX
X-Gm-Gg: ASbGncsPzRYg9p3Nufm+0dkTmSTp7INHU7SoqA/VJ72yIusEePxHncyqEjJmhcph4+z
	FAdQLTUgmABPnjOSWwt2Q/mMyi4J9RlMpQRgm1rarNnoep9a/zicjIAxqRAwCDvUeyqkE1mdUrz
	SAyjkkxWQ=
X-Google-Smtp-Source: AGHT+IF7aj3xZqg1BXSkAfM9Yrb4ohI/2Ky9Ht430sL32q+fWf5c8humNsilGQHX1CYP+rTmJHV5RbiY8qCIFlua/4w=
X-Received: by 2002:ac8:598b:0:b0:472:95f:d25e with SMTP id
 d75a77b69052e-4722473cfb4mr342060211cf.19.1740645316870; Thu, 27 Feb 2025
 00:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740643844.git.tanggeliang@kylinos.cn> <38054b456a54cc5c7628c81a42816a770f0bff27.1740643844.git.tanggeliang@kylinos.cn>
In-Reply-To: <38054b456a54cc5c7628c81a42816a770f0bff27.1740643844.git.tanggeliang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Feb 2025 09:35:05 +0100
X-Gm-Features: AQ5f1JryXKMVP6N9LHTCBYmNcUmx9qDszFAnKpx8VGAyOne3EBu3Vo70b-0zGuA
Message-ID: <CANn89i+ZLAPPKVCzAMrchJBvisiOsEZyVN-TqGUkEH8EFApbpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net/tcp_ao: use sock_kmemdup for tcp_ao_key
To: Geliang Tang <geliang@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:24=E2=80=AFAM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Instead of using sock_kmalloc() to allocate a tcp_ao_key "new_key" and
> then immediately duplicate the input "key" to it in tcp_ao_copy_key(),
> the newly added sock_kmemdup() helper can be used to simplify the code.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/ipv4/tcp_ao.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bbb8d5f0eae7..d21412d469cc 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -246,12 +246,11 @@ static struct tcp_ao_key *tcp_ao_copy_key(struct so=
ck *sk,
>  {
>         struct tcp_ao_key *new_key;
>
> -       new_key =3D sock_kmalloc(sk, tcp_ao_sizeof_key(key),
> +       new_key =3D sock_kmemdup(sk, key, tcp_ao_sizeof_key(key),
>                                GFP_ATOMIC);
>         if (!new_key)
>                 return NULL;
>
> -       *new_key =3D *key;

Note that this only copies 'sizeof(struct tcp_ao_key)' bytes, which is
smaller than tcp_ao_sizeof_key(key)

