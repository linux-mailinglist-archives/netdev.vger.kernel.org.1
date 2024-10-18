Return-Path: <netdev+bounces-137016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5EF9A407C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768151C20F2D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4860201008;
	Fri, 18 Oct 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXddXQky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BA1D9686
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259594; cv=none; b=m+CTZu3JjMFbSDaDYmS/avgQHrz6k7O/r7r9bTAK2C8LZJ0K/swx+1HTAMzJMeso+Hm3+DTuDuhwfOLV/GbQdS8MC2TgaKZs7TNsRZMg0oyr87cl4akuC1pcO6uLhPZlo28DaDQuTdPr1d3f2F1JBgsj8kVd9x3KHnNd3x4ZJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259594; c=relaxed/simple;
	bh=rkHsAzxCSGsuQrWfNYzUejdZeKn4gjuMJ4tWK0qWRWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpsmDxzIWo3sXYuk5wSa3mQoTMTghIVQp2X+c4eVIvHv6CXEYuEmMeMR0YXOwLUv6RgpiSozClWZhirEhVqrOJ6xa2mZ5rGYKAWNnCg/L9G2AI0LwUZoEYfeFxATTAp37tAAslUh4xRb6AmOuqyI3ygxVJ4+8IXJdwdbLCt+lvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXddXQky; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c973697b52so2604163a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259591; x=1729864391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkHsAzxCSGsuQrWfNYzUejdZeKn4gjuMJ4tWK0qWRWk=;
        b=mXddXQkyrtWPVn6gHnW8WQmAaVuhMQGlcFw0s7w0vI08y87h5WtcrGFSGklTToawgp
         SJp8Wun9EazMkZ2bhg48GnweD62/QO1TsRRQF4gJ1ieO5oDNQB5f2ygFNe/Q8F8XPG1k
         n6Vn6UkZ+4J9pNDypQDxUx6JS2bZD6j1rI4tKG1yJz3nk3TE5traJLxPOhHplnSsCDXd
         RQLTqpDQzMAmgE+sFZQVICT1mE7eDo50fevet/47x5JS4KC7iFr404rLv5eklYZgn69f
         x11eAfYkZmMnjMI0VqvOAOwdmMIcQa/H1z8mxkEcxDzHBUpbnqt3UdGYX/CJMnj9PiNA
         x/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259591; x=1729864391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkHsAzxCSGsuQrWfNYzUejdZeKn4gjuMJ4tWK0qWRWk=;
        b=o3vwInC8o+Kys7fm2eaJOvxcwDSBT0Gbk5Mq7YfAx9ANVvwSDag5cAuVyI+LhWZWj2
         wecBzOtxNeNSxu6YMbFVz7tTGqcuY5TZNeak4afLrFo1infBJYDi/KlNbPpNqUxn0LeL
         0jGu0hElxATJDlhrlbo9LF0Op6nvjdEevk9kijBArxMl+WK2vSCWc1KQqhmDHwYZmczK
         Lt4RwI9zhasCvbo97u4KJ+uiz33WvdpxMJ1yTw67rCNihCufwXDDFRYUyiXCzFjXVE0c
         rkHOcEtNHSlDF6gR5BNRAuyGSZtqih5cC16h8VgglcydwUJKBXUtK11sA98/IFJbLWft
         0Juw==
X-Forwarded-Encrypted: i=1; AJvYcCW+NFbld3N6DJ55o2mRLbL9XrK+epLTGwc4kNG17YnIlEDwE57rVetW5GyX2vZrdDYh1lnrXhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxusc14jyLa5D3wyItzpKhLgcU3VY7JghERQf5SpgNmS95T9MF7
	gHkvBdpx85Xzyt1f1SvPek9U3OmLRG6L+wS/6r//JITq+FUlGlS0h5S3Q1gqtn+i/ruBsRP1FzF
	MKACjCg+tNlXGbuCcRsPfYPg1jfuCQNFMxYhW
X-Google-Smtp-Source: AGHT+IGzLogfvU7/Chwp2kdk7P/jr0qWtP0S4WEploWrTAWTtQjHjfLxm6ytVdITofLDQyc5J2zFHCM2rXuyHIzjlkg=
X-Received: by 2002:a05:6402:2743:b0:5c9:6222:cdc2 with SMTP id
 4fb4d7f45d1cf-5ca0af7d21fmr2051550a12.32.1729259590623; Fri, 18 Oct 2024
 06:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-6-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:52:59 +0200
Message-ID: <CANn89iLq5nrh9FQoGO_Dwi6ThS0UELEGpgRVuexV9gRF8HU+jg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 05/11] ipv4: Use per-netns RTNL helpers in inet_rtm_newaddr().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> inet_rtm_to_ifa() and find_matching_ifa() are called
> under rtnl_net_lock().
>
> __in_dev_get_rtnl() and in_dev_for_each_ifa_rtnl() there
> can use per-netns RTNL helpers.
>
> Let's define and use __in_dev_get_rtnl_net() and
> in_dev_for_each_ifa_rtnl_net().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

