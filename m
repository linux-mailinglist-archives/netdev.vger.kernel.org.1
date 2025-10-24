Return-Path: <netdev+bounces-232532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EC5C0646C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD5E188FA79
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CBD317706;
	Fri, 24 Oct 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGQJD57M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7F30B52E
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309385; cv=none; b=hMRkX59dQaiIYCQTIj4dJHlq93Pepbp3jYCKyxAsxa7WRKYQPaqvDGv0mq8ADhvco0qIZzwK3KibqzGKjzGsfR0FH01ynC4S+lCLTKo3yxIY44mjP6NnFI11Esx6USaeaQqGdjcKHvS9z7iunMaxb+iBtTuWSuyShELlC+Z5lAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309385; c=relaxed/simple;
	bh=DYHtoeoUIQ1Gfa3pBqit3HHf/lqRBlGFOoSlz9tenKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oA/EwnalbpzQ0vwK5fYXjI3pcOwiV+q2x51eFRMt02jswfrd+1fzpp1FBPi29oDLI+XkL0pmnBLDySd/hb+B2KYe2+2icmHBRRLCaqKjFgdlxWNJWMoeeyN4Vv6hTVcNYw8hgsDdxZMtoNw0a2kldeaYyBJDE/NrDkNOwfjJFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGQJD57M; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63e3568f90dso2089377d50.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761309383; x=1761914183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYHtoeoUIQ1Gfa3pBqit3HHf/lqRBlGFOoSlz9tenKY=;
        b=OGQJD57MWIFycpKuF2308reFFj5Yuii0x1dNVJZJ99WIfiPjv03XyS8xfccDmMs+x+
         ZcTyh5qRESM+5WWrK5VU63VEAiz0HR9gPkUCfTipfaB56E1mAYZ809OltnxpDgY/UFWV
         qUi6hb/zct/lajqvNCOG238XGKoMIFlV16tT0qsYrOIuRMEjFDhxpRkWNDKPKIfcWp3G
         JQCGTrkFOboJQS/N1Y+a7PR5p20mpH+vI7dYZf7SCp/OFxkLcb66mLWzr345lQhTEyKY
         rSmVAf3UTFwCudU1Lj4wvr1JSvKaWWs9jLkycK5C6GCEEnAz31UaPXENBomU2S9BoGcn
         yauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309383; x=1761914183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYHtoeoUIQ1Gfa3pBqit3HHf/lqRBlGFOoSlz9tenKY=;
        b=I5ZTlT9ricckap9PHbhwc/pMom5TkWsILy7Lf8ArSHBCjajeW69B6hq/3QrRZvVkIL
         FRQm1IMCUNJ0mctT8qGpyq8Q831YCbBJZn5JsmxHMqQdaLSSIQY1OOjLndZFfw7Ftbzy
         Iy9Tr/33Kg9upuHELQe6gZcbjrJ2VZEoEMVYjcN8Hr4cPUrsAAmUcHGBJk/rzLyrNd00
         +lAfB2Wm14i/AXFm2tt8kLyUy1mie4jFZx7HVdvgWY/unNa6cMcyg7osO0GuxFgE7cmq
         3IVmSZ7wxHDeldNGhTgsZIvq+Y8Z3ToaCa3gUyq1bINUvF+kvBx8Ow6ir1eSWPd9UjeS
         HJQg==
X-Forwarded-Encrypted: i=1; AJvYcCWtGzYKaud0Ctp5fHrOBKrKCri2r/2Op92EErmQvoyO6SzFFrDy6LDeW24GsNcdb8H+sdCM0rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQeNuYi63G/0maY6oSq28IBU0XzEF3tdBM2LOoTTNPF00QaDOL
	OgCsCJ7jt750igJQSRYcVKLf1NZ2d49rvnAA1GUPTVTRisdrdL8nH8TP4yZnGJnUdz8GMRqgOSW
	7RWpTYatyauNONleujPK0AhFbZ78YZqfrTcroAIN9
X-Gm-Gg: ASbGncssuKRWkIxK+iYSIr9BVIGUn8JWOuSrPxDDlwPb6Pi6+imd+Dhw57PWbj8EsO7
	ccFoglUnPaswuf9m1a7ohefqwUrBP4jLD4IE1iEbHSxkT977Uzrv3dt0gNTn/bHIVPIUijjGulA
	ro/s4H7R8TT+fonDbh5xz9a3TNr2ag1pjmOoJYwkTxubuZH9YvRzqmBYBsQNjqG1fCXhawd91oE
	hANv/DMwc1yyXnMRY8ePhsV+pol7g6A0xer0OO8jY+5bUCA9RWqk7K/PvAQ1quGGyQN6AA9I/db
	ucwp
X-Google-Smtp-Source: AGHT+IHrfSGOY5DtoYVlQVilpa51WkTGanLjqjByiL4oV3nKMid9Ujs1A62HiFz4mSosLJAstHxFBIHtBy10kBTtMZw=
X-Received: by 2002:a05:690e:c4d:b0:636:d286:4829 with SMTP id
 956f58d0204a3-63f377d2558mr4350703d50.4.1761309382594; Fri, 24 Oct 2025
 05:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com> <20251022054004.2514876-5-kuniyu@google.com>
In-Reply-To: <20251022054004.2514876-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 05:36:11 -0700
X-Gm-Features: AS18NWDSgCOuGM-hs9rLk9PnpAAhQ1Z9exN__2TJ5lN7r-G2YnbgBONK5utrAJQ
Message-ID: <CANn89iLmd7Woe5tOPTSAMgtd3B+RpaN5tSZmCGry693b5bHpkA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/5] neighbour: Convert RTM_SETNEIGHTBL to RCU.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 10:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> neightbl_set() fetches neigh_tables[] and updates attributes under
> write_lock_bh(&tbl->lock), so RTNL is not needed.
>
> neigh_table_clear() synchronises RCU only, and rcu_dereference_rtnl()
> protects nothing here.
>
> If we released RCU after fetching neigh_tables[], there would be no
> synchronisation to block neigh_table_clear() further, so RCU is held
> until the end of the function.
>
> Another option would be to protect neigh_tables[] user with SRCU
> and add synchronize_srcu() in neigh_table_clear().
>
> But, holding RCU should be fine as we hold write_lock_bh() for the
> rest of neightbl_set() anyway.
>
> Let's perform RTM_SETNEIGHTBL under RCU and drop RTNL.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

