Return-Path: <netdev+bounces-295284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1bivEISNIWoiIwEAu9opvQ
	(envelope-from <netdev+bounces-295284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:36:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF052640EEF
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:36:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oiPPIXt8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295284-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295284-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D948F311E97F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43464480971;
	Thu,  4 Jun 2026 14:19:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C43480977
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:19:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582772; cv=none; b=hPyZkd711992cwDE6EolXcMpWN7/O1czACbIKschhDD2RI2njeZt7PwWTOkhRPs+nBxPnMmzLM2PxaF8jDVyD7pQ3oSXmXy5UMGCMG02jLmtLIRwUsXkh0JT3H2uSijlBR7LXJuVyEyPEiPKOPY4MaWkdgJ2+T3+U6YLmYPwHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582772; c=relaxed/simple;
	bh=PY0GgQpHC9Aq0VJm9Y+dvOS4dC/BpXJjS+JJGwvRgdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZxcRX4q4yG1ax4ssQP+qM8IJ1yx/k7BS/ReFtjgH0QvOsb5JBUX8GAmric5njeSBzkyo8XtGTg0Ls+9PAqBpxagcuWbmhG8w4s8o8OObNNl3WgC1ujXnKM1AwFpNbWHd0a8PE8susHo97W70wZmLtI6umzNUoX0qKw0/44hYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiPPIXt8; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso6954375e9.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780582769; x=1781187569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NRZUa7I3XPfqUu/QiRSG37yGjwWwJiviNkPIf3sJNM=;
        b=oiPPIXt86B70xSggytLMjrAInt/7O1wxZybk2aEfecVyEaaU3GkPwWdOj7Ked077lH
         PAQGWE5q99eLeP7Seepab66sbnz+rPPgN5Cb6d0m2d00zGoGyr9pBCVB3PDeViIRvj6+
         C1lij7IvwQEpx/auF53Dy3yPe9qJpqFs4dJ0Ma1oDEWN1pTDpogyPqOfw8o/FbsShw+n
         2EBJBzU/kXwetnQF0Le2b7o1hRjN8Dy9i30EtQ3TSRty/i1Oy0H0as9e9ZxXssFyxcyG
         w+ZlJ7boyPuwjNIAc92U0pLO5juDK00rhw2n6PAEFQ49KSLWsApiyRQhUBRJ2RjqU0sh
         1MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582769; x=1781187569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4NRZUa7I3XPfqUu/QiRSG37yGjwWwJiviNkPIf3sJNM=;
        b=JXJbxXxwoWbjSn0k6f82qBCRD62o81wYEE3VPiem8RjIZcHtSdtmlL2SpCyQVr7v0F
         Aragv75IE27paiCrF6AnjmYi5RaNPiEALthpimxwirse4a9lPRI1n4aEcvGtuzpySY+x
         YPEnji9EezN4Kj9gOhm0tOQWNQ8KDntYcbmOUC/M0rx9XQuz4Uoml6X0uqBWNLErDgkA
         kzlfh2T/Wd8VgtQvmVtU3aFwaUiOqrJVynVvsNTRHYuqCgzZ3k31AyvneS+X3jm1Jc7p
         PGkbYBk1m8mG1j2Gway0Hz27Br4eKSCeOYHbhZ2gH246fssIP/ZlfgxG49JoaPcCyzdg
         NbVg==
X-Forwarded-Encrypted: i=1; AFNElJ+3ucNP2i/P4c782HBMALN3hIv+evPKQ+ReF6yLtHql2DAZmVEgsCgr4q0wD0Xab0x/Lc4cg+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjYazIbeoc1j7a3MJp+HJvuyBETUpS/f8k6YqmJa1SrUQodeD
	irP7JV1bfJlLKbsFhlGpV1C380V9byiySCFjGApK+9RsnN14CsZHGbA7
X-Gm-Gg: Acq92OF8lE42oCNQDid8+1018CVmCIS5g7OBkZ9NP3Cxu9prSHZh9j1dTHMh644uu7X
	JnU1wMNlHKH6EcJkA+B31Da/U+pDckCNLTMJCzQEpkieGUB2WF32AusoGCZJZ4fg2ZJCVhD58JP
	K3IADkpmqvoQF6CZv5qlfbyEDCTehKP3Z1u3HnK/fjKkAsMBWsHFryzrsrs+bptxx6AYBqk5suy
	R14PGAWfov+T9CyNWT4sSGplZZda5E93W+nIca+We5qbLihb5aUYlQbD3ahAJZd/4QCaHzZj+J9
	r/+0wvfhZIBJmJOUhfSHveO+Zo4ac4TzqYO6YnAU9rwK1KGmSIFJsnJURWAuIobkbnoufebP+19
	Mt/nXFgcwoYL60dx6x8UvinplqJU5kgBF70nsARysrq7weKHAu/zxGWzty46VNDHet9wsdW5tPk
	V6zdb2Y37e/qojldy16RfJBG+1mCFjeEKVPRK9JTDFKEvucd70IA/FXOpyne7vbjQKhs4KNpc=
X-Received: by 2002:a05:600c:698c:b0:48e:6db3:ff33 with SMTP id 5b1f17b1804b1-490b5d41d43mr146363555e9.14.1780582769139;
        Thu, 04 Jun 2026 07:19:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm3788978f8f.32.2026.06.04.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:19:28 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:19:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Tim Bird <tim.bird@sony.com>, Amir Goldstein
 <amir73il@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/dns_resolver: use kasprintf +
 kmemdup_nul to simplify dns_query
Message-ID: <20260604151925.081e9f47@pumpkin>
In-Reply-To: <20260602071343.962830-2-thorsten.blum@linux.dev>
References: <20260602071343.962830-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295284-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:tim.bird@sony.com,m:amir73il@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,sony.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF052640EEF

On Tue,  2 Jun 2026 09:13:41 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Use kasprintf() for descriptions with a query type and kmemdup_nul()
> otherwise to simplify dns_query().

It'll be a lot slower - if that matters.

-- David

> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Reverse xmas tree (Jakub)
> - v1: https://lore.kernel.org/lkml/20260528222030.1655010-2-thorsten.blum@linux.dev/
> ---
>  net/dns_resolver/dns_query.c | 33 ++++++++-------------------------
>  1 file changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
> index c250d82cad96..14bee83cbe22 100644
> --- a/net/dns_resolver/dns_query.c
> +++ b/net/dns_resolver/dns_query.c
> @@ -64,44 +64,27 @@ int dns_query(struct net *net,
>  	      const char *options, char **_result, time64_t *_expiry,
>  	      bool invalidate)
>  {
> -	struct key *rkey;
>  	struct user_key_payload *upayload;
> -	size_t typelen, desclen;
> -	char *desc, *cp;
> +	struct key *rkey;
>  	int ret, len;
> +	char *desc;
>  
>  	kenter("%s,%*.*s,%zu,%s",
>  	       type, (int)namelen, (int)namelen, name, namelen, options);
>  
>  	if (!name || namelen < 3 || namelen > 255)
>  		return -EINVAL;
> +	if (type && *type == '\0')
> +		return -EINVAL;
>  
>  	/* construct the query key description as "[<type>:]<name>" */
> -	typelen = 0;
> -	desclen = 0;
> -	if (type) {
> -		typelen = strlen(type);
> -		if (typelen < 1)
> -			return -EINVAL;
> -		desclen += typelen + 1;
> -	}
> -
> -	desclen += namelen + 1;
> -
> -	desc = kmalloc(desclen, GFP_KERNEL);
> +	if (type)
> +		desc = kasprintf(GFP_KERNEL, "%s:%.*s", type, (int)namelen, name);
> +	else
> +		desc = kmemdup_nul(name, namelen, GFP_KERNEL);
>  	if (!desc)
>  		return -ENOMEM;
>  
> -	cp = desc;
> -	if (type) {
> -		memcpy(cp, type, typelen);
> -		cp += typelen;
> -		*cp++ = ':';
> -	}
> -	memcpy(cp, name, namelen);
> -	cp += namelen;
> -	*cp = '\0';
> -
>  	if (!options)
>  		options = "";
>  	kdebug("call request_key(,%s,%s)", desc, options);
> 


