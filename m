Return-Path: <netdev+bounces-104217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B090B927
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B674A1C23FC1
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC21991D0;
	Mon, 17 Jun 2024 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LcZYx/gn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAB1991A3
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647759; cv=none; b=KvsABS+KQrd3OVVPyJ9CL1uY5yK/RjRIw8K5NRbJunSYEiGVuu52e/MwLMnJ0dYmc3iwMqwoLwpN2xFXZEbtl65yvrUQlhYCrTBemWhTrZYa1XfhTae6f4ITpltsP5tM6psU3T/HKp9y4Mu5kjwRXXcVpujoHz/eDArDj+6QTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647759; c=relaxed/simple;
	bh=jkzjDY7vnEB8DqdbcGuw7ABHpoGpOOOicO2KkYgqYYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgKBq0TfufooDU4qk+Z6bY+FvsFt0V2Soo5dFGN+fBejwbDR1e4D2WF69L7V3NsobMj8ZD6C91qdWhyNoDHSruWC9PrkACVlyxf/66yOE7ej4vHGbPh2X45GNMrGFVIPM3rSHRhrEo6OMX0uLIkgfrvaSifR0xZKyBNkOtIReqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LcZYx/gn; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24542b8607fso2439488fac.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718647756; x=1719252556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=LcZYx/gnJJsug/Sfl6L0zHhZRKyWVZgwrlhA4zu+CahJizK2gO5QdzMgb+0xsnzQNo
         evan3dyYTPgNvsA3sPaW8sr+AytInQBktb4lXU2wG38l+esEeyoDurHkJagLp+ojcbbO
         Gsz5XgS4Q1I62M4OJaS+obs0lQjRYApw6JH0w2twa8T4hCr3dDN8DDMmC67qLXKPPtSZ
         +mebRKNQ35IQ9khJsw7NSZbIKZGcYGpM1ITbxujiP0YCrvhazv1nAHkQC8TinfZwWzPJ
         fiJI7LXJB7shJpgWuFRf8NcFOgPrBcY3CApWsdywRl15SMCnvg5avCUtLfK0+DZYCjhJ
         12lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647756; x=1719252556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=GEwbvErZbsRowE+c6XYT6NyydSsTJ9n9XrWKOzt59sREbBKVnsyAr1P80CVW8x7j46
         PXogboTIZyD+gA9JhPAGh5oCEPGxVU/ApnbAxamkQX2JQYLg/OldtymS1qvrUWo/XWd5
         NAheDLahxg7A+PPTbT6EX5/rEgRU5vNHjnOT0q0ZqAnCNi+b23Zu89H+UwP7EPBa2SxM
         pCUe7It1ruJNKdX6NalMlB1Dh/iS6LtIdFUQo+kpbJTHdl9iGMF7IUmLs1ehlmkFv5up
         R1NWHfhD3obGeas713E1XiC7jkkKEnIcCR028RlEthCjA+BpXE6QVbDTUm9dFefsxTbh
         AqUg==
X-Gm-Message-State: AOJu0YxsVD+YoAmADbt1LYkv1dA8lRkkwhWli9uSp1i4ErrlR3F3CKK2
	zw/XdfXWOeYt6o+aTKu7fbT1rzjsbKRp5jdBrNzvIix4M8+j+tlW6JgEr3k75hFg6XnYIxGtzVd
	6hzU=
X-Google-Smtp-Source: AGHT+IFFC2G/bSVkCKnhdhy6XgDtxqeArS3o3uSF0Inup/+kbVo1ad1TRgDLl5euVpsu7c0aiEjQlw==
X-Received: by 2002:a05:6870:584:b0:254:6eb5:ab2f with SMTP id 586e51a60fabf-258428976b3mr12669126fac.6.1718647756618;
        Mon, 17 Jun 2024 11:09:16 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecce85sm451625885a.41.2024.06.17.11.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:09:15 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:13 -0700
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-trace-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v5 3/7] ping: use sk_skb_reason_drop to free rx
 packets
Message-ID: <3b6f00440b880559fa3918504d85521702921e3b.1718642328.git.yan@cloudflare.com>
References: <cover.1718642328.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718642328.git.yan@cloudflare.com>

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



