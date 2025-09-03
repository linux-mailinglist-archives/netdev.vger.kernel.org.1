Return-Path: <netdev+bounces-219607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C128AB42481
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F421BA3EF6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FE3128B1;
	Wed,  3 Sep 2025 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ytd5FpMz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCA3126D1
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912184; cv=none; b=gn1wRGyh7J66eTiAq+O/8JRbFCvMDWR500mYl+rBoPT7xbzGCDVDQLp1/egHKD9msAcbMgzdLpGDc+n9I3s/9uvdsaWoDL6Nel+uSwSAMdYWVGkWK/pEyyJWNa34yi/CzT4xt/nBKZbfNQfKbV0yJtFmhPzb+7jGX6dIyU/nCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912184; c=relaxed/simple;
	bh=ty69+cYt6+Cd3H3aY+qNXs1+uRlJVUgwGOYALwSxmxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4ToHIExFLGT/2kCl6Sc14fq6PSnV8jroAx+GQJCM2SPWszyBpcDIoV5aqeYRmIFL2zsew5yjY5WvrHA50frl87UUDm65LaQrv+ZqORO29GWJZvXKg2uSozbg1YeNcpzWXbQOWJnOQ4B6l5W62D0T8BRmjIuARxzrqlzbcN01Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ytd5FpMz; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b4bcb9638aso175591cf.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756912182; x=1757516982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty69+cYt6+Cd3H3aY+qNXs1+uRlJVUgwGOYALwSxmxk=;
        b=Ytd5FpMzD2Ux0FrGw7nkygy7HqSGHO2s7Y8ZU7u+D3fhLRL+Qk4FrwTkfSzwN/xtu0
         nrHYAGCvhKVVk0mD53VGumEBfvLY2xb4WOb7xlyBnpnLMvjiRuoUzUBHiCZxErzsE+SN
         bBXQl2fmMTdtN0pRW9dY/P5/7iNun1iq4kbfj9zLX9V1eIlS7B0XvlaZjf2uzRwFLok9
         pvY+Dn1hZGZb+dSccG1N8LBf4OG8H6YjlrB6NFA7l/t2MP5HcEmlU5dsj8migcdIIpX0
         gkdMXez2DTUOrwqll383DkmrCMiziA25Y5G5uBEeUHTBjikdAHmeWBujD3SuNxc1rZt+
         s8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912182; x=1757516982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty69+cYt6+Cd3H3aY+qNXs1+uRlJVUgwGOYALwSxmxk=;
        b=wSIGBc+9vdZUF49PalDDVaVIruO4L7HdNSguedA2/1QlyqbI4tIcKyKOYCs6RCBbTj
         tOefQpV+xMT5kC/MYZK7DVP9ROhCu9CcQ8Q1fEbur4MveeSuO0c6mBxQa34rZxOgeTUH
         BY9BJ/e3TSqOxEaXr9z4qxsM7UVYzSPX/cZ9Ps4dr9xdk1zLXtquv8bm6P4JkMltYlfG
         kFEYee1vdkQf5VZ+PhiEfjOC/qZstFOi7A4SqkI8GQCydf3WgB0jZpGAuknAhPFOIf4r
         yBNnOBsTEkyrYJTAx3028+JQ0kAq3kD6wUqFnRlkgAp3sop8ImpFlpuelNRaHB3sKqKX
         uzFA==
X-Forwarded-Encrypted: i=1; AJvYcCUzySMz7itFSsMHfJ0srQwkH2oMeyLT7hZzQMoGpjl7lGBQH9DRoBbBiaiGwYW3uepcCsZlJKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYyiHrLmVX6jyRHKc5T3IqvnWXTXp0154YSDL5EySo7jZ6WKVR
	eZ5tWGPIZ4oHazzn4ExoqW8h3TPqvFqC2wX6PwQggj2tlYhIB0kPFi2F/gTTTg9o+r40f+/cdJ1
	5iK6C6//ipGxoyaBSYdQC7hhYLQb6TMtDbl1j327g
X-Gm-Gg: ASbGnctGYyDJMec2CpXWqJJlbY+IzaWLIP6BXoHAs3PtW179ytaz89wLiKQ6WUjG+jq
	/ciW6a6SVmg7zqvOt1TrGVOTFEPXpCT45GAklyQPjIKzI2cYBv5wuOVHBnPCbaMf5WCEWsMvlzR
	FJfaAd2rMQI1Ugv0wU3+i9BP8fyo1SJlBx3qYoqdzk4H2Qs+hN3a1ktqaOouuP9lY4+t/1kumpc
	3mG4CL9UoP9K2FSvI6VPK9QIeD5Mk3rpXNeNgMoLPiJbg==
X-Google-Smtp-Source: AGHT+IF0IzXjfLZU0/gH24wq8Su0YPGauzjMvLoZrPXOmzg6pP2vXUHQxRx91AP8JsYBs/4foYLy0wQZIx1Mv69Yw48=
X-Received: by 2002:a05:622a:254:b0:4b3:fa:1832 with SMTP id
 d75a77b69052e-4b48dc200d0mr6178141cf.14.1756912181630; Wed, 03 Sep 2025
 08:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-4-edumazet@google.com>
In-Reply-To: <20250903084720.1168904-4-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 3 Sep 2025 11:09:25 -0400
X-Gm-Features: Ac12FXw4E9_zkZTEM2ftsdEWFH-V1Q8brZfx0yW6xQQzEa6SzcARkEzYtsmkcBg
Message-ID: <CADVnQymopx3uxsn1vCts0mDKEOZWT9==X2VE-oC3rzg_AEdFAA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: use tcp_eat_recv_skb in __tcp_close()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:47=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Small change to use tcp_eat_recv_skb() instead
> of __kfree_skb(). This can help if an application
> under attack has to close many sockets with unread data.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

