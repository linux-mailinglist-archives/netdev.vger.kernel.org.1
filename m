Return-Path: <netdev+bounces-201383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C3AE93E3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7227B1C41D0F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FCE155C88;
	Thu, 26 Jun 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5Bepo7B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CF126C17
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750903790; cv=none; b=KGDouFPwpdGQdej7OKrAP/R+/TO45RDC5ieVAAVeWc/uFT8zaEE+vXVWKer7zDCDQkImD4JFzGrbebhPmaE0FHqX78SmGpynM0u0wQRk4XlcEmGR8iraK+K9pSE+mtoRAHeoZLh4NTScWqh3wosLSZduYvJfsz1Pa/+tTwlXbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750903790; c=relaxed/simple;
	bh=Wqty1Sr2BI+7QSfMAWMfkPsDP6b5h8UaMXw4nLxdkhs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TVk9+BNj8FrTFUOrhaw0zIt7Y2UOPVbvgEPoyKcyWbAQCuuJCSbdfurHb9kZmM/0ZPXzQ5QXnvlyxvx9r1rVjc5PgRfZAgoX5ka7tHd1XHJHJJ4V5X9T+eRhjgqrVkLH21y8RHo0GdH4A8ibzOB1zMmphLxjDv/ADoR/TAe5osw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5Bepo7B; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8600c87293so352255276.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 19:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750903788; x=1751508588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGO3+WNE1wIEinGZMQxws0sCB+Qzo5nwbEfCXDM6Reg=;
        b=e5Bepo7BHMf3a6Asm9aYK37MXZWwhCcYZqEkwXe1Lr2DLsFPlH4Hp6uloE4U4gZL91
         kWMdZqFxbUfQPgCDx4ebEBxlV0xgN9V/mzdHSPfCsBwNiVTVHpbJKRIfArUK0yWYXQdH
         3RPbKEv8a0r/QcxQOLNdufROxxeCMGJJc3scdj00lXGIJBheDj1mBjsw/4RFTaVF2LQy
         Bjw0WAliYTJ+7rAEy6SHe6LXv3CBKKHO1u+wS3mnZtVnX0EnAC1mkv1SEVpmWm0LoCDn
         O5LYReN1nCXU1PUitFpOe86UrIa9dkbToGgmLFdEvUXhWDYCKMWGsE1H5sYLwR2Ai6+R
         7sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750903788; x=1751508588;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mGO3+WNE1wIEinGZMQxws0sCB+Qzo5nwbEfCXDM6Reg=;
        b=Lq7ii/jsHZmVtFmwlxNcoifduqFxGdiKoA3mTV+xINplQLWkklIY2Wua+gOCgg7pEI
         9rRKXUahHmGus0Ki5JJJOWHBLqoBhqlItnSAd8pZ7ug9BPoRWoCw/5jnHXvtIOHslzH9
         A4aJUoLvDhyLQf7LtvnZF9x8MQWd5y+G4VrAMj2ZVJITfhJExBhv3z5cXxmlDUp33kRs
         aYpsw4WEnvH7IyIyW8aG9wbly6WJ4VaY7Th/FRgI0Lta9AmovfGCgjttPalvzGuYhOnJ
         N+dtaEAG64rgRYeDMkIBwHPD59cXbQ1cY+wZjcD2zCzuEOK8bHvH0CC9Z25hHNsHjyhm
         uYlw==
X-Forwarded-Encrypted: i=1; AJvYcCVJoRrVFQ9lqJH4/JDaUAsMB7YwpT/tFYqi3lYhq2o35eA7WUBKPKTSo31S0d7jRTDd9w7QxCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKISeOzb7sQCdQllDQP39X14/ve8tSKKLXdjFWdC/bwkTyNZD4
	/m2C5wO1znX0fkhnubOaqa5nP0fHU1LbC5a5FTxaZ7uW2g6dCjTdvPw7
X-Gm-Gg: ASbGncseTiI1bCAFWhIp7P2Qkpgc6gVJMDvS6509p5mpnS/qpfmEwNbzY37kO6j1wKx
	ozcX3/KMKuijms3UiE85LjzT/TIUu0f9JiK3k2fRdnTYfOfNXzZwJYHWDEsND9pqqvHb/K2XUDD
	6SSVSCQJmQHgngo6lFkKqD2vmByoRBWor3Rs2bhft12l5jalihCXMpiloLnAam2jOoQEKpbhXqT
	HxnkxQy7uQ3p29GdyhPRVem+TR6Boq1TkPsir8T+0kMddR665E/h6AwUpD5p5cakywhpWGO28u1
	qn0sDOI4/WtTkeuSpq3vNnhRGKGEWoE0Zv5R1lIP8ZmncNUF182/UYDmImnmDHIxGgq+yTn1+P2
	SpZb6NWkh2LYcHWxHS3vnoMPD/UJ/WQlmeEIVcYl3rg==
X-Google-Smtp-Source: AGHT+IHOg9gE9rwG6ydwBzD4KT8iHu3nL+B+0sA1LmI2CjR889nbFxAVjJT5+/QJS7Na/Hmw1XGbPQ==
X-Received: by 2002:a05:6902:846:b0:e82:5142:7c9f with SMTP id 3f1490d57ef6-e86017c4236mr5715893276.35.1750903787734;
        Wed, 25 Jun 2025 19:09:47 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e85e39a6b1csm2014084276.6.2025.06.25.19.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 19:09:47 -0700 (PDT)
Date: Wed, 25 Jun 2025 22:09:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685cabeaa2ef6_2a5da42944b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625135210.2975231-9-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-9-daniel.zahka@gmail.com>
Subject: Re: [PATCH v2 08/17] net: psp: add socket security association code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add the ability to install PSP Rx and Tx crypto keys on TCP
> connections. Netlink ops are provided for both operations.
> Rx side combines allocating a new Rx key and installing it
> on the socket. Theoretically these are separate actions,
> but in practice they will always be used one after the
> other. We can add distinct "alloc" and "install" ops later.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>

> +static inline bool psp_is_nondata(struct sk_buff *skb, struct psp_assoc *pas)
> +{
> +	bool fin = !!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN);
> +	u32 end_seq = TCP_SKB_CB(skb)->end_seq;
> +	u32 seq = TCP_SKB_CB(skb)->seq;
> +	bool pure_fin;
> +
> +	pure_fin = fin && end_seq - seq == 1;
> +
> +	return seq == end_seq || (pure_fin && seq == pas->upgrade_seq);
> +}

Minor: with that test against pas->upgrade_seq this function does more
than its name implies. Maybe psp_is_allowed_nondata_at_upgrade or so.

