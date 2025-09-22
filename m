Return-Path: <netdev+bounces-225420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF1B93950
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7309717FCA7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2E25784A;
	Mon, 22 Sep 2025 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/A2AmyH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19615A86D
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584006; cv=none; b=emo2n5U+NWou9K+VqSUnXhAfQie0QqHSglIuS0r5JozKU6T5btxWdWlRMQY2hJdrckmX+QQ5dCU4fZcnVrHE7o8qv2m4YorftJnMfXwmlH8S5Xb/zNsiZaVsalVoDcfbjz71aLhIN9Rba+I2w3eZkPBph/QvChZudrbWQFrsU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584006; c=relaxed/simple;
	bh=rehPoiZlG+iTYO8iT3wC0jVWuE2HD+3tGzNf/q9oWyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1dTY8nCxAFrLIDbcxqsaKfBukIFPcHtI4QM6ynydXA7LJhRsBa5CjNOQZEUor0xSWUVWslkzSaxJ+FvNBrPM/GpIqRc/kRW3uDuWfb7EuSs9CBa//vpOZu4wdZ00THFumWJSegod/8Gpq6Fhg2iQiz7LMGNtMZS0BYpW6hm7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/A2AmyH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33082aed31dso4060104a91.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758584004; x=1759188804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rehPoiZlG+iTYO8iT3wC0jVWuE2HD+3tGzNf/q9oWyo=;
        b=H/A2AmyHMVh2+iSCaZk5w0EB+hga8kvt5dButl7spMV9Wjy+jWA2H1NgyoCkOjzd9Q
         oaiaA0shaVwzA84/dPyDdOSLu8LYPyCLeFYMQangWIFjMwNzkuPalweHutaBD0EFgT8G
         OQlauVzsjS+lONO7MUV0X0GRAkW32UBrRwsrtgV+r0yOHquQ5Gbbb2yacmFrcH9UnR9Y
         HzBvNlKM1dTmywbzbVNU0+L4VKoC723GxDMTUDEocSvejaFIuIq02WEiNdzUjsZzM3E3
         e02VSgbVbRc9xbqNYGvJO7Ws+V873nKn/emJAJXQJK8zUjTGuucgpiozhixeacAXVsbr
         AU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584004; x=1759188804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rehPoiZlG+iTYO8iT3wC0jVWuE2HD+3tGzNf/q9oWyo=;
        b=X6u+gidQpnquv90UPxgrluZoW8DCJfr4SIT+RhOvT0FQgf3+jc6C0oM3zUv4Oydimz
         mW/iisdvou5NFRBXrBYNeW/tEuV0I45VQMvPW2PpSSLMD2LLLoVGvbMH9ZQsAm/20y+7
         q/oAYOC3aAgXZ4pFXaC+uEUjwfAsDpx5QoQdGuTnwdzYWbpvDYGUEGrlCvQwwhXtl/4y
         oLntwNHcouX8IdT/4cU2zDwyYJQleWO8gEnU7jc750c48Uw8Kfqc1U1duV5L4FsJpdaw
         oMKeD6tsp7pA7T+kiiZMyIx0UHBaqdppIh2GUAzqYviKHqGKzGDuFiiuQIZxz8TJsNyO
         VSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvvCP6mqR8/EwNMjqAxC9EsqKqkx6kxnAmwuktT4OzxQQtaHsPWgoWPt51U9NUJx+BnMQK5EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2gxqmmNon6p4ZN3oMs/v8iKw61jiwuPpo36a1PC/urN2QXLQ
	uoCvZZYMUgZdvOfFvHxcHxszUXPsYLfras/DpdQGz0nv5fYkyrtc5FJNWTT2bMSCBcYwQWhOnq3
	few5wLFaTFdUR1aXBr0TNdIn6WUT+/rlFcp89UCIF
X-Gm-Gg: ASbGncuoFJ6DtjosL6nfNJvpXiumAsM5Q6cZ9/0bn6wvWMzQ9Rt/469ydn2hU8+kV6y
	7qiFaDKyy7lmFZC3nhjLH6ndVbJ84KwnFZ5GxfigQy4YXRkV3cjm/LwtBBxGfMkrR8fTMWfcPCE
	km91ais2o6VBSzbtSQmXlN+2q0xCVgEDcxHhFeL7gW9//ZBUdlUfDJjW+Vbyrpvusr2aTHfJDSK
	OEkSyUJyLQuWBmUWvfJRAGwmSm47n7gJtJRUQ==
X-Google-Smtp-Source: AGHT+IEmpZQWtz4AbOFit3qZyS8Anlad24lgpBoLrHfa+QJd6ReOwuCSYqhWRJXHC6jSbQHy2WKXHcSQoY1D2aOnwaQ=
X-Received: by 2002:a17:90a:d446:b0:32b:d79e:58a6 with SMTP id
 98e67ed59e1d1-332a990adb5mr631608a91.25.1758584004117; Mon, 22 Sep 2025
 16:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com> <20250919204856.2977245-2-edumazet@google.com>
In-Reply-To: <20250919204856.2977245-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 16:33:12 -0700
X-Gm-Features: AS18NWAXz5eIDngm8OqPVqZ54uzmOWtFNS6bvaRiJ_G1KB6NumqFXfuWCCT6XZs
Message-ID: <CAAVpQUDzWcggVdMNESrU8FXm=n6VZqei7CX24JtadQi7Rffk7g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/8] net: move sk_uid and sk_protocol to sock_read_tx
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> sk_uid and sk_protocol are read from inet6_csk_route_socket()
> for each TCP transmit.
>
> Also read from udpv6_sendmsg(), udp_sendmsg() and others.
>
> Move them to sock_read_tx for better cache locality.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

