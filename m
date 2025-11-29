Return-Path: <netdev+bounces-242652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7403CC9370B
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C373A86F0
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1A223DEC;
	Sat, 29 Nov 2025 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP+ff1lY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E3221F15
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764385740; cv=none; b=csp2Ptm3yZ+qdS8lnbmnRKL4lywT3jxrDKif3sHGL+oaRaD9EvAnkr03vUAFVGbNA9ax3CpjZ+3V3xAHEAdMEDMQ9Q72k/lUwCbZEkNkmEWrCuPwOiqJzXPqvTz+vGwEIQq3SiwO8g4nRcV6H5Yr8Y+acwuJZeG/aOjEMR0OG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764385740; c=relaxed/simple;
	bh=/PZP3yAQumAvTqUj8cFxO/xQNdxZy4OkZQG461Pimws=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=epL2NpSlUhRaHo6ycwyqJ0ddHN+SDFdmFaNleu6VaKzsCpt0YksoW4v007zu6gLn6umjIhJA9MebWdxc81OTbbXeHG9VBI7gckJus4dv1zYOwm5mABBy2Dd4F71gXMyzEomM8cQJ7a/NfGNjH3qval4TPBkkje+OqdhxISrXgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP+ff1lY; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f9beb2730so1897697d50.0
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 19:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764385738; x=1764990538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKP9QMT2JZnZYL/pm9t1iF9V8rMC2bcnAu0ULKob60k=;
        b=YP+ff1lYYzC0pTfM43GF/XlRAFWhROeUGfZqDEiM65WdE78Pe+vADB8mOStfquBAzH
         2le6rUIZEttqanaY6FQcI3sNfgfF5y56jMRBzgXlYB1MsX9PmLNztDkKwBZGqbPlcJu4
         /4oPyu/aEKx2fiXemzI9Mc45kvYSYMxQGasR/BBPpz8vztfve3zg6x3wyrUHD0GJRtCO
         Rrja9I5JGagBxDI2r0bapPq0HBDnBQgQEvDq5bKwD0RdKPHZasAWCuCduNOthF72xd9C
         fl1GlNTS46HYRrSvl+z13Em3phkkx/QdKXMlBQMJGdv12SlsrLW3DGspbZ61GEtHc4Eh
         d9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764385738; x=1764990538;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKP9QMT2JZnZYL/pm9t1iF9V8rMC2bcnAu0ULKob60k=;
        b=rpzYrL3W5+B4yNH6aUoesGRzoSlHmrVjsmWuVH9TcckAws787Xb5BUv1mzLYW6MuGu
         EiLnAF2n8LAZGgXtGbSxN17Y38eFefVQoYP4OHlCvGXzPmgIqjLHRSKt/3Z/yagiBjzx
         4Xn4/nSLjmmtzlRCZ4rKBnslf9t/N6qlwHE0Z6ITlrahsLuNqjzkkdhDC04W7fig2VAT
         xppzdGa6htvA0xNPSnWWC8fnYMMXpGDA7bY4URd1vekissu9Nz72N7ZlBKyWr8MwZflO
         is29ArckTlJm9hha4cC4Qtu5PhcjcqmFookHbgWbPKYqOpi1+0Bsk1VqlXcJ6kbWr6Xf
         mGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3CQc8xbiMn4hiIj9fcTsCM8hViXOc904gqvBwTlDrN92jetTpZ0HVt4UEU9UVJEJRHbjNuAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Iob0jZqadkpw1jtw1ZgimNojwq3alpdl8UlY//g67i9f1jQR
	4qfn+AeOSUQ6VdY8b5ebwBBYYY4YIMCgrCGP4ygYaCEk434fyIh5SiUgRe7Qkw==
