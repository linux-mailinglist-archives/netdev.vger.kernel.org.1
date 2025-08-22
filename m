Return-Path: <netdev+bounces-215894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB4B30D0E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACA91CE422B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02B7277CA2;
	Fri, 22 Aug 2025 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="s0cTfwsx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9147393DE2;
	Fri, 22 Aug 2025 03:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834873; cv=none; b=WMmspDRgWiyqcuBuepH7on1S8ewryV0qbaw50W7P+rbp492F+i2bradNYh7uEBvIC6RR+PnEXh/mVnIpKAawTflTf3IQMvcM41muHlGnUzhbeJQK3JuNmSIYrhT9zyJJIPSMOXuu51gNgS/PlbflqokZbhx/jFx7rzNLA9R9kuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834873; c=relaxed/simple;
	bh=qI8bZAA2Zqy39VyGC8+39a/1c6k4LzwCc1SZ0CNmLkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tW9h8YujQiadtMk+QaTpPd2UJtyUdIQoMF1wI2YziRJYD8Tu6mQK58CzJhLKdEjH/SNR+O8onRaqNjXUUkYV05wUR6sbDX6qaKNS/SBEdN77GuE60995dYGNro2azU3brHX8K/0PO2FwooViO0CoYxGdIozKea/PLifoV8fkgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=s0cTfwsx; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755834869; x=1756439669; i=efault@gmx.de;
	bh=4EUYfaocQHlDFb92PRxw93GL+dbsyMJy8t+/CbeTSfE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s0cTfwsxK4RBbmLl6G+Eiac33A2kwVQ/g21qhofUbWYywEr8e+hz2avzoHDgIReF
	 kEcGbR1+/4xj0/mfl+CL4NB2+iZkqFEZPgVAuM66U48fskopfOOahBmJB9KTAwCpm
	 QNQjsaa3ZmbM4UtJLKJ3kz0kVoXQhQZe75SaeqtEEVxvatN5f0eh6biBlCkOg+G2l
	 e/pN+zY4fpMgaUftUFVuz3z3NvW7nVWxGtOM8e1xT4jhqcbbRuhYPT1s8dsQ2czLu
	 NEr08bZQy76GnfeLi07zqw01bd8yWKNqwB4G+SE/zqhTMDjFjAfO+sMsBEEENEsvq
	 q/pHdN2J+enpDnkNDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.21]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1uRA1L3EzH-0174Wd; Fri, 22
 Aug 2025 05:54:28 +0200
Message-ID: <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Breno Leitao <leitao@debian.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>,  Johannes Berg <johannes@sipsolutions.net>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Fri, 22 Aug 2025 05:54:28 +0200
In-Reply-To: <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
References: <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
	 <20250815094217.1cce7116@kernel.org>
	 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
	 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
	 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
	 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
	 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
	 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
	 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
	 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
	 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:/NNsoQb8snN483P6iDaZ5PkM+rSso7dMoCUaQSm9KyGwibGbigh
 yeJGhqhzLHHf+Ux7otkljuLtYbL1A+uQKuZF8ELmxbjC0h8awgGjedFWbEk9O4VM2LNIoaP
 UdtEPpvXEFZJYzrZc6MRcYcX3jROvDhe0dtsKCWqKfqzZaeaSZw7aTIWhYrtj+POBBhBVT+
 PG4WGQR1km3dHDt+3ROOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RYCWiz9X3s8=;uLyMYQ7XmGXagNccL7HQ/U3nM0x
 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

On Thu, 2025-08-21 at 10:35 -0700, Breno Leitao wrote:
> > On Thu, Aug 21, 2025 at 05:51:59AM +0200, Mike Galbraith wrote:
=20
> > > > --- a/drivers/net/netconsole.c
> > > > +++ b/drivers/net/netconsole.c
> > > > @@ -1952,12 +1952,12 @@ static void netcon_write_thread(struct c
> > > > =C2=A0static void netconsole_device_lock(struct console *con, unsig=
ned long *flags)
> > > > =C2=A0{
> > > > =C2=A0	/* protects all the targets at the same time */
> > > > -	spin_lock_irqsave(&target_list_lock, *flags);
> > > > +	spin_lock(&target_list_lock);
> >=20
> > I personally think this target_list_lock can be moved to an RCU lock.
> >=20
> > If that is doable, then we probably make netconsole_device_lock()
> > to a simple `rcu_read_lock()`, which would solve this problem as well.

The bigger issue for the nbcon patch would seem to be the seemingly
required .write_atomic leading to landing here with disabled IRQs.

WRT my patch, seeing a hard RT crash on wired box cleanly logged with
your nbcon patch applied (plus my twiddle mentioned earlier) tells me
my patch has lost its original reason to exist.  It's relevant to this
thread only in that those once thought to be RT specific IRQ disable
spots turned out to actually be RT agnostic wireless sore spots.

> > > > --- a/net/core/netpoll.c
> > > > +++ b/net/core/netpoll.c
> > > > @@ -58,6 +58,29 @@ static void zap_completion_queue(void);
> > > > =C2=A0static unsigned int carrier_timeout =3D 4;
> > > > =C2=A0module_param(carrier_timeout, uint, 0644);
> > > > =C2=A0
> > > > +DEFINE_PER_CPU(int, _netpoll_tx_running);
> > > > +EXPORT_PER_CPU_SYMBOL(_netpoll_tx_running);
> > > > +
> > > > +#define
> > > > netpoll_tx_begin(flags)					\
> > > > +	do
> > > > {							\
> > > > +		if (IS_ENABLED(CONFIG_PREEMPT_RT)
> > > > ||		\
> > > > +		=C2=A0=C2=A0=C2=A0
> > > > IS_ENABLED(CONFIG_NETCONSOLE_NBCON))	\
> > > > +			local_bh_disable();	=09
> > > > 	\
> > > > +		else				=09
> > > > 	\
> > > > +			local_irq_save(flags);	=09
> > > > 	\
> > > > +		this_cpu_write(_netpoll_tx_running,
> > > > 1);		\
> > > > +	} while (0)
> >=20
> > Why can't we just use local_bh_disable() in both cases?

Yeah, believe so.

> > >=20
> > > > @@ -246,7 +269,7 @@ static void refill_skbs(struct netpoll *
> > > > =C2=A0static void zap_completion_queue(void)
> > > > =C2=A0{
> > > > =C2=A0	unsigned long flags;
> > > > -	struct softnet_data *sd =3D &get_cpu_var(softnet_data);
> > > > +	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
> >=20
> > How do I check if this is safe to do ?

Too much water under the bridge, I don't recall my path to conclusion
reached, and it seems to no longer matter.

	-Mike

