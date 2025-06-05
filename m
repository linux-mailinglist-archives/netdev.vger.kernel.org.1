Return-Path: <netdev+bounces-195161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D8EACE840
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 04:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF5A1897612
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787FB770E2;
	Thu,  5 Jun 2025 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLyWiL3H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3CA1E3DEB
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749089272; cv=none; b=P9wj2Al3LdeW6wWtwcjvWiJEIjJsV2On0TBrqbABXYura/co9yepHlhA40/CRADGu3LniASq2x/XqMbB1UE4eb2Ip1nVCaVjfTmIfQ4/cNfb1lhe69YShxrX4qtPIhgg8OeRcJtXODfOhGoMnH41AvfVzGIjVRiDqE11uYZMKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749089272; c=relaxed/simple;
	bh=XAQF/h3mf1N0s/IIxZhuR8jh7LXzL2WKhwzKMCb5He8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ7j9IIKBjdd5ZJSW1HtqqiuV4yEb3vULpLc1j1M+RLyWNV2yP/SaR/eqKlCLX15hLRdvY4BWOdXX9IZFNxI4i5IpGJqfkfXFAjw4jX/nQkOKHaB0Z1zR5aVySkzw5jXrkJzRbeGNPdSPSAR4yhNprnwNMuA8tVUcZ8xewhz6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLyWiL3H; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3dd83950ec6so2091575ab.0
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 19:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749089270; x=1749694070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAQF/h3mf1N0s/IIxZhuR8jh7LXzL2WKhwzKMCb5He8=;
        b=LLyWiL3Hbc00hQam6JVPpZoZZjrRIod7pFXTwcPEUriWj7LtUZ4vbnj+i0i4oHva+z
         JOQkh5oV7gp/W8XJH1L4X7nwcIkELyQBjfx1tS5MHpxkVJS+6COC6Cle8mHxNB5qaO3s
         xeBdwUJYXYELmJRCB1RxwORS0r5RMppcflaLyH85pXBfiCgVewj8hChebVqq2C3RVAQA
         unxvQ2fpbvKzsMz/Mm4LzV1Bwf8aLVSckfZ0Hhr/jpLyQwd86Y+i7ZcZhvfOWJzmx9Vb
         mkAYY+8NjR9EzBXGRer/vu9v9UzNBTEGOEcN4qLBvR7bn4TqO0SICJ79SDOCfeZqFD1m
         r7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749089270; x=1749694070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAQF/h3mf1N0s/IIxZhuR8jh7LXzL2WKhwzKMCb5He8=;
        b=Es4er+mQ1W2JKQOZyrsVkvOaBUaPtcSE6QzXrj9lKDGvhySRaZ5aX4MXamqQq+KLhn
         N5p4ZjmErDhS10WGpIJEww+Bi+unYTvHTFGGl3NlNIx43PaB93UZNDSb9rwxFwfeAvvm
         WOYn98uZTgDqhDSDytzgn6Il8v3YBSo+BPDcw8Up2C9ypk2c5N9I+H0B8YVyiXtTe0eQ
         QRPR6ByUDbQ5KBH6NwxUSeuFJCJFMWCS/DG7wxPzP6bBSDGQdRRuUO/yjggKwV84M7DH
         t+8mwLPH+/9uoaj3tBgYIxdsNu8FazZQAafKosot44q6MG4trFv+QymA6jGvTr4JPhLc
         D1bg==
X-Forwarded-Encrypted: i=1; AJvYcCV7AvH2lzPz/hVQSEzp0LSSi93dSALh3eVAYnBQAQyoVuvhXwHSzMo7X63pf6B299uo7FMdvwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtw6IKKLFf8maOfnjcI+BBYz4Ynz909/m/5nCy/WuUeQ7u7uGr
	XofBgK3wDz7S+/Ta0UYa7g7G9KkqqTELeMgnTMtooTjPSNftcV7IMBZIr+u+6/mcc9+To4OoH+/
	z5LlXC05i5HkidbFqrPM9zN5DTJ4ofZs=
X-Gm-Gg: ASbGncscP0XDq9pTLlnXu9ZV81jfVOIFYWwfbIwzaDQ9t75DL2Pweu5iQ63gCayjRZJ
	w6YaqBtw2+X7YF42eI9qSJdDonNpAURnyjwBGB9KbLqocKKw2RTijPtLC+8XduiuicmK7fEBAFD
	WSbXUOXTFw9drULsFo95WPebsARFTBePz6aecR7y5MiQ==
X-Google-Smtp-Source: AGHT+IH2WucgBmVm7tVxi5l08SrNSvUJ25IIh5fPMiEvw1raqHWouv2KAxis2xc3U5LjpS/nXpfHgxPO0He60Qrmb6A=
X-Received: by 2002:a05:6e02:1b08:b0:3dd:8136:a687 with SMTP id
 e9e14a558f8ab-3ddc5fb8867mr21788955ab.8.1749089270052; Wed, 04 Jun 2025
 19:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604093928.1323333-1-edumazet@google.com>
In-Reply-To: <20250604093928.1323333-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Jun 2025 10:07:13 +0800
X-Gm-Features: AX0GCFsMTbE4MkW76T3GeoXyWtv7Elda77bfobThxpLhyasdyXLsSRaaS_Hd4ZQ
Message-ID: <CAL+tcoAj=i_gG--SnVJ38RKfnsUzw=5YQqptN4cKr3nof4RLYg@mail.gmail.com>
Subject: Re: [PATCH net] net: annotate data-races around cleanup_net_task
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 5:39=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> from_cleanup_net() reads cleanup_net_task locklessly.
>
> Add READ_ONCE()/WRITE_ONCE() annotations to avoid
> a potential KCSAN warning, even if the race is harmless.
>
> Fixes: 0734d7c3d93c ("net: expedite synchronize_net() for cleanup_net()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