X-Gm-Gg: ASbGncurvOMb6oCwHUHFVLBA+T0Y+wDcxxskzMiIUkioDUTTAQI0/p8VjxKzsiDz2LU
	mFmkchil4y8yCXbKoaR/XTM541t//1BvD2bsMoxXQDy3A0l/HT+7IFcwroEfMJrNats59/NePg9
	PBHQr2zEtSo1YDVL8LZMbpHKmNLrBSrjo5aXLDm0JhaZoQG49qXfZFcNLSmpm/bO2LhlaHwJh7O
	lfV7YA16qm0MjVOTmDPXKWmvMi6TqtkHFtch7mT3F+TzvWdG9Qr6X7uRl9oOn8qhQ8Wh5gmKnvx
	89aHENRLila1Vg006rvhwSXUTbxMPduv2vMHhnWa8BoVyY58e0aW8MIKjYuwRFTPxK0ZpGgOh4R
	9Gr8dUQovIEGMpIRnNB+23UG3n0idEFIqvzTv0JtCRkrVB7qhg7BmW6GWWVXB/0TLHZHp6lStJJ
	SW/dytW5vljrHLIGIg6axzxe/ELn06hyOIBNb+uwZ7A2MDbpzj6PJLGQAOPTXoZj7BOvYfXCWUb
	NS8omRpIvFQ4UgX
X-Google-Smtp-Source: AGHT+IGYpcqbLsEsitYexRW3zdBcpnFckpxZnQFAdH0o6v5MgT8neurL+UA3Zo6zVsKYEWD+ES+tig==
X-Received: by 2002:a05:690e:4198:b0:63f:a585:14 with SMTP id 956f58d0204a3-6432922291bmr13857167d50.17.1764385738219;
        Fri, 28 Nov 2025 19:08:58 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6433c050348sm2106414d50.1.2025.11.28.19.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 19:08:57 -0800 (PST)
Date: Fri, 28 Nov 2025 22:08:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 netdev@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 "(open list:XDP \\(eXpress Data Path\\):Keyword:\\(?:\\b|_\\)xdp\\(?:\\b|_\\))" <bpf@vger.kernel.org>
Cc: Jon Kohler <jon@nutanix.com>
Message-ID: <willemdebruijn.kernel.199f9af074377@gmail.com>
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Subject: Re: [PATCH net-next v2 0/9] tun: optimize SKB allocation with NAPI
 cache
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Use the per-CPU NAPI cache for SKB allocation in most places, and
> leverage bulk allocation for tun_xdp_one since the batch size is known
> at submission time. Additionally, utilize napi_build_skb and
> napi_consume_skb to further benefit from the NAPI cache. This all
> improves efficiency by reducing allocation overhead. 
> 
> Note: This series does not address the large payload path in
> tun_alloc_skb, which spans sock.c and skbuff.c,A separate series will
> handle privatizing the allocation code in tun and integrating the NAPI
> cache for that path.
> 
> Results using basic iperf3 UDP test:
> TX guest: taskset -c 2 iperf3 -c rx-ip-here -t 30 -p 5200 -b 0 -u -i 30
> RX guest: taskset -c 2 iperf3 -s -p 5200 -D
> 
>         Bitrate       
> Before: 6.08 Gbits/sec
> After : 6.36 Gbits/sec
> 
> However, the basic test doesn't tell the whole story. Looking at a
> flamegraph from before and after, less cycles are spent both on RX
> vhost thread in the guest-to-guest on a single host case, but also less
> cycles in the guest-to-guest case when on separate hosts, as the host
> NIC handlers benefit from these NAPI-allocated SKBs (and deferred free)
> as well.
> 
> Speaking of deferred free, v2 adds exporting deferred free from net
> core and using immediately prior in tun_put_user. This not only keeps
> the cache as warm as you can get, but also prevents a TX heavy vhost
> thread from getting IPI'd like its going out of style. This approach
> is similar in concept to what happens from NAPI loop in net_rx_action.
> 
> I've also merged this series with a small series about cleaning up
> packet drop statistics along the various error paths in tun, as I want
> to make sure those all go through kfree_skb_reason(), and we'd have
> merge conflicts separating the two. If the maintainers want to take
> them separately, happy to break them apart if needed. It is fairly
> clean keeping them together otherwise.

I think it would be preferable to send the cleanup separately, first.

Why would that cause merge conflicts?

