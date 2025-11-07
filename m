Return-Path: <netdev+bounces-236663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D853FC3EA5F
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 07:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948613AB01E
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 06:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D22FBE13;
	Fri,  7 Nov 2025 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCqU8shh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE07283686
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498088; cv=none; b=NDlXdUlX0SbsGPXGVCHIJ9JqPcumF55wcLShoGPoAX5jbpeNQBaYjzkLWWLJ0ks+O3LybJ4eLujASw585snThzoLvRXmBIuVj6Zn/54aZW1CQ7lWKsBTD3g4XwsKkONoMFp9KY2dXtOq7ZqsFBSfLfXItxO2aiNJDAxpRea6Rc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498088; c=relaxed/simple;
	bh=dK0bVXDPi7zfyd+H4JqDOMxQz4qMp9Q6s0qz3Cr0/Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwcavW+YrzcoBlivEJ03aI11TBbVDhsvXpp1BqUzsQ6xRX5U73ymqK57la1Pz9a8p9TA7lGMINst0bpTXV3awgrNXlFXx98TSyIru7v54gcbVi5csx44t4m+mWitywUqlASRpSE/JmdIcIzCiR4v4bcjeYVV/kyt2QhRmKyXneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCqU8shh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so460507b3a.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 22:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762498086; x=1763102886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dK0bVXDPi7zfyd+H4JqDOMxQz4qMp9Q6s0qz3Cr0/Xo=;
        b=hCqU8shhbYNMkC70wvd9Qi98FVB9XgBUzdijGDizIyWOsnmXCk6hh7lyXAuCKe5T+H
         xkYLtZwF2pZK8tzq31uYBB6cqFzPlY4goVniTXG89fxd4mdGZw3kfHHqKJr4kt9DzZPt
         lWZ8zldrZfdYeam9/POQsc0E0bEyQqo8Wq5AtnaZ1zpvWxFeJE6I+X7oATeAGAjBpLI5
         mMtLy6AjxSAW6assPrKq3qxV4XuV3erkDopEhbIf0KQYOn7v+JtQ/uF2gTZDUL1tTuRl
         PwJ8CohJiFTW6PWWJw3ECa9+quu4HG2DHvncLoIL9U623yVEuUNzZEjXGBeHchyoWw9w
         H3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762498086; x=1763102886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dK0bVXDPi7zfyd+H4JqDOMxQz4qMp9Q6s0qz3Cr0/Xo=;
        b=P7fA5ifk4FP3cD8GXfasPV0Y77/ryR4D4Otbgfo1QjyDJ3dX4ysob7B3vaTIStwkpK
         TBfe8Af08gEoecvGrt0TtaOaRP+XGzEFm3xkoNdbPT4fGVlEog8fAGZ20ZDkqrwRxMEQ
         VBEUZuI9N784ut9jOxci68MDCDFJjWXB/2ZPGKQbRAypt6MOgCGSCTTab5GOotzOdpwW
         QRMDyxCCgeiiqTH+XQ7aHrXZ2O7eqiN3Hw+aaBWoS7uyg/QvaZLK31PvBM8updj1iFBC
         QSs97v7IQnaHo3U/lSS++yB3EAnlQn52ITXreulrRihZeddq7w7IIKAGYl0T85yuVUoR
         8meQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtGntEcq52Zi0FCnZXpDcPhG/z1vaGywsw5GUsdeKtIQzTw3harT9MoqRxshZVGZwI19elpYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWkagPcIruNK/MZaI3KAjJh+6tFZK+8OE2JRX4K05Z9n9h45H
	GwA1KPwDcgCsnmDN7c9jWHNG8ZSXYzqw3LIu0PcEv8FqTtKVniu2qFq5yqNgkZo7xoETj8Ne9tI
	51QRXnA5HwdlMxyZUjlSqTSGxzgyRc5crvqnWyDiq
X-Gm-Gg: ASbGncvDvOtn/MDMsigFoiZ4svrYoN6QoWscwep7ya3AUNtDSvqRmaiU9yRVouUwkvD
	nbfXAtbmhgzV3S+6Y/kMpby+BR7v7bFPe0HE9IRMpd2wUPiekSxTe4yMQu8ryR4D1OOjk7YHkHw
	RF4Fj9AiONdtya5FU08/kpBPKdQWMQLHk+t/UmOyREDj5SpjWZhfhStn72NiFtnDogHMOy5w5WA
	J2F5iCSN9v5eoa6UrXxckMWIiOXZWrjMmVtetxbxldbh4Zxj3v3tjDtY6WdK5NtTNUQON/Db5G5
	SbWZb3T5JuaRqkBKXs7NFsRYM97E0Gpxs8zeFU0=
X-Google-Smtp-Source: AGHT+IEuQ85GM0FsQtGHIl5tXX8nksN7rfGLEZh0qH+KC9Bzl+d+AgEEnzMUfciHTOIoQJOSHUgA9rYBaxciTiNAGVs=
X-Received: by 2002:a17:903:32c5:b0:297:c0f0:42a1 with SMTP id
 d9443c01a7336-297c0f04a73mr26048495ad.44.1762498085783; Thu, 06 Nov 2025
 22:48:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-4-edumazet@google.com>
In-Reply-To: <20251106202935.1776179-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 6 Nov 2025 22:47:53 -0800
X-Gm-Features: AWmQ_bl9x1e6ykZZNYR3UqBJJi1Y5haVf-fxNYe4NW2j1uvJz_BYILWgyC2TsvA
Message-ID: <CAAVpQUB96moQmT8E1Te+hKebXoxvOUC2RqeLmMjgCA_YOHx+jw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> skb_defer_max value is very conservative, and can be increased
> to avoid too many calls to kick_defer_list_purge().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

