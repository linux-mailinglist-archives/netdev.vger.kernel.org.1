Return-Path: <netdev+bounces-261929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCAxGRfXoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:40:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D311BB8CF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E76083004F67
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D24418D5;
	Fri, 27 Feb 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6aVplE+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479F3ED133
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213898; cv=none; b=kw90Jg0167VfzrydUTFZ7aKlTehi4mU2VwT0rbK1mvVcxL7eicooCIUFVWCo4stokG9WDmP03V+K0HbP8nhAvsjb+XEuavWrsIS2CU9b5xIwAKyxbPuAcrq/DUBZTwVOw6m+x61y31DKpZALErNgLuMasTMlEYSJLPdw4JsAr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213898; c=relaxed/simple;
	bh=GqKJN4wicu+ARcppCF2d6g6bNUpLTY8dZOP//kGjqUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2mZ/0fc5eFxGJeypaoiUq1uep3yebns4elJH13NjhRfCr6aSBH3WoA2EHkpsonud4K3N7bBUgz4o2MZZzLAKs0g1AJNh5IX4KNfhRsu4DIRbIjpz1DpU20+uBKgk+c5NISBsBqu2nmUyi1wtQVcaJHqTf//j0sQSudPN/LRQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6aVplE+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43988056dc3so2307773f8f.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772213896; x=1772818696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5330lVPGxgJgwW4sth2NQqr3TSgpLx4HpGSr8ZLQeRA=;
        b=P6aVplE+WNFBo+ayyk6rY6iLnPh8J4YGtzfAuFS7UNVhT0/wlvI5iUe9RivBDHCz3q
         d2oXD1UIigI5yNH5+elv0o5/tIu4EPlxHaqa8YqeKqaq5pCTEKnv2cBKfvNr1/PTenWL
         nvqUBY9LBQnr7kCVgigl8qVElLbbgS0TwLcxzV939HSO2NktSLOT1ue/8HEcR/7aB8kr
         QGP/ykZredSBuLQg7f4DUk178VU0K6hFD4A0aXGSQCrWt9xGyQ8yduHl4Z7W06WKMf1C
         kILiyzhw13qtwkamD/KoZWU9i2kY3zSMtPCIN4HFUpP/uPdjBgphi11wfBzqI6sKejBR
         xNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772213896; x=1772818696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5330lVPGxgJgwW4sth2NQqr3TSgpLx4HpGSr8ZLQeRA=;
        b=AuYCZjn/Z1ZAYtyJdGFG+afGmiW96n7Ixw+z4cXvax4345tkLj9uvAQPwtpoiiOqYz
         wBosCD1LXPahhWmLF5/aHoaIvSFoLPR7PXgeR9XS43FSAQXR6VEKPjGP/FodQk/pTy1B
         s4ZKNwRf5SikrEmxkU8MyoW70/k4T1eACcdgPQ6cgm+NrqLU3l6XKnjcIIXG7cQJQC5c
         egjcJCsd5bBDHq38rCyrFNMxsxUJLFGxBsFCDO5jeXG7VakW66sReiIizbPMneBvb9RQ
         mGAOoHgf8hZaTc1NzQWpxFCVufxfLkkcqYy8PceZ/BI79thJ2B/BJymwa0/Em1Z5YRcn
         /L7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+k9N1gIctO3ctmGeugsUK0bj4G5qEIqrPJM9p99itQS1zuKoiwd02BvYW09ZvDCNoMgQTtio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUvjiQmiVgiWP7TehfYpjzKtqI+gufkiorCXVGPDk24yYXgPZv
	CJwsDtaL5pAJ6DD2qv1ifbKxOLs3sd0xkFv4mS5GbCz1BntkSYo+HLFe
X-Gm-Gg: ATEYQzy5eNIziD72JWnEj0FLaoYD6ZwTOGwieHh8D6bwDprQoz5gM1KLHsoxQi2Q8H8
	MmW2gWadsClkodlWpBSCC6JI9KL5wPkh+jzHqnwctqi4jE8v9iluBcQ4etWSwSto1PGfKuYyquo
	piyJ16pyWJR4LqMuF70C1DoPK9qyDrlqzVcHvqfGRTSYBPcVSDpg0nmM0IezXfJYsSf95Er9oZG
	wfWeXmH6WvW9htbAD8jolRlc5iNWZoFwRQgnueu+/bNcvksOBcuQgQ+7uViX6fWmmsGXODWI1rX
	9Mk3qvpSj/gdgzJkx8MD5cYW7JVm09hqnobZlMGBh8aAYCbP167OfCQ5fSatQhZri5Rhj8MWE+g
	mbcA9FV/z0fksSDOxAcB99y0rfzO9GEktda/d3ngRTpsmXBTStD6DFg0jZiIT6GTqQgTzKorTDo
	pErZFvUdu/hY+8Vv3lv0AIx99Jox1brJO9KkWXk0hDDUy8L4nOimGWHW8Way/SnjnGU5PSGwLJ8
	Y4=
X-Received: by 2002:a05:6000:2c08:b0:437:712a:fab5 with SMTP id ffacd0b85a97d-4399de3e39bmr6530808f8f.35.1772213895640;
        Fri, 27 Feb 2026 09:38:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c7657c7sm8793640f8f.28.2026.02.27.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:38:15 -0800 (PST)
Date: Fri, 27 Feb 2026 17:38:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using
 no_printk
Message-ID: <20260227173814.2f928556@pumpkin>
In-Reply-To: <20260227152624.164964-2-seanwascoding@gmail.com>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
	<20260227152624.164964-2-seanwascoding@gmail.com>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261929-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: B7D311BB8CF
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 23:26:23 +0800
Sean Chang <seanwascoding@gmail.com> wrote:

> When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
> expand to empty do-while loops. This causes variables used solely
> within these calls to appear unused, triggering -Wunused-variable
> warnings.
> 
> Instead of marking every affected variable with __maybe_unused,
> update the dfprintk and dfprintk_rcu stubs to use no_printk().
> This allows the compiler to see the variables and perform type
> checking without emitting any code, thus silencing the warnings
> globally for these macros.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
>  include/linux/sunrpc/debug.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index eb4bd62df319..55c54df8bc7d 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -52,8 +52,8 @@ do {									\
>  # define RPC_IFDEBUG(x)		x
>  #else
>  # define ifdebug(fac)		if (0)
> -# define dfprintk(fac, fmt, ...)	do {} while (0)
> -# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
> +# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)

You can omit fmt, then you don't need the ##
#define dfprintk(fac, ...)	no_printk(__VA_ARGS__)

	David

>  # define RPC_IFDEBUG(x)
>  #endif
>  


