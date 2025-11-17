Return-Path: <netdev+bounces-239177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41119C650AC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B83B4E5C0B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57822C159E;
	Mon, 17 Nov 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Loh+SqJY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D02C0F73
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395548; cv=none; b=s6Q/43S038HcDrFOlp5iArvWkPjvKOb8+FQ8fYLAPZ8vSIwgZeL3Q5X0L/b1jiIWSlpSU3jHjPaKLvuBR5r+PfNut89JZ4PZ0sEsopYQRV+y/LWtSPNhSTwF/FSiYHKWiTpUNQd+w3gJlM8dU1z5aZEE6HyauvRG+LRaBgOKMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395548; c=relaxed/simple;
	bh=zR11PadUKffBVoAS2I53jVhWoEUv6Rds+RYWfmCWtD4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=GArd3GdUrnOFdFrHAUHB/nOTUBh+K0gbs8j06Gee4+ecfK+rCCTjAQiClpHVk9DHlkSLw1HDkaUcNAgG5LK8DsFnX7/gqLcmo3tqNoSKrSGKr/Y6ZVzDnYsKxHwpUf7dbDPku4fb1BGoCdJbZ22+WYpLjydsWWk9u6l2N9fXXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Loh+SqJY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so17729555e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763395545; x=1764000345; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=veP6ZsFPLmRwgmCdpo5pE77+0E1WbpqRaQfM3K7/5S0=;
        b=Loh+SqJYiVGQEAVFX0kxXdZpT4MKZ3u7QInsz1A2u/ZPjbwsFHAFD1x8ta4i/soq7D
         uEZgOgQm4DXKF64R3TE9ROsAQPdCkFJXKFdabHY0jYzVNyLjX4TD/W4bEnsZNxY5YWt7
         rTH6hufZsCMPPOxwMpeNW/UoG4VTYsh6cRfFwDps6hf4QZuWPx3MrAXB5zU+q6Cs9B4C
         jBfRtyCwuA607Se5to40ev1ec9AbrA9Xp05tIjDkj9TlMQgDkmJ35tZ4smi5G1UEanr2
         smiagnzpf6tw2mLcMp8uigGK1J2DEQJwoqdc8waNBalKJoMoR1SheZXw0an9dp+1Anhg
         6wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395545; x=1764000345;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=veP6ZsFPLmRwgmCdpo5pE77+0E1WbpqRaQfM3K7/5S0=;
        b=lFns6xybASguhIN+AjY7dScSYMlpRveAzcLhC/Tu13ZdKXjIAhmm4oWpnJlqE9axMp
         bZgO+LT2yjM/EpNMgYkHHrSmy4Zeqh1rq3KKKgdF39DbfCmusG9dJdp6hzFbxiVJ0L3y
         temiy8tW41PMnk2t6YvdqLHN5Kos/iWnAZ5CBZH1vAIdyUfIyQhZX/FJM5+XTM8vq8JJ
         F/r1z/6Axx67z6b1s1nIHsI5UVNkZJtTrKnJ8pmx6qjRzLcB+RQR9EbAozpVc3Uhmw9D
         Yd7i04f2mObV6IRqpP1Lh3TdKBPnAj/s85WGK5kCePlUH5Lwhou3M9lPZMDNBgEwlUKi
         tzug==
X-Forwarded-Encrypted: i=1; AJvYcCW/mhGEClaFqFHBG7W1yrTneC0/Lg4RmOnZIYBXyrSILNm5PZZHC29AfKpwfAAfxENbFei5tFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjH0xCGVtKEvJ4rTBylyBEGrdoUQrVWiLFPCOoD9EczCXSn9K
	1Nyf2fX4F3uOoS8lLGfhBQwPtNgF/zMWATonFTwFYTux8VvrP+YPXSHB
X-Gm-Gg: ASbGncvIfAXaa2pPGCdgGI1bxXnFGbHQhup3uHWmvo4hQwAtQWtV9WaaU2KrP0jE1KF
	VoG57478ZT1+Ado4ZZboUuRbLlXc0UOfYjK4WM8lWGT9V+uS2+x1CwVxFIQlceV400fHWsdZK1x
	5KHu3uyrJd5nqsYhHN83f+c4x4DtfC+br6gDZEBBV8BEcfsjjZq9ML6cT2WaYw8m8MEUVV582jJ
	JH6QIMltHR3hNp9n9N5Yq8V+CaNR5E5jjqgbZ6LyupTQFhzfYS81AuU22wXOppkefZc/epl+cWK
	dgd6DFXRMN47PKHcFJWeW34q9flFmCCP2UMLVYbXJfuYo/gU4jgBBqQm21rFJEyiVUqWtZNKPxM
	STYXSDAtYQBP7n1HpGv1N9aLnxRrS3VkhRBwt7zEY49xRV9Jq760ZW7u4wp4kOaneIKPkfdVol2
	g3ChLu1KwTvkYZczx0Tae97kAv1AkyfhPfpA==
X-Google-Smtp-Source: AGHT+IELmBtYaKQJWSaqOyfivRd23QI/DFTaZg6tiH7/6qdQirofoDu9HP7b5w4rLfETnNrziPkg1g==
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-477994bddeemr52518145e9.11.1763395545080;
        Mon, 17 Nov 2025 08:05:45 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7408:290d:f7fc:41bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779cec0f2fsm51154305e9.10.2025.11.17.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:05:44 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  <netdev@vger.kernel.org>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  <bpf@vger.kernel.org>,  Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next 2/3] tools: ynl: cli: Parse nested attributes
 in --list-attrs output
In-Reply-To: <20251116192845.1693119-3-gal@nvidia.com>
Date: Mon, 17 Nov 2025 15:57:21 +0000
Message-ID: <m2o6p0mz32.fsf@gmail.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-3-gal@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gal Pressman <gal@nvidia.com> writes:

> Enhance the --list-attrs option to recursively display nested attributes
> instead of just showing "nest" as the type.
> Nested attributes now show their attribute set name and expand to
> display their contents.
>
>   # ./cli.py --family ethtool --list-attrs rss-get
>   [..]
>   Do request attributes:
>     - header: nest -> header
>         - dev-index: u32
>         - dev-name: string
>         - flags: u32 (enum: header-flags)
>         - phy-index: u32
>     - context: u32
>   [..]
>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

