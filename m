Return-Path: <netdev+bounces-264329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIrqIcRsqWnH7AAAu9opvQ
	(envelope-from <netdev+bounces-264329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:45:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DAB210C2B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A3733039A6B
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C27438645A;
	Thu,  5 Mar 2026 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IHFEI3hs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516721ABC9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711076; cv=none; b=IaVXuOiJHB2r3VNoBxmIaIm/uXVHuGlA84B2nz9SFkYWFRD8hY/L8lPAl7y2N/S9hY1A0DpzXvmNGvOMk7oBWzQuFZQfs1IKN1BYxotZJXAaNXQsliMm8Pa9mRW1kBv/mYGYz/FdIVxFB7GUNwe3BMVAzWnpkcgPUtuYa8fJU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711076; c=relaxed/simple;
	bh=/0XFzDbt1OeftBqbZi0eWIao1hkizOLEMD1YcCWqRG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IG6ntmi90auVeki7NOifGLTZfehNIGpZiKgn3llJMPsxFRfMKOD1sFRTjMEu5CAW7FrsUxS5yEwq7XN9cYCtl1GxgwBU6maqROkveINMSn/E53ya+cY3vzf6tMX2xm73t9AnS2ThhVwj1sp0ZKIQNHKguKJGrJpAVJQ2OSqLsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IHFEI3hs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b93695f7cdcso1020330266b.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772711073; x=1773315873; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCxkrMhyBYQPmJVmEwEa8XKJ/EiaedFOYCkENfL/8Jg=;
        b=IHFEI3hsU/ocqKHO79RLk8h24CFgVyCAkXR45MaCrL3fDnHk0poPigkiKVbCBPxt0E
         2AltYmWV6WhbXjRwJlyua0MjyVtOAYiPCcZiXhvAYNXd3v/EJ4C6rDzu+5BmQwImWWLI
         apJCuAXbGbn0lDW08Tboe+A5Hi44VGzKhIScJRKmPSnTxq5WOy/Vq2aWBn8VC58PeijI
         T35okrHtWcoJbqEiTyKEhYj02Fvti9FyqvaywjX8CZCONeT+iQ5Cu/38NWygYPwA13Q2
         Pg+sBdzzPm6nj8MKofYc513Hz/RcEjViVJSSACxSg7uwqMocnZMREdTV/Xmn315uNsjV
         vS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711073; x=1773315873;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCxkrMhyBYQPmJVmEwEa8XKJ/EiaedFOYCkENfL/8Jg=;
        b=a9CExqGTZhOLFl/5cMgaJv3dfvoHDOGskG47cu45u9wrlHNRo++sO4/R1hhUtWtddd
         W0wMghmyR/BR4q0mykRZMEj/HCvP6BsNM8iZz/AJD88H/tE4crKEKnJEjP9rYRqtvyQB
         hsbkZmT8aw4/yxfbKz6/dVdrs6WtvCZhAXMgwWUeC+t7rfpDOxh84kshKYpdoV1ylTPQ
         K5WkSHhcbt4Be5A/lk/E85h5i0kUS04Pd1ibBXap/LV8r4+E0V+3GBF0McuZw721xlyc
         kkhn7RA4eG7BRzDMV5mjaev4GQAug0pmnN5Pt2sleh0UrBVwGmNrsWE4uyiDWgfpAoZq
         gLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUl3+v+kcR2O+2gfLiW0cVvBrXvrQvDYadLUJGBjEK04yrX3gjRRQlw/7QPFqLSvLNrziFHrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUOQkwPtzfgCXgghVERVYcNlwcM+L/6Ckl4tZYm+3FvO8iac4
	UJgenHLlpBv4LHQPoVO22lMOviYjaNGJE/F5zbgkovt6dUCZujXZYGdXmjJEcPBlcKA=
X-Gm-Gg: ATEYQzzjKcxS3SX/lBPS8NkmSWrIkqVvcDNi7h4DwZuEQnk8gayx7lfB1aoDBmWe2I8
	7W/OjJW3sb1XK6rXm7TOG4N7jXgcuJc0fs6MIBi7nTyHNrhHrUI3pgBUC1NP3U8R0RYZmKvA9uI
	gXNhx8Zwg4SxkbzsMW5GnHCTvNbHCMkhfbR93vcFYb720qLYEXg94gckp2tzw4e1sBJqN/f9X8o
	jXtHy/ibjNqLGK3GRSPbzCu63gJQQ59cDqMOLHWbFPN9G5cCvrco1GxliKLG2Smwt5241B1dv1O
	OkKmbhDjz8IokUtD7cAjKzHrztJ677afRhbhYXEgoyEq4v78aPMQp82D2hYZytiADTa7EWtM3/i
	NRZ01kd7lLCj3Vp8kS+Ny9CTcG3FE6hNM1aAjHHJLdpsR6RQyn/E0f3HiPRXQ2d9icedDhuoO1X
	4dmYDJiclZEwyZyDK85xZ5PEkU4G0fstOAXuIjGxFEhcVlMYGCXXc9blClct8KGnr88cL2er9Jp
	hzCtE/z
X-Received: by 2002:a17:907:9686:b0:b8f:96f3:de05 with SMTP id a640c23a62f3a-b93f1552c04mr299133866b.60.1772711073180;
        Thu, 05 Mar 2026 03:44:33 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b93eea5869bsm241536066b.13.2026.03.05.03.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:44:32 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Kuniyuki Iwashima
 <kuni1840@gmail.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf/net 4/6] sockmap: Inline
 sk_psock_create_ingress_msg().
In-Reply-To: <20260221233234.3814768-5-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Sat, 21 Feb 2026 23:30:51 +0000")
References: <20260221233234.3814768-1-kuniyu@google.com>
	<20260221233234.3814768-5-kuniyu@google.com>
Date: Thu, 05 Mar 2026 12:44:31 +0100
Message-ID: <871phyo600.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 93DAB210C2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264329-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 11:30 PM GMT, Kuniyuki Iwashima wrote:
> SOCKMAP memory accounting for UDP is broken for two reasons:
>
>   1. sk->sk_forward_alloc must be changed under
>      spin_lock_bh(&sk->sk_receive_queue.lock)
>
>   2. sk_psock_skb_ingress_self() should not be used for UDP
>      since UDP may reclaim sk->sk_forward_alloc partially
>      before passing skb to sockmap, resulting in a negative
>      sk->sk_forward_alloc
>
> This is a prep commit to consolidate sk_psock_skb_ingress_self()
> and centralise the fix to sk_psock_skb_ingress().
>
> Let's inline sk_psock_create_ingress_msg().
>
> Note that now alloc_sk_msg() is called first.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v4: Don't pass gfp_flags and instead change it based on
>     take_ref in the next patch
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

