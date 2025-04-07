Return-Path: <netdev+bounces-179975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7B6A7F04E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634E03A9CC3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47B223710;
	Mon,  7 Apr 2025 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2N0LuQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D1199235
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744064880; cv=none; b=ZOqUuhMg3X6JJQHwb5Csrkel2Qa5NVJWL1sDldls2BgoQryoq7fZQtMk6PL61uZ8F1cjPM2WGl1qxrmQTS3cxf4BvsHpHfCBBXzyR+tIEIcmeNABj7hTiULOrs+0WkdOQIS8Au+56SgFQaf5nMGMNU7g8PF76JCZTP5NBsLB89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744064880; c=relaxed/simple;
	bh=hpS31OidI1u1n619ZrpB0oeuFlCs2qG1imG8iMq5PZ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cG6R9a516jGC6Dvh82ZnSQhEPGPTNhSUuF5MhnhZBIwJ7UKP2ZrSgz2BPE+C57xhly5wi2eT4oBb/gPjs9rdtTkSUrOR7bvrITnPlVHgjIy6wGHlsrceG06Fu9ouRpYso78e/UQQhmOPl598DX0EzNiJ6+cLnMe53jTXsa8DJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2N0LuQM; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8fce04655so48148286d6.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744064877; x=1744669677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iTkYZ2z/iJ6mmWy9lefMkRZbYfPGltl7Qb840MKyJM=;
        b=A2N0LuQMvlhwIqYw7w+8fQN1VVGj0a7Kfiste2EOhJYsSfyzSqLnb+q356wEpSRjlU
         2Sxj1PQvl3yBQ7pYCoiTYh0unLExYAIjHoVXj0n2ukMaLzICUUY6Cql8lguLoFydnBnB
         mCl+PMXRKkZDIIv1X9quHlPdx5ONa0ep+rukwISWy+PqwI6/pbehk/I5zM3xs4Yf7Lo3
         P1kIM+Wo3xpWcwXAFu0BxXpGBNsDQ26fxMfvIdv/OF5u9PuvZa5nkUKXhvFgfpucMjy4
         9IzPpKq4nNr9ZXxvDlM/tmIfAMRHjxI4a/gFq748azMGmmYhm+yD6qQ9+3iU8r/0mgtk
         UZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744064877; x=1744669677;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2iTkYZ2z/iJ6mmWy9lefMkRZbYfPGltl7Qb840MKyJM=;
        b=X78TL2XHxIEyh6W8WQ0S6T+6oBkqxrinI5c5eDEh6aUfL4icjwx/ZPbTOcKHANLVtW
         KDUszRlHsOQt8kZVNHYYW6MSU866v31MTIrr1pxEdHdfcOSnSZysICPFLRVir7ooFXbg
         kkw8scnmXWwcRUzhDulB8D3tXU4oytE7/mzadewLrwxmGa53ihSYo5V4jZGS+szVmCE6
         3tbkxB34ZSh73bsVuyJfxP3CKpzSA8SnSFMyIj392V4UhWcOvLixroGqW/cJpYiKD6WV
         5e+ObjSLNvPkk/Agy5IZnm/A2bdN048GHLn5sd7Cs7NGJXXXEGGYp1+uDsunfdLLogig
         unjA==
X-Forwarded-Encrypted: i=1; AJvYcCXIF9qM8fprOO0+dj4C6rp9Wu/77RcJfczNkL8tcNAEX2oP6xlj+hp8e8WKgcvydnF7eTjn6zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mgZYc/TGilXamLstn8ww79Sq/PpdZPTE98kRzrg8JXhfuaXA
	J2lSAKk4JECfJ4IUuvMz4jOzwCdY6l2k6nmj+9tH+RX41sOh6ECg
X-Gm-Gg: ASbGncvMKStXstsmZNF7THY3WHbItbqbLraZEWzLWeYQbPkEKrJ4v6R4j2zTIFpPPr6
	hNW1FYfcrzqSjDkqKXYktp52/CF4HZJ1MQ6cWuh1dAVJulGWzXmQ4NseEKfQsIN1DEPNK1ySxN0
	faV3k/y4t+2hj7da3znkkURtnr0gZ3Cm+7+V9BRERkdpWiiOkWevs8J4BHTSFjARKnF51M8ALUH
	JAwvnwEIqWdDo//9v7i6t8X8scyo33ZE3DW8H7vG3KqJroJxwrsi8Z6Pcufb8CmFqr/fBxndkdz
	QnNjq6NrnMabWz1VjQHDkzS3GX01xomDUv5pCuiZMRTHhAiGGS+3eHrCmc9SglQzRxhH1DU+v4j
	BCJPDK7ncnjo7msBvDlDLmg==
X-Google-Smtp-Source: AGHT+IF7wH3xLK/rYNlyIjb0HK9OfoQ9BkV4iUYdrI1TogzY9W47TsRN6dfXhLaPj18ZdjmIjuHjrQ==
X-Received: by 2002:ad4:5e89:0:b0:6e8:9dfa:d932 with SMTP id 6a1803df08f44-6f0b74133demr153644686d6.15.1744064877390;
        Mon, 07 Apr 2025 15:27:57 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f14e993sm64386416d6.112.2025.04.07.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 15:27:56 -0700 (PDT)
Date: Mon, 07 Apr 2025 18:27:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67f4516c97bac_3bfc83294be@willemb.c.googlers.com.notmuch>
In-Reply-To: <41d16bc8d1257d567f9344c445b4ae0b4a91ede4.1744040675.git.pabeni@redhat.com>
References: <cover.1744040675.git.pabeni@redhat.com>
 <41d16bc8d1257d567f9344c445b4ae0b4a91ede4.1744040675.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 1/2] udp_tunnel: create a fastpath GRO lookup.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> Most UDP tunnels bind a socket to a local port, with ANY address, no
> peer and no interface index specified.
> Additionally it's quite common to have a single tunnel device per
> namespace.
> 
> Track in each namespace the UDP tunnel socket respecting the above.
> When only a single one is present, store a reference in the netns.
> 
> When such reference is not NULL, UDP tunnel GRO lookup just need to
> match the incoming packet destination port vs the socket local port.
> 
> The tunnel socket never sets the reuse[port] flag[s]. When bound to no
> address and interface, no other socket can exist in the same netns
> matching the specified local port.
> 
> Matching packets with non-local destination addresses will be
> aggregated, and eventually segmented as needed - no behavior changes
> intended.
> 
> Restrict the optimization to kernel sockets only: it covers all the
> relevant use-cases, and user-space owned sockets could be disconnected
> and rebound after setup_udp_tunnel_sock(), breaking the uniqueness
> assumption
> 
> Note that the UDP tunnel socket reference is stored into struct
> netns_ipv4 for both IPv4 and IPv6 tunnels. That is intentional to keep
> all the fastpath-related netns fields in the same struct and allow
> cacheline-based optimization. Currently both the IPv4 and IPv6 socket
> pointer share the same cacheline as the `udp_table` field.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

