Return-Path: <netdev+bounces-224155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19705B81507
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D5E526750
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682E32FE578;
	Wed, 17 Sep 2025 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u605KMUl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4327E076
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132733; cv=none; b=C8e2TFxyVKR9lZG/xDD/VCIwcAqZ32uW8H6dcq4r4itZC7FLtJmOn2g4OSNY41b/YjMwyn20e/EEk578uStqGXCmcXdeVSW3Ea34g5bQjQtOfk2SBnXABp9K8k2576A//8/E6TUXUcwajevD5K57i4VOWgOXkPHQ42SzciHWxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132733; c=relaxed/simple;
	bh=ZYekZDd7lx33i3G1PFfX3Znbnb9W/cKvL8bU2Uaq07o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJniED5cbFCmBBpykmd8FvAG9WJrxeagk+3psztr8Td1uvqppop8BBhruBkImNnTG+TJrj1cYj5papuczeFrdu6TGGE9Yt0mmaiIvFhUdvfc5pPdmI4lfcxj5PqR2PN44TTIYJUQt3pFgM1j9bBaKMuwpjY9Dl9c2xEySQhuaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u605KMUl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-251fc032d1fso1101065ad.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758132731; x=1758737531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUL+OC2nMGL0kAsbdJ8HzDApRRY/gzKOrq6ZxDtFTgw=;
        b=u605KMUl4v6RN4KOtF/OKGAC7LNBVziVL+FPFuWLfc5UsfasGjEdNVVnbQxZIvT5io
         fcYesGGkOYLrgtpf/gDaH8cQxOU0W3TigzZapfZE/avNtOwOyhVpk1LQtioizjzvDLpj
         98J8Dl6g32ce061tBhi/89fhKOf1E5ducbeqrA+KhupK+HSXhtJy9x3P0HETzyhwOmlc
         UWgSoSLhop99xBf4wkska6AUb0/ddHcpVGY20xZesI7ufT2+CM4kpG8FaZGIfe4jRt1d
         aN9wHpXTOuc+oFfS54jJWdLvH9LvPdMiuhTOBmxMffhlJ97Ul1Qg7cbJ3xR2KOT9zHaF
         u+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132731; x=1758737531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUL+OC2nMGL0kAsbdJ8HzDApRRY/gzKOrq6ZxDtFTgw=;
        b=s4iTdpO9slenes18p/BorkEwNO7gaMOTjs70ZQxlynUpmkUr4iab5dRYbnHV6khXir
         dXI6dLKGdwz1r+Y541BPHxe274Q+caAgmflh+DAt+GQMOP8qBVrmcPoVy6ArAe1f0/ju
         fYHY7BfSykhjPJaajuZrvzo0ATlnTKyQjOp6dCvd13GeGxwJpqrqICjyoaVpXYbJ8kQ+
         e/TzSr1JR5wpTvC5XfKaujMn6PDjD72/eQj4kASVjxni59vFwy2AXzIb0vtG08XyE/u0
         /RN1NSWNo1dQ8G+hOOzSur9k2SqUGXlj0EzxHaaoLjrsJxwBqfIKlLv3eyKHUMWbfpc7
         +KMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxaektt2sys1lhI3KokScN7+Ntm7yv3QKndwYGie+9kn5OXZ1SM3n7vuBKunqVpKjnfUq5Qvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRIY+zqCsT6VWUPezl9EEPa5fGITtM6Wq2+1FifltqqEsGgG+
	bLCslyJYLadls6KzuDueyDe/ca4KeMagfDvkHfTHtHvzvjUZTgZus+qKlQ0w1a2kzDkYjy88JTm
	N6+4BwZWzyIzCcj39TCLTh3rX+kKfeUcVd0TEpSco
X-Gm-Gg: ASbGncurvHnWrEYtluc7nYQcy0rwR//oMqf22wWMCcgnd/DStJZZZIrwYSdoYD5l0m5
	XCVDWmcYWuZWqlIET4K1naAJVZ9PFunUqBAoEInqd9lrFRGlSMx+CZs9KA72FvkYT5iZ2pqa67q
	mtPWregbSuwm/rVklkodUmEJ5HjDwPHRgfKxwIxnynr8UfsQ1oUJO8mbQ4dnGOpkngrdVIb3dP2
	UgsW+WME+cfd4cEOFPQWWpQbeVKoFkTvqOp5WoqJh1K3kRomDliTm4=
X-Google-Smtp-Source: AGHT+IHZwgyx2xPvMxMi1YFPiIA5T/9qo1K8uUt2tU8kO70Fhx1jdaLKlopboLqu//ZCK61lURawyinEpF8BuvDFlJY=
X-Received: by 2002:a17:902:ec83:b0:25f:d90:ed34 with SMTP id
 d9443c01a7336-268118b952fmr33526465ad.9.1758132730927; Wed, 17 Sep 2025
 11:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-8-edumazet@google.com>
In-Reply-To: <20250916160951.541279-8-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 11:11:59 -0700
X-Gm-Features: AS18NWCgIObnNet5tGTvzuJr_vFM0sXyLaHzi8XiMUQ-nfMeo_CzmODWVpxnu98
Message-ID: <CAAVpQUC=rHiK+u5rw0Tiw68hp0WiNu7kk6MRkPq1=OvcTOFcYg@mail.gmail.com>
Subject: Re: [PATCH net-next 07/10] net: group sk_backlog and sk_receive_queue
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> UDP receivers suffer from sk_rmem_alloc updates,
> currently sharing a cache line with fields that
> need to be read-mostly (sock_read_rx group):
>
> 1) RFS enabled hosts read sk_napi_id
> from __udpv6_queue_rcv_skb().
>
> 2) sk->sk_rcvbuf is read from __udp_enqueue_schedule_skb()
>
> /* --- cacheline 3 boundary (192 bytes) --- */
> struct {
>     atomic_t           rmem_alloc;           /*  0xc0   0x4 */   // Oops
>     int                len;                  /*  0xc4   0x4 */
>     struct sk_buff *   head;                 /*  0xc8   0x8 */
>     struct sk_buff *   tail;                 /*  0xd0   0x8 */
> } sk_backlog;                                /*  0xc0  0x18 */
> __u8                       __cacheline_group_end__sock_write_rx[0]; /*  0=
xd8     0 */
> __u8                       __cacheline_group_begin__sock_read_rx[0]; /*  =
0xd8     0 */
> struct dst_entry *         sk_rx_dst;        /*  0xd8   0x8 */
> int                        sk_rx_dst_ifindex;/*  0xe0   0x4 */
> u32                        sk_rx_dst_cookie; /*  0xe4   0x4 */
> unsigned int               sk_ll_usec;       /*  0xe8   0x4 */
> unsigned int               sk_napi_id;       /*  0xec   0x4 */
> u16                        sk_busy_poll_budget;/*  0xf0   0x2 */
> u8                         sk_prefer_busy_poll;/*  0xf2   0x1 */
> u8                         sk_userlocks;     /*  0xf3   0x1 */
> int                        sk_rcvbuf;        /*  0xf4   0x4 */
> struct sk_filter *         sk_filter;        /*  0xf8   0x8 */
>
> Move sk_error (which is less often dirtied) there.
>
> Alternative would be to cache align sock_read_rx but
> this has more implications/risks.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

