Return-Path: <netdev+bounces-100761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AAA8FBE3E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90F1286F35
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF7C14D708;
	Tue,  4 Jun 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z2PNykFB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAA14C5A5
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537671; cv=none; b=jqrXvEMUmpeajyQiiJAtUF1hRJyfKvfePm8GQNtOivG/ZCD5hzKHvmUhPoHMi2gOALDxLpzA3p3qL6YWTnT82YvP2LrCiaPDbFSYqr4M88/wnkeMAxFU7GxAAlfdorbWflDqEe6NUdY1+Z1RJUkmL76SQu8b6kL3KVd+ccy9iJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537671; c=relaxed/simple;
	bh=jkzjDY7vnEB8DqdbcGuw7ABHpoGpOOOicO2KkYgqYYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1FRqkiyBAAcXhE+Zp4bM8uwanLkBomHzIfXbG8X7OzPyv8oo+z12vkVKhjqzfnye8pNR946qnNhBtSe9afGBnVkSQivjnjz8GeWuiiMBPYYDYsxBltCE3EqohWN7KCI7ClVIOmokJOAc6GUSsW6TwsULu9V3OlPFcK8Xs/0wyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z2PNykFB; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d1d35cdfc6so3591352b6e.3
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537669; x=1718142469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=Z2PNykFBGGMHFGchjXa/OmUdra2jHDOXI+VbW5tmKPM9o748EuEl3EoT3SSTcwWMGg
         LJ/vJGeOGay59QynmfMC/fgz9bPdmGyR5eWWUEX0XiCGrsJ0t98gUMi8vr2mQJn6vTvX
         +PjLlqClYuBFDQSZReLpacJbsfNsVr1UH2C6A4BpjSNi2UBR6E9b8VCioNJNbqWhazrI
         qErncViwqW4Touum7ORClyMtMFDoXDV6S6UgXNC5ysH6t9iPfaJ7YXV3Vlr/Y0suZgiL
         x4AoGkGEItIbHOGwaU0FcPCv65EL2aGIhDpdOxYzjYZZ6pqouyVx5rq8qa2sKpx/uSiw
         Th8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537669; x=1718142469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=Ul1mH4tjEDTawgWFswONMX0EXLWiV3fetvYYtibdag+zsxX3uqZ4x2wCND1SgnHJlP
         US3ZEukPOepiPVx6B4+kHVuY0Q8JQZlmtZe73x1ktNZqwtd/66Mx1F4FjyIqhNObkLj8
         Ha3njtJU+5vpjugREBExDIjfphi8/ps5E6yraP2lvyROG8361BQYEqdl7Ex9zRLdFMRL
         rkHeEByO/alhDYMe3Y57wT84elqGLF+lvrlbxi8OF0vfwir+6ZH/HUuujtfsjs7QpfaM
         3Ta9/SOoYw+1l1YoRtZgNGkJcKypYHPPtr3HE97VYSqU9JASx+Wm3RvYJ74CZ1q7ESqF
         UV/w==
X-Gm-Message-State: AOJu0Yz/5MfSFaHYEraPtBMi94mGIuSwhYPofX2zy63n1h6/tZAGjZck
	Nqwfcr0g1bkUJORVxkMM/jhHXwVcy7XDfpSTq194UY7qHnT5J2Xh2mnddyO3Uz1F6F/v9mfAF8a
	ApHw=
X-Google-Smtp-Source: AGHT+IE/CcVqEmURDm+qAHOzuZAeWRfQfnebx+xrgKlGcKR6QHmLUh+u4nT5c3F0so32M1T4yr9MCQ==
X-Received: by 2002:a54:4193:0:b0:3c9:94ab:e8e8 with SMTP id 5614622812f47-3d2043a7200mr644527b6e.33.1717537668593;
        Tue, 04 Jun 2024 14:47:48 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a73e425sm42261866d6.24.2024.06.04.14.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:47:47 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:45 -0700
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
Subject: [RFC v3 net-next 3/7] ping: use sk_skb_reason_drop to free rx packets
Message-ID: <5e4263e09e784f8b32e261a0fb8ed7056da313a5.1717529533.git.yan@cloudflare.com>
References: <cover.1717529533.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717529533.git.yan@cloudflare.com>

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



