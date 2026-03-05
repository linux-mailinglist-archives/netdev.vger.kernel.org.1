Return-Path: <netdev+bounces-264343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIetMVFuqWnl7QAAu9opvQ
	(envelope-from <netdev+bounces-264343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:51:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CDE210E33
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A01B303A242
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30508386578;
	Thu,  5 Mar 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZXwRkc03"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9A38424E
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711493; cv=none; b=oz+/iyXtavNITNlD6F9+ngj/OKx8UoP6hz7/owzr37vP/y5dfDudzJWet2jaINCd03NjwFwpvhmbLTXr/UZ7dD5mgdDmR4RBLD0VK04N5D1fsnNBOU9JH23s074u082m1EuVtFvsBI6/y1VsmQx6uIVAgUQg/UxcuLTTfd+/AUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711493; c=relaxed/simple;
	bh=4xPQDd0ljv/9b2VO7qXd5XCtz0aa94rQyFRE6a/5wPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HjcLxAmk3VxMpwH2nLyxELnR+aLyOliqDKgKv/T2nDGjNbzUl25QVqu9sphpx6ppoGlI3TnqSPCwF2qRv2uBC5O2JT4wFmMBqai7FLPSV1srA3j4tOmTQXhdtDslAAaC6zVg6afF2c6FyuRQKeP2vsBKtCpbtLutt7pJLyUPC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZXwRkc03; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9358bc9c50so867318366b.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772711490; x=1773316290; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xPQDd0ljv/9b2VO7qXd5XCtz0aa94rQyFRE6a/5wPE=;
        b=ZXwRkc03ZlinU9pRVjLJgJWY14X4DNfs+zMdDHALwpq+x4x2IE9xfteraMPwdvYIQ1
         P9zdwAvitSDKU4pxi+mgZFYsbbGlNJQEyb46pkbHs+t2Tn+USSPvNt7xVHzOYFZ0lJT/
         vJeQmMD9r5pyMuXQOa4gs7hS7Z6wczh9vSDDxJKeNTlS7hFlCnM4AdL1iY2FkTDjVM/Q
         h9iiPCd2GRUpiDXf4FCmhGN8NsY+TLujKqnaId+kWaseMV7HZBwaGGodSj3vZxEF50cK
         Xea0Wv+Awj6zgOMMM6BHGck5WKS45POvbHUhz4ckBFPpb+edaHX04l7seJ49//MBStez
         oH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711490; x=1773316290;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xPQDd0ljv/9b2VO7qXd5XCtz0aa94rQyFRE6a/5wPE=;
        b=sqYplmSMi8d6jc53w2oPnvPNSPdMZEm4FUu0nZEhWZ03vJS2MD53xjrGfbteHMch6m
         78vVJhuJIEwLJQSarpNXjvJpCme85/kXXytID/wDyiBjoemrwQb47irl7NvEhEcl/mZB
         8TVzDoErlXOjuhKQFJiQHjTrlgRNYb6RLM/D0LVJ2ILw/kA17Ix7FzTNoLnmgK3CN9OE
         jQLPiylhxP5pxpXR4IRXvXAiN+DeDdnl9zek4le/lsRZlsaX5JEasJUbsMOd5cd5lJJ8
         ek+st+kkw020bnqs6IuGLlk7BGZxQrdvF7h5vPRB09UTTELHj3K0+JjvRR/WqEJObwrT
         siNw==
X-Forwarded-Encrypted: i=1; AJvYcCWmSZZX3r0wELwnYoTGncTGPrA+7nagqOJD+FvCfzu5Wcqd1uCDEchVlbjA1srRDssnty2GXao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJiwy+RtJ4MSMQw9ewTkzASrsyZ9KKqUT0OaoyRTO9dOcD0Abr
	RrY5eeqKQCjRdA4jmS8wLUD+USB1HVRVkslGL+Rr8QRlCmQaKUH5pD9lpWUGFB6VzFE=
X-Gm-Gg: ATEYQzwMy87dHW0K9gMbqHm/rlNS0VhEj9L3ONKgcQF7r5y1AT1PBZJK/5cqQbK7Kb1
	Z/F7HtszMrJFnnC00IRCC6EWmmdhmUwShFOkIYBZGaaAAlcpChkhpELTmj7l8/rkW0N7J7NaEm6
	F6wbzB45G+YjyvFh/gxuqHOBjJT5Uz+JRLP/ZIpWI2Cc/lkMEGwFRk4Hui7j4s8hO5lQgdkMu+U
	9NpUprgOGrFTGoE42uA2yJRJO3JeSdzsd7foU5bRfuNG019VU0g5aIRx8bsikqDZk3nR8iBKOH/
	DJpTQl2khLaO8VV6M4lI2Jns01jvy7mdUjCpp616fQSCpPMzLPyIQ6iKUaKPltBWxk7b0vT+YW9
	lDNOGAYtLBFDYP9fPKu/AaMeTZioyKS1c4AqL679koU45sMXMocbTrtV7pFCv3gJHXnk7YxWkUy
	zeANiz9CgdaXw1MKeYV1eTEGJ43kXtzfcOxT7KEVZUeS2Mp2U9NNlh3n5Y2g1RIsfleM/+Hg==
X-Received: by 2002:a17:907:25c9:b0:b8e:d04e:e506 with SMTP id a640c23a62f3a-b93f15afc56mr331477666b.57.1772711489846;
        Thu, 05 Mar 2026 03:51:29 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ab13d57sm900463166b.12.2026.03.05.03.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:51:29 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Kuniyuki Iwashima
 <kuni1840@gmail.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space()
 for UDP.
In-Reply-To: <20260221233234.3814768-3-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Sat, 21 Feb 2026 23:30:49 +0000")
References: <20260221233234.3814768-1-kuniyu@google.com>
	<20260221233234.3814768-3-kuniyu@google.com>
Date: Thu, 05 Mar 2026 12:51:28 +0100
Message-ID: <87wlzqmr3z.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 05CDE210E33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264343-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 11:30 PM GMT, Kuniyuki Iwashima wrote:
> UDP TX skb->destructor() is sock_wfree(), and UDP only
> holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().
>
> Otherwise, sk->sk_write_space() is read locklessly.
>
> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
>
> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v3: Use WRITE_ONCE() in udp_bpf_update_proto()
> v2: Cache sk->sk_write_space in sock_wfree()
> ---

I agree with Jiayuan that it would be less confusing to drop the
overlapping parts but Eric's patch went through net tree and this is
targeted for bpf tree (?). I'm actually not sure what exactly the
bpf/net target signifies.

So if it makes everyone's life easier:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

