Return-Path: <netdev+bounces-204435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB7AFA694
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC9C1769D0
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C72063F0;
	Sun,  6 Jul 2025 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/rz+xun"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FB78F36
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751820565; cv=none; b=BWt1E+9hH0U0XkTjbp7jrFCsJi5xwWH5nFPIlNxHhSu99SrxQSnhbzUWTdx+l7aAzZIQjTrnhLLXCsH62k0Uzsi+ZSpW2oyzbD75leuxV/Vf0BWLqq4t8XZ7yptg4r1x2k+O7fEfMr6uxFyINig/d/BQEe2Kl3UW/PFPz5Q0f+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751820565; c=relaxed/simple;
	bh=9zw8qmJO8qT5XHC+5uJSUXzdmmW/k10RrY71YVxi/XE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J+XGeTa2Hp27lz9BEgW1iLeQzB110mopL5yufnviMVSDk6EVPXiE7XT3deD3ucSc76N/ZVpzFDMOkhI0aGKURh6EClMTqvMDVaxw/a8fz726lPTGEsLwZbT7ewUnFSx4ObRfG8pvFMolaZUPmMrcSYA7hGzs4Re7tcy6OWRqDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/rz+xun; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8187601f85so2155916276.2
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751820563; x=1752425363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0BGiNzVy9M9Jh3jZEjuBLyXdajst/j7vBH1kwewi2E=;
        b=S/rz+xunCt67rvatZlNgmjvQ6X0bEdbqx5bY+6K+zNxRk6OGzabNUaKyRQaF2ADSD5
         EiJ33gOAlGqZp84K48r8TPCL9V6yRU8jhHY58MrtNkUDWjJB5ottVcmQ07qx+4i9oaLK
         iRGDlpKRPLakTx+f4K24F0lBjBtR19PoavA3fGb+X3sofU9mrjeh5eFCck/ozPx99UGX
         gN8MPoFmwcFZTkotnJ3uEaVDJYBNzrjxjUhbcK8Fmb6Q5QUhkYYbIqth52cinF6hwKlC
         K2i5w+lKYUyXISB7EkRReTV9gXYTjgamuJ1K1fiLqNRkbSBK9n3Ra90bA/Utg3wMdibu
         j5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751820563; x=1752425363;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g0BGiNzVy9M9Jh3jZEjuBLyXdajst/j7vBH1kwewi2E=;
        b=ZL3s8gQ/lml4egZyUlcAiqAYS/d+Kkwcq9bBQ48rpV7vl0CXCoXX5nnyxCDqhck25P
         Y+MJXbQOgKJ8ollALUDEcUsqUoyjhmdCdwnhDjAv8SiiUKCk3EpWdsDBlRBl/JPm2cep
         XFm/2P07zIQIi1VaxH3t0k+U/d1hQlZLepHtCiN3PyuOdXTrc43kFIlPSq8BJM1oSpIP
         LSy9vPpGYFSyTTWmlz6J8sNgccIwBnLNz+5DuqxdmslYz14uwwMY380EqxhkC9pd79W+
         jLLrvcuroZtMKgz1nQoI19Wt31l3CGSAPUjAGaDSJHdsNalDmdrVC3CO259v3O0O6NB5
         FKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7zhtq2E4xCRfXTuYN/jeVDCtDtAy/XUs4STEB8LTAnx3FiwCTO7voebKa/RCRQMl6rvH5s78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz572BCRZ2e1KmJjToluC8+XYwQ7oZvFBTAiUnIcofimt3HmSea
	0VeUL45MKqgs+6yhsQAaN/kn0WNG1yUyymSN72JdqXtUnvd08aIekJoY
X-Gm-Gg: ASbGncsju6PAojdUP9uGMs1R21TuPDZCRXpKIx/4JS55ahMqY7dODag1CLLNVDf5PPH
	PauT3x0a9obLjovdlJS8ZwRHDJGxFvtWv9+jRWhKhtcDTFUGQJhfGZDtSWBvSL3iqlFilZeo/rr
	0uYLIcUXuaypkeTvfqepSEA4tb2x8VRHlb3cCz/2V6fWzR7A//v89V2AA+vixGsds2mLu4s3RJW
	uGItk8mz05NIrd+AtemvKHj+SARix8eQhTEC41CwRKsxIF7RV4AR87wlC51e1kqtL9MTV/nj1wP
	hXS4a/sEL5+7UuhwL5NlrM+J+wgKD6NnKv0L+w65MNjyKCNx2Mx6mEaQnqBKFyiN7fgrry8bLlm
	H5tGGa+n/ApAsRJtO3B8GabJ8jnSeRxgIdCm/gNo=
X-Google-Smtp-Source: AGHT+IEZuC3d+HNvbldzI0qVme3/Hfg9yT3KDM/AWFXVW9XCnBUgoPXQ5QCu9W2s3mVAsQ+sIowz6g==
X-Received: by 2002:a05:6902:e02:b0:e81:b2ba:cedf with SMTP id 3f1490d57ef6-e8b3ccbb9cemr5695720276.15.1751820563387;
        Sun, 06 Jul 2025 09:49:23 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c441fa8sm2079534276.36.2025.07.06.09.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 09:49:22 -0700 (PDT)
Date: Sun, 06 Jul 2025 12:49:22 -0400
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
Message-ID: <686aa91268bbd_3ad0f32942b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-10-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-10-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 09/19] net: psp: update the TCP MSS to reflect PSP
 packet overhead
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
> PSP eats 32B of header space. Adjust MSS appropriately.
> 
> We can either modify tcp_mtu_to_mss() / tcp_mss_to_mtu()
> or reuse icsk_ext_hdr_len. The former option is more TCP
> specific and has runtime overhead. The latter is a bit
> of a hack as PSP is not an ext_hdr. If one squints hard
> enough, UDP encap is just a more practical version of
> IPv6 exthdr, so go with the latter. Happy to change.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> 
> Notes:
>     v1:
>     - https://lore.kernel.org/netdev/20240510030435.120935-8-kuba@kernel.org/
> 
>  include/net/psp/functions.h | 12 ++++++++++++
>  include/net/psp/types.h     |  3 +++
>  net/ipv4/tcp_ipv4.c         |  4 ++--
>  net/ipv6/ipv6_sockglue.c    |  6 +++++-
>  net/ipv6/tcp_ipv6.c         |  6 +++---
>  net/psp/psp_sock.c          |  5 +++++
>  6 files changed, 30 insertions(+), 6 deletions(-)
> 

> @@ -95,6 +95,9 @@ struct psp_dev_caps {
>  #define PSP_V1_KEY	32
>  #define PSP_MAX_KEY	32
>  
> +#define PSP_HDR_SIZE	16	/* We don't support optional fields, yet */

Duplicate of PSP_HDRLEN_NOOPT?

> +#define PSP_TRL_SIZE	16	/* AES-GCM/GMAC trailer size */
> +
>  struct psp_skb_ext {
>  	__be32 spi;
>  	u16 dev_id;

