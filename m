Return-Path: <netdev+bounces-159567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE373A15D81
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B75E1888131
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF86119408C;
	Sat, 18 Jan 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c2+0cs6L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34C191F83
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737212223; cv=none; b=BTta8XwuARpr+BpOjVJj3vxjm/joUNKR8izrbPr9UnrOZCbUeKrvbchiBIDBW1NWNmzL9vprx5SCLtryu03dn3g55Wg6guthGF1yCoznSQCyg/1baLbA8hzcuX18RmpDk+BT/5Cd7YLuKeyMZ/zc8i9AMtfBWbQRzCiCTDj93Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737212223; c=relaxed/simple;
	bh=0NHPeW6qzDJKyKyv2LwHCzsD698hpuM+Soh5q7bWTbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o869PWuzEBwxawCdapRVOA/7+RPs8q5fAVZv57NWMCepmv7qgBznE5MexyXBxEx2LXL+ep3JbxTEm2yRHZSGYtN178SU/AQ/p0oynMOHV25rJ4IZdPm7EshV3PGe+8JWFjjxiCDkqZjuSRP9GD7kXbJQWXv+OopPwWyIyaotpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c2+0cs6L; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d9f0a6adb4so6190998a12.1
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 06:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737212220; x=1737817020; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EocVmcdr+s+eiVI2gdxLwDypgeYEKTEqnZdPS6MtY40=;
        b=c2+0cs6L8hAmDImKIpm6CJUfE9wjeLBIBE48ER01GByH146T44N7zQbjL0CaUYiHOs
         F9SLD+hydfEw9wJsm0nobw5hk5kibrb2JcTafsICKy8IGFt3bafjIVYZUxS3XCaD5TQo
         kOh2gI939tn8A3ble18F4/iYVoXqq5X1ez84lTO7nfi7l6ZzZi3riA8qcsCiVZ1sp+Bo
         /XoEvfThEJt7/44wGpcXtO4FS4Da9K+YTkKWcRBjLubvhrod7AXAz85vi6fovhsku5/b
         td0Tgc+yeqTitxUP+c+J+hYFm5Mc5xbaxiMrXdDUmlBpzm/fFPnYJMSTasVDbzSdhgmL
         xZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737212220; x=1737817020;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EocVmcdr+s+eiVI2gdxLwDypgeYEKTEqnZdPS6MtY40=;
        b=EmRyKiUX2XSy627UdyjxhLg++myo+dZi9Drhw+4h4Xjj1FyGa7QcPb8km33wxByVpU
         NgtPDnpQVksUmYayMMxKDp/rsejD9XryroOv1m6Fw4IFc2JCgsEFO2+F7l/QBiPzNh4C
         lTxFLiVn/4rvlCc36c2D2PMmbrwZaQRR8Q2vzupZRvSpAo91daHtAPGWGN6ZLpGLyFe+
         aOBICLv13z+l81TAKhoUvHHRk/ZFDJA3UR9ko0JITJiywB7KtIb7Ob3WDewVv8+8Aib+
         sIcWODq46bQDt1BnlSuU+vbQM9mfO6K6pti8uWkcVXGWUOGtXbAr+q3kyJ8wRB34sRro
         Ea8g==
X-Forwarded-Encrypted: i=1; AJvYcCV2v1SfFMRkKJRPbR5vzZ1Wv+ysBxTI7Sv5B7yDBSsln7AoVl5RBcguiA2n6ZpevNCVwO0b/pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhfVAqjPxRNXdz0yRdafoi1EgKlUwf87ROVILyQ/Y/i/sf70C
	kBFKkiVPOe5MeAy5eoDSTT3wHLh5vVRMV2LPxKzG0ufsqJ/+lyVhsWM+vfzrrcA=
X-Gm-Gg: ASbGncvKXAam2ncdOMyCkcpeosxRF46MNEMFJzCBI25I7tP8Tvogkhz3V6P1qZANQIO
	1RDjRqZVM6VxTqMej4heouLoXpUTuM057oWcsU6KT9QR9rNqKxnFw37UcytjAkxMxK4ekRW/x2F
	WHACpwr89+ffMLkOz1GDpiWkjl0WxArZrqXCFzv7xviwuJtaImX0oP+QJQti+R/Bq63rbCJ/JqD
	z9reGfqYoFUNQM1vyjXscT1UpbamLdhPvHAwH+9U6HiaV7vSk6Rd8/dKv3Y7A==
X-Google-Smtp-Source: AGHT+IESevYlMBNi2PmR28hKWZ371XolKifqyy2lHOUQAsdFLp4R497eQossqBOZ8uhDdvfVNH8xPw==
X-Received: by 2002:a17:907:3f97:b0:aa6:82e8:e89b with SMTP id a640c23a62f3a-ab38b166589mr543353366b.28.1737212220098;
        Sat, 18 Jan 2025 06:57:00 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5ba0:d60::38a:14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f2244csm350261966b.92.2025.01.18.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 06:56:59 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v7 1/5] strparser: add read_sock callback
In-Reply-To: <20250116140531.108636-2-mrpre@163.com> (Jiayuan Chen's message
	of "Thu, 16 Jan 2025 22:05:27 +0800")
References: <20250116140531.108636-1-mrpre@163.com>
	<20250116140531.108636-2-mrpre@163.com>
Date: Sat, 18 Jan 2025 15:56:57 +0100
Message-ID: <87ed10dvba.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 16, 2025 at 10:05 PM +08, Jiayuan Chen wrote:
> Added a new read_sock handler, allowing users to customize read operations
> instead of relying on the native socket's read_sock.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  Documentation/networking/strparser.rst | 11 ++++++++++-
>  include/net/strparser.h                |  2 ++
>  net/strparser/strparser.c              | 11 +++++++++--
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
> index 6cab1f74ae05..e41c18eee2f4 100644
> --- a/Documentation/networking/strparser.rst
> +++ b/Documentation/networking/strparser.rst
> @@ -112,7 +112,7 @@ Functions
>  Callbacks
>  =========
>  
> -There are six callbacks:
> +There are seven callbacks:
>  
>      ::
>  
> @@ -182,6 +182,15 @@ There are six callbacks:
>      the length of the message. skb->len - offset may be greater
>      then full_len since strparser does not trim the skb.
>  
> +    ::
> +
> +	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
> +                     sk_read_actor_t recv_actor);
> +
> +    read_sock is called when the user specify it, allowing for customized
> +    read operations. If the callback is not set (NULL in strp_init) native
> +    read_sock operation of the socket is used.
> +

Could be one sentence:

        The read_sock callback is used by strparser instead of
        sock->ops->read_sock, if provided.

>      ::
>  
>  	int (*read_sock_done)(struct strparser *strp, int err);

[...]

