Return-Path: <netdev+bounces-216955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04325B3668A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C599B6151A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B767350D64;
	Tue, 26 Aug 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="WRuQxmhr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9682B9A7;
	Tue, 26 Aug 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216582; cv=none; b=Mcz8JEZSOeJs9AIIgzJhRJhJ4GrUMUogb9SQdLjinBefC3DZrHJ/WQkNBTrH+tzC7e4kWtTDnfJ0QIAT0b7QqdN5fVOQt+kgFDKtHUZUrdKWHXBvYdPSKDFy9HZBOqcMXrFz00mCQy5C6lwypmShUzBtaadIrCvPUxCcNY1JZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216582; c=relaxed/simple;
	bh=Wxh9CyDqfJUe93SkJLh7S5XxhL5F9zPer4yWVfDpO+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TyPboyLC3tiUQx/wd6YFWQZS3FAALPNSnWxHqE0xHjDxfNWdPcvuTkeVXbKUQwYpk3ehTRDyRmTatlmItkIdIoQXvs+Zaw4o2/HPcEJ8GKs2czmTCRSdSGKuu+I2AQhKxzCaTGQbygCwo5Dm08RY9m+VSlRronbzJsXngyI3z5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=WRuQxmhr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756216567; x=1756821367; i=efault@gmx.de;
	bh=nAnjvL2palqw0IYUeTqSWpneuRn9XvKOA3DVCbCc/cE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WRuQxmhrSLR3zrQEhb2HBoOAsQeHQfFxL0nrBYZA53dXz04R1ugzDJ54fJp1UJHE
	 lkYH9qZFwK9/HDMp3Apaj7COXGG5Y4iShXawJOH+jdUZpNBB0fHDnvX+edecl4biU
	 tCw3cOfQ2lU4+mz5+DfwaGX4rGVOvnMrnKxncY9M8xNZe/GHkh6RcNX00r3ppUkn9
	 SX0Go2YZ8zFhDEmkskSIau07kORZEqfo4QpyRb5pyDWprVdFZJRI0qb/X3dIcXO73
	 6d4ATjkOUDa13ch+dVTlMnNPmaZA2w295YIsXCtJrzWaZjEGqrOjFNIgM61sUlnkf
	 ZHnN3CMQ1g+VtjmMGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QS8-1uvHrr1nYO-00FyaM; Tue, 26
 Aug 2025 15:56:07 +0200
Message-ID: <6bc3af45969936668200657112140b78615e3873.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Breno Leitao <leitao@debian.org>, Simon Horman <horms@kernel.org>, 
	kuba@kernel.org, calvin@wbinvd.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, paulmck@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Tue, 26 Aug 2025 15:56:06 +0200
In-Reply-To: <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
References: 
	<isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
	 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
	 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
	 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
	 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
	 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
	 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
	 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
	 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
	 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
	 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
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
X-Provags-ID: V03:K1:9uT6Z0M9IpWj0Lsri5lbd3yJ237dOwF4ME+2CEQ267QHgUwrPTi
 7ZPmGHcDitxcNpgGnBuMJv0slpE02PSpsUVMhfTRoADpauspmq1dYLi/481vWDXvuYfz6RI
 qn4cjUCtcf6aWZGDuv+phSXP71OqQ3x+E441SDl3R/sGaet2+FXNW7GBh+P3WC+AwCnTWbg
 zRmXPqXmf0JzzdHtWv4wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m5LYjiNdxNw=;GBRMmTk6YtFgM08RXBxksGvIVIT
 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
 twgd+lOS+np04SXhs01bbtLrkBJm

On Tue, 2025-08-26 at 05:43 -0700, Breno Leitao wrote:
> On Fri, Aug 22, 2025 at 05:54:28AM +0200, Mike Galbraith wrote:
> > On Thu, 2025-08-21 at 10:35 -0700, Breno Leitao wrote:
> > > > On Thu, Aug 21, 2025 at 05:51:59AM +0200, Mike Galbraith wrote:
> > =C2=A0
> > > > > > --- a/drivers/net/netconsole.c
> > > > > > +++ b/drivers/net/netconsole.c
> > > > > > @@ -1952,12 +1952,12 @@ static void netcon_write_thread(struct =
c
> > > > > > =C2=A0static void netconsole_device_lock(struct console *con, u=
nsigned long *flags)
> > > > > > =C2=A0{
> > > > > > =C2=A0	/* protects all the targets at the same time */
> > > > > > -	spin_lock_irqsave(&target_list_lock, *flags);
> > > > > > +	spin_lock(&target_list_lock);
> > > >=20
> > > > I personally think this target_list_lock can be moved to an RCU loc=
k.
> > > >=20
> > > > If that is doable, then we probably make netconsole_device_lock()
> > > > to a simple `rcu_read_lock()`, which would solve this problem as we=
ll.
> >=20
> > The bigger issue for the nbcon patch would seem to be the seemingly
> > required .write_atomic leading to landing here with disabled IRQs.
>=20
> In this case, instead of transmitting through netpoll directly in the
> .write_atomic context, we could queue the messages for later delivery.
>=20
> With the current implementation, this is not straightforward unless we
> introduce an additional message copy at the start of .write_atomic.
>=20
> This is where the interface between netpoll and netconsole becomes
> problematic. Ideally, we would avoid carrying extra data into netconsole
> and instead copy the message into an SKB and queue the SKB for
> transmission.
>=20
> The core issue is that netpoll and netconsole are tightly coupled, and
> several pieces of functionality that live in netpoll really belong in
> netconsole. A good example is the SKB pool: that=E2=80=99s a netconsole c=
oncept,
> not a netpoll one. None of the other netpoll users send raw char *
> messages. They all work directly with skbs, so, in order to achieve it,
> we need to move the concept of skb pool into netconsole, and give
> netconsole the management of the skb pool.
>=20
> > WRT my patch, seeing a hard RT crash on wired box cleanly logged with
> > your nbcon patch applied (plus my twiddle mentioned earlier) tells me
> > my patch has lost its original reason to exist.=C2=A0 It's relevant to =
this
> > thread only in that those once thought to be RT specific IRQ disable
> > spots turned out to actually be RT agnostic wireless sore spots.
>=20
> Thanks. As a follow-up, I would suggest the following steps:
>=20
> 1) Decouple the SKB pool from netpoll and move it into netconsole
>=20
> =C2=A0 * This makes netconsole behave like any other netpoll user,
> =C2=A0=C2=A0=C2=A0 interacting with netpoll by sending SKBs.
> 	* The SKB population logic would then reside in netconsole, where it
> 	=C2=A0 logically belongs.
>=20
> =C2=A0 * Enable NBCONS in netconsole, guarded by NETCONSOLE_NBCON
> 	* In normal .write_atomic() mode, messages should be queued in
> 	=C2=A0 a workqueue.
> 	* If oops_in_progress is set, we bypass the queue and
> 	=C2=A0 transmit the SKB immediately. (Maybe disabling lockdep?!).
>=20
> Any concern with this plan?

Nope, sounds like progress to me.

From an RT perspective, the further netconsole gets from the netpoll's
definition of acceptable IRQ holdoff, the better.  For a death rattle,
it doesn't matter, but for mundane kernel squeaks that's a fail.

	-Mike

