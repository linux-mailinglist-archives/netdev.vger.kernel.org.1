Return-Path: <netdev+bounces-207554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D06DB07C2B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A625D160A5C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B78E2F273C;
	Wed, 16 Jul 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddIBmixL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979623BD0B
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687487; cv=none; b=lIUvCfsQJU9W0AkpGeSpXtNWgFX777pj3yTvAY5G3D8BAjJZIzftrIPYK3jNOupfZGC+1yEHATcm+nHCLSeJy/3azAm6o5loLjP9gPgm43dLuf62qyOmrRAXmoxrbeSnnekujyjCexZ4HdEggk7QQUEKboPiJPp6WgjyBYpyeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687487; c=relaxed/simple;
	bh=4Pdfk6ltbPab/B8aS+upI8Q9yCKqEwTv7Xds+3+/xp4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=l+EUB652LSoxK0Ut2EqWEtGA9+LfKzaRS8X2tzAZiw08UTUWYW6a4cy7jviKW+dzmY5n41EIqnKZi8NPxavuKLtiZwzO4Yrrvt9Ie1z8TkCYV1bFfGyYsulJp9R32MIOUfdG3yHZwQCQ0ka9KnUVVZtbLqC/vH+Axho4xRHxJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddIBmixL; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e897c8ca777so148059276.2
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752687484; x=1753292284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jw9AmnZW2An5Pfp0vKbidE+Nga/TyiPJdY/GvnLN19c=;
        b=ddIBmixLAWZ94mXBalFNHB9pRw5KTnLvGh0716wz8jXzoD6ZYU0JX2LZM52eQpJtBj
         AaaOnwbWnkBdH9PfW/57je4aRF2Ngkhfo+UQNGyGK+3IcrK/ku79Ag0pn85G6ZKGL7UH
         fhLD7gLZggxKlri9lvhH1UPG0V4BjLOoSSupVgnn+9NoxhVTK4seNKMxDL3d/K5D6gHe
         0jfzIvMvPe4TCzonasM2ldB5sAa6cHmCDgATH/yKKOIlOEOvMFz0KOW7XDAtos+RTQUi
         ffrG9u+yPl2ckEgVp3peh7g5ON/Dvs5VVt/K9tRKNFM7gxsM/r4TlZS1C9JqRRexSD4P
         SAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687484; x=1753292284;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jw9AmnZW2An5Pfp0vKbidE+Nga/TyiPJdY/GvnLN19c=;
        b=hvNC6IgXJEUISdwm0hSzVhogO2R8gyzacIPTTqtxUVGE2clRX4Q9fd6KDBjFIIfm/t
         P93tmSqMi2GFw8cXJ27ocaHP92QX339qXmszKpOq/zUR03uiY9GfUUfz+zK+KQVKxYQo
         0H6AIlJ0eUIF+g/X7p70YVqnpjkrWfIdAygPkLn3uOEz5/EQpc2lq0R7cH9CEFVWE/cU
         fehGmJlXpBsqxRXGxK/3SZQWtYK9gzCLKPDx2053BBkzOBV5/STkEUmi00wFHN50V0Qs
         poog1hdX3wEO8wv0RAA6Fd1jtLVzHk6diIt8XTs71BgOTmBGvzGyPB4KZg9BUhjJegTT
         ttpw==
X-Forwarded-Encrypted: i=1; AJvYcCXvOBAU8uo6bbRTRiFoo1zQCGw959D6ENgQuOSUIFgorwunNgd/0Lp+B8GoZ/DA6bFzx3jDDfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGEzCv/CDWxnlfFm7xpY7JFyqgyh9e58nDI23nsvQIuhGIr2dP
	LjpWwxca5dErdtYfHREYZT4TPsKD0g45nRPRJXAGY31D2pMLsHPfFHV4
X-Gm-Gg: ASbGnctcN9STwrueqbxMNY9ZAbHa3ddNVgykgp1WCm38y5bwDhq+6ehoGAWEUE6ycfy
	Z0xcvo3ET9ncelWFxQw1MsAcsLgmFKSiCSZG+qfKpYsqx8v6fvVL6pkSPJuzaEz5gbBSxCa+G6z
	CjpiIFzwsgTbWSxAZCd0YBV4x/+t+rj7+1ocW1cw3mtxkw/R4D22eYsdQWDw/sXkfJWw//6lGYj
	d+NY0dPuzO/BLYmCS9uBcGvn0MTHr39iogmUG5D5eyZLaju6sjnz4mWGAEcJx8Jp1Hg2ONZJ1vY
	30eth2hxMW4UOaHhHTKcKAUhEveaz+6CYcaQ8WIQIPfGWwWPl+7xWe7scVQVUZjNuAzBrQOBv+x
	EmVnHwGReGPRzTxhcmi99xPWh/u3Oufld9qh06lhM9L+MxF/Besz59qw+XnKpnAo45+clkQ==
X-Google-Smtp-Source: AGHT+IHuEM45/uPbfNGCb191JryhKM4FOVAzynAsWqx3c82TLvN+hglLdIbsbe7p3GsdHtoc9G1Ezg==
X-Received: by 2002:a05:690c:6e0b:b0:710:e4c4:a92f with SMTP id 00721157ae682-71834f3680dmr48343197b3.5.1752687484590;
        Wed, 16 Jul 2025 10:38:04 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c5d70373sm29865247b3.35.2025.07.16.10.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:38:04 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:38:03 -0400
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
Message-ID: <6877e37bbaf6b_796ff294bf@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250716144551.3646755-10-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
 <20250716144551.3646755-10-daniel.zahka@gmail.com>
Subject: Re: [PATCH net-next v4 09/19] net: psp: update the TCP MSS to reflect
 PSP packet overhead
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

Reviewed-by: Willem de Bruijn <willemb@google.com>

