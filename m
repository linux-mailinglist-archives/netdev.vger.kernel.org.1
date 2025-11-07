Return-Path: <netdev+bounces-236701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD2C3EFD3
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D06F4E5BC3
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DCC3112B3;
	Fri,  7 Nov 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtpfCcDX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648520E011
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504882; cv=none; b=BUDkgA351SnhiQ3r7ZN35z9GA2Bq3T+QjP6nmxjuszRiGLGC09R+3u6t/QV66KzUHXVd/NoKixu1CMgK35pCLu4QsVlYkAwgXDckWxD6GD/BLIE70TgwRPDSYA9PcNSBUVTrlffem06aEt7mA4kYlHvi2RhnX+I+869GAxPeV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504882; c=relaxed/simple;
	bh=UeeOsFyHF/xPwgPQ7aNrPI/DnDsJm1PJSj/7mslouq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJy7KQPfNV0AP8Dv/o1aBUiMhKB+qFcNrfWm71txeNTyIsAOT+VTXc137nPDcU05VXckgFdLwu9CX6IVaMFjOODPpsZqWdzIdRFHDocgnW5yGqq18nBHatLGeX231eCB0nDfeQXf/Zn5TOEIkGcNyAnQJeanK8XTgH/Ba9xARxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtpfCcDX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88059c28da1so5361476d6.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762504880; x=1763109680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeeOsFyHF/xPwgPQ7aNrPI/DnDsJm1PJSj/7mslouq4=;
        b=GtpfCcDXM7PQ7tjrbQ14TZ+GbfRIsFujaoswGTRl5NNT2K7zMHsLuQNPPOf5M1oqh9
         dweAomjdCAb9IywGtohlMQRSdX2iSy9Pr/pOym1EV36Z9jkJTRjzs8If5HWquumZEOLM
         zFIBwOJKJKW07HXEquvbtte6cA4mbR75awoWka01hIQFAmal4Vc6iT4R9BWRctAeIjWX
         jqAnRnpyTRqX9G+zTlO/9r+h125fX3WN+LJ0iliTHesCrFs4kiwCLg00pYzh/8soroqU
         NNaHprI7xLYSWqg86F7ruBHGB2uH5/tRcE1VR721GultmnwsIWgSdc91AWxpDa+B+7ah
         1rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504880; x=1763109680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeeOsFyHF/xPwgPQ7aNrPI/DnDsJm1PJSj/7mslouq4=;
        b=JyFWSdl7HoKSIprY/4sXmDK9I10b1jbs7tbejIM//YxBvVrFbcHg8lgfywxNv1vXx0
         cP14gdOzJ2bz4qhjd3gjuwC43kUF0cKcLbcP7EIaHvsHOQL7DpQ/z4oQ4xSvJOcYZKsp
         ySgdKV59X/UaNjhq3xmFpAWgHrS/0NtusEDA4/JHUKZmQA9n89rMcmjcZkaZkoCFenKP
         lNfHZZrOx053YU20yCgi1bW6UIlAca5mA7YAjJtgbe6nVbKjSs7QhpvQaAP1/zqOMsTx
         6Rq67OAFdI6WfxrVrt9iBGpBUfODBotOkq1vlgUHFoNsyszAQwviIGTlWQ/27ErTc3vn
         tekw==
X-Forwarded-Encrypted: i=1; AJvYcCWjxMjH4g4GMdCKuGx1zuej8Z6sTEouMBTeP+CNmhk77+L9MyWzUC01V577mDkKSO0RuxNnA9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0nuRQrcb7DQGlBXKuog2htvdrogAmYAcGr5BhOiNc4VGY8BBQ
	Hwrh5icbaK0g07dSlTdVl4ww0ipgfRJOEvmYj6ipwk4t2C1/gjaxEjLk8ylD/T7gVb8Em/R70cP
	FCdO69TWXIcB8SI5Zr7yfNpeC+98isBmuSslS3ur+
X-Gm-Gg: ASbGncvhSEUey0nThqp3tHCf9WNDtuoeym7HvTg76stR/qhkXZ9c7WdSy6C4n0Ze6w1
	5ryzLFQ4B9ZVYo/Bez3fr2gXBeS2zRFWJgGij+epPctHjo0JnBZmsLvjm6OCxewruoQhdp3EWj4
	9N4ZpvJq5Mp15Qnm97MYoKkEuONgZDA+meLVTrwlQs71nO2gg+UEIUlxOTtQDMlvCNk6oV7OJbv
	0VJilLZFBsHYWRRZPf80xtXQLmTloQX8RldAsJmBccWc4G5ywcuaDEYlIcJq9xZe9oWpSR9
X-Google-Smtp-Source: AGHT+IG1HG5XAbJZfsHb7/UDvCB9fxAnq7ggnuPugH7Szg2iSNAkgc/X8c1ZpePLbvlWTv3B11srq9thaUSWgzoSBFc=
X-Received: by 2002:a05:6214:2a49:b0:87c:2919:7db3 with SMTP id
 6a1803df08f44-88176764f48mr30881946d6.51.1762504880215; Fri, 07 Nov 2025
 00:41:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com> <20251106003357.273403-6-kuniyu@google.com>
In-Reply-To: <20251106003357.273403-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 00:41:07 -0800
X-Gm-Features: AWmQ_bmkYV_vX5LD-O4pZ1fvMN3RZn42N_hJbERasjqWUt-1bxU8kMFoPo4gtbc
Message-ID: <CANn89iLhhXcY4P12TfaRdonBcBszT6BOwibnt2RW4Q2fZ8Y42A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/6] tcp: Apply max RTO to non-TFO SYN+ACK.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Since commit 54a378f43425 ("tcp: add the ability to control
> max RTO"), TFO SYN+ACK RTO is capped by the TFO full sk's
> inet_csk(sk)->icsk_rto_max.
>
> The value is inherited from the parent listener.
>
> Let's apply the same cap to non-TFO SYN+ACK.
>
> Note that req->rsk_listener is always non-NULL when we call
> tcp_reqsk_timeout() in reqsk_timer_handler() or tcp_check_req().
>
> It could be NULL for SYN cookie req, but we do not use
> req->timeout then.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

