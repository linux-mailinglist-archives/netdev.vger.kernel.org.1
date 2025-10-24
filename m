Return-Path: <netdev+bounces-232531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED85C06469
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17773A6F92
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AA5317710;
	Fri, 24 Oct 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npRQkysC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9A317706
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309305; cv=none; b=Y8inH6j/swc+w9JWGcn9vVcco6tSJ9RcN05z7JV6+6HFSgbpagPIiKLks9jD9WGNTv8CKFUmYfUxWTMN60EkBtJ4mTcSK4bXOWp9+m22PVTRjf0Wcvi+VCvPimn8EXzCCfjEOJF2eoBIlYN0GwvcFflk91s+Ye5L9TJ75NlGdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309305; c=relaxed/simple;
	bh=nAzmTCTuSFoPvjrnW5rHiXMdh8jXQknZXjCYVDGF58I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAzhGG1ZDBQOhG/S+/2UZVvDohz4o+yedowhgMaYyP2AXng1/K8FBD/9oSIa6cLRkgC/6iatqo0+Hw3cv8LIs64AXcWLaeAKd3h+CAJtIV08vPirbxlO8PGkVc1VZI6GavEtm+MpxsTtD5KdLeOwnVkCkUPMR3FTXXzYmjhvQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npRQkysC; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7849c889ac8so46968907b3.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761309303; x=1761914103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOKA294v7CeX/A+J1mMywUsys/UgcKQ0Ty4x3NHcSC0=;
        b=npRQkysCbkHsAlCKkE6Mm3jWWfXIY/8CblF42wIwsxI0gq/1eiz3vrCxBjutixa09H
         2PFEjDMhHcbWz/C8GeNCMnqjLsTK3vhIf6HYlFPKHTv09h/OVyltVjHaIOHrVs8m9kxn
         JUX14bRN/B8KFYGyIS6DhneSdyt4tgNoP3IU8ma0FtkOcLqoVRElwqK3YLvAH3LOJd3i
         HfME8mRB7wlARrDFojxIjDDIqDTDi/u9HH77xe+GSLn6hvxetFLarXagq1rXWqJ0Ux8z
         xBt2UNlEQE4VW7dyeSPwiLnfiC9drkJsahkyq/rpWXwTEyove8RuoBGzhIoh4aUKFDSB
         y60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309303; x=1761914103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOKA294v7CeX/A+J1mMywUsys/UgcKQ0Ty4x3NHcSC0=;
        b=eXFPYHz9KWx2541MS9yOYmbOapzqMx3P0iXeD+xeHiOLpCYFU3Ndb58nrbZNWLmR/h
         lKqHSGPXrcb097c0FlJyDj4FvGAzm3HuXE/6oEZKSU12LLAUP2xNwoRUfFE7tS0qVjFS
         LEE22LuR+uhYfP8FHbktwumDu+NgJQ8e6q+LSirNSJ/3Sq9qXqin1noDQrJeHoczq9YD
         tBiFLLUt9a77PFjhlO68wN5PYiOWoMTVl00O85ew4EBjbzULwB7z6LrUhzTf2MHAM2t3
         aYPmtZ08+So1rvbrRy2KPX/qToYx/G2zxzZbhxkSZiFZ2Eh6IBYqmWlUQc7893GCl6PJ
         NomQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/PRnayocOqhrm0iTM31pTvORvYZw7+AvaHPyO71ziuoTdnktWO+jkRjXV47QdJCPYzrGbwj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVM4AC6hNOiQW2Ru+ohX8cPtawxvqkPOtxzxMN0kfcEV5zBLsX
	vd4lpojF2+vmqMH8deLsu1RvwtMcXlM+3y0+FcHYgkJAzPTmg8lkSLtsN05NoeY5bZlmkmMwAAn
	y9s+zLmSp5OCgdMxloRNrxrikbzmkudeGM4nCG7MP
X-Gm-Gg: ASbGncsRnhpDCIJZ/fpYAcC/1wnwNsxZs3hidUjsm/ZYU5sc5LPgieReCjFbiNFmRau
	9cjddKnXa14hs3TTGALTmJH80XzlvpuaxIpYjTC4AMk+ybNgORtJ7fLW/nTDgjgmNpHVT2UQ6zi
	+Lgl6TxCrqBK1J0U4KYt08mzWQU2DRMmQ+PcvUTR3LIAu+ZixHi/FIVtCdu7l3zzwB56zPYE0Ss
	FOSol37d73JhqtkvC793Nay6qmOijZyVUFaBUnh08LC8K12/f4EZz5VPHA=
X-Google-Smtp-Source: AGHT+IH8C4YbTawHwwSTw4y0FI4bBSIBGUU6IUMi7NiybaxKub1FqXvKz59K5J4eUdqAcKETSmY5ufdBhLEgVb4BcIQ=
X-Received: by 2002:a05:690e:4092:b0:63e:29af:bd23 with SMTP id
 956f58d0204a3-63f42b10bbamr1785725d50.4.1761309303162; Fri, 24 Oct 2025
 05:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com> <20251022054004.2514876-4-kuniyu@google.com>
In-Reply-To: <20251022054004.2514876-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 05:34:51 -0700
X-Gm-Features: AS18NWD21cDDAHd1KuaBTL4WS5Zy6aIoBAaGX6nY4P0o00Ije-nLYquyuCTp_ZM
Message-ID: <CANn89i+nC-+NpenTPjGUZ0fA-TsNyWUK35PF70fHNBf4BrdPDA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/5] neighbour: Convert RTM_GETNEIGHTBL to RCU.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 10:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> neightbl_dump_info() calls these functions for each neigh_tables[]
> entry:
>
>   1. neightbl_fill_info() for tbl->parms
>   2. neightbl_fill_param_info() for tbl->parms_list (except tbl->parms)
>
> Both functions rely on the table lock (read_lock_bh(&tbl->lock))
> and RTNL is not needed.
>
> Let's fetch the table under RCU and convert RTM_GETNEIGHTBL to RCU.
>
> Note that the first entry of tbl->parms_list is tbl->parms.list and
> embedded in neigh_table, so list_next_entry() is safe.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

