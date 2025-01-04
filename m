Return-Path: <netdev+bounces-155113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB940A01184
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 02:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE77A0FBA
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 01:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35EF1AAC4;
	Sat,  4 Jan 2025 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9J9EZip"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873F25949A
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735953799; cv=none; b=uCQvNzh3NPaZD9ylzRrHvSa+30wOeEa+5EgsUUxcxHQf3lUOSmPim2BAkIRT+jV4VIWf02tI0/8pHWsK+Z4G5FgU0Cu+47jWQpe0gYu+aCFkmEk6FuE2YyegJJTJSHuiwZIrIXrF56VKaRmyA6MhbPmsC4k+XjyaGoYYphqMCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735953799; c=relaxed/simple;
	bh=EVOupnJPJ+EDNHb2VGmRjdRqs7i7dSED3oEZFoCrKAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFXJb/bwcpm9xPYGiTa3DxVJCGy6/0aueDLOLG0H4OrQP+WLthhWGRsOX9+OZIhV2Wmsm2rOxDbqdSH3gPbihX8MXKT8bwduRTBNUIBbrtiJQzc5GQhSoQqM7AYbIw80o8fiEjLRD6rBZ54Snj7MInvmjtkXxs0WndPzoXcyx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9J9EZip; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a8146a8ddaso47887265ab.1
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 17:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735953797; x=1736558597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVOupnJPJ+EDNHb2VGmRjdRqs7i7dSED3oEZFoCrKAg=;
        b=C9J9EZipeYdSqdA7CJz5Jt7yus9z0QlZimwnkS/RfiDXK5kB4y4EXvG9CBHcqZWhqf
         yAokJLqyhjgxT9T084QKpJRJPsmIFQjr2yRNPLzi4Xo4gjqzCUjbQGbTqndOaua1TB17
         OYN30lzpXrJol8tJGX83PPo/Px3ebAicykIEGCCGJvo2rxTPz3vD/vZWq88mBYlVvWRT
         OjgBNFWImf2BATL7PSG+7oel7eZvDmRLsDHE2QkpW6Mb5d6g+UaMLTFq9OBdLErFSihL
         O8C63VPrN0QuaDtsmq1xlukABuw0pD4Ia7t/iHfWcmdUpLGYHJEwhAFOtZ8+m04mBAq7
         DI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735953797; x=1736558597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVOupnJPJ+EDNHb2VGmRjdRqs7i7dSED3oEZFoCrKAg=;
        b=EM/5XFEnsejMoMiYHKn3DCddswhO26UfBocSS168eyx4qWm534cXGbYkE7ARnAti+B
         5kSu93SuWbDvvuYNXJ7AqMVe54s4pijWCmwd3mUJPup2f4rCKs1G2ckAdeNKRcyqlgjO
         t1xynX6FuVgzJJDpjLCUVcBZa6+snmG9Tu4LurjKlsDschMfv2J4t4q/qEa7ekqtpMQC
         DxrRWxbd4VhojLOP1BU8op0zpmSTL0A++DVHa9a0C+ptBAEXM5TiPiuvtp/6SY8bDVhf
         uqOmiyYEruVn4qLu6rBS2gRDxoJTEBZlhGGa2YJo2IILY0YpxWaCR4R00rMasH/zJDV8
         oYJg==
X-Gm-Message-State: AOJu0YzgXWgQuMXhuOl9cUV+i1h1XQX2xTJqLXsmZ9KpLocl9Dg0DJn5
	8QigqvgQpbfgHWZBRUJqEv6GdTDAftWBcTI1/Ye1F6Cb7fT0T3RfNbUvao1pmwot1RwW6MwTyZ0
	XVkoh1FzhIO64e55UbViA79U7IAU=
X-Gm-Gg: ASbGncsWrOBqqSsetrj2O9kxpIkyblKjIiTFxTcbwYP9HxWy0Pgf9vCKcA8lIz/Kza+
	GcyDRrz/ryK6dQQ8l+2cdlPTit+Ekn/R4K3J4
X-Google-Smtp-Source: AGHT+IEF2DFtpu1CM/JpQVifOINvrTrOkI8ndxrbEbIMK4E4YfXsOp29sblwqmI9y98nhwQGrlrYaTuuU0kQ80SpGD0=
X-Received: by 2002:a05:6e02:2408:b0:3a7:8ee6:cd6e with SMTP id
 e9e14a558f8ab-3c2d26813eamr449688455ab.8.1735953797247; Fri, 03 Jan 2025
 17:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102171426.915276-1-dzq.aishenghu0@gmail.com>
In-Reply-To: <20250102171426.915276-1-dzq.aishenghu0@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 4 Jan 2025 09:22:41 +0800
X-Gm-Features: AbW1kvaqKGu7EvNiuXzBczh3-ZaLnkrCoXNqRcYGdiElTqLQDR2j0furdoTQNmY
Message-ID: <CAL+tcoDoE27q4Wus_9rtQDqTezejZdNQ0V-9ynCoN0KZTiqg_g@mail.gmail.com>
Subject: Re: [PATCH] tcp/dccp: allow a connection when sk_max_ack_backlog is zero
To: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 1:14=E2=80=AFAM Zhongqiu Duan <dzq.aishenghu0@gmail.=
com> wrote:
>
> If the backlog of listen() is set to zero, sk_acceptq_is_full() allows
> one connection to be made, but inet_csk_reqsk_queue_is_full() does not.
> When the net.ipv4.tcp_syncookies is zero, inet_csk_reqsk_queue_is_full()
> will cause an immediate drop before the sk_acceptq_is_full() check in
> tcp_conn_request(), resulting in no connection can be made.
>
> This patch tries to keep consistent with 64a146513f8f ("[NET]: Revert
> incorrect accept queue backlog changes.").
>
> Link: https://lore.kernel.org/netdev/20250102080258.53858-1-kuniyu@amazon=
.com/
> Fixes: ef547f2ac16b ("tcp: remove max_qlen_log")
> Signed-off-by: Zhongqiu Duan <dzq.aishenghu0@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

