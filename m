Return-Path: <netdev+bounces-99884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8860F8D6D58
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 03:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83DE1C21788
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1A61755C;
	Sat,  1 Jun 2024 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="P6BCgOqj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C514287
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206175; cv=none; b=J0kLrdZxVbgugQbvuiCduLjS/97Qrio+wYRRNBUF7o7Ucw7pwtgxYY0e8hQsAdfpWNIfXuWBg4+Iit5wAgLBbF5TEGLv7AzF/AoW3ingvbqYP3JUzW2wWgDDtZR6mxwy/yOJXS3o64tn3/nlw6AWR2wk3lo1mwGR+Fx0SfTqHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206175; c=relaxed/simple;
	bh=jkzjDY7vnEB8DqdbcGuw7ABHpoGpOOOicO2KkYgqYYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeXD749pArD8PZ/4BxHkjtXb7jOOCIrypIWbfsIak00NIvKhX3sBwsfnSOoe6RSiIAq6nuhcqvlCrVnUfi0d8OH16O6/LIEGrTdHZgMW8OkEhf+nLV1eGP/wGT1HEeSPbiZsDQo6U8ys9R7EUFWzFTMJs4ivzFKK4vipCk0tx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=P6BCgOqj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a08092c4dso25275967b3.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206172; x=1717810972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=P6BCgOqjCwEYkeAdeHdpygNBK/qpkaaRTAoG3Srt734tzOsdCer3T7xSEb8QjSZy+2
         DCoioOQojDkxUysL/G2PvHNUmDcM9YU0jKUERh8K1jpIt9kQeOALk4V4WaR4rY09speE
         G8eYlu48+epL/jS9HWmK4Mwy3V/c8H1IUyxUa4QZPFozfnxFTRt+JOAoG+omCPo7jKvf
         SXG8vFVQNcv+v827gegNe/z6fkWaphPaYenKBwVSr2bdW9LD4MAnTwdcTLbZz/MJ6Q02
         RaQWwT3nLZUhqYff2Rgqi9BlDjPOep9vpDxbzDUuReLbDtM9aOyYCDlY5ngsA+6yQyre
         D+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206172; x=1717810972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=Ba75hhym/YgRiZ26/unnew+x0qSOb5fU5tNyTWbb5eqDrRyKFp/atN4VaZLQmLy5sJ
         36L5GV3/5V6yjbmPhuhQIox2DzqYyMGZ4nMbHIExWyg93lO7iwdqVS/Zm5u3L87sVQsJ
         V8J+S+l4dZ+/+0HIHgZ7gRavqB4j9Dj7tz4OH7e4vEFJYapyHAENuExp5RZCMGPWxmQF
         3EQf1QCBmWGSwKnm21dnmcRIYWhnyFlSSkpb2rT4RZXm4guKZYbmvmG2WWPIsDLltHw6
         gEpfvsjhwbh1RzhPXRqX8xyt1pSvjbroSZrpkDZuGcDgWqQLcmpehCll7zin+QmrXCec
         upBw==
X-Gm-Message-State: AOJu0YwQU1XN239CDD+iQO2WpK+RE4V1GJBBEyTL/2EkVbrJjqL7AHcS
	+81PE42gPmKf0GBoCgFHXKH9A7tWPuVtGFZeaU5sM4HpFdN/qPEhK/JG3WADfQN0GE4Rqm44qcG
	TKsE=
X-Google-Smtp-Source: AGHT+IHxVHyrr3VrYHe1OY427vM5xOxlLkkCH+3te1HypqOSqMSXO5Gncg6Y43GhkUSd/fqXGDmlUw==
X-Received: by 2002:a81:e302:0:b0:61a:cd65:3010 with SMTP id 00721157ae682-62c7971cf21mr35315987b3.30.1717206172275;
        Fri, 31 May 2024 18:42:52 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c765b8c28sm5377187b3.28.2024.05.31.18.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:51 -0700 (PDT)
Date: Fri, 31 May 2024 18:42:49 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [RFC v2 net-next 3/7] ping: use sk_skb_reason_drop to free rx packets
Message-ID: <71a5ce50c3a2657bc9b28d5030e33bef112e74cc.1717206060.git.yan@cloudflare.com>
References: <cover.1717206060.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717206060.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 823306487a82..619ddc087957 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -946,7 +946,7 @@ static enum skb_drop_reason __ping_queue_rcv_skb(struct sock *sk,
 	pr_debug("ping_queue_rcv_skb(sk=%p,sk->num=%d,skb=%p)\n",
 		 inet_sk(sk), inet_sk(sk)->inet_num, skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		pr_debug("ping_queue_rcv_skb -> failed\n");
 		return reason;
 	}
-- 
2.30.2



