Return-Path: <netdev+bounces-78788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBA5876774
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 16:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB717281A30
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519051EA84;
	Fri,  8 Mar 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11d0XEBa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKJZhap6"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EFC1DDF1
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911987; cv=none; b=s7hPu7rohwAGFVi4BXpk8FyPASDdettwIDn1uy/CKxUujB3D2jMUfdLjNxQDXJUqqlbytLAJnxTn8SsszXnqflPFjGduVTfclBWuOs9V7R9zFVyioJ3elABN8NQV0U9TW1HP/pHeOea7o/JXP/PL7DC8px9eCB2JtvIuhtlnrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911987; c=relaxed/simple;
	bh=v38IQMRHfiIXADWouHoAAKPP5mZnl9dnbH0Ocw5TjMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjd1PosyhEez4nSJowjqdrHPmfxgPno8l5Mki0loZuYW4ifWcuamb9foY35vM33YpZhLigGf6XGdWvYOOAJnLm+5eKdxiB3RU8u6OAQzxDF1n/AGMgaFr8Dq7Y26B0dqn+nRssgsF0D4ZnhwYGL7jPFdZA5VVQ9uZvE352IN91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11d0XEBa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DKJZhap6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Mar 2024 16:33:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709911983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v38IQMRHfiIXADWouHoAAKPP5mZnl9dnbH0Ocw5TjMg=;
	b=11d0XEBazxZVTOs/f8KCNTIwqmYy4CNpjLiyLEnYkQapzMnyQ98CGb8OKXsoZvgDo8fqLb
	h3EP4/T8lGnFvwxAjJl0hexGzZNjm/SfSQU0cxrd2l6+yT/YV8vY1l3yfX1m/0Yy/Kxxx/
	/RssjkUjRMSRVPJzs2ARwTrGDP2Bz2ZOxv5oeJMWKqM6BX8Tg2LT2qm0RTP67ppLnsNQz1
	c6ut95z0UlPZ+4y1/vxTZevK+aTZ/s7Rgs7aVhy+vNwBPqT2JGdL4ijEks6nP1/7i8F+mu
	NNbY+RzwQXp3Cp6En0avP0iLepsMQPG/EwNki3dHFkai/dB7FSC4qz0NTqK0zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709911983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v38IQMRHfiIXADWouHoAAKPP5mZnl9dnbH0Ocw5TjMg=;
	b=DKJZhap6p5AbgggdVdjjre4+/ZMKDiaSQ62VSryr3KbgG1wvLgGpjzRpByEaQ1zRV+RJep
	LcRQQ7ryO7Iu32Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v4 net-next 0/4] net: Provide SMP threads for backlog NAPI
Message-ID: <20240308153302.AmmDp45Q@linutronix.de>
References: <20240305120002.1499223-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240305120002.1499223-1-bigeasy@linutronix.de>

On 2024-03-05 12:53:18 [+0100], To netdev@vger.kernel.org wrote:
> The RPS code and "deferred skb free" both send IPI/ function call
> to a remote CPU in which a softirq is raised. This leads to a warning on
> PREEMPT_RT because raising softiqrs from function call led to undesired
> behaviour in the past. I had duct tape in RT for the "deferred skb free"
> and Wander Lairson Costa reported the RPS case.
>=20
> This series only provides support for SMP threads for backlog NAPI, I
> did not attach a patch to make it default and remove the IPI related
> code to avoid confusion. I can post it for reference it asked.
>=20
> The RedHat performance team was so kind to provide some testing here.
> The series (with the IPI code removed) has been tested and no regression
> vs without the series has been found. For testing iperf3 was used on 25G
> interface, provided by mlx5, ix40e or ice driver and RPS was enabled. I
> can provide the individual test results if needed.
>=20
> Changes:
> - v3=E2=80=A6v4 https://lore.kernel.org/all/20240228121000.526645-1-bigea=
sy@linutronix.de/

The v4 is marked as "Changes Requested". Is there anything for me to do?
I've been asked to rebase v3 on top of net-next which I did with v4. It
still applies onto net-next as of today.
=20
Sebastian

