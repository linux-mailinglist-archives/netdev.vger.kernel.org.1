Return-Path: <netdev+bounces-216506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B78B342AE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E5E1B21E0A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D82ECD32;
	Mon, 25 Aug 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1vV3nULP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6812D1F61
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130366; cv=none; b=XesMB6UEwXBPXHmzjkkVNg84lG7etPbFpEwCFeU8xZZrkntP6TnjyYqlHMembCFIIdRqLyjF6n/FuIKAGL/tjCvMl3zfsL8VuxKIUHcpogyO/Je9m0TpTY0OBgSKuOv1n42pkR1P7L3huh/6dpJFg4IEyTukJE/BVih7pDhBjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130366; c=relaxed/simple;
	bh=aENDtU7SN3nb+sH0t4FgGbaHhMkD2QD7dkaUBCnJUMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdqM+FtshURrdoIiFAFKOVLCnDzzbzNAaN/3BdQuGbgmYunk2ROd3aWPfwByK02McktY6cIxA7py/IL6gXdoJkNTpCN6ggX5CyD7YlD9dZQbQSsbDarUUdyKduvV4xwJRWKPgT+BhXIsQMdBagg5Lzz/NMovfgndwFQQbw5+EG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1vV3nULP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e8704c7a46so537813185a.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756130363; x=1756735163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7AcYOQXixbFv7ykzQpGuPz3LwvAdYFN1nVF8sWs+Fs=;
        b=1vV3nULPfQO3X/j3400lcEjOOuncD3NypojvcqiyaM1+ubeGGssYne8TFcrl+SEO6v
         K2C4eYA0BGBF2+TvaU57Hyx04+IxYRcVsuRYYwKMFUVd1gbj97nwgezc4y3b6A2WaJyn
         M8mtLcHIPmb90Btj8ZbC9Z6fcdDKDoTfLEFmYnB2VMGPnxR9P+jLDPyVHea8E/Va8i8g
         DmwkezcEB+y3D00qlcMr8r/WZH402mkLU1pJuwFY7pKRKL3F41ydcNCGmIf/XM9rKZEp
         0fRjRb9tr9Oj+D3a/tBz8CK/w1aPME2oK69mQwj9awJ3UTpqWylho8NmsSaef4uzMF5U
         nNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130363; x=1756735163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7AcYOQXixbFv7ykzQpGuPz3LwvAdYFN1nVF8sWs+Fs=;
        b=prYhX2AcP3BW/fuWo7K407v+tGJbptrl+JHTFI/fOqZ5XNrxfkpv+1Gnl2DLKc1Zcw
         4pLr6OX5USTFYJXhC3BnXYqUO6FBnyeyV0slkRHIlu9+/fhudQAw6ijgZxhU6bb+Hjc1
         zsOAZUoLzyoaMAsr3FgNoPOjXsHUW4n9YG4Jk+520OvPtMhW6W5zj9EPf8Q1pXxtzEme
         tOTc2aMsJtgtuJh+crL/fBPqPtBta93lQMpGA8YeBXXd+y3heuJCOe+y32zvBIEIG8eC
         Y6vFIPsOLK6k29ihru0Ihh0EtSE3Gptoq97ttrL7kB+h8xWHQbakGF5f92bGMmcuYaMM
         LHBA==
X-Forwarded-Encrypted: i=1; AJvYcCU9f9vdprvos1pXexmtGKkj7OSrz/sc5RRdSz6VW0BhD23Rjc9DSFMur2Z6IVDBZdjlMgZq01c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7H3KheFNHoQnxgqRLkFPIgLKXMKat0ZqMSPk2IfmswbD1wjq
	KLouViINd0zLmqYmWa2Ync+YpRUHb9dZ6ibnDv7z3aUnagEpcUVVMQt1jMwXYbLh0KghDnOKwE+
	2YBYD9ZYQNQtkoexIuyHBSkniKaW3CiBG/pqAR9ea
X-Gm-Gg: ASbGncscNXI72z5lVAZCQnZIo4N6Q19OTilTQ7Xw2Vug5+3UKYWXNSQenyYXft5GsBO
	zqRslYRZOKdqlkhc8L+uGOBZ/pRgcbhUAYHZ6Td5Oq0kdg8gP4bU/w2icHJNspBFvmCV8nTePXs
	OOJMPIPuhrMnj9jzdsIiAUOierTMYnRq/vAE8uWcW777BZODSaTRBukyD2GIpkdPBurMaQ/HOBz
	IB/seyZhCqE
X-Google-Smtp-Source: AGHT+IGW0Bo6dDN/OjygA2zGUopkllC6s4EeoANdDL7FtOYgRMhUA3qOMkCvCzq5W7Xlbe60H480YJSJzL7OiJFlTxA=
X-Received: by 2002:a05:620a:2982:b0:7e8:221c:c968 with SMTP id
 af79cd13be357-7ea110bb914mr1455309685a.65.1756130362861; Mon, 25 Aug 2025
 06:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822190803.540788-1-kuniyu@google.com> <20250822190803.540788-5-kuniyu@google.com>
In-Reply-To: <20250822190803.540788-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Aug 2025 06:59:11 -0700
X-Gm-Features: Ac12FXwu7VdxzddSX_XWWq0CVDpyTWWDh6a9M3dLlgIIaTLmSJ_7_Ee5j0hY_ls
Message-ID: <CANn89i+wyBVnG0nx0jeWodfeJoZ0-P_H+mzBTaZ5iRtkAKkrDA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/6] tcp: Don't pass hashinfo to socket lookup helpers.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:08=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> These socket lookup functions required struct inet_hashinfo because
> they are shared by TCP and DCCP.
>
>   * __inet_lookup_established()
>   * __inet_lookup_listener()
>   * __inet6_lookup_established()
>   * inet6_lookup_listener()
>
> DCCP has gone, and we don't need to pass hashinfo down to them.
>
> Let's fetch net->ipv4.tcp_death_row.hashinfo directly in the above
> 4 functions.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Okay, although this is a lot of code churn.

Reviewed-by: Eric Dumazet <edumazet@google.com>

