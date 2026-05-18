Return-Path: <netdev+bounces-289187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBuPGYWOC2p1IwUAu9opvQ
	(envelope-from <netdev+bounces-289187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:11:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ABC57452D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E59E6301CE88
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFC3A63F6;
	Mon, 18 May 2026 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="vtNhK/OI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9913A7F61
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142256; cv=none; b=Efklheeifja9TYUunxXhRYyL/4YZUlZ7IGBofHwgq1MqDwxbLKb8S8cVZF8eFoiqKyaJ/CgItiIuBU2mA313nE7+CTsy7njAKjeL9A6ABERW7B5sm4NS4xOUARKUThQrh02mOS0mN63Sb0BVs7DS5HJW/2lcJolav8vhHKtKdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142256; c=relaxed/simple;
	bh=E1F8Bv0JMO95AP1LroZfNQSpDjtd44MvQX58AKIq+XE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+81J/VX4w0HP5nvCP6utauy3udUT2sBCReQAy34PPfQcdHIZjt7+T65cK3+QdHaLsu3SUIghFHx2IBc9wlDb9q5zcuKL2cBCfTbbC4Lfsnkksktm7Rtaae7StTlUZwdBvObZK97I/vlOmiGIdx+1eveD+cGcyeCi14wHiDWqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=vtNhK/OI; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8f9846c8so3293463c88.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779142254; x=1779747054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6vAzFHT3rBOl6VAhV1BRH93ujw55GkVtyi8zlCynfk=;
        b=vtNhK/OIHRFILCPkEhWarZTYQlIVfR56VDZrqPG/GNwFcZE7MC0ya0BBbeHWFkjk4F
         C6Bi1dnAjiNk+EpwozhJEOKDXJfOeQKzFr0ms6ME2zK1gaQ1QjwRjgwkjHwXUO+Qy1TG
         hYBqSpN+GpVAE1utTAOwoe9x0ivSke9k2t/alivwzFj53Uv4I9oY73IRcc4cTlqLryx9
         GHmDvZoUekqo47fGmMNHUDQtmMPxxZ0Z/+Jgnde6YewfwRz0JR7Hs1MbVXim5aDqwYh8
         vlBBA6aJPkULXaBiNE/1XE8Le99okf4AugV/0DBcu8v7ee6yqEn8IpOn/dvjleCNhZKH
         Uv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779142254; x=1779747054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N6vAzFHT3rBOl6VAhV1BRH93ujw55GkVtyi8zlCynfk=;
        b=FWg1RY7Pq3itjvY6vsshJrWwRK8mz6ZCG0OyopAA18l+Uvam7ltFkR2FuMzL9kzvyB
         rYwy9REUZu4yyss8qCEjDSF+h9DX0rfNZEndL55xV5hoE+nzzdIuMtBUfV7LYwKyJ6aT
         tRHEJdP5cmCei75ePxulOOUFVPYMB4jSfkNK+i+HxqFgM7cniJ2WSjfmc8jpoxgZnWsx
         aqVkgP2h45nxRBMyZqdZnh+vS9g/EtbzwP8L1J3zr81ESvfV5PJz50+a+z82InAiC/2j
         u65RO03I/HzG8pZG0WHVSGZu+WFGy7eKDtGQmAwVXJpb+Zb72qt+5RGEQwElpIQ3rCGf
         aPAg==
X-Gm-Message-State: AOJu0YxpJMvw1eewSU8eUPgtENEqPQZ/GtKD7M0DvjYwac1gR3iYiInh
	/bJbjsWIkmb4FhWr5rRu46VASPG/4v4RdKTw4igTsix8RGzJUaleFr7WDb9DR2jUZXA=
X-Gm-Gg: Acq92OGfsKom3SePw7GQH2SdQyqEzJEhMR0tPBC7sdU0Pjzqm6DtijREf8wlj2oqZyP
	MpoAgQ7QUoQFhGbDJr0d4u1mHH8Vjye1s/faUD/nXMBuACkX+JcZjzj/IZzwooqURZNBvztx2Jk
	2Wcmkg7LkzYswJUkjsNO+YljUsFdKPoBWaWpTXELXzlHjGwx1h0bBWF7Gy5zwr/UOI8DUu2GUMw
	vbL939t1trsC5aUTwGRxGaes3D20lH9yrKRS6/vDl8BW6mr1VLm+axr/UgI5XNt/QVtgRbh90Vp
	2P/LFJLyrcrJjw+u05xlMA8Z7XLF09VIi889oJlgstX9XUW6WB2MpJyT0wjWs6ijb2xpq4wGl0i
	U7d0OPi1MmnIuLF1OL6Q76WhIqLTVZ1YNDH78b+0qZZZKIuN7WF3eKBXuuZ/VU4hf0jQ/jkkm8/
	dPwGBqG4fk0uAW8taqIa0jIOOcjFMMzvtJht1dV//FcZAjKQ==
X-Received: by 2002:a05:701b:2611:b0:135:1be3:a4ac with SMTP id a92af1059eb24-1351be3a71cmr3521981c88.23.1779142253940;
        Mon, 18 May 2026 15:10:53 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cf44668asm17681620c88.6.2026.05.18.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:10:53 -0700 (PDT)
Date: Mon, 18 May 2026 15:10:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andy Roulin <aroulin@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, bridge@lists.linux.dev,
 razor@blackwall.org, nikolay@nvidia.com, idosch@nvidia.com,
 petrm@nvidia.com, danieller@nvidia.com
Subject: Re: [PATCH iproute2-next] iplink: bridge: add stp_mode support
Message-ID: <20260518151050.5dc637fd@phoenix.local>
In-Reply-To: <20260518163647.1935156-1-aroulin@nvidia.com>
References: <20260518163647.1935156-1-aroulin@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289187-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D9ABC57452D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 09:36:47 -0700
Andy Roulin <aroulin@nvidia.com> wrote:

> +		} else if (strcmp(*argv, "stp_mode") == 0) {
> +			__u32 stp_mode;
> +
> +			NEXT_ARG();
> +			if (strcmp(*argv, "auto") == 0)
> +				stp_mode = BR_STP_MODE_AUTO;
> +			else if (strcmp(*argv, "user") == 0)
> +				stp_mode = BR_STP_MODE_USER;
> +			else if (strcmp(*argv, "kernel") == 0)
> +				stp_mode = BR_STP_MODE_KERNEL;
> +			else if (get_u32(&stp_mode, *argv, 0))
> +				invarg("invalid stp_mode", *argv);
> +
> +			addattr32(n, 1024, IFLA_BR_STP_MODE, stp_mode);

Not your fault but yet another case where matches() was bad idea
because if you pass "stp" it matches only stp_state.

Really should fix all of iproute2 to use a table approach and
not allow conflicting matches, but that is a lot of work,
and will break peoples scripts.

