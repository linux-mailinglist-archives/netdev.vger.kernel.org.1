Return-Path: <netdev+bounces-294391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vtHtNw83H2oviwAAu9opvQ
	(envelope-from <netdev+bounces-294391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:03:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 558CE6319A3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:03:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=0XZ8zm5z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294391-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294391-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36AE0300B99E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8B282F1F;
	Tue,  2 Jun 2026 20:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01D25B088
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:02:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430566; cv=none; b=cdyQCERD9igH+w2Cbt6OU+ZFsg4NU4MgpXjcFYspr2Xb5ZG7wEAg/vqDg/70pJ4Mg8aDVnYLiWN6dsXfNqqBTewtEdgU6r7TB/UCAaup0+E2680PNODUxeHjFp6F33guwN3TWR/XykJETixzVztWBSffn7XqXkVZIUVF0pTJFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430566; c=relaxed/simple;
	bh=ubN7rJhKOz1075OIQcVENw6KgdBshN0T14DBYnp3L0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q53ehXx9rget5EAurBsCOMWuXWKZwlxb1ZJuRJ7DN+/MYNxFuPyf3fhl7yB67cremLIr52le+ei+SKRaRQCKpWgQxuGJlh3blDD32I2ekC2wAS/x1PqyMMAnAvICnhCFMonEIOkuo5oo5ERxkKGsUSiytI3qbKJl5V50wqCn5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=0XZ8zm5z; arc=none smtp.client-ip=209.85.167.178
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4864aea1316so528234b6e.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780430564; x=1781035364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BRYLAnGlifz6f71lYVFRYdvZhz3P6e20DcsrrJucHg=;
        b=0XZ8zm5zhZXWUqypXCOSSGfw2nOvLPJLS5r60RIH2IRCdYig6P8rwCG8p5srDzO+Wl
         REz2DUAwljlA/7Rj3Xc/T+7zprRuWQbz6rdWJ/q6CxJypuhVtYJyAWN2V8EnDWj+qPOH
         UcBdI8eBXkgEaGxxCm/V2RWmPIjHjrHIFdpIeaFxju0MdpzwVd8FVfONpae5s1wY5vPO
         OswfILtowKlf27nySrgwN/bSo9q0KLxW6TyIlYJ2ysreA7qpCM4brYJF+sA6E1iWSdNO
         InsDZrCbrHObTuv1kUYUYxq+IrE0pYMLaJsNOW5+ZQzl9AC771IUROWQyJGfiFZfm5Tm
         Vw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780430564; x=1781035364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BRYLAnGlifz6f71lYVFRYdvZhz3P6e20DcsrrJucHg=;
        b=A1dIX8Zuoup+lCt8I8/Fc/1uK4IYVBODyV3IswZ7wQlwVu7WAJ3de4tryQYLxyhdMP
         qpu8pq8Hg0R8q40C2ZnGbSL7iL06mocllgGmgLEU+XYATdjzM9IitNktEtpCvXwR4vx8
         d1LnHFrTWm3Sx5Ue1M93dwOd/1hQrBgPbYdkNhz7aCTZNc4oCE97u+7qIY4KTbwTvc0K
         2nlnJ7a40GK8BA4Cz7uhAuFy6X1IIGmOBxGK9WNoRRSl0bGcZTgOARygNqu8E4TsE2kp
         u0IQ9RiFxWy5CgA7Km9t74Phks2qdO68hSNeE6hhzH2+syL56+S7oWdWG9FOEc0S7GO8
         TUrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CofWGOUMSnb2boebTYDW17ZT81DT8ptQSv5ZTQRpCz8FelAcARYbCya20LrwRpnjAyOazOwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hit0yF9kEldYvpxB7tfjXYiv5C6YuBuS5o/cderomyXIVwE3
	1m9O0DqjF6/mDgkCErPJM4dmoKkP4pF97Uxwfwzo/hJ3+h1gPh2n+c7QWjIPCaWQrxe/W4Rvom/
	abyEz
X-Gm-Gg: Acq92OEiImWdNTTtBLjJXfdZPdI7oXyLcNmTryPzJn6Fw1XvQ1nuPWenaUP+ABnuSjw
	tJ1vTqEL2dkZXFOXuUIxQZWteVZlvp99VxWjoo1iZTp7EhXDe67t7fRUVc/eAHqmxfACyYAtORL
	2cdw4LW++DjY7LwHh4m3nrYRaeqS4acbZr4ublsWZx+9fXGISF8FlwxVxlWkM9aNpcN4WgV1Eou
	icJ5PLMUXjlfXSfq7ReoZ9B6q6zlAa9K/t8z1HRAbWyH/69ku6K/fv6tR7ZI6DeuagiMBJ6oLKG
	RpGO6sQhjEFfUIfwn82fggLc1ILOUyz2gVlfJZmP8lU+1+baoviTP1lHReu7wp60UT0ENydwlCR
	mPx/wOILcv/NETTx7uWXmCIxs0c64f7Zr2WyzwsN9EuyYVlVM4+H1JUJkW5873UOKwJvPRaMa44
	TrJrvwgb3i4c4IPUxWofD+tESMNNTfezjyM0fB2D3V+ikQfW07AgJuVBuRj7ZmdCWdv74rlQwAw
	vw=
X-Received: by 2002:a05:6808:1a19:b0:486:4c2c:63d9 with SMTP id 5614622812f47-4865a9c01bamr187350b6e.20.1780430564190;
        Tue, 02 Jun 2026 13:02:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8297311sm550691fac.12.2026.06.02.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:02:44 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:02:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next] iplink_geneve: Support
 IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
Message-ID: <20260602130240.26c03c7e@phoenix.local>
In-Reply-To: <20260602185711.129769-1-kuniyu@google.com>
References: <20260602185711.129769-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294391-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 558CE6319A3

On Tue,  2 Jun 2026 18:56:51 +0000
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> +	if (tb[IFLA_GENEVE_LOCAL]) {
> +		__be32 addr = rta_getattr_u32(tb[IFLA_GENEVE_LOCAL]);
> +
> +		print_string(PRINT_ANY,
> +			     "local",
> +			     "local %s ",
> +			     format_host(AF_INET, 4, &addr));

Should use print_color_string(PRINT_ANY, COLOR_INET, ...

> +		struct in6_addr addr;
> +
> +		memcpy(&addr, RTA_DATA(tb[IFLA_GENEVE_LOCAL6]), sizeof(struct in6_addr));
> +		if (!IN6_IS_ADDR_UNSPECIFIED(&addr)) {
> +			print_string(PRINT_ANY,
> +				     "local6",
> +				     "local %s ",
> +				     format_host(AF_INET6,
> +						 sizeof(struct in6_addr),
> +						 &addr));

And print_color_string(PRINT_ANY, COLOR_INET6, ...
> +		}
> +	}

