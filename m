Return-Path: <netdev+bounces-254506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFZeI524emkr9gEAu9opvQ
	(envelope-from <netdev+bounces-254506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:32:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA51AAC89
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC8A83002E6B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 01:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13022FE566;
	Thu, 29 Jan 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KWAglPss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D319ABD8
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 01:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769650330; cv=none; b=ls86mnHFtPesypZUAGn5XXdwbWFGpcd521fbvE0W5VCKOXnqykxvrypSM+v7uiqXI9Q5ODwSgsZIp6lIKXBztmVCsXUAC4txw2UgH9slBdqajXepzY0RC80aykAMPPy0Sx01Vksr7oA9r9onGVViUZozYpa9+SO28rGkL2YIDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769650330; c=relaxed/simple;
	bh=Bcc5hC+ASc9uvpT5HgVAEj4Tl+b4TpZScy6xlZWAHrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C96OGzmPJw1Jm8aRJhzYO7nTyJbIgO/6Q9+7z2+RsbowViKtScTpVctAVdFtJo9N3e/nS480mj8eM+kDn4QjGfw2qrmvM73HGGpqhX6MgIjn905ibfDzhJ0dcJSfmbYukVr6/rpWv30oCJZFm0q/wjXVLx3v+KocUtSTQo/FE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=KWAglPss; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso1642395e9.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769650327; x=1770255127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZSal9qb9qHfiabhRiyUi4l/RMOn/fC8jtI9T3CRNJo=;
        b=KWAglPss08bh5hHrkcgHoRe7cpMgJAMpYCOZZjxSvmbtTTETbVDcAC7BxIL94Mfkaq
         eESclf35jw1w3F7ZXz2ZJyf27f8+vHUy3/WhivaWM+M6c1BpouImBdpkD5WN0m5Ik2C3
         10mBXyMjX5IiilICLfKAQOXoRGFtMHKCDt+gGHhgbYcBaAqW6uQf103YjdNK15wA5T26
         /DN8j2uns4qp8dnx98C/jsQQUi7vGhxHD+phmtbMpN7x1p6KSbr9ADc1nCE1t6ktgwl+
         vaDN0JpuAMediEUhDgL/lNstIUx3hy4D3tgoklDEM2V3zgA2Ij3G5F2ueHf/dSgpEax9
         xlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769650327; x=1770255127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZSal9qb9qHfiabhRiyUi4l/RMOn/fC8jtI9T3CRNJo=;
        b=tqQYD1KlgJsQVJeoEBxEMmP/i/Ytft93sdUfqAJz0WlDWSP5h4EHJPqVqqQRsEEJep
         MGyyo96aMb7X4I0EX3HvCdndjGlhJKAWxoOzgcT+GFEqIrqX5kd952Cnnt6kt5tV4GDw
         PTCOVbyetFk3P7PJtJ3lujVfGxkeyRhQwHZ94vEAR3Ai378HQ4uDdSecEN7BMoV4wNYC
         OaMPtVfC2stfTABhqse+DRJo13TCeMddDvI713LpB4Dy82cO9iqCqDKl+L2NMh4eGEYX
         pY/YT2bGTTcFeOnY70OeR8bDQgrknxAw0PzcgX9EMcD/rQRHUE2CC9CgkHGvEioys7s/
         2bjg==
X-Gm-Message-State: AOJu0YxGZPdPw/4UZwx2ArmRHFP1dWdQa430Zr5TDHHWKI1KbD68BEFG
	0X7vr4iyNYWyDQ5vXNLgrZMx8xPbUj60YPzc+2oTgoHwT8EMJ8e/B4PLmAqlOyo4ORxBX4Un0eI
	c1c9LYb8=
X-Gm-Gg: AZuq6aJL2dBVlakbR262ooDFiZmgyAlF1/S2fP4QD2iG3EBnQZxnT/jxkVGXH+SFolL
	al1FeLUM0gj0SQJTc/ia1/JmW5ZIuUo+G4gB+yvuhahxCxv4WnpJTAWRd6aLZ1U0+P7qwxDciHR
	51c6GljcmKKFXhKoWe0UM91NPlUy9rPJxH/tbtEnz0xl7Lhl/NO6nMvB9RDi5q0HyOqoIMJg1Ip
	HpbD+Owi8eoEQOlemUmVA9V/JBWz9wjKa+TuQiZ8codCuJ13ifXPKG7Ig52NedXQ3t8IZt/jEja
	CrTtoq5rEqWW6OzSBT8q0lDaB2v5TmAmlGpv/urHwnZC+DtiqadDNi/9lwb61pCmNbZVsyF42MB
	Cx9xm5VkV+5v03K84Mo3eBMk7g4m6LGPNua3AudCv5oRLbMfR6y5TMVfCKLR8WawBdNYVepVtHo
	qMB07H+y8jFugwpgJxBYlvKLu0AKI5Yn6Qvzl5fI5O9O7coInmDGSs
X-Received: by 2002:a05:600c:350b:b0:480:49ce:42cc with SMTP id 5b1f17b1804b1-48069c0de5cmr87447895e9.9.1769650327390;
        Wed, 28 Jan 2026 17:32:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132356dsm11295622f8f.33.2026.01.28.17.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 17:32:07 -0800 (PST)
Date: Wed, 28 Jan 2026 17:32:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] doc: add AGENTS.md for AI coding
 assistants
Message-ID: <20260128173202.30cdcb58@phoenix.local>
In-Reply-To: <6f5f0afd-ded9-4438-9dc1-82483581489f@lunn.ch>
References: <20260124221439.234122-1-stephen@networkplumber.org>
	<6f5f0afd-ded9-4438-9dc1-82483581489f@lunn.ch>
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
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254506-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: DDA51AAC89
X-Rspamd-Action: no action

On Sat, 24 Jan 2026 23:29:45 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Sat, Jan 24, 2026 at 02:14:27PM -0800, Stephen Hemminger wrote:
> > I (and probably others) are experimenting with AI code review
> > and dumentation tools. It is worthwhile to have a baseline  
> 
> dumentation tools? I know we say code should be KISS when possible,
> but i did not know there were tools to help make our code dumb.
> 
>      Andrew

Guess which part I wrote..

