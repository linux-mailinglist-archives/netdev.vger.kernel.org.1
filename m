Return-Path: <netdev+bounces-229527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292D9BDD946
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECA9192388D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593B307AE1;
	Wed, 15 Oct 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjiL2/bl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8727A477
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518834; cv=none; b=mL58UAmLd7JpDEpZjDDXCYoJJPRbMkYEUu29jmKhkJNwtB/P4GJj4slUZ6R8HnD8FxgL7X+CCsC1yTqXS9Ub8mfgzCpCsDZiT+FgGwljmGk3o3v9DUxAqBuHvdW8On7I7+zjPC6AjlNs0m9CZ702cX18Di7t8xbJzdBczPCQuk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518834; c=relaxed/simple;
	bh=C7onbhn40nMQmem0pWCFzosAQoas5RiRttR8T9P0SDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMoOqWS1CxwUSLqoAs/8xKugxQyT2UBlSPW9c7U3TCM1QibQ7n3A4Q3DCBlFAk1qmJman19HDgxUpRRY4rVMPBDEvh1j2k2ZLh2ZIY71X+uRJ7s1C6Wl0drIT5k2bM76p1TyvrnXb3Sp7Xt7L1TZ+uJWiTWlqw+4ZadK3vMpnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjiL2/bl; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7970e8d1cfeso114384046d6.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760518831; x=1761123631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rxa5jj21S4jyKybCNN7B4da4OfcIehhPgrhvX4pviYw=;
        b=rjiL2/blPizWsbiVmWHkELScuHKdbegJsE+euy8lMPZXAGQ08J3ipe2XBS69zN3itn
         z2+x7OzKFgciKGgUgen4BgNqD1phFmcB3TfRQs8FyfPp3UvRqEQYF2sFedV3t4clnLtT
         kTHKSgP/HZeP3Fie/RIciSFjl6Wfti3t5NT8Uw6XvmZ73OdH8no8oC0JEmzspzMH9aId
         ZMDO50irt3aREdbESMz3fqcy1n3x4IKuntHs/JOrQjRq1Lesz5y66IyxcCxWgxkrYMFz
         41GxOhGg6+aQBFA3RUvFZ+F13H0xtcuCf3FqYCAiL8ftPoFgkfuBuxbYKB2GGMHBTngK
         OZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518831; x=1761123631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rxa5jj21S4jyKybCNN7B4da4OfcIehhPgrhvX4pviYw=;
        b=uxE5papK+kIO8yZLKg/jsEQ739M4W2xrD3uxTUUMiJieAUu4KU/larYx6mlzP/y3VU
         2NX8hUb6FOP6kJTG67WvAPujNPoGLt1QtobjOA9rYuJb5lR0zVndai2w3K69bCV0tqQr
         R6cjiAGmmDZgWUdnAwluS51v+3nVxeFmMIzgW3vqUCNZgjI5zyjx33qLnJj3SEtYgecn
         y9S09E5NTkhhsDlCwA5ZCl4Bn2xsDyGNxsKNvSDa0Flf3cNUFWQEE+J0QKQNgpvY5Te0
         xohGeOVjHHmALE/Zzi7MLIweszW/MP7iJrIFUlwj9hWGw+O9zC0R3+aLliiRT8gVDVxC
         Zxfg==
X-Forwarded-Encrypted: i=1; AJvYcCXZbM0GbGNzROiNVDEk6w9vXVI2yYbCyTMcpjJxKMl3s/FGgHI4KA0S3KY9v0zobAQfEC9iHpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylDMcC4QXh6Tu2bzclS9dRTqeMgMW7kCrQ4auiD8VScnSEoL7v
	k2vvC1RwPNxy7yZZfW1xBux5ASGxtzi1PCufFEJtCjsnequd5GWZVyyVdn70ypfjipNJ8Rfdxq1
	PAMpZPhVsUS7OfY1ZEBiRn+coWAHZtoEYpLsqj5+h
X-Gm-Gg: ASbGncv72USg0fbgpJXgFJqmZxT112yoklBICIeka/goe8nRpZK+wI4HzDiYJPu223Y
	K1iU4oNhF2xymjZBNlqgRagYSR2sMIm2lRE48ThMsmBsg3R1fkmKrZpGU3rfBCBs24ebPNtJM46
	wtOUunrD8bg81pOkYfB6r3bzttfL9b9y222taTT+2koen5qjK5Il+SlrpF3178wpVqDGUlf4iP/
	8JqzMDServfdgWygWrzEj1Do/wTFbE4Rw==
X-Google-Smtp-Source: AGHT+IGIQticENZQtdfb62fiUGbC+73/2T+vsWYy/+30ubkxYFSRCANaVNP13QoNndu2HGrd+YfHrnB0bqtLwUZMD0g=
X-Received: by 2002:a05:622a:491:b0:4e7:218e:706c with SMTP id
 d75a77b69052e-4e7218e7148mr162363141cf.49.1760518830670; Wed, 15 Oct 2025
 02:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015020236.431822-1-xuanqiang.luo@linux.dev> <20251015020236.431822-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20251015020236.431822-3-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 02:00:19 -0700
X-Gm-Features: AS18NWAWbkMMWRCmq9Kyi3kaeXCMh_52Eze5MYkEklW5vzSbbsFzWkAEaJSshUg
Message-ID: <CANn89iKvf6i7-Ku-iqYG0JoGqfiewx45ZVoYcCRzbDW7g=RDvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
To: xuanqiang.luo@linux.dev
Cc: kuniyu@google.com, pabeni@redhat.com, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	horms@kernel.org, jiayuan.chen@linux.dev, ncardwell@google.com, 
	dsahern@kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:04=E2=80=AFPM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Since ehash lookups are lockless, if one CPU performs a lookup while
> another concurrently deletes and inserts (removing reqsk and inserting sk=
),
> the lookup may fail to find the socket, an RST may be sent.
>
> The call trace map is drawn as follows:
>    CPU 0                           CPU 1
>    -----                           -----
>                                 inet_ehash_insert()
>                                 spin_lock()
>                                 sk_nulls_del_node_init_rcu(osk)
> __inet_lookup_established()
>         (lookup failed)
>                                 __sk_nulls_add_node_rcu(sk, list)
>                                 spin_unlock()
>
> As both deletion and insertion operate on the same ehash chain, this patc=
h
> introduces a new sk_nulls_replace_node_init_rcu() helper functions to
> implement atomic replacement.
>
> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>

