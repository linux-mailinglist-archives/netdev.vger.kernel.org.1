Return-Path: <netdev+bounces-57474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACC813246
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A47B1C20AC3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915257882;
	Thu, 14 Dec 2023 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NInP5snR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C4B11D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:56:11 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4b2d08747e7so2153726e0c.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702562171; x=1703166971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2yKAEncwRm3uBvSmdHVhBg2GFoJmldNAoOXza5tMHY=;
        b=NInP5snRlp6oc/H/Eyyi2JkKvvEBS7VhUYVKCnojCU7LpPCnhCJuN1SaD2NEuJJ8F8
         S9BhNtWVyP74RU55fcAws1isix9iMmIzKPwOFO5/l83FN92gDA1chHq28XGwtTW6gnT5
         YD6GAxT8mxRikD4gjPyVaBfNvDi9CI1ZrCD0hxCmIXM8pJ8IKuVpOF27AAvdNkRaTlvO
         z6HQWq+POsR/Teg5O3LVsdTHgDGbJJUvDQUacnOO7t7mcWawRXq3HZLVEuhtAVMmj4/I
         Wf7fXSPRYx0Tz8Ry5fWyApBmfkn2n//+XIswVOp4lmCLRDEIynYfgNEWVa/dOUvsN7SG
         KUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562171; x=1703166971;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2yKAEncwRm3uBvSmdHVhBg2GFoJmldNAoOXza5tMHY=;
        b=ngyXIOXFx6W6o9Ns6fNzNaLGL+9ckJZQggxbdrYjGIERLyjiAtBqinkwCFvkuJ+l15
         WkZy0NbtqckJWGi8n/V7IwLNiG3AjFi+Le5rtVfLuwOB1UJFp/GsUw5QWdXIY3NUfwOb
         QiKkxkjOFviJlbzG6rNZj7fRPZ0VKU8oomiY1JwyuuOWdG5jZh6MtyGLvXzZolJdv1jU
         LzoL6f0+8JTVsc4BCu6RXk8eubpx9/y7XKk8YGuXn4LKkMR/7zj8LFf+EBDHAzsUUnHC
         rOnq++d/84UyxTUE1IsBZJIC7b3TsQwSL77rW8NGuVxhevgnPY8LqIPgq86VfSF9MDI4
         MK8w==
X-Gm-Message-State: AOJu0Yx5f3KEVZwpxvU7ybtvaZ1FhQipqsmLP1SMXCsELy0IjGGWpZ1u
	Yv1jJYzcmae6kOZ1vi2d/Ns=
X-Google-Smtp-Source: AGHT+IEIkQ+rCDqLW5UOPkQ3DUdIKh8+TYJ54MRwQQXazFK6k7i+QrF8C8YAuc12EW6lb1o2n1fKDA==
X-Received: by 2002:a05:6122:200c:b0:4b2:caf7:cc72 with SMTP id l12-20020a056122200c00b004b2caf7cc72mr7687380vkd.29.1702562170962;
        Thu, 14 Dec 2023 05:56:10 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id g6-20020ac84806000000b004255638e8b9sm5772991qtq.79.2023.12.14.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:56:10 -0800 (PST)
Date: Thu, 14 Dec 2023 08:56:10 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Chao Wu <wwchao@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <657b097a526a9_14c73d29495@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231214104901.1318423-2-edumazet@google.com>
References: <20231214104901.1318423-1-edumazet@google.com>
 <20231214104901.1318423-2-edumazet@google.com>
Subject: Re: [PATCH net-next 1/3] net: increase optmem_max default value
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> For many years, /proc/sys/net/core/optmem_max default value
> on a 64bit kernel has been 20 KB.
> 
> Regular usage of TCP tx zerocopy needs a bit more.
> 
> Google has used 128KB as the default value for 7 years without
> any problem.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

