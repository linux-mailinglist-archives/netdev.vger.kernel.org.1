Return-Path: <netdev+bounces-176385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D690A6A00C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5D34624E7
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E9016F841;
	Thu, 20 Mar 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMEJraS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65227819
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454051; cv=none; b=k62fceNd6sfLr7Wb72jqrTnGKHWJjw+Gi++JZ/QmJf1bWJbAkvkOeObBmRoWbNrWS2eHAia2JRtLTah6G9bko7Fyxiun7IGGGLJVhDEEKC6TRMBIz3CHT6PIcd767lj6zA1CBiL93gzMdFVEa2NKPqhsLMeVt/j54TuBonDUmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454051; c=relaxed/simple;
	bh=8v4VZnLyl3+dyYNF7e8jakagvSXtI9RKvGesLqR5o+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0DfXdelf1cFryIgmcgzbPcM/hwOhYxXWsp3zAb5mMvcVD+hF2kYVSyB1vZeqH0TinIqYi5+E0q+K90zZXO3fxI/GGA/mrEoR3h8P+UtrCCgn/s+ibCcW0N4dXLr4sS2jPs/f54FE80zE1pi8tdRwGnbd7iDEf98cEyxqZgfm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMEJraS7; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476b89782c3so5629741cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742454049; x=1743058849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v4VZnLyl3+dyYNF7e8jakagvSXtI9RKvGesLqR5o+U=;
        b=vMEJraS7VK1v3mqPIXnMKmDHqU3yZG377SlUKGCOG+u/5wzK0Tyd69nrYmuZ/SY8N2
         HKZI0qtF/N9Auswu5n3XlFczwq1Lg9T1fiYCk6b+mUWiGcHl+T7KjhPSL3xlPD+PNiOn
         qiqfhAgF65SjMpyCKSPpuS5/QZmf3ft1FbtSnkP+Mj2RJ7TCPYHzTDlvvn4vONYpOnIl
         z27jzz2FzFcZk2uF2kfhE29F9mwnoSSaD8jU1NBAEGVEbntxdfkazztpS0tmy2hnpQVg
         wz518zYTpmiaVEsACd2fJkRSp/Qc0cBNrHO2FxIbkbLT3QPhcdPn+oxByh+mGcMX/lW1
         dVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742454049; x=1743058849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v4VZnLyl3+dyYNF7e8jakagvSXtI9RKvGesLqR5o+U=;
        b=oeWarE3Ew8M6fVSKSIlzeTIb8l+vxiEyJfkO2p6jyBvnEt1tZPnSpTlFTS92gE4o72
         ZPpL/LhxIgMSlwjXONniv+Ym8EBPuz7aFoxQUIj4mGbD2AHsC3/cjLrpJBPhVrvTiUoH
         Fo4YGp9BImKnYrJG+wp76xftowlFqTBcdIXS7IIhoi/a7Q4FHr4AmLogXxggJ/BTag8P
         IEdDA+GjgedENGuqgllZMlp8Cr+RjWlEAfQcaMn7SIAs6ShjYKV/au8nwVEYygTwKfWO
         afXt8d7dtTQPq2Z90o8w2NaVtc6KbvweVw81UWf0Jf+iqNLsbfM3XA3cNaOeMVzHgj7E
         tPkg==
X-Forwarded-Encrypted: i=1; AJvYcCXQKi8sbz+U1AS0XS2niqdAov5MZv0cGHjRUNgOS/6fze9XzaeSuPD067Hd7YtCMoUpF/9biDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jj2I7ruPu0sP2lpDe66tmybplxlFAVo7n79ly1FZcr+X/bFe
	C2hHkUQHHPfMRWE1ZsJO+j/WwR094lbxlUBtwT0tU0NYmzFzVko/sqtFdmJJDGTGEObWyRxxkwd
	+2zEehfistm19Y5KHi/0DCSGGMTkmlQRQYTuv
X-Gm-Gg: ASbGnctbvxk9uret/PgQ/fOb2IbC1GkCjWbn1/QfS5lZMHt/ecvteqXlkwshmEq+SPv
	/Qz+qjSJrq95ziV1pZncXf/20p8Z2fyrSZ/oQt8/fCbWM7XeuvCM5DUE/YY0XbYPN9mgUjQXn6p
	5JNc7ooO0WhKR6PcL+I2XXIqYx
X-Google-Smtp-Source: AGHT+IHcJMJVo8YDzVput7IMo+7I0nw/PKxf4vhV6/l73w3i5sRd6nrg3ckxIUDzfCAG0ChaxfouMoaX3KrprZbl9eU=
X-Received: by 2002:a05:622a:1bab:b0:476:6ddb:1a25 with SMTP id
 d75a77b69052e-47708307153mr87161671cf.26.1742454048994; Thu, 20 Mar 2025
 00:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230743.65267-1-kuniyu@amazon.com> <20250319230743.65267-2-kuniyu@amazon.com>
In-Reply-To: <20250319230743.65267-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Mar 2025 08:00:37 +0100
X-Gm-Features: AQ5f1JrdgK9IKlKPv569Vb8SszWPk1O9itEnD7iOK0Dj-fux-U-88ePunB0FRPI
Message-ID: <CANn89iKEHLQaTqVJc6p2q0-Y7wFSUbX=E3R584ADNH6vV7OhyA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/7] nexthop: Move nlmsg_parse() in
 rtm_to_nh_config() to rtm_new_nexthop().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:08=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will split rtm_to_nh_config() into non-RTNL and RTNL parts,
> and then the latter also needs tb.
>
> As a prep, let's move nlmsg_parse() to rtm_new_nexthop().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

