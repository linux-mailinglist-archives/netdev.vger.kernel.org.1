Return-Path: <netdev+bounces-264278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB0pFRNeqWkL6AAAu9opvQ
	(envelope-from <netdev+bounces-264278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:42:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E152020FDE6
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 302503066CCD
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2B38228B;
	Thu,  5 Mar 2026 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="duvo3kHf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE737366057
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707232; cv=none; b=dO5BFjW0h5ZCHkZBaNgaLKzKMU22PlATia5rVGoLUOB7tMOYzmAO0YBYYfYr158oq1eqnrsmNWbjY3Otkm9DyfxuY71xioVpxqhUTOkBbygnMilpi5fvtnpG9MEt/Ws4KlLI43TdYeUlc/iVxQL5caizTVzCDeLtS2A8bWw7AYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707232; c=relaxed/simple;
	bh=pMXAPz6rRpIt0TmYV3UYgAGQEEmHwHzSHA9H7ONKRgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ayyGPrigzQZOjrJOk5EbhtMKfoDGMwRRINx7vdphvMGnEOwRgP/1U2P4+BtkjMMTfzVLDJIdeCeNl2qHxh0e19FaHRCXmk3xfFMmdrdGR3zlgKUVDb0acvXoM2xJ/c3wkfM1NBTdw0lGcFBpkmiNKVBNmhYvUQRv+Szvo62lWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=duvo3kHf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-660a293515fso5729365a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772707229; x=1773312029; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OmEEWEe7hw50EcSRskP7Ho2A43L76NQ2PK5yFgjRUKk=;
        b=duvo3kHf2pqNHkWqet8xy4Kc5DBBG0/8uecQa7ids7UqABS7u3OlzI/cTMFVJRnE+R
         0JnlT5olx7uxwkNSsOZVpaQ9TDHL2cf1YqczwJ+9cmOuGQTIDe0N1gsd1nx+ay/kLYH+
         /3gTpeQxoEQ4bdRtFAXHY9vHjsGx6XWxyltJ4P6OpxeU+7ZWVGRZhGj8/MMZDqhDeyll
         vMO6SL5TAshultlByEemdDLoAK38+gtLPYt5nvybBpD7Ofv5WWceyf+Hhizq3qsKNdF/
         CpMzcf2QkpnVBrXSMJ/BzULujslbk5m7S/mZAsOKwos58fz2bpY/V0sKYcq9cm7FHudx
         NtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772707229; x=1773312029;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmEEWEe7hw50EcSRskP7Ho2A43L76NQ2PK5yFgjRUKk=;
        b=rmDa3V8V/jNVICmNv96RWYH1M5GOa8Q+kDqhJ6FEN3IQZwpfmsLituYWJdPyHGpCC+
         vhwqYfCE6zsEPJGRPIhfhzpF4FWq1tKJBayY9bQmkHV0+yNrejiz3xrv5ldt1R17ctjC
         ujVVqQvZ5Dj3cDw5C9xp4aGAnmI3yCQ5Ow8IwvKLslw5t1XVxcwZoNmHyMEgt0XKiYni
         fXRJ6F3Idrqtm/y12ZnsIMusChbIYE5Rt02CJBS5NgTlUbu7ZBrlLEyh6nmWkrhkZ9v6
         WrgmqYxCX5HTK1x0GWS0C6wLKaqBpLNtz3mo9RZAxGeKXSKodtN673AiZvWEuMcDQKVL
         BPXA==
X-Forwarded-Encrypted: i=1; AJvYcCUTPQjEWaMkSywfmMlhnTfK6RzMs4XDUusINALYv1x54ICOVa7NzNpvJPS+mwgl+5Hb2nvdPuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJXUtk4P972hlJiaJWBbdDtFINIryYkJE1zWm0zUykpz1kJ5R
	W7UmoD5nBT8M/vBHbiqFE+peg/DjCimxO/DhzbcKAEtZYZZhdWjPdnfigB9y8z/C2Nd5YUIRrU0
	DHdvt1Cgf2w==
X-Gm-Gg: ATEYQzzoSiJvvihRzfyVQLeApx3XBYK9NXyhq5weQEtrfduFQ85LfjdF1ll+jL6IclH
	U82s1T+4BBqF79IesuL8KXRcefZYxFftwkgE4j5KFDf6nKxDz/pVhJAMeU7N0Onk8Z9yLCqXo7y
	dsYdSfdBBy5qiLK+M4AAo+vBk6W0RppWyxKm7WsqDRqKM8LkFK/dOzs9bHAbJuux2pZzEcgTZiG
	rC6MRk4TRAIQ1ybgf6wmjrIOG6IX2wpMqRp5nLRZv027zK7VUmhyIP2x1QQllVD7Igzwg/bQKGO
	fC1/HEg/dql2NFP1dFz3P/b/4nHcqyx0MXf9zml8GW3zbtS2X05bFyvn15EY2+d+d+OIw/9qpkx
	HRp0iXcM8R0AHcwIKAG46clUgX74D6c+5oitLD7AXXje0znVT2Nbbcvzyb/r/FGrKaxR8MX2RMz
	IMzgM+b7CObtyq1Xu89EgD+B5J2NPdl2zPYc26NlkbAc7xld+amy6IXUp7B1uOATZt2GRGrr56v
	TMchsrL
X-Received: by 2002:a17:907:7f86:b0:b90:1088:6c54 with SMTP id a640c23a62f3a-b93f146710dmr305133166b.34.1772707229102;
        Thu, 05 Mar 2026 02:40:29 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ab13558sm914137766b.5.2026.03.05.02.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:40:28 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,  Neal Cardwell
 <ncardwell@google.com>,  "David S . Miller" <davem@davemloft.net>,  David
 Ahern <dsahern@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Kuniyuki Iwashima <kuniyu@google.com>,  Simon
 Horman <horms@kernel.org>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: remove unused hash_size from struct
 tcp_out_options
In-Reply-To: <20260305022703.3946470-1-kmta1236@gmail.com> (Keita Morisaki's
	message of "Thu, 5 Mar 2026 11:27:03 +0900")
References: <20260305022703.3946470-1-kmta1236@gmail.com>
Date: Thu, 05 Mar 2026 11:40:27 +0100
Message-ID: <87eclyo8ys.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E152020FDE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-264278-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 11:27 AM +09, Keita Morisaki wrote:
> hash_size is declared but never read. The MD5 path always uses a
> fixed size of 16, and the TCP-AO path uses tcp_ao_maclen().
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 63ee037f46e50..f0e04ebd8b723 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -441,7 +441,6 @@ struct tcp_out_options {
>  	u8 ws;			/* window scale, 0 to disable */
>  	u8 num_accecn_fields:7,	/* number of AccECN fields needed */
>  	   use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
> -	u8 hash_size;		/* bytes in hash_location */
>  	__u8 *hash_location;	/* temporary pointer, overloaded */
>  	__u32 tsval, tsecr;	/* need to include OPTION_TS */
>  	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
>
> base-commit: 21fc6b53f12379f3f9b29830be3597a322261df8

Worth noting that this closes a 7-byte hole we had there:

        u8                         num_accecn_fields:7;  /*     7: 0  1 */
        u8                         use_synack_ecn_bytes:1; /*     7: 7  1 */
        u8                         hash_size;            /*     8     1 */

        /* XXX 7 bytes hole, try to pack */

        __u8 *                     hash_location;        /*    16     8 */

Struct size went down from 96B to 88B.

