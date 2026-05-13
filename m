Return-Path: <netdev+bounces-287482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJccBrQ7BGoqFgIAu9opvQ
	(envelope-from <netdev+bounces-287482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:52:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8473552FF55
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 463D9307837F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3173E51EC;
	Wed, 13 May 2026 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwTMoSVp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67E3E0240
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662243; cv=none; b=bamnkUjxIe7XC+hH8J60PMcAgqWhe4FFiGkta4UPHC5GVh8wN759gXoLQh/dHlV71R4AgRdwCaXQEldwj2nctrH/GNOOl3gSTLN6JAb7A5h0eYx0lEcY7u/D3tX8JW7QOXiHlI8h4Xe3Y5RcU5TxIaCkTk31ovl3mBL/rlZspGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662243; c=relaxed/simple;
	bh=3atT8USYLIyolOIkhccSjZU/S/v3HIGIn0LtMDF2p5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kf/dzjGMcNW4MMbFMFxhMwR09NuzecLCWwtAVnHIWV1gvnkjfV5BJncgLBDcWvRD6QWeAwEwNVLXjVbWovU8T4f6Afl7vgDUd8iUl5Zsi7g8oGpCjS6CuFoq9chnu0wTZf5FHAAR62MKaXaLocM83dFKw08/kdEJrP8sdxQw4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwTMoSVp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891f625344so59266925e9.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778662240; x=1779267040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcw11gCqq0VyT35kEJZv5m0sbkpjx3GDV6qa/qW2fn0=;
        b=DwTMoSVpLsanxE8CtUA3Q9WtxQ+80kxmf0smirjXzld9yQJRbkVYDGvZz3Kz0lPzZa
         NxfQfXgphsMKYH+RzvbjRjSrB3j96N19BAnSOHGrHM6H3lkZc6WI/BbryEtkFr+HrkS/
         Ms/FdEtV5d9qKq/ar1libMyVpzjGvfF1eP1+qPzjPWIBOEoj/bBTcgswWdlfJChL/Xiw
         7wfYgPv778vHYCDOcJfzJSmRgMBDZkkcZtUxcuURbD/OwJuVmT16jguia6bqN/3DEX9p
         EUfKktfvLbGRf5hyDvXfMVMJqOCK+IO4ouKjb1QVq4jUg5fzbpUKKJiWNfS2XrD4jAg/
         2HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778662240; x=1779267040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcw11gCqq0VyT35kEJZv5m0sbkpjx3GDV6qa/qW2fn0=;
        b=llOycc50H8mVTkpS8Iify+92DKtJSpCEnfYFsy452v/2Z9Dsx/0pdmHyVzG9PkS3y3
         ENVEjcEVlSDRw+Y2Go5cYyPT5IYeqptYjuwHhUFz4gFyNGWttl/psxrA7dRv60JoVITH
         KwXSOrbJj1/BdJ2DqNTkqC70Gz6sD3DeLAaHu6qFr5+A/PCqT8Qti8cMllrLRHLaZhO7
         uidozkn00f4KWPayuvnyY4GO7yWaUkI8oXEevIAZgi8Zmqhuc4wkuDbG2cQkYhiLVNoL
         otCycYeRWu6wemHoGr1U4Xv8ekQxmO8XfyeQ1HUzZIO/iyN4Vp0uOzCAsTXL6Pl4aNBt
         sMVw==
X-Forwarded-Encrypted: i=1; AFNElJ8O7i6r3Zs8bN6XxV3/TVKycobesh2YfMSc5LLMO2U+yp3TEwqNPgQBDFDuDVox8IeQZFvF1Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrj/Iwhb7i+AtfDGVJqtqpwncJ/U/4HA2i/7YC9gjMdBXteTAg
	bbywm+YSg7URQZ0EGCangdgq1BsPjQwB4Ds5+06Od8EzNdl4nA3/gDaH
X-Gm-Gg: Acq92OF4V1dbmX/2xjv7EytoPzbKqU06zZLn73jyOpzhWFd6sVHL5gRSBNW9rOAenxF
	yXOEinf3jNKnFeZlMISMhBL73vs0onmQH1vl+Amn3s0JuHxnU6cxgDVoa9ovuRgZA7S4wxvctXc
	bclwBUqp0mvzQmPQj3N/gK981u2Hr5NRudKNzR+WlMCy7ulvg10V5K1Dq36E+aYdnYuWu7YTLdr
	pLQpdqv97Pe215TQCXlgSBWi5tPwvBlskZERganWJ9LWTbLVs0ZrK6uxypgy58UOJ5NI6JpKsuB
	rb7ozXPDzoRXZoPp/NM1p4vl0hatCOB1w6hCmB2Uh0hKnMnl1sN9Q/bL6N+1Li4ZJtANPbGKx2v
	DiHq/TE/KZHJJxe2PIV2zrOeSSJaJ088c/0/zFNx1LNE4hbOPkjl9h0YQcE1QyKS9xZC5L/UkHg
	lXSM+tc9QMeNMerzJSAKYsubGCGid7M0xKwLR9Q4I5vCpw7os4ecj1c1AulxSS
X-Received: by 2002:a05:600c:45cd:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48fc971f0ecmr33004645e9.2.1778662240054;
        Wed, 13 May 2026 01:50:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e62944bsm38225035e9.8.2026.05.13.01.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:50:39 -0700 (PDT)
Date: Wed, 13 May 2026 09:50:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH] net: block MSG_NO_SHARED_FRAGS in sendmsg()
Message-ID: <20260513095038.116dcb34@pumpkin>
In-Reply-To: <20260512-msg_no_shared_frags-v1-1-55ea46760331@google.com>
References: <20260512-msg_no_shared_frags-v1-1-55ea46760331@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8473552FF55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287482-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 16:02:03 +0200
Jann Horn <jannh@google.com> wrote:

