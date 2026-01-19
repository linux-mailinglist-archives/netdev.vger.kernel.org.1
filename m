Return-Path: <netdev+bounces-251303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5F5D3B8D2
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35F2430142E5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1533263F34;
	Mon, 19 Jan 2026 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="VCU5/KOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37282231C91
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855606; cv=none; b=Tbh8WWCgg+w2j28p42gbBtspnWatXo/dd9qmZ3xckehU2p09Q7aVe1rrrUTXGboKeLTVpJ46B90Fa7iWY01JxQAxEbkRd49YwkbaUhZTAUr43yeu1bVwxg3DfEBXdf+Z5br8Q5E/u/3rulyp05+nnHO7+RWplkA7NA8VNuK4MUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855606; c=relaxed/simple;
	bh=GThpleLyVlAzIlq7NuE8Ybc0GuZ4EhZQkax0YhHOBP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eV+pXEEd2rTawcT3wY8uk5VSMjTPZpHQjJOmHzkZQwSSpZGnp48zw0C48wD10csfoRls3vLewWcYhQQvGmVAtIWRsgaDmFlephRXE9t+z4OQRFcwhKKQygDLiKX9NzfPa9G7DwwsNw6u9+GQFfHvAnQMsLkUzkAQdF5OKI6GqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VCU5/KOT; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ae255ac8bdso8544376eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 12:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1768855604; x=1769460404; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GThpleLyVlAzIlq7NuE8Ybc0GuZ4EhZQkax0YhHOBP4=;
        b=VCU5/KOTLtwnzkNNi24bWWknbQiIG/v3iEMWWTpPeOBf6TZDdE3MJ/YSpYfEVNVtYI
         2OR1gxWqpjfW9Vm/foo3mJkIFBH3xKNTo5wfbF7O0YjFpFzZLO3IUPTyofuzCxtVn+EK
         WCjb9IR3k3kAXmrgtBd2t0tItaFwxv9DCXZB1jHKY0yy8goSVSC4o0ITCgbP1HU9XdQR
         Ab7CtDh+0DvEcneczqnmRlCDH6X9hP+UlLQ8T18Ti7Ag5vi1MT9y03qvPyxiN5wW9kWJ
         UWta2dPYOArUXAbUUxTFtutI/Vmr6+9Lx/9vIPHzeRaKc8tN+xVWyBvYQKFj0FRcRASd
         UK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855604; x=1769460404;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GThpleLyVlAzIlq7NuE8Ybc0GuZ4EhZQkax0YhHOBP4=;
        b=T+WfbzNjOXx+alM+W6IKwA3hXW1sCWWOF9ydFS+IPRq3rJ4cH8ziPKy58LGJlL7mzy
         49QNsHs/wkfqClNnKaEW2Q722o8dqCHl+pn4etkQjx+4jUVtx+moIvadKctDh9r0Cro8
         rJSaalD4/WgOk7komnsQYmt8ghLQSYvNFaiPapzWrFg2PPrkeuVMxYe4b4DW5FVKxwb1
         K1gSC5cSPf1ZEUyiKISRm6BgN71q4n0MIsUyht/Fg3NG4+LcgOqREJyFBJOn8L7lK2tN
         vV3SLol8QjWiW/gfx8lzbhKJPPoYz+8jHODRf2Rre+us3NRowupM7usvOiuTtmZSi/9W
         /jvw==
X-Forwarded-Encrypted: i=1; AJvYcCWgNAawJzJhQv2sln89iCZrKWGcwPTjSTjOSv8yPoQYWXNtWrjOkDlJHBvYSkavTaXJRMXxpwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZ4kiuDvIF0PVB63G9k6pUOswawgLMZm59jOviVFnbPQUfzLi
	xcTqc/+06oYraBvrZ4DiDU9cwxl1bl+O0EIUff1arV7Bq0wkP01fqbKeBMhBd71gAQ==
X-Gm-Gg: AZuq6aIfDjGUndteF+ghNPmFy7eWWg/2ecyfKRATrR9N+/afCkbR3Qk/FXJ8H/9OU7I
	k6jIp2DH1qmptydZIvMj1gtVIy1DEaom8hWpis4q8FeWJj4ha3CGuXmWifgB2VjU4JXlQHfDfB2
	EsNquQ9UWH7AxGc/xQEet4iUPbop8iSB/EFbD2aiKwnLSlQr9td6Xxjpk/3KQgiJEQ77kYT2am0
	5ZH5FsoIGAqEfcQDfJvUgOgQJNrfZL3UNColpsFE42K7Y4PDgu9E7BESVti3sfnrbgUzCwPW9Y7
	fz6pkSbuS8m1nahEDF5XiqLDtdBSXGt0IMp72g1/de11ikHzlJQckbp64GzDV/4VSAluJiAo9RU
	H09NldEBE8GXD4Kr2UPc2yLH+3pT3Oj2MRIedJ0LGWINoiY/iuDK6cwZSrATEr/Md+9ylaDtyop
	xW/jLbqpf6GGOq1oEPGjnSO3EmaLKy2IJ1UqPMjAqbZZM=
X-Received: by 2002:a05:7301:4196:b0:2b4:7c92:3f81 with SMTP id 5a478bee46e88-2b6b381df3emr8278030eec.0.1768855602827;
        Mon, 19 Jan 2026 12:46:42 -0800 (PST)
Received: from gmail.com (209-147-139-190.nat.asu.edu. [209.147.139.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14264767eec.14.2026.01.19.12.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:46:42 -0800 (PST)
Date: Mon, 19 Jan 2026 13:46:40 -0700
From: Will Rosenberg <whrosenb@asu.edu>
To: whrosenb@asu.edu
Cc: Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: ipv4: cipso potential BUG()
Message-ID: <aW6YMA11KFzSkgfw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Previously, it was discussed that skb_cow() has a bug due to implicit
integer casting that can lead to a BUG when headroom < -NET_SKB_PAD. We
concluded that it was not worthwhile to fix the root cause and to
instead fix the symptom found in calipso. The thread for this issue can
be found here:

https://lore.kernel.org/netdev/CAHC9VhQmR8A2vz0W-VrrhYNQ2wgCYxHbAmdgmM2yTL-uh4qiOg@mail.gmail.com/

I recently reviewed the use cases of skb_cow() throughout the kernel and
found that cipso_v4_skbuff_setattr() comes very close to triggering the
same BUG. However, I concluded this was not triggerable. Even though
len_delta can become negative, leading to a negative headroom passed to
skb_cow(), we do not satisfy the condition headroom < -NET_SKB_PAD.

Nonetheless, I believe cipso is using skb_cow() dangerously, but since
the issue is not triggerable, would it still make sense to patch it?
I figured I would throw out a quick email. Please let me know and I can
make a similar patch for cipso if necessary.

--
Will Rosenberg

