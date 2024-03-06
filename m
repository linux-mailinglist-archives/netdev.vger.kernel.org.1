Return-Path: <netdev+bounces-77798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588E87307D
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5752286E72
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2335CDF1;
	Wed,  6 Mar 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onJBn04H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDMtURgq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168085CDC2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713088; cv=none; b=BK+0rdP7+1DFPnO+1JtA7Tk4XHrs3ocicO+QT7FmlbYQSC0Gke5ij+PY92cnbr7eUaX+5AY+cdrNSp0opo9FyrOiM0LfUUsKYJslOjdjshvDFpDoHp0E+m7k7wh2o8TNji1EaryX4nr7wFemDSK/FtJFG8SjRA+6xzZiYAYXC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713088; c=relaxed/simple;
	bh=8A5+4al8R3jb2cfpvpe3U34UpSI6gSX9iRW7qW3p9Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVkBHTTcEQ4uEGpsvcZE1Wc5oK2/uop0+nk2EcyLU3UgxopKvKeiYcw9V/563+NsPWNbWnguKu7VwCPoe1LoCnCSa7K/Urp6QBy9CsiZy6hnI+SLS42W1h/fqabr2DD9xot1VfepVYQA2mKqVZ757vU2ejF+uFyemExV4yTpDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onJBn04H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDMtURgq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 6 Mar 2024 09:18:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709713083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8A5+4al8R3jb2cfpvpe3U34UpSI6gSX9iRW7qW3p9Ao=;
	b=onJBn04HF32gjYEK1zm5icRJPcttFm6fdRTQ3AkWNjG1WzyK1506Wo1N9/B1sU7vJMxNPU
	HwhgkMpqYfUUbXRAU2SINJCv1Nj5Hdc1FugUGtIv/LHtWWYK43We9oTk7q2zc0kuAlViuv
	aHQANpOGjOAqJNo/d9IaWIdV6pO6soJCY1OXIxAmNcEaTc3yNrGIMX63Rbhg5o9WWuiUAg
	ycYXlHteyzYEAgQdt1vxK8mA0oZDQYciFlDdcX5diDlbbYdBpdHvA7/w/SZL27I5WzIzUG
	+k5aA41N2ZvaxYtx4nVoDwPolvOOCLp5N0pVE7wa507XnhpIyhyhEZ20U0CE5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709713083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8A5+4al8R3jb2cfpvpe3U34UpSI6gSX9iRW7qW3p9Ao=;
	b=QDMtURgqxnJl3E2QuvK8rk7LEW8usiCEoL1BY4I+4teMeuc1RaxXUeLUuQkNjVuycQESht
	rWo6nYqdymXobNDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v3 net-next 2/4] net: Allow to use SMP threads for
 backlog NAPI.
Message-ID: <20240306081802.4MgVOkad@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
 <20240228121000.526645-3-bigeasy@linutronix.de>
 <c37223527d5b6bcf0ffce69c81f16fd0781fa2d6.camel@redhat.com>
 <20240305103530.FEVh-64E@linutronix.de>
 <20240305072334.59819960@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240305072334.59819960@kernel.org>

On 2024-03-05 07:23:34 [-0800], Jakub Kicinski wrote:
> On Tue, 5 Mar 2024 11:35:30 +0100 Sebastian Andrzej Siewior wrote:
> > I had RH benchmarking this and based on their 25Gbe and 50Gbe NICs and
> > the results look good. If anything it looked a bit better with this on
> > the 50Gbe NICs but since those NICs have RSS=E2=80=A6
>=20
> TBH if y'all tested this with iperf that's pretty meaningless.
> The concern is not as much throughput on an idle system as it=20
> is the fact that we involve scheduler with it's heuristics
> for every NAPI run.

Yeah, I thought so. According to RH, they don't have a RPS workload left
since all their NICs use RSS now. That iperf test was the next best
thing.=20

> But I recognize that your access to production workloads may=20
> be limited and you did more than most, so =F0=9F=A4=B7=EF=B8=8F

Sebastian