> This change should cause no difference in behavior; it just cleans up some
> hazardous code that could have become a problem in the future.
> 
> MSG_NO_SHARED_FRAGS is a kernel-internal flag that cancels the effect of
> MSG_SPLICE_PAGES, another kernel-internal flag that influences the
> data-sharing semantics of SKBs.
> 
> Prevent passing this flag in from userspace via sendmsg() by adding it to
> MSG_INTERNAL_SENDMSG_FLAGS.
> 
> This is not currently an observable problem because MSG_NO_SHARED_FRAGS
> only has an effect if kernel code adds MSG_SPLICE_PAGES to it.
> The only codepath that adds MSG_SPLICE_PAGES to user-supplied flags from
> which MSG_NO_SHARED_FRAGS hasn't been cleared is the path
> tcp_bpf_sendmsg -> tcp_bpf_send_verdict -> tcp_bpf_push, and that is not a
> problem because tcp_bpf_sendmsg always intentionally sets
> MSG_NO_SHARED_FRAGS anyway.

Should that be inverted to an explicit list of valid flags?

Unfortunately it doesn't look like calls with unsupported flags can be
errored - which actually means that no new ones can be allocated for
new functionality.

-- David

> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/linux/socket.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index ec4a0a025793..1a4d0d128a13 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -357,7 +357,7 @@ struct ucred {
>  
>  /* Flags to be cleared on entry by sendmsg and sendmmsg syscalls */
>  #define MSG_INTERNAL_SENDMSG_FLAGS \
> -	(MSG_SPLICE_PAGES | MSG_SENDPAGE_NOPOLICY | MSG_SENDPAGE_DECRYPTED)
> +	(MSG_SPLICE_PAGES | MSG_SENDPAGE_NOPOLICY | MSG_SENDPAGE_DECRYPTED | MSG_NO_SHARED_FRAGS)
>  
>  /* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
>  #define SOL_IP		0
> 
> ---
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> change-id: 20260511-msg_no_shared_frags-d557c14e487b
> 
> --  
> Jann Horn <jannh@google.com>
> 
> 


