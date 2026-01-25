Return-Path: <netdev+bounces-253247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPa/EFybdmmqSwEAu9opvQ
	(envelope-from <netdev+bounces-253247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:38:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E2382B6C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3750330037F3
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282042F362A;
	Sun, 25 Jan 2026 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+HwabPe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54BB1F9F7A
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380697; cv=none; b=f+BB/A3aWiunETVCHJmwZEgB6Hv4LJykCgj6adZyzzH6Y1nuHw/HLwzeh/e6Q1K9A/jFcLAC1BAwbmbphajXwevMnHy4nwSg++iBN+5cQbTfs74Aot/KJyjeDxeUiTGw5SO3HSew6eDavjLimrlI5On+hYQXMzyHCxGABsYC/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380697; c=relaxed/simple;
	bh=bShR+DvzxtrfjAzpYpHrf19jxtgKZ01PGTNh9LJuV2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry9OgvxRf0iZv+nO9Pc+2N3cUYQ6IdGI0TEpYbd+H5DBMed/uE2Lj/bjaKodj+loM2qZEsMUQHLDhUNmQ1tx5qUAW3rsh0aIDZGCrY6yoo2g++2VCWXa67jiGqOH413a3eaWFy5b5wN/PcGWjcrHKaTwuf8/NTMTQ3qWLY2smUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+HwabPe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee0291921so33075905e9.3
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 14:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769380694; x=1769985494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2umcnwEupH/jiJ8gD8E4VSgSAY8v1C2B2I4eeqRnGkg=;
        b=i+HwabPer2NLHrOA4q7Dn2W3cf24MoWNVWCYh9At4NDuco5iMFfsKqGQH96UgWqNeR
         qHKuunOyhNmlREYsWz+I/Xmymoy3vmC0hBPohjyjehLCLqVgmHnRxbKaQSw/SQBgZeCI
         BSrZkUpotLZCVN1A7vftXQJVaCoborg+KPxq7L/dVSrPce6slctbukmRyhoAYFWdcAJF
         UyaZmGWhfq7HyaHCsf92J7JwV026FpjlZ1nNoYvPYG9n4QcBt2xX601Y1o3/IeUyl+Ru
         PmsTV+n/Rd7TN8jFPfgYP2QvVRi3BVt8v5hV1slijhm9BC53KoZaCoBa14cNH9KOU+qd
         ztfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769380694; x=1769985494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2umcnwEupH/jiJ8gD8E4VSgSAY8v1C2B2I4eeqRnGkg=;
        b=Peqn48aaRelhkJy31+pxNAqG1Drd1MvbRdo2ECOPDJovEWz63NqtXvYhaKDeVL4tSF
         wJXFjz+BziojP2j+WBw7NmfHez2VTU5FHK0c3HwNxbwpL/AbAEkW4IZyKCzoAIKiOPWD
         8UsKjKoYmAR5hMKj01n0vJBr3gakZqoTKcgziYGQzXzbryBDj4W95AQf9FumA4R2OtTa
         XKQ1WkpdP3RgbxIV+R48QnzOUtmqdZK3sl6yFdWIC/DJZQwVViay/thW02FFlLD+T6w8
         JNtfI6mZ4bFBvjQ/QyayjW0MHl9VIUl5EX0cl0clwd8X4WemK4xqk70zWQd09xdeteYL
         qtgA==
X-Gm-Message-State: AOJu0YwW/mbnDcssewWmMBDkinLejflUYuz4w/myE/xFZqTgRx84nXWt
	vTUY58SidzAuUxuAs/A6OkICo9nGndTc1m1Z7iN8zNAO+ZNpgWi8EXCf
X-Gm-Gg: AZuq6aJ6aYlqJ/MnkMCEE1B6/UY2DroN/4EMf6kDpXlfN50NRcDCgB3KkfzjZfDcJL0
	0J1vGfJcp1vrgdp8WoCvPke9UAPAFldW06SDMT9hdqG2AmYkCI9WG8hflcjZ5GXhE9Ic/pOcU2y
	vcmVCcedGeamKoi8SeD1gFb7zpKaMXM4fjouOxNqN98gJ1ckVYMQ6g3zNSCgBpA4F70e/pGzHJr
	tDSi5jkwplZ/8xH4KCEuhuOR3pqKo+XLkcOswZr/vPCJCuxYcK56MWYNNhG4L+AATXU2MHkwNQx
	JLGv4J+iKRfkc6wwp2QwXGLkO5JWAfI89wlST7j5872KXUcpKIF+16uFNEE9VXeGd2MiMpGwOAj
	5DHcL7wUrjnNR2x20wM/YJoJvDFIhzfEqAz75MYstQ7YndK7lX1r0NaPOaHiJ89S4zUIKgM51Xq
	g7089Yb2dwF5Q+vebpYmwPnuli9VoTE36fSRQdPIrEWncf7GEKObZm
X-Received: by 2002:a05:600c:4684:b0:47e:e20e:bba3 with SMTP id 5b1f17b1804b1-4805cd44c41mr49205745e9.7.1769380694028;
        Sun, 25 Jan 2026 14:38:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24bedsm24336005f8f.17.2026.01.25.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:38:13 -0800 (PST)
Date: Sun, 25 Jan 2026 22:38:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] u64_stats: Allow u64_stats_add() to
 accept s64
Message-ID: <20260125223812.3a2ae148@pumpkin>
In-Reply-To: <20260125220753.3984326-2-mmyangfl@gmail.com>
References: <20260125220753.3984326-1-mmyangfl@gmail.com>
	<20260125220753.3984326-2-mmyangfl@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253247-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 84E2382B6C
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 06:07:49 +0800
David Yang <mmyangfl@gmail.com> wrote:

> The current u64_stats_add() accepts only unsigned long, which makes no
> sense as u64_stats_set() accepts u64 already, and causes unnecessary
> narrowing on 32-bit architectures.

Isn't is a chicken/egg?
A value over 2^31 could just be a very large value that needs to be added.
Where the add is being done 'just in time' so avoid overflow.

	David

> 
> Moreover, since there's no u64_stats_sub(), users may be tempted to
> reuse it for decrements, which already happened on nft_counter_reset()
> in net/netfilter/nft_counter.c .
> 
> Change to s64 to allow both positive and negative values.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  include/linux/u64_stats_sync.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
> index 457879938fc1..e77f2b30bac7 100644
> --- a/include/linux/u64_stats_sync.h
> +++ b/include/linux/u64_stats_sync.h
> @@ -84,7 +84,7 @@ static inline void u64_stats_set(u64_stats_t *p, u64 val)
>  	local64_set(&p->v, val);
>  }
>  
> -static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
> +static inline void u64_stats_add(u64_stats_t *p, s64 val)
>  {
>  	local64_add(val, &p->v);
>  }
> @@ -125,7 +125,7 @@ static inline void u64_stats_set(u64_stats_t *p, u64 val)
>  	p->v = val;
>  }
>  
> -static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
> +static inline void u64_stats_add(u64_stats_t *p, s64 val)
>  {
>  	p->v += val;
>  }


