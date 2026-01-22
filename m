Return-Path: <netdev+bounces-252484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DE4NPlscmlpkwAAu9opvQ
	(envelope-from <netdev+bounces-252484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:31:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA7F6C75B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FE4F3014924
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A3B360756;
	Thu, 22 Jan 2026 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qfrrln7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572E2D6E44
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104291; cv=none; b=b2oAJtFJ5wQMRo3h3WsZGCD1MeaeE6wMBuwHggyLoH0auI4kC0ablIErPeCQPk2EFG6BtDsfgZO0Ia1KgrT7jX0FjrMqt42HE8w7+yrGnheVqAfnMq9sunhdelQkWTKGyE37nwRzWbpIf+ZA1wvAoCE1OXEwmRM0yE4neEM0J2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104291; c=relaxed/simple;
	bh=pRIQIWRrRQgnj3ezXQTQ3jrO9DmpI9kPBw6zPbHb67g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce+zCBDWDR2VmkPlEVUUIv7bqkHKHnS8FNKw/BxsLjHHQRYqyX8uDYkRVjG6qQZUj4wsomsodphdsP+mXxH8C6w7E72FVxh3oWX0Xv8IwfW3ORzQDugazwoNN4y2idPl0PuXRTTUnVlNB6OcSj+5b11Mvm3WOQpy/Z3Za/4fv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qfrrln7P; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so10127975e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769104281; x=1769709081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AS4wzg3mx3qj2Nf8DZyjeBJuZsttBAvemF6BKgHNWis=;
        b=Qfrrln7PGNuizmBYrmItUNneoU+j9SrxNhbg3FpmRoJVInXIVwkel16lbsF0Qt+pnT
         w3vieA8V4U/6skgBZGvdomGnuAJbEnBFAZT4CPubR5NCsEQikcNScQ7wQfOcEm+Px2SC
         FjnPkPAqLJlQyuxPdv6idUOsDTtb/fweZGGF51l6FbqN5OSSLD0qxA9B4SwGV+XFFxrp
         URbQ/cLhVUXDckzAVaC1OP6hW1nOmQ6fDSAA855wy/Rn5afbll+nvNcPuPchkZL5GRfC
         32mPUORqpo5NnRg2UvEkQMMO3264B2AscJrXvSzfoq//elRxn3As++HZwwrITX6vaNpI
         Rlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104281; x=1769709081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AS4wzg3mx3qj2Nf8DZyjeBJuZsttBAvemF6BKgHNWis=;
        b=XwjE8xx+hmEoR11s1O2yIviXTMDUKzEdlQ034S+a2285xSxb7qUbVPJjW3lLtcI6E7
         tOJgrGf4vXxt4R8RNR0fk71HhbSBb9+cBNHSzGUDMxGIaPvjhq8SBuesEBVnhpSmfdOt
         78gn7WZ+OMxCipv/OuYc1LnG8RUVnGuOPjHNSWAgvt7zc3Dm4/lcAPzmP2WgrT/TRQAL
         t43lDImAZzZbZa0W/OYA9CN15oIVocp5cg2QnyiSwWJtbqTSQqzdHHQPSSjRbTYlwJgC
         Ridtq/VGC7MmF1mziYaoW4KflPKGKo7Fen+82dqvEzqq+iae/YYwbDm1IbbuWm8ZV8r+
         plWg==
X-Forwarded-Encrypted: i=1; AJvYcCUzguEwBEBGXV9PCJHBqHOq4eAA1qmtFePJ04IGAvSeDsP2zVxW3e1RiskoY6DjJwL/f2SJY9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YySB8arjinKk+p9xhh2Gzyj8UhKYFEkTSIMWojoQTI3UMPaBth8
	kl/449oxStlPNvcNk1TFkXBj1Sd2dR7ORMjUT98oYl3vUSX8gbCVrFfi
X-Gm-Gg: AZuq6aJgy5Fcvi9XfOWstwI/xUDTWgclYN+/LtEn1uVWcIgylX35ps2c2KhVtC2CFJR
	syZ81Ula40Y2bNeJQq5ICGyJXdba7HjNGGF8bTEnTQ/fX3AXMUpSKTdVvp9kSHijYc25T/p5L/p
	Qa2djWThAO0XK8Ate6zA4vD8bkPzK5f7wiEwgb1X4CtnQfPSf9fgoAmHYppKHozb0WvPgxzfmf9
	6w2O3BIQepBXDd2Rnfwkuuj79g3OMorMgkYZ8EzgRiEGxeyf3hxN5XPuR3gCv/UF7IUHxtpXhi4
	I4vvbD0BfygpYnZyJGgl6lMKmcMXL0lmIZII9ZCl+g6mS20JS6x6bCvGDWUhzhxieTftqz1SSiZ
	2+P2EPbWjzR/iYy9x76bzIhfjr0ZIYwilN8fMAdIFx6hXOwq3KZaZWzLQcsL15tf/03uGf8EnIL
	n6PhexIXqDkNgNMR0d
X-Received: by 2002:a05:600c:1552:b0:47e:dc64:f1c6 with SMTP id 5b1f17b1804b1-4804c9456e1mr7701325e9.6.1769104280996;
        Thu, 22 Jan 2026 09:51:20 -0800 (PST)
Received: from archlinux ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48046fb7eaasm83645505e9.0.2026.01.22.09.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:51:20 -0800 (PST)
Date: Thu, 22 Jan 2026 17:51:18 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Message-ID: <aXJikx-Tt7XjHpl3@archlinux>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
 <20260120172057.6600eefe@kernel.org>
 <aXFIk1L8G_dHF6od@archlinux>
 <20260121174505.5e710b0b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121174505.5e710b0b@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252484-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AA7F6C75B
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 05:45:05PM -0800, Jakub Kicinski wrote:
> My main point is that even if we fix the HW setups to do the right thing
> in systemd policies - the tests are running against netdevsim, not the
> precious HW present on those setups.

This makes total sense. I got too carried away trying to make sense of why this
was failing (I might still submit a follow up to make the test more resilient).

> I don't remember the history, it's quite possible that Breno wanted to
> have a separate target for netcons from the start and I pushed back.
> I think we reached the point where we want to create a target.

Sounds good. I had a chat with Breno and I'll look into moving netconsole tests
to a standalone target.

Thanks for the patience and reviewing this series!

-- 
Andre Carvalho

