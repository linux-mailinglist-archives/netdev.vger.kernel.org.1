Return-Path: <netdev+bounces-224241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A1FB82C86
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716941C00EED
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EB823CF12;
	Thu, 18 Sep 2025 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jc7hOQhv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377E23B62C
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166984; cv=none; b=WZCzlhtgS24fGe7I1FqJsrHYG8z873lpS0tK/5PVjm0L96QjXW2pIuO/jy8x7qnWadjEd/sNy9enlJ9O5/TdTf5gIgjJz5r7WLeOSP6uNbavza3kjRJW003B7MFvkqDbWONwye3tQOZxtgVWo4Qd1rOsUW+oR8bd4gRYYJkVjes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166984; c=relaxed/simple;
	bh=IbHe1LjTTwbACM237OgnC0zeqmo5IqnF69eA6NwGXQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okEDGlHL9857W9PT6FOoWQcs7cnr9hOlbTYDXK5FiF+4o+AWnoT87lRfwZNE1qWlH2zsKw4/qhhOTFPeejBxa/l5/glmq9qCTVnp+9XzfbFMfbkNr+mTyGmhLK1j6fZo/OadhcN65hYNVlzqBMXueBig3burmEBYpmKroCm96Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jc7hOQhv; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b5e35453acso5327091cf.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758166981; x=1758771781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbHe1LjTTwbACM237OgnC0zeqmo5IqnF69eA6NwGXQk=;
        b=Jc7hOQhvjJxCYu61DY6G9WjzlHNybaEgyYTqBy0ZfqpHlnBa7k+eM5qgXSfGMzlRLO
         QLu3avV/3AdjbBlRmY2GLO6x0qRHH9HComPZSYyxd9c93/Ln4xkFK3BmxcRYdte0KQdJ
         Ac1gUMSVFuM4vWPdyFdF3dAtwL4DtrxE7e/5GPUPvNR1N7lQKzj81sa1aBnBo/ZVrbtP
         orH9fvjjtpjKCUYQyQHPFJYLf2W+MRVPA2g6/0Ti0XSdkxy7Xu65A0gctoQ2zUR/vuU8
         D2SIOT2xc9ZlMIM00Nbu3gpF4GMESpcuIMaika9a+xxZLE//sp8pEmmMspg5viPOJxgq
         /kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758166981; x=1758771781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbHe1LjTTwbACM237OgnC0zeqmo5IqnF69eA6NwGXQk=;
        b=Hrcox0nX9LO+YidecrpWiCF/ouCFaFsn5w3xhtACPH6U57XkSIhosjRs3b3+xeIkdB
         USHs0Tk66ott193RW+kw+tCWH9xrBF/L6I4s3eXH1+bsOch3RPYpzZkeUlBxvAUB6kRG
         YCYyd/aC9XisfyDwiICowq4DunyP8bYl87o7edZ4Ysi5Haq5XBrD1XfzaDQWEdIWuzIB
         I5KdX2lV9X9Esz+jIsSXgnPD80+/xjLjXsS/B1NzNkrdS4+0whcQGTvRr1f0O06/3hj8
         8yaMSAy/EnaH8Oc66XNpI8irlr5W1pqdxg23JV+uYrXJxss8wLCCispq0Im+YE5q7wWy
         SJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaSgP0oKWHY3M5XH1wmTZBmFIX8Nm+yGJ5tVcrtn3yM0YcMbXLi40+0XGC1EtUBx4gGPXwhP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKg6D3pz/N8XrBj02uTbXZUWrP7q/BzCcVA7fm9Tm+4coTmoN/
	GuSazIZawlFu5Qo9PPW4L7+moNaiij5weafLpxSFZNc2uoNDWiFF0ANpUsNjKEgPbwoLaDwz1iz
	5069ClZy17h+0Ua8LIa5UInieOgkCFJSkhhmRQ9Ub
X-Gm-Gg: ASbGncvC0DKTa8ZuSmMgyMVD0IMFpSps0ToyfQbB+yJakk7/Zyl5YVImH6HvzHdUj5a
	ZJeQT0bzOfI62EVXDvw9WjIbHqqM9s/W4AKq1ADbAFYhn/qSYsaCn7feGcFNshkkKnFdk7uAhOz
	lnhuDj18Uvs1vYPvedWRWX3CN2JsbwdaM14d+RTa7EVNHmtY0jSRztaKzNmCephgfguIk9bS/1B
	Q6v1BX6CmEKNWaadkRpLHwge0E9gYsj
X-Google-Smtp-Source: AGHT+IHby8lsvJPvTO34p8QvZu00AhxVXdWAl+umMF782g6NzDLvTx2ghlAFUgK44yAFEOcnzAGfLS5Msw4wm8UiZD0=
X-Received: by 2002:a05:620a:4588:b0:80a:72d7:f0c8 with SMTP id
 af79cd13be357-831140c3a4dmr532888885a.64.1758166981040; Wed, 17 Sep 2025
 20:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-5-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-5-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 20:42:50 -0700
X-Gm-Features: AS18NWB7-V2KF3k3MAbamaj9MPYdxtd8uc3QhI-HwFXt3_0q8PKxiVReW6OfwtU
Message-ID: <CANn89iKSf=2AVyB8MCbjmw2zdTGqBqyPUMaqPY7E_aMWzsZOcg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 04/19] tcp: add datapath logic for PSP with
 inline key exchange
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
> Add validation points and state propagation to support PSP key
> exchange inline, on TCP connections. The expectation is that
> application will use some well established mechanism like TLS
> handshake to establish a secure channel over the connection and
> if both endpoints are PSP-capable - exchange and install PSP keys.
> Because the connection can existing in PSP-unsecured and PSP-secured
> state we need to make sure that there are no race conditions or
> retransmission leaks.
>
> On Tx - mark packets with the skb->decrypted bit when PSP key
> is at the enqueue time. Drivers should only encrypt packets with
> this bit set. This prevents retransmissions getting encrypted when
> original transmission was not. Similarly to TLS, we'll use
> sk->sk_validate_xmit_skb to make sure PSP skbs can't "escape"
> via a PSP-unaware device without being encrypted.
>
> On Rx - validation is done under socket lock. This moves the validation
> point later than xfrm, for example. Please see the documentation patch
> for more details on the flow of securing a connection, but for
> the purpose of this patch what's important is that we want to
> enforce the invariant that once connection is secured any skb
> in the receive queue has been encrypted with PSP.
>
> Add GRO and coalescing checks to prevent PSP authenticated data from
> being combined with cleartext data, or data with non-matching PSP
> state. On Rx, check skb's with psp_skb_coalesce_diff() at points
> before psp_sk_rx_policy_check(). After skb's are policy checked and on
> the socket receive queue, skb_cmp_decrypted() is sufficient for
> checking for coalescable PSP state. On Tx, tcp_write_collapse_fence()
> should be called when transitioning a socket into PSP Tx state to
> prevent data sent as cleartext from being coalesced with PSP
> encapsulated data.
>
> This change only adds the validation points, for ease of review.
> Subsequent change will add the ability to install keys, and flesh
> the enforcement logic out
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

