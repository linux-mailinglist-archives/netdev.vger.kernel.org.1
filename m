Return-Path: <netdev+bounces-252331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKwMME0YcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:30:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71F66A51
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43AD98E5C5A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B699F28D850;
	Thu, 22 Jan 2026 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="mqtzlL4T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BEF333424
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084053; cv=pass; b=AmuqspzCHuwMyIOdbTT0EwqPXg++M8kNNJkPrOYHzAwOYSFrzVVRS2/D6AiyWeh9tvWReiJYnDtxcMjvNEVB9nAuoYSjrdhXr2K3doxQqML/uuSFmSHq+2nshU+X5vmrwR38j0x7hdyRP/fXhUZhfcZgPPlrxYc4Bm98GbtNolI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084053; c=relaxed/simple;
	bh=x1HSNZe4tcjZ8dZN0rtmuX85jUwKuTptbJYB2DuoAGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rK9yqbeS1W6boQ9ME5Z6/jDzGEEUVjYc31RPV2yHPsBydrzA10LWZeocXyH05RCegvm0DtqxfEoJ0o6CP2cf3Ncpkh5u4wdD3yKrSwCTsHDste0zsuU908WgVduR6R6IDudrSA2SkD3ZQIVeT/YhyEVKWiUOj98zXYqf07NkO5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=mqtzlL4T; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c634bb5bd8eso119296a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769084050; cv=none;
        d=google.com; s=arc-20240605;
        b=NPoF4iGoJWSlMr3fTHyojXeUxRxEnpkn3jriPRBLc9nO7aDcA7/EkdvgGRgzunbEo6
         RcUJWQxbpSaWPAOX4zNzrpA9DQMKvfZ9wy4SXUkudkPN7BagvILXrR6/ewYgcORj3Xcy
         tFLWf+5iYTd4dKHws+ibL0dxfkzfB326aWYnLLu7svcyJPXH0OTOOnSSGJAw1OD90mPM
         Yr++x51OXqlqx+RhNQjULWWNa+O+chORCBUcq5hcupkoGd8sucA3CTCOFsUxEbbdbuRZ
         6neguUUcZyqLrzUf+m6iX4Z03xpo8voDPEo55GyOGRPv3a0JPsBREAd3YU+K4eP9ORKD
         Jtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x1HSNZe4tcjZ8dZN0rtmuX85jUwKuTptbJYB2DuoAGQ=;
        fh=rHeYutayo0pcFDxVlsfMzm0OIsTdMbBtQ2pELn5L3N8=;
        b=e+evPc3RbMK+Tlbw9wMTY9W9cEwP3nkq5gJtXbtQxS2vz+5IIGCl5wkwr4wlAZsqfT
         Thadau1/YejceeH/2we48BOTtUaYN1MOjezN7nC9zKXBit1Yw2uKx/MYL/B971kiXthu
         CThSdlNOy683RgnXtT9b0SKTDsrllpxMFGdKfhdOIvw2A6w8iLFd0Oidt1EqyeTgQimI
         wCQr3sQiFjm4JPqC3BygFIsFItjGfZCR9jhOwVrRBqGSczoHZBmTVMP2rWvZyouUm00t
         Sut9z1czbb7Tx6tAWizKvwiOsA9BZ87h8niYlpMu1Gy92xwMSWqPMRR6OjyS/T/Ep2vK
         Rcxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1769084050; x=1769688850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x1HSNZe4tcjZ8dZN0rtmuX85jUwKuTptbJYB2DuoAGQ=;
        b=mqtzlL4Tm274vvJ+LBrY4v2iFjV34WFrKFwZg0vAfFbCnC+pKZpPO8oMqJ0asHIwrM
         ro+Z5n+FcdONAlxlqVlQLWSLUasGNJ4BQKUKmaBNRwRfZ1hING2H51YGaLi6N2YdsbFD
         /vR/q/E0wzEfGX877aiDjmYGXiNMKN+wuhHqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769084050; x=1769688850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1HSNZe4tcjZ8dZN0rtmuX85jUwKuTptbJYB2DuoAGQ=;
        b=CaFhbdxKaUfsbrDOWlsJUoHaz5impYwsf8E2Ob+YMFIwyES1y2YptzghOl5S3SiUr8
         xRFbkaBz0zRT3bjCkIwb1hXgk4OLKCZifiOKeOjWhkfE36IDDKicrFA6lLUP9AvNis5x
         sps/HawwMugHLtzudQ10mp1H+uClGGpggqSFH1qVZirHRG0CDTHv92+v8Je90m2peIiR
         l/SNwcsx6aOqMmXsQKXb9bSbT5LjPYn7/JrMis4E1uZ+PdOdMOo0LlD/+JhHzatT7TGB
         y/kM7i+qK5HzcSTEElazhUBSfA+IBV+mmAP+HDnlyjjCOeTkgxK/arWDnQ4WLPOqTsiL
         wESA==
X-Gm-Message-State: AOJu0YyMYvEkeU6R9FHhWKv1FXSR2rsBpcVxlRotVhT2/zXodTlTnb17
	cQHIoZti/4Xr6LOxk0W/FZXlrf15JUDX/AVJiwJcdFq4TH14EGcYxugcqyxh1FeXKXiQhk3oDS0
	3osD4Dz5KB32+wjhPdXhl73XrMDRn4Ps/FOc2SRdCpQ==
X-Gm-Gg: AZuq6aL/3Ej4cTO8xIo7fQcTkZWWERuKuE+UbA4P81hLwBUrpey4O91vEiRiCxY7U89
	Z1B5GPPRi7BbnMK3MdzvO7qSF0h82gRgmWZ8PbwFjmGFg6Fk89z1mBXSoWvZjMDb6UxxD9knbH9
	ayhex1obr6NRX6p6HEelhEYcidl0NrMAII0TovIQ/J3nMrzSNypRzDbghqSxYAUoGJoR0VvQXQ1
	Ut6WiJ6dKMKEIgy3XVDXh/imzt8QNtrXJAA9uTfllHPI/wRcBwPG6kYqUfildP8KnqEjL6I
X-Received: by 2002:a17:90b:35cf:b0:34c:6108:bf32 with SMTP id
 98e67ed59e1d1-352c40a8501mr6975147a91.34.1769084050562; Thu, 22 Jan 2026
 04:14:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121084532.60606-1-enelsonmoore@gmail.com>
In-Reply-To: <20260121084532.60606-1-enelsonmoore@gmail.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Thu, 22 Jan 2026 21:13:59 +0900
X-Gm-Features: AZwV_QhGLrR_GJkeQXgbzvS81DS_i0A0Hh4swYvW7BCdb83HT0KZ_27RcL9_Md0
Message-ID: <CAFr9PXmWjeKYeTO_QucDeQvj=q4hvVtEXZ2+HR_30PcLSU_gLg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: atp: drop ancient parallel-port Ethernet driver
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[thingy.jp:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[thingy.jp];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@thingy.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[thingy.jp:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2C71F66A51
X-Rspamd-Action: no action

Hi Ethan,

On Wed, 21 Jan 2026 at 17:45, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
> "The parallel port is largely replaced by USB [...] Let us not pretend
> that anyone cares about these drivers anymore, or worse - pretend that
> anyone is using them on a modern kernel."

I think I only got CC'd because I touched one of the same files
recently but as an enjoyer of mainline Linux on really old machines
and I didn't even know these existed.
According to google's AI overview the oldest machine I have running
mainline was released 1988 and even that has proper-ish ethernet.

So for FWIW

Acked-by: Daniel Palmer <daniel@thingy.jp>

