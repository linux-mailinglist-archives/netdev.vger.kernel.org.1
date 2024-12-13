Return-Path: <netdev+bounces-151892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CBF9F1792
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27DB161734
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83F18B492;
	Fri, 13 Dec 2024 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChvmaAmw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC866189BAC
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122888; cv=none; b=jYUlmszA1jDdYnx5ICxgaxv8cMFsQmyXUKU6IlIfWfZSMKf14IT6RaCUMTNMOPlMuBnCg9YLMWsEWS3tjVCGqnk/5xkBYN6Zit+8sQgbf6QNAurcGwUrjoNDDODLrShi+glEMkHmSL4r1UTNN0Vc/vLlEF+2O0PqMGpAvcpNQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122888; c=relaxed/simple;
	bh=rva9khKUh5S4eyCpPUaDoZslmuYjcHZJcPqbOE/Ftxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvHSv4dfMKp8ef7UTdKg3yIKTvOdKnQuHMHBt49+9lJTy1na/uokBNNAT6e46XYkKiymZ9+wxtqePPZ8e3GT7moYbOmgIsPtwgILWZyMh3R3hEeOYzwOqTPxpU0kHSotAdPx8mbcWV/eIlhODmB2QoM8Jslc0XCZ20HNj4/pDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChvmaAmw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso3288416a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734122885; x=1734727685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rva9khKUh5S4eyCpPUaDoZslmuYjcHZJcPqbOE/Ftxg=;
        b=ChvmaAmw+ndo5NNkae/CNayo889AkDyppIE/3jbZIAqiTcj6YIBtJTwwoYTUmhMmoM
         MgbkLXXum/F73FnVI42PksMV8KV+qtnbku5SOqXRRK6REfY3CWSRT6WnZN7RCAXVvIje
         pJZyIeshCgoh8MAppHOGPtOo9TXHv/RmC4lu7e3EWqOlEB781b+Bu0VrreHdrrS9a2yf
         II5Ar4H1ByfBGnRKGXFugXfLp6AFm9sdDJXFtcn2NYwgMP1QLmVCvUeEUnxyHcLBjEvx
         6SAhQ+OH4QnnxHci6Mr98xE8+4y8g8k31+Fixm4IV0hB9AWrug3XpITDR48P0qK7OmDQ
         ka9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122885; x=1734727685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rva9khKUh5S4eyCpPUaDoZslmuYjcHZJcPqbOE/Ftxg=;
        b=uq7Zc/bMECppRc/4OeO0MWHmCjYtjAVx0e+mkebyswl49RuP4BxAwpWu4uwwiPNobQ
         yTkg2xQRoYnYOkdCafE9ou7k2WtROva17fvvNaZaZBxnhnBGa3KYfjfhz/gw//U9CLSP
         UxL86Zi1mt9RJ2nA1LiUj8mQ3Oew6MLusT/+wXHQhpz69tYZe2d+aR8Eb8VUIS8w8I5F
         umh3QL+JqvJogWwK5A6+RGY/hBD+xM6j/Ax4H9d5N/s8rkgp3MTvrOv89thNXW17Xje0
         G7GvJ4O+r5Cg3A1296f9Ng7vaj0Ksilaf47QdbS9HUeho1wn2s6emJVHiO9xBDXgg484
         43Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWk5fxN1W6lyWu3SQjRTnpVwrLY7baINCBK4epZ/rxbvhnwaZIbIbpoSOTneNozVvmJ1qDQ7Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgkmSTZ1HP17pPYyVcs6rJGV0L0GGHdWGOPTjdTWZDdr17X42
	BIjx++vJOQ/MuU5pvoeLK8acpKib3mUdAjYU3sfpjg/9kffW1fB++dFm3cwQ/BZSAsg79Nel9NY
	/+MtRhOYZxKG9JNV9q/iEGf66ts7mXfHQVP4s
X-Gm-Gg: ASbGncubI/eu8eWCQPR2XgzllTjcpEOJhkVF3prJ9laVEOPENUqSIxpP7xOSghz5K/T
	2rV+yR7ZwrL77IQ47qJpVtydsdQTJEIBZhjo6
X-Google-Smtp-Source: AGHT+IF23UoUb/v7LLN/KNXAmcOZlXPcDLJ8NDzKHipziUTtTxthBjTorDj0mtSfhWZgsX9bVXiC6pWSvKnnDEMCB/g=
X-Received: by 2002:a05:6402:34cb:b0:5d2:6993:ad91 with SMTP id
 4fb4d7f45d1cf-5d63c3da9a9mr3353320a12.32.1734122884514; Fri, 13 Dec 2024
 12:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213130212.1783302-1-edumazet@google.com> <20241213130212.1783302-3-edumazet@google.com>
 <20241213201641.GH561418@kernel.org>
In-Reply-To: <20241213201641.GH561418@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Dec 2024 21:47:53 +0100
Message-ID: <CANn89iLHSZQcejDktwE8gb2L-vJGGzO1+eevZCqbkQ+=Cr3_6A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] inetpeer: remove create argument of inet_getpeer()
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:16=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:

> Hi Eric,
>
> With this change invalidated is set but otherwise unused in this function=
,
> so it can probably be removed.
>
> Flagged by W=3D1 builds.

Ah, right, I will fix this in V2.

Thanks Simon.

