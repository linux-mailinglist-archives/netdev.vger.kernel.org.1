Return-Path: <netdev+bounces-176391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE45A6A03D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FD946442D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1F21EC00D;
	Thu, 20 Mar 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gwzWLa9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090E1EE01A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454786; cv=none; b=Nd87yCYCetGjqF5boJ+KbweqUw9tLeMxeFStK/8Ec+HgvI37Wu0pg2AmprCkA+XmrAHLtiUnEoUuyPBVubc2mQkcHkBSyiiCeYJJnszLGYfFjHuTEQxUM6lYVj02bZsWZ5TCVg0wMe44KCc5PAACHFZaLUE/AIWS98G6DqN6Gw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454786; c=relaxed/simple;
	bh=GxEvHcu3T8Ssa8QJ1BUwPIlWomAxJwa3czX8v0IqZi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZZjmiPOKZQfCiHKOByKKtXyFNV7eBpqxdAJxs7x2i5YtcjtJr/oCjmaTtY5aNifw8YRAn9w5ZFHNfRxpEO2kn5xHbTTwbDBSMREz/G2L5fvgtrAkwpgY8n8aQ5F3UhdcQh0nVeGjcOLE+j/lIIlACeTcmnKD+W7tEbSwfI9Yzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gwzWLa9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c597760323so44424585a.3
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742454784; x=1743059584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxEvHcu3T8Ssa8QJ1BUwPIlWomAxJwa3czX8v0IqZi0=;
        b=2gwzWLa91N0wBU6KoKW7N+S4snp0uP1kTm0EUJcqtdkeQcDgbMW8wEpV73/Jajqt2w
         hgOxC2UsxFLSNpBnQxjFeze7CqIfzRLMtCeKd9+OnSqcJeyyNzVg35KKEFVdh6ulm36b
         TIWGzJW4e77a3m4eywzCylN37/Gf82bcqVvK7Dxm2EpyxDhuS90pAJUypfaJQ5tuiSMa
         J/ONq2fzf5jCvSFgnoCZFzc5VTTiybyUl52euvWQ9pbVbHM2PaCzHHemwkG22FxsZzBr
         WsJ4AAZT0rgI4x+SYzyUfhzeXlReeUhjyg2lGzlN4KY28q/AJM6zobqbDaViRAQH6p4Q
         ENLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742454784; x=1743059584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxEvHcu3T8Ssa8QJ1BUwPIlWomAxJwa3czX8v0IqZi0=;
        b=ikMAffDpBdk9WC3/En/p9CGr81sf7zrgEwi3b4BYE69uNOTRaDwe/gxJz5tCp87LtW
         1MbJ5ro12WAMrUALe4IZxCZjw2Lu3pw02fMAbu0akryVTgXWGPsrc4wr2v67aFyhQP7g
         zsCXNNyB3xBV4WDPbZApVPZVqBSt+YaOj4XlrF5liALsav/s50GStZgkdB4cSbusVakL
         EDzUteHqZ4dQOl5W9AhmslRlTHNJzhYPqWC0VdpGo7idYAikQC4KuziqkE2cvifesHWK
         XdmzeEkM2CcFm2vJIHlBQlpv9RNZge0BazDWwv0D8KF16NP900OHugK0dMDQfG95JQU4
         pSwA==
X-Forwarded-Encrypted: i=1; AJvYcCUQPQ7FVDNlligF4BJ6jn/80lFwQ+uO6QRZz7znbeEb/jo8++Mz9AStlt9DA6POSXqabaA0kBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jSlebQCdW6UbZ+C5G4Yj0nWL/OsqNi7MeQn9QkZV0HPKMjsD
	0KI5+fKHOxug0Z+lHJzD/FPpt3j8I38puGcctUz9K2NTlcGqqvnaTpB5FswCu3Mr7w1MZrU3guk
	i9FZn2bTMX974lHwOo3m/Nqh2Ak7R8lf+WgoY
X-Gm-Gg: ASbGncukIDXQpOoCKtjm+Y4XHSoCL2TslEgADzpiF2vd0y2bWJvCXoEF6Kf36N9ymuk
	ugdGIPrU5+fnjzgkCKexBaDDdfTU5CxLEmTzUjGbLL4AfT5F7JCgqzr71h6tclEiJa8ABLoS82e
	uY7zZ+9/jIIdEDOPwPk6FFl31U61pIwkqYAa8=
X-Google-Smtp-Source: AGHT+IGYW7EjSo6DPSpXEPx0qQOhqoO15O54Cw9+WTlfnOQO6h9pmIzz8HpMNGfuOQzI0GCoCL0VfzB2b32hSDjqAmc=
X-Received: by 2002:a05:620a:3915:b0:7c5:4be5:b0b9 with SMTP id
 af79cd13be357-7c5a83d100bmr730637685a.28.1742454783611; Thu, 20 Mar 2025
 00:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230743.65267-1-kuniyu@amazon.com> <20250319230743.65267-8-kuniyu@amazon.com>
In-Reply-To: <20250319230743.65267-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Mar 2025 08:12:52 +0100
X-Gm-Features: AQ5f1Jp1uvkLDXxmpo9Z3LAL4UP_DOqT_1FjICyGN0f1b68UymJX_UEeUqXYPUs
Message-ID: <CANn89i+ERKCKkkA_=-t_MekgUUmzXyEMe9hmss=Q9RgAMxit+g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 7/7] nexthop: Convert RTM_DELNEXTHOP to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:11=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> In rtm_del_nexthop(), only nexthop_find_by_id() and remove_nexthop()
> require RTNL as they touch net->nexthop.rb_root.
>
> Let's move RTNL down as rtnl_net_lock() before nexthop_find_by_id().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

