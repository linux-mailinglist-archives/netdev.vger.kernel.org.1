Return-Path: <netdev+bounces-115316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED4A945D28
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22B8282BD7
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458C71E2118;
	Fri,  2 Aug 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EhPYw3Af"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB061D1F4B
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597635; cv=none; b=LYALqR6hgSneYQ5qhW0A5i/B5FpPavd7+MioHt8ARv6Bq/4a0FgqiKjDf3eh7CCVxjx5qEUIT7eRblnlH7fZc8bbIG/XACAZFNvV/gascU0tgTERy9/0w5+PlH5n3TZN6378FgLod7cbOv2LTfnRQiZmipTaVeRrxps8S4IVbDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597635; c=relaxed/simple;
	bh=ahVW27mFm4tKufePWHLVWyZ/GW++VPFGJbISeuzLUXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U8cyQof6Fnul4icfKzwOQOs1SBFJgftFysh6YytHqo0P9pEzcpCFtyW/uC4yzY8R/TXk59xaDQN1oq6wdfyA89kea9yt0SUZrFd5vfBWE5SxkVBMpWjQ2JeXHt2UO28qkGq/o4tj0QizSXIR6AzIQx6TYkYxuyVgxYnKqtdLXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EhPYw3Af; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so5547999a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722597632; x=1723202432; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bp0Lv7R938kb69AhH/RUpNk52nvW3s45fMjR04Xwyk=;
        b=EhPYw3AfnSDv3su+CRVQe8k7E5rnxiU5b8+YpFSZmvuiGcZbmdVWTbFrkHnnkjUGm0
         tkWa8H+9nxDRONfTJG2Zc1VPacyAqh/AlE/EjK1/fyc6Dde5Qf9VNXueahAPNi0gJ4aA
         qTN8XDHGYER54a6BBF9DZb6Qs4iy9GZG4OiY3eVDOv6tSTGPuHi3FQdyuF1cozER2jvR
         jqu4HUhOheHvw12f5Lc69QGIjLAy5xTBxSBKAa4nZx4RiXswwzCJYFPpoQmZNEKe1EGD
         UvOwXSe9wq4dcgy6aoSB7WYCAYDLvuWSlk7+oIl2HAo0cOmUYzdoQ+iJgtJuWzRYrlcv
         lv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597632; x=1723202432;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bp0Lv7R938kb69AhH/RUpNk52nvW3s45fMjR04Xwyk=;
        b=fogPvBdNJ9WiQERVcszlMn7Nxn3jHICVN4kZBDodTcX3qpleFsO3Vz4D1lb+5+bFGS
         p4dkZ/GBcT86EJnxrsPvA4tlzZOCk2rpwLn9N5rDAmhysHXtTWRgjP1bmauGwMF+B1Wl
         sGvSbJlJN7RCY+vzn8iDF2LbWFzc19tEWvHDq5JC6EX99NMs5e5BbIGhl8xZ4xh7g764
         +dK8nhTsQl84HdrAqSZkX5/Ih5k0StaQ4FlKct/eW5Z+WlnV6vIGKvrCRvTnFoZWcDjY
         q7UtcZeLAkyJKPiqBNrXQuZRv4eNPxXL/rf5uey76FIBhhsVfOZPrb5tqIP/q1ouhHbp
         ZUOw==
X-Gm-Message-State: AOJu0Yw1l2EUJ8BnJQaRAIpEaklxXSpTtWHjMyg+uGr3WWvlRX9bS9oH
	KOBZI6X4M/F+VoPm8fMJG0wOb4er7GqWLp4loj4gRXyd5bya2mCCzhq/S4dXwG0=
X-Google-Smtp-Source: AGHT+IE8kXYEwxyh2rF5/J9aD7Dl1W5CwWPprLc67eBJ2XZXbvCKMs6cyZYrUE9gtmmuVgAEnzrQAQ==
X-Received: by 2002:a17:906:dc90:b0:a7d:895b:fd with SMTP id a640c23a62f3a-a7dbcb9000fmr411014966b.6.1722597631730;
        Fri, 02 Aug 2024 04:20:31 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7fe3csm86590166b.162.2024.08.02.04.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:20:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem
 de Bruijn <willemb@google.com>,  kernel-team@cloudflare.com,
  syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 0/2] Silence bad offload warning when sending UDP
 GSO with IPv6 extension headers
In-Reply-To: <20240801183659.17c25cbd@kernel.org> (Jakub Kicinski's message of
	"Thu, 1 Aug 2024 18:36:59 -0700")
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
	<20240801183659.17c25cbd@kernel.org>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 02 Aug 2024 13:20:30 +0200
Message-ID: <87ikwjyxvl.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 01, 2024 at 06:36 PM -07, Jakub Kicinski wrote:
> On Thu, 01 Aug 2024 15:52:52 +0200 Jakub Sitnicki wrote:
>> This series addresses a recent regression report from syzbot [1].
>> Please see patch 1 description for details.
>
> The test doesn't seem super happy in netdev CI:
>
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/709100/79-udpgso-sh/stdout
> https://netdev-3.bots.linux.dev/vmksft-net/results/709101/78-udpgso-sh/stdout
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/708921/75-udpgso-sh/stdout
> https://netdev-3.bots.linux.dev/vmksft-net/results/708921/78-udpgso-sh/stdout

Embarassing. I must have not recompiled the tests after tweaking it.
Sorry for the oversight. I will deal with it.

Reproduces for me locally:

[pid   507] setsockopt(4, SOL_IPV6, IPV6_HOPOPTS, NULL, 0) = 0
[pid   507] recvfrom(3, 0x55fcf63813a0, 65535, 0, NULL, NULL) = -1 EAGAIN (Resource temporarily unavailable)

