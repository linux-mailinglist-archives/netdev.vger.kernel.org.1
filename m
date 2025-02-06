Return-Path: <netdev+bounces-163476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2F3A2A5C4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29BC7A1AFF
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05A322686E;
	Thu,  6 Feb 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGMRVZoi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C07022686A
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738837576; cv=none; b=LOJAzhHPPnkmR50SGM0hQwI+lHPAt9sZEGbqBAHScrIqqWXtPksZdxH3W/DMoEgyWneKeV7HvHC9ADetYNLGIelujKsAQtJ++5DNI0PAOwy3VcyqizJn45fX793Yoe+D5hYYyNMzQ/inXHgTzL+gF7891CHQtnUGPWpgzKyzjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738837576; c=relaxed/simple;
	bh=Pf2se8yEan/1gp2hFEqHDKCSn4B3Ks8rDhLvWs4KA0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrDeFGRESLY93kuJMolxWHk7N2Z+MvWnvNGhs/WyIxdnmLJg6wleEEvdsdQa3ju7FzS4pWIWsaHG7ScygvqHv2xA/1sZ+czTWCI7om6JZXnDa9u+hNsckx/E0a0XZEfCfqPjP3m+03iAo4tVt/eteWBzvNkUCIaIFHIcXG2BrE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGMRVZoi; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d03ac846a7so2333085ab.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 02:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738837574; x=1739442374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf2se8yEan/1gp2hFEqHDKCSn4B3Ks8rDhLvWs4KA0k=;
        b=XGMRVZoiIi4Lu4jmq8oPztgMlmDRcsQK2hsLTMQd6NwTRHrpAnNEfoMVZM95X5Rcen
         gqAFkHWQ7HTc++T4vDdZ6kKm+7S5wSa6HdkH9V0C9AydVKGbvYvoDIn9Ze4Pf65RRo+1
         rG0HF3e8qyYfQ7ZXtJkkxVTNqSeI408VAGeQscZ46Ku63hZ88mTxchFNrAVbH/xiZwk6
         6thxEOVqixWEv3iamnha2WaaA/zshwxb1HDELJot8VGwOJwsuu+h/qDaaD7WCrat7tkd
         jXBT2kuGHbpdMenU99sy0qa261bgejpmq0b2EzGKnvGXeyHI2o55a1K28fEmAubOd9R0
         JJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738837574; x=1739442374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf2se8yEan/1gp2hFEqHDKCSn4B3Ks8rDhLvWs4KA0k=;
        b=gQLGCIuZYEpEUqNG3jMlWOLYFr0ZhvqBRa+ZHhciaFqjNy3KDGwBeO682LOxFCHHv0
         6g9/1aZCblJ0W76X92tdows28TKY+A63VxeoC4B05QRoc6LPYuLgCQCG6CS9/0cXW/gv
         oDvBzorLg9ToYQAZMYviTal8YzCpXHXmkJ+1YfGun06bxK3LHxR9Ea2X20oJ5pw/YNRD
         +G9jC0ae1V0yexrGiQ3XFA9HRFdsKSCtADeXmR9ku2QfBNZGgQj6JhcVh3Tz5yFUzoxa
         K9ELLGCnOz7esdDA8lZVQ8DqMPuXUkUuwtPjcEHKzBjBlEEF4bJigDqUD4dn1A2wizbg
         8YiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdvKxKca1APsCGxSzxRMUpqIwTWawLXFONnCbkHsCu0r7MXAaVngFaotkmXBd+WTfLTJZKsp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoMCF88xyLW1UTaVDbyjsd+/4I3QZ7PwPlCYSmFr2MmXOM0DSA
	e4JEsKdbO57BLGztsYv8ab6LsqfZnGVsdtriuOy0aj1jOJi+mP8by1mpWR5RFdvZ1RB5+Mqmdgd
	r0541aQqPpiSxn7wWH/Q3TmTgMBQ=
X-Gm-Gg: ASbGnctwM8eOaCWh693EgYj63XAlkPzClpCA7BQ+dNg3imi3KhgFATGsxYb5Y6XkKpY
	0REYBQjUQBQ4wCIsoT9YEVVBDBSrKOdKlCNMBfriBvdVraJ/dL1jBsttC+jH+RhyQ7/a/7ATg
X-Google-Smtp-Source: AGHT+IEVCOdta2ugzbj6qcXOHYJfY2VSsBEcYVBA5FIX4t6+5XC2lmPdNW/nZOjyC5r0jwh65z8Lt6sSuMLjbMrgygw=
X-Received: by 2002:a05:6e02:2688:b0:3d0:2b88:116c with SMTP id
 e9e14a558f8ab-3d04f45aff3mr55030015ab.10.1738837574364; Thu, 06 Feb 2025
 02:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206094605.2694118-1-edumazet@google.com>
In-Reply-To: <20250206094605.2694118-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 18:25:37 +0800
X-Gm-Features: AWEUYZlDP-SxNEyJo7gNUFC-WOzibgjTBQVLm5wZjUt6P1qfzXxHXmpB6i4T7tA
Message-ID: <CAL+tcoAHcK8bRJFRZN-U6AxyUZY88oLESUEW98uzsTDdg0apkQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: rename inet_csk_{delete|reset}_keepalive_timer()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 5:46=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> inet_csk_delete_keepalive_timer() and inet_csk_reset_keepalive_timer()
> are only used from core TCP, there is no need to export them.
>
> Replace their prefix by tcp.
>
> Move them to net/ipv4/tcp_timer.c and make tcp_delete_keepalive_timer()
> static.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

