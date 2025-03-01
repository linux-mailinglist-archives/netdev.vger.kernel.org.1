Return-Path: <netdev+bounces-170959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB41A4AD99
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA1E3A982D
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0F61DED49;
	Sat,  1 Mar 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3EtfVwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE31B6CE4
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859474; cv=none; b=D/cBya1uJoq0csjjGYSk1mIIp2iZddtJxLNDhIC9OmCzbm0FIsUCfts15xQ48AWsrzmGZQAG/X/Np8I9aa5HVCAZI+tWJHq8duQe4j6uwPpmYBXaYtezZd/JsbxW3SSKWHQ6gMIwZcUdmLjQ47NmfvFavtzRs+TvtWG1UOr0WMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859474; c=relaxed/simple;
	bh=SV9+QaJFu0EN8P0+o2WrwdM6ZgnSHNyIq5I2YTmzd34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1NgTbDaO4rmiz+L2KEpnjnl5UhotivH9d7G7IHzief2TP0Er1hgnwjR7p+Tqi3pbLezUw4vA+uACzIozIDhwzIz5jrn2ldW2fu7sGY0QM9E65KOzyaBZgO6sHNbDA9iG6u3pAg3D3gQJjOeezjfRudB038HzJRf5QZ107q3q3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3EtfVwx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-472003f8c47so29882721cf.1
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 12:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740859472; x=1741464272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KviZHRnG5Iw9a9IYsWKRokcC2ICNIVORYihnsdKCC0k=;
        b=L3EtfVwxNKiNuWlnGI0UuPyzwuKMh2hziMvNIwOJqXSZ+JUlMDFrKq0iAfdFI4rJvp
         oLawotRK8cXcPGwCAbSNA8lQaWEpkfq608zet35FNmjJ/C0XcMqaW3kxzmEsx4LW4EaQ
         2ZJVZjx8PS0wy61ri/E4V9VNGan6yQVyz9frOi1q54nEMpbuG+Jlh4tP+q6NpiAX/3cU
         RX925iGCLlRAhGm3KeAG64uvRSrYk2Sk7rtKiT1ESIzNm8VO/tR4l7irMeo7h6Fb9KLF
         q4fdT2Omc1gidWysAQzngq6yxy7HoDrH2zFVjbhnw8YbWvsWAxebFeTBdOtKpHGZi/VT
         rStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740859472; x=1741464272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KviZHRnG5Iw9a9IYsWKRokcC2ICNIVORYihnsdKCC0k=;
        b=vPvUjHZdHZRtiemHatdNJm+q+6hSbr6aEP7900SzBkq49Tg0L/ps5TQL21qSJcjxXc
         hJ12bZHxBaSevE5g7LsJ3BkcZDTvcwYztGuGqPA7GbDv0uEev3uhzy43k8JrBJUmU77q
         MElk3saUqGiR4Cwco0BqidhgVdBc7XqsYAAimfK5C473WxubaHyTJSgsIaVLYw1BH6sN
         Pd1G3WVT6djCGYvsfWhAnqlIDyVCWZVRAk9yLUJxFTzkRhPbOP1QpA/Q1uUEuvojhVsF
         L+gM1nJtR9+Mxl+dczQCsRep0VvTtMicUdoWMRqDxBs75CvKMv77Px9VOgsxQzQncRcF
         kjxw==
X-Forwarded-Encrypted: i=1; AJvYcCXsMF5KVXpuLaJkF6ixdH0MK/yQCTfSgYUr1H2sYd6S0S2FAfgGKS6+EKuF2bfQwcy9xfuXkrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKcIq2X6+hojaygxhUyh4WOKGWGQ3cTc1b//G3FTCvUBySFtp
	H8/gv400AKhii8QVncGb8P4D1bCZNk2UWgBaO7q2QDK1Y1DNxK5q3kaj/faHOTXdsBhJOnt+deB
	rXxUFgOq5vRhBz7T0kfjlOmQyCZ3Gb/t1C/pl
X-Gm-Gg: ASbGncthgyW9tMw+UdZo5EJKCNHc+hWStFdk32VkT/5opNlL/+zAUvrRfFeoVIqIypL
	Ozwx1HMI1U2EPKY/ueBD7qiNYD5ASEQ5E/Ejzm8h0/zbNegn42KXdsv5RI7Saja5HC6c+QjBgwa
	E7Tx4eKZPKEguCAVA256PQ5CKMSP4=
X-Google-Smtp-Source: AGHT+IFQWWja2NkPTm83Q4ruayfvx2hZIyG2SbvbIrktnsXf8bdKGOc3XrJ7jAQS3yyL0QE2DtxbEfytBmhJQRbQ61A=
X-Received: by 2002:a05:622a:3d4:b0:468:f858:6662 with SMTP id
 d75a77b69052e-473d8f9cb3fmr175435081cf.10.1740859471837; Sat, 01 Mar 2025
 12:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228132248.25899-1-edumazet@google.com> <20250228132248.25899-3-edumazet@google.com>
 <20250228142816.3077420d@kernel.org>
In-Reply-To: <20250228142816.3077420d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 1 Mar 2025 21:04:20 +0100
X-Gm-Features: AQ5f1JqmVIV4mpo9VT_qkD8XyhK2D-p26sqmAYrvzBUi_M3_efP_hbzogThkI6I
Message-ID: <CANn89i+CSGY4Cp-c0q5wT7kHa-Vn2oO8EVUgHf4o3gr6sW_YZg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] tcp: add four drop reasons to tcp_check_req()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 11:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 28 Feb 2025 13:22:44 +0000 Eric Dumazet wrote:
> > +     /** @SKB_DROP_TCP_REASON_LISTEN_OVERFLOW: listener queue full. */
> > +          SKB_DROP_REASON_TCP_LISTEN_OVERFLOW,
>
> nit: TCP_REASON vs REASON_TCP

Oops, thanks !

