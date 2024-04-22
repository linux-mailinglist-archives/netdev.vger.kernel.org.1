Return-Path: <netdev+bounces-90083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DAC8ACB19
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1DE281A29
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC1A14A4C7;
	Mon, 22 Apr 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VY0wzZpC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5E145FF8
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782489; cv=none; b=GSMW/3M1oT3iS6PlVRt5ZNSaO6GBZSShdEt5XENR9NcZHmw73OMynw0PokXG0AXao7NnOtCAva+oEBPzeW0SqxlXj2jVyTkbtjpxmlH5acPHY+kH8bB5HEGlRvW5txFBYds6hPnCIVZ03YhwgPq1T+4iPtCmQtGae40C3nTrqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782489; c=relaxed/simple;
	bh=WBRC1YDpPGCAjFOyqrEApiRfhPhWX1kD74GppyD2DVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk36v5hIv6AvH/XFA46aYFRt6tH/qOgHSK3yGjnjOezeeyc0mCi8Grh8w6h3UwXs/MXcv41gjSiwEV4PsyOTkhknz+V7Q+P/IroQzUtit6sH/Jh5ChYuknTlD2bxnjYABAGw7BdVEuxwln6XBgib42mgEuuM1tfWy24/rFxlWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VY0wzZpC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5720583df54so5042a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713782486; x=1714387286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBRC1YDpPGCAjFOyqrEApiRfhPhWX1kD74GppyD2DVk=;
        b=VY0wzZpCcdx/bo62neGHWFe23Q/OsCeYebcEus4NW5c4xFxc8GLzrqZOT2Ix8rkklA
         LpYGeaTwAGbke+9X4JldJhKmWC6IFgjnu6rLFTtWyjggez74bdrLLQP4lU1ocf6tcTBc
         0xO6ooobYsBamy66GGixMVUUmmTK+s+mvuDt05w/Y6b65zosQ2tXiIn3fNGTO1zI59jx
         r94zYdvUw1UCVTk5urNSm950HyNcYxFlUs8mk61POl9XJxXZ1dkbvG8P6JEjzwaYnR7i
         KoBoKM1k3cVKOjN4QDPiTTg0rmTlNH0NoeqYIdqEtjkyJyZNWBX/Q4rnuJ1x9URSDkhG
         klVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782486; x=1714387286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBRC1YDpPGCAjFOyqrEApiRfhPhWX1kD74GppyD2DVk=;
        b=lk2heNtfIZyV4MnV/rIuTEBZ1yex1vONV30TPd7dGFm5b0fvk+nRMJtP37KLIKCDIw
         awuJgu0kxfjhxzEsRmpIokdIOSdOvVh7ZRn9K6dKIbM6HBRFdNxwrxoifpXY/jf5Kxix
         tppZQQVTNoeQ4uDXk1XxGQ9VaOhYG3/jw8ylE0ATxiKF77Jvio2OiYFKjEAYa5QUXIbR
         FTCu6B1VZTSFz9orfsGYeYrZON5d4w/9EP+xSbj2AwjAeyrPplxSRrehfQvxm/NSqb1L
         jp6A0RtNQjEnPG4/a6Le3ghIcBHVThna0rnOI0NDOluOlhOxGdluazpbPh7tixVI0dCo
         uBug==
X-Forwarded-Encrypted: i=1; AJvYcCXxTb0X484di7RMYUqt+8zCghQ7YZFgcyOyeTiPtrQv86RlBUFnH3A31PbrFmD2viVuG9If435b6jZGnRQ05s/VQPKNh/qR
X-Gm-Message-State: AOJu0YxreQaywGp44d1s+DJ6i2WUXkoOW/j+4bpFqfBwgVPL19u+D3iI
	wLtnWCMFlNGlw24zQV6eBOvsO7FIdeS2KC94pkbN2lbJmJS/kZy0fUHmODVK7ox/H+0Gflly3Yn
	nAZIq4bOeu/cY9mpyNCvACe9juu2vlbtdopN2
X-Google-Smtp-Source: AGHT+IGJCCnmZCJSsHSxEAneZezhyepUjxPj+3DwdkZfFCUXOX2W2iK36+58hR0uav9q4Qv8dTpG3dgIYuFX/Fp9Xcs=
X-Received: by 2002:aa7:da0a:0:b0:571:fc5e:ba34 with SMTP id
 r10-20020aa7da0a000000b00571fc5eba34mr134189eds.2.1713782485665; Mon, 22 Apr
 2024 03:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZiYwUnZU+50fH0SN@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <ZiYwUnZU+50fH0SN@v4bel-B760M-AORUS-ELITE-AX>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Apr 2024 12:41:14 +0200
Message-ID: <CANn89iKSxF1Nz-XjeeJ2Hv9BfbV1tULE0aq6S8xnT4pys1qvZw@mail.gmail.com>
Subject: Re: [PATCH] net: gtp: Fix Use-After-Free in gtp_dellink
To: Hyunwoo Kim <v4bel@theori.io>
Cc: pablo@netfilter.or, laforge@gnumonks.org, imv4bel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:39=E2=80=AFAM Hyunwoo Kim <v4bel@theori.io> wrot=
e:
>
> Since call_rcu, which is called in the hlist_for_each_entry_rcu traversal
> of gtp_dellink, is not part of the RCU read critical section, it
> is possible that the RCU grace period will pass during the traversal and
> the key will be free.
>
> To prevent this, it should be changed to hlist_for_each_entry_safe.
>
> Fixes: 94dc550a5062 ("gtp: fix an use-after-free in ipv4_pdp_find()")
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

