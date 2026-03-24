Return-Path: <netdev+bounces-271114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN3UCNSmwmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:59:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD030AA1B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E05B30DBAE3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B2235DA69;
	Tue, 24 Mar 2026 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI0Z6qmR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993E1DFF7
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364022; cv=none; b=BXdveuIxYp/t7apzuMCtJrsmHy1CzN1mrGHW4YtwhxpkrkQb20kTbPZXsz4Fdyn9D5Y0UGqNQWvBEUuqDbHUOY0H5C6K/6+IkkQajoUXatsGkHH5XPmIA7/RjuGPvAUfelskbZWCZX5eaRqyhxxoq2AL5MbFquMCtjiu4ZzmB+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364022; c=relaxed/simple;
	bh=SXjnvGi4R1c72XJGwZ8Zm6T4OvxABtSHWXoZg6vrEfs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qdKQ4UNLAoZnKUfDOHpLc1y0tXitJKcCMvX8z3igxqhIZDxkHbW5ymv56iNheZseF47HfcGES9PabkxY2mCC7U+DsIKSPqVEAVHPISQyg2SFgIsOOpB7pRcuCy//tJtyoW8fU0/lpOWOuOWqnceYasoM44OotG3dxZVMHd0sCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI0Z6qmR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7927261a3acso23030667b3.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364020; x=1774968820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ochj+QvGqw+fcfta2/7hBkzAJqloREVHuN2ZlebGWc=;
        b=kI0Z6qmRkzdsFWhHWJnRHyvDxyxgL6bietl+hz4Rrq7DhYbwlzuyif5DhA/cyX5zR0
         XDakjkw9EFs2lsW0XPzlmYHeBFotR8vY5CKCX1IXpIKjI+WqE7x5PpBnIhZSu5W0huRJ
         +ZD/mxQBFNY4uePq8oyHH+SH/121MnrFLCZnMgoIB1iMjMcHiOxeO3T7N6J7ZxUzx9Qh
         z4TnuuQOdPfKauRke7EZ0M0/gqB7X3R68+HSdaImEN9rJAdQ4o9WYf3eI3jI+ajVVrDK
         r8YKJXg0J+vcy8XQcERYuEzml70pLE++d73GYuziP84EgTqpi5MIpiZtMMIYtQu8HQY5
         b4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364020; x=1774968820;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ochj+QvGqw+fcfta2/7hBkzAJqloREVHuN2ZlebGWc=;
        b=N6HDo++/gPsabbmG2DnlPMaAS4a3vpu2EX1RSQYbfLXyTmcZ0760oVuknuxnBcBg8W
         v3WnZwzX2evqlMnuw43Dq7DjZhbYzrE57nJVndFR8SVQX3qai43u2UzMfgkhTHbVFFxF
         9+6a5imWQ6nzUWBvmDw6eJ9jK7OeKNYy1s45eAFypjWreQGDekYzVw2hD0in0+IC2nSn
         d5wneiy5l17eRPl9mOB+0cVmcq7f47eRzrZ8ur72S9bcsz3dXWfy4uXsnUamOZNRMCzY
         yUgkv62vikOF9qsAz0LJ/4DLiGE1JPG4H1zYquyhRIHYHbgWfMrczDvmNAAKuTNrzzAM
         WEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPFXvknbRepoW/2dgtreSCF8v1wSD+0p2PjF+aHWTH3i/WP8ezTYTpn13YuAgmqateTzhsqmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyll9Y4jyaSzv9lqBQu4rI7U0uPqdySLCHjhqG5xWLbkL6cEZak
	DCKf0P0Gy1lyuPPphqodEbtrZPtPFA1nPrM73teFUbrZyg9hUVWp22iZ
X-Gm-Gg: ATEYQzy6wdfdZuaMLrW/8Sk+9oIHqhcwcnClP/r5EUixghtgNzDbzN1X3ZIW41sHyaT
	OtBt3fn9/5IzwNizEqseF9s+iY+uoRa2UXqWNuxd7JHAsIqzcooG9pAQg/O5WirJLyGG6Aami/I
	fbp8ewav7ad+XLNOsrSroSBXpT6URgeNCVJULCW4T3Tor5Z6J1wAiAnlia3OcovQHT5C69j7thX
	GTBad57KFlcfGn9lnnxtgYNmuNzSgy2XOZDfynMOKDLhKuNJCXH2gPLQapAAVWZlA61uijMbzIK
	IVChcX1+3LXi8ApURqzmkvWtmypHXsMFtiwA84wMGuKxcISCEwnC+Gli3qwIqCGwAh6bn+LSGZH
	CkvVgtRIMLP12T+z8MvFO3j96WZ/1ntQBf6w4GAq9CnImTL/L20r8blko8upKdlA+O5KT8t3zo/
	WoZloYDyv+gpgynbNYWgAGSv4yaoY4qWFmhpVQecUUye3bP8mRw/oFBDBpEB4BcM+vyobBhD3DE
	dDY
X-Received: by 2002:a05:690c:b05:b0:79a:51df:6a0a with SMTP id 00721157ae682-79a90c39a45mr165486337b3.60.1774364020286;
        Tue, 24 Mar 2026 07:53:40 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a903e0b8csm73393107b3.12.2026.03.24.07.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:53:37 -0700 (PDT)
Date: Tue, 24 Mar 2026 10:53:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.94dd9c2ea7d@gmail.com>
In-Reply-To: <20260324142556.1844523-1-edumazet@google.com>
References: <20260324142556.1844523-1-edumazet@google.com>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add
 CONFIG_MAX_SKB_FRAGS=17
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271114-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 40CD030AA1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric Dumazet wrote:
> Before adding tests about RWIN, enforce the default linux value
> for the number of fragments per skb.
> 
> With 17 fragments, sizeof(skb_shared_info) == 320.
> 
> With 45 fragments, sizeof(skb_shared_info) == 768.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  tools/testing/selftests/net/packetdrill/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/packetdrill/config b/tools/testing/selftests/net/packetdrill/config
> index c4a19a78552111df690d2c97c0f3a8abe2176ada..8c739db4752c3abaaa8862ea2aeb661a2d5f0575 100644
> --- a/tools/testing/selftests/net/packetdrill/config
> +++ b/tools/testing/selftests/net/packetdrill/config
> @@ -1,6 +1,7 @@
>  CONFIG_HZ=1000
>  CONFIG_HZ_1000=y
>  CONFIG_IPV6=y
> +CONFIG_MAX_SKB_FRAGS=17
>  CONFIG_NET_NS=y
>  CONFIG_NET_SCH_FIFO=y
>  CONFIG_NET_SCH_FQ=y

Why do we need to make this explicit, if it is the default?

