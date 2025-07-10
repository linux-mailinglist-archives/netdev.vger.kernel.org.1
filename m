Return-Path: <netdev+bounces-205822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5CB00490
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E91F1894C7F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4174327056A;
	Thu, 10 Jul 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx/6Bfx/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DE26A0E0
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155841; cv=none; b=gWLNIZSZQLXQt9lpHJFzAdyeHr16AtzCSAis9FAYGdwKY/4wHdXu0TYy4D55VIDo92vFDXia8ZRxDBKsF52QkLLivheFKGy3d9wrwm7dlGyklO7rx9ujGsi79mlpQWTnSfVF7jQ2A28+cSJzPRzTJcfcpd1Wlb7oM0hXjjbQV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155841; c=relaxed/simple;
	bh=y4nV6T3TuHX+v2HCqGtpWtOI0S9EaizoqqF3RBVuTOQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XyWNdHv2JLP1aiqvxCJfQ9lG4ctgsijvG8aw1BL76YOHx10J5CfmmfnW0HXA3bLy67UiQlRzH3dfanPC6oUIs/8fjDSn0PsrEstjvHiio84dyJQxLIDvciXWmBWEK5PpmCsF5jIDovs0kvY2g57ERefdlMI+OtnjKlEyIBA+I/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx/6Bfx/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-711d4689084so10678087b3.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752155838; x=1752760638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10AbMEhl99dsExbNa6r+bsVXf02l56K4FdTwAIHGIyo=;
        b=Hx/6Bfx/h8jZ5uYjCexNc/T4SzD9ceXPwRlJcaB6JjlqfEw1+GhJrH9dQt96rXxfmU
         LVO7eF0ldJI1CmLBRuU80nkZJI22CTdfi1U3ic8wqWI74hsUmmHYuMBoq2vncjutTL8b
         wYJBW8D1SI1CVgYQrFrw0nbJKK5UInyNEJZkBpKxxcuQHR415jj+yF2lIz5rcorgH0kP
         Wl+eXkkehb6n5P+Y4jVND5+9cKsBS1j9Wu64pqVKbzfYxZS5eXAX0m5PWhV7LcqvW0y2
         0bV1nTEF4qJxFEEqo+KYwBZnkwdY7lArcpYCa5KRSqv1Dr+xAC7qyp8JHCDClHSFvUiz
         hetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752155838; x=1752760638;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=10AbMEhl99dsExbNa6r+bsVXf02l56K4FdTwAIHGIyo=;
        b=g5ak1Rbwkv9lv6Kyty5h78sa0wMeBNyKmcsrCvO/nxsKyygZdBNOTKlcI7MHuSBFGD
         YZi/6ycplxxYuOJOiBEok+dGJOYQptAcoyibJmDOlAdjnmNdNj92uO1fSm/QLEB3weST
         kVEWi0NjuQRoIiMhLviwYzNwg4jXmSGNs4A6jusJdIrmL3Zl+Twpmui5MO6lT1Jt/z9p
         wjwgpbINqfjag1qjBEYT4NRKYBXsW3qbqjdCgcI9hh5pb7AmbLY+F0nM8DD5y0yGKfKc
         UnOYadwXDoadnh+Vi7tu9wSOHcIYAHWdRAnIZLooBtTG+Ps7OlODKv9bV87bZ6Wpi6Jq
         NLLA==
X-Forwarded-Encrypted: i=1; AJvYcCXd422NEJwDxDCZV2ZE2/xIHsmtwF/MG8wLVbSuBY5Kc4bErRpcTyJTyYaJUYsnDhEU7UTu/dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVN40wDGPulYQybz6utsm8/fIJ020FTXEeadklEgiPYb4dm7v+
	JLd/dbKTAvBcGeYipgWfs9Pu76fKHeFEb/W6T2CT3BpBDtgjwOyV9hS+
X-Gm-Gg: ASbGnctBmXWHdkCdCUDJB3hUqgN6kNfK8QPIvQ0Xl35hSPGK38Kktjp1AhifMfXd8Xk
	o9K9FGeVajfYI3OR4LTJK/qVKZefd5f2auBuHyy7ZJafn1JEiGK2oj+MfM6Grfh/TH/YQygMzsb
	GpA0mYUVdc1mSOkMvaSSS5d86LBGSYfY1OFM8BISP4DRlL9G+0vS4/Dqlh4MfETIKHYZJ920PTe
	ZEjxgKwUJMxlVjcZ09VbrhOhUgC6gz78l3EDMfOUiDdKozuFHKaTZZvxqL35IIvm/2UmrUDbj55
	GcxcGqncME61nAOMpJX806xPM2atQl0yGoX2kiiLk4Mkm0XqDJ3ppEC/5nRhNw5ewBq+X1JA1wW
	flTBRS8Wnrpzpd/qyfBDc1QGoxdrNq/mUf1TfJR4=
X-Google-Smtp-Source: AGHT+IFbegGZtZ7b3uiQl4JFY+mwj/sSGLNi495p10Fh7JFnL4b982yB8GwEdlvciAOlZXtjZV2avg==
X-Received: by 2002:a05:690c:3687:b0:70b:6651:b3e2 with SMTP id 00721157ae682-717b167732bmr109281087b3.6.1752155838580;
        Thu, 10 Jul 2025 06:57:18 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c61e99b9sm2878947b3.103.2025.07.10.06.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 06:57:18 -0700 (PDT)
Date: Thu, 10 Jul 2025 09:57:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686fc6bda1124_fd3882945b@willemb.c.googlers.com.notmuch>
In-Reply-To: <582cde2d-bdcd-4866-ab78-2a8e8590e8eb@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-5-daniel.zahka@gmail.com>
 <686aa16a9e5a7_3ad0f329432@willemb.c.googlers.com.notmuch>
 <582cde2d-bdcd-4866-ab78-2a8e8590e8eb@gmail.com>
Subject: Re: [PATCH v3 04/19] tcp: add datapath logic for PSP with inline key
 exchange
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> 
> 
> On 7/6/25 12:16 PM, Willem de Bruijn wrote:
> >> @@ -689,6 +690,7 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
> >>   	tcb->seq     = tcb->end_seq = tp->write_seq;
> >>   	tcb->tcp_flags = TCPHDR_ACK;
> >>   	__skb_header_release(skb);
> >> +	psp_enqueue_set_decrypted(sk, skb);
> > If touching the tcp hot path, maybe a static branch.
> 
> Ack. Do you imagine we would key the branch on pas creation or on psd 
> creation?

That's kind of immaterial, as long as it gets set before the majority
of hot patch calls.

Since psp_dev is the first object created, that is the more precise
starting point for when PSP as a whole becomes active.

> Our preference would be to defer the change to its own series 
> if the code is acceptable as is.

I would also defer it to a stand-alone patch or set of patches, to
avoid complicating existing patches.

And as the series is already over 15, fine to move to a follow-on
series too.

