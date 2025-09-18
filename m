Return-Path: <netdev+bounces-224239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4DB82C56
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88B0164245
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8C4690;
	Thu, 18 Sep 2025 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbXGxzkN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A762582
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166707; cv=none; b=XKAO5fEB3qnFsuMr6UUu+ZuMC+n+V6ZR4fA+JqdLOkUivr6Cva3oqhVScifiG+U1eCGjXqhuiw4YQfVW4ytHFbzDSl9EuJ4d4pc2YVXsyUF1/7RYBBrwyTw3WIr7hvsBDvudPnv63x4Q7S2VozCw5E7jxEJKNhEG1NKA8R9VsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166707; c=relaxed/simple;
	bh=CtmJwnJu8N1ck7hE2ozZRsNG2IyusRlVhIzOEMCYUxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3m3cUqEUlijwsKWZAQvxOmcpB+VGduCRddaYrpRTy63KzBzw3z5Rk0y7FJlwRSmNld/WkCcckBq8WNva6xlxLWMCurcqutZM4mDReAuCbllzs6tGrt8PEZ35HtqqtUjsKbyugPNIoBN6JR52L8F4/TtbHZC14EFzjWrfmVZQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CbXGxzkN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b58b1b17d7so5332381cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758166704; x=1758771504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtmJwnJu8N1ck7hE2ozZRsNG2IyusRlVhIzOEMCYUxs=;
        b=CbXGxzkN1vyZx1Tx7udVqHaQl3zYvFbdVpGkihezL+QE5BBLgIoFwQfvpK/7iCCisL
         /e/Met77PtcWF1/stP5fLt1hlVG6wotgKdZ+DUpxTobAfQvM0xu5x9/TnsHAgNh2gX1p
         45nO4f6WrJn6jsqkYcJIyU4O0xbX39Ilzac/1OaIYd67ZyBAYm43IRy4+srQcSoDxppj
         DaDk7MQpi3nMeDD4MexuefggM4E7TLoFqZxruGT+39ge1VrUUJ9SoCImorXDHIq9hy9e
         uqe2MQyTruBtxUtFd+QKZn7Rbr2yf8nDTcdptKGu7+VkXlzsuKZ0FBJ2VxecLb5vr5zJ
         3fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758166704; x=1758771504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtmJwnJu8N1ck7hE2ozZRsNG2IyusRlVhIzOEMCYUxs=;
        b=E62fYRqZT+ZIoMdUTwBvCErq3l36MALIYnLcCEkyebWRCEJuT9sku98jpHFvDU+sim
         wqfH0Cr5lauZb/bySJZOwRiVaLiiiIHTkBK98k7kxlzQNw414iwYnz3V++V54M3NQNZN
         V+xsMv20VDtfLLY7TgL8POAaRcBmPFVL+7hy3CYDELTMPIqYeqHRWRYQSY9ZXOYxsCfU
         AxqMp/UJl+4A7pY6khIxtN9oLECD2ljLJA0Ohy+Zsc0bnHf+glE/1bZJWPTfUVyrC6OU
         wxx85Y/9ksDFI0WizZwzsCa6QvCpIe6MrFRBFTiQ4AVXFNaehz3xtLZaA9fVfiggDBUV
         IyHA==
X-Forwarded-Encrypted: i=1; AJvYcCU2AgeoXkPlUQDcD4k8C666Wfutoe447YrqOonQKf/5r70vMuu2fAZUpGyk6HfhdjTFCw0c0f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmErDz+bGmRIo+qfZXhxHwGS7tVWEfOd3GTPWxbu5MIYYoIPI3
	QSyLCRITLqkzI/zNPQJGMzSEEojo+fVUP5X06PNg+XdFfD/WJvs4zFV5+/Dfz+H57pCRbEBaTi9
	ac3WICDnyBWDqp7ASAMQDJoYLVf+VgJo0u1bqNsyr
X-Gm-Gg: ASbGnctC8s3k8gbyE56y1nUcZUMgIJii6Dpjc34YHwpPNtmbUmHrsk8B6u46JvEbD4G
	KYLE+Mlgu19hCfFQOfLeaAPvTxNODrgJgu/Oe6/WLAdkvJPVB0bFB2qgUPystGohZ2GJ0NjyDkO
	DdTZTYt8iWCiwfftQgyZsIgtJ9TggEtog8M28t9Sw7yBDGgyZdm+fIFLrQKCxu3/GZfG+bgrsvW
	sLBxZRViNVU0hRl34AvjaM9nsdGYZXMq/nsgUiLjcI=
X-Google-Smtp-Source: AGHT+IHQ/vI3m62oc3lTGmMRquOrCf9ZNSwaX02jvWxKgFAebN5mwLp7yfa+/ssRjlqgibT6xnoUJ6polTr8YZzjzRY=
X-Received: by 2002:ac8:7f04:0:b0:4b3:4e8e:9e32 with SMTP id
 d75a77b69052e-4bda7bf3cd3mr23704301cf.3.1758166704267; Wed, 17 Sep 2025
 20:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-4-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-4-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 20:38:12 -0700
X-Gm-Features: AS18NWCKzGTw_2kJKMKy6W6qhulrBNk3LTgmJ1NdFzjvaaGc8fOnCA9Hjr9IW8k
Message-ID: <CANn89iLLtSoGrMNjSY5-wETVQJmsNcUVgQe5shY5Eqt7kdsaZA@mail.gmail.com>
Subject: Re: [PATCH net-next v13 03/19] net: modify core data structures for
 PSP datapath support
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
> Add pointers to psp data structures to core networking structs,
> and an SKB extension to carry the PSP information from the drivers
> to the socket layer.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---

Sorry for the sk_drop_counters intrusion ;)

Reviewed-by: Eric Dumazet <edumazet@google.com>

