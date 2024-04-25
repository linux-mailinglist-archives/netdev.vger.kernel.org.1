Return-Path: <netdev+bounces-91450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ABA8B29E8
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 22:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F0B1F21460
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD75A0EA;
	Thu, 25 Apr 2024 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYg6OFE3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E918EAB
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077286; cv=none; b=Q2xLd7kKsgMX9BCl321sxxFttiQI9fH8MPDcDrZyJwpebM/wEFL7+IA8Z4+/xD8eu2DZUVbuJ47kvonV/AQAbHisL//gch/cm6CKlFDd+IiEYs4fnA8UWGoCj83S+km1sivH2NjmwoC2m6beRxSpUTS5qig5IgbhzbmfkWOffxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077286; c=relaxed/simple;
	bh=V/6DRcfVBeYI/EV9EeadqQiL8ogpcOEiqAoK1MwLNCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If6r3xEWZaqntScbHjxIY8nroieLgjZpvPcB85pM+gQSD1h7cpYm2Yig/aifpg95piiyblw1cMenOF4hOFHPM9Dufk4lBIbdl0EbLfKdiN3wD8m6RpDHmWWD9uqEPuBknn/Jy6iZgrQ8erT9useg3UAN/DZyoW5nitVNuHcF70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cYg6OFE3; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7ef180ad3b5so492678241.1
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714077284; x=1714682084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/6DRcfVBeYI/EV9EeadqQiL8ogpcOEiqAoK1MwLNCo=;
        b=cYg6OFE3C3Cd/Tqspqyuyako6Vye5UZM0c34M70TP1dIK0RR5nn5AQlF3SkQlVWkOW
         VtcGCFXNRWrXQc0w7Bmi21UJr02iIBBTU+vGeW7aBYkheVyiM7gLRbpEvVkdRfCoPAxW
         eH5HnM3pGJbdIO+ZxR8ordCz2LUa43haCstDgJbm57intrV0KxCDQN+Eyo7lK2kHqL7O
         u2KAW2bnhaVEO4DBt7wtgT4PsVzMNCs/5XIHWtiouyIlsv3aBPNrHaIpAXyAEkr/2Nxw
         I6okbYko1RQwg7wEKlwOdac1UYG/ZYvHMv/sjQtlNERbZH3uA/8/7djpuQeg3nPqVy6T
         S3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077284; x=1714682084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/6DRcfVBeYI/EV9EeadqQiL8ogpcOEiqAoK1MwLNCo=;
        b=uj0oOT6OxlJ7OttUZIzV9GWKzB1zuZZ4IUTf8pfDOiur6kJ5KXl4Y6Wzb4wJ8ktmp6
         snw1rr3q7CUmAOH5M+BGNtl1eI7phv33vmS5vHrb4OM0Gby4dULjowR4bq8nZhljzuRF
         152tc7m4WWGYd5RexMqdpEh6cOelqusjcPkYuPXXVW/EdVqyWncKRNUkSxsij3F4hCPP
         28BJuchREse39AE3dGHzik+W2NXktkzFaW8pQo7PeV4jHd9bN87nVIq9kUNDckGX0plt
         XraLtTXvzP9WqgTB3Iu6dfeYTo42ViFYG3jzIQeE7wh+6LFzZEfy6X4fx7ybNi4/SIhg
         09bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeDqLzSLSxpSFkX8qSbz9cf6bi3AoL62V7UxhG/HaWmKpPNeKcUB8sYt3S18E/5RpWW33SXvryd/c+T42oIswGBHDbr6UA
X-Gm-Message-State: AOJu0YzkinZnbwjjKHcII9aEq8g9TsRC6XaqurM7XtUFQFdOclxBMZnG
	rJgnbvcjBW5mhh/ccGJQ/HycpASPFEjiuVRgHpAH+VKJD5RU52ICQtNHfPzNj1PutGa4C42gI1f
	e210BR230FZ4jMw1tg00AC3W6axsohbDx6Flk
X-Google-Smtp-Source: AGHT+IHdUtFAbWwPDRr3GNYBdVZyNScxO1JKcp9RaUdWwHW4UjaN0ujk54ehAeO34V7fwRw976ta1xGZlNpGPo6qyHo=
X-Received: by 2002:a05:6102:316b:b0:47b:dc17:104b with SMTP id
 l11-20020a056102316b00b0047bdc17104bmr691179vsm.2.1714077282730; Thu, 25 Apr
 2024 13:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425193450.411640-1-edumazet@google.com>
In-Reply-To: <20240425193450.411640-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 25 Apr 2024 16:34:22 -0400
Message-ID: <CADVnQymDnLd-S8zMKOF-ZGzaAHRu3yMkP+C34EaLdY_L79qQCg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix tcp_grow_skb() vs tstamps
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> I forgot to call tcp_skb_collapse_tstamp() in the
> case we consume the second skb in write queue.
>
> Neal suggested to create a common helper used by tcp_mtu_probe()
> and tcp_grow_skb().
>
> Fixes: 8ee602c63520 ("tcp: try to send bigger TSO packets")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

Great. Thanks, Eric!

neal

