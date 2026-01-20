Return-Path: <netdev+bounces-251432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27176D3C4FF
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 937D15E1387
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA203D6481;
	Tue, 20 Jan 2026 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ev756wyh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tzJGH8MJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325223D6477;
	Tue, 20 Jan 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903849; cv=none; b=kd1gWERuUiSNTFyvJpc7XmCO6087d2c9tziLX4LmK8kB1DgS2lfUEvSNEec+vaozvACSMv1unscGvx+4gRJzxK5WYllFOyizi9tjugE11KYMKULMV8utaMkFPDabWu6bRRoSLIyvcR1wXrtAS6TAI366SifhTTuVRvzHXsTc40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903849; c=relaxed/simple;
	bh=F1Zw6TCGLNqf3t6hP+FCcbTvxMoD0YoiJHXLgtM7PPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gVbsfLze+EQ7CCHBX8KjowNKyXabsjEshB70em4nkiT7laG9AL669w3SFiYjmhQcCWuUDoglo5I9k9pMhWHGkocc+SOwNjFQGoJU2vbUrtHpp8jiHsG0lIonEKaAJJ7ieZiCSag85nKgup8JF0ZDSXIocvJtduPZZEN3gwkGKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ev756wyh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tzJGH8MJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768903845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1Zw6TCGLNqf3t6hP+FCcbTvxMoD0YoiJHXLgtM7PPI=;
	b=ev756wyhL5oQnxjyE0+KoLudN4honMIfLcxvyPGFhr1d/VzdxpgQ2ZHOe1V52q9vINy3Bt
	J8F7TQPucHTeZxLz6wtzTCwjGJcc7hFB9aXDegnCOt3UhciYgacTLo3BmXHIvxlXFh6bGi
	d7efX8U+VBoKoqNtXL9VnI2DvPpCu18UMnRCI+7+nN5/Nks6FB/+VRlf5XKozAYNdoQun1
	auoFUvHszT8nsMVUhJYuTOBYuhQ0/iyKnA6822yyPxPjQj3V3i7p52tr3DiiYCplcavqPi
	MnXpZo5kmPXtbk2l7cYFmgi3rPWpt/us36pQSEGF9CRuKRY/G8OaFlQ2ETxAIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768903845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1Zw6TCGLNqf3t6hP+FCcbTvxMoD0YoiJHXLgtM7PPI=;
	b=tzJGH8MJuM4p47lqYxbDcT2lBgFfaT9tUAk6oOgV/TfsHRllTtyrYiZolP181FU4Dxl7Mb
	1ngVRy/OAZnC77BA==
To: Petr Mladek <pmladek@suse.com>, Breno Leitao <leitao@debian.org>
Cc: osandov@osandov.com, mpdesouza@suse.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
In-Reply-To: <aW9D5M0o9_8hdVvt@pathway.suse.cz>
References: <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz> <875x9a6cpw.fsf@jogness.linutronix.de>
 <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
 <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>
 <aWpekVlhRpD4CaDI@pathway.suse.cz> <aWpfDKd64DLX32Hl@pathway.suse.cz>
 <6tryrckp7mah2qghxu5fktrwexoik6anplubfvybushtcgocq5@kg6ln44istyk>
 <aW446yxd-FQ1JJ9Q@pathway.suse.cz>
 <bvmrtic6pr52cxwf6mis526zz4sbxstxjd2wiqkd2emueatv33@eccynoxgjgo2>
 <aW9D5M0o9_8hdVvt@pathway.suse.cz>
Date: Tue, 20 Jan 2026 11:16:43 +0106
Message-ID: <87pl74tx0c.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-01-20, Petr Mladek <pmladek@suse.com> wrote:
> Is the netconsole part ready for mainline?
>
> If yes, I would suggest to send the full patchset for review and it
> might go in via the networking tree.
>
> If no, then we could try to get in at least the printk part for
> 6.20. I would personally use the variant with caller_id2 just to be on
> the safe side.

I am also fine with these changes (and caller_id2). Please add me CC
when submitting the official patches.

John

